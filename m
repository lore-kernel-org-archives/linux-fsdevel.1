Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78533AD8C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464007; cv=none; b=ZWtDT+q7niUpZXFz7dyATRSuqaWaZFhUsKdejna4K3+9vYNdV4keZuXvW3weumznwNOv9psf4wMMeGxhcCmXCcEgraIN/CQHVYvPD9JFWJaqW/pItKlRd/QossT4CeCfGZ1OllA0SeRkJ1S74eXBOsNTz2KEMLe0B9I5LwIJX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464007; c=relaxed/simple;
	bh=fixBGJo6M7fHUae/bxhYOGyJ0GgE18cVwn2C/iuzmIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEqNJYaisc9TRU9s+hoGa+jGjvk7iZGcz7Fk8+AdsaAZ650rc9+jM82DSMpXRzDSTzEMdggU6kXRW/nk297DR+Sh9/+Sh0XhURrpnxPSlQk4tNdZJgJevsOv3SD2hb2BYWi3DeposGttb9hj5x6kr1fguSVdQqSGCtNF7Je2uoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WbsUkHLP; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WbsUkHLP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774464000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaTNz46zEkUTNzfpveGw6ogtHadEbA20yWavHlcngfY=;
	b=WbsUkHLPqKIq7mNPNUCupDI5R3OERO3dOlxv2dTKYfo1X/r4bffu3YkOKELVqrGiUrWhQw
	hYAnsfqF+zMBpL4rURC4GysvZ+HoY9wY1T8vX10Lji4yvyZ59E4LrtUUOi6nFSStF4pW7h
	YehBT/NnXR/5cGEuz8cyJFyG7nYZulg=
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v5 2/2] sysctl: convert kernel/sysctl-test.c to use CTLTBL_ENTRY_XXX()
Date: Thu, 26 Mar 2026 02:39:16 +0800
Message-Id: <d2589e4a49044b0d857ee1b9da495ca73d19ae57.1774463505.git.wen.yang@linux.dev>
In-Reply-To: <cover.1774463505.git.wen.yang@linux.dev>
References: <cover.1774463505.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Replace open-coded struct ctl_table initialisers with the
CTLTBL_ENTRY_VNMR(), CTLTBL_ENTRY_VNMHR(), and CTLTBL_ENTRY_VNMHRL()
macros introduced in the previous patch.

Add a parameterized KUnit test case exercising all CTLTBL_ENTRY_XXX()
variants (V, VM, VMR, VN, VNM, VNMH) for int, u8, and bool types.
char[] (proc_dostring) requires CTLTBL_ENTRY_VNMH() with an explicit
handler since _Generic cannot dispatch on array types.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/sysctl-test.c | 237 +++++++++++++++++++++++++------------------
 1 file changed, 138 insertions(+), 99 deletions(-)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 92f94ea28957..3b37bb0516e3 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -15,20 +15,14 @@
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
+	/*
+	 * Here we are testing that proc_dointvec behaves correctly when
+	 * we give it a NULL .data field. Normally this would point to a
+	 * piece of memory where the value would be stored.
+	 */
+	struct ctl_table null_data_table = CTLTBL_ENTRY_VNMHR(
+			SYSCTL_NULL, "foo", 0644, proc_dointvec,
+			SYSCTL_ZERO, SYSCTL_ONE_HUNDRED);
 	/*
 	 * proc_dointvec expects a buffer in user space, so we allocate one. We
 	 * also need to cast it to __user so sparse doesn't get mad.
@@ -66,19 +60,14 @@ static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
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
+	/*
+	 * So .data is no longer NULL, but we tell proc_dointvec its
+	 * length is 0, so it still shouldn't try to use it.
+	 */
+	struct ctl_table data_maxlen_unset_table = CTLTBL_ENTRY_VNMHRL(
+			data, "foo", 0644, proc_dointvec,
+			SYSCTL_ZERO, SYSCTL_ONE_HUNDRED, 0);
+
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
 	size_t len;
@@ -113,15 +102,8 @@ static void sysctl_test_api_dointvec_table_len_is_zero(struct kunit *test)
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
+	struct ctl_table table = CTLTBL_ENTRY_VNMR(data, "foo",
+			0644, SYSCTL_ZERO, SYSCTL_ONE_HUNDRED);
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
 	/*
@@ -147,15 +129,8 @@ static void sysctl_test_api_dointvec_table_read_but_position_set(
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
+	struct ctl_table table = CTLTBL_ENTRY_VNMR(data, "foo", 0644,
+			SYSCTL_ZERO, SYSCTL_ONE_HUNDRED);
 	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
 							   GFP_USER);
 	/*
@@ -182,15 +157,8 @@ static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
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
+	struct ctl_table table = CTLTBL_ENTRY_VNMR(data, "foo", 0644,
+			SYSCTL_ZERO, SYSCTL_ONE_HUNDRED);
 	size_t len = 4;
 	loff_t pos = 0;
 	char *buffer = kunit_kzalloc(test, len, GFP_USER);
@@ -213,15 +181,8 @@ static void sysctl_test_dointvec_read_happy_single_negative(struct kunit *test)
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
+	struct ctl_table table = CTLTBL_ENTRY_VNMR(data, "foo", 0644,
+			SYSCTL_ZERO, SYSCTL_ONE_HUNDRED);
 	size_t len = 5;
 	loff_t pos = 0;
 	char *buffer = kunit_kzalloc(test, len, GFP_USER);
@@ -242,15 +203,8 @@ static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
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
+	struct ctl_table table = CTLTBL_ENTRY_VNMR(data, "foo", 0644,
+			SYSCTL_ZERO, SYSCTL_ONE_HUNDRED);
 	char input[] = "9";
 	size_t len = sizeof(input) - 1;
 	loff_t pos = 0;
@@ -272,15 +226,8 @@ static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
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
+	struct ctl_table table = CTLTBL_ENTRY_VNMR(data, "foo", 0644,
+			SYSCTL_ZERO, SYSCTL_ONE_HUNDRED);
 	char input[] = "-9";
 	size_t len = sizeof(input) - 1;
 	loff_t pos = 0;
@@ -304,15 +251,8 @@ static void sysctl_test_api_dointvec_write_single_less_int_min(
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
+	struct ctl_table table = CTLTBL_ENTRY_VNMR(data, "foo", 0644,
+			SYSCTL_ZERO, SYSCTL_ONE_HUNDRED);
 	size_t max_len = 32, len = max_len;
 	loff_t pos = 0;
 	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
@@ -342,15 +282,8 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
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
+	struct ctl_table table = CTLTBL_ENTRY_VNMR(data, "foo", 0644,
+			SYSCTL_ZERO, SYSCTL_ONE_HUNDRED);
 	size_t max_len = 32, len = max_len;
 	loff_t pos = 0;
 	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
@@ -367,6 +300,111 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
 }
 
+/*
+ * Test each CTLTBL_ENTRY_XXX() variant.  File-scope variables are required
+ * so that &var is a valid constant expression in a static initializer.
+ */
+static int  ctltbl_int;
+static u8   ctltbl_u8;
+static u8   ctltbl_u8_min, ctltbl_u8_max = 200;
+static bool ctltbl_bool;
+static char ctltbl_str[64];
+
+struct ctltbl_param {
+	const char       *desc;
+	struct ctl_table  table;    /* built by CTLTBL_ENTRY_XXX() */
+	struct ctl_table  expected; /* expected field values */
+};
+
+static const struct ctltbl_param ctltbl_cases[] = {
+	/* auto handler — int */
+	{
+		.desc  = "sysctl_test_api_ctltbl_entry_V_int",
+		.table = CTLTBL_ENTRY_V(ctltbl_int),
+		.expected = { .procname = "ctltbl_int", .mode = 0444,
+			      .data = &ctltbl_int, .maxlen = sizeof(int),
+			      .proc_handler = proc_dointvec },
+	},
+	{
+		.desc  = "sysctl_test_api_ctltbl_entry_VM_int",
+		.table = CTLTBL_ENTRY_VM(ctltbl_int, 0644),
+		.expected = { .procname = "ctltbl_int", .mode = 0644,
+			      .data = &ctltbl_int, .maxlen = sizeof(int),
+			      .proc_handler = proc_dointvec },
+	},
+	{
+		.desc  = "sysctl_test_api_ctltbl_entry_VMR_int",
+		.table = CTLTBL_ENTRY_VMR(ctltbl_int, 0644,
+					  SYSCTL_ZERO, SYSCTL_ONE_HUNDRED),
+		.expected = { .procname = "ctltbl_int", .mode = 0644,
+			      .data = &ctltbl_int, .maxlen = sizeof(int),
+			      .proc_handler = proc_dointvec_minmax },
+	},
+	{
+		.desc  = "sysctl_test_api_ctltbl_entry_VN_int",
+		.table = CTLTBL_ENTRY_VN(ctltbl_int, "my-sysctl"),
+		.expected = { .procname = "my-sysctl", .mode = 0444,
+			      .data = &ctltbl_int, .maxlen = sizeof(int),
+			      .proc_handler = proc_dointvec },
+	},
+	{
+		.desc  = "sysctl_test_api_ctltbl_entry_VNM_int",
+		.table = CTLTBL_ENTRY_VNM(ctltbl_int, "my-sysctl", 0644),
+		.expected = { .procname = "my-sysctl", .mode = 0644,
+			      .data = &ctltbl_int, .maxlen = sizeof(int),
+			      .proc_handler = proc_dointvec },
+	},
+	/* auto handler — u8 */
+	{
+		.desc  = "sysctl_test_api_ctltbl_entry_V_u8",
+		.table = CTLTBL_ENTRY_V(ctltbl_u8),
+		.expected = { .procname = "ctltbl_u8", .mode = 0444,
+			      .data = &ctltbl_u8, .maxlen = sizeof(u8),
+			      .proc_handler = proc_dou8vec_minmax },
+	},
+	{
+		.desc  = "sysctl_test_api_ctltbl_entry_VMR_u8",
+		.table = CTLTBL_ENTRY_VMR(ctltbl_u8, 0644,
+					  &ctltbl_u8_min, &ctltbl_u8_max),
+		.expected = { .procname = "ctltbl_u8", .mode = 0644,
+			      .data = &ctltbl_u8, .maxlen = sizeof(u8),
+			      .proc_handler = proc_dou8vec_minmax },
+	},
+	/* auto handler — bool */
+	{
+		.desc  = "sysctl_test_api_ctltbl_entry_V_bool",
+		.table = CTLTBL_ENTRY_V(ctltbl_bool),
+		.expected = { .procname = "ctltbl_bool", .mode = 0444,
+			      .data = &ctltbl_bool, .maxlen = sizeof(bool),
+			      .proc_handler = proc_dobool },
+	},
+	/* VNMH — char[] cannot be auto-dispatched by _Generic (each char[N]
+	 * is a distinct type); explicit handler is required for strings.
+	 * .maxlen must be sizeof(array), not sizeof(char *). */
+	{
+		.desc  = "sysctl_test_api_ctltbl_entry_VNMH_string",
+		.table = CTLTBL_ENTRY_VNMH(ctltbl_str, "foo", 0644,
+					   proc_dostring),
+		.expected = { .procname = "foo", .mode = 0644,
+			      .data = ctltbl_str, .maxlen = sizeof(ctltbl_str),
+			      .proc_handler = proc_dostring },
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(ctltbl, ctltbl_cases, desc);
+
+static void sysctl_test_api_ctltbl_entry(struct kunit *test)
+{
+	const struct ctltbl_param *p = test->param_value;
+
+	KUNIT_EXPECT_STREQ(test, p->expected.procname, p->table.procname);
+	KUNIT_EXPECT_EQ(test, p->expected.mode, p->table.mode);
+	KUNIT_EXPECT_PTR_EQ(test, p->expected.data, p->table.data);
+	KUNIT_EXPECT_EQ(test, p->expected.maxlen, p->table.maxlen);
+	KUNIT_EXPECT_PTR_EQ(test, p->expected.proc_handler,
+			p->table.proc_handler);
+}
+
 static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
 	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
@@ -378,6 +416,7 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	KUNIT_CASE_PARAM(sysctl_test_api_ctltbl_entry, ctltbl_gen_params),
 	{}
 };
 
-- 
2.25.1

