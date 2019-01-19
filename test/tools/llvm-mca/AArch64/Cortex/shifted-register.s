# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -march=aarch64 -mcpu=cortex-a57 -resource-pressure=false < %s | FileCheck %s

  add	w0, w1, w2, lsl #0
  sub	x3, x4, x5, lsl #1
  adds	x6, x7, x8, lsr #2
  subs	x9, x10, x11, asr #3

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      400
# CHECK-NEXT: Total Cycles:      304
# CHECK-NEXT: Total uOps:        400

# CHECK:      Dispatch Width:    3
# CHECK-NEXT: uOps Per Cycle:    1.32
# CHECK-NEXT: IPC:               1.32
# CHECK-NEXT: Block RThroughput: 3.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.50                        add	w0, w1, w2
# CHECK-NEXT:  1      2     1.00                        sub	x3, x4, x5, lsl #1
# CHECK-NEXT:  1      2     1.00                        adds	x6, x7, x8, lsr #2
# CHECK-NEXT:  1      2     1.00                        subs	x9, x10, x11, asr #3
