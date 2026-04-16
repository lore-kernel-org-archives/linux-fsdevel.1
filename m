Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3739B4AF
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331061; cv=none; b=Crja+Vs7aVwM5FLqXPRUVf4NR+qlY1/Kse0nXHgdNcJwnnjVBuCqLjxmQHdMvy4dkg/0LGVzDX/eadJkHDeC+7s1FB++LekAcPc9Gl7d+yeIuJ2M616z1v4wsFwgo9E81Ax8O91z4CC11khAj2DqkUKL5RQ7k9S0thdp+/u8UzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331061; c=relaxed/simple;
	bh=K/TaEfWt9Uf5VpvRSWMgT3Z+1hNM1hrA1FsVv3vLJ+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bf9jgWxVnlWvqg3aNfpbAvBspmgy2PMgXoYFpHRLymw4+euuz9rItuV7oh9OgXMjRG7JvwECCNVA0GAAmGnafQ5jovJaIOYj35oVcsOVR5ph+L/NlcoG7w7aRP5r+wu3gf1RF6rC0y9CbZ7B+7aFz1VV//1Clcxe0mLElKMW5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0iyGoWW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpkRT9Mq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0iyGoWW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpkRT9Mq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XKLEilXUNzkgU63Y1kxVb2OFYW6G21+TJccAbz/tT0=;
	b=L0iyGoWW+vFPON+vMbNqHJlRA1uWGdf0knVy/gEDEqRhUeI8GUxy1ZwurTXGE+6vlHp+07
	xZd3fYMwexh716PgbcdNN1sYNuFvN9X1Wd4bFdV5c07DOz2u8CagVO5CC1l3U4SZXuHQ3/
	CCYqSchYWFy1cov1emBquNC+21qPnF8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-LJ4myqUVOkmpY6tTJUKmnQ-1; Thu, 16 Apr 2026 05:17:33 -0400
X-MC-Unique: LJ4myqUVOkmpY6tTJUKmnQ-1
X-Mimecast-MFC-AGG-ID: LJ4myqUVOkmpY6tTJUKmnQ_1776331052
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so48814205e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331052; x=1776935852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XKLEilXUNzkgU63Y1kxVb2OFYW6G21+TJccAbz/tT0=;
        b=NpkRT9MqZXeIYQT4GPzFo575nzdQnNlGORCdCWuqlqmxhgTNRe+4gmkcGms7cpTX8K
         pj34x9iFf+LVGl8PINaRrnq/NukbUKdm9C9anfFLZsHMcwzNcxvv09S6eQs59ZtxtTnQ
         nUZtulAwvlyv1ZFnUMpD21hVY4YNf83EXxhlKYtKJRkJIxcZJg2QH2q8BVtpzpdUEzLD
         1CbrSNt+G3c1rrIZco+5UTsvD+aOj8M8Qh9GRx3XduWQklQa+10qXfMTxR2XWWuItC9l
         zGEGFHaVV9uGHw4+paECwIbu+smNBpTYAl/XyxqDFP+XkqofOTjTiiujAuSYRxBBtakC
         FIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331052; x=1776935852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9XKLEilXUNzkgU63Y1kxVb2OFYW6G21+TJccAbz/tT0=;
        b=E2ixbtvaR0Zz+01WyZw0xgeJNMiY7e7OdSNOjGaLkliJGxi5zjFyH0yIac9M6eJbnB
         b5S6e6lIXWTqfTyBWtOUTvglzvKtgR6SPbdgwuCmoJR12HmlXAZsOCRdzaVhoVbmqV9d
         i8KNHMCWRIoMtyaFYtWwTwmFvEHW4r1x43rdLl5BdCV1txrE457sMOrc7HGSx3RrRkpJ
         A0A75t6c+hVvRNEs7Iuqo9DAeNDTBYlI1ehXeV7uA/c2c+wCKeN5CAXAapq2IGNC4sCp
         qqLmFrzrI5sL5TU0pgdYxiJ9hW154vV9k8qYhQrQu3jUjqnSuVt8SL+J1AtoJulD9byW
         eozA==
X-Forwarded-Encrypted: i=1; AFNElJ8ER2Dj4uI5Wv4Q5C3+zcNfY4BqZeLYARh+vvt3kED6bNDir3InoXjmJ2qAmnFSzykHTDDydN2zIzeD7DNB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/eqjIckUa3GCaiqQGahxFi9vnDbSJvrzOTr/1of+L4WNZssCf
	Ox6+6H/6IL/8pdIKZZrskrz9xs69Ygi6mHvhYiqeUgTTJsyS1gNLboLfcopNusVbAbfHlqmt46h
	Ok6JM2A7n4nSJiwW2ikHWGHIOZOrb1jLHShw9p/zn+bmbgJmFFhl6x1SO9QMvsHSVH4se+KXwIi
	w=
X-Gm-Gg: AeBDiesN5pjVkMy8+QQjipHAt/vEp24jAe9YlyXO1RexxbUIKMgp48cQE5T3Fyy4cWU
	zJFdQS7n4d81uAIwcs9G1vz7XFUrNe8/g5ioZLQp66trfeCLpm5BMCOdyEUvjGnKSiqhP4W4Kfu
	9r0pBVlO9Nq3EN/YgBuGpmGFNrSSeKdRet0kWkbwYlgEI4crXkgNOZUz63+C3UjMASbuntP9W9J
	QYuE6htYUcSep5JSK9Ts16M2BJ0EztqKvGBDYnQr7SP/q5XSiPpYA+RCSmiJF/mS7ZmALs4NiF4
	JYwKfx2SeLmOBitYdgQEoOYdvSJ332ATf7uTSZfoefCpDmsP9mVTJMIFn6s9A4QMxZzNcievVND
	O/tns0BcVM7f2DN8juOn/73cOtokCl60HeE26kPGe21TGVzXsLWQYHVp8sjKjAqR1GO3KbPmZXi
	GO3YGEJw==
X-Received: by 2002:a05:600c:528f:b0:488:a82f:bbb4 with SMTP id 5b1f17b1804b1-488d689d0b8mr333952395e9.26.1776331052003;
        Thu, 16 Apr 2026 02:17:32 -0700 (PDT)
X-Received: by 2002:a05:600c:528f:b0:488:a82f:bbb4 with SMTP id 5b1f17b1804b1-488d689d0b8mr333951635e9.26.1776331051394;
        Thu, 16 Apr 2026 02:17:31 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:30 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 21/32] fuse: remove fm arg of args->end callback
Date: Thu, 16 Apr 2026 11:16:45 +0200
Message-ID: <20260416091658.462783-22-mszeredi@redhat.com>
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

Only used by FUSE_INIT and CUSE_INIT, these can store the relevant pointer
in their structs derived from fuse_args.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/cuse.c  |  7 ++++---
 fs/fuse/dev.c   |  7 +++----
 fs/fuse/file.c  | 22 +++++++++-------------
 fs/fuse/inode.c | 10 ++++++----
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 9341bb5a88cb..bf5724415b04 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -307,6 +307,7 @@ struct cuse_init_args {
 	struct cuse_init_out out;
 	struct folio *folio;
 	struct fuse_folio_desc desc;
+	struct fuse_conn *fc;
 };
 
 /**
@@ -320,11 +321,10 @@ struct cuse_init_args {
  * required data structures for it.  Please read the comment at the
  * top of this file for high level overview.
  */
-static void cuse_process_init_reply(struct fuse_mount *fm,
-				    struct fuse_args *args, int error)
+static void cuse_process_init_reply(struct fuse_args *args, int error)
 {
-	struct fuse_conn *fc = fm->fc;
 	struct cuse_init_args *ia = container_of(args, typeof(*ia), ap.args);
+	struct fuse_conn *fc = ia->fc;
 	struct fuse_args_pages *ap = &ia->ap;
 	struct cuse_conn *cc = fc_to_cc(fc), *pos;
 	struct cuse_init_out *arg = &ia->out;
@@ -467,6 +467,7 @@ static int cuse_send_init(struct cuse_conn *cc)
 	ap->descs = &ia->desc;
 	ia->folio = folio;
 	ia->desc.length = ap->args.out_args[1].size;
+	ia->fc = &cc->fc;
 	ap->args.end = cuse_process_init_reply;
 
 	rc = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index cbf8f086536c..f1e7e67912a3 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -641,7 +641,7 @@ void fuse_request_end(struct fuse_req *req)
 	}
 
 	if (test_bit(FR_ASYNC, &req->flags))
-		req->args->end(fm, req->args, req->out.h.error);
+		req->args->end(req->args, req->out.h.error);
 put_request:
 	fuse_put_request(req);
 }
@@ -1983,8 +1983,7 @@ struct fuse_retrieve_args {
 	struct fuse_notify_retrieve_in inarg;
 };
 
-static void fuse_retrieve_end(struct fuse_mount *fm, struct fuse_args *args,
-			      int error)
+static void fuse_retrieve_end(struct fuse_args *args, int error)
 {
 	struct fuse_retrieve_args *ra =
 		container_of(args, typeof(*ra), ap.args);
@@ -2071,7 +2070,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	err = fuse_simple_notify_reply(fm, args, outarg->notify_unique);
 	if (err)
-		fuse_retrieve_end(fm, args, err);
+		fuse_retrieve_end(args, err);
 
 	return err;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 11d3797ad26b..d549f47170d6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -92,8 +92,7 @@ static struct fuse_file *fuse_file_get(struct fuse_file *ff)
 	return ff;
 }
 
-static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
-			     int error)
+static void fuse_release_end(struct fuse_args *args, int error)
 {
 	struct fuse_release_args *ra = container_of(args, typeof(*ra), args);
 
@@ -113,10 +112,10 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 		if (!args) {
 			/* Do nothing when server does not implement 'opendir' */
 		} else if (args->opcode == FUSE_RELEASE && ff->fm->fc->no_open) {
-			fuse_release_end(ff->fm, args, 0);
+			fuse_release_end(args, 0);
 		} else if (sync) {
 			fuse_simple_request(ff->fm, args);
-			fuse_release_end(ff->fm, args, 0);
+			fuse_release_end(args, 0);
 		} else {
 			/*
 			 * DAX inodes may need to issue a number of synchronous
@@ -127,7 +126,7 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 			args->end = fuse_release_end;
 			if (fuse_simple_background(ff->fm, args,
 						   GFP_KERNEL | __GFP_NOFAIL))
-				fuse_release_end(ff->fm, args, -ENOTCONN);
+				fuse_release_end(args, -ENOTCONN);
 		}
 		kfree(ff);
 	}
@@ -710,8 +709,7 @@ static void fuse_io_free(struct fuse_io_args *ia)
 	kfree(ia);
 }
 
-static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
-				  int err)
+static void fuse_aio_complete_req(struct fuse_args *args, int err)
 {
 	struct fuse_io_args *ia = container_of(args, typeof(*ia), ap.args);
 	struct fuse_io_priv *io = ia->io;
@@ -759,7 +757,7 @@ static ssize_t fuse_async_req_send(struct fuse_mount *fm,
 	ia->ap.args.may_block = io->should_dirty;
 	err = fuse_simple_background(fm, &ia->ap.args, GFP_KERNEL);
 	if (err)
-		fuse_aio_complete_req(fm, &ia->ap.args, err);
+		fuse_aio_complete_req(&ia->ap.args, err);
 
 	return num_bytes;
 }
@@ -1001,8 +999,7 @@ static int fuse_iomap_read_folio_range(const struct iomap_iter *iter,
 	return fuse_do_readfolio(file, folio, off, len);
 }
 
-static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
-			       int err)
+static void fuse_readpages_end(struct fuse_args *args, int err)
 {
 	int i;
 	struct fuse_io_args *ia = container_of(args, typeof(*ia), ap.args);
@@ -1068,7 +1065,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
 		res = fuse_simple_request(fm, &ap->args);
 		err = res < 0 ? res : 0;
 	}
-	fuse_readpages_end(fm, &ap->args, err);
+	fuse_readpages_end(&ap->args, err);
 }
 
 static void fuse_readahead(struct readahead_control *rac)
@@ -1985,8 +1982,7 @@ __acquires(fi->lock)
 	}
 }
 
-static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
-			       int error)
+static void fuse_writepage_end(struct fuse_args *args, int error)
 {
 	struct fuse_writepage_args *wpa =
 		container_of(args, typeof(*wpa), ia.ap.args);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5cb0cc9b365e..b7dfe8338988 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1263,13 +1263,14 @@ struct fuse_init_args {
 	struct fuse_args args;
 	struct fuse_init_in in;
 	struct fuse_init_out out;
+	struct fuse_mount *fm;
 };
 
-static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
-			       int error)
+static void process_init_reply(struct fuse_args *args, int error)
 {
-	struct fuse_conn *fc = fm->fc;
 	struct fuse_init_args *ia = container_of(args, typeof(*ia), args);
+	struct fuse_mount *fm = ia->fm;
+	struct fuse_conn *fc = fm->fc;
 	struct fuse_init_out *arg = &ia->out;
 	bool ok = true;
 
@@ -1437,6 +1438,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 
 	ia = kzalloc_obj(*ia, GFP_KERNEL | __GFP_NOFAIL);
 
+	ia->fm = fm;
 	ia->in.major = FUSE_KERNEL_VERSION;
 	ia->in.minor = FUSE_KERNEL_MINOR_VERSION;
 	ia->in.max_readahead = fm->sb->s_bdi->ra_pages * PAGE_SIZE;
@@ -1510,7 +1512,7 @@ int fuse_send_init(struct fuse_mount *fm)
 		if (!err)
 			return 0;
 	}
-	process_init_reply(fm, &ia->args, err);
+	process_init_reply(&ia->args, err);
 	if (fm->fc->conn_error)
 		return -ENOTCONN;
 	return 0;
-- 
2.53.0

