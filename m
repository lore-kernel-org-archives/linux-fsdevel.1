Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CFC385525
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774804820; cv=none; b=jGWwmkztmmFDyUf/ro0f5Jh20SZFp9dTaUaKO7kj5Fra233fr3a1d62XuqzaWKyTCY7QSAfQGEvnHkTzlU86otphomkeWDCXdEphCZoY2nu6jle8Tjy1IB+JCnFKXUVbn+4PCRCtw3/JhHmqd0fMQChLkeiZdm8VT5hkCaYUY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774804820; c=relaxed/simple;
	bh=8xxPYCYi3jBF56gf5sck7mIQAohhuUh0PXeHCMgHG/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9Z5ESfP0o2AgvR5pb12AjQO1G3TGvuah2YvAiqW3xMLfQgnitZ7gKa5j0ElUf9L9q3RFGvAYMOgXdf62gETUJLnvAmXsLpZBqG3SEp5o7yzXxz+RwM7LMMyEKXP+ldR39273rZWvChqgKK11bYlGyXuTbcy3FwY00f9oJA1DA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ttxi0UNh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttxi0UNh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483487335c2so38728315e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774804816; x=1775409616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1fu/byEUJ6qDFBkZYB9aFVVTkqU/ACSQVsqGJXvhx0=;
        b=Ttxi0UNhA30K2/D9a5MlnIwp04Ti+6LOyt/vP/oQSlzm2kNS8fC73vOQ8W1os4kAL2
         vOSuW1ZFR6ag0wpiDgLQ4fLQAWEOOUg0FT0FWqJY1jsnPpmbHQ7yjqPhJjZXdM2Zwild
         wRlw8tSB1Mp89qoFydhzpjmbSE0kAr8Cfrj0EvvjEn8Z7tiuB4NjU26s962A3uWuaoUe
         a1t5FMcXPdOSOfEc1LB+C0aLPTi3K1rKfR/4kGthDA9NfQUbq8HVjnjUtG72HcMEPR6Y
         eTBs8+iXHF+flZjbU7rpcxdMw6MgNllct0Lk9PQ/oTkxIqvAKBGFIEiDsgZNYwhgsB6m
         31LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774804816; x=1775409616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a1fu/byEUJ6qDFBkZYB9aFVVTkqU/ACSQVsqGJXvhx0=;
        b=RpZOX/Uc9nZNKHncUTXeLKNhiO21n26HiJ4ZRyoq2d/5uKDnVYMjpmwcyOOE3X2f+S
         uU23cyAjlaf797pIY5l10EWMeiq9P7GFvE433OOSwQ4v6vUP9Yl4bm6DqlAhZnmPw8pU
         gHsiL0RGIZ0Uta/zi4STasiUYV6e+/mBjglbnXyMVdj7AV+pfRuClzwCzR8uJEYSnQBH
         HE2Kh07sgY5neNbBcBE5LVWrRwSgVvsMoEbTkiRetWNs/SihZ90d3gN6bE4rHle7WgFu
         Fi4NB7vmct/srxNw8aFHZ8ho2UZHXby5Mo1V+82wnIX2T2nITJuJwqo8jkGX2LdCF2WH
         z1bw==
X-Forwarded-Encrypted: i=1; AJvYcCVvDIQYeQLuMsYdpQjdJquduJ8xvxtHSmRgysqw29wgU1AH/KWSezglr1ceYHbfWg3878UITj1P8jv287gH@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVtjI2lh8OXDuQ/42xA0aDbfaAbM2tN9g+7BGqtW830rYuokc
	FjvXZgrlE34Fx5q3KRz9g4ReNQN531TFTvZ7TDV68GaYLbGhaMjvjuGZ
X-Gm-Gg: ATEYQzziOYOy+QSEGzFOR6AjEBhKX0F6CS1wdCQe+U7KccBaYqFq7P36mAn69TClGLz
	p5+lbVWXJwbU7VFmM+SX/ZDNrnfTbltpevVwbND/ERrK4cR2GqXtgo4YbJmTCZcbOsMOQOefiia
	G5GHuUfaj6Ws5oq3xhx1rm3IdKDk6zE8B7jGdxkVWBxIqsxTbncY05fZCxYN923xNX85V2VJz8J
	FqVaNBt5X2Y9QuL8nCT2zZVl9zRNMn5xzedpi/gwKGiLHWtbzXoodUMNwx/BWl7/647gLpalNNl
	+hH09WDp/S7ZDyPFSLtOwJ24R4dqZAPXF3SLqArvxIyU5cCXHy0DpUOlw0EG6aXxkRzzZUxi+Rn
	rNgbqEyyXdTm5LvOvw+/+sN44Ht9zql7UmCDwrO+cfpJwPgsIkbIa/wC4nkI8tCOLGGpevFoI6I
	IVTCYtmuEFCTcIvBxrszQXMKZolskLWDduW8s7WzZPr6Lo3sHskTrmcahEhKlo/3GoN9YEElbZR
	w==
X-Received: by 2002:a05:600c:8b03:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48727ef16aemr196607465e9.6.1774804816012;
        Sun, 29 Mar 2026 10:20:16 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873cd7d039sm9776805e9.15.2026.03.29.10.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 10:20:15 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 2/7] Use icount_read() and icount_read_once() as appropriate.
Date: Sun, 29 Mar 2026 19:19:57 +0200
Message-ID: <20260329172002.3557801-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329172002.3557801-1-mjguzik@gmail.com>
References: <20260329172002.3557801-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't open-code ->i_count access.

This is expected to be a nop.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/file.c |  2 +-
 fs/btrfs/inode.c                         |  2 +-
 fs/ceph/mds_client.c                     |  2 +-
 fs/ext4/ialloc.c                         |  4 ++--
 fs/hpfs/inode.c                          |  2 +-
 fs/inode.c                               | 12 ++++++------
 fs/nfs/inode.c                           |  4 ++--
 fs/smb/client/inode.c                    |  2 +-
 fs/ubifs/super.c                         |  2 +-
 fs/xfs/xfs_inode.c                       |  2 +-
 fs/xfs/xfs_trace.h                       |  2 +-
 include/trace/events/filelock.h          |  2 +-
 security/landlock/fs.c                   |  2 +-
 13 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 10fa9b844fcc..f6de8c1169d5 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1430,7 +1430,7 @@ static int spufs_mfc_open(struct inode *inode, struct file *file)
 	if (ctx->owner != current->mm)
 		return -EINVAL;
 
-	if (icount_read(inode) != 1)
+	if (icount_read_once(inode) != 1)
 		return -EBUSY;
 
 	mutex_lock(&ctx->mapping_lock);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8d97a8ad3858..f36c49e83c04 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4741,7 +4741,7 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 
 	inode = btrfs_find_first_inode(root, min_ino);
 	while (inode) {
-		if (icount_read(&inode->vfs_inode) > 1)
+		if (icount_read_once(&inode->vfs_inode) > 1)
 			d_prune_aliases(&inode->vfs_inode);
 
 		min_ino = btrfs_ino(inode) + 1;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b1746273f186..2cb3c919d40d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2223,7 +2223,7 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 			int count;
 			dput(dentry);
 			d_prune_aliases(inode);
-			count = icount_read(inode);
+			count = icount_read_once(inode);
 			if (count == 1)
 				(*remaining)--;
 			doutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 3fd8f0099852..8c80d5087516 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -252,10 +252,10 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 		       "nonexistent device\n", __func__, __LINE__);
 		return;
 	}
-	if (icount_read(inode) > 1) {
+	if (icount_read_once(inode) > 1) {
 		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%llu: count=%d",
 			 __func__, __LINE__, inode->i_ino,
-			 icount_read(inode));
+			 icount_read_once(inode));
 		return;
 	}
 	if (inode->i_nlink) {
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index 0e932cc8be1b..1b4fcf760aad 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -184,7 +184,7 @@ void hpfs_write_inode(struct inode *i)
 	struct hpfs_inode_info *hpfs_inode = hpfs_i(i);
 	struct inode *parent;
 	if (i->i_ino == hpfs_sb(i->i_sb)->sb_root) return;
-	if (hpfs_inode->i_rddir_off && !icount_read(i)) {
+	if (hpfs_inode->i_rddir_off && !icount_read_once(i)) {
 		if (*hpfs_inode->i_rddir_off)
 			pr_err("write_inode: some position still there\n");
 		kfree(hpfs_inode->i_rddir_off);
diff --git a/fs/inode.c b/fs/inode.c
index 5ad169d51728..1f5a383ccf27 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -907,7 +907,7 @@ void evict_inodes(struct super_block *sb)
 again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (icount_read(inode))
+		if (icount_read_once(inode))
 			continue;
 
 		spin_lock(&inode->i_lock);
@@ -1926,7 +1926,7 @@ static void iput_final(struct inode *inode)
 	int drop;
 
 	WARN_ON(inode_state_read(inode) & I_NEW);
-	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
+	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
 
 	if (op->drop_inode)
 		drop = op->drop_inode(inode);
@@ -1945,7 +1945,7 @@ static void iput_final(struct inode *inode)
 	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
 	 * Note we only execute this if the verdict was to drop the inode.
 	 */
-	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
+	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
 
 	if (drop) {
 		inode_state_set(inode, I_FREEING);
@@ -1989,7 +1989,7 @@ void iput(struct inode *inode)
 	 * equal to one, then two CPUs racing to further drop it can both
 	 * conclude it's fine.
 	 */
-	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 1, inode);
+	VFS_BUG_ON_INODE(icount_read_once(inode) < 1, inode);
 
 	if (atomic_add_unless(&inode->i_count, -1, 1))
 		return;
@@ -2023,7 +2023,7 @@ EXPORT_SYMBOL(iput);
 void iput_not_last(struct inode *inode)
 {
 	VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR), inode);
-	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 2, inode);
+	VFS_BUG_ON_INODE(icount_read_once(inode) < 2, inode);
 
 	WARN_ON(atomic_sub_return(1, &inode->i_count) == 0);
 }
@@ -3046,7 +3046,7 @@ void dump_inode(struct inode *inode, const char *reason)
 	}
 
 	state = inode_state_read_once(inode);
-	count = atomic_read(&inode->i_count);
+	count = icount_read_once(inode);
 
 	if (!sb ||
 	    get_kernel_nofault(s_type, &sb->s_type) || !s_type ||
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 98a8f0de1199..22834eddd5b1 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -608,7 +608,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		inode->i_sb->s_id,
 		(unsigned long long)NFS_FILEID(inode),
 		nfs_display_fhandle_hash(fh),
-		icount_read(inode));
+		icount_read_once(inode));
 
 out:
 	return inode;
@@ -2261,7 +2261,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	dfprintk(VFS, "NFS: %s(%s/%llu fh_crc=0x%08x ct=%d info=0x%llx)\n",
 			__func__, inode->i_sb->s_id, inode->i_ino,
 			nfs_display_fhandle_hash(NFS_FH(inode)),
-			icount_read(inode), fattr->valid);
+			icount_read_once(inode), fattr->valid);
 
 	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
 		/* Only a mounted-on-fileid? Just exit */
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 888f9e35f14b..ab35e35b16d7 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2842,7 +2842,7 @@ int cifs_revalidate_dentry_attr(struct dentry *dentry)
 	}
 
 	cifs_dbg(FYI, "Update attributes: %s inode 0x%p count %d dentry: 0x%p d_time %ld jiffies %ld\n",
-		 full_path, inode, icount_read(inode),
+		 full_path, inode, icount_read_once(inode),
 		 dentry, cifs_get_time(dentry), jiffies);
 
 again:
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 9a77d8b64ffa..38972786817e 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -358,7 +358,7 @@ static void ubifs_evict_inode(struct inode *inode)
 		goto out;
 
 	dbg_gen("inode %llu, mode %#x", inode->i_ino, (int)inode->i_mode);
-	ubifs_assert(c, !icount_read(inode));
+	ubifs_assert(c, !icount_read_once(inode));
 
 	truncate_inode_pages_final(&inode->i_data);
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index beaa26ec62da..4f659eba6ae5 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1046,7 +1046,7 @@ xfs_itruncate_extents_flags(
 	int			error = 0;
 
 	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
-	if (icount_read(VFS_I(ip)))
+	if (icount_read_once(VFS_I(ip)))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 	if (whichfork == XFS_DATA_FORK)
 		ASSERT(new_size <= XFS_ISIZE(ip));
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 5e8190fe2be9..cbdec40826b3 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1156,7 +1156,7 @@ DECLARE_EVENT_CLASS(xfs_iref_class,
 	TP_fast_assign(
 		__entry->dev = VFS_I(ip)->i_sb->s_dev;
 		__entry->ino = ip->i_ino;
-		__entry->count = icount_read(VFS_I(ip));
+		__entry->count = icount_read_once(VFS_I(ip));
 		__entry->pincount = atomic_read(&ip->i_pincount);
 		__entry->iflags = ip->i_flags;
 		__entry->caller_ip = caller_ip;
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 116774886244..c8c8847bb6f6 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -190,7 +190,7 @@ TRACE_EVENT(generic_add_lease,
 		__entry->i_ino = inode->i_ino;
 		__entry->wcount = atomic_read(&inode->i_writecount);
 		__entry->rcount = atomic_read(&inode->i_readcount);
-		__entry->icount = icount_read(inode);
+		__entry->icount = icount_read_once(inode);
 		__entry->owner = fl->c.flc_owner;
 		__entry->flags = fl->c.flc_flags;
 		__entry->type = fl->c.flc_type;
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..32d560f12dbd 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1278,7 +1278,7 @@ static void hook_sb_delete(struct super_block *const sb)
 		struct landlock_object *object;
 
 		/* Only handles referenced inodes. */
-		if (!icount_read(inode))
+		if (!icount_read_once(inode))
 			continue;
 
 		/*
-- 
2.48.1

