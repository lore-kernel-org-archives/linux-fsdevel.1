Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5644CADF;
	Fri, 22 May 2026 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468283; cv=none; b=LsLkdkZ0EAahHmPR4NmqjQWgKDbJY4zvsfTEfTkh7Ojf0v8vNrsWd6L2cnsRN1iR2JW+mwh2Fvqx3cYXxcILtrFsdZgBfs//5b3+VSG7QwlhX8CsSuKvyNZHBodxI4hYq+vyX3DCNjIwvNpvcwGDOh/F05xbm3I1XUBxJ1dSAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468283; c=relaxed/simple;
	bh=/xHqRTO2zjYCKx0/GdOznI7H8QKk3Vyf9kPi929KwYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jfwYoU7LgemzHY580wh931WddIuZ4A/AyXD5xkctqXZFfJ3z8LW4QkxgH6No7MmvLSDT2+3pqpx5MHNW1a/8M9Ojj5yNRWoTxoHD5F2N+JsYhPAjZqq4suxPVAJ4SJM40YKaqDoO4NMcGTf+rb/ORk6Llaeni9F4Bga8/AFeCXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EC8jVXAv; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="EC8jVXAv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Aw+E1KV64PHL5+qduaNKFyFbxxy3EjSau0LQIK83gBE=; b=EC8jVXAvw0sO4BIpuTNjLu74M3
	7aeDirgFvqc/+mNJ5WXeVhiIaduI8NytS9N98Yb1l+kyNxoYgUYu9LhYUTgxSUxyXWcDy/yeoY8ZI
	jehBFMAG+/ZG3PQ2L3BF7QAddk5SLkxgTZ2BIlVL6F91MDsZjHuehpxYKEgXYB8QOf4sKvl2L64Tf
	p+HvDmxNbZoHqPlAz+h+kCnbIpS5/GbRi2tmVNRo8Nj8XnbSx9X7tX1J3Iy28OqQKYOeGj+lBnCET
	/JG+FjjQ1wFGDwYbpB9EqS+7RlI5LiSSJVxFVSmZbL9NzA23i/PNV0bZUCZEBikfA5HnbUMREixRL
	ynkrHlsg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQSzD-004nmg-0x;
	Fri, 22 May 2026 16:44:35 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 22 May 2026 09:44:21 -0700
Subject: [PATCH v2 1/2] fs/pipe: pre-allocate pages outside pipe->mutex in
 anon_pipe_write
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-fix_pipe-v2-1-a8b35a78244e@debian.org>
References: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
In-Reply-To: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, 
 oleg@redhat.com, axboe@kernel.dk, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=6089; i=leitao@debian.org;
 h=from:subject:message-id; bh=/xHqRTO2zjYCKx0/GdOznI7H8QKk3Vyf9kPi929KwYo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEIfob5uCweanJ/elEd9VoKupP6OUlA5/jNK/N
 TSkAYLuBIyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahCH6AAKCRA1o5Of/Hh3
 bVuOEACiubRtGu4seXhszduhutWH6QPeDgUF7krNFyRw+Ch6oUH4+0mx2GOoApetETyoz7g/84W
 HC5EcFVYtnLwtbqfN7Wo6TWbyBGL4StOel8pVGWbF1kfkSydt0aJXUAh15EiJKrYPEwa6arVBNs
 0t9p+tNEPDqsEW2broNT3Y+U+Q5q+BhnBYDMWlcstXNMMLSu8EJSN4zbLPXs6PiBO5//grJyxM9
 QziQS9zRzxe0VKGfCPqdy3XVc1vX78pXAE8naaubdjNEQ4O1Uqk2ouFu7Ikx6UfMDISt+cBEl/R
 GJBijQYVkNJ0EPx0WmZKBRcpmOEnnkII5FZUFddGQyoOL/b/KCub6ImiFYo4dFX2dXod0bx9HRw
 l4Vsbti6VVoruJkvrTaUapVZ4jD43bvo75wSaCbqoPQkW0Ed34yCoLGUREIDG4nWX3LXnQNWear
 dNNqkyyHi+pQyiciPgRrKQuvgeil5fZBrTe31MjmEzLix/wX7At4mvbWw2fZleqlEt889hqbrUD
 hoayCGYF2LnVlKg7X5zFLeR7CVJlkyugaiCagaVdx1rTBSt3LNiMHWJiEdwrW/0I0v70rPahfoz
 YoK2R1ppJ5pXKV+nAnGUaoEGg7A8W2kdhJ45FhEn2TyfyoNyk8B7ZkiVSeb/ryG11Cw8sR9+rKg
 lBQEkly8q8fAm0A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

anon_pipe_write() takes pipe->mutex (aka "mutex protecting the whole
thing") and then, from the per-iteration anon_pipe_get_page() helper,
used to call alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT) once per page
while still holding it.

That allocation can sleep doing direct reclaim and/or runs memcg
charging, which extends the critical section and stalls a concurrent
reader on the very same mutex.

Just pre-alloc the required pages before the lock in an array and just pop
them inside the lock.

This can improve the pipe throughput up to 48% and reduce the
latency in 33%, easily seen when there is memory pressure and direct
reclaim.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/pipe.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9841648c9cf3e..cff255217bbfe 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -111,16 +111,76 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
 	pipe_lock(pipe2);
 }
 
-static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
+#define PIPE_PREALLOC_MAX 8
+
+struct anon_pipe_prealloc {
+	struct page *pages[PIPE_PREALLOC_MAX];
+	unsigned int count;
+};
+
+/*
+ * Pre-allocate pages outside pipe->mutex for multi-page writes.
+ * alloc_page() with GFP_HIGHUSER can sleep in reclaim and runs memcg
+ * charging; doing it under the mutex stalls a concurrent reader.
+ *
+ * Loop alloc_page() instead of alloc_pages_bulk_*(): the bulk path refuses
+ * __GFP_ACCOUNT under memcg (see commit 8dcb3060d81d "memcg: page_alloc:
+ * skip bulk allocator for __GFP_ACCOUNT") and silently degrades to a single
+ * page. A per-page loop keeps memcg accounting and the task NUMA mempolicy
+ * honoured for every page; the per-call overhead is small compared to the
+ * pipe->mutex hold-time being shrunk. Any shortfall is covered by the
+ * in-lock alloc_page() fallback in anon_pipe_get_page().
+ */
+static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
+					size_t total_len)
+{
+	unsigned int want, i;
+	struct page *page;
+
+	prealloc->count = 0;
+	if (total_len <= PAGE_SIZE)
+		return;
+
+	want = min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
+		     PIPE_PREALLOC_MAX);
+
+	for (i = 0; i < want; i++) {
+		page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
+		if (!page)
+			break;
+		prealloc->pages[prealloc->count++] = page;
+	}
+}
+
+static struct page *anon_pipe_prealloc_pop(struct anon_pipe_prealloc *prealloc)
+{
+	if (!prealloc->count)
+		return NULL;
+
+	prealloc->count--;
+
+	return prealloc->pages[prealloc->count];
+}
+
+static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe,
+				       struct anon_pipe_prealloc *prealloc)
 {
+	struct page *page;
+
+	/* Drain prealloc first to keep tmp_page[] hot for later small writes. */
+	page = anon_pipe_prealloc_pop(prealloc);
+	if (page)
+		return page;
+
 	for (int i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
 		if (pipe->tmp_page[i]) {
-			struct page *page = pipe->tmp_page[i];
+			page = pipe->tmp_page[i];
 			pipe->tmp_page[i] = NULL;
 			return page;
 		}
 	}
 
+	/* FWIW: This is called with pipe->mutex held */
 	return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
 }
 
@@ -139,6 +199,38 @@ static void anon_pipe_put_page(struct pipe_inode_info *pipe,
 	put_page(page);
 }
 
+/*
+ * Stash leftover prealloc pages in tmp_page[] so the next write to this
+ * pipe gets a hot page without entering the allocator.
+ */
+static void anon_pipe_refill_tmp_pages(struct pipe_inode_info *pipe,
+				       struct anon_pipe_prealloc *prealloc)
+{
+	int i, idx;
+
+	if (!prealloc->count)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
+		if (pipe->tmp_page[i])
+			continue;
+		if (!prealloc->count)
+			return;
+		idx = --prealloc->count;
+		pipe->tmp_page[i] = prealloc->pages[idx];
+		prealloc->pages[idx] = NULL;
+	}
+}
+
+/* Runs after mutex_unlock() to keep put_page() out of the critical section. */
+static void anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
+{
+	while (prealloc->count) {
+		prealloc->count--;
+		put_page(prealloc->pages[prealloc->count]);
+	}
+}
+
 static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
 				  struct pipe_buffer *buf)
 {
@@ -432,6 +524,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
+	struct anon_pipe_prealloc prealloc;
 	unsigned int head;
 	ssize_t ret = 0;
 	size_t total_len = iov_iter_count(from);
@@ -455,6 +548,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
+	anon_pipe_get_page_prealloc(&prealloc, total_len);
+
 	mutex_lock(&pipe->mutex);
 
 	if (!pipe->readers) {
@@ -512,7 +607,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			struct page *page;
 			int copied;
 
-			page = anon_pipe_get_page(pipe);
+			page = anon_pipe_get_page(pipe, &prealloc);
 			if (unlikely(!page)) {
 				if (!ret)
 					ret = -ENOMEM;
@@ -566,7 +661,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		 * after waiting we need to re-check whether the pipe
 		 * become empty while we dropped the lock.
 		 */
+		anon_pipe_refill_tmp_pages(pipe, &prealloc);
 		mutex_unlock(&pipe->mutex);
+		anon_pipe_free_pages(&prealloc);
 		if (was_empty)
 			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
@@ -576,9 +673,11 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		wake_next_writer = true;
 	}
 out:
+	anon_pipe_refill_tmp_pages(pipe, &prealloc);
 	if (pipe_is_full(pipe))
 		wake_next_writer = false;
 	mutex_unlock(&pipe->mutex);
+	anon_pipe_free_pages(&prealloc);
 
 	/*
 	 * If we do do a wakeup event, we do a 'sync' wakeup, because we

-- 
2.54.0

