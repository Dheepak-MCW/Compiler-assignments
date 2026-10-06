define i32 @main() {
entry:
  %x = alloca i32
  store i32 10, ptr %x
  %a = load i32, ptr %x
  %y = add i32 %a, 5
  ret i32 %y
}
