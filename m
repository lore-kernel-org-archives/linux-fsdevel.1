Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F076113957E;
	Sat, 16 May 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778943195; cv=none; b=UX0334rz6yLwD2zxIVGdjbSSELCORdN+KOMTIybNtiKzK+C0EC9dxMZJfwvmryEwcXasgwJaLcnR2j18dcWSCBALNF1usitlXdTS2lgSarNaMCb+AQxH00vGQP7sJSU9bVwWImtOtTFOxuzmiL9m0m0ld1KbFeoFwvb/yy/zfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778943195; c=relaxed/simple;
	bh=YF1XyKJb87v9y8rx61JMJWuNEerZjAq3xp7LMovVURA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R8SlA4Scvr7Ajdaq3uIO1sYHxfZucb6FO9OJyI6aWKyskx3GDDt7ud4MqwLVY/Gio1h2SdA4fWOFBFZyLQBpXYiPHXautyTS2GoxLZxENp71wlSbrX+vi7zj+v0bSfnHyfxF7vkydjPrDsnaSdt9ZJ8GvvNzT/eod1XLu+3YyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=UbEB08zf; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="UbEB08zf"
Received: from fedora.fritz.box (075-132-067-156.ip-addr.inexio.net [156.67.132.75])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id E48B3E0264;
	Sat, 16 May 2026 16:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1778943191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J7q2AM6VnUhAxM2WbUbmg3b8RThZZLB9DuJrJFSBf0E=;
	b=UbEB08zfcr43H93yFS0CqPm/Q+e1TaP+A54otAVjepbcMgDkJnUPwjh3NrrsuFfPZvRmJ9
	53S59EFoRC6skECIix6rcrDisMYmKD1kuv8ae91nM0IV5lBfZUZR5k3Xg4Clws+UZaGCxt
	Q1VUw0DiX+58yAVxblA9n/txF8P7b1cxGnTXV0GkSNaLCGsj/EdrWGXFp8pF7N1U0ZIJta
	crJV7le591N1++8RA3FFMygQOH2uee1UcBlbBEmTH2nsRGu+fuQfqGUgy3Egyeo/bStICx
	ZKe2QhPr4noURwo4Ur7NEM4JxffpkxXx2PzphmSdmi4654aR8qeJMThS23D/5Q==
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Sat, 16 May 2026 16:52:54 +0200
Subject: [PATCH v2] dcache: add fs.dentry-limit sysctl with negative-first
 reaper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-limit-dentries-cache-v2-1-c733a78e603b@ddn.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4XM2jF9QBFX/odhAe0ok0hLWkI0h
 H+3kLhzeW5yzl0hUWRKcC1WiLRw4uAzqFMBduj8k5BdZlBCGVFJjS8eeUZHft49tJ0dCI02l6p
 WjalVD1mdIj34fWTvbeaB0xzi53hZ5L7+guX/4CJRYqll31AvbKXFzTl/tmGEdtu2L/+xcQu2A
 AAA
X-Change-ID: 20260513-limit-dentries-cache-63685729672b
To: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778943189; l=12287;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=tt2rp61eAWz8aPVsFJc9HcBNcTjKnIFX+OsySV/F1As=;
 b=ao7wVgveNK/tQdMjPrETD6ZiHoTDEMAjqTPC1efiZ3ETUfQ3sVzupqjFBL98ML5jmQmL0Knee
 rp2uMpCVAAIA66lR8LtPsV+AQGWki+P44w0KKmX5+dYrbUUOO8eCiEE
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

From: Horst Birthelmer <hbirthelmer@ddn.com>

The dcache only shrinks under memory pressure, which is rarely reached
on machines with ample RAM, so cached negative dentries can accumulate
without bound.  Give administrators a soft cap they can set,
and a background worker that prefers negative dentries when reclaiming.

Two new sysctls under /proc/sys/fs/:

  dentry-limit             -- soft cap on nr_dentry.  0 (default)
                              disables the feature; behaviour is then
                              identical to before.
  dentry-limit-interval-ms -- pacing for the worker while still over
                              the cap.  Default 1000, minimum 1.

When the cap is exceeded, a delayed_work runs in two phases:

  1. iterate_supers() draining only negative dentries from every LRU.
     Positive entries are rotated past so the walk makes progress.
     DCACHE_REFERENCED is ignored here on purpose -- an admin-imposed
     cap should evict even hot negatives before any positive entry.
  2. If still over the cap, iterate_supers() again with the same
     isolate callback the memory-pressure shrinker uses.

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
There was a discussion at LSFMM about servers with too many cached
negative dentries.
That gave me the idea to keep the dentries in general limited
if the system administrator needs it to.

This is somewhat related to [1] where it would address the same
symptoms but in a more unobtrusive way, by just garbage collecting
the negative and then the unused cache entries.

The other effect I have seen regarding this is that FUSE
will not forget inodes (no FORGET call to the FUSE server)
even after the latest reference has been closed until much later.

In a FUSE server that mirrors the kernel cached inodes in user space
because it has to keep a lot of private data for every node
this puts an unnecessarry memory strain on that userspace entity
especially if the memory is limited for its cgroup.

[1]: https://lore.kernel.org/linux-fsdevel/20260331012925.74840-1-raven@themaw.net/
---
Changes in v2:
- get_nr_dentry() was protected by #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS) 
  fix the location for the reaper code to be inside the #if bracket
- Link to v1: https://lore.kernel.org/r/20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com
---
 Documentation/admin-guide/sysctl/fs.rst |  28 +++++
 fs/dcache.c                             | 207 ++++++++++++++++++++++++++++++++
 2 files changed, 235 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 9b7f65c3efd8..0229aea45d85 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -38,6 +38,34 @@ requests.  ``aio-max-nr`` allows you to change the maximum value
 ``aio-max-nr`` does not result in the
 pre-allocation or re-sizing of any kernel data structures.
 
+dentry-limit
+------------
+
+Soft cap on the total number of dentries allocated system-wide (i.e. on
+``nr_dentry`` from ``dentry-state``).  A value of ``0`` (the default)
+disables the feature and the dcache grows or shrinks only under memory
+pressure as before.
+
+When set to a non-zero value, a background worker is woken whenever
+the live dentry count exceeds the limit. The worker walks every
+superblock's LRU and prefers to evict negative dentries first; if it
+cannot get back under the limit using negative entries alone it falls
+back to the same LRU policy used by the memory-pressure shrinker.
+
+The limit is *soft*: allocations never fail because of it, and brief
+overshoots while the worker catches up are expected. Set the cap a
+comfortable margin above your steady-state working set.
+
+dentry-limit-interval-ms
+------------------------
+
+How often, in milliseconds, the ``dentry-limit`` worker re-runs while
+``nr_dentry`` is still above the cap. Defaults to ``1000`` (one
+second); the minimum accepted value is ``1``. Smaller values trim the
+cache more aggressively at the cost of more CPU spent walking LRUs;
+larger values let temporary spikes ride out before any work is done.
+Has no effect when ``dentry-limit`` is ``0``.
+
 dentry-negative
 ----------------------------
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 2c61aeea41f4..196f842845ed 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -145,6 +145,26 @@ static DEFINE_PER_CPU(long, nr_dentry_negative);
 static int dentry_negative_policy;
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
+/*
+ * Soft cap on the total number of dentries. When non-zero and exceeded,
+ * a background worker prunes unused dentries (preferring negative ones)
+ * until we are back under the limit. Zero (the default) disables the
+ * feature entirely; the fast path in __d_alloc() only pays the cost of
+ * a READ_ONCE and a branch in that case.
+ */
+static unsigned long sysctl_dentry_limit __read_mostly;
+static unsigned int sysctl_dentry_limit_interval_ms __read_mostly = 1000;
+static unsigned long dentry_limit_last_kick;
+
+static void dentry_limit_kick(void);
+
+/* Forward decls: the helpers used by the reaper live further down. */
+static void d_lru_isolate(struct list_lru_one *lru, struct dentry *dentry);
+static void d_lru_shrink_move(struct list_lru_one *lru, struct dentry *dentry,
+			      struct list_head *list);
+static enum lru_status dentry_lru_isolate(struct list_head *item,
+			      struct list_lru_one *lru, void *arg);
+
 /* Statistics gathering. */
 static struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
@@ -171,6 +191,161 @@ static long get_nr_dentry(void)
 	return sum < 0 ? 0 : sum;
 }
 
+#define DENTRY_LIMIT_BATCH	1024UL
+
+static void dentry_limit_worker_fn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(dentry_limit_work, dentry_limit_worker_fn);
+
+/*
+ * Variant of dentry_lru_isolate() that only frees negative dentries.
+ * DCACHE_REFERENCED is intentionally not honoured here: the whole point
+ * of an admin-imposed cap on negatives is that even frequently-looked-up
+ * negative entries should be evicted before any positive dentry.
+ * Positive entries are rotated to the tail so the walk continues to
+ * make progress without disturbing their LRU position.
+ */
+static enum lru_status dentry_lru_isolate_negative(struct list_head *item,
+		struct list_lru_one *lru, void *arg)
+{
+	struct list_head *freeable = arg;
+	struct dentry *dentry = container_of(item, struct dentry, d_lru);
+
+	if (!spin_trylock(&dentry->d_lock))
+		return LRU_SKIP;
+
+	/* Same handling as dentry_lru_isolate() for in-use entries. */
+	if (dentry->d_lockref.count) {
+		d_lru_isolate(lru, dentry);
+		spin_unlock(&dentry->d_lock);
+		return LRU_REMOVED;
+	}
+
+	if (!d_is_negative(dentry)) {
+		spin_unlock(&dentry->d_lock);
+		return LRU_ROTATE;
+	}
+
+	d_lru_shrink_move(lru, dentry, freeable);
+	spin_unlock(&dentry->d_lock);
+	return LRU_REMOVED;
+}
+
+struct dentry_limit_ctx {
+	long over;		/* remaining dentries to evict */
+	list_lru_walk_cb isolate;
+};
+
+static void dentry_limit_prune_sb(struct super_block *sb, void *arg)
+{
+	struct dentry_limit_ctx *ctx = arg;
+	unsigned long walked = 0;
+	unsigned long budget;
+
+	if (ctx->over <= 0)
+		return;
+
+	/*
+	 * Walk up to one full pass of this superblock's LRU, in
+	 * DENTRY_LIMIT_BATCH-sized chunks. The loop matters mainly for
+	 * phase 1: dentry_lru_isolate_negative() returns LRU_ROTATE for
+	 * positive dentries, which still counts against list_lru_walk()'s
+	 * nr_to_walk. A single batch can therefore finish having freed
+	 * nothing when positives crowd the head of the LRU, and without
+	 * the inner loop the worker would have to wait a full
+	 * dentry-limit-interval-ms before retrying never reaching the
+	 * negatives buried behind a long run of positives.
+	 *
+	 * The budget is snapshot at entry so a filesystem allocating
+	 * dentries faster than we drain them can't keep us spinning here
+	 * forever; freshly added dentries are picked up on the next
+	 * worker invocation.
+	 *
+	 * Phase 2 normally exits much sooner: its isolate callback frees
+	 * any non-referenced dentry, so ctx->over typically hits zero
+	 * inside the first batch. The worst-case over-eviction is one
+	 * batch past the cap, which is within the soft semantics of
+	 * fs.dentry-limit.
+	 */
+	budget = list_lru_count(&sb->s_dentry_lru);
+
+	while (ctx->over > 0 && walked < budget) {
+		LIST_HEAD(dispose);
+		unsigned long nr;
+		long freed;
+
+		nr = min(DENTRY_LIMIT_BATCH, budget - walked);
+		freed = list_lru_walk(&sb->s_dentry_lru, ctx->isolate,
+				      &dispose, nr);
+		shrink_dentry_list(&dispose);
+
+		ctx->over -= freed;
+		walked += nr;
+
+		cond_resched();
+	}
+}
+
+static void dentry_limit_worker_fn(struct work_struct *work)
+{
+	struct dentry_limit_ctx ctx;
+	unsigned long limit = READ_ONCE(sysctl_dentry_limit);
+	unsigned int ms;
+	long nr;
+
+	if (!limit)
+		return;
+
+	nr = get_nr_dentry();
+	if (nr <= (long)limit)
+		return;
+
+	ctx.over = nr - (long)limit;
+
+	/* Phase 1: drain negative dentries across every superblock. */
+	ctx.isolate = dentry_lru_isolate_negative;
+	iterate_supers(dentry_limit_prune_sb, &ctx);
+
+	/* Phase 2: still over? Apply the ordinary LRU policy. */
+	if (ctx.over > 0) {
+		ctx.isolate = dentry_lru_isolate;
+		iterate_supers(dentry_limit_prune_sb, &ctx);
+	}
+
+	/*
+	 * Re-arm while still above the limit. Re-read the sysctls in
+	 * case the admin raised the cap or disabled the feature during
+	 * the walk.
+	 */
+	limit = READ_ONCE(sysctl_dentry_limit);
+	if (!limit || get_nr_dentry() <= (long)limit)
+		return;
+
+	ms = READ_ONCE(sysctl_dentry_limit_interval_ms);
+	queue_delayed_work(system_unbound_wq, &dentry_limit_work,
+			   msecs_to_jiffies(ms));
+}
+
+static void dentry_limit_kick(void)
+{
+	unsigned long limit = READ_ONCE(sysctl_dentry_limit);
+	unsigned long now;
+
+	if (!limit)
+		return;
+	if (delayed_work_pending(&dentry_limit_work))
+		return;
+
+	now = jiffies;
+	if (time_before(now, READ_ONCE(dentry_limit_last_kick) + HZ / 10))
+		return;
+	WRITE_ONCE(dentry_limit_last_kick, now);
+
+	if (get_nr_dentry() <= (long)limit)
+		return;
+
+	queue_delayed_work(system_unbound_wq, &dentry_limit_work, 0);
+}
+
 static long get_nr_dentry_unused(void)
 {
 	int i;
@@ -199,6 +374,20 @@ static int proc_nr_dentry(const struct ctl_table *table, int write, void *buffer
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 
+/*
+ * Writing fs.dentry-limit should give prompt feedback to admins
+ * lowering the cap, so kick the worker on every successful write.
+ */
+static int proc_dentry_limit(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (write && !ret)
+		dentry_limit_kick();
+	return ret;
+}
+
 static const struct ctl_table fs_dcache_sysctls[] = {
 	{
 		.procname	= "dentry-state",
@@ -207,6 +396,21 @@ static const struct ctl_table fs_dcache_sysctls[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_nr_dentry,
 	},
+	{
+		.procname	= "dentry-limit",
+		.data		= &sysctl_dentry_limit,
+		.maxlen		= sizeof(sysctl_dentry_limit),
+		.mode		= 0644,
+		.proc_handler	= proc_dentry_limit,
+	},
+	{
+		.procname	= "dentry-limit-interval-ms",
+		.data		= &sysctl_dentry_limit_interval_ms,
+		.maxlen		= sizeof(sysctl_dentry_limit_interval_ms),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ONE,
+	},
 	{
 		.procname	= "dentry-negative",
 		.data		= &dentry_negative_policy,
@@ -1868,6 +2072,9 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	}
 
 	this_cpu_inc(nr_dentry);
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
+	dentry_limit_kick();
+#endif
 
 	return dentry;
 }

---
base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
change-id: 20260513-limit-dentries-cache-63685729672b

Best regards,
-- 
Horst Birthelmer <hbirthelmer@ddn.com>

