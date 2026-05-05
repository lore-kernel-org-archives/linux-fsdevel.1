Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039633CF02B
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960449; cv=none; b=Qdz7XJhHrFp2FguyeTNgqGmeYxkKtAN2sS5nt8UhZPA8at257pR5+fbR6z5aKT/Pc16MNsO19KLJ+U8af/s+Athot7VNoviCx4NWfvMHDbI2Ub3igSSgnEScYn2yXHN5b+ZXo7a5SZ/80ZONZI4oSfkf3f9HUciwfr6+3VB23+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960449; c=relaxed/simple;
	bh=IB8WfHb/q4dWCtMODhdupEzxoifDQsrULr+Bv0C6kN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aphIkhNMkpocY5GBo07mgJ6TwGm6u40ypOFechbEOBDExTiGz66YJcphZBY9NseEPM1EQbd9mQeMRgbwOfPUHkxS1ydonVzPtvs6zSnRjgD4WjAp3/lpYbca7U2rhgdDj75drZdELHamYwVWyNDfZMdbY+cEPYKsuUWGyV55+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Hc+sjtTs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Hc+sjtTs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3wWcvgGrF8CxAVBv90cSykRA454X2OQwx3EbJdTm/54=; b=Hc+sjtTshyH8ppZZeYcezZk5QI
	mwX8y+gVX4ObbHhAxrPWipv0HTG/KhBM5ggaqj78H/nGjZEcDvZymPn6e1rirtNYMAPuB6YkSVddn
	FqdX8gn9ihBl2h6X/CJsiPSjVwCrZINhWyicjfqwl+W9VJeCuZ3ylz2FilRsAohCaPvLrO+W5aCg4
	+fySJQHU5Et6tiGUHF7MId6a55+2cGKMSEXUSXNI/VDgb/kkoExyN4vPJqYtHHgAVxfmdLnms2a9g
	7wtsFhGw1CbsvNeu+tJXXXsCe36D0hsT5vg9cZohPz92GLK2RmRkR2xkSE6Y9tJ+k8xU1o3KquvhR
	H1nQAQRg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jh-00000005IAA-3rMv;
	Tue, 05 May 2026 05:54:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 24/25] nfs: get rid of fake root dentries
Date: Tue,  5 May 2026 06:54:11 +0100
Message-ID: <20260505055412.1261144-25-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... just grab the reference to the (real) root we are about to return
for the first mount of this superblock and be done with that.

Once upon a time dentry tree eviction at fs shutdown used to break
if ->s_root had been spliced on top of something; that hadn't been
the case for years now, and these fake root dentries violate a bunch
of invariants.  Let's get rid of them...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c      |  8 ++------
 fs/nfs/getroot.c | 35 ++---------------------------------
 2 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 12f1143d479a..2b5cf6e52ed6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -455,14 +455,10 @@ static void dentry_unlink_inode(struct dentry * dentry)
 
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_clear_type_and_inode(dentry);
-	hlist_del_init(&dentry->d_alias);
+	__hlist_del(&dentry->d_alias);
 	/*
 	 * dentry becomes negative, so the space occupied by ->d_alias
-	 * belongs to ->waiters now; we could use __hlist_del() instead
-	 * of hlist_del_init(), if not for the stunt pulled by nfs
-	 * dummy root dentries - positive dentry *not* included into
-	 * the alias list of its inode.  Open-coding hlist_del_init()
-	 * and removing zeroing would be too clumsy...
+	 * belongs to ->waiters now.
 	 */
 	dentry->waiters = NULL;
 	raw_write_seqcount_end(&dentry->d_seq);
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index eef0736beb67..ff7424bc4bec 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -32,35 +32,6 @@
 
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
 
-/*
- * Set the superblock root dentry.
- * Note that this function frees the inode in case of error.
- */
-static int nfs_superblock_set_dummy_root(struct super_block *sb, struct inode *inode)
-{
-	/* The mntroot acts as the dummy root dentry for this superblock */
-	if (sb->s_root == NULL) {
-		sb->s_root = d_make_root(inode);
-		if (sb->s_root == NULL)
-			return -ENOMEM;
-		ihold(inode);
-		/*
-		 * Ensure that this dentry is invisible to d_find_alias().
-		 * Otherwise, it may be spliced into the tree by
-		 * d_splice_alias if a parent directory from the same
-		 * filesystem gets mounted at a later time.
-		 * This again causes shrink_dcache_for_umount_subtree() to
-		 * Oops, since the test for IS_ROOT() will fail.
-		 */
-		spin_lock(&d_inode(sb->s_root)->i_lock);
-		spin_lock(&sb->s_root->d_lock);
-		hlist_del_init(&sb->s_root->d_alias);
-		spin_unlock(&sb->s_root->d_lock);
-		spin_unlock(&d_inode(sb->s_root)->i_lock);
-	}
-	return 0;
-}
-
 /*
  * get a root dentry from the root filehandle
  */
@@ -99,10 +70,6 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		goto out_fattr;
 	}
 
-	error = nfs_superblock_set_dummy_root(s, inode);
-	if (error != 0)
-		goto out_fattr;
-
 	/* root dentries normally start off anonymous and get spliced in later
 	 * if the dentry tree reaches them; however if the dentry already
 	 * exists, we'll pick it up at this point and use it as the root
@@ -123,6 +90,8 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		name = NULL;
 	}
 	spin_unlock(&root->d_lock);
+	if (!s->s_root)
+		s->s_root = dget(root);
 	fc->root = root;
 	if (server->caps & NFS_CAP_SECURITY_LABEL)
 		kflags |= SECURITY_LSM_NATIVE_LABELS;
-- 
2.47.3

