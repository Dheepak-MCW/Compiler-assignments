define i32 @test(i32 %x) {
entry:
  %a = add i32 %x, 0
  %b = mul i32 %a, 1
  %c = sub i32 %b, %b
  ret i32 %c
}