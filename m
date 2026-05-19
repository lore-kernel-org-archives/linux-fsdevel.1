Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC933B3C10
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174400; cv=none; b=qcQlD3igD4Ti0l/34nH4cAeJmTYs3TnybDaZ2QvscAhsY6WmCBFQyc/dOgHzHTDXZKvCrwnBS54EnUsJnjElDXdx7U2XxzmSHWQU27QQYuoDOO990lIHpcoVUzPUvfw16S76H+n72ar6Fea4xhkwsxzov6waAprHdeuOQut1vJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174400; c=relaxed/simple;
	bh=uLjo2xJaobiMB2l85ZGtmDEcPisizSlb1pZU6aU0QXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bbrb5hs0HHBmJmiwxnCT8/8vMfRtVkLyRgw1PCmHk7iGQ/mWMgglAhh26evtTHKHXZfTLKsONrvOfcdB/KdfQ/ty7uAdFF/kXUUKNTeS/3mgCdadTxkCckmQClmjzoGVq4R1LQ1B7mS8sfQLU/j+zQ95p2FqY8SlUzHlncj5xL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cNd6MYn5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cNd6MYn5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=glTAvMPR2r5XPnJl0cZfY2YIRTHlw/3Xci4WdGNb+hM=; b=cNd6MYn5Ljn+ykE4B08LwC8hMz
	UsPGqgaF7NDDzE7MGJQSUSJOZCtJwfJvJWIUXbMqC+OIiv/sVKILC0xhcZFfIpogBt3A652PZRlu2
	X0/MWb2WZwW2txokykf2b5Ea1p8Ow0eCzPN6EzE7MRGxtLVFeVHJflTay6BS72Tg/YbNnJlJ+A43m
	8nalKbyDRXukDttu7b2KGYBGRx9LFMcqpi2eT+j11HZ2Z2RYG7xlPdOamexlnTeiCq5geYW+u68f1
	syElwxOeXCM6lQj5dYVotCLWISKFgTQkqKgyVeROpwb90+gZZ8d4K2MZSuhviI4+HHeixTvcvnm9d
	iYNUsTkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXC-00000008Uwi-2jnW;
	Tue, 19 May 2026 07:06:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 13/14] kill configfs_drop_dentry()
Date: Tue, 19 May 2026 08:06:32 +0100
Message-ID: <20260519070633.2025485-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Fold into the only remaining user, don't bother with the timestamps
of parent - we are going to rmdir it shortly anyway, which will
override those.

Fix the locking of inode, while we are at it - updating the link
count and timestamps ought to be done with the inode locked.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/configfs_internal.h |  1 -
 fs/configfs/dir.c               | 17 ++++++++++++++++-
 fs/configfs/inode.c             | 22 ----------------------
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index 0b969d0eb8ff..acdeea8e2d69 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -76,7 +76,6 @@ extern int configfs_make_dirent(struct configfs_dirent *, struct dentry *,
 extern int configfs_dirent_is_ready(struct configfs_dirent *);
 
 extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
-extern void configfs_drop_dentry(struct configfs_dirent *sd, struct dentry *parent);
 extern int configfs_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct iattr *iattr);
 
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 740ea2c115bd..a2bb602fb38c 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -562,12 +562,27 @@ static void detach_attrs(struct dentry *dentry)
 
 	parent_sd = dentry->d_fsdata;
 	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
+		struct dentry *child;
 		if (!sd->s_element || !(sd->s_type & CONFIGFS_NOT_PINNED))
 			continue;
 		spin_lock(&configfs_dirent_lock);
 		list_del_init(&sd->s_sibling);
+		child = sd->s_dentry;
+		if (child && simple_positive(child))
+			dget_dlock(child);
+		else
+			child = NULL;
 		spin_unlock(&configfs_dirent_lock);
-		configfs_drop_dentry(sd, dentry);
+		if (child) {
+			struct inode *inode = child->d_inode;
+			d_drop(child);
+
+			inode_lock_nested(inode, I_MUTEX_NONDIR2);
+			inode_set_ctime_current(inode);
+			drop_nlink(inode);
+			inode_unlock(inode);
+			dput(child);
+		}
 		configfs_put(sd);
 	}
 }
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index bc507b720a01..3c26b6c443be 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -195,25 +195,3 @@ const unsigned char * configfs_get_name(struct configfs_dirent *sd)
 	}
 	return NULL;
 }
-
-
-/*
- * Unhashes the dentry corresponding to given configfs_dirent
- * Called with parent inode's i_mutex held.
- */
-void configfs_drop_dentry(struct configfs_dirent * sd, struct dentry * parent)
-{
-	struct dentry * dentry = sd->s_dentry;
-
-	if (dentry) {
-		spin_lock(&dentry->d_lock);
-		if (simple_positive(dentry)) {
-			dget_dlock(dentry);
-			__d_drop(dentry);
-			spin_unlock(&dentry->d_lock);
-			__simple_unlink(d_inode(parent), dentry);
-			dput(dentry);
-		} else
-			spin_unlock(&dentry->d_lock);
-	}
-}
-- 
2.47.3

