Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9073FEB3B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344433; cv=none; b=IQfK7jRCicQsdyYcKojF6LSXZ9zbBszmIKCPgKTlRayduGxaZZs/efjTXI5pq3nT8buaY1KRiilKUDrGNMAuWUeMnL+YvpJsYaxZZGEY51pa09eTzP9Rbeble+kvfqd09J6k8sH54fGzeIO+2SskzRb8PDT+GUYKo8DNoptwAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344433; c=relaxed/simple;
	bh=rrOMMyv4j5jycmMzhacYEzAui1GqtMv2alyzLvE+s3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HP2JSzmcoX47hc3trF4zz26ysv6tOOFugzt5VltRKzmYiNHwBRhrWEglg+8HAA7DtmZlazeFT1RDkZ3ArPWLR7Bv2EFK0qr2O9ZJ2RbGxq1hggpz24z8I5qYvcMk4d06iGn4VVE6zQNNdaJZID1dfmU+OjrAXUjv/PWKO4+xtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnHrJ4Xa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tOd7UzH0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnHrJ4Xa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tOd7UzH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773344429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjtfqezOUIGVWTT2wHYeTSUb6IpGuKrfwjpdG4ReJu0=;
	b=gnHrJ4XaWbqcRM4kiGsJN99W4XyrUFH/e2V1jHSA7Cf70M93l5nu7kqnMgUMdBZU8wyUuI
	RBlqeKmSQFMloBkmcClkoLdwxqhYbsNXAd722UE8Jc+Zi8St61BCrFMvQZfL1q7t0V1Bxi
	5GurTZEmgoYvrWsaoowYSAa1aSepF7I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-4kME2k5qNX6KgjlnNk48LQ-1; Thu, 12 Mar 2026 15:40:28 -0400
X-MC-Unique: 4kME2k5qNX6KgjlnNk48LQ-1
X-Mimecast-MFC-AGG-ID: 4kME2k5qNX6KgjlnNk48LQ_1773344427
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-485355493aeso9615265e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 12:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773344427; x=1773949227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjtfqezOUIGVWTT2wHYeTSUb6IpGuKrfwjpdG4ReJu0=;
        b=tOd7UzH04RB9hBWxBXQUzmgeUrxsK+sRlO/V4tBfo010SBLDxXTksvOxLLBcGXNu8v
         w7XD7VMT949X+j18L/Ruy4v1CFQzgFzyQB5+0ZDTmh4CVZpw4Dr0Tl9t7qwT2Iik0EgX
         6JdeZHAMwdbzm8KMrPb8A98sSwkH0oHu1JeBEcHVkRhcSGSiFHVNGwxWGsZvcE/6pRhL
         CyBMDjEEAbJJ4onwiLsVcFtjzz9rg7Q6P/TTHRHMyuZ1Ix5dBM02g12lWJ8XAOS8CNJT
         zrfT01ipOv5T9P0KWveYjoljHceHQ6ReleYbmBtmiMT6d2fHzHw4zSCTFkXABjZN5FZo
         Km0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344427; x=1773949227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PjtfqezOUIGVWTT2wHYeTSUb6IpGuKrfwjpdG4ReJu0=;
        b=ZhQN8plkl1+nHjSwK4BC2tMMfqIgVMuhdoA4EJlGFd2iAvD3bV34N/cmKykR21476b
         OLXX7SK0rfpkILvRslrWdWmZ89xez3uJv3cQwB28JbRd27RC5dJ2kFChu68u/Nfnz8E/
         0WlVfNq56Ul8ofw63GJFh0L9FFBNUDjGVKt+xAs4Jw6+L/RSiXtnqABi4S8XCgdW7t7s
         PwrjYcdPY1WPNm0ftyEC7BGoMTR4ioiKpIMFgDRPzkgoiCZC2UkaYI7/0BCnSPWTBtHg
         KcJnf2ktmJqBqJigd50bLr0cWZdDrDd1WLUQLQY0fya4B7aiLLdg6L29PWZWm0iatlzl
         xxRA==
X-Gm-Message-State: AOJu0YzFODJo0EpydARE+ZzjHkI0EtlTdqdv0HJlW7XAIxStSO5Zupgh
	/cqrT7ReJP9q8dkCh6cLuKoFTerX+q6WlwqFm7qa6jerwb8yo4Ycbwmuj2sbdA+ewMzheLLG+ZT
	Taqk7oiPu/qL0rQ/ADRHOjmp7FledvsdwTPcHy0UZOsaKrCUoHc6o8ytcGMNe/m6Z5NK7ZMfqBm
	gYYc01+GmB7bJgyrVWkp6JNq3sLeY8iFfUbxPcNumYMCiSh2lE/Ds=
X-Gm-Gg: ATEYQzzdH4QLpIm/O1G/U08zWGEdkbLxWr8a62EhcQ/HpWdupkBGKffIlKEM/au2oCW
	QX1cyR/A8rmUKvcvBw/ifHirQgSVKFaapheUndCv+TERirB3xYBMXuyMrOPt+8AvWICf+BX6wmJ
	W2Tc/yqkJ8R/0shgk/gY2tI99nR9X17Tvyll7EVaQ3CDfMxqwfcyVwYxqVhMfcV0ZwGL59ej3pe
	j9zY5g8GgdBSVEDk8/NGFiFl6FWKGSJAVT42rIzXhFXHh0MAYA6AWsKY9m4qHsm+/WuY/YNKBCe
	yFo7IZMus6Cd7g1b9ki0+0GE0s5W2ttSh6lhl9EEvEoei6vMoISQsj/CDvv91PGfqT1JdBTi8pG
	g5MV1NE25eUqwbHPyiZjNM9iNII0smLDv6teFf720tdqkrjTui3aM8nZUJATbY+uqGqnpx9oeUt
	NeC/c=
X-Received: by 2002:a05:600c:c8f:b0:485:3c05:24dc with SMTP id 5b1f17b1804b1-48556710c02mr8363515e9.33.1773344427079;
        Thu, 12 Mar 2026 12:40:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c8f:b0:485:3c05:24dc with SMTP id 5b1f17b1804b1-48556710c02mr8363225e9.33.1773344426491;
        Thu, 12 Mar 2026 12:40:26 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-127.pool.digikabel.hu. [176.241.63.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm396705955e9.2.2026.03.12.12.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:40:25 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v2 4/6] fuse: clean up device cloning
Date: Thu, 12 Mar 2026 20:40:02 +0100
Message-ID: <20260312194019.3077902-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312194019.3077902-1-mszeredi@redhat.com>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
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
 fs/fuse/dev.c    | 44 ++++++++++++++++----------------------------
 fs/fuse/fuse_i.h |  3 ---
 fs/fuse/inode.c  |  1 -
 3 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3adf6bd38c9b..18cc844cf290 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2543,14 +2543,15 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 
 		fuse_dev_end_requests(&to_end);
 
+		spin_lock(&fc->lock);
+		list_del(&fud->entry);
+		spin_unlock(&fc->lock);
+
 		/* Are we the last open device? */
-		if (atomic_dec_and_test(&fc->dev_count)) {
+		if (list_empty(&fc->devices)) {
 			WARN_ON(fc->iq.fasync != NULL);
 			fuse_abort_conn(fc);
 		}
-		spin_lock(&fc->lock);
-		list_del(&fud->entry);
-		spin_unlock(&fc->lock);
 		fuse_conn_put(fc);
 	}
 	fuse_dev_put(fud);
@@ -2569,24 +2570,10 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
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
@@ -2599,17 +2586,18 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
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
index b77b384b0385..92576e28f8ac 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -647,9 +647,6 @@ struct fuse_conn {
 	/** Refcount */
 	refcount_t count;
 
-	/** Number of fuse_dev's */
-	atomic_t dev_count;
-
 	/** Current epoch for up-to-date dentries */
 	atomic_t epoch;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 45abcfec03a4..e42356d60f7a 100644
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

