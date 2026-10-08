; ModuleID = 'RedundantStoreElimination_before.ll'
source_filename = "RedundantStoreElimination_before.ll"

define i32 @test(i32 %x) {
entry:
  %a = alloca i32, align 4
  store i32 %x, ptr %a, align 4
  %b = load i32, ptr %a, align 4
  ret i32 %b
}
