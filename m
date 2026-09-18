Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6384B95CD
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722079; cv=none; b=mKrsa8xl+uXVe50R4kOz3gEyLDYp2982UJfSlmhvtdY8VdWBm0QniGCRolrFgUzUnbmCv7rhC38gzCR/2DSRq95JmUyJPFA/gewtdNqJ59j/zdQ/7LhXxDigxRudZWOyUS23HAS62wAvh/UMNufoFK3AuunMYqKdz1CV5Nk2NKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722079; c=relaxed/simple;
	bh=+o0snggj/m/2d8D7ycD9G9GtJCC4yhk0g3zHdR/kbaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RM6e7upGpY3MDeqp9uFiytCUKakUiDBwq+3Ok4lAqskcuDDay2tHu//I3M/ytAmUSidvoP2FlDoL55H5QAdl6Z1M7ORIr+7pB/ljQJBMl5irHADWFL8DUTjCM1dmdPLU9k3pChO+aGHK8amAObmCnuKAFDLq5uizMi2m3L45GL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGJ32yGV; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGJ32yGV"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so535832b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789722076; x=1790326876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x6YgE1Yw7lkJk47zy1LDh67BaPudxiOFGn/bxCkqDz4=;
        b=HGJ32yGVw5hv2acG/U4+3uAFcH3GM9iSovhV15zxNAlLBvTvfcE7uBoMw4ly0Ib6Yp
         LWwpgO5Aw7dME6SP/rJt8A/wPZLlJmQtcU/dMjN7VVQFFSw7Ma/LXsk2wyiQcu8uhnlF
         +OUnzHdWOFUiUdaOXY4JymNt6rqVUU19dJATWnMRBHeoa5uWrTu6ySWwRB8ELf1Mo3+O
         13MrcI9JfwncRDTLMirQixJM+oveeIh0q1QGdZun33R108wlvzpiuSoQlmmQBlLWbuvA
         XgOQ2lqYNOdvAQFu7B6yJqvX2ZK/97rBlRlPsognqPRy9kEq8qDdkAvmhJS0KUxMmwRZ
         D3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722076; x=1790326876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x6YgE1Yw7lkJk47zy1LDh67BaPudxiOFGn/bxCkqDz4=;
        b=j54fIGK46PfRaH35Gp/1N/7d+7IEe61nA2nUEdH8z8FvCFOPwDCBDaDIINVgYzbcG3
         0pJL/gaJ+jv+DhV0aVd8VgEQPXjy0pHgszYYAelyaN2P4nvcyFh/jI7yWPZEsvuaULUY
         6x1gnQHeUyfb8xg38AYkS/oD/X5bfDhen4t7/mjVfjS2vKnzv6fL/Zw8WVszK/8GcGsm
         cL8Ecfld/VMfPtXZ/Sv7mFy3cNsptvNk1T/FB+PeURVOWHd8lgXHDxU4LwXOwhNlBetN
         T8h9CSo54Ue5o74/mu0Mi4Ryojub/pyJCGyMtXJvCKgnfkIF5Jy3DqNIdRCRhjyDWI8t
         PTFQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3U/OPUTDHnnoEjGr6BnMMGOm3tieGreD165+2sU7W1grKuL+6dDpGHrTusLlm1B6hDN/s5JQEBKxFxIk3@vger.kernel.org
X-Gm-Message-State: AFuF++lJaF0rksutf80gs5jFlqlTAJn8nBpb7PzSYfQMsJTR+irb464I
	pN709Pwj5VuSuKQz4Vw65Hg5M3H0PC5+fyWsWTKw58MF85eWqu9IpKB6
X-Gm-Gg: AYBFou0T+kwV9UZ/TH78vDzgUVXJDdTvK4y0gzJfNv0CBj6OxaF11EimUnbIIwn9uo2
	oBHbk9R0S27gV7BncGUrIWSfNJPGPSBz0Y2o+UfRETnLXacs6KVKhZgvIraKwlIWNe9TVC14EIu
	AA/ohdVkyyCmI171uByIM5fL7q9Jjbd6vW90aZe+KxJSRlklMmC/GVrTzkzYLje3b2Mv71O+VH6
	eERP60uub0Ufa+73pEn6MbmeZYH9yQIrN2GGMp8Sp4KUvLwyd0KCU04xiz/1iVEqo+POXzFhdAm
	phKnZMMop+dg3sPJEyTUU52QsR3+eJwnD5w8OdYOvyObZ0xeVp9DtvXpoPMyDYPN33AZIvLC3nQ
	nJshPz5ZvJUYvTsBjxFyun4FIUhDXyZvLeN+a5YD6nQPfiUnpH/noznFKs++KElPQjdkP/KGoEi
	HYcYv6Q0s/5rPk6WOqfwUiMtrT+OpP/xSvuO3b+s9ofa86HsTg9/GHuweNV1zaigRxrqG5gAg/5
	eeC7Iag+BagpLicJj6rH1vruoSL6SSFFZfsnYSdeGmKfXc3qSVBeNb7LRaXSyTAZTG5B1a476CE
	nbb60/2KZmGUQmGtliMmZ0xo7W6A7Cmsuh7B8wGw/QxaXapdyCLhYhnQK1JBVmGeHT2A4I/DHic
	yX9xDUQ==
X-Received: by 2002:a05:6a00:13a7:b0:855:74f7:40c2 with SMTP id d2e1a72fcca58-874dc7e5dd3mr3205309b3a.14.1789722075508;
        Fri, 18 Sep 2026 02:01:15 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.t54fbfa9bf0658dcb-tp.internal (96.177.21.34.bc.googleusercontent.com. [34.21.177.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-875dc8fa40fsm504491b3a.15.2026.09.18.02.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:01:15 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v4 2/3] fs: make file_listxattr and file_removexattr helpers non-static
Date: Fri, 18 Sep 2026 09:00:09 +0000
Message-ID: <20260918090010.1688-3-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918090010.1688-1-aditya.ansh182@gmail.com>
References: <20260918090010.1688-1-aditya.ansh182@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding IORING_OP_FREMOVEXATTR and
IORING_OP_FLISTXATTR support in io_uring, we need to invoke the VFS-layer
helpers from within io_uring.

Make the following helpers non-static and declare them in fs/internal.h:
- file_listxattr()
- file_removexattr()

No functional change is introduced.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 fs/internal.h | 2 ++
 fs/xattr.c    | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index c658c8a5ebd5..ff7344ac8cef 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -298,6 +298,8 @@ int filename_setxattr(int dfd, struct filename *filename,
 		      unsigned int lookup_flags, struct kernel_xattr_ctx *ctx);
 int setxattr_copy(const char __user *name, struct kernel_xattr_ctx *ctx);
 int import_xattr_name(struct xattr_name *kname, const char __user *name);
+ssize_t file_listxattr(struct file *f, char __user *list, size_t size);
+int file_removexattr(struct file *f, struct xattr_name *kname);
 
 int may_write_xattr(struct mnt_idmap *idmap, struct inode *inode);
 
diff --git a/fs/xattr.c b/fs/xattr.c
index d58979115200..31b8a5eeec1e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -953,7 +953,6 @@ listxattr(struct dentry *d, char __user *list, size_t size)
 	return error;
 }
 
-static
 ssize_t file_listxattr(struct file *f, char __user *list, size_t size)
 {
 	audit_file(f);
@@ -1036,7 +1035,7 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d, const char *name)
 	return vfs_removexattr(idmap, d, name);
 }
 
-static int file_removexattr(struct file *f, struct xattr_name *kname)
+int file_removexattr(struct file *f, struct xattr_name *kname)
 {
 	int error = mnt_want_write_file(f);
 
-- 
2.47.3

