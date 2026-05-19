Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810A1DF248
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205049; cv=none; b=lC9G6+QtEiqDG4OVwQZHD+/K5Z4GxVBUZIKtoQ+8XQX5V9zadJyfV/uK+YFCjjj6cVlr5cOkmL5ghPgVLrIF8hU9c+shhJex2LQnOa6e/xqUr9I59WFYhLLy1TbM6oAVTEViAn5tbdqpWCwtwVwQ3ALmc1qCrYXvFYiF5AzwK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205049; c=relaxed/simple;
	bh=Sh7LFiVKxwXoK7jptZ6oSsZnZHvPgosZSHYuc/e4HVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1Jhmo7LQcbk0JlLW6KB62vp4d5thmu+yWLUxhvuGSwY9rzyfYY5TFnm/Lrrq/9mqw8/0mRG8uVnGQ+CRtRjzQwtqfhFppYp5C1sePZ6V7UKZGqEmz9/SVlfinzzd0sZ6Gac/Kf//nplVUm+/yHZUGt53wYa7uGIRv4vdMGM+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vRYrD3AU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vRYrD3AU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2f5A6PcKAnLUbi/ATO3HyrZSeUaidFLP2ZDVtBins2E=; b=vRYrD3AUJQf+ibdSuTO4kx5aqo
	bdV9YDEbSusvaZT7qk+ui/65jLtK81lzkH083fBQ/wRlS2nUum2EFpwQ+L0NhgxIV8HiOb36XNInK
	Bsr+N38WyKR9TQpGREJegqi1Fczs/fQdmRPmEWErpeHYF/AbtsqZU/T2lG73UOyglKVdh2rsLH9UT
	znXp/ghw48KX/YBKzm+VVtXM1ul0kP/E7SFZXHINJinAtzpV/aI6vz15j0uOjtBZcSd7xvQhAw8EQ
	KLm9I8q3Ot4pDklQA46M7+zxaEpa6Ip5fY0F/yr+loHkMupMm1dcyrWSfgyy31+zupWxrKUr0vHTw
	yTN4Bk1A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPMVY-00000009TGm-0QY2;
	Tue, 19 May 2026 15:37:24 +0000
Date: Tue, 19 May 2026 16:37:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 13/14] kill configfs_drop_dentry()
Message-ID: <20260519153724.GD2636677@ZenIV>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-14-viro@zeniv.linux.org.uk>
 <ugllhpqcy62ludmg2wgc4dcsmm4z4m6pgpzdhcehkp7jvxnf4d@6mxgiskj5ct7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ugllhpqcy62ludmg2wgc4dcsmm4z4m6pgpzdhcehkp7jvxnf4d@6mxgiskj5ct7>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 19, 2026 at 03:12:56PM +0200, Jan Kara wrote:

> Why is it safe to call dget_dlock() here? We hold only configfs_dirent_lock
> so cannot we race with somebody doing dget() on the 'child' dentry? Even if
> it is indeed safe for some reason I'm missing, it would deserve a comment I
> guess?

Because of the braindamage on conflict resolution.  Thanks for spotting,
fixed and force-pushed.  Updated version of commit:

commit 85863f5773c15f02ff6518ad034e3b380b78ca53
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue May 12 12:53:35 2026 -0400

    kill configfs_drop_dentry()
    
    Fold into the only remaining user, don't bother with the timestamps
    of parent - we are going to rmdir it shortly anyway, which will
    override those.
    
    Fix the locking of inode, while we are at it - updating the link
    count and timestamps ought to be done with the inode locked.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

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
index 740ea2c115bd..a68b4a9241c0 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -562,12 +562,33 @@ static void detach_attrs(struct dentry *dentry)
 
 	parent_sd = dentry->d_fsdata;
 	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
+		struct dentry *child;
 		if (!sd->s_element || !(sd->s_type & CONFIGFS_NOT_PINNED))
 			continue;
 		spin_lock(&configfs_dirent_lock);
 		list_del_init(&sd->s_sibling);
+		child = sd->s_dentry;
+		if (child) {
+			spin_lock(&child->d_lock);
+			if (simple_positive(child)) {
+				dget_dlock(child);
+				spin_unlock(&child->d_lock);
+			} else {
+				spin_unlock(&child->d_lock);
+				child = NULL;
+			}
+		}
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
