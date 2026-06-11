Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD847B406;
	Thu, 11 Jun 2026 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198071; cv=none; b=Xmnu/ptqP2xf8MTGgDbCs3cuCUUcaS/nFOtYAUwxke8nJ0OrxzxZH5GsIKC8PfrHXlTUOsl65n5KJI6/fvBllZmt0T5CLPcmAzp8Ey0TVI+M+jSwhehvKyELKk/pcVtCK+OHTvyX6qIO2Qd33r1S0O1fBCOtwK6K8HccsCU0ggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198071; c=relaxed/simple;
	bh=iWGtuh7JjQqrtyc0lfzLPHywxbj0DKzoSSxXIEG81fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLYVrfrPNsAcQyMuuYedvXYDttVJ5hVXVk2ZeIJm89tlcLSmsZ2sphTGfHYl9HmJvp0ZmryQp4SRzbSiLgOYru2IOdaeODSUpAJZFfspoEYW5Qm6hEBmfrlBcIJS1wqPRDm8CI2jw05/yHdDsSexoGH14PPIWLDq9GmaaDBVwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KJK6qiV0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KJK6qiV0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XtXmcCiq3eJia7JzFxANPEPogqTgQiMYpvOYfxZs+RI=; b=KJK6qiV0e0G8WoQlcK2JqYtaui
	8miztq7wA6yYYX/f4HajFclZu8p1SKefoIT0q58+ZY6NpFablzxRG59VFh/+xfPLt5AbvsLlPmvmk
	X4RzoemUbpYOzr4K2d/WDoNwo4ic3kK5bFwC+K4IrLm/I4yKp6GwWbIjMpFvQu03zBhK+7hYbstEJ
	9qO2lQEVeBqiwYx4SO7xzIQcQQN3iMOXx3QdjKcJpuBngCbXGtPVH6rMtiOjDaRNXvH3GDaDjUyvT
	2nx2yo9mReMaNcG5Rn7kfRC63u+ihLXXxGgXthaboOXA1qvCcfuHDwWnGCrlcUYFNjH6xOvo0sN47
	hC09ZUeA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXiz4-000000070nS-36xx;
	Thu, 11 Jun 2026 17:14:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] make ufs_inode_cache statically allocated
Date: Thu, 11 Jun 2026 18:14:24 +0100
Message-ID: <20260611171425.1671254-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
References: <20260611171309.GN2636677@ZenIV>
 <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

A modular example I used for testing...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index c4831a8b9b3f..72053bc9c8dc 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -90,6 +90,7 @@
 #include <linux/log2.h>
 #include <linux/seq_file.h>
 #include <linux/iversion.h>
+#include <linux/slab-static.h>
 
 #include "ufs_fs.h"
 #include "ufs.h"
@@ -1353,7 +1354,8 @@ static int ufs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static struct kmem_cache * ufs_inode_cachep;
+static struct kmem_cache_opaque ufs_inode_cache;
+#define ufs_inode_cachep to_kmem_cache(&ufs_inode_cache)
 
 static struct inode *ufs_alloc_inode(struct super_block *sb)
 {
@@ -1383,16 +1385,13 @@ static void init_once(void *foo)
 
 static int __init init_inodecache(void)
 {
-	ufs_inode_cachep = kmem_cache_create_usercopy("ufs_inode_cache",
+	return kmem_cache_setup_usercopy(ufs_inode_cachep, "ufs_inode_cache",
 				sizeof(struct ufs_inode_info), 0,
 				(SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT),
 				offsetof(struct ufs_inode_info, i_u1.i_symlink),
 				sizeof_field(struct ufs_inode_info,
 					i_u1.i_symlink),
 				init_once);
-	if (ufs_inode_cachep == NULL)
-		return -ENOMEM;
-	return 0;
 }
 
 static void destroy_inodecache(void)
-- 
2.47.3

