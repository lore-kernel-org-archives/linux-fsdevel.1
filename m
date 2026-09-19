Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD462475CB
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776984; cv=none; b=IRQDeofMzUw9yJiRYvc5oWNRAzCHjT8D7if6qPX4uS1E4CvWfh90KieN0mSoGtClB1rAOeEMbHMU06wzvs6FbuSYSXNfc6jrQ4RTHeVQFhKslpDDHIez3yunMbVw1LX9rFiAzk1NzG9Mvdp0cmnWjfwSqLjDxlXkNoqHCgZ6RSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776984; c=relaxed/simple;
	bh=I6vcAznO/lx/xgSk45ie8+VNZpbmRwpLwpkuDJyLRS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNcd3l85iG81UnHdaPhewMpOuhCBAZob/2yZ/1Y8bPMrBSwsStU/BmT0AfuMb1ZNrVXZD3cH/sdcx0ydwODYxt7lf61+kf078EtETLN6UJAIv2RNboZNuQfx1/cvq5ACwYUVAXIH4qU5KBOStXXyxRuyU6BvWeiefoTNA585XCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=J9JGWXGY; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="J9JGWXGY"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85e68bdbcc1so9657377b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 17:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789776981; x=1790381781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bshBUcl3pHzufl7tFotwVFrM5gBazShO03UVMeXLhOE=;
        b=J9JGWXGYXVJGy1lT4TeLzpCj//P4EllZbaY6sv6IyD9r4hn1+1FRuYL9VQoth08aJW
         +Pm4buO7v5EDIlp690b2VmJ5+U+PV64Y5yGi4jkii/r/dK4OfQT5ylqaVvFMUo/s+JtB
         Q/Q5fmVqQRgNLxwjSUEWjVn+80fBWxpeg10lJubxqQ42dw1FYC0iKFONh0RCpPCYYzX3
         csCEZP4VbAPRQlPqgpR2tv+qVOUMvn+P6zLJG7iTTqoo/EUnwZiavwall8EzQaqvX62C
         80M8XdfDkLiB1E9NdMhGo3hmHJvblShyJ5rT4sz10STLDRqAaH8mWLo1QnMgzqlPCJ/P
         /MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789776981; x=1790381781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bshBUcl3pHzufl7tFotwVFrM5gBazShO03UVMeXLhOE=;
        b=n3tT0MQiLd/OoF0R9AKT8o70o/TYCiU008VbNm54fF5l9xXetiaso3/u8hnW2ykC/m
         jHRPgtZDIM8ckWtUv/mYZz9GgShv+PEtmMNQKYzo8ez1c6+c8kOwEVmFoQcfWS2eRt4d
         BSETJuqA/tWG7t3PJtR71l7S/ukQui9Y+RsuNHSzImORrj93lShtDuaRZ2IZc+rGvVYK
         EOWBopRRiAQ9h/fBCQOVQSm9uvy4XJw1PkE0k5QY3/dsSLuiaYqVYRKISHEUnChPBk3d
         feB5CUu60EmeLX6kitOZOUUB1Nzlvc6hDg+5VVghwcfJq8VVT3D7yGPHKd/vPcYI6lFM
         Db6A==
X-Gm-Message-State: AFuF++nLJ0xDoWdwzKTDWJwNzhogYl84L0HJG+lryU7VICPUW/Y2zQQK
	usw6IHBC5jbLQ5the/DXtkUgsg3HY3GiuIgtcvVhjpGXbuXha5J+yxPsb4WcwD3dMGs=
X-Gm-Gg: AYBFou0RUv3e0D9HYANWYrJHfbD9ivFj8scVUaAfikDU34gQ0zND1IXrjdFfRKs9ntb
	MuLLEw6H6akRcgmpOjhAh9IPov/hlMPzjW3OJ82zIpd2hqQxhy5iEt6eKUMTgfGP5RV/KotIiTY
	dF5xtQ4984DPL/szumwONjqQQ+X8BMm8X6f5AfzPipibVNRGslglTHpIYytzqihkcMhieTSsbUr
	gsgced/DWHLnRSJI7slACIcDf8L4bbSVrbyfV0aiBvnX2LdHyCCJTYKFkCdnRasjUqURdNmu7cG
	Dz2AF0AyRygf8xK7SnI37yQkPjUT6PXFPCGkSEpBugM6lF/CuBdlAQDOaaL4/wz+6W0j6JNO1js
	iScbEGXPzoGA0qRcdxm7F4MouFqr9CSAsY/yNEfokGaBT1P6AnY1QGaGn/RGoYA5ABm6zVnMP4F
	nqPul7sO1WobnA7v0Yd3JfdG+X0cakje0EIpI3d1jgLFuYuCI3ffPtMbJ7Jtd2TG8IvzBBzjytq
	kn/Z5FM8nClVRPOn5yyeU2XFTC8OwYwFwmxJY0f3dmUXkOlWKOWrGhNsdR/0mq9MqEXNE4NXa/1
	ZJcgm3v2hb2PRv/whzuRnFChys8x
X-Received: by 2002:a05:690c:81:b0:86c:c7a8:2ebd with SMTP id 00721157ae682-8973878af64mr30138427b3.34.1789776980847;
        Fri, 18 Sep 2026 17:16:20 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:f1ff:bb02:6c7c:6979])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672990ab5desm642471d50.8.2026.09.18.17.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:16:19 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 1/3] hfsplus: add Unicode combining-class and legacy decomposition data
Date: Fri, 18 Sep 2026 17:16:05 -0700
Message-ID: <20260919001607.2777138-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919001607.2777138-1-slava@dubeyko.com>
References: <20260919001607.2777138-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

macOS's own fsck_hfs rejects a catalog name as "Illegal name" in two
cases this driver's decomposition tables don't currently account for:

 - a decomposed name whose combining marks aren't in Unicode canonical
   combining-class order (fsck_hfs's FixDecomps(), CatalogCheck.c);
 - a small, fixed set of characters whose canonical decomposition either
   wasn't yet defined, or was later corrected, since the driver's
   existing hfsplus_decompose_table (Apple Technote #1150) predates
   those corrections, which macOS has applied since Mac OS X 10.2
   ("Jaguar", 2002).

This is purely a data patch and adds no new behavior on its own:

 - hfsplus_ccc_table: canonical combining class per BMP code point,
   generated from the Unicode Character Database version 12.1.0
   (https://www.unicode.org/Public/12.1.0/ucd/extracted/
   DerivedCombiningClass.txt), the same UCD version fs/unicode's
   README.utf8data documents.

 - hfsplus_legacy_decomp_table and hfsplus_legacy_seq_fixups: the
   corrected decompositions and sequence replacements fsck_hfs itself
   requires, decoded from hfsprogs 540.1's
   fsck_hfs.tproj/dfalib/DecompData.h (upstream: Apple's diskdev_cmds,
   https://opensource.apple.com/source/diskdev_cmds/).

The three new struct types and the extern declarations for all of
tables.c's tables (existing and new) move into a new fs/hfsplus/
unicode.h, replacing the ad hoc externs that used to live in
hfsplus_fs.h.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/hfsplus_fs.h   |   6 +-
 fs/hfsplus/tables.c       | 397 ++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/unicode.c      |   1 +
 fs/hfsplus/unicode.h      |  59 ++++++
 fs/hfsplus/unicode_test.c |   1 +
 5 files changed, 459 insertions(+), 5 deletions(-)
 create mode 100644 fs/hfsplus/unicode.h

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 1e5b58e6a13f..916e6552e3f0 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -17,6 +17,7 @@
 #include <linux/blkdev.h>
 #include <linux/fs_context.h>
 #include "hfsplus_raw.h"
+#include "unicode.h"
 
 /* Runtime config options */
 #define HFSPLUS_DEF_CR_TYPE    0x3F3F3F3F  /* '????' */
@@ -486,11 +487,6 @@ void hfsplus_mark_mdb_dirty(struct super_block *sb);
 void hfsplus_prepare_volume_header_for_commit(struct hfsplus_vh *vhdr);
 int hfsplus_commit_superblock(struct super_block *sb);
 
-/* tables.c */
-extern u16 hfsplus_case_fold_table[];
-extern u16 hfsplus_decompose_table[];
-extern u16 hfsplus_compose_table[];
-
 /* unicode.c */
 int hfsplus_strcasecmp(const struct hfsplus_unistr *s1,
 		       const struct hfsplus_unistr *s2);
diff --git a/fs/hfsplus/tables.c b/fs/hfsplus/tables.c
index a5fb8ee7d019..3bbdc83debb5 100644
--- a/fs/hfsplus/tables.c
+++ b/fs/hfsplus/tables.c
@@ -3244,3 +3244,400 @@ u16 hfsplus_compose_table[] = {
 	/* 0x0342 0x0314 0x03c9 0x0345 */
 	0x1fa7, 0x0000,
 };
+
+/*
+ * Unicode canonical combining class (ccc) table, restricted to the Basic
+ * Multilingual Plane: HFS+ names are stored as UTF-16 and this kernel's
+ * wchar_t (see MAX_WCHAR_T in include/linux/nls.h) tops out at U+FFFF, so
+ * no HFS+ catalog name can contain a code point above the BMP anyway.
+ *
+ * Generated from the Unicode Character Database, version 12.1.0
+ * (https://www.unicode.org/Public/12.1.0/ucd/extracted/DerivedCombiningClass.txt),
+ * the same UCD version fs/unicode/README.utf8data documents. Class 0
+ * ("Not_Reordered") is the default for every code point not listed here
+ * and needs no entry.
+ *
+ * Used by hfsplus_canonical_reorder() to apply the Unicode Canonical
+ * Ordering Algorithm to a decomposed name, matching what macOS's own
+ * fsck_hfs (FixDecomps()) requires of a stored catalog name.
+ */
+struct hfsplus_ccc_range hfsplus_ccc_table[] = {
+	{ 0x0300, 0x0314, 230 },
+	{ 0x0315, 0x0315, 232 },
+	{ 0x0316, 0x0319, 220 },
+	{ 0x031a, 0x031a, 232 },
+	{ 0x031b, 0x031b, 216 },
+	{ 0x031c, 0x0320, 220 },
+	{ 0x0321, 0x0322, 202 },
+	{ 0x0323, 0x0326, 220 },
+	{ 0x0327, 0x0328, 202 },
+	{ 0x0329, 0x0333, 220 },
+	{ 0x0334, 0x0338,   1 },
+	{ 0x0339, 0x033c, 220 },
+	{ 0x033d, 0x0344, 230 },
+	{ 0x0345, 0x0345, 240 },
+	{ 0x0346, 0x0346, 230 },
+	{ 0x0347, 0x0349, 220 },
+	{ 0x034a, 0x034c, 230 },
+	{ 0x034d, 0x034e, 220 },
+	{ 0x0350, 0x0352, 230 },
+	{ 0x0353, 0x0356, 220 },
+	{ 0x0357, 0x0357, 230 },
+	{ 0x0358, 0x0358, 232 },
+	{ 0x0359, 0x035a, 220 },
+	{ 0x035b, 0x035b, 230 },
+	{ 0x035c, 0x035c, 233 },
+	{ 0x035d, 0x035e, 234 },
+	{ 0x035f, 0x035f, 233 },
+	{ 0x0360, 0x0361, 234 },
+	{ 0x0362, 0x0362, 233 },
+	{ 0x0363, 0x036f, 230 },
+	{ 0x0483, 0x0487, 230 },
+	{ 0x0591, 0x0591, 220 },
+	{ 0x0592, 0x0595, 230 },
+	{ 0x0596, 0x0596, 220 },
+	{ 0x0597, 0x0599, 230 },
+	{ 0x059a, 0x059a, 222 },
+	{ 0x059b, 0x059b, 220 },
+	{ 0x059c, 0x05a1, 230 },
+	{ 0x05a2, 0x05a7, 220 },
+	{ 0x05a8, 0x05a9, 230 },
+	{ 0x05aa, 0x05aa, 220 },
+	{ 0x05ab, 0x05ac, 230 },
+	{ 0x05ad, 0x05ad, 222 },
+	{ 0x05ae, 0x05ae, 228 },
+	{ 0x05af, 0x05af, 230 },
+	{ 0x05b0, 0x05b0,  10 },
+	{ 0x05b1, 0x05b1,  11 },
+	{ 0x05b2, 0x05b2,  12 },
+	{ 0x05b3, 0x05b3,  13 },
+	{ 0x05b4, 0x05b4,  14 },
+	{ 0x05b5, 0x05b5,  15 },
+	{ 0x05b6, 0x05b6,  16 },
+	{ 0x05b7, 0x05b7,  17 },
+	{ 0x05b8, 0x05b8,  18 },
+	{ 0x05b9, 0x05ba,  19 },
+	{ 0x05bb, 0x05bb,  20 },
+	{ 0x05bc, 0x05bc,  21 },
+	{ 0x05bd, 0x05bd,  22 },
+	{ 0x05bf, 0x05bf,  23 },
+	{ 0x05c1, 0x05c1,  24 },
+	{ 0x05c2, 0x05c2,  25 },
+	{ 0x05c4, 0x05c4, 230 },
+	{ 0x05c5, 0x05c5, 220 },
+	{ 0x05c7, 0x05c7,  18 },
+	{ 0x0610, 0x0617, 230 },
+	{ 0x0618, 0x0618,  30 },
+	{ 0x0619, 0x0619,  31 },
+	{ 0x061a, 0x061a,  32 },
+	{ 0x064b, 0x064b,  27 },
+	{ 0x064c, 0x064c,  28 },
+	{ 0x064d, 0x064d,  29 },
+	{ 0x064e, 0x064e,  30 },
+	{ 0x064f, 0x064f,  31 },
+	{ 0x0650, 0x0650,  32 },
+	{ 0x0651, 0x0651,  33 },
+	{ 0x0652, 0x0652,  34 },
+	{ 0x0653, 0x0654, 230 },
+	{ 0x0655, 0x0656, 220 },
+	{ 0x0657, 0x065b, 230 },
+	{ 0x065c, 0x065c, 220 },
+	{ 0x065d, 0x065e, 230 },
+	{ 0x065f, 0x065f, 220 },
+	{ 0x0670, 0x0670,  35 },
+	{ 0x06d6, 0x06dc, 230 },
+	{ 0x06df, 0x06e2, 230 },
+	{ 0x06e3, 0x06e3, 220 },
+	{ 0x06e4, 0x06e4, 230 },
+	{ 0x06e7, 0x06e8, 230 },
+	{ 0x06ea, 0x06ea, 220 },
+	{ 0x06eb, 0x06ec, 230 },
+	{ 0x06ed, 0x06ed, 220 },
+	{ 0x0711, 0x0711,  36 },
+	{ 0x0730, 0x0730, 230 },
+	{ 0x0731, 0x0731, 220 },
+	{ 0x0732, 0x0733, 230 },
+	{ 0x0734, 0x0734, 220 },
+	{ 0x0735, 0x0736, 230 },
+	{ 0x0737, 0x0739, 220 },
+	{ 0x073a, 0x073a, 230 },
+	{ 0x073b, 0x073c, 220 },
+	{ 0x073d, 0x073d, 230 },
+	{ 0x073e, 0x073e, 220 },
+	{ 0x073f, 0x0741, 230 },
+	{ 0x0742, 0x0742, 220 },
+	{ 0x0743, 0x0743, 230 },
+	{ 0x0744, 0x0744, 220 },
+	{ 0x0745, 0x0745, 230 },
+	{ 0x0746, 0x0746, 220 },
+	{ 0x0747, 0x0747, 230 },
+	{ 0x0748, 0x0748, 220 },
+	{ 0x0749, 0x074a, 230 },
+	{ 0x07eb, 0x07f1, 230 },
+	{ 0x07f2, 0x07f2, 220 },
+	{ 0x07f3, 0x07f3, 230 },
+	{ 0x07fd, 0x07fd, 220 },
+	{ 0x0816, 0x0819, 230 },
+	{ 0x081b, 0x0823, 230 },
+	{ 0x0825, 0x0827, 230 },
+	{ 0x0829, 0x082d, 230 },
+	{ 0x0859, 0x085b, 220 },
+	{ 0x08d3, 0x08d3, 220 },
+	{ 0x08d4, 0x08e1, 230 },
+	{ 0x08e3, 0x08e3, 220 },
+	{ 0x08e4, 0x08e5, 230 },
+	{ 0x08e6, 0x08e6, 220 },
+	{ 0x08e7, 0x08e8, 230 },
+	{ 0x08e9, 0x08e9, 220 },
+	{ 0x08ea, 0x08ec, 230 },
+	{ 0x08ed, 0x08ef, 220 },
+	{ 0x08f0, 0x08f0,  27 },
+	{ 0x08f1, 0x08f1,  28 },
+	{ 0x08f2, 0x08f2,  29 },
+	{ 0x08f3, 0x08f5, 230 },
+	{ 0x08f6, 0x08f6, 220 },
+	{ 0x08f7, 0x08f8, 230 },
+	{ 0x08f9, 0x08fa, 220 },
+	{ 0x08fb, 0x08ff, 230 },
+	{ 0x093c, 0x093c,   7 },
+	{ 0x094d, 0x094d,   9 },
+	{ 0x0951, 0x0951, 230 },
+	{ 0x0952, 0x0952, 220 },
+	{ 0x0953, 0x0954, 230 },
+	{ 0x09bc, 0x09bc,   7 },
+	{ 0x09cd, 0x09cd,   9 },
+	{ 0x09fe, 0x09fe, 230 },
+	{ 0x0a3c, 0x0a3c,   7 },
+	{ 0x0a4d, 0x0a4d,   9 },
+	{ 0x0abc, 0x0abc,   7 },
+	{ 0x0acd, 0x0acd,   9 },
+	{ 0x0b3c, 0x0b3c,   7 },
+	{ 0x0b4d, 0x0b4d,   9 },
+	{ 0x0bcd, 0x0bcd,   9 },
+	{ 0x0c4d, 0x0c4d,   9 },
+	{ 0x0c55, 0x0c55,  84 },
+	{ 0x0c56, 0x0c56,  91 },
+	{ 0x0cbc, 0x0cbc,   7 },
+	{ 0x0ccd, 0x0ccd,   9 },
+	{ 0x0d3b, 0x0d3c,   9 },
+	{ 0x0d4d, 0x0d4d,   9 },
+	{ 0x0dca, 0x0dca,   9 },
+	{ 0x0e38, 0x0e39, 103 },
+	{ 0x0e3a, 0x0e3a,   9 },
+	{ 0x0e48, 0x0e4b, 107 },
+	{ 0x0eb8, 0x0eb9, 118 },
+	{ 0x0eba, 0x0eba,   9 },
+	{ 0x0ec8, 0x0ecb, 122 },
+	{ 0x0f18, 0x0f19, 220 },
+	{ 0x0f35, 0x0f35, 220 },
+	{ 0x0f37, 0x0f37, 220 },
+	{ 0x0f39, 0x0f39, 216 },
+	{ 0x0f71, 0x0f71, 129 },
+	{ 0x0f72, 0x0f72, 130 },
+	{ 0x0f74, 0x0f74, 132 },
+	{ 0x0f7a, 0x0f7d, 130 },
+	{ 0x0f80, 0x0f80, 130 },
+	{ 0x0f82, 0x0f83, 230 },
+	{ 0x0f84, 0x0f84,   9 },
+	{ 0x0f86, 0x0f87, 230 },
+	{ 0x0fc6, 0x0fc6, 220 },
+	{ 0x1037, 0x1037,   7 },
+	{ 0x1039, 0x103a,   9 },
+	{ 0x108d, 0x108d, 220 },
+	{ 0x135d, 0x135f, 230 },
+	{ 0x1714, 0x1714,   9 },
+	{ 0x1734, 0x1734,   9 },
+	{ 0x17d2, 0x17d2,   9 },
+	{ 0x17dd, 0x17dd, 230 },
+	{ 0x18a9, 0x18a9, 228 },
+	{ 0x1939, 0x1939, 222 },
+	{ 0x193a, 0x193a, 230 },
+	{ 0x193b, 0x193b, 220 },
+	{ 0x1a17, 0x1a17, 230 },
+	{ 0x1a18, 0x1a18, 220 },
+	{ 0x1a60, 0x1a60,   9 },
+	{ 0x1a75, 0x1a7c, 230 },
+	{ 0x1a7f, 0x1a7f, 220 },
+	{ 0x1ab0, 0x1ab4, 230 },
+	{ 0x1ab5, 0x1aba, 220 },
+	{ 0x1abb, 0x1abc, 230 },
+	{ 0x1abd, 0x1abd, 220 },
+	{ 0x1b34, 0x1b34,   7 },
+	{ 0x1b44, 0x1b44,   9 },
+	{ 0x1b6b, 0x1b6b, 230 },
+	{ 0x1b6c, 0x1b6c, 220 },
+	{ 0x1b6d, 0x1b73, 230 },
+	{ 0x1baa, 0x1baa,   9 },
+	{ 0x1bab, 0x1bab,   9 },
+	{ 0x1be6, 0x1be6,   7 },
+	{ 0x1bf2, 0x1bf3,   9 },
+	{ 0x1c37, 0x1c37,   7 },
+	{ 0x1cd0, 0x1cd2, 230 },
+	{ 0x1cd4, 0x1cd4,   1 },
+	{ 0x1cd5, 0x1cd9, 220 },
+	{ 0x1cda, 0x1cdb, 230 },
+	{ 0x1cdc, 0x1cdf, 220 },
+	{ 0x1ce0, 0x1ce0, 230 },
+	{ 0x1ce2, 0x1ce8,   1 },
+	{ 0x1ced, 0x1ced, 220 },
+	{ 0x1cf4, 0x1cf4, 230 },
+	{ 0x1cf8, 0x1cf9, 230 },
+	{ 0x1dc0, 0x1dc1, 230 },
+	{ 0x1dc2, 0x1dc2, 220 },
+	{ 0x1dc3, 0x1dc9, 230 },
+	{ 0x1dca, 0x1dca, 220 },
+	{ 0x1dcb, 0x1dcc, 230 },
+	{ 0x1dcd, 0x1dcd, 234 },
+	{ 0x1dce, 0x1dce, 214 },
+	{ 0x1dcf, 0x1dcf, 220 },
+	{ 0x1dd0, 0x1dd0, 202 },
+	{ 0x1dd1, 0x1df5, 230 },
+	{ 0x1df6, 0x1df6, 232 },
+	{ 0x1df7, 0x1df8, 228 },
+	{ 0x1df9, 0x1df9, 220 },
+	{ 0x1dfb, 0x1dfb, 230 },
+	{ 0x1dfc, 0x1dfc, 233 },
+	{ 0x1dfd, 0x1dfd, 220 },
+	{ 0x1dfe, 0x1dfe, 230 },
+	{ 0x1dff, 0x1dff, 220 },
+	{ 0x20d0, 0x20d1, 230 },
+	{ 0x20d2, 0x20d3,   1 },
+	{ 0x20d4, 0x20d7, 230 },
+	{ 0x20d8, 0x20da,   1 },
+	{ 0x20db, 0x20dc, 230 },
+	{ 0x20e1, 0x20e1, 230 },
+	{ 0x20e5, 0x20e6,   1 },
+	{ 0x20e7, 0x20e7, 230 },
+	{ 0x20e8, 0x20e8, 220 },
+	{ 0x20e9, 0x20e9, 230 },
+	{ 0x20ea, 0x20eb,   1 },
+	{ 0x20ec, 0x20ef, 220 },
+	{ 0x20f0, 0x20f0, 230 },
+	{ 0x2cef, 0x2cf1, 230 },
+	{ 0x2d7f, 0x2d7f,   9 },
+	{ 0x2de0, 0x2dff, 230 },
+	{ 0x302a, 0x302a, 218 },
+	{ 0x302b, 0x302b, 228 },
+	{ 0x302c, 0x302c, 232 },
+	{ 0x302d, 0x302d, 222 },
+	{ 0x302e, 0x302f, 224 },
+	{ 0x3099, 0x309a,   8 },
+	{ 0xa66f, 0xa66f, 230 },
+	{ 0xa674, 0xa67d, 230 },
+	{ 0xa69e, 0xa69f, 230 },
+	{ 0xa6f0, 0xa6f1, 230 },
+	{ 0xa806, 0xa806,   9 },
+	{ 0xa8c4, 0xa8c4,   9 },
+	{ 0xa8e0, 0xa8f1, 230 },
+	{ 0xa92b, 0xa92d, 220 },
+	{ 0xa953, 0xa953,   9 },
+	{ 0xa9b3, 0xa9b3,   7 },
+	{ 0xa9c0, 0xa9c0,   9 },
+	{ 0xaab0, 0xaab0, 230 },
+	{ 0xaab2, 0xaab3, 230 },
+	{ 0xaab4, 0xaab4, 220 },
+	{ 0xaab7, 0xaab8, 230 },
+	{ 0xaabe, 0xaabf, 230 },
+	{ 0xaac1, 0xaac1, 230 },
+	{ 0xaaf6, 0xaaf6,   9 },
+	{ 0xabed, 0xabed,   9 },
+	{ 0xfb1e, 0xfb1e,  26 },
+	{ 0xfe20, 0xfe26, 230 },
+	{ 0xfe27, 0xfe2d, 220 },
+	{ 0xfe2e, 0xfe2f, 230 },
+};
+
+/*
+ * Some HFS Plus catalog names contain characters whose canonical
+ * decomposition either was not yet defined, or was later corrected, in
+ * the version of Unicode this file's tables above were generated from
+ * (Apple Technote #1150, itself derived from pre-Unicode-3.0/pre-"Jaguar"
+ * (Mac OS X 10.2) data). macOS's own fsck_hfs has carried a permanent
+ * "FixDecomps" fixup for exactly this since 2002 (see
+ * fsck_hfs.tproj/dfalib/CatalogCheck.c and DecompData.h in the hfsprogs /
+ * diskdev_cmds sources) and flags any catalog name it finds still using
+ * the old form as "Illegal name". The two tables and functions below are
+ * a port of that same fixup data, decoded from hfsprogs 540.1's
+ * DecompData.h, so this driver stores names the same way macOS has since
+ * 10.2 rather than the way the original HFS Plus format documentation
+ * described in 2001.
+ */
+
+/* Category A: single code point -> missing canonical decomposition */
+/* 44 entries */
+struct hfsplus_legacy_decomp hfsplus_legacy_decomp_table[] = {
+	{ 0x01f8, 2, { 0x004e, 0x0300 } },
+	{ 0x01f9, 2, { 0x006e, 0x0300 } },
+	{ 0x0218, 2, { 0x0053, 0x0326 } },
+	{ 0x0219, 2, { 0x0073, 0x0326 } },
+	{ 0x021a, 2, { 0x0054, 0x0326 } },
+	{ 0x021b, 2, { 0x0074, 0x0326 } },
+	{ 0x021e, 2, { 0x0048, 0x030c } },
+	{ 0x021f, 2, { 0x0068, 0x030c } },
+	{ 0x0226, 2, { 0x0041, 0x0307 } },
+	{ 0x0227, 2, { 0x0061, 0x0307 } },
+	{ 0x0228, 2, { 0x0045, 0x0327 } },
+	{ 0x0229, 2, { 0x0065, 0x0327 } },
+	{ 0x022a, 3, { 0x004f, 0x0308, 0x0304 } },
+	{ 0x022b, 3, { 0x006f, 0x0308, 0x0304 } },
+	{ 0x022c, 3, { 0x004f, 0x0303, 0x0304 } },
+	{ 0x022d, 3, { 0x006f, 0x0303, 0x0304 } },
+	{ 0x022e, 2, { 0x004f, 0x0307 } },
+	{ 0x022f, 2, { 0x006f, 0x0307 } },
+	{ 0x0230, 3, { 0x004f, 0x0307, 0x0304 } },
+	{ 0x0231, 3, { 0x006f, 0x0307, 0x0304 } },
+	{ 0x0232, 2, { 0x0059, 0x0304 } },
+	{ 0x0233, 2, { 0x0079, 0x0304 } },
+	{ 0x0400, 2, { 0x0415, 0x0300 } },
+	{ 0x040d, 2, { 0x0418, 0x0300 } },
+	{ 0x0450, 2, { 0x0435, 0x0300 } },
+	{ 0x045d, 2, { 0x0438, 0x0300 } },
+	{ 0x04ec, 2, { 0x042d, 0x0308 } },
+	{ 0x04ed, 2, { 0x044d, 0x0308 } },
+	{ 0x0622, 2, { 0x0627, 0x0653 } },
+	{ 0x0623, 2, { 0x0627, 0x0654 } },
+	{ 0x0624, 2, { 0x0648, 0x0654 } },
+	{ 0x0625, 2, { 0x0627, 0x0655 } },
+	{ 0x0626, 2, { 0x064a, 0x0654 } },
+	{ 0x06c0, 2, { 0x06d5, 0x0654 } },
+	{ 0x06c2, 2, { 0x06c1, 0x0654 } },
+	{ 0x06d3, 2, { 0x06d2, 0x0654 } },
+	{ 0x0a33, 2, { 0x0a32, 0x0a3c } },
+	{ 0x0a36, 2, { 0x0a38, 0x0a3c } },
+	{ 0x0dda, 2, { 0x0dd9, 0x0dca } },
+	{ 0x0ddc, 2, { 0x0dd9, 0x0dcf } },
+	{ 0x0ddd, 3, { 0x0dd9, 0x0dcf, 0x0dca } },
+	{ 0x0dde, 2, { 0x0dd9, 0x0ddf } },
+	{ 0x1026, 2, { 0x1025, 0x102e } },
+	{ 0xfb1d, 2, { 0x05d9, 0x05b4 } },
+};
+
+/* Category B: 2-3 code point sequence -> corrected replacement */
+/* 25 entries */
+struct hfsplus_legacy_seq_fixup hfsplus_legacy_seq_fixups[] = {
+	{ 2, { 0x00a8, 0x030d }, 2, { 0x00a8, 0x0301 } },
+	{ 2, { 0x0306, 0x0307 }, 1, { 0x0310 } },
+	{ 2, { 0x0308, 0x030d }, 2, { 0x0308, 0x0301 } },
+	{ 2, { 0x0391, 0x030d }, 2, { 0x0391, 0x0301 } },
+	{ 2, { 0x0395, 0x030d }, 2, { 0x0395, 0x0301 } },
+	{ 2, { 0x0397, 0x030d }, 2, { 0x0397, 0x0301 } },
+	{ 2, { 0x0399, 0x030d }, 2, { 0x0399, 0x0301 } },
+	{ 2, { 0x039f, 0x030d }, 2, { 0x039f, 0x0301 } },
+	{ 2, { 0x03a5, 0x030d }, 2, { 0x03a5, 0x0301 } },
+	{ 2, { 0x03a9, 0x030d }, 2, { 0x03a9, 0x0301 } },
+	{ 2, { 0x03b1, 0x030d }, 2, { 0x03b1, 0x0301 } },
+	{ 2, { 0x03b5, 0x030d }, 2, { 0x03b5, 0x0301 } },
+	{ 2, { 0x03b7, 0x030d }, 2, { 0x03b7, 0x0301 } },
+	{ 2, { 0x03b9, 0x030d }, 2, { 0x03b9, 0x0301 } },
+	{ 2, { 0x03bf, 0x030d }, 2, { 0x03bf, 0x0301 } },
+	{ 2, { 0x03c5, 0x030d }, 2, { 0x03c5, 0x0301 } },
+	{ 2, { 0x03c9, 0x030d }, 2, { 0x03c9, 0x0301 } },
+	{ 2, { 0x03d2, 0x030d }, 2, { 0x03d2, 0x0301 } },
+	{ 2, { 0x09ac, 0x09bc }, 1, { 0x09b0 } },
+	{ 2, { 0x0a21, 0x0a3c }, 1, { 0x0a5c } },
+	{ 2, { 0x0b2f, 0x0b3c }, 1, { 0x0b5f } },
+	{ 2, { 0x0e4d, 0x0e32 }, 1, { 0x0e33 } },
+	{ 2, { 0x0ecd, 0x0eb2 }, 1, { 0x0eb3 } },
+	{ 3, { 0x0fb2, 0x0f80, 0x0f71 }, 1, { 0x0f77 } },
+	{ 3, { 0x0fb3, 0x0f80, 0x0f71 }, 1, { 0x0f79 } },
+};
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 008fec186382..93d39481e477 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -16,6 +16,7 @@
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
+#include "unicode.h"
 
 /* Fold the case of a unicode char, given the 16 bit value */
 /* Returns folded char, or 0 if ignorable */
diff --git a/fs/hfsplus/unicode.h b/fs/hfsplus/unicode.h
new file mode 100644
index 000000000000..3957ebccc232
--- /dev/null
+++ b/fs/hfsplus/unicode.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Unicode related declarations
+ */
+
+#ifndef _LINUX_HFSPLUS_UNICODE_H
+#define _LINUX_HFSPLUS_UNICODE_H
+
+/*
+ * struct hfsplus_ccc_range - one run of consecutive BMP code points that
+ *                            share the same Unicode canonical combining class
+ * @first: the first UTF-16 code point in the run
+ * @last: the last code point in the run (inclusive)
+ * @combining_class: canonical combining class (ccc) shared by @first..@last
+ */
+struct hfsplus_ccc_range {
+	u16 first;
+	u16 last;
+	u8 combining_class;
+};
+
+/*
+ * struct hfsplus_legacy_decomp - corrected canonical decomposition
+ * @uc: the code point (a UTF-16 code unit) to look up
+ * @len: number of valid code units in @repl
+ * @repl: corrected decomposition sequence (base letter + combining marks)
+ */
+struct hfsplus_legacy_decomp {
+	u16 uc;
+	u8 len;
+#define HFSPLUS_LEGACY_DECOMP_MAX_LEN	(3)
+	u16 repl[HFSPLUS_LEGACY_DECOMP_MAX_LEN];
+};
+
+/*
+ * struct hfsplus_legacy_seq_fixup - corrected replacement for a short
+ *                                   sequence of already-decomposed code units
+ * @match_len: number of valid code units in @match
+ * @match: decomposed sequence to look for in the buffer
+ * @repl_len: number of valid code units in @repl
+ * @repl: corrected sequence to substitute in place of @match
+ */
+struct hfsplus_legacy_seq_fixup {
+	u8 match_len;
+#define HFSPLUS_LEGACY_SEQ_MAX_MATCH	(3)
+	u16 match[HFSPLUS_LEGACY_SEQ_MAX_MATCH];
+	u8 repl_len;
+#define HFSPLUS_LEGACY_SEQ_MAX_REPL	(2)
+	u16 repl[HFSPLUS_LEGACY_SEQ_MAX_REPL];
+};
+
+extern u16 hfsplus_case_fold_table[];
+extern u16 hfsplus_decompose_table[];
+extern u16 hfsplus_compose_table[];
+extern struct hfsplus_ccc_range hfsplus_ccc_table[];
+extern struct hfsplus_legacy_decomp hfsplus_legacy_decomp_table[];
+extern struct hfsplus_legacy_seq_fixup hfsplus_legacy_seq_fixups[];
+
+#endif /* _LINUX_HFSPLUS_UNICODE_H */
diff --git a/fs/hfsplus/unicode_test.c b/fs/hfsplus/unicode_test.c
index 7f6b2a3c69d9..32a64029d77b 100644
--- a/fs/hfsplus/unicode_test.c
+++ b/fs/hfsplus/unicode_test.c
@@ -10,6 +10,7 @@
 #include <linux/dcache.h>
 #include <linux/stringhash.h>
 #include "hfsplus_fs.h"
+#include "unicode.h"
 
 struct test_mock_string_env {
 	struct hfsplus_unistr str1;
-- 
2.43.0

