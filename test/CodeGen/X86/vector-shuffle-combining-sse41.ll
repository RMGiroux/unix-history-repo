; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse4.1 | FileCheck %s --check-prefixes=CHECK,SSE,SSE41
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx | FileCheck %s --check-prefixes=CHECK,AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=CHECK,AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx512f | FileCheck %s --check-prefixes=CHECK,AVX,AVX512F

; Combine tests involving SSE41 target shuffles (BLEND,INSERTPS,MOVZX)

declare <16 x i8> @llvm.x86.ssse3.pshuf.b.128(<16 x i8>, <16 x i8>)

define <16 x i8> @combine_vpshufb_as_movzx(<16 x i8> %a0) {
; SSE-LABEL: combine_vpshufb_as_movzx:
; SSE:       # %bb.0:
; SSE-NEXT:    pmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vpshufb_as_movzx:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; AVX-NEXT:    retq
  %res0 = call <16 x i8> @llvm.x86.ssse3.pshuf.b.128(<16 x i8> %a0, <16 x i8> <i8 0, i8 1, i8 2, i8 3, i8 -1, i8 -1, i8 -1, i8 -1, i8 undef, i8 undef, i8 undef, i8 undef, i8 -1, i8 -1, i8 -1, i8 -1>)
  ret <16 x i8> %res0
}
