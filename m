Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B039B949
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331054; cv=none; b=ZmUgmXc6LhGb6TheJbWZfgq6xnotMLVtUSUtpw4u9AukoNVZwkfJhW18uMHVtuqhencfdoBPnBtAKct4mZs/ICYRr7FIQZagEVJ1fzPGaIL817QqkG50soApe5mHd3y8j4zHOM8OtGVylQ8wxxqOALcLBpiQd/y46SXsOj+CVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331054; c=relaxed/simple;
	bh=VYbmk5wPV9lXRDsmNlYt1YZLM2GJtwYMuhFMxXwb2as=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neAjxENP1Xrv+HCZET1E7DI7kcGnn1ymQyCmx08DOqWS7CP0W9sb9cyQSU7AHTYlZi3RjGgSCYxR8RFdIMgu/c6oUWP5klpZQebhcooAGQKS4qVwfBdHJwtAipZovvbaC3yC6Ug9GWZQNo6HzshF6NOwN3xDMKK0zhEJEo2coGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfpvDF2/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWb8YvT+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfpvDF2/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWb8YvT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqIgMyXT00pZ75/hzPEqZu5A+QPVl1ZSN6dj/sJjgT0=;
	b=LfpvDF2/BoGLWo0yzy4kpQUwv3txCPja2RyJ+0zj+cSNk1khBxGCAEd361UWWhrk6vFF8W
	sC0ZEQPym9nrniGuk/r68qwOIxKNSmzEGU0YxrUXwvgHWonitF9vPEzyH2CO2y5vWkjqOM
	iWV5QnfCCsvjzBrIJfaXsb7+ryN4H+8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-ZkYQerGIPq6_tGI7FQSZjg-1; Thu, 16 Apr 2026 05:17:27 -0400
X-MC-Unique: ZkYQerGIPq6_tGI7FQSZjg-1
X-Mimecast-MFC-AGG-ID: ZkYQerGIPq6_tGI7FQSZjg_1776331045
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d70e3e4e7so4556113f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331045; x=1776935845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqIgMyXT00pZ75/hzPEqZu5A+QPVl1ZSN6dj/sJjgT0=;
        b=VWb8YvT+gqeGJTsz1DTg2rtiBz8L/wKDgp4WrDHLwaixAmBwkTpN1WNcvncjpTiCBM
         wMLpfeN43JT/hetXOjOYRdm4mHGH2uVWHBUU90TtdlQORKJ9NcDpR9BOX2MOvNSNl1Kl
         PHn+7davRV/+KlFk3Hyacx8EfH/qinbQys5o5kVwHRpu5fyeiCI5sd3E0VaTbHGZRC3j
         9zLnwyldMKndGBDZof64AUF/XyMeHdfN0cqJIpp/7bGIJ7/1GcpuiijuYZRMwGKK7L9S
         f5xwlMUSQrhJHkj/6LOL24iWJMbn7DxFirEjShQYGIb60rRwiYYQ/0J3nAuwvhupeP2X
         vwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331045; x=1776935845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oqIgMyXT00pZ75/hzPEqZu5A+QPVl1ZSN6dj/sJjgT0=;
        b=RO2p7wivtWNJOI3rHtB3kk8IKplPNvVRE/tAll1isSOSefUUEGT+g/3P4zD8lIDHOe
         CYHuEpqNY390SUe6rpuir87esxnOiS+DNFkRRaMLMTfbaonhDcwEBqAkNAQM5mFhgURA
         +Q5Lu220f6w+fd+4vo7SBvZqTcO27DDLUEDJtpluFbSbZVzXjvBSwDid5lSOFY8yFD0i
         ms/PpPMJp9Zt+KgImvOKfamrqkS5T4fEe8pa6R/awC99dN2DI7IV8FJ9pDvxuRgUz6u4
         RgY6uwOfmi5cMZT2lD0Bgo4zu2hB8CX2ZDvdwn2qmz+ss5W/Vce1o/XXOce0w+nFNfHX
         uOmw==
X-Forwarded-Encrypted: i=1; AFNElJ8jWYLPjvnBdt+Jp6LPk31blmuyxk6goGqRBQN4xloyDwwCIRsSl7cf0gPp7WY0PoGn6JHESjlt1EGB+Cc4@vger.kernel.org
X-Gm-Message-State: AOJu0YxppRGRKcEaOZdZ+DMd+wzBpSRl88smagBU23tjNNIINhmCR57e
	tlh3fX+FVC2PHlK0s4eQd+FfqNRldjLFonGyiaN1ot0imtR6x0xfZ4X0QSdM/kKVG7eUL6wj/LN
	lHDlsONN4qIwyAQSYQpQVRzaxtd857K5C4ykeA/F0LxHZGQdHwSpFnZwqy8cZpoTyf+Z8vx0pU2
	o=
X-Gm-Gg: AeBDiev23NPmzdB6Irn+FsCQKdKK6GjAoyM0DGWEbYVtIGPI7/y1zcjjomx13IbuQ6q
	ICthRWy/F2eZskHmHgB5sBq60sRCUq+0hGo0Y398Ic+FOJWOTmrN9dN6fFjilSS8J1lpdZdkewE
	RfxeoLZoFARHTuWf122ahrBrQiMvszytPpiDPgKIO8vj3hKbZr6WyoWgQNKgR/uPHW6MbWmVSOh
	nDGy1B0vNtVICAUCGlYLn3h7ktU+BVFGmA3Wjew7XUlKAkfQKjhAccJki1jbD0XxPtj7+sMozcB
	umFskFKXZ2+WdeX9LpMIHPcQX2oAr93lfII25YeskRf3wWrInrOr7WA4vHVdABhchRkV6AcWv/o
	Cr1iSx2KpKfD2l0k3+Jk+B8ByCUu/7R4KeFZB11F4mkyF6Xtk6Ja76DtS+uyyrbyjFC5SfLvs/0
	xrgSha4Q==
X-Received: by 2002:a05:600c:8b2f:b0:485:3423:727d with SMTP id 5b1f17b1804b1-488d688d46cmr319158545e9.26.1776331044562;
        Thu, 16 Apr 2026 02:17:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8b2f:b0:485:3423:727d with SMTP id 5b1f17b1804b1-488d688d46cmr319158085e9.26.1776331044097;
        Thu, 16 Apr 2026 02:17:24 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:23 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/32] fuse: move fuse_dev_waitq to dev.c
Date: Thu, 16 Apr 2026 11:16:40 +0200
Message-ID: <20260416091658.462783-17-mszeredi@redhat.com>
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

Move wake_up_all(&fuse_dev_waitq) into fuse_dev_install() where it
logically belongs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c        | 3 +++
 fs/fuse/fuse_dev_i.h | 2 --
 fs/fuse/inode.c      | 6 ++----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 58cfd0b1fd6f..8096c861e853 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -31,6 +31,8 @@
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
 
+static DECLARE_WAIT_QUEUE_HEAD(fuse_dev_waitq);
+
 static struct kmem_cache *fuse_req_cachep;
 
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
@@ -480,6 +482,7 @@ void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
 	} else {
 		list_add_tail(&fud->entry, &fc->chan->devices);
 		fuse_conn_get(fc);
+		wake_up_all(&fuse_dev_waitq);
 	}
 	spin_unlock(&fc->chan->lock);
 }
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index ef72159eb558..2e1c251572ca 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -13,8 +13,6 @@
 #define FUSE_INT_REQ_BIT (1ULL << 0)
 #define FUSE_REQ_ID_STEP (1ULL << 1)
 
-extern struct wait_queue_head fuse_dev_waitq;
-
 struct fuse_arg;
 struct fuse_args;
 struct fuse_pqueue;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 85088b0671a9..88a4dc402155 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -34,7 +34,6 @@ MODULE_LICENSE("GPL");
 static struct kmem_cache *fuse_inode_cachep;
 struct list_head fuse_conn_list;
 DEFINE_MUTEX(fuse_mutex);
-DECLARE_WAIT_QUEUE_HEAD(fuse_dev_waitq);
 
 static int set_global_limit(const char *val, const struct kernel_param *kp);
 
@@ -1788,10 +1787,9 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	if (fud) {
+	if (fud)
 		fuse_dev_install(fud, fc);
-		wake_up_all(&fuse_dev_waitq);
-	}
+
 	mutex_unlock(&fuse_mutex);
 	return 0;
 
-- 
2.53.0

