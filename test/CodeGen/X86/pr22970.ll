; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefix=X64

define i32 @PR22970_i32(i32* nocapture readonly, i32) {
; X86-LABEL: PR22970_i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl $4095, %ecx # imm = 0xFFF
; X86-NEXT:    andl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl 32(%eax,%ecx,4), %eax
; X86-NEXT:    retl
;
; X64-LABEL: PR22970_i32:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def %esi killed %esi def %rsi
; X64-NEXT:    andl $4095, %esi # imm = 0xFFF
; X64-NEXT:    movl 32(%rdi,%rsi,4), %eax
; X64-NEXT:    retq
  %3 = and i32 %1, 4095
  %4 = add nuw nsw i32 %3, 8
  %5 = zext i32 %4 to i64
  %6 = getelementptr inbounds i32, i32* %0, i64 %5
  %7 = load i32, i32* %6, align 4
  ret i32 %7
}

define i32 @PR22970_i64(i32* nocapture readonly, i64) {
; X86-LABEL: PR22970_i64:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl $4095, %ecx # imm = 0xFFF
; X86-NEXT:    andl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl 32(%eax,%ecx,4), %eax
; X86-NEXT:    retl
;
; X64-LABEL: PR22970_i64:
; X64:       # %bb.0:
; X64-NEXT:    andl $4095, %esi # imm = 0xFFF
; X64-NEXT:    movl 32(%rdi,%rsi,4), %eax
; X64-NEXT:    retq
  %3 = and i64 %1, 4095
  %4 = add nuw nsw i64 %3, 8
  %5 = getelementptr inbounds i32, i32* %0, i64 %4
  %6 = load i32, i32* %5, align 4
  ret i32 %6
}
