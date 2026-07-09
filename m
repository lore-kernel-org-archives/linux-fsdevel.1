Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180BA23392C;
	Thu,  9 Jul 2026 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604316; cv=none; b=L7fvHeCtPQ5MeWD4zasYY1HbcO3qyvhEsvEleCk8mBvRw4HWVFqKvQcMwHSiWi1qCPqoVTbNcO1x+ZfLrO4eyWkhASqf/DZhD5T9EoNkJtz9Kg58UfqSu+c66GsgEDYGXi7yEVvdwZawD76os/qvb0Kmxjz/RPz+HZFmIihfMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604316; c=relaxed/simple;
	bh=fByCdZxoIgrD1ndJO9cUVOOWfalMlSVR1yiLB1mlVeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RQj9zVOcXUSZWAwDBOVUIHnrnkAF6SctsOpbkGBlUR9pA6xoW+vu1Q7HBrz4cKPxKBvaI2XZ0dhw7dnMvP4uA2124i2YYNrFM6YkxgRBbHGEGLs8eKsGhDPH6RRt3TaJ+NLJT1AV1AjlD9wSbeyGgNNJm13UmKzXrIsr9+QMiIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=s9/l3ZFN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="s9/l3ZFN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=4/fuzytDNbhILCFGkuOJOfyS1BZLrX6nTr2fdSXQxoo=; b=s9/l3ZFNSp3hQk0J77KjSwI5PO
	H/0CmRWZSZBpLs8izo6Mob8/7WH4oTOYAnxc6p2OHcrtR0N/mmto/cm9xbpoWUduTV6T6lKq3wNbQ
	Cpe70iq9clqTVTXNmLJGPTWQxLfc4qH+GUWynzOftKFqC4NTG6saRYqiai6xeBXLjzIYadFF0k1UU
	0jHj/00CPFST1Q0bgtKZ/lzZpGABujkPf5b1WT19+Moz4Oom9CiWpUnBdpsVtKBDMydVM6AwVBpWS
	iJrFoAmRIPUjGvJZ0PKzRYt18PIAVVDCqnHl2LH8e+TNagHNUKy2y4fuD3jCL/1Wc8Ajiow7Cbzi4
	Hn9J1hrg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whoxK-003kZk-23;
	Thu, 09 Jul 2026 13:38:23 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 09 Jul 2026 06:38:06 -0700
Subject: [PATCH v3] fs/pipe: unify the page pools into a single per-pipe
 pool
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-b4-pipe-unification-v3-1-80cafe097681@debian.org>
X-B4-Tracking: v=1; b=H4sIAD2kT2oC/23NQQqDMBBA0auEWTsljjUprnqP0kViRjubRKKVF
 vHuRaGUgtu/eH+BkbPwCI1aIPMso6QIjaoKBe3DxZ5RAjQKSJPRhmr0ZxxkYHxG6aR1k6SIzjv
 rLzXVgS0UCobMnbx29XYvFDxknFJ+75O53OrXM4feXKLGQFXnjC+ZyV4De3HxlHIPGzjTD7HaH
 iOEGtnX5ENg5i78Ieu6fgCwq6Fp/AAAAA==
X-Change-ID: 20260625-b4-pipe-unification-aba7b8525de7
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=12020; i=leitao@debian.org;
 h=from:subject:message-id; bh=fByCdZxoIgrD1ndJO9cUVOOWfalMlSVR1yiLB1mlVeY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqT6RJNAr+nyz32DQgNCerdwK2sVSzjzOy+TKQi
 +74OVYH0EKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCak+kSQAKCRA1o5Of/Hh3
 bSeXEACi/uPf28iZOfdVpUkJgoYZgk2jQ8KYQQonoiRUmUh05Zf43hCA1UNbZL2l4MvEQWCmFiH
 Q3K8u8PsPiJV5VgVB8AvIoGOf95yjeBAbCRiMdmdGl5aDxrSejflp+NzA2NYkiu+0ChYbO7uGal
 GDgkuAaTjjYKDk7AJVcm1ugsn6eR4Bp/eNnONZyhBdZVAk8JyS3/dC4t/+2M7IvPohLOL+NjjRL
 ZiIKQ4UUYIg2lro/I0aMFPVzQdDg2X1eKmlUlVoGqTTUaoJKRUE6baWLlKqVJuqT2tY2NCviXpO
 LggR3/ufnS0HuWrpRdqHsHz743OBwzykajPSwPRQ4RVu/0NySnWhxp3L7LnytVo9H/tXQ1nF+DC
 4Nr2CvcXDx+HqX6U8FN3XKt6zj05HxVIvdhIG6ad+DK5xC4dfRR579SUQWksA3JVuuCkJ7L1m8e
 ofv4iNIwDp7snfWHkC6wD29IUgy0Mq78jwWIQ6D+WuxEXooIbpsjZg/sbLHi5coIyfC++xfiG7L
 CZHyOyd/9WfaaB10aaOc/lYBeIOt57sPOrmpbzub1dj4i8ihJlNmnBtDHMG+xUb2knJTAtgBoxL
 pTrMRHFHt3MOvRnhwURh/Bn5qB+7fKDT0vbC8QFd7Tpu/QeOfAzhiflt0Xuc3zDPh9sLgcefXfe
 FgthvqNCRCSUGcA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Pipes keep two separate page caches:
 a) A the per-pipe, lock-protected tmp_page[2]
 b) An on-stack anon_pipe_prealloc burst pool of up to eight pages
    filled before the lock

Converge them into a single per-pipe pool (struct anon_pipe_prealloc
embedded in pipe_inode_info) with the same budget as before: up to
PIPE_PREALLOC_MAX (8) pages, trimmed back to PIPE_PREALLOC_KEEP (2)
after each operation. tmp_page[2] is removed.

Pages are still allocated and freed outside pipe->mutex; only the
assignment into the pool is done under it.

anon_pipe_prefill_and_lock() tops the pool up to the write's page count
-- and returns with pipe->mutex held, so a write acquires the lock only once.

anon_pipe_trim_pool_and_unlock() trims the pool under that same lock
before dropping it, then frees the excess.

A huge thanks to Mateusz Guzik <mjguzik@gmail.com> who has been
a solid collaborator.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v3:
- Squashes them into a single patch (Guzik)
- Fold prefill and trim into one mutex acquire per write. (Guzik)
- Link to v2: https://patch.msgid.link/20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org

Changes in v2:
- User READ_ONCE to read prealloc.count
- Trim the pool at the reader side
- Link to v1: https://lore.kernel.org/r/20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org
---
 fs/pipe.c                 | 171 ++++++++++++++++++++--------------------------
 include/linux/pipe_fs_i.h |  21 +++++-
 2 files changed, 93 insertions(+), 99 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 429b0714ec575..b14d5bb2b45a4 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -111,75 +111,95 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
 	pipe_lock(pipe2);
 }
 
-#define PIPE_PREALLOC_MAX 8
+static struct page *anon_pipe_prealloc_pop(struct anon_pipe_prealloc *prealloc)
+{
+	if (!prealloc->count)
+		return NULL;
 
-struct anon_pipe_prealloc {
-	struct page *pages[PIPE_PREALLOC_MAX];
-	unsigned int count;
-};
+	prealloc->count--;
+
+	return prealloc->pages[prealloc->count];
+}
+
+/* Push a page to the prealloc pool. Returns true if added, false if full. */
+static bool anon_pipe_prealloc_push(struct anon_pipe_prealloc *prealloc,
+				    struct page *page)
+{
+	if (prealloc->count >= PIPE_PREALLOC_MAX)
+		return false;
+	prealloc->pages[prealloc->count++] = page;
+	return true;
+}
 
 /*
- * Pre-allocate pages outside pipe->mutex for multi-page writes.
- * alloc_page() with GFP_HIGHUSER can sleep in reclaim and runs memcg
- * charging; doing it under the mutex stalls a concurrent reader.
- *
- * Loop alloc_page() instead of alloc_pages_bulk_*(): the bulk path refuses
- * __GFP_ACCOUNT under memcg (see commit 8dcb3060d81d "memcg: page_alloc:
- * skip bulk allocator for __GFP_ACCOUNT") and silently degrades to a single
- * page. A per-page loop keeps memcg accounting and the task NUMA mempolicy
- * honoured for every page; the per-call overhead is small compared to the
- * pipe->mutex hold-time being shrunk. Any shortfall is covered by the
- * in-lock alloc_page() fallback in anon_pipe_get_page().
+ * Top up the pipe's own pool, then take pipe->mutex and return with it held.
+ * The shortfall is allocated outside the lock; the push and the caller's write
+ * then run under a single lock acquisition, avoiding a separate prefill
+ * lock/unlock cycle. anon_pipe_get_page() drains the pool instead of allocating
+ * under the lock.
  */
-static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
-					size_t total_len)
+static void anon_pipe_prefill_and_lock(struct pipe_inode_info *pipe, size_t total_len)
 {
-	unsigned int want, i;
-	struct page *page;
-
-	prealloc->count = 0;
-	if (total_len <= PAGE_SIZE)
-		return;
+	struct page *pages[PIPE_PREALLOC_MAX];
+	unsigned int want, have, need, n = 0;
 
 	want = min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
 		     PIPE_PREALLOC_MAX);
+	/* Unlocked read; the pool is refilled under the lock below. */
+	have = min_t(unsigned int, READ_ONCE(pipe->prealloc.count), want);
+	need = want - have;
+
+	if (!need) {
+		mutex_lock(&pipe->mutex);
+		return;
+	}
+
+	while (n < need) {
+		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
 
-	for (i = 0; i < want; i++) {
-		page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
 		if (!page)
 			break;
-		prealloc->pages[prealloc->count++] = page;
+		pages[n++] = page;
 	}
+
+	mutex_lock(&pipe->mutex);
+	while (n && anon_pipe_prealloc_push(&pipe->prealloc, pages[n - 1]))
+		n--;
+
+	/*
+	 * Just flush any extra page that got affected by the TOCTOU
+	 * effect
+	 */
+	while (n)
+		put_page(pages[--n]);
 }
 
-static struct page *anon_pipe_prealloc_pop(struct anon_pipe_prealloc *prealloc)
+/*
+ * Called with pipe->mutex held. Trim the pool down to PIPE_PREALLOC_KEEP under
+ * the lock, drop it, then free the excess outside the critical section.
+ */
+static void anon_pipe_trim_pool_and_unlock(struct pipe_inode_info *pipe)
 {
-	if (!prealloc->count)
-		return NULL;
+	struct page *excess[PIPE_PREALLOC_MAX];
+	unsigned int nexcess = 0;
 
-	prealloc->count--;
+	while (pipe->prealloc.count > PIPE_PREALLOC_KEEP)
+		excess[nexcess++] = anon_pipe_prealloc_pop(&pipe->prealloc);
+	mutex_unlock(&pipe->mutex);
 
-	return prealloc->pages[prealloc->count];
+	while (nexcess)
+		put_page(excess[--nexcess]);
 }
 
-static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe,
-				       struct anon_pipe_prealloc *prealloc)
+static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
 {
 	struct page *page;
 
-	/* Drain prealloc first to keep tmp_page[] hot for later small writes. */
-	page = anon_pipe_prealloc_pop(prealloc);
+	/* Drain the prealloc pool before allocating. Called with mutex held. */
+	page = anon_pipe_prealloc_pop(&pipe->prealloc);
 	if (page)
 		return page;
 
-	for (int i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
-		if (pipe->tmp_page[i]) {
-			page = pipe->tmp_page[i];
-			pipe->tmp_page[i] = NULL;
-			return page;
-		}
-	}
-
 	/* FWIW: This is called with pipe->mutex held */
 	return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
 }
@@ -187,48 +207,11 @@ static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe,
 static void anon_pipe_put_page(struct pipe_inode_info *pipe,
 			       struct page *page)
 {
-	if (page_count(page) == 1) {
-		for (int i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
-			if (!pipe->tmp_page[i]) {
-				pipe->tmp_page[i] = page;
-				return;
-			}
-		}
-	}
-
-	put_page(page);
-}
-
-/*
- * Stash leftover prealloc pages in tmp_page[] so the next write to this
- * pipe gets a hot page without entering the allocator.
- */
-static void anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
-				       struct anon_pipe_prealloc *prealloc)
-{
-	int i, idx;
-
-	if (!prealloc->count)
+	if (page_count(page) == 1 &&
+	    anon_pipe_prealloc_push(&pipe->prealloc, page))
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
-		if (pipe->tmp_page[i])
-			continue;
-		if (!prealloc->count)
-			return;
-		idx = --prealloc->count;
-		pipe->tmp_page[i] = prealloc->pages[idx];
-		prealloc->pages[idx] = NULL;
-	}
-}
-
-/* Runs after mutex_unlock() to keep put_page() out of the critical section. */
-static void anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
-{
-	while (prealloc->count) {
-		prealloc->count--;
-		put_page(prealloc->pages[prealloc->count]);
-	}
+	put_page(page);
 }
 
 static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
@@ -485,7 +468,8 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	}
 	if (pipe_is_empty(pipe))
 		wake_next_reader = false;
-	mutex_unlock(&pipe->mutex);
+	/* Consumed buffers may have refilled the pool; trim it and unlock. */
+	anon_pipe_trim_pool_and_unlock(pipe);
 
 	if (wake_writer)
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
@@ -524,7 +508,6 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
-	struct anon_pipe_prealloc prealloc;
 	unsigned int head;
 	ssize_t ret = 0;
 	size_t total_len = iov_iter_count(from);
@@ -548,9 +531,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
-	anon_pipe_get_page_prealloc(&prealloc, total_len);
-
-	mutex_lock(&pipe->mutex);
+	anon_pipe_prefill_and_lock(pipe, total_len);
 
 	if (!pipe->readers) {
 		if ((iocb->ki_flags & IOCB_NOSIGNAL) == 0)
@@ -607,7 +588,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			struct page *page;
 			int copied;
 
-			page = anon_pipe_get_page(pipe, &prealloc);
+			page = anon_pipe_get_page(pipe);
 			if (unlikely(!page)) {
 				if (!ret)
 					ret = -ENOMEM;
@@ -671,11 +652,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		wake_next_writer = true;
 	}
 out:
-	anon_pipe_refill_tmp_pages(pipe, &prealloc);
 	if (pipe_is_full(pipe))
 		wake_next_writer = false;
-	mutex_unlock(&pipe->mutex);
-	anon_pipe_free_pages(&prealloc);
+	anon_pipe_trim_pool_and_unlock(pipe);
 
 	/*
 	 * If we do do a wakeup event, we do a 'sync' wakeup, because we
@@ -956,10 +935,8 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 	if (pipe->watch_queue)
 		put_watch_queue(pipe->watch_queue);
 #endif
-	for (i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
-		if (pipe->tmp_page[i])
-			__free_page(pipe->tmp_page[i]);
-	}
+	for (i = 0; i < pipe->prealloc.count; i++)
+		__free_page(pipe->prealloc.pages[i]);
 	kfree(pipe->bufs);
 	kfree(pipe);
 }
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 7f6a92ac97047..4e2e4f44fbe5f 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -14,6 +14,9 @@
 #define PIPE_BUF_FLAG_LOSS	0x40	/* Message loss happened after this buffer */
 #endif
 
+#define PIPE_PREALLOC_MAX	8	/* max pages in prealloc pool */
+#define PIPE_PREALLOC_KEEP	2	/* keep at least this many after trim */
+
 /**
  *	struct pipe_buffer - a linux kernel pipe buffer
  *	@page: the page containing the data for the pipe buffer
@@ -58,6 +61,20 @@ union pipe_index {
 	};
 };
 
+/**
+ *	struct anon_pipe_prealloc - per-pipe page preallocation pool
+ *	@pages: array of cached pages (pool)
+ *	@count: number of pages currently in the pool
+ *
+ * Each pipe keeps a small bounded pool of preallocated pages to reduce
+ * allocation overhead during writes. The pool is bounded at PIPE_PREALLOC_MAX
+ * and trimmed down to PIPE_PREALLOC_KEEP after a write completes.
+ */
+struct anon_pipe_prealloc {
+	struct page *pages[PIPE_PREALLOC_MAX];
+	unsigned int count;
+};
+
 /**
  *	struct pipe_inode_info - a linux kernel pipe
  *	@mutex: mutex protecting the whole thing
@@ -68,7 +85,7 @@ union pipe_index {
  *	@max_usage: The maximum number of slots that may be used in the ring
  *	@ring_size: total number of buffers (should be a power of 2)
  *	@nr_accounted: The amount this pipe accounts for in user->pipe_bufs
- *	@tmp_page: cached released page
+ *	@prealloc: per-pipe page preallocation pool
  *	@readers: number of current readers of this pipe
  *	@writers: number of current writers of this pipe
  *	@files: number of struct file referring this pipe (protected by ->i_lock)
@@ -99,7 +116,7 @@ struct pipe_inode_info {
 #ifdef CONFIG_WATCH_QUEUE
 	bool note_loss;
 #endif
-	struct page *tmp_page[2];
+	struct anon_pipe_prealloc prealloc;
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;
 	struct pipe_buffer *bufs;

---
base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
change-id: 20260625-b4-pipe-unification-aba7b8525de7

Best regards,
--  
Breno Leitao <leitao@debian.org>

