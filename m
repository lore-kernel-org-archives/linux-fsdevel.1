Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320B3ED138;
	Fri, 26 Jun 2026 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469625; cv=none; b=XCs/eUSbSJK/A2ii6zsuuhVrxt05eSS/DlZUE7b/alaAb7BJYtghfjVjx0al5eB5+hZ4rOGPOkVIyybuRiQSzB/3JBWpZJ/75c5Gcxo2wXj3k9Vfpdg2LvZ5HOJKTEYFzs76Dti/IE7lWw/qPuMrsa8wKkOI65autIX9fgceESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469625; c=relaxed/simple;
	bh=2nuruS0FJFMErHCJnT3XDuxjtZmtTnSHSu7Henxd2dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvHg01s0yLXJCYpycGGoVoL7FFOs6/U1ihux0dATFaM8rtYTQBM52CMkCpOFHTRFKi8JHXrsAjINjW7lpBPew06CRrgdadDnilOEqvMo6o27UxycVsKm0H5ncNFRf0y90L0nTJfC4PlLh70No/hrHPIWaVPJjKzVtMnUhzGRFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EWkyHpM6; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="EWkyHpM6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=hve7BPM4yGVz8FohCUf6yt5UenIEO9B76ChlQqt8r70=; b=EWkyHpM62kLkXIxvEssATVL3Gr
	0UMkNPMUiQySkzSLqt5XGNyT3HgNsKy3p6tH6JGh0RsHRonfXqRNsv+2rwFCLeOfreb3H4Mdwdv/X
	WIfXsqBHeqrbN5e+euvF93yFp+Jsy46+xo5Hm2BENhXeLXNPEmY/04qoPq9/NicvvHOo8MNI7PY0Z
	iECIkX7GbNEyLPKNg3gwfVU11RFF4wQx3SO2e6g36NgEdcyYP6li9sW1OZf2YXYxotmMeXqj/ebaa
	wEyYeB9DQhMgi3n6urcj0eAxabp52yku49FmVWUdEAH876vzkgt/hXtceCa6z4DnV57INA0yTX7v2
	1GlSDYIQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd3lq-003u0h-05;
	Fri, 26 Jun 2026 10:26:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 03:26:32 -0700
Subject: [PATCH RFC 3/4] fs/pipe: switch the write path to the per-pipe
 pool
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-b4-pipe-unification-v1-3-d23fa6b1ee27@debian.org>
References: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
In-Reply-To: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6238; i=leitao@debian.org;
 h=from:subject:message-id; bh=2nuruS0FJFMErHCJnT3XDuxjtZmtTnSHSu7Henxd2dk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPlPZxOaUsEukaRfY1fpX80kgPa9ENBLdnIHaU
 Du9S35syr+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj5T2QAKCRA1o5Of/Hh3
 bU/9D/4/f8ke0taIb8LcBLky7jwa+oDsMtJYlXtKfBw93v9nbPG7UxajTCch9WauJCA1hcEknY5
 m6wpQJxkuG0ILGngW7T6hVQjyIQaJbgyElr03fZ53EmWCo/cK/pUI+Mafj+RpMSwpQjnm4oABp8
 itQoDTF4CRrZVHW84T+0kEZkXYX5wGVlC8Niao55aQobYgk1GmALkARPkZpHW9aLB+pwkG6LNhS
 EicS2pZwrvWkCbZSai9qHzjlrhtIWWPBx5ZXiE8k36KzmZN44x1CUAt6ts+N0XSE0fiIwP92xeV
 B9jYXrrm9JctsrBgacccAajwZISX+sKjf/JCePORqiYcz0HZBeX2jzbQo9cwaDkTgm57j623pBt
 yO7jKaw5UWq4xG7K+AtV2EbGSXM9AzuDqADNxMFMr24O4o3+o9oYKKmFwG67baqKkPByOJ22cXq
 k0pDmkcrrK3nljsFIiktmoe40tw7P9k2zOuR9xWL8bVNFKJKGgtQYbVN+sEQ6OZzVPXjcup9aY2
 tBIrW5zYDz+TE+wa2CqZrdhccyFxHW8hX/wktjjaIwul05SQkFbc/Cbax6Ok3ubuEPw1LGLfsSx
 1PpJoyJFJ6KUYO56bHCLNmvzGKGG8T2wAs+WwnZtOdM7H3bgionIcGnxSrIgNYKP6drVFyjVDQn
 fZeKAyynn1g2n4w==
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
callers; they are marked __maybe_unused here and removed in the next patch.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/pipe.c | 57 ++++++++++++++++++---------------------------------------
 1 file changed, 18 insertions(+), 39 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 93bdc7a846bd6..070fba8c865c1 100644
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
@@ -204,7 +203,7 @@ static void __maybe_unused anon_pipe_prefill(struct pipe_inode_info *pipe,
 }
 
 /* Trim the pool down to PIPE_PREALLOC_KEEP, freeing the excess unlocked. */
-static void __maybe_unused anon_pipe_trim_pool(struct pipe_inode_info *pipe)
+static void anon_pipe_trim_pool(struct pipe_inode_info *pipe)
 {
 	struct page *excess[PIPE_PREALLOC_MAX];
 	unsigned int nexcess = 0;
@@ -221,39 +220,24 @@ static void __maybe_unused anon_pipe_trim_pool(struct pipe_inode_info *pipe)
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
-	/* FWIW: This is called with pipe->mutex held */
 	return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
 }
 
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
@@ -262,8 +246,8 @@ static void anon_pipe_put_page(struct pipe_inode_info *pipe,
  * Stash leftover prealloc pages in tmp_page[] so the next write to this
  * pipe gets a hot page without entering the allocator.
  */
-static void anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
-				       struct anon_pipe_prealloc *prealloc)
+static void __maybe_unused anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
+						      struct anon_pipe_prealloc *prealloc)
 {
 	int i, idx;
 
@@ -282,7 +266,7 @@ static void anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
 }
 
 /* Runs after mutex_unlock() to keep put_page() out of the critical section. */
-static void anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
+static void __maybe_unused anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
 {
 	while (prealloc->count) {
 		prealloc->count--;
@@ -583,7 +567,6 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
-	struct anon_pipe_prealloc prealloc;
 	unsigned int head;
 	ssize_t ret = 0;
 	size_t total_len = iov_iter_count(from);
@@ -607,8 +590,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
-	anon_pipe_get_page_prealloc(&prealloc, total_len);
-
+	anon_pipe_prefill(pipe, total_len);
 	mutex_lock(&pipe->mutex);
 
 	if (!pipe->readers) {
@@ -666,7 +648,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			struct page *page;
 			int copied;
 
-			page = anon_pipe_get_page(pipe, &prealloc);
+			page = anon_pipe_get_page(pipe);
 			if (unlikely(!page)) {
 				if (!ret)
 					ret = -ENOMEM;
@@ -730,11 +712,10 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -1015,10 +996,8 @@ void free_pipe_info(struct pipe_inode_info *pipe)
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

