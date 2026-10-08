#include "RedundantStoreElimination.h"

#include "llvm/ADT/DenseMap.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Plugins/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include <vector>

using namespace llvm;

PreservedAnalyses
RedundantStoreEliminationPass::run(
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

            auto *SI = dyn_cast<StoreInst>(&I);

            if (!SI)
                continue;

            auto *Var =
                dyn_cast<AllocaInst>(
                    SI->getPointerOperand());

            if (!Var || !SI->isSimple()) {
                Current.clear();
                continue;
            }

            Value *V = SI->getValueOperand();

            if (Current.lookup(Var) == V) {

                errs()
                    << "Redundant store eliminated: "
                    << I << "\n";

                ToErase.push_back(SI);
                continue;
            }

            Current[Var] = V;
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
        "RedundantStoreElimination",
        LLVM_VERSION_STRING,

        [](PassBuilder &PB) {

            PB.registerPipelineParsingCallback(
                [](StringRef Name,
                   FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {

                    if (Name == "redundant-store-elimination") {
                        FPM.addPass(
                            RedundantStoreEliminationPass());
                        return true;
                    }

                    return false;
                }
            );
        }
    };
}