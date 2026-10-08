cmake_minimum_required(VERSION 3.20)

project(DeadCodeElimination LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(LLVM_DIR "C:/Users/MCW/llvm_project/llvm-project/build/lib/cmake/llvm")

find_package(LLVM REQUIRED CONFIG)

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

add_library(DeadCodeElimination MODULE
    DeadCodeElimination.cpp
)

set_target_properties(DeadCodeElimination PROPERTIES
    PREFIX ""
    WINDOWS_EXPORT_ALL_SYMBOLS ON
)

llvm_map_components_to_libnames(LLVM_LIBS
    Core
    Support
    Analysis
    TransformUtils
)

target_link_libraries(DeadCodeElimination
    PRIVATE ${LLVM_LIBS}
)