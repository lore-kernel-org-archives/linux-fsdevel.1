Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297409;
	b=TDuBU4eDhRvPPmn+WG5Io3mzIKN76TwIuwrpvdnxW1OwuvpCwpxQ62eDshhFJ6v2nx1k
	 3OJ8kXUFR40GwOdqLgimMsx7gsZpSJhjiMR7h2bjsImsQDOODFys1TkeQb7buOtOs6Z89
	 u9EF9+vr8tY8wP3H73zp2kdyCmb6qxZ3HAAiz8Xi3RYhUizqZqTvkTTusWimRvkTTxP0e
	 0dUkNhGK7KdTeGmRmDc2noQF3YqrGFDTLCfXPuZClvi8M/I39h8gYRoWef8s9VaTVH9aZ
	 2ZIEg4s6Eg+AklH2fkBGH0+nDLTXA/PUn+FBJYl7RIMiePlLbhUmJv0m3njhfOaQ+FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rH9CbGqODly4QJymlyl4BG0aA7nsrIIcMmK3tybqsts=;
	b=SEX4uz9+MMr5mLRmHZlZVSkOco6B6nYqTlZHbsYDfdor6nqsEtI0Y5Yf0HuJAaEoFQ1B
	 xBWCPopNyJu99ymG2gc65qfom7wmNOmuG3V8OAzo8yu+6dLLLyrpqqGaPaIC2TsoP4mCu
	 40t7Ket7JXQNSvqWyHC+1yuuHa7BrtyfcjfpoWzvAytzGOyDQX/ErvjhTPQphR+zxpnQh
	 lRBwrmuUe2sUslJat5IVb+51EI8eZ9GOOM4gDwSwKqjsn50iE1R44HGHuU6KnvRu0ys4j
	 1zgqxUTGMiJRc+4Npu8+fyeBnpQylZY2zVkj5KFQCRNmWaTbOscJ5gsaHJahAyANJ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=jiIoUki4;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1660A6F7A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14A1660A6F7A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=jiIoUki4
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8241a56cd70so1551054a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1793297408; x=1793902208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rH9CbGqODly4QJymlyl4BG0aA7nsrIIcMmK3tybqsts=;
        b=jiIoUki4j4MwfBdQRja9mQm5YbKyR2UfdgEDEpBelWc7CL+KZVxs8YGe3V4thSYnTf
         4Q+6PlYwf8H0dxXpIZVkw0gqDbX1JjegbhGQsrf0o123qkP9aVQ+RgM9z+sgWLRegzAy
         mXzOKWzYxxn3T25pHgaOYoGMT14v36G/tEp03Ighzjd8v+4bIIhikIk6gOb+8BzUxOip
         IeVfFmYJIsZi4z1gBG6/k7WKvjJtJAehF2bUmKLJyCjPLaBWNFrYAiaSo9l0uVlFKgw0
         Pm1MqLT15sII2XEXTBrAYgBpCOqBlXifLBnUsRmeBl6T25KGkyrt9j3xpkOIqf7olmiN
         p8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297408; x=1793902208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rH9CbGqODly4QJymlyl4BG0aA7nsrIIcMmK3tybqsts=;
        b=skOFPqVrGA4vandy6X36DtRRZ1EvgfLlr+6uj4NAQDxTYHxtP8xFhAM/nsNU4E1m4t
         i5JPKtnpvY4z3fa0juf3eLM8foT6PpoXJ5/9o9yk54Fkc/KsAmExFDjFDqDwUxHPLJCT
         50C5PeRcZJSjXNBRY1XeINZBKTEwmacNHZJhdeBrBBxcFVVYQZihLxGp5WxLNvbkq9QQ
         dt/FqSr8UxHJ1w9GwtEuxhS3YD0ZdSFp7KrZdGn35wkFYfylH7EWwxsFqg0NgMrzHxKd
         6cu8WZK3cKsv8xXgvR49PMGmP+9PpZ02nHOipM4djTR+PPoWQL+2kGIpa7NTyWepAZOe
         Ymjg==
X-Forwarded-Encrypted: i=1; AKwUvBwSFCEGSPMbscwzVFGfvOfe6g3Bc8oV1/78yGXcsDN0EXMf1IGsRZmp4+BFyiCGAubIHaaJa/xCor53lY9I@vger.kernel.org
X-Gm-Message-State: AFq9FYLzu5fMDrwp/XBmpoJ8cqobUQ26LNqb7CcXXqI79aaZ4Ma7OQNN
	nZ3YtnSv+CLbPsOXrYmGYsYfv1CaYMEd5yM2M8ipFbSMeISi2p1CO69ueF5EpclegAw=
X-Gm-Gg: AYBFou3zlNdGkZm8u8O3DU7ws1dMQjyQuOcBcX/pBU2aHrfYSy5vD0ZIdMoIwrR+Tn0
	Mad1juRicMgrBRUULq+6PDffPOofNS39w/X6bYlJvxG3jyZi3WLCbQCTFCY2K2JQuxOvZQRL1h6
	qxw+ZTck9Fp1WuoAce3qDxdle/T0hkYTMgW71SzY6QNUErvXIVelQbkcPpaEPnEhuc423CjTi+K
	gz9ETqBsfZjDahn07ahZAe8+87apCI8jfvVyCbSzQG9kAPHuDXBew8qq204o7CVVjwaZ0jA960x
	hA6Decsb538QWu04Lz0CNZUhj2mN45QThoiYeIYu/MdPi1MWQNgF4eAzYh1uFw/50FizYXNrTY5
	DBurkdpiZ1C3l2pApD3X7mlhQj3jYVDs2UGVggnVuZ/F53fuPwkyHZi411hop9c15DKCBFUWJxG
	l1T21HK6eY7EtVTAjps8vPg48t8wY2QDOAtztkYFyudaUTGk6ZtXCRzBpvygVPqDlH0PYLn2SSk
	boMvMekVOCE1asQq0SplHhyC5ne8NxdiZVwEA+ROBl/sd9pQoEUxzLg6tWxkBZ2aNswRu7mvREO
	b0tAeF6ByFlzdQgzb5FxunurtQKSH158KUo6lsocL2v5ia6RbrJT6JyXSN36N9bzCFLUazJE
X-Received: by 2002:a05:6808:1904:b0:4e4:627a:e0a5 with SMTP id 5614622812f47-56383e91af6mr4444175b6e.40.1793297407750;
        Thu, 29 Oct 2026 11:10:07 -0700 (PDT)
Received: from localhost (75-163-200-235.clsp.qwest.net. [75.163.200.235])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c654a22bsm4702434b6e.14.2026.10.29.11.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:10:06 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
To: NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 05/12] vfs: factor file removal into a helper, no functional change
Date: Thu, 29 Oct 2026 12:09:50 -0600
Message-ID: <20261029180957.387138-6-jonathan.flynn@hammerspace.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029180957.387138-1-jonathan.flynn@hammerspace.com>
References: <20261028041023.3738553-1-neilb@ownmail.net>
 <20261029180957.387138-1-jonathan.flynn@hammerspace.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the body of vfs_unlink() into a static helper, __vfs_unlink(),
that calls the method it is passed in place of ->unlink(), or
->unlink() when passed NULL.  vfs_unlink() becomes a wrapper that
passes NULL, so every caller behaves exactly as before; its kerneldoc,
including the requirement that the caller hold the parent directory's
lock exclusive, does not change.

This prepares for a second removal method, called with the parent
directory's lock held shared, which a following patch adds.

Signed-off-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
---
 fs/namei.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ce10a408d3..1b3a605ded 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5679,6 +5679,12 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
 	return filename_rmdir(AT_FDCWD, name);
 }
 
+static int __vfs_unlink(const struct mnt_idmap *idmap, struct inode *dir,
+			struct dentry *dentry,
+			struct delegated_inode *delegated_inode,
+			int (*method)(struct inode *dir,
+				      struct dentry *dentry));
+
 /**
  * vfs_unlink - unlink a filesystem object
  * @idmap:	idmap of the mount the inode was found from
@@ -5706,6 +5712,20 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  */
 int vfs_unlink(const struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, struct delegated_inode *delegated_inode)
+{
+	return __vfs_unlink(idmap, dir, dentry, delegated_inode, NULL);
+}
+EXPORT_SYMBOL(vfs_unlink);
+
+/*
+ * The body of vfs_unlink().  @method, if not NULL, is called in place of
+ * dir->i_op->unlink(); vfs_unlink() passes NULL.
+ */
+static int __vfs_unlink(const struct mnt_idmap *idmap, struct inode *dir,
+			struct dentry *dentry,
+			struct delegated_inode *delegated_inode,
+			int (*method)(struct inode *dir,
+				      struct dentry *dentry))
 {
 	struct inode *target = dentry->d_inode;
 	int error = may_delete_dentry(idmap, dir, dentry, false);
@@ -5730,7 +5750,10 @@ int vfs_unlink(const struct mnt_idmap *idmap, struct inode *dir,
 			error = try_break_deleg(target, 0, delegated_inode);
 			if (error)
 				goto out;
-			error = dir->i_op->unlink(dir, dentry);
+			if (method)
+				error = method(dir, dentry);
+			else
+				error = dir->i_op->unlink(dir, dentry);
 			if (!error) {
 				dont_mount(dentry);
 				detach_mounts(dentry);
@@ -5750,7 +5773,6 @@ int vfs_unlink(const struct mnt_idmap *idmap, struct inode *dir,
 
 	return error;
 }
-EXPORT_SYMBOL(vfs_unlink);
 
 /*
  * Make sure that the actual truncation of the file will occur outside its
-- 
2.43.0

