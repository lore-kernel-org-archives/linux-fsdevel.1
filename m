Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157945BE3
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392392; cv=none; b=TTTko0sKidz3s3Einv2x1i2SatH0Elsy2vixiy2VpeEaoZL9C7UBfap02BxMw45cQT608odRycG9ZrAvTuMeTZt3F4HG7BWikb2zcdO0KyzjZkuIbrdue82ipJpByxAX4s03d2mtcAQTXQuW5OWYkK4HOWY+XWIQJgd8G2xcEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392392; c=relaxed/simple;
	bh=hSnu7+41+1EmriTOJrVGBVWFFe0doecd3EFnKxLuM3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeSierxR0SirFgKIWMCdfvMJpSF3mInfAud9NGUdxR8kIllZOH8rjrQ/2OOqGw/HqTclP5MN2yl6lbKRtZNZRB5pY4/Rp6x+zYoor7+UtN2Svm5N/ngJdtcMCRoTW43ij1GnP6aQj8DyEuOELyMqWJTBFASyJeqldcCcil5DQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6tUk3ZD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6tUk3ZD"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82c20b9f989so2041579b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392390; x=1774997190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LW+MuV9rgJSKVQ3Kt7hBTWPySJ74EbrDJ/EilXH77o=;
        b=f6tUk3ZDseJVLJuclDkPb06OXBKrN8C6KpODyDgP+m6vVo77/vCuK5I/jHPkWJ120t
         lGJHkH00AfEjkuWTSfp0YGKr2gFXfYBuXqI+zUXdyHgwTcQPp7D02KVsPUj2QAXtXfMr
         N8WDmwYitugNF3lXBj7VWGnRqlvv47tUgojfMKhPqEwt3S2qgjn+H7VO/YP+b02KokI+
         e9Z10eZdHWu5MPXz1G86Qoy/7CoruzLdMai262oHT889iL+TDYhPcYXaj3DIlQu9IoVH
         JE9JfHyawFUBSZ+4p2MS+LmyhMfjcYaSL3sqiTYeBHpd3YThmL7uTtlSFZgRQQZK1qOW
         YU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392390; x=1774997190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LW+MuV9rgJSKVQ3Kt7hBTWPySJ74EbrDJ/EilXH77o=;
        b=aGwew5EBkr+BUZjrJQl42hAJ2IhQ6B88WIln6GLWlOzftCNszE1Za9Hn+KxDpvUEsW
         rwCE5ujqQ8xQxSkCj/GOy3pMANCcpZt32jcGF84H5fdueyroEqaavWKvNWiv8zlGexo+
         FWDrciayV1vwd2doyJKL8sZoqhtwmcMFLrQbsCfEWfiYqVouv92qik0U8EoHVSmg0jAG
         MFhNWTWAVk5KGL41v9syXEmUcLTu9yFTmopThgbyD5cfltQQxdFNSFmYkY6sK8KJJvE9
         amPd8ojek3y5qrvLnQ0i63HFSAFkDYwMEP2MVHv5j14pBpK5ohPY8/XSvicBs5id6EK/
         UCJw==
X-Forwarded-Encrypted: i=1; AJvYcCWFUe5v1vzO5ktIOfoFiGbnXb41i2wMgejI+vSLQlx+GB2YdB6TYTL1mvv01Q9FqvSvpWUeE4Wt+IbVXuvA@vger.kernel.org
X-Gm-Message-State: AOJu0YwhiqZWeb+KbYPGLhsA3L6CxLKzTQQvxWL4JVwGXUescvN67NP0
	+FWDF+BhWT6vzAk30p2f1DNm7Z0aYVA5yGo80SKzz1HFusyE4yqGPYyx
X-Gm-Gg: ATEYQzz8sB3UcA4hUwlYRwHyRV8UVmpHdATm8Laj4e7xvJ2i5YzArTwuyyRAhM/JDRs
	ma/9zQuBIcfntVcrCieELYGG44HC6UtY1cxK9FoO7FsMG+7sWkasnCAeMfYiksIIcq9zlCRKr7z
	YG2GTXkwI/h5ezmnfXsHmbnPhR3i0546VEAxYfNMRD7KNB+6d9dlLZG1v3s7+udurV200GThEMN
	/SYrSAZ52kcJ9/w5Fg+zu0qewt9pdjq9rOXBdp32QFZj+4s2H07X4qNhf7LR5MuHO3kZ++u2NjZ
	fZ8b2EnptOgwEwyXBAk3m5i6bXGffB2R5X4zYeqnRE8UMopuzFtUY8tXqqNjF10gJ4eHMb1PNHy
	uvI6CNq/ROcQrBHSOYpqY65qcYHi7QwZIHQB84Mb5Q8/OG1qDvp6Sk2Y0ghUT7hoKuBxa6DDQSP
	ACRLw6H39e7gmlJ8LXFw==
X-Received: by 2002:a05:6a00:3d0b:b0:82a:17b8:1474 with SMTP id d2e1a72fcca58-82c6de85836mr1163601b3a.1.1774392390324;
        Tue, 24 Mar 2026 15:46:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b04220d9asm12995386b3a.60.2026.03.24.15.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:46:29 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: miklos@szeredi.hu,
	bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 8/9] fuse: add zero-copy over io-uring
Date: Tue, 24 Mar 2026 15:45:31 -0700
Message-ID: <20260324224532.3733468-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324224532.3733468-1-joannelkoong@gmail.com>
References: <20260324224532.3733468-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement zero-copy data transfer for fuse over io-uring, eliminating
memory copies between kernel and userspace for read/write operations.

This is only allowed on privileged servers and requires the server to
preregister the following:
a) a kernel-managed buffer ring
b) a registered memory region large enough to hold the headers
c) a sparse buffer corresponding to the queue depth

The sparse buffer is where the client's pages reside. The registered
memory region is where the headers (struct fuse_uring_req_header) are
placed. The kernel-managed buffer ring is where any non-zero-copied args
reside (for example, out headers).

Benchmarks with bs=1M showed approximately the following differences in
throughput:
direct randreads: ~20% increase (~2100 MB/s -> ~2600 MB/s)
buffered randreads: ~25% increase (~1900 MB/s -> 2400 MB/s)
direct randwrites: no difference (~750 MB/s)
buffered randwrites: ~10% increase (950 MB/s -> 1050 MB/s)

The benchmark was run using fio on the passthrough_hp server:
fio --name=test_run --ioengine=sync --rw=rand{read,write} --bs=1M
--size=1G --numjobs=2 --ramp_time=30 --group_reporting=1

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c             |   7 +-
 fs/fuse/dev_uring.c       | 163 ++++++++++++++++++++++++++++++++------
 fs/fuse/dev_uring_i.h     |   6 +-
 fs/fuse/fuse_dev_i.h      |   1 +
 include/uapi/linux/fuse.h |   3 +-
 5 files changed, 151 insertions(+), 29 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7fee4ff64348..c94a8cc3a996 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1231,10 +1231,13 @@ int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 
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
index cd45b6a8e6c6..7409fccf93ca 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -31,6 +31,11 @@ struct fuse_uring_pdu {
 	struct fuse_ring_ent *ent;
 };
 
+struct fuse_zero_copy_bvs {
+	unsigned nr_bvs;
+	struct bio_vec bvs[];
+};
+
 static const struct fuse_iqueue_ops fuse_io_uring_ops;
 
 enum fuse_uring_header_type {
@@ -47,6 +52,11 @@ static inline bool bufring_enabled(struct fuse_ring_queue *queue)
 	return queue->bufring.enabled;
 }
 
+static inline bool zero_copy_enabled(struct fuse_ring_queue *queue)
+{
+	return queue->bufring.zero_copy;
+}
+
 static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
 				   struct fuse_ring_ent *ring_ent)
 {
@@ -92,8 +102,14 @@ static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
 	}
 }
 
+static bool can_zero_copy_req(struct fuse_ring_ent *ent, struct fuse_req *req)
+{
+	return zero_copy_enabled(ent->queue) &&
+		(req->args->in_pages || req->args->out_pages);
+}
+
 static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
-			       int error)
+			       int error, unsigned issue_flags)
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
@@ -112,6 +128,11 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 
 	spin_unlock(&queue->lock);
 
+	if (ent->zero_copied) {
+		io_buffer_unregister(ent->cmd, ent->id, issue_flags);
+		ent->zero_copied = false;
+	}
+
 	if (error)
 		req->out.h.error = error;
 
@@ -314,6 +335,7 @@ static void *fuse_uring_get_buf_ring_headers(struct io_uring_cmd *cmd,
 
 static int fuse_uring_buf_ring_setup(struct io_uring_cmd *cmd,
 				     struct fuse_ring_queue *queue,
+				     bool zero_copy,
 				     unsigned int issue_flags)
 {
 	const struct fuse_uring_cmd_req *cmd_req =
@@ -323,7 +345,7 @@ static int fuse_uring_buf_ring_setup(struct io_uring_cmd *cmd,
 	void *headers;
 	int err;
 
-	if (!queue_depth)
+	if (!queue_depth || (zero_copy && !capable(CAP_SYS_ADMIN)))
 		return -EINVAL;
 
 	headers = fuse_uring_get_buf_ring_headers(cmd, headers_offset,
@@ -342,6 +364,7 @@ static int fuse_uring_buf_ring_setup(struct io_uring_cmd *cmd,
 	queue->bufring.headers = headers;
 	queue->bufring.queue_depth = queue_depth;
 	queue->bufring.enabled = true;
+	queue->bufring.zero_copy = zero_copy;
 
 	return 0;
 
@@ -352,7 +375,8 @@ static int fuse_uring_buf_ring_setup(struct io_uring_cmd *cmd,
 
 static struct fuse_ring_queue *
 fuse_uring_create_queue(struct io_uring_cmd *cmd, struct fuse_ring *ring,
-			int qid, bool use_bufring, unsigned int issue_flags)
+			int qid, bool use_bufring, bool use_zero_copy,
+			unsigned int issue_flags)
 {
 	struct fuse_conn *fc = ring->fc;
 	struct fuse_ring_queue *queue;
@@ -384,12 +408,13 @@ fuse_uring_create_queue(struct io_uring_cmd *cmd, struct fuse_ring *ring,
 	fuse_pqueue_init(&queue->fpq);
 
 	if (use_bufring) {
-		err = fuse_uring_buf_ring_setup(cmd, queue, issue_flags);
-		if (err) {
-			kfree(pq);
-			kfree(queue);
-			return ERR_PTR(err);
-		}
+		err = fuse_uring_buf_ring_setup(cmd, queue, use_zero_copy,
+						issue_flags);
+		if (err)
+			goto cleanup;
+	} else if (use_zero_copy) {
+		err = -EINVAL;
+		goto cleanup;
 	}
 
 	spin_lock(&fc->lock);
@@ -403,7 +428,8 @@ fuse_uring_create_queue(struct io_uring_cmd *cmd, struct fuse_ring *ring,
 		kfree(queue);
 
 		queue = ring->queues[qid];
-		if (bufring_enabled(queue) != use_bufring)
+		if (bufring_enabled(queue) != use_bufring ||
+		    zero_copy_enabled(queue) != use_zero_copy)
 			return ERR_PTR(-EINVAL);
 		return queue;
 	}
@@ -415,6 +441,11 @@ fuse_uring_create_queue(struct io_uring_cmd *cmd, struct fuse_ring *ring,
 	spin_unlock(&fc->lock);
 
 	return queue;
+
+cleanup:
+	kfree(pq);
+	kfree(queue);
+	return ERR_PTR(err);
 }
 
 static void fuse_uring_stop_fuse_req_end(struct fuse_req *req)
@@ -774,6 +805,7 @@ static int setup_fuse_copy_state(struct fuse_copy_state *cs,
 		cs->is_kaddr = true;
 		cs->len = ent->payload_kvec.iov_len;
 		cs->kaddr = ent->payload_kvec.iov_base;
+		cs->skip_folio_copy = can_zero_copy_req(ent, req);
 	}
 
 	cs->is_uring = true;
@@ -806,11 +838,70 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
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
+				       unsigned issue_flags)
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
+		folio_get(page_folio(bvs[i].bv_page));
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
@@ -843,6 +934,11 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		num_args--;
 	}
 
+	if (can_zero_copy_req(ent, req)) {
+		err = fuse_uring_set_up_zero_copy(ent, req, issue_flags);
+		if (err)
+			return err;
+	}
 	/* copy the payload */
 	err = fuse_copy_args(&cs, num_args, args->in_pages,
 			     (struct fuse_arg *)in_args, 0);
@@ -853,12 +949,17 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
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
@@ -876,7 +977,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 		return err;
 
 	/* copy the request */
-	err = fuse_uring_args_to_ring(ring, req, ent);
+	err = fuse_uring_args_to_ring(ring, req, ent, issue_flags);
 	if (unlikely(err)) {
 		pr_info_ratelimited("Copy to ring failed: %d\n", err);
 		return err;
@@ -887,11 +988,20 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
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
+	if ((args->in_numargs > 1) && (!args->in_pages || args->in_numargs > 2))
+		return true;
+	if (args->out_numargs && (!args->out_pages || args->out_numargs > 1))
+		return true;
+
+	return false;
 }
 
 static int fuse_uring_select_buffer(struct fuse_ring_ent *ent,
@@ -948,7 +1058,7 @@ static int fuse_uring_next_req_update_buffer(struct fuse_ring_ent *ent,
 		return 0;
 
 	buffer_selected = ent->payload_kvec.iov_base != NULL;
-	has_payload = fuse_uring_req_has_payload(req);
+	has_payload = fuse_uring_req_has_copyable_payload(ent, req);
 
 	if (has_payload && !buffer_selected)
 		return fuse_uring_select_buffer(ent, issue_flags);
@@ -966,22 +1076,23 @@ static int fuse_uring_prep_buffer(struct fuse_ring_ent *ent,
 		return 0;
 
 	/* no payload to copy, can skip selecting a buffer */
-	if (!fuse_uring_req_has_payload(req))
+	if (!fuse_uring_req_has_copyable_payload(ent, req))
 		return 0;
 
 	return fuse_uring_select_buffer(ent, issue_flags);
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
@@ -1086,7 +1197,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 
 	err = fuse_uring_copy_from_ring(ring, req, ent);
 out:
-	fuse_uring_req_end(ent, req, err);
+	fuse_uring_req_end(ent, req, err, issue_flags);
 }
 
 /*
@@ -1109,7 +1220,7 @@ static bool fuse_uring_get_next_fuse_req(struct fuse_ring_ent *ent,
 	spin_unlock(&queue->lock);
 
 	if (req) {
-		err = fuse_uring_prepare_send(ent, req);
+		err = fuse_uring_prepare_send(ent, req, issue_flags);
 		if (err)
 			goto retry;
 	}
@@ -1378,6 +1489,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 								       struct fuse_uring_cmd_req);
 	unsigned int init_flags = READ_ONCE(cmd_req->flags);
 	bool use_bufring = init_flags & FUSE_URING_BUF_RING;
+	bool use_zero_copy = init_flags & FUSE_URING_ZERO_COPY;
 	struct fuse_ring *ring = smp_load_acquire(&fc->ring);
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent;
@@ -1399,11 +1511,12 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 	queue = ring->queues[qid];
 	if (!queue) {
 		queue = fuse_uring_create_queue(cmd, ring, qid, use_bufring,
-						issue_flags);
+						use_zero_copy, issue_flags);
 		if (IS_ERR(queue))
 			return PTR_ERR(queue);
 	} else {
-		if (bufring_enabled(queue) != use_bufring)
+		if (bufring_enabled(queue) != use_bufring ||
+		    zero_copy_enabled(queue) != use_zero_copy)
 			return -EINVAL;
 	}
 
@@ -1506,7 +1619,7 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
 	int err;
 
 	if (!tw.cancel) {
-		err = fuse_uring_prepare_send(ent, ent->fuse_req);
+		err = fuse_uring_prepare_send(ent, ent->fuse_req, issue_flags);
 		if (err) {
 			if (!fuse_uring_get_next_fuse_req(ent, queue,
 							  issue_flags))
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 36496013e3e8..2fdb733a4170 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -49,7 +49,7 @@ struct fuse_ring_ent {
 		struct {
 			/*
 			 * unique fixed id for the ent. Used by kernel/server to
-			 * locate the header data.
+			 * locate the header data and zero-copy backing pages.
 			 */
 			unsigned int id;
 			/*
@@ -61,6 +61,8 @@ struct fuse_ring_ent {
 			 */
 			unsigned int buf_id;
 			struct kvec payload_kvec;
+			/* true if the request's pages are being zero-copied */
+			bool zero_copied;
 		};
 	};
 
@@ -130,6 +132,8 @@ struct fuse_ring_queue {
 	 */
 	struct {
 		bool enabled: 1;
+		/* this is only allowed on privileged servers */
+		bool zero_copy: 1;
 		unsigned int queue_depth;
 		/*
 		 * pointer to where the headers reside in the registered memory
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
index 8f6ab0693a3d..57499f25d65c 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -242,7 +242,7 @@
  *  - add FUSE_NOTIFY_PRUNE
  *
  *  7.46
- *  - add FUSE_URING_BUF_RING flag
+ *  - add FUSE_URING_BUF_RING and FUSE_URING_ZERO_COPY flag
  *  - add fuse_uring_cmd_req init struct
  */
 
@@ -1300,6 +1300,7 @@ enum fuse_uring_cmd {
 
 /* fuse_uring_cmd_req flags */
 #define FUSE_URING_BUF_RING	(1 << 0)
+#define FUSE_URING_ZERO_COPY	(1 << 1)
 
 /**
  * In the 80B command area of the SQE.
-- 
2.52.0

