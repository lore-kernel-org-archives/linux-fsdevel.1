Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B95408023;
	Fri, 10 Jul 2026 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679532; cv=none; b=hMoL/oTVj576jUXwndwxKh95qMPm4oPNDMhug96KwBqh0MXCPOASYun5gOeOjvAmlNBome8pr/XGi2F3IDTUUZZIJT15fpBwspSrHFbWu8y8v5pSBo0ZZP18ZiWhoTCGnMjQgtk9RoPpD5cx7KegUTYMIsp3i5OmeCUjo9VmEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679532; c=relaxed/simple;
	bh=Ql7ZdITjsG98Lc/fIie3nPjKYywOVu+zd4pBEIUNwb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WZkazD0nLlkRW24+2jo+bLf/uJVJBfCHplelf6NR/vq1q8iJ77olfKAyUWJd7FjnNFPw8msF/x9t/dD9wbRmmZkm1SkhFU9jmgHZyYPUkrv6AqdcA1rx8xQnQor7E3R1O0LrnHJBu9ryIXYMnmZah7ETWt4/d/3qJMndw/XSCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bT3hWudK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bT3hWudK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=Segrr/hKU/37W+mgPf/y/PBrot+G3Q93NyghHk6wYgc=; b=bT3hWudK1VnAY1NRAaQZ3k48/k
	AMU/zHhPV6FbBBRkDiN1Qe+zKiOeVXab+lHkndfzEUm4/3Vf00QR0gMjPg9WDspu+KPT16GUeVsSr
	hMAyho/x/s0XsaX3pUk1Ypcr1M7TAGj65Wt9HFB0zUad7x9WNcAKaNDLtkwi5pKuLFkwVEbHVie31
	QBTcNLfhTZDcvN9ZYMPBq+voQMoVr/64Rwz0bZz00Np0yeVpHGMM/k7l+4433Dmb5Ph2HmbEAl5w2
	/9W/OIqnTmdXZLh0QShucllVF2lsh7K7zOk75EW8BKwesNWz5x5a4qk+DoyYI3+00ySvNNVXGAldv
	zLPj/nVA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi8WS-004PjC-2S;
	Fri, 10 Jul 2026 10:31:57 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Jul 2026 03:31:18 -0700
Subject: [PATCH v4] fs/pipe: unify the page pools into a single per-pipe
 pool
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-pipe-unification-v4-1-ff31c39f1c16@debian.org>
X-B4-Tracking: v=1; b=H4sIAPXJUGoC/23NwY6CMBCA4Vdp5sxs2kFa5LTvYTy0dKpzKaQoW
 WN4dwOJcTfL9T98/xMmLsITdOoJhWeZZMjQqUOloL/6fGGUCJ0C0mS1pQbDAUcZGe9ZkvT+JkN
 GH7wLbUNNZAeVgrFwkp9NPZ0rBVeZbkN5bJPZrPXt2V1vNqgxUp28DYaZ3HfkID5/DeUCKzjTB
 3Ha7SOEGjk0FGJk5hT/IfVv5LiP1Giw1b1PrI/OtuYPsizLC7r+zv1BAQAA
X-Change-ID: 20260625-b4-pipe-unification-aba7b8525de7
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=12178; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ql7ZdITjsG98Lc/fIie3nPjKYywOVu+zd4pBEIUNwb4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqUMoYk4OJr+OjtYncb6VpZL/p5vmcptRZnnSux
 jkX8qAcyp2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalDKGAAKCRA1o5Of/Hh3
 bZ5ZD/9a/evMK5+5Y/D6Z+lu/30adcsAVLHrpSx9u1ogi2sBBAXWuIBQyxcPMJIoZHyOrlBM9iW
 /1womEpUP5Hlf8B6+ry4kakO9yvXS3fIYrb098oPggoix2qlRuIcRKN8HD44WRPGmOrinqJi8pn
 psB0zBI1ni03yFWmL8LHF9Kr74erEZcsw6SfiC88mZEJvzq5DC/QK9LY7LiU8FMW5HMr0i8YG9g
 DIrLU9IlRPBvCAFM3go4apj3XhJ3WGRDt6D/6n8q299gWig8QrtipxS6x4cwAZa0vR1KSei1a+S
 jyexuZfk6+UIXPR7xvSTpcTEp/s0xrhSGaTQuGItXLajwSrAqQ+MHeYUgF0DXQ2b5EZakEwwAYT
 UDcIdaYc1IXCoOMq0VHlwvkMqcQEiPkodEtoSUh4pu/wSt5uvEnOCiscjE5AIhPtKXKjEI5tzM0
 sXQJj4CVIWKQNo8LRSsgz5BMqwAibW6SlzKR/bx0e11JswPMTn2gylzqvWf2vNSGuGYfEaQ3UKI
 W9QwUdobfewHJfYBofrLpfsjd54hMpL6IcOPXFphJz1fFqQSVEElCzEq29OCekCJvPxwTfmkLtL
 iBDl9eHxq4G4CLMwfFBbYsiC3x588LnbACwWwQzX23ofrqrU0zLPCQgsOM1E3Cee2l0/SFP9UqS
 NEsGNtUSYVaW/mg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Pipes keep two separate page caches:
 a) The per-pipe, lock-protected tmp_page[2]
 b) An on-stack anon_pipe_prealloc burst pool of up to eight pages
    filled before the lock

Converge them into a single per-pipe pool (struct anon_pipe_prealloc
embedded in pipe_inode_info) with the same budget as before: up to
PIPE_PREALLOC_MAX (8) pages, trimmed back to PIPE_PREALLOC_KEEP (2)
after each operation. tmp_page[2] is removed.

Pages are still allocated and freed outside pipe->mutex; only the
assignment into the pool is done under it.

anon_pipe_prefill_and_lock() tops the pool up to the write's page count
-- and returns with pipe->mutex held, so a write acquires the lock only
once.

anon_pipe_trim_and_unlock() trims the pool under that same lock before
dropping it, then frees the excess.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>
---
Changes in v4:
- Rename anon_pipe_trim_pool_and_unlock() to anon_pipe_trim_and_unlock()
  for naming symmetry (Guzik)
- Link to v3: https://patch.msgid.link/20260709-b4-pipe-unification-v3-1-80cafe097681@debian.org

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
index 429b0714ec575..3c6061cefe791 100644
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
+static void anon_pipe_trim_and_unlock(struct pipe_inode_info *pipe)
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
+	anon_pipe_trim_and_unlock(pipe);
 
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
+	anon_pipe_trim_and_unlock(pipe);
 
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

