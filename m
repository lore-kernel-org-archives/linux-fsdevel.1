Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F9E3090CC
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780726359; cv=none; b=NThtycyvhIMXpbUTYvAkeuO7mtQ4M6AfHn4hTFCyhe0KvuqIQbRde5OIlXhpVNUPW2C1Z75Bb7aEJW0QpD5ClZhSE9HCELAZhYX+kCBKh7GFBkQOvA38By7L+OS4a5LBzzTZIN3ftGMbTjb0glpomSD0LP1uAIHNdGtZpGLM1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780726359; c=relaxed/simple;
	bh=qZiu7fS8kCZwF8htRjH//VRi7MyCn+kxzvosWiYjiV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opDhOHHDz/Fb6/QxbMW0kpo0lsktgoW4AffFBzZcpAnM0x3gnHVPXHXXRRZtRZGa34ZdLKP/wQpnYZm7cUek4t6A7qx7HFxv4c1RFv8kMm1KL2QxI9Y0OqtMC1zbR/ujWbtCGSbZVhbR4El3kyZ7WdAQv3GZid1LAgGhmcHtj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4s7ECxT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4s7ECxT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso1909757f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 23:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780726357; x=1781331157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhjLk1CMHsJsOzOKQ1JbfvjErAaIXQv49sV6IFA3w98=;
        b=L4s7ECxTUjG0RDR3WRK3BqiiobD46Pe2PuXxbGIjV7aQ7oZjPFdSWw9K+z8QGFl9vd
         ooopF3muoWuT8/+JvGAAQly7+qEYOjvnyirFepJ1O+L2ozkOox3jTYsaWlX59Cm6Jr+b
         uF69w7fjnJcEPFFSves52eqvnSji2yx1Pq034qcRi8pn0wMhVyR/EhwYyNfkK3pBxhTt
         xfLpYL4v01Nd/smdKvYZalHR7hMy9sYdamMYZWsRDyep9SNVzk8zm6qofTd4BYKWOD4c
         EifQHVjNsQG69TrCjxXzvUjJv6LIP5jJTtEfOki8rmwwFw3R1r9qpLpFePMbdgy3P4Uq
         KEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780726357; x=1781331157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhjLk1CMHsJsOzOKQ1JbfvjErAaIXQv49sV6IFA3w98=;
        b=UN9fj3RuuUIXcFn1nFIQVOgZErBB0xQ2NAQHUDjNsN8L2E3GWHpS34Dw08RIO6aNEJ
         XnUtqHpqJKPo4m4fM7q7Kxpn9iDvA6TDhiXK4ZsINThCpHzHEY+nfoylxUH5XdRE4Yla
         2Q54qpqiG7rQKQhmvpJ45TpJEvz6WbBJhE8/fpINJhYBhAGIBEZWv0Fmric56I7XpxOB
         7RVMtRjSE7yE53TEP4RldU3H4hhjZ36Ni0uUmPlwq+ZtrjRzKf9cpmy7wmOZl8Vn/1rl
         qdEK1g2zApuAyU5XXscaEvnCR6zSZsYNiSk1+vvzFeCjydYsIq/bqyWm8wuohO1mPN5l
         JG1Q==
X-Gm-Message-State: AOJu0YxWJCuRnqnA63kUkenQrtU6A8yQkgOTvBRsXY/tDEH6Y/SSocd2
	VFi3VjBFHmOU/gRk7YCgcIUTIfS0hwGlAtpXoVGOYeiNMNT/RygF/y7V3oykcg==
X-Gm-Gg: Acq92OHsV0Z6VW+BCQMxHXoyEM5TVCBm3uKNweAwj1ndjjpir6LLAU4d0dyf/Coo2WI
	DfNdBCiba1iSBx/L7pfIfQlbug+wfZ1U+ko2IP1Xy+bl9pNZrB4Zzq6idYTjPdvbe2bHOxL1Vky
	YU1AVfcbHKQonRJlOyMBWRSTmIomgWe3+xS+sPf8zkd5nYyHe3X04WUrIfIiuU8sJAFs0ZsDJV1
	LYGaeyqRjUdbO4FLtvS1hOx3z2wEW7UgIMIeJDsTGjSKj4IlIHpA5JXtVEeE109gdnIjm9muAWs
	FXmne3AeSfFzcsu8LtKLCHgv7a+IBjd2Ky0wInDzQTE+wQ6U9s2DP4LGjX1zt7ZrmFYa3obDYWG
	FocgTym7J6LNyNa5MSOSLlqe6G231luLmg6230utb2Etql+i1AoEo1REUPf+/OyYE0b+3zcGVKM
	Q8gE32Z1vT3bsCQ9+QllGRRSBxEdXnbA==
X-Received: by 2002:adf:e545:0:b0:45e:e44b:3136 with SMTP id ffacd0b85a97d-4603063a715mr8180799f8f.19.1780726356710;
        Fri, 05 Jun 2026 23:12:36 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f344541sm29667978f8f.22.2026.06.05.23.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 23:12:36 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	ltp@lists.linux.it,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH 4/5] pipe: move wait_for_space to fs/pipe.c and rename it
Date: Sat,  6 Jun 2026 06:10:30 +0000
Message-ID: <20260606061031.3744880-5-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
References: <20260606061031.3744880-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed, because I plan to use it in fs/read_write.c.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/pipe.c                 | 17 +++++++++++++++++
 fs/splice.c               | 19 +------------------
 include/linux/pipe_fs_i.h |  2 ++
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9841648c9..c0ccf21b9 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1451,6 +1451,23 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 	return ret;
 }
 
+int pipe_wait_for_space(struct pipe_inode_info *pipe, bool non_block)
+{
+	for (;;) {
+		if (unlikely(!pipe->readers)) {
+			send_sig(SIGPIPE, current, 0);
+			return -EPIPE;
+		}
+		if (!pipe_is_full(pipe))
+			return 0;
+		if (non_block)
+			return -EAGAIN;
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		pipe_wait_writable(pipe);
+	}
+}
+
 static const struct super_operations pipefs_ops = {
 	.destroy_inode = free_inode_nonrcu,
 	.statfs = simple_statfs,
diff --git a/fs/splice.c b/fs/splice.c
index 707db2c2c..d12243d19 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,23 +1239,6 @@ ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 }
 EXPORT_SYMBOL(splice_file_range);
 
-static int wait_for_space(struct pipe_inode_info *pipe, bool non_block)
-{
-	for (;;) {
-		if (unlikely(!pipe->readers)) {
-			send_sig(SIGPIPE, current, 0);
-			return -EPIPE;
-		}
-		if (!pipe_is_full(pipe))
-			return 0;
-		if (non_block)
-			return -EAGAIN;
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-		pipe_wait_writable(pipe);
-	}
-}
-
 static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			       struct pipe_inode_info *opipe,
 			       size_t len, unsigned int flags);
@@ -1268,7 +1251,7 @@ ssize_t splice_file_to_pipe(struct file *in,
 	ssize_t ret;
 
 	pipe_lock(opipe);
-	ret = wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
+	ret = pipe_wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
 	if (!ret)
 		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index a1eeed800..be653625d 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -335,4 +335,6 @@ struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice);
 int create_pipe_files(struct file **, int);
 unsigned int round_pipe_size(unsigned int size);
 
+int pipe_wait_for_space(struct pipe_inode_info *pipe, bool non_block);
+
 #endif
-- 
2.47.3

