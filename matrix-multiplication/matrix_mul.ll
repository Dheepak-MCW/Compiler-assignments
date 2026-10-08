; ModuleID = 'matrix_mul.c'
source_filename = "matrix_mul.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.42.34433"

$sprintf = comdat any

$vsprintf = comdat any

$_snprintf = comdat any

$_vsnprintf = comdat any

$printf = comdat any

$_vsprintf_l = comdat any

$_vsnprintf_l = comdat any

$__local_stdio_printf_options = comdat any

$_vfprintf_l = comdat any

$"??_C@_0CB@LOPINMNG@Matrix?5multiplication?3?5?$CFd?5x?5?$CFd?6?6@" = comdat any

$"??_C@_0CJ@DOAKPOFL@Reference?5multiplication?5?3?5?$CF?44f?5@" = comdat any

$"??_C@_03ICICOMAL@yes?$AA@" = comdat any

$"??_C@_02KAJCLHKP@no?$AA@" = comdat any

$"??_C@_0DJ@GKECCNJC@Loop?5interchange?5?5?5?5?5?5?5?5?5?3?5?$CF?44f?5@" = comdat any

$"??_C@_0DJ@FHDIMGND@Loop?5tiling?5?5?5?5?5?5?5?5?5?5?5?5?5?5?3?5?$CF?44f?5@" = comdat any

$"??_C@_0DJ@DAFBNBEJ@Loop?5unrolling?5?5?5?5?5?5?5?5?5?5?5?3?5?$CF?44f?5@" = comdat any

@"??_C@_0CB@LOPINMNG@Matrix?5multiplication?3?5?$CFd?5x?5?$CFd?6?6@" = linkonce_odr dso_local unnamed_addr constant [33 x i8] c"Matrix multiplication: %d x %d\0A\0A\00", comdat, align 8
@matrixA = internal global [500 x [500 x i32]] zeroinitializer, align 16
@matrixB = internal global [500 x [500 x i32]] zeroinitializer, align 16
@"??_C@_0CJ@DOAKPOFL@Reference?5multiplication?5?3?5?$CF?44f?5@" = linkonce_odr dso_local unnamed_addr constant [41 x i8] c"Reference multiplication : %.4f seconds\0A\00", comdat, align 8
@matrixC = internal global [500 x [500 x i32]] zeroinitializer, align 16
@"??_C@_03ICICOMAL@yes?$AA@" = linkonce_odr dso_local unnamed_addr constant [4 x i8] c"yes\00", comdat, align 4
@"??_C@_02KAJCLHKP@no?$AA@" = linkonce_odr dso_local unnamed_addr constant [3 x i8] c"no\00", comdat, align 4
@"??_C@_0DJ@GKECCNJC@Loop?5interchange?5?5?5?5?5?5?5?5?5?3?5?$CF?44f?5@" = linkonce_odr dso_local unnamed_addr constant [57 x i8] c"Loop interchange         : %.4f seconds  (correct = %s)\0A\00", comdat, align 8
@"??_C@_0DJ@FHDIMGND@Loop?5tiling?5?5?5?5?5?5?5?5?5?5?5?5?5?5?3?5?$CF?44f?5@" = linkonce_odr dso_local unnamed_addr constant [57 x i8] c"Loop tiling              : %.4f seconds  (correct = %s)\0A\00", comdat, align 8
@"??_C@_0DJ@DAFBNBEJ@Loop?5unrolling?5?5?5?5?5?5?5?5?5?5?5?3?5?$CF?44f?5@" = linkonce_odr dso_local unnamed_addr constant [57 x i8] c"Loop unrolling           : %.4f seconds  (correct = %s)\0A\00", comdat, align 8
@__local_stdio_printf_options._OptionsStorage = internal global i64 0, align 8

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @sprintf(ptr noundef %0, ptr noundef %1, ...) #0 comdat {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  store ptr %1, ptr %3, align 8
  store ptr %0, ptr %4, align 8
  call void @llvm.va_start.p0(ptr %6)
  %7 = load ptr, ptr %6, align 8
  %8 = load ptr, ptr %3, align 8
  %9 = load ptr, ptr %4, align 8
  %10 = call i32 @_vsprintf_l(ptr noundef %9, ptr noundef %8, ptr noundef null, ptr noundef %7)
  store i32 %10, ptr %5, align 4
  call void @llvm.va_end.p0(ptr %6)
  %11 = load i32, ptr %5, align 4
  ret i32 %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @vsprintf(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 comdat {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %2, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %0, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call i32 @_vsnprintf_l(ptr noundef %9, i64 noundef -1, ptr noundef %8, ptr noundef null, ptr noundef %7)
  ret i32 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_snprintf(ptr noundef %0, i64 noundef %1, ptr noundef %2, ...) #0 comdat {
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  store ptr %2, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store ptr %0, ptr %6, align 8
  call void @llvm.va_start.p0(ptr %8)
  %9 = load ptr, ptr %8, align 8
  %10 = load ptr, ptr %4, align 8
  %11 = load i64, ptr %5, align 8
  %12 = load ptr, ptr %6, align 8
  %13 = call i32 @_vsnprintf(ptr noundef %12, i64 noundef %11, ptr noundef %10, ptr noundef %9)
  store i32 %13, ptr %7, align 4
  call void @llvm.va_end.p0(ptr %8)
  %14 = load i32, ptr %7, align 4
  ret i32 %14
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_vsnprintf(ptr noundef %0, i64 noundef %1, ptr noundef %2, ptr noundef %3) #0 comdat {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  store ptr %3, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i64 %1, ptr %7, align 8
  store ptr %0, ptr %8, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = load i64, ptr %7, align 8
  %12 = load ptr, ptr %8, align 8
  %13 = call i32 @_vsnprintf_l(ptr noundef %12, i64 noundef %11, ptr noundef %10, ptr noundef null, ptr noundef %9)
  ret i32 %13
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [500 x [500 x i32]], align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca double, align 8
  store i32 0, ptr %1, align 4
  %6 = call i32 (ptr, ...) @printf(ptr noundef @"??_C@_0CB@LOPINMNG@Matrix?5multiplication?3?5?$CFd?5x?5?$CFd?6?6@", i32 noundef 500, i32 noundef 500)
  call void @initialize_matrix(ptr noundef @matrixA)
  call void @initialize_matrix(ptr noundef @matrixB)
  %7 = call i32 @clock()
  store i32 %7, ptr %3, align 4
  call void @multiply_reference()
  %8 = call i32 @clock()
  store i32 %8, ptr %4, align 4
  %9 = load i32, ptr %4, align 4
  %10 = load i32, ptr %3, align 4
  %11 = sub i32 %9, %10
  %12 = sitofp i32 %11 to double
  %13 = fdiv double %12, 1.000000e+03
  store double %13, ptr %5, align 8
  %14 = load double, ptr %5, align 8
  %15 = call i32 (ptr, ...) @printf(ptr noundef @"??_C@_0CJ@DOAKPOFL@Reference?5multiplication?5?3?5?$CF?44f?5@", double noundef %14)
  %16 = getelementptr inbounds [500 x [500 x i32]], ptr %2, i64 0, i64 0
  call void @copy_matrix(ptr noundef @matrixC, ptr noundef %16)
  %17 = call i32 @clock()
  store i32 %17, ptr %3, align 4
  call void @multiply_interchanged()
  %18 = call i32 @clock()
  store i32 %18, ptr %4, align 4
  %19 = getelementptr inbounds [500 x [500 x i32]], ptr %2, i64 0, i64 0
  %20 = call i32 @matrices_equal(ptr noundef @matrixC, ptr noundef %19)
  %21 = icmp ne i32 %20, 0
  %22 = zext i1 %21 to i64
  %23 = select i1 %21, ptr @"??_C@_03ICICOMAL@yes?$AA@", ptr @"??_C@_02KAJCLHKP@no?$AA@"
  %24 = load i32, ptr %4, align 4
  %25 = load i32, ptr %3, align 4
  %26 = sub i32 %24, %25
  %27 = sitofp i32 %26 to double
  %28 = fdiv double %27, 1.000000e+03
  %29 = call i32 (ptr, ...) @printf(ptr noundef @"??_C@_0DJ@GKECCNJC@Loop?5interchange?5?5?5?5?5?5?5?5?5?3?5?$CF?44f?5@", double noundef %28, ptr noundef %23)
  %30 = call i32 @clock()
  store i32 %30, ptr %3, align 4
  call void @multiply_tiled()
  %31 = call i32 @clock()
  store i32 %31, ptr %4, align 4
  %32 = getelementptr inbounds [500 x [500 x i32]], ptr %2, i64 0, i64 0
  %33 = call i32 @matrices_equal(ptr noundef @matrixC, ptr noundef %32)
  %34 = icmp ne i32 %33, 0
  %35 = zext i1 %34 to i64
  %36 = select i1 %34, ptr @"??_C@_03ICICOMAL@yes?$AA@", ptr @"??_C@_02KAJCLHKP@no?$AA@"
  %37 = load i32, ptr %4, align 4
  %38 = load i32, ptr %3, align 4
  %39 = sub i32 %37, %38
  %40 = sitofp i32 %39 to double
  %41 = fdiv double %40, 1.000000e+03
  %42 = call i32 (ptr, ...) @printf(ptr noundef @"??_C@_0DJ@FHDIMGND@Loop?5tiling?5?5?5?5?5?5?5?5?5?5?5?5?5?5?3?5?$CF?44f?5@", double noundef %41, ptr noundef %36)
  %43 = call i32 @clock()
  store i32 %43, ptr %3, align 4
  call void @multiply_unrolled()
  %44 = call i32 @clock()
  store i32 %44, ptr %4, align 4
  %45 = getelementptr inbounds [500 x [500 x i32]], ptr %2, i64 0, i64 0
  %46 = call i32 @matrices_equal(ptr noundef @matrixC, ptr noundef %45)
  %47 = icmp ne i32 %46, 0
  %48 = zext i1 %47 to i64
  %49 = select i1 %47, ptr @"??_C@_03ICICOMAL@yes?$AA@", ptr @"??_C@_02KAJCLHKP@no?$AA@"
  %50 = load i32, ptr %4, align 4
  %51 = load i32, ptr %3, align 4
  %52 = sub i32 %50, %51
  %53 = sitofp i32 %52 to double
  %54 = fdiv double %53, 1.000000e+03
  %55 = call i32 (ptr, ...) @printf(ptr noundef @"??_C@_0DJ@DAFBNBEJ@Loop?5unrolling?5?5?5?5?5?5?5?5?5?5?5?3?5?$CF?44f?5@", double noundef %54, ptr noundef %49)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @printf(ptr noundef %0, ...) #0 comdat {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.va_start.p0(ptr %4)
  %5 = load ptr, ptr %4, align 8
  %6 = load ptr, ptr %2, align 8
  %7 = call ptr @__acrt_iob_func(i32 noundef 1)
  %8 = call i32 @_vfprintf_l(ptr noundef %7, ptr noundef %6, ptr noundef null, ptr noundef %5)
  store i32 %8, ptr %3, align 4
  call void @llvm.va_end.p0(ptr %4)
  %9 = load i32, ptr %3, align 4
  ret i32 %9
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @initialize_matrix(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  br label %5

5:                                                ; preds = %28, %1
  %6 = load i32, ptr %3, align 4
  %7 = icmp slt i32 %6, 500
  br i1 %7, label %8, label %31

8:                                                ; preds = %5
  store i32 0, ptr %4, align 4
  br label %9

9:                                                ; preds = %24, %8
  %10 = load i32, ptr %4, align 4
  %11 = icmp slt i32 %10, 500
  br i1 %11, label %12, label %27

12:                                               ; preds = %9
  %13 = load i32, ptr %3, align 4
  %14 = load i32, ptr %4, align 4
  %15 = add i32 %13, %14
  %16 = srem i32 %15, 10
  %17 = load ptr, ptr %2, align 8
  %18 = load i32, ptr %3, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [500 x i32], ptr %17, i64 %19
  %21 = load i32, ptr %4, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [500 x i32], ptr %20, i64 0, i64 %22
  store i32 %16, ptr %23, align 4
  br label %24

24:                                               ; preds = %12
  %25 = load i32, ptr %4, align 4
  %26 = add i32 %25, 1
  store i32 %26, ptr %4, align 4
  br label %9, !llvm.loop !7

27:                                               ; preds = %9
  br label %28

28:                                               ; preds = %27
  %29 = load i32, ptr %3, align 4
  %30 = add i32 %29, 1
  store i32 %30, ptr %3, align 4
  br label %5, !llvm.loop !9

31:                                               ; preds = %5
  ret void
}

declare dso_local i32 @clock() #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @multiply_reference() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  call void @reset_matrix(ptr noundef @matrixC)
  store i32 0, ptr %1, align 4
  br label %5

5:                                                ; preds = %49, %0
  %6 = load i32, ptr %1, align 4
  %7 = icmp slt i32 %6, 500
  br i1 %7, label %8, label %52

8:                                                ; preds = %5
  store i32 0, ptr %2, align 4
  br label %9

9:                                                ; preds = %45, %8
  %10 = load i32, ptr %2, align 4
  %11 = icmp slt i32 %10, 500
  br i1 %11, label %12, label %48

12:                                               ; preds = %9
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %13

13:                                               ; preds = %34, %12
  %14 = load i32, ptr %4, align 4
  %15 = icmp slt i32 %14, 500
  br i1 %15, label %16, label %37

16:                                               ; preds = %13
  %17 = load i32, ptr %1, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixA, i64 0, i64 %18
  %20 = load i32, ptr %4, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [500 x i32], ptr %19, i64 0, i64 %21
  %23 = load i32, ptr %22, align 4
  %24 = load i32, ptr %4, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixB, i64 0, i64 %25
  %27 = load i32, ptr %2, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds [500 x i32], ptr %26, i64 0, i64 %28
  %30 = load i32, ptr %29, align 4
  %31 = mul i32 %23, %30
  %32 = load i32, ptr %3, align 4
  %33 = add i32 %32, %31
  store i32 %33, ptr %3, align 4
  br label %34

34:                                               ; preds = %16
  %35 = load i32, ptr %4, align 4
  %36 = add i32 %35, 1
  store i32 %36, ptr %4, align 4
  br label %13, !llvm.loop !10

37:                                               ; preds = %13
  %38 = load i32, ptr %3, align 4
  %39 = load i32, ptr %1, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixC, i64 0, i64 %40
  %42 = load i32, ptr %2, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [500 x i32], ptr %41, i64 0, i64 %43
  store i32 %38, ptr %44, align 4
  br label %45

45:                                               ; preds = %37
  %46 = load i32, ptr %2, align 4
  %47 = add i32 %46, 1
  store i32 %47, ptr %2, align 4
  br label %9, !llvm.loop !11

48:                                               ; preds = %9
  br label %49

49:                                               ; preds = %48
  %50 = load i32, ptr %1, align 4
  %51 = add i32 %50, 1
  store i32 %51, ptr %1, align 4
  br label %5, !llvm.loop !12

52:                                               ; preds = %5
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @copy_matrix(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %1, ptr %3, align 8
  store ptr %0, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %7

7:                                                ; preds = %34, %2
  %8 = load i32, ptr %5, align 4
  %9 = icmp slt i32 %8, 500
  br i1 %9, label %10, label %37

10:                                               ; preds = %7
  store i32 0, ptr %6, align 4
  br label %11

11:                                               ; preds = %30, %10
  %12 = load i32, ptr %6, align 4
  %13 = icmp slt i32 %12, 500
  br i1 %13, label %14, label %33

14:                                               ; preds = %11
  %15 = load ptr, ptr %4, align 8
  %16 = load i32, ptr %5, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [500 x i32], ptr %15, i64 %17
  %19 = load i32, ptr %6, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [500 x i32], ptr %18, i64 0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = load ptr, ptr %3, align 8
  %24 = load i32, ptr %5, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [500 x i32], ptr %23, i64 %25
  %27 = load i32, ptr %6, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds [500 x i32], ptr %26, i64 0, i64 %28
  store i32 %22, ptr %29, align 4
  br label %30

30:                                               ; preds = %14
  %31 = load i32, ptr %6, align 4
  %32 = add i32 %31, 1
  store i32 %32, ptr %6, align 4
  br label %11, !llvm.loop !13

33:                                               ; preds = %11
  br label %34

34:                                               ; preds = %33
  %35 = load i32, ptr %5, align 4
  %36 = add i32 %35, 1
  store i32 %36, ptr %5, align 4
  br label %7, !llvm.loop !14

37:                                               ; preds = %7
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @multiply_interchanged() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  call void @reset_matrix(ptr noundef @matrixC)
  store i32 0, ptr %1, align 4
  br label %5

5:                                                ; preds = %49, %0
  %6 = load i32, ptr %1, align 4
  %7 = icmp slt i32 %6, 500
  br i1 %7, label %8, label %52

8:                                                ; preds = %5
  store i32 0, ptr %2, align 4
  br label %9

9:                                                ; preds = %45, %8
  %10 = load i32, ptr %2, align 4
  %11 = icmp slt i32 %10, 500
  br i1 %11, label %12, label %48

12:                                               ; preds = %9
  %13 = load i32, ptr %1, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixA, i64 0, i64 %14
  %16 = load i32, ptr %2, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [500 x i32], ptr %15, i64 0, i64 %17
  %19 = load i32, ptr %18, align 4
  store i32 %19, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %20

20:                                               ; preds = %41, %12
  %21 = load i32, ptr %4, align 4
  %22 = icmp slt i32 %21, 500
  br i1 %22, label %23, label %44

23:                                               ; preds = %20
  %24 = load i32, ptr %3, align 4
  %25 = load i32, ptr %2, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixB, i64 0, i64 %26
  %28 = load i32, ptr %4, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [500 x i32], ptr %27, i64 0, i64 %29
  %31 = load i32, ptr %30, align 4
  %32 = mul i32 %24, %31
  %33 = load i32, ptr %1, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixC, i64 0, i64 %34
  %36 = load i32, ptr %4, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [500 x i32], ptr %35, i64 0, i64 %37
  %39 = load i32, ptr %38, align 4
  %40 = add i32 %39, %32
  store i32 %40, ptr %38, align 4
  br label %41

41:                                               ; preds = %23
  %42 = load i32, ptr %4, align 4
  %43 = add i32 %42, 1
  store i32 %43, ptr %4, align 4
  br label %20, !llvm.loop !15

44:                                               ; preds = %20
  br label %45

45:                                               ; preds = %44
  %46 = load i32, ptr %2, align 4
  %47 = add i32 %46, 1
  store i32 %47, ptr %2, align 4
  br label %9, !llvm.loop !16

48:                                               ; preds = %9
  br label %49

49:                                               ; preds = %48
  %50 = load i32, ptr %1, align 4
  %51 = add i32 %50, 1
  store i32 %51, ptr %1, align 4
  br label %5, !llvm.loop !17

52:                                               ; preds = %5
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @matrices_equal(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %1, ptr %4, align 8
  store ptr %0, ptr %5, align 8
  store i32 0, ptr %6, align 4
  br label %8

8:                                                ; preds = %39, %2
  %9 = load i32, ptr %6, align 4
  %10 = icmp slt i32 %9, 500
  br i1 %10, label %11, label %42

11:                                               ; preds = %8
  store i32 0, ptr %7, align 4
  br label %12

12:                                               ; preds = %35, %11
  %13 = load i32, ptr %7, align 4
  %14 = icmp slt i32 %13, 500
  br i1 %14, label %15, label %38

15:                                               ; preds = %12
  %16 = load ptr, ptr %5, align 8
  %17 = load i32, ptr %6, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [500 x i32], ptr %16, i64 %18
  %20 = load i32, ptr %7, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [500 x i32], ptr %19, i64 0, i64 %21
  %23 = load i32, ptr %22, align 4
  %24 = load ptr, ptr %4, align 8
  %25 = load i32, ptr %6, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [500 x i32], ptr %24, i64 %26
  %28 = load i32, ptr %7, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [500 x i32], ptr %27, i64 0, i64 %29
  %31 = load i32, ptr %30, align 4
  %32 = icmp ne i32 %23, %31
  br i1 %32, label %33, label %34

33:                                               ; preds = %15
  store i32 0, ptr %3, align 4
  br label %43

34:                                               ; preds = %15
  br label %35

35:                                               ; preds = %34
  %36 = load i32, ptr %7, align 4
  %37 = add i32 %36, 1
  store i32 %37, ptr %7, align 4
  br label %12, !llvm.loop !18

38:                                               ; preds = %12
  br label %39

39:                                               ; preds = %38
  %40 = load i32, ptr %6, align 4
  %41 = add i32 %40, 1
  store i32 %41, ptr %6, align 4
  br label %8, !llvm.loop !19

42:                                               ; preds = %8
  store i32 1, ptr %3, align 4
  br label %43

43:                                               ; preds = %42, %33
  %44 = load i32, ptr %3, align 4
  ret i32 %44
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @multiply_tiled() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  call void @reset_matrix(ptr noundef @matrixC)
  store i32 0, ptr %1, align 4
  br label %11

11:                                               ; preds = %103, %0
  %12 = load i32, ptr %1, align 4
  %13 = icmp slt i32 %12, 500
  br i1 %13, label %14, label %106

14:                                               ; preds = %11
  store i32 0, ptr %2, align 4
  br label %15

15:                                               ; preds = %99, %14
  %16 = load i32, ptr %2, align 4
  %17 = icmp slt i32 %16, 500
  br i1 %17, label %18, label %102

18:                                               ; preds = %15
  store i32 0, ptr %3, align 4
  br label %19

19:                                               ; preds = %95, %18
  %20 = load i32, ptr %3, align 4
  %21 = icmp slt i32 %20, 500
  br i1 %21, label %22, label %98

22:                                               ; preds = %19
  %23 = load i32, ptr %1, align 4
  %24 = add i32 %23, 25
  store i32 %24, ptr %4, align 4
  %25 = load i32, ptr %2, align 4
  %26 = add i32 %25, 25
  store i32 %26, ptr %5, align 4
  %27 = load i32, ptr %3, align 4
  %28 = add i32 %27, 25
  store i32 %28, ptr %6, align 4
  %29 = load i32, ptr %4, align 4
  %30 = icmp sgt i32 %29, 500
  br i1 %30, label %31, label %32

31:                                               ; preds = %22
  store i32 500, ptr %4, align 4
  br label %32

32:                                               ; preds = %31, %22
  %33 = load i32, ptr %5, align 4
  %34 = icmp sgt i32 %33, 500
  br i1 %34, label %35, label %36

35:                                               ; preds = %32
  store i32 500, ptr %5, align 4
  br label %36

36:                                               ; preds = %35, %32
  %37 = load i32, ptr %6, align 4
  %38 = icmp sgt i32 %37, 500
  br i1 %38, label %39, label %40

39:                                               ; preds = %36
  store i32 500, ptr %6, align 4
  br label %40

40:                                               ; preds = %39, %36
  %41 = load i32, ptr %1, align 4
  store i32 %41, ptr %7, align 4
  br label %42

42:                                               ; preds = %91, %40
  %43 = load i32, ptr %7, align 4
  %44 = load i32, ptr %4, align 4
  %45 = icmp slt i32 %43, %44
  br i1 %45, label %46, label %94

46:                                               ; preds = %42
  %47 = load i32, ptr %2, align 4
  store i32 %47, ptr %8, align 4
  br label %48

48:                                               ; preds = %87, %46
  %49 = load i32, ptr %8, align 4
  %50 = load i32, ptr %5, align 4
  %51 = icmp slt i32 %49, %50
  br i1 %51, label %52, label %90

52:                                               ; preds = %48
  %53 = load i32, ptr %7, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixA, i64 0, i64 %54
  %56 = load i32, ptr %8, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [500 x i32], ptr %55, i64 0, i64 %57
  %59 = load i32, ptr %58, align 4
  store i32 %59, ptr %9, align 4
  %60 = load i32, ptr %3, align 4
  store i32 %60, ptr %10, align 4
  br label %61

61:                                               ; preds = %83, %52
  %62 = load i32, ptr %10, align 4
  %63 = load i32, ptr %6, align 4
  %64 = icmp slt i32 %62, %63
  br i1 %64, label %65, label %86

65:                                               ; preds = %61
  %66 = load i32, ptr %9, align 4
  %67 = load i32, ptr %8, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixB, i64 0, i64 %68
  %70 = load i32, ptr %10, align 4
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds [500 x i32], ptr %69, i64 0, i64 %71
  %73 = load i32, ptr %72, align 4
  %74 = mul i32 %66, %73
  %75 = load i32, ptr %7, align 4
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixC, i64 0, i64 %76
  %78 = load i32, ptr %10, align 4
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds [500 x i32], ptr %77, i64 0, i64 %79
  %81 = load i32, ptr %80, align 4
  %82 = add i32 %81, %74
  store i32 %82, ptr %80, align 4
  br label %83

83:                                               ; preds = %65
  %84 = load i32, ptr %10, align 4
  %85 = add i32 %84, 1
  store i32 %85, ptr %10, align 4
  br label %61, !llvm.loop !20

86:                                               ; preds = %61
  br label %87

87:                                               ; preds = %86
  %88 = load i32, ptr %8, align 4
  %89 = add i32 %88, 1
  store i32 %89, ptr %8, align 4
  br label %48, !llvm.loop !21

90:                                               ; preds = %48
  br label %91

91:                                               ; preds = %90
  %92 = load i32, ptr %7, align 4
  %93 = add i32 %92, 1
  store i32 %93, ptr %7, align 4
  br label %42, !llvm.loop !22

94:                                               ; preds = %42
  br label %95

95:                                               ; preds = %94
  %96 = load i32, ptr %3, align 4
  %97 = add i32 %96, 25
  store i32 %97, ptr %3, align 4
  br label %19, !llvm.loop !23

98:                                               ; preds = %19
  br label %99

99:                                               ; preds = %98
  %100 = load i32, ptr %2, align 4
  %101 = add i32 %100, 25
  store i32 %101, ptr %2, align 4
  br label %15, !llvm.loop !24

102:                                              ; preds = %15
  br label %103

103:                                              ; preds = %102
  %104 = load i32, ptr %1, align 4
  %105 = add i32 %104, 25
  store i32 %105, ptr %1, align 4
  br label %11, !llvm.loop !25

106:                                              ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @multiply_unrolled() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  call void @reset_matrix(ptr noundef @matrixC)
  store i32 0, ptr %1, align 4
  br label %5

5:                                                ; preds = %138, %0
  %6 = load i32, ptr %1, align 4
  %7 = icmp slt i32 %6, 500
  br i1 %7, label %8, label %141

8:                                                ; preds = %5
  store i32 0, ptr %2, align 4
  br label %9

9:                                                ; preds = %134, %8
  %10 = load i32, ptr %2, align 4
  %11 = icmp slt i32 %10, 500
  br i1 %11, label %12, label %137

12:                                               ; preds = %9
  store i32 0, ptr %3, align 4
  br label %13

13:                                               ; preds = %99, %12
  %14 = load i32, ptr %3, align 4
  %15 = add i32 %14, 3
  %16 = icmp slt i32 %15, 500
  br i1 %16, label %17, label %102

17:                                               ; preds = %13
  %18 = load i32, ptr %1, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixA, i64 0, i64 %19
  %21 = load i32, ptr %2, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [500 x i32], ptr %20, i64 0, i64 %22
  %24 = load i32, ptr %23, align 4
  store i32 %24, ptr %4, align 4
  %25 = load i32, ptr %4, align 4
  %26 = load i32, ptr %2, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixB, i64 0, i64 %27
  %29 = load i32, ptr %3, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [500 x i32], ptr %28, i64 0, i64 %30
  %32 = load i32, ptr %31, align 4
  %33 = mul i32 %25, %32
  %34 = load i32, ptr %1, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixC, i64 0, i64 %35
  %37 = load i32, ptr %3, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [500 x i32], ptr %36, i64 0, i64 %38
  %40 = load i32, ptr %39, align 4
  %41 = add i32 %40, %33
  store i32 %41, ptr %39, align 4
  %42 = load i32, ptr %4, align 4
  %43 = load i32, ptr %2, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixB, i64 0, i64 %44
  %46 = load i32, ptr %3, align 4
  %47 = add i32 %46, 1
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [500 x i32], ptr %45, i64 0, i64 %48
  %50 = load i32, ptr %49, align 4
  %51 = mul i32 %42, %50
  %52 = load i32, ptr %1, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixC, i64 0, i64 %53
  %55 = load i32, ptr %3, align 4
  %56 = add i32 %55, 1
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [500 x i32], ptr %54, i64 0, i64 %57
  %59 = load i32, ptr %58, align 4
  %60 = add i32 %59, %51
  store i32 %60, ptr %58, align 4
  %61 = load i32, ptr %4, align 4
  %62 = load i32, ptr %2, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixB, i64 0, i64 %63
  %65 = load i32, ptr %3, align 4
  %66 = add i32 %65, 2
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds [500 x i32], ptr %64, i64 0, i64 %67
  %69 = load i32, ptr %68, align 4
  %70 = mul i32 %61, %69
  %71 = load i32, ptr %1, align 4
  %72 = sext i32 %71 to i64
  %73 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixC, i64 0, i64 %72
  %74 = load i32, ptr %3, align 4
  %75 = add i32 %74, 2
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds [500 x i32], ptr %73, i64 0, i64 %76
  %78 = load i32, ptr %77, align 4
  %79 = add i32 %78, %70
  store i32 %79, ptr %77, align 4
  %80 = load i32, ptr %4, align 4
  %81 = load i32, ptr %2, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixB, i64 0, i64 %82
  %84 = load i32, ptr %3, align 4
  %85 = add i32 %84, 3
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds [500 x i32], ptr %83, i64 0, i64 %86
  %88 = load i32, ptr %87, align 4
  %89 = mul i32 %80, %88
  %90 = load i32, ptr %1, align 4
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixC, i64 0, i64 %91
  %93 = load i32, ptr %3, align 4
  %94 = add i32 %93, 3
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds [500 x i32], ptr %92, i64 0, i64 %95
  %97 = load i32, ptr %96, align 4
  %98 = add i32 %97, %89
  store i32 %98, ptr %96, align 4
  br label %99

99:                                               ; preds = %17
  %100 = load i32, ptr %3, align 4
  %101 = add i32 %100, 4
  store i32 %101, ptr %3, align 4
  br label %13, !llvm.loop !26

102:                                              ; preds = %13
  br label %103

103:                                              ; preds = %130, %102
  %104 = load i32, ptr %3, align 4
  %105 = icmp slt i32 %104, 500
  br i1 %105, label %106, label %133

106:                                              ; preds = %103
  %107 = load i32, ptr %1, align 4
  %108 = sext i32 %107 to i64
  %109 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixA, i64 0, i64 %108
  %110 = load i32, ptr %2, align 4
  %111 = sext i32 %110 to i64
  %112 = getelementptr inbounds [500 x i32], ptr %109, i64 0, i64 %111
  %113 = load i32, ptr %112, align 4
  %114 = load i32, ptr %2, align 4
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixB, i64 0, i64 %115
  %117 = load i32, ptr %3, align 4
  %118 = sext i32 %117 to i64
  %119 = getelementptr inbounds [500 x i32], ptr %116, i64 0, i64 %118
  %120 = load i32, ptr %119, align 4
  %121 = mul i32 %113, %120
  %122 = load i32, ptr %1, align 4
  %123 = sext i32 %122 to i64
  %124 = getelementptr inbounds [500 x [500 x i32]], ptr @matrixC, i64 0, i64 %123
  %125 = load i32, ptr %3, align 4
  %126 = sext i32 %125 to i64
  %127 = getelementptr inbounds [500 x i32], ptr %124, i64 0, i64 %126
  %128 = load i32, ptr %127, align 4
  %129 = add i32 %128, %121
  store i32 %129, ptr %127, align 4
  br label %130

130:                                              ; preds = %106
  %131 = load i32, ptr %3, align 4
  %132 = add i32 %131, 1
  store i32 %132, ptr %3, align 4
  br label %103, !llvm.loop !27

133:                                              ; preds = %103
  br label %134

134:                                              ; preds = %133
  %135 = load i32, ptr %2, align 4
  %136 = add i32 %135, 1
  store i32 %136, ptr %2, align 4
  br label %9, !llvm.loop !28

137:                                              ; preds = %9
  br label %138

138:                                              ; preds = %137
  %139 = load i32, ptr %1, align 4
  %140 = add i32 %139, 1
  store i32 %140, ptr %1, align 4
  br label %5, !llvm.loop !29

141:                                              ; preds = %5
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #2

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_vsprintf_l(ptr noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3) #0 comdat {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  store ptr %3, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store ptr %1, ptr %7, align 8
  store ptr %0, ptr %8, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = load ptr, ptr %7, align 8
  %12 = load ptr, ptr %8, align 8
  %13 = call i32 @_vsnprintf_l(ptr noundef %12, i64 noundef -1, ptr noundef %11, ptr noundef %10, ptr noundef %9)
  ret i32 %13
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #2

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_vsnprintf_l(ptr noundef %0, i64 noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4) #0 comdat {
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i64, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  store ptr %4, ptr %6, align 8
  store ptr %3, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store i64 %1, ptr %9, align 8
  store ptr %0, ptr %10, align 8
  %12 = load ptr, ptr %6, align 8
  %13 = load ptr, ptr %7, align 8
  %14 = load ptr, ptr %8, align 8
  %15 = load i64, ptr %9, align 8
  %16 = load ptr, ptr %10, align 8
  %17 = call ptr @__local_stdio_printf_options()
  %18 = load i64, ptr %17, align 8
  %19 = or i64 %18, 1
  %20 = call i32 @__stdio_common_vsprintf(i64 noundef %19, ptr noundef %16, i64 noundef %15, ptr noundef %14, ptr noundef %13, ptr noundef %12)
  store i32 %20, ptr %11, align 4
  %21 = load i32, ptr %11, align 4
  %22 = icmp slt i32 %21, 0
  br i1 %22, label %23, label %24

23:                                               ; preds = %5
  br label %26

24:                                               ; preds = %5
  %25 = load i32, ptr %11, align 4
  br label %26

26:                                               ; preds = %24, %23
  %27 = phi i32 [ -1, %23 ], [ %25, %24 ]
  ret i32 %27
}

declare dso_local i32 @__stdio_common_vsprintf(i64 noundef, ptr noundef, i64 noundef, ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local ptr @__local_stdio_printf_options() #0 comdat {
  ret ptr @__local_stdio_printf_options._OptionsStorage
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dso_local i32 @_vfprintf_l(ptr noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3) #0 comdat {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  store ptr %3, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store ptr %1, ptr %7, align 8
  store ptr %0, ptr %8, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = load ptr, ptr %7, align 8
  %12 = load ptr, ptr %8, align 8
  %13 = call ptr @__local_stdio_printf_options()
  %14 = load i64, ptr %13, align 8
  %15 = call i32 @__stdio_common_vfprintf(i64 noundef %14, ptr noundef %12, ptr noundef %11, ptr noundef %10, ptr noundef %9)
  ret i32 %15
}

declare dso_local ptr @__acrt_iob_func(i32 noundef) #1

declare dso_local i32 @__stdio_common_vfprintf(i64 noundef, ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @reset_matrix(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  br label %5

5:                                                ; preds = %24, %1
  %6 = load i32, ptr %3, align 4
  %7 = icmp slt i32 %6, 500
  br i1 %7, label %8, label %27

8:                                                ; preds = %5
  store i32 0, ptr %4, align 4
  br label %9

9:                                                ; preds = %20, %8
  %10 = load i32, ptr %4, align 4
  %11 = icmp slt i32 %10, 500
  br i1 %11, label %12, label %23

12:                                               ; preds = %9
  %13 = load ptr, ptr %2, align 8
  %14 = load i32, ptr %3, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [500 x i32], ptr %13, i64 %15
  %17 = load i32, ptr %4, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [500 x i32], ptr %16, i64 0, i64 %18
  store i32 0, ptr %19, align 4
  br label %20

20:                                               ; preds = %12
  %21 = load i32, ptr %4, align 4
  %22 = add i32 %21, 1
  store i32 %22, ptr %4, align 4
  br label %9, !llvm.loop !30

23:                                               ; preds = %9
  br label %24

24:                                               ; preds = %23
  %25 = load i32, ptr %3, align 4
  %26 = add i32 %25, 1
  store i32 %26, ptr %3, align 4
  br label %5, !llvm.loop !31

27:                                               ; preds = %5
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "clang version 23.1.2 (https://github.com/llvm/llvm-project 85ac560262434c9ccfc0c183ec22d4138ed647fb)", isOptimized: false, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "matrix_mul.c", directory: "C:\\Users\\MCW\\llvm_project\\llvm-project\\assignment\\matrix-multiplication")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{i32 1, !"MaxTLSAlign", i32 65536}
!6 = !{!"clang version 23.1.2 (https://github.com/llvm/llvm-project 85ac560262434c9ccfc0c183ec22d4138ed647fb)"}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = distinct !{!9, !8}
!10 = distinct !{!10, !8}
!11 = distinct !{!11, !8}
!12 = distinct !{!12, !8}
!13 = distinct !{!13, !8}
!14 = distinct !{!14, !8}
!15 = distinct !{!15, !8}
!16 = distinct !{!16, !8}
!17 = distinct !{!17, !8}
!18 = distinct !{!18, !8}
!19 = distinct !{!19, !8}
!20 = distinct !{!20, !8}
!21 = distinct !{!21, !8}
!22 = distinct !{!22, !8}
!23 = distinct !{!23, !8}
!24 = distinct !{!24, !8}
!25 = distinct !{!25, !8}
!26 = distinct !{!26, !8}
!27 = distinct !{!27, !8}
!28 = distinct !{!28, !8}
!29 = distinct !{!29, !8}
!30 = distinct !{!30, !8}
!31 = distinct !{!31, !8}
