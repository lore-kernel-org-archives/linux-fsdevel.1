Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66C399351
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331032; cv=none; b=nY+yqaC1xfCQjkeFuTwLAOtriTYHG+jjQ55Hy3KYfGr9c0rj8ZwooDPolIRQiwx1s+RO+Xp4rO0xxMQjL3B4xM8IFCi1RrpSZvUT8mn5HSKpy6rgKixZpGEDij9DM0cVKofIBO0RhD3e06jUFi87bDjaUHpEy9hyEzhd8xThlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331032; c=relaxed/simple;
	bh=x/DSvtCyRipWNH91T3HbbeUOM89Uw//kQAjmllL4jPc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPaBv0uqG+Kei25DyH1J0SoTAa3N6KihYPxNTHRAxWhvM4Rxrd7HJrb5RfqkcsDjwiLmQgXNX70wILOHSnNYZhR2u7PCmhMfdhqJS4Zw6RKlAnjgVaMyDpZXX31VjV8xKAYhvbHZrDplSDRZEOaKVdIzp+ZammLvnApEiQmZjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVYDib/N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpnCgyfk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVYDib/N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpnCgyfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJEDd63xzRQVhGo4HSyO9OcLIgdMyTGFGR0O6k6LKrE=;
	b=JVYDib/Ny9i+6Jk+HFoXgk5ZqA9s5nornbjzA6NGZMuko72wnW7xE1OXTrrL/cSQ0al3Tf
	vJ1Lkr+SLzCb1wSE6pi73Dbv5BFWvDg/c4xOgCqIwT0RueGK4kHSHOLs3joMINMnurM4HS
	G4uf5zh0klLWPpPaaem+vihDtiI0MBY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-NeCaxjpTPXuoSkiZpYZeWw-1; Thu, 16 Apr 2026 05:17:05 -0400
X-MC-Unique: NeCaxjpTPXuoSkiZpYZeWw-1
X-Mimecast-MFC-AGG-ID: NeCaxjpTPXuoSkiZpYZeWw_1776331024
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7c6d58c8so4943056f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331024; x=1776935824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJEDd63xzRQVhGo4HSyO9OcLIgdMyTGFGR0O6k6LKrE=;
        b=OpnCgyfkF5EZLU+6Y2bI3XvC1xbvd6BBqOMLufS3o7hXwvaPfAyFyLqTj0vGFC6K/Y
         kxiAME76fQBoP1kylr7/FuI1mYGf9s1LC4ff9718hEahblrT/eBjTc+veWbugcoaDZM4
         fjNeX4YltC7pxaAKu+lFwQy97RuWztfahrmeTFceKMcdY0Q8AX2EiVF/Uy5fLQ6wi2Ef
         cVs3YEIU1EP3Hh3gG4h42eaXEO48psCUOqsvR9yX7MQ+OVQYUbqIKczOZHL+q6V+M+dV
         Qo6D01NTHXeCxvnvFJAuBRcVbQP7+vxkdLDX6XProHIE4kBmUTbyC1ZNOUUwMGFc8CWA
         q3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331024; x=1776935824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xJEDd63xzRQVhGo4HSyO9OcLIgdMyTGFGR0O6k6LKrE=;
        b=kP8nuXwoHt48netQv7CagEzefPiDkPnXiEzxUFMXR2vKUBxVxXTwAmK0SGXRjaUeD8
         Dsf3T7Ds677PYny7Hkd03pGlvFPp7PfYPj3Gh1XToZYGN0b3tGpK54cIE6gwYb4Gcasd
         tlR7V4o8U5eNUN1UeOSw71u0oxJvSCbYG20E7r4B2GXDusC+Ye429cTWkJXIamDjVDN4
         Rosmq6V2XFqa1RHuFj3rsdDoVBLVF3cuj+ZfNjulX8G1S9rVUdOcr1kYYfCCT/aqe13j
         JZ86cb0dzHSTlC64xC10HognWGUPSTtoHGblswOwtsylNyLhgPtwBy/xVx+GoZLr/DzD
         FJfg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ruv8DOpQjCHHYk8xUnVZEaG6Q428DVHqwGljSOpHM2wEbTl5dcIvI+e7yQVzYknzn4/9GqldUh2ThTCCs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3TT2UOISWE3Z5GsnQ8qqIHxIflzWZhYnK4URRQUwDx9fEt2w5
	9O2NZLse33VGokR9kYFEVekq4TKNtHjWJxVPsH4vN4osEP0FOfFlwKirw+NwuuIGvMGN7UnnoUg
	wS9RQsSKcahbuPB44OEkZRjPL6G3mLF98Ut8RukFNPewjzrGKMN1XTUplGTEQ6SCbBAg=
X-Gm-Gg: AeBDievGGxO65Uu6Ttx2DBs8vdLC1m8eho5z5/TnEEeCWvVmc2VPa9X66tdIfr/Dmqa
	955hZOjFUOKg+9VV4tYI/uMJgrvKPAdCJhe+5nGQqFi/0ymASlAR3O+fuoU1yylsy1NCJUWOSza
	+iSqwgUWgm+fYZNcOgrTsnZEKheGsTltwXxSBOsiASI/nMwH/U9Tqxty5pAKlxxS418oHf/PFu2
	8QjTonUeb/fRER4P8/orbHcftzndHOLFt/nCtplWx+9JPrHWdYDj+V/0+0elH5K0uUQ6Nf2p/xo
	3Od3fZ/eIMHX4iNUvq3JUB8i86p/QZbVgJIW2crEc776a98eukstK0b5XVXAN38gdTSNnKjZrG8
	fibYj769Ei1vNdoO+mJlEeOvRe6MhlnKcz8Watq/5tKpEUjpG4Zjgv14myrzqiS5/AGG1zaVv+8
	36kF1+pw==
X-Received: by 2002:a05:600c:3acf:b0:485:35a4:939f with SMTP id 5b1f17b1804b1-488d68a8275mr309195395e9.28.1776331023832;
        Thu, 16 Apr 2026 02:17:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3acf:b0:485:35a4:939f with SMTP id 5b1f17b1804b1-488d68a8275mr309194905e9.28.1776331023283;
        Thu, 16 Apr 2026 02:17:03 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:02 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/32] fuse: add struct fuse_chan
Date: Thu, 16 Apr 2026 11:16:26 +0200
Message-ID: <20260416091658.462783-3-mszeredi@redhat.com>
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

The goal is to separate transport layer stuff out from struct fuse_conn,
leaving just the filesystem related members.

Add a new object referenced from fuse_conn.  This patch just implements the
allocation and freeing of this object.

Following patches will move transport related members from fuse_conn to
fuse_chan.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/cuse.c       |  7 ++++++-
 fs/fuse/dev.c        | 13 +++++++++++++
 fs/fuse/dev.h        |  7 +++++++
 fs/fuse/fuse_dev_i.h |  4 ++++
 fs/fuse/fuse_i.h     |  6 +++++-
 fs/fuse/inode.c      | 10 ++++++++--
 fs/fuse/virtio_fs.c  |  8 +++++++-
 7 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 174333633471..b135c3281a05 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -51,6 +51,7 @@
 #include <linux/uio.h>
 #include <linux/user_namespace.h>
 
+#include "dev.h"
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
 
@@ -502,8 +503,12 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 {
 	struct fuse_dev *fud;
 	struct cuse_conn *cc;
+	struct fuse_chan *fch __free(fuse_chan_free) = fuse_chan_new();
 	int rc;
 
+	if (!fch)
+		return -ENOMEM;
+
 	/* set up cuse_conn */
 	cc = kzalloc_obj(*cc);
 	if (!cc)
@@ -514,7 +519,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	 * be represented in file->f_cred->user_ns.
 	 */
 	fuse_conn_init(&cc->fc, &cc->fm, file->f_cred->user_ns,
-		       &fuse_dev_fiq_ops, NULL);
+		       &fuse_dev_fiq_ops, NULL, no_free_ptr(fch));
 
 	cc->fc.release = cuse_fc_release;
 	fud = fuse_dev_alloc_install(&cc->fc);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index eea85eaa5e77..3e1e8ce83f1c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -6,6 +6,7 @@
   See the file COPYING.
 */
 
+#include "dev.h"
 #include "dev_uring_i.h"
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
@@ -319,6 +320,18 @@ const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
 };
 EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
 
+void fuse_chan_free(struct fuse_chan *fch)
+{
+	kfree(fch);
+}
+EXPORT_SYMBOL_GPL(fuse_chan_free);
+
+struct fuse_chan *fuse_chan_new(void)
+{
+	return kzalloc_obj(struct fuse_chan);
+}
+EXPORT_SYMBOL_GPL(fuse_chan_new);
+
 static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	req->in.h.len = sizeof(struct fuse_in_header) +
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index f7db15c33cf9..70e4a75e6942 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -3,7 +3,14 @@
 #ifndef _FS_FUSE_DEV_H
 #define _FS_FUSE_DEV_H
 
+#include <linux/cleanup.h>
+
 struct fuse_conn;
+struct fuse_chan;
+
+struct fuse_chan *fuse_chan_new(void);
+void fuse_chan_free(struct fuse_chan *fch);
+DEFINE_FREE(fuse_chan_free, struct fuse_chan *, if (_T) fuse_chan_free(_T))
 
 void fuse_init_server_timeout(struct fuse_conn *fc, unsigned int timeout);
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 910f883cd090..8d69ea8761c5 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -21,6 +21,10 @@ struct fuse_req;
 struct fuse_iqueue;
 struct fuse_forget_link;
 
+struct fuse_chan {
+	/* will move stuff from struct fuse_conn */
+};
+
 struct fuse_copy_state {
 	struct fuse_req *req;
 	struct iov_iter *iter;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 111fb6f3ebc4..deaffe245284 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -668,6 +668,9 @@ struct fuse_conn {
 	/** Input queue */
 	struct fuse_iqueue iq;
 
+	/* transport layer object */
+	struct fuse_chan *chan;
+
 	/** The next unique kernel file handle */
 	atomic64_t khctr;
 
@@ -1313,7 +1316,8 @@ void fuse_pqueue_init(struct fuse_pqueue *fpq);
  */
 void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 		    struct user_namespace *user_ns,
-		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv);
+		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv,
+		    struct fuse_chan *fch);
 
 /**
  * Release reference to fuse_conn
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index db0ef19f4abe..758cefa9b9b6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -997,7 +997,7 @@ void fuse_pqueue_init(struct fuse_pqueue *fpq)
 
 void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 		    struct user_namespace *user_ns,
-		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
+		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv, struct fuse_chan *fch)
 {
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
@@ -1035,6 +1035,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
 	fm->fc = fc;
+	fc->chan = fch;
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
@@ -1043,6 +1044,7 @@ static void delayed_release(struct rcu_head *p)
 	struct fuse_conn *fc = container_of(p, struct fuse_conn, rcu);
 
 	fuse_uring_destruct(fc);
+	fuse_chan_free(fc->chan);
 
 	put_user_ns(fc->user_ns);
 	fc->release(fc);
@@ -1982,8 +1984,12 @@ static int fuse_get_tree(struct fs_context *fsc)
 	struct fuse_conn *fc;
 	struct fuse_mount *fm;
 	struct super_block *sb;
+	struct fuse_chan *fch __free(fuse_chan_free) = fuse_chan_new();
 	int err;
 
+	if (!fch)
+		return -ENOMEM;
+
 	fc = kmalloc_obj(*fc);
 	if (!fc)
 		return -ENOMEM;
@@ -1994,7 +2000,7 @@ static int fuse_get_tree(struct fs_context *fsc)
 		return -ENOMEM;
 	}
 
-	fuse_conn_init(fc, fm, fsc->user_ns, &fuse_dev_fiq_ops, NULL);
+	fuse_conn_init(fc, fm, fsc->user_ns, &fuse_dev_fiq_ops, NULL, no_free_ptr(fch));
 	fc->release = fuse_free_conn;
 
 	fsc->s_fs_info = fm;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 12300651a0f1..f6d41b760210 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/cleanup.h>
 #include <linux/uio.h>
+#include "dev.h"
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
 
@@ -1683,8 +1684,12 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	struct fuse_conn *fc = NULL;
 	struct fuse_mount *fm;
 	unsigned int virtqueue_size;
+	struct fuse_chan *fch __free(fuse_chan_free) = fuse_chan_new();
 	int err = -EIO;
 
+	if (!fch)
+		return -ENOMEM;
+
 	if (!fsc->source)
 		return invalf(fsc, "No source specified");
 
@@ -1711,7 +1716,8 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	if (!fm)
 		goto out_err;
 
-	fuse_conn_init(fc, fm, fsc->user_ns, &virtio_fs_fiq_ops, fs);
+	fuse_conn_init(fc, fm, fsc->user_ns, &virtio_fs_fiq_ops, fs, no_free_ptr(fch));
+
 	fc->release = fuse_free_conn;
 	fc->delete_stale = true;
 	fc->auto_submounts = true;
-- 
2.53.0

