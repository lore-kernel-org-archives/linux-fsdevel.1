Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877681;
	b=iJpXW+3a0r2xqbKB9TJmN3gRYA4Tk/+lrc4zFjelak9euG7mk8/EWE7C82JAG1PxwqUJ
	 9G5vAq5HggrGzlWy1zLznoKus6KYsxDUfQ9bbHeIdNTKWmOvmCIvtuGLkq7b4TaxDDIdR
	 SoUl9wvJ4XWWoveeiKPboPlu0rWTU6FMDw0cJYiN9W7nG4I/AoUwcxxKaJyy/mbi+23YD
	 Rd6vM1a1DM0RS1VTp3QemE6rmW5Dj2TpQokodwQdFnOirOXjYgCGWdKnHto7FfQKvtB5M
	 IUEh55a/tlHN8lEL92DjF9xIVzGOQuaWkvytY3f4dub6mIUP2XTf5phAMsCsRthRJsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877681;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9jkkQ4t+J9o+IePrPfR3Ab6g6inLOJoRbMgYz7UJ/NU=;
	b=qx5UU9LEgpSsdTvdNaT7uVKbagJf5skkwD2HUNqAeR5NdgghZd1QMR7jjlYzroiPZd2/
	 2nSuVI+ePrdCXrxhtyvu/abmEVdgxQx8b42A7/YEmm8N1Dqr0uEbGptjcGgkoQcW7lTGB
	 pa3lnfOKz3I6YtNSpdD4ok7ZQioScXzObxtpX2JmKXDkDcT2CrZsOXNmbzeBZblijzmKu
	 jFibEJgWwjNO9lFt4b4L7W9HBVCnctDUcw7hgJ459ziiGoeXfX48vcb1jYDirP9WEe7SA
	 9IyZHeBRsBjqe1wCar7mmiscbKWolKwD2ELyzil1c+gOzBkpu5I9W6NH5jW7Z/NQ3gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=r2papFc5;
	arc=none smtp.remote-ip=195.121.94.184
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051CF606A322
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 051CF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=r2papFc5
X-KPN-MessageId: b26e88a6-cff2-11f1-a3d1-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b26e88a6-cff2-11f1-a3d1-005056994fde;
	Sat, 24 Oct 2026 23:34:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=9jkkQ4t+J9o+IePrPfR3Ab6g6inLOJoRbMgYz7UJ/NU=;
	b=r2papFc5QXQ61BJ+ncBtX5ru/pseR8F/fwgQUmEtrDLRMn0dpQho5WXRi9HORSYj2GWLAC9Wbi1O6
	 wlr32I8CxyVE2pEyqO5h9hIdVA9yRIOk1J8j1eN+7UWiz8c1mJHGbU2mLPxWjOHpl7mDSZEz2sxCTl
	 qgdmLu+rC0R6q4Mqyh0r9NqpT1CqQRZZCdmetHIF2xIpt5CX/RgkunKnCZXJdgqAnII5M2DjB6S35J
	 +aK8sF+Cs3qozDVPMzWNCXq0vW3gnXb4gNKpmH3cT7vPfnLinFokvm+/7xT5PGwwR1ERRz3uR8zcEX
	 KcSyM/7E0LxQipvMdG8HzvpLySMzGCQ==
X-KPN-MID: 33|BA+JGkQutz4Xtr17pqSLz2DbJ+5C7aRPvCi8wiwrwAAFuGY+LmW+nYobFOr1sUF
 0xUXRfjiN3uXwTd7fxyfMin9FJR6RVyfDvwCC6hRR02Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|D2xwUxXnCh4KdaHJbIIw0xhkFJxVj2WcCguHK6l+3ILHYXcHZluL7/in3TwtY0G
 GG+NasPLSULW8K/ciSLxhgQ==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id b2350ed9-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:30 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	neil@brown.name,
	cyphar@cyphar.com,
	jlayton@kernel.org,
	amir73il@gmail.com,
	shakeel.butt@linux.dev,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v8 05/12] vfs: lookup_open(): use vfs_create_no_perm()
Date: Sat, 24 Oct 2026 23:35:32 +0200
Message-ID: <20261024213539.1307600-6-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
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

We can replace the code in the no create_error/negative dentry found
from lookup case in lookup_open() with the vfs_create_no_perm() helper.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 45c2de449927..8b8e248edfeb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4167,7 +4167,7 @@ static inline umode_t vfs_prepare_mode(const struct mnt_idmap *idmap,
 }
 
 static inline
-int vfs_create_no_perm(struct mnt_idmap *idmap, struct dentry *dentry,
+int vfs_create_no_perm(const struct mnt_idmap *idmap, struct dentry *dentry,
 		       umode_t mode, struct delegated_inode *di)
 {
 	struct inode *dir = d_inode(dentry->d_parent);
@@ -4430,8 +4430,14 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 		}
 		dput(dentry);
 		dentry = ERR_PTR(error);
+	} else {
+		if (file->f_mode & FMODE_CREATED)
+			fsnotify_create(dir_inode, dentry);
+		if (file->f_mode & FMODE_OPENED)
+			fsnotify_open(file);
 	}
 
+
 	return dentry;
 }
 
@@ -4583,22 +4589,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
-	if (error)
-		goto out_dput;
-
-	error = dir_inode->i_op->create(idmap, dir_inode, dentry, mode);
+	error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
 	if (error)
 		goto out_dput;
 
 	file->f_mode |= FMODE_CREATED;
 out:
-	if (!IS_ERR(dentry)) {
-		if (file->f_mode & FMODE_CREATED)
-			fsnotify_create(dir_inode, dentry);
-		if (file->f_mode & FMODE_OPENED)
-			fsnotify_open(file);
-	}
 	if (shared_flag)
 		inode_unlock_shared(dir_inode);
 	else
@@ -5226,13 +5222,6 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 			/* Drop the extra reference */
 			dput(orig_dentry);
 
-		if (!error) {
-			if (file->f_mode & FMODE_CREATED)
-				fsnotify_create(dir->d_inode, dentry);
-			if (file->f_mode & FMODE_OPENED)
-				fsnotify_open(file);
-		}
-
 		path->dentry = dentry;
 
 	} else {
-- 
2.56.0

