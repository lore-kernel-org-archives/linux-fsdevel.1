Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC93EFD34;
	Fri, 26 Jun 2026 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469615; cv=none; b=EzMb+IFmuknoNZDSB4yItDiZ2daSC78ctwMb7rKtWahe6MjcZMlT38OQrBgUr1RayJ1kbKX9qMTxDyPfz3k/jYmWy3ZfBYRPocOpCAJVeZmhCq57hJJIeM5dCyC72WOsGA9ZMGgHE5sTAn4B/Xg3DabMOJKwCtIzOrUzwdg0Usw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469615; c=relaxed/simple;
	bh=30Mifart66PNOREWQghDBMGF+JtVp5ZKAuUWN6kIxns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQ2rCBLrATLy3WSFfqd+vBOkntgNUKmkxIraeU9aTmvKw1htXCzINIl2nTK13ThjJVWTVxXYx4UtHyJ2uqOvMW5W+UNjxzV4S12UoxfNuWG9UqSAllY3GCk6RJU8lx98JValAEv3GTafw/QEor3iw+LDWxdXaBGg9LpjGZcOsAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=SCnijmx8; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="SCnijmx8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=lh7viwTZV0DElaZjYojU5JIUrRhCdNSvlyul6SWr+AQ=; b=SCnijmx8VlLT7ahqAmH1HUMEXa
	YIrRlK7v8jnPIkjXQAFQZyL3vT6dXQ1mo7SAGhE9hp5fh7FcddXagiA7pf2JOn9fOZhqWZjT9GcU/
	9dhlYSUjSjCzvXtH6W+mMAEHenoMPF9PatjGP7RccrMSnJDn257wEyKnVRUr4XMTEYcC9pMZL8O+G
	CbZ9T8BqlTZ7HceEYgIAdoBHf7/RzRJzTeG86fY3FKluBqkX2GLwZJQe/fDt4toFzI44AmXnItpnU
	FzsFFqmuYJXfJvlS6FaROfYopIsq6E3a6G5kDo3//BYAWXr886VCqRQ6417sJI840xCfET51lPXl8
	CeVC2DHw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd3lh-003u0F-2U;
	Fri, 26 Jun 2026 10:26:42 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 03:26:30 -0700
Subject: [PATCH RFC 1/4] fs/pipe: make the prealloc pool per-pipe
 infrastructure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-b4-pipe-unification-v1-1-d23fa6b1ee27@debian.org>
References: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
In-Reply-To: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3067; i=leitao@debian.org;
 h=from:subject:message-id; bh=30Mifart66PNOREWQghDBMGF+JtVp5ZKAuUWN6kIxns=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPlPZNFkZuAS3kf64x7I/r4N7+twwPbLcQfTRE
 Dz6TuOTGWiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj5T2QAKCRA1o5Of/Hh3
 bdn8D/9nifTU6aYM0Rqu4hXbF2X0MCDttsm4xSFKYUk8ET4lhMaJWmZIdwZN0n+AxNYEkqMMAey
 QQJqbHlb49HKY/tcxDO2akWWiLMbjS3I+u8CbIRwGbw/UoTxAPvCjQK1bNSyzJU0gWHQOAkYfLu
 ZKRXltgtzi42HcVUR5Qkxh8xhojBpMNReF8AuzIfh7HKmYYax1E6MB0xN59+LBCa8SqCPC9hEcB
 mInnEc0dtNXdUVVoil5S4C+Xuc9ftjvM4qpv1O+nA3z8T0FdStwpmPx73P+SpX7TTjfgialUWKL
 uyrYZG64Za9Acws+oMEiR2EtnLO/OlqxQRvcrU7Hc2ztoQhvXgkjVYZSuZIAPUPJdPk5svbpaO3
 8kMhnki0L1bqtvqyDu/vjGxwxwwetnNpxY0j4rZPhGzIiIs+ai6a0DK3ElY+fwvuCn4Rq3NO9zi
 3TulLNgDD/ycrEUoq2NCu4oLKn0tIUU3n2mCnUqyzy54ttI0hYHO5YTUqqvgPSs6hdAKvrNRpK3
 DSb6AIZtRjHWwdT+K87YbmqsxYFKO9A0dHLnklc4xt6kl26e0ggvQGbs/NV4mIy+EcJboDar3f8
 MUSqiRRDj3ESdUfpdiFbAzQFiDOKrwir7Xsv+eZHseEVelzS14SLf4rN2BiUo4ylpT3VvyyFNNE
 Vk6O3lR9V10CHLg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Move struct anon_pipe_prealloc and PIPE_PREALLOC_MAX to pipe_fs_i.h and
embed the pool in each pipe via a new prealloc field, next to the existing
tmp_page[2] cache (which will be removed by the end of this patchset).
Add PIPE_PREALLOC_KEEP for the post-write trim target.

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

