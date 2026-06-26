Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03563EEAF8;
	Fri, 26 Jun 2026 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469629; cv=none; b=QgVDTnUwuTYqI6hq7m9c04BpHnADkuTyqBDHU7mz8P6zPHDrlLB7EPTEHeRl11ULvE2YxcdG46t+kPJJSkG+lnGSoTwmAayxeznY5iJ6z8ZIgwuP10eXyMqIGj7FsOimYLm2QQ54E06a6+0LBPijMt50s+jkl5VJGaWRXDYwMFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469629; c=relaxed/simple;
	bh=s8N+6S/muj0e1W9benlWMW+/mo8BPEDAPAlP18So2HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Leu310KF25lxLbu4MnJoaFI3NaX8P3DiwrsAVpBo6tcVXlpnF+G3QsX6DncJF6aImc9HO6U6ObJxZL+Tf8IRtB+57h86houwlBqWIkapSWJLusbWEezSKgfrLJ9ce2d2zp31yBG02A1p2X5dPqETU/5baIVJfr3g7Bcnj/zP4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VozU0ToE; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VozU0ToE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=qipHOBO5+4w6MxLdGl9vGCVVYRkU+FVrsRuGxczPMro=; b=VozU0ToEZW01608c4Hb/EJeD//
	KGkxGMuuytgCtn5Cms2iDU9wEvk51vzhWkMCRyui9gR6yFZJ/Opu82khLOoUQMzFQZkk7qD8pkPiz
	QpIqsmsSrWdZLKzD/ROPVAhmM8OtZ/wdRyGcuVKlrJ0CptNqoSVvpUsOGCh6Hj7tl4bWvytKXgTR6
	LhOnQFKZhqSo+Pj9JlNz79GW0rARkogJWkzWjw5sUcKJl3K9spu7dnTkjaD//kUhjEEBW5ewMDmLA
	6lpSI8UwxLQ2fUveHAwUznb81ALd8Kv5gVu0HVcNgFStc0BWXwsxrDlH5IF3JXMMNss0Rn39DVJnp
	OzZTtFwA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd3lu-003u0w-1G;
	Fri, 26 Jun 2026 10:26:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 03:26:33 -0700
Subject: [PATCH RFC 4/4] fs/pipe: remove the old on-stack prealloc helpers
 and tmp_page[2]
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-b4-pipe-unification-v1-4-d23fa6b1ee27@debian.org>
References: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
In-Reply-To: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4033; i=leitao@debian.org;
 h=from:subject:message-id; bh=s8N+6S/muj0e1W9benlWMW+/mo8BPEDAPAlP18So2HE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPlPZDKeZ6JzI6I3Jgqs/bdNP4kMifDpiTVG8n
 V4DGemhV8CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj5T2QAKCRA1o5Of/Hh3
 bdduEACxFbiUE7+J6C3lVAi8MfNniNdwtcLkBwS8riEmyxg29Y/KbCI70spAnU0ICdaQhQHz23z
 xfE9NFhHvVxIq8AYmVlmk2cuX2SUxLAd5kBaYOYvlzUq+H+Ua0IMDRzMZc25viKPVeIf9mDVg4G
 mEN1Up4lQs380M1w+QpOf39Ci0nYlB6nJB6336JIksJPKUlhTvGoxtSLQxbn0eSM4VBeGaswHjP
 Xn+EkItT9U7fAmEdqhJPk7oSaTjtS4ElPjq3mULCzwwawi6VSu/dye17myFRAIZuJH5Is5dbHwg
 vGM8CWfMbCe0J3cY/1YN5AjQpNSh7ad0+bCFaQwF30ysA60Gi2ikLDYh6Za0V6PzA0wh2WyiCI9
 rHUqI86yiaVh1PvTIm3cP2tqqueuTuqcmWqp/vVMBAQNBcSr/DqwM8yBY9MNN66tUO7bo09B80y
 l39TviRrUBmoE0VPE45w2g1uz3tzXz/eSWyCj7dwO61EFUuq2dZUuxyG6dDpVAdZfoZEkLjv1+l
 ob/RMOkwdyUokWjwZ5tLi+PnCLOtn/tiFNglNfVz3eBVLbLblgFbNzjpRYCxpsREVAmP2OV14FW
 CdxGX1pBqXDhzL7eOIAakjhFCEbM0QcY55yvlxileaE/XT2rOzs8nBptaFQ2mu46nkpnd/y1FLp
 hE7NIxj8ZXRFVAQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

With the write path converted to the per-pipe pool, the old on-stack
prealloc helpers (anon_pipe_get_page_prealloc, anon_pipe_refill_tmp_pages,
anon_pipe_free_pages) and the tmp_page[2] cache have no remaining users.
Remove them.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/pipe.c                 | 66 -----------------------------------------------
 include/linux/pipe_fs_i.h |  2 --
 2 files changed, 68 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 070fba8c865c1..108e498aee47e 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -111,40 +111,6 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
 	pipe_lock(pipe2);
 }
 
-/*
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
- */
-static void __maybe_unused anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
-						       size_t total_len)
-{
-	unsigned int want, i;
-	struct page *page;
-
-	prealloc->count = 0;
-	if (total_len <= PAGE_SIZE)
-		return;
-
-	want = min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
-		     PIPE_PREALLOC_MAX);
-
-	for (i = 0; i < want; i++) {
-		page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
-		if (!page)
-			break;
-		prealloc->pages[prealloc->count++] = page;
-	}
-}
-
 static struct page *anon_pipe_prealloc_pop(struct anon_pipe_prealloc *prealloc)
 {
 	if (!prealloc->count)
@@ -242,38 +208,6 @@ static void anon_pipe_put_page(struct pipe_inode_info *pipe,
 	put_page(page);
 }
 
-/*
- * Stash leftover prealloc pages in tmp_page[] so the next write to this
- * pipe gets a hot page without entering the allocator.
- */
-static void __maybe_unused anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
-						      struct anon_pipe_prealloc *prealloc)
-{
-	int i, idx;
-
-	if (!prealloc->count)
-		return;
-
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
-static void __maybe_unused anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
-{
-	while (prealloc->count) {
-		prealloc->count--;
-		put_page(prealloc->pages[prealloc->count]);
-	}
-}
-
 static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
 				  struct pipe_buffer *buf)
 {
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 796860cbddf30..6bd0d956691cb 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -84,7 +84,6 @@ struct anon_pipe_prealloc {
  *	@max_usage: The maximum number of slots that may be used in the ring
  *	@ring_size: total number of buffers (should be a power of 2)
  *	@nr_accounted: The amount this pipe accounts for in user->pipe_bufs
- *	@tmp_page: cached released page
  *	@prealloc: per-pipe page preallocation pool
  *	@readers: number of current readers of this pipe
  *	@writers: number of current writers of this pipe
@@ -116,7 +115,6 @@ struct pipe_inode_info {
 #ifdef CONFIG_WATCH_QUEUE
 	bool note_loss;
 #endif
-	struct page *tmp_page[2];
 	struct anon_pipe_prealloc prealloc;
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;

-- 
2.53.0-Meta

