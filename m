Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA7403E8C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472908; cv=none; b=hP8Wg5wMGL6js4tuNgtYBOCuMBhN5tCEG62Yyg4vu5j7DL6OImZT9TJScnZxCQeoCKxUhysAJUlRjmknJlEKhQYX5BmZF2WsEiq8FwcCFRtdfL6cEbS6RQUYzz9enaVEOJCXE9GXdt01DvcbXmlEMmWGs3CnSzOiKTwmIDAceg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472908; c=relaxed/simple;
	bh=Tr8Hdf3HXsf0Jx0ZudSvZLqLSeRCXAG3dkRzGxjAft8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezIemo+3xHS70VaGMZm+WAu2wcEx4LI14ZD/IxzIZWOoMThF6Q0KNEW+PKhww843NWZ2pWdHUrASr88eVSvLKM14WT1w6d4fuWHxKO+Q9lP3MxtN2U6zGR8q2ZfeRAtZnG2oOVi4QkQRUWPJ7wncQnBZz80JwpEwfhnoUES4nIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BjipzRjk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BjipzRjk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=baMAPmZIwZq6tkw0KCfOpYYb8CP9eNyBodEPcRrhb9c=; b=BjipzRjkt+TmLkhXM/b6qn+5KS
	9oWIQm/yz6ajLDO2L2U3rtyn/QvtN1Bdp7iM+n03chYyKhF5aIPIOQqOlqdbFmW8PVc4guFR+8nHw
	OEOrYg8toYA3jc2vA+TtmHDd1dYN/R66cjnuMxuVX8Ecg5nlEMP7Zf8rQ/X7bPAxK4FAmvUkXhNmK
	Uv0X1zPRoMCHrUbP+Ndodzq8GPVJqaS4QzKMnJggH/b3Qx30iPnpdvXnew45XikcRDKsi6XunyWiU
	+SND4RSnV6CjAHYTuyB899Bj4ytslDuofagxwT33ABC67LQocxEXciYwaH86RKY/tQjTQSRLXmVaR
	eKolWiCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKl-0000000CjDy-2GPT;
	Wed, 03 Jun 2026 07:48:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 01/18] configfs_lookup(): don't leave ->s_dentry dangling on failure
Date: Wed,  3 Jun 2026 08:47:55 +0100
Message-ID: <20260603074815.3033766-2-viro@zeniv.linux.org.uk>
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

Normally ->s_dentry is cleared when dentry it's pointing to becomes
negative (on eviction, realistically).  However, that only happens
if dentry gets to be positive in the first place; in case of inode
allocation failure dentry never becomes positive, so ->d_iput()
is not called at all.

We do part of what normally would've been done by configfs_d_iput()
(dropping the reference to configfs_dirent) manually, but we do
not clear ->s_dentry there.  Sloppy as it is, it does not matter in
case of configfs_create_{dir,link}() - there configfs_dirent does
not survive dropping the sole reference to it.

However, for configfs_lookup() it *does* survive, with a dangling
pointer to soon to be freed dentry sitting it its ->s_dentry.

Subsequent getdents(2) in that directory will end up dereferencing
that pointer in order to pick the inode number.  Use after free...

This is the minimal fix; the right approach is to set the linkage
between dentry and configfs_dirent only after we know that we have
an inode, but that takes more surgery and the bug had been there
since 2006, so...

Fixes: 3d0f89bb1694 ("configfs: Add permission and ownership to configfs objects") # 2.6.16-rc3
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 362b6ff9b908..e84483a0836d 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -486,6 +486,9 @@ static struct dentry * configfs_lookup(struct inode *dir,
 
 			inode = configfs_create(dentry, mode);
 			if (IS_ERR(inode)) {
+				spin_lock(&configfs_dirent_lock);
+				sd->s_dentry = NULL;
+				spin_unlock(&configfs_dirent_lock);
 				configfs_put(sd);
 				return ERR_CAST(inode);
 			}
-- 
2.47.3

