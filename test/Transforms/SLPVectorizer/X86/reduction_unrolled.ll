; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -slp-vectorizer -slp-vectorize-hor -S -mtriple=x86_64-unknown-linux-gnu -mcpu=bdver2 -debug < %s 2>&1 | FileCheck %s
; RUN: opt -slp-vectorizer -slp-vectorize-hor -S -mtriple=x86_64-unknown-linux-gnu -mcpu=core2 -debug < %s 2>&1 | FileCheck --check-prefix=SSE2 %s
; REQUIRES: asserts

; int test_add(unsigned int *p) {
;   int result = 0;
;   for (int i = 0; i < 8; i++)
;     result += p[i];
;   return result;
; }

; Vector cost is 5, Scalar cost is 7
; CHECK: Adding cost -2 for reduction that starts with   %7 = load i32, i32* %arrayidx.7, align 4 (It is a splitting reduction)
; Vector cost is 11, Scalar cost is 7
; SSE2:  Adding cost 4 for reduction that starts with   %7 = load i32, i32* %arrayidx.7, align 4 (It is a splitting reduction)
define i32 @test_add(i32* nocapture readonly %p) {
; CHECK-LABEL: @test_add(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[P:%.*]], i64 1
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 2
; CHECK-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 3
; CHECK-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 4
; CHECK-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 5
; CHECK-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 6
; CHECK-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 7
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[P]] to <8 x i32>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* [[TMP0]], align 4
; CHECK-NEXT:    [[MUL_18:%.*]] = add i32 undef, undef
; CHECK-NEXT:    [[MUL_29:%.*]] = add i32 undef, [[MUL_18]]
; CHECK-NEXT:    [[MUL_310:%.*]] = add i32 undef, [[MUL_29]]
; CHECK-NEXT:    [[MUL_411:%.*]] = add i32 undef, [[MUL_310]]
; CHECK-NEXT:    [[MUL_512:%.*]] = add i32 undef, [[MUL_411]]
; CHECK-NEXT:    [[MUL_613:%.*]] = add i32 undef, [[MUL_512]]
; CHECK-NEXT:    [[RDX_SHUF:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <8 x i32> [[TMP1]], [[RDX_SHUF]]
; CHECK-NEXT:    [[RDX_SHUF1:%.*]] = shufflevector <8 x i32> [[BIN_RDX]], <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[BIN_RDX2:%.*]] = add <8 x i32> [[BIN_RDX]], [[RDX_SHUF1]]
; CHECK-NEXT:    [[RDX_SHUF3:%.*]] = shufflevector <8 x i32> [[BIN_RDX2]], <8 x i32> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[BIN_RDX4:%.*]] = add <8 x i32> [[BIN_RDX2]], [[RDX_SHUF3]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <8 x i32> [[BIN_RDX4]], i32 0
; CHECK-NEXT:    [[MUL_714:%.*]] = add i32 undef, [[MUL_613]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;
; SSE2-LABEL: @test_add(
; SSE2-NEXT:  entry:
; SSE2-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[P:%.*]], i64 1
; SSE2-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 2
; SSE2-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 3
; SSE2-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 4
; SSE2-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 5
; SSE2-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 6
; SSE2-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 7
; SSE2-NEXT:    [[TMP0:%.*]] = bitcast i32* [[P]] to <8 x i32>*
; SSE2-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* [[TMP0]], align 4
; SSE2-NEXT:    [[MUL_18:%.*]] = add i32 undef, undef
; SSE2-NEXT:    [[MUL_29:%.*]] = add i32 undef, [[MUL_18]]
; SSE2-NEXT:    [[MUL_310:%.*]] = add i32 undef, [[MUL_29]]
; SSE2-NEXT:    [[MUL_411:%.*]] = add i32 undef, [[MUL_310]]
; SSE2-NEXT:    [[MUL_512:%.*]] = add i32 undef, [[MUL_411]]
; SSE2-NEXT:    [[MUL_613:%.*]] = add i32 undef, [[MUL_512]]
; SSE2-NEXT:    [[RDX_SHUF:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX:%.*]] = add <8 x i32> [[TMP1]], [[RDX_SHUF]]
; SSE2-NEXT:    [[RDX_SHUF1:%.*]] = shufflevector <8 x i32> [[BIN_RDX]], <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX2:%.*]] = add <8 x i32> [[BIN_RDX]], [[RDX_SHUF1]]
; SSE2-NEXT:    [[RDX_SHUF3:%.*]] = shufflevector <8 x i32> [[BIN_RDX2]], <8 x i32> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX4:%.*]] = add <8 x i32> [[BIN_RDX2]], [[RDX_SHUF3]]
; SSE2-NEXT:    [[TMP2:%.*]] = extractelement <8 x i32> [[BIN_RDX4]], i32 0
; SSE2-NEXT:    [[MUL_714:%.*]] = add i32 undef, [[MUL_613]]
; SSE2-NEXT:    ret i32 [[TMP2]]
;
entry:
  %0 = load i32, i32* %p, align 4
  %arrayidx.1 = getelementptr inbounds i32, i32* %p, i64 1
  %1 = load i32, i32* %arrayidx.1, align 4
  %mul.18 = add i32 %1, %0
  %arrayidx.2 = getelementptr inbounds i32, i32* %p, i64 2
  %2 = load i32, i32* %arrayidx.2, align 4
  %mul.29 = add i32 %2, %mul.18
  %arrayidx.3 = getelementptr inbounds i32, i32* %p, i64 3
  %3 = load i32, i32* %arrayidx.3, align 4
  %mul.310 = add i32 %3, %mul.29
  %arrayidx.4 = getelementptr inbounds i32, i32* %p, i64 4
  %4 = load i32, i32* %arrayidx.4, align 4
  %mul.411 = add i32 %4, %mul.310
  %arrayidx.5 = getelementptr inbounds i32, i32* %p, i64 5
  %5 = load i32, i32* %arrayidx.5, align 4
  %mul.512 = add i32 %5, %mul.411
  %arrayidx.6 = getelementptr inbounds i32, i32* %p, i64 6
  %6 = load i32, i32* %arrayidx.6, align 4
  %mul.613 = add i32 %6, %mul.512
  %arrayidx.7 = getelementptr inbounds i32, i32* %p, i64 7
  %7 = load i32, i32* %arrayidx.7, align 4
  %mul.714 = add i32 %7, %mul.613
  ret i32 %mul.714
}

; int test_mul(unsigned int *p) {
;   int result = 0;
;   for (int i = 0; i < 8; i++)
;     result *= p[i];
;   return result;
; }

define i32 @test_mul(i32* nocapture readonly %p) {
; CHECK-LABEL: @test_mul(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[P:%.*]], align 4
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[ARRAYIDX_1]], align 4
; CHECK-NEXT:    [[MUL_18:%.*]] = mul i32 [[TMP1]], [[TMP0]]
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 2
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[ARRAYIDX_2]], align 4
; CHECK-NEXT:    [[MUL_29:%.*]] = mul i32 [[TMP2]], [[MUL_18]]
; CHECK-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 3
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, i32* [[ARRAYIDX_3]], align 4
; CHECK-NEXT:    [[MUL_310:%.*]] = mul i32 [[TMP3]], [[MUL_29]]
; CHECK-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 4
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, i32* [[ARRAYIDX_4]], align 4
; CHECK-NEXT:    [[MUL_411:%.*]] = mul i32 [[TMP4]], [[MUL_310]]
; CHECK-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 5
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, i32* [[ARRAYIDX_5]], align 4
; CHECK-NEXT:    [[MUL_512:%.*]] = mul i32 [[TMP5]], [[MUL_411]]
; CHECK-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 6
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, i32* [[ARRAYIDX_6]], align 4
; CHECK-NEXT:    [[MUL_613:%.*]] = mul i32 [[TMP6]], [[MUL_512]]
; CHECK-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 7
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, i32* [[ARRAYIDX_7]], align 4
; CHECK-NEXT:    [[MUL_714:%.*]] = mul i32 [[TMP7]], [[MUL_613]]
; CHECK-NEXT:    ret i32 [[MUL_714]]
;
; SSE2-LABEL: @test_mul(
; SSE2-NEXT:  entry:
; SSE2-NEXT:    [[TMP0:%.*]] = load i32, i32* [[P:%.*]], align 4
; SSE2-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 1
; SSE2-NEXT:    [[TMP1:%.*]] = load i32, i32* [[ARRAYIDX_1]], align 4
; SSE2-NEXT:    [[MUL_18:%.*]] = mul i32 [[TMP1]], [[TMP0]]
; SSE2-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 2
; SSE2-NEXT:    [[TMP2:%.*]] = load i32, i32* [[ARRAYIDX_2]], align 4
; SSE2-NEXT:    [[MUL_29:%.*]] = mul i32 [[TMP2]], [[MUL_18]]
; SSE2-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 3
; SSE2-NEXT:    [[TMP3:%.*]] = load i32, i32* [[ARRAYIDX_3]], align 4
; SSE2-NEXT:    [[MUL_310:%.*]] = mul i32 [[TMP3]], [[MUL_29]]
; SSE2-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 4
; SSE2-NEXT:    [[TMP4:%.*]] = load i32, i32* [[ARRAYIDX_4]], align 4
; SSE2-NEXT:    [[MUL_411:%.*]] = mul i32 [[TMP4]], [[MUL_310]]
; SSE2-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 5
; SSE2-NEXT:    [[TMP5:%.*]] = load i32, i32* [[ARRAYIDX_5]], align 4
; SSE2-NEXT:    [[MUL_512:%.*]] = mul i32 [[TMP5]], [[MUL_411]]
; SSE2-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 6
; SSE2-NEXT:    [[TMP6:%.*]] = load i32, i32* [[ARRAYIDX_6]], align 4
; SSE2-NEXT:    [[MUL_613:%.*]] = mul i32 [[TMP6]], [[MUL_512]]
; SSE2-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 7
; SSE2-NEXT:    [[TMP7:%.*]] = load i32, i32* [[ARRAYIDX_7]], align 4
; SSE2-NEXT:    [[MUL_714:%.*]] = mul i32 [[TMP7]], [[MUL_613]]
; SSE2-NEXT:    ret i32 [[MUL_714]]
;
entry:
  %0 = load i32, i32* %p, align 4
  %arrayidx.1 = getelementptr inbounds i32, i32* %p, i64 1
  %1 = load i32, i32* %arrayidx.1, align 4
  %mul.18 = mul i32 %1, %0
  %arrayidx.2 = getelementptr inbounds i32, i32* %p, i64 2
  %2 = load i32, i32* %arrayidx.2, align 4
  %mul.29 = mul i32 %2, %mul.18
  %arrayidx.3 = getelementptr inbounds i32, i32* %p, i64 3
  %3 = load i32, i32* %arrayidx.3, align 4
  %mul.310 = mul i32 %3, %mul.29
  %arrayidx.4 = getelementptr inbounds i32, i32* %p, i64 4
  %4 = load i32, i32* %arrayidx.4, align 4
  %mul.411 = mul i32 %4, %mul.310
  %arrayidx.5 = getelementptr inbounds i32, i32* %p, i64 5
  %5 = load i32, i32* %arrayidx.5, align 4
  %mul.512 = mul i32 %5, %mul.411
  %arrayidx.6 = getelementptr inbounds i32, i32* %p, i64 6
  %6 = load i32, i32* %arrayidx.6, align 4
  %mul.613 = mul i32 %6, %mul.512
  %arrayidx.7 = getelementptr inbounds i32, i32* %p, i64 7
  %7 = load i32, i32* %arrayidx.7, align 4
  %mul.714 = mul i32 %7, %mul.613
  ret i32 %mul.714
}

; int test_and(unsigned int *p) {
;   int result = 0;
;   for (int i = 0; i < 8; i++)
;     result &= p[i];
;   return result;
; }

define i32 @test_and(i32* nocapture readonly %p) {
; CHECK-LABEL: @test_and(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[P:%.*]], align 4
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[ARRAYIDX_1]], align 4
; CHECK-NEXT:    [[MUL_18:%.*]] = and i32 [[TMP1]], [[TMP0]]
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 2
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[ARRAYIDX_2]], align 4
; CHECK-NEXT:    [[MUL_29:%.*]] = and i32 [[TMP2]], [[MUL_18]]
; CHECK-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 3
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, i32* [[ARRAYIDX_3]], align 4
; CHECK-NEXT:    [[MUL_310:%.*]] = and i32 [[TMP3]], [[MUL_29]]
; CHECK-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 4
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, i32* [[ARRAYIDX_4]], align 4
; CHECK-NEXT:    [[MUL_411:%.*]] = and i32 [[TMP4]], [[MUL_310]]
; CHECK-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 5
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, i32* [[ARRAYIDX_5]], align 4
; CHECK-NEXT:    [[MUL_512:%.*]] = and i32 [[TMP5]], [[MUL_411]]
; CHECK-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 6
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, i32* [[ARRAYIDX_6]], align 4
; CHECK-NEXT:    [[MUL_613:%.*]] = and i32 [[TMP6]], [[MUL_512]]
; CHECK-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 7
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, i32* [[ARRAYIDX_7]], align 4
; CHECK-NEXT:    [[MUL_714:%.*]] = and i32 [[TMP7]], [[MUL_613]]
; CHECK-NEXT:    ret i32 [[MUL_714]]
;
; SSE2-LABEL: @test_and(
; SSE2-NEXT:  entry:
; SSE2-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[P:%.*]], i64 1
; SSE2-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 2
; SSE2-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 3
; SSE2-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 4
; SSE2-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 5
; SSE2-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 6
; SSE2-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 7
; SSE2-NEXT:    [[TMP0:%.*]] = bitcast i32* [[P]] to <8 x i32>*
; SSE2-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* [[TMP0]], align 4
; SSE2-NEXT:    [[MUL_18:%.*]] = and i32 undef, undef
; SSE2-NEXT:    [[MUL_29:%.*]] = and i32 undef, [[MUL_18]]
; SSE2-NEXT:    [[MUL_310:%.*]] = and i32 undef, [[MUL_29]]
; SSE2-NEXT:    [[MUL_411:%.*]] = and i32 undef, [[MUL_310]]
; SSE2-NEXT:    [[MUL_512:%.*]] = and i32 undef, [[MUL_411]]
; SSE2-NEXT:    [[MUL_613:%.*]] = and i32 undef, [[MUL_512]]
; SSE2-NEXT:    [[RDX_SHUF:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX:%.*]] = and <8 x i32> [[TMP1]], [[RDX_SHUF]]
; SSE2-NEXT:    [[RDX_SHUF1:%.*]] = shufflevector <8 x i32> [[BIN_RDX]], <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX2:%.*]] = and <8 x i32> [[BIN_RDX]], [[RDX_SHUF1]]
; SSE2-NEXT:    [[RDX_SHUF3:%.*]] = shufflevector <8 x i32> [[BIN_RDX2]], <8 x i32> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX4:%.*]] = and <8 x i32> [[BIN_RDX2]], [[RDX_SHUF3]]
; SSE2-NEXT:    [[TMP2:%.*]] = extractelement <8 x i32> [[BIN_RDX4]], i32 0
; SSE2-NEXT:    [[MUL_714:%.*]] = and i32 undef, [[MUL_613]]
; SSE2-NEXT:    ret i32 [[TMP2]]
;
entry:
  %0 = load i32, i32* %p, align 4
  %arrayidx.1 = getelementptr inbounds i32, i32* %p, i64 1
  %1 = load i32, i32* %arrayidx.1, align 4
  %mul.18 = and i32 %1, %0
  %arrayidx.2 = getelementptr inbounds i32, i32* %p, i64 2
  %2 = load i32, i32* %arrayidx.2, align 4
  %mul.29 = and i32 %2, %mul.18
  %arrayidx.3 = getelementptr inbounds i32, i32* %p, i64 3
  %3 = load i32, i32* %arrayidx.3, align 4
  %mul.310 = and i32 %3, %mul.29
  %arrayidx.4 = getelementptr inbounds i32, i32* %p, i64 4
  %4 = load i32, i32* %arrayidx.4, align 4
  %mul.411 = and i32 %4, %mul.310
  %arrayidx.5 = getelementptr inbounds i32, i32* %p, i64 5
  %5 = load i32, i32* %arrayidx.5, align 4
  %mul.512 = and i32 %5, %mul.411
  %arrayidx.6 = getelementptr inbounds i32, i32* %p, i64 6
  %6 = load i32, i32* %arrayidx.6, align 4
  %mul.613 = and i32 %6, %mul.512
  %arrayidx.7 = getelementptr inbounds i32, i32* %p, i64 7
  %7 = load i32, i32* %arrayidx.7, align 4
  %mul.714 = and i32 %7, %mul.613
  ret i32 %mul.714
}

; int test_or(unsigned int *p) {
;   int result = 0;
;   for (int i = 0; i < 8; i++)
;     result |= p[i];
;   return result;
; }

define i32 @test_or(i32* nocapture readonly %p) {
; CHECK-LABEL: @test_or(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[P:%.*]], align 4
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[ARRAYIDX_1]], align 4
; CHECK-NEXT:    [[MUL_18:%.*]] = or i32 [[TMP1]], [[TMP0]]
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 2
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[ARRAYIDX_2]], align 4
; CHECK-NEXT:    [[MUL_29:%.*]] = or i32 [[TMP2]], [[MUL_18]]
; CHECK-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 3
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, i32* [[ARRAYIDX_3]], align 4
; CHECK-NEXT:    [[MUL_310:%.*]] = or i32 [[TMP3]], [[MUL_29]]
; CHECK-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 4
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, i32* [[ARRAYIDX_4]], align 4
; CHECK-NEXT:    [[MUL_411:%.*]] = or i32 [[TMP4]], [[MUL_310]]
; CHECK-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 5
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, i32* [[ARRAYIDX_5]], align 4
; CHECK-NEXT:    [[MUL_512:%.*]] = or i32 [[TMP5]], [[MUL_411]]
; CHECK-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 6
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, i32* [[ARRAYIDX_6]], align 4
; CHECK-NEXT:    [[MUL_613:%.*]] = or i32 [[TMP6]], [[MUL_512]]
; CHECK-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 7
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, i32* [[ARRAYIDX_7]], align 4
; CHECK-NEXT:    [[MUL_714:%.*]] = or i32 [[TMP7]], [[MUL_613]]
; CHECK-NEXT:    ret i32 [[MUL_714]]
;
; SSE2-LABEL: @test_or(
; SSE2-NEXT:  entry:
; SSE2-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[P:%.*]], i64 1
; SSE2-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 2
; SSE2-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 3
; SSE2-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 4
; SSE2-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 5
; SSE2-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 6
; SSE2-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 7
; SSE2-NEXT:    [[TMP0:%.*]] = bitcast i32* [[P]] to <8 x i32>*
; SSE2-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* [[TMP0]], align 4
; SSE2-NEXT:    [[MUL_18:%.*]] = or i32 undef, undef
; SSE2-NEXT:    [[MUL_29:%.*]] = or i32 undef, [[MUL_18]]
; SSE2-NEXT:    [[MUL_310:%.*]] = or i32 undef, [[MUL_29]]
; SSE2-NEXT:    [[MUL_411:%.*]] = or i32 undef, [[MUL_310]]
; SSE2-NEXT:    [[MUL_512:%.*]] = or i32 undef, [[MUL_411]]
; SSE2-NEXT:    [[MUL_613:%.*]] = or i32 undef, [[MUL_512]]
; SSE2-NEXT:    [[RDX_SHUF:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX:%.*]] = or <8 x i32> [[TMP1]], [[RDX_SHUF]]
; SSE2-NEXT:    [[RDX_SHUF1:%.*]] = shufflevector <8 x i32> [[BIN_RDX]], <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX2:%.*]] = or <8 x i32> [[BIN_RDX]], [[RDX_SHUF1]]
; SSE2-NEXT:    [[RDX_SHUF3:%.*]] = shufflevector <8 x i32> [[BIN_RDX2]], <8 x i32> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX4:%.*]] = or <8 x i32> [[BIN_RDX2]], [[RDX_SHUF3]]
; SSE2-NEXT:    [[TMP2:%.*]] = extractelement <8 x i32> [[BIN_RDX4]], i32 0
; SSE2-NEXT:    [[MUL_714:%.*]] = or i32 undef, [[MUL_613]]
; SSE2-NEXT:    ret i32 [[TMP2]]
;
entry:
  %0 = load i32, i32* %p, align 4
  %arrayidx.1 = getelementptr inbounds i32, i32* %p, i64 1
  %1 = load i32, i32* %arrayidx.1, align 4
  %mul.18 = or i32 %1, %0
  %arrayidx.2 = getelementptr inbounds i32, i32* %p, i64 2
  %2 = load i32, i32* %arrayidx.2, align 4
  %mul.29 = or i32 %2, %mul.18
  %arrayidx.3 = getelementptr inbounds i32, i32* %p, i64 3
  %3 = load i32, i32* %arrayidx.3, align 4
  %mul.310 = or i32 %3, %mul.29
  %arrayidx.4 = getelementptr inbounds i32, i32* %p, i64 4
  %4 = load i32, i32* %arrayidx.4, align 4
  %mul.411 = or i32 %4, %mul.310
  %arrayidx.5 = getelementptr inbounds i32, i32* %p, i64 5
  %5 = load i32, i32* %arrayidx.5, align 4
  %mul.512 = or i32 %5, %mul.411
  %arrayidx.6 = getelementptr inbounds i32, i32* %p, i64 6
  %6 = load i32, i32* %arrayidx.6, align 4
  %mul.613 = or i32 %6, %mul.512
  %arrayidx.7 = getelementptr inbounds i32, i32* %p, i64 7
  %7 = load i32, i32* %arrayidx.7, align 4
  %mul.714 = or i32 %7, %mul.613
  ret i32 %mul.714
}

; int test_xor(unsigned int *p) {
;   int result = 0;
;   for (int i = 0; i < 8; i++)
;     result ^= p[i];
;   return result;
; }

define i32 @test_xor(i32* nocapture readonly %p) {
; CHECK-LABEL: @test_xor(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[P:%.*]], align 4
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[ARRAYIDX_1]], align 4
; CHECK-NEXT:    [[MUL_18:%.*]] = xor i32 [[TMP1]], [[TMP0]]
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 2
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[ARRAYIDX_2]], align 4
; CHECK-NEXT:    [[MUL_29:%.*]] = xor i32 [[TMP2]], [[MUL_18]]
; CHECK-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 3
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, i32* [[ARRAYIDX_3]], align 4
; CHECK-NEXT:    [[MUL_310:%.*]] = xor i32 [[TMP3]], [[MUL_29]]
; CHECK-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 4
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, i32* [[ARRAYIDX_4]], align 4
; CHECK-NEXT:    [[MUL_411:%.*]] = xor i32 [[TMP4]], [[MUL_310]]
; CHECK-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 5
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, i32* [[ARRAYIDX_5]], align 4
; CHECK-NEXT:    [[MUL_512:%.*]] = xor i32 [[TMP5]], [[MUL_411]]
; CHECK-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 6
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, i32* [[ARRAYIDX_6]], align 4
; CHECK-NEXT:    [[MUL_613:%.*]] = xor i32 [[TMP6]], [[MUL_512]]
; CHECK-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 7
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, i32* [[ARRAYIDX_7]], align 4
; CHECK-NEXT:    [[MUL_714:%.*]] = xor i32 [[TMP7]], [[MUL_613]]
; CHECK-NEXT:    ret i32 [[MUL_714]]
;
; SSE2-LABEL: @test_xor(
; SSE2-NEXT:  entry:
; SSE2-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[P:%.*]], i64 1
; SSE2-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 2
; SSE2-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 3
; SSE2-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 4
; SSE2-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 5
; SSE2-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 6
; SSE2-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 7
; SSE2-NEXT:    [[TMP0:%.*]] = bitcast i32* [[P]] to <8 x i32>*
; SSE2-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* [[TMP0]], align 4
; SSE2-NEXT:    [[MUL_18:%.*]] = xor i32 undef, undef
; SSE2-NEXT:    [[MUL_29:%.*]] = xor i32 undef, [[MUL_18]]
; SSE2-NEXT:    [[MUL_310:%.*]] = xor i32 undef, [[MUL_29]]
; SSE2-NEXT:    [[MUL_411:%.*]] = xor i32 undef, [[MUL_310]]
; SSE2-NEXT:    [[MUL_512:%.*]] = xor i32 undef, [[MUL_411]]
; SSE2-NEXT:    [[MUL_613:%.*]] = xor i32 undef, [[MUL_512]]
; SSE2-NEXT:    [[RDX_SHUF:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX:%.*]] = xor <8 x i32> [[TMP1]], [[RDX_SHUF]]
; SSE2-NEXT:    [[RDX_SHUF1:%.*]] = shufflevector <8 x i32> [[BIN_RDX]], <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX2:%.*]] = xor <8 x i32> [[BIN_RDX]], [[RDX_SHUF1]]
; SSE2-NEXT:    [[RDX_SHUF3:%.*]] = shufflevector <8 x i32> [[BIN_RDX2]], <8 x i32> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE2-NEXT:    [[BIN_RDX4:%.*]] = xor <8 x i32> [[BIN_RDX2]], [[RDX_SHUF3]]
; SSE2-NEXT:    [[TMP2:%.*]] = extractelement <8 x i32> [[BIN_RDX4]], i32 0
; SSE2-NEXT:    [[MUL_714:%.*]] = xor i32 undef, [[MUL_613]]
; SSE2-NEXT:    ret i32 [[TMP2]]
;
entry:
  %0 = load i32, i32* %p, align 4
  %arrayidx.1 = getelementptr inbounds i32, i32* %p, i64 1
  %1 = load i32, i32* %arrayidx.1, align 4
  %mul.18 = xor i32 %1, %0
  %arrayidx.2 = getelementptr inbounds i32, i32* %p, i64 2
  %2 = load i32, i32* %arrayidx.2, align 4
  %mul.29 = xor i32 %2, %mul.18
  %arrayidx.3 = getelementptr inbounds i32, i32* %p, i64 3
  %3 = load i32, i32* %arrayidx.3, align 4
  %mul.310 = xor i32 %3, %mul.29
  %arrayidx.4 = getelementptr inbounds i32, i32* %p, i64 4
  %4 = load i32, i32* %arrayidx.4, align 4
  %mul.411 = xor i32 %4, %mul.310
  %arrayidx.5 = getelementptr inbounds i32, i32* %p, i64 5
  %5 = load i32, i32* %arrayidx.5, align 4
  %mul.512 = xor i32 %5, %mul.411
  %arrayidx.6 = getelementptr inbounds i32, i32* %p, i64 6
  %6 = load i32, i32* %arrayidx.6, align 4
  %mul.613 = xor i32 %6, %mul.512
  %arrayidx.7 = getelementptr inbounds i32, i32* %p, i64 7
  %7 = load i32, i32* %arrayidx.7, align 4
  %mul.714 = xor i32 %7, %mul.613
  ret i32 %mul.714
}
