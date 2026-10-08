#ifndef ALGEBRAIC_IDENTITY_H
#define ALGEBRAIC_IDENTITY_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class AlgebraicIdentityPass
    : public OptionalPassInfoMixin<AlgebraicIdentityPass> {
public:
    PreservedAnalyses run(
        Function &F,
        FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif