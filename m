Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F939A7F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331048; cv=none; b=u774SwXOCJ2w73mW5ykCxH6HraC3D2JjoJjhzfqQscsth3q0sHXkQfs/JC+NQOb7f7HdzB4TQ5rxIXT80+9cfD9nxcpkphE/M8HS+PLvzgB477vI7V3rY4F+LIAsgjrfP72zhZspWMocvITC9LZ6T1aMUrljx/18PyZKPsbDwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331048; c=relaxed/simple;
	bh=B6tfrUXgHMIplKvxjVlZ0rJuFia4j5csfd5kXqSFBAA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ugg2+rv1Vc1bJONpH+YlLW5hfRX3YEqi3PEHbiGtp9u79n9G408X4XISf936zKj4KF90F/AL8c03s9m90Xe4fpfakszZ1Ol7tINVEPBAjRd3uqXq2GovTfpSopfMwOdM6myvOd/9l99/oaIeYk/n6F4a48u53EhaYX80EUHYZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmYtBZWr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y09DxUPs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmYtBZWr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y09DxUPs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaFpey7Gno59NYREHz6EyyD8pDWjNfZ7ACS9nMM9NnU=;
	b=RmYtBZWrlZWYyW8NcK91t09j1Na4n0aXWVHuxxCggBYukXgHAc0taSMJLnCIugRLz3a0bn
	ekr7zG7E2hogKcgYMQbZu2CDdjRJbk60pnxChLRNJtbJCiniHBKirmEnvh3UdDozQM0Ec9
	vqRx1ZMxTX1de/6rK88u7QjSArz8CdE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-KFBNL9ypN9mhk1SYspIu_Q-1; Thu, 16 Apr 2026 05:17:22 -0400
X-MC-Unique: KFBNL9ypN9mhk1SYspIu_Q-1
X-Mimecast-MFC-AGG-ID: KFBNL9ypN9mhk1SYspIu_Q_1776331041
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488ba2f4094so49471945e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331040; x=1776935840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaFpey7Gno59NYREHz6EyyD8pDWjNfZ7ACS9nMM9NnU=;
        b=Y09DxUPs80f8RB8CFUvYY2J3PCQNaJwonXjIK6eLY1YBz785+IV8CvWRoKvSL9OUKz
         n0DqXxcdc1+hSvzR4jM5zGKTs/1AHzDWlGazVn+2RhJVU0cAuFn9L0X/1TScYeUcP3vY
         exgd1ikdhQGgRF980yOAiN/yniQnHYslv83uDbgqAoxGXYogL8UzV/PxyMDenAN1ItSe
         3fO3cr/hzA2MY+EXBk8oVKRZqL1fyPQgpxQPREYxePQ4gxw5d+ys3d3TZGoduMkKgwDl
         J1tXMEv61GtKjy/MP1VzB5belg0Pn7UR965/RuUDptdQ1+oRJVYRnhXuTicOQYPUmXGU
         KR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331040; x=1776935840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qaFpey7Gno59NYREHz6EyyD8pDWjNfZ7ACS9nMM9NnU=;
        b=hCX1L97BoFs1iQB+1FrRB+ezbkqRK/rBZ/vopOpc4j2V9KyEXUwNPWHS4ACRZY8i/k
         aiHsFVRMU252JsOBM5/lpasLWV6yYgcj5cDrAp3QA64wM9i4cGTB9FBShyKuCLUPHbFL
         zIUG0iQ9DEfAU35ck8hkMCB9EF4oiecXQjLV6ULjI08v8m9JJVFOPr6FK0RGi3HGLWJ9
         EgDzyk9eXv7gL3LMmLZFb5V3CodLc60OOd4eap4Hsb9uq7E+rR/G/OqPmcklmpsDFBcm
         w48pgaYqnMbYR+Imm/Z01TAGF1PXys7Od70d2sjVxkDUzKeeS1RO3WScrY9eA4Y90yqZ
         WaEg==
X-Forwarded-Encrypted: i=1; AFNElJ8nxugPZ+qDxzi0dVZ9LvvPwkZIkYSObraekeojTeaZcL18HTHru3iODGJXZ8xJb/DHH9v58n8jIWcPAy4A@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaCL7AjeYI1Sc2ecA3JjOF8f0CSlrTmfBX8t9A8PEB7OCLLRP
	+zNQAaZOWYwMLcdmIeEnmrXBc0fNVqzthKC0G/ZMY23ynBYDg9YsmnRahVEPsIxz2WRvzzlGbxe
	et1Y5KR0LHPbliEDEzTGQy/1A+VvHHbvD/GAcsOWxx7eX9plkSTWnlKPN5iLYCDgk9wXHYT+Y/f
	A=
X-Gm-Gg: AeBDiesS42dlVyMfNDC1yROWVneh9twDPsR3BwaWD3u4syLvZlWSuuF13n4jbSFPt+6
	28Eq5VHcOPLu79crYN7Zog5v7oO9B5n7cd739KbJ+Y8/nopL+z4tsuX3gpG68v/GZqD0v3l74iM
	82nsJA7PtTSfYb5ZVOYoSjtaHsWPvgoiIx4wpdlQb7MuGwnzEblxZ0XYeORHZQoahPESGtXq7/H
	DK3I6nhIqzV8KxVz62q9lGJbEVa40K+K/73yTpUhekFwFV4mOKaK3NG8dn7Dvsngae7nSQlYZyV
	12pzD5voRca+11G2mvreEr9/GiwmM2qVVnUbwytCPy2uJohaZfPGMCMlflm0rZmLmTaUWH9hXUH
	yGVRM8YN3BuMzAw0NZiCfcwnpJtgbcQXrvVLDkyP+MRO43cI64X/MFkjTf1nE/brPB1FLodo4gC
	Flrzg30Q==
X-Received: by 2002:a05:600c:4e48:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488d685655dmr353660595e9.21.1776331040295;
        Thu, 16 Apr 2026 02:17:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4e48:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488d685655dmr353660035e9.21.1776331039721;
        Thu, 16 Apr 2026 02:17:19 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:19 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/32] fuse: move struct fuse_req and related to fuse_dev_i.h
Date: Thu, 16 Apr 2026 11:16:37 +0200
Message-ID: <20260416091658.462783-14-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416091658.462783-1-mszeredi@redhat.com>
References: <20260416091658.462783-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_dev_i.h | 91 +++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h     | 91 --------------------------------------------
 2 files changed, 90 insertions(+), 92 deletions(-)

diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 2e0193acc9c2..f20a28448e55 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -17,10 +17,95 @@ extern struct wait_queue_head fuse_dev_waitq;
 struct fuse_arg;
 struct fuse_args;
 struct fuse_pqueue;
-struct fuse_req;
 struct fuse_iqueue;
 struct fuse_forget_link;
 
+/**
+ * Request flags
+ *
+ * FR_ISREPLY:		set if the request has reply
+ * FR_FORCE:		force sending of the request even if interrupted
+ * FR_BACKGROUND:	request is sent in the background
+ * FR_WAITING:		request is counted as "waiting"
+ * FR_ABORTED:		the request was aborted
+ * FR_INTERRUPTED:	the request has been interrupted
+ * FR_LOCKED:		data is being copied to/from the request
+ * FR_PENDING:		request is not yet in userspace
+ * FR_SENT:		request is in userspace, waiting for an answer
+ * FR_FINISHED:		request is finished
+ * FR_PRIVATE:		request is on private list
+ * FR_ASYNC:		request is asynchronous
+ * FR_URING:		request is handled through fuse-io-uring
+ */
+enum fuse_req_flag {
+	FR_ISREPLY,
+	FR_FORCE,
+	FR_BACKGROUND,
+	FR_WAITING,
+	FR_ABORTED,
+	FR_INTERRUPTED,
+	FR_LOCKED,
+	FR_PENDING,
+	FR_SENT,
+	FR_FINISHED,
+	FR_PRIVATE,
+	FR_ASYNC,
+	FR_URING,
+};
+
+/**
+ * A request to the client
+ *
+ * .waitq.lock protects the following fields:
+ *   - FR_ABORTED
+ *   - FR_LOCKED (may also be modified under fpq->lock, tested under both)
+ */
+struct fuse_req {
+	/** This can be on either pending processing or io lists in
+	    fuse_conn */
+	struct list_head list;
+
+	/** Entry on the interrupts list  */
+	struct list_head intr_entry;
+
+	/* Input/output arguments */
+	struct fuse_args *args;
+
+	/** refcount */
+	refcount_t count;
+
+	/* Request flags, updated with test/set/clear_bit() */
+	unsigned long flags;
+
+	/* The request input header */
+	struct {
+		struct fuse_in_header h;
+	} in;
+
+	/* The request output header */
+	struct {
+		struct fuse_out_header h;
+	} out;
+
+	/** Used to wake up the task waiting for completion of request*/
+	wait_queue_head_t waitq;
+
+#if IS_ENABLED(CONFIG_VIRTIO_FS)
+	/** virtio-fs's physically contiguous buffer for in and out args */
+	void *argbuf;
+#endif
+
+	/** fuse_mount this request belongs to */
+	struct fuse_mount *fm;
+
+#ifdef CONFIG_FUSE_IO_URING
+	void *ring_entry;
+	void *ring_queue;
+#endif
+	/** When (in jiffies) the request was created */
+	unsigned long create_time;
+};
+
 /**
  * Input queue callbacks
  *
@@ -290,6 +375,10 @@ struct fuse_dev *fuse_dev_alloc(void);
  */
 void fuse_pqueue_init(struct fuse_pqueue *fpq);
 
+/**
+ * End a finished request
+ */
+void fuse_request_end(struct fuse_req *req);
 
 #endif
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7bc6c2054d1a..e6c1c161214c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -383,92 +383,6 @@ struct fuse_io_priv {
 	.iocb = i,			\
 }
 
-/**
- * Request flags
- *
- * FR_ISREPLY:		set if the request has reply
- * FR_FORCE:		force sending of the request even if interrupted
- * FR_BACKGROUND:	request is sent in the background
- * FR_WAITING:		request is counted as "waiting"
- * FR_ABORTED:		the request was aborted
- * FR_INTERRUPTED:	the request has been interrupted
- * FR_LOCKED:		data is being copied to/from the request
- * FR_PENDING:		request is not yet in userspace
- * FR_SENT:		request is in userspace, waiting for an answer
- * FR_FINISHED:		request is finished
- * FR_PRIVATE:		request is on private list
- * FR_ASYNC:		request is asynchronous
- * FR_URING:		request is handled through fuse-io-uring
- */
-enum fuse_req_flag {
-	FR_ISREPLY,
-	FR_FORCE,
-	FR_BACKGROUND,
-	FR_WAITING,
-	FR_ABORTED,
-	FR_INTERRUPTED,
-	FR_LOCKED,
-	FR_PENDING,
-	FR_SENT,
-	FR_FINISHED,
-	FR_PRIVATE,
-	FR_ASYNC,
-	FR_URING,
-};
-
-/**
- * A request to the client
- *
- * .waitq.lock protects the following fields:
- *   - FR_ABORTED
- *   - FR_LOCKED (may also be modified under fpq->lock, tested under both)
- */
-struct fuse_req {
-	/** This can be on either pending processing or io lists in
-	    fuse_conn */
-	struct list_head list;
-
-	/** Entry on the interrupts list  */
-	struct list_head intr_entry;
-
-	/* Input/output arguments */
-	struct fuse_args *args;
-
-	/** refcount */
-	refcount_t count;
-
-	/* Request flags, updated with test/set/clear_bit() */
-	unsigned long flags;
-
-	/* The request input header */
-	struct {
-		struct fuse_in_header h;
-	} in;
-
-	/* The request output header */
-	struct {
-		struct fuse_out_header h;
-	} out;
-
-	/** Used to wake up the task waiting for completion of request*/
-	wait_queue_head_t waitq;
-
-#if IS_ENABLED(CONFIG_VIRTIO_FS)
-	/** virtio-fs's physically contiguous buffer for in and out args */
-	void *argbuf;
-#endif
-
-	/** fuse_mount this request belongs to */
-	struct fuse_mount *fm;
-
-#ifdef CONFIG_FUSE_IO_URING
-	void *ring_entry;
-	void *ring_queue;
-#endif
-	/** When (in jiffies) the request was created */
-	unsigned long create_time;
-};
-
 enum fuse_dax_mode {
 	FUSE_DAX_INODE_DEFAULT,	/* default */
 	FUSE_DAX_ALWAYS,	/* "-o dax=always" */
@@ -1094,11 +1008,6 @@ static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
 
-/**
- * End a finished request
- */
-void fuse_request_end(struct fuse_req *req);
-
 /* Abort all requests */
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
-- 
2.53.0

