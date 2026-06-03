Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EE407576
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472908; cv=none; b=eqtvhF7JlbhsmZeLUR0WlZqPVFJ2qVQeUNSkYB+kYm+H1w5nlzJkbeZOWZl5uvuAIliNSSeZNGAOY2GA0t/gMrsPxhWyW5DYeyRHmuxg9grzwbtgDjT/J2eO8iVC3pug6ytuFuWuGfisxBB1mKa2zvBTT2gBuxRLzpiW8O04454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472908; c=relaxed/simple;
	bh=qXBeUR8siHfo9F7jSGywClktpzXkgALoJQ/3XpFwSLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6gwkKD9R2iaFVUNUSjuVvqTM81xPf6/gOCfYlOI7T0fawTX8pC9iw3yw6drJIkXQo3oVDOvAZqrK/3SoChB/acG72rqaTMbEqKEXfdHokawv6kzepu58q5JA23fKmPLy0fzP7Fsdt3iVOgCGLmbQz4VLeihqeg9w9HS9+BAot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QdcnFAO+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QdcnFAO+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3B7lpI+x6aLvVRs2D17lv+e7KvssSz96YiGGzLN6zGs=; b=QdcnFAO+oeEKFhxzRjnI+1A29W
	p/FJNO4pg2FA8DiCy3Ef9cF5mIk6Cz/ezAX6LFhQEUaQPLTKnf34pYp4nEAGLFI1J017UoHbhL4Tk
	50GlUkq08fS4mnXKYJZ/3/R+jJ3hpLfuodzlVpJNaL79kwV3pP/TB/VtMaA6A62TX8kMyLvhYoY0v
	zmSed0M9hDwcDXJk2pIbFr+u9vhV7xZxpQeRDoIkMlDYDAvdLcqMRSMp2NQuZME+5fLtIwZXnRplP
	YW1TNMWd+QSX87BEZrfKy/On8sn/avEZORany0gMYYlKIH0YxfFgMww6iFYR1LIAV5H8jwRtA8qPy
	SlP7B9vA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKo-0000000CjGo-18nz;
	Wed, 03 Jun 2026 07:48:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 12/18] configfs: dentry refcount needs to be pinned only once
Date: Wed,  3 Jun 2026 08:48:09 +0100
Message-ID: <20260603074815.3033766-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

currently we have a weird situation where
	* symlinks and roots of subtrees created by mkdir are pinned once
	* subdirectories of subtrees created by mkdir are pinned twice
	* roots of subtrees created by register_{group,subsystem} are pinned
twice.

It makes things harder to follow for no good reason.  The goal is to
encapsulate the unbalanced dget/dput into d_{make,discard}_persisitent()
and, preferably, allow a use of simple_recursive_removal() or analogue
thereof.  So let's regularize that and pin things only once.

create_default_group() and configfs_register_subsystem() don't need to
keep their reference around on success - configfs_create_dir() has pinned
the sucker already.  So we can drop the reference passed to
configfs_create_dir() (via configfs_attach_group(), etc.) both on success
and on failure.  On the removal side we no longer have the double references,
so we need an explicit dget() to compensate.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 87a0847d88b9..4836ffb3b70f 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -657,7 +657,7 @@ static void detach_groups(struct dentry *dentry)
 		if (!(sd->s_type & CONFIGFS_USET_DEFAULT))
 			continue;
 
-		child = sd->s_dentry;
+		child = dget(sd->s_dentry);
 		spin_unlock(&configfs_dirent_lock);
 
 		inode_lock(d_inode(child));
@@ -708,8 +708,8 @@ static int create_default_group(struct config_group *parent_group,
 		} else {
 			BUG_ON(d_inode(child));
 			d_drop(child);
-			dput(child);
 		}
+		dput(child);
 	}
 
 	return ret;
@@ -1781,7 +1781,7 @@ EXPORT_SYMBOL(configfs_register_group);
 void configfs_unregister_group(struct config_group *group)
 {
 	struct configfs_subsystem *subsys = group->cg_subsys;
-	struct dentry *dentry = group->cg_item.ci_dentry;
+	struct dentry *dentry = dget(group->cg_item.ci_dentry);
 	struct dentry *parent = group->cg_item.ci_parent->ci_dentry;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
@@ -1896,12 +1896,12 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 		if (err) {
 			BUG_ON(d_inode(dentry));
 			d_drop(dentry);
-			dput(dentry);
 		} else {
 			spin_lock(&configfs_dirent_lock);
 			configfs_dir_set_ready(dentry->d_fsdata);
 			spin_unlock(&configfs_dirent_lock);
 		}
+		dput(dentry);
 	}
 
 	inode_unlock(d_inode(root));
@@ -1920,7 +1920,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 {
 	struct config_group *group = &subsys->su_group;
-	struct dentry *dentry = group->cg_item.ci_dentry;
+	struct dentry *dentry = dget(group->cg_item.ci_dentry);
 	struct dentry *root = dentry->d_sb->s_root;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
-- 
2.47.3

