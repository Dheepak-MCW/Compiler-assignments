; ModuleID = 'StrengthReduction_before.ll'
source_filename = "StrengthReduction_before.ll"

define i32 @test(i32 %x) {
entry:
  %0 = shl i32 %x, 1
  %1 = shl i32 %x, 2
  %2 = shl i32 %x, 3
  %d = mul i32 %x, 3
  %e = add i32 %0, %1
  %f = add i32 %e, %2
  %g = add i32 %f, %d
  ret i32 %g
}
