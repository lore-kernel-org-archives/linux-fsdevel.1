Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBDA3B3C03
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174399; cv=none; b=DIfn4zD798flZXWPSVGd3YWA0F85U/bEctJANocKOjpm39ZF4IQlz75OR5tEbRGMESsEJA+25DhFBev4bFZjgIFx4XW3YHwQ8RNETJfBaAgJdvwkSL4lBtZhkoPctW9U9rin0AsP6fzSA+VIkOjtBzOoQtmgRojP2lOOwgtuTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174399; c=relaxed/simple;
	bh=7XGECBozP1WkL643RMlP0q5mtdLpw6N+zHE4JrV2++s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OITNHVwnLfMNk16xXgm03SVTMkBCUyqQXG80hR35UNFX9xy6QbKW+upyjloVQUcHdCdKuZEgnPVsFR7AoUzAU2/wDj0P0rfe+s7D08t+DWG5tyXCpMV+f/FZNqs6BjBm79XEs/E2vQnRRh6RKwhHXgmctFMEParSbJJ7ouywLQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=svv6etF1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="svv6etF1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HbftWAzH06Rn04EwuvGPifvrW4pT/dq25bSX2WmS5aY=; b=svv6etF1ALzRlrcp6/VuFUsLc8
	/LUarsnShKZqQzQM13aa7xG+wXhQAy1bkRs0sPjZDL/Ma4x2TBiTLurzI9sAvvpJVo6wx0bkcoZxi
	Wt6nP3izXD5e+FFvCy+JCtTN/GBnmVEZXzRB3tF5ObfGqRO53eDHmxnNzb3j021tq+ZjCgvgn5BYO
	z43I43/P+uDTz67GLPu1wtZi14eV6VYfImgxoc0r3cyqJGL1AYRq76SYB12uXbNERdynHYU95gixW
	HsQY7TBfvxPXnuveiSkRrJcKtsHeenZzKApG/v8/1csF73LKqdlXpIzKPjfmq6e3ATy/DPSqm9cF6
	VcDifQRA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXC-00000008Uwc-227t;
	Tue, 19 May 2026 07:06:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 12/14] configfs: mark pinned dentries persistent
Date: Tue, 19 May 2026 08:06:31 +0100
Message-ID: <20260519070633.2025485-13-viro@zeniv.linux.org.uk>
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

on the removal side we can (finally) get rid of __simple_unlink()
and __simple_rmdir() kludges now that dentries in question are
properly marked persistent - simple_unlink() and simple_rmdir()
will do the right thing for those.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c     | 13 +++----------
 fs/configfs/symlink.c |  3 +--
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 6d9c6a5b17ff..740ea2c115bd 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -314,9 +314,7 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
 	inode->i_fop = &configfs_dir_operations;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
-	d_instantiate(dentry, inode);
-	/* already hashed */
-	dget(dentry);  /* pin directory dentries in core */
+	d_make_persistent(dentry, inode);
 	inc_nlink(d_inode(p));
 	item->ci_dentry = dentry;
 	return 0;
@@ -384,8 +382,7 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
 
 	inode->i_link = body;
 	inode->i_op = &configfs_symlink_inode_operations;
-	d_instantiate(dentry, inode);
-	dget(dentry);  /* pin link dentries in core */
+	d_make_persistent(dentry, inode);
 	return 0;
 
 out_remove:
@@ -412,12 +409,8 @@ static void configfs_remove_dir(struct dentry *d)
 	configfs_remove_dirent(d);
 
 	if (d_really_is_positive(d)) {
-		if (likely(simple_empty(d))) {
-			__simple_rmdir(d_inode(parent),d);
-			dput(d);
-		} else {
+		if (unlikely(simple_rmdir(d_inode(parent), d)))
 			pr_warn("remove_dir (%pd): attributes remain", d);
-		}
 	}
 
 	pr_debug(" o %pd removing done (%d)\n", d, d_count(d));
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index f3f79c67add5..31eb28b27309 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -229,9 +229,8 @@ int configfs_unlink(struct inode *dir, struct dentry *dentry)
 	spin_lock(&configfs_dirent_lock);
 	list_del_init(&sd->s_sibling);
 	spin_unlock(&configfs_dirent_lock);
-	configfs_drop_dentry(sd, dentry->d_parent);
-	dput(dentry);
 	configfs_put(sd);
+	simple_unlink(dir, dentry);
 
 	/*
 	 * drop_link() must be called before
-- 
2.47.3

