Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C03E44E0
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325370; cv=none; b=HpCUWasDcnrsKy0WMJwqWxwYEdXtck30aLpNsFt/cb3+vLVPCIhYZIp69abRVa7ck2E28yMzeeDo9Q/eGQNV8EwFrXsdspCVVFJoj4n+A/aVOiQKTdTU3rDMebvGmvaSplFrS7WsHLRimGtqsydd6y9UN3ojYm/MvLN/jVDPy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325370; c=relaxed/simple;
	bh=XqjTRSAeusxjIvb88nvpx2e0wRq44xzIeWwFjEgozjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOtrE/HUQg8PMMmCWBoMRMWDHFuSs57Iqd3MP55lxCS8rF+QrReX4WdWAJODFyc6KmQmn48+g+z1f03i7rjwgBO/mXACx8rmhASzjie0a0MFeWg8ynSyccrMyjEG7jL70xG5+o43zmciiNOH7MCoKLr0vgF3ip6nkSNKahN7aE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=hqAGKD2C; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="hqAGKD2C"
X-KPN-MessageId: d4d3bcc3-afa3-11f1-83b4-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d4d3bcc3-afa3-11f1-83b4-005056ab378f;
	Sun, 13 Sep 2026 20:49:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=cy7joNni2CrQLvwbxj313gtPlwa2FaN78EUx0NBwmA8=;
	b=hqAGKD2C3uKTXolIotZ/b6MsW0k+V52RGdI1uUFcACNckFpjcp5EPfiF2+mY2tGsvBPN7QWEzVSDw
	 Jh0MHT85d2Y7UjirEVsvn22sjI1f2dH/5lJVjNoIt2J0oPlzA/X0Bmft7Z3ajTDloDAhbk+aQ/E5hp
	 jZOtMVwqFhaxr2ud4zq9HmZA0frI2l5n8UHDqadxmvJxg9Bc8wBOLNesGNX6Y81Lz6KpGstruTQWwm
	 3rJqzkzIPep2JBCuTJxJt7NtT/a9ZD72KeIbtBvecZ42t4GyLvBKoKvNCGgLabuFgSzF+G45PJ5yBs
	 kjUD5kbZFzzZKzjPTxYoHrqkq59qknA==
X-KPN-MID: 33|zsZ60YH4g4xW5cNEZAWv56vNMlKRW86APWQ0Oe+ZcC+/WGOyA4hFA73cNpZZxSt
 Hz/Qremx1HaWhevxZ5rlGeaw27dr6rxVWW+31Iimch+o=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|H8sS7t4Kh9QsZRaMGpmZrnZ4tpYncHUSMyoM33kJtj1L839lf+uffQwaXY27yGK
 B3EQITgRBFcTVFZKoRZBQOA==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id d499945f-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:20 +0200 (CEST)
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
Subject: [PATCH v6 05/12] vfs: lookup_open(): use vfs_create_no_perm()
Date: Sun, 13 Sep 2026 20:50:09 +0200
Message-ID: <20260913185016.523376-6-jkoolstra@xs4all.nl>
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

We can replace the code in the no create_error/negative dentry found
from lookup case in lookup_open() with the vfs_create_no_perm() helper.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e1cdece42c9b..90c8be0257be 100644
--- a/fs/namei.c
+++ b/fs/namei.c
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
 
@@ -4581,22 +4587,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
 	if ((open_flag & O_CREAT) || create_error)
 		inode_unlock(dir_inode);
 	else
@@ -5216,13 +5212,6 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
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
2.55.0

