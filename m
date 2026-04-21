Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AECD375AB5
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795970; cv=none; b=b/5qHCo/L9HSwtGgs86M3s7Y0lQhGA43fGkvdbgy/hNpH3QKk85WHkjn9qOK2xa5jzhfupXd0ZQkUqkPMKSawlj3lT2n03GRi/8K8f5X5ItXPK3xWpSzSIWfmxLLsaLWwIXWd6vPbCxMs1+LjODlVjr0kVHcxG5s+LNWV158Qdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795970; c=relaxed/simple;
	bh=XDOLfamNpMiS8ohhmHXjcuP7Y/+SfT+yBUF9Gbw2JrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTlL2TMxJngxi5gHpWpL44tPB2gmZjinEFKSa8tWMYNVa2qLzE9LZ3+2hvX3SRntOwZ56gD6BcDUPUWVtH63uKjCSeB5rEL2L9aFqLTg8kOQYVfboIiB9ilg13MmgKgYx1Wx/pc1b8u6BwyNUC/E+4v4E7Xf1GDkdJk+npKh9to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdPWWtzW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdPWWtzW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d73352cf2so3832248f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795954; x=1777400754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpreA5Lv6NS64q4BhjgYRMLorI88lJFA+slHotBbvSo=;
        b=VdPWWtzW7wKZA8GfKr8Dze5sp/RcpEIXH4dlfGxzeEVQRJqmwUGThyhL4tJfqxbnBq
         E+qUJ7gTL1BBKnq4pO5odUgjaCHOEVz8T2Ui28OCuoiBA9aVvnOhFFgEGlen2E2DlVps
         kSBFMUSB4n91W/XBPRpyfXnyegWyA9XuW0CLWVxRT5pD1H/0YYjm4c0mwyA1pnyyHUlV
         BjmDKWcXkgyugSOadxpzaFaphup+n3y71+G7IrJr27pthlylusOHx4OXnD7dxZhoE1/r
         hMUzWlyB9Lq03HdfNYRnrpLpO9hhiYjH8yxRFtYgfB3U9VU+Ihj16SjfpTyH8CBcluyO
         5XvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795954; x=1777400754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zpreA5Lv6NS64q4BhjgYRMLorI88lJFA+slHotBbvSo=;
        b=YZYy4JS4DuQj8WsAglPxZ/wRpwypE/HnzPEqg5aTRokIiwycUqz2zAYnO6qrm4SnmD
         QsklKfLPgAYv547QEwxOEeCfGaPtfQuvlQpRaRspby5kkW4MtNzPyvzfAEA1G4/UdYKd
         +KZJo/xRPYiKP3Nth3T4nMakw62OseTShsGTxrv5vBJIGvZWxKqTCYLd5ItUu2OTtSBG
         9lAJ6LbevEU/ZRMFI6VNZ1hupjXNP6SEsqdoG4CABKTeZ14HAoa5G6deyV0zzX9/b3mE
         BvhyIOY8WlqRpBHaV025u0D6rDxQZRxo++AuZcFxXNPFPtq3A98U5pN2Xx3OQg911FAS
         3yfA==
X-Forwarded-Encrypted: i=1; AFNElJ/Vk8JErm2aB2E8EDcoNgtW0tSLK+DLWkEFIkUWz0sdub+Z7QCeKhhH/kLv5QKXAgdV49HuJ/errqWsjbER@vger.kernel.org
X-Gm-Message-State: AOJu0YzKelFn8nk8PVBoCgn+CnvSaYT1Xul+tSVk4rp0D4AxPqxwiQGl
	FNpdEp0G3bVnGwqTvrZmiNBKrvao4BUFWwdL8lPvDPX2id/IAqKH52VF
X-Gm-Gg: AeBDiet+8gIGmZy/AadIevPl7pjQ/lFbQ/9CsiZ7AA76nNgcOOO6VvxZfPw1OzfpEH0
	6KEEUbVcJhlVS7Qvja/j2qXOXc8hscSEM5QEV8U0ab3UFAe4txr03nb6TD99Z1SH22DSqh8C4vL
	pZ41mF4B4xZiRfqNDq5PXsySU7DZZU0uHuor3BoK4DKYNfcZGjgN8Ud7LCnTfbMtytKCEiowPOL
	w2SGVhbeHLFs1mtZE7CuXlLceWcGX2M5G3Z+q0T8bVFz7mOEC6Uw8sfpbG+8epEuN1QZ/YLK87Z
	qNaWGxcAxob2j2Ncozmp2pQXcqhKr2mECIWfM0OicwgcdBv85kwB8KSsOq1Mpc7M+ncocs2NOKk
	KTAokSODLBmMdTxDOWQfyEhDl0DJFGdsczzXs8XATECHM6Lz6mkynJykBF5PU9PD+jGbBz0nFQB
	VB5WnmhGjXvtY2uNP8JbkCtHfA7LhH4rufsjELVybLgzFbwsRmqxNRO11p/WMSoIs5m+DFA25Ow
	Y71n8ouVw==
X-Received: by 2002:a05:6000:22c5:b0:43c:ef4f:79dc with SMTP id ffacd0b85a97d-43fe3db9b0emr29468488f8f.8.1776795953480;
        Tue, 21 Apr 2026 11:25:53 -0700 (PDT)
Received: from f.. (cst-prg-4-152.cust.vodafone.cz. [46.135.4.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm38694053f8f.4.2026.04.21.11.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:25:52 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v6 1/3] fs: add icount_read_once() and stop open-coding ->i_count loads
Date: Tue, 21 Apr 2026 20:25:36 +0200
Message-ID: <20260421182538.1215894-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421182538.1215894-1-mjguzik@gmail.com>
References: <20260421182538.1215894-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to inode_state_read_once(), it makes the caller spell out
they acknowledge instability of the returned value.

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
 include/linux/fs.h                       | 13 +++++++++++++
 include/trace/events/filelock.h          |  2 +-
 security/landlock/fs.c                   |  2 +-
 14 files changed, 33 insertions(+), 20 deletions(-)

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
index 40474014c03f..7dc1b8168278 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4745,7 +4745,7 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 
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
index 69e219f0cfcb..e57873136093 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -902,7 +902,7 @@ void evict_inodes(struct super_block *sb)
 again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (icount_read(inode))
+		if (icount_read_once(inode))
 			continue;
 
 		spin_lock(&inode->i_lock);
@@ -1920,7 +1920,7 @@ static void iput_final(struct inode *inode)
 	int drop;
 
 	WARN_ON(inode_state_read(inode) & I_NEW);
-	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
+	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
 
 	if (op->drop_inode)
 		drop = op->drop_inode(inode);
@@ -1939,7 +1939,7 @@ static void iput_final(struct inode *inode)
 	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
 	 * Note we only execute this if the verdict was to drop the inode.
 	 */
-	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
+	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
 
 	if (drop) {
 		inode_state_set(inode, I_FREEING);
@@ -1983,7 +1983,7 @@ void iput(struct inode *inode)
 	 * equal to one, then two CPUs racing to further drop it can both
 	 * conclude it's fine.
 	 */
-	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 1, inode);
+	VFS_BUG_ON_INODE(icount_read_once(inode) < 1, inode);
 
 	if (atomic_add_unless(&inode->i_count, -1, 1))
 		return;
@@ -2017,7 +2017,7 @@ EXPORT_SYMBOL(iput);
 void iput_not_last(struct inode *inode)
 {
 	VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR), inode);
-	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 2, inode);
+	VFS_BUG_ON_INODE(icount_read_once(inode) < 2, inode);
 
 	WARN_ON(atomic_sub_return(1, &inode->i_count) == 0);
 }
@@ -3040,7 +3040,7 @@ void dump_inode(struct inode *inode, const char *reason)
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
index 24040909d184..0b66cd0fa2ff 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2843,7 +2843,7 @@ int cifs_revalidate_dentry_attr(struct dentry *dentry)
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
index 1c098cfc5c00..f87c738d84b2 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1158,7 +1158,7 @@ DECLARE_EVENT_CLASS(xfs_iref_class,
 	TP_fast_assign(
 		__entry->dev = VFS_I(ip)->i_sb->s_dev;
 		__entry->ino = ip->i_ino;
-		__entry->count = icount_read(VFS_I(ip));
+		__entry->count = icount_read_once(VFS_I(ip));
 		__entry->pincount = atomic_read(&ip->i_pincount);
 		__entry->iflags = ip->i_flags;
 		__entry->caller_ip = caller_ip;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b5b01bb22d12..a046ae84a227 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2217,8 +2217,21 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+/*
+ * returns the refcount on the inode. it can change arbitrarily.
+ */
+static inline int icount_read_once(const struct inode *inode)
+{
+	return atomic_read(&inode->i_count);
+}
+
+/*
+ * returns the refcount on the inode. The lock guarantees no new references
+ * are added, but references can be dropped as long as the result is > 0.
+ */
 static inline int icount_read(const struct inode *inode)
 {
+	lockdep_assert_held(&inode->i_lock);
 	return atomic_read(&inode->i_count);
 }
 
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

