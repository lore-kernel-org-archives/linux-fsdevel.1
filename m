Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383C427A0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747414; cv=none; b=f0usks5SJnbcTl5rUR41kuKCDNethtqovF7hTPhN23vKhvFKq63x+oi+D56RQ+cDDr8Pp/d4nPED1B2PldfOibqRLPFpVY74mH3MbTN7/7abFd6ZsoQrrsLI9aL+M95LW7p013D93IIj3bW15Yzj9P43EdLpt4n1GICU++KIIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747414; c=relaxed/simple;
	bh=kAYBoyOLpCYkr0RPQ7qsWlseqnbRZM6MEuUF2uLNZkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHf7gktUvMTxi/reVQyVh5ckzVJU7K+b/aBOcfcpD71lsDrEbeabuXQT/1Y0CCJscFXTwObBynSGNwEUosIT2BOj7WyMtLbb21ojtTl+L4UC5MVMUeX3Oo7wEZoMM1l7otxej2E7m9QsVwXiC2qzEi2p75Y0oF7n3y167LHX/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=nYAx3ZMR; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="nYAx3ZMR"
X-KPN-MessageId: 3219674a-73d0-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3219674a-73d0-11f1-bfba-00505699b430;
	Mon, 29 Jun 2026 17:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=oB+rqMMzSki8Vq0oSn92xDaW+LG7pclchsnXtOgcwy8=;
	b=nYAx3ZMRwJTn3QusdNqHoAk3pntRLMAqsKp+NcqYSavRmgSkxvoNCEvsFi8bQKSrNylrIn3/OlQWC
	 6zsiLGV5mwzfMIt6PGnkeSOlVRB8hrOssasops+aiwVHYaumuL4N080jXj7PxzplGk97bJhnYVG+Dk
	 63rmjauQbWnWsM8Wf2QIe3J534E8HCudOTqbqD6DC2ySHdebmMcn9GgQiu+oUV3AuOqezQ1KcJoaJG
	 f6RTbHjWD5GwIgnnei9QPD2tg6iqtu5wxl9l0+ZkS7DneQS8kr9alBhItfvkbQzVn3V6vVOswtkHyM
	 3JT7BkZXhmP4lCy3/3vgAKHxyU1xgug==
X-KPN-MID: 33|VmdrfwHLHqG/U9b0oUMXvcDY9ALAu7Fj7pA+TtoWP+Euxf/MI77q6V12IhHS4D7
 BxPPy/E3ZJ6SMG3yL8wBgHg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|iL3MEb/t2v013yJV75igjALvtjIv7COPqX9XNuy6XE13lvF1aaICN0IHer2kKzr
 Bd+dAgFxwSCv0q3Zlm+3/Hg==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 31dd1c2a-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:45 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neilb@suse.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 04/14] vfs: call audit_inode_child() in lookup_open() on failure too
Date: Mon, 29 Jun 2026 17:36:20 +0200
Message-ID: <20260629153630.2158649-5-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
References: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

audit_inode_child() is called in may_create_dentry() so that failed
filesystem operations still register an audit entry. On success, the
entry is overwritten when, for instance, fsnotify_create() is called.
This is the calling convention in vfs_create() and vfs_mkdir().
In lookup_open(), however, when atomic_open() should have created a
file but didn't, no call to audit_inode_child() is made. The same is
true for the regular ->create() path.

Fix the calling of audit_inode_child() in lookup_open() to match the
vfs_create() path. Note that if ->atomic_open() returned an error
other than -ENOENT while trying to do a create, the audit is skipped.
There is no way around this because we can't know at the vfs level
if the error was due to a failed lookup or failed create.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 60 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9cdc9191dcda..4f747546ff3d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4462,7 +4462,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		dentry = NULL;
 	}
 	if (dentry->d_inode) {
-		/* Cached positive dentry: will open in f_op->open */
+		/* Cached positive dentry: will open in do_open(). */
 		return dentry;
 	}
 
@@ -4494,11 +4494,23 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (create_error)
 		open_flag &= ~O_CREAT;
 	if (dir_inode->i_op->atomic_open) {
+		struct dentry *orig_dentry = dentry;
 		if (nd->flags & LOOKUP_DIRECTORY)
 			open_flag |= O_DIRECTORY;
+		dget(orig_dentry);
 		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
-		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
-			dentry = ERR_PTR(create_error);
+		error = PTR_ERR_OR_ZERO(dentry);
+		if (unlikely(error))
+			dentry = orig_dentry;
+		else
+			dput(orig_dentry);
+		if (unlikely(create_error) && error == -ENOENT) {
+			/* Should have done a create, but we already errored. */
+			audit_inode_child(dir->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
+			error = create_error;
+		}
+		if (unlikely(error))
+			goto out_dput;
 		return dentry;
 	}
 
@@ -4515,33 +4527,37 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			dentry = res;
 		}
 	}
+	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {
+		/* No need to create a file. If lookup returned a positive
+		 * dentry, the file will be opened in do_open(). */
+		return dentry;
+	}
+
+	/* Negative dentry with O_CREAT flag set */
+	audit_inode_child(dir->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 
-	if (unlikely(create_error) && !dentry->d_inode) {
+	if (unlikely(create_error)) {
+		/* Should have done a create, but we already errored */
 		error = create_error;
 		goto out_dput;
 	}
 
-	/* Negative dentry, just create the file */
-	if (!dentry->d_inode && (open_flag & O_CREAT)) {
-		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
-		if (error)
-			goto out_dput;
+	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
+	if (error)
+		goto out_dput;
 
-		file->f_mode |= FMODE_CREATED;
-		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
-		if (!dir_inode->i_op->create) {
-			error = -EACCES;
-			goto out_dput;
-		}
+	file->f_mode |= FMODE_CREATED;
+	if (!dir_inode->i_op->create) {
+		error = -EACCES;
+		goto out_dput;
+	}
 
-		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
-						mode, open_flag & O_EXCL);
-		if (error)
-			goto out_dput;
+	error = dir_inode->i_op->create(idmap, dir_inode, dentry,
+					mode, open_flag & O_EXCL);
+	if (error)
+		goto out_dput;
 
-		fsnotify_create(dir_inode, dentry);
-	}
+	fsnotify_create(dir_inode, dentry);
 
 	return dentry;
 
-- 
2.54.0

