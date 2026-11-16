Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845283;
	b=TIev8B3fjgPCL5ehw/OENpObqKRs8MAaDj23xEGwD4Twr8bZztTyp6SgynhXAFJM/fDN
	 8SLbzyKhKX5YiepU5QQcPox+4NRSU+85FiyG+yBGcVBxSTEJoE8Tt9ULGa4dM6b3Nbl5w
	 5DgP/+EYDASQk9AIa9T/UYoI93l01mjaLA/kex2A7mPQZBGG1l4iPsZOB5DLGI33wHOE1
	 uG3DLCmivB0h551FUTR+GDK0bNJLRyemNjqodS0vxsb3gJy+eJPADe28gS00JUT/8wwdT
	 +/9jVK6jeeQYxtkY831J5QhPBa1OSqzKS3ecfXmW6hzWCHitOEbKT5Mt/+G+wuMYmgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845283;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CkTPRq+CcC4p7UWdZKzOwR6OJ+yj0A7DikbrSxNZ8Qg=;
	b=mjDHFstJdBTN4QFH5ShQxTbl0iNT1j76p3XCurtYiMKdIggiaJwoj6Sy6K6hdt2hA7R7
	 xdbtvU9tjwqIBVn0GS5SJixT4CWyD7g7ujmMyeqQ27OVaCgR+m2qZ+VYX8GP/iIZZorxE
	 R/dbRIqDpxu88VZyWZHPvWgVsPFhg8ttY0Pv7q6jHL/wK5dTnipQXmS0A3KXSDq5/ocpo
	 PlXI3PTDqTDlNhJ8KQWEFw3k7bf+MsNDf2g1GpZikxUlrGcBWL7wZA/1bmtGLwrRzPN1d
	 ZsTEu1J8gkxo+zntzrESGE1vGdBk4Y8g7TauzJtAJSZ02gM0b54wlar11tlcyXm7W7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C6G8Ecj8;
	arc=none smtp.remote-ip=91.218.175.93
Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3E606A32A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 16:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA3E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C6G8Ecj8
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=t9APUF08Q1dvRABaymhBlsoaiIGA9/4F9QIFyE+thGU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794845280; v=1; x=1795450080;
 b=C6G8Ecj8bLMAdfaBnWi7oU5Jb52ORAG4vozYGWmY+99kZP+fxlouLej0vqRQ51LG4bfhVIc8
 mYg0I8Lj3HiLwQkipHC+mmoUI/wvor+a3BLWyo12vmtZ3SU51eWtgvuBoLhvBzyQkCavxCfkxhm
 Goen6vAwrvkb8DXDcluCKfqk=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 8c75857ac0dd5ebd;
	Mon, 16 Nov 2026 16:08:00 +0000
X-Mizu-Trace-ID: 8c75857ac0dd5ebd
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/5] sysctl: cover numeric bounds and table containers in KUnit
Date: Tue, 17 Nov 2026 00:07:34 +0800
Message-Id: <6a13aa6ca707258d39db6b8ccd0b432bb3410243.1794844686.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1794844686.git.wen.yang@linux.dev>
References: <cover.1794844686.git.wen.yang@linux.dev>
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

Add comprehensive KUnit test coverage for numeric bounds and table
containers without mutating live /proc/sys entries:

- Validate signed, unsigned and u8 numeric bounds across positive,
  negative, zero and boundary ranges.
- Test atomic array commits rejecting partial updates.
- Test dynamic range updates and sibling bounds.
- Test container recovery with sysctl_table_container() across
  multi-entry, per-entry, and copied table structures.
- Ensure SYSCTL_KUNIT_TEST depends on SYSCTL to prevent undefined
  symbol errors when building as a module without CONFIG_SYSCTL.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/sysctl-test.c | 776 +++++++++++++++++++++++++++++++++++++++++--
 lib/Kconfig.debug    |   1 +
 2 files changed, 757 insertions(+), 20 deletions(-)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 92f94ea28957..a48c2871e203 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -4,11 +4,27 @@
  */
 
 #include <kunit/test.h>
+#include <linux/jiffies.h>
+#include <linux/limits.h>
 #include <linux/sysctl.h>
+#if IS_ENABLED(CONFIG_NET)
+#endif
 
 #define KUNIT_PROC_READ 0
 #define KUNIT_PROC_WRITE 1
 
+/* data is the value; handlers recover the containing object from it. */
+#define SYSCTL_TEST_CTX(VALUE, NAME, MODE, HANDLER, CTX) \
+	{ \
+		.procname	= (NAME), \
+		.data		= &(VALUE), \
+		.maxlen		= sizeof(VALUE), \
+		.mode		= (MODE), \
+		.proc_handler	= (HANDLER), \
+		.min		= 0, \
+		.max		= ULONG_MAX, \
+	}
+
 /*
  * Test that proc_dointvec will not try to use a NULL .data field even when the
  * length is non-zero.
@@ -26,8 +42,8 @@ static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	};
 	/*
 	 * proc_dointvec expects a buffer in user space, so we allocate one. We
@@ -76,8 +92,8 @@ static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
 		.maxlen		= 0,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	};
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
@@ -119,8 +135,8 @@ static void sysctl_test_api_dointvec_table_len_is_zero(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	};
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
@@ -153,8 +169,8 @@ static void sysctl_test_api_dointvec_table_read_but_position_set(
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	};
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
@@ -188,8 +204,8 @@ static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	};
 	size_t len = 4;
 	loff_t pos = 0;
@@ -219,8 +235,8 @@ static void sysctl_test_dointvec_read_happy_single_negative(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	};
 	size_t len = 5;
 	loff_t pos = 0;
@@ -248,8 +264,8 @@ static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	};
 	char input[] = "9";
 	size_t len = sizeof(input) - 1;
@@ -278,8 +294,8 @@ static void sysctl_test_dointvec_write_happy_single_negative(struct kunit *test)
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	};
 	char input[] = "-9";
 	size_t len = sizeof(input) - 1;
@@ -310,8 +326,8 @@ static void sysctl_test_api_dointvec_write_single_less_int_min(
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	};
 	size_t max_len = 32, len = max_len;
 	loff_t pos = 0;
@@ -348,8 +364,8 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
+		.min		= 0,
+		.max		= 100,
 	};
 	size_t max_len = 32, len = max_len;
 	loff_t pos = 0;
@@ -367,6 +383,715 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
 }
 
+static void sysctl_test_entry_roundtrip(struct kunit *test,
+					const struct ctl_table *table, const char *input)
+{
+	char expected[32];
+	char *buffer = kunit_kzalloc(test, sizeof(expected), GFP_KERNEL);
+	size_t len = strlen(input);
+	loff_t pos = 0;
+
+	KUNIT_ASSERT_NOT_NULL(test, buffer);
+	KUNIT_ASSERT_LT(test, len, sizeof(expected) - 1);
+	memcpy(buffer, input, len);
+	KUNIT_ASSERT_EQ(test, table->proc_handler(table, KUNIT_PROC_WRITE,
+						  buffer, &len, &pos), 0);
+	KUNIT_EXPECT_EQ(test, len, strlen(input));
+	KUNIT_EXPECT_EQ(test, pos, strlen(input));
+
+	snprintf(expected, sizeof(expected), "%s\n", input);
+	memset(buffer, 0, sizeof(expected));
+	len = sizeof(expected) - 1;
+	pos = 0;
+	KUNIT_ASSERT_EQ(test, table->proc_handler(table, KUNIT_PROC_READ,
+						  buffer, &len, &pos), 0);
+	KUNIT_ASSERT_LT(test, len, sizeof(expected));
+	buffer[len] = '\0';
+	KUNIT_EXPECT_EQ(test, len, strlen(expected));
+	KUNIT_EXPECT_STREQ(test, buffer, expected);
+}
+
+/* A rejected write must not change any byte of the backing storage. */
+static void sysctl_test_entry_reject(struct kunit *test,
+				     const struct ctl_table *table, const char *input)
+{
+	void *saved = kunit_kmalloc(test, table->maxlen, GFP_KERNEL);
+	char *buffer = kunit_kstrdup(test, input, GFP_KERNEL);
+	size_t len = strlen(input);
+	loff_t pos = 0;
+
+	KUNIT_ASSERT_NOT_NULL(test, saved);
+	KUNIT_ASSERT_NOT_NULL(test, buffer);
+	memcpy(saved, table->data, table->maxlen);
+	KUNIT_EXPECT_EQ(test, table->proc_handler(table, KUNIT_PROC_WRITE,
+						  buffer, &len, &pos), -EINVAL);
+	KUNIT_EXPECT_MEMEQ(test, table->data, saved, table->maxlen);
+}
+
+/* Entries are full-range, lower-only, upper-only and explicitly zero-only. */
+enum sysctl_test_value_kind {
+	SYSCTL_TEST_VALUE_INT,
+	SYSCTL_TEST_VALUE_ULONG,
+	SYSCTL_TEST_VALUE_U8,
+};
+
+union sysctl_test_value {
+	int i;
+	unsigned long ul;
+	u8 b;
+};
+
+struct sysctl_test_range {
+	unsigned long min;
+	unsigned long max;
+};
+
+struct sysctl_test_limits {
+	proc_handler *handler;
+	size_t size;
+	enum sysctl_test_value_kind kind;
+	const struct sysctl_test_range *ranges;
+	size_t nranges;
+};
+
+static const struct sysctl_test_range int_limit_ranges[] = {
+	{ (unsigned long)INT_MIN, (unsigned long)INT_MAX },
+	{ 2, (unsigned long)INT_MAX },
+	{ (unsigned long)INT_MIN, 4 },
+	{ 0, 0 },
+};
+
+static const struct sysctl_test_range ulong_limit_ranges[] = {
+	{ 0, ULONG_MAX },
+	{ 2, ULONG_MAX },
+	{ 0, 4 },
+	{ 0, 0 },
+};
+
+static const struct sysctl_test_range u8_limit_ranges[] = {
+	{ 0, U8_MAX },
+	{ 2, U8_MAX },
+	{ 0, 4 },
+	{ 0, 0 },
+	{ 2, 4 },
+};
+
+static const struct sysctl_test_limits limit_tests[] = {
+	{
+		.handler = proc_dointvec_minmax,
+		.size = sizeof(int),
+		.kind = SYSCTL_TEST_VALUE_INT,
+		.ranges = int_limit_ranges,
+		.nranges = ARRAY_SIZE(int_limit_ranges),
+	},
+	{
+		.handler = proc_doulongvec_minmax,
+		.size = sizeof(unsigned long),
+		.kind = SYSCTL_TEST_VALUE_ULONG,
+		.ranges = ulong_limit_ranges,
+		.nranges = ARRAY_SIZE(ulong_limit_ranges),
+	},
+	{
+		.handler = proc_dou8vec_minmax,
+		.size = sizeof(u8),
+		.kind = SYSCTL_TEST_VALUE_U8,
+		.ranges = u8_limit_ranges,
+		.nranges = ARRAY_SIZE(u8_limit_ranges),
+	},
+};
+
+static unsigned long sysctl_test_value_get(const union sysctl_test_value *value,
+					   enum sysctl_test_value_kind kind)
+{
+	switch (kind) {
+	case SYSCTL_TEST_VALUE_INT:
+		return (unsigned long)(long)value->i;
+	case SYSCTL_TEST_VALUE_ULONG:
+		return value->ul;
+	case SYSCTL_TEST_VALUE_U8:
+		return value->b;
+	}
+	return 0;
+}
+
+static void sysctl_test_entry_range_limits(struct kunit *test,
+					   const struct ctl_table *entries,
+					   size_t nranges,
+					   const char *minimum,
+					   const char *maximum,
+					   const char *underflow,
+					   const char *overflow)
+{
+	sysctl_test_entry_roundtrip(test, &entries[0], minimum);
+	sysctl_test_entry_roundtrip(test, &entries[0], maximum);
+	sysctl_test_entry_reject(test, &entries[0], underflow);
+	sysctl_test_entry_reject(test, &entries[0], overflow);
+
+	sysctl_test_entry_roundtrip(test, &entries[1], "2");
+	sysctl_test_entry_roundtrip(test, &entries[1], maximum);
+	sysctl_test_entry_reject(test, &entries[1], "1");
+	sysctl_test_entry_reject(test, &entries[1], overflow);
+
+	sysctl_test_entry_roundtrip(test, &entries[2], minimum);
+	sysctl_test_entry_roundtrip(test, &entries[2], "4");
+	sysctl_test_entry_reject(test, &entries[2], "5");
+	sysctl_test_entry_reject(test, &entries[2], underflow);
+
+	sysctl_test_entry_roundtrip(test, &entries[3], "0");
+	sysctl_test_entry_reject(test, &entries[3], "1");
+	sysctl_test_entry_reject(test, &entries[3], "-1");
+
+	if (nranges > 4) {
+		sysctl_test_entry_roundtrip(test, &entries[4], "2");
+		sysctl_test_entry_roundtrip(test, &entries[4], "4");
+		sysctl_test_entry_reject(test, &entries[4], "1");
+		sysctl_test_entry_reject(test, &entries[4], "5");
+	}
+}
+
+static void sysctl_test_entry_limits(struct kunit *test)
+{
+	static const char *const names[] = {
+		"full", "lower", "upper", "zero", "both",
+	};
+	size_t t, i;
+
+	for (t = 0; t < ARRAY_SIZE(limit_tests); t++) {
+		const struct sysctl_test_limits *limits = &limit_tests[t];
+		union sysctl_test_value value = {};
+		struct ctl_table entries[5] = {};
+		char minimum[32], maximum[32], underflow[32], overflow[32];
+		unsigned long max_value;
+
+		for (i = 0; i < limits->nranges; i++) {
+			entries[i].procname = names[i];
+			entries[i].data = &value;
+			entries[i].maxlen = limits->size;
+			entries[i].mode = 0644;
+			entries[i].proc_handler = limits->handler;
+			entries[i].min = limits->ranges[i].min;
+			entries[i].max = limits->ranges[i].max;
+		}
+
+		switch (limits->kind) {
+		case SYSCTL_TEST_VALUE_INT:
+			snprintf(minimum, sizeof(minimum), "%d", INT_MIN);
+			snprintf(maximum, sizeof(maximum), "%d", INT_MAX);
+			snprintf(underflow, sizeof(underflow), "-%lu",
+				 (unsigned long)INT_MAX + 2);
+			snprintf(overflow, sizeof(overflow), "%lu",
+				 (unsigned long)INT_MAX + 1);
+			max_value = (unsigned long)INT_MAX;
+			break;
+		case SYSCTL_TEST_VALUE_ULONG:
+			snprintf(minimum, sizeof(minimum), "0");
+			snprintf(maximum, sizeof(maximum), "%lu", ULONG_MAX);
+			snprintf(underflow, sizeof(underflow), "-1");
+			snprintf(overflow, sizeof(overflow), "%lu0", ULONG_MAX);
+			max_value = ULONG_MAX;
+			break;
+		case SYSCTL_TEST_VALUE_U8:
+			snprintf(minimum, sizeof(minimum), "0");
+			snprintf(maximum, sizeof(maximum), "%u", U8_MAX);
+			snprintf(underflow, sizeof(underflow), "-1");
+			snprintf(overflow, sizeof(overflow), "%u", U8_MAX + 1);
+			max_value = U8_MAX;
+			break;
+		}
+
+		sysctl_test_entry_range_limits(test, entries, limits->nranges,
+					       minimum, maximum, underflow, overflow);
+		sysctl_test_entry_roundtrip(test, &entries[0], maximum);
+		KUNIT_EXPECT_EQ(test, sysctl_test_value_get(&value, limits->kind),
+				max_value);
+	}
+}
+
+static void sysctl_test_entry_array_no_partial_commit(struct kunit *test)
+{
+	int signed_data[] = { 2, 3 };
+	unsigned long long_data[] = { 2, 3 };
+	unsigned int unsigned_data[] = { 2, 3 };
+	u8 byte_data[] = { 2, 3 };
+	const struct ctl_table entries[] = {
+		{
+			.procname = "signed",
+			.data = &(signed_data),
+			.maxlen = sizeof(signed_data),
+			.mode = 0644,
+			.proc_handler = proc_dointvec_minmax,
+			.min = 2,
+			.max = 4,
+		},
+		{
+			.procname = "long",
+			.data = &(long_data),
+			.maxlen = sizeof(long_data),
+			.mode = 0644,
+			.proc_handler = proc_doulongvec_minmax,
+			.min = 2,
+			.max = 4,
+		},
+		{
+			.procname = "unsigned",
+			.data = &(unsigned_data),
+			.maxlen = sizeof(unsigned_data),
+			.mode = 0644,
+			.proc_handler = proc_douintvec_minmax,
+			.min = 0,
+			.max = UINT_MAX,
+		},
+		{
+			.procname = "byte",
+			.data = &(byte_data),
+			.maxlen = sizeof(byte_data),
+			.mode = 0644,
+			.proc_handler = proc_dou8vec_minmax,
+			.min = 0,
+			.max = U8_MAX,
+		},
+	};
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		sysctl_test_entry_reject(test, &entries[i], "4\t5");
+		sysctl_test_entry_reject(test, &entries[i], "4\t1");
+		sysctl_test_entry_reject(test, &entries[i], "4\tbad");
+		sysctl_test_entry_reject(test, &entries[i], "4\t-1");
+		sysctl_test_entry_roundtrip(test, &entries[i], "4\t2");
+	}
+	for (; i < ARRAY_SIZE(entries); i++) {
+		char buffer[32] = {};
+		size_t len = sizeof(buffer);
+		loff_t pos = 0;
+
+		sysctl_test_entry_reject(test, &entries[i], "4\t2");
+		KUNIT_EXPECT_EQ(test, entries[i].proc_handler(&entries[i],
+							      KUNIT_PROC_READ,
+							      buffer, &len, &pos),
+				-EINVAL);
+	}
+	KUNIT_EXPECT_EQ(test, signed_data[0], 4);
+	KUNIT_EXPECT_EQ(test, signed_data[1], 2);
+	KUNIT_EXPECT_EQ(test, long_data[0], 4UL);
+	KUNIT_EXPECT_EQ(test, long_data[1], 2UL);
+}
+
+/* Each wrapper reads the related bound anew and resolves data in a local copy. */
+static int sysctl_test_entry_write(struct kunit *test, const struct ctl_table *table,
+				   const char *input)
+{
+	char *buffer = kunit_kstrdup(test, input, GFP_KERNEL);
+	size_t len = strlen(input);
+	loff_t pos = 0;
+
+	if (!buffer)
+		return -ENOMEM;
+	return table->proc_handler(table, KUNIT_PROC_WRITE, buffer, &len, &pos);
+}
+
+/* Dynamic ranges refresh their limit on every call. */
+struct sysctl_test_dynamic {
+	union {
+		int i;
+		unsigned int u;
+		unsigned long l;
+		u8 b;
+	} value;
+	unsigned long min, max;
+	unsigned int calls;
+	proc_handler *handler;
+};
+
+static int sysctl_test_dynamic_handler(const struct ctl_table *table, int dir,
+				       void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_dynamic *ctx =
+		container_of(table->data, struct sysctl_test_dynamic, value);
+	struct ctl_table resolved = *table;
+
+	ctx->calls++;
+	resolved.data = &ctx->value;
+	resolved.maxlen = ctx->handler == proc_doulongvec_minmax ?
+			  sizeof(ctx->value.l) :
+			  ctx->handler == proc_dou8vec_minmax ? sizeof(ctx->value.b) :
+			  sizeof(ctx->value.i);
+	resolved.min = ctx->min;
+	resolved.max = ctx->max;
+	return ctx->handler(&resolved, dir, buffer, lenp, ppos);
+}
+
+static unsigned long sysctl_test_dynamic_read(const struct sysctl_test_dynamic *ctx)
+{
+	if (ctx->handler == proc_doulongvec_minmax)
+		return ctx->value.l;
+	if (ctx->handler == proc_douintvec_minmax)
+		return ctx->value.u;
+	if (ctx->handler == proc_dou8vec_minmax)
+		return ctx->value.b;
+	return (unsigned long)(long)ctx->value.i;
+}
+
+static void sysctl_test_dynamic_range(struct kunit *test)
+{
+	static proc_handler *const handlers[] = {
+		proc_dointvec_minmax, proc_douintvec_minmax,
+		proc_doulongvec_minmax, proc_dou8vec_minmax,
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(handlers); i++) {
+		struct sysctl_test_dynamic ctx = { .min = 2, .max = 4,
+						   .handler = handlers[i] };
+		const struct ctl_table table = SYSCTL_TEST_CTX(ctx.value, "dynamic",
+							       0644,
+							       sysctl_test_dynamic_handler,
+							       ctx);
+		sysctl_test_entry_roundtrip(test, &table, "4");
+		KUNIT_EXPECT_EQ(test, sysctl_test_dynamic_read(&ctx), 4UL);
+		KUNIT_EXPECT_GT(test, ctx.calls, 0U);
+
+		ctx.max = 2;
+		KUNIT_EXPECT_EQ(test, -EINVAL, sysctl_test_entry_write(test, &table, "3"));
+		KUNIT_EXPECT_EQ(test, sysctl_test_dynamic_read(&ctx), 4UL);
+
+		ctx.min = 3;
+		ctx.max = 4;
+		sysctl_test_entry_roundtrip(test, &table, "3");
+		KUNIT_EXPECT_EQ(test, sysctl_test_dynamic_read(&ctx), 3UL);
+		KUNIT_EXPECT_EQ(test, -EINVAL, sysctl_test_entry_write(test, &table, "2"));
+
+		ctx.min = 2;
+		ctx.max = 8;
+		sysctl_test_entry_roundtrip(test, &table, "8");
+		KUNIT_EXPECT_EQ(test, sysctl_test_dynamic_read(&ctx), 8UL);
+		KUNIT_EXPECT_GT(test, ctx.calls, 0U);
+		KUNIT_EXPECT_EQ(test, table.min, 0UL);
+		KUNIT_EXPECT_EQ(test, table.max, ULONG_MAX);
+	}
+}
+
+/* Sibling thresholds bound each other. */
+struct sysctl_test_sibling_long {
+	unsigned long high;
+	unsigned long low;
+};
+
+static int sysctl_test_high_long_handler(const struct ctl_table *table, int dir,
+					 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_sibling_long *ctx =
+		container_of(table->data, struct sysctl_test_sibling_long, high);
+	struct ctl_table resolved = *table;
+
+	resolved.data = &ctx->high;
+	resolved.maxlen = sizeof(ctx->high);
+	resolved.min = ctx->low;
+	resolved.max = ULONG_MAX;
+	return proc_doulongvec_minmax(&resolved, dir, buffer, lenp, ppos);
+}
+
+static int sysctl_test_low_long_handler(const struct ctl_table *table, int dir,
+					void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_sibling_long *ctx =
+		container_of(table->data, struct sysctl_test_sibling_long, low);
+	struct ctl_table resolved = *table;
+
+	resolved.data = &ctx->low;
+	resolved.maxlen = sizeof(ctx->low);
+	resolved.min = 0;
+	resolved.max = ctx->high;
+	return proc_doulongvec_minmax(&resolved, dir, buffer, lenp, ppos);
+}
+
+static void sysctl_test_runtime_sibling_bounds(struct kunit *test)
+{
+	struct sysctl_test_sibling_long ctx = { .high = 4, .low = 2 };
+	const struct ctl_table entries[] = {
+		SYSCTL_TEST_CTX(ctx.high, "high", 0644,
+				sysctl_test_high_long_handler, ctx),
+		SYSCTL_TEST_CTX(ctx.low, "low", 0644,
+				sysctl_test_low_long_handler, ctx),
+	};
+
+	sysctl_test_entry_roundtrip(test, &entries[0], "4");
+	KUNIT_EXPECT_EQ(test, -EINVAL, sysctl_test_entry_write(test, &entries[0], "1"));
+	KUNIT_EXPECT_EQ(test, ctx.high, 4UL);
+	sysctl_test_entry_roundtrip(test, &entries[1], "3");
+	KUNIT_EXPECT_EQ(test, ctx.low, 3UL);
+	KUNIT_EXPECT_EQ(test, -EINVAL, sysctl_test_entry_write(test, &entries[1], "5"));
+	KUNIT_EXPECT_EQ(test, ctx.low, 3UL);
+
+	ctx.low = 1;
+	sysctl_test_entry_roundtrip(test, &entries[0], "2");
+	KUNIT_EXPECT_EQ(test, ctx.high, 2UL);
+	KUNIT_EXPECT_EQ(test, -EINVAL, sysctl_test_entry_write(test, &entries[1], "3"));
+	KUNIT_EXPECT_EQ(test, ctx.low, 1UL);
+	sysctl_test_entry_roundtrip(test, &entries[1], "2");
+	KUNIT_EXPECT_EQ(test, ctx.low, 2UL);
+}
+
+/* Two object pointers supply value and limit without becoming bounds. */
+/* An owner embedded around the bound storage can be recovered with container_of(). */
+struct sysctl_test_owner {
+	int value;
+	int limit;
+};
+
+struct sysctl_test_holder {
+	struct sysctl_test_owner owner;
+};
+
+static int sysctl_test_owner_handler(const struct ctl_table *table, int dir,
+				     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_holder *holder =
+		container_of(table->data, struct sysctl_test_holder,
+			     owner.value);
+	struct sysctl_test_owner *owner = &holder->owner;
+	struct ctl_table tmp = *table;
+
+	tmp.data = &owner->value;
+	tmp.maxlen = sizeof(owner->value);
+	tmp.min = 0;
+	tmp.max = READ_ONCE(owner->limit);
+	return proc_dointvec_minmax(&tmp, dir, buffer, lenp, ppos);
+}
+
+static void sysctl_test_runtime_owner_from_data(struct kunit *test)
+{
+	struct sysctl_test_holder holder = { .owner.limit = 4 };
+	const struct ctl_table table = {
+		.procname = "owner",
+		.data = &(holder.owner.value),
+		.maxlen = sizeof(holder.owner.value),
+		.mode = 0644,
+		.proc_handler = sysctl_test_owner_handler,
+		.min = 0,
+		.max = ULONG_MAX,
+	};
+
+	sysctl_test_entry_roundtrip(test, &table, "4");
+	KUNIT_EXPECT_EQ(test, holder.owner.value, 4);
+	holder.owner.limit = 2;
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			sysctl_test_entry_write(test, &table, "3"));
+	KUNIT_EXPECT_EQ(test, holder.owner.value, 4);
+	holder.owner.limit = 8;
+	sysctl_test_entry_roundtrip(test, &table, "8");
+	KUNIT_EXPECT_EQ(test, holder.owner.value, 8);
+	KUNIT_EXPECT_PTR_EQ(test, table.data, &holder.owner.value);
+}
+
+struct sysctl_test_dynamic_jiffies {
+	int int_value;
+	unsigned long ulong_value;
+	int int_min;
+	int int_max;
+	unsigned long ulong_min;
+	unsigned long ulong_max;
+	unsigned int calls;
+};
+
+static int sysctl_test_dynamic_jiffies_int_handler(const struct ctl_table *table,
+						   int dir, void *buffer,
+						   size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_dynamic_jiffies *ctx =
+		container_of(table->data, struct sysctl_test_dynamic_jiffies,
+			     int_value);
+	struct ctl_table resolved = *table;
+
+	ctx->calls++;
+	resolved.data = &ctx->int_value;
+	resolved.maxlen = sizeof(ctx->int_value);
+	resolved.min = (unsigned long)(long)ctx->int_min;
+	resolved.max = (unsigned long)(long)ctx->int_max;
+	return proc_dointvec_ms_jiffies_minmax(&resolved, dir, buffer, lenp, ppos);
+}
+
+static int sysctl_test_dynamic_jiffies_ulong_handler(const struct ctl_table *table,
+						     int dir, void *buffer,
+						     size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_dynamic_jiffies *ctx =
+		container_of(table->data, struct sysctl_test_dynamic_jiffies,
+			     ulong_value);
+	struct ctl_table resolved = *table;
+
+	ctx->calls++;
+	resolved.data = &ctx->ulong_value;
+	resolved.maxlen = sizeof(ctx->ulong_value);
+	resolved.min = ctx->ulong_min;
+	resolved.max = ctx->ulong_max;
+	return proc_doulongvec_ms_jiffies_minmax(&resolved, dir, buffer, lenp, ppos);
+}
+
+static void sysctl_test_dynamic_jiffies_ranges(struct kunit *test)
+{
+	struct sysctl_test_dynamic_jiffies ctx = {
+		.int_min = HZ,
+		.int_max = 2 * HZ,
+		.ulong_min = HZ,
+		.ulong_max = 2 * HZ,
+	};
+	const struct ctl_table entries[] = {
+		SYSCTL_TEST_CTX(ctx.int_value, "jiffies_int", 0644,
+				sysctl_test_dynamic_jiffies_int_handler, ctx),
+		SYSCTL_TEST_CTX(ctx.ulong_value, "jiffies_ulong", 0644,
+				sysctl_test_dynamic_jiffies_ulong_handler, ctx),
+	};
+
+	sysctl_test_entry_roundtrip(test, &entries[0], "1000");
+	KUNIT_EXPECT_EQ(test, ctx.int_value, HZ);
+	ctx.int_max = HZ;
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			sysctl_test_entry_write(test, &entries[0], "1500"));
+	KUNIT_EXPECT_EQ(test, ctx.int_value, HZ);
+	ctx.int_min = 2 * HZ;
+	ctx.int_max = 2 * HZ;
+	sysctl_test_entry_roundtrip(test, &entries[0], "2000");
+	KUNIT_EXPECT_EQ(test, ctx.int_value, 2 * HZ);
+
+	sysctl_test_entry_roundtrip(test, &entries[1], "1000");
+	KUNIT_EXPECT_EQ(test, ctx.ulong_value, (unsigned long)HZ);
+	ctx.ulong_max = HZ;
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			sysctl_test_entry_write(test, &entries[1], "1500"));
+	KUNIT_EXPECT_EQ(test, ctx.ulong_value, (unsigned long)HZ);
+	ctx.ulong_min = 2UL * HZ;
+	ctx.ulong_max = 2UL * HZ;
+	sysctl_test_entry_roundtrip(test, &entries[1], "2000");
+	KUNIT_EXPECT_EQ(test, ctx.ulong_value, 2UL * HZ);
+	KUNIT_EXPECT_GT(test, ctx.calls, 0U);
+}
+
+/* sysctl_table_container() coverage for embedded, shared and per-entry tables. */
+
+#define TEST_ENTRIES		8
+
+struct sysctl_test_shared_context {
+	const struct ctl_table table[TEST_ENTRIES];
+	int shared;
+};
+
+struct sysctl_test_entry_context {
+	int value;
+	int limit;
+};
+
+struct sysctl_test_per_entry_context {
+	const struct ctl_table table[TEST_ENTRIES];
+	struct sysctl_test_entry_context entries[TEST_ENTRIES];
+};
+
+struct sysctl_test_two_tables {
+	const struct ctl_table device_dir[2];
+	int shared;
+	const struct ctl_table vars[4];
+};
+
+struct sysctl_test_handler_state {
+	const struct ctl_table table[4];
+	int calls;
+};
+
+static int sysctl_test_counting_handler(const struct ctl_table *table, int dir,
+					void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_handler_state *outer =
+		sysctl_table_container(table, struct sysctl_test_handler_state, table, 2);
+
+	(void)dir;
+	(void)buffer;
+	(void)lenp;
+	(void)ppos;
+	outer->calls++;
+	return 0;
+}
+
+static void sysctl_test_table_container_multi_entry(struct kunit *test)
+{
+	struct sysctl_test_shared_context outer = { .shared = 7 };
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(outer.table); i++) {
+		struct sysctl_test_shared_context *p;
+
+		p = sysctl_table_container(&outer.table[i],
+					   struct sysctl_test_shared_context, table, i);
+		KUNIT_EXPECT_PTR_EQ(test, p, &outer);
+		KUNIT_EXPECT_EQ(test, p->shared, 7);
+	}
+
+	{
+		const struct ctl_table *entry = &outer.table[3];
+		struct sysctl_test_shared_context *p;
+
+		p = sysctl_table_container(entry, struct sysctl_test_shared_context, table, 3);
+		KUNIT_EXPECT_PTR_EQ(test, p, &outer);
+	}
+}
+
+static void sysctl_test_table_container_per_entry_context(struct kunit *test)
+{
+	struct sysctl_test_per_entry_context outer;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(outer.entries); i++) {
+		struct sysctl_test_per_entry_context *p;
+
+		outer.entries[i].value = i * 10;
+		outer.entries[i].limit = i * 10 + 5;
+		p = sysctl_table_container(&outer.table[i],
+					   struct sysctl_test_per_entry_context, table, i);
+		KUNIT_EXPECT_PTR_EQ(test, p, &outer);
+		KUNIT_EXPECT_PTR_EQ(test, &p->entries[i], &outer.entries[i]);
+		KUNIT_EXPECT_EQ(test, p->entries[i].value, i * 10);
+		KUNIT_EXPECT_EQ(test, p->entries[i].limit, i * 10 + 5);
+	}
+}
+
+static void sysctl_test_table_container_two_arrays(struct kunit *test)
+{
+	struct sysctl_test_two_tables outer = { .shared = 3 };
+	struct sysctl_test_two_tables *p;
+
+	p = sysctl_table_container(&outer.device_dir[0],
+				   struct sysctl_test_two_tables, device_dir, 0);
+	KUNIT_EXPECT_PTR_EQ(test, p, &outer);
+
+	p = sysctl_table_container(&outer.vars[3], struct sysctl_test_two_tables, vars, 3);
+	KUNIT_EXPECT_PTR_EQ(test, p, &outer);
+	KUNIT_EXPECT_EQ(test, p->shared, 3);
+}
+
+static void sysctl_test_table_container_handler(struct kunit *test)
+{
+	struct sysctl_test_handler_state outer = { .calls = 5 };
+	int ret;
+
+	ret = sysctl_test_counting_handler(&outer.table[2], 0, NULL, NULL, NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, outer.calls, 6);
+}
+
+static void sysctl_test_table_container_copied_outer(struct kunit *test)
+{
+	struct sysctl_test_shared_context outer = { .shared = 123 };
+	struct sysctl_test_shared_context *copy;
+	struct sysctl_test_shared_context *p;
+
+	copy = kunit_kzalloc(test, sizeof(*copy), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, copy);
+	memcpy(copy, &outer, sizeof(outer));
+
+	p = sysctl_table_container(&copy->table[6], struct sysctl_test_shared_context, table, 6);
+	KUNIT_EXPECT_PTR_EQ(test, p, copy);
+	KUNIT_EXPECT_EQ(test, p->shared, 123);
+}
+
 static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
 	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
@@ -378,6 +1103,17 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	KUNIT_CASE(sysctl_test_entry_limits),
+	KUNIT_CASE(sysctl_test_entry_array_no_partial_commit),
+	KUNIT_CASE(sysctl_test_dynamic_range),
+	KUNIT_CASE(sysctl_test_runtime_sibling_bounds),
+	KUNIT_CASE(sysctl_test_runtime_owner_from_data),
+	KUNIT_CASE(sysctl_test_dynamic_jiffies_ranges),
+	KUNIT_CASE(sysctl_test_table_container_multi_entry),
+	KUNIT_CASE(sysctl_test_table_container_per_entry_context),
+	KUNIT_CASE(sysctl_test_table_container_two_arrays),
+	KUNIT_CASE(sysctl_test_table_container_handler),
+	KUNIT_CASE(sysctl_test_table_container_copied_outer),
 	{}
 };
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1dac2674a983..bda6ebb25471 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2847,6 +2847,7 @@ config RESOURCE_KUNIT_TEST
 config SYSCTL_KUNIT_TEST
 	tristate "KUnit test for sysctl" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	depends on SYSCTL
 	default KUNIT_ALL_TESTS
 	help
 	  This builds the proc sysctl unit test, which runs on boot.
-- 
2.25.1

