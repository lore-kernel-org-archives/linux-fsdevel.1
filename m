Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D85C3FF1;
	Sun, 24 May 2026 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779633933; cv=none; b=Abc+8JVPVaJ9vdz99y3RHZu2sopp+DkETxPzoCQFbJK9rZVX64LYOdhm1yGLzJs+eQi0t24iY4iW+IswrvELdib9o4Jw8oQmBwdVkde+PCUaJSqz41J1vfjCTuKvV5ER8rvhuLehSkamTNfVCDFypz2xr0tv06L28MMwWjOxwaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779633933; c=relaxed/simple;
	bh=wsFayDdvCcbbdN70RHKxk0+ylgtcDhZ7jVKM6uw29Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VxsbG6sVULd/37ccjLWHtqADaDRTQSz8NdtV+iFEM4MNip6dNR2SZbGUEJOJKXODzGpN4l0SVsLiw0cHT7s8ZeTpx163aYWdLCZ+6tPhm5OULAv62r/aVfROXc1Hpt+MatzSkABYKgLD8Sy0KUnCXWgvHMYzigH6lMuBGemkdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GANjCxHh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GANjCxHh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=gqIwuyUbYsnIH/lFXH+STqAFeNJuSo2bMCvkxRl3oiM=; b=GANjCxHhG2ThtV5ryC5NjAH5FS
	i2DiGrIUjnfMEto5Wo0ssn2lApNGeTHRdgV5GiqIEw+umUM2yjyxZPJbCML9ZSpwSgB/LQ4+v349W
	v8RFYb7z1jc0aYlwxdgZuMQRK7UOp18k9jLffh0PSj3WEYb9+Co/8RkXhZDIXlXou0k+cQosBz0NL
	paDroAzY+zu7wl2ilsoDBNQZv1Mt2KayIe7i02hArvRd8l094iykitLfmseL9FAbyR+F8AavRDRZb
	a4dmYVIHmZ5S98GoEn+L9LBDIynomHXn20lDxlu3KOdN22z/lHB13PokF7DmieAnvjRFWR7YBsytl
	FfLRVoLQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wRA4y-000s6b-21;
	Sun, 24 May 2026 14:45:25 +0000
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 07:44:58 -0700
Subject: [PATCH v3 1/2] fs/pipe: pre-allocate pages outside pipe->mutex in
 anon_pipe_write
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-fix_pipe-v3-1-bb4a75d23a90@debian.org>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
In-Reply-To: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, 
 oleg@redhat.com, axboe@kernel.dk, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=5719; i=leitao@debian.org;
 h=from:subject:message-id; bh=wsFayDdvCcbbdN70RHKxk0+ylgtcDhZ7jVKM6uw29Z8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEw760bfHkAkogCdjDJLUCxGX2ApEqgXbEa0Q3
 oi77WclSXiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMO+gAKCRA1o5Of/Hh3
 bfrOEACUhLTb+2dnykUdoR6/cvALnNxNBWH0wOaj4x6aLEIkQOQEONJCrB00iPI9upb09HyfAZ8
 WF7pJuj0Pe4GgLdr4IJOx/Kmut6xsN9mG9ykav06JbBjPtqdWCKRZOM+qrcV4h2XjPpIY2VgmMA
 3ozH9A2hIKnn9z0vxbJrqPF84ACF41x2PYECwrh6zQbINIJWme+mK8WAtyiLk2NCJ+9zbFdhGPk
 GumehOQT2sPO2PjIGyGvS3xuAFpiAcfmIXHS3Qg4mtFKUMt0R7SUiFk43pO3wqhuWnZ96IptoH9
 SuxlfEgHDuasE7rPhDoHZElmnHO2QaMuXJEyGoHSyj72xiUFjYaoMKpukSOk2cXbCCPBTE+eUV9
 ix+gBhbJcJqivPHI7kLjuI0WjAQeE9W34WQdtMW57kswJyZxLnVEbyXiQUDDSaoxWAe13NvvElK
 XHxfgnOuo5TKtRGPhzuHFzBVBIDelYH72E30zNwIa9iar8+YXPmfuJNzoZjMmsknyRhK/iuJsWm
 UkvjLgloOk+/fouRbwGsLNy/4tr0hOAidZsmEUU3xVDz2tRmE3hI69XPYbXjblqRYwXkE3f7Gp8
 zmgyO7tD3fLwvrYZlpt+981CmqlTPKHwdup1/Ye/zhYkEqoxn9fFx6zp6oCN9Mg4v5dJ6mjO5Lo
 S0baeD1SpU/2UiA==
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

Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/pipe.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9841648c9cf3..e15795cf0c76 100644
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
@@ -576,9 +671,11 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
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

