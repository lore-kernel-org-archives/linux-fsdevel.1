Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECC39B483
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331054; cv=none; b=N1EFbRbwAsMBhBeeWXq5pEPY8a3W4a4F18wyiBTBp9vTE6rxPnBFxUDSIcD6k9AxIxHkPCaJTWU3GFbXrWpCNmZCJpqtetdH3wHogMef3CR0gc0HqCoosgo1XxZ+K8lAkY8XoDGzaPQF2jCQzuZ9wpj8uBevDuUAG+IauX1MiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331054; c=relaxed/simple;
	bh=HVSJxOtwKFYvRwjnDlO+jnkg+JmABr9oU+j8w/idV7Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9MG+PnaGeHY1cyxgaG85oNzfhGpIV/pQVF9KGLwJfaCk5aJ+um9lb+NkyGYlsCT8NfBsMJkOzwyo6WniW6wa5eCn7wzF9K+DR8rTy2O3miPx4f6VVbryrQD1nvHFjY9bETw9pEET4xbPWG9kxKKTmhnJV3/qyPsAHYnvvrqsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmJr7aeM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEUMHKCe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmJr7aeM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEUMHKCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4dfb7ebiQqTklkwuTWUNTQNMxpyNspY9sJYDq8fi3Q=;
	b=OmJr7aeM5tv1LoGg8hhcG3WjJZMK9RBUKqFiM62c8DmX52LTTpHnDZNUAfrUFn7uI04dC0
	Dh/Wli6sVH3dSe9h193Src1bs5wxPtUtsboizkPZDF/u5sm5fMhuBbpr53K6fXncSODrLs
	GM4lg8eeVEh27g7H5V7JTY6np3O8K+c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-n3qtGrwaNiKJ6pfNipwoxw-1; Thu, 16 Apr 2026 05:17:27 -0400
X-MC-Unique: n3qtGrwaNiKJ6pfNipwoxw-1
X-Mimecast-MFC-AGG-ID: n3qtGrwaNiKJ6pfNipwoxw_1776331047
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c213b485so55854215e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331046; x=1776935846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4dfb7ebiQqTklkwuTWUNTQNMxpyNspY9sJYDq8fi3Q=;
        b=fEUMHKCeFo+RtVDARfPsy3ra+2DSeXUx2eh5pfQ3BIOB0avLbHICBCbd6Oy49UWvdD
         il/ABE3UWPrcC/G/AyR6H7f3N3/kN2xNXAGJxzVcqyemEgcd6sHgnsMFkYGmjGQni8iz
         2QYUHfVeoGKafJ4itQYvSnYhQgfd9WBLQ/bQjCv5qfLRwmI700Aur1n1zToj+QMJNS2L
         LHqXBGinw9LNIHUo5hRajlxccn+ix3WhB+ICszg9ykVFGkMmT7dYxrQG8umsjMEjbfmq
         zdlcZnuBEBPjhrVlUlGm9J0ENDR3jlZRJO+Fc2k2hafNF7+zdXaMp6FU8L9t90EtQcVZ
         aT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331046; x=1776935846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p4dfb7ebiQqTklkwuTWUNTQNMxpyNspY9sJYDq8fi3Q=;
        b=iNw+mO1vHmakKON/JdePafjnw2nmIRxvphTkW778JhnPlsHjA6HQIXdnWAujBmBTP2
         MKi1JFSCQrHigPVXj1C+m30G8qxKafKSGWnlHESxE0MJeP4EGVv5r4u4Uc2Well1oWpq
         DYatoXM3F6QOp9DCFOcdNIeNfWlh2hGqEoNFChRNs9lEqjtT5qJN6Id+Ed1Sm347RaQG
         n1mIE3GNcd1eEAI5aMxiVTKMYGaZzgFbyVdgWs3KxOGM5bi6y3SUcFSBtGOv8LmI1TUk
         qZZ8WfRrk0JYQsPQ1/DbK10x4o+boMWAXnM05bL4ydc73tVTkVplXGXO6LisWBc1TiW2
         Jofg==
X-Forwarded-Encrypted: i=1; AFNElJ8y3R+ExNdEpSGsV9cAJx98N7JUR2jlPTvm1xdgXwP0kJuEcbWn6b7vG3ptQqnIHHEFleRzoKqd8jQrgSet@vger.kernel.org
X-Gm-Message-State: AOJu0YyRAcfx6jqBS1lAnx9mMtfwIB5TrN7P2RwFgrGAhROnNjXv4sA4
	ZZawHnN2VSULy38j/+KoS/TqW7/Hxb7J0uu7zfZeR9A1OyMlSZcFirpS+EDJAXASdCdr68hFG0r
	fhYUYttyTj7oYu3yneugMmlrE0ZAUrTg+MRqApGXYbcyqgdeJonDXi0/SRcpdh1tTPAZY0R6imC
	Q=
X-Gm-Gg: AeBDieuqS6s2DOe/eO7UaJ4eNUwEvF0Ojh97al5vzdN7zA1pOBB55OJH9Cn0BN95fvp
	3E3V6bJFOG3mOu9Yg3N2mahgVicHJ8ZGsZx0sJnFOtkm8tiwxRpT1jqbOnJcnqnUsyc4JQ/zfAA
	XShL9Vv09/oHq70WvUV8ueqVIC10DUbb8rJMSm83g9LqqZHlw2aXQ7L/fOwtybgUnP84MEbl3bo
	t5xT6Fjxt/YklrRfSgkaZjUM+xN2WzozuWs7mWXqHYOR+6HNQRYIyPCdgwZ99Ovc0AR6PH479HC
	pvPS/9x9/C1j04VR7ZcPdO1WYI2LoEgQNosxqyIW/d1JZ++Oq2bD9KSOnssYta0gIO88tCW4FTE
	16WhXmvrMQ5sy7iorCOCh/X0+N4cyhtr8c8pLRzNlsgelatrD/71rOpQ13DXFG/K85S6IOd+cuo
	NUpiTrIQ==
X-Received: by 2002:a05:600c:c0dc:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-488d68105d2mr242801555e9.11.1776331046231;
        Thu, 16 Apr 2026 02:17:26 -0700 (PDT)
X-Received: by 2002:a05:600c:c0dc:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-488d68105d2mr242801285e9.11.1776331045739;
        Thu, 16 Apr 2026 02:17:25 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:24 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/32] fuse: remove #include "fuse_i.h" from "dev_uring_i.h"
Date: Thu, 16 Apr 2026 11:16:41 +0200
Message-ID: <20260416091658.462783-18-mszeredi@redhat.com>
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

Start getting rid of fs layer stuff from transport layer files.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c         |  8 ++++----
 fs/fuse/dev_uring_i.h | 19 +++++++++----------
 fs/fuse/fuse_dev_i.h  |  4 ++++
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8096c861e853..fadad23e8369 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -82,7 +82,7 @@ void fuse_chan_set_initialized(struct fuse_chan *fch)
 static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
 {
 	return !fc->chan->initialized || (for_background && fc->chan->blocked) ||
-	       (fc->chan->io_uring && fc->chan->connected && !fuse_uring_ready(fc));
+	       (fc->chan->io_uring && fc->chan->connected && !fuse_uring_ready(fc->chan));
 }
 
 static void fuse_drop_waiting(struct fuse_conn *fc)
@@ -876,7 +876,7 @@ static int fuse_request_queue_background(struct fuse_req *req)
 	__set_bit(FR_ISREPLY, &req->flags);
 
 #ifdef CONFIG_FUSE_IO_URING
-	if (fuse_uring_ready(fc))
+	if (fuse_uring_ready(fc->chan))
 		return fuse_request_queue_background_uring(fc, req);
 #endif
 
@@ -2660,7 +2660,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		 * fc->chan->lock must not be taken to avoid conflicts with io-uring
 		 * locks
 		 */
-		fuse_uring_abort(fc);
+		fuse_uring_abort(fc->chan);
 	} else {
 		spin_unlock(&fc->chan->lock);
 	}
@@ -2673,7 +2673,7 @@ void fuse_wait_aborted(struct fuse_conn *fc)
 	smp_mb();
 	wait_event(fc->chan->blocked_waitq, fuse_chan_num_waiting(fc->chan) == 0);
 
-	fuse_uring_wait_stopped_queues(fc);
+	fuse_uring_wait_stopped_queues(fc->chan);
 }
 
 int fuse_dev_release(struct inode *inode, struct file *file)
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index d14299eff1dd..741fdead2161 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -7,7 +7,6 @@
 #ifndef _FS_FUSE_DEV_URING_I_H
 #define _FS_FUSE_DEV_URING_I_H
 
-#include "fuse_i.h"
 #include "fuse_dev_i.h"
 
 #ifdef CONFIG_FUSE_IO_URING
@@ -144,9 +143,9 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req);
 bool fuse_uring_remove_pending_req(struct fuse_req *req);
 bool fuse_uring_request_expired(struct fuse_chan *fch);
 
-static inline void fuse_uring_abort(struct fuse_conn *fc)
+static inline void fuse_uring_abort(struct fuse_chan *fch)
 {
-	struct fuse_ring *ring = fc->chan->ring;
+	struct fuse_ring *ring = fch->ring;
 
 	if (ring == NULL)
 		return;
@@ -157,31 +156,31 @@ static inline void fuse_uring_abort(struct fuse_conn *fc)
 	}
 }
 
-static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
+static inline void fuse_uring_wait_stopped_queues(struct fuse_chan *fch)
 {
-	struct fuse_ring *ring = fc->chan->ring;
+	struct fuse_ring *ring = fch->ring;
 
 	if (ring)
 		wait_event(ring->stop_waitq,
 			   atomic_read(&ring->queue_refs) == 0);
 }
 
-static inline bool fuse_uring_ready(struct fuse_conn *fc)
+static inline bool fuse_uring_ready(struct fuse_chan *fch)
 {
-	return fc->chan->ring && fc->chan->ring->ready;
+	return fch->ring && fch->ring->ready;
 }
 
 #else /* CONFIG_FUSE_IO_URING */
 
-static inline void fuse_uring_abort(struct fuse_conn *fc)
+static inline void fuse_uring_abort(struct fuse_chan *fch)
 {
 }
 
-static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
+static inline void fuse_uring_wait_stopped_queues(struct fuse_chan *fch)
 {
 }
 
-static inline bool fuse_uring_ready(struct fuse_conn *fc)
+static inline bool fuse_uring_ready(struct fuse_chan *fch)
 {
 	return false;
 }
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 2e1c251572ca..fd1ccc8df60d 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -8,6 +8,10 @@
 
 #include <linux/fuse.h>
 #include <linux/types.h>
+#include <linux/refcount.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+#include <linux/fs.h>
 
 /* Ordinary requests have even IDs, while interrupts IDs are odd */
 #define FUSE_INT_REQ_BIT (1ULL << 0)
-- 
2.53.0

