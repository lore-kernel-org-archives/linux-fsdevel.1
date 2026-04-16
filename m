Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CBC39B946
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331077; cv=none; b=d487+n+DgxZvzn+buSNiGhZP1YRXHUw0t+IQ0xylYoNO1HJGSr2MDWAcZWCDIQr1zHklGapEmkCRatt9RPFT1HPEJBFxvE2u2eaN2D9HN5fpLODIoAFoEaY2iC1S4vk7xXXV+LN7RvDNy9d74iH51ZYCyuu/t/j+hXXR6E+wJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331077; c=relaxed/simple;
	bh=+YTWH/lZVvfoLr0apXjAfpemYjGoHnEqjfudUq5/hSw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYyWLc8lJJ9ZWMBb0XeokPBaciiUKbOYieJa0CUlY+XiMS0ihsUuurf+8etY78ehpGraEzdzmntBIF5Bc6uToS72bXrx8XiZzMhjY3Radvzm0H7eSCRsEb0ut9BXp1lx7uwlwZIjUt4A4UXYOx12yYH07/91ofyTbJH53miWexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mlg4fboq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRZFRK8E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mlg4fboq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRZFRK8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzSqfcyXD4ximg6Y76NRYLAOye4Lg+D8CbgnM6EyGMI=;
	b=Mlg4fboqkNYAEDsReEEWGxZL46Qd0G8BVPUcdICbwV5tQ8suwteVAoaww5uOujkbGFrFoS
	E6eqblDPZAiEJHXQce6s94C4SMQWt+qNKs2HuURz9dS33eZWhAaA667QGpp/R3jzlnngr5
	gCkDjYr0v1cnc1DK6UgEkvA4k64IOcI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-fnOtdXVjO0esAQ4-cXEYeA-1; Thu, 16 Apr 2026 05:17:45 -0400
X-MC-Unique: fnOtdXVjO0esAQ4-cXEYeA-1
X-Mimecast-MFC-AGG-ID: fnOtdXVjO0esAQ4-cXEYeA_1776331064
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488dcff87b7so34578425e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331064; x=1776935864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzSqfcyXD4ximg6Y76NRYLAOye4Lg+D8CbgnM6EyGMI=;
        b=IRZFRK8EjJXwZyeIuJxQ/tPHlRST16Z9hzsYblQniUuIeZjG49WdlwWXlKKFHB72V7
         QWKK6tIzLqD/mX5Aoen4VjNKBiMG10CzUai3guiC492ptWX+sdvhQVQk+NNxg1Nl0FTm
         xg4bGds0Lu+F1drqytmeSWS7FzXIOvR9wdBbvxgmAUdnyl5sLT4grTPYyb2z8m798Ysl
         BELvtbdAgJK9gW9OE9V25Xilp3fqez6uSFIQ04HO1eVVWDza5dqXRdwJ7gAZuW86tWRQ
         0DPYDgzU7udve8kV1MNTQerLCxUJDlOzaL3ULwbWsaWyNC7NwFSLOIEiFNVHwH54aUEq
         X8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331064; x=1776935864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uzSqfcyXD4ximg6Y76NRYLAOye4Lg+D8CbgnM6EyGMI=;
        b=R/hftZaI2uwysw4cRaxhF707+/M6htZiCJAJKRsWbqv9Mk6vvC+NsRSj6f/x+G3Pkp
         1RJlMu9ZUnRE5SRhX6RxjRHgmRR2NgehuyK+sMWezTP7CQkFCaz0I/2JXHOtDYG79KhP
         QAq1SG0roCG2V3Q5NYKpxYVKmYlHS1xOE78MFvxEIPZe1mYu7ATOUHX5SZNCl6nh5cP4
         RJ6KKlZna5yIGIswPGZI3ixyshIbUIOli7azZpJSqDAZ2mQzZdEVD1kVdUEZHGM7oxpE
         +w1sILjuhtQprcXVmM28w5CwSYDkmg/iyI5ZOcfXVbzrsGK49KdwCsr6Y1IDTq8G7OC0
         Y2DA==
X-Forwarded-Encrypted: i=1; AFNElJ/d/srfNi5Tm3Un3c7B6ZZ4VS1HDN2EiYl8KbshouaeJPhBoBwcZnKLkp+uBSvO2hm35YNbuaIMJ5IvJLwx@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXtGDI6S4GWTDo3IDE6uWegwWvS4aGarUMsi5TQziMe+7zQPo
	LcfOO0FD7YKcUKS7vtkHQQ0nGoK3yTJPtssedMyGZKC3wM2QAbKcIHlNo7UBSiCxrKbVjthn21K
	AJhEZx1BkdNAF4Gy1Ju9W1MpAEAC/kuhpuD2Af0+7zeNufmMcLeMsZUk1Q6ST3R1qHAk=
X-Gm-Gg: AeBDieskCeVwVEgASBxra8TGex5Mc74X1xUWlX+xlssXoicnATugCVe8LZtN2LqZ8XL
	jd9/qLBGfO1SKC2vIu9dJhr4DI0Qw2gUvrW0mxBJSuz57m0KogWE1GM4ILV/cej43RVlmvPW9TU
	AF36Y8KvJKP6GAI/2Vs74V7fIs0XTFWY1yKALnshQ3z/nu0SUadmDYQ+5eQe/q2tuVc5x+mwZb3
	rtHtJYkthE5GZJAOCeWyFnZnOlV6BUYkIMcAmyShRoEbaPdd81Vsbvc5tdEbPoVUdMu/9Pq2k6j
	oZH2eOW47HiWFFLWAxGKajAzZkU12tWJ8UnSioe4RCS11XHB1VofkbZzcQRN8Ci4gCAtL0biGnF
	t7aZLGYPX0KT/0PDprBRA33wp2wkatQtC8aqEDpulmenbkPix75hVImnxaJM27zAlw7XU0xeW4h
	HVy0UBfg==
X-Received: by 2002:a05:600c:45ce:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-488d6890c9dmr345487115e9.28.1776331064048;
        Thu, 16 Apr 2026 02:17:44 -0700 (PDT)
X-Received: by 2002:a05:600c:45ce:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-488d6890c9dmr345486675e9.28.1776331063538;
        Thu, 16 Apr 2026 02:17:43 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:42 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 31/32] fuse: alloc pqueue before installing fch in fuse_dev
Date: Thu, 16 Apr 2026 11:16:55 +0200
Message-ID: <20260416091658.462783-32-mszeredi@redhat.com>
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

Prior to this patchset, fuse_dev (containing fuse_pqueue) was allocated on
mount.  But now fuse_dev is allocated when opening /dev/fuse, even though
the queues are not needed at that time.

Delay allocation of the pqueue (4k worth of list_head) just before mounting
or cloning a device.

Various distributions (e.g. Debian/Fedora) configure /dev/fuse as world
writable, so the pqueue allocation should be deferred to a privileged
operation (mount) to prevent unprivileged userspace from consuming pinned
kernel memory.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c        | 75 +++++++++++++++++++++++++++++++++-----------
 fs/fuse/fuse_dev_i.h |  3 ++
 2 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index d6cd066a3fff..6fbe6084c5ae 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -328,6 +328,7 @@ void fuse_chan_release(struct fuse_chan *fch)
 void fuse_chan_free(struct fuse_chan *fch)
 {
 	WARN_ON(!list_empty(&fch->devices));
+	kfree(fch->pq_prealloc);
 	kfree(fch);
 }
 EXPORT_SYMBOL_GPL(fuse_chan_free);
@@ -354,15 +355,30 @@ struct fuse_chan *fuse_chan_new(void)
 }
 EXPORT_SYMBOL_GPL(fuse_chan_new);
 
+static struct list_head *fuse_pqueue_alloc(void)
+{
+	struct list_head *pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
+
+	if (pq) {
+		for (int i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+			INIT_LIST_HEAD(&pq[i]);
+	}
+	return pq;
+}
+
 struct fuse_chan *fuse_dev_chan_new(void)
 {
-	struct fuse_chan *fch = fuse_chan_new();
+	struct fuse_chan *fch __free(kfree) = fuse_chan_new();
 	if (!fch)
 		return NULL;
 
+	fch->pq_prealloc = fuse_pqueue_alloc();
+	if (!fch->pq_prealloc)
+		return NULL;
+
 	fuse_iqueue_init(&fch->iq, &fuse_dev_fiq_ops, NULL);
 
-	return fch;
+	return no_free_ptr(fch);
 }
 EXPORT_SYMBOL_GPL(fuse_dev_chan_new);
 
@@ -403,39 +419,42 @@ void fuse_chan_io_uring_enable(struct fuse_chan *fch)
 
 void fuse_pqueue_init(struct fuse_pqueue *fpq)
 {
-	unsigned int i;
-
 	spin_lock_init(&fpq->lock);
-	for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
-		INIT_LIST_HEAD(&fpq->processing[i]);
 	INIT_LIST_HEAD(&fpq->io);
 	fpq->connected = 1;
+	fpq->processing = NULL;
 }
 
-struct fuse_dev *fuse_dev_alloc(void)
+static struct fuse_dev *fuse_dev_alloc_no_pq(void)
 {
 	struct fuse_dev *fud;
-	struct list_head *pq;
 
 	fud = kzalloc_obj(struct fuse_dev);
 	if (!fud)
 		return NULL;
 
 	refcount_set(&fud->ref, 1);
-	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
-	if (!pq) {
-		kfree(fud);
-		return NULL;
-	}
-
-	fud->pq.processing = pq;
 	fuse_pqueue_init(&fud->pq);
 
 	return fud;
 }
+
+struct fuse_dev *fuse_dev_alloc(void)
+{
+	struct fuse_dev *fud __free(kfree) = fuse_dev_alloc_no_pq();
+	if (!fud)
+		return NULL;
+
+	fud->pq.processing = fuse_pqueue_alloc();
+	if (!fud->pq.processing)
+		return NULL;
+
+	return no_free_ptr(fud);
+}
 EXPORT_SYMBOL_GPL(fuse_dev_alloc);
 
-void fuse_dev_install(struct fuse_dev *fud, struct fuse_chan *fch)
+static void fuse_dev_install_with_pq(struct fuse_dev *fud, struct fuse_chan *fch,
+				     struct list_head *pq)
 {
 	struct fuse_chan *old_fch;
 
@@ -453,20 +472,33 @@ void fuse_dev_install(struct fuse_dev *fud, struct fuse_chan *fch)
 		 *  - it was set to disconneted
 		 */
 		fch->connected = 0;
+		kfree(pq);
 	} else {
+		if (pq) {
+			WARN_ON(fud->pq.processing);
+			fud->pq.processing = pq;
+		}
 		list_add_tail(&fud->entry, &fch->devices);
 		fuse_conn_get(fch->conn);
 		wake_up_all(&fuse_dev_waitq);
 	}
 	spin_unlock(&fch->lock);
 }
+
+void fuse_dev_install(struct fuse_dev *fud, struct fuse_chan *fch)
+{
+	struct list_head *pq = fch->pq_prealloc;
+
+	fch->pq_prealloc = NULL;
+	fuse_dev_install_with_pq(fud, fch, pq);
+}
 EXPORT_SYMBOL_GPL(fuse_dev_install);
 
 struct fuse_dev *fuse_dev_alloc_install(struct fuse_chan *fch)
 {
 	struct fuse_dev *fud;
 
-	fud = fuse_dev_alloc();
+	fud = fuse_dev_alloc_no_pq();
 	if (!fud)
 		return NULL;
 
@@ -1632,7 +1664,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
 static int fuse_dev_open(struct inode *inode, struct file *file)
 {
-	struct fuse_dev *fud = fuse_dev_alloc();
+	struct fuse_dev *fud = fuse_dev_alloc_no_pq();
 
 	if (!fud)
 		return -ENOMEM;
@@ -2231,6 +2263,7 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 {
 	int oldfd;
 	struct fuse_dev *fud, *new_fud;
+	struct list_head *pq;
 
 	if (get_user(oldfd, argp))
 		return -EFAULT;
@@ -2254,7 +2287,11 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 	if (fuse_dev_chan_get(new_fud))
 		return -EINVAL;
 
-	fuse_dev_install(new_fud, fud->chan);
+	pq = fuse_pqueue_alloc();
+	if (!pq)
+		return -ENOMEM;
+
+	fuse_dev_install_with_pq(new_fud, fud->chan, pq);
 
 	return 0;
 }
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 3d945b20f8d5..f9364d4103d4 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -248,6 +248,9 @@ struct fuse_chan {
 	/* Maximum number of pages that can be used in a single request */
 	unsigned int max_pages;
 
+	/* Before being installed into fud, contains the preallocated pq array*/
+	struct list_head *pq_prealloc;
+
 	/** Connection aborted via sysfs, respond with ECONNABORTED on device I/O */
 	bool abort_with_err;
 
-- 
2.53.0

