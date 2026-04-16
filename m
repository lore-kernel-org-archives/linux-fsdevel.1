Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC538C2A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331051; cv=none; b=aGUFONGx1giXdJthl+ioqCSu8oINs9F8ecJ9PGRd0+H5D40d3x7PzFXr/5lsuXsgU+Jk3jrrfWluKiAOENKTvObtjUVwLGmDkkymz9cg9QeXQGgvEPHiWsas3C/5ZFebBY7bqCVJRYDtefmfHdkauDGt+NSbs7zdu81cpQ5ZHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331051; c=relaxed/simple;
	bh=58emgwcwmjD5eUPgp20ccTFeKoJJGwrxbMW4Z1LiyEA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBzviG/dzsMwt/+nrDzcg43tvQRYfXzZ8+hLBcxcfg1t0G0jSwCTHC16f2KkDzertpR2W37pnphk+wlhGz7DWdzE2vb+uy3COsjuZxPxrShaaaXDad/Knu0aXz7MOUGPAjIfzIeJn9sUdsTGeCLKm2OGE6Ik4KWgZ8gaDpuKbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCxpMNhd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nsd3rNpC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCxpMNhd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nsd3rNpC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbiyLKWoF8/H48SsR/iAgHVAb5VOZJUdB63gP5Unsfo=;
	b=HCxpMNhdYM/PZHL/kdKLSL7Ut6Zbk8ykzJiNJLh8VBO5v6061o12Iv6adMCTgRmL1UiQ3P
	/7qkk7mS624/QVLQzWcQItK2Owq/wYczT/9KytGl+QdMDHjF2tjCauF+3K7wW7c1ZXOt7q
	qmKBn7wjXFHB8EAPmM1XEtJNtlj6Zmc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-0PPLmsHdPDmEWr8v5UcbgA-1; Thu, 16 Apr 2026 05:17:24 -0400
X-MC-Unique: 0PPLmsHdPDmEWr8v5UcbgA-1
X-Mimecast-MFC-AGG-ID: 0PPLmsHdPDmEWr8v5UcbgA_1776331043
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so64190565e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331042; x=1776935842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbiyLKWoF8/H48SsR/iAgHVAb5VOZJUdB63gP5Unsfo=;
        b=Nsd3rNpCqaGhKW7YmtIQWp71SmlqT34/6G1cf4OH+rExKPG/yDXxJAq4O/2uUCjPvi
         z0CAZIhJZjfqoPO6Qo0F+BeiQwM6eYH2sy0Vxw8wfTQ/WOYog0IthGanQMNfRXOWKV5f
         hQjZTE8dCpKHVF0MFC6ONbuV8BOtIjcmL8MZ3+Oji5vkSYNaL7GPxD4Shombf8FjHBUj
         TOAQ8diw56Q3tvaEM1qDPEcJJ6Vx/kuf9zk9X/Nq1vH6TY+NwpYHsS12e5br66RowL9U
         c1I+Viav+wqYgVA1XRG68RCgL8n2U46jqsq8mRus4drAgkNVakDDYf0Q277p24glEeWU
         +Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331042; x=1776935842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pbiyLKWoF8/H48SsR/iAgHVAb5VOZJUdB63gP5Unsfo=;
        b=m30ntRBiNEc6MHd5GKtbkGCcu3sFudlywNrfPZqMYSzOd0kbJqYZLG7oyQdvHQKUvR
         Oq06AGo0kpWi8ZJvF8ELgzBU6xKvk8MDHj/naVDsc2a1jsnzeRu7flllcRdFPb01Vfv0
         EmUQyEQfSNeAgrH3pw2kAERjiD7MPn+Kp3ijYB960juv+g/otghgnlxRV1cv5cYgAcaP
         ihubmq23xzheUFTTo/GGtWpeTm+DtQtHr/sYd9plk7RC0lM+yugkGYYEb2EmnWeMTxF8
         rNz2p/UmtT8qL67rpp7JgZB/yf8Wm+sBCPAikihxBTH8FA0eDu4jdPROXJWQsPx43fkH
         8rjA==
X-Forwarded-Encrypted: i=1; AFNElJ9rJP7IlL9g2sDGetWHEjHhhF/I8x5AgqMRUIC0FL5HyMGfMFEh0LW9pZTAye+R1KqGLC15a3ldG6PPrF3Q@vger.kernel.org
X-Gm-Message-State: AOJu0YymFINIINZPX5Cl/O+K+qxyAmfp4LzbSLXmOipbfM0CG3bKkOpX
	aBVOhavM9HAUbUsRiI+07WQecYVTFr1ZyGiCtRDlD80wMKQs+NIW4DoWKdsieYyp2mt1iwtXe36
	n5kbRdqZ/B0HvPIkmgvZP0L68dGCBYSSGdW0m11eGFsas73/EjNshEHDQnEfasvOeN29kKwFWQ4
	E=
X-Gm-Gg: AeBDieuFdxfPQcd311cRsUWxY498/Ic2hwlqFXKaKmE9D4BtcPQOqEZqnZ3mWfKuZWA
	8TIcBlv561T4nbrPbaolnSoCsyOxb2UeYpiwNNwHYQbC5w8mE5uvAuHTg8BC/5iyocl0eB9BHHD
	lOzLH88SrYLK0fwuakDFugHZCu7NdiHs2ibGVrAlRvXoO/wbyi/N8VnNBhJGWV8gfrg8t5dlAjd
	T4LD0TPIO9Vl7uLTIKEXVW2hbKpkAyw+Twd0A5hUw6E/HYEKLnk7BxODr9nNvFQMAqLXbYDHmKf
	hgYM5DtiWL1QsLN1g9UeZqv0fu5Ir04Pp8obOXBLN4T66WAOiMgXzUL9jYE7UW8pAv7cB38gdlR
	Hp8tqrZjv4NXPLd81FUgx/oKj0qU+Xm1GMVwaW9pBqozcO50qw+ya0BRFVgqRp7EnxtnnmcnzQ9
	8SyYfStA==
X-Received: by 2002:a05:600c:5249:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488d680577dmr334143935e9.2.1776331042197;
        Thu, 16 Apr 2026 02:17:22 -0700 (PDT)
X-Received: by 2002:a05:600c:5249:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488d680577dmr334143555e9.2.1776331041617;
        Thu, 16 Apr 2026 02:17:21 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:20 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/32] fuse: don't access transport layer structs directly from the fs layer
Date: Thu, 16 Apr 2026 11:16:38 +0200
Message-ID: <20260416091658.462783-15-mszeredi@redhat.com>
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

Add helpers (get and set functions mainly) that cleanly separate the
layers.

Remove #include "fuse_dev_i.h" from:

 - inode.c
 - file.c
 - control.c

Remove #include "dev_uring_i.h" from inode.c.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/control.c     | 13 +++-----
 fs/fuse/dev.c         | 77 ++++++++++++++++++++++++++++++++++++++++---
 fs/fuse/dev.h         | 27 +++++++++++++++
 fs/fuse/dev_uring.c   |  7 ++--
 fs/fuse/dev_uring_i.h | 11 -------
 fs/fuse/file.c        |  6 ++--
 fs/fuse/fuse_i.h      |  2 --
 fs/fuse/inode.c       | 36 ++++++++------------
 8 files changed, 124 insertions(+), 55 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 228e1e7114b7..e6f513eb7d4a 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -7,7 +7,7 @@
 */
 
 #include "fuse_i.h"
-#include "fuse_dev_i.h"
+#include "dev.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -58,7 +58,7 @@ static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
 		if (!fc)
 			return 0;
 
-		value = atomic_read(&fc->chan->num_waiting);
+		value = fuse_chan_num_waiting(fc->chan);
 		file->private_data = (void *)value;
 		fuse_conn_put(fc);
 	}
@@ -112,7 +112,7 @@ static ssize_t fuse_conn_max_background_read(struct file *file,
 	if (!fc)
 		return 0;
 
-	val = READ_ONCE(fc->chan->max_background);
+	val = fuse_chan_max_background(fc->chan);
 	fuse_conn_put(fc);
 
 	return fuse_conn_limit_read(file, buf, len, ppos, val);
@@ -130,12 +130,7 @@ static ssize_t fuse_conn_max_background_write(struct file *file,
 	if (ret > 0) {
 		struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
 		if (fc) {
-			spin_lock(&fc->chan->bg_lock);
-			fc->chan->max_background = val;
-			fc->chan->blocked = fc->chan->num_background >= fc->chan->max_background;
-			if (!fc->chan->blocked)
-				wake_up(&fc->chan->blocked_waitq);
-			spin_unlock(&fc->chan->bg_lock);
+			fuse_chan_max_background_set(fc->chan, val);
 			fuse_conn_put(fc);
 		}
 	}
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fa2d027dfa36..3858f6e59925 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -69,11 +69,12 @@ static void __fuse_put_request(struct fuse_req *req)
 	refcount_dec(&req->count);
 }
 
-void fuse_set_initialized(struct fuse_conn *fc)
+void fuse_chan_set_initialized(struct fuse_chan *fch)
 {
 	/* Make sure stores before this are seen on another CPU */
 	smp_wmb();
-	fc->chan->initialized = 1;
+	fch->initialized = 1;
+	wake_up_all(&fch->blocked_waitq);
 }
 
 static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
@@ -118,7 +119,7 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
 				(TASK_KILLABLE | TASK_FREEZABLE)))
 			goto out;
 	}
-	/* Matches smp_wmb() in fuse_set_initialized() */
+	/* Matches smp_wmb() in fuse_chan_set_initialized() */
 	smp_rmb();
 
 	err = -ENOTCONN;
@@ -338,6 +339,9 @@ void fuse_chan_release(struct fuse_chan *fch)
 
 	if (fiq->ops->release)
 		fiq->ops->release(fiq);
+
+	if (fch->timeout.req_timeout)
+		cancel_delayed_work_sync(&fch->timeout.work);
 }
 
 void fuse_chan_free(struct fuse_chan *fch)
@@ -381,6 +385,41 @@ struct fuse_chan *fuse_dev_chan_new(void)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_chan_new);
 
+unsigned int fuse_chan_num_background(struct fuse_chan *fch)
+{
+	return fch->num_background;
+}
+
+unsigned int fuse_chan_max_background(struct fuse_chan *fch)
+{
+	return READ_ONCE(fch->max_background);
+}
+
+void fuse_chan_max_background_set(struct fuse_chan *fch, unsigned int val)
+{
+	spin_lock(&fch->bg_lock);
+	fch->max_background = val;
+	fch->blocked = fch->num_background >= fch->max_background;
+	if (!fch->blocked)
+		wake_up(&fch->blocked_waitq);
+	spin_unlock(&fch->bg_lock);
+}
+
+unsigned int fuse_chan_num_waiting(struct fuse_chan *fch)
+{
+	return atomic_read(&fch->num_waiting);
+}
+
+void fuse_chan_set_fc(struct fuse_chan *fch, struct fuse_conn *fc)
+{
+	fch->conn = fc;
+}
+
+void fuse_chan_io_uring_enable(struct fuse_chan *fch)
+{
+	fch->io_uring = 1;
+}
+
 void fuse_pqueue_init(struct fuse_pqueue *fpq)
 {
 	unsigned int i;
@@ -475,6 +514,34 @@ void fuse_dev_put(struct fuse_dev *fud)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_put);
 
+bool fuse_dev_is_installed(struct fuse_dev *fud)
+{
+	struct fuse_conn *fc = fuse_dev_fc_get(fud);
+
+	return fc != NULL && fc != FUSE_DEV_FC_DISCONNECTED;
+}
+
+/*
+ * Checks if @fc matches the one installed in @fud
+ */
+bool fuse_dev_verify(struct fuse_dev *fud, struct fuse_conn *fc)
+{
+	return fuse_dev_fc_get(fud) == fc;
+}
+
+bool fuse_dev_is_sync_init(struct fuse_dev *fud)
+{
+	return fud->sync_init;
+}
+
+struct fuse_dev *fuse_dev_grab(struct file *file)
+{
+	struct fuse_dev *fud = fuse_file_to_fud(file);
+
+	refcount_inc(&fud->ref);
+	return fud;
+}
+
 static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	req->in.h.len = sizeof(struct fuse_in_header) +
@@ -2537,7 +2604,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		fc->chan->connected = 0;
 		spin_unlock(&fc->chan->bg_lock);
 
-		fuse_set_initialized(fc);
+		fuse_chan_set_initialized(fc->chan);
 		list_for_each_entry(fud, &fc->chan->devices, entry) {
 			struct fuse_pqueue *fpq = &fud->pq;
 
@@ -2596,7 +2663,7 @@ void fuse_wait_aborted(struct fuse_conn *fc)
 {
 	/* matches implicit memory barrier in fuse_drop_waiting() */
 	smp_mb();
-	wait_event(fc->chan->blocked_waitq, atomic_read(&fc->chan->num_waiting) == 0);
+	wait_event(fc->chan->blocked_waitq, fuse_chan_num_waiting(fc->chan) == 0);
 
 	fuse_uring_wait_stopped_queues(fc);
 }
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index df8a199b42d2..7994f5290252 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -11,16 +11,43 @@
 struct fuse_conn;
 struct fuse_chan;
 struct fuse_dev;
+struct file;
 
 struct fuse_chan *fuse_chan_new(void);
 struct fuse_chan *fuse_dev_chan_new(void);
 void fuse_chan_release(struct fuse_chan *fch);
 void fuse_chan_free(struct fuse_chan *fch);
+unsigned int fuse_chan_num_background(struct fuse_chan *fch);
+unsigned int fuse_chan_max_background(struct fuse_chan *fch);
+void fuse_chan_max_background_set(struct fuse_chan *fch, unsigned int val);
+unsigned int fuse_chan_num_waiting(struct fuse_chan *fch);
+void fuse_chan_set_fc(struct fuse_chan *fch, struct fuse_conn *fc);
+void fuse_chan_set_initialized(struct fuse_chan *fch);
+void fuse_chan_io_uring_enable(struct fuse_chan *fch);
+
 DEFINE_FREE(fuse_chan_free, struct fuse_chan *, if (_T) fuse_chan_free(_T))
 
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
+bool fuse_dev_verify(struct fuse_dev *fud, struct fuse_conn *fc);
 void fuse_dev_put(struct fuse_dev *fud);
+bool fuse_dev_is_installed(struct fuse_dev *fud);
+bool fuse_dev_is_sync_init(struct fuse_dev *fud);
+struct fuse_dev *fuse_dev_grab(struct file *file);
 
 void fuse_init_server_timeout(struct fuse_chan *fch, unsigned int timeout);
 
+#ifdef CONFIG_FUSE_IO_URING
+bool fuse_uring_enabled(void);
+void fuse_uring_destruct(struct fuse_chan *fch);
+#else /* CONFIG_FUSE_IO_URING */
+static inline bool fuse_uring_enabled(void)
+{
+	return false;
+}
+
+static inline void fuse_uring_destruct(struct fuse_chan *fch)
+{
+}
+#endif /* CONFIG_FUSE_IO_URING */
+
 #endif /* _FS_FUSE_DEV_H */
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 97059069316e..2c7331e49630 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2023-2024 DataDirect Networks.
  */
 
+#include "dev.h"
 #include "fuse_i.h"
 #include "dev_uring_i.h"
 #include "fuse_dev_i.h"
@@ -185,9 +186,9 @@ bool fuse_uring_request_expired(struct fuse_chan *fch)
 	return false;
 }
 
-void fuse_uring_destruct(struct fuse_conn *fc)
+void fuse_uring_destruct(struct fuse_chan *fch)
 {
-	struct fuse_ring *ring = fc->chan->ring;
+	struct fuse_ring *ring = fch->ring;
 	int qid;
 
 	if (!ring)
@@ -218,7 +219,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 
 	kfree(ring->queues);
 	kfree(ring);
-	fc->chan->ring = NULL;
+	fch->ring = NULL;
 }
 
 /*
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 8aa33f989e4c..d14299eff1dd 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -136,8 +136,6 @@ struct fuse_ring {
 	bool ready;
 };
 
-bool fuse_uring_enabled(void);
-void fuse_uring_destruct(struct fuse_conn *fc);
 void fuse_uring_stop_queues(struct fuse_ring *ring);
 void fuse_uring_abort_end_requests(struct fuse_ring *ring);
 int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
@@ -175,15 +173,6 @@ static inline bool fuse_uring_ready(struct fuse_conn *fc)
 
 #else /* CONFIG_FUSE_IO_URING */
 
-static inline void fuse_uring_destruct(struct fuse_conn *fc)
-{
-}
-
-static inline bool fuse_uring_enabled(void)
-{
-	return false;
-}
-
 static inline void fuse_uring_abort(struct fuse_conn *fc)
 {
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 64348ffbf202..11d3797ad26b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -7,7 +7,7 @@
 */
 
 #include "fuse_i.h"
-#include "fuse_dev_i.h"
+#include "dev.h"
 
 #include <linux/pagemap.h>
 #include <linux/slab.h>
@@ -903,7 +903,7 @@ static int fuse_handle_readahead(struct folio *folio,
 		ia = NULL;
 	}
 	if (!ia) {
-		if (fc->chan->num_background >= fc->congestion_threshold &&
+		if (fuse_chan_num_background(fc->chan) >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
 			/*
 			 * Congested and only async pages left, so skip the
@@ -2294,7 +2294,7 @@ static int fuse_writepages(struct address_space *mapping,
 		return -EIO;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    fc->chan->num_background >= fc->congestion_threshold)
+	    fuse_chan_num_background(fc->chan) >= fc->congestion_threshold)
 		return 0;
 
 	return iomap_writepages(&wpc);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e6c1c161214c..18fa729bfef2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1184,8 +1184,6 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc);
 int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		    struct iattr *attr, struct file *file);
 
-void fuse_set_initialized(struct fuse_conn *fc);
-
 void fuse_unlock_inode(struct inode *inode, bool locked);
 bool fuse_lock_inode(struct inode *inode);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 03da955d419d..507b50b0d631 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -8,8 +8,6 @@
 
 #include "dev.h"
 #include "fuse_i.h"
-#include "fuse_dev_i.h"
-#include "dev_uring_i.h"
 
 #include <linux/dax.h>
 #include <linux/pagemap.h>
@@ -812,8 +810,7 @@ static int fuse_opt_fd(struct fs_context *fsc, struct file *file)
 	if (file->f_cred->user_ns != fsc->user_ns)
 		return invalfc(fsc, "wrong user namespace for fuse device");
 
-	ctx->fud = file->private_data;
-	refcount_inc(&ctx->fud->ref);
+	ctx->fud = fuse_dev_grab(file);
 
 	return 0;
 }
@@ -994,7 +991,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
 	fm->fc = fc;
-	fch->conn = fc;
+	fuse_chan_set_fc(fch, fc);
 	fc->chan = fch;
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
@@ -1003,7 +1000,7 @@ static void delayed_release(struct rcu_head *p)
 {
 	struct fuse_conn *fc = container_of(p, struct fuse_conn, rcu);
 
-	fuse_uring_destruct(fc);
+	fuse_uring_destruct(fc->chan);
 	fuse_chan_free(fc->chan);
 
 	put_user_ns(fc->user_ns);
@@ -1019,8 +1016,6 @@ void fuse_conn_put(struct fuse_conn *fc)
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_conn_free(fc);
-	if (fc->chan->timeout.req_timeout)
-		cancel_delayed_work_sync(&fc->chan->timeout.work);
 	cancel_work_sync(&fc->epoch_work);
 	fuse_chan_release(fc->chan);
 	put_pid_ns(fc->pid_ns);
@@ -1253,12 +1248,13 @@ static void process_init_limits(struct fuse_conn *fc, struct fuse_init_out *arg)
 	sanitize_global_limit(&max_user_bgreq);
 	sanitize_global_limit(&max_user_congthresh);
 
-	spin_lock(&fc->chan->bg_lock);
 	if (arg->max_background) {
-		fc->chan->max_background = arg->max_background;
+		unsigned int max_background = max_background = arg->max_background;
 
-		if (!cap_sys_admin && fc->chan->max_background > max_user_bgreq)
-			fc->chan->max_background = max_user_bgreq;
+		if (!cap_sys_admin && max_background > max_user_bgreq)
+			max_background = max_user_bgreq;
+
+		fuse_chan_max_background_set(fc->chan, max_background);
 	}
 	if (arg->congestion_threshold) {
 		fc->congestion_threshold = arg->congestion_threshold;
@@ -1267,7 +1263,6 @@ static void process_init_limits(struct fuse_conn *fc, struct fuse_init_out *arg)
 		    fc->congestion_threshold > max_user_congthresh)
 			fc->congestion_threshold = max_user_congthresh;
 	}
-	spin_unlock(&fc->chan->bg_lock);
 }
 
 struct fuse_init_args {
@@ -1412,7 +1407,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 					ok = false;
 			}
 			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
-				fc->chan->io_uring = 1;
+				fuse_chan_io_uring_enable(fc->chan);
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
@@ -1438,8 +1433,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 		fc->conn_error = 1;
 	}
 
-	fuse_set_initialized(fc);
-	wake_up_all(&fc->chan->blocked_waitq);
+	fuse_chan_set_initialized(fc->chan);
 }
 
 static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
@@ -1787,9 +1781,9 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
 	if (fud) {
-		if (fuse_dev_fc_get(fud))
+		if (fuse_dev_is_installed(fud))
 			goto err_unlock;
-		if (fud->sync_init)
+		if (fuse_dev_is_sync_init(fud))
 			fc->sync_init = 1;
 	}
 
@@ -1847,9 +1841,7 @@ static int fuse_set_no_super(struct super_block *sb, struct fs_context *fsc)
 
 static int fuse_test_super(struct super_block *sb, struct fs_context *fsc)
 {
-	struct fuse_dev *fud = fsc->sget_key;
-
-	return fuse_dev_fc_get(fud) == get_fuse_conn_super(sb);
+	return fuse_dev_verify(fsc->sget_key, get_fuse_conn_super(sb));
 }
 
 static int fuse_get_tree(struct fs_context *fsc)
@@ -1895,7 +1887,7 @@ static int fuse_get_tree(struct fs_context *fsc)
 	 * Allow creating a fuse mount with an already initialized fuse
 	 * connection
 	 */
-	if (fuse_dev_fc_get(ctx->fud)) {
+	if (fuse_dev_is_installed(ctx->fud)) {
 		fsc->sget_key = ctx->fud;
 		sb = sget_fc(fsc, fuse_test_super, fuse_set_no_super);
 		err = PTR_ERR_OR_ZERO(sb);
-- 
2.53.0

