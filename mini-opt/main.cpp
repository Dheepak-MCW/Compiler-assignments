#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Plugins/PassPlugin.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

static cl::opt<std::string> InputFilename(
    cl::Positional,
    cl::desc("<input LLVM IR file>"),
    cl::Required);

static cl::opt<std::string> OutputFilename(
    "o",
    cl::desc("Output LLVM IR file"),
    cl::value_desc("filename"),
    cl::init("-"));

static cl::opt<std::string> PluginFilename(
    "load-pass-plugin",
    cl::desc("Load LLVM pass plugin"),
    cl::value_desc("filename"),
    cl::Required);

static cl::opt<std::string> PassPipeline(
    "passes",
    cl::desc("Pass pipeline"),
    cl::value_desc("pipeline"),
    cl::Required);

int main(int argc, char **argv) {
    cl::ParseCommandLineOptions(argc, argv, "Mini LLVM Pass Driver\n");

    LLVMContext Context;
    SMDiagnostic Err;

    auto M = parseIRFile(InputFilename, Err, Context);

    if (!M) {
        Err.print(argv[0], errs());
        return 1;
    }

    auto Plugin = PassPlugin::Load(PluginFilename);

    if (!Plugin) {
        errs() << "Failed to load plugin\n";
        logAllUnhandledErrors(
            Plugin.takeError(),
            errs(),
            "");
        return 1;
    }

    errs() << "Loaded plugin: "
           << Plugin->getPluginName()
           << "\n";

    PassBuilder PB;

    Plugin->registerPassBuilderCallbacks(PB);

    LoopAnalysisManager LAM;
    FunctionAnalysisManager FAM;
    CGSCCAnalysisManager CGAM;
    ModuleAnalysisManager MAM;

    PB.registerModuleAnalyses(MAM);
    PB.registerCGSCCAnalyses(CGAM);
    PB.registerFunctionAnalyses(FAM);
    PB.registerLoopAnalyses(LAM);

    PB.crossRegisterProxies(
        LAM, FAM, CGAM, MAM);

    ModulePassManager MPM;

    if (auto PipelineErr =
            PB.parsePassPipeline(MPM, PassPipeline)) {

        errs() << "Failed to parse pass pipeline\n";

        logAllUnhandledErrors(
            std::move(PipelineErr),
            errs(),
            "");

        return 1;
    }

    MPM.run(*M, MAM);

    if (OutputFilename == "-") {
        M->print(outs(), nullptr);
    } else {
        std::error_code EC;

        raw_fd_ostream OS(OutputFilename, EC);

        if (EC) {
            errs() << "Could not open output file: "
                   << EC.message() << "\n";
            return 1;
        }

        M->print(OS, nullptr);
    }

    return 0;
}