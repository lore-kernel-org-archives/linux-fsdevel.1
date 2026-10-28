Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205347;
	b=RjBPn5coF5DCSjTUpF2Ne+kSMY//g9LtqSrqU2L9d4g8kiwwEbTDRpYtPU9RxU0Ozmox
	 h0FK31FOLZgzUCtbY2zNoN9eb12zSaN/sUSisRhLhq6XIQ/mr4h+O7I+vrlEfiT3X7rza
	 LU8FFpFeDRizWjs9oTjCASmMM4sU8eNxHrUZaL2YaA63aogh4anZgWvzM75oJ3QQxc1wf
	 ATgJe5Nq2ttWPvxvmKipxAlyMoYBL8D7B0vIAzpuLu/iWGcIwg0mUFHqpGSEfQHM6k+q1
	 klgpbQ/wZ0lmN5lTtKsP7rXiM7iDC0bucl8r1Bju9Ty3cvLcErclG1WLH9pVa0u47UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205347;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CYUMJpVx2RvolOxKz5WhQE96CiP+XYGWeLcVyKTByls=;
	b=fy2rOlQGNLtxgNhLU57mUetvvlETzG/Sckt5qfdDYPDdrsqRLAU34I447Cbziiy3dlwu
	 e2YUODTiGimXlvua2jrPB6OOJrl8NVPXzo8GpBmV2QPLULyY0fiGUs51xID/fJBnMbHQA
	 NxEpW8W6j6IINVZf1fgcwUzRU9GgaR8k5iuabb0Ad71sbPYvqZIkDv3SrG7OXrPvREYAY
	 xztTnCpAK9T39R/uGcQ8myDNFsZMZyAJI4QkmdijH2zshn6TxwfmS8vDALCOK4BpIZJy6
	 RGn8FLLwlrK0Aku0KN66T7DEPWQmSMbzi3Kget+mt7a0XRfxB4P80DNsZYKNXhmMvxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CZVnAoTN;
	arc=none smtp.remote-ip=91.218.175.5
Received: from mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D7606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E6D7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CZVnAoTN
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OXIwk5iSpTJ2CChYlnDV6/jEa5BV7bC0dzT0mRilrR0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205344; v=1; x=1793810144;
 b=CZVnAoTNmO7G+RsKjyWVRp/dmecAyLsZcpMYMI0bpWcEPcc9N/XNFQBab9Ycn2/B6npyMWcC
 zLFKiGLuVn5jva6oQOHtLHqLvcgmuit+7QRuylp7nBB6XZwz6gtzmIaVwuvPr8ge1uurlZ8QJbv
 aznNfPbrzTUbb1eCB24anvOA=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id e2999e8f0d6d20a3;
	Wed, 28 Oct 2026 16:35:44 +0000
X-Mizu-Trace-ID: e2999e8f0d6d20a3
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/39] test_sysctl: convert bounds to numeric values
Date: Thu, 29 Oct 2026 00:34:41 +0800
Message-Id: <4f48767377d817a63f348a7725056ca4c0869ef9.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
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

From: Wen Yang <wen.yang@linux.dev>

The debug module still passes extra pointers for its numeric ranges.
Convert them to numeric min/max so it exercises the same shape as the
rest of the tree, and keep the dynamic-value entry's context in data for
now; the priv conversion comes later.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 lib/test_sysctl.c | 135 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 109 insertions(+), 26 deletions(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index eed2cc1bea82..1411896fdbd0 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -15,7 +15,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/init.h>
-#include <linux/limits.h>
 #include <linux/jiffies.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -28,8 +27,6 @@
 #include <linux/delay.h>
 #include <linux/vmalloc.h>
 
-static int i_zero;
-static int i_one_hundred = 100;
 static int match_int_ok = 1;
 
 enum {
@@ -43,6 +40,12 @@ enum {
 };
 
 static struct ctl_table_header *ctl_headers[TEST_H_SIZE] = {};
+
+struct test_sysctl_range_context {
+	int value;
+	int limit;
+};
+
 struct test_sysctl_data {
 	int int_0001;
 	int int_0002;
@@ -56,6 +59,11 @@ struct test_sysctl_data {
 
 	unsigned int uint_0001;
 
+	struct test_sysctl_range_context dynamic;
+	int int_zero;
+	unsigned long ulong_zero;
+	u8 u8_zero;
+
 	char string_0001[65];
 
 #define SYSCTL_TEST_BITMAP_SIZE	65536
@@ -80,9 +88,25 @@ static struct test_sysctl_data test_data = {
 
 	.uint_0001 = 314,
 
+	.dynamic = { .value = 0, .limit = 100 },
+
 	.string_0001 = "(none)",
 };
 
+/* The registered data is typed context, not the backing integer. */
+static int test_sysctl_dynamic_value(const struct ctl_table *table, int dir,
+				     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct test_sysctl_range_context *context = table->data;
+	struct ctl_table resolved = *table;
+
+	resolved.data = &context->value;
+	resolved.maxlen = sizeof(context->value);
+	resolved.min = INT_MIN;
+	resolved.max = READ_ONCE(context->limit);
+	return proc_dointvec_minmax(&resolved, dir, buffer, lenp, ppos);
+}
+
 /* These are all under /proc/sys/debug/test_sysctl/ */
 static const struct ctl_table test_table[] = {
 	{
@@ -91,8 +115,8 @@ static const struct ctl_table test_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &i_zero,
-		.extra2         = &i_one_hundred,
+		.min		= 0,
+		.max		= 100,
 	},
 	{
 		.procname	= "int_0002",
@@ -100,6 +124,8 @@ static const struct ctl_table test_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
+		.min		= INT_MIN,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "int_0003",
@@ -107,6 +133,8 @@ static const struct ctl_table test_table[] = {
 		.maxlen		= sizeof(test_data.int_0003),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
+		.min		= INT_MIN,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "match_int",
@@ -114,6 +142,8 @@ static const struct ctl_table test_table[] = {
 		.maxlen		= sizeof(match_int_ok),
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,
+		.min		= INT_MIN,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "boot_int",
@@ -121,8 +151,8 @@ static const struct ctl_table test_table[] = {
 		.maxlen		= sizeof(test_data.boot_int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "int_jiffies",
@@ -130,6 +160,8 @@ static const struct ctl_table test_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
+		.min		= INT_MIN,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "int_ms_jiffies",
@@ -137,6 +169,8 @@ static const struct ctl_table test_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_ms_jiffies,
+		.min		= INT_MIN,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "int_userhz_jiffies",
@@ -144,6 +178,8 @@ static const struct ctl_table test_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_userhz_jiffies,
+		.min		= INT_MIN,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "uint_0001",
@@ -151,6 +187,8 @@ static const struct ctl_table test_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec,
+		.min		= 0,
+		.max		= UINT_MAX,
 	},
 	{
 		.procname	= "string_0001",
@@ -166,28 +204,73 @@ static const struct ctl_table test_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_large_bitmap,
 	},
+	{
+		.procname	= "dynamic_limit",
+		.data		= &test_data.dynamic.limit,
+		.maxlen		= sizeof(test_data.dynamic.limit),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.min		= INT_MIN,
+		.max		= INT_MAX,
+	},
+	{
+		.procname	= "dynamic_value",
+		.data		= &test_data.dynamic,
+		.maxlen		= sizeof(test_data.dynamic),
+		.mode		= 0644,
+		.proc_handler	= test_sysctl_dynamic_value,
+		.min		= 0,
+		.max		= ULONG_MAX,
+	},
+	{
+		.procname	= "int_zero",
+		.data		= &test_data.int_zero,
+		.maxlen		= sizeof(test_data.int_zero),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.min		= 0,
+		.max		= 0,
+	},
+	{
+		.procname	= "ulong_zero",
+		.data		= &test_data.ulong_zero,
+		.maxlen		= sizeof(test_data.ulong_zero),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= 0,
+	},
+	{
+		.procname	= "u8_zero",
+		.data		= &test_data.u8_zero,
+		.maxlen		= sizeof(test_data.u8_zero),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= 0,
+	},
 };
 
 static void test_sysctl_calc_match_int_ok(void)
 {
 	int i;
 
-	struct {
+	const struct {
 		int defined;
 		int wanted;
 	} match_int[] = {
-		{.defined = *(int *)SYSCTL_ZERO,	.wanted = 0},
-		{.defined = *(int *)SYSCTL_ONE,		.wanted = 1},
-		{.defined = *(int *)SYSCTL_TWO,		.wanted = 2},
-		{.defined = *(int *)SYSCTL_THREE,	.wanted = 3},
-		{.defined = *(int *)SYSCTL_FOUR,	.wanted = 4},
-		{.defined = *(int *)SYSCTL_ONE_HUNDRED, .wanted = 100},
-		{.defined = *(int *)SYSCTL_TWO_HUNDRED,	.wanted = 200},
-		{.defined = *(int *)SYSCTL_ONE_THOUSAND, .wanted = 1000},
-		{.defined = *(int *)SYSCTL_THREE_THOUSAND, .wanted = 3000},
-		{.defined = *(int *)SYSCTL_INT_MAX,	.wanted = INT_MAX},
-		{.defined = *(int *)SYSCTL_MAXOLDUID,	.wanted = 65535},
-		{.defined = *(int *)SYSCTL_NEG_ONE,	.wanted = -1},
+		{ .defined = 0, .wanted = 0 },
+		{ .defined = 1, .wanted = 1 },
+		{ .defined = 2, .wanted = 2 },
+		{ .defined = 3, .wanted = 3 },
+		{ .defined = 4, .wanted = 4 },
+		{ .defined = 100, .wanted = 100 },
+		{ .defined = 200, .wanted = 200 },
+		{ .defined = 1000, .wanted = 1000 },
+		{ .defined = 3000, .wanted = 3000 },
+		{ .defined = INT_MAX, .wanted = INT_MAX },
+		{ .defined = 65535, .wanted = 65535 },
+		{ .defined = -1, .wanted = -1 },
 	};
 
 	for (i = 0; i < ARRAY_SIZE(match_int); i++)
@@ -282,8 +365,8 @@ static const struct ctl_table table_u8_over[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_FOUR,
-		.extra2		= SYSCTL_ONE_THOUSAND,
+		.min		= 4,
+		.max		= 1000,
 	},
 };
 
@@ -294,8 +377,8 @@ static const struct ctl_table table_u8_under[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_NEG_ONE,
-		.extra2		= SYSCTL_ONE_HUNDRED,
+		.min		= ULONG_MAX,
+		.max		= 100,
 	},
 };
 
@@ -306,8 +389,8 @@ static const struct ctl_table table_u8_valid[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO_HUNDRED,
+		.min		= 0,
+		.max		= 200,
 	},
 };
 
-- 
2.25.1

