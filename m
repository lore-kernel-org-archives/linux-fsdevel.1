Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CBE282F31
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774135355; cv=none; b=ct2ALK17yYoXD5DIAxAd0WtnEFOeP1fPTzfZWnQqs8ZuxX+BCxxwib2+y5i6nhr8FW0CERCwMHIg7yUdkXa2HDBQdT2OYxp8L/fzUp0VljWjg0+HNU5J+zZRzj8RXs9bJ69EK+vYrJHcNHsOtiE/edhymPbMPvIkyikx/QS3NRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774135355; c=relaxed/simple;
	bh=ROMfGYd1LZZDpizt5KvMI5Hvlep5QW6GFQbuJzEUyh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wru401iXs4MsmKZ+aXIXcEslaHjIUaaMmUKgEAGEpDq21Zk3wpbo59Q5NEs8VnO5f1ZpAhPZCgU7STF7zMkLm1toctbvpbEzu6q2+VVjKCZI9ZmNxs8TmyzgSdkeQEFyCt9U+6F3/bNBzMUEUXjZ5q6qGbB8lvfb7DfoHlc8WyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR8yaP1s; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR8yaP1s"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso1789766f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774135353; x=1774740153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdQSJEHFZ7rSPNbXPhY3/Q7gh3hfhmNkmSd9kla/fNA=;
        b=bR8yaP1s+30hVqzDknmHx/kh56jaPd84wibErsEx96LwlnZPi1juWosuGXrdt0xa6i
         Qw1zv0Uyioxh7wzz25KwFbU4b6c16K3ak6dQC1LyEDnC1SZk+XmRe4OxWwEqXrIpQ4QW
         UO+PDYmDaXRw4+ZE50BuTgmlpoqyFEPCEKz4bCDRDWlFveAE1TSYQfta3ZCDrsZJ8yUJ
         fqPEON+Lm7VVIJmbJyL6XIiM8tnBd/NlmTXO8bKmeI7QP+Tu8LnXyj8FWlaP4/DcTVpo
         /ScZRPv6eDh74J0Jwjyd7FIv52L08MiL4xLSR01k2VERuPLQCLV/4aMl759pmgYK63u5
         uE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774135353; x=1774740153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DdQSJEHFZ7rSPNbXPhY3/Q7gh3hfhmNkmSd9kla/fNA=;
        b=PItZj2N7QCU3Ez4MoxIzkbu3U1MBL8zRnZPePszWkTvS5l4XJKL73CdNUkerJBy81Z
         +uvrjAQWIJTKK3+p5vnC99qCqz0BAQOgu+eiu0ZatScd0WhzLn2IaZTYVHkO6vneT7Z4
         P0J6r3m2uva/vQKHj4HO8FnCBBBBf/jEKPSUnmDLeBqdxCmnXvRPRozKxtLQ7192d+9z
         2uxbff+VYFkztSNPbI1OVooQPbGTWMlOTI4oFcvHTkIW2cCWfRZmtz85rSVFELY+6zC2
         coqEi4OIPNyecks138cOEaQiGrmVRCFEg8Csvh/7rr6HEG2mWiT8uZwWFodOdUa+BOqi
         rGxg==
X-Forwarded-Encrypted: i=1; AJvYcCXFp1D5popOpqjxXh3D7BoWOSSntM9JYfOAVThGZwOolEeMNeW4qHv/mvDCsPndZu4+xmYzxGYmmr26Oa56@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pwaGwYxlU0K3O8ZJa2wNcQSTUlsKkNQBMbDzgulT9SAYykWi
	ASh+9g6tSyl5kEb9+OqpYMEB4aLbMkTg6FMDUIhzGYIIIvnmqNJOzvJj
X-Gm-Gg: ATEYQzyUOz8NkCSktEZSa67XvCfamdhGJP0FlVvfntEQOkpnfehLcusuno1QE2eQC3u
	J0VNuC9nZ6HuoOfOdiDimRzAYI/pwbWSXTayx1kcLPFrENqGtsOrkm0mrXTg/s8aNBeDe235N1k
	zHT0wZz/Se4+88TlJ2bBYosjHkdpG0w19R7+e+XXmngGbOuxfNvXKxRPQLkdrm8uRX5y34DcPGm
	2tmjYUx4Ky+P7Rv4lyV7xwTkuP8ipVfchNsnx0iUxNJ78Cqhmq/p0R6CWMhB1V3zWkspRpTvuvl
	QLkgaJ/VUfAytW46R2etxm3KAhAN27gmTYiSGNKPEtanWs0uoH6r+LlVaoByfWHOVqGuhSogsWE
	wuawvhJldCVKrqYATEvN8bjsjxM95te2wQr7+aHXC8V6gL/NWQjeI4D+BU21MHw+2+Pibrd+Vmh
	KISoa+ABUOj+ihooZZCb64g1GRIwYfG5EcB8CSY2A6V93OvlMkoe/cQYQLv/E=
X-Received: by 2002:a05:6000:2f84:b0:43b:4d2e:a004 with SMTP id ffacd0b85a97d-43b64242f00mr11258972f8f.10.1774135352711;
        Sat, 21 Mar 2026 16:22:32 -0700 (PDT)
Received: from ddp-thinkpad.tail20b0d.ts.net ([95.141.20.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm15609897f8f.0.2026.03.21.16.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 16:22:32 -0700 (PDT)
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
Subject: [PATCH v3 1/4] io_uring: Extract io_file_get_fixed_node() helper
Date: Sat, 21 Mar 2026 23:21:39 +0000
Message-ID: <20260321232142.911280-2-daniele.di.proietto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321232142.911280-1-daniele.di.proietto@gmail.com>
References: <20260321232142.911280-1-daniele.di.proietto@gmail.com>
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

