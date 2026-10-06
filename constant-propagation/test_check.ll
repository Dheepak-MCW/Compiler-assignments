; ModuleID = 'test.bc'
source_filename = "test.ll"

define i32 @main() {
entry:
  %x = alloca i32, align 4
  store i32 10, ptr %x, align 4
  %a = load i32, ptr %x, align 4
  %y = add i32 %a, 5
  ret i32 %y
}
