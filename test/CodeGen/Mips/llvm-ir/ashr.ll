; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips2 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS32
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r2 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r3 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r5 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r6 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=32R6
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips3 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS3
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips4 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r2 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r3 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r5 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r6 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R6
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r3 -mattr=+micromips -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MMR3
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r6 -mattr=+micromips -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MMR6

define signext i1 @ashr_i1(i1 signext %a, i1 signext %b) {
; MIPS-LABEL: ashr_i1:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    move $2, $4
;
; MIPS32-LABEL: ashr_i1:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    move $2, $4
;
; 32R2-LABEL: ashr_i1:
; 32R2:       # %bb.0: # %entry
; 32R2-NEXT:    jr $ra
; 32R2-NEXT:    move $2, $4
;
; 32R6-LABEL: ashr_i1:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    move $2, $4
;
; MIPS3-LABEL: ashr_i1:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    move $2, $4
;
; MIPS64-LABEL: ashr_i1:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    move $2, $4
;
; MIPS64R2-LABEL: ashr_i1:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    move $2, $4
;
; MIPS64R6-LABEL: ashr_i1:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    move $2, $4
;
; MMR3-LABEL: ashr_i1:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    move $2, $4
; MMR3-NEXT:    jrc $ra
;
; MMR6-LABEL: ashr_i1:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    move $2, $4
; MMR6-NEXT:    jrc $ra
entry:
  %r = ashr i1 %a, %b
  ret i1 %r
}

define signext i8 @ashr_i8(i8 signext %a, i8 signext %b) {
; MIPS-LABEL: ashr_i8:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    andi $1, $5, 255
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    srav $2, $4, $1
;
; MIPS32-LABEL: ashr_i8:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    andi $1, $5, 255
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    srav $2, $4, $1
;
; 32R2-LABEL: ashr_i8:
; 32R2:       # %bb.0: # %entry
; 32R2-NEXT:    andi $1, $5, 255
; 32R2-NEXT:    jr $ra
; 32R2-NEXT:    srav $2, $4, $1
;
; 32R6-LABEL: ashr_i8:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    andi $1, $5, 255
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    srav $2, $4, $1
;
; MIPS3-LABEL: ashr_i8:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    andi $1, $5, 255
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    srav $2, $4, $1
;
; MIPS64-LABEL: ashr_i8:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    andi $1, $5, 255
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    srav $2, $4, $1
;
; MIPS64R2-LABEL: ashr_i8:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    andi $1, $5, 255
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    srav $2, $4, $1
;
; MIPS64R6-LABEL: ashr_i8:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    andi $1, $5, 255
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    srav $2, $4, $1
;
; MMR3-LABEL: ashr_i8:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    andi16 $2, $5, 255
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    srav $2, $4, $2
;
; MMR6-LABEL: ashr_i8:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    andi16 $2, $5, 255
; MMR6-NEXT:    srav $2, $4, $2
; MMR6-NEXT:    jrc $ra
entry:
  ; FIXME: The andi instruction is redundant.
  %r = ashr i8 %a, %b
  ret i8 %r
}

define signext i16 @ashr_i16(i16 signext %a, i16 signext %b) {
; MIPS-LABEL: ashr_i16:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    andi $1, $5, 65535
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    srav $2, $4, $1
;
; MIPS32-LABEL: ashr_i16:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    andi $1, $5, 65535
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    srav $2, $4, $1
;
; 32R2-LABEL: ashr_i16:
; 32R2:       # %bb.0: # %entry
; 32R2-NEXT:    andi $1, $5, 65535
; 32R2-NEXT:    jr $ra
; 32R2-NEXT:    srav $2, $4, $1
;
; 32R6-LABEL: ashr_i16:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    andi $1, $5, 65535
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    srav $2, $4, $1
;
; MIPS3-LABEL: ashr_i16:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    andi $1, $5, 65535
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    srav $2, $4, $1
;
; MIPS64-LABEL: ashr_i16:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    andi $1, $5, 65535
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    srav $2, $4, $1
;
; MIPS64R2-LABEL: ashr_i16:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    andi $1, $5, 65535
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    srav $2, $4, $1
;
; MIPS64R6-LABEL: ashr_i16:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    andi $1, $5, 65535
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    srav $2, $4, $1
;
; MMR3-LABEL: ashr_i16:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    andi16 $2, $5, 65535
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    srav $2, $4, $2
;
; MMR6-LABEL: ashr_i16:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    andi16 $2, $5, 65535
; MMR6-NEXT:    srav $2, $4, $2
; MMR6-NEXT:    jrc $ra
entry:
  ; FIXME: The andi instruction is redundant.
  %r = ashr i16 %a, %b
  ret i16 %r
}

define signext i32 @ashr_i32(i32 signext %a, i32 signext %b) {
; MIPS-LABEL: ashr_i32:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    srav $2, $4, $5
;
; MIPS32-LABEL: ashr_i32:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    srav $2, $4, $5
;
; 32R2-LABEL: ashr_i32:
; 32R2:       # %bb.0: # %entry
; 32R2-NEXT:    jr $ra
; 32R2-NEXT:    srav $2, $4, $5
;
; 32R6-LABEL: ashr_i32:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    srav $2, $4, $5
;
; MIPS3-LABEL: ashr_i32:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    srav $2, $4, $5
;
; MIPS64-LABEL: ashr_i32:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    srav $2, $4, $5
;
; MIPS64R2-LABEL: ashr_i32:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    srav $2, $4, $5
;
; MIPS64R6-LABEL: ashr_i32:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    srav $2, $4, $5
;
; MMR3-LABEL: ashr_i32:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    srav $2, $4, $5
;
; MMR6-LABEL: ashr_i32:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    srav $2, $4, $5
; MMR6-NEXT:    jrc $ra
entry:
  %r = ashr i32 %a, %b
  ret i32 %r
}

define signext i64 @ashr_i64(i64 signext %a, i64 signext %b) {
; MIPS-LABEL: ashr_i64:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    srav $2, $4, $7
; MIPS-NEXT:    andi $6, $7, 32
; MIPS-NEXT:    beqz $6, $BB4_3
; MIPS-NEXT:    move $3, $2
; MIPS-NEXT:  # %bb.1: # %entry
; MIPS-NEXT:    bnez $6, $BB4_4
; MIPS-NEXT:    nop
; MIPS-NEXT:  $BB4_2: # %entry
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    nop
; MIPS-NEXT:  $BB4_3: # %entry
; MIPS-NEXT:    srlv $1, $5, $7
; MIPS-NEXT:    not $3, $7
; MIPS-NEXT:    sll $5, $4, 1
; MIPS-NEXT:    sllv $3, $5, $3
; MIPS-NEXT:    beqz $6, $BB4_2
; MIPS-NEXT:    or $3, $3, $1
; MIPS-NEXT:  $BB4_4:
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    sra $2, $4, 31
;
; MIPS32-LABEL: ashr_i64:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    srlv $1, $5, $7
; MIPS32-NEXT:    not $2, $7
; MIPS32-NEXT:    sll $3, $4, 1
; MIPS32-NEXT:    sllv $2, $3, $2
; MIPS32-NEXT:    or $3, $2, $1
; MIPS32-NEXT:    srav $2, $4, $7
; MIPS32-NEXT:    andi $1, $7, 32
; MIPS32-NEXT:    movn $3, $2, $1
; MIPS32-NEXT:    sra $4, $4, 31
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    movn $2, $4, $1
;
; 32R2-LABEL: ashr_i64:
; 32R2:       # %bb.0: # %entry
; 32R2-NEXT:    srlv $1, $5, $7
; 32R2-NEXT:    not $2, $7
; 32R2-NEXT:    sll $3, $4, 1
; 32R2-NEXT:    sllv $2, $3, $2
; 32R2-NEXT:    or $3, $2, $1
; 32R2-NEXT:    srav $2, $4, $7
; 32R2-NEXT:    andi $1, $7, 32
; 32R2-NEXT:    movn $3, $2, $1
; 32R2-NEXT:    sra $4, $4, 31
; 32R2-NEXT:    jr $ra
; 32R2-NEXT:    movn $2, $4, $1
;
; 32R6-LABEL: ashr_i64:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    srav $1, $4, $7
; 32R6-NEXT:    andi $3, $7, 32
; 32R6-NEXT:    seleqz $2, $1, $3
; 32R6-NEXT:    sra $6, $4, 31
; 32R6-NEXT:    selnez $6, $6, $3
; 32R6-NEXT:    or $2, $6, $2
; 32R6-NEXT:    srlv $5, $5, $7
; 32R6-NEXT:    not $6, $7
; 32R6-NEXT:    sll $4, $4, 1
; 32R6-NEXT:    sllv $4, $4, $6
; 32R6-NEXT:    or $4, $4, $5
; 32R6-NEXT:    seleqz $4, $4, $3
; 32R6-NEXT:    selnez $1, $1, $3
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    or $3, $1, $4
;
; MIPS3-LABEL: ashr_i64:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    dsrav $2, $4, $5
;
; MIPS64-LABEL: ashr_i64:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    dsrav $2, $4, $5
;
; MIPS64R2-LABEL: ashr_i64:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    dsrav $2, $4, $5
;
; MIPS64R6-LABEL: ashr_i64:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    dsrav $2, $4, $5
;
; MMR3-LABEL: ashr_i64:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    srlv $2, $5, $7
; MMR3-NEXT:    not16 $3, $7
; MMR3-NEXT:    sll16 $5, $4, 1
; MMR3-NEXT:    sllv $3, $5, $3
; MMR3-NEXT:    or16 $3, $2
; MMR3-NEXT:    srav $2, $4, $7
; MMR3-NEXT:    andi16 $5, $7, 32
; MMR3-NEXT:    movn $3, $2, $5
; MMR3-NEXT:    sra $1, $4, 31
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    movn $2, $1, $5
;
; MMR6-LABEL: ashr_i64:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    srav $1, $4, $7
; MMR6-NEXT:    andi16 $3, $7, 32
; MMR6-NEXT:    seleqz $2, $1, $3
; MMR6-NEXT:    sra $6, $4, 31
; MMR6-NEXT:    selnez $6, $6, $3
; MMR6-NEXT:    or $2, $6, $2
; MMR6-NEXT:    srlv $5, $5, $7
; MMR6-NEXT:    not16 $6, $7
; MMR6-NEXT:    sll16 $4, $4, 1
; MMR6-NEXT:    sllv $4, $4, $6
; MMR6-NEXT:    or16 $4, $5
; MMR6-NEXT:    seleqz $4, $4, $3
; MMR6-NEXT:    selnez $1, $1, $3
; MMR6-NEXT:    or $3, $1, $4
; MMR6-NEXT:    jrc $ra
entry:
  %r = ashr i64 %a, %b
  ret i64 %r
}

define signext i128 @ashr_i128(i128 signext %a, i128 signext %b) {
; MIPS-LABEL: ashr_i128:
; MIPS:       # %bb.0: # %entry
; MIPS-NEXT:    addiu $sp, $sp, -8
; MIPS-NEXT:    .cfi_def_cfa_offset 8
; MIPS-NEXT:    sw $17, 4($sp) # 4-byte Folded Spill
; MIPS-NEXT:    sw $16, 0($sp) # 4-byte Folded Spill
; MIPS-NEXT:    .cfi_offset 17, -4
; MIPS-NEXT:    .cfi_offset 16, -8
; MIPS-NEXT:    lw $25, 36($sp)
; MIPS-NEXT:    addiu $1, $zero, 64
; MIPS-NEXT:    subu $11, $1, $25
; MIPS-NEXT:    sllv $9, $5, $11
; MIPS-NEXT:    andi $13, $11, 32
; MIPS-NEXT:    addiu $2, $zero, 0
; MIPS-NEXT:    bnez $13, $BB5_2
; MIPS-NEXT:    addiu $3, $zero, 0
; MIPS-NEXT:  # %bb.1: # %entry
; MIPS-NEXT:    move $3, $9
; MIPS-NEXT:  $BB5_2: # %entry
; MIPS-NEXT:    not $gp, $25
; MIPS-NEXT:    srlv $12, $6, $25
; MIPS-NEXT:    andi $8, $25, 32
; MIPS-NEXT:    bnez $8, $BB5_4
; MIPS-NEXT:    move $15, $12
; MIPS-NEXT:  # %bb.3: # %entry
; MIPS-NEXT:    srlv $1, $7, $25
; MIPS-NEXT:    sll $10, $6, 1
; MIPS-NEXT:    sllv $10, $10, $gp
; MIPS-NEXT:    or $15, $10, $1
; MIPS-NEXT:  $BB5_4: # %entry
; MIPS-NEXT:    addiu $10, $25, -64
; MIPS-NEXT:    sll $17, $4, 1
; MIPS-NEXT:    srav $14, $4, $10
; MIPS-NEXT:    andi $24, $10, 32
; MIPS-NEXT:    bnez $24, $BB5_6
; MIPS-NEXT:    move $16, $14
; MIPS-NEXT:  # %bb.5: # %entry
; MIPS-NEXT:    srlv $1, $5, $10
; MIPS-NEXT:    not $10, $10
; MIPS-NEXT:    sllv $10, $17, $10
; MIPS-NEXT:    or $16, $10, $1
; MIPS-NEXT:  $BB5_6: # %entry
; MIPS-NEXT:    sltiu $10, $25, 64
; MIPS-NEXT:    beqz $10, $BB5_8
; MIPS-NEXT:    nop
; MIPS-NEXT:  # %bb.7:
; MIPS-NEXT:    or $16, $15, $3
; MIPS-NEXT:  $BB5_8: # %entry
; MIPS-NEXT:    srav $15, $4, $25
; MIPS-NEXT:    beqz $8, $BB5_20
; MIPS-NEXT:    move $3, $15
; MIPS-NEXT:  # %bb.9: # %entry
; MIPS-NEXT:    sltiu $gp, $25, 1
; MIPS-NEXT:    beqz $gp, $BB5_21
; MIPS-NEXT:    nop
; MIPS-NEXT:  $BB5_10: # %entry
; MIPS-NEXT:    beqz $10, $BB5_22
; MIPS-NEXT:    sra $25, $4, 31
; MIPS-NEXT:  $BB5_11: # %entry
; MIPS-NEXT:    beqz $13, $BB5_23
; MIPS-NEXT:    nop
; MIPS-NEXT:  $BB5_12: # %entry
; MIPS-NEXT:    beqz $8, $BB5_24
; MIPS-NEXT:    nop
; MIPS-NEXT:  $BB5_13: # %entry
; MIPS-NEXT:    beqz $24, $BB5_25
; MIPS-NEXT:    move $4, $25
; MIPS-NEXT:  $BB5_14: # %entry
; MIPS-NEXT:    bnez $10, $BB5_26
; MIPS-NEXT:    nop
; MIPS-NEXT:  $BB5_15: # %entry
; MIPS-NEXT:    beqz $gp, $BB5_27
; MIPS-NEXT:    nop
; MIPS-NEXT:  $BB5_16: # %entry
; MIPS-NEXT:    beqz $8, $BB5_28
; MIPS-NEXT:    move $2, $25
; MIPS-NEXT:  $BB5_17: # %entry
; MIPS-NEXT:    bnez $10, $BB5_19
; MIPS-NEXT:    nop
; MIPS-NEXT:  $BB5_18: # %entry
; MIPS-NEXT:    move $2, $25
; MIPS-NEXT:  $BB5_19: # %entry
; MIPS-NEXT:    move $4, $6
; MIPS-NEXT:    move $5, $7
; MIPS-NEXT:    lw $16, 0($sp) # 4-byte Folded Reload
; MIPS-NEXT:    lw $17, 4($sp) # 4-byte Folded Reload
; MIPS-NEXT:    jr $ra
; MIPS-NEXT:    addiu $sp, $sp, 8
; MIPS-NEXT:  $BB5_20: # %entry
; MIPS-NEXT:    srlv $1, $5, $25
; MIPS-NEXT:    sllv $3, $17, $gp
; MIPS-NEXT:    sltiu $gp, $25, 1
; MIPS-NEXT:    bnez $gp, $BB5_10
; MIPS-NEXT:    or $3, $3, $1
; MIPS-NEXT:  $BB5_21: # %entry
; MIPS-NEXT:    move $7, $16
; MIPS-NEXT:    bnez $10, $BB5_11
; MIPS-NEXT:    sra $25, $4, 31
; MIPS-NEXT:  $BB5_22: # %entry
; MIPS-NEXT:    bnez $13, $BB5_12
; MIPS-NEXT:    move $3, $25
; MIPS-NEXT:  $BB5_23: # %entry
; MIPS-NEXT:    not $1, $11
; MIPS-NEXT:    srl $5, $5, 1
; MIPS-NEXT:    sllv $4, $4, $11
; MIPS-NEXT:    srlv $1, $5, $1
; MIPS-NEXT:    bnez $8, $BB5_13
; MIPS-NEXT:    or $9, $4, $1
; MIPS-NEXT:  $BB5_24: # %entry
; MIPS-NEXT:    move $2, $12
; MIPS-NEXT:    bnez $24, $BB5_14
; MIPS-NEXT:    move $4, $25
; MIPS-NEXT:  $BB5_25: # %entry
; MIPS-NEXT:    beqz $10, $BB5_15
; MIPS-NEXT:    move $4, $14
; MIPS-NEXT:  $BB5_26:
; MIPS-NEXT:    bnez $gp, $BB5_16
; MIPS-NEXT:    or $4, $2, $9
; MIPS-NEXT:  $BB5_27: # %entry
; MIPS-NEXT:    move $6, $4
; MIPS-NEXT:    bnez $8, $BB5_17
; MIPS-NEXT:    move $2, $25
; MIPS-NEXT:  $BB5_28: # %entry
; MIPS-NEXT:    bnez $10, $BB5_19
; MIPS-NEXT:    move $2, $15
; MIPS-NEXT:  # %bb.29: # %entry
; MIPS-NEXT:    b $BB5_18
; MIPS-NEXT:    nop
;
; MIPS32-LABEL: ashr_i128:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    lw $9, 28($sp)
; MIPS32-NEXT:    srlv $1, $7, $9
; MIPS32-NEXT:    not $2, $9
; MIPS32-NEXT:    sll $3, $6, 1
; MIPS32-NEXT:    sllv $3, $3, $2
; MIPS32-NEXT:    addiu $8, $zero, 64
; MIPS32-NEXT:    or $1, $3, $1
; MIPS32-NEXT:    srlv $10, $6, $9
; MIPS32-NEXT:    subu $3, $8, $9
; MIPS32-NEXT:    sllv $11, $5, $3
; MIPS32-NEXT:    andi $12, $3, 32
; MIPS32-NEXT:    andi $13, $9, 32
; MIPS32-NEXT:    move $8, $11
; MIPS32-NEXT:    movn $8, $zero, $12
; MIPS32-NEXT:    movn $1, $10, $13
; MIPS32-NEXT:    addiu $14, $9, -64
; MIPS32-NEXT:    srlv $15, $5, $14
; MIPS32-NEXT:    sll $24, $4, 1
; MIPS32-NEXT:    not $25, $14
; MIPS32-NEXT:    sllv $25, $24, $25
; MIPS32-NEXT:    or $gp, $1, $8
; MIPS32-NEXT:    or $1, $25, $15
; MIPS32-NEXT:    srav $8, $4, $14
; MIPS32-NEXT:    andi $14, $14, 32
; MIPS32-NEXT:    movn $1, $8, $14
; MIPS32-NEXT:    sllv $15, $4, $3
; MIPS32-NEXT:    not $3, $3
; MIPS32-NEXT:    srl $25, $5, 1
; MIPS32-NEXT:    srlv $3, $25, $3
; MIPS32-NEXT:    sltiu $25, $9, 64
; MIPS32-NEXT:    movn $1, $gp, $25
; MIPS32-NEXT:    or $15, $15, $3
; MIPS32-NEXT:    srlv $3, $5, $9
; MIPS32-NEXT:    sllv $2, $24, $2
; MIPS32-NEXT:    or $5, $2, $3
; MIPS32-NEXT:    srav $24, $4, $9
; MIPS32-NEXT:    movn $5, $24, $13
; MIPS32-NEXT:    sra $2, $4, 31
; MIPS32-NEXT:    movz $1, $7, $9
; MIPS32-NEXT:    move $3, $2
; MIPS32-NEXT:    movn $3, $5, $25
; MIPS32-NEXT:    movn $15, $11, $12
; MIPS32-NEXT:    movn $10, $zero, $13
; MIPS32-NEXT:    or $4, $10, $15
; MIPS32-NEXT:    movn $8, $2, $14
; MIPS32-NEXT:    movn $8, $4, $25
; MIPS32-NEXT:    movz $8, $6, $9
; MIPS32-NEXT:    movn $24, $2, $13
; MIPS32-NEXT:    movn $2, $24, $25
; MIPS32-NEXT:    move $4, $8
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    move $5, $1
;
; 32R2-LABEL: ashr_i128:
; 32R2:       # %bb.0: # %entry
; 32R2-NEXT:    lw $9, 28($sp)
; 32R2-NEXT:    srlv $1, $7, $9
; 32R2-NEXT:    not $2, $9
; 32R2-NEXT:    sll $3, $6, 1
; 32R2-NEXT:    sllv $3, $3, $2
; 32R2-NEXT:    addiu $8, $zero, 64
; 32R2-NEXT:    or $1, $3, $1
; 32R2-NEXT:    srlv $10, $6, $9
; 32R2-NEXT:    subu $3, $8, $9
; 32R2-NEXT:    sllv $11, $5, $3
; 32R2-NEXT:    andi $12, $3, 32
; 32R2-NEXT:    andi $13, $9, 32
; 32R2-NEXT:    move $8, $11
; 32R2-NEXT:    movn $8, $zero, $12
; 32R2-NEXT:    movn $1, $10, $13
; 32R2-NEXT:    addiu $14, $9, -64
; 32R2-NEXT:    srlv $15, $5, $14
; 32R2-NEXT:    sll $24, $4, 1
; 32R2-NEXT:    not $25, $14
; 32R2-NEXT:    sllv $25, $24, $25
; 32R2-NEXT:    or $gp, $1, $8
; 32R2-NEXT:    or $1, $25, $15
; 32R2-NEXT:    srav $8, $4, $14
; 32R2-NEXT:    andi $14, $14, 32
; 32R2-NEXT:    movn $1, $8, $14
; 32R2-NEXT:    sllv $15, $4, $3
; 32R2-NEXT:    not $3, $3
; 32R2-NEXT:    srl $25, $5, 1
; 32R2-NEXT:    srlv $3, $25, $3
; 32R2-NEXT:    sltiu $25, $9, 64
; 32R2-NEXT:    movn $1, $gp, $25
; 32R2-NEXT:    or $15, $15, $3
; 32R2-NEXT:    srlv $3, $5, $9
; 32R2-NEXT:    sllv $2, $24, $2
; 32R2-NEXT:    or $5, $2, $3
; 32R2-NEXT:    srav $24, $4, $9
; 32R2-NEXT:    movn $5, $24, $13
; 32R2-NEXT:    sra $2, $4, 31
; 32R2-NEXT:    movz $1, $7, $9
; 32R2-NEXT:    move $3, $2
; 32R2-NEXT:    movn $3, $5, $25
; 32R2-NEXT:    movn $15, $11, $12
; 32R2-NEXT:    movn $10, $zero, $13
; 32R2-NEXT:    or $4, $10, $15
; 32R2-NEXT:    movn $8, $2, $14
; 32R2-NEXT:    movn $8, $4, $25
; 32R2-NEXT:    movz $8, $6, $9
; 32R2-NEXT:    movn $24, $2, $13
; 32R2-NEXT:    movn $2, $24, $25
; 32R2-NEXT:    move $4, $8
; 32R2-NEXT:    jr $ra
; 32R2-NEXT:    move $5, $1
;
; 32R6-LABEL: ashr_i128:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    lw $3, 28($sp)
; 32R6-NEXT:    addiu $1, $zero, 64
; 32R6-NEXT:    subu $1, $1, $3
; 32R6-NEXT:    sllv $2, $5, $1
; 32R6-NEXT:    andi $8, $1, 32
; 32R6-NEXT:    selnez $9, $2, $8
; 32R6-NEXT:    sllv $10, $4, $1
; 32R6-NEXT:    not $1, $1
; 32R6-NEXT:    srl $11, $5, 1
; 32R6-NEXT:    srlv $1, $11, $1
; 32R6-NEXT:    or $1, $10, $1
; 32R6-NEXT:    seleqz $1, $1, $8
; 32R6-NEXT:    or $1, $9, $1
; 32R6-NEXT:    srlv $9, $7, $3
; 32R6-NEXT:    not $10, $3
; 32R6-NEXT:    sll $11, $6, 1
; 32R6-NEXT:    sllv $11, $11, $10
; 32R6-NEXT:    or $9, $11, $9
; 32R6-NEXT:    andi $11, $3, 32
; 32R6-NEXT:    seleqz $9, $9, $11
; 32R6-NEXT:    srlv $12, $6, $3
; 32R6-NEXT:    selnez $13, $12, $11
; 32R6-NEXT:    seleqz $12, $12, $11
; 32R6-NEXT:    or $1, $12, $1
; 32R6-NEXT:    seleqz $2, $2, $8
; 32R6-NEXT:    or $8, $13, $9
; 32R6-NEXT:    addiu $9, $3, -64
; 32R6-NEXT:    srlv $12, $5, $9
; 32R6-NEXT:    sll $13, $4, 1
; 32R6-NEXT:    not $14, $9
; 32R6-NEXT:    sllv $14, $13, $14
; 32R6-NEXT:    sltiu $15, $3, 64
; 32R6-NEXT:    or $2, $8, $2
; 32R6-NEXT:    selnez $1, $1, $15
; 32R6-NEXT:    or $8, $14, $12
; 32R6-NEXT:    srav $12, $4, $9
; 32R6-NEXT:    andi $9, $9, 32
; 32R6-NEXT:    seleqz $14, $12, $9
; 32R6-NEXT:    sra $24, $4, 31
; 32R6-NEXT:    selnez $25, $24, $9
; 32R6-NEXT:    seleqz $8, $8, $9
; 32R6-NEXT:    or $14, $25, $14
; 32R6-NEXT:    seleqz $14, $14, $15
; 32R6-NEXT:    selnez $9, $12, $9
; 32R6-NEXT:    seleqz $12, $24, $15
; 32R6-NEXT:    or $1, $1, $14
; 32R6-NEXT:    selnez $14, $1, $3
; 32R6-NEXT:    selnez $1, $2, $15
; 32R6-NEXT:    or $2, $9, $8
; 32R6-NEXT:    srav $8, $4, $3
; 32R6-NEXT:    seleqz $4, $8, $11
; 32R6-NEXT:    selnez $9, $24, $11
; 32R6-NEXT:    or $4, $9, $4
; 32R6-NEXT:    selnez $9, $4, $15
; 32R6-NEXT:    seleqz $2, $2, $15
; 32R6-NEXT:    seleqz $4, $6, $3
; 32R6-NEXT:    seleqz $6, $7, $3
; 32R6-NEXT:    or $1, $1, $2
; 32R6-NEXT:    selnez $1, $1, $3
; 32R6-NEXT:    or $1, $6, $1
; 32R6-NEXT:    or $4, $4, $14
; 32R6-NEXT:    or $2, $9, $12
; 32R6-NEXT:    srlv $3, $5, $3
; 32R6-NEXT:    sllv $5, $13, $10
; 32R6-NEXT:    or $3, $5, $3
; 32R6-NEXT:    seleqz $3, $3, $11
; 32R6-NEXT:    selnez $5, $8, $11
; 32R6-NEXT:    or $3, $5, $3
; 32R6-NEXT:    selnez $3, $3, $15
; 32R6-NEXT:    or $3, $3, $12
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    move $5, $1
;
; MIPS3-LABEL: ashr_i128:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    sll $8, $7, 0
; MIPS3-NEXT:    dsrav $2, $4, $7
; MIPS3-NEXT:    andi $6, $8, 64
; MIPS3-NEXT:    beqz $6, .LBB5_3
; MIPS3-NEXT:    move $3, $2
; MIPS3-NEXT:  # %bb.1: # %entry
; MIPS3-NEXT:    bnez $6, .LBB5_4
; MIPS3-NEXT:    nop
; MIPS3-NEXT:  .LBB5_2: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    nop
; MIPS3-NEXT:  .LBB5_3: # %entry
; MIPS3-NEXT:    dsrlv $1, $5, $7
; MIPS3-NEXT:    dsll $3, $4, 1
; MIPS3-NEXT:    not $5, $8
; MIPS3-NEXT:    dsllv $3, $3, $5
; MIPS3-NEXT:    beqz $6, .LBB5_2
; MIPS3-NEXT:    or $3, $3, $1
; MIPS3-NEXT:  .LBB5_4:
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    dsra $2, $4, 63
;
; MIPS64-LABEL: ashr_i128:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    dsrlv $1, $5, $7
; MIPS64-NEXT:    dsll $2, $4, 1
; MIPS64-NEXT:    sll $5, $7, 0
; MIPS64-NEXT:    not $3, $5
; MIPS64-NEXT:    dsllv $2, $2, $3
; MIPS64-NEXT:    or $3, $2, $1
; MIPS64-NEXT:    dsrav $2, $4, $7
; MIPS64-NEXT:    andi $1, $5, 64
; MIPS64-NEXT:    movn $3, $2, $1
; MIPS64-NEXT:    dsra $4, $4, 63
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    movn $2, $4, $1
;
; MIPS64R2-LABEL: ashr_i128:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    dsrlv $1, $5, $7
; MIPS64R2-NEXT:    dsll $2, $4, 1
; MIPS64R2-NEXT:    sll $5, $7, 0
; MIPS64R2-NEXT:    not $3, $5
; MIPS64R2-NEXT:    dsllv $2, $2, $3
; MIPS64R2-NEXT:    or $3, $2, $1
; MIPS64R2-NEXT:    dsrav $2, $4, $7
; MIPS64R2-NEXT:    andi $1, $5, 64
; MIPS64R2-NEXT:    movn $3, $2, $1
; MIPS64R2-NEXT:    dsra $4, $4, 63
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    movn $2, $4, $1
;
; MIPS64R6-LABEL: ashr_i128:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    dsrav $1, $4, $7
; MIPS64R6-NEXT:    sll $3, $7, 0
; MIPS64R6-NEXT:    andi $2, $3, 64
; MIPS64R6-NEXT:    sll $6, $2, 0
; MIPS64R6-NEXT:    seleqz $2, $1, $6
; MIPS64R6-NEXT:    dsra $8, $4, 63
; MIPS64R6-NEXT:    selnez $8, $8, $6
; MIPS64R6-NEXT:    or $2, $8, $2
; MIPS64R6-NEXT:    dsrlv $5, $5, $7
; MIPS64R6-NEXT:    dsll $4, $4, 1
; MIPS64R6-NEXT:    not $3, $3
; MIPS64R6-NEXT:    dsllv $3, $4, $3
; MIPS64R6-NEXT:    or $3, $3, $5
; MIPS64R6-NEXT:    seleqz $3, $3, $6
; MIPS64R6-NEXT:    selnez $1, $1, $6
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    or $3, $1, $3
;
; MMR3-LABEL: ashr_i128:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    addiusp -48
; MMR3-NEXT:    .cfi_def_cfa_offset 48
; MMR3-NEXT:    sw $17, 44($sp) # 4-byte Folded Spill
; MMR3-NEXT:    sw $16, 40($sp) # 4-byte Folded Spill
; MMR3-NEXT:    .cfi_offset 17, -4
; MMR3-NEXT:    .cfi_offset 16, -8
; MMR3-NEXT:    move $8, $7
; MMR3-NEXT:    sw $6, 32($sp) # 4-byte Folded Spill
; MMR3-NEXT:    sw $5, 36($sp) # 4-byte Folded Spill
; MMR3-NEXT:    sw $4, 8($sp) # 4-byte Folded Spill
; MMR3-NEXT:    lw $16, 76($sp)
; MMR3-NEXT:    srlv $4, $8, $16
; MMR3-NEXT:    not16 $3, $16
; MMR3-NEXT:    sw $3, 24($sp) # 4-byte Folded Spill
; MMR3-NEXT:    sll16 $2, $6, 1
; MMR3-NEXT:    sllv $3, $2, $3
; MMR3-NEXT:    li16 $2, 64
; MMR3-NEXT:    or16 $3, $4
; MMR3-NEXT:    srlv $6, $6, $16
; MMR3-NEXT:    sw $6, 12($sp) # 4-byte Folded Spill
; MMR3-NEXT:    subu16 $7, $2, $16
; MMR3-NEXT:    sllv $9, $5, $7
; MMR3-NEXT:    andi16 $2, $7, 32
; MMR3-NEXT:    sw $2, 28($sp) # 4-byte Folded Spill
; MMR3-NEXT:    andi16 $5, $16, 32
; MMR3-NEXT:    sw $5, 16($sp) # 4-byte Folded Spill
; MMR3-NEXT:    move $4, $9
; MMR3-NEXT:    li16 $17, 0
; MMR3-NEXT:    movn $4, $17, $2
; MMR3-NEXT:    movn $3, $6, $5
; MMR3-NEXT:    addiu $2, $16, -64
; MMR3-NEXT:    lw $5, 36($sp) # 4-byte Folded Reload
; MMR3-NEXT:    srlv $5, $5, $2
; MMR3-NEXT:    sw $5, 20($sp) # 4-byte Folded Spill
; MMR3-NEXT:    lw $17, 8($sp) # 4-byte Folded Reload
; MMR3-NEXT:    sll16 $6, $17, 1
; MMR3-NEXT:    sw $6, 4($sp) # 4-byte Folded Spill
; MMR3-NEXT:    not16 $5, $2
; MMR3-NEXT:    sllv $5, $6, $5
; MMR3-NEXT:    or16 $3, $4
; MMR3-NEXT:    lw $4, 20($sp) # 4-byte Folded Reload
; MMR3-NEXT:    or16 $5, $4
; MMR3-NEXT:    srav $1, $17, $2
; MMR3-NEXT:    andi16 $2, $2, 32
; MMR3-NEXT:    sw $2, 20($sp) # 4-byte Folded Spill
; MMR3-NEXT:    movn $5, $1, $2
; MMR3-NEXT:    sllv $2, $17, $7
; MMR3-NEXT:    not16 $4, $7
; MMR3-NEXT:    lw $7, 36($sp) # 4-byte Folded Reload
; MMR3-NEXT:    srl16 $6, $7, 1
; MMR3-NEXT:    srlv $6, $6, $4
; MMR3-NEXT:    sltiu $10, $16, 64
; MMR3-NEXT:    movn $5, $3, $10
; MMR3-NEXT:    or16 $6, $2
; MMR3-NEXT:    srlv $2, $7, $16
; MMR3-NEXT:    lw $3, 24($sp) # 4-byte Folded Reload
; MMR3-NEXT:    lw $4, 4($sp) # 4-byte Folded Reload
; MMR3-NEXT:    sllv $3, $4, $3
; MMR3-NEXT:    or16 $3, $2
; MMR3-NEXT:    srav $11, $17, $16
; MMR3-NEXT:    lw $4, 16($sp) # 4-byte Folded Reload
; MMR3-NEXT:    movn $3, $11, $4
; MMR3-NEXT:    sra $2, $17, 31
; MMR3-NEXT:    movz $5, $8, $16
; MMR3-NEXT:    move $8, $2
; MMR3-NEXT:    movn $8, $3, $10
; MMR3-NEXT:    lw $3, 28($sp) # 4-byte Folded Reload
; MMR3-NEXT:    movn $6, $9, $3
; MMR3-NEXT:    li16 $3, 0
; MMR3-NEXT:    lw $7, 12($sp) # 4-byte Folded Reload
; MMR3-NEXT:    movn $7, $3, $4
; MMR3-NEXT:    or16 $7, $6
; MMR3-NEXT:    lw $3, 20($sp) # 4-byte Folded Reload
; MMR3-NEXT:    movn $1, $2, $3
; MMR3-NEXT:    movn $1, $7, $10
; MMR3-NEXT:    lw $3, 32($sp) # 4-byte Folded Reload
; MMR3-NEXT:    movz $1, $3, $16
; MMR3-NEXT:    movn $11, $2, $4
; MMR3-NEXT:    movn $2, $11, $10
; MMR3-NEXT:    move $3, $8
; MMR3-NEXT:    move $4, $1
; MMR3-NEXT:    lw $16, 40($sp) # 4-byte Folded Reload
; MMR3-NEXT:    lw $17, 44($sp) # 4-byte Folded Reload
; MMR3-NEXT:    addiusp 48
; MMR3-NEXT:    jrc $ra
;
; MMR6-LABEL: ashr_i128:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    addiu $sp, $sp, -40
; MMR6-NEXT:    .cfi_def_cfa_offset 40
; MMR6-NEXT:    sw $17, 36($sp) # 4-byte Folded Spill
; MMR6-NEXT:    sw $16, 32($sp) # 4-byte Folded Spill
; MMR6-NEXT:    .cfi_offset 17, -4
; MMR6-NEXT:    .cfi_offset 16, -8
; MMR6-NEXT:    move $1, $7
; MMR6-NEXT:    sw $6, 28($sp) # 4-byte Folded Spill
; MMR6-NEXT:    move $6, $5
; MMR6-NEXT:    sw $4, 12($sp) # 4-byte Folded Spill
; MMR6-NEXT:    lw $3, 68($sp)
; MMR6-NEXT:    li16 $2, 64
; MMR6-NEXT:    subu16 $7, $2, $3
; MMR6-NEXT:    sllv $8, $6, $7
; MMR6-NEXT:    andi16 $5, $7, 32
; MMR6-NEXT:    selnez $9, $8, $5
; MMR6-NEXT:    sllv $16, $4, $7
; MMR6-NEXT:    not16 $7, $7
; MMR6-NEXT:    srl16 $17, $6, 1
; MMR6-NEXT:    sw $6, 20($sp) # 4-byte Folded Spill
; MMR6-NEXT:    srlv $7, $17, $7
; MMR6-NEXT:    or16 $7, $16
; MMR6-NEXT:    seleqz $7, $7, $5
; MMR6-NEXT:    or $7, $9, $7
; MMR6-NEXT:    srlv $17, $1, $3
; MMR6-NEXT:    not16 $2, $3
; MMR6-NEXT:    sw $2, 24($sp) # 4-byte Folded Spill
; MMR6-NEXT:    lw $4, 28($sp) # 4-byte Folded Reload
; MMR6-NEXT:    sll16 $16, $4, 1
; MMR6-NEXT:    sllv $16, $16, $2
; MMR6-NEXT:    or16 $16, $17
; MMR6-NEXT:    andi16 $17, $3, 32
; MMR6-NEXT:    seleqz $9, $16, $17
; MMR6-NEXT:    srlv $10, $4, $3
; MMR6-NEXT:    selnez $11, $10, $17
; MMR6-NEXT:    seleqz $16, $10, $17
; MMR6-NEXT:    or16 $16, $7
; MMR6-NEXT:    seleqz $2, $8, $5
; MMR6-NEXT:    sw $2, 8($sp) # 4-byte Folded Spill
; MMR6-NEXT:    or $7, $11, $9
; MMR6-NEXT:    addiu $2, $3, -64
; MMR6-NEXT:    srlv $4, $6, $2
; MMR6-NEXT:    sw $4, 4($sp) # 4-byte Folded Spill
; MMR6-NEXT:    lw $5, 12($sp) # 4-byte Folded Reload
; MMR6-NEXT:    sll16 $4, $5, 1
; MMR6-NEXT:    sw $4, 16($sp) # 4-byte Folded Spill
; MMR6-NEXT:    not16 $6, $2
; MMR6-NEXT:    sllv $6, $4, $6
; MMR6-NEXT:    sltiu $8, $3, 64
; MMR6-NEXT:    move $4, $7
; MMR6-NEXT:    lw $7, 8($sp) # 4-byte Folded Reload
; MMR6-NEXT:    or16 $4, $7
; MMR6-NEXT:    selnez $9, $16, $8
; MMR6-NEXT:    lw $7, 4($sp) # 4-byte Folded Reload
; MMR6-NEXT:    or16 $6, $7
; MMR6-NEXT:    srav $7, $5, $2
; MMR6-NEXT:    andi16 $2, $2, 32
; MMR6-NEXT:    seleqz $10, $7, $2
; MMR6-NEXT:    sra $11, $5, 31
; MMR6-NEXT:    selnez $12, $11, $2
; MMR6-NEXT:    seleqz $6, $6, $2
; MMR6-NEXT:    or $10, $12, $10
; MMR6-NEXT:    seleqz $10, $10, $8
; MMR6-NEXT:    selnez $2, $7, $2
; MMR6-NEXT:    seleqz $7, $11, $8
; MMR6-NEXT:    or $9, $9, $10
; MMR6-NEXT:    selnez $9, $9, $3
; MMR6-NEXT:    selnez $4, $4, $8
; MMR6-NEXT:    or $2, $2, $6
; MMR6-NEXT:    srav $5, $5, $3
; MMR6-NEXT:    seleqz $6, $5, $17
; MMR6-NEXT:    selnez $10, $11, $17
; MMR6-NEXT:    or $6, $10, $6
; MMR6-NEXT:    selnez $6, $6, $8
; MMR6-NEXT:    seleqz $2, $2, $8
; MMR6-NEXT:    lw $16, 28($sp) # 4-byte Folded Reload
; MMR6-NEXT:    seleqz $10, $16, $3
; MMR6-NEXT:    seleqz $1, $1, $3
; MMR6-NEXT:    or $2, $4, $2
; MMR6-NEXT:    selnez $2, $2, $3
; MMR6-NEXT:    or $1, $1, $2
; MMR6-NEXT:    or $4, $10, $9
; MMR6-NEXT:    or $2, $6, $7
; MMR6-NEXT:    lw $6, 20($sp) # 4-byte Folded Reload
; MMR6-NEXT:    srlv $3, $6, $3
; MMR6-NEXT:    lw $6, 24($sp) # 4-byte Folded Reload
; MMR6-NEXT:    lw $16, 16($sp) # 4-byte Folded Reload
; MMR6-NEXT:    sllv $6, $16, $6
; MMR6-NEXT:    or16 $6, $3
; MMR6-NEXT:    seleqz $3, $6, $17
; MMR6-NEXT:    selnez $5, $5, $17
; MMR6-NEXT:    or $3, $5, $3
; MMR6-NEXT:    selnez $3, $3, $8
; MMR6-NEXT:    or $3, $3, $7
; MMR6-NEXT:    move $5, $1
; MMR6-NEXT:    lw $16, 32($sp) # 4-byte Folded Reload
; MMR6-NEXT:    lw $17, 36($sp) # 4-byte Folded Reload
; MMR6-NEXT:    addiu $sp, $sp, 40
; MMR6-NEXT:    jrc $ra
entry:
; o32 shouldn't use TImode helpers.
; GP32-NOT:       lw        $25, %call16(__ashrti3)($gp)
; MM-NOT:         lw        $25, %call16(__ashrti3)($2)

  %r = ashr i128 %a, %b
  ret i128 %r
}
