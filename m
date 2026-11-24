Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560821;
	b=dvdf/GybPWDv1PNjokCX4KAP8IIlq/dDMdzNL6lEJAImyLPF5vEKfh9OmeWQOCzHiBmQ
	 sEwAvItL8jeRHRf58SeAfRwIpe71JwoUZczNhQTsjF/hY5CRbnoKw56hIAqYk09+uNjSS
	 ZHr65RGn26OH0jIZX8heQ06P1cHPikjFGjkQcyFPQbOLzatDabWUop/gu9M7wYCDcqjXh
	 uRyJnF1l93LY7mVXGK1QPeN2eaBPc6kOLQPKlFIdanWScuW1CvIzN6MzUO4oVCYZK6Pyl
	 42QiD1qWjzJQ16xrV6WtH0nI2hVSivI5vBMdKKT5XgLR+enZuFdlRVgvIgqkL2ld7cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UvjeapSGNK6WUM8yBfJmR85TspM0g2j3gcozNHMc1eM=;
	b=y3xGPn4Jgd9v0WdrDEO8JPESFPO0bFhotAteo/f8DSRYr34J/9p0Sn2DDXdUdm0UTO29
	 ioRY7Ao2pHaGCF44qFO69Fqnq3LiZhOhzhOpBDaWe2UiMxP3BAY1iJDocIZ9mB2MSWqYS
	 DOt2jBUSIHSa+iRauCh/HUsfbCh/UQnli2e8qbDvrlR124c/cwirCvfICHQ6ych5i/fwG
	 mMyyWSNzXHONTbZZ4XgylKtBX0vIrUDvPzkOowatf09enYdtCkA+/I+LJQ7XqRPpkGgQB
	 7V1M9i9YxfNOygusutUF4Xt6pWMh9n+P/jUsJkuiUgLE3MHDuuiUIoRKwh50mlxVU0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A60AmEeF;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B074606A693
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B074606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A60AmEeF
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6798eb0d190so4282448d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 14:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795560820; x=1796165620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UvjeapSGNK6WUM8yBfJmR85TspM0g2j3gcozNHMc1eM=;
        b=A60AmEeFg/zE3Y6HedX/yysh7wmyL7zwV3cOa5L20r4rWKqV+QY7EzKdTvpVuQ3KLj
         1UXdpdKFQOZd8jJIP2mXxLCHimHM2H85H4t/R4o3m4xBLdwi+aSgFyq7iVl1qVjsADlt
         3UUPt9yF8EW9NOXRGPrIOuBX5iB5ZDpitfw6YVaMoZo5PV8djp4MBRqdcY/foEqMPIxO
         WZ1L8tWwx4mcqnalKDCls1WV1RvEGiBCN6h2MiKeJSRYTAon5DxLHLxIhwRo3VTZMELD
         WTR44ZWxdGJvQ/CkiGnWrvvJosscyltzMUWzoLd4haFoEetr6NFnipdi7B8UeVpHnSxr
         BGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560820; x=1796165620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UvjeapSGNK6WUM8yBfJmR85TspM0g2j3gcozNHMc1eM=;
        b=JiaamvwHciraHTj+740XjrBKnQ+rLNVEVJ+GAoJBWr73wZPej+DLtnmjz8gDpCjh8O
         47VuXytuTZ7xON2SBkWBaGDsUvPooZAzk2OYjhgz0niKFuSNYiMu8yFJdG5ou5Gpg/pA
         8GhpBZ+3hAe7FAf27Z36/PhzJDZKEsel2h/E6NZgJRDIKuNRbLpKK2Xyb2D91KbNWOaD
         8a8XMb3/zNgChVHC62m3DFpIRYA3vkOneyah+Htit4IkJKrsC4rz9t9i+77UGEcpQ9JV
         HYyU+5cWhq5Gf3kPzL1lPKk3pl1reYWG8nQwwuhdkneDPDYZ3VrODN6n+P8A+ma0wps5
         bagg==
X-Gm-Message-State: APuU4Z8uaE/7W2vxh9WKzHTse4T88eEiC/ifc50Q9iQ7i4/tZLnE9fAh
	6G247FiF+012Di9n+3+IAZuTEDKZUbjPurFmoKiOwXNs0K98nAzn14DDsShf/eNdp4w=
X-Gm-Gg: AZFdTZfzcTOKO5Y1+7FGirjfy52rLuu5BXTB/DJhg/RBEtjCRWyJxBecxnqa/FNreye
	iyBbEqqvgeSeOKqHckjow2JNNeoqA6QTsymXHiJLcbfaLVhLlEjuNnkwVETE3VEvPQReMR1BSA8
	ppkAS8ylbdsXKTj3eMk4hqnY2zPQH4S0/4PAzURUalNDUYnnWO3F+QnBAEBtkkjxcTkUiywqNOn
	01TTyMXCYm9UUM0yiuHsKlgGuGc+x1RQ5V1SUcp+yXetFtcR5YccpxPxmWry6KR6Cz/aV4Lwuvi
	C0wTVNx6o1hJGzCdKLyuv7TSsFjY8h6y1evxSZDQ+AeKFG14l0iEWD2/+e8mRpjQlpvwytrZ+bM
	RI4oKEpeciGymnbI27S5nAnf7ovnQshQt7tVqQkpEAaQELIuvHZH6pco+fRfR6uYTorYWwKKvtt
	ag9p4OnmCRgrshVkzdlG+kjkKdnXL4lB8bQam0nWh+9VQpfjiuFDn0N+fdQF97ejeU0TI8YNw5G
	Kh1F9OhLoeL88oMt1ed0KdQlrLkYu64uTk/y2CMrSyCsuLIkO9oNX54VjpAakT0HJIQjolnnn9b
	FkVB9BEm26Mo1hv7xNq3TQ3xbafpd3528T9YlA6WIi5t7FKbJvmELhN/OQgz5u0tsj7EjGDKWVJ
	AEUdsApUf26VLekldfRWRXSKF3ubGzwAnJRKOTz9t7kPyp2n47tMRhVY4HvtRgjDVN8v/mq0=
X-Received: by 2002:a05:690e:1381:b0:67d:ac40:6bcc with SMTP id 956f58d0204a3-67df448c9b0mr6406209d50.98.1795560820105;
        Tue, 24 Nov 2026 14:53:40 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:c4f2:e852:cd48:35ad])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33b7502sm7706219d50.20.2026.11.24.14.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 14:53:39 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 3/3] hfs: add KUnit tests for date/time conversion
Date: Tue, 24 Nov 2026 14:53:30 -0800
Message-ID: <20261124225330.3879708-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124225330.3879708-1-slava@dubeyko.com>
References: <20261124225330.3879708-1-slava@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add KUnit tests for the HFS date/time conversion logic:

(1) the time range constants and the location of the spare
    bytes in the catalog records;
(2) conversion of on-disk (1904-based) timestamps into
    1970-based ones and vice versa;
(3) clamping of the timestamps out of the supported range
    instead of wrapping;
(4) round trip of the timestamps from the supported range;
(5) conversion and validation of the extended 64-bit timestamps;
(6) storing the timestamps after February 2040 in the spare
    bytes of the file and directory records without touching
    other fields;
(7) removing the stale extended value if the timestamp becomes
    representable by MdDat again;
(8) ignoring the extended value if another implementation
    has updated MdDat;
(9) the mark without the valid extended value;
(10) preserving the spare bytes of another implementation.

HFS keeps timestamps in local time. So, the expected values are
shifted by the local time zone offset.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/Makefile        |   2 +-
 fs/hfs/hfs_time_test.c | 400 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 401 insertions(+), 1 deletion(-)
 create mode 100644 fs/hfs/hfs_time_test.c

diff --git a/fs/hfs/Makefile b/fs/hfs/Makefile
index a7c9ce6b4609..be68c5305f04 100644
--- a/fs/hfs/Makefile
+++ b/fs/hfs/Makefile
@@ -10,4 +10,4 @@ hfs-objs := bitmap.o bfind.o bnode.o brec.o btree.o \
             part_tbl.o string.o super.o sysdep.o trans.o
 
 # KUnit tests
-obj-$(CONFIG_HFS_KUNIT_TEST) += string_test.o
+obj-$(CONFIG_HFS_KUNIT_TEST) += string_test.o hfs_time_test.o
diff --git a/fs/hfs/hfs_time_test.c b/fs/hfs/hfs_time_test.c
new file mode 100644
index 000000000000..508ecfbfdec4
--- /dev/null
+++ b/fs/hfs/hfs_time_test.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for HFS date/time conversion
+ *
+ * Copyright (C) 2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/unaligned.h>
+#include "hfs_fs.h"
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
+/* on-disk (1904-based) values of the timestamps above */
+#define TEST_Y2000_MT			3029529600U
+#define TEST_Y2026_MT			3850070400U
+#define TEST_Y2038_MT			4230328448U
+#define TEST_Y2100_EXT_MT		6185289600ULL
+
+/* garbage of another implementation in the spare bytes */
+#define TEST_FOREIGN_BYTE		0x5A
+
+/*
+ * HFS keeps timestamps in local time. The expected values
+ * are shifted by the local time zone offset.
+ */
+static time64_t tz_secs(void)
+{
+	return sys_tz.tz_minuteswest * 60;
+}
+
+static u32 mt_raw(__be32 mt)
+{
+	return be32_to_cpu(mt);
+}
+
+static hfs_cat_rec *alloc_cat_rec(struct kunit *test, s8 type)
+{
+	hfs_cat_rec *rec;
+
+	rec = kunit_kzalloc(test, sizeof(*rec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, rec);
+	rec->type = type;
+
+	return rec;
+}
+
+static u64 file_ext_mt(hfs_cat_rec *rec)
+{
+	return get_unaligned_be64(&rec->file.FndrInfo);
+}
+
+static u64 dir_ext_mt(hfs_cat_rec *rec)
+{
+	return get_unaligned_be64(rec->dir.Resrv);
+}
+
+/* Test the time range constants */
+static void hfs_time_constants_test(struct kunit *test)
+{
+	/* 32-bit unsigned on-disk field covers exactly U32_MAX seconds */
+	KUNIT_EXPECT_EQ(test, (s64)U32_MAX,
+			HFS_MAX_TIMESTAMP_SECS - HFS_MIN_TIMESTAMP_SECS);
+	KUNIT_EXPECT_EQ(test, -(s64)HFS_UTC_OFFSET, HFS_MIN_TIMESTAMP_SECS);
+
+	/* spare bytes extend the supported range beyond February 2040 */
+	KUNIT_EXPECT_GT(test, HFS_EXT_MAX_TIMESTAMP_SECS,
+			HFS_MAX_TIMESTAMP_SECS);
+
+	/* the extended timestamp mark is the maximal on-disk value */
+	KUNIT_EXPECT_EQ(test, U32_MAX, mt_raw(HFS_EXT_TIMESTAMP_MARK));
+	KUNIT_EXPECT_EQ(test, 8, (int)HFS_EXT_TIMESTAMP_SIZE);
+
+	/* the spare bytes do not overlap the used fields */
+	KUNIT_EXPECT_GE(test, offsetof(struct hfs_fxinfo, fdUnused) + 6,
+			HFS_EXT_TIMESTAMP_SIZE);
+	KUNIT_EXPECT_GE(test, offsetof(struct hfs_fxinfo, fdComment),
+			HFS_EXT_TIMESTAMP_SIZE + 2);
+	KUNIT_EXPECT_GE(test, sizeof(((struct hfs_cat_dir *)0)->Resrv),
+			HFS_EXT_TIMESTAMP_SIZE);
+}
+
+/* Test conversion of on-disk (1904-based) timestamp into 1970-based one */
+static void hfs_m_to_utime_test(struct kunit *test)
+{
+	time64_t tz = tz_secs();
+
+	KUNIT_EXPECT_EQ(test, HFS_MIN_TIMESTAMP_SECS + tz,
+			__hfs_m_to_utime(cpu_to_be32(0)));
+	KUNIT_EXPECT_EQ(test, TEST_UNIX_EPOCH_SECS + tz,
+			__hfs_m_to_utime(cpu_to_be32(HFS_UTC_OFFSET)));
+	KUNIT_EXPECT_EQ(test, TEST_BEFORE_UNIX_EPOCH_SECS + tz,
+			__hfs_m_to_utime(cpu_to_be32(HFS_UTC_OFFSET - 1)));
+	KUNIT_EXPECT_EQ(test, TEST_Y2000_SECS + tz,
+			__hfs_m_to_utime(cpu_to_be32(TEST_Y2000_MT)));
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_SECS + tz,
+			__hfs_m_to_utime(cpu_to_be32(TEST_Y2026_MT)));
+	KUNIT_EXPECT_EQ(test, TEST_Y2038_SECS + tz,
+			__hfs_m_to_utime(cpu_to_be32(TEST_Y2038_MT)));
+	KUNIT_EXPECT_EQ(test, HFS_MAX_TIMESTAMP_SECS + tz,
+			__hfs_m_to_utime(HFS_EXT_TIMESTAMP_MARK));
+}
+
+/* Test conversion of 1970-based timestamp into on-disk (1904-based) one */
+static void hfs_u_to_mtime_test(struct kunit *test)
+{
+	time64_t tz = tz_secs();
+
+	KUNIT_EXPECT_EQ(test, 0U,
+			mt_raw(__hfs_u_to_mtime(HFS_MIN_TIMESTAMP_SECS + tz)));
+	KUNIT_EXPECT_EQ(test, HFS_UTC_OFFSET,
+			mt_raw(__hfs_u_to_mtime(TEST_UNIX_EPOCH_SECS + tz)));
+	KUNIT_EXPECT_EQ(test, HFS_UTC_OFFSET - 1,
+			mt_raw(__hfs_u_to_mtime(TEST_BEFORE_UNIX_EPOCH_SECS + tz)));
+	KUNIT_EXPECT_EQ(test, TEST_Y2000_MT,
+			mt_raw(__hfs_u_to_mtime(TEST_Y2000_SECS + tz)));
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_MT,
+			mt_raw(__hfs_u_to_mtime(TEST_Y2026_SECS + tz)));
+	KUNIT_EXPECT_EQ(test, TEST_Y2038_MT,
+			mt_raw(__hfs_u_to_mtime(TEST_Y2038_SECS + tz)));
+	KUNIT_EXPECT_EQ(test, U32_MAX,
+			mt_raw(__hfs_u_to_mtime(HFS_MAX_TIMESTAMP_SECS + tz)));
+}
+
+/* Test that out of range timestamps are clamped instead of wrapped */
+static void hfs_u_to_mtime_clamp_test(struct kunit *test)
+{
+	time64_t tz = tz_secs();
+
+	KUNIT_EXPECT_EQ(test, 0U,
+			mt_raw(__hfs_u_to_mtime(TEST_Y1900_SECS + tz)));
+	KUNIT_EXPECT_EQ(test, 0U,
+			mt_raw(__hfs_u_to_mtime(HFS_MIN_TIMESTAMP_SECS + tz - 1)));
+	KUNIT_EXPECT_EQ(test, U32_MAX,
+			mt_raw(__hfs_u_to_mtime(HFS_MAX_TIMESTAMP_SECS + tz + 1)));
+	KUNIT_EXPECT_EQ(test, U32_MAX,
+			mt_raw(__hfs_u_to_mtime(TEST_Y2100_SECS + tz)));
+}
+
+/* Test round trip of the timestamps from the supported range */
+static void hfs_time_round_trip_test(struct kunit *test)
+{
+	static const time64_t values[] = {
+		HFS_MIN_TIMESTAMP_SECS,
+		TEST_BEFORE_UNIX_EPOCH_SECS,
+		TEST_UNIX_EPOCH_SECS,
+		TEST_Y2000_SECS,
+		TEST_Y2026_SECS,
+		TEST_Y2038_SECS,
+		HFS_MAX_TIMESTAMP_SECS,
+	};
+	time64_t tz = tz_secs();
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(values); i++) {
+		time64_t ut = values[i] + tz;
+
+		KUNIT_EXPECT_EQ(test, ut,
+				__hfs_m_to_utime(__hfs_u_to_mtime(ut)));
+	}
+}
+
+/* Test conversion of the extended (64-bit) on-disk timestamps */
+static void hfs_ext_mtime_test(struct kunit *test)
+{
+	time64_t tz = tz_secs();
+
+	KUNIT_EXPECT_EQ(test, TEST_Y2100_EXT_MT,
+			__hfs_u_to_ext_mtime(TEST_Y2100_SECS + tz));
+	KUNIT_EXPECT_EQ(test, TEST_Y2100_SECS + tz,
+			__hfs_ext_m_to_utime(TEST_Y2100_EXT_MT));
+
+	/* the extended value is the continuation of the 32-bit one */
+	KUNIT_EXPECT_EQ(test, (u64)TEST_Y2026_MT,
+			__hfs_u_to_ext_mtime(TEST_Y2026_SECS + tz));
+	KUNIT_EXPECT_EQ(test, (u64)U32_MAX + 1,
+			__hfs_u_to_ext_mtime(HFS_MAX_TIMESTAMP_SECS + tz + 1));
+
+	/* clamping */
+	KUNIT_EXPECT_EQ(test, 0ULL, __hfs_u_to_ext_mtime(TIME64_MIN));
+	KUNIT_EXPECT_LE(test, __hfs_u_to_ext_mtime(TIME64_MAX),
+			HFS_EXT_MAX_MAC_DATE);
+	KUNIT_EXPECT_TRUE(test,
+		hfs_ext_mt_is_valid(__hfs_u_to_ext_mtime(TIME64_MAX)));
+	KUNIT_EXPECT_EQ(test,
+		HFS_EXT_MAX_TIMESTAMP_SECS,
+		__hfs_ext_m_to_utime(__hfs_u_to_ext_mtime(TIME64_MAX)));
+}
+
+/* Test validation of the extended on-disk timestamps */
+static void hfs_ext_mt_is_valid_test(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test, hfs_ext_mt_is_valid(0));
+	KUNIT_EXPECT_FALSE(test, hfs_ext_mt_is_valid(TEST_Y2026_MT));
+	KUNIT_EXPECT_FALSE(test, hfs_ext_mt_is_valid(U32_MAX));
+	KUNIT_EXPECT_TRUE(test, hfs_ext_mt_is_valid((u64)U32_MAX + 1));
+	KUNIT_EXPECT_TRUE(test, hfs_ext_mt_is_valid(TEST_Y2100_EXT_MT));
+	KUNIT_EXPECT_TRUE(test, hfs_ext_mt_is_valid(HFS_EXT_MAX_MAC_DATE));
+	KUNIT_EXPECT_FALSE(test, hfs_ext_mt_is_valid(HFS_EXT_MAX_MAC_DATE + 1));
+	KUNIT_EXPECT_FALSE(test, hfs_ext_mt_is_valid(U64_MAX));
+
+	KUNIT_EXPECT_TRUE(test,
+		hfs_mt_is_ext_timestamp(HFS_EXT_TIMESTAMP_MARK));
+	KUNIT_EXPECT_FALSE(test,
+		hfs_mt_is_ext_timestamp(cpu_to_be32(TEST_Y2026_MT)));
+	KUNIT_EXPECT_FALSE(test, hfs_mt_is_ext_timestamp(cpu_to_be32(0)));
+}
+
+/* Test regular timestamp in the file record */
+static void hfs_cat_file_regular_mtime_test(struct kunit *test)
+{
+	hfs_cat_rec *rec = alloc_cat_rec(test, HFS_CDR_FIL);
+	time64_t tz = tz_secs();
+
+	hfs_cat_write_mtime(rec, TEST_Y2026_SECS + tz);
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_MT, mt_raw(rec->file.MdDat));
+	KUNIT_EXPECT_EQ(test, 0ULL, file_ext_mt(rec));
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_SECS + tz, hfs_cat_read_mtime(rec));
+}
+
+/* Test timestamp after February 2040 in the file record */
+static void hfs_cat_file_ext_mtime_test(struct kunit *test)
+{
+	hfs_cat_rec *rec = alloc_cat_rec(test, HFS_CDR_FIL);
+	time64_t tz = tz_secs();
+
+	rec->file.FlNum = cpu_to_be32(HFS_FIRSTUSER_CNID);
+	rec->file.CrDat = cpu_to_be32(TEST_Y2000_MT);
+	rec->file.FndrInfo.fdUnused[6] = TEST_FOREIGN_BYTE;
+	rec->file.FndrInfo.fdUnused[7] = TEST_FOREIGN_BYTE;
+	rec->file.FndrInfo.fdComment = cpu_to_be16(0x1234);
+	rec->file.FndrInfo.fdPutAway = cpu_to_be32(0xDEADBEEF);
+
+	hfs_cat_write_mtime(rec, TEST_Y2100_SECS + tz);
+	KUNIT_EXPECT_TRUE(test, hfs_mt_is_ext_timestamp(rec->file.MdDat));
+	KUNIT_EXPECT_EQ(test, TEST_Y2100_EXT_MT, file_ext_mt(rec));
+	KUNIT_EXPECT_EQ(test, TEST_Y2100_SECS + tz, hfs_cat_read_mtime(rec));
+
+	/* other fields are not touched */
+	KUNIT_EXPECT_EQ(test, HFS_FIRSTUSER_CNID, be32_to_cpu(rec->file.FlNum));
+	KUNIT_EXPECT_EQ(test, TEST_Y2000_MT, mt_raw(rec->file.CrDat));
+	KUNIT_EXPECT_EQ(test, TEST_FOREIGN_BYTE,
+			rec->file.FndrInfo.fdUnused[6]);
+	KUNIT_EXPECT_EQ(test, TEST_FOREIGN_BYTE,
+			rec->file.FndrInfo.fdUnused[7]);
+	KUNIT_EXPECT_EQ(test, 0x1234, be16_to_cpu(rec->file.FndrInfo.fdComment));
+	KUNIT_EXPECT_EQ(test, 0xDEADBEEF,
+			be32_to_cpu(rec->file.FndrInfo.fdPutAway));
+	KUNIT_EXPECT_EQ(test, 0U, rec->file.Resrv);
+
+	/* timestamp becomes representable again: stale value is removed */
+	hfs_cat_write_mtime(rec, TEST_Y2026_SECS + tz);
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_MT, mt_raw(rec->file.MdDat));
+	KUNIT_EXPECT_EQ(test, 0ULL, file_ext_mt(rec));
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_SECS + tz, hfs_cat_read_mtime(rec));
+	KUNIT_EXPECT_EQ(test, TEST_FOREIGN_BYTE,
+			rec->file.FndrInfo.fdUnused[6]);
+	KUNIT_EXPECT_EQ(test, 0x1234, be16_to_cpu(rec->file.FndrInfo.fdComment));
+}
+
+/* Test timestamp after February 2040 in the directory record */
+static void hfs_cat_dir_ext_mtime_test(struct kunit *test)
+{
+	hfs_cat_rec *rec = alloc_cat_rec(test, HFS_CDR_DIR);
+	time64_t tz = tz_secs();
+	int i;
+
+	rec->dir.DirID = cpu_to_be32(HFS_FIRSTUSER_CNID);
+	rec->dir.FndrInfo.frPutAway = cpu_to_be32(0xDEADBEEF);
+	for (i = HFS_EXT_TIMESTAMP_SIZE; i < sizeof(rec->dir.Resrv); i++)
+		rec->dir.Resrv[i] = TEST_FOREIGN_BYTE;
+
+	hfs_cat_write_mtime(rec, TEST_Y2026_SECS + tz);
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_MT, mt_raw(rec->dir.MdDat));
+	KUNIT_EXPECT_EQ(test, 0ULL, dir_ext_mt(rec));
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_SECS + tz, hfs_cat_read_mtime(rec));
+
+	hfs_cat_write_mtime(rec, TEST_Y2100_SECS + tz);
+	KUNIT_EXPECT_TRUE(test, hfs_mt_is_ext_timestamp(rec->dir.MdDat));
+	KUNIT_EXPECT_EQ(test, TEST_Y2100_EXT_MT, dir_ext_mt(rec));
+	KUNIT_EXPECT_EQ(test, TEST_Y2100_SECS + tz, hfs_cat_read_mtime(rec));
+
+	/* other fields are not touched */
+	KUNIT_EXPECT_EQ(test, HFS_FIRSTUSER_CNID, be32_to_cpu(rec->dir.DirID));
+	KUNIT_EXPECT_EQ(test, 0xDEADBEEF,
+			be32_to_cpu(rec->dir.FndrInfo.frPutAway));
+	for (i = HFS_EXT_TIMESTAMP_SIZE; i < sizeof(rec->dir.Resrv); i++)
+		KUNIT_EXPECT_EQ(test, TEST_FOREIGN_BYTE, rec->dir.Resrv[i]);
+
+	hfs_cat_write_mtime(rec, TEST_Y2000_SECS + tz);
+	KUNIT_EXPECT_EQ(test, TEST_Y2000_MT, mt_raw(rec->dir.MdDat));
+	KUNIT_EXPECT_EQ(test, 0ULL, dir_ext_mt(rec));
+	KUNIT_EXPECT_EQ(test, TEST_Y2000_SECS + tz, hfs_cat_read_mtime(rec));
+}
+
+/* Test that another implementation updating MdDat invalidates the value */
+static void hfs_cat_foreign_mtime_update_test(struct kunit *test)
+{
+	hfs_cat_rec *rec = alloc_cat_rec(test, HFS_CDR_FIL);
+	time64_t tz = tz_secs();
+
+	hfs_cat_write_mtime(rec, TEST_Y2100_SECS + tz);
+	KUNIT_EXPECT_TRUE(test, hfs_mt_is_ext_timestamp(rec->file.MdDat));
+
+	/* Mac OS updates MdDat but keeps the spare bytes */
+	rec->file.MdDat = cpu_to_be32(TEST_Y2026_MT);
+	KUNIT_EXPECT_EQ(test, TEST_Y2100_EXT_MT, file_ext_mt(rec));
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_SECS + tz, hfs_cat_read_mtime(rec));
+}
+
+/* Test the mark without the valid extended value */
+static void hfs_cat_mark_without_ext_test(struct kunit *test)
+{
+	hfs_cat_rec *rec = alloc_cat_rec(test, HFS_CDR_FIL);
+	time64_t tz = tz_secs();
+
+	/* the spare bytes are zero */
+	rec->file.MdDat = HFS_EXT_TIMESTAMP_MARK;
+	KUNIT_EXPECT_EQ(test, HFS_MAX_TIMESTAMP_SECS + tz,
+			hfs_cat_read_mtime(rec));
+
+	/* the value is representable by MdDat */
+	put_unaligned_be64(TEST_Y2026_MT, &rec->file.FndrInfo);
+	KUNIT_EXPECT_EQ(test, HFS_MAX_TIMESTAMP_SECS + tz,
+			hfs_cat_read_mtime(rec));
+
+	/* the value cannot be converted into time64_t */
+	put_unaligned_be64(U64_MAX, &rec->file.FndrInfo);
+	KUNIT_EXPECT_EQ(test, HFS_MAX_TIMESTAMP_SECS + tz,
+			hfs_cat_read_mtime(rec));
+}
+
+/* Test that the spare bytes of another implementation are preserved */
+static void hfs_cat_foreign_spare_bytes_test(struct kunit *test)
+{
+	hfs_cat_rec *rec = alloc_cat_rec(test, HFS_CDR_FIL);
+	time64_t tz = tz_secs();
+	u64 foreign;
+
+	memset(&rec->file.FndrInfo, TEST_FOREIGN_BYTE, HFS_EXT_TIMESTAMP_SIZE);
+	foreign = file_ext_mt(rec);
+	rec->file.MdDat = cpu_to_be32(TEST_Y2000_MT);
+
+	hfs_cat_write_mtime(rec, TEST_Y2026_SECS + tz);
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_MT, mt_raw(rec->file.MdDat));
+	KUNIT_EXPECT_EQ(test, foreign, file_ext_mt(rec));
+	KUNIT_EXPECT_EQ(test, TEST_Y2026_SECS + tz, hfs_cat_read_mtime(rec));
+
+	/*
+	 * The maximal regular value is equal to the mark. The spare bytes
+	 * must be cleared, otherwise they will be treated as the extended
+	 * value.
+	 */
+	hfs_cat_write_mtime(rec, HFS_MAX_TIMESTAMP_SECS + tz);
+	KUNIT_EXPECT_TRUE(test, hfs_mt_is_ext_timestamp(rec->file.MdDat));
+	KUNIT_EXPECT_EQ(test, 0ULL, file_ext_mt(rec));
+	KUNIT_EXPECT_EQ(test, HFS_MAX_TIMESTAMP_SECS + tz,
+			hfs_cat_read_mtime(rec));
+}
+
+static struct kunit_case hfs_time_test_cases[] = {
+	KUNIT_CASE(hfs_time_constants_test),
+	KUNIT_CASE(hfs_m_to_utime_test),
+	KUNIT_CASE(hfs_u_to_mtime_test),
+	KUNIT_CASE(hfs_u_to_mtime_clamp_test),
+	KUNIT_CASE(hfs_time_round_trip_test),
+	KUNIT_CASE(hfs_ext_mtime_test),
+	KUNIT_CASE(hfs_ext_mt_is_valid_test),
+	KUNIT_CASE(hfs_cat_file_regular_mtime_test),
+	KUNIT_CASE(hfs_cat_file_ext_mtime_test),
+	KUNIT_CASE(hfs_cat_dir_ext_mtime_test),
+	KUNIT_CASE(hfs_cat_foreign_mtime_update_test),
+	KUNIT_CASE(hfs_cat_mark_without_ext_test),
+	KUNIT_CASE(hfs_cat_foreign_spare_bytes_test),
+	{}
+};
+
+static struct kunit_suite hfs_time_test_suite = {
+	.name = "hfs_time",
+	.test_cases = hfs_time_test_cases,
+};
+
+kunit_test_suite(hfs_time_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for HFS date/time conversion");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
-- 
2.53.0

