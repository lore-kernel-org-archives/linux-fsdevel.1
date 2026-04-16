Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B884399340
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331035; cv=none; b=B6pOJ/dQAscsi/rg7ZhgHvAkwYtH4P/AekGqvUGuFMCcovMYQEjE4hGr/jOEAAvAHPa2DHgU9qxH3PZ18XxGz/mZtYDjE+OqHO57B1F/DI7O2NAdtaJmpcKJhxVz8dR3mtYTXjhJ+WYPOgayTwDhodHrVE9TcL/Mf5rc7UBwiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331035; c=relaxed/simple;
	bh=rAnPPcyPamLpsP8P2z3a5DcysXm50OUQu3dnhoT+U7g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcqeAb6PUV6F4/w0ivo1IYjwK5qKMtr5nC+88qHlqix4HiRxPegmay/JneuTZd1T+9C6ghF7hwjUkZweVIaIAEHa2/Z8goNaGDGh4IpjZJMuw47GslkZq1TrPjEF+ZqVCG/tL8zTbmGIj/b8svVO3m8JNcSZCylQbhHYG6pO0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMDmb6ow; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciqJAqQy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMDmb6ow";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciqJAqQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/2Y6IiaO/mUP1Nrl4o6z/uHOOkkwviI1kk8jZeRPsk=;
	b=NMDmb6owuG/KAPaMYQ1epr3vLsUVsFjuBm0gaOojbpvSQzUsawjCoFlqd+8Tylkp/zfNNT
	X74MWeZAb+adGOfeGu84o8NDZMlx8WvfYdHtk/B1YlnPrUTBHIZXV8uIJDY6BpjrlMBafr
	QS/qxAxLJpSbR+VtuZv+CWR3lHRvshM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-3BM7h2hGP9qLJvkRhcJKoQ-1; Thu, 16 Apr 2026 05:17:10 -0400
X-MC-Unique: 3BM7h2hGP9qLJvkRhcJKoQ-1
X-Mimecast-MFC-AGG-ID: 3BM7h2hGP9qLJvkRhcJKoQ_1776331029
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488cc31ea57so50132005e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331029; x=1776935829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/2Y6IiaO/mUP1Nrl4o6z/uHOOkkwviI1kk8jZeRPsk=;
        b=ciqJAqQyOfev4QjAGZhAMTZTFIVyKIuDgUBeti6owP16n7rfVguqQ1voS6rVJnOguK
         8pyILsi+9151x8zlg98Mf7Tm3+ihgTPsJ2gKpdtQT0t2WRluMzKFcxeCojREi7UcCeGH
         aIDVEfwSb+woLwHYWBjv4pvJL9XmH3m3Ga7PhoREZ7Br+1aEl2mInEFseMMghs/3jZY7
         91Zo518vdB6yFqxvBXAORY9ich8YVwS6gOMrI3xA6CBDjPbjO2SIbWgBzocN22MEEvtX
         ygP1VjdRd3HcobAEZSkZpGnAppk8pr3HlZQf/L2kiBTO99q+ovctc9/J43RF6CWYQDkt
         HbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331029; x=1776935829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W/2Y6IiaO/mUP1Nrl4o6z/uHOOkkwviI1kk8jZeRPsk=;
        b=jprME4XPXVdE5b0SKoYnyhVFWMXXKDpnURhXb3DZUKeDLi10WPUD1uPAFB+VURpRd3
         QEHgNDv4Zr3eOKj+HKxn8f9suw7VmxAEjIOKc3Gy8M5L0qDNFPAiZD4b+z41jwZGXcZ8
         HJ0FOYNS5tVa7jo5HwLj0d30o9uGskr5FxPqj86ttX7zYSq3a8AFYnmVONuSS/teJ/uW
         Pp6W3Vtvnq6h9OsOO/z45VeeuW+B83xY0+FsGs8XgeRor2ntUbFfpIFqPKdeIj0jWBR8
         sZjrt31ia83Lkcr1mol2HSm5qCvhtcVdrXuLA0iG5q1vWFY2fNTTEgjfhgVYKGdU4KCN
         Rhfg==
X-Forwarded-Encrypted: i=1; AFNElJ9peqSdFslC+CZhQkbDrUu325KqVbU2XPTX8x/8h8dADNFQ+Sqzb2iePgmM35Ilje9bt41wMy1TdS9Akrno@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3T5MfYtbagSB49ujWVsLjzy/XPnnj0e7JFoI9HWfaM0iMSVh
	3/X5o+3DZofW+9PE1JiW0hCfDqesec6AOp/aifSb1Jmg0fcmMZEFWrAHX/uG4PfjRXU05P0av2p
	NJYJ2Xizz9QMvE7lhRZ44d0TIqqwOV60/h+e4xb6HlWyh3OP3L0DJ+/L/g8rc4hRvKqfK7YfHHH
	M=
X-Gm-Gg: AeBDiet89aHlRJ5AkHXchUfn0U1rRMQr5VjKHcp4+HhDUTAO8Zn21ptb1aN+DUu3/o+
	ykLlqrszAwDRYFnyxImkQh29WiJFRGKsCziF9zejSyOEhijL1GxhOw+I+xFYrXLdiWoHGH3zAF9
	4PJ+E/Opg15TAOqKZ54BVzZyvoRltKzeODtZYP+7liIpbxBBsd6POEGuQ44Nk2aiZAQ03dek2DZ
	Rdatpx5p1cb/IY54RwzLk3kyfQRCFzOBAB7Y5a8OYF8TewbrFrZJlIKq605a5Xxwt5yoCnMNusN
	yfRJoCAVBdQFccKWUj+Uc4zDF9RG+KZn3dt9Qc/gRg75YfwVKP9Ibp96Fj2Zd5lXrFXx3brl6K8
	VmzMTZFfnU4Og1ZeCptMuCg9WbC1K+a6ZcdsTN2HOdhmbwgfaH+XhxEbFp5v9galvZnBfB21JNW
	52jhpMCA==
X-Received: by 2002:a05:600c:8b27:b0:488:b1c7:b432 with SMTP id 5b1f17b1804b1-488d6881e82mr326551365e9.24.1776331028878;
        Thu, 16 Apr 2026 02:17:08 -0700 (PDT)
X-Received: by 2002:a05:600c:8b27:b0:488:b1c7:b432 with SMTP id 5b1f17b1804b1-488d6881e82mr326550895e9.24.1776331028421;
        Thu, 16 Apr 2026 02:17:08 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:07 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/32] fuse: move 'devices' member from fuse_conn to fuse_chan
Date: Thu, 16 Apr 2026 11:16:29 +0200
Message-ID: <20260416091658.462783-6-mszeredi@redhat.com>
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

This belongs in the transport layer.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c         | 17 ++++++++++++-----
 fs/fuse/fuse_dev_i.h  |  5 ++++-
 fs/fuse/fuse_i.h      |  3 ---
 fs/fuse/inode.c       |  2 --
 fs/fuse/req_timeout.c |  2 +-
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 416c144c6e0d..18bad9089917 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -342,13 +342,20 @@ void fuse_chan_release(struct fuse_chan *fch)
 
 void fuse_chan_free(struct fuse_chan *fch)
 {
+	WARN_ON(!list_empty(&fch->devices));
 	kfree(fch);
 }
 EXPORT_SYMBOL_GPL(fuse_chan_free);
 
 struct fuse_chan *fuse_chan_new(void)
 {
-	return kzalloc_obj(struct fuse_chan);
+	struct fuse_chan *fch = kzalloc_obj(struct fuse_chan);
+	if (!fch)
+		return NULL;
+
+	INIT_LIST_HEAD(&fch->devices);
+
+	return fch;
 }
 EXPORT_SYMBOL_GPL(fuse_chan_new);
 
@@ -417,7 +424,7 @@ void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
 		 */
 		fc->connected = 0;
 	} else {
-		list_add_tail(&fud->entry, &fc->devices);
+		list_add_tail(&fud->entry, &fc->chan->devices);
 		fuse_conn_get(fc);
 	}
 	spin_unlock(&fc->lock);
@@ -2046,7 +2053,7 @@ static void fuse_resend(struct fuse_conn *fc)
 		return;
 	}
 
-	list_for_each_entry(fud, &fc->devices, entry) {
+	list_for_each_entry(fud, &fc->chan->devices, entry) {
 		struct fuse_pqueue *fpq = &fud->pq;
 
 		spin_lock(&fpq->lock);
@@ -2519,7 +2526,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		spin_unlock(&fc->bg_lock);
 
 		fuse_set_initialized(fc);
-		list_for_each_entry(fud, &fc->devices, entry) {
+		list_for_each_entry(fud, &fc->chan->devices, entry) {
 			struct fuse_pqueue *fpq = &fud->pq;
 
 			spin_lock(&fpq->lock);
@@ -2605,7 +2612,7 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 		spin_lock(&fc->lock);
 		list_del(&fud->entry);
 		/* Are we the last open device? */
-		last = list_empty(&fc->devices);
+		last = list_empty(&fc->chan->devices);
 		spin_unlock(&fc->lock);
 
 		if (last) {
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index e80409c2f496..459f37ece46a 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -90,6 +90,9 @@ struct fuse_iqueue {
 struct fuse_chan {
 	/** Input queue */
 	struct fuse_iqueue iq;
+
+	/** List of device instances belonging to this connection */
+	struct list_head devices;
 };
 
 #define FUSE_PQ_HASH_BITS 8
@@ -125,7 +128,7 @@ struct fuse_dev {
 	/** Processing queue */
 	struct fuse_pqueue pq;
 
-	/** list entry on fc->devices */
+	/** list entry on fch->devices */
 	struct list_head entry;
 };
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fd5f741693ca..6185b97df106 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -835,9 +835,6 @@ struct fuse_conn {
 	 */
 	struct rw_semaphore killsb;
 
-	/** List of device instances belonging to this connection */
-	struct list_head devices;
-
 #ifdef CONFIG_FUSE_DAX
 	/* Dax mode */
 	enum fuse_dax_mode dax_mode;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ac6a0b736fb9..4d958c53900f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -982,7 +982,6 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	init_waitqueue_head(&fc->blocked_waitq);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
-	INIT_LIST_HEAD(&fc->devices);
 	atomic_set(&fc->num_waiting, 0);
 	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
@@ -1543,7 +1542,6 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
 
 void fuse_free_conn(struct fuse_conn *fc)
 {
-	WARN_ON(!list_empty(&fc->devices));
 	kfree(fc);
 }
 EXPORT_SYMBOL_GPL(fuse_free_conn);
diff --git a/fs/fuse/req_timeout.c b/fs/fuse/req_timeout.c
index 5357a2d63b3f..ca44a7940174 100644
--- a/fs/fuse/req_timeout.c
+++ b/fs/fuse/req_timeout.c
@@ -94,7 +94,7 @@ static void fuse_check_timeout(struct work_struct *work)
 		spin_unlock(&fc->lock);
 		return;
 	}
-	list_for_each_entry(fud, &fc->devices, entry) {
+	list_for_each_entry(fud, &fc->chan->devices, entry) {
 		fpq = &fud->pq;
 		spin_lock(&fpq->lock);
 		if (fuse_request_expired(fc, &fpq->io) ||
-- 
2.53.0

