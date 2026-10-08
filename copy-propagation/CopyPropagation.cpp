#include "CopyPropagation.h"

#include "llvm/ADT/DenseMap.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Plugins/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include <vector>

using namespace llvm;

PreservedAnalyses
CopyPropagationPass::run(
    Function &F,
    FunctionAnalysisManager &)
{
    std::vector<Instruction *> ToErase;

    for (BasicBlock &BB : F) {

        DenseMap<AllocaInst *, Value *> Current;

        for (Instruction &I : BB) {

            if (isa<CallBase>(&I)) {
                Current.clear();
                continue;
            }

            if (auto *SI = dyn_cast<StoreInst>(&I)) {

                auto *Var =
                    dyn_cast<AllocaInst>(
                        SI->getPointerOperand());

                if (!Var || !SI->isSimple())
                    Current.clear();
                else
                    Current[Var] =
                        SI->getValueOperand();

                continue;
            }

            auto *LI = dyn_cast<LoadInst>(&I);

            if (!LI || !LI->isSimple())
                continue;

            auto *Var =
                dyn_cast<AllocaInst>(
                    LI->getPointerOperand());

            if (!Var)
                continue;

            Value *Known = Current.lookup(Var);

            if (!Known ||
                Known->getType() != LI->getType())
                continue;

            errs() << "Copy propagation applied to: "
                   << I << "\n";

            LI->replaceAllUsesWith(Known);
            ToErase.push_back(LI);
        }
    }

    for (Instruction *I : ToErase)
        I->eraseFromParent();

    return ToErase.empty()
        ? PreservedAnalyses::all()
        : PreservedAnalyses::none();
}

extern "C" LLVM_ATTRIBUTE_WEAK
PassPluginLibraryInfo llvmGetPassPluginInfo()
{
    return {
        LLVM_PLUGIN_API_VERSION,
        "CopyPropagation",
        LLVM_VERSION_STRING,

        [](PassBuilder &PB) {

            PB.registerPipelineParsingCallback(
                [](StringRef Name,
                   FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {

                    if (Name == "copy-propagation") {
                        FPM.addPass(CopyPropagationPass());
                        return true;
                    }

                    return false;
                }
            );
        }
    };
}