Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54243406291
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472906; cv=none; b=pgaGgMVcNO9XBUEMbxCDYoTbsXEk/XLiY4/jNyw3eDUrob0YRkyEU2sCUH2rMYm2PrtIeGa2B8fSmGCoQaPJUttJ0pMdBdN62gFxa23dih99PJnR8oImNVCwQFtPCqA5ddGANerNziCin/PP47t9e/3UtgydShqog62iFiiI8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472906; c=relaxed/simple;
	bh=pYQ2iDB1u/M8CP9WbfyJAAHpUeDg3ZP5qdiASkGKCaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAll0FWgrc94GvymEEptA2+xa7s85Kx6drLIRo1HsxnxG21yxQHAUv8AslSQLmTQa0/eKTT94yg4L241V34nrIWGUSKtG2iz+BLkzZSwilUnHieX0XWbrTcxtTj0gKl6oQ+bjmCFSrCKHDzxb8GgAtnkwbMUcVD3oGixZ8PRBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=p7qSyqPr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p7qSyqPr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eEbez3SmBseJq7M1z/gIdz58yP3IJrdUliDU+eMF1qI=; b=p7qSyqPrMrigVp6vAci9z7a/KJ
	TVSQJT/ZYSIpTmmuHi8noPY5NILKVeL8b2usLEokRlMneffQWk28e9jm/u940gxlhpOXD8KbWCsGc
	KU2TcFPCdYmchFp7vx3GVCVTibRJJsSYAQiN03XMipfYNjE/7z3XItFxjoE7W7zzcnpa2N9TSOLKr
	67T5qH7cZ+6qVahkTQlQzLTlPe7qzQWnjtLYwIyLtfRpre9otdSmLBbKKX6q3CImzNi1diajuqVp4
	kSz5w3UvvHKnYH52v9xt42u37sZ/YDqEFhij6jLmMErY1ofn+AEBxe1onBZpRG2C7TG4UjIVmLWja
	70EuN+jg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKm-0000000CjF4-2G9X;
	Wed, 03 Jun 2026 07:48:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 06/18] configfs_do_depend_item(): pass configfs_dirent instead of dentry
Date: Wed,  3 Jun 2026 08:48:03 +0100
Message-ID: <20260603074815.3033766-10-viro@zeniv.linux.org.uk>
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

Again, the only thing it uses the argument for is its ->d_fsdata
and callers already have that - as the matter of fact, they are
passing ->s_dentry of that configfs_dirent, so that the function
could get it back as ->d_fsdata of that.  With nothing else in
dentry even looked at...

configfs_dirent in question is a directory one - in this case those
are subdirectories of root (aka roots of "subsystem" trees).

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index a6b99bcbddbc..c6055a626bef 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1119,7 +1119,7 @@ static int configfs_depend_prep(struct configfs_dirent *sd,
 	return ret;
 }
 
-static int configfs_do_depend_item(struct dentry *subsys_dentry,
+static int configfs_do_depend_item(struct configfs_dirent *subsys_sd,
 				   struct config_item *target)
 {
 	struct configfs_dirent *p;
@@ -1127,7 +1127,7 @@ static int configfs_do_depend_item(struct dentry *subsys_dentry,
 
 	spin_lock(&configfs_dirent_lock);
 	/* Scan the tree, return 0 if found */
-	ret = configfs_depend_prep(subsys_dentry->d_fsdata, target);
+	ret = configfs_depend_prep(subsys_sd, target);
 	if (ret)
 		goto out_unlock_dirent_lock;
 
@@ -1195,7 +1195,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
 	}
 
 	/* Ok, now we can trust subsys/s_item */
-	ret = configfs_do_depend_item(subsys_sd->s_dentry, target);
+	ret = configfs_do_depend_item(subsys_sd, target);
 
 out_unlock_fs:
 	inode_unlock(d_inode(root));
@@ -1297,7 +1297,7 @@ int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
 	}
 
 	/* Now we can execute core of depend item */
-	ret = configfs_do_depend_item(subsys_sd->s_dentry, target);
+	ret = configfs_do_depend_item(subsys_sd, target);
 
 	if (target_subsys != caller_subsys)
 out_root_unlock:
-- 
2.47.3

