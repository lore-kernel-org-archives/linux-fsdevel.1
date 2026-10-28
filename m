Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205362;
	b=COWeDY+eqdGZznBHGmgM9QZvGygF9xu2fQua2S2Ey0Q6vT4ORYgusQd0cdScjKLBJhBI
	 SM/AB5gp4fysSJg0GHxs5zk5pT+jHcZZTuqSoQlY7hDx/aS7y9oS3GkB8H8s6Nbp8dk1l
	 wWBaCT1jQvqUYVHwoyFlQH/KqmFpSn3C53a8Eoj+UJ2+3ri3zQR853lLT/wXE3AXUClw0
	 67DWw08HmObRYk1U02SDqd11K6oz8eGsHzcnFhRRHJ+lsULHAAzTOdgo3dqzFDQOFhA5H
	 xjcFYTqaI7g/gUdxBw/UdYn7y4WHOmtAH3ICGHHJJP/E6nKR2412N25OF/6GtHNwHfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205362;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NCNRMJdhDMzO/2sWjC7Y+PROteYUpLgqhNZyUBTIsCU=;
	b=XllQAwqtMvjjZqpAULkdRnhOxCttwgY8kHSAkvIgwcgUsfGoisZY7e65SBwQDvpRf0fF
	 oNxZOthA+iLYh9uw7cJ8Da7WUQWSHvTqDL82oq8nj40jGgRS/mMySK6RW8ucl6WQKEP6I
	 ckknme40e0ncDuTQLYsMbfGE409aBL9hthWGSMirkTTs+m+7/0Ot9+99a8oFJdYT5Ofjx
	 8FK8XbGGccsZIVuLaYx+HDcdSvQtn4WjahJjHYb2h3Ox3s9/HFI1S5JqdgcaTtmvI/sch
	 AF1JttxAgpqE7DdcPvYsX+gm2f9u1ofgP5ASSdXl0fL0CSqKpxVeyv3vfFSnFy+aVHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xnP1YPcx;
	arc=none smtp.remote-ip=91.218.175.12
Received: from mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCF606A31D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FFCF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xnP1YPcx
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6Tu6gJPae9yI90JWFk+EVAW0ZpaoXiDj6r6Ej6+/foI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205359; v=1; x=1793810159;
 b=xnP1YPcx++Sah8GT6R16n2hB5rD01gl0GLdLEYvcuI6LcDDWKbiXF1bjBkCRYSJOBlG9MJQ2
 tzApGOx0F3HZxBD54x+Wvj6zmcshMZmZsWHecBVPKqV0epv9jQ9mzHDaCzdR47qY3277HakZkv1
 i4Ag0axZCuSfzZEeiFXshkTQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id cf995e9684743ee7;
	Wed, 28 Oct 2026 16:35:59 +0000
X-Mizu-Trace-ID: cf995e9684743ee7
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/39] sysctl: cover runtime ranges and context lifecycles in KUnit
Date: Thu, 29 Oct 2026 00:34:43 +0800
Message-Id: <49c0671b9ace2b1d1bbd8c7c602f29694a861b19.1793204511.git.wen.yang@linux.dev>
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

Exercise per-call refresh for scalar and jiffies range families,
including bounds reached through runtime pointers and sibling sysctls.
Verify typed object context, owner derivation and bool handling.

Simulate per-net table duplication through register_net_sysctl_sz():
independent contexts, registration failure, and unregister/re-register
with a replacement context. Add a registered-entry harness demo that
finds an entry in a registered table and invokes its proc_handler, so
static handlers can be tested without copying their implementation.
Also cover generic registration and invalid numeric bounds.

The KUnit module references both millisecond-jiffies range handlers, so
export the signed one alongside its unsigned long sibling.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/sysctl-test.c  | 651 ++++++++++++++++++++++++++++++++++++++++++
 kernel/time/jiffies.c |   1 +
 2 files changed, 652 insertions(+)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index f18ec901443f..dd658ca18793 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -682,6 +682,18 @@ static void sysctl_test_entry_unsigned_arrays_rejected(struct kunit *test)
 
 /* Each wrapper reads the related bound anew and resolves data in a local copy. */
 /* Context handlers resolve real storage on a local table; data is not a value. */
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
 /*
  * Standard handlers only touch data and maxlen. Attaching priv to such an
  * entry must not change what is stored, so a stray context pointer cannot
@@ -701,22 +713,464 @@ static void sysctl_test_entry_unsigned_arrays_rejected(struct kunit *test)
  * generic wrappers model the delegation pattern used by scheduler, IPC,
  * fragment, namespace and jiffies sysctls.
  */
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
+	struct sysctl_test_dynamic *ctx = table->priv;
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
+		const struct ctl_table table = SYSCTL_TEST_CTX_NODATA("dynamic",
+								     0644,
+								     sysctl_test_dynamic_handler,
+								     ctx);
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
+		KUNIT_EXPECT_PTR_EQ(test, table.priv, &ctx);
+		KUNIT_EXPECT_EQ(test, table.min, 0UL);
+		KUNIT_EXPECT_EQ(test, table.max, ULONG_MAX);
+	}
+}
+
+/* Runtime-bound pointers are dereferenced afresh on every handler call. */
+struct sysctl_test_bound_pointer {
+	int value;
+	int *limit;
+};
+
+static int sysctl_test_bound_pointer_handler(const struct ctl_table *table, int dir,
+					     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_bound_pointer *ctx = table->priv;
+	struct ctl_table resolved = *table;
+
+	resolved.data = &ctx->value;
+	resolved.maxlen = sizeof(ctx->value);
+	resolved.min = 0;
+	resolved.max = READ_ONCE(*ctx->limit);
+	return proc_dointvec_minmax(&resolved, dir, buffer, lenp, ppos);
+}
+
+static void sysctl_test_runtime_bound_pointer(struct kunit *test)
+{
+	int limit = 4;
+	struct sysctl_test_bound_pointer ctx = { .limit = &limit };
+	const struct ctl_table table = SYSCTL_TEST_CTX(ctx.value, "pointer_bound",
+						       0644, sysctl_test_bound_pointer_handler,
+						       ctx);
+
+	sysctl_test_entry_roundtrip(test, &table, "4");
+	KUNIT_EXPECT_EQ(test, ctx.value, 4);
+	limit = 2;
+	KUNIT_EXPECT_EQ(test, -EINVAL, sysctl_test_entry_write(test, &table, "3"));
+	KUNIT_EXPECT_EQ(test, ctx.value, 4);
+	limit = 8;
+	sysctl_test_entry_roundtrip(test, &table, "8");
+	KUNIT_EXPECT_EQ(test, ctx.value, 8);
+	KUNIT_EXPECT_PTR_EQ(test, table.priv, &ctx);
+	KUNIT_EXPECT_PTR_EQ(test, ctx.limit, &limit);
+}
+
 /*
  * Sibling thresholds bound each other. These mirror the fragment and SCTP
  * handlers that read the other sysctl's current value at every call.
  */
+struct sysctl_test_sibling_long {
+	unsigned long high;
+	unsigned long low;
+};
+
+static int sysctl_test_high_long_handler(const struct ctl_table *table, int dir,
+					 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_sibling_long *ctx = table->priv;
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
+	struct sysctl_test_sibling_long *ctx = table->priv;
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
+	KUNIT_EXPECT_PTR_EQ(test, entries[0].priv, &ctx);
+	KUNIT_EXPECT_PTR_EQ(test, entries[1].priv, &ctx);
+}
+
 
 /* Two object pointers supply value and limit without becoming bounds. */
+struct sysctl_test_object_state {
+	int value;
+	int limit;
+};
+
+struct sysctl_test_object_holder {
+	struct sysctl_test_object_state *owner;
+	struct sysctl_test_object_state *related;
+};
+
+static int sysctl_test_object_context_handler(const struct ctl_table *table,
+					      int dir, void *buffer,
+					      size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_object_holder *holder = table->priv;
+	struct ctl_table resolved = *table;
+
+	resolved.data = &holder->owner->value;
+	resolved.maxlen = sizeof(holder->owner->value);
+	resolved.min = 0;
+	resolved.max = READ_ONCE(holder->related->limit);
+	return proc_dointvec_minmax(&resolved, dir, buffer, lenp, ppos);
+}
+
+static void sysctl_test_runtime_object_context(struct kunit *test)
+{
+	struct sysctl_test_object_state owner = { .limit = 4 };
+	struct sysctl_test_object_state other = { .limit = 4 };
+	struct sysctl_test_object_holder holder = {
+		.owner = &owner,
+		.related = &other,
+	};
+	const struct ctl_table table = SYSCTL_TEST_CTX_NODATA("object_context", 0644,
+							      sysctl_test_object_context_handler,
+							      holder);
+
+	sysctl_test_entry_roundtrip(test, &table, "4");
+	KUNIT_EXPECT_EQ(test, owner.value, 4);
+	KUNIT_EXPECT_EQ(test, -EINVAL, sysctl_test_entry_write(test, &table, "5"));
+	KUNIT_EXPECT_EQ(test, owner.value, 4);
+
+	other.limit = 2;
+	KUNIT_EXPECT_EQ(test, -EINVAL, sysctl_test_entry_write(test, &table, "3"));
+	KUNIT_EXPECT_EQ(test, owner.value, 4);
+	holder.owner = &other;
+	sysctl_test_entry_roundtrip(test, &table, "2");
+	KUNIT_EXPECT_EQ(test, other.value, 2);
+	KUNIT_EXPECT_EQ(test, owner.value, 4);
+	other.limit = 8;
+	sysctl_test_entry_roundtrip(test, &table, "8");
+	KUNIT_EXPECT_EQ(test, other.value, 8);
+	KUNIT_EXPECT_PTR_EQ(test, table.priv, &holder);
+	KUNIT_EXPECT_PTR_EQ(test, holder.owner, &other);
+	KUNIT_EXPECT_PTR_EQ(test, holder.related, &other);
+}
+
 /* An owner embedded around the bound storage can be recovered with container_of(). */
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
+	const struct ctl_table table = CTLTBL_ENTRY_VNMH(holder.owner.value, "owner",
+							 0644, sysctl_test_owner_handler);
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
+static void sysctl_test_entry_bool(struct kunit *test)
+{
+	bool value = false;
+	const struct ctl_table table = CTLTBL_ENTRY_VNMH(value, "bool", 0644,
+							 proc_dobool);
+
+	sysctl_test_entry_roundtrip(test, &table, "1");
+	KUNIT_EXPECT_TRUE(test, value);
+	sysctl_test_entry_roundtrip(test, &table, "0");
+	KUNIT_EXPECT_FALSE(test, value);
+	KUNIT_EXPECT_EQ(test, table.maxlen, sizeof(value));
+	KUNIT_EXPECT_PTR_EQ(test, table.data, &value);
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
+	struct sysctl_test_dynamic_jiffies *ctx = table->priv;
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
+	struct sysctl_test_dynamic_jiffies *ctx = table->priv;
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
+	KUNIT_EXPECT_PTR_EQ(test, entries[0].priv, &ctx);
+	KUNIT_EXPECT_PTR_EQ(test, entries[1].priv, &ctx);
+}
+
 /*
  * A registered table may be unregistered and recreated. The table and its
  * handler context are caller-owned; registration must not rewrite either.
  */
+struct sysctl_test_lifecycle {
+	int value;
+	unsigned int calls;
+};
+
+static int sysctl_test_lifecycle_handler(const struct ctl_table *table, int dir,
+					 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_lifecycle *ctx = table->priv;
+	struct ctl_table resolved = *table;
+
+	ctx->calls++;
+	resolved.data = &ctx->value;
+	resolved.maxlen = sizeof(ctx->value);
+	resolved.min = (unsigned long)INT_MIN;
+	resolved.max = (unsigned long)INT_MAX;
+	return proc_dointvec_minmax(&resolved, dir, buffer, lenp, ppos);
+}
+
+static void sysctl_test_unregister_table(void *header)
+{
+	unregister_sysctl_table(header);
+}
+
+static void sysctl_test_context_registration_lifecycle(struct kunit *test)
+{
+	struct sysctl_test_lifecycle ctx = {};
+	const struct ctl_table table = SYSCTL_TEST_CTX(ctx.value, "context", 0644,
+						       sysctl_test_lifecycle_handler, ctx);
+	const char *path = "sysctl_kunit_lifecycle";
+	struct ctl_table_header *header;
+
+	header = register_sysctl_sz(path, &table, 1);
+	KUNIT_ASSERT_NOT_NULL(test, header);
+	kunit_add_action(test, sysctl_test_unregister_table, header);
+
+	sysctl_test_entry_roundtrip(test, &table, "31");
+	KUNIT_EXPECT_EQ(test, ctx.value, 31);
+	KUNIT_EXPECT_GT(test, ctx.calls, 0U);
+	KUNIT_EXPECT_PTR_EQ(test, table.priv, &ctx);
+
+	kunit_release_action(test, sysctl_test_unregister_table, header);
+	header = register_sysctl_sz(path, &table, 1);
+	KUNIT_ASSERT_NOT_NULL(test, header);
+	kunit_add_action(test, sysctl_test_unregister_table, header);
+
+	sysctl_test_entry_roundtrip(test, &table, "-16");
+	KUNIT_EXPECT_EQ(test, ctx.value, -16);
+	KUNIT_EXPECT_GT(test, ctx.calls, 2U);
+	KUNIT_EXPECT_PTR_EQ(test, table.priv, &ctx);
+	KUNIT_EXPECT_EQ(test, table.maxlen, sizeof(ctx.value));
+	KUNIT_EXPECT_EQ(test, table.min, 0UL);
+	KUNIT_EXPECT_EQ(test, table.max, ULONG_MAX);
+
+	kunit_release_action(test, sysctl_test_unregister_table, header);
+}
+
 /*
  * Registration copies the table entry but must leave data and priv pointing
  * at the caller-owned objects; the handler resolves storage through data and
  * context through priv on every call.
  */
+/* Registration rejects numeric bounds that cannot represent the element type. */
+static void sysctl_test_context_registration_reject(struct kunit *test)
+{
+	u8 value = 0;
+	const struct ctl_table table = CTLTBL_ENTRY_VNMHR(value, "invalid", 0644,
+							  proc_dou8vec_minmax, 0,
+							  U8_MAX + 1);
+
+	KUNIT_EXPECT_PTR_EQ(test, NULL,
+			    register_sysctl_sz("sysctl_kunit_invalid", &table, 1));
+}
+
 #if IS_ENABLED(CONFIG_NET) && IS_ENABLED(CONFIG_SYSCTL)
 /*
  * Simulate per-net table duplication and teardown through the real
@@ -724,6 +1178,116 @@ static void sysctl_test_entry_unsigned_arrays_rejected(struct kunit *test)
  * exercises copied tables, independent contexts, registration failure and
  * unregister/re-register ordering.
  */
+struct sysctl_test_net_context {
+	int value;
+	int limit;
+	unsigned int calls;
+};
+
+static int sysctl_test_net_handler(const struct ctl_table *table, int dir,
+				   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_net_context *ctx = table->priv;
+	struct ctl_table tmp = *table;
+
+	ctx->calls++;
+	tmp.data = &ctx->value;
+	tmp.maxlen = sizeof(ctx->value);
+	tmp.min = 0;
+	tmp.max = READ_ONCE(ctx->limit);
+	return proc_dointvec_minmax(&tmp, dir, buffer, lenp, ppos);
+}
+
+static void sysctl_test_unregister_net_table(void *header)
+{
+	unregister_net_sysctl_table(header);
+}
+
+static void sysctl_test_net_context_isolation(struct kunit *test)
+{
+	struct sysctl_test_net_context first = { .limit = 50 };
+	struct sysctl_test_net_context second = { .limit = 10 };
+	struct ctl_table first_table = SYSCTL_TEST_CTX(first.value, "first", 0644,
+						       sysctl_test_net_handler, first);
+	struct ctl_table second_table = SYSCTL_TEST_CTX(second.value, "second", 0644,
+							sysctl_test_net_handler, second);
+	struct ctl_table_header *header;
+
+	header = register_net_sysctl_sz(&init_net, "net/sysctl_kunit_a",
+					&first_table, 1);
+	KUNIT_ASSERT_NOT_NULL(test, header);
+	kunit_add_action(test, sysctl_test_unregister_net_table, header);
+
+	header = register_net_sysctl_sz(&init_net, "net/sysctl_kunit_b",
+					&second_table, 1);
+	KUNIT_ASSERT_NOT_NULL(test, header);
+	kunit_add_action(test, sysctl_test_unregister_net_table, header);
+
+	sysctl_test_entry_roundtrip(test, &first_table, "40");
+	KUNIT_EXPECT_EQ(test, first.value, 40);
+	KUNIT_EXPECT_EQ(test, second.value, 0);
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			sysctl_test_entry_write(test, &second_table, "20"));
+	KUNIT_EXPECT_EQ(test, second.value, 0);
+	sysctl_test_entry_roundtrip(test, &second_table, "10");
+	KUNIT_EXPECT_EQ(test, second.value, 10);
+	KUNIT_EXPECT_EQ(test, first.value, 40);
+
+	first.limit = 5;
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			sysctl_test_entry_write(test, &first_table, "6"));
+	KUNIT_EXPECT_EQ(test, first.value, 40);
+	KUNIT_EXPECT_PTR_EQ(test, first_table.priv, &first);
+	KUNIT_EXPECT_PTR_EQ(test, second_table.priv, &second);
+}
+
+static void sysctl_test_net_context_registration_cycle(struct kunit *test)
+{
+	struct sysctl_test_net_context first = { .limit = 100 };
+	struct sysctl_test_net_context second = { .limit = 50 };
+	struct ctl_table table = SYSCTL_TEST_CTX(first.value, "cycle", 0644,
+						 sysctl_test_net_handler, first);
+	struct ctl_table_header *header;
+
+	header = register_net_sysctl_sz(&init_net, "net/sysctl_kunit_cycle",
+					&table, 1);
+	KUNIT_ASSERT_NOT_NULL(test, header);
+	kunit_add_action(test, sysctl_test_unregister_net_table, header);
+	sysctl_test_entry_roundtrip(test, &table, "31");
+	KUNIT_EXPECT_EQ(test, first.value, 31);
+	kunit_release_action(test, sysctl_test_unregister_net_table, header);
+
+	/* A recreated table may carry a new owner context. */
+	table.data = &second.value;
+	table.maxlen = sizeof(second.value);
+	table.priv = &second;
+	header = register_net_sysctl_sz(&init_net, "net/sysctl_kunit_cycle",
+					&table, 1);
+	KUNIT_ASSERT_NOT_NULL(test, header);
+	kunit_add_action(test, sysctl_test_unregister_net_table, header);
+	sysctl_test_entry_roundtrip(test, &table, "50");
+	KUNIT_EXPECT_EQ(test, second.value, 50);
+	KUNIT_EXPECT_EQ(test, first.value, 31);
+	KUNIT_EXPECT_PTR_EQ(test, table.priv, &second);
+	KUNIT_EXPECT_EQ(test, table.maxlen, sizeof(second.value));
+
+	kunit_release_action(test, sysctl_test_unregister_net_table, header);
+}
+
+static void sysctl_test_net_context_registration_reject(struct kunit *test)
+{
+	u8 value = 0;
+	struct ctl_table table = CTLTBL_ENTRY_VNMHR(value, "invalid", 0644,
+						    proc_dou8vec_minmax, 0,
+						    U8_MAX + 1);
+	struct ctl_table_header *header;
+
+	header = register_net_sysctl_sz(&init_net, "net/sysctl_kunit_invalid",
+					&table, 1);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, header);
+	if (header)
+		unregister_net_sysctl_table(header);
+}
 #endif
 
 /*
@@ -732,6 +1296,80 @@ static void sysctl_test_entry_unsigned_arrays_rejected(struct kunit *test)
  * This helper is deliberately table-agnostic: the demo below uses a synthetic
  * table, while future tests can pass a header obtained from a real subsystem.
  */
+struct sysctl_test_registered {
+	struct ctl_table_header *header;
+	const struct ctl_table *entry;
+};
+
+static const struct ctl_table *sysctl_test_find_entry(const struct ctl_table_header *header,
+						      const char *name)
+{
+	int i;
+
+	for (i = 0; i < header->ctl_table_size; i++) {
+		const struct ctl_table *entry = &header->ctl_table_arg[i];
+
+		if (entry->procname && !strcmp(entry->procname, name))
+			return entry;
+	}
+	return NULL;
+}
+
+static void sysctl_test_unregister_registered(void *header)
+{
+	unregister_sysctl_table(header);
+}
+
+struct sysctl_test_demo_ctx {
+	int value;
+	int limit;
+	unsigned int calls;
+};
+
+static int sysctl_test_demo_handler(const struct ctl_table *table, int dir,
+				    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct sysctl_test_demo_ctx *ctx = table->priv;
+	struct ctl_table tmp = *table;
+
+	ctx->calls++;
+	tmp.data = &ctx->value;
+	tmp.maxlen = sizeof(ctx->value);
+	tmp.min = 0;
+	tmp.max = READ_ONCE(ctx->limit);
+	return proc_dointvec_minmax(&tmp, dir, buffer, lenp, ppos);
+}
+
+static void sysctl_test_registered_entry_demo(struct kunit *test)
+{
+	struct sysctl_test_demo_ctx ctx = { .limit = 4 };
+	struct ctl_table table = SYSCTL_TEST_CTX(ctx.value, "value", 0644,
+						 sysctl_test_demo_handler, ctx);
+	struct sysctl_test_registered registered;
+	const struct ctl_table *entry;
+
+	registered.header = register_sysctl_sz("sysctl_kunit_demo", &table, 1);
+	KUNIT_ASSERT_NOT_NULL(test, registered.header);
+	kunit_add_action(test, sysctl_test_unregister_registered,
+			 registered.header);
+
+	entry = sysctl_test_find_entry(registered.header, "value");
+	KUNIT_ASSERT_NOT_NULL(test, entry);
+	registered.entry = entry;
+
+	sysctl_test_entry_roundtrip(test, registered.entry, "4");
+	KUNIT_EXPECT_EQ(test, ctx.value, 4);
+	ctx.limit = 2;
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+			sysctl_test_entry_write(test, registered.entry, "3"));
+	KUNIT_EXPECT_EQ(test, ctx.value, 4);
+	ctx.limit = 8;
+	sysctl_test_entry_roundtrip(test, registered.entry, "8");
+	KUNIT_EXPECT_EQ(test, ctx.value, 8);
+	KUNIT_EXPECT_PTR_EQ(test, registered.entry->priv, &ctx);
+	KUNIT_EXPECT_PTR_EQ(test, registered.entry->data, &ctx.value);
+}
+
 static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
 	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
@@ -750,7 +1388,20 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_entry_u8_limits),
 	KUNIT_CASE(sysctl_test_entry_array_no_partial_commit),
 	KUNIT_CASE(sysctl_test_entry_unsigned_arrays_rejected),
+	KUNIT_CASE(sysctl_test_dynamic_range),
+	KUNIT_CASE(sysctl_test_runtime_bound_pointer),
+	KUNIT_CASE(sysctl_test_runtime_sibling_bounds),
+	KUNIT_CASE(sysctl_test_runtime_object_context),
+	KUNIT_CASE(sysctl_test_runtime_owner_from_data),
+	KUNIT_CASE(sysctl_test_entry_bool),
+	KUNIT_CASE(sysctl_test_dynamic_jiffies_ranges),
+	KUNIT_CASE(sysctl_test_context_registration_lifecycle),
+	KUNIT_CASE(sysctl_test_context_registration_reject),
+	KUNIT_CASE(sysctl_test_registered_entry_demo),
 #if IS_ENABLED(CONFIG_NET) && IS_ENABLED(CONFIG_SYSCTL)
+	KUNIT_CASE(sysctl_test_net_context_isolation),
+	KUNIT_CASE(sysctl_test_net_context_registration_cycle),
+	KUNIT_CASE(sysctl_test_net_context_registration_reject),
 #endif
 	{}
 };
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index af1c69bf0c23..8dde5a2cc532 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -316,6 +316,7 @@ int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
 				  do_proc_int_conv_ms_jiffies_minmax);
 }
+EXPORT_SYMBOL(proc_dointvec_ms_jiffies_minmax);
 
 /**
  * proc_doulongvec_ms_jiffies_minmax - read a vector of millisecond values with min/max values
-- 
2.25.1

