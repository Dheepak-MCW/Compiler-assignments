#ifndef STRENGTH_REDUCTION_H
#define STRENGTH_REDUCTION_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class StrengthReductionPass
    : public OptionalPassInfoMixin<StrengthReductionPass> {
public:
    PreservedAnalyses run(
        Function &F,
        FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif