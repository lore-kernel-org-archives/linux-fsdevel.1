Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A638AC79;
	Sat,  1 Aug 2026 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785624995; cv=pass; b=m5iuYaxcQgrxKPEptx0MbxJlZIs92jA7WW3SQZ+47ANQEfiFpbsJLK0ekglmOS4z9fCcyA2TVrFTYMoBCiIBxw5v1rwSNY3ap+AWgUDSC00gTVKx8dzOJTC5+SzHifp81Vl7GVKdRUiDPj6GggmBpxtogglk8D9WoeNleaqQ8Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785624995; c=relaxed/simple;
	bh=R4u7/bKEg9i84hjJCm4SMqcUG7IyauuWymJ28/yL+zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPd7N3fqyYdkdF0bKJjugf9jv6a+rYWsQjUHEwgDVR9z6eFH6zQbKpDoxj3BVh6a3sAmX1Yvvut9GKqgwBkBKSjPrC62WswOMNEff2zG5e8D2EExLU7i1UlALQnGPB+9QDlftkuAsL8JZybjckNSaenvU4iDmDIZjAVl2jsb6b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=S9+k2A8n; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="S9+k2A8n"
ARC-Seal: i=1; a=rsa-sha256; t=1785624970; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RZdVJJgD2yiF8tcsz5RLvTWXOfLu7B7U+bWcwNzmoXO67rDpdxJJecH628K1J3kSJAUq4DoGwblizF4D4dkQlT9KffzxGXprKffavmIUGUqcIpgFKFekbqpBRw3Qc6hjcwTHerkJPhjfH1v1cqp3iBn6BnabRAsg0eatB734IoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785624970; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MF2VMMsgjFNzzRTYjvZAPgcacW+ZbpDTdl6P3sBfAcM=; 
	b=gq8QGdevp5pjJZvNM1G0cF1bkVJq9dOAautp3WLXpoepAOd5lXDk8ZSnOp2+nOWgFsk7mdG5Qld+b4hCutr3+S9WYJiWtNDyeoCObAhYz5ev6B8d7llSiMn0jJ5fSQKcCpoUZTUwqOsSKO+pXMNY1rvVGQL1PQVbkIDcX5hMkGw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785624970;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MF2VMMsgjFNzzRTYjvZAPgcacW+ZbpDTdl6P3sBfAcM=;
	b=S9+k2A8nssAfu3QZy9Oef+9TmsKaU8qyCyMG0rMvZIMNZar25LpcVufU6lDEPkh8
	ifzb+6hiI93bfFv/zgfZuGv5bO1YQNlbJSQaSGf2e1a6ekHhrEEvyf5fZbcn2//7EoQ
	Gw+dZwd6qMc5k4FOTAIW2K5+txCdFFxuINlMsA0U=
Received: by mx.zoho.eu with SMTPS id 17856249689741021.5164796163593;
	Sun, 2 Aug 2026 00:56:08 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] ufs: honour on-disk immutable and append-only flags
Date: Sat,  1 Aug 2026 22:55:25 +0000
Message-ID: <20260801225530.148386-6-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801225530.148386-1-ali@iusegentoo.com>
References: <20260801225530.148386-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ui_flags holds the BSD chflags of the inode. ufs1_read_inode() and
ufs2_read_inode() copy it into ufsi->i_flags and nothing else ever looks
at it. In particular it never reaches inode->i_flags, so IS_IMMUTABLE()
and IS_APPEND() are always false for a UFS inode. The check in
ufs_truncate(),

	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
		return -EPERM;

can never fire, and neither can the generic ones in the VFS.

A file that FreeBSD marked with chflags schg or uchg is therefore freely
writable and removable once the filesystem is mounted on Linux, and an
sappnd file can be rewritten rather than only appended to.

Map the immutable and append-only bits onto S_IMMUTABLE and S_APPEND
when the inode is read. Only 44BSD and UFS2 are handled: the other
flavours put something else at that offset and their ui_flags is not a
chflags word.

NOUNLINK has no equivalent in inode->i_flags. Mapping it to S_IMMUTABLE
would be wrong, since it is meant to allow modification, so files marked
that way stay removable for now.

Note that Linux offers no way to clear these flags again; UFS has no
FS_IOC_SETFLAGS support. Filesystems carrying them have to be edited
from an operating system that implements chflags.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 7079285bac2a..029f6771b214 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -517,6 +517,22 @@ const struct address_space_operations ufs_aops = {
 	.bmap = ufs_bmap
 };
 
+// only 44BSD and UFS2 store BSD chflags in ui_flags
+static void ufs_set_inode_flags(struct inode *inode)
+{
+	unsigned int flavour = UFS_SB(inode->i_sb)->s_flavour;
+	unsigned int flags = UFS_I(inode)->i_flags;
+
+	if (flavour != UFS_MOUNT_UFSTYPE_44BSD &&
+	    flavour != UFS_MOUNT_UFSTYPE_UFS2)
+		return;
+
+	if (flags & (UFS_UF_IMMUTABLE | UFS_SF_IMMUTABLE))
+		inode->i_flags |= S_IMMUTABLE;
+	if (flags & (UFS_UF_APPEND | UFS_SF_APPEND))
+		inode->i_flags |= S_APPEND;
+}
+
 // on-disk criterion is i_size < fs_maxsymlinklen, not i_blocks
 static bool ufs_is_fast_symlink(struct inode *inode)
 {
@@ -704,6 +720,7 @@ struct inode *ufs_iget(struct super_block *sb, unsigned long ino)
 	ufsi->i_dir_start_lookup = 0;
 	ufsi->i_osync = 0;
 
+	ufs_set_inode_flags(inode);
 	ufs_set_inode_ops(inode);
 
 	UFSD("EXIT\n");
-- 
2.55.0

