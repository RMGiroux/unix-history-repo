; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -fast-isel -mtriple=i386-unknown-unknown -mattr=+sse3 | FileCheck %s --check-prefix=ALL --check-prefix=X32
; RUN: llc < %s -fast-isel -mtriple=x86_64-unknown-unknown -mattr=+sse3 | FileCheck %s --check-prefix=ALL --check-prefix=X64

; NOTE: This should use IR equivalent to what is generated by clang/test/CodeGen/sse3-builtins.c

define <2 x double> @test_mm_addsub_pd(<2 x double> %a0, <2 x double> %a1) {
; X32-LABEL: test_mm_addsub_pd:
; X32:       # %bb.0:
; X32-NEXT:    addsubpd %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_addsub_pd:
; X64:       # %bb.0:
; X64-NEXT:    addsubpd %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <2 x double> @llvm.x86.sse3.addsub.pd(<2 x double> %a0, <2 x double> %a1)
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse3.addsub.pd(<2 x double>, <2 x double>) nounwind readnone

define <4 x float> @test_mm_addsub_ps(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: test_mm_addsub_ps:
; X32:       # %bb.0:
; X32-NEXT:    addsubps %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_addsub_ps:
; X64:       # %bb.0:
; X64-NEXT:    addsubps %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse3.addsub.ps(<4 x float> %a0, <4 x float> %a1)
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse3.addsub.ps(<4 x float>, <4 x float>) nounwind readnone

define <2 x double> @test_mm_hadd_pd(<2 x double> %a0, <2 x double> %a1) {
; X32-LABEL: test_mm_hadd_pd:
; X32:       # %bb.0:
; X32-NEXT:    haddpd %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_hadd_pd:
; X64:       # %bb.0:
; X64-NEXT:    haddpd %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <2 x double> @llvm.x86.sse3.hadd.pd(<2 x double> %a0, <2 x double> %a1)
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse3.hadd.pd(<2 x double>, <2 x double>) nounwind readnone

define <4 x float> @test_mm_hadd_ps(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: test_mm_hadd_ps:
; X32:       # %bb.0:
; X32-NEXT:    haddps %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_hadd_ps:
; X64:       # %bb.0:
; X64-NEXT:    haddps %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse3.hadd.ps(<4 x float> %a0, <4 x float> %a1)
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse3.hadd.ps(<4 x float>, <4 x float>) nounwind readnone

define <2 x double> @test_mm_hsub_pd(<2 x double> %a0, <2 x double> %a1) {
; X32-LABEL: test_mm_hsub_pd:
; X32:       # %bb.0:
; X32-NEXT:    hsubpd %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_hsub_pd:
; X64:       # %bb.0:
; X64-NEXT:    hsubpd %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <2 x double> @llvm.x86.sse3.hsub.pd(<2 x double> %a0, <2 x double> %a1)
  ret <2 x double> %res
}
declare <2 x double> @llvm.x86.sse3.hsub.pd(<2 x double>, <2 x double>) nounwind readnone

define <4 x float> @test_mm_hsub_ps(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: test_mm_hsub_ps:
; X32:       # %bb.0:
; X32-NEXT:    hsubps %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_hsub_ps:
; X64:       # %bb.0:
; X64-NEXT:    hsubps %xmm1, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.sse3.hsub.ps(<4 x float> %a0, <4 x float> %a1)
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse3.hsub.ps(<4 x float>, <4 x float>) nounwind readnone

define <2 x i64> @test_mm_lddqu_si128(<2 x i64>* %a0) {
; X32-LABEL: test_mm_lddqu_si128:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    lddqu (%eax), %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_lddqu_si128:
; X64:       # %bb.0:
; X64-NEXT:    lddqu (%rdi), %xmm0
; X64-NEXT:    retq
  %bc = bitcast <2 x i64>* %a0 to i8*
  %call = call <16 x i8> @llvm.x86.sse3.ldu.dq(i8* %bc)
  %res = bitcast <16 x i8> %call to <2 x i64>
  ret <2 x i64> %res
}
declare <16 x i8> @llvm.x86.sse3.ldu.dq(i8*) nounwind readonly

define <2 x double> @test_mm_loaddup_pd(double* %a0) {
; X32-LABEL: test_mm_loaddup_pd:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movddup {{.*#+}} xmm0 = mem[0,0]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_loaddup_pd:
; X64:       # %bb.0:
; X64-NEXT:    movddup {{.*#+}} xmm0 = mem[0,0]
; X64-NEXT:    retq
  %ld = load double, double* %a0
  %res0 = insertelement <2 x double> undef, double %ld, i32 0
  %res1 = insertelement <2 x double> %res0, double %ld, i32 1
  ret <2 x double> %res1
}

define <2 x double> @test_mm_movedup_pd(<2 x double> %a0) {
; X32-LABEL: test_mm_movedup_pd:
; X32:       # %bb.0:
; X32-NEXT:    movddup {{.*#+}} xmm0 = xmm0[0,0]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_movedup_pd:
; X64:       # %bb.0:
; X64-NEXT:    movddup {{.*#+}} xmm0 = xmm0[0,0]
; X64-NEXT:    retq
  %res = shufflevector <2 x double> %a0, <2 x double> %a0, <2 x i32> zeroinitializer
  ret <2 x double> %res
}

define <4 x float> @test_mm_movehdup_ps(<4 x float> %a0) {
; X32-LABEL: test_mm_movehdup_ps:
; X32:       # %bb.0:
; X32-NEXT:    movshdup {{.*#+}} xmm0 = xmm0[1,1,3,3]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_movehdup_ps:
; X64:       # %bb.0:
; X64-NEXT:    movshdup {{.*#+}} xmm0 = xmm0[1,1,3,3]
; X64-NEXT:    retq
  %res = shufflevector <4 x float> %a0, <4 x float> %a0, <4 x i32> <i32 1, i32 1, i32 3, i32 3>
  ret <4 x float> %res
}

define <4 x float> @test_mm_moveldup_ps(<4 x float> %a0) {
; X32-LABEL: test_mm_moveldup_ps:
; X32:       # %bb.0:
; X32-NEXT:    movsldup {{.*#+}} xmm0 = xmm0[0,0,2,2]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm_moveldup_ps:
; X64:       # %bb.0:
; X64-NEXT:    movsldup {{.*#+}} xmm0 = xmm0[0,0,2,2]
; X64-NEXT:    retq
  %res = shufflevector <4 x float> %a0, <4 x float> %a0, <4 x i32> <i32 0, i32 0, i32 2, i32 2>
  ret <4 x float> %res
}
