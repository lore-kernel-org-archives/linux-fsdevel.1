Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9E2356BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174400; cv=none; b=Bj5yx47kXnQwLiVrPAMOggq7Z6Ldq+eGU07iTztCD5iJpC9uJprjCbyLho5rEqLn9j7qkJI23iGJM+TKOLMFuegL/snS2DnfUwiUcTAOFN1Mvkjxqv+eAxgIXLipdbQRBQV5NcY8b0tIjBRrz+AFVzpK01UGqchUBV5DZqYiV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174400; c=relaxed/simple;
	bh=dg5BmgZrpAUqPGL7wSdJEqfvHR+e4BprDjr7DpvcPxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdxbLNhmwfl3ZuJPon92Z/3ZUcXglW3O1Op+wl0TJ0/rS5CAHRT9FGQ92muKvAaStnzZNN6t5JyhwsMz3Pn+wnx4TOf8JIbFuSjDqqosCUKiEKjAR43kZQ3nsC5Kon92QwR9pG2NS64IHl1W0ULgy5YDt6806pGl1BXflabUKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QA/nUG9/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QA/nUG9/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HMzg/gEwiXkwxwvApBJEYOKnnOu+1EoBbfbKUwDDaus=; b=QA/nUG9/GAIEYkzzEvD8hS17h/
	2YpFyZe3JJdUcwvwUCPbUEIbMNR77KTfwLapwbe2Cj6Mo2zvuNWPOtrGw6ezwpjHZXuHEr47mLeZ6
	0zOcf1XLc7929SwytFqKSguO8m0anL0hr6RqBKCwaAzG35eNyPetAguUggT1cqD5TBUjy6FMeKSMa
	VFhgCPI1Vcsgd1eYtXxbhZddmcScoJl9Kw3RwtkckVKpCOEasPqloelG+bxc69qNIv4yAXPlwckYv
	sZylWUZ2jBMaZvEMMtJb6X7/iZeAc2d/uC2rkKVQQgb/AEs8VlQpVAvSHAEXBn77Di+3+FQS1Zr88
	rkB0OsHg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXC-00000008UwV-1a8Z;
	Tue, 19 May 2026 07:06:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 11/14] configfs: dentry refcount needs to be pinned only once
Date: Tue, 19 May 2026 08:06:30 +0100
Message-ID: <20260519070633.2025485-12-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 39a496749dc2..6d9c6a5b17ff 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -635,7 +635,7 @@ static void detach_groups(struct dentry *dentry)
 		    !(sd->s_type & CONFIGFS_USET_DEFAULT))
 			continue;
 
-		child = sd->s_dentry;
+		child = dget(sd->s_dentry);
 
 		inode_lock(d_inode(child));
 
@@ -683,8 +683,8 @@ static int create_default_group(struct config_group *parent_group,
 		} else {
 			BUG_ON(d_inode(child));
 			d_drop(child);
-			dput(child);
 		}
+		dput(child);
 	}
 
 	return ret;
@@ -1754,7 +1754,7 @@ EXPORT_SYMBOL(configfs_register_group);
 void configfs_unregister_group(struct config_group *group)
 {
 	struct configfs_subsystem *subsys = group->cg_subsys;
-	struct dentry *dentry = group->cg_item.ci_dentry;
+	struct dentry *dentry = dget(group->cg_item.ci_dentry);
 	struct dentry *parent = group->cg_item.ci_parent->ci_dentry;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
@@ -1869,12 +1869,12 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
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
@@ -1893,7 +1893,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
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

