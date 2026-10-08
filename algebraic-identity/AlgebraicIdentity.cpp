#include "AlgebraicIdentity.h"

#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Plugins/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include <vector>

using namespace llvm;

namespace {

/*
 * Check whether two operands represent the same SSA value.
 *
 * We intentionally use the conservative A == B check here.
 * This avoids making assumptions about loads and intervening stores.
 */
static bool sameValue(Value *A, Value *B)
{
    return A == B;
}

} // anonymous namespace

PreservedAnalyses
AlgebraicIdentityPass::run(
    Function &F,
    FunctionAnalysisManager &)
{
    bool Changed = false;

    /*
     * Store instructions to erase after the traversal.
     * We do not erase instructions while iterating through
     * the BasicBlock because that can invalidate the iterator.
     */
    std::vector<Instruction *> ToErase;

    for (BasicBlock &BB : F) {

        for (Instruction &I : BB) {

            auto *BO = dyn_cast<BinaryOperator>(&I);

            if (!BO)
                continue;

            Value *Op0 = BO->getOperand(0);
            Value *Op1 = BO->getOperand(1);

            auto *C0 = dyn_cast<ConstantInt>(Op0);
            auto *C1 = dyn_cast<ConstantInt>(Op1);

            Value *Replacement = nullptr;

            switch (BO->getOpcode()) {

            /*
             * Multiplication identities:
             *
             * x * 1 -> x
             * 1 * x -> x
             * x * 0 -> 0
             * 0 * x -> 0
             */
            case Instruction::Mul:

                if (C1 && C1->isOne()) {
                    Replacement = Op0;
                }
                else if (C0 && C0->isOne()) {
                    Replacement = Op1;
                }
                else if (C1 && C1->isZero()) {
                    Replacement =
                        ConstantInt::get(BO->getType(), 0);
                }
                else if (C0 && C0->isZero()) {
                    Replacement =
                        ConstantInt::get(BO->getType(), 0);
                }

                break;

            /*
             * Addition identities:
             *
             * x + 0 -> x
             * 0 + x -> x
             */
            case Instruction::Add:

                if (C1 && C1->isZero()) {
                    Replacement = Op0;
                }
                else if (C0 && C0->isZero()) {
                    Replacement = Op1;
                }

                break;

            /*
             * Subtraction identities:
             *
             * x - x -> 0
             * x - 0 -> x
             */
            case Instruction::Sub:

                if (sameValue(Op0, Op1)) {
                    Replacement =
                        ConstantInt::get(BO->getType(), 0);
                }
                else if (C1 && C1->isZero()) {
                    Replacement = Op0;
                }

                break;

            /*
             * Division identities:
             *
             * x / x -> 1
             * x / 1 -> x
             */
            case Instruction::SDiv:
            case Instruction::UDiv:

                if (sameValue(Op0, Op1)) {
                    Replacement =
                        ConstantInt::get(BO->getType(), 1);
                }
                else if (C1 && C1->isOne()) {
                    Replacement = Op0;
                }

                break;

            default:
                break;
            }

            if (Replacement) {

                errs() << "Algebraic identity simplified: ";
                I.print(errs());
                errs() << "\n";

                BO->replaceAllUsesWith(Replacement);

                ToErase.push_back(BO);

                Changed = true;
            }
        }
    }

    /*
     * Remove instructions after traversal.
     */
    for (Instruction *I : ToErase) {
        I->eraseFromParent();
    }

    return Changed
        ? PreservedAnalyses::none()
        : PreservedAnalyses::all();
}

extern "C" LLVM_ATTRIBUTE_WEAK
PassPluginLibraryInfo llvmGetPassPluginInfo()
{
    return {
        LLVM_PLUGIN_API_VERSION,
        "AlgebraicIdentity",
        LLVM_VERSION_STRING,

        [](PassBuilder &PB) {

            PB.registerPipelineParsingCallback(
                [](StringRef Name,
                   FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {

                    if (Name == "algebraic-identity") {

                        FPM.addPass(
                            AlgebraicIdentityPass());

                        return true;
                    }

                    return false;
                }
            );
        }
    };
}