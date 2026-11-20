Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168718;
	b=aLy6aNiRMAYWg+QDtvfB3I+2eoCXzAXWwKWbqKQvUjmIMrs3ZCrivYmdqGeuYenZcyka
	 T8wD9DzxkA4XFc84EbWk5nVwUIP1T83wQMZP8ZXwkVIOafioXVRQ0X9TAo6NZFYhh3/AX
	 GCLPmaeCn+o39c2d0L0Sx1zwzyHpCoxSVIS2iprxTZwv8bWElb4O2tE4NoK4eJYQ3gbs1
	 fV7Bfaj4eU5Ax1CMjuCvLukdwLlZO8efag0rSrqe7w8eSLQCUE5DqlO+ZFg2jUOWRhKH4
	 h1hVdxuKWta2wI9ix/HhqkpobuhJAZF4vYe1O70bVSLb+dtwOm8GGLNDKjwH/QpGwrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=47qKgjPLk/HlG7xONmnC2hXhMR5aH9m0CTLLnBtxpJY=;
	b=XN5vT5Wm4AuyyTg13yJmis7Y9pg12/B3vqdw46krITPlesgn8w7s7slZ3eSXNR2Xs4L1
	 Kp1UAWTnbd3HXKjYssQkeyww+ZA44ZRZvNiExuhdziJkbKD2y79+4wC6uUok1udRD9PxB
	 JICpvxSBcwpIUJEPvCekBIi91pNQ5twdkQgNjsM6BZ2+oxq6c9r+ngXfqg1ylVMGWAE17
	 kdP9wMMOqzWfEoEXFkv+NBqUWC273RVkxsYwqJ9TZmBQMgV1mO5o37U6cyoskjQxjy+Dm
	 77shQS9uECt2eIQrx2ttg8tNdbhXeCtZn1h2znFaOASFV5RgmutMrEx/EAlFjQ3M3jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CG7XtrN+;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BDD606A332
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 09:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0BDD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CG7XtrN+
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b40d23e1adso628299a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 01:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795168717; x=1795773517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=47qKgjPLk/HlG7xONmnC2hXhMR5aH9m0CTLLnBtxpJY=;
        b=CG7XtrN+bj1/pSesM9+QeYBRdVxAPg04RwzYmCsEKzTj2RJccDZHQ9hbDea3r4o+Xv
         ozDQE7iNQ1zcz3/69XfAikpmHuaViqN+C+F+5FzEKJ5sL0E/hAmuBGrgKq4hGQEnYtiL
         32MJExITtl/HDVbNCxQez1TNr/5CTJ/QSjCsog/k4GS08fMiiV9nnwMrkMNKqW41Z6u2
         4HLfL7mOpbUZKDt1ZLRbtY4KDvvFTo8ZAinJcMFh4EJ1jH9ooTjDQbuGnQiw7lAiUIc3
         A/U78dIrOy+/AEeUeb32/eM1opIdsu2ibvIDBJRk4r0OvE0zQQsn305vyxW6r+QBZQLR
         T4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168717; x=1795773517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47qKgjPLk/HlG7xONmnC2hXhMR5aH9m0CTLLnBtxpJY=;
        b=GvjELt5RyV/hzmJ5PYeUe8oiMMb1pyrMMF06N3fTNh4wtYVyAYujt2a8QumI+kRMND
         U7pNBwvAqTqCxOp//4e8q1a1j5ZHhbNe6mSRPrv+a2cXVE+11vsHvE0XZ47OLwejwPFz
         Enzen74RUVw93DImag5BUQXkBB4BSwn//wmSVOlyU8JODJU1MPEdHCa7Gx4+BK/czDYL
         7W2HoyyphbkhtQpAJds8kO/LSwG+m766q53T6EyIYvd1dJRNWQ1idXK+OXytvV0cF0QJ
         ztysVHfHPBJqVP9TkrM0Y1sbjcD4PiwxERr0s6GvAaebChtg84fst898nMzwFarAf6Nz
         Bpyg==
X-Forwarded-Encrypted: i=1; AL+hErFw5R5WUOuiWARuNwmM94790JaD38xUcxVbbpXs1teUFQegh+KlvEN+KRQbplyEAZEdybDZBUT063kTHKyd@vger.kernel.org
X-Gm-Message-State: APuU4Z8e7icOZCKY7AFF1LADr96cLfCrwJKvnvoJ8ijoWfi+fOT006Cp
	1uZzfzZfeGAMYbF+fKlNypFvTlRtR9fs5m0Ubu5owMJkpzWRXAE+vMHF
X-Gm-Gg: AZFdTZeevV13dXBeddLkH6Dxppn+bQh3Izu5nlOtyMiwNKQsXlgQAIe+xGQ0seyYLFv
	HHlMqZf99co52sD18oV2vGpgOejWB1ord35BYK9TN0UgzdpnHgb2brNYn2ITXURiCfgxM0ORtqB
	gc5A45m8P/E3OE4h80RvG9EDPCPG13r8b5qe3ydTWLzFQYE9cahaNOGVj5Uz9WvrWYUGHv9feZ/
	5+5mp3/poEDNlzTeLDPCqdxAYTLqKfV1dINy4Q5wHI9Q7l8sSWXnNZCIPA886j+w5GWDNx/HPjL
	MhBglSTcUVXhCIFOKukKp0yxFFom9AFESnYxNGSp1zqFZIxO0LW9gYyit0xQvCd/5yzpo9TL4su
	ZCLf6E4gPsrHLsjhFg7hkom5ivCBSwT3k9GkUGdefCT7sWNFx5/m1qVNDrq7TV6creVs3Cq8TK4
	3o8JmcGCn7RTK8A8O7rXG0FwHqY1VMZCoeMXUa6k1HqY1RZYPdaCuIE4ifVpJ/MbTrsHrpLyyPk
	0wTFrp15KBnZoRSlTEc3uhrEtvv60qgrkAJLfFwzn4MPQfmUv3kSjWaHPm5OBG5/kIWqSiWP2E/
	OI5QhzATDMQH+ct4v8pAPx/aUfnV/HfmUtT5sVykNw0Pva3Cn9HIPKEiIfWOUmbLsxMzfFFcliO
	yMFoVdyzhNw==
X-Received: by 2002:a17:90b:2c84:b0:3b4:1220:36fe with SMTP id 98e67ed59e1d1-3b41c7d0ddfmr2141240a91.9.1795168716946;
        Fri, 20 Nov 2026 01:58:36 -0800 (PST)
Received: from szth-acg-baixin10897724.szth.baidu.com ([120.72.52.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcfe16sm3684982a91.17.2026.11.20.01.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:58:36 -0800 (PST)
From: Xavier Xia <xavier.qyxia@gmail.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev
Cc: mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	david@kernel.org,
	brauner@kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier Xia <xavier.qyxia@gmail.com>
Subject: [PATCH] mm: batch per-task lruvec stat updates on the writeback path
Date: Fri, 20 Nov 2026 17:55:58 +0800
Message-ID: <20261120095559.429515-1-xavier.qyxia@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The writeback path updates two lruvec stats per folio through the memcg
rstat machinery: NR_FILE_DIRTY when a folio is dirtied and again when
writeback clears it, and NR_WRITEBACK when writeback starts on it.
Consecutive folios almost always share a lruvec, so the same counters
are updated over and over.  On a 4k buffered write + fsync workload
__mod_memcg_lruvec_state() is about 8% of the profile.

Hold those deltas in the task instead and apply them through
mod_lruvec_state() once a counter would grow past 64 pages.  Three
task_struct fields hold the pending delta: a lruvec pointer and two
signed counters, 16 bytes that fit in existing padding, and nothing
without CONFIG_MEMCG.  Besides the size limit, the batch is flushed
when a folio from another lruvec arrives, before
balance_dirty_pages() reads the dirty stats, at
file_write_and_wait_range() entry before it writes back and waits,
when a writeback round ends, and on task exit.  The per-folio RCU
section, folio_memcg() and mem_cgroup_lruvec() lookup stay; only the
update through the lruvec is batched.

A task therefore applies its own pending delta before its dirty
throttling decision and before its own writeback-and-wait, so neither
runs with the task's own pages missing from the counters.  Deltas
pending in other tasks are not visible until those tasks flush, so a
counter can lag by up to 64 pages per task and item.  That is a fixed
amount, so it matters in proportion to the dirty threshold: 64 tasks
that each dirty a few pages and then idle hide 7.4MB, which is 7.2% of
the threshold of a 512M memcg at dirty_ratio=20 and 29% of it at 256M
and dirty_ratio=10.  I was not able to measure whether this delays
another writer's throttling; see below the ---.

fio 3.36 on ext4 in a 16 vCPU arm64 guest, raw block backend, pinned to
one NUMA node, in a cgroup v2, 6 runs per side over alternating boots:

  seqwrite 4k +fsync:   547 -> 591 MiB/s (+7.9%), system 63.9 -> 59.7%
  randwrite 4k +fsync:  550 -> 575 MiB/s (+4.6%)

1M blocks, fsync-per-write and sqlite synchronous=FULL do not change,
and neither does anything with cgroup_disable=memory (p=0.31, n=12 per
side).  For one 256MB write+fsync in a non-root memcg,
lruvec_stat_mod_folio() drops from 393464 to 196858 calls.

Those are call counts, not CPU time.  A 384MiB buffered write with no
fsync and periodic writeback off, where only the dirty side batches,
drops lruvec_stat_mod_folio() from 196747 to 98443 and
__mod_memcg_lruvec_state() from 297789 to 201019, and that is worth
1.27% fewer instructions and no measurable change in cycles.

In testing, memory.stat file_dirty followed a write in progress,
matched the bytes written once it completed, and returned to zero after
sync; a fork()+exit() writer and 200 short-lived writers accounted for
the same number of pages as without the patch.  No reports with
DEBUG_VM, PROVE_LOCKING and DEBUG_ATOMIC_SLEEP, including on
PREEMPT_RT.

Assisted-by: LLM
Signed-off-by: Xavier Xia <xavier.qyxia@gmail.com>
---
Against 7.4-rc3.  mod_lruvec_state() and lruvec_stat_mod_folio() are
unchanged on mm-unstable and this patch does not touch mm/memcontrol.c,
but I have not test-applied or built it on that tree.

Interaction with c78842919368 ("memcg: don't go through the lruvec for
folio and kmem lruvec stat updates") in mm-unstable: that commit stops
routing per-folio stat updates through the lruvec because lruvec->pgdat
and mem_cgroup_per_node->memcg share cachelines with fields the lru_lock
holder writes.  This patch caches a lruvec and reads both fields in its
flush path, so the two go in opposite directions at the API level.
Caching memcg+nid here instead would need an exported helper, since
mod_memcg_node_state() is static to mm/memcontrol.c; the css reference
this patch takes would cover the lifetime either way.  I have not
measured that variant or the two changes stacked.  I can respin it that
way if you prefer.

The 7.4MB of hidden dirty state in the changelog is from 64 writers
that each dirty a few pages and sleep (4 measurements, sd 92KB, zero
without the patch).  I could not turn that into a throttling
measurement: with periodic writeback off balance_dirty_pages() never
reached its pause path on either kernel, and with dirty_ratio=10 in a
256M memcg it does throttle but throughput varied 5x between boots of
the same kernel on this setup.  It needs a bandwidth-limited backing
device, which I don't have.  If 29% of a small cgroup's threshold is
too much, STAT_BATCH_MAX is the knob - lowering it cuts the staleness
and the number of avoided updates together.

Only the writeback-start side of NR_WRITEBACK is batched.  Completion
keeps the existing direct update, since it may run in interrupt
context, where current is not the task that owns the batch.  That
counter can therefore also read low by up to 64 pages per task, in the
same direction as the NR_FILE_DIRTY lag.

Benchmarks, in addition to what the changelog describes:

  seqwrite:   fio --name=t --size=256M --ioengine=psync --rw=write \
                 --bs=4k --end_fsync=1
  randwrite:  same with --rw=randwrite

Call counts come from the ftrace function tracer filtered to the one
symbol (11MiB per-cpu buffer, overrun and dropped both zero), cross-
checked with perf stat on a kprobe.  They count the named symbol only,
so inlined callers are missing and the numbers should not be composed
with each other.  The dirty-only comparison is a 384MiB buffered write
with no fsync and periodic writeback off, PMU cycles and instructions,
3 groups of 5 runs per side.

Also built and booted with CONFIG_PREEMPT_RT=y, PROVE_LOCKING, DEBUG_VM
and DEBUG_ATOMIC_SLEEP.  CONFIG_DEBUG_VM=n and CONFIG_MEMCG=n build
clean.

 fs/fs-writeback.c     |   3 +
 include/linux/mm.h    |   6 ++
 include/linux/sched.h |  11 ++++
 kernel/exit.c         |   2 +
 kernel/fork.c         |   5 ++
 mm/filemap.c          |   2 +
 mm/page-writeback.c   | 128 +++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 15260cf2a29b..46327617a7ad 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2491,6 +2491,9 @@ static long wb_do_writeback(struct bdi_writeback *wb)
 	wrote += wb_check_background_flush(wb);
 	clear_bit(WB_writeback_running, &wb->state);
 
+	/* Don't pin another cgroup's memcg via a pending batch while idle. */
+	dirty_stat_flush_current();
+
 	return wrote;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6af3b7008f1a..3267d74c0994 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2134,6 +2134,12 @@ int folio_mc_copy(struct folio *dst, struct folio *src);
 
 unsigned long nr_free_buffer_pages(void);
 
+#ifdef CONFIG_MEMCG
+void dirty_stat_flush_current(void);
+#else
+static inline void dirty_stat_flush_current(void) { }
+#endif
+
 /* Returns the number of bytes in this potentially compound page. */
 static inline unsigned long page_size(const struct page *page)
 {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e4f6323d7855..13b557bc037e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -67,6 +67,7 @@ struct cfs_rq;
 struct fs_struct;
 struct io_context;
 struct io_uring_task;
+struct lruvec;
 struct mempolicy;
 struct nameidata;
 struct nsproxy;
@@ -1476,6 +1477,16 @@ struct task_struct {
 	int				nr_dirtied_pause;
 	/* Start of a write-and-pause period: */
 	unsigned long			dirty_paused_when;
+#ifdef CONFIG_MEMCG
+	/*
+	 * Pending NR_FILE_DIRTY/NR_WRITEBACK lruvec deltas; the lruvec is
+	 * kept alive by a css reference on its memcg (not for the root).
+	 * See stat_batch_mod() in mm/page-writeback.c.
+	 */
+	struct lruvec			*stat_batch_lruvec;
+	int				stat_batch_dirty;
+	int				stat_batch_writeback;
+#endif
 
 #ifdef CONFIG_LATENCYTOP
 	int				latency_record_count;
diff --git a/kernel/exit.c b/kernel/exit.c
index d5e7bc2af804..0f60e1c04ede 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -979,6 +979,8 @@ void __noreturn do_exit(long code)
 	exit_nsproxy_namespaces(tsk);
 	exit_task_work(tsk);
 	exit_thread(tsk);
+	/* After exit_task_work(): a deferred fput() can still dirty pages. */
+	dirty_stat_flush_current();
 
 	sched_autogroup_exit_task(tsk);
 	cgroup_task_exit(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index 5efceb8d58a7..6ae5076d74e5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2412,6 +2412,11 @@ __latent_entropy struct task_struct *copy_process(
 	p->nr_dirtied = 0;
 	p->nr_dirtied_pause = 128 >> (PAGE_SHIFT - 10);
 	p->dirty_paused_when = 0;
+#ifdef CONFIG_MEMCG
+	p->stat_batch_lruvec = NULL;
+	p->stat_batch_dirty = 0;
+	p->stat_batch_writeback = 0;
+#endif
 
 	p->pdeath_signal = 0;
 	p->task_works = NULL;
diff --git a/mm/filemap.c b/mm/filemap.c
index b04be64a5069..d837371ae988 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -781,6 +781,8 @@ int file_write_and_wait_range(struct file *file, loff_t lstart, loff_t lend)
 	if (lend < lstart)
 		return 0;
 
+	dirty_stat_flush_current();
+
 	if (mapping_needs_writeback(mapping)) {
 		err = filemap_fdatawrite_range(mapping, lstart, lend);
 		/* See comment of filemap_write_and_wait() */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0694ec4098f6..516a8bb028f8 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1812,6 +1812,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 	unsigned long start_time = jiffies;
 	int ret = 0;
 
+	/* The loop below reads the dirty stats. */
+	dirty_stat_flush_current();
+
 	for (;;) {
 		unsigned long now = jiffies;
 
@@ -2597,6 +2600,125 @@ bool noop_dirty_folio(struct address_space *mapping, struct folio *folio)
 }
 EXPORT_SYMBOL(noop_dirty_folio);
 
+#ifdef CONFIG_MEMCG
+
+#define STAT_BATCH_MAX		64
+
+/*
+ * Per-task batching of the NR_FILE_DIRTY and NR_WRITEBACK lruvec stats.
+ * Consecutive folios on the writeback path almost always share a lruvec,
+ * so hold the pending delta in the task and apply it through
+ * mod_lruvec_state() once it would grow past STAT_BATCH_MAX.
+ *
+ * A task applies its own pending delta before balance_dirty_pages()
+ * reads the dirty stats, and at file_write_and_wait_range() entry
+ * before writeback and wait; deltas pending in other tasks stay
+ * invisible until those tasks flush.
+ *
+ * The cached lruvec is kept valid outside the RCU section by a css
+ * reference on its memcg; the root memcg needs none.  Writeback workers
+ * clean folios for other cgroups, so they flush when a writeback round
+ * ends rather than pin a memcg while idle.
+ *
+ * Only the owning task touches the batch, hence no locking.  Interrupt
+ * context, deltas above the limit and a memcg being released all bypass
+ * it.
+ */
+static void stat_batch_flush_task(struct task_struct *t)
+{
+	struct lruvec *lruvec = t->stat_batch_lruvec;
+	int dirty = t->stat_batch_dirty;
+	int writeback = t->stat_batch_writeback;
+
+	/*
+	 * Key the flush off the cached lruvec, not off the counters: a
+	 * batch whose deltas have cancelled out to zero still owns the
+	 * css reference that was taken when it was started.
+	 */
+	if (!lruvec) {
+		VM_WARN_ON_ONCE(dirty || writeback);
+		return;
+	}
+	t->stat_batch_dirty = 0;
+	t->stat_batch_writeback = 0;
+	t->stat_batch_lruvec = NULL;
+	if (dirty)
+		mod_lruvec_state(lruvec, NR_FILE_DIRTY, dirty);
+	if (writeback)
+		mod_lruvec_state(lruvec, NR_WRITEBACK, writeback);
+	if (!mem_cgroup_is_root(lruvec_memcg(lruvec)))
+		css_put(&lruvec_memcg(lruvec)->css);
+}
+
+void dirty_stat_flush_current(void)
+{
+	stat_batch_flush_task(current);
+}
+
+static void stat_batch_mod(struct folio *folio, enum node_stat_item item,
+			   long nr)
+{
+	struct task_struct *t = current;
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
+	bool pinned;
+	int *slot;
+
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
+	/* An untracked folio has no lruvec, only a node. */
+	if (!memcg) {
+		rcu_read_unlock();
+		mod_node_page_state(folio_pgdat(folio), item, nr);
+		return;
+	}
+
+	lruvec = mem_cgroup_lruvec(memcg, folio_pgdat(folio));
+
+	/* current is not the owner in interrupt context. */
+	if (unlikely(!in_task() || nr > STAT_BATCH_MAX ||
+		     nr < -STAT_BATCH_MAX)) {
+		mod_lruvec_state(lruvec, item, nr);
+		rcu_read_unlock();
+		return;
+	}
+
+	slot = item == NR_FILE_DIRTY ?
+		&t->stat_batch_dirty : &t->stat_batch_writeback;
+
+	if (likely(t->stat_batch_lruvec == lruvec &&
+		   *slot + nr <= STAT_BATCH_MAX &&
+		   *slot + nr >= -STAT_BATCH_MAX)) {
+		*slot += nr;
+		rcu_read_unlock();
+		return;
+	}
+
+	/* Reference the new memcg before dropping the RCU section. */
+	pinned = !mem_cgroup_is_root(memcg);
+	if (pinned && !css_tryget(&memcg->css)) {
+		mod_lruvec_state(lruvec, item, nr);
+		rcu_read_unlock();
+		return;
+	}
+
+	stat_batch_flush_task(t);
+	t->stat_batch_lruvec = lruvec;
+	t->stat_batch_dirty = item == NR_FILE_DIRTY ? nr : 0;
+	t->stat_batch_writeback = item == NR_WRITEBACK ? nr : 0;
+	rcu_read_unlock();
+}
+
+#else /* !CONFIG_MEMCG */
+
+static void stat_batch_mod(struct folio *folio, enum node_stat_item item,
+			   long nr)
+{
+	mod_node_page_state(folio_pgdat(folio), item, nr);
+}
+
+#endif /* CONFIG_MEMCG */
+
 /*
  * Helper function for set_page_dirty family.
  *
@@ -2616,7 +2738,7 @@ static void folio_account_dirtied(struct folio *folio,
 		inode_attach_wb(inode, folio);
 		wb = inode_to_wb(inode);
 
-		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
+		stat_batch_mod(folio, NR_FILE_DIRTY, nr);
 		if (folio_test_dropbehind(folio))
 			wb_stat_mod(wb, WB_DONTCACHE_DIRTY, nr);
 		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
@@ -2915,7 +3037,7 @@ bool folio_clear_dirty_for_io(struct folio *folio)
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 		if (folio_test_clear_dirty(folio)) {
 			long nr = folio_nr_pages(folio);
-			lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
+			stat_batch_mod(folio, NR_FILE_DIRTY, -nr);
 			if (folio_test_dropbehind(folio))
 				wb_stat_mod(wb, WB_DONTCACHE_DIRTY, -nr);
 			zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
@@ -3033,7 +3155,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 		folio_test_set_writeback(folio);
 	}
 
-	lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr);
+	stat_batch_mod(folio, NR_WRITEBACK, nr);
 	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
 
 	access_ret = arch_make_folio_accessible(folio);
-- 
2.43.0

