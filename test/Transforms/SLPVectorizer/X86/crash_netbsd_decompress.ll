; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -basicaa -slp-vectorizer -dce -S -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7 | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.8.0"

%struct.DState = type { i32, i32 }

@b = common global %struct.DState zeroinitializer, align 4
@d = common global i32 0, align 4
@c = common global i32 0, align 4
@a = common global i32 0, align 4
@e = common global i32 0, align 4

define i32 @fn1() {
; CHECK-LABEL: @fn1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* getelementptr inbounds (%struct.DState, %struct.DState* @b, i32 0, i32 0), align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* getelementptr inbounds (%struct.DState, %struct.DState* @b, i32 0, i32 1), align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* @d, align 4
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[SW_BB:%.*]], label [[SAVE_STATE_AND_RETURN:%.*]]
; CHECK:       sw.bb:
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, i32* @c, align 4
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[TMP3]], 7
; CHECK-NEXT:    store i32 [[AND]], i32* @a, align 4
; CHECK-NEXT:    switch i32 [[AND]], label [[IF_END:%.*]] [
; CHECK-NEXT:    i32 7, label [[SAVE_STATE_AND_RETURN]]
; CHECK-NEXT:    i32 0, label [[SAVE_STATE_AND_RETURN]]
; CHECK-NEXT:    ]
; CHECK:       if.end:
; CHECK-NEXT:    br label [[SAVE_STATE_AND_RETURN]]
; CHECK:       save_state_and_return:
; CHECK-NEXT:    [[T_0:%.*]] = phi i32 [ 0, [[IF_END]] ], [ [[TMP0]], [[ENTRY:%.*]] ], [ [[TMP0]], [[SW_BB]] ], [ [[TMP0]], [[SW_BB]] ]
; CHECK-NEXT:    [[F_0:%.*]] = phi i32 [ 0, [[IF_END]] ], [ [[TMP1]], [[ENTRY]] ], [ 0, [[SW_BB]] ], [ 0, [[SW_BB]] ]
; CHECK-NEXT:    store i32 [[T_0]], i32* getelementptr inbounds (%struct.DState, %struct.DState* @b, i32 0, i32 0), align 4
; CHECK-NEXT:    store i32 [[F_0]], i32* getelementptr inbounds (%struct.DState, %struct.DState* @b, i32 0, i32 1), align 4
; CHECK-NEXT:    ret i32 undef
;
entry:
  %0 = load i32, i32* getelementptr inbounds (%struct.DState, %struct.DState* @b, i32 0, i32 0), align 4
  %1 = load i32, i32* getelementptr inbounds (%struct.DState, %struct.DState* @b, i32 0, i32 1), align 4
  %2 = load i32, i32* @d, align 4
  %cond = icmp eq i32 %2, 0
  br i1 %cond, label %sw.bb, label %save_state_and_return

sw.bb:                                            ; preds = %entry
  %3 = load i32, i32* @c, align 4
  %and = and i32 %3, 7
  store i32 %and, i32* @a, align 4
  switch i32 %and, label %if.end [
  i32 7, label %save_state_and_return
  i32 0, label %save_state_and_return
  ]

if.end:                                           ; preds = %sw.bb
  br label %save_state_and_return

save_state_and_return:                            ; preds = %sw.bb, %sw.bb, %if.end, %entry
  %t.0 = phi i32 [ 0, %if.end ], [ %0, %entry ], [ %0, %sw.bb ], [ %0, %sw.bb ]
  %f.0 = phi i32 [ 0, %if.end ], [ %1, %entry ], [ 0, %sw.bb ], [ 0, %sw.bb ]
  store i32 %t.0, i32* getelementptr inbounds (%struct.DState, %struct.DState* @b, i32 0, i32 0), align 4
  store i32 %f.0, i32* getelementptr inbounds (%struct.DState, %struct.DState* @b, i32 0, i32 1), align 4
  ret i32 undef
}

