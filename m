Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.238
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205369;
	b=R8XR3l7ajrFe3sG1hyXMn3s4QcmslDmnA7vIknaqE1RVb2R8L8UJ6ifXSMo3T8yX9MgH
	 VWkp1A0cuxtxYfJGkEXg9JXdngCmhVEr7SyOjsRRj7jzPbopU6dagah4AJvJMB3zgeB8T
	 ob5oBBShulBrWIjF5R6q0+7EgTj2bj7126TaKFcou76sd9YbHEf9CSIsA5IH1a58X6Fot
	 P6Ri2F6/Ri9mEszp/x70zJxmE5mVJqFsPCdtYH+RjqfcTVPMDbCh02w+a6wDnN6taaXh5
	 +mihYciB/10VXBT9N2PhfOAm23roi61fPVo9QtG2zCN9jhNo64WdGT80aJx6cMNjRJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205369;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gr+FffybMoKTnzaG6ZAR8E+VcbDqxuoWTalkBsg0XwE=;
	b=Vvmz9OgBLiKBTiU5r72eRvmb3ukr5/Kxrd1ae+1Ls2bdMQcWC/bfGIyoTvtZ69S6mX9t
	 3QGTRo9638RbJfI0UdEOsA0I3W1jksf8mmS4GherBX0eABLAOpCwLMWPrba8UZ31UmB2r
	 NSiJ6S4dTCepac7W4jAYjNHZH+j9vou1SZNqzcxrFgb864prQ7/2DcPYTWDOiqVU1YIW3
	 3feUbyeL2LmBFRDzZmuxdiq/FAz0IHly253gYsMJZsWp+vl/MFoiYY4biRhNeC+l4Ioos
	 LN6qcosWME7S4G2FCRFBj6br772PGw/Bu/GySzOjg+0TV0c0LtxAdV8Z0Bb0iwmOCmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EIPoYy9N;
	arc=none smtp.remote-ip=95.215.58.238
Received: from mta1.migadu.com (out-238.mta1.migadu.com [95.215.58.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF613606A31A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF613606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EIPoYy9N
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Lwcocf08TuUY2qZwcshYxQ7Rgj7nIQ+06tZbHdoA2Cg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205367; v=1; x=1793810167;
 b=EIPoYy9NMKyCdwLYmbEtbNvafrl1TYwK+akJxV1io0NapV4Ns4MOWbdkZsbfTK2sLMb9SEaa
 x6qzxXy7VQVFxh57c0kjeKXPo87T6O/fTe0FBkoc/pT0a5gao2bpQnVn64o2pbboqenQeBFUJQf
 pngFE3Qv2+CmZjKM3skNlDdQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 17bde889dcd46300;
	Wed, 28 Oct 2026 16:36:07 +0000
X-Mizu-Trace-ID: 17bde889dcd46300
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/39] sysctl: cover priv in KUnit and the debug test module
Date: Thu, 29 Oct 2026 00:34:44 +0800
Message-Id: <0384433c6fd37d307100b5c8eaf33c6ec4b442ba.1793204511.git.wen.yang@linux.dev>
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

Add KUnit cases for priv: a standard handler must ignore it, registration
must reject priv with a standard handler, and a re-registered table must
keep both the value pointer and the context.

Move the debug module's dynamic-value entry to the same shape so it
exercises data-as-value and priv-as-context.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/sysctl-test.c | 72 ++++++++++++++++++++++++++++++++++++++++++++
 lib/test_sysctl.c    |  9 +++---
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index dd658ca18793..f9efc146f219 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -699,10 +699,56 @@ static int sysctl_test_entry_write(struct kunit *test, const struct ctl_table *t
  * entry must not change what is stored, so a stray context pointer cannot
  * redirect a write to the wrong address.
  */
+static void sysctl_test_priv_standard_handler(struct kunit *test)
+{
+	int value = 0;
+	struct sysctl_test_demo_ctx {
+		int marker;
+	} ctx = { .marker = -1 };
+	const struct ctl_table table = {
+		.procname = "standard",
+		.data = &value,
+		.maxlen = sizeof(value),
+		.mode = 0644,
+		.proc_handler = proc_dointvec_minmax,
+		.min = 0,
+		.max = 100,
+		.priv = &ctx,
+	};
+
+	sysctl_test_entry_roundtrip(test, &table, "42");
+	KUNIT_EXPECT_EQ(test, value, 42);
+	KUNIT_EXPECT_EQ(test, ctx.marker, -1);
+	KUNIT_EXPECT_PTR_EQ(test, table.data, &value);
+	KUNIT_EXPECT_PTR_EQ(test, table.priv, &ctx);
+}
+
 /*
  * Registration refuses priv on a standard handler: the context would be
  * silently ignored, which is always a configuration mistake.
  */
+static void sysctl_test_priv_standard_handler_reject(struct kunit *test)
+{
+	int value = 0;
+	struct sysctl_test_demo_ctx {
+		int marker;
+	} ctx = { .marker = -1 };
+	const struct ctl_table table = {
+		.procname = "invalid_priv",
+		.data = &value,
+		.maxlen = sizeof(value),
+		.mode = 0644,
+		.proc_handler = proc_dointvec_minmax,
+		.min = 0,
+		.max = 100,
+		.priv = &ctx,
+	};
+
+	KUNIT_EXPECT_PTR_EQ(test, NULL,
+			    register_sysctl_sz("sysctl_kunit_priv_invalid",
+					       &table, 1));
+}
+
 
 /*
  * A dynamic range wrapper reads its related limit through priv on each call
@@ -1159,6 +1205,29 @@ static void sysctl_test_context_registration_lifecycle(struct kunit *test)
  * at the caller-owned objects; the handler resolves storage through data and
  * context through priv on every call.
  */
+static void sysctl_test_priv_registration_lifecycle(struct kunit *test)
+{
+	struct sysctl_test_lifecycle ctx = {};
+	struct ctl_table table = SYSCTL_TEST_CTX(ctx.value, "priv_lifecycle",
+						 0644,
+						 sysctl_test_lifecycle_handler, ctx);
+	struct ctl_table_header *header;
+
+	header = register_sysctl_sz("sysctl_kunit_priv", &table, 1);
+	KUNIT_ASSERT_NOT_NULL(test, header);
+	kunit_add_action(test, sysctl_test_unregister_table, header);
+
+	sysctl_test_entry_roundtrip(test, &table, "23");
+	KUNIT_EXPECT_EQ(test, ctx.value, 23);
+	KUNIT_EXPECT_PTR_EQ(test, table.priv, &ctx);
+	KUNIT_EXPECT_PTR_EQ(test, table.data, &ctx.value);
+
+	kunit_release_action(test, sysctl_test_unregister_table, header);
+	sysctl_test_entry_roundtrip(test, &table, "17");
+	KUNIT_EXPECT_EQ(test, ctx.value, 17);
+	KUNIT_EXPECT_PTR_EQ(test, table.priv, &ctx);
+}
+
 /* Registration rejects numeric bounds that cannot represent the element type. */
 static void sysctl_test_context_registration_reject(struct kunit *test)
 {
@@ -1381,6 +1450,9 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	KUNIT_CASE(sysctl_test_priv_standard_handler),
+	KUNIT_CASE(sysctl_test_priv_standard_handler_reject),
+	KUNIT_CASE(sysctl_test_priv_registration_lifecycle),
 	KUNIT_CASE(sysctl_test_entry_null_handler),
 	KUNIT_CASE(sysctl_test_entry_explicit_handler),
 	KUNIT_CASE(sysctl_test_entry_int_limits),
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 1411896fdbd0..64c82fd53975 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -97,7 +97,7 @@ static struct test_sysctl_data test_data = {
 static int test_sysctl_dynamic_value(const struct ctl_table *table, int dir,
 				     void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct test_sysctl_range_context *context = table->data;
+	struct test_sysctl_range_context *context = table->priv;
 	struct ctl_table resolved = *table;
 
 	resolved.data = &context->value;
@@ -215,12 +215,11 @@ static const struct ctl_table test_table[] = {
 	},
 	{
 		.procname	= "dynamic_value",
-		.data		= &test_data.dynamic,
-		.maxlen		= sizeof(test_data.dynamic),
+		.data		= &test_data.dynamic.value,
+		.maxlen		= sizeof(test_data.dynamic.value),
 		.mode		= 0644,
 		.proc_handler	= test_sysctl_dynamic_value,
-		.min		= 0,
-		.max		= ULONG_MAX,
+		.priv		= &test_data.dynamic,
 	},
 	{
 		.procname	= "int_zero",
-- 
2.25.1

