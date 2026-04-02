Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB23F23AD
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147415; cv=none; b=ZcALSpa9ZVHoWj7Lsn2dvJMqfNG/Bj3lD4D3ZG1T66cF0I8X4fGoKeSjprJg6ZOv0fv8C5JSBiBsoJlLWVS6tfc1XPLUZsLoeqbst7b2K/2zukMOQcr8c9OdnzEYzSxj1q1SFGdYWTU0H/c27HFYpPTol0tOl2NcEbdGmQ1L+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147415; c=relaxed/simple;
	bh=bMDLpvNblq/HKfLkq0s4E3Iu5YjHGOpbK3FG2iaveDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lr/JM0RJ7YuY7ZQyT9r4lIj7AIIsZITT/Z/Fm+YPDNZSM+T2A0Ft/oNfM/D2m6q5aTKUJUd4U3vUTF54NEjqjQ60U16xsRKuBl+UKrmxl4JkmId3rQAoXJiCurcDqG7ZHwit5Q50Z/6+d9itntwisab9D3QANpNqFQt9aomv4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaqC1hlQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaqC1hlQ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c76864f4e58so439670a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147412; x=1775752212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/uRjmZ8AYgDGetnl57sjA0Mu5iL8Amv11N8Rlt5iLY=;
        b=SaqC1hlQBNRax3ti++0ARX4NPPKsxn92uxZh2wEQOsfUs92YL6BzI3ClR/uIY2xIu1
         +uDO4CFaNE4ok8XClc+WLObN6OVINS0no29chBgGJApGhQhcppTmVQ+Lo62MKFuwsMd3
         Uk3HWwTSpPfFeqqj7IohG23Ho7WntfUHi2RVAThfGA/K27paK9Tigi1hoqEepx50jD/Q
         v9h9tK9DejF66RXLi77EZ4Lo8kskAwrTtgSTAswyBOW6jEKSV3dOw9IAxU25xGYpt1X8
         +Lj3Mmqkd7wNqSlAjxYe6dMDHe+mE9KVGXYIENqJ1KZvjbPSHl3JwKNX1nD8XawhmpOk
         BKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147412; x=1775752212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B/uRjmZ8AYgDGetnl57sjA0Mu5iL8Amv11N8Rlt5iLY=;
        b=lvVMN3uXdd0d1/Q80WoGbtIFfzA+5iRvUXAFPpIWM3QsiksZX0v3Hg8bnKVr4jTg1A
         3j/PeHw96Xjbg4BD/M6X+/dyMjaVjkEMXy7eoEjxbdoywdZ6Pd1KKKvOX2AIWQgwiA2M
         zScpDDfIc3WBapthfdpWZeJdkdd+kAlwW2+vFSZGaObbUKwC28k2LAMV9Df1OChzfBGA
         dNPfFN+msM3jKiV5F+DgkpEoEenUJsVJWlwGqiXPWuZ7T9EWgq2jvSZ3G7Kx6tMFgDeY
         O27ToqCKvT0BtTnA6BHMxTNPadGz7WmJDDZlu+Ey6/N2KDkY0ZIjiI7bEzxalP3+AoGc
         KeGA==
X-Forwarded-Encrypted: i=1; AJvYcCWtc/cL7EBg0BuRNom/DNtnw4SBc9Xl7YLFj7C6wHc7r2vMOetAbGldiEXmdnfRNMfnvW1yUl2zWQPncxq9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/I02h8Y/f7ps8ZCowaBdS+jjqBAFbuH0W+fjSEHunHJouxmW
	THBLSfcVWPdDBwm16dk8AO3j9WppsH8/YxOBYmKa7PdNO1Tyas7e4IDzg1Bbsw==
X-Gm-Gg: ATEYQzwlYhB+HLt7wKCgBZgHZ+/bDLwPu8jPUGuUwD6xkwfIVIIC44ZaGsBB6BDrXn6
	DXKsZI2UroqeKh2CFy3BznartGlosYbkfzdNwFeZ7gtocTItWyquq1sWTRZJgO8ymK4ZhIB/4Jj
	UMHcuoY/wNvPAakuJ9Pdg9TL8NXAFvpPLQtUt6O+9tQn4QABo2I2uEQuUb+0UhQlj4ryp3Dx+ST
	PH+E2m3GdMjg0zx5ze7NyjeiFvmyM856gVQ9J4Zp0ZkIgVJXfzcZw02vh3YlfjRYjiMeYK29nB6
	O3/9qISPqVNRKsHIK8+6TvgKv57KdjTTek2NJy1AuOQQXNsU1kNdRMe5DvzKkrPDx6pUcfhupoZ
	u9WbNWAHmd0g4iWo8XHP5J0HEjtnZYcGxtEDlWjKszB8nsGIoiQcC+q1B9Gi+YCh20GPxjTdlNi
	aohV32hShmSsff9ZKA+Q==
X-Received: by 2002:a05:6a20:4320:b0:398:a3e5:d04b with SMTP id adf61e73a8af0-39f10c7dbaamr3877820637.33.1775147412137;
        Thu, 02 Apr 2026 09:30:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65991a8sm3210180a12.28.2026.04.02.09.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:30:11 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 13/14] fuse: add zero-copy over io-uring
Date: Thu,  2 Apr 2026 09:28:39 -0700
Message-ID: <20260402162840.2989717-14-joannelkoong@gmail.com>
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

Implement zero-copy data transfer for fuse over io-uring, eliminating
memory copies between userspace, the kernel, and the fuse server for
page-backed read/write operations.

When the FUSE_URING_ZERO_COPY flag is set alongside FUSE_URING_BUFRING,
the kernel registers the client's underlying pages as a sparse buffer at
the entry's fixed id via io_buffer_register_bvec(). The fuse server can
then perform io_uring read/write operations directly on these pages.
Non-page-backed args (eg out headers) go through the payload buffer as
normal.

This requires CAP_SYS_ADMIN and buffer rings with pinned headers and
buffers. Gating on pinned headers and buffers keeps the configuration
space small and avoids partially-optimized modes that are unlikely to be
useful in practice. Pages are unregistered when the request completes.

The request flow for the zero-copy write path (client writes data,
server reads it) is as follows:
=======================================================================
|  Kernel                                   |  FUSE server
|                                           |
|  "write(fd, buf, 1MB)"                    |
|                                           |
|  >sys_write()                             |
|    >fuse_file_write_iter()                |
|      >fuse_send_one()                     |
|        [req->args->in_pages = true]       |
|        [folios hold client write data]    |
|                                           |
|  >fuse_uring_copy_to_ring()               |
|    >copy_header_to_ring(IN_OUT)           |
|      [memcpy fuse_in_header to            |
|       pinned headers buf via kaddr]       |
|    >copy_header_to_ring(OP)               |
|      [memcpy write_in header]             |
|                                           |
|    >fuse_uring_args_to_ring()             |
|      >setup_fuse_copy_state()             |
|        [is_kaddr = true]                  |
|        [skip_folio_copy = true]           |
|                                           |
|      >fuse_uring_set_up_zero_copy()       |
|        [folio_get for each client folio]  |
|        [build bio_vec array from folios]  |
|        >io_buffer_register_bvec()         |
|          [register pages at ent->id]      |
|        [ent->zero_copied = true]          |
|                                           |
|      >fuse_copy_args()                    |
|        [skip_folio_copy => return 0       |
|         for page arg, skip data copy]     |
|                                           |
|    >copy_header_to_ring(RING_ENT)         |
|      [memcpy ent_in_out]                  |
|    >io_uring_cmd_done()                   |
|                                           |
|                                           | [CQE received]
|                                           |
|                                           | [issue io_uring READ at
|                                           |  ent->id]
|                                           | [reads directly from
|                                           |client's pages (ZERO_COPY)]
|                                           |
|                                           | [write data to backing
|                                           | store]
|                                           |  [submit COMMIT AND FETCH]
|                                           |
|  >fuse_uring_commit_fetch()               |
|    >fuse_uring_commit()                   |
|      >fuse_uring_copy_from_ring()         |
|    >fuse_uring_req_end()                  |
|      >io_buffer_unregister(ent->id)       |
|        [unregister sparse buffer]         |
|      >fuse_zero_copy_release()            |
|        [folio_put for each folio]         |
|      [ent->zero_copied = false]           |
|      >fuse_request_end()                  |
|        [wake up client]                   |

The zero-copy read path is analogous.

Some requests may have both page-backed args and non-page-backed args.
For these requests, the page-backed args are zero-copied while the
non-page-backed args are copied to the buffer selected from the buffer
ring:
    zero-copy: pages registered via io_buffer_register_bvec()
    non-page-backed: copied to payload buffer via fuse_copy_args()

For a request whose payload is zero-copied, the
registration/unregistration path looks like:

    register:  fuse_uring_set_up_zero_copy()
                 folio_get() for each folio
                 io_buffer_register_bvec(ent->id)

    [server accesses pages via io_uring fixed buf at ent->id]

    unregister: fuse_uring_req_end()
                  io_buffer_unregister(ent->id)
                  -> fuse_zero_copy_release() callback
                     folio_put() for each folio

The throughput improvement from zero-copy depends on how much of the
per-request latency is spent on data copying vs backing I/O. When
backing I/O dominates, the saved memcpy is a negligible fraction of
overall latency. Please also note that for the server to read/write
into the zero-copied pages, the read/write must go through io-uring
as an IORING_OP_READ_FIXED / IORING_OP_WRITE_FIXED operation. If the
server's backing I/O is instantaneous (eg served from cache), the
overhead of the additional io_uring operation may negate the savings
from eliminating the memcpy.

In benchmarks using passthrough_hp on a high-performance NVMe-backed
system, zero-copy showed around a 35% throughput improvement for direct
randreads (~2150 MiB/s to ~2900 MiB/s), a 15% improvement for direct
sequential reads (~2510 MiB/s to ~2900 MiB/s), a 15% improvement for
buffered randreads (~2100 MiB/s to ~2470 MiB/s), and a 10% improvement
for buffered sequential reads (~2500 MiB/s to ~2750 MiB/s).

The benchmarks were run using:
  fio --name=test_run --ioengine=sync --rw=rand{read,write} --bs=1M
  --size=1G --numjobs=2 --ramp_time=30 --group_reporting=1

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c             |   7 +-
 fs/fuse/dev_uring.c       | 167 +++++++++++++++++++++++++++++++++-----
 fs/fuse/dev_uring_i.h     |   4 +
 fs/fuse/fuse_dev_i.h      |   1 +
 include/uapi/linux/fuse.h |   5 ++
 5 files changed, 160 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index a87939eaa103..cd326e61831b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1233,10 +1233,13 @@ int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 
 	for (i = 0; !err && i < numargs; i++)  {
 		struct fuse_arg *arg = &args[i];
-		if (i == numargs - 1 && argpages)
+		if (i == numargs - 1 && argpages) {
+			if (cs->skip_folio_copy)
+				return 0;
 			err = fuse_copy_folios(cs, arg->size, zeroing);
-		else
+		} else {
 			err = fuse_copy_one(cs, arg->value, arg->size);
+		}
 	}
 	return err;
 }
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 06d3d8dc1c82..d9f1ee4beaf3 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -31,6 +31,11 @@ struct fuse_uring_pdu {
 	struct fuse_ring_ent *ent;
 };
 
+struct fuse_zero_copy_bvs {
+	unsigned int nr_bvs;
+	struct bio_vec bvs[];
+};
+
 static const struct fuse_iqueue_ops fuse_io_uring_ops;
 
 enum fuse_uring_header_type {
@@ -57,6 +62,11 @@ static inline bool bufring_pinned_buffers(struct fuse_ring_queue *queue)
 	return queue->bufring->use_pinned_buffers;
 }
 
+static inline bool bufring_zero_copy(struct fuse_ring_queue *queue)
+{
+	return queue->bufring->use_zero_copy;
+}
+
 static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
 				   struct fuse_ring_ent *ring_ent)
 {
@@ -102,8 +112,18 @@ static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
 	}
 }
 
+static bool can_zero_copy_req(struct fuse_ring_ent *ent, struct fuse_req *req)
+{
+	struct fuse_args *args = req->args;
+
+	if (!bufring_enabled(ent->queue) || !bufring_zero_copy(ent->queue))
+		return false;
+
+	return args->in_pages || args->out_pages;
+}
+
 static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
-			       int error)
+			       int error, unsigned int issue_flags)
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
@@ -122,6 +142,11 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 
 	spin_unlock(&queue->lock);
 
+	if (ent->zero_copied) {
+		io_buffer_unregister(ent->cmd, ent->id, issue_flags);
+		ent->zero_copied = false;
+	}
+
 	if (error)
 		req->out.h.error = error;
 
@@ -485,6 +510,7 @@ static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
 	struct iovec iov[FUSE_URING_IOV_SEGS];
 	bool pinned_headers = init_flags & FUSE_URING_PINNED_HEADERS;
 	bool pinned_bufs = init_flags & FUSE_URING_PINNED_BUFFERS;
+	bool zero_copy = init_flags & FUSE_URING_ZERO_COPY;
 	void __user *payload, *headers;
 	size_t headers_size, payload_size, ring_size;
 	struct fuse_bufring *br;
@@ -508,7 +534,7 @@ static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
 	if (headers_size < queue_depth * sizeof(struct fuse_uring_req_header))
 		return -EINVAL;
 
-	if (buf_size < queue->ring->max_payload_sz)
+	if (!zero_copy && buf_size < queue->ring->max_payload_sz)
 		return -EINVAL;
 
 	nr_bufs = payload_size / buf_size;
@@ -521,6 +547,7 @@ static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
 	if (!br)
 		return -ENOMEM;
 
+	br->use_zero_copy = zero_copy;
 	br->queue_depth = queue_depth;
 	if (pinned_headers) {
 		err = fuse_bufring_pin_mem(&br->pinned_headers, headers,
@@ -580,6 +607,7 @@ static bool queue_init_flags_consistent(struct fuse_ring_queue *queue,
 	bool bufring = init_flags & FUSE_URING_BUFRING;
 	bool pinned_headers = init_flags & FUSE_URING_PINNED_HEADERS;
 	bool pinned_bufs = init_flags & FUSE_URING_PINNED_BUFFERS;
+	bool zero_copy = init_flags & FUSE_URING_ZERO_COPY;
 
 	if (bufring_enabled(queue) != bufring)
 		return false;
@@ -588,7 +616,8 @@ static bool queue_init_flags_consistent(struct fuse_ring_queue *queue,
 		return true;
 
 	return bufring_pinned_headers(queue) == pinned_headers &&
-		bufring_pinned_buffers(queue) == pinned_bufs;
+		bufring_pinned_buffers(queue) == pinned_bufs &&
+		bufring_zero_copy(queue) == zero_copy;
 }
 
 static struct fuse_ring_queue *
@@ -1063,6 +1092,7 @@ static int setup_fuse_copy_state(struct fuse_copy_state *cs,
 		cs->is_kaddr = true;
 		cs->kaddr = (void *)ent->payload_buf.addr;
 		cs->len = ent->payload_buf.len;
+		cs->skip_folio_copy = ent->zero_copied;
 	}
 
 	cs->is_uring = true;
@@ -1095,11 +1125,70 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	return err;
 }
 
+static void fuse_zero_copy_release(void *priv)
+{
+	struct fuse_zero_copy_bvs *zc_bvs = priv;
+	unsigned int i;
+
+	for (i = 0; i < zc_bvs->nr_bvs; i++)
+		folio_put(page_folio(zc_bvs->bvs[i].bv_page));
+
+	kfree(zc_bvs);
+}
+
+static int fuse_uring_set_up_zero_copy(struct fuse_ring_ent *ent,
+				       struct fuse_req *req,
+				       unsigned int issue_flags)
+{
+	struct fuse_args_pages *ap;
+	int err, i, ddir = 0;
+	struct fuse_zero_copy_bvs *zc_bvs;
+	struct bio_vec *bvs;
+
+	/* out_pages indicates a read, in_pages indicates a write */
+	if (req->args->out_pages)
+		ddir |= IO_BUF_DEST;
+	if (req->args->in_pages)
+		ddir |= IO_BUF_SOURCE;
+
+	WARN_ON_ONCE(!ddir);
+
+	ap = container_of(req->args, typeof(*ap), args);
+
+	zc_bvs = kmalloc(struct_size(zc_bvs, bvs, ap->num_folios),
+			 GFP_KERNEL_ACCOUNT);
+	if (!zc_bvs)
+		return -ENOMEM;
+
+	zc_bvs->nr_bvs = ap->num_folios;
+	bvs = zc_bvs->bvs;
+	for (i = 0; i < ap->num_folios; i++) {
+		bvs[i].bv_page = folio_page(ap->folios[i], 0);
+		bvs[i].bv_offset = ap->descs[i].offset;
+		bvs[i].bv_len = ap->descs[i].length;
+		folio_get(ap->folios[i]);
+	}
+
+	err = io_buffer_register_bvec(ent->cmd, bvs, ap->num_folios,
+				      fuse_zero_copy_release, zc_bvs,
+				      ddir, ent->id,
+				      issue_flags);
+	if (err) {
+		fuse_zero_copy_release(zc_bvs);
+		return err;
+	}
+
+	ent->zero_copied = true;
+
+	return 0;
+}
+
 /*
  * Copy data from the req to the ring buffer
  */
 static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
-				   struct fuse_ring_ent *ent)
+				   struct fuse_ring_ent *ent,
+				   unsigned int issue_flags)
 {
 	struct fuse_copy_state cs;
 	struct fuse_args *args = req->args;
@@ -1112,8 +1201,15 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		.commit_id = req->in.h.unique,
 	};
 
-	if (bufring_enabled(ent->queue))
+	if (bufring_enabled(ent->queue)) {
 		ent_in_out.buf_id = ent->payload_buf.id;
+		if (can_zero_copy_req(ent, req)) {
+			ent_in_out.flags |= FUSE_URING_ENT_ZERO_COPY;
+			err = fuse_uring_set_up_zero_copy(ent, req, issue_flags);
+			if (err)
+				return err;
+		}
+	}
 
 	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_DEST, &iter);
 	if (err)
@@ -1145,12 +1241,17 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
+	if (cs.skip_folio_copy && args->in_pages)
+		ent_in_out.payload_sz +=
+			args->in_args[args->in_numargs - 1].size;
+
 	return copy_header_to_ring(ent, FUSE_URING_HEADER_RING_ENT,
 				   &ent_in_out, sizeof(ent_in_out));
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
-				   struct fuse_req *req)
+				   struct fuse_req *req,
+				   unsigned int issue_flags)
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
@@ -1168,7 +1269,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 		return err;
 
 	/* copy the request */
-	err = fuse_uring_args_to_ring(ring, req, ent);
+	err = fuse_uring_args_to_ring(ring, req, ent, issue_flags);
 	if (unlikely(err)) {
 		pr_info_ratelimited("Copy to ring failed: %d\n", err);
 		return err;
@@ -1179,11 +1280,25 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 				   sizeof(req->in.h));
 }
 
-static bool fuse_uring_req_has_payload(struct fuse_req *req)
+static bool fuse_uring_req_has_copyable_payload(struct fuse_ring_ent *ent,
+						struct fuse_req *req)
 {
 	struct fuse_args *args = req->args;
 
-	return args->in_numargs > 1 || args->out_numargs;
+	if (!can_zero_copy_req(ent, req))
+		return args->in_numargs > 1 || args->out_numargs;
+
+	/*
+	 * the asymmetry between in_numargs > 2 and out_numargs > 1 is because
+	 * the per-op header is extracted before fuse_copy_args() for inargs but
+	 * not for outargs
+	 */
+	if ((args->in_numargs > 1) && (!args->in_pages || args->in_numargs > 2))
+		return true;
+	if (args->out_numargs && (!args->out_pages || args->out_numargs > 1))
+		return true;
+
+	return false;
 }
 
 static int fuse_uring_select_buffer(struct fuse_ring_ent *ent)
@@ -1245,7 +1360,7 @@ static int fuse_uring_next_req_update_buffer(struct fuse_ring_ent *ent,
 		return 0;
 
 	buffer_selected = !!ent->payload_buf.addr;
-	has_payload = fuse_uring_req_has_payload(req);
+	has_payload = fuse_uring_req_has_copyable_payload(ent, req);
 
 	if (has_payload && !buffer_selected)
 		return fuse_uring_select_buffer(ent);
@@ -1263,22 +1378,23 @@ static int fuse_uring_prep_buffer(struct fuse_ring_ent *ent,
 		return 0;
 
 	/* no payload to copy, can skip selecting a buffer */
-	if (!fuse_uring_req_has_payload(req))
+	if (!fuse_uring_req_has_copyable_payload(ent, req))
 		return 0;
 
 	return fuse_uring_select_buffer(ent);
 }
 
 static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
-				   struct fuse_req *req)
+				   struct fuse_req *req,
+				   unsigned int issue_flags)
 {
 	int err;
 
-	err = fuse_uring_copy_to_ring(ent, req);
+	err = fuse_uring_copy_to_ring(ent, req, issue_flags);
 	if (!err)
 		set_bit(FR_SENT, &req->flags);
 	else
-		fuse_uring_req_end(ent, req, err);
+		fuse_uring_req_end(ent, req, err, issue_flags);
 
 	return err;
 }
@@ -1386,7 +1502,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 
 	err = fuse_uring_copy_from_ring(ring, req, ent);
 out:
-	fuse_uring_req_end(ent, req, err);
+	fuse_uring_req_end(ent, req, err, issue_flags);
 }
 
 /*
@@ -1396,7 +1512,8 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
  * Else, there is no next fuse request and this returns false.
  */
 static bool fuse_uring_get_next_fuse_req(struct fuse_ring_ent *ent,
-					 struct fuse_ring_queue *queue)
+					 struct fuse_ring_queue *queue,
+					 unsigned int issue_flags)
 {
 	int err;
 	struct fuse_req *req;
@@ -1408,7 +1525,7 @@ static bool fuse_uring_get_next_fuse_req(struct fuse_ring_ent *ent,
 	spin_unlock(&queue->lock);
 
 	if (req) {
-		err = fuse_uring_prepare_send(ent, req);
+		err = fuse_uring_prepare_send(ent, req, issue_flags);
 		if (err)
 			goto retry;
 	}
@@ -1523,7 +1640,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	 * no-op and the next request will be serviced when a buffer becomes
 	 * available.
 	 */
-	if (fuse_uring_get_next_fuse_req(ent, queue))
+	if (fuse_uring_get_next_fuse_req(ent, queue, issue_flags))
 		fuse_uring_send(ent, cmd, 0, issue_flags);
 	return 0;
 }
@@ -1645,12 +1762,17 @@ static bool init_flags_valid(u64 init_flags)
 {
 	u64 valid_flags =
 		FUSE_URING_BUFRING | FUSE_URING_PINNED_HEADERS |
-		FUSE_URING_PINNED_BUFFERS;
+		FUSE_URING_PINNED_BUFFERS | FUSE_URING_ZERO_COPY;
 	bool bufring = init_flags & FUSE_URING_BUFRING;
 	bool pinned_headers = init_flags & FUSE_URING_PINNED_HEADERS;
 	bool pinned_buffers = init_flags & FUSE_URING_PINNED_BUFFERS;
+	bool zero_copy = init_flags & FUSE_URING_ZERO_COPY;
+
+	if (!bufring && (pinned_headers || pinned_buffers || zero_copy))
+		return false;
 
-	if (!bufring && (pinned_headers || pinned_buffers))
+	if (zero_copy &&
+	    (!capable(CAP_SYS_ADMIN) || !pinned_headers || !pinned_buffers))
 		return false;
 
 	return !(init_flags & ~valid_flags);
@@ -1795,9 +1917,10 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
 	int err;
 
 	if (!tw.cancel) {
-		err = fuse_uring_prepare_send(ent, ent->fuse_req);
+		err = fuse_uring_prepare_send(ent, ent->fuse_req, issue_flags);
 		if (err) {
-			if (!fuse_uring_get_next_fuse_req(ent, queue))
+			if (!fuse_uring_get_next_fuse_req(ent, queue,
+							  issue_flags))
 				return;
 			err = 0;
 		}
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 859ee4e6ba03..0546f719fc65 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -58,6 +58,8 @@ struct fuse_bufring_pinned {
 struct fuse_bufring {
 	bool use_pinned_headers: 1;
 	bool use_pinned_buffers: 1;
+	/* this is only allowed on privileged servers */
+	bool use_zero_copy: 1;
 	unsigned int queue_depth;
 
 	union {
@@ -96,6 +98,8 @@ struct fuse_ring_ent {
 			 */
 			unsigned int id;
 			struct fuse_bufring_buf payload_buf;
+			/* true if the request's pages are being zero-copied */
+			bool zero_copied;
 		};
 	};
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index aa1d25421054..67b5bed451fe 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -39,6 +39,7 @@ struct fuse_copy_state {
 	bool is_uring:1;
 	/* if set, use kaddr; otherwise use pg */
 	bool is_kaddr:1;
+	bool skip_folio_copy:1;
 	struct {
 		unsigned int copied_sz; /* copied size into the user buffer */
 	} ring;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 51ecb66dd6eb..c2e53886cf06 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -246,6 +246,7 @@
  *  - add fuse_uring_cmd_req init struct
  *  - add FUSE_URING_PINNED_HEADERS flag
  *  - add FUSE_URING_PINNED_BUFFERS flag
+ *  - add FUSE_URING_ZERO_COPY flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -1257,6 +1258,9 @@ struct fuse_supp_groups {
 #define FUSE_URING_IN_OUT_HEADER_SZ 128
 #define FUSE_URING_OP_IN_OUT_SZ 128
 
+/* Set if the ent's payload is zero-copied */
+#define FUSE_URING_ENT_ZERO_COPY	(1 << 0)
+
 /* Used as part of the fuse_uring_req_header */
 struct fuse_uring_ent_in_out {
 	uint64_t flags;
@@ -1310,6 +1314,7 @@ enum fuse_uring_cmd {
 #define FUSE_URING_BUFRING		(1 << 0)
 #define FUSE_URING_PINNED_HEADERS	(1 << 1)
 #define FUSE_URING_PINNED_BUFFERS	(1 << 2)
+#define FUSE_URING_ZERO_COPY		(1 << 3)
 
 /**
  * In the 80B command area of the SQE.
-- 
2.52.0

