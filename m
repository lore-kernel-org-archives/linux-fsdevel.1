Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC2339A07D
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331068; cv=none; b=tJ/ZDcpu8Bb3hDC+ociuq+1IJcLqkX6scLnFiCscej6lhpJ3j/T45UN0jM5yPf4sArKc+mprR1rTmu3wz408MJhsfHNTGLBV5D6pxLgdwdVGjko9RwIo1a6EvcUj++soFr7LZnsF8jeV2X8W2VL6DgCbdPcOP684tbeUUkwIzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331068; c=relaxed/simple;
	bh=QEYv1JyCIHd66D8a10UakWcyKxxHsU3W7wi/WtXwWuM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+vZDWU1oeLBkW1kxkiVc0vkfCCm289o4eLiQJw2UxZ8C5E0PzFYGO77xC+iQx9XhyCQRTeKHA7FhSSQqVgfcGcpMrVg3H1llI6Gf3vm3fUWdrlc/eSUWZEZvgF5jBXRQgQBFejkC9C998alEspy7RMBH7gQ6duJGuGM5cAc6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7pQRNJe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0O3d2XZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7pQRNJe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0O3d2XZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYs2aH9cnC/FcYAafN5ozvPOzmP2OG0VJ1IJjySXv9g=;
	b=X7pQRNJesqP7JDQIaact0CKiqrCPH5T4zz64liuZOnfhX5W/y1KumxqqiMcN4PIpbG+IwL
	1nvEKDgpIo1Je4EEt9Fp/5IaMwzYjht/bgIcv6YU2idVzbl4NHo39akVFuMcP01Kh+pmFV
	xqHYH01tgu5A76NIIETAcXyRgV3wABk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-1dGYzXCSNc-28R0-S44fMw-1; Thu, 16 Apr 2026 05:17:38 -0400
X-MC-Unique: 1dGYzXCSNc-28R0-S44fMw-1
X-Mimecast-MFC-AGG-ID: 1dGYzXCSNc-28R0-S44fMw_1776331057
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488cc31ea57so50135105e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331057; x=1776935857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYs2aH9cnC/FcYAafN5ozvPOzmP2OG0VJ1IJjySXv9g=;
        b=Q0O3d2XZZ4OV7ngEIqbuehSyuR3zHRNAmmZX2Po53aANfK0cZDqEEtnl6eU2RrLkbc
         KAlMd3MMmje4PJzLX/al2YdGz3vxqQ5EZ3ijRgFQu2d8Y8MZb4aTi5U7D/PpFbqZ6Atw
         cA+qjY2kdlsG9dNHzROx8+ovVz6gMeIzeMP9STr5KmWvFTdrG6PMzwC9l+IwJYOkw5IJ
         kPl6tJHcpOaULxY6Pvd0VOAfqT52dDzR4hnf+kbS9bY5PVEamNbKDMWKPnyppr8y+BY0
         tMswpxbqKQKlZhz/3vBIUTc+m49S8KMa/SeN+wbt9hMofpMUGbe0YtGc79WHh5VbBryf
         YvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331057; x=1776935857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UYs2aH9cnC/FcYAafN5ozvPOzmP2OG0VJ1IJjySXv9g=;
        b=M+uViw86L7nas3W1yQ3UOxhsiXVNZ5YIZKWXdXOuM6fA4kZ0LAqQtlGYW5qDgX63jG
         VCRVU05lmUPx8VVTgEne6/HZvf8Ewfp39N55hp3Xw3Fe0cPoGaD2iQJPxvgY5l3KJeEa
         +iCWXFR3VTiUsT7/z8bM7lcRd0wOWlTv3zNo9SpxX/bUHS8RpKtMLZLqSlNilL6FBJqv
         R97qj7XjPal5MC0o3wOMve7Zs+r3hX3WQ3W2cqply+q3xbYH5E/eIepFEF/ArmMlDukw
         gc8gISZ4wbha/zr6OY/38vDeId38RfauatwRZ9cGc5Rlr8dOGLL0QUo+Xcm7BpFZI1Sm
         oEfg==
X-Forwarded-Encrypted: i=1; AFNElJ+nuVEvcLPV2JczQYoIVrum6G/s04bGVrWJx5ROyEWnDP0jUjc68fMWwBD7psY32dWgScQ3v5rfeg7UepMj@vger.kernel.org
X-Gm-Message-State: AOJu0YyRStJu9MUhSRICN6/tuAP5kV3JCKNeAX3wJ4OAARztpwcwSuUO
	Ucvvj9Q9z3WwgBQ8GSD3T0oIae33qctayY750Z6LicRO4tbrwyC2qNHfXfFHqzLJ06DZnoqnD/d
	pcf9BitvKYtPSm+eF2kbrXxUS2P1Kiwb8dkfEPYGMjwihmVVBiGdK/1vrCVLf+Dl5qOXCI0VAsK
	Q=
X-Gm-Gg: AeBDieuByMVheVHJx5xFdVrXsxh68qZ8pAJg4Q5VbBba0ITH/rn1shKmvsB8PEDQ1uE
	dn9JP+QF8k2477Jv2DCI98uQnTpBIrDUDS0q3hMKkQZSFNpwX5doGrN+4L9PuAPaEQUIl34pxUM
	xpczczm56Gp5w8lesPZkp9aAA1S0l0GzpPPJxDeunN4bSzaE7kEM55ZiS5QPnIk8UvKpAOVlRrp
	+9yErNSWAHxJ4fDO955zKYDxx5cboodKzhnDQK6ZN6eJEEz0nYfrRp1+Dem9cP3soMlG4Mptm4K
	iRjgjQO1FlAlg6h12sa8Yzq2p1cLEi2p5BIOL/mCPRNWhtL/29iDkDyL5BZFL1wjy0R0c18aSuP
	SujqmYsnTH+MLfIKKgyYvNUeh37kbH12st7osHRkK+YMvwMO4x4/WJRIbBjutCDp5j+0+cq1RDS
	HL4IVMzw==
X-Received: by 2002:a05:600c:3546:b0:488:a82f:bbb6 with SMTP id 5b1f17b1804b1-488d6890a46mr348061315e9.27.1776331056869;
        Thu, 16 Apr 2026 02:17:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3546:b0:488:a82f:bbb6 with SMTP id 5b1f17b1804b1-488d6890a46mr348060825e9.27.1776331056288;
        Thu, 16 Apr 2026 02:17:36 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:35 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 25/32] fuse: create poll.c
Date: Thu, 16 Apr 2026 11:16:49 +0200
Message-ID: <20260416091658.462783-26-mszeredi@redhat.com>
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

Move f_op->poll related functions to the new source file.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/Makefile |   1 +
 fs/fuse/dev.c    |  45 +++++----------
 fs/fuse/dev.h    |   2 +
 fs/fuse/file.c   | 119 ---------------------------------------
 fs/fuse/poll.c   | 141 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 158 insertions(+), 150 deletions(-)
 create mode 100644 fs/fuse/poll.c

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 08be6817a1cc..26086bf5b494 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := trace.o	# put trace.o first so we see ftrace errors sooner
 fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o req_timeout.o req.o
+fuse-y += poll.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index f3d16a224df7..a76822bd81c2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -79,10 +79,10 @@ void fuse_chan_set_initialized(struct fuse_chan *fch)
 	wake_up_all(&fch->blocked_waitq);
 }
 
-static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
+static bool fuse_block_alloc(struct fuse_chan *fch, bool for_background)
 {
-	return !fc->chan->initialized || (for_background && fc->chan->blocked) ||
-	       (fc->chan->io_uring && fc->chan->connected && !fuse_uring_ready(fc->chan));
+	return !fch->initialized || (for_background && fch->blocked) ||
+	       (fch->io_uring && fch->connected && !fuse_uring_ready(fch));
 }
 
 static void fuse_drop_waiting(struct fuse_chan *fch)
@@ -108,10 +108,10 @@ static struct fuse_req *fuse_get_req(struct fuse_chan *fch, bool for_background)
 
 	atomic_inc(&fch->num_waiting);
 
-	if (fuse_block_alloc(fch->conn, for_background)) {
+	if (fuse_block_alloc(fch, for_background)) {
 		err = -EINTR;
 		if (wait_event_state_exclusive(fch->blocked_waitq,
-				!fuse_block_alloc(fch->conn, for_background),
+				!fuse_block_alloc(fch, for_background),
 				(TASK_KILLABLE | TASK_FREEZABLE)))
 			goto out;
 	}
@@ -2065,21 +2065,21 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
  * if the FUSE daemon takes careful measures to avoid processing duplicated
  * non-idempotent requests.
  */
-static void fuse_resend(struct fuse_conn *fc)
+static void fuse_resend(struct fuse_chan *fch)
 {
 	struct fuse_dev *fud;
 	struct fuse_req *req, *next;
-	struct fuse_iqueue *fiq = &fc->chan->iq;
+	struct fuse_iqueue *fiq = &fch->iq;
 	LIST_HEAD(to_queue);
 	unsigned int i;
 
-	spin_lock(&fc->chan->lock);
-	if (!fc->chan->connected) {
-		spin_unlock(&fc->chan->lock);
+	spin_lock(&fch->lock);
+	if (!fch->connected) {
+		spin_unlock(&fch->lock);
 		return;
 	}
 
-	list_for_each_entry(fud, &fc->chan->devices, entry) {
+	list_for_each_entry(fud, &fch->devices, entry) {
 		struct fuse_pqueue *fpq = &fud->pq;
 
 		spin_lock(&fpq->lock);
@@ -2087,7 +2087,7 @@ static void fuse_resend(struct fuse_conn *fc)
 			list_splice_tail_init(&fpq->processing[i], &to_queue);
 		spin_unlock(&fpq->lock);
 	}
-	spin_unlock(&fc->chan->lock);
+	spin_unlock(&fch->lock);
 
 	list_for_each_entry_safe(req, next, &to_queue, list) {
 		set_bit(FR_PENDING, &req->flags);
@@ -2111,7 +2111,7 @@ static void fuse_resend(struct fuse_conn *fc)
 
 static int fuse_notify_resend(struct fuse_conn *fc)
 {
-	fuse_resend(fc);
+	fuse_resend(fc->chan);
 	return 0;
 }
 
@@ -2499,23 +2499,6 @@ void fuse_dev_end_requests(struct list_head *head)
 	}
 }
 
-static void end_polls(struct fuse_conn *fc)
-{
-	struct rb_node *p;
-
-	spin_lock(&fc->lock);
-	p = rb_first(&fc->polled_files);
-
-	while (p) {
-		struct fuse_file *ff;
-		ff = rb_entry(p, struct fuse_file, polled_node);
-		wake_up_interruptible_all(&ff->poll_wait);
-
-		p = rb_next(p);
-	}
-	spin_unlock(&fc->lock);
-}
-
 /*
  * Abort all requests.
  *
@@ -2593,7 +2576,7 @@ void fuse_chan_abort(struct fuse_chan *fch, bool abort_with_err)
 		wake_up_all(&fiq->waitq);
 		spin_unlock(&fiq->lock);
 		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
-		end_polls(fch->conn);
+		fuse_end_polls(fch->conn);
 		wake_up_all(&fch->blocked_waitq);
 		spin_unlock(&fch->lock);
 
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index 9a1f79b130bd..2c4d0c53ffbb 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -49,6 +49,8 @@ void fuse_init_server_timeout(struct fuse_chan *fch, unsigned int timeout);
 void fuse_chan_abort(struct fuse_chan *fch, bool abort_with_err);
 void fuse_chan_wait_aborted(struct fuse_chan *fch);
 
+void fuse_end_polls(struct fuse_conn *fc);
+
 #ifdef CONFIG_FUSE_IO_URING
 bool fuse_uring_enabled(void);
 void fuse_uring_destruct(struct fuse_chan *fch);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d549f47170d6..b8fd148dc109 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2676,125 +2676,6 @@ static loff_t fuse_file_llseek(struct file *file, loff_t offset, int whence)
 	return retval;
 }
 
-/*
- * All files which have been polled are linked to RB tree
- * fuse_conn->polled_files which is indexed by kh.  Walk the tree and
- * find the matching one.
- */
-static struct rb_node **fuse_find_polled_node(struct fuse_conn *fc, u64 kh,
-					      struct rb_node **parent_out)
-{
-	struct rb_node **link = &fc->polled_files.rb_node;
-	struct rb_node *last = NULL;
-
-	while (*link) {
-		struct fuse_file *ff;
-
-		last = *link;
-		ff = rb_entry(last, struct fuse_file, polled_node);
-
-		if (kh < ff->kh)
-			link = &last->rb_left;
-		else if (kh > ff->kh)
-			link = &last->rb_right;
-		else
-			return link;
-	}
-
-	if (parent_out)
-		*parent_out = last;
-	return link;
-}
-
-/*
- * The file is about to be polled.  Make sure it's on the polled_files
- * RB tree.  Note that files once added to the polled_files tree are
- * not removed before the file is released.  This is because a file
- * polled once is likely to be polled again.
- */
-static void fuse_register_polled_file(struct fuse_conn *fc,
-				      struct fuse_file *ff)
-{
-	spin_lock(&fc->lock);
-	if (RB_EMPTY_NODE(&ff->polled_node)) {
-		struct rb_node **link, *parent;
-
-		link = fuse_find_polled_node(fc, ff->kh, &parent);
-		BUG_ON(*link);
-		rb_link_node(&ff->polled_node, parent, link);
-		rb_insert_color(&ff->polled_node, &fc->polled_files);
-	}
-	spin_unlock(&fc->lock);
-}
-
-__poll_t fuse_file_poll(struct file *file, poll_table *wait)
-{
-	struct fuse_file *ff = file->private_data;
-	struct fuse_mount *fm = ff->fm;
-	struct fuse_poll_in inarg = { .fh = ff->fh, .kh = ff->kh };
-	struct fuse_poll_out outarg;
-	FUSE_ARGS(args);
-	int err;
-
-	if (fm->fc->no_poll)
-		return DEFAULT_POLLMASK;
-
-	poll_wait(file, &ff->poll_wait, wait);
-	inarg.events = mangle_poll(poll_requested_events(wait));
-
-	/*
-	 * Ask for notification iff there's someone waiting for it.
-	 * The client may ignore the flag and always notify.
-	 */
-	if (waitqueue_active(&ff->poll_wait)) {
-		inarg.flags |= FUSE_POLL_SCHEDULE_NOTIFY;
-		fuse_register_polled_file(fm->fc, ff);
-	}
-
-	args.opcode = FUSE_POLL;
-	args.nodeid = ff->nodeid;
-	args.in_numargs = 1;
-	args.in_args[0].size = sizeof(inarg);
-	args.in_args[0].value = &inarg;
-	args.out_numargs = 1;
-	args.out_args[0].size = sizeof(outarg);
-	args.out_args[0].value = &outarg;
-	err = fuse_simple_request(fm, &args);
-
-	if (!err)
-		return demangle_poll(outarg.revents);
-	if (err == -ENOSYS) {
-		fm->fc->no_poll = 1;
-		return DEFAULT_POLLMASK;
-	}
-	return EPOLLERR;
-}
-EXPORT_SYMBOL_GPL(fuse_file_poll);
-
-/*
- * This is called from fuse_handle_notify() on FUSE_NOTIFY_POLL and
- * wakes up the poll waiters.
- */
-int fuse_notify_poll_wakeup(struct fuse_conn *fc,
-			    struct fuse_notify_poll_wakeup_out *outarg)
-{
-	u64 kh = outarg->kh;
-	struct rb_node **link;
-
-	spin_lock(&fc->lock);
-
-	link = fuse_find_polled_node(fc, kh, NULL);
-	if (*link) {
-		struct fuse_file *ff;
-
-		ff = rb_entry(*link, struct fuse_file, polled_node);
-		wake_up_interruptible_sync(&ff->poll_wait);
-	}
-
-	spin_unlock(&fc->lock);
-	return 0;
-}
-
 static void fuse_do_truncate(struct file *file)
 {
 	struct inode *inode = file->f_mapping->host;
diff --git a/fs/fuse/poll.c b/fs/fuse/poll.c
new file mode 100644
index 000000000000..bce3ee2e861e
--- /dev/null
+++ b/fs/fuse/poll.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "dev.h"
+#include "fuse_i.h"
+
+void fuse_end_polls(struct fuse_conn *fc)
+{
+	struct rb_node *p;
+
+	spin_lock(&fc->lock);
+	p = rb_first(&fc->polled_files);
+
+	while (p) {
+		struct fuse_file *ff;
+		ff = rb_entry(p, struct fuse_file, polled_node);
+		wake_up_interruptible_all(&ff->poll_wait);
+
+		p = rb_next(p);
+	}
+	spin_unlock(&fc->lock);
+}
+
+/*
+ * All files which have been polled are linked to RB tree
+ * fuse_conn->polled_files which is indexed by kh.  Walk the tree and
+ * find the matching one.
+ */
+static struct rb_node **fuse_find_polled_node(struct fuse_conn *fc, u64 kh,
+					      struct rb_node **parent_out)
+{
+	struct rb_node **link = &fc->polled_files.rb_node;
+	struct rb_node *last = NULL;
+
+	while (*link) {
+		struct fuse_file *ff;
+
+		last = *link;
+		ff = rb_entry(last, struct fuse_file, polled_node);
+
+		if (kh < ff->kh)
+			link = &last->rb_left;
+		else if (kh > ff->kh)
+			link = &last->rb_right;
+		else
+			return link;
+	}
+
+	if (parent_out)
+		*parent_out = last;
+	return link;
+}
+
+/*
+ * The file is about to be polled.  Make sure it's on the polled_files
+ * RB tree.  Note that files once added to the polled_files tree are
+ * not removed before the file is released.  This is because a file
+ * polled once is likely to be polled again.
+ */
+static void fuse_register_polled_file(struct fuse_conn *fc,
+				      struct fuse_file *ff)
+{
+	spin_lock(&fc->lock);
+	if (RB_EMPTY_NODE(&ff->polled_node)) {
+		struct rb_node **link, *parent;
+
+		link = fuse_find_polled_node(fc, ff->kh, &parent);
+		BUG_ON(*link);
+		rb_link_node(&ff->polled_node, parent, link);
+		rb_insert_color(&ff->polled_node, &fc->polled_files);
+	}
+	spin_unlock(&fc->lock);
+}
+
+__poll_t fuse_file_poll(struct file *file, poll_table *wait)
+{
+	struct fuse_file *ff = file->private_data;
+	struct fuse_mount *fm = ff->fm;
+	struct fuse_poll_in inarg = { .fh = ff->fh, .kh = ff->kh };
+	struct fuse_poll_out outarg;
+	FUSE_ARGS(args);
+	int err;
+
+	if (fm->fc->no_poll)
+		return DEFAULT_POLLMASK;
+
+	poll_wait(file, &ff->poll_wait, wait);
+	inarg.events = mangle_poll(poll_requested_events(wait));
+
+	/*
+	 * Ask for notification iff there's someone waiting for it.
+	 * The client may ignore the flag and always notify.
+	 */
+	if (waitqueue_active(&ff->poll_wait)) {
+		inarg.flags |= FUSE_POLL_SCHEDULE_NOTIFY;
+		fuse_register_polled_file(fm->fc, ff);
+	}
+
+	args.opcode = FUSE_POLL;
+	args.nodeid = ff->nodeid;
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(outarg);
+	args.out_args[0].value = &outarg;
+	err = fuse_simple_request(fm, &args);
+
+	if (!err)
+		return demangle_poll(outarg.revents);
+	if (err == -ENOSYS) {
+		fm->fc->no_poll = 1;
+		return DEFAULT_POLLMASK;
+	}
+	return EPOLLERR;
+}
+EXPORT_SYMBOL_GPL(fuse_file_poll);
+
+/*
+ * This is called from fuse_handle_notify() on FUSE_NOTIFY_POLL and
+ * wakes up the poll waiters.
+ */
+int fuse_notify_poll_wakeup(struct fuse_conn *fc,
+			    struct fuse_notify_poll_wakeup_out *outarg)
+{
+	u64 kh = outarg->kh;
+	struct rb_node **link;
+
+	spin_lock(&fc->lock);
+
+	link = fuse_find_polled_node(fc, kh, NULL);
+	if (*link) {
+		struct fuse_file *ff;
+
+		ff = rb_entry(*link, struct fuse_file, polled_node);
+		wake_up_interruptible_sync(&ff->poll_wait);
+	}
+
+	spin_unlock(&fc->lock);
+	return 0;
+}
+
-- 
2.53.0

