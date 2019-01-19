; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -basicaa -newgvn -S | FileCheck %s
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

%struct.foo = type { %struct.wombat.28*, %struct.zot, %struct.wombat.28* }
%struct.zot = type { i64 }
%struct.barney = type <{ %struct.wombat.28*, %struct.wibble, %struct.snork, %struct.quux.4, %struct.snork.10, %struct.ham.16*, %struct.wobble.23*, i32, i8, i8, [2 x i8] }>
%struct.wibble = type { %struct.pluto, %struct.bar }
%struct.pluto = type { %struct.quux }
%struct.quux = type { %struct.eggs }
%struct.eggs = type { %struct.zot.0, %struct.widget }
%struct.zot.0 = type { i8*, i8*, i8* }
%struct.widget = type { %struct.barney.1 }
%struct.barney.1 = type { [8 x i8] }
%struct.bar = type { [3 x %struct.widget] }
%struct.snork = type <{ %struct.wobble, %struct.bar.3, [7 x i8] }>
%struct.wobble = type { %struct.wombat }
%struct.wombat = type { %struct.zot.2 }
%struct.zot.2 = type { %struct.zot.0, %struct.ham }
%struct.ham = type { %struct.barney.1 }
%struct.bar.3 = type { i8 }
%struct.quux.4 = type <{ %struct.quux.5, %struct.snork.9, [7 x i8] }>
%struct.quux.5 = type { %struct.widget.6 }
%struct.widget.6 = type { %struct.spam }
%struct.spam = type { %struct.zot.0, %struct.ham.7 }
%struct.ham.7 = type { %struct.barney.8 }
%struct.barney.8 = type { [24 x i8] }
%struct.snork.9 = type { i8 }
%struct.snork.10 = type <{ %struct.foo.11, %struct.spam.15, [7 x i8] }>
%struct.foo.11 = type { %struct.snork.12 }
%struct.snork.12 = type { %struct.wombat.13 }
%struct.wombat.13 = type { %struct.zot.0, %struct.wibble.14 }
%struct.wibble.14 = type { %struct.barney.8 }
%struct.spam.15 = type { i8 }
%struct.ham.16 = type { %struct.pluto.17, %struct.pluto.17 }
%struct.pluto.17 = type { %struct.bar.18 }
%struct.bar.18 = type { %struct.baz*, %struct.zot.20, %struct.barney.22 }
%struct.baz = type { %struct.wibble.19* }
%struct.wibble.19 = type <{ %struct.baz, %struct.wibble.19*, %struct.baz*, i8, [7 x i8] }>
%struct.zot.20 = type { %struct.ham.21 }
%struct.ham.21 = type { %struct.baz }
%struct.barney.22 = type { %struct.blam }
%struct.blam = type { i64 }
%struct.wobble.23 = type { %struct.spam.24, %struct.barney* }
%struct.spam.24 = type { %struct.bar.25, %struct.zot.26* }
%struct.bar.25 = type <{ i32 (...)**, i8, i8 }>
%struct.zot.26 = type { i32 (...)**, i32, %struct.widget.27* }
%struct.widget.27 = type { %struct.zot.26, %struct.zot.26* }
%struct.wombat.28 = type <{ i32 (...)**, i8, i8, [6 x i8] }>

; Function Attrs: norecurse nounwind ssp uwtable
define weak_odr hidden %struct.foo* @quux(%struct.barney* %arg, %struct.wombat.28* %arg1) local_unnamed_addr #0 align 2 {
; CHECK-LABEL: @quux(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = getelementptr inbounds %struct.barney, %struct.barney* %arg, i64 0, i32 3, i32 0, i32 0, i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast %struct.spam* [[TMP]] to %struct.foo**
; CHECK-NEXT:    [[TMP3:%.*]] = load %struct.foo*, %struct.foo** [[TMP2]], align 8, !tbaa !2
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds %struct.barney, %struct.barney* %arg, i64 0, i32 3, i32 0, i32 0, i32 0, i32 0, i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast i8** [[TMP4]] to %struct.foo**
; CHECK-NEXT:    [[TMP6:%.*]] = load %struct.foo*, %struct.foo** [[TMP5]], align 8, !tbaa !7
; CHECK-NEXT:    [[TMP7:%.*]] = icmp eq %struct.foo* [[TMP3]], [[TMP6]]
; CHECK-NEXT:    br i1 [[TMP7]], label %bb21, label %bb8
; CHECK:       bb8:
; CHECK-NEXT:    br label %bb11
; CHECK:       bb9:
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq %struct.foo* [[TMP18:%.*]], [[TMP6]]
; CHECK-NEXT:    br i1 [[TMP10]], label %bb19, label %bb11
; CHECK:       bb11:
; CHECK-NEXT:    [[TMP12:%.*]] = phi %struct.foo* [ [[TMP17:%.*]], %bb9 ], [ undef, %bb8 ]
; CHECK-NEXT:    [[TMP13:%.*]] = phi %struct.foo* [ [[TMP18]], %bb9 ], [ [[TMP3]], %bb8 ]
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds %struct.foo, %struct.foo* [[TMP13]], i64 0, i32 0
; CHECK-NEXT:    [[TMP15:%.*]] = load %struct.wombat.28*, %struct.wombat.28** [[TMP14]], align 8, !tbaa !8
; CHECK-NEXT:    [[TMP16:%.*]] = icmp eq %struct.wombat.28* [[TMP15]], %arg1
; CHECK-NEXT:    [[TMP17]] = select i1 [[TMP16]], %struct.foo* [[TMP13]], %struct.foo* [[TMP12]]
; CHECK-NEXT:    [[TMP18]] = getelementptr inbounds %struct.foo, %struct.foo* [[TMP13]], i64 1
; CHECK-NEXT:    br i1 [[TMP16]], label %bb19, label %bb9
; CHECK:       bb19:
; CHECK-NEXT:    [[TMP20:%.*]] = phi %struct.foo* [ null, %bb9 ], [ [[TMP17]], %bb11 ]
; CHECK-NEXT:    br label %bb21
; CHECK:       bb21:
; CHECK-NEXT:    [[TMP22:%.*]] = phi %struct.foo* [ null, %bb ], [ [[TMP20]], %bb19 ]
; CHECK-NEXT:    ret %struct.foo* [[TMP22]]
;
bb:
  %tmp = getelementptr inbounds %struct.barney, %struct.barney* %arg, i64 0, i32 3, i32 0, i32 0, i32 0
  %tmp2 = bitcast %struct.spam* %tmp to %struct.foo**
  %tmp3 = load %struct.foo*, %struct.foo** %tmp2, align 8, !tbaa !2
  %tmp4 = getelementptr inbounds %struct.barney, %struct.barney* %arg, i64 0, i32 3, i32 0, i32 0, i32 0, i32 0, i32 1
  %tmp5 = bitcast i8** %tmp4 to %struct.foo**
  %tmp6 = load %struct.foo*, %struct.foo** %tmp5, align 8, !tbaa !7
  %tmp7 = icmp eq %struct.foo* %tmp3, %tmp6
  br i1 %tmp7, label %bb21, label %bb8

bb8:                                              ; preds = %bb
  br label %bb11

bb9:                                              ; preds = %bb11
  %tmp10 = icmp eq %struct.foo* %tmp18, %tmp6
  br i1 %tmp10, label %bb19, label %bb11

bb11:                                             ; preds = %bb9, %bb8
  %tmp12 = phi %struct.foo* [ %tmp17, %bb9 ], [ undef, %bb8 ]
  %tmp13 = phi %struct.foo* [ %tmp18, %bb9 ], [ %tmp3, %bb8 ]
  %tmp14 = getelementptr inbounds %struct.foo, %struct.foo* %tmp13, i64 0, i32 0
  %tmp15 = load %struct.wombat.28*, %struct.wombat.28** %tmp14, align 8, !tbaa !8
  %tmp16 = icmp eq %struct.wombat.28* %tmp15, %arg1
  %tmp17 = select i1 %tmp16, %struct.foo* %tmp13, %struct.foo* %tmp12
  %tmp18 = getelementptr inbounds %struct.foo, %struct.foo* %tmp13, i64 1
  br i1 %tmp16, label %bb19, label %bb9

bb19:                                             ; preds = %bb11, %bb9
  %tmp20 = phi %struct.foo* [ null, %bb9 ], [ %tmp17, %bb11 ]
  br label %bb21

bb21:                                             ; preds = %bb19, %bb
  %tmp22 = phi %struct.foo* [ null, %bb ], [ %tmp20, %bb19 ]
  ret %struct.foo* %tmp22
}

attributes #0 = { norecurse nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 4.0.0"}
!2 = !{!3, !4, i64 0}
!3 = !{!"_ZTSN4llvm15SmallVectorBaseE", !4, i64 0, !4, i64 8, !4, i64 16}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{!3, !4, i64 8}
!8 = !{!9, !4, i64 0}
!9 = !{!"_ZTSN4llvm9RecordValE", !4, i64 0, !10, i64 8, !4, i64 16}
!10 = !{!"_ZTSN4llvm14PointerIntPairIPNS_5RecTyELj1EbNS_21PointerLikeTypeTraitsIS2_EENS_18PointerIntPairInfoIS2_Lj1ES4_EEEE", !11, i64 0}
!11 = !{!"long", !5, i64 0}
