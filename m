Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BEE37B027;
	Tue,  7 Jul 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436752; cv=none; b=TPugH9dT5FyL8c+m5nCbOTAV88kmxvzryTo2E4v5ss6pHqisVdaXCAQCOEHSm+6vI+fTSoxkqDnVYM4N4hbDUCp99xgT+DOzske7cJ+wOeC2GT7vC5uXT9r3oCQjegZ4QWmgXGEvLBbIApML4ruMeCbfgdV56Fe9QsZO3sQ04qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436752; c=relaxed/simple;
	bh=c0xPkSZ+CGHrK158YMqVBZtyJf91PIhU+tFt68XaCHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAZTkp6FpWsaOG1vcqUBdwp28kwAD7qB+x/KlE7ltZ3BCW4HvriwcgBdfoPIj1wMmuXcwbkGfh99bI2d9AKs4iWUAN38rygmY/gSzMXPwmuR5NM3HxfwfVHMaI0lAWMR4ukHmFtfIf9Qq+IvaB4Xglsk26agQ8h6Ji+5nNFbTZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Qt/sWW8c; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Qt/sWW8c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=JMp3PCajAO8/CYs9GJjL601oDeJjO9RKpbLAKcNiTvA=; b=Qt/sWW8cryxRUAfMuyS1cJUtxd
	MU9oNh70zp0I/vNwd52sqogGqrYzN057gXSPNZ9EvOaHbl31zoJ7YhZnLnLnan3PcFZ6nq4wxk8dv
	hDCI+YbtITO84c9k9gQGwelMYK+CQuZFBi+1pldIo7C+zPzGF7M3ofqnk26GT3VolDQ1jDf5eKROR
	xbMHWWTCq7VbgjAZOeJml0thx9XxEsQoHzbuwPPDwz39WxPEXVdGTrHszFhhqexZGuIty815SlLqE
	IlXcnx7NDhBeOQcHRTwisGdQKzDnCizfBrmfwg4lByXM8kqmzNXka1oRup0+qXcQUVB93G5QpFNc1
	z9QxjrPA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wh7Mp-002Gsi-0F;
	Tue, 07 Jul 2026 15:05:47 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 07 Jul 2026 08:04:58 -0700
Subject: [PATCH v2 1/4] fs/pipe: move the prealloc pool to per-pipe
 infrastructure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pipe-unification-v2-1-eb52bddeeefd@debian.org>
References: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
In-Reply-To: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3219; i=leitao@debian.org;
 h=from:subject:message-id; bh=c0xPkSZ+CGHrK158YMqVBZtyJf91PIhU+tFt68XaCHg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqTRXCqNVvleJY/ep7zKg/+zPuqjn8qBreMwKoU
 R27hpsNcW2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCak0VwgAKCRA1o5Of/Hh3
 bU2SD/4uoRRudpK5P2yEkDX8UNQCVIa2JDB2TtT1a5+GpJVw/ZCpB9Cy7JQtyycnBsh0Cb+vDvD
 /azr6xgSeyqrJ7FFnsVsVCDaydGmB+yBBpGjedGr++rHp/JywqTYMTZD5NjXzQV7b+HBfQ6QdU4
 bUs8/V/1O/47tcEIBCrmDDi8o7arfqrwNVlk46J2S9SOvbzkfzWeYZwnOTjFbfxF99ihwH05J0S
 mxkWAFenTP9G8EVNz5w0DpITdjrMGP7rPqTvg9C9IVPpTNaeoENHgzrBWAc6UUhwwrTwQTGtxcK
 Myd6pSO+hGzRTeZz2yKDjv/f0C7RoOuZUh8x/Il44y1gXvYwLmlPBL6TjakyAsiPzgF2j9R5D//
 w6iwAsrscrMGLzGBxK2CmAIVz5BBNq8ooIgQBYlRnjXEaUAAjvcCRf4/pLrZblX7FOoCNSMu8/F
 eCWPDWUJXzMWh+ioGQUnYZwBzwBvH1N1vO+sea3tC35qPj/mkaEh9HVBT8FK9l9pc/MHBMQZ63U
 I4Rcs5yDDb8bXAHJ84y3pvjWOqugfx+6Cmk/IpTW49guedz0rQd8q8vtQK/e1D16x3OLWhyddbB
 kA8OwMQpnl6K3C7XzihRjVVeBp6jxqi+Gib7/Goo2mAUfGfReiB82igfOzVX4Gy9euNv88N4Z+D
 RIFwAz7ARWZ5hgg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Move struct anon_pipe_prealloc and PIPE_PREALLOC_MAX to pipe_fs_i.h and
embed the pool in each pipe via a new prealloc field, next to the existing
tmp_page[2] cache (which will be removed by the end of this patchset).
Add PIPE_PREALLOC_KEEP for the post-write trim target.

PIPE_PREALLOC_KEEP (2) is the number of pages that will be buffered in
the pipe (similar to struct page *tmp_page[2]), which will be removed
soon.

The on-stack prealloc pool used by anon_pipe_write() is unchanged; this
only adds the per-pipe storage that later patches switch the read/write
paths over to.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/pipe.c                 |  7 -------
 include/linux/pipe_fs_i.h | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 429b0714ec575..325fd9757dbdd 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -111,13 +111,6 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
 	pipe_lock(pipe2);
 }
 
-#define PIPE_PREALLOC_MAX 8
-
-struct anon_pipe_prealloc {
-	struct page *pages[PIPE_PREALLOC_MAX];
-	unsigned int count;
-};
-
 /*
  * Pre-allocate pages outside pipe->mutex for multi-page writes.
  * alloc_page() with GFP_HIGHUSER can sleep in reclaim and runs memcg
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index a1eeed8006694..796860cbddf30 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -13,6 +13,9 @@
 #define PIPE_BUF_FLAG_LOSS	0x40	/* Message loss happened after this buffer */
 #endif
 
+#define PIPE_PREALLOC_MAX	8	/* max pages in prealloc pool */
+#define PIPE_PREALLOC_KEEP	2	/* keep at least this many after trim */
+
 /**
  *	struct pipe_buffer - a linux kernel pipe buffer
  *	@page: the page containing the data for the pipe buffer
@@ -57,6 +60,20 @@ union pipe_index {
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
@@ -68,6 +85,7 @@ union pipe_index {
  *	@ring_size: total number of buffers (should be a power of 2)
  *	@nr_accounted: The amount this pipe accounts for in user->pipe_bufs
  *	@tmp_page: cached released page
+ *	@prealloc: per-pipe page preallocation pool
  *	@readers: number of current readers of this pipe
  *	@writers: number of current writers of this pipe
  *	@files: number of struct file referring this pipe (protected by ->i_lock)
@@ -99,6 +117,7 @@ struct pipe_inode_info {
 	bool note_loss;
 #endif
 	struct page *tmp_page[2];
+	struct anon_pipe_prealloc prealloc;
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;
 	struct pipe_buffer *bufs;

-- 
2.53.0-Meta

