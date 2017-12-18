; RUN: %llc_dwarf -filetype=obj < %s | llvm-dwarfdump -debug-info - | FileCheck %s
; REQUIRES: object-emission

; Generated by clang -c -g -std=c11 -S -emit-llvm from the following C11 source
;
; // every object of type struct data will be aligned to 128-byte boundary
; struct data {
;   char x;
;   _Alignas(128) char arr[2];
; };
;
; _Alignas(2048) struct data d; // this instance of data is aligned even stricter
; int foo(void)
; {
;     struct data local_data;
;     return 0;
; }

; CHECK: DW_TAG_variable
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_name{{.*}}"d"
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_alignment{{.*}}2048
; CHECK: DW_TAG_structure_type
; CHECK: DW_TAG_member
; CHECK: DW_TAG_member
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_name{{.*}}"arr"
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_alignment{{.*}}128

; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.data = type { i8, [127 x i8], [2 x i8], [126 x i8] }

@d = common global %struct.data zeroinitializer, align 2048, !dbg !0

; Function Attrs: nounwind uwtable
define i32 @foo() #0 !dbg !17 {
entry:
  %local_data = alloca %struct.data, align 128
  call void @llvm.dbg.declare(metadata %struct.data* %local_data, metadata !21, metadata !22), !dbg !23
  ret i32 0, !dbg !24
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { nounwind uwtable }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!14, !15}
!llvm.ident = !{!16}

!0 = distinct !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = !DIGlobalVariable(name: "d", scope: !2, file: !3, line: 7, type: !6, isLocal: false, isDefinition: true, align: 16384)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 4.0.0 (http://llvm.org/git/clang.git 9ce5220b821054019059c2ac4a9b132c7723832d) (http://llvm.org/git/llvm.git 9a6298be89ce0359b151c0a37af2776a12c69e85)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "test.c", directory: "/tmp")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "data", file: !3, line: 2, size: 2048, elements: !7)
!7 = !{!8, !10}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !6, file: !3, line: 3, baseType: !9, size: 8)
!9 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "arr", scope: !6, file: !3, line: 4, baseType: !11, size: 16, align: 1024, offset: 1024)
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 16, elements: !12)
!12 = !{!13}
!13 = !DISubrange(count: 2)
!14 = !{i32 2, !"Dwarf Version", i32 4}
!15 = !{i32 2, !"Debug Info Version", i32 3}
!16 = !{!"clang version 4.0.0 (http://llvm.org/git/clang.git 9ce5220b821054019059c2ac4a9b132c7723832d) (http://llvm.org/git/llvm.git 9a6298be89ce0359b151c0a37af2776a12c69e85)"}
!17 = distinct !DISubprogram(name: "foo", scope: !3, file: !3, line: 8, type: !18, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!18 = !DISubroutineType(types: !19)
!19 = !{!20}
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DILocalVariable(name: "local_data", scope: !17, file: !3, line: 10, type: !6)
!22 = !DIExpression()
!23 = !DILocation(line: 10, column: 17, scope: !17)
!24 = !DILocation(line: 11, column: 5, scope: !17)

