define i32 @test(i32 %x) {
entry:
  %a = alloca i32
  store i32 %x, ptr %a
  %b = load i32, ptr %a
  %c = add i32 %b, 10
  ret i32 %c
}