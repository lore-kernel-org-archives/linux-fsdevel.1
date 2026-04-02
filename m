Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF03F23D3
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147412; cv=none; b=r4ZxUdnxDlp+5PaqeR9yL/zxqT85zF798xu6eO8f5K+XLm/HaPs+qFhYTIO1lVF1iwwmu5b0/OocMMp5uFI8vtBfXo+H3xJoOVJ5dgz3BiQQybOcNmkCPxI44bcXeR3Nv8FEcDBe+cpvSyDaj8Ex0syNy5flyjbQqlcKiWK+g2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147412; c=relaxed/simple;
	bh=EXmnSuokNGlNIdUUMSDWVxFnz65gfWkiC/YEF9Gd9tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVn0YItDITLOucgw9ckjrm5qk0m/z42mkoVvIwR9E/cmm96BdS9war+YFhSfSmhEdCh4pvECHdZtDPNwDGHkCM06BGQ4g38nFJVyEJj6R4UCHU+vzpbcTD8uQRMaFrbI5+LIOGeXoSnSD5EEAbU3ECcmiI6rjEoNqCupeKmYlWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VopfEpoS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VopfEpoS"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2adff872068so4951515ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147410; x=1775752210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDnMDd1d0+Hbkjlv7nYnVibela+7SffcMvd8aeSnL44=;
        b=VopfEpoSlY2t4zZn3/uvfX4fYdRzay2CeK6ramcQl2mfHyPpwd/yUFcSGsO8u8xW8e
         EfUDXUNjmjWFh1jbPRfKD3FnTo89UcmlLNTCiJ2adXlw8KNeRCm585ZvalHzrOjgvcwW
         NwqXu8M97LAtLQkcGAisKJC9GcTeV4jrB9qZLH7qxzPqY6atrXL8c4+QHWMYPlY5u8li
         BhEEaIEExGdD9D3zCc1d3SVlXczGJLLejIiExon257sIyDhNH1IxEcV74xnG1JIK/JWn
         wjKuqt1LXF8MDw8lUZp1XQ3bxkMC3p2Lo+bSemJTbc2x2iP8NRpCuTXJPFfhutOe8EPR
         tRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147410; x=1775752210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HDnMDd1d0+Hbkjlv7nYnVibela+7SffcMvd8aeSnL44=;
        b=GNg0pcRDsJ6QHZdcNwogLLEp9Svuhc7ZJyYKDkmLiXpbV3iSgw7P2iZYl6y1+55Gdu
         5OHzL2GTuNF+L3Blfq1rBDP0n3aZ07uzPqVIrImfSk5zGY2Ki/cN/yv+Ryu3Lo8SRRHd
         3sNCm8uZ9LcL0MlUkPCcF8qbZvdBsNkwtXKTkbKpTQK1LvNSYpk4usPVU5/xWg5F3XYq
         S6ROQxE+N93itWCJ2au768oXhDhRd9S8WNrWRgVZX9yXFTHFdlBYilCCEeZANkxI+8+S
         qMP7gdGPn37kCe/oA93VvpUmV1Phpw+3vtO7Cw4DgqzskAGvZlfNAXXW4zdhH3yIKsL7
         QFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlynvVJnzh17VGZ+FRx30cV86ea7HgJrbna7eC+Kd9xqZxPmOby/TPRbFH39BEzaumgEfgEgK4sxuuEXmb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3nZRkHUGFdKDY+I2pneuTWEv/pQsv9YrG8aXf5UXDqDEXRfXe
	qynZGAdEenW92vzVLN1e0DK8h7lo9Fp13jfHEOdyAjLu2EbVq2a9kE6T
X-Gm-Gg: AeBDievokKPG9Zhoty7jkGXAQqn3d+yXW0ieyAD4cfARFCuMbhiJeD2j2BApSf3uxRo
	5FH1kwzARMGMBgXbBXZUZUZ5/IAUHw1tDeOGbb9MMqAdbNTL66G89Cte+vGPS8vwKnsd0aPncLt
	TsqLXgM092Pn2AWqk+U3pXDA6SYr7Fu0U+wXVv36dGy1PS+yiUOvc4/wmoK7Kwian5Ohm/EYTym
	iJbQGAHlCaHeq4tKJ6Ygc7N5sQP3bmRSIiptTqbp/Cc8J+CrGZGvTMPqJ7qGpKHmHyvfjWskpk6
	qh9CEAglGOP7HktxYi2IA3YZ03ecefaSVQx26Q2ipJD4YeyRtrkKnKlhZ/JybeAtqxqATPHUAR5
	iajOkBNahHRyqXHMHYTvFROeaT8pcsVatOzRRz5+imPu+qaNQKD/q0oeQ+Z5h0DWBlCJgIsEt4M
	y7hfEGhRxXKf95n7OmfA==
X-Received: by 2002:a17:902:7c0a:b0:2b2:647b:a744 with SMTP id d9443c01a7336-2b269c7b362mr61271765ad.24.1775147410259;
        Thu, 02 Apr 2026 09:30:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d55fsm46391905ad.11.2026.04.02.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:30:09 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 12/14] fuse: add pinned payload buffers capability for io-uring buffer rings
Date: Thu,  2 Apr 2026 09:28:38 -0700
Message-ID: <20260402162840.2989717-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402162840.2989717-1-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the buffer ring pinning capability to payload buffers via the
FUSE_URING_PINNED_BUFFERS flag. When set alongside FUSE_URING_BUFRING,
the kernel pins and vmaps the payload buffer region during queue setup.

With pinned payloads, the kernel uses direct memcpy for all payload
buffer copies, avoiding the per-request overhead of pinning/unpinning
user pages and translating virtual addresses. This is particularly
beneficial for large payload copies.

As with pinned headers, buffers must be page-aligned. Pinned pages are
accounted against RLIMIT_MEMLOCK (bypassed with CAP_IPC_LOCK) and
unpinned in process context during connection abort.

In benchmarks using passthrough_hp on a high-performance NVMe-backed
system, pinned headers and pinned payload buffers showed around a 10%
throughput improvement for direct randreads (~2150 MiB/s to ~2400
MiB/s), a 4% improvement for direct sequential reads (~2510 MiB/s to
~2620 MiB/s), a 8% improvement for buffered randreads (~2100 MiB/s to
~2280 MiB/s), and a 6% improvement for buffered sequential reads (~2500
MiB/s to ~2670 MiB/s).

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c       | 54 +++++++++++++++++++++++++++++++++------
 fs/fuse/dev_uring_i.h     |  4 +++
 include/uapi/linux/fuse.h |  2 ++
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 79736b02cf9f..06d3d8dc1c82 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -52,6 +52,11 @@ static inline bool bufring_pinned_headers(struct fuse_ring_queue *queue)
 	return queue->bufring->use_pinned_headers;
 }
 
+static inline bool bufring_pinned_buffers(struct fuse_ring_queue *queue)
+{
+	return queue->bufring->use_pinned_buffers;
+}
+
 static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
 				   struct fuse_ring_ent *ring_ent)
 {
@@ -235,6 +240,11 @@ static void fuse_uring_bufring_unpin(struct fuse_ring_queue *queue)
 		fuse_bufring_unpin_mem(&br->pinned_headers);
 		br->use_pinned_headers = false;
 	}
+
+	if (bufring_pinned_buffers(queue)) {
+		fuse_bufring_unpin_mem(&br->pinned_bufs);
+		br->use_pinned_buffers = false;
+	}
 }
 
 void fuse_uring_destruct(struct fuse_conn *fc)
@@ -474,6 +484,7 @@ static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
 	unsigned int buf_size = READ_ONCE(cmd_req->init.buf_size);
 	struct iovec iov[FUSE_URING_IOV_SEGS];
 	bool pinned_headers = init_flags & FUSE_URING_PINNED_HEADERS;
+	bool pinned_bufs = init_flags & FUSE_URING_PINNED_BUFFERS;
 	void __user *payload, *headers;
 	size_t headers_size, payload_size, ring_size;
 	struct fuse_bufring *br;
@@ -523,7 +534,22 @@ static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
 		br->headers = headers;
 	}
 
-	payload_addr = (uintptr_t)payload;
+	if (pinned_bufs) {
+		err = fuse_bufring_pin_mem(&br->pinned_bufs, payload,
+					   payload_size);
+		if (err) {
+			if (pinned_headers)
+				fuse_bufring_unpin_mem(&br->pinned_headers);
+			kfree(br);
+			return err;
+		}
+		br->use_pinned_buffers = true;
+	}
+
+	if (pinned_bufs)
+		payload_addr = (uintptr_t)br->pinned_bufs.addr;
+	else
+		payload_addr = (uintptr_t)payload;
 
 	/* populate the ring buffer */
 	for (i = 0; i < nr_bufs; i++, payload_addr += buf_size) {
@@ -553,6 +579,7 @@ static bool queue_init_flags_consistent(struct fuse_ring_queue *queue,
 {
 	bool bufring = init_flags & FUSE_URING_BUFRING;
 	bool pinned_headers = init_flags & FUSE_URING_PINNED_HEADERS;
+	bool pinned_bufs = init_flags & FUSE_URING_PINNED_BUFFERS;
 
 	if (bufring_enabled(queue) != bufring)
 		return false;
@@ -560,7 +587,8 @@ static bool queue_init_flags_consistent(struct fuse_ring_queue *queue,
 	if (!bufring)
 		return true;
 
-	return bufring_pinned_headers(queue) == pinned_headers;
+	return bufring_pinned_headers(queue) == pinned_headers &&
+		bufring_pinned_buffers(queue) == pinned_bufs;
 }
 
 static struct fuse_ring_queue *
@@ -1011,13 +1039,15 @@ static int setup_fuse_copy_state(struct fuse_copy_state *cs,
 				 struct fuse_ring_ent *ent, int dir,
 				 struct iov_iter *iter)
 {
-	void __user *payload;
+	void __user *payload = NULL;
+	bool use_bufring = bufring_enabled(ent->queue);
+	bool pinned_buffers = use_bufring && bufring_pinned_buffers(ent->queue);
 	int err;
 
-	if (bufring_enabled(ent->queue))
-		payload = (void __user *)ent->payload_buf.addr;
-	else
+	if (!use_bufring)
 		payload = ent->payload;
+	else if (!pinned_buffers)
+		payload = (void __user *)ent->payload_buf.addr;
 
 	if (payload) {
 		err = import_ubuf(dir, payload, ring->max_payload_sz, iter);
@@ -1029,6 +1059,12 @@ static int setup_fuse_copy_state(struct fuse_copy_state *cs,
 
 	fuse_copy_init(cs, dir == ITER_DEST, iter);
 
+	if (pinned_buffers) {
+		cs->is_kaddr = true;
+		cs->kaddr = (void *)ent->payload_buf.addr;
+		cs->len = ent->payload_buf.len;
+	}
+
 	cs->is_uring = true;
 	cs->req = req;
 
@@ -1608,11 +1644,13 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 static bool init_flags_valid(u64 init_flags)
 {
 	u64 valid_flags =
-		FUSE_URING_BUFRING | FUSE_URING_PINNED_HEADERS;
+		FUSE_URING_BUFRING | FUSE_URING_PINNED_HEADERS |
+		FUSE_URING_PINNED_BUFFERS;
 	bool bufring = init_flags & FUSE_URING_BUFRING;
 	bool pinned_headers = init_flags & FUSE_URING_PINNED_HEADERS;
+	bool pinned_buffers = init_flags & FUSE_URING_PINNED_BUFFERS;
 
-	if (pinned_headers && !bufring)
+	if (!bufring && (pinned_headers || pinned_buffers))
 		return false;
 
 	return !(init_flags & ~valid_flags);
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 05c0f061a882..859ee4e6ba03 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -57,6 +57,7 @@ struct fuse_bufring_pinned {
 
 struct fuse_bufring {
 	bool use_pinned_headers: 1;
+	bool use_pinned_buffers: 1;
 	unsigned int queue_depth;
 
 	union {
@@ -65,6 +66,9 @@ struct fuse_bufring {
 		struct fuse_bufring_pinned pinned_headers;
 	};
 
+	/* only used if the buffers are pinned */
+	struct fuse_bufring_pinned pinned_bufs;
+
 	/* metadata tracking state of the bufring */
 	unsigned int nbufs;
 	unsigned int head;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e57244c03d42..51ecb66dd6eb 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -245,6 +245,7 @@
  *  - add FUSE_URING_BUFRING flag
  *  - add fuse_uring_cmd_req init struct
  *  - add FUSE_URING_PINNED_HEADERS flag
+ *  - add FUSE_URING_PINNED_BUFFERS flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -1308,6 +1309,7 @@ enum fuse_uring_cmd {
 /* fuse_uring_cmd_req flags */
 #define FUSE_URING_BUFRING		(1 << 0)
 #define FUSE_URING_PINNED_HEADERS	(1 << 1)
+#define FUSE_URING_PINNED_BUFFERS	(1 << 2)
 
 /**
  * In the 80B command area of the SQE.
-- 
2.52.0

