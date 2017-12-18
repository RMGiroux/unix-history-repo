; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -newgvn -S %s | FileCheck %s
; Ensure that loads that bypass memory def-use chains get added as users of the new
; MemoryDef.  Otherwise this test will not pass memory verification because the value
; of the load will not be reprocessed until verification.
; ModuleID = 'bugpoint-reduced-simplified.bc'
source_filename = "bugpoint-output-f242c4f.bc"
target triple = "x86_64-apple-darwin16.7.0"

@global = external global i32 #0
@global.1 = external global i32 #0

define void @hoge(i32 %arg) {
; CHECK-LABEL: @hoge(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[BB2]]
; CHECK:       bb2:
; CHECK-NEXT:    [[TMP:%.*]] = phi i32 [ 0, [[BB1:%.*]] ], [ [[ARG:%.*]], [[BB:%.*]] ]
; CHECK-NEXT:    br label [[BB6:%.*]]
; CHECK:       bb3:
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, i32* @global, !h !0
; CHECK-NEXT:    unreachable
; CHECK:       bb6:
; CHECK-NEXT:    store i32 [[TMP]], i32* @global.1, !h !0
; CHECK-NEXT:    br i1 undef, label [[BB7:%.*]], label [[BB1]]
; CHECK:       bb7:
; CHECK-NEXT:    br i1 undef, label [[BB10:%.*]], label [[BB8:%.*]]
; CHECK:       bb8:
; CHECK-NEXT:    br i1 false, label [[BB9:%.*]], label [[BB3:%.*]]
; CHECK:       bb9:
; CHECK-NEXT:    store i8 undef, i8* null
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb10:
; CHECK-NEXT:    store i32 0, i32* @global, !h !0
; CHECK-NEXT:    br label [[BB7]]
;
bb:
  br label %bb2

bb1:                                              ; preds = %bb6
  br label %bb2

bb2:                                              ; preds = %bb1, %bb
  %tmp = phi i32 [ 0, %bb1 ], [ %arg, %bb ]
  br label %bb6

bb3:                                              ; preds = %bb9, %bb8
  %tmp4 = load i32, i32* @global, !h !0
  %tmp5 = icmp eq i32 %tmp4, 0
  unreachable

bb6:                                              ; preds = %bb2
  store i32 %tmp, i32* @global.1, !h !0
  br i1 undef, label %bb7, label %bb1

bb7:                                              ; preds = %bb10, %bb6
  br i1 undef, label %bb10, label %bb8

bb8:                                              ; preds = %bb7
  br i1 false, label %bb9, label %bb3

bb9:                                              ; preds = %bb8
  call void @widget()
  br label %bb3

bb10:                                             ; preds = %bb7
  store i32 0, i32* @global, !h !0
  br label %bb7
}

declare void @widget()

attributes #0 = { align=4 }

!0 = !{}
