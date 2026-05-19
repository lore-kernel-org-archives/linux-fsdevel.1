Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE53B3C19
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174401; cv=none; b=XF5bKEiFcO0yGE5GPOCq1+k5h02/FrxqjoWB1IFDqx4grq22KmOlJNQUeAHgir5V8C7lzfQcoOO4D54w614jLlDg6ev5w2+m4IAbirahLrRmXys+kXIDBzh0Doht2KCkMH9p93ocb/9d6Xe1915Km65nAbhd2jwB80HmRkpJHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174401; c=relaxed/simple;
	bh=DwT3UmZTbMRq4hnxFpqTUzPdIQSAib5R16D7PpVOD/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2j8wV/wI5wq8BPZadvtb0D/lpNGQWWzOMqMHyck2Sv77q0k1+sB2gAnvSh3fRi6PWvOhdJAe5ICDYyhwSl4Jrn19db8HIa+M5EbWWL0DAJTEhbLOMyNQU93jZWo89jNkiFJCuXpPW0VwDK7k149liTx+Dzfifm+Xu1S9SpKT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Js+3HT5j; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Js+3HT5j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6LdFdfTw3AfaP5aDT9Ia7+wSgGAm0HYk+N2vwPkamFE=; b=Js+3HT5jH0CVTmlZoj9llk9j+4
	14NlgUrA8HXjQY2zzQjsULlABwqmO6eP4HThv+BzRU15VW5p0SalNYTeR0UEqxBfDLcdACadfKpeS
	CWFFLoUjRKj3hVAyMyw4E0vx6jep2IG+zUCi39qpBIOatvW1/w5MX8wp/XN+N2dUlKwD6OoUTYZfy
	Wmn3aZ8eAmDGZVGlh4z5K1CTNpBAnC9EI4ns8qqVbJzaJTjFU0dgUH4G6IaMPc1i08V0HkLPpJ/Sh
	XNimRBTITN1Ed4+B8ZF9k79Gmmeaq16sdw4MCqWJ+3iJOjGnW4kC8ea0PFnO8LX2REY+WcuJ82/hy
	6y0F9Ngw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXB-00000008UvR-2CYM;
	Tue, 19 May 2026 07:06:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 03/14] configfs_detach_prep(): pass configfs_dirent instead of dentry
Date: Tue, 19 May 2026 08:06:22 +0100
Message-ID: <20260519070633.2025485-4-viro@zeniv.linux.org.uk>
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

The only thing it uses the argument for is its ->d_fsdata and
all callers have that already available.

Note that in the recursive call we are dealing with a (sub)directory
configfs_dirent, and for those ->s_dentry->d_fsdata points back
to configfs_dirent itself.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 662dcd7d1bf0..0c071252c9d4 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -516,9 +516,8 @@ static struct dentry * configfs_lookup(struct inode *dir,
  * If there is an error, the caller will reset the flags via
  * configfs_detach_rollback().
  */
-static int configfs_detach_prep(struct dentry *dentry, struct dentry **wait)
+static int configfs_detach_prep(struct configfs_dirent *parent_sd, struct dentry **wait)
 {
-	struct configfs_dirent *parent_sd = dentry->d_fsdata;
 	struct configfs_dirent *sd;
 	int ret;
 
@@ -546,7 +545,7 @@ static int configfs_detach_prep(struct dentry *dentry, struct dentry **wait)
 			 * Yup, recursive.  If there's a problem, blame
 			 * deep nesting of default_groups
 			 */
-			ret = configfs_detach_prep(sd->s_dentry, wait);
+			ret = configfs_detach_prep(sd, wait);
 			if (!ret)
 				continue;
 		} else
@@ -1512,7 +1511,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
 		 */
 		ret = sd->s_dependent_count ? -EBUSY : 0;
 		if (!ret) {
-			ret = configfs_detach_prep(dentry, &wait);
+			ret = configfs_detach_prep(sd, &wait);
 			if (ret)
 				configfs_detach_rollback(dentry);
 		}
@@ -1809,7 +1808,7 @@ void configfs_unregister_group(struct config_group *group)
 
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
 	spin_lock(&configfs_dirent_lock);
-	configfs_detach_prep(dentry, NULL);
+	configfs_detach_prep(sd, NULL);
 	spin_unlock(&configfs_dirent_lock);
 
 	configfs_detach_group(&group->cg_item);
@@ -1956,7 +1955,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	inode_lock_nested(d_inode(dentry), I_MUTEX_CHILD);
 	mutex_lock(&configfs_symlink_mutex);
 	spin_lock(&configfs_dirent_lock);
-	if (configfs_detach_prep(dentry, NULL)) {
+	if (configfs_detach_prep(sd, NULL)) {
 		pr_err("Tried to unregister non-empty subsystem!\n");
 	}
 	spin_unlock(&configfs_dirent_lock);
-- 
2.47.3

