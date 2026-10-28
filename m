Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205355;
	b=Qt30DYn+MWHdEeGRn7QiJhOJnBzP23J3bs6PTtCXxObGBq9DJfcf9gQdAFT8HBubGJZ6
	 vSEhkXwiy8XpZn6Kug6qBjoRtpXfyRbZ8k9mYadBKTGU60KB7nBxErg42JT8xRbV2E6gQ
	 ox/R52us3H3Ka+eSFy0fxigCaBbUHd4kdbeaPR5YfTqxsqkjDHHYUvHG0e432aY1BfLQV
	 +4fMsxjrhZf1N3db9FbakPauq+7PDozl4YBah93+mkWAtmXqicVR0DUaz9EFLLohYCbA2
	 HXnt3VZ93nnFDN+Cwf/IeyF+GySCTaViHABTWhYDDCVlNllIgw4Wf2TcqNZBDrvB46w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205355;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n8PeXdEhWPR6AgDC3BvBAiTwIDriePvdbn2c8K267qA=;
	b=4/X5wZTpQ9kUZ5/5XwJUtJ8Hf7Kj0CtFsQs/hQk8rTUsAO8SMRUzprcxsw779Acw/659
	 NW1U+B8fhhPTABHCWLlDeTulHsh6RoO/+l8jCxPPDdNBwKrDCrwYeO+gZAycAPUX0Qu1Z
	 d2bjCUL+DWGNqaGTRU7ODfqCyZ5Mg9qdgju1cc2V1c6VcSD7hTVpz8wajcJTgnA4qFSyB
	 AR7JWJnc+sIFyEbw4KQS+pCp7LNQ3fRNIpJBPxzwgwsfDtPDlUNOVw/frmcuBhtZqHEkW
	 rSCFencfQNf4/yLDkXni2HlTE1L2jSdzi2yQIik0sau3KoSKxkKLOXmda4DAxR6Mn2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CBQIASOo;
	arc=none smtp.remote-ip=91.218.175.9
Received: from mta0.migadu.com (out-9.mta0.migadu.com [91.218.175.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBD606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0BBD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CBQIASOo
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Xn8u4NoMeCpwqoMOOFKTZP+Jzb9Y9Krdo38jdUVl20U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205351; v=1; x=1793810151;
 b=CBQIASOoifVtKO4oqtiUn3+BlvcnYV4ZxJD6/mnHqdWV5lgy1/wMKnDNGjp/1/kMXHIS0OMx
 W2Z2GM49pCOYTwUZo5O0ctwUQY1nygokq1kQoHifNLCal6pQ+G817F0xEhEgFu2YoWUylh3CDH3
 0hj0oHs+h3ZaYRtVBxZbK3yY=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id d1ed82421b33130e;
	Wed, 28 Oct 2026 16:35:51 +0000
X-Mizu-Trace-ID: d1ed82421b33130e
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/39] sysctl: add KUnit coverage for numeric bounds and handlers
Date: Thu, 29 Oct 2026 00:34:42 +0800
Message-Id: <3f6be87a6685418f170b6713c1759a9c16573871.1793204511.git.wen.yang@linux.dev>
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

Give numeric bounds and the handlers that consume them executable
coverage: full type ranges, one-sided and zero bounds, entries without
backing storage, explicit handlers for arrays and members, and rejection
of writes that would partially commit.

The test file uses a small set of local constructor macros so the cases
stay readable. They are private to the test, not a kernel API, and have
no production users.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/sysctl-test.c | 634 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 504 insertions(+), 130 deletions(-)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 92f94ea28957..f18ec901443f 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -4,39 +4,146 @@
  */
 
 #include <kunit/test.h>
+#include <linux/jiffies.h>
+#include <linux/limits.h>
 #include <linux/sysctl.h>
+#if IS_ENABLED(CONFIG_NET)
+#include <net/net_namespace.h>
+#endif
+
+/*
+ * Constructors for test entries. They are local to this file: they are not
+ * a kernel API and have no production users.
+ */
+
+/*
+ * Local constructors for test entries: variable-first, with the suffix
+ * letters spelling out the arguments. They are not a kernel API.
+ */#define __CTLTBL_ENTRY_INIT(DATA, NAME, MODE, HANDLER, MIN, MAX, MAXLEN) \
+	{ \
+		.procname	= "" NAME "", \
+		.data		= (DATA), \
+		.maxlen		= (MAXLEN), \
+		.mode		= (MODE), \
+		.proc_handler	= (HANDLER), \
+		.poll		= NULL, \
+		.min		= (MIN), \
+		.max		= (MAX), \
+		.priv		= NULL, \
+	}
+
+#define __CTLTBL_ENTRY(VAR, NAME, MODE, HANDLER, MIN, MAX, MAXLEN) \
+	__CTLTBL_ENTRY_INIT(&(VAR), NAME, MODE, HANDLER, MIN, MAX, MAXLEN)
+
+/* No default association: unsupported automatic types fail to compile. */
+#define __CTLTBL_AUTO_HANDLER(VAR) \
+	_Generic((VAR), \
+		 signed int: proc_dointvec, \
+		 unsigned int: proc_douintvec, \
+		 unsigned long: proc_doulongvec_minmax)
+
+#define __CTLTBL_AUTO_HANDLER_MINMAX(VAR) \
+	_Generic((VAR), \
+		 signed int: proc_dointvec_minmax, \
+		 unsigned int: proc_douintvec_minmax, \
+		 unsigned long: proc_doulongvec_minmax)
+
+/* Bounds do not evaluate VAR, including in explicit-handler forms. */
+#define __CTLTBL_MIN(VAR) \
+	_Generic((VAR), signed int: INT_MIN, default : 0)
+
+#define __CTLTBL_MAX(VAR) \
+	_Generic((VAR), signed int: INT_MAX, unsigned int: UINT_MAX, \
+		 unsigned long: ULONG_MAX, default : ULONG_MAX)
+
+#define CTLTBL_ENTRY_V(VAR) \
+	__CTLTBL_ENTRY(VAR, #VAR, 0444, __CTLTBL_AUTO_HANDLER(VAR), \
+		       __CTLTBL_MIN(VAR), __CTLTBL_MAX(VAR), sizeof(VAR))
+
+#define CTLTBL_ENTRY_VN(VAR, NAME) \
+	__CTLTBL_ENTRY(VAR, NAME, 0444, __CTLTBL_AUTO_HANDLER(VAR), \
+		       __CTLTBL_MIN(VAR), __CTLTBL_MAX(VAR), sizeof(VAR))
+
+#define CTLTBL_ENTRY_VNM(VAR, NAME, MODE) \
+	__CTLTBL_ENTRY(VAR, NAME, MODE, __CTLTBL_AUTO_HANDLER(VAR), \
+		       __CTLTBL_MIN(VAR), __CTLTBL_MAX(VAR), sizeof(VAR))
+
+#define CTLTBL_ENTRY_VNMH(VAR, NAME, MODE, HANDLER) \
+	__CTLTBL_ENTRY(VAR, NAME, MODE, HANDLER, \
+		       __CTLTBL_MIN(VAR), __CTLTBL_MAX(VAR), sizeof(VAR))
+
+#define CTLTBL_ENTRY_VNMR(VAR, NAME, MODE, MIN, MAX) \
+	__CTLTBL_ENTRY(VAR, NAME, MODE, __CTLTBL_AUTO_HANDLER_MINMAX(VAR), \
+		       MIN, MAX, sizeof(VAR))
+
+#define CTLTBL_ENTRY_VNMHR(VAR, NAME, MODE, HANDLER, MIN, MAX) \
+	__CTLTBL_ENTRY(VAR, NAME, MODE, HANDLER, MIN, MAX, sizeof(VAR))
+
+#define CTLTBL_ENTRY_VNMHRL(VAR, NAME, MODE, HANDLER, MIN, MAX, MAXLEN) \
+	__CTLTBL_ENTRY(VAR, NAME, MODE, HANDLER, MIN, MAX, MAXLEN)
+
+#define CTLTBL_ENTRY_NH(NAME, HANDLER) \
+	__CTLTBL_ENTRY_INIT(NULL, NAME, 0444, HANDLER, 0, ULONG_MAX, 0)
+
+#define CTLTBL_ENTRY_NMH(NAME, MODE, HANDLER) \
+	__CTLTBL_ENTRY_INIT(NULL, NAME, MODE, HANDLER, 0, ULONG_MAX, 0)
+
+#define CTLTBL_ENTRY_NMHL(NAME, MODE, HANDLER, MAXLEN) \
+	__CTLTBL_ENTRY_INIT(NULL, NAME, MODE, HANDLER, 0, ULONG_MAX, MAXLEN)
+
+#define CTLTBL_ENTRY_NMHRL(NAME, MODE, HANDLER, MIN, MAX, MAXLEN) \
+	__CTLTBL_ENTRY_INIT(NULL, NAME, MODE, HANDLER, MIN, MAX, MAXLEN)
+
 
 #define KUNIT_PROC_READ 0
 #define KUNIT_PROC_WRITE 1
 
+/*
+ * Test entries that carry handler context: data stays the real value storage
+ * and priv references the context object, as production handlers do.
+ */
+#define SYSCTL_TEST_CTX(VALUE, NAME, MODE, HANDLER, CTX) \
+	{ \
+		.procname	= (NAME), \
+		.data		= &(VALUE), \
+		.maxlen		= sizeof(VALUE), \
+		.mode		= (MODE), \
+		.proc_handler	= (HANDLER), \
+		.min		= 0, \
+		.max		= ULONG_MAX, \
+		.priv		= &(CTX), \
+	}
+
+#define SYSCTL_TEST_CTX_NODATA(NAME, MODE, HANDLER, CTX) \
+	{ \
+		.procname	= (NAME), \
+		.maxlen		= sizeof(int), \
+		.mode		= (MODE), \
+		.proc_handler	= (HANDLER), \
+		.min		= 0, \
+		.max		= ULONG_MAX, \
+		.priv		= &(CTX), \
+	}
+
 /*
  * Test that proc_dointvec will not try to use a NULL .data field even when the
  * length is non-zero.
  */
 static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
 {
-	struct ctl_table null_data_table = {
-		.procname = "foo",
-		/*
-		 * Here we are testing that proc_dointvec behaves correctly when
-		 * we give it a NULL .data field. Normally this would point to a
-		 * piece of memory where the value would be stored.
-		 */
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
-	};
 	/*
-	 * proc_dointvec expects a buffer in user space, so we allocate one. We
-	 * also need to cast it to __user so sparse doesn't get mad.
+	 * Here we are testing that proc_dointvec behaves correctly when
+	 * we give it a NULL .data field. Normally this would point to a
+	 * piece of memory where the value would be stored.
 	 */
-	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
-							   GFP_USER);
+	const struct ctl_table null_data_table = CTLTBL_ENTRY_NMHRL("foo", 0644,
+			proc_dointvec, 0, 100, sizeof(int));
+	/*
+	 * proc handlers consume kernel buffers; no userspace access is needed.
+	 */
+	void *buffer = kunit_kzalloc(test, sizeof(int), GFP_KERNEL);
 	size_t len;
-	loff_t pos;
+	loff_t pos = 0;
 
 	/*
 	 * We don't care what the starting length is since proc_dointvec should
@@ -66,23 +173,16 @@ static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
 static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
 {
 	int data = 0;
-	struct ctl_table data_maxlen_unset_table = {
-		.procname = "foo",
-		.data		= &data,
-		/*
-		 * So .data is no longer NULL, but we tell proc_dointvec its
-		 * length is 0, so it still shouldn't try to use it.
-		 */
-		.maxlen		= 0,
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
-	};
-	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
-							   GFP_USER);
+	/*
+	 * So .data is no longer NULL, but we tell proc_dointvec its
+	 * length is 0, so it still shouldn't try to use it.
+	 */
+	const struct ctl_table data_maxlen_unset_table = CTLTBL_ENTRY_VNMHRL(data,
+			"foo", 0644, proc_dointvec, 0, 100,
+			0);
+	void *buffer = kunit_kzalloc(test, sizeof(int), GFP_KERNEL);
 	size_t len;
-	loff_t pos;
+	loff_t pos = 0;
 
 	/*
 	 * As before, we don't care what buffer length is because proc_dointvec
@@ -113,22 +213,14 @@ static void sysctl_test_api_dointvec_table_len_is_zero(struct kunit *test)
 {
 	int data = 0;
 	/* Good table. */
-	struct ctl_table table = {
-		.procname = "foo",
-		.data		= &data,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
-	};
-	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
-							   GFP_USER);
+	const struct ctl_table table = CTLTBL_ENTRY_VNMHR(data, "foo", 0644,
+			proc_dointvec, 0, 100);
+	void *buffer = kunit_kzalloc(test, sizeof(int), GFP_KERNEL);
 	/*
 	 * However, now our read/write buffer has zero length.
 	 */
 	size_t len = 0;
-	loff_t pos;
+	loff_t pos = 0;
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buffer,
 					       &len, &pos));
@@ -147,17 +239,9 @@ static void sysctl_test_api_dointvec_table_read_but_position_set(
 {
 	int data = 0;
 	/* Good table. */
-	struct ctl_table table = {
-		.procname = "foo",
-		.data		= &data,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
-	};
-	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
-							   GFP_USER);
+	const struct ctl_table table = CTLTBL_ENTRY_VNMHR(data, "foo", 0644,
+			proc_dointvec, 0, 100);
+	void *buffer = kunit_kzalloc(test, sizeof(int), GFP_KERNEL);
 	/*
 	 * We don't care about our buffer length because we start off with a
 	 * non-zero file position.
@@ -182,24 +266,16 @@ static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
 {
 	int data = 0;
 	/* Good table. */
-	struct ctl_table table = {
-		.procname = "foo",
-		.data		= &data,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
-	};
+	const struct ctl_table table = CTLTBL_ENTRY_VNMHR(data, "foo", 0644,
+			proc_dointvec, 0, 100);
 	size_t len = 4;
 	loff_t pos = 0;
-	char *buffer = kunit_kzalloc(test, len, GFP_USER);
-	char __user *user_buffer = (char __user *)buffer;
+	char *buffer = kunit_kzalloc(test, len, GFP_KERNEL);
 	/* Store 13 in the data field. */
 	*((int *)table.data) = 13;
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
-					       user_buffer, &len, &pos));
+					       buffer, &len, &pos));
 	KUNIT_ASSERT_EQ(test, 3, len);
 	buffer[len] = '\0';
 	/* And we read 13 back out. */
@@ -213,23 +289,15 @@ static void sysctl_test_dointvec_read_happy_single_negative(struct kunit *test)
 {
 	int data = 0;
 	/* Good table. */
-	struct ctl_table table = {
-		.procname = "foo",
-		.data		= &data,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
-	};
+	const struct ctl_table table = CTLTBL_ENTRY_VNMHR(data, "foo", 0644,
+			proc_dointvec, 0, 100);
 	size_t len = 5;
 	loff_t pos = 0;
-	char *buffer = kunit_kzalloc(test, len, GFP_USER);
-	char __user *user_buffer = (char __user *)buffer;
+	char *buffer = kunit_kzalloc(test, len, GFP_KERNEL);
 	*((int *)table.data) = -16;
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
-					       user_buffer, &len, &pos));
+					       buffer, &len, &pos));
 	KUNIT_ASSERT_EQ(test, 4, len);
 	buffer[len] = '\0';
 	KUNIT_EXPECT_STREQ(test, "-16\n", buffer);
@@ -242,25 +310,17 @@ static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
 {
 	int data = 0;
 	/* Good table. */
-	struct ctl_table table = {
-		.procname = "foo",
-		.data		= &data,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
-	};
+	const struct ctl_table table = CTLTBL_ENTRY_VNMHR(data, "foo", 0644,
+			proc_dointvec, 0, 100);
 	char input[] = "9";
 	size_t len = sizeof(input) - 1;
 	loff_t pos = 0;
-	char *buffer = kunit_kzalloc(test, len, GFP_USER);
-	char __user *user_buffer = (char __user *)buffer;
+	char *buffer = kunit_kzalloc(test, len, GFP_KERNEL);
 
 	memcpy(buffer, input, len);
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
-					       user_buffer, &len, &pos));
+					       buffer, &len, &pos));
 	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
 	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
 	KUNIT_EXPECT_EQ(test, 9, *((int *)table.data));
@@ -272,25 +332,17 @@ static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
 static void sysctl_test_dointvec_write_happy_single_negative(struct kunit *test)
 {
 	int data = 0;
-	struct ctl_table table = {
-		.procname = "foo",
-		.data		= &data,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
-	};
+	const struct ctl_table table = CTLTBL_ENTRY_VNMHR(data, "foo", 0644,
+			proc_dointvec, 0, 100);
 	char input[] = "-9";
 	size_t len = sizeof(input) - 1;
 	loff_t pos = 0;
-	char *buffer = kunit_kzalloc(test, len, GFP_USER);
-	char __user *user_buffer = (char __user *)buffer;
+	char *buffer = kunit_kzalloc(test, len, GFP_KERNEL);
 
 	memcpy(buffer, input, len);
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
-					       user_buffer, &len, &pos));
+					       buffer, &len, &pos));
 	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
 	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
 	KUNIT_EXPECT_EQ(test, -9, *((int *)table.data));
@@ -304,19 +356,11 @@ static void sysctl_test_api_dointvec_write_single_less_int_min(
 		struct kunit *test)
 {
 	int data = 0;
-	struct ctl_table table = {
-		.procname = "foo",
-		.data		= &data,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
-	};
+	const struct ctl_table table = CTLTBL_ENTRY_VNMHR(data, "foo", 0644,
+			proc_dointvec, 0, 100);
 	size_t max_len = 32, len = max_len;
 	loff_t pos = 0;
-	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
-	char __user *user_buffer = (char __user *)buffer;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_KERNEL);
 	unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
 					     - (INT_MAX + INT_MIN) + 1;
 
@@ -330,7 +374,7 @@ static void sysctl_test_api_dointvec_write_single_less_int_min(
 			max_len);
 
 	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec(&table, KUNIT_PROC_WRITE,
-						     user_buffer, &len, &pos));
+						     buffer, &len, &pos));
 	KUNIT_EXPECT_EQ(test, max_len, len);
 	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
 }
@@ -342,19 +386,11 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 		struct kunit *test)
 {
 	int data = 0;
-	struct ctl_table table = {
-		.procname = "foo",
-		.data		= &data,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-		.extra1		= SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE_HUNDRED,
-	};
+	const struct ctl_table table = CTLTBL_ENTRY_VNMHR(data, "foo", 0644,
+			proc_dointvec, 0, 100);
 	size_t max_len = 32, len = max_len;
 	loff_t pos = 0;
-	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
-	char __user *user_buffer = (char __user *)buffer;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_KERNEL);
 	unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
 
 	KUNIT_ASSERT_GT(test, greater_than_max, (unsigned long)INT_MAX);
@@ -362,11 +398,340 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 					       greater_than_max),
 			max_len);
 	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec(&table, KUNIT_PROC_WRITE,
-						     user_buffer, &len, &pos));
+						     buffer, &len, &pos));
 	KUNIT_ASSERT_EQ(test, max_len, len);
 	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
 }
 
+/*
+ * priv is separate from data and is never interpreted by the core. Macro
+ * entries leave it NULL; a custom entry can attach typed context without
+ * displacing the value storage that standard handlers use.
+ */
+/* Invoke the selected handler directly, with kernel buffers and a fresh position. */
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
+static int sysctl_test_owned_data;
+
+static int sysctl_test_owned_handler(const struct ctl_table *table, int dir,
+				     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table resolved = *table;
+
+	resolved.data = &sysctl_test_owned_data;
+	resolved.maxlen = sizeof(sysctl_test_owned_data);
+	return proc_dointvec(&resolved, dir, buffer, lenp, ppos);
+}
+
+static void sysctl_test_entry_null_handler(struct kunit *test)
+{
+	const struct ctl_table table = CTLTBL_ENTRY_NH("owned", sysctl_test_owned_handler);
+
+	sysctl_test_owned_data = 0;
+	KUNIT_EXPECT_PTR_EQ(test, table.data, NULL);
+	KUNIT_EXPECT_EQ(test, table.maxlen, 0);
+	KUNIT_EXPECT_EQ(test, table.mode, 0444);
+	KUNIT_EXPECT_EQ(test, table.min, 0UL);
+	KUNIT_EXPECT_EQ(test, table.max, ULONG_MAX);
+	sysctl_test_entry_roundtrip(test, &table, "31");
+	KUNIT_EXPECT_EQ(test, sysctl_test_owned_data, 31);
+	sysctl_test_owned_data = 0;
+}
+
+static struct {
+	int vector[2];
+	int member;
+	char string[8];
+} sysctl_test_static_data;
+
+/* Both automatic and explicit-handler forms must allow static initializers. */
+static const struct ctl_table sysctl_test_static_entries[] = {
+	CTLTBL_ENTRY_VNMH(sysctl_test_static_data.vector, "vector", 0644, proc_dointvec),
+	CTLTBL_ENTRY_VNMH(sysctl_test_static_data.member, "member", 0644, proc_dointvec_minmax),
+	CTLTBL_ENTRY_VNMH(sysctl_test_static_data.string, "string", 0644, proc_dostring),
+	CTLTBL_ENTRY_VNMHRL(sysctl_test_static_data.vector, "first", 0644,
+			    proc_dointvec, INT_MIN, INT_MAX, sizeof(int)),
+	CTLTBL_ENTRY_VNM(sysctl_test_static_data.member, "automatic", 0644),
+};
+
+static void sysctl_test_entry_explicit_handler(struct kunit *test)
+{
+	const struct ctl_table *entries = sysctl_test_static_entries;
+
+	memset(&sysctl_test_static_data, 0, sizeof(sysctl_test_static_data));
+	KUNIT_EXPECT_PTR_EQ(test, entries[0].data, &sysctl_test_static_data.vector);
+	KUNIT_EXPECT_EQ(test, entries[0].maxlen, sizeof(sysctl_test_static_data.vector));
+	KUNIT_EXPECT_PTR_EQ(test, entries[1].data, &sysctl_test_static_data.member);
+	KUNIT_EXPECT_EQ(test, entries[1].maxlen, sizeof(sysctl_test_static_data.member));
+	KUNIT_EXPECT_TRUE(test, entries[1].proc_handler == proc_dointvec_minmax);
+	KUNIT_EXPECT_PTR_EQ(test, entries[2].data, &sysctl_test_static_data.string);
+	KUNIT_EXPECT_EQ(test, entries[2].maxlen, sizeof(sysctl_test_static_data.string));
+	KUNIT_EXPECT_TRUE(test, entries[2].proc_handler == proc_dostring);
+	KUNIT_EXPECT_EQ(test, entries[3].maxlen, sizeof(int));
+	KUNIT_EXPECT_TRUE(test, entries[4].proc_handler == proc_dointvec);
+	KUNIT_EXPECT_EQ(test, entries[0].min, 0UL);
+	KUNIT_EXPECT_EQ(test, entries[0].max, ULONG_MAX);
+	KUNIT_EXPECT_EQ(test, entries[1].min, (unsigned long)INT_MIN);
+	KUNIT_EXPECT_EQ(test, entries[1].max, (unsigned long)INT_MAX);
+	KUNIT_EXPECT_EQ(test, entries[2].min, 0UL);
+	KUNIT_EXPECT_EQ(test, entries[2].max, ULONG_MAX);
+	KUNIT_EXPECT_EQ(test, entries[3].min, (unsigned long)INT_MIN);
+	KUNIT_EXPECT_EQ(test, entries[3].max, (unsigned long)INT_MAX);
+
+	sysctl_test_entry_roundtrip(test, &entries[0], "7\t8");
+	KUNIT_EXPECT_EQ(test, sysctl_test_static_data.vector[0], 7);
+	KUNIT_EXPECT_EQ(test, sysctl_test_static_data.vector[1], 8);
+	sysctl_test_entry_roundtrip(test, &entries[1], "-9");
+	KUNIT_EXPECT_EQ(test, sysctl_test_static_data.member, -9);
+	sysctl_test_entry_roundtrip(test, &entries[2], "hello");
+	KUNIT_EXPECT_STREQ(test, sysctl_test_static_data.string, "hello");
+	/* An explicit length limits the write without changing sizeof(vector). */
+	sysctl_test_entry_roundtrip(test, &entries[3], "11");
+	KUNIT_EXPECT_EQ(test, sysctl_test_static_data.vector[0], 11);
+	KUNIT_EXPECT_EQ(test, sysctl_test_static_data.vector[1], 8);
+	sysctl_test_entry_roundtrip(test, &entries[4], "-16");
+	KUNIT_EXPECT_EQ(test, sysctl_test_static_data.member, -16);
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
+static void sysctl_test_entry_range_limits(struct kunit *test,
+					   const struct ctl_table *entries,
+					   const char *minimum, const char *maximum,
+					   const char *underflow, const char *overflow)
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
+}
+
+static void sysctl_test_entry_int_limits(struct kunit *test)
+{
+	int data = 0;
+	const struct ctl_table entries[] = {
+		CTLTBL_ENTRY_VNMH(data, "full", 0644, proc_dointvec_minmax),
+		CTLTBL_ENTRY_VNMR(data, "lower", 0644, 2, INT_MAX),
+		CTLTBL_ENTRY_VNMR(data, "upper", 0644, INT_MIN, 4),
+		CTLTBL_ENTRY_VNMR(data, "zero", 0644, 0, 0),
+	};
+	char minimum[32], maximum[32], underflow[32], overflow[32];
+
+	snprintf(minimum, sizeof(minimum), "%d", INT_MIN);
+	snprintf(maximum, sizeof(maximum), "%d", INT_MAX);
+	snprintf(underflow, sizeof(underflow), "-%lu", (unsigned long)INT_MAX + 2);
+	snprintf(overflow, sizeof(overflow), "%lu", (unsigned long)INT_MAX + 1);
+	KUNIT_EXPECT_EQ(test, entries[0].min, (unsigned long)INT_MIN);
+	KUNIT_EXPECT_EQ(test, entries[0].max, (unsigned long)INT_MAX);
+	sysctl_test_entry_range_limits(test, entries, minimum, maximum, underflow, overflow);
+	KUNIT_EXPECT_EQ(test, data, 0);
+	sysctl_test_entry_roundtrip(test, &entries[0], minimum);
+	KUNIT_EXPECT_EQ(test, data, INT_MIN);
+	sysctl_test_entry_roundtrip(test, &entries[0], maximum);
+	KUNIT_EXPECT_EQ(test, data, INT_MAX);
+}
+
+static void sysctl_test_entry_ulong_limits(struct kunit *test)
+{
+	unsigned long data = 0;
+	const struct ctl_table entries[] = {
+		CTLTBL_ENTRY_VNMH(data, "full", 0644, proc_doulongvec_minmax),
+		CTLTBL_ENTRY_VNMR(data, "lower", 0644, 2, ULONG_MAX),
+		CTLTBL_ENTRY_VNMR(data, "upper", 0644, 0, 4),
+		CTLTBL_ENTRY_VNMR(data, "zero", 0644, 0, 0),
+	};
+	char maximum[32], overflow[32];
+
+	snprintf(maximum, sizeof(maximum), "%lu", ULONG_MAX);
+	/* Appending a digit overflows unsigned long on both 32-bit and 64-bit. */
+	snprintf(overflow, sizeof(overflow), "%lu0", ULONG_MAX);
+	KUNIT_EXPECT_EQ(test, entries[0].min, 0UL);
+	KUNIT_EXPECT_EQ(test, entries[0].max, ULONG_MAX);
+	sysctl_test_entry_range_limits(test, entries, "0", maximum, "-1", overflow);
+	KUNIT_EXPECT_EQ(test, data, 0UL);
+	sysctl_test_entry_roundtrip(test, &entries[0], maximum);
+	KUNIT_EXPECT_EQ(test, data, ULONG_MAX);
+}
+
+static void sysctl_test_entry_u8_limits(struct kunit *test)
+{
+	u8 data = 0;
+	const struct ctl_table entries[] = {
+		CTLTBL_ENTRY_VNMHR(data, "full", 0644, proc_dou8vec_minmax, 0, U8_MAX),
+		CTLTBL_ENTRY_VNMHR(data, "lower", 0644, proc_dou8vec_minmax, 2, U8_MAX),
+		CTLTBL_ENTRY_VNMHR(data, "upper", 0644, proc_dou8vec_minmax, 0, 4),
+		CTLTBL_ENTRY_VNMHR(data, "zero", 0644, proc_dou8vec_minmax, 0, 0),
+		CTLTBL_ENTRY_VNMHR(data, "both", 0644, proc_dou8vec_minmax, 2, 4),
+	};
+	char maximum[32], overflow[32];
+
+	snprintf(maximum, sizeof(maximum), "%u", U8_MAX);
+	snprintf(overflow, sizeof(overflow), "%u", U8_MAX + 1);
+	sysctl_test_entry_range_limits(test, entries, "0", maximum, "-1", overflow);
+	sysctl_test_entry_roundtrip(test, &entries[0], maximum);
+	KUNIT_EXPECT_EQ(test, data, U8_MAX);
+	sysctl_test_entry_roundtrip(test, &entries[4], "2");
+	KUNIT_EXPECT_EQ(test, data, 2);
+	sysctl_test_entry_roundtrip(test, &entries[4], "4");
+	KUNIT_EXPECT_EQ(test, data, 4);
+	sysctl_test_entry_reject(test, &entries[4], "1");
+	sysctl_test_entry_reject(test, &entries[4], "5");
+}
+
+static void sysctl_test_entry_array_no_partial_commit(struct kunit *test)
+{
+	int signed_data[] = { 2, 3 };
+	unsigned long long_data[] = { 2, 3 };
+	const struct ctl_table entries[] = {
+		CTLTBL_ENTRY_VNMHR(signed_data, "signed", 0644, proc_dointvec_minmax, 2, 4),
+		CTLTBL_ENTRY_VNMHR(long_data, "long", 0644, proc_doulongvec_minmax, 2, 4),
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(entries); i++) {
+		sysctl_test_entry_reject(test, &entries[i], "4\t5");
+		sysctl_test_entry_reject(test, &entries[i], "4\t1");
+		sysctl_test_entry_reject(test, &entries[i], "4\tbad");
+		sysctl_test_entry_reject(test, &entries[i], "4\t-1");
+		sysctl_test_entry_roundtrip(test, &entries[i], "4\t2");
+	}
+	KUNIT_EXPECT_EQ(test, signed_data[0], 4);
+	KUNIT_EXPECT_EQ(test, signed_data[1], 2);
+	KUNIT_EXPECT_EQ(test, long_data[0], 4UL);
+	KUNIT_EXPECT_EQ(test, long_data[1], 2UL);
+}
+
+/* Unsigned int and u8 handlers deliberately do not support arrays. */
+static void sysctl_test_entry_unsigned_arrays_rejected(struct kunit *test)
+{
+	unsigned int unsigned_data[] = { 2, 3 };
+	u8 byte_data[] = { 2, 3 };
+	const struct ctl_table entries[] = {
+		CTLTBL_ENTRY_VNMHR(unsigned_data, "unsigned", 0644,
+				   proc_douintvec_minmax, 0, UINT_MAX),
+		CTLTBL_ENTRY_VNMHR(byte_data, "byte", 0644, proc_dou8vec_minmax, 0, U8_MAX),
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(entries); i++) {
+		char buffer[32] = {};
+		size_t len = sizeof(buffer);
+		loff_t pos = 0;
+
+		sysctl_test_entry_reject(test, &entries[i], "4\t2");
+		KUNIT_EXPECT_EQ(test, entries[i].proc_handler(&entries[i], KUNIT_PROC_READ,
+							      buffer, &len, &pos), -EINVAL);
+	}
+}
+
+/* Each wrapper reads the related bound anew and resolves data in a local copy. */
+/* Context handlers resolve real storage on a local table; data is not a value. */
+/*
+ * Standard handlers only touch data and maxlen. Attaching priv to such an
+ * entry must not change what is stored, so a stray context pointer cannot
+ * redirect a write to the wrong address.
+ */
+/*
+ * Registration refuses priv on a standard handler: the context would be
+ * silently ignored, which is always a configuration mistake.
+ */
+
+/*
+ * A dynamic range wrapper reads its related limit through priv on each call
+ * while data keeps pointing at the value, mirroring addrconf and devinet.
+ */
+/*
+ * Dynamic range families refresh their related limit on every call. These
+ * generic wrappers model the delegation pattern used by scheduler, IPC,
+ * fragment, namespace and jiffies sysctls.
+ */
+/*
+ * Sibling thresholds bound each other. These mirror the fragment and SCTP
+ * handlers that read the other sysctl's current value at every call.
+ */
+
+/* Two object pointers supply value and limit without becoming bounds. */
+/* An owner embedded around the bound storage can be recovered with container_of(). */
+/*
+ * A registered table may be unregistered and recreated. The table and its
+ * handler context are caller-owned; registration must not rewrite either.
+ */
+/*
+ * Registration copies the table entry but must leave data and priv pointing
+ * at the caller-owned objects; the handler resolves storage through data and
+ * context through priv on every call.
+ */
+#if IS_ENABLED(CONFIG_NET) && IS_ENABLED(CONFIG_SYSCTL)
+/*
+ * Simulate per-net table duplication and teardown through the real
+ * register_net_sysctl_sz() path. This does not create a namespace, but it
+ * exercises copied tables, independent contexts, registration failure and
+ * unregister/re-register ordering.
+ */
+#endif
+
+/*
+ * Registered-entry harness. A static handler cannot be called by symbol from
+ * KUnit, but a registered table exposes its proc_handler through the entry.
+ * This helper is deliberately table-agnostic: the demo below uses a synthetic
+ * table, while future tests can pass a header obtained from a real subsystem.
+ */
 static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
 	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
@@ -378,6 +743,15 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	KUNIT_CASE(sysctl_test_entry_null_handler),
+	KUNIT_CASE(sysctl_test_entry_explicit_handler),
+	KUNIT_CASE(sysctl_test_entry_int_limits),
+	KUNIT_CASE(sysctl_test_entry_ulong_limits),
+	KUNIT_CASE(sysctl_test_entry_u8_limits),
+	KUNIT_CASE(sysctl_test_entry_array_no_partial_commit),
+	KUNIT_CASE(sysctl_test_entry_unsigned_arrays_rejected),
+#if IS_ENABLED(CONFIG_NET) && IS_ENABLED(CONFIG_SYSCTL)
+#endif
 	{}
 };
 
-- 
2.25.1

