Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84C3955CD;
	Sat,  1 Aug 2026 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785624997; cv=pass; b=fbKlGFcLr0DP87bYN7NgaQOGY7XkZc3uVCEqpZ/NppCrNImq/5Eoi3VxqryzQ7y/IW7UcPB3czODrdviTnCl/0i1OY0CIGAH3t3NzhbgTlvfjWaHXlwpSot6gmDUZmR0nqsA+BCxJTigbFx9EjwiE1GMUOIly0Yj3AWuLDRaByQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785624997; c=relaxed/simple;
	bh=6NYd6in0rzVfgUh8gjPpc/kYd9uu5M96agV9tYIQgcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdefJBvwz8/S40CjbzxgynfhGaB8PD774ccPO1Q+O8EHIFPY8ua1ZdwXQdGLZFw0BIB+pI52UWKbiWEVy7HylZiJIPxgy1Sxek9Aft86sJsNtpcK+yqNoL/sRQnqYQHWepA+3sjC9HgD6sMPcr61KuRChs0Bzm0sHEevYDVHk7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=SBA37Rrx; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="SBA37Rrx"
ARC-Seal: i=1; a=rsa-sha256; t=1785624969; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=R8N92I0M+ViE86cxahige+4EwK/EjPC4yApsIndD5VhvdvsLWTJ8wB69Jxb+98HxHCkqjWuYO/OaB7GR7JVWHq+4Eoh5DbgBcu4bctYfkhSblzkQluROuZ98CCjWwbEerEfGbKiHES4Oee7zK0p/r2G6KAyXf0h5L/Nb+Ma3hMY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785624969; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KJceAGSvicSHI55BXIH/luGROGrl7VGF+MQRV7iaMTM=; 
	b=OvknFy9cD6ljgO90HnIGJVmRYxK5qmakrkolRCuz9+6tZBWvCap1XliTjEgYAqLW7+NI357/8frUHaWUGezROuuyglRyIchGSd35fO/GIs4Dkk9AppKLC9OAwDxQQHq2OcLAlJK4wRQsOT9YzznKFqwaf0O0raiXszL0qoKEkaE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785624969;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KJceAGSvicSHI55BXIH/luGROGrl7VGF+MQRV7iaMTM=;
	b=SBA37RrxmBlaXuFChukkvMl3N7eOufWGZZNntjS2n55cCjSfsFc+Cq2YhvJPA3ai
	UO5oILxWw4IZIxk8CyloqzIoc7xieT210Uh/+vgIUL0VV6Z8Twr5BRPtCP9bGZs1KF2
	TnDK6+rmDdTZhAx1NZH5KkOtMkB+i+GRs7kccLPM=
Received: by mx.zoho.eu with SMTPS id 1785624966606460.58651198992493;
	Sun, 2 Aug 2026 00:56:06 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] ufs: use i_size to detect fast symlinks
Date: Sat,  1 Aug 2026 22:55:22 +0000
Message-ID: <20260801225530.148386-3-ali@iusegentoo.com>
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

Whether a symlink stores its target inline is decided by testing
i_blocks == 0. The on-disk criterion is i_size < fs_maxsymlinklen;
FreeBSD's ufs_readlink() and ufs_symlink() both use it, and our own
ufs_symlink() already checks s_maxsymlinklen on the write side.

The two disagree on UFS2 inodes with extended attributes. ffs_alloc()
adds every allocation to di_blocks, including the IO_EXT path, so a
symlink carrying an extended attribute, an ACL or a MAC label has
di_blocks != 0 while its target is still stored inline.

Linux then takes it for a slow symlink. readlink() reads the target
through ufs_getfrag_block(), treating the ASCII bytes of the target as
block pointers. On a read-write mount unlinking it reaches
ufs_truncate_blocks() from ufs_evict_inode(), which hands the same bytes
to ufs_free_fragments() as block numbers. Values built from printable
characters fall outside the device, so this ends in ufs_panic() with the
inode already modified.

Add ufs_is_fast_symlink() and use it in the read, write and evict paths.
In ufs_evict_inode() it has to run before i_size is cleared.

Flavours that leave s_maxsymlinklen at 0 keep the old i_blocks
heuristic, so only 44BSD and UFS2 change behaviour.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/inode.c | 54 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 440d014cc5ed..802bc6e01db2 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -517,6 +517,17 @@ const struct address_space_operations ufs_aops = {
 	.bmap = ufs_bmap
 };
 
+// on-disk criterion is i_size < fs_maxsymlinklen, not i_blocks
+static bool ufs_is_fast_symlink(struct inode *inode)
+{
+	struct ufs_sb_private_info *uspi = UFS_SB(inode->i_sb)->s_uspi;
+
+	if (uspi->s_maxsymlinklen)
+		return inode->i_size < uspi->s_maxsymlinklen;
+
+	return inode->i_blocks == 0;
+}
+
 static void ufs_set_inode_ops(struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode)) {
@@ -528,7 +539,7 @@ static void ufs_set_inode_ops(struct inode *inode)
 		inode->i_fop = &ufs_dir_operations;
 		inode->i_mapping->a_ops = &ufs_aops;
 	} else if (S_ISLNK(inode->i_mode)) {
-		if (!inode->i_blocks) {
+		if (ufs_is_fast_symlink(inode)) {
 			inode->i_link = (char *)UFS_I(inode)->i_u1.i_symlink;
 			inode->i_op = &simple_symlink_inode_operations;
 		} else {
@@ -578,13 +589,13 @@ static int ufs1_read_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 	ufsi->i_oeftflag = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_oeftflag);
 
 
-	if (S_ISCHR(mode) || S_ISBLK(mode) || inode->i_blocks) {
-		memcpy(ufsi->i_u1.i_data, &ufs_inode->ui_u2.ui_addr,
-		       sizeof(ufs_inode->ui_u2.ui_addr));
-	} else {
+	if (S_ISLNK(mode) && ufs_is_fast_symlink(inode)) {
 		memcpy(ufsi->i_u1.i_symlink, ufs_inode->ui_u2.ui_symlink,
 		       sizeof(ufs_inode->ui_u2.ui_symlink) - 1);
 		ufsi->i_u1.i_symlink[sizeof(ufs_inode->ui_u2.ui_symlink) - 1] = 0;
+	} else {
+		memcpy(ufsi->i_u1.i_data, &ufs_inode->ui_u2.ui_addr,
+		       sizeof(ufs_inode->ui_u2.ui_addr));
 	}
 	return 0;
 }
@@ -625,13 +636,13 @@ static int ufs2_read_inode(struct inode *inode, struct ufs2_inode *ufs2_inode)
 	ufsi->i_oeftflag = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_oeftflag);
 	*/
 
-	if (S_ISCHR(mode) || S_ISBLK(mode) || inode->i_blocks) {
-		memcpy(ufsi->i_u1.u2_i_data, &ufs2_inode->ui_u2.ui_addr,
-		       sizeof(ufs2_inode->ui_u2.ui_addr));
-	} else {
+	if (S_ISLNK(mode) && ufs_is_fast_symlink(inode)) {
 		memcpy(ufsi->i_u1.i_symlink, ufs2_inode->ui_u2.ui_symlink,
 		       sizeof(ufs2_inode->ui_u2.ui_symlink) - 1);
 		ufsi->i_u1.i_symlink[sizeof(ufs2_inode->ui_u2.ui_symlink) - 1] = 0;
+	} else {
+		memcpy(ufsi->i_u1.u2_i_data, &ufs2_inode->ui_u2.ui_addr,
+		       sizeof(ufs2_inode->ui_u2.ui_addr));
 	}
 	return 0;
 }
@@ -731,13 +742,12 @@ static void ufs1_update_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		/* ufs_inode->ui_u2.ui_addr.ui_db[0] = cpu_to_fs32(sb, inode->i_rdev); */
 		ufs_inode->ui_u2.ui_addr.ui_db[0] = ufsi->i_u1.i_data[0];
-	} else if (inode->i_blocks) {
-		memcpy(&ufs_inode->ui_u2.ui_addr, ufsi->i_u1.i_data,
-		       sizeof(ufs_inode->ui_u2.ui_addr));
-	}
-	else {
+	} else if (S_ISLNK(inode->i_mode) && ufs_is_fast_symlink(inode)) {
 		memcpy(&ufs_inode->ui_u2.ui_symlink, ufsi->i_u1.i_symlink,
 		       sizeof(ufs_inode->ui_u2.ui_symlink));
+	} else {
+		memcpy(&ufs_inode->ui_u2.ui_addr, ufsi->i_u1.i_data,
+		       sizeof(ufs_inode->ui_u2.ui_addr));
 	}
 
 	if (!inode->i_nlink)
@@ -774,13 +784,13 @@ static void ufs2_update_inode(struct inode *inode, struct ufs2_inode *ufs_inode)
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		/* ufs_inode->ui_u2.ui_addr.ui_db[0] = cpu_to_fs32(sb, inode->i_rdev); */
 		ufs_inode->ui_u2.ui_addr.ui_db[0] = ufsi->i_u1.u2_i_data[0];
-	} else if (inode->i_blocks) {
-		memcpy(&ufs_inode->ui_u2.ui_addr, ufsi->i_u1.u2_i_data,
-		       sizeof(ufs_inode->ui_u2.ui_addr));
-	} else {
+	} else if (S_ISLNK(inode->i_mode) && ufs_is_fast_symlink(inode)) {
 		memcpy(&ufs_inode->ui_u2.ui_symlink, ufsi->i_u1.i_symlink,
 		       sizeof(ufs_inode->ui_u2.ui_symlink));
- 	}
+	} else {
+		memcpy(&ufs_inode->ui_u2.ui_addr, ufsi->i_u1.u2_i_data,
+		       sizeof(ufs_inode->ui_u2.ui_addr));
+	}
 
 	if (!inode->i_nlink)
 		memset (ufs_inode, 0, sizeof(struct ufs2_inode));
@@ -839,14 +849,18 @@ int ufs_sync_inode (struct inode *inode)
 void ufs_evict_inode(struct inode * inode)
 {
 	int want_delete = 0;
+	bool fast_symlink;
 
 	if (!inode->i_nlink && !is_bad_inode(inode))
 		want_delete = 1;
 
+	// must be evaluated before i_size is cleared below
+	fast_symlink = S_ISLNK(inode->i_mode) && ufs_is_fast_symlink(inode);
+
 	truncate_inode_pages_final(&inode->i_data);
 	if (want_delete) {
 		inode->i_size = 0;
-		if (inode->i_blocks &&
+		if (inode->i_blocks && !fast_symlink &&
 		    (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 		     S_ISLNK(inode->i_mode)))
 			ufs_truncate_blocks(inode);
-- 
2.55.0

