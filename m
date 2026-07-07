Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440BD3F39F8;
	Tue,  7 Jul 2026 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436762; cv=none; b=E72Mg7Kri/qr1GAML59yhTTS3h3w7RTUeCjplGCFX8IXu2cF3xpKreOQU+DUC/hftXTKki6vt/dPeQYxoUXbfUHpRoCR6sUaDiSTjf185xv//fM51GYyofu+6arDfwC3UxkmOOmcgQcyk8b7OThFVilTVDETrsYmS/3NyBMgsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436762; c=relaxed/simple;
	bh=kx+yPO3duqEuhKfJwajcCraoOJcqomVeaB59Rdl5ggQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bTvdsg0E44VRZaclkLr9ebNLNsjvuBCjVjNGJUJdIXiNlemt0isSwdMem52sxg7Sc1QLqfauwn5oz9rbpMyu2uT0RmriaKLbkljvyu+5xn+w2ZO2WGwAioxhlOWb/twK2ehYtMAwX4PG9ruReT7ojiSnA7is8ivF3as8Iz7L3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XkowzbcX; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XkowzbcX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=qu2Rl5doclwgoTyRJ8DDQ0cuBHl4khJwt2kvXqF+n4Y=; b=XkowzbcXIoBTOmsFJFwN+8tYdL
	fNe+1/uXfvnLdnFf1ltJjP7Vy4kQ+F/oTRvb07g53bNq/R/LPZMkxkn2p/3xJADq+47gFj6iNOT5J
	JxYjayOQKnxhAGh/7j61eqiFC8dn8scB6x82Yy3oY4f2WCPuzbxUM92Map3zb1TMdLjoB3xUeM7oN
	xtRVqj6r92HUaTev6mvzRYszdx0RR844Rzdvj26BKz/RYlIwSpN227l3ULQbQrqPO8t8O7SOfhRSm
	n5xK/vA+BF5F3D/McbRCVn4dk16DkbDF64qCjAkJ2Zkv+2YYKXhJrN26+mSkIsnh2Sn+mlvbb600i
	ejXpthVg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wh7N1-002GtK-1z;
	Tue, 07 Jul 2026 15:05:59 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 07 Jul 2026 08:05:01 -0700
Subject: [PATCH v2 4/4] fs/pipe: remove the old on-stack prealloc helpers
 and tmp_page[2]
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pipe-unification-v2-4-eb52bddeeefd@debian.org>
References: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
In-Reply-To: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4033; i=leitao@debian.org;
 h=from:subject:message-id; bh=kx+yPO3duqEuhKfJwajcCraoOJcqomVeaB59Rdl5ggQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqTRXC+zxAPL8JhemD+nG/FR11yvjoFtzULU0Jd
 wFT4+W/OaCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCak0VwgAKCRA1o5Of/Hh3
 bac0D/9a6NnWgR2dbyQ936a5Ao2d1AbDIhMkDLkQF24oqfxVUzMhzy93s6KQMjNBWqfg6skU9z7
 cTGKdcTxMtYbk0VEcAJ8T9a1eRJNZtK2m1WsuVnlkEe1+OihQYI4k1U8X9Ju2RT9k6kdTqXbQW8
 p+zp7vE1EeoQIHc7s94cWRSzstRo/3vv6mCBK9JPeRZWvPdnL5APTJn7jf5OLRu8/YtDzyTfsDJ
 MeNyLOWNOzoPbggxCj/fEwsGzbon2kzxc3iiGcwQTJId2+4DEsccrOyOkrOYMtRJM/uTSTLokE4
 Ty4YLh+kf9P+J2KA6YSdSW0JROqTZ8D7MbiVwP4n59nrjYC757tiEGL+aZc4VGJgJrj8wbW4Lqc
 Lx/tvTSKw8m/b+mRzwaRTr6rXtySfc5lYTTmMsNwfHpwnlVMJmkZ+EL9IpyDKAYf/RoGGwhgbXw
 RHaXz/amUUARcNsOUwnhv7glQS2pkoiSVKI10B6vF4vP/J5d87KX39s2bm1SCIF9umGCt2BuG+9
 Vf+ay3WWdvEIUBM3VIocQblHgSPijf/i/r2HgR2JjejWMOG2dvMdYIWaq8q3PI6xSMntoWZO+Kr
 mZHs6jsSaF9scFvFo4uhChK6Iv/DjcdpO5SPw+LVdjk0PZ+WKD3N1BKypAdwS7P78QKJgSbvw1p
 aFGuEPmPqkqnfEw==
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
index 3288a16f8a40a..c163b05ef9708 100644
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
@@ -249,38 +215,6 @@ static void anon_pipe_put_page(struct pipe_inode_info *pipe,
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

