#ifndef COPY_PROPAGATION_H
#define COPY_PROPAGATION_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class CopyPropagationPass
    : public OptionalPassInfoMixin<CopyPropagationPass> {
public:
    PreservedAnalyses run(
        Function &F,
        FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif