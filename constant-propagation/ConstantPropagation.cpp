#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Plugins/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {

class ConstantPropagationPass
    : public OptionalPassInfoMixin<ConstantPropagationPass> {

public:
    PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {

        bool Changed = false;

        for (BasicBlock &BB : F) {
            for (auto It = BB.begin(); It != BB.end();) {
                Instruction *I = &*It++;
                
                auto *BinOp = dyn_cast<BinaryOperator>(I);
                if (!BinOp)
                    continue;

                auto *C1 = dyn_cast<ConstantInt>(BinOp->getOperand(0));
                auto *C2 = dyn_cast<ConstantInt>(BinOp->getOperand(1));

                if (!C1 || !C2)
                    continue;

                Constant *Result = nullptr;

                switch (BinOp->getOpcode()) {
                case Instruction::Add:
                    Result = ConstantInt::get(
                        BinOp->getType(),
                        C1->getValue() + C2->getValue());
                    break;

                case Instruction::Sub:
                    Result = ConstantInt::get(
                        BinOp->getType(),
                        C1->getValue() - C2->getValue());
                    break;

                case Instruction::Mul:
                    Result = ConstantInt::get(
                        BinOp->getType(),
                        C1->getValue() * C2->getValue());
                    break;

                case Instruction::UDiv:
                    if (!C2->isZero()) {
                        Result = ConstantInt::get(
                            BinOp->getType(),
                            C1->getValue().udiv(C2->getValue()));
                    }
                    break;

                case Instruction::SDiv:
                    if (!C2->isZero()) {
                        Result = ConstantInt::get(
                            BinOp->getType(),
                            C1->getValue().sdiv(C2->getValue()));
                    }
                    break;

                case Instruction::And:
                    Result = ConstantInt::get(
                        BinOp->getType(),
                        C1->getValue() & C2->getValue());
                    break;

                case Instruction::Or:
                    Result = ConstantInt::get(
                        BinOp->getType(),
                        C1->getValue() | C2->getValue());
                    break;

                case Instruction::Xor:
                    Result = ConstantInt::get(
                        BinOp->getType(),
                        C1->getValue() ^ C2->getValue());
                    break;

                default:
                    break;
                }

                if (Result) {
                    errs() << "Constant folded: ";
                    I->print(errs());
                    errs() << "\n";

                    I->replaceAllUsesWith(Result);
                    I->eraseFromParent();

                    Changed = true;
                }
            }
        }

        return Changed
            ? PreservedAnalyses::none()
            : PreservedAnalyses::all();
    }
};

} // namespace

extern "C" LLVM_ATTRIBUTE_WEAK
llvm::PassPluginLibraryInfo llvmGetPassPluginInfo() {

    return {
        LLVM_PLUGIN_API_VERSION,
        "ConstantPropagation",
        LLVM_VERSION_STRING,

        [](llvm::PassBuilder &PB) {

            PB.registerPipelineParsingCallback(
                [](llvm::StringRef Name,
                   llvm::FunctionPassManager &FPM,
                   llvm::ArrayRef<llvm::PassBuilder::PipelineElement>) {

                    if (Name == "constant-propagation") {
                        FPM.addPass(ConstantPropagationPass());
                        return true;
                    }

                    return false;
                }
            );
        }
    };
}