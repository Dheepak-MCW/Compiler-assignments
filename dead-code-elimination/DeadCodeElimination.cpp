#include "DeadCodeElimination.h"

#include "llvm/IR/Instructions.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Plugins/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include <vector>

using namespace llvm;

PreservedAnalyses
DeadCodeEliminationPass::run(
    Function &F,
    FunctionAnalysisManager &AM) {

    bool EverChanged = false;
    bool Changed = true;

    // Repeat until no more dead instructions can be removed.
    while (Changed) {
        Changed = false;

        std::vector<Instruction *> ToErase;

        for (BasicBlock &BB : F) {
            for (Instruction &I : BB) {

                // An instruction is dead when:
                // 1. Its result is unused.
                // 2. It has no side effects.
                // 3. It is not a terminator.
                if (I.use_empty() &&
                    !I.isTerminator() &&
                    !I.mayHaveSideEffects()) {

                    errs() << "Dead code eliminated: "
                           << I << "\n";

                    ToErase.push_back(&I);
                }
            }
        }

        // Erase after iteration to avoid invalidating iterators.
        for (Instruction *I : ToErase) {
            I->eraseFromParent();
            Changed = true;
            EverChanged = true;
        }
    }

    return EverChanged
        ? PreservedAnalyses::none()
        : PreservedAnalyses::all();
}


// Register the pass as an LLVM plugin.
extern "C" LLVM_ATTRIBUTE_WEAK
PassPluginLibraryInfo llvmGetPassPluginInfo() {

    return {
        LLVM_PLUGIN_API_VERSION,
        "DeadCodeElimination",
        LLVM_VERSION_STRING,

        [](PassBuilder &PB) {

            PB.registerPipelineParsingCallback(
                [](StringRef Name,
                   FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {

                    if (Name == "dead-code-elimination") {
                        FPM.addPass(DeadCodeEliminationPass());
                        return true;
                    }

                    return false;
                });
        }
    };
}