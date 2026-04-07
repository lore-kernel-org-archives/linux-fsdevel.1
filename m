Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784371A6827
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523046; cv=none; b=Y5VrCX1vj+N8PjznlC+vqL7Eyrew6Weg8XE3qSl/XyVb2otlYKWYOOeUta7WnDf0dxmREx/YLwPENx3UVMLdM6G6khihSMrOtpxdiFZPDBrR1Tg0UGQtIfODTIsDgfjUgWZ/dgKv+Ic2Cbbjjp86e2H6Iwku64ZFYSv3ASQtDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523046; c=relaxed/simple;
	bh=TC6ed81rxr+W3Wdj5geKklBu2oV4/PnRv130qp4MZNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uubCCaD95oj94EzpvIQXQFZXSpPtwTHvm9Fxss1O8vhmf2N/N2gK4aRRy9mfFN+JqH8WtfZXzpwPkNcDOhmcOTI/afrYpqz3NIjjHvoqGM1vwrxvl1Qh43yp82WHUHO5IXmqNpK36E9gBtrywepp0N+tNvM0n7GzOLYvOfhHegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rmTSh2x0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rmTSh2x0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6vpMZcC4V9gMMs0Z8Kd+L/b5U2bgEnIUjS2nqo7YQJM=; b=rmTSh2x0+p5xL7r0SQu3Jn+kna
	jij45IXsXUgS3W6p17/19gUraz4qxUpWuK98tqDB+1tH/wymdr9c1mNOK9hRQ0C/b1Hejcin6eOui
	CKj8AYKS6lQAjw+WaiQiikTE+JA6vpeH84xR8b5bWgrxNduGxenteWLno7PThshIEapGlRMMwJdGu
	auX1F11DPsLZicJqBZcMInYW0D4hY7K+Y3Y3OrwUjtOz7FgvPfx4wO+dgAyPRw95LaD/UYm6gnMtU
	8wJ6RUr3B6YpbqSJXtpIBF4OfdRG3ma6jXZuIx3PbOysekxf8sJ7LgyNyC27OXs2C6HYcsEVEc14N
	UfX0kkoQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9ueP-00000005ff8-27J5;
	Tue, 07 Apr 2026 00:50:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 2/3 v2] fuse: fuse_dev_i.h: clean up kernel-doc warnings
Date: Mon,  6 Apr 2026 17:50:39 -0700
Message-ID: <20260407005040.1929492-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407005040.1929492-1-rdunlap@infradead.org>
References: <20260407005040.1929492-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change some "/**" to "/*" since they are not kernel-doc comments:

Warning: fs/fuse/fuse_dev_i.h:25 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * Request flags
Warning: fs/fuse/fuse_dev_i.h:58 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * A request to the client
Warning: fs/fuse/fuse_dev_i.h:117 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * Input queue callbacks
Warning: fs/fuse/fuse_dev_i.h:289 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * Fuse device instance
and more like this.

Convert enum fuse_req_flag to kernel-doc format.
Convert struct fuse_req, struct fuse_iqueue_ops, and struct fuse_dev
to kernel-doc format.

These warnings remain:
Warning: fs/fuse/fuse_dev_i.h:115 struct member 'ring_entry' not described in 'fuse_req'
Warning: fs/fuse/fuse_dev_i.h:115 struct member 'ring_queue' not described in 'fuse_req'

Binary build output is the same before and after these changes.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: new patch for this series

Cc: Miklos Szeredi <miklos@szeredi.hu>

 fs/fuse/fuse_dev_i.h |   93 ++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 43 deletions(-)

--- linux-next-20260406.orig/fs/fuse/fuse_dev_i.h
+++ linux-next-20260406/fs/fuse/fuse_dev_i.h
@@ -23,21 +23,21 @@ struct fuse_pqueue;
 struct fuse_iqueue;
 
 /**
- * Request flags
+ * enum fuse_req_flag - Request flags
  *
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
+ * @FR_ISREPLY:		set if the request has reply
+ * @FR_FORCE:		force sending of the request even if interrupted
+ * @FR_BACKGROUND:	request is sent in the background
+ * @FR_WAITING:		request is counted as "waiting"
+ * @FR_ABORTED:		the request was aborted
+ * @FR_INTERRUPTED:	the request has been interrupted
+ * @FR_LOCKED:		data is being copied to/from the request
+ * @FR_PENDING:		request is not yet in userspace
+ * @FR_SENT:		request is in userspace, waiting for an answer
+ * @FR_FINISHED:	request is finished
+ * @FR_PRIVATE:		request is on private list
+ * @FR_ASYNC:		request is asynchronous
+ * @FR_URING:		request is handled through fuse-io-uring
  */
 enum fuse_req_flag {
 	FR_ISREPLY,
@@ -56,55 +56,62 @@ enum fuse_req_flag {
 };
 
 /**
- * A request to the client
+ * struct fuse_req - A request to the client
  *
  * .waitq.lock protects the following fields:
  *   - FR_ABORTED
  *   - FR_LOCKED (may also be modified under fpq->lock, tested under both)
  */
 struct fuse_req {
-	/** This can be on either pending processing or io lists in
-	    fuse_conn */
+	/**
+	 * @list: This can be on either pending processing or io lists in
+	 * fuse_conn
+	 */
 	struct list_head list;
 
-	/** Entry on the interrupts list  */
+	/** @intr_entry: Entry on the interrupts list  */
 	struct list_head intr_entry;
 
-	/* Input/output arguments */
+	/** @args: Input/output arguments */
 	struct fuse_args *args;
 
-	/** refcount */
+	/** @count: refcount */
 	refcount_t count;
 
-	/* Request flags, updated with test/set/clear_bit() */
+	/** @flags: Request flags, updated with test/set/clear_bit() */
 	unsigned long flags;
 
-	/* The request input header */
+	/** @in: The request input header */
 	struct {
+		/** @in.h: The request input header */
 		struct fuse_in_header h;
 	} in;
 
-	/* The request output header */
+	/** @out: The request output header */
 	struct {
+		/** @out.h: The request output header */
 		struct fuse_out_header h;
 	} out;
 
-	/** Used to wake up the task waiting for completion of request*/
+	/** @waitq: Used to wake up the task waiting for completion of request */
 	wait_queue_head_t waitq;
 
 #if IS_ENABLED(CONFIG_VIRTIO_FS)
-	/** virtio-fs's physically contiguous buffer for in and out args */
+	/**
+	 * @argbuf: virtio-fs's physically contiguous buffer for in and out
+	 * args
+	 */
 	void *argbuf;
 #endif
 
-	/** fuse_chan this request belongs to */
+	/** @chan: fuse_chan this request belongs to */
 	struct fuse_chan *chan;
 
 #ifdef CONFIG_FUSE_IO_URING
 	void *ring_entry;
 	void *ring_queue;
 #endif
-	/** When (in jiffies) the request was created */
+	/** @create_time: When (in jiffies) the request was created */
 	unsigned long create_time;
 };
 
@@ -115,7 +122,7 @@ struct fuse_forget_link {
 };
 
 /**
- * Input queue callbacks
+ * struct fuse_iqueue_ops - Input queue callbacks
  *
  * Input queue signalling is device-specific.  For example, the /dev/fuse file
  * uses fiq->waitq and fasync to wake processes that are waiting on queue
@@ -124,22 +131,22 @@ struct fuse_forget_link {
  */
 struct fuse_iqueue_ops {
 	/**
-	 * Send one forget
+	 * @send_forget: Send one forget
 	 */
 	void (*send_forget)(struct fuse_iqueue *fiq, struct fuse_forget_link *link);
 
 	/**
-	 * Send interrupt for request
+	 * @send_interrupt: Send interrupt for request
 	 */
 	void (*send_interrupt)(struct fuse_iqueue *fiq, struct fuse_req *req);
 
 	/**
-	 * Send one request
+	 * @send_req: Send one request
 	 */
 	void (*send_req)(struct fuse_iqueue *fiq, struct fuse_req *req);
 
 	/**
-	 * Clean up when fuse_iqueue is destroyed
+	 * @release: Clean up when fuse_iqueue is destroyed
 	 */
 	void (*release)(struct fuse_iqueue *fiq);
 };
@@ -287,22 +294,22 @@ struct fuse_pqueue {
 };
 
 /**
- * Fuse device instance
+ * struct fuse_dev - Fuse device instance
  */
 struct fuse_dev {
-	/** Reference count of this object */
+	/** @ref: Reference count of this object */
 	refcount_t ref;
 
-	/** Issue FUSE_INIT synchronously */
+	/** @sync_init: Issue FUSE_INIT synchronously */
 	bool sync_init;
 
-	/** Fuse channel for this device */
+	/** @chan: Fuse channel for this device */
 	struct fuse_chan *chan;
 
-	/** Processing queue */
+	/** @pq: Processing queue */
 	struct fuse_pqueue pq;
 
-	/** list entry on fch->devices */
+	/** @entry: list entry on fch->devices */
 	struct list_head entry;
 };
 
@@ -367,7 +374,7 @@ void fuse_dev_end_requests(struct list_h
 
 void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 			   struct iov_iter *iter);
-/**
+/*
  * Return the number of bytes in an arguments list
  */
 unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
@@ -384,12 +391,12 @@ bool fuse_remove_pending_req(struct fuse
 
 bool fuse_request_expired(struct fuse_chan *fch, struct list_head *list);
 
-/**
+/*
  * Assign a unique id to a fuse request
  */
 void fuse_request_assign_unique(struct fuse_iqueue *fiq, struct fuse_req *req);
 
-/**
+/*
  * Get the next unique ID for a request
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
@@ -399,12 +406,12 @@ struct fuse_dev *fuse_dev_alloc(void);
 
 int fuse_dev_release(struct inode *inode, struct file *file);
 
-/**
+/*
  * Initialize the fuse processing queue
  */
 void fuse_pqueue_init(struct fuse_pqueue *fpq);
 
-/**
+/*
  * End a finished request
  */
 void fuse_request_end(struct fuse_req *req);
