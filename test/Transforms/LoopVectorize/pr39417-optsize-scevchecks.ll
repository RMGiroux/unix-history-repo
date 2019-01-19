; RUN: opt -S -loop-vectorize -force-vector-width=4 -force-vector-interleave=1 < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; PR39417
; Check that the need for overflow check prevents vectorizing a loop with tiny
; trip count (which implies opt for size).
; CHECK-LABEL: @func_34
; CHECK-NOT: vector.scevcheck
; CHECK-NOT: vector.body:
; CHECK-LABEL: bb67:
define void @func_34() {
bb1:
  br label %bb67

bb67:
  %storemerge2 = phi i32 [ 0, %bb1 ], [ %_tmp2300, %bb67 ]
  %sext = shl i32 %storemerge2, 16
  %_tmp2299 = ashr exact i32 %sext, 16
  %_tmp2300 = add nsw i32 %_tmp2299, 1
  %_tmp2310 = trunc i32 %_tmp2300 to i16
  %_tmp2312 = icmp slt i16 %_tmp2310, 3
  br i1 %_tmp2312, label %bb67, label %bb68

bb68:
  ret void
}

; Check that the need for stride==1 check prevents vectorizing a loop under opt
; for size.
; CHECK-LABEL: @scev4stride1
; CHECK-NOT: vector.scevcheck
; CHECK-NOT: vector.body:
; CHECK-LABEL: for.body:
define void @scev4stride1(i32* noalias nocapture %a, i32* noalias nocapture readonly %b, i32 %k) #0 {
for.body.preheader:
  br label %for.body

for.body:
  %i.07 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %mul = mul nsw i32 %i.07, %k
  %arrayidx = getelementptr inbounds i32, i32* %b, i32 %mul
  %0 = load i32, i32* %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds i32, i32* %a, i32 %i.07
  store i32 %0, i32* %arrayidx1, align 4
  %inc = add nuw nsw i32 %i.07, 1
  %exitcond = icmp eq i32 %inc, 1024
  br i1 %exitcond, label %for.end.loopexit, label %for.body

for.end.loopexit:
  ret void
}

attributes #0 = { optsize }
