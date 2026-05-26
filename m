Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FC3FD13B;
	Tue, 26 May 2026 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803364; cv=none; b=FAKvCH7aaFNfZzitpWZ1mndyTY2kSFE99bGGoo5LMsj1VRXsXD2upno0pG9cq7Y37gVXj67ypNHlvwUZCiAlJw0PHU2A8qAal76Ir6owyZUKTlNKVOGZhIWSeu3yYvcvfnghyPrk3zhEIdNY/QELeNJeuYmXUrYcWOUFMUx7j/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803364; c=relaxed/simple;
	bh=K1CZOvYw26/2CnOXQQMSlIdrrc2BIL3sfekVnobidk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u15VuVQXjKSS+fVRUyQuohtWVxajba+b2scctuJWksmBHO6ZtiaThsSju5NNj+FI657RMam5GlvKlJT+Q7IBmZj1Ko9bmvuRpkYJhA3RYWdDaepDFGnKRgxgaZjhO+28dHK4D3NrWjBojzQ6ySDZ335bDcPGWd2JVm+VUx0ZTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=VTP1jbKR; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="VTP1jbKR"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 10FB51D40;
	Tue, 26 May 2026 13:49:23 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=VTP1jbKR;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 58EBD1E07;
	Tue, 26 May 2026 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1779803360;
	bh=L/Uc4IxEWBGjiSYqcNyQivMtiJFGpQIxuvDhehHtO/4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VTP1jbKRunr5DRMSoYP/gK+lCK5xNZpRDcuV+jYeDDZGPa6Q1yxm5ffxiVId3aI7w
	 wHxfxSqXQmyAGF3t8hbD4RBWZt3TZwH+L1gwdCfoY53wvslOynAtZLiJAaDngkXanZ
	 R6ImnV6XgFXD4QbAMDZWWvdx4b3rWZg+15ap26g0=
Received: from localhost.localdomain (172.30.20.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 May 2026 16:49:19 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 1/6] fs/ntfs3: add fileattr support
Date: Tue, 26 May 2026 15:49:02 +0200
Message-ID: <20260526134907.11402-2-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526134907.11402-1-almaz.alexandrovich@paragon-software.com>
References: <20260526134907.11402-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Implement fileattr_get() and fileattr_set() to fix a problem found
during the internal testing.

This allows ntfs3 to expose and modify inode flags through the generic
file attribute interface used by FS_IOC_GETFLAGS and FS_IOC_SETFLAGS.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/inode.c   |  2 ++
 fs/ntfs3/namei.c   |  4 +++
 fs/ntfs3/ntfs_fs.h |  6 ++++
 4 files changed, 91 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index b041639ab406..f421a36b1ed6 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -89,6 +89,80 @@ static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
 	return 0;
 }
 
+/*
+ * ntfs_fileattr_get - inode_operations::fileattr_get
+ */
+int ntfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_inode *ni = ntfs_i(inode);
+	u32 flags = 0;
+
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
+	if (inode->i_flags & S_IMMUTABLE)
+		flags |= FS_IMMUTABLE_FL;
+
+	if (inode->i_flags & S_APPEND)
+		flags |= FS_APPEND_FL;
+
+	if (is_compressed(ni))
+		flags |= FS_COMPR_FL;
+
+	if (is_encrypted(ni))
+		flags |= FS_ENCRYPT_FL;
+
+	if (ni->nodump)
+		flags |= FS_NODUMP_FL;
+
+	fileattr_fill_flags(fa, flags);
+
+	return 0;
+}
+
+/*
+ * ntfs_fileattr_set - inode_operations::fileattr_set
+ */
+int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
+		      struct file_kattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_inode *ni = ntfs_i(inode);
+	u32 flags = fa->flags;
+	unsigned int new_fl = 0;
+
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
+
+	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL))
+		return -EOPNOTSUPP;
+
+	if (flags & FS_IMMUTABLE_FL)
+		new_fl |= S_IMMUTABLE;
+
+	if (flags & FS_APPEND_FL)
+		new_fl |= S_APPEND;
+
+	inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
+
+	/* Save nodump flag to return in ntfs_getattr. */
+	if (flags & FS_NODUMP_FL)
+		ni->nodump = 1;
+	else
+		ni->nodump = 0;
+
+	inode_set_ctime_current(inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
+
 static int ntfs_ioctl_get_volume_label(struct ntfs_sb_info *sbi, u8 __user *buf)
 {
 	if (copy_to_user(buf, sbi->volume.label, FSLABEL_MAX))
@@ -203,6 +277,9 @@ int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	if (inode->i_flags & S_APPEND)
 		stat->attributes |= STATX_ATTR_APPEND;
 
+	if (ni->nodump)
+		stat->attributes |= STATX_ATTR_NODUMP;
+
 	if (is_compressed(ni))
 		stat->attributes |= STATX_ATTR_COMPRESSED;
 
@@ -1547,6 +1624,8 @@ const struct inode_operations ntfs_file_inode_operations = {
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
+	.fileattr_set	= ntfs_fileattr_set,
 };
 
 const struct file_operations ntfs_file_operations = {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 42af1abe17f8..356fc94c5a18 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2095,6 +2095,8 @@ const struct inode_operations ntfs_link_inode_operations = {
 	.get_link	= ntfs_get_link,
 	.setattr	= ntfs_setattr,
 	.listxattr	= ntfs_listxattr,
+	.fileattr_get	= ntfs_fileattr_get,
+	.fileattr_set	= ntfs_fileattr_set,
 };
 
 const struct address_space_operations ntfs_aops = {
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 64cde1a856f4..c59de5f2fa97 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -518,6 +518,8 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
+	.fileattr_set	= ntfs_fileattr_set,
 };
 
 const struct inode_operations ntfs_special_inode_operations = {
@@ -526,6 +528,8 @@ const struct inode_operations ntfs_special_inode_operations = {
 	.listxattr	= ntfs_listxattr,
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
+	.fileattr_get	= ntfs_fileattr_get,
+	.fileattr_set	= ntfs_fileattr_set,
 };
 
 const struct dentry_operations ntfs_dentry_ops = {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index d53febc2559c..9939556dcdc1 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -392,6 +392,9 @@ struct ntfs_inode {
 	 */
 	u8 ni_bad;
 
+	/* Keep track of FS_NODUMP_FL. */
+	u8 nodump;
+
 	union {
 		struct ntfs_index dir;
 		struct {
@@ -529,6 +532,9 @@ bool dir_is_empty(struct inode *dir);
 extern const struct file_operations ntfs_dir_operations;
 
 /* Globals from file.c */
+int ntfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
+		      struct file_kattr *fa);
 int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
 int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-- 
2.43.0

