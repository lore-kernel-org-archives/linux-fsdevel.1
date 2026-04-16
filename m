Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9A39B483
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331069; cv=none; b=oq2/3/58nAOuFVwRSy3ihHW1IWym8wsul0mfz8YqJrXZLws16crdDecL1rdNDpsmSMxLLeGNnEUbk3n1UScwZcKmOA3jf9rWssh2a5mdxTS3XX7gaj+59v0svaBy2WX/et+Sab5Gzoxo4DvbcCsqqiXmg+1CbWFIR+Jl5Mou5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331069; c=relaxed/simple;
	bh=O+4KVlniXvNGSYZZLt4N6YZeHsDhERRbEOLrDosZqwY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WInzwz+JawoK5u4e9LQml5oLttd+sXMFUqVQMkXkpCu6+FgistFLO/eNEtzlwVdiBUy4DREADjHVE+0MB7zqwLvuIkz1XaNL4GEoV+8Mqau0EMgNyh7YxW+xJsWsgpSwoVRq7eaZhXklDlWYkXUfbf2Tqv2oNGk918KGLKqicbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpFxhe7I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPKC1nbb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpFxhe7I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPKC1nbb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tyd3skm6Msy+AniTzISQ/tVZvLyvz28Fd5IlGdI+aJk=;
	b=BpFxhe7ITm7sISTT8ZzVQLpe+Hbl4PLymtM2vyYu/TK1oSkG3vLlyDG6fDhyqICtgMTHS/
	pfQhksi467pkajKmj43uWPzUlKbJSYLM4IIkZfqwoChulGu9g2+t5KHlXQn7RupIKxau6D
	MUwtAkENU4Du1GKB8WKWINZoY3x1aXM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-Xwy3L-gFM5KYlk_IywL1mg-1; Thu, 16 Apr 2026 05:17:40 -0400
X-MC-Unique: Xwy3L-gFM5KYlk_IywL1mg-1
X-Mimecast-MFC-AGG-ID: Xwy3L-gFM5KYlk_IywL1mg_1776331059
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488dcaf2f2fso36318865e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331059; x=1776935859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tyd3skm6Msy+AniTzISQ/tVZvLyvz28Fd5IlGdI+aJk=;
        b=WPKC1nbbk5Bca6wjuBT6gEeIDScJLLSraJsWEniSLv0H9C49Dl7Xh2a/kOcyV8eWB3
         gFVXdAKkczP7zvGKfQMyDCOSN13UwwkLNxIKSGw/TKNV8U0G9zbcb3s2uKwqQPn+OlgL
         rxh0DKtfvwtk56bcAqYWsdwTAacrbTbSQAEQldIsTw0e058LasBdOgmQhDEv3PGPb3aC
         KzzAyGdEqE9gkNTXc5VAt1Dfsjm1R8AvYi3D4irf7uyEFIckkdBC39gWTZC8E5AKbiIE
         a08gaxvXcLUvAn9v0kUiZCNpw4rzJW3D6bN3Pkq7FjpiLUQEUULSBgs+fYdkMDFvoRBi
         6Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331059; x=1776935859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tyd3skm6Msy+AniTzISQ/tVZvLyvz28Fd5IlGdI+aJk=;
        b=q8xuVX3jy4eOEj9WN2EvPETgGRNHMDO32Tv6TKt6idejv+D3C6J+414DWJbrIYQlsn
         kCoXJ8YPWVa1uAtMp1s90ldq/eX/GVvp58WXgvuqx2pZ3d2d4fBDHWu3OBHvfpxxmu3h
         bY7ds3/ICGLo9PVAwUZV6hMIBNgN4SAMRplNC23h2Itq5vdw7vjBQBnFtQ6G9dqxhDVT
         Lr0GHAnjVAY1C8ZjCO7I7TDJe2FGo+vmT/6dxlRIkp/nvY2C/IO4T/gYfBbZXcMkjvFF
         nN1wfAAxp+tHjJGLoh2bgBo4wcUWe1IrFtIreCdRSYgl+kM6p+mMQbzVBe4IT4+U/EVS
         b9XQ==
X-Forwarded-Encrypted: i=1; AFNElJ8v7VN6kQMgGLMNU3HeMAXZJs3eQ5zh0vvQYxSWZOzz8MBDbs+zTcpuzUWoCJI0DoHQPb9K9SWcYkkhW3Uf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaf0DMCG62DKn9xqTnWJyI093aNc0nbw3oXzDOZAm6g3zKhNvv
	M6ibxyqu+84spQX+sXZ73r5rIOe2KVTvJGdKEh54FGsXIjhsSOjsEmkka+WulM8JydoR7J2/KYy
	m+C1j/Va06+Ev60/wW1ZI09RmGM2du4V3DG4dFscvS7gtwoSrMu7ahMbbnZhAZj6qhfM=
X-Gm-Gg: AeBDiet2rXQUFJkiYkEwwwi+C7YNWoU3hWI7xs5e/q/qVhteDjhWMPywCue6x2/V0Jj
	p5k6uHiiyKSx3CdaNptdDKAcOoSeHMyn23PvH/w5k2ZxF983dGYgWnsE6w+/2rQ+0vcLflgeSlY
	R85L7w8uVcSTRXuew0XMnMj9dxydLZA6q/NGwCcynqYCfptH6GTKnAGQWiKJ8WIdF4JMj/oRS9p
	bMlBquqX2j60IKT98hRHbE1tlAZ13nVAP4n8zJMzOJcKm/RJj9t4MgZK3N7t5941IJlIMVASQJL
	VHzRyXA7n/tEP8JO5r7bnbSuSBNT+skt02tLXEGhMpylugwF3jC3xIzPQ/q5a8mMrK65JC2KBSx
	zPK+uYs/lVeBq1IJ5EkkV1rxnP0WSkqKaPWPio9xA3OYlgFK7YatsVouTtGPKpmddrNmBHNNGwf
	iZi5rA4Q==
X-Received: by 2002:a05:600c:a416:b0:488:7f69:4abf with SMTP id 5b1f17b1804b1-488d67f946bmr262115065e9.12.1776331058839;
        Thu, 16 Apr 2026 02:17:38 -0700 (PDT)
X-Received: by 2002:a05:600c:a416:b0:488:7f69:4abf with SMTP id 5b1f17b1804b1-488d67f946bmr262114625e9.12.1776331058330;
        Thu, 16 Apr 2026 02:17:38 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:37 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 27/32] fuse: set params in fuse_chan_set_initialized()
Date: Thu, 16 Apr 2026 11:16:51 +0200
Message-ID: <20260416091658.462783-28-mszeredi@redhat.com>
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

Set minor, max_write and max_pages in the fuse_chan.  These match the same
fields in fuse_conn but are needed in both layers.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c        | 30 ++++++++++++++++++------------
 fs/fuse/dev.h        |  8 +++++++-
 fs/fuse/dev_uring.c  |  4 ++--
 fs/fuse/fuse_dev_i.h |  9 +++++++++
 fs/fuse/inode.c      | 10 ++++++++--
 5 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fe415454de0f..c59cbfd3ffee 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -71,11 +71,17 @@ static void __fuse_put_request(struct fuse_req *req)
 	refcount_dec(&req->count);
 }
 
-void fuse_chan_set_initialized(struct fuse_chan *fch)
+void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *param)
 {
 	/* Make sure stores before this are seen on another CPU */
 	smp_wmb();
 	fch->initialized = 1;
+	if (param) {
+		fch->minor = param->minor;
+		fch->max_write = param->max_write;
+		fch->max_pages = param->max_pages;
+	}
+
 	wake_up_all(&fch->blocked_waitq);
 }
 
@@ -711,12 +717,12 @@ static void __fuse_request_send(struct fuse_req *req)
 	smp_rmb();
 }
 
-static void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args)
+static void fuse_adjust_compat(struct fuse_chan *fch, struct fuse_args *args)
 {
-	if (fc->minor < 4 && args->opcode == FUSE_STATFS)
+	if (fch->minor < 4 && args->opcode == FUSE_STATFS)
 		args->out_args[0].size = FUSE_COMPAT_STATFS_SIZE;
 
-	if (fc->minor < 9) {
+	if (fch->minor < 9) {
 		switch (args->opcode) {
 		case FUSE_LOOKUP:
 		case FUSE_CREATE:
@@ -732,7 +738,7 @@ static void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args)
 			break;
 		}
 	}
-	if (fc->minor < 12) {
+	if (fch->minor < 12) {
 		switch (args->opcode) {
 		case FUSE_CREATE:
 			args->in_args[0].size = sizeof(struct fuse_open_in);
@@ -776,8 +782,8 @@ ssize_t fuse_chan_send(struct fuse_chan *fch, struct fuse_args *args)
 			return PTR_ERR(req);
 	}
 
-	/* Needs to be done after fuse_get_req() so that fc->minor is valid */
-	fuse_adjust_compat(fch->conn, args);
+	/* Needs to be done after fuse_get_req() so that fch->minor is valid */
+	fuse_adjust_compat(fch, args);
 	fuse_args_to_req(req, args);
 
 	if (!args->noreply)
@@ -1467,12 +1473,12 @@ __releases(fiq->lock)
 	return ih.len;
 }
 
-static int fuse_read_forget(struct fuse_conn *fc, struct fuse_iqueue *fiq,
+static int fuse_read_forget(struct fuse_chan *fch, struct fuse_iqueue *fiq,
 			    struct fuse_copy_state *cs,
 			    size_t nbytes)
 __releases(fiq->lock)
 {
-	if (fc->minor < 16 || fiq->forget_list_head.next->next == NULL)
+	if (fch->minor < 16 || fiq->forget_list_head.next->next == NULL)
 		return fuse_read_single_forget(fiq, cs, nbytes);
 	else
 		return fuse_read_batch_forget(fiq, cs, nbytes);
@@ -1514,7 +1520,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	if (nbytes < max_t(size_t, FUSE_MIN_READ_BUFFER,
 			   sizeof(struct fuse_in_header) +
 			   sizeof(struct fuse_write_in) +
-			   fch->conn->max_write))
+			   fch->max_write))
 		return -EINVAL;
 
  restart:
@@ -1545,7 +1551,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
 	if (forget_pending(fiq)) {
 		if (list_empty(&fiq->pending) || fiq->forget_batch-- > 0)
-			return fuse_read_forget(fch->conn, fiq, cs, nbytes);
+			return fuse_read_forget(fch, fiq, cs, nbytes);
 
 		if (fiq->forget_batch <= -8)
 			fiq->forget_batch = 16;
@@ -2110,7 +2116,7 @@ void fuse_chan_abort(struct fuse_chan *fch, bool abort_with_err)
 		fch->connected = 0;
 		spin_unlock(&fch->bg_lock);
 
-		fuse_chan_set_initialized(fch);
+		fuse_chan_set_initialized(fch, 0);
 		list_for_each_entry(fud, &fch->devices, entry) {
 			struct fuse_pqueue *fpq = &fud->pq;
 
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index 2bf4aba256d1..6437331058d9 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -17,6 +17,12 @@ struct file;
 struct folio;
 enum fuse_notify_code;
 
+struct fuse_chan_param {
+	unsigned int minor;
+	unsigned int max_write;
+	unsigned int max_pages;
+};
+
 struct fuse_chan *fuse_chan_new(void);
 struct fuse_chan *fuse_dev_chan_new(void);
 void fuse_chan_release(struct fuse_chan *fch);
@@ -26,7 +32,7 @@ unsigned int fuse_chan_max_background(struct fuse_chan *fch);
 void fuse_chan_max_background_set(struct fuse_chan *fch, unsigned int val);
 unsigned int fuse_chan_num_waiting(struct fuse_chan *fch);
 void fuse_chan_set_fc(struct fuse_chan *fch, struct fuse_conn *fc);
-void fuse_chan_set_initialized(struct fuse_chan *fch);
+void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *param);
 void fuse_chan_io_uring_enable(struct fuse_chan *fch);
 ssize_t fuse_chan_send(struct fuse_chan *fch, struct fuse_args *args);
 int fuse_chan_send_bg(struct fuse_chan *fch, struct fuse_args *args, gfp_t gfp_flags);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 87066d6ee782..f6bed983fea0 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -241,8 +241,8 @@ static struct fuse_ring *fuse_uring_create(struct fuse_chan *fch)
 	if (!ring->queues)
 		goto out_err;
 
-	max_payload_size = max(FUSE_MIN_READ_BUFFER, fch->conn->max_write);
-	max_payload_size = max(max_payload_size, fch->conn->max_pages * PAGE_SIZE);
+	max_payload_size = max(FUSE_MIN_READ_BUFFER, fch->max_write);
+	max_payload_size = max(max_payload_size, fch->max_pages * PAGE_SIZE);
 
 	spin_lock(&fch->lock);
 	if (fch->ring) {
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 61b054b73cb8..3acf73be3990 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -239,6 +239,15 @@ struct fuse_chan {
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
+	/* Negotiated minor version */
+	unsigned int minor;
+
+	/* Maximum write size */
+	unsigned int max_write;
+
+	/* Maximum number of pages that can be used in a single request */
+	unsigned int max_pages;
+
 	/** Connection aborted via sysfs, respond with ECONNABORTED on device I/O */
 	bool abort_with_err;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bda1bd4a9357..38f379374067 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1426,9 +1426,15 @@ static void process_init_reply(struct fuse_args *args, int error)
 	if (!ok) {
 		fc->conn_init = 0;
 		fc->conn_error = 1;
+		fuse_chan_set_initialized(fc->chan, NULL);
+	} else {
+		struct fuse_chan_param cp = {
+			.minor = fc->minor,
+			.max_write = fc->max_write,
+			.max_pages = fc->max_pages,
+		};
+		fuse_chan_set_initialized(fc->chan, &cp);
 	}
-
-	fuse_chan_set_initialized(fc->chan);
 }
 
 static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
-- 
2.53.0

