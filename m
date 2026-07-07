Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61EA3783B1;
	Tue,  7 Jul 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436760; cv=none; b=eEgjzcOCqEe9uC5Ko6JoEKqs7++N3rRryC0djPi7ZtqXRq9rL0cUdZw5XA2XqI1dAHFsC5dXTPIT8WbA7w/qYXx6V4hwlVbEjM8DdKrIO3WRmYl7J/otO2MykV1+8AAnhUWm35nKjENKg5qtfWBqoI+2EBoltjk8GBZG/Km16MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436760; c=relaxed/simple;
	bh=zUTJm8WJQ0+x13BCyMJr9RN4TqMeDKDA+GGpcVehBlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dnqy6e71kQejOk4eTBYd+64CSUhTcubw0CkFbkl4mwUXT+AlqXhXbyKO82qAZNQO394quA7xsre/WIAIhwxl7MAeoe7YMPLshFMVLiGqBCClM+YY+8aSTg9C0SYUgNhcLHirgShAvVt5NFx9TPEvAwdn6Tmm07pREoPOO2lUejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gGJWXEg1; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gGJWXEg1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=vZyLbnVj1D0Om5K31yp1ngdIOnPMvlSIAzFBKIO/dhc=; b=gGJWXEg1hMx5agQaqYBY5KwzUK
	MbZljf8IjIx0P9s5UTXOS1jNYpDS6+zyimGSw9Skqy+SXdwtseSIBYqv1jhf45NAYKFgcdDqnU+mA
	Hg0uuJH4Kwd2RmauMxs/JLfEXF+w8c2byPfKQpn0PqdLXj5xZqhL3RTAA2U33NL6piBjURw9qdCPh
	RvqLfHr5WAREPkMHJwBurhnLO9UxJ/JFM5xEHHnZ+g0RhBpA3+cObIiORB0H7XMjuWCFsYb9bK7HP
	SMUEIDxhLC852TqhiBWD/85jIy5kmNyOMxeI6pNJuZSTXKpfGJN9LRelx8nD5W1INSoG7HRbVvHVt
	Q7dfolxQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wh7Mx-002Gss-0q;
	Tue, 07 Jul 2026 15:05:55 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 07 Jul 2026 08:05:00 -0700
Subject: [PATCH v2 3/4] fs/pipe: switch the read and write paths to the
 per-pipe pool
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pipe-unification-v2-3-eb52bddeeefd@debian.org>
References: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
In-Reply-To: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=6735; i=leitao@debian.org;
 h=from:subject:message-id; bh=zUTJm8WJQ0+x13BCyMJr9RN4TqMeDKDA+GGpcVehBlQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqTRXC93gJ9wLnaeKPCoO8+BNBNO7y8olGpgFkx
 4AzpKjMs82JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCak0VwgAKCRA1o5Of/Hh3
 bVFID/4+S2ByrU1G89chZpzhF9Qy4urlESqjZvkHfitdo5bDaukEDJOmyU0x8IqnWU7gzWxHNXQ
 ZMwrS7Q3XfxngiH2DW77ushriTqcSeoddus3Vyl7yKT31KxBYBWu0PJrqcsXhGDSFfCycUxXhf9
 lUbVA/Y86oMU2Boj6Xd16QyVxXY3K4h+PdgKLOQB4aDCE0jaENsATAFBQGtcTkRC4Mw/ZjWy7Fu
 F2S1HhfGShhcSjyqcx163LVO2w4fI8h+pE0kyZgEXnZO2tOjLNizpq2wpE69qxVzPi9eecVSja4
 Hti+v5quThjrMj2cAllW/tcRe9VnLDH15AMyJj03FClhfk3Nm83p5ILgrRCSc0fuZo7doCP+c9z
 XO5eoTYRjR05cw59A5uD/gA7ZAC+q9QtFZ61uYGEceZA/R0KHFFVbjha9Ss8yLJR46czxmZXEDc
 lKiVZ4GSsmZY2G8yi2JVCWqr4VMyL9Szex130UCYJbydJPtqK4bSiDg115cYanpHYHido1ZgYHZ
 N565ASVuhqZsmvg9Us6+rV15WX2N8OfgR/VL1Llv9+BOZWdcP+XibQzHu/FG5l6V01rMGBve5S5
 nB6bH9SqjH6M1Ygfd8ZRH6AUACCDwnYKO5M0ivMGizUx65SU4w+XOjpoht4gEsriJge/4eO2OnA
 aTkI/WcXzjRyzJg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Replace the per-write on-stack prealloc pool with the pipe's persistent
pool: anon_pipe_write() now tops up pipe->prealloc before the lock via
anon_pipe_prefill() and trims it after the write via anon_pipe_trim_pool(),
and anon_pipe_get_page()/anon_pipe_put_page() drain and refill that pool
directly. Free the pool, instead of tmp_page[2], on teardown.

This leaves the old on-stack helpers (anon_pipe_get_page_prealloc,
anon_pipe_refill_tmp_pages, anon_pipe_free_pages) and tmp_page[2] without
callers; they are marked __maybe_unused here and removed in the next
patch (aiming to make the patch more reviewable)

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/pipe.c | 58 ++++++++++++++++++++--------------------------------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 240fede27542d..3288a16f8a40a 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -124,8 +124,8 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
  * pipe->mutex hold-time being shrunk. Any shortfall is covered by the
  * in-lock alloc_page() fallback in anon_pipe_get_page().
  */
-static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
-					size_t total_len)
+static void __maybe_unused anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
+						       size_t total_len)
 {
 	unsigned int want, i;
 	struct page *page;
@@ -170,8 +170,7 @@ static bool anon_pipe_prealloc_push(struct anon_pipe_prealloc *prealloc,
  * shortfall outside the lock, then briefly take the lock to push the pages in.
  * anon_pipe_get_page() then drains the pool instead of allocating under the lock.
  */
-static void __maybe_unused anon_pipe_prefill(struct pipe_inode_info *pipe,
-					     size_t total_len)
+static void anon_pipe_prefill(struct pipe_inode_info *pipe, size_t total_len)
 {
 	struct page *pages[PIPE_PREALLOC_MAX];
 	unsigned int want, have, need, n = 0;
@@ -209,7 +208,7 @@ static void __maybe_unused anon_pipe_prefill(struct pipe_inode_info *pipe,
 }
 
 /* Trim the pool down to PIPE_PREALLOC_KEEP, freeing the excess unlocked. */
-static void __maybe_unused anon_pipe_trim_pool(struct pipe_inode_info *pipe)
+static void anon_pipe_trim_pool(struct pipe_inode_info *pipe)
 {
 	struct page *excess[PIPE_PREALLOC_MAX];
 	unsigned int nexcess = 0;
@@ -227,24 +226,15 @@ static void __maybe_unused anon_pipe_trim_pool(struct pipe_inode_info *pipe)
 		put_page(excess[--nexcess]);
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
@@ -252,14 +242,9 @@ static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe,
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
+	if (page_count(page) == 1 &&
+	    anon_pipe_prealloc_push(&pipe->prealloc, page))
+		return;
 
 	put_page(page);
 }
@@ -268,8 +253,8 @@ static void anon_pipe_put_page(struct pipe_inode_info *pipe,
  * Stash leftover prealloc pages in tmp_page[] so the next write to this
  * pipe gets a hot page without entering the allocator.
  */
-static void anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
-				       struct anon_pipe_prealloc *prealloc)
+static void __maybe_unused anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
+						      struct anon_pipe_prealloc *prealloc)
 {
 	int i, idx;
 
@@ -288,7 +273,7 @@ static void anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
 }
 
 /* Runs after mutex_unlock() to keep put_page() out of the critical section. */
-static void anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
+static void __maybe_unused anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
 {
 	while (prealloc->count) {
 		prealloc->count--;
@@ -551,6 +536,8 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	if (pipe_is_empty(pipe))
 		wake_next_reader = false;
 	mutex_unlock(&pipe->mutex);
+	/* Consumed buffers may have refilled the pool; trim it back. */
+	anon_pipe_trim_pool(pipe);
 
 	if (wake_writer)
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
@@ -589,7 +576,6 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
-	struct anon_pipe_prealloc prealloc;
 	unsigned int head;
 	ssize_t ret = 0;
 	size_t total_len = iov_iter_count(from);
@@ -613,8 +599,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
-	anon_pipe_get_page_prealloc(&prealloc, total_len);
-
+	anon_pipe_prefill(pipe, total_len);
 	mutex_lock(&pipe->mutex);
 
 	if (!pipe->readers) {
@@ -672,7 +657,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			struct page *page;
 			int copied;
 
-			page = anon_pipe_get_page(pipe, &prealloc);
+			page = anon_pipe_get_page(pipe);
 			if (unlikely(!page)) {
 				if (!ret)
 					ret = -ENOMEM;
@@ -736,11 +721,10 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		wake_next_writer = true;
 	}
 out:
-	anon_pipe_refill_tmp_pages(pipe, &prealloc);
 	if (pipe_is_full(pipe))
 		wake_next_writer = false;
 	mutex_unlock(&pipe->mutex);
-	anon_pipe_free_pages(&prealloc);
+	anon_pipe_trim_pool(pipe);
 
 	/*
 	 * If we do do a wakeup event, we do a 'sync' wakeup, because we
@@ -1021,10 +1005,8 @@ void free_pipe_info(struct pipe_inode_info *pipe)
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

-- 
2.53.0-Meta

