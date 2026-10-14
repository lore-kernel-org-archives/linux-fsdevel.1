Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB630DECB
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791938279; cv=none; b=AmmRyEkRZvsgb3kEx6BAGEUHlo6dIl3sCw5AMSMPLN2ur9kuNoDZX2fziZMGVTboq4kimYHqzs+nStOIaXrIfGNkzcMYV/4+RGhCEQWs/DP+GN3IyFwnp9k8kZB4oDAnjZMLvcDTgUevGrIYcEGv4EfxK9UVte5iv6pBMYNspk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791938279; c=relaxed/simple;
	bh=9C4MQrSXkQHizBdJu9v9VLpw6lG/Hk33vFwdnkGVp6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVpG/9/EkESp/6d9pQGMfKVlRItlGYRyhW9XlkiLvCfeyl4HKxItzOtjworVjADa9bPEQ95ppFimg2k31akpg2aYxNqHfutpImwgliXOTYGVkaGq3GScG3x4P4FBwa3HbFM2YKSYNu0LZjO+oM1sYQ83kaoKSLqS4yg18Jmofxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=v8aTiysP; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="v8aTiysP"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67699afea08so2681660d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 17:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791938277; x=1792543077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImXh9POr/GNJfHt9uKWlPLztX9BMfwED4KT+uloYyoA=;
        b=v8aTiysPfihJoz1vkV+16jsZbvmnXFIxtFzsRGlhPTnOgEMd9YuDrnKEreUCrOdGTX
         YkEUWjAP0t7zhUrq7iK2Gxt2HL4qUN6uR1Ufx4FPXu2yxJsq5i/vXTwjsEo0mKvQjGYj
         dnMQThF5ctyJonPq8FdCl8HmY7nezeRcOCYEXLROFeehnaAEvEFo0S8IKbiGmupbuWNv
         OjUbPBU3BIpeAYUg24i8ON6joM6rypp3JwGQWwBt3ahyH69dysMLlxxSZhoz8KCFBnmh
         uN/KuKznuWgvXiK57ejrzXiEMO+wQ9257TQGRqDiQ7Qg1DpwxWqLe48y6JN0srfwC4u5
         JArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791938277; x=1792543077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ImXh9POr/GNJfHt9uKWlPLztX9BMfwED4KT+uloYyoA=;
        b=sXi+wPTOCY2TSqr2t409RvwfbAof+HwVhiFORfTperIKeixfSETXhH+5qtW6JsEp+T
         kkCpfIOTp//WAI59oHWdorFF/cnOtOwyEzWZbeOrxW3cLnXVxkv+xTM6IRhETDXzjwRa
         Z0L636FolWyDzt8DKVPx7xCPBydfhviOzkgFoIGjmqSomIg0uCIo4SzIQAuho0dbNEiS
         frvPA42pCiR5cUVdydY1/5ZkQ1teho0vEAsDriDH8Dqa9wKm6nAxggpztFC4Ff41Veq6
         Wqcv6MQ51bXVACxjkMnrm1iWbVgtbqsvmgk3i6sbep3mfX3a7BJkGpU0dEoo3cK5B3JC
         vqBw==
X-Gm-Message-State: AFq9FYLpqxDfMkjQhRxC75yChnWzfvF88bLy9HGD/ri/hnSmxuP1LMJ6
	pozM14fs/Ohl6XOiw1hC/WxGtuJxRelMIy8hVHX5lUwfAWb02/O7Fjb5aLswFMEcpzA=
X-Gm-Gg: AYBFou2P1T5X1Tn293vsxaOEsS1yqanc9s6iMnIzQ6lMoosKXaC72HP3be2hJSkFCqs
	nONVVKBC2LyHYtvEGI1sEVyNRciCRpaCdnPGdkPLFENLFKGKUTDxlT2IgcpvDQuQb9/K+GepVdx
	eZI9X1qso90BmtyoMyRjvLpfHrwKw1Q9gWpnn/e8jzrVOU4NZH2HyfQcKxpXD3+l5ld8d3V35Zz
	NHsyKb5vEJ4xsZeccDEqi11YoWuZiawZoFL0gIPgj175v1T0V19soD0sw5voF+5M06/DKsFKJQ0
	EvJ3DF85qXkyljYt+X5hEu4DvAh8SEGFg1/r65PlprIgh/2KAEa1luErDAvSVlUhkssJoRaofFX
	tzrimPxJVn5kcWlje9gIu5GPM2PadVRO8M/BIWRfMpXmoL4t1KS5RYvKnL49Mj5XFB8o8dTB7pc
	9aHHRLcaLcgF5ozCIZ4PFH1oojfGw1q83GrFN8gMEHVIgXqQq2lTYSYR+JV1Wy6i3digwn8PTdL
	UhajYsY4GDmIYiCRVsadAVSofsN9qiWaeikkwf+9mlZS/C1hiPPDPEIZz+L7o2t1hbqSteBfeMj
	HPp7izT1u20FsJty6kIfX5umYaBxDIiBEYnPduY=
X-Received: by 2002:a05:690e:1918:b0:674:1e29:81eb with SMTP id 956f58d0204a3-67976eec642mr1428101d50.58.1791938276642;
        Tue, 13 Oct 2026 17:37:56 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:98d3:ec2f:c938:3bc1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a15c13sm463194d50.7.2026.10.13.17.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 17:37:56 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3 3/3] hfsplus: add KUnit tests for date/time conversion
Date: Tue, 13 Oct 2026 17:37:31 -0700
Message-ID: <20261014003731.369728-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014003731.369728-1-slava@dubeyko.com>
References: <20261014003731.369728-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the hfsplus_time KUnit test suite that checks
the date/time conversion logic and the extended timestamp support:

(1) hfsplus_time_constants_test: the supported time range
    and HFSPLUS_EXT_TIMESTAMP_MARK value;
(2) hfsplus_mt2ut_test, hfsplus_ut2mt_test: conversion of
    the known dates (1904, 1970, 2000, 2026, 2038, 2040);
(3) hfsplus_ut2mt_before_1970_test: timestamps before
    January 1, 1970 (xfstests generic/258 issue);
(4) hfsplus_ut2mt_clamp_test: out-of-range timestamps are
    clamped instead of wrapped;
(5) hfsplus_time_roundtrip_test: representable timestamps
    survive the round trip;
(6) hfsplus_ut_needs_xattr_test, hfsplus_mt_is_ext_timestamp_test:
    the decision to keep the timestamp in xattr;
(7) hfsplus_read_timestamp_regular_test,
    hfsplus_read_timestamp_mark_no_xattr_test: reading of
    the regular on-disk timestamp and HFSPLUS_EXT_TIMESTAMP_MARK
    without xattr;
(8) hfsplus_timestamp_xattr_names_test: names of internal
    xattrs fit the name buffer.

The hfsplus_read_timestamp() is exported by means of
EXPORT_SYMBOL_IF_KUNIT().

./tools/testing/kunit/kunit.py run --kunitconfig=fs/hfsplus/.kunitconfig

[PASSED] hfsplus_time_constants_test
[PASSED] hfsplus_mt2ut_test
[PASSED] hfsplus_ut2mt_test
[PASSED] hfsplus_ut2mt_before_1970_test
[PASSED] hfsplus_ut2mt_clamp_test
[PASSED] hfsplus_time_roundtrip_test
[PASSED] hfsplus_ut_needs_xattr_test
[PASSED] hfsplus_mt_is_ext_timestamp_test
[PASSED] hfsplus_read_timestamp_regular_test
[PASSED] hfsplus_read_timestamp_mark_no_xattr_test
[PASSED] hfsplus_timestamp_xattr_names_test
================== [PASSED] hfsplus_time ===================

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
v3
File time_test.c has been renamed into hfsplus_time_test.c
and file unicode_test.c has been renamed into hfsplus_unicode_test.c
with the goal to exclude modules name conflict.
---
 fs/hfsplus/Makefile                           |   2 +-
 fs/hfsplus/hfsplus_time_test.c                | 354 ++++++++++++++++++
 ...{unicode_test.c => hfsplus_unicode_test.c} |   0
 fs/hfsplus/inode.c                            |   2 +
 4 files changed, 357 insertions(+), 1 deletion(-)
 create mode 100644 fs/hfsplus/hfsplus_time_test.c
 rename fs/hfsplus/{unicode_test.c => hfsplus_unicode_test.c} (100%)

diff --git a/fs/hfsplus/Makefile b/fs/hfsplus/Makefile
index f2a9ae697e81..7cb0a5ef9831 100644
--- a/fs/hfsplus/Makefile
+++ b/fs/hfsplus/Makefile
@@ -10,4 +10,4 @@ hfsplus-objs := super.o options.o inode.o ioctl.o extents.o catalog.o dir.o btre
 		attributes.o xattr.o xattr_user.o xattr_security.o xattr_trusted.o
 
 # KUnit tests
-obj-$(CONFIG_HFSPLUS_KUNIT_TEST) += unicode_test.o
+obj-$(CONFIG_HFSPLUS_KUNIT_TEST) += hfsplus_unicode_test.o hfsplus_time_test.o
diff --git a/fs/hfsplus/hfsplus_time_test.c b/fs/hfsplus/hfsplus_time_test.c
new file mode 100644
index 000000000000..4b3312dc0048
--- /dev/null
+++ b/fs/hfsplus/hfsplus_time_test.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for HFS+ date/time conversion
+ *
+ * Copyright (C) 2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <kunit/test.h>
+#include "hfsplus_fs.h"
+#include "xattr.h"
+
+/* January 1, 1970, 00:00:00 UTC */
+#define TEST_UNIX_EPOCH_SECS		0LL
+/* December 31, 1969, 23:59:59 UTC */
+#define TEST_BEFORE_UNIX_EPOCH_SECS	-1LL
+/* January 1, 2000, 00:00:00 UTC */
+#define TEST_Y2000_SECS			946684800LL
+/* January 19, 2038, 03:14:08 UTC (signed 32-bit overflow) */
+#define TEST_Y2038_SECS			2147483648LL
+/* January 1, 2026, 00:00:00 UTC */
+#define TEST_Y2026_SECS			1767225600LL
+/* January 1, 2100, 00:00:00 UTC */
+#define TEST_Y2100_SECS			4102444800LL
+/* January 1, 1900, 00:00:00 UTC */
+#define TEST_Y1900_SECS			-2208988800LL
+
+static u32 mt_raw(__be32 mt)
+{
+	return be32_to_cpu(mt);
+}
+
+/* Test the time range constants */
+static void hfsplus_time_constants_test(struct kunit *test)
+{
+	/* 32-bit unsigned on-disk field covers exactly U32_MAX seconds */
+	KUNIT_EXPECT_EQ(test, (s64)U32_MAX,
+			HFS_MAX_TIMESTAMP_SECS - HFS_MIN_TIMESTAMP_SECS);
+	KUNIT_EXPECT_EQ(test, -(s64)HFS_UTC_OFFSET, HFS_MIN_TIMESTAMP_SECS);
+
+	/* xattrs extend the supported range beyond February 2040 */
+	KUNIT_EXPECT_GT(test, (s64)HFSPLUS_MAX_TIMESTAMP_SECS,
+			(s64)HFS_MAX_TIMESTAMP_SECS);
+
+	/* the extended timestamp mark is the maximal on-disk value */
+	KUNIT_EXPECT_EQ(test, U32_MAX, mt_raw(HFSPLUS_EXT_TIMESTAMP_MARK));
+}
+
+/* Test conversion of on-disk (1904-based) timestamp into 1970-based one */
+static void hfsplus_mt2ut_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, HFS_MIN_TIMESTAMP_SECS,
+			__hfsp_mt2ut(cpu_to_be32(0)));
+	KUNIT_EXPECT_EQ(test, TEST_UNIX_EPOCH_SECS,
+			__hfsp_mt2ut(cpu_to_be32(HFS_UTC_OFFSET)));
+	KUNIT_EXPECT_EQ(test, TEST_BEFORE_UNIX_EPOCH_SECS,
+			__hfsp_mt2ut(cpu_to_be32(HFS_UTC_OFFSET - 1)));
+	KUNIT_EXPECT_EQ(test, TEST_Y2000_SECS,
+			__hfsp_mt2ut(cpu_to_be32(3029529600U)));
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_SECS,
+			__hfsp_mt2ut(cpu_to_be32(3850070400U)));
+	KUNIT_EXPECT_EQ(test, TEST_Y2038_SECS,
+			__hfsp_mt2ut(cpu_to_be32(4230328448U)));
+	KUNIT_EXPECT_EQ(test, HFS_MAX_TIMESTAMP_SECS,
+			__hfsp_mt2ut(cpu_to_be32(U32_MAX)));
+	KUNIT_EXPECT_EQ(test, HFS_MAX_TIMESTAMP_SECS,
+			__hfsp_mt2ut(HFSPLUS_EXT_TIMESTAMP_MARK));
+}
+
+/* Test conversion of 1970-based timestamp into on-disk (1904-based) one */
+static void hfsplus_ut2mt_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 0U,
+			mt_raw(__hfsp_ut2mt(HFS_MIN_TIMESTAMP_SECS)));
+	KUNIT_EXPECT_EQ(test, HFS_UTC_OFFSET,
+			mt_raw(__hfsp_ut2mt(TEST_UNIX_EPOCH_SECS)));
+	KUNIT_EXPECT_EQ(test, 3029529600U,
+			mt_raw(__hfsp_ut2mt(TEST_Y2000_SECS)));
+	KUNIT_EXPECT_EQ(test, 3850070400U,
+			mt_raw(__hfsp_ut2mt(TEST_Y2026_SECS)));
+	KUNIT_EXPECT_EQ(test, 4230328448U,
+			mt_raw(__hfsp_ut2mt(TEST_Y2038_SECS)));
+	KUNIT_EXPECT_EQ(test, U32_MAX - 1,
+			mt_raw(__hfsp_ut2mt(HFS_MAX_TIMESTAMP_SECS - 1)));
+	KUNIT_EXPECT_EQ(test, U32_MAX,
+			mt_raw(__hfsp_ut2mt(HFS_MAX_TIMESTAMP_SECS)));
+}
+
+/*
+ * Test timestamps before January 1, 1970 (xfstests generic/258).
+ * The old logic added HFS_UTC_OFFSET to lower 32 bits of negative
+ * value and produced completely wrong result.
+ */
+static void hfsplus_ut2mt_before_1970_test(struct kunit *test)
+{
+	time64_t ut;
+
+	KUNIT_EXPECT_EQ(test, HFS_UTC_OFFSET - 1,
+			mt_raw(__hfsp_ut2mt(TEST_BEFORE_UNIX_EPOCH_SECS)));
+
+	/* January 1, 1960, 00:00:00 UTC */
+	ut = -315619200LL;
+	KUNIT_EXPECT_EQ(test, ut, __hfsp_mt2ut(__hfsp_ut2mt(ut)));
+
+	/* January 1, 1904, 00:00:01 UTC */
+	ut = HFS_MIN_TIMESTAMP_SECS + 1;
+	KUNIT_EXPECT_EQ(test, 1U, mt_raw(__hfsp_ut2mt(ut)));
+	KUNIT_EXPECT_EQ(test, ut, __hfsp_mt2ut(__hfsp_ut2mt(ut)));
+}
+
+/* Test that out-of-range timestamps are clamped instead of wrapped */
+static void hfsplus_ut2mt_clamp_test(struct kunit *test)
+{
+	/* below January 1, 1904 */
+	KUNIT_EXPECT_EQ(test, 0U,
+			mt_raw(__hfsp_ut2mt(HFS_MIN_TIMESTAMP_SECS - 1)));
+	KUNIT_EXPECT_EQ(test, 0U,
+			mt_raw(__hfsp_ut2mt(TEST_Y1900_SECS)));
+	KUNIT_EXPECT_EQ(test, 0U,
+			mt_raw(__hfsp_ut2mt(TIME64_MIN)));
+
+	/* after February 6, 2040 */
+	KUNIT_EXPECT_EQ(test, U32_MAX,
+			mt_raw(__hfsp_ut2mt(HFS_MAX_TIMESTAMP_SECS + 1)));
+	KUNIT_EXPECT_EQ(test, U32_MAX,
+			mt_raw(__hfsp_ut2mt(TEST_Y2100_SECS)));
+	KUNIT_EXPECT_EQ(test, U32_MAX,
+			mt_raw(__hfsp_ut2mt(HFSPLUS_MAX_TIMESTAMP_SECS)));
+
+	/* lower 32 bits of these values would wrap into small dates */
+	KUNIT_EXPECT_EQ(test, U32_MAX,
+			mt_raw(__hfsp_ut2mt(HFS_MAX_TIMESTAMP_SECS +
+					    (s64)U32_MAX + 1)));
+	KUNIT_EXPECT_EQ(test, U32_MAX,
+			mt_raw(__hfsp_ut2mt(1LL << 32)));
+}
+
+/* Test that representable timestamps survive the round trip */
+static void hfsplus_time_roundtrip_test(struct kunit *test)
+{
+	static const time64_t values[] = {
+		HFS_MIN_TIMESTAMP_SECS,
+		HFS_MIN_TIMESTAMP_SECS + 1,
+		TEST_BEFORE_UNIX_EPOCH_SECS,
+		TEST_UNIX_EPOCH_SECS,
+		1,
+		TEST_Y2000_SECS,
+		TEST_Y2026_SECS,
+		(s64)S32_MAX,
+		TEST_Y2038_SECS,
+		HFS_MAX_TIMESTAMP_SECS - 1,
+		HFS_MAX_TIMESTAMP_SECS,
+	};
+	time64_t ut;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(values); i++) {
+		KUNIT_EXPECT_EQ_MSG(test, values[i],
+				    __hfsp_mt2ut(__hfsp_ut2mt(values[i])),
+				    "round trip failed: index %d", i);
+	}
+
+	/* sweep the whole range with a large prime step */
+	for (ut = HFS_MIN_TIMESTAMP_SECS; ut <= HFS_MAX_TIMESTAMP_SECS;
+	     ut += 999983) {
+		if (__hfsp_mt2ut(__hfsp_ut2mt(ut)) != ut) {
+			KUNIT_FAIL(test, "round trip failed: ut %lld", ut);
+			break;
+		}
+	}
+
+	/* every on-disk value maps back to itself */
+	for (i = 0; i < 32; i++) {
+		u32 raw = (u32)BIT_ULL(i);
+
+		KUNIT_EXPECT_EQ(test, raw,
+				mt_raw(__hfsp_ut2mt(__hfsp_mt2ut(cpu_to_be32(raw)))));
+	}
+}
+
+/* Test the decision to keep timestamp in xattr */
+static void hfsplus_ut_needs_xattr_test(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test, hfsp_ut_needs_xattr(HFS_MIN_TIMESTAMP_SECS));
+	KUNIT_EXPECT_FALSE(test, hfsp_ut_needs_xattr(TEST_BEFORE_UNIX_EPOCH_SECS));
+	KUNIT_EXPECT_FALSE(test, hfsp_ut_needs_xattr(TEST_UNIX_EPOCH_SECS));
+	KUNIT_EXPECT_FALSE(test, hfsp_ut_needs_xattr(TEST_Y2026_SECS));
+	KUNIT_EXPECT_FALSE(test, hfsp_ut_needs_xattr(TEST_Y2038_SECS));
+	KUNIT_EXPECT_FALSE(test,
+			   hfsp_ut_needs_xattr(HFS_MAX_TIMESTAMP_SECS - 1));
+
+	KUNIT_EXPECT_TRUE(test, hfsp_ut_needs_xattr(HFS_MAX_TIMESTAMP_SECS));
+	KUNIT_EXPECT_TRUE(test,
+			  hfsp_ut_needs_xattr(HFS_MAX_TIMESTAMP_SECS + 1));
+	KUNIT_EXPECT_TRUE(test, hfsp_ut_needs_xattr(TEST_Y2100_SECS));
+	KUNIT_EXPECT_TRUE(test,
+			  hfsp_ut_needs_xattr(HFSPLUS_MAX_TIMESTAMP_SECS));
+}
+
+/* Test detection of the extended timestamp mark */
+static void hfsplus_mt_is_ext_timestamp_test(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test,
+		hfsp_mt_is_ext_timestamp(HFSPLUS_EXT_TIMESTAMP_MARK));
+	KUNIT_EXPECT_TRUE(test,
+		hfsp_mt_is_ext_timestamp(cpu_to_be32(U32_MAX)));
+
+	KUNIT_EXPECT_FALSE(test, hfsp_mt_is_ext_timestamp(cpu_to_be32(0)));
+	KUNIT_EXPECT_FALSE(test,
+		hfsp_mt_is_ext_timestamp(cpu_to_be32(U32_MAX - 1)));
+	KUNIT_EXPECT_FALSE(test,
+		hfsp_mt_is_ext_timestamp(cpu_to_be32(HFS_UTC_OFFSET)));
+
+	/* every timestamp that needs xattr is stored as the mark */
+	KUNIT_EXPECT_TRUE(test,
+		hfsp_mt_is_ext_timestamp(__hfsp_ut2mt(HFS_MAX_TIMESTAMP_SECS)));
+	KUNIT_EXPECT_TRUE(test,
+		hfsp_mt_is_ext_timestamp(__hfsp_ut2mt(TEST_Y2100_SECS)));
+	KUNIT_EXPECT_FALSE(test,
+		hfsp_mt_is_ext_timestamp(__hfsp_ut2mt(HFS_MAX_TIMESTAMP_SECS - 1)));
+}
+
+static struct super_block *alloc_mock_sb(struct kunit *test)
+{
+	struct super_block *sb;
+	struct hfsplus_sb_info *sbi;
+
+	sb = kunit_kzalloc(test, sizeof(*sb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sb);
+
+	sbi = kunit_kzalloc(test, sizeof(*sbi), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sbi);
+
+	/* no attributes tree: xattr lookup returns -EOPNOTSUPP */
+	sbi->attr_tree = NULL;
+	sb->s_fs_info = sbi;
+
+	return sb;
+}
+
+/*
+ * Test reading of the on-disk timestamp that doesn't need xattr.
+ * The superblock must not be touched in such case.
+ */
+static void hfsplus_read_timestamp_regular_test(struct kunit *test)
+{
+	static const time64_t values[] = {
+		HFS_MIN_TIMESTAMP_SECS,
+		TEST_BEFORE_UNIX_EPOCH_SECS,
+		TEST_UNIX_EPOCH_SECS,
+		TEST_Y2026_SECS,
+		HFS_MAX_TIMESTAMP_SECS - 1,
+	};
+	time64_t ut;
+	bool has_xattr;
+	int err;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(values); i++) {
+		ut = 0;
+		has_xattr = true;
+
+		err = hfsplus_read_timestamp(NULL, HFSPLUS_FIRSTUSER_CNID,
+					     XATTR_LINUX_ACCESS_DATE_NAME,
+					     __hfsp_ut2mt(values[i]),
+					     &ut, &has_xattr);
+		KUNIT_EXPECT_EQ(test, 0, err);
+		KUNIT_EXPECT_EQ(test, values[i], ut);
+		KUNIT_EXPECT_FALSE(test, has_xattr);
+	}
+}
+
+/*
+ * Test reading of the extended timestamp mark without xattr
+ * (for example, the record has been created by Mac OS X or
+ * the volume has no attributes tree). The timestamp must be
+ * HFS_MAX_TIMESTAMP_SECS without any error.
+ */
+static void hfsplus_read_timestamp_mark_no_xattr_test(struct kunit *test)
+{
+	struct super_block *sb = alloc_mock_sb(test);
+	static const char * const names[] = {
+		XATTR_LINUX_CREATE_DATE_NAME,
+		XATTR_LINUX_CONTENT_MOD_DATE_NAME,
+		XATTR_LINUX_ATTRIBUTE_MOD_DATE_NAME,
+		XATTR_LINUX_ACCESS_DATE_NAME,
+	};
+	time64_t ut;
+	bool has_xattr;
+	int err;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		ut = 0;
+		has_xattr = true;
+
+		err = hfsplus_read_timestamp(sb, HFSPLUS_FIRSTUSER_CNID,
+					     names[i],
+					     HFSPLUS_EXT_TIMESTAMP_MARK,
+					     &ut, &has_xattr);
+		KUNIT_EXPECT_EQ(test, 0, err);
+		KUNIT_EXPECT_EQ(test, HFS_MAX_TIMESTAMP_SECS, ut);
+		KUNIT_EXPECT_FALSE(test, has_xattr);
+	}
+}
+
+/* Test that names of internal xattrs fit the name buffer */
+static void hfsplus_timestamp_xattr_names_test(struct kunit *test)
+{
+	static const char * const names[] = {
+		XATTR_LINUX_CREATE_DATE_NAME,
+		XATTR_LINUX_CONTENT_MOD_DATE_NAME,
+		XATTR_LINUX_ATTRIBUTE_MOD_DATE_NAME,
+		XATTR_LINUX_ACCESS_DATE_NAME,
+		XATTR_LINUX_BACKUP_DATE_NAME,
+	};
+	int i;
+
+	KUNIT_EXPECT_EQ(test, strlen(XATTR_LINUX_HFS_PREFIX),
+			(size_t)XATTR_LINUX_HFS_PREFIX_LEN);
+
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		size_t len = XATTR_LINUX_HFS_PREFIX_LEN + strlen(names[i]);
+
+		KUNIT_EXPECT_LT_MSG(test, len, (size_t)XATTR_LINUX_HFS_NAME_MAX,
+				    "name %s is too long", names[i]);
+		KUNIT_EXPECT_LE(test, len, (size_t)HFSPLUS_ATTR_MAX_STRLEN);
+	}
+}
+
+static struct kunit_case hfsplus_time_test_cases[] = {
+	KUNIT_CASE(hfsplus_time_constants_test),
+	KUNIT_CASE(hfsplus_mt2ut_test),
+	KUNIT_CASE(hfsplus_ut2mt_test),
+	KUNIT_CASE(hfsplus_ut2mt_before_1970_test),
+	KUNIT_CASE(hfsplus_ut2mt_clamp_test),
+	KUNIT_CASE(hfsplus_time_roundtrip_test),
+	KUNIT_CASE(hfsplus_ut_needs_xattr_test),
+	KUNIT_CASE(hfsplus_mt_is_ext_timestamp_test),
+	KUNIT_CASE(hfsplus_read_timestamp_regular_test),
+	KUNIT_CASE(hfsplus_read_timestamp_mark_no_xattr_test),
+	KUNIT_CASE(hfsplus_timestamp_xattr_names_test),
+	{}
+};
+
+static struct kunit_suite hfsplus_time_test_suite = {
+	.name = "hfsplus_time",
+	.test_cases = hfsplus_time_test_cases,
+};
+
+kunit_test_suite(hfsplus_time_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for HFS+ date/time conversion");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/fs/hfsplus/unicode_test.c b/fs/hfsplus/hfsplus_unicode_test.c
similarity index 100%
rename from fs/hfsplus/unicode_test.c
rename to fs/hfsplus/hfsplus_unicode_test.c
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c2ee1906589d..0df58dfda5a3 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -18,6 +18,7 @@
 #include <linux/cred.h>
 #include <linux/uio.h>
 #include <linux/fileattr.h>
+#include <kunit/visibility.h>
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
@@ -648,6 +649,7 @@ int hfsplus_read_timestamp(struct super_block *sb, u32 cnid,
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(hfsplus_read_timestamp);
 
 static int hfsplus_inode_read_timestamps(struct inode *inode,
 					 struct hfsplus_timestamps *timestamps)
-- 
2.43.0

