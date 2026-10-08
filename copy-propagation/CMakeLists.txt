cmake_minimum_required(VERSION 3.20)

project(CopyPropagation LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(LLVM_DIR
    "C:/Users/MCW/llvm_project/llvm-project/build/lib/cmake/llvm"
)

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "LLVM include dirs: ${LLVM_INCLUDE_DIRS}")

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

add_library(CopyPropagation MODULE
    CopyPropagation.cpp
)

set_target_properties(CopyPropagation PROPERTIES
    PREFIX ""
    WINDOWS_EXPORT_ALL_SYMBOLS ON
)

llvm_map_components_to_libnames(LLVM_LIBS
    Core
    Support
    Analysis
    TransformUtils
)

target_link_libraries(CopyPropagation
    PRIVATE
    ${LLVM_LIBS}
)