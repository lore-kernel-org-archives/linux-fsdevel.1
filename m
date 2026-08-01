Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38ED3859C2;
	Sat,  1 Aug 2026 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785624994; cv=pass; b=mo93BZKgfXEE55A3EOxI4UFYpRbybhNZJss/OqVZ1arT9YeTiUkQbdvc/+hQpnxaAVoLwrGpIKw4m/QvNhP9v92jNwwT38W27lmTZICSksiwibNLi0OtPlNqLCCS0cFgitZgRA/9eAenpHHYJbGo4dWBmq2LHj7fNhwVWhLJgeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785624994; c=relaxed/simple;
	bh=B5qx66ga9t+tzyzyQzw/g4F5wGoX2yCKJ/Ebtec5eto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncNxjD3ALSvtMkLJ+NitIKtx55gLOlUkIZ/zxnf59YlSz+DuyDxKZmsceDI7H2T+qQypHCiBVMUQYFg1w90WJpHRlLepZn9sKY7G5JrFmfF5P5NwkaCAHT0+uV7msh0ui8q5moswaHaUD7cJh5I7666pKyCCfXE+LIjVN4h21iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=NLtJ7Msn; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="NLtJ7Msn"
ARC-Seal: i=1; a=rsa-sha256; t=1785624969; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZhnDD4nNfSbTb3tEuXXdsvdKm0eFX5jowtc1aFMnargHxB1gy+RM42EBEaaJaS/WOZsLZ3lSdJ0yVr4CImN/l0TA2/XSc/zWcdoza3z+3rkGfExIDUNuM/6xiQVpayriI8+aWXpNm24tl42jtnOLeOliFZllqG92V64/QirpCMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785624969; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+yIzktvg7jzlKW2ywu6nga4OYqtDSuEi2C9eSFYa+h0=; 
	b=TgkOq4iYLp8sC3aqdjbSr8Q7ajkwFNpuX8khXdfN5v99nJSsUlKpMGCSAXlEnbrNCrc8mqxn6SX3uw7D5CjO/Q5KwBRyDqxWBQv6CDnONr1FxGqgr53JGPmHQHNgCNLI1DMJRXv67sIydnOU8aGxbf67Sv+EE/8574uaJt3mAYo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785624969;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+yIzktvg7jzlKW2ywu6nga4OYqtDSuEi2C9eSFYa+h0=;
	b=NLtJ7MsnEnm3k8cD4ponZ8nPSszXRKED/xLZ8nXorT7tyssJMR2onjTvOs0x8QsD
	6ke1VhZRHzBExPwGNC/l69jWFvgD+CerzgRj2nGC031dQQfV6lD5yUW5upUNsy5HUHr
	hfV5NC9SPYrnOEZ+2ygd/619OcSCSpUDHRtZtKb0=
Received: by mx.zoho.eu with SMTPS id 1785624967356866.9833602936747;
	Sun, 2 Aug 2026 00:56:07 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] ufs: free UFS2 external attribute blocks on inode deletion
Date: Sat,  1 Aug 2026 22:55:23 +0000
Message-ID: <20260801225530.148386-4-ali@iusegentoo.com>
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

A UFS2 inode can own up to UFS_NXADDR blocks holding extended
attributes, described by di_extsize and di_extb[]. They sit outside the
block tree of the file, but ffs_alloc() counts them in di_blocks like
any other allocation.

Linux never reads those two fields. ufs_truncate_blocks() only walks
di_db[] and di_ib[], so on unlink the extattr blocks stay marked in use
while ufs_update_inode() clears the whole on-disk inode, di_extb[]
included. The only record of where the blocks were is gone, and nothing
can ever free them. Deleting FreeBSD files that carry an extended
attribute, an ACL or a MAC label therefore leaks disk space until fsck
reclaims it.

Keep di_extsize and di_extb[] in the in-core inode and release them from
ufs_evict_inode(), before the on-disk inode is cleared. The last block
of the area can be a fragment, so size it the way FreeBSD's sblksize()
does rather than assuming a full block.

An external attribute size larger than the area can describe means the
inode is corrupted and the block numbers cannot be trusted. Warn and
leave the blocks alone in that case; leaking them is better than freeing
blocks that may belong to something else.

Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/ialloc.c |  2 ++
 fs/ufs/inode.c  | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ufs/ufs.h    |  2 ++
 3 files changed, 59 insertions(+)

diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index 8e51f4630d18..4c3c76c4e7ff 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -294,6 +294,8 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	inode->i_generation = 0;
 	simple_inode_init_ts(inode);
 	ufsi->i_flags = UFS_I(dir)->i_flags;
+	ufsi->i_extsize = 0;
+	memset(ufsi->i_extb, 0, sizeof(ufsi->i_extb));
 	ufsi->i_lastfrag = 0;
 	ufsi->i_shadow = 0;
 	ufsi->i_osync = 0;
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 802bc6e01db2..7079285bac2a 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -585,6 +585,8 @@ static int ufs1_read_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 	inode->i_blocks = fs32_to_cpu(sb, ufs_inode->ui_blocks);
 	inode->i_generation = fs32_to_cpu(sb, ufs_inode->ui_gen);
 	ufsi->i_flags = fs32_to_cpu(sb, ufs_inode->ui_flags);
+	ufsi->i_extsize = 0;
+	memset(ufsi->i_extb, 0, sizeof(ufsi->i_extb));
 	ufsi->i_shadow = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_shadow);
 	ufsi->i_oeftflag = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_oeftflag);
 
@@ -605,6 +607,7 @@ static int ufs2_read_inode(struct inode *inode, struct ufs2_inode *ufs2_inode)
 	struct ufs_inode_info *ufsi = UFS_I(inode);
 	struct super_block *sb = inode->i_sb;
 	umode_t mode;
+	unsigned int i;
 
 	UFSD("Reading ufs2 inode, ino %llu\n", inode->i_ino);
 	/*
@@ -631,6 +634,9 @@ static int ufs2_read_inode(struct inode *inode, struct ufs2_inode *ufs2_inode)
 	inode->i_blocks = fs64_to_cpu(sb, ufs2_inode->ui_blocks);
 	inode->i_generation = fs32_to_cpu(sb, ufs2_inode->ui_gen);
 	ufsi->i_flags = fs32_to_cpu(sb, ufs2_inode->ui_flags);
+	ufsi->i_extsize = fs32_to_cpu(sb, ufs2_inode->ui_extsize);
+	for (i = 0; i < UFS_NXADDR; i++)
+		ufsi->i_extb[i] = fs64_to_cpu(sb, ufs2_inode->ui_extb[i]);
 	/*
 	ufsi->i_shadow = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_shadow);
 	ufsi->i_oeftflag = fs32_to_cpu(sb, ufs_inode->ui_u3.ui_sun.ui_oeftflag);
@@ -846,6 +852,54 @@ int ufs_sync_inode (struct inode *inode)
 	return ufs_update_inode (inode, 1);
 }
 
+/*
+ * UFS2 keeps extended attributes in up to UFS_NXADDR blocks of their own.
+ * They live outside the block tree of the file but are counted in di_blocks.
+ * Linux does not implement extended attributes, but it still has to release
+ * those blocks when the inode goes away: ufs_update_inode() clears the whole
+ * on-disk inode, taking di_extb[] with it, so nothing would ever free them.
+ */
+static void ufs_free_ext_blocks(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
+	struct ufs_inode_info *ufsi = UFS_I(inode);
+	u64 size = ufsi->i_extsize;
+	unsigned int i;
+
+	if ((UFS_SB(sb)->s_flags & UFS_TYPE_MASK) != UFS_TYPE_UFS2 || !size)
+		return;
+
+	if (size > ((u64)UFS_NXADDR << uspi->s_bshift)) {
+		// leaking is better than freeing something we cannot locate
+		ufs_warning(sb, __func__,
+			    "inode %llu: bad external attribute size %llu\n",
+			    inode->i_ino, size);
+		return;
+	}
+
+	for (i = 0; i < UFS_NXADDR; i++) {
+		u64 off = (u64)i << uspi->s_bshift;
+		u64 block = ufsi->i_extb[i];
+		unsigned int frags;
+
+		if (!block || size <= off)
+			continue;
+
+		if (size - off >= uspi->s_bsize)
+			frags = uspi->s_fpb;
+		else
+			frags = (size - off + uspi->s_fsize - 1) >> uspi->s_fshift;
+
+		ufsi->i_extb[i] = 0;
+		if (frags == uspi->s_fpb)
+			ufs_free_blocks(inode, block, frags);
+		else
+			ufs_free_fragments(inode, block, frags);
+	}
+	ufsi->i_extsize = 0;
+}
+
 void ufs_evict_inode(struct inode * inode)
 {
 	int want_delete = 0;
@@ -864,6 +918,7 @@ void ufs_evict_inode(struct inode * inode)
 		    (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 		     S_ISLNK(inode->i_mode)))
 			ufs_truncate_blocks(inode);
+		ufs_free_ext_blocks(inode);
 		ufs_update_inode(inode, inode_needs_sync(inode));
 	}
 
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 788e025056b2..6cac5f8222eb 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -40,6 +40,8 @@ struct ufs_inode_info {
 		__fs64	u2_i_data[15];
 	} i_u1;
 	__u32	i_flags;
+	__u32	i_extsize;		/* UFS2 external attribute area size */
+	__u64	i_extb[UFS_NXADDR];	/* UFS2 external attribute blocks */
 	__u32	i_shadow;
 	__u32	i_unused1;
 	__u32	i_unused2;
-- 
2.55.0

