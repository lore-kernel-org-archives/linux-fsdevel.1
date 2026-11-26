Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795731387;
	b=u1FgJkXRtY+tHTrACQOcrKCwZBgDJjfgntpOmdrYLksPrGhsDbnZf4jMKX1fSh8odHys
	 1npEdR70BCm4ICyEXZvCHttboP8ABAnmL5zgQ5zu6I0adl5mxrBLg4cVIsrKm9M6vNp6n
	 0hHmLkv0Q9jT9nBNyWYaJ+usIjXaiX+14t6c1NSZHBD/I3TevUAOgeNeHeeQg3D9Ung8j
	 d+OBfkaUnUKwkkjf3TpNo/QUm8ELoOyLkal6YC+Gz8jpG4zc2KXYabSYfG5XmSEZeZn3/
	 MhJqNkx9qBeSpBxiTHOra0QQS88JWsUYxCWT+blAQsXCcl4/gdMiAOGi8jGjq2ZfAhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795731387;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8z2XUUqREtvPD1Rvl386LWx/7ramX/eBbc0c8rwkDls=;
	b=GU7ME2ZP7tfh/3J5D0Hyttl7yPSSTWcB0F4sZDWqa9KHlJYnaDM2rhLDNI/vwB/ZY/3Z
	 eXNt5VNkjRDbz2eS84mD842VJ8qtU3iDJrCUVMkeHPHIFwipDhBdbHP2RYc8ZhaN+Lq8h
	 2RP+zBZLxLenXOb3DxcQfsdntCaHz/fvcFj8auThbRPzo5AV+eTqSAfVnKck6lpOF4Ys4
	 YSXQaYi/8f+sfCT9Plw5Zs/9dRPv/SyhqowOWTLprof74vPcBWMttOZh47fJ3LWjU7ymS
	 f14rF6GTFSb8/Rkw+NqeNHO2/UhknSwtZVDaA/kXFWm3rknZ1MIfcsahW9Ql8u0PZlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Im9LDFM/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F84606A323;
	Thu, 26 Nov 2026 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Im9LDFM/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6AD1F00893;
	Thu, 26 Nov 2026 22:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795731387;
	bh=8z2XUUqREtvPD1Rvl386LWx/7ramX/eBbc0c8rwkDls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Im9LDFM/yNmdORFKqB+F5MhFM4umiQeEjJY3ky2rjxCe65GJ0/llc2nyqtGv9zOQy
	 ZUxqA2dOHOXsZuOaAQydICv5NN/w5xh/1403/SMVGQcF8eXtZvuo+qiZrt7vNE3ADZ
	 NCSO0/nvyl7bSygZUFGCrMJu+NQjiYWP+odvg4WdTyokbxkssSQmdA9SI+kkYijdpZ
	 cZpzyR/pZQq0imADHDhAsqsbyWkSSo9o9RDNOYYaXW2pOcb4hLsh53x2i4+uBbWxuY
	 JKO5h0qiPX0BExjokSAToNDO/l7m19WMZ2N5m0p3DPBBanNn+72KhXCTYobBGqxiQL
	 YgnBnELOpjoYw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Nov 2026 23:15:33 +0100
Subject: [PATCH 3/4] fat: support O_TMPFILE on msdos
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-work-fat-tmpfile-v1-3-3bca7b2dbc20@kernel.org>
References: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
In-Reply-To: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=3238; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jT7nQIWsz8DKwPxh3Nz0xfFEfYVqZfzjWLZ7pz9zZY4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRzrN84T295XUpAXLC2gqP+NrOM6nWtl+v7dGxSZgnMn
 673+wNjRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERa3jP84f/y5cGy8+5OE5UK
 jhr2//ZZnq3DHmBt1nM5ZU0Ji75ULSPDFO41TjkpZ/Vfp+Qkz/9XwnPHaXJxy/O2aZzSaesVLpo
 zAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Do what vfat does. msdos_link() creates the directory entry the same
way msdos_create() does and handles ATTR_HIDDEN like do_msdos_rename().
With the dots mount option a leading dot means the file is hidden and
__fat_write_inode() writes the attributes from i_attrs. So i_attrs has
to agree with the new name.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fat/namei_msdos.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 5a43d042eb01f..5709650a29986 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -439,6 +439,74 @@ static int msdos_unlink(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
+/***** Give an O_TMPFILE its first name */
+static int msdos_link(struct dentry *old_dentry, struct inode *dir,
+		      struct dentry *dentry)
+{
+	struct inode *inode = d_inode(old_dentry);
+	struct super_block *sb = dir->i_sb;
+	struct fat_slot_info sinfo;
+	unsigned char msdos_name[MSDOS_NAME];
+	struct timespec64 ts;
+	int err, err2, is_hid, old_attrs;
+
+	/* FAT has no hard links. */
+	if (inode->i_nlink)
+		return -EPERM;
+
+	mutex_lock(&MSDOS_SB(sb)->s_lock);
+
+	err = msdos_format_name(dentry->d_name.name, dentry->d_name.len,
+				msdos_name, &MSDOS_SB(sb)->options);
+	if (err)
+		goto out;
+	is_hid = (dentry->d_name.name[0] == '.') && (msdos_name[0] != '.');
+	/* Have to do it due to foo vs. .foo conflicts */
+	if (!fat_scan(dir, msdos_name, &sinfo)) {
+		brelse(sinfo.bh);
+		err = -EINVAL;
+		goto out;
+	}
+
+	ts = current_time(dir);
+	err = msdos_add_entry(dir, msdos_name, 0, is_hid, 0, &ts, &sinfo);
+	if (err)
+		goto out;
+	inode_inc_iversion(dir);
+
+	old_attrs = MSDOS_I(inode)->i_attrs;
+	fat_attach(inode, sinfo.i_pos);
+	if (is_hid)
+		MSDOS_I(inode)->i_attrs |= ATTR_HIDDEN;
+	else
+		MSDOS_I(inode)->i_attrs &= ~ATTR_HIDDEN;
+	mark_inode_dirty(inode);
+	if (IS_DIRSYNC(dir)) {
+		err = sync_inode_metadata(inode, 1);
+		if (err)
+			goto out_detach;
+	}
+	brelse(sinfo.bh);
+
+	inc_nlink(inode);
+	ihold(inode);
+	d_instantiate(dentry, inode);
+	mutex_unlock(&MSDOS_SB(sb)->s_lock);
+	fat_flush_inodes(sb, dir, inode);
+	return 0;
+
+out_detach:
+	fat_detach(inode);
+	MSDOS_I(inode)->i_attrs = old_attrs;
+	err2 = fat_remove_entries(dir, &sinfo);	/* and releases bh */
+	if (err2)
+		fat_msg(sb, KERN_WARNING,
+			"failed to roll back new entry (%d)", err2);
+out:
+	mutex_unlock(&MSDOS_SB(sb)->s_lock);
+	return err;
+}
+
 static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 			   struct dentry *old_dentry,
 			   struct inode *new_dir, unsigned char *new_name,
@@ -651,10 +719,12 @@ static int msdos_rename(const struct mnt_idmap *idmap,
 static const struct inode_operations msdos_dir_inode_operations = {
 	.create		= msdos_create,
 	.lookup		= msdos_lookup,
+	.link		= msdos_link,
 	.unlink		= msdos_unlink,
 	.mkdir		= msdos_mkdir,
 	.rmdir		= msdos_rmdir,
 	.rename		= msdos_rename,
+	.tmpfile	= fat_tmpfile,
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
 	.fileattr_get	= fat_fileattr_get,

-- 
2.53.0

