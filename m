Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795731386;
	b=CE/w8iABU8DkVGdrY7F7nGsx4nuPukHc36CoyNFNVDniK39B+8qdZz1nvDJsRL774kx6
	 0yTVVvMKgBxApXHxXKxc0/BtfKkRt69k3/xH4Z5zLB6rj9NwTRJZFxqhyA2fKhgSlTNln
	 9N35WbPMgue3qWkZWkxZIt/C+l3P7NBjUrweqfTpBV4P0d+W3B3CMYM4WW8XEah8RxDl7
	 4NktGbmu0NnSRCroo9VA64foNhdnZ7LJx/JU6RRTN+HRoRG3fkM87Xeoq8aC/J63aW42c
	 p8EyrWvAe+OzN/Anim2CBNikt97QiRIjumR3uvAV1U7puvwF4fECY+zHh2oh3SZKumw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795731386;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MtSVervo5/JHlDjB6bg5lOqeG0sDu+F/unUEYfN8lBk=;
	b=Ziy94zjBhV0BI4Bx8M87D8Lf0rRZB/SF/1YsYPrEMQkI6G8zr0w2MU3CWd6AyffVeUTv
	 pNZQAP1HsGmNbMF05PEC3nJOfejZp/Kp6/dNH26JCZK4sJzGP0wvs/vImkDTOrgdYtOsY
	 tz9V2I3VO+n5NkFaA77LI7x286lZ8M/eAgyy0Fw+9YIfMZ3V82IXsrvhML6MSzExw2buK
	 CBv3hYlCYEkxgZ6bCkL8sZ4dLEFEaVRT3DFZkWZtUBiWu01Z8FwVllnJahAAno6WXzKlB
	 w/dFgtlNu5zWpXccffiq/GDqrY3i+BvGsLdNJfRQib5vgfpPRJIeysO2dweVDvPAeaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GK/3jCC9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F8606A335;
	Thu, 26 Nov 2026 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GK/3jCC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DD41F00893;
	Thu, 26 Nov 2026 22:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795731386;
	bh=MtSVervo5/JHlDjB6bg5lOqeG0sDu+F/unUEYfN8lBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GK/3jCC92/+wLKZzqqGg5cAhFLS7rSTlWDT/gO0CtydFtdAN52fSqLW2103n6m+v4
	 Ye9+ncLPimKnroqLr8ccIF+N4Hlhzsh/o/TXFNpJcepqBdmkdqxBEn6L2e//1P2Zok
	 tKjcWK7DC9xVYlU+Fs/IC2jIGAFWsrqsG4A4MDa4+Q9hvY2Upw/TLJHpD/6s4dkF4O
	 yiiqIXSXwXG8OfbqnvSPC0tGjiWLG4IPHgqy+pPlF9PEScN+8VrRE1XRIQ0TJ+Mtbt
	 ECLj9fL3vdxyyi9WatojTwHDZVYeJv6m2od4/zZ71wY2ChtGGpCUUFTjvLQBrvbaEN
	 4Y01EKOd6snfQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Nov 2026 23:15:32 +0100
Subject: [PATCH 2/4] fat: support O_TMPFILE on vfat
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
Message-Id: <20261126-work-fat-tmpfile-v1-2-3bca7b2dbc20@kernel.org>
References: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
In-Reply-To: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=3568; i=brauner@kernel.org;
 h=from:subject:message-id; bh=J77JDwswhFlCLchQF/DL8MWhpzoh/IdIkAG2j78+VpQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRzrN+Q8iQl+P6D2ryCSXkihy6mVn46Kxz78t7zhRPSC
 qYsvv7bv6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi//0Y/gcERlg/uNn2W0o0
 yLMkOu9n5PeXOxWTNN3Pnpq3ZULRiyCGP1wf/rk/vDCxak1Df9zr2UGa/o21RQ8uJ8u4Hny24s2
 Fz/wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently, vfat doesn't implement ->link() since FAT has no hard links
and link(2) fails with EPERM. But O_TMPFILE is only half a feature
without linkat(). Worse, implementing just ->tmpfile() would break
userspace that works fine right now. systemd's
open_tmpfile_linkable_at() only falls back to a named temporary file if
opening with O_TMPFILE fails. If the open succeeds link_tmpfile_at()
calls linkat() and gives up if that fails. bootctl writes loader.conf,
entries.srel and the boot loader binaries to the ESP like that.

So add a ->link() that only gives an O_TMPFILE its first name.
vfs_link() refuses to link an inode without links unless it is
I_LINKABLE and it checks that under the inode lock. So an inode without
links that makes it into vfat_link() is an O_TMPFILE that may be
linked. Everything else still gets EPERM.

Linking does what vfat_rename() does for a new name: add the directory
entry, attach the inode at its position and let the inode write fill in
the start cluster and the size.

If the system crashes while an O_TMPFILE is open its clusters stay
allocated but no directory entry refers to them. The same thing happens
to an open file that was unlinked. fsck.fat finds them as lost
clusters, with -a it saves them to FSCKnnnn.REC files. ext2, minix and
udf implement O_TMPFILE without orphan handling as well.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fat/namei_vfat.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 791f2d7b85092..31b4a293c0493 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -938,6 +938,50 @@ static void vfat_update_dir_metadata(struct inode *dir, struct timespec64 *ts)
 		(void)sync_inode_metadata(dir, 1);
 }
 
+static int vfat_link(struct dentry *old_dentry, struct inode *dir,
+		     struct dentry *dentry)
+{
+	struct inode *inode = d_inode(old_dentry);
+	struct super_block *sb = dir->i_sb;
+	struct fat_slot_info sinfo;
+	struct timespec64 ts;
+	int err, err2;
+
+	/* No hard links on FAT, only give an O_TMPFILE its first name. */
+	if (inode->i_nlink)
+		return -EPERM;
+
+	mutex_lock(&MSDOS_SB(sb)->s_lock);
+
+	ts = current_time(dir);
+	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &ts, &sinfo);
+	if (err)
+		goto out;
+	inode_inc_iversion(dir);
+
+	fat_attach(inode, sinfo.i_pos);
+	err = vfat_sync_ipos(dir, inode);
+	if (err)
+		goto out_detach;
+	brelse(sinfo.bh);
+
+	inc_nlink(inode);
+	ihold(inode);
+	d_instantiate(dentry, inode);
+	mutex_unlock(&MSDOS_SB(sb)->s_lock);
+	return 0;
+
+out_detach:
+	fat_detach(inode);
+	err2 = fat_remove_entries(dir, &sinfo);	/* and releases bh */
+	if (err2)
+		fat_msg(sb, KERN_WARNING,
+			"failed to roll back new entry (%d)", err2);
+out:
+	mutex_unlock(&MSDOS_SB(sb)->s_lock);
+	return err;
+}
+
 static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		       struct inode *new_dir, struct dentry *new_dentry)
 {
@@ -1190,10 +1234,12 @@ static int vfat_rename2(const struct mnt_idmap *idmap, struct inode *old_dir,
 static const struct inode_operations vfat_dir_inode_operations = {
 	.create		= vfat_create,
 	.lookup		= vfat_lookup,
+	.link		= vfat_link,
 	.unlink		= vfat_unlink,
 	.mkdir		= vfat_mkdir,
 	.rmdir		= vfat_rmdir,
 	.rename		= vfat_rename2,
+	.tmpfile	= fat_tmpfile,
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
 	.fileattr_get	= fat_fileattr_get,

-- 
2.53.0

