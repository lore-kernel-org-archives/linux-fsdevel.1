Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4E3F788A
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325378; cv=none; b=m5AwAdSP+dPj/xI/tRW2PNrWBA9Rvl6Et1Myz6QdS7NC2lFfWfDCmoSacmaR5L2LMtLe1CWhQw36qMzaVHD15Igb26XPRT/OSE79E8719TSxjjjUD3eknnrf3rvNb5p7vE29H5O7Yb3sAQsi2ypGVUPJSnWdpDnpMhrUS8yHlWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325378; c=relaxed/simple;
	bh=m7XSGu+/MVEE/A4Ak5fwrpyK+p674yeU60dUk0JjCls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jREw7fej+dLgyH7jo4J6kuRvGQMDwnVzFlBCT7QZY6YvR6/GoQ0XJ1Vvnl129p/DjiWG1mt8bqo1pqt/JRT9lVQrzCQYiPP05NPBd72f8HvaE40iMISFUdtXwRGoCOBEcBp/Fy9x+j7II70kpoQBcxGQDUusEvmPFomak+N8bbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=tcukTA6Y; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="tcukTA6Y"
X-KPN-MessageId: db16b9c8-afa3-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id db16b9c8-afa3-11f1-b2a8-005056abbe64;
	Sun, 13 Sep 2026 20:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=gmYuawAZ/peOxaHNONnX0nilthKlpl6zgZFvwjd7FvA=;
	b=tcukTA6YlIp6mALHut6LsAu65HA8QuG6XFZvIwQMmle3KUMDAeeHsT4pXLGEKHZ3v962R2na5BNYU
	 ZVgrD38ZEaRVjrD7goe2TxotKjjkNpr8a7uS7oWTPvcub9tlBXdi4NHwj8UuXhtm19ZAklR6mMvzaG
	 1dkip0Aa/YHTOmYyLwiX1F8lcpsdHuxvUjj5+kjh+tEiHu1pjJHULp7p76wa4dWN/RLhHZofH7gL0C
	 cE9VhOgoLIdOvma9w3OIOGKMDFH2ZD1UA+wio6ciCCavddkRQsHhpuov9byFs45RUO+1R8kpncnEmZ
	 HB76OgNRhd560xe7gOQr3RWK9cF805A==
X-KPN-MID: 33|a6Y2HhULI4OyTNThlAru9K0mKxscrxCJtJSxYGTbklqwQ1uzCpaGn7M+K0PzzJW
 LO3mNPin4kV3WQxxDmn9lhm7XDON1hfVHutH6AmM6BlY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zyee0ZaljSniYLVyteu+u9KZIjDdLFQKhVO6WQgpoJI3qLNUnfb1cSJjlNtMQ8E
 OtcyUOs2a0Ume9TpDROwP3A==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id daded0f1-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:31 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v6 08/12] vfs: change ->create/->mkdir operations unavailable errno
Date: Sun, 13 Sep 2026 20:50:12 +0200
Message-ID: <20260913185016.523376-9-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913185016.523376-1-jkoolstra@xs4all.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently filesystems return -EACCES for missing ->create and -EPERM for
missing ->mkdir in vfs_create/vfs_mkdir. Instead of duplicating these
dubious and inconsistent error codes to lookup_open(), change all to
-EOPNOTSUPP.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c                       | 14 +++++---------
 include/uapi/asm-generic/errno.h |  2 +-
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6ff0a3c04f02..f31046f8b3ba 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4224,7 +4224,7 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
 		return error;
 
 	if (!dir->i_op->create)
-		return -EACCES;	/* shouldn't it be ENOSYS? */
+		return -EOPNOTSUPP;
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
@@ -4646,13 +4646,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	/* mimic operation missing errnos of vfs_mkdir/vfs_create */
-	if (create_dir && !dir_inode->i_op->mkdir) {
-		error = -EPERM;
-		goto out_dput;
-	}
-	if (!create_dir && !dir_inode->i_op->create) {
-		error = -EACCES;
+	if ((create_dir && !dir_inode->i_op->mkdir)
+		|| (!create_dir && !dir_inode->i_op->create)) {
+		error = -EOPNOTSUPP;
 		goto out_dput;
 	}
 
@@ -5501,7 +5497,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto err;
 
-	error = -EPERM;
+	error = -EOPNOTSUPP;
 	if (!dir->i_op->mkdir)
 		goto err;
 
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index bd78e69e0a43..c84ebf89c8b6 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -76,7 +76,7 @@
 #define	ENOPROTOOPT	92	/* Protocol not available */
 #define	EPROTONOSUPPORT	93	/* Protocol not supported */
 #define	ESOCKTNOSUPPORT	94	/* Socket type not supported */
-#define	EOPNOTSUPP	95	/* Operation not supported on transport endpoint */
+#define	EOPNOTSUPP	95	/* Operation not supported */
 #define	EPFNOSUPPORT	96	/* Protocol family not supported */
 #define	EAFNOSUPPORT	97	/* Address family not supported by protocol */
 #define	EADDRINUSE	98	/* Address already in use */
-- 
2.55.0

