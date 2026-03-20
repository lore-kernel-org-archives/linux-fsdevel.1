Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B43E5EF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031327; cv=none; b=fGPmZGRmLDt8S4DFvPnQjzu7HWalpTUY18WW/rvw9ux1+vRPveBhEYw0nbJ87KTIzHmjhyZlqfMTdNS9uBewMSQ4tPoz9c5QieSqJk1CXC/cx2wMaTVgz2F2gIPOWdtWaEjORTpldgIx5LHxauKnSrWvvga30FYkACpYwu/ihi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031327; c=relaxed/simple;
	bh=ROMfGYd1LZZDpizt5KvMI5Hvlep5QW6GFQbuJzEUyh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwzRznOPY7Nr1Ez2s2ey96yZR3ifhu7kW3lLWmjYmXVk1N9dm0gu5U6FrgbKyBAEyb7jj6pdcVs6JMUS+qyi+CrLAdgwf5YZRTrb2l7J2t9mLQll0vjzSpm5tuIPBJcKPaj0CSdnMNlzW05V2TZJW1tx1YAUcX5TlQgMqanLh60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiq1qhDH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiq1qhDH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48541edecf9so23279685e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774031325; x=1774636125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdQSJEHFZ7rSPNbXPhY3/Q7gh3hfhmNkmSd9kla/fNA=;
        b=kiq1qhDHMxyv+TXqHSQ3/+VxQssA/c3hODQzoef8y1KceErs1PocrAL4N+qIeBYLYm
         JrhrPcIWk/1GHDmcGhb76FxEvKSt+21JUUa+hLEQ7WxoOmRMFn6etEHhH1FMJcQ6ae1s
         GhKYBp0hpZIvlMyoRQ06bUVlSxSEy05lARUSAqr6CbOfAc7F0/sIfI7f7hBHTzb7FNhO
         WjSI9SNIHnbNqGSjcgN7oLUcZDSe/rGzr5Jp4fvatg/wVfYpLG2GbmBMKX9qt39Myvab
         n4hy9B+UqQueaC3uFzHRc56epTRcNJJvBETW3hYX4ptHlXlrgNE6MJVjYn8f07U4mh3Y
         mQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774031325; x=1774636125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DdQSJEHFZ7rSPNbXPhY3/Q7gh3hfhmNkmSd9kla/fNA=;
        b=UC8p+givJS8dLjgNdX/eh7RcSTwenGQ9M6SurHGIh3wvsYoLw1tkf6+/f0ylzLhvid
         dl3ArwPgwozw3P+KrYxKLxlaBzDz281NlJOMJ9cYybSMramQcCPT6YbDmI6/k8oDxG/y
         Uljx4/4NpByksPO2dQn1KUQzXnTjIquTWlrkeoPEz1UqeEQ4u6u8jpJreTMgx3tjXVqF
         K3rXhS7WROVDwxQyO1jx0xC+axtXyBq4b+r38cTiunmXtnVQ14fFyWAUlpJ99UniZQqb
         gRFLBlr0DxEIZ7wN9cgOdG+IKEBfBvn5+7kXSXw5oVoAOxGRzbMoaQZ6SShnz9B/2/ou
         kttw==
X-Forwarded-Encrypted: i=1; AJvYcCU4WG/XfZo1BQo/kMfDbb3RNxh7CjqMPnYy5sypwSzzh1GTEOuR8NTkn9FNEfd0oR1Sr4F4rCjeeDkW49X4@vger.kernel.org
X-Gm-Message-State: AOJu0YyRac+IdER2/Vzth9MwtaFlJ9SvHlmuX2sHfWsDnsshGN1WuuR4
	N+Ezp5AtgA67dNaNE7PNxoYHhyGQfOYlKqRyzpQ9lxjmrRVtjZWC4f3/
X-Gm-Gg: ATEYQzzPc+/FW0auFePw2QDQF88lh2Nn8Yq2g3ny/XU0WdybK1XyPK6tu+4NJWiSXLl
	ydKHqHW2hpyd0qW+yMQ1eAsR33TSm1Ua+GxJR6UX1/qy5xKywgvYIiB2HhVH1dTlVDTgrOFIx5P
	aaoIF8TO+QGrwasQrZM54MimN/DrqbaAqgsJGckMH1WLDkqil83N6X9ztQMscG6zM+p8dkGwCdk
	I4n3AUtSLQbLvINeVZWXqPJCUzmBBHNqBI0H1eiZGOvu2TxPaAtNdOIJyrXI1xtxQanzctx2h3F
	gg+ny1qMOf/xtm9grahdxwmcZSfnzQ63UMVaK45jQannXd3S4TjEQWcjN0Tvf/8NbsIT7HUyXaI
	RSNqPhXKkeIvpiskesti96o+94ugNexQZvLZKcv3Ho4lCK1y+yzwhJxgAiFg7WRD+DHZizdE07b
	XhTdu6q8evyoVk6X7gbsfxL9+9NOqEhZF7vm+o5BChCUyeHN8ZQoN7ifToWw==
X-Received: by 2002:a05:600c:5288:b0:485:3bb5:92cf with SMTP id 5b1f17b1804b1-486fedc9a5fmr66441895e9.12.1774031324726;
        Fri, 20 Mar 2026 11:28:44 -0700 (PDT)
Received: from ddp-thinkpad.tail20b0d.ts.net ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7e2665sm92433725e9.6.2026.03.20.11.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:28:44 -0700 (PDT)
From: Daniele Di Proietto <daniele.di.proietto@gmail.com>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Daniele Di Proietto <daniele.di.proietto@gmail.com>
Subject: [PATCH v2 1/2] io_uring: Extract io_file_get_fixed_node helper
Date: Fri, 20 Mar 2026 18:23:40 +0000
Message-ID: <20260320182341.780295-2-daniele.di.proietto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320182341.780295-1-daniele.di.proietto@gmail.com>
References: <20260320182341.780295-1-daniele.di.proietto@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has two users and it's about to have a third in a future commit.

Reading io_slot_flags() and io_slot_file() outside of
io_ring_submit_lock() should be fine after a reference has been
acquired, as those are immutable.

Signed-off-by: Daniele Di Proietto <daniele.di.proietto@gmail.com>
---
 io_uring/io_uring.c | 20 ++++++++++++++++----
 io_uring/io_uring.h |  2 ++
 io_uring/splice.c   |  6 +-----
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 9a37035e76c0..726245a28b87 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1553,22 +1553,34 @@ void io_wq_submit_work(struct io_wq_work *work)
 		io_req_task_queue_fail(req, ret);
 }
 
-inline struct file *io_file_get_fixed(struct io_kiocb *req, int fd,
-				      unsigned int issue_flags)
+inline struct io_rsrc_node *io_file_get_fixed_node(struct io_kiocb *req, int fd,
+						   unsigned int issue_flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_rsrc_node *node;
-	struct file *file = NULL;
 
 	io_ring_submit_lock(ctx, issue_flags);
 	node = io_rsrc_node_lookup(&ctx->file_table.data, fd);
 	if (node) {
 		node->refs++;
+	}
+	io_ring_submit_unlock(ctx, issue_flags);
+
+	return node;
+}
+
+inline struct file *io_file_get_fixed(struct io_kiocb *req, int fd,
+				      unsigned int issue_flags)
+{
+	struct io_rsrc_node *node;
+	struct file *file = NULL;
+
+	node = io_file_get_fixed_node(req, fd, issue_flags);
+	if (node) {
 		req->file_node = node;
 		req->flags |= io_slot_flags(node);
 		file = io_slot_file(node);
 	}
-	io_ring_submit_unlock(ctx, issue_flags);
 	return file;
 }
 
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 0fa844faf287..1ed44201fa77 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -170,6 +170,8 @@ void __io_commit_cqring_flush(struct io_ring_ctx *ctx);
 
 unsigned io_linked_nr(struct io_kiocb *req);
 void io_req_track_inflight(struct io_kiocb *req);
+struct io_rsrc_node *io_file_get_fixed_node(struct io_kiocb *req, int fd,
+					    unsigned int issue_flags);
 struct file *io_file_get_normal(struct io_kiocb *req, int fd);
 struct file *io_file_get_fixed(struct io_kiocb *req, int fd,
 			       unsigned issue_flags);
diff --git a/io_uring/splice.c b/io_uring/splice.c
index e81ebbb91925..3c5021a46e79 100644
--- a/io_uring/splice.c
+++ b/io_uring/splice.c
@@ -60,22 +60,18 @@ static struct file *io_splice_get_file(struct io_kiocb *req,
 				       unsigned int issue_flags)
 {
 	struct io_splice *sp = io_kiocb_to_cmd(req, struct io_splice);
-	struct io_ring_ctx *ctx = req->ctx;
 	struct io_rsrc_node *node;
 	struct file *file = NULL;
 
 	if (!(sp->flags & SPLICE_F_FD_IN_FIXED))
 		return io_file_get_normal(req, sp->splice_fd_in);
 
-	io_ring_submit_lock(ctx, issue_flags);
-	node = io_rsrc_node_lookup(&ctx->file_table.data, sp->splice_fd_in);
+	node = io_file_get_fixed_node(req, sp->splice_fd_in, issue_flags);
 	if (node) {
-		node->refs++;
 		sp->rsrc_node = node;
 		file = io_slot_file(node);
 		req->flags |= REQ_F_NEED_CLEANUP;
 	}
-	io_ring_submit_unlock(ctx, issue_flags);
 	return file;
 }
 
-- 
2.43.0

