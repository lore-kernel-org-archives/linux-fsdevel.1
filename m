Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAF8411605
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973350; cv=none; b=YuJ4e69V1RWGUYr0ncv+nhy1hf9e7khIEKu//wMnXYltA3xCjIAkRRFwaQtlI/N3g691qBT4j+mHl0vVTju7kS0ta1e0F7HW8sUNgl+zfcjLrYbbNTASHlbTW9oNQWlMxGoM7dM89GWJS4+PvwonrA5LroCelu5ZeL1aossM52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973350; c=relaxed/simple;
	bh=L1RFcgDnQ31NWDGIxtybwFx8VaMwRcRUNwVLv3wONAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUuUeD+AvGEYnf/Zlc5h5X/89PIedqOYukUopokkLsAxn1daJCA3ir4ZU6od7f+d+LnEuJ3lJ5hhBnk8tra40721xCC4e3e/nbU7XTBQn1vkefPMpSj8omx8Sv5Z8y/XLP2BtJ4kWe+Uo4D8z+fo1jFO2tNfkAJUaC40ZgrMHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE+bCi48; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE+bCi48"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf5d14d6eso2456398f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774973345; x=1775578145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNGkc6mI/lF/b7D/ZXMwhX1tSYEj50reD2Mab1GCQ2M=;
        b=dE+bCi48+lmTNKp95lKJaLSCcBVJX/hDmY5gS/OIv0uh7FCB4hE5Nii9ob76ht6wx+
         sO/Crvmo+f/fJbG4OVGoU2x+iCpRLBo3MvMG5TDHN/7lXzkS5z+uXE/5cIP6IO4DyVda
         CMPOsizBucYx+2nGJZJ9yKLfn8efebxM5/bGvwn3kiPMxQWk7GKvTXbtaBxy4Lc/Jf1B
         cayzAIObuJmDdYFPdmOr1Q2JJmm2+4RlFMAt1giunpzcahtn6dD+q6fteIMW7lxdJjQv
         i6JPxchzyNcI9MaYbw8YLB3vijJaTb1xqnzrJtklkF28VXOKCrfSEP517gs9uglX4TMM
         J0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973345; x=1775578145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNGkc6mI/lF/b7D/ZXMwhX1tSYEj50reD2Mab1GCQ2M=;
        b=oJpfNt5Q3pownL+qze4HoQBYCenoty1pLUtCTHGgi9qqcqaHOg92COqdwTNh3ChwTP
         PXnQOWcll1C2C+A4fYQGp/W40m+IkysCTYXE5j0j/oeEpcFX0MeRQ1fwSfI3ELhxUlNW
         gqLUUgHhTlcRuP+BUvrzWfQvAFqyQN9JjYGEeO7bOpGBg0maOmmxRrt0sMepxnbIz5qC
         jvEiKA/yuztDjm5BnVXQVfylfwjv1bVV/900XFnTkoEVElHQ+I5KOXQ0TEbztCWI11z/
         JAdRZV+8HJesRM38O5bXIy0FfT389LNMCYnXCCaQp4rl6poA+KSZ+fUSN8RF+771WXQF
         0SXg==
X-Forwarded-Encrypted: i=1; AJvYcCXnjszvMrMSTLc1ACr+Kh5C7Vs6OHyWOe5G8DTVal2Mvh3uXUTI5VilAD7nFa/KggCpvuv4rZ9vyEyVtOx4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd5jja2KCeYP8P9cs9H64C13dGKlxCMorZjluaippP7QK/2r1n
	rhkGPb/8zAqLGeDdPinff7OnII5zryqXnD40/kJfYfguxlP16OKx4Asw
X-Gm-Gg: ATEYQzw205eoxCkQNDivKOPn71lWWXi+f7RkTIk2NOY9CRUV12sSzx0ftnJO3mMIR9V
	yrQjTc1Z+HBKQ2pvYRKmC1LYXWIi0EUcxCU8JmfgZiFpBTvVj7oK+bfC6udXxsycCol+2712e8N
	P7/IFe+VXy0mOstRhZinPDsDYqsy3R35dVlXMGmHIEH6L+wiGTLMU67cTFtyW/mycKRNNSWymZR
	Fim/ISjExe881tK/khnxTPBq8zDO0FnqptuB6s8BUbHQ4N33sieWXW9ShM6xlPA6+6qNn6n8g3H
	dCVtjS1E3X/ckTG2XbxNIzOsxdeZGaFbVA6UxuOpko9XkjWErztT9mbzvRi5bJ3Iw1biiwI7Znl
	nDrd3CozqPYGLIU3i+DtJjcMYnCSmrj6empV147HFX1ELT6rHS4z8K3HZ88W+OaFzHIQcP6mtDx
	n6QDJYaxBLhF+o3Gf/LLlk55Kf79bc4FgAH5KssklCaiSPI8rBeFO+50UXArroLITCwkbk9+5wn
	Q==
X-Received: by 2002:a05:6000:2384:b0:43c:f5f2:292a with SMTP id ffacd0b85a97d-43d150485edmr409130f8f.4.1774973345094;
        Tue, 31 Mar 2026 09:09:05 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e3602sm28792632f8f.4.2026.03.31.09.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:09:04 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v5 1/4] fs: add icount_read_once() and stop open-coding ->i_count loads
Date: Tue, 31 Mar 2026 18:08:48 +0200
Message-ID: <20260331160851.3854954-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331160851.3854954-1-mjguzik@gmail.com>
References: <20260331160851.3854954-1-mjguzik@gmail.com>
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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8afbe2ef2686..07363fce4406 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2225,8 +2225,21 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
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

