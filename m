Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9F410D0C;
	Fri, 15 May 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840944; cv=none; b=Gz+9EXeH3Sj6vjRP8h5KvR6FDgeStGDJl9qWdJWCogZmNCib8SnzBbHSrkUnYXBYz4Cynf7+PNZsHc2lidMOWMtU6NzTTGtFGqEEJ2H6IR54i9mLkHmQOxXDAMwbli0FFByELWE51qD2mFpS70Z5MxoQtHsuFHMw9Qgz/6nzrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840944; c=relaxed/simple;
	bh=MPURX6JFlAquZBbR7yyzF8vZZq340uZMJDshW8LZBPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXUR5peJEXEK8cqkCI2qedqlsHTXuQ+Fm96k8riltmP5Qv151y5yYL2sdbfcnzXWYHcHsXydW59dkimuqviRDVETHiSR+gv0XM9FYmbq672kqpmNjSpG1vAx3BvXZ2p1zDs2Qz8pKjuXFxKovHjy+mhXNUKh8OSMcJ27teEzfY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=g2tNiYs7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="g2tNiYs7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=rCPR2AgJvJjAbhXX3W+kZLQf9geRDBUDTHySUo4oNXE=; b=g2tNiYs7eN8jSN2OF+QImOBBua
	rP3j29vXHwRTfiXoJatZ/Vn1aG4RvBW+IoJyL6a935TQx4G1o4Xv++mjo5IpnZbDMqHX4yozXGuU4
	rvGZL9yobnZRY7sm9Y0uRt/waBVACyL/L5ahl2TDtuQalx/2Vnn2MOUztj/pf8WftUuymcm0L7UnK
	fIwuMOq/6nSV3dBApm8mc5VPikmJu7xcz9uuHbRUerWtzg7LgmjVLPiRtxqr8Zor93epI14DJaWo9
	X6V9Z/waiOOL6NGW3vFWkMggE0KDycGtdNyVC19ebPRWR2fkSTzGfUv3QpIQA5b/JSw4Kry7eZsoC
	CZmRUa4A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNpmt-004fTo-1o;
	Fri, 15 May 2026 10:28:59 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 15 May 2026 03:28:44 -0700
Subject: [PATCH 1/2] fs/pipe: bulk pre-allocate pages outside pipe->mutex
 in anon_pipe_write
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-fix_pipe-v1-1-b14c840c7555@debian.org>
References: <20260515-fix_pipe-v1-0-b14c840c7555@debian.org>
In-Reply-To: <20260515-fix_pipe-v1-0-b14c840c7555@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 usama.arif@linux.dev, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4832; i=leitao@debian.org;
 h=from:subject:message-id; bh=MPURX6JFlAquZBbR7yyzF8vZZq340uZMJDshW8LZBPY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBvVimeYTLLrcByW/6F4+ao69Ef/k3DDp0EI+z
 YIsm1d7hD+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagb1YgAKCRA1o5Of/Hh3
 bUCuEACOYF3vXZNvkAYTQvVN4r/lZHxlgA+/Q3Eg06G1UqOHH61r+sCRFGDd8zRGjOLMZWhdv40
 c+0rsmOgU6b8z2hk5W/MXnZeVLkpUIjnFc1x+ZX7XanDFqJK0Jrp6W7UYqLiZ4iE4ffOtzK6MZy
 5hng4c9kh4NhDvywihwQWR4R1aLUlFIjoQLeGtVHNYHMIOP8IotODEKTD2kTL46mKywcym65WI4
 qIeudgEjPGLa4XxAWG0jYsSLEOZ0vaVL5+4x/Hn5+RdvtzUrnBBsC41VbZ2PFM2eF9pP170yK9w
 Ipx/WDPXCWjiA2KrY6AeTb1xnQdtlC/ntrocV1rQyvsK9sS/OC505eM8P1LqwqedcXdP6AYoqLg
 RlwZLrZjl3qt7V3pPb/WPXp10z7ECaH9kJY3NmehT1fz/EJNNJdkKvgNQt5sck5eLejRaWavFgf
 c34b2MiTW1CxwUd9Obh6BH0jAcsuhJy2+A355QNmhpS3dg8+mEiGPnl2R2Ci/Vx+BmABD20MyFN
 NQfzd1u9cDpkvCrAY8YLofdRuN3LPPh/Au2dw2Ih7cks/RcVyGD/VtSOLqJDvF4RvamARjK90zb
 TxqxbhTc5IUqoYPk0kHfEhLXuKxxNGsuv00rFWkbP0dw78tAHhkXcSJEfR0EjMd0HDbNJx9yiz9
 RwX22iPH2yrnzlA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

anon_pipe_write() takes pipe->mutex and then, from the per-iteration
anon_pipe_get_page() helper, used to call alloc_page(GFP_HIGHUSER |
__GFP_ACCOUNT) once per page while still holding it. That allocation
can sleep doing direct reclaim and/or runs memcg charging, which extends
the critical section and stalls a concurrent reader on the very same
mutex.

Bulk pre-allocate DIV_ROUND_UP(total_len, PAGE_SIZE) pages (up to
PIPE_PREALLOC_MAX (8)) pages outside the mutex when total_len >=
PAGE_SIZE, using alloc_pages_bulk().  (Under memcg, alloc_pages_bulk()
with __GFP_ACCOUNT might return less pages than requested, but, this is
still a win, given some pages allocation is moved outside of the
lock).

Pass the array into anon_pipe_get_page(), which now consumes from
tmp_page[] first, then from the prealloc array, and only as a last
resort falls back to alloc_page() under the mutex (reached only for
writes larger than 8 pages, where the prealloc cap is exhausted).

Doing this in one bulk call before the lock keeps the fast path's
mutex held for a single, write-bounded critical section -- no extra
mutex_unlock/_lock cycles -- so it avoids the per-page lock-handoff
overhead that a per-page drop-and-retake design would introduce, while
still moving the typical multi-page allocation off the critical
section. Unused prealloc pages are pushed to the pipe's tmp_page[]
cache (or freed) before unlock, so a subsequent write to the same
pipe gets a hot cached page rather than paying for an alloc again.

Sub-PAGE_SIZE writes are unchanged: the merge path handles them
without ever needing a fresh page, so it is not worth speculatively
allocating for them.

This can improve the pipe throughput up to 48% and reduce the latency in
33%.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/pipe.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9841648c9cf3e..7a1517d15107a 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -111,7 +111,11 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
 	pipe_lock(pipe2);
 }
 
-static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
+#define PIPE_PREALLOC_MAX 8
+
+static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe,
+				       struct page **prealloc,
+				       unsigned int *prealloc_n)
 {
 	for (int i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
 		if (pipe->tmp_page[i]) {
@@ -121,6 +125,14 @@ static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
 		}
 	}
 
+	if (*prealloc_n) {
+		unsigned int idx = --(*prealloc_n);
+		struct page *page = prealloc[idx];
+
+		prealloc[idx] = NULL;
+		return page;
+	}
+
 	return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
 }
 
@@ -438,6 +450,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t chars;
 	bool was_empty = false;
 	bool wake_next_writer = false;
+	struct page *prealloc[PIPE_PREALLOC_MAX] = { NULL };
+	unsigned int prealloc_n = 0;
 
 	/*
 	 * Reject writing to watch queue pipes before the point where we lock
@@ -455,6 +469,26 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
+	/*
+	 * Bulk pre-allocate up to PIPE_PREALLOC_MAX pages outside pipe->mutex
+	 * for writes that span at least one full page. alloc_page() with
+	 * GFP_HIGHUSER may sleep doing reclaim and runs memcg charging, so
+	 * doing it under the mutex extends the critical section and stalls
+	 * the reader. The merge path handles sub-PAGE_SIZE writes without
+	 * needing a fresh page; for writes larger than PIPE_PREALLOC_MAX
+	 * pages, anon_pipe_get_page() falls back to a single alloc_page()
+	 * under the mutex for the remainder. Unused prealloc pages are
+	 * returned to the pipe's tmp_page[] cache (or freed) before unlock.
+	 */
+	if (total_len >= PAGE_SIZE) {
+		unsigned int want = min_t(unsigned int,
+					  DIV_ROUND_UP(total_len, PAGE_SIZE),
+					  PIPE_PREALLOC_MAX);
+
+		prealloc_n = alloc_pages_bulk(GFP_HIGHUSER | __GFP_ACCOUNT,
+					      want, prealloc);
+	}
+
 	mutex_lock(&pipe->mutex);
 
 	if (!pipe->readers) {
@@ -512,7 +546,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			struct page *page;
 			int copied;
 
-			page = anon_pipe_get_page(pipe);
+			page = anon_pipe_get_page(pipe, prealloc, &prealloc_n);
 			if (unlikely(!page)) {
 				if (!ret)
 					ret = -ENOMEM;
@@ -576,6 +610,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		wake_next_writer = true;
 	}
 out:
+	while (prealloc_n)
+		anon_pipe_put_page(pipe, prealloc[--prealloc_n]);
 	if (pipe_is_full(pipe))
 		wake_next_writer = false;
 	mutex_unlock(&pipe->mutex);

-- 
2.53.0-Meta

