; ModuleID = 'C:\Users\MCW\llvm_project\llvm-project\assignment\dead-code-elimination\DeadCodeElimination_before.ll'
source_filename = "C:\\Users\\MCW\\llvm_project\\llvm-project\\assignment\\dead-code-elimination\\DeadCodeElimination_before.ll"

define i32 @test(i32 %x, i32 %y) {
entry:
  %used = add i32 %x, 5
  ret i32 %used
}
