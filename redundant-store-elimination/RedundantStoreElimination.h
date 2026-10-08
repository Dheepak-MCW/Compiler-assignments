#ifndef REDUNDANT_STORE_ELIMINATION_H
#define REDUNDANT_STORE_ELIMINATION_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class RedundantStoreEliminationPass
    : public OptionalPassInfoMixin<RedundantStoreEliminationPass> {
public:
    PreservedAnalyses run(
        Function &F,
        FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif