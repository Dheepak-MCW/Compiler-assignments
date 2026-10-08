# LLVM Optimization Passes and Loop Optimizations

Implementation, testing, and performance evaluation of LLVM optimization passes and classic loop transformations.

The assignment contains two main components:

1. **LLVM optimization passes** implemented as standalone LLVM pass plugins.
2. **Matrix multiplication loop optimizations** implemented and benchmarked at the source level.

The LLVM passes are built against the existing LLVM 24 build and loaded dynamically using a lightweight `mini-opt` driver. Each pass is tested using LLVM IR input and output files so that the optimization can be directly verified.

## Folder Structure

```text
assignment/
│
├── algebraic-identity/
│   ├── AlgebraicIdentity.cpp
│   ├── AlgebraicIdentity.h
│   ├── Algebraic_before.ll
│   ├── AlgebraicIdentity_after.ll
│   └── CMakeLists.txt
│
├── constant-folding/
│   ├── ConstantFolding.cpp
│   ├── ConstantFolding.h
│   ├── ConstantFolding_before.ll
│   ├── ConstantFolding_after.ll
│   └── CMakeLists.txt
│
├── constant-propagation/
│   ├── ConstantPropagation.cpp
│   ├── ConstantPropagation.h
│   ├── test.ll
│   ├── test_check.ll
│   └── CMakeLists.txt
│
├── copy-propagation/
│   ├── CopyPropagation.cpp
│   ├── CopyPropagation.h
│   ├── CopyPropagation_before.ll
│   ├── CopyPropagation_after.ll
│   └── CMakeLists.txt
│
├── dead-code-elimination/
│   ├── DeadCodeElimination.cpp
│   ├── DeadCodeElimination.h
│   ├── DeadCodeElimination_before.ll
│   ├── DeadCodeElimination_after.ll
│   └── CMakeLists.txt
│
├── redundant-store-elimination/
│   ├── RedundantStoreElimination.cpp
│   ├── RedundantStoreElimination.h
│   ├── RedundantStoreElimination_before.ll
│   ├── RedundantStoreElimination_after.ll
│   └── CMakeLists.txt
│
├── strength-reduction/
│   ├── StrengthReduction.cpp
│   ├── StrengthReduction.h
│   ├── StrengthReduction_before.ll
│   ├── StrengthReduction_after.ll
│   └── CMakeLists.txt
│
├── matrix-multiplication/
│   ├── matrix_mul.c
│   ├── matrix_mul.ll
│   └── output.txt
│
├── mini-opt/
│   ├── main.cpp
│   └── CMakeLists.txt
│
└── README.md
```

Generated build directories and compiled binaries are excluded from the repository using `.gitignore`.

## LLVM Optimization Passes

The following LLVM passes were implemented:

- Constant Propagation
- Algebraic Identity
- Constant Folding
- Copy Propagation
- Redundant Store Elimination
- Strength Reduction
- Dead Code Elimination

Each optimization is implemented as an LLVM pass plugin.

The source code is separated into:

```text
PassName.cpp
PassName.h
CMakeLists.txt
```

The `.cpp` file contains the optimization logic and LLVM plugin registration. The `.h` file contains the pass declaration. `CMakeLists.txt` builds the pass as a dynamically loadable LLVM plugin.

## Build Environment

The passes were developed using:

- LLVM 24
- CMake
- Visual Studio 2022
- MSVC
- Windows
- C++17

The LLVM source and build are assumed to be available through a local LLVM workspace:

```text
<LLVM_PROJECT>
```

The LLVM CMake configuration used by the standalone passes is:

```text
<LLVM_PROJECT>\build\lib\cmake\llvm
```

The LLVM installation is not rebuilt for every pass. Each optimization is compiled independently as a plugin.

## Building an Optimization Pass

For example, to build Dead Code Elimination, navigate to the assignment directory and then:

```cmd
cd <ASSIGNMENT>\dead-code-elimination
```

Configure the project:

```cmd
cmake -S . -B build -G "Visual Studio 17 2022" -A x64
```

Build the Release version:

```cmd
cmake --build build --config Release
```

The resulting plugin is:

```text
build\Release\DeadCodeElimination.dll
```

The same build process is used for the other optimization passes.

## Why DLL Plugins Are Used

Each optimization pass is compiled into a Windows DLL.

DLL means **Dynamic-Link Library**.

The DLL contains the compiled LLVM optimization pass and allows `mini-opt` to load and execute the pass without rebuilding the complete LLVM project.

The basic flow is:

```text
Optimization source code
        |
        v
      CMake
        |
        v
   Optimization.dll
        |
        v
      mini-opt
        |
        v
    LLVM IR output
```

## mini-opt

`mini-opt` is a small standalone LLVM optimization driver created for this assignment.

It provides the functionality needed to:

- read LLVM IR
- load an LLVM pass plugin
- select a pass by name
- execute the pass
- write the resulting LLVM IR

It is used instead of depending on a complete LLVM `opt` executable.

The executable is:

```text
mini-opt\build\Release\mini-opt.exe
```

A typical invocation is:

```cmd
mini-opt\build\Release\mini-opt.exe ^
  -load-pass-plugin="path\PassName.dll" ^
  -passes="pass-name" ^
  "before.ll" ^
  -o "after.ll"
```

For example, from the `assignment` directory:

```cmd
mini-opt\build\Release\mini-opt.exe -load-pass-plugin="dead-code-elimination\build\Release\DeadCodeElimination.dll" -passes="dead-code-elimination" "dead-code-elimination\DeadCodeElimination_before.ll" -o "dead-code-elimination\DeadCodeElimination_after.ll"
```

The command:

1. Loads the DCE DLL.
2. Registers the `dead-code-elimination` pass.
3. Reads the input LLVM IR.
4. Runs the optimization.
5. Writes the optimized IR.

## Before and After IR Testing

Each pass is tested using LLVM IR.

The general workflow is:

```text
PassName_before.ll
        |
        v
     mini-opt
        |
        v
PassName_after.ll
```

The `before.ll` file contains instructions that can be optimized.

The `after.ll` file is generated by running the actual pass.

This provides a direct way to verify that the implementation changes the LLVM IR as intended.

For example, Dead Code Elimination starts with:

```llvm
define i32 @test(i32 %x, i32 %y) {
entry:
  %dead1 = add i32 %x, %y
  %dead2 = mul i32 %x, 10
  %used = add i32 %x, 5
  ret i32 %used
}
```

After running the pass:

```llvm
define i32 @test(i32 %x, i32 %y) {
entry:
  %used = add i32 %x, 5
  ret i32 %used
}
```

The unused instructions are removed while the required computation remains.

## Optimization Pass Summary

### Constant Propagation

Replaces uses of values when their values are known to be constant.

Example:

```text
constant value
     |
     v
replace uses
     |
     v
simpler IR
```

### Algebraic Identity

Simplifies expressions using algebraic identities.

Examples include:

```text
x + 0  -> x
x * 1  -> x
x - x  -> 0
```

This removes unnecessary arithmetic operations.

### Constant Folding

Evaluates operations whose operands are compile-time constants.

Examples:

```text
10 + 5 -> 15
4 * 5  -> 20
20 - 7 -> 13
15 & 7 -> 7
```

The calculated value replaces the original instruction.

### Copy Propagation

Replaces a value loaded or copied from a known location with the original value when it is safe to do so.

Example:

```text
store x
load x
```

can allow subsequent uses of the loaded value to directly use `x`.

### Redundant Store Elimination

Removes stores that write the same value to the same memory location without an intervening operation that changes the value.

Example:

```text
store x, %a
store x, %a
```

The second store is redundant.

### Strength Reduction

Replaces expensive operations with cheaper equivalent operations where appropriate.

For example:

```text
x * 2  -> x << 1
x * 4  -> x << 2
x * 8  -> x << 3
```

Multiplication by powers of two can therefore be represented using shifts.

### Dead Code Elimination

Removes instructions whose results are never used and which have no observable side effects.

Example:

```text
%dead = add i32 %x, %y
```

is removed when `%dead` has no uses and the instruction has no side effects.

## Matrix Multiplication

The `matrix-multiplication` directory contains a source-level implementation of matrix multiplication and several loop transformations.

The program compares:

- Naive matrix multiplication
- Loop interchange
- Loop tiling
- Loop unrolling

The computation is:

```text
C = A * B
```

The implementation also checks that the optimized versions produce the same result as the reference implementation.

### Loop Interchange

Loop interchange changes the order of nested loops to improve memory locality.

The goal is to make the innermost loop access memory with a more cache-friendly stride.

### Loop Tiling

Loop tiling divides the iteration space into smaller blocks.

This improves cache reuse by keeping portions of the matrices in the cache for longer.

### Loop Unrolling

Loop unrolling duplicates loop iterations inside the loop body.

This reduces loop-control overhead and can expose additional instruction-level parallelism.

## Matrix Multiplication Build and Run

The matrix multiplication program can be compiled using LLVM Clang:

```cmd
clang -O2 matrix_mul.c -o matrix_mul.exe
```

Run it with:

```cmd
matrix_mul.exe
```

The program reports the execution time and speedup for each implementation.

Example output:

```text
Matrix size 512 x 512, tile size 64

Naive         0.4970 s   1.00x
Interchange   0.1340 s   3.71x   ok
Tiling        0.1510 s   3.29x   ok
Unrolling     0.1260 s   3.94x   ok
```

The exact timing depends on the processor, memory hierarchy, compiler version, and system load.

## LLVM IR for Matrix Multiplication

The matrix multiplication directory also contains:

```text
matrix_mul.ll
```

This is the LLVM IR representation generated from the C implementation.

It can be used to inspect how the source-level matrix multiplication is represented in LLVM IR.

## Reproducibility

The optimization passes can be reproduced independently.

For each pass:

```text
1. Configure with CMake
2. Build the Release DLL
3. Prepare the before.ll test input
4. Load the DLL using mini-opt
5. Run the pass
6. Generate the after.ll output
7. Compare before and after IR
```

The matrix multiplication experiment follows:

```text
1. Compile matrix_mul.c
2. Run the executable
3. Measure each loop implementation
4. Verify correctness
5. Compare execution times and speedups
```

## Repository Notes

Generated files are intentionally excluded from version control.

The following should not be committed:

```text
build/
*.dll
*.lib
*.exp
*.obj
*.exe
```

The repository contains the source code, CMake configuration, test LLVM IR, generated reference output, and documentation required to understand and reproduce the assignment.

## Summary

This assignment demonstrates two levels of compiler optimization:

```text
Source-level optimization
        |
        +-- Loop Interchange
        +-- Loop Tiling
        +-- Loop Unrolling


LLVM IR optimization
        |
        +-- Constant Propagation
        +-- Algebraic Identity
        +-- Constant Folding
        +-- Copy Propagation
        +-- Redundant Store Elimination
        +-- Strength Reduction
        +-- Dead Code Elimination
```

The LLVM passes are implemented as standalone plugins and executed using `mini-opt`. The matrix multiplication experiments demonstrate the performance impact of loop transformations on a real numerical workload.