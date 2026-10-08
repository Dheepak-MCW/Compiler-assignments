define i32 @test(i32 %x) {
entry:
  %a = alloca i32
  store i32 %x, ptr %a
  store i32 %x, ptr %a
  %b = load i32, ptr %a
  ret i32 %b
}