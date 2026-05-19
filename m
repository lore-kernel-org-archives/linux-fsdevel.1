Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF93B3C0F
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174399; cv=none; b=mfpD8bypLacqGrI+ErvVqoP2sAAg20RujCd+keESvyAR2SX4s691xV6m1Iqugww1cCxyWM5Zf1z884ZpUFgzJ1cgJ75m9Zbclsqy7AqkaMGLHKRvu5kjONrjkkhG4HW4ZFg5/S8kpWrpvkuMcZ6WrhdMZXLXqjqN0uytNSmrr70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174399; c=relaxed/simple;
	bh=81RorpLgxyOWpdunYycAycR2apLbF6FiVGIZkCEA3FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvfGpsYkigN+Ye68TkVbj+zLyHy2Z/dwmOFnysBf0X0WvU07jjmt7saIxkzGmYg52CSFn7IRR2XPDBYK4Q8FnBvm5RL7irTkIAKNd+dGH8kgAHNdOXoY/YaspkkJ/g1LLBA+iqDAYCBLttpivBk/nzcwjycNmFr4BLMKOv/Y1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nE3ZpYLa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nE3ZpYLa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qsuVCDS5gxqFVDBl3QqEpHS/qpxRVxWm3YsMCmFITew=; b=nE3ZpYLayU08kGwAx93/Yl7cTl
	v5s6aIDU8DRBpW++mWkMQ/r519CZjeeku3wP+nvUwBRHadrx+u4DRUMX0kXTNgJ5dKVDK3nI1szth
	heYq700nyaIA08i8B8e6Mw2r2foay3P7+o5JtjDWU82SeL65ZkMGfjcmgItWE+KtVjcKBDXpyryDp
	ltPQzS7VjFqDYgmrdhcys0vsZYIEAKimhB5B4RA7NBHOHteeNhQ9OTr9n/+Br6YCDzuFaBkR6aO4O
	RAlk0SvnXH1rimvfwt650L8x6R58mOf8y5mEpgnoWfKZzXjHCv/+tWF/Izp0NXuYjXhmxT5c/yBm9
	4GBAcMnA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXB-00000008Uvb-3VJl;
	Tue, 19 May 2026 07:06:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 06/14] configfs_detach_rollback(): pass configfs_dirent instead of dentry
Date: Tue, 19 May 2026 08:06:25 +0100
Message-ID: <20260519070633.2025485-7-viro@zeniv.linux.org.uk>
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

same story as with configfs_detach_prep() this function is undoing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index e4b7eaa58d65..726c56d1772d 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -562,16 +562,15 @@ static int configfs_detach_prep(struct configfs_dirent *parent_sd, struct dentry
  * Walk the tree, resetting CONFIGFS_USET_DROPPING wherever it was
  * set.
  */
-static void configfs_detach_rollback(struct dentry *dentry)
+static void configfs_detach_rollback(struct configfs_dirent *parent_sd)
 {
-	struct configfs_dirent *parent_sd = dentry->d_fsdata;
 	struct configfs_dirent *sd;
 
 	parent_sd->s_type &= ~CONFIGFS_USET_DROPPING;
 
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling)
 		if (sd->s_type & CONFIGFS_USET_DEFAULT)
-			configfs_detach_rollback(sd->s_dentry);
+			configfs_detach_rollback(sd);
 }
 
 static void detach_attrs(struct config_item * item)
@@ -1509,7 +1508,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
 		if (!ret) {
 			ret = configfs_detach_prep(sd, &wait);
 			if (ret)
-				configfs_detach_rollback(dentry);
+				configfs_detach_rollback(sd);
 		}
 		spin_unlock(&configfs_dirent_lock);
 		mutex_unlock(&configfs_symlink_mutex);
@@ -1530,7 +1529,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
 	frag = sd->s_frag;
 	if (down_write_killable(&frag->frag_sem)) {
 		spin_lock(&configfs_dirent_lock);
-		configfs_detach_rollback(dentry);
+		configfs_detach_rollback(sd);
 		spin_unlock(&configfs_dirent_lock);
 		config_item_put(parent_item);
 		return -EINTR;
-- 
2.47.3

