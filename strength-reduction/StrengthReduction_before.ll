define i32 @test(i32 %x) {
entry:
  %a = mul i32 %x, 2
  %b = mul i32 %x, 4
  %c = mul i32 %x, 8
  %d = mul i32 %x, 3
  %e = add i32 %a, %b
  %f = add i32 %e, %c
  %g = add i32 %f, %d
  ret i32 %g
}