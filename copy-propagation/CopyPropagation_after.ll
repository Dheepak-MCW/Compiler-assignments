; ModuleID = 'CopyPropagation_before.ll'
source_filename = "CopyPropagation_before.ll"

define i32 @test(i32 %x) {
entry:
  %a = alloca i32, align 4
  store i32 %x, ptr %a, align 4
  %c = add i32 %x, 10
  ret i32 %c
}
