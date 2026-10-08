define i32 @test(i32 %x, i32 %y) {
entry:
  %dead1 = add i32 %x, %y
  %dead2 = mul i32 %x, 10
  %used = add i32 %x, 5
  ret i32 %used
}