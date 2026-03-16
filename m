Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0CA3CEB8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680016; cv=none; b=cXvqP6+ts5b5mOL4IeW/OMJZBJoNx3JJ+ySjntURk+BfTOL64mFtCpfv7N+EmkezkNu2OSx5XvkG+i+22fZF84glPPqQZllckCsAnbOKvvnW8mIyaNkV5LGDl/0C/ZojvSBU4HlWDBuxa8qFGgQO9WDGvq81q23rLGZW+IBN9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680016; c=relaxed/simple;
	bh=zAYMefaYVylzyeKh7BT1sIt1cbANSjqOd9SB8b/nxeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwKm4YGmKI6louFYIgpEnQMFIZXAfdsajW9R+a6NWmTlgpUfjGZdxKx5/tX+XC9gsaTxEBIZu92zoeYVK8xUIbvZVvEp3IoZGgXDmUYuhCnjhsfvW9BxczcyHCvXABOKYxI4IoWjPqS14AuNzYPd49XKL9k5ORbW7V+3UwWgpjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFgoLEka; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTeWS0nG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFgoLEka";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTeWS0nG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773680011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmnQS3Jw6sqpgtWWlKOH1/CBDAieGhq+/+5xzviMfrk=;
	b=iFgoLEkaSpTP7dOQqBTFwj85xh1c95WzlTDDw1kXJ+4l17DBdL6hOWJ1fDIXZ8WCKr1t0L
	816qQfQ9BQ73O/0NVdQ5THZcUt0ZImRftU+0aJpAniykavxGFPAYkmIGbjI85sZDZH3sXq
	bGQDxwshtNawPgMHCIzSo4eoCKmMTt8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-dQOalNjvONqUmTlUMLeEsw-1; Mon, 16 Mar 2026 12:53:30 -0400
X-MC-Unique: dQOalNjvONqUmTlUMLeEsw-1
X-Mimecast-MFC-AGG-ID: dQOalNjvONqUmTlUMLeEsw_1773680009
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so46905155e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773680009; x=1774284809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmnQS3Jw6sqpgtWWlKOH1/CBDAieGhq+/+5xzviMfrk=;
        b=UTeWS0nGbRj4ZE38Fi/3vOZRLgNkZCjaQ3w3Gc04zNR7wl9kyYbObcGO86SqjO33ld
         fv8V8XA/2BwZ+uogH6jgDlM60wHMNxMVJDUZYCi3dk8rpuL1YeCuifTSC4AM61ABfTpn
         ak5y4uo0sZrJTt8mcIFeCB4Rs5UkjloDrfG6ZHAEaI5KlEuuJs8vx7cWBkaYcEsdbUJ/
         76yBmoLahBLudgAKMByXartFDl5X43pWY8a6zo5oCrKrZ4zhi3gxJVwJ7eXyGNbCkRX7
         OEx3TCt/Ohs2sa7OAfDGQoa6YB8/MlmV/W7vTYX5p5UHgO3B/amdAh88kMnK6jdIlyAz
         8oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680009; x=1774284809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmnQS3Jw6sqpgtWWlKOH1/CBDAieGhq+/+5xzviMfrk=;
        b=i8b0vHpYPVuETkFbB6ndqJMAgJITv61Igu8lChaOIjIBahJGEDcW1qG8hwQWtY1yCG
         3sKm2Enq+ERx9fWZzDGvFS2dWkYMZO92/q4U0TIsYSrE+6C7mrBgC53qnKFj55xwqj5L
         XuKiN+mAvHradjveT0u+F+sh93us1wDebcC+xCEJPEt7IFv5J/BDXBfausBAzQAB5G/s
         KWA57T5QB3hdcDfMUKRq0jMfjuJBGhUl96bsrbJ9KAhGE64a+LIeILwerMDXJigup3Ax
         zSDA1n/s0JlwK+WkiuIdiJvte+Vdlj1UOsw02rlNX2e7HgtyAlocZORjCSKEAs9Izhoi
         JJZA==
X-Gm-Message-State: AOJu0YzzBtlLr+zBQ/odfr03MllQ7u2or7x9oNfayHqvV8g58KYY6rXL
	1+Zr2vDhP/homiQx7ETOq6UTLYYhKXcC7VVM16CGzJm1EndVTGf7BzL+7TXocYBerQrwlQT+8Or
	q3T0Tp+nvMy/ZzMO3MmkaB+tE4lKdmBAY6Xp69HSx6GBJ+bKJl4XLWhYvhpZIvkvaFZyuXtvFHd
	akWbDWyUrSDLCZi++RG3Txsu4WGtTuNaKiMMtCDBduu8tzm166KhI=
X-Gm-Gg: ATEYQzwdVgU+1ixGr7jG6/wS50jNeHz+K16KX/3V9tuDXXmE4/clTDUT5QDXxoWzrEj
	kxiqz/zB6FTu0SnR2gd96JL5GnM34RsyYUFnvD+wmage2byECXm3TplBKfgIBMJTkSNhSbGSctw
	c4qBxWeBZ0PpTnN7eGO/BWtBioSdeptlmvszSlhOOpwm8SeOYMGA6ZHQtqF+IJoSf2WYvIddUDE
	jm99CP1WhPTlFONaEEu3rEm4TDh6/a+gIBUDVb3PhxKIOyI7yyt74Jqky4JlN6rsZcNPIH1tpPv
	nZf3peHbXD7sxUusC2NcuqswFqZCHBWXHAz25r+hNHTOmI/YVKDnIEXTLkO/tO/Y+AktjepbSE+
	NgMevl1cnn8jPE0tM3hsGTI/4prUKg/Eduy+eBGjqR3idvotoGY/B3ijRkCHidQ324fm+nXKE2g
	==
X-Received: by 2002:a05:600c:524b:b0:485:2c61:9459 with SMTP id 5b1f17b1804b1-485570ce1b9mr245411105e9.8.1773680008788;
        Mon, 16 Mar 2026 09:53:28 -0700 (PDT)
X-Received: by 2002:a05:600c:524b:b0:485:2c61:9459 with SMTP id 5b1f17b1804b1-485570ce1b9mr245410555e9.8.1773680008267;
        Mon, 16 Mar 2026 09:53:28 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-172-54.pool.digikabel.hu. [85.67.172.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c340sm4978295e9.7.2026.03.16.09.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:53:27 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v3 5/7] fuse: clean up device cloning
Date: Mon, 16 Mar 2026 17:53:16 +0100
Message-ID: <20260316165320.3245526-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316165320.3245526-1-mszeredi@redhat.com>
References: <20260316165320.3245526-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - fuse_mutex is not needed for device cloning, because fuse_dev_install()
   uses cmpxcg() to set fud->fc, which prevents races between clone/mount
   or clone/clone.  This makes the logic simpler

 - Drop fc->dev_count.  This is only used to check in release if the device
   is the last clone, but checking list_empty(&fc->devices) is equivalent
   after removing the released device from the list.  Removing the fuse_dev
   before calling fuse_abort_conn() is okay, since the processing and io
   lists are now empty for this device.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c    | 46 ++++++++++++++++++----------------------------
 fs/fuse/fuse_i.h |  3 ---
 fs/fuse/inode.c  |  1 -
 3 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4c926c9c4f39..3d6578fcb386 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2538,6 +2538,7 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 		struct fuse_pqueue *fpq = &fud->pq;
 		LIST_HEAD(to_end);
 		unsigned int i;
+		bool last;
 
 		spin_lock(&fpq->lock);
 		WARN_ON(!list_empty(&fpq->io));
@@ -2547,14 +2548,16 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 
 		fuse_dev_end_requests(&to_end);
 
+		spin_lock(&fc->lock);
+		list_del(&fud->entry);
 		/* Are we the last open device? */
-		if (atomic_dec_and_test(&fc->dev_count)) {
+		last = list_empty(&fc->devices);
+		spin_unlock(&fc->lock);
+
+		if (last) {
 			WARN_ON(fc->iq.fasync != NULL);
 			fuse_abort_conn(fc);
 		}
-		spin_lock(&fc->lock);
-		list_del(&fud->entry);
-		spin_unlock(&fc->lock);
 		fuse_conn_put(fc);
 	}
 	fuse_dev_put(fud);
@@ -2573,24 +2576,10 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
 	return fasync_helper(fd, file, on, &fud->fc->iq.fasync);
 }
 
-static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
-{
-	struct fuse_dev *new_fud = fuse_file_to_fud(new);
-
-	if (fuse_dev_fc_get(new_fud))
-		return -EINVAL;
-
-	fuse_dev_install(new_fud, fc);
-	atomic_inc(&fc->dev_count);
-
-	return 0;
-}
-
 static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 {
-	int res;
 	int oldfd;
-	struct fuse_dev *fud = NULL;
+	struct fuse_dev *fud, *new_fud;
 
 	if (get_user(oldfd, argp))
 		return -EFAULT;
@@ -2603,17 +2592,18 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 	 * Check against file->f_op because CUSE
 	 * uses the same ioctl handler.
 	 */
-	if (fd_file(f)->f_op == file->f_op)
-		fud = __fuse_get_dev(fd_file(f));
+	if (fd_file(f)->f_op != file->f_op)
+		return -EINVAL;
 
-	res = -EINVAL;
-	if (fud) {
-		mutex_lock(&fuse_mutex);
-		res = fuse_device_clone(fud->fc, file);
-		mutex_unlock(&fuse_mutex);
-	}
+	fud = __fuse_get_dev(fd_file(f));
+	if (!fud)
+		return -EINVAL;
 
-	return res;
+	new_fud = fuse_file_to_fud(file);
+	if (!fuse_dev_install(new_fud, fud->fc))
+		return -EINVAL;
+
+	return 0;
 }
 
 static long fuse_dev_ioctl_backing_open(struct file *file,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4a591a436324..77f1c7cf24d2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -650,9 +650,6 @@ struct fuse_conn {
 	/** Refcount */
 	refcount_t count;
 
-	/** Number of fuse_dev's */
-	atomic_t dev_count;
-
 	/** Current epoch for up-to-date dentries */
 	atomic_t epoch;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 314fb37f272f..7065614d02c9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -995,7 +995,6 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	spin_lock_init(&fc->bg_lock);
 	init_rwsem(&fc->killsb);
 	refcount_set(&fc->count, 1);
-	atomic_set(&fc->dev_count, 1);
 	atomic_set(&fc->epoch, 1);
 	INIT_WORK(&fc->epoch_work, fuse_epoch_work);
 	init_waitqueue_head(&fc->blocked_waitq);
-- 
2.53.0

