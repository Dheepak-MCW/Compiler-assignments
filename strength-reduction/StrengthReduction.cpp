#include "StrengthReduction.h"

#include "llvm/IR/Constants.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Plugins/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include <vector>

using namespace llvm;

PreservedAnalyses
StrengthReductionPass::run(
    Function &F,
    FunctionAnalysisManager &)
{
    std::vector<Instruction *> ToErase;

    for (BasicBlock &BB : F) {
        for (Instruction &I : BB) {

            auto *BO = dyn_cast<BinaryOperator>(&I);

            if (!BO || BO->getOpcode() != Instruction::Mul)
                continue;

            Value *Op0 = BO->getOperand(0);
            Value *Op1 = BO->getOperand(1);

            ConstantInt *CI =
                dyn_cast<ConstantInt>(Op1);

            Value *Other = Op0;

            if (!CI) {
                CI = dyn_cast<ConstantInt>(Op0);
                Other = Op1;
            }

            if (!CI)
                continue;

            const APInt &Val = CI->getValue();

            if (!Val.isPowerOf2())
                continue;

            unsigned ShiftAmt = Val.exactLogBase2();

            errs() << "Strength reduction applied to: "
                   << I
                   << " (shift left by "
                   << ShiftAmt
                   << ")\n";

            IRBuilder<> Builder(BO);

            Value *Shl = Builder.CreateShl(
                Other,
                ConstantInt::get(
                    BO->getType(),
                    ShiftAmt));

            BO->replaceAllUsesWith(Shl);

            ToErase.push_back(BO);
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
        "StrengthReduction",
        LLVM_VERSION_STRING,

        [](PassBuilder &PB) {

            PB.registerPipelineParsingCallback(
                [](StringRef Name,
                   FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {

                    if (Name == "strength-reduction") {
                        FPM.addPass(StrengthReductionPass());
                        return true;
                    }

                    return false;
                }
            );
        }
    };
}