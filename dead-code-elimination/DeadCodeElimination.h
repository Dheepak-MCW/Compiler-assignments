#ifndef DEAD_CODE_ELIMINATION_H
#define DEAD_CODE_ELIMINATION_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class DeadCodeEliminationPass
    : public OptionalPassInfoMixin<DeadCodeEliminationPass> {
public:
    PreservedAnalyses run(
        Function &F,
        FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif