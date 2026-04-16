Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A98399351
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331069; cv=none; b=jgwPhj5GNhN/mJZ/70l/1P0lbGxSqCR2yde+T1c+d4EAKL0IZYUYxCerXeD0Z5yRO1ISAYLO5tMX1M/fakJYoIW+nSexonGV6WYITu0pTs6QYPFtah/9OHkdIuV4u6x/I/XnvJYcYJaUbGG216TsM2pO73R3dUtov9DL87nx014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331069; c=relaxed/simple;
	bh=o2TRhL26L9NSfPeFRxX7OHidOHIrOe7kuKVF6GkfxQc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gt3twdRcNzH6Om5ND4cE1c2C0UX9pn5F2j2vnzbXkVNIVNOXtQOH4Vtdskc4FLffIYp9L8Gn1CARXKzDCVoQVbWaItH0Q68vKI+JMeW1+1zrFewy9bbncYX4fEEI7eOkyL59rBVCvwAw+D4YhXAIW/2L4ji6HhxgdyVLbVqQ16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMcgkAGo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBhTrrGN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMcgkAGo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBhTrrGN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbaJEA9MO6bqlLSOx8ZxcFBDBbtOdy+ISiZH/GSHqa8=;
	b=NMcgkAGokzOT1lBqvmey0tiyf2BfxZJ8DLtAJGUvESldYh+NIMpZn8Usol0qIm5YhHeMw/
	eeBr2soGD5obO6wCvpMp23kiEBoprKuVPwmwsnyz2uz6tvFfW9wtDFoF6vu/fspVCrBUEr
	x3nP4xNqvENONqXW6C90jx6wDB62I14=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-x8ruLn1jMQikCWOGhUnXHw-1; Thu, 16 Apr 2026 05:17:35 -0400
X-MC-Unique: x8ruLn1jMQikCWOGhUnXHw-1
X-Mimecast-MFC-AGG-ID: x8ruLn1jMQikCWOGhUnXHw_1776331055
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-483786a09b1so81822135e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331054; x=1776935854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbaJEA9MO6bqlLSOx8ZxcFBDBbtOdy+ISiZH/GSHqa8=;
        b=CBhTrrGN6b/f8Qh2R+KGnmUKIe/EobMd3P1sq9c5tBLltfHdOh9+8Am91vZHnkerv6
         zJ2A36WC6JBfQbXRfhTFgkXomsMPXVQKBVpUXwGHrHHS/rAFcMHnv/W8poziOB2ZFsmd
         cRCUEfkuNRgpBMNnzu+Uqf2BvQAFVJkXR5Xd4tVEfNbv626z3lOSy0jGWnOONc9JlTbJ
         WIV3J8qBdxN1Eug1iHjOu9IrkzxtQZxym5DfHSlCR8izbcPaJxljo+DSZbysxLdjdTKN
         BaCok/jNA/2NoQ6rmobVw2p+PlUiIFX7K81Wvr99OB/ISyycwihTgPJEa5sTtONvyUTW
         do3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331054; x=1776935854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nbaJEA9MO6bqlLSOx8ZxcFBDBbtOdy+ISiZH/GSHqa8=;
        b=hkcAUoao+fINtup/FdjWn9P/rbnAHgvg46imj1Iiw3wPCiGvKrzjyo6pdytQNKpcIY
         ehU8xZalarFPbulWnMi7IPPgOtH8XOgn1NkKGrK08Wb/4Uvbjuqo6O2npNMnzKBdKt/P
         jt4yeDoNJ/mCVxfIWhKQPbN1qkxez4gV13WsKDX7EslF4ScxjtZORf5QHrLKAXA6lgqW
         vE8YUsEHUM8cZm2ZnQOQkE7EsIVqEjSK8GMaOZGXy6CE+mzzAQJk7Url8kcfrY2zgCU3
         NnxD55eAVPb2BWnevEaOIj9R8MAtV4zckl+4Gi5YTpRJvxWMR+n8aK9ZWgsYwn54v/K9
         PFNA==
X-Forwarded-Encrypted: i=1; AFNElJ9Qh/QoP+nZssE+Wy20e2m4slmN3tHnktDEWcTF6oW86MNKMd2/hvtzm8vCKiE82WDKPodjjVFjYR/3bH6C@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/Z6nzzrOEPMMYDFj8472kCz9E4GIuIawVxVQMoltiPghT8q5
	sDY/uWV3X+FceqwlnNA4/l7hRoxLO6MYTdiBCun9Xr+SyJge+zep8PM0OeeTu+rdF0DGMkqLu6y
	8cKmts12YiA0be3vOeXnlg6emnTxDmGJay+5oNXtJbQ2M1mvOB7lHuGhP4s9xFGTSLRyNpnsx15
	0=
X-Gm-Gg: AeBDieuKsxOrf7cK8xC8PXHTzZptnYoqXMs0FN42Tsxi409R5k2EeudcSkOTflozJ1P
	uu/I0aDzj2LPfW3zN7uzRyTTD5htwQ6ZsHdBcjtZ+H4mbFKJ1INUXv3LfSjoXpc4yZSm2gvicHc
	ojKuBGsvOxFT07UAk/8AMPXYZ3UPV2pVUZ/wg34Sx8BltQwVzFogqi5f+P1zcW3ivB2mh3YtYZP
	DDSskgBpi1TLUPffmRyUoFeefLJPqUOzMvkhUmr9qEPNIyoiHInaIu1frzFeco7dcAi4hvsKJxc
	wjBPs2XIO8ksozsHmAZVOduvsxGSocm6U2w896j7Q08gDR1ZMyR3PCJjOQaHtW0STr9GvN592Oo
	a+kO+wJcK0JNPuGqEyNP69OqkNRj23BSx+VL2JAR+rm8IMy/WzJjmxfwHCt6Lnxu9s3LHCgLosy
	mW6ckbjA==
X-Received: by 2002:a05:600c:c16d:b0:488:be21:54ae with SMTP id 5b1f17b1804b1-488d66504bfmr377433155e9.0.1776331054131;
        Thu, 16 Apr 2026 02:17:34 -0700 (PDT)
X-Received: by 2002:a05:600c:c16d:b0:488:be21:54ae with SMTP id 5b1f17b1804b1-488d66504bfmr377432455e9.0.1776331053557;
        Thu, 16 Apr 2026 02:17:33 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:33 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/32] fuse: split out filesystem part of request sending
Date: Thu, 16 Apr 2026 11:16:47 +0200
Message-ID: <20260416091658.462783-24-mszeredi@redhat.com>
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

Create a new source file: req.c and add the request sending entry
functions:

  __fuse_simple_request()
  fuse_simple_background()
  fuse_simple_notify_reply()

Introduce transport layer sending functions that are called by the
respective fs layer function:

  fuse_chan_send()
  fuse_chan_send_bg()
  fuse_chan_send_notify_reply()

Move calculation of request header fields uid, gid and pid from
fuse_get_req() and fuse_force_creads() to a new helper: fuse_fill_creds().

These fileds are now passed to the transport layer via struct fuse_args.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/Makefile |   2 +-
 fs/fuse/dev.c    | 103 +++++++++++------------------------------------
 fs/fuse/dev.h    |   4 ++
 fs/fuse/fuse_i.h |   1 +
 fs/fuse/req.c    |  99 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+), 80 deletions(-)
 create mode 100644 fs/fuse/req.c

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 30dd1bee931d..08be6817a1cc 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := trace.o	# put trace.o first so we see ftrace errors sooner
-fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o req_timeout.o
+fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o req_timeout.o req.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5b74bd4d7cc3..95b8de20542a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -101,75 +101,44 @@ static void fuse_drop_waiting(struct fuse_chan *fch)
 
 static void fuse_put_request(struct fuse_req *req);
 
-static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
-				     struct fuse_mount *fm,
-				     bool for_background)
+static struct fuse_req *fuse_get_req(struct fuse_chan *fch, bool for_background)
 {
-	struct fuse_conn *fc = fm->fc;
 	struct fuse_req *req;
-	bool no_idmap = !fm->sb || (fm->sb->s_iflags & SB_I_NOIDMAP);
-	kuid_t fsuid;
-	kgid_t fsgid;
 	int err;
 
-	atomic_inc(&fc->chan->num_waiting);
+	atomic_inc(&fch->num_waiting);
 
-	if (fuse_block_alloc(fc, for_background)) {
+	if (fuse_block_alloc(fch->conn, for_background)) {
 		err = -EINTR;
-		if (wait_event_state_exclusive(fc->chan->blocked_waitq,
-				!fuse_block_alloc(fc, for_background),
+		if (wait_event_state_exclusive(fch->blocked_waitq,
+				!fuse_block_alloc(fch->conn, for_background),
 				(TASK_KILLABLE | TASK_FREEZABLE)))
 			goto out;
 	}
+
 	/* Matches smp_wmb() in fuse_chan_set_initialized() */
 	smp_rmb();
 
 	err = -ENOTCONN;
-	if (!fc->chan->connected)
-		goto out;
-
-	err = -ECONNREFUSED;
-	if (fc->conn_error)
+	if (!fch->connected)
 		goto out;
 
-	req = fuse_request_alloc(fc->chan, GFP_KERNEL);
+	req = fuse_request_alloc(fch, GFP_KERNEL);
 	err = -ENOMEM;
 	if (!req) {
 		if (for_background)
-			wake_up(&fc->chan->blocked_waitq);
+			wake_up(&fch->blocked_waitq);
 		goto out;
 	}
 
-	req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
-
 	__set_bit(FR_WAITING, &req->flags);
 	if (for_background)
 		__set_bit(FR_BACKGROUND, &req->flags);
 
-	/*
-	 * Keep the old behavior when idmappings support was not
-	 * declared by a FUSE server.
-	 *
-	 * For those FUSE servers who support idmapped mounts,
-	 * we send UID/GID only along with "inode creation"
-	 * fuse requests, otherwise idmap == &invalid_mnt_idmap and
-	 * req->in.h.{u,g}id will be equal to FUSE_INVALID_UIDGID.
-	 */
-	fsuid = no_idmap ? current_fsuid() : mapped_fsuid(idmap, fc->user_ns);
-	fsgid = no_idmap ? current_fsgid() : mapped_fsgid(idmap, fc->user_ns);
-	req->in.h.uid = from_kuid(fc->user_ns, fsuid);
-	req->in.h.gid = from_kgid(fc->user_ns, fsgid);
-
-	if (no_idmap && unlikely(req->in.h.uid == ((uid_t)-1) ||
-				 req->in.h.gid == ((gid_t)-1))) {
-		fuse_put_request(req);
-		return ERR_PTR(-EOVERFLOW);
-	}
-
 	return req;
 
  out:
-	fuse_drop_waiting(fc->chan);
+	fuse_drop_waiting(fch);
 	return ERR_PTR(err);
 }
 
@@ -775,25 +744,13 @@ static void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args)
 	}
 }
 
-static void fuse_force_creds(struct fuse_mount *fm, struct fuse_req *req)
-{
-	struct fuse_conn *fc = fm->fc;
-
-	if (!fm->sb || fm->sb->s_iflags & SB_I_NOIDMAP) {
-		req->in.h.uid = from_kuid_munged(fc->user_ns, current_fsuid());
-		req->in.h.gid = from_kgid_munged(fc->user_ns, current_fsgid());
-	} else {
-		req->in.h.uid = FUSE_INVALID_UIDGID;
-		req->in.h.gid = FUSE_INVALID_UIDGID;
-	}
-
-	req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
-}
-
 static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 {
 	req->in.h.opcode = args->opcode;
 	req->in.h.nodeid = args->nodeid;
+	req->in.h.uid = args->uid;
+	req->in.h.gid = args->gid;
+	req->in.h.pid = args->pid;
 	req->args = args;
 	if (args->is_ext)
 		req->in.h.total_extlen = args->in_args[args->ext_idx].size / 8;
@@ -801,33 +758,26 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 		__set_bit(FR_ASYNC, &req->flags);
 }
 
-ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
-			      struct fuse_mount *fm,
-			      struct fuse_args *args)
+ssize_t fuse_chan_send(struct fuse_chan *fch, struct fuse_args *args)
 {
-	struct fuse_conn *fc = fm->fc;
 	struct fuse_req *req;
 	ssize_t ret;
 
 	if (args->force) {
-		atomic_inc(&fc->chan->num_waiting);
-		req = fuse_request_alloc(fc->chan, GFP_KERNEL | __GFP_NOFAIL);
-
-		if (!args->nocreds)
-			fuse_force_creds(fm, req);
+		atomic_inc(&fch->num_waiting);
+		req = fuse_request_alloc(fch, GFP_KERNEL | __GFP_NOFAIL);
 
 		__set_bit(FR_WAITING, &req->flags);
 		if (!args->abort_on_kill)
 			__set_bit(FR_FORCE, &req->flags);
 	} else {
-		WARN_ON(args->nocreds);
-		req = fuse_get_req(idmap, fm, false);
+		req = fuse_get_req(fch, false);
 		if (IS_ERR(req))
 			return PTR_ERR(req);
 	}
 
 	/* Needs to be done after fuse_get_req() so that fc->minor is valid */
-	fuse_adjust_compat(fc, args);
+	fuse_adjust_compat(fch->conn, args);
 	fuse_args_to_req(req, args);
 
 	if (!args->noreply)
@@ -891,20 +841,17 @@ static int fuse_request_queue_background(struct fuse_req *req)
 	return queued;
 }
 
-int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
-			    gfp_t gfp_flags)
+int fuse_chan_send_bg(struct fuse_chan *fch, struct fuse_args *args, gfp_t gfp_flags)
 {
 	struct fuse_req *req;
 
 	if (args->force) {
-		WARN_ON(!args->nocreds);
-		req = fuse_request_alloc(fm->fc->chan, gfp_flags);
+		req = fuse_request_alloc(fch, gfp_flags);
 		if (!req)
 			return -ENOMEM;
 		__set_bit(FR_BACKGROUND, &req->flags);
 	} else {
-		WARN_ON(args->nocreds);
-		req = fuse_get_req(&invalid_mnt_idmap, fm, true);
+		req = fuse_get_req(fch, true);
 		if (IS_ERR(req))
 			return PTR_ERR(req);
 	}
@@ -918,15 +865,13 @@ int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fuse_simple_background);
 
-static int fuse_simple_notify_reply(struct fuse_mount *fm,
-				    struct fuse_args *args, u64 unique)
+int fuse_chan_send_notify_reply(struct fuse_chan *fch, struct fuse_args *args, u64 unique)
 {
 	struct fuse_req *req;
-	struct fuse_iqueue *fiq = &fm->fc->chan->iq;
+	struct fuse_iqueue *fiq = &fch->iq;
 
-	req = fuse_get_req(&invalid_mnt_idmap, fm, false);
+	req = fuse_get_req(fch, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index a0c1212573d6..fb814a0b6782 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -11,6 +11,7 @@
 struct fuse_conn;
 struct fuse_chan;
 struct fuse_dev;
+struct fuse_args;
 struct file;
 
 struct fuse_chan *fuse_chan_new(void);
@@ -24,6 +25,9 @@ unsigned int fuse_chan_num_waiting(struct fuse_chan *fch);
 void fuse_chan_set_fc(struct fuse_chan *fch, struct fuse_conn *fc);
 void fuse_chan_set_initialized(struct fuse_chan *fch);
 void fuse_chan_io_uring_enable(struct fuse_chan *fch);
+ssize_t fuse_chan_send(struct fuse_chan *fch, struct fuse_args *args);
+int fuse_chan_send_bg(struct fuse_chan *fch, struct fuse_args *args, gfp_t gfp_flags);
+int fuse_chan_send_notify_reply(struct fuse_chan *fch, struct fuse_args *args, u64 unique);
 
 struct fuse_forget_link *fuse_alloc_forget(void);
 void fuse_chan_queue_forget(struct fuse_chan *fch, struct fuse_forget_link *forget,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 22a6d58678ad..f7a9c7cedd39 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -941,6 +941,7 @@ static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
 
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
+int fuse_simple_notify_reply(struct fuse_mount *fm, struct fuse_args *args, u64 unique);
 
 void fuse_dentry_tree_init(void);
 void fuse_dentry_tree_cleanup(void);
diff --git a/fs/fuse/req.c b/fs/fuse/req.c
new file mode 100644
index 000000000000..a01ee743d31e
--- /dev/null
+++ b/fs/fuse/req.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "dev.h"
+#include "fuse_i.h"
+
+static int fuse_fill_creds(struct fuse_mount *fm, struct fuse_args *args, struct mnt_idmap *idmap)
+{
+	struct fuse_conn *fc = fm->fc;
+	bool no_idmap = !fm->sb || (fm->sb->s_iflags & SB_I_NOIDMAP);
+	kuid_t fsuid = mapped_fsuid(idmap, fc->user_ns);
+	kgid_t fsgid = mapped_fsgid(idmap, fc->user_ns);
+
+	args->pid = pid_nr_ns(task_pid(current), fc->pid_ns);
+
+	if (args->force) {
+		if (args->nocreds)
+			return 0;
+
+		if (no_idmap) {
+			args->uid = from_kuid_munged(fc->user_ns, current_fsuid());
+			args->gid = from_kgid_munged(fc->user_ns, current_fsgid());
+		} else {
+			args->uid = FUSE_INVALID_UIDGID;
+			args->gid = FUSE_INVALID_UIDGID;
+		}
+		return 0;
+	}
+
+	WARN_ON(args->nocreds);
+	/*
+	 * Keep the old behavior when idmappings support was not
+	 * declared by a FUSE server.
+	 *
+	 * For those FUSE servers who support idmapped mounts, we send UID/GID
+	 * only along with "inode creation" fuse requests, otherwise idmap ==
+	 * &invalid_mnt_idmap and req->in.h.{u,g}id will be equal to
+	 * FUSE_INVALID_UIDGID.
+	 */
+	if (no_idmap) {
+		fsuid = current_fsuid();
+		fsgid = current_fsgid();
+	}
+	args->uid = from_kuid(fc->user_ns, fsuid);
+	args->gid = from_kgid(fc->user_ns, fsgid);
+
+	if (no_idmap && unlikely(args->uid == ((uid_t)-1) || args->gid == ((gid_t)-1)))
+		return -EOVERFLOW;
+
+	return 0;
+}
+
+static int fuse_req_prep(struct fuse_mount *fm, struct fuse_args *args, struct mnt_idmap *idmap)
+{
+	if (!args->force && fm->fc->conn_error)
+		return -ECONNREFUSED;
+
+	return fuse_fill_creds(fm, args, idmap);
+}
+
+ssize_t __fuse_simple_request(struct mnt_idmap *idmap, struct fuse_mount *fm,
+			      struct fuse_args *args)
+{
+	struct fuse_conn *fc = fm->fc;
+	int err = fuse_req_prep(fm, args, idmap);
+
+	if (err)
+		return err;
+
+	return fuse_chan_send(fc->chan, args);
+}
+
+int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args, gfp_t gfp_flags)
+{
+	struct fuse_conn *fc = fm->fc;
+	int err;
+
+	WARN_ON(args->force && !args->nocreds);
+
+	err = fuse_req_prep(fm, args, &invalid_mnt_idmap);
+	if (err)
+		return err;
+
+	return fuse_chan_send_bg(fc->chan, args, gfp_flags);
+}
+EXPORT_SYMBOL_GPL(fuse_simple_background);
+
+int fuse_simple_notify_reply(struct fuse_mount *fm, struct fuse_args *args, u64 unique)
+{
+	struct fuse_conn *fc = fm->fc;
+	int err;
+
+	WARN_ON(args->force && !args->nocreds);
+
+	err = fuse_req_prep(fm, args, &invalid_mnt_idmap);
+	if (err)
+		return err;
+
+	return fuse_chan_send_notify_reply(fc->chan, args, unique);
+}
-- 
2.53.0

