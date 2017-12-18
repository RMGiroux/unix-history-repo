; RUN: opt -S -instcombine < %s | FileCheck %s
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.8.0"

define i1 @test1(float %x, float %y) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[CEIL:%.*]] = call float @llvm.ceil.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[CEIL]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %ceil = call double @ceil(double %x.ext) nounwind readnone
  %ext.y = fpext float %y to double
  %cmp = fcmp oeq double %ceil, %ext.y
  ret i1 %cmp
}

define i1 @test1_intrin(float %x, float %y) {
; CHECK-LABEL: @test1_intrin(
; CHECK-NEXT:    [[CEIL:%.*]] = call float @llvm.ceil.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[CEIL]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %ceil = call double @llvm.ceil.f64(double %x.ext) nounwind readnone
  %ext.y = fpext float %y to double
  %cmp = fcmp oeq double %ceil, %ext.y
  ret i1 %cmp
}

define i1 @test2(float %x, float %y) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[FABS:%.*]] = call float @llvm.fabs.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[FABS]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %fabs = call double @fabs(double %x.ext) nounwind readnone
  %y.ext = fpext float %y to double
  %cmp = fcmp oeq double %fabs, %y.ext
  ret i1 %cmp
}

define i1 @test2_intrin(float %x, float %y) {
; CHECK-LABEL: @test2_intrin(
; CHECK-NEXT:    [[FABS:%.*]] = call float @llvm.fabs.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[FABS]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %fabs = call double @llvm.fabs.f64(double %x.ext) nounwind readnone
  %y.ext = fpext float %y to double
  %cmp = fcmp oeq double %fabs, %y.ext
  ret i1 %cmp
}

define i1 @fmf_test2(float %x, float %y) {
; CHECK-LABEL: @fmf_test2(
; CHECK-NEXT:    [[TMP1:%.*]] = call nnan float @llvm.fabs.f32(float %x)
; CHECK-NEXT:    [[TMP2:%.*]] = fcmp oeq float [[TMP1]], %y
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = fpext float %x to double
  %2 = call nnan double @fabs(double %1) nounwind readnone
  %3 = fpext float %y to double
  %4 = fcmp oeq double %2, %3
  ret i1 %4
}

define i1 @test3(float %x, float %y) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[FLOOR:%.*]] = call float @llvm.floor.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[FLOOR]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %floor = call double @floor(double %x.ext) nounwind readnone
  %y.ext = fpext float %y to double
  %cmp = fcmp oeq double %floor, %y.ext
  ret i1 %cmp
}


define i1 @test3_intrin(float %x, float %y) {
; CHECK-LABEL: @test3_intrin(
; CHECK-NEXT:    [[FLOOR:%.*]] = call float @llvm.floor.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[FLOOR]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %floor = call double @llvm.floor.f64(double %x.ext) nounwind readnone
  %y.ext = fpext float %y to double
  %cmp = fcmp oeq double %floor, %y.ext
  ret i1 %cmp
}

define i1 @test4(float %x, float %y) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[NEARBYINT:%.*]] = call float @llvm.nearbyint.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[NEARBYINT]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %nearbyint = call double @nearbyint(double %x.ext) nounwind
  %y.ext = fpext float %y to double
  %cmp = fcmp oeq double %nearbyint, %y.ext
  ret i1 %cmp
}

define i1 @shrink_nearbyint_intrin(float %x, float %y) {
; CHECK-LABEL: @shrink_nearbyint_intrin(
; CHECK-NEXT:    [[NEARBYINT:%.*]] = call float @llvm.nearbyint.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[NEARBYINT]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %nearbyint = call double @llvm.nearbyint.f64(double %x.ext) nounwind
  %y.ext = fpext float %y to double
  %cmp = fcmp oeq double %nearbyint, %y.ext
  ret i1 %cmp
}

define i1 @test5(float %x, float %y) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[RINT:%.*]] = call float @llvm.rint.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[RINT]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %rint = call double @rint(double %x.ext) nounwind
  %y.ext = fpext float %y to double
  %cmp = fcmp oeq double %rint, %y.ext
  ret i1 %cmp
}

define i1 @test6(float %x, float %y) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    [[ROUND:%.*]] = call float @llvm.round.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[ROUND]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %round = call double @round(double %x.ext) nounwind readnone
  %y.ext = fpext float %y to double
  %cmp = fcmp oeq double %round, %y.ext
  ret i1 %cmp
}

define i1 @test6_intrin(float %x, float %y) {
; CHECK-LABEL: @test6_intrin(
; CHECK-NEXT:    [[ROUND:%.*]] = call float @llvm.round.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[ROUND]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %round = call double @llvm.round.f64(double %x.ext) nounwind readnone
  %y.ext = fpext float %y to double
  %cmp = fcmp oeq double %round, %y.ext
  ret i1 %cmp
}

define i1 @test7(float %x, float %y) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[TRUNC:%.*]] = call float @llvm.trunc.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[TRUNC]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %trunc = call double @trunc(double %x.ext) nounwind
  %y.ext = fpext float %y to double
  %cmp = fcmp oeq double %trunc, %y.ext
  ret i1 %cmp
}

define i1 @test7_intrin(float %x, float %y) {
; CHECK-LABEL: @test7_intrin(
; CHECK-NEXT:    [[TRUNC:%.*]] = call float @llvm.trunc.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[TRUNC]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %trunc = call double @llvm.trunc.f64(double %x.ext) nounwind
  %y.ext = fpext float %y to double
  %cmp = fcmp oeq double %trunc, %y.ext
  ret i1 %cmp
}

define i1 @test8(float %x, float %y) {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[CEIL:%.*]] = call float @llvm.ceil.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[CEIL]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %ceil = call double @ceil(double %x.ext) nounwind readnone
  %cmp = fcmp oeq double %y.ext, %ceil
  ret i1 %cmp
}

define i1 @test8_intrin(float %x, float %y) {
; CHECK-LABEL: @test8_intrin(
; CHECK-NEXT:    [[CEIL:%.*]] = call float @llvm.ceil.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[CEIL]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %ceil = call double @llvm.ceil.f64(double %x.ext) nounwind readnone
  %cmp = fcmp oeq double %y.ext, %ceil
  ret i1 %cmp
}

define i1 @test9(float %x, float %y) {
; CHECK-LABEL: @test9(
; CHECK-NEXT:    [[FABS:%.*]] = call float @llvm.fabs.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[FABS]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %fabs = call double @fabs(double %x.ext) nounwind readnone
  %cmp = fcmp oeq double %y.ext, %fabs
  ret i1 %cmp
}

define i1 @test9_intrin(float %x, float %y) {
; CHECK-LABEL: @test9_intrin(
; CHECK-NEXT:    [[FABS:%.*]] = call float @llvm.fabs.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[FABS]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %fabs = call double @llvm.fabs.f64(double %x.ext) nounwind readnone
  %cmp = fcmp oeq double %y.ext, %fabs
  ret i1 %cmp
}

define i1 @test10(float %x, float %y) {
; CHECK-LABEL: @test10(
; CHECK-NEXT:    [[FLOOR:%.*]] = call float @llvm.floor.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[FLOOR]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %floor = call double @floor(double %x.ext) nounwind readnone
  %cmp = fcmp oeq double %floor, %y.ext
  ret i1 %cmp
}

define i1 @test10_intrin(float %x, float %y) {
; CHECK-LABEL: @test10_intrin(
; CHECK-NEXT:    [[FLOOR:%.*]] = call float @llvm.floor.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[FLOOR]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %floor = call double @llvm.floor.f64(double %x.ext) nounwind readnone
  %cmp = fcmp oeq double %floor, %y.ext
  ret i1 %cmp
}

define i1 @test11(float %x, float %y) {
; CHECK-LABEL: @test11(
; CHECK-NEXT:    [[NEARBYINT:%.*]] = call float @llvm.nearbyint.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[NEARBYINT]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %nearbyint = call double @nearbyint(double %x.ext) nounwind
  %cmp = fcmp oeq double %nearbyint, %y.ext
  ret i1 %cmp
}

define i1 @test11_intrin(float %x, float %y) {
; CHECK-LABEL: @test11_intrin(
; CHECK-NEXT:    [[NEARBYINT:%.*]] = call float @llvm.nearbyint.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[NEARBYINT]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %nearbyint = call double @llvm.nearbyint.f64(double %x.ext) nounwind
  %cmp = fcmp oeq double %nearbyint, %y.ext
  ret i1 %cmp
}

define i1 @test12(float %x, float %y) {
; CHECK-LABEL: @test12(
; CHECK-NEXT:    [[RINT:%.*]] = call float @llvm.rint.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[RINT]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %rint = call double @rint(double %x.ext) nounwind
  %cmp = fcmp oeq double %y.ext, %rint
  ret i1 %cmp
}

define i1 @test13(float %x, float %y) {
; CHECK-LABEL: @test13(
; CHECK-NEXT:    [[ROUND:%.*]] = call float @llvm.round.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[ROUND]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %round = call double @round(double %x.ext) nounwind readnone
  %cmp = fcmp oeq double %y.ext, %round
  ret i1 %cmp
}

define i1 @test13_intrin(float %x, float %y) {
; CHECK-LABEL: @test13_intrin(
; CHECK-NEXT:    [[ROUND:%.*]] = call float @llvm.round.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[ROUND]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %round = call double @llvm.round.f64(double %x.ext) nounwind readnone
  %cmp = fcmp oeq double %y.ext, %round
  ret i1 %cmp
}

define i1 @test14(float %x, float %y) {
; CHECK-LABEL: @test14(
; CHECK-NEXT:    [[TRUNC:%.*]] = call float @llvm.trunc.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[TRUNC]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %trunc = call double @trunc(double %x.ext) nounwind
  %cmp = fcmp oeq double %y.ext, %trunc
  ret i1 %cmp
}

define i1 @test14_intrin(float %x, float %y) {
; CHECK-LABEL: @test14_intrin(
; CHECK-NEXT:    [[TRUNC:%.*]] = call float @llvm.trunc.f32(float %x)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[TRUNC]], %y
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %trunc = call double @llvm.trunc.f64(double %x.ext) nounwind
  %cmp = fcmp oeq double %y.ext, %trunc
  ret i1 %cmp
}

define i1 @test15(float %x, float %y, float %z) {
; CHECK-LABEL: @test15(
; CHECK-NEXT:    [[FMINF:%.*]] = call float @fminf(float %x, float %y) #0
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp oeq float [[FMINF]], %z
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = fpext float %x to double
  %2 = fpext float %y to double
  %3 = call double @fmin(double %1, double %2) nounwind
  %4 = fpext float %z to double
  %5 = fcmp oeq double %3, %4
  ret i1 %5
}

define i1 @test16(float %x, float %y, float %z) {
; CHECK-LABEL: @test16(
; CHECK-NEXT:    [[FMINF:%.*]] = call float @fminf(float %x, float %y) #0
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp oeq float [[FMINF]], %z
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = fpext float %z to double
  %2 = fpext float %x to double
  %3 = fpext float %y to double
  %4 = call double @fmin(double %2, double %3) nounwind
  %5 = fcmp oeq double %1, %4
  ret i1 %5
}

define i1 @test17(float %x, float %y, float %z) {
; CHECK-LABEL: @test17(
; CHECK-NEXT:    [[FMAXF:%.*]] = call float @fmaxf(float %x, float %y) #0
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp oeq float [[FMAXF]], %z
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = fpext float %x to double
  %2 = fpext float %y to double
  %3 = call double @fmax(double %1, double %2) nounwind
  %4 = fpext float %z to double
  %5 = fcmp oeq double %3, %4
  ret i1 %5
}

define i1 @test18(float %x, float %y, float %z) {
; CHECK-LABEL: @test18(
; CHECK-NEXT:    [[FMAXF:%.*]] = call float @fmaxf(float %x, float %y) #0
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp oeq float [[FMAXF]], %z
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = fpext float %z to double
  %2 = fpext float %x to double
  %3 = fpext float %y to double
  %4 = call double @fmax(double %2, double %3) nounwind
  %5 = fcmp oeq double %1, %4
  ret i1 %5
}

define i1 @test19(float %x, float %y, float %z) {
; CHECK-LABEL: @test19(
; CHECK-NEXT:    [[COPYSIGNF:%.*]] = call float @copysignf(float %x, float %y) #0
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp oeq float [[COPYSIGNF]], %z
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = fpext float %x to double
  %2 = fpext float %y to double
  %3 = call double @copysign(double %1, double %2) nounwind
  %4 = fpext float %z to double
  %5 = fcmp oeq double %3, %4
  ret i1 %5
}

define i1 @test20(float %x, float %y) {
; CHECK-LABEL: @test20(
; CHECK-NEXT:    [[FMINF:%.*]] = call float @fminf(float 1.000000e+00, float %x) #0
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp oeq float [[FMINF]], %y
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = fpext float %y to double
  %2 = fpext float %x to double
  %3 = call double @fmin(double 1.000000e+00, double %2) nounwind
  %4 = fcmp oeq double %1, %3
  ret i1 %4
}

; should not be changed to fminf as the constant would lose precision

define i1 @test21(float %x, float %y) {
; CHECK-LABEL: @test21(
; CHECK-NEXT:    [[TMP1:%.*]] = fpext float %y to double
; CHECK-NEXT:    [[TMP2:%.*]] = fpext float %x to double
; CHECK-NEXT:    [[TMP3:%.*]] = call double @fmin(double 1.300000e+00, double [[TMP2]]) #2
; CHECK-NEXT:    [[TMP4:%.*]] = fcmp oeq double [[TMP3]], [[TMP1]]
; CHECK-NEXT:    ret i1 [[TMP4]]
;
  %1 = fpext float %y to double
  %2 = fpext float %x to double
  %3 = call double @fmin(double 1.300000e+00, double %2) nounwind
  %4 = fcmp oeq double %1, %3
  ret i1 %4
}

declare double @fabs(double) nounwind readnone
declare double @ceil(double) nounwind readnone
declare double @copysign(double, double) nounwind readnone
declare double @floor(double) nounwind readnone
declare double @nearbyint(double) nounwind readnone
declare double @rint(double) nounwind readnone
declare double @round(double) nounwind readnone
declare double @trunc(double) nounwind readnone
declare double @fmin(double, double) nounwind readnone
declare double @fmax(double, double) nounwind readnone

declare double @llvm.fabs.f64(double) nounwind readnone
declare double @llvm.ceil.f64(double) nounwind readnone
declare double @llvm.floor.f64(double) nounwind readnone
declare double @llvm.nearbyint.f64(double) nounwind readnone
declare double @llvm.round.f64(double) nounwind readnone
declare double @llvm.trunc.f64(double) nounwind readnone
