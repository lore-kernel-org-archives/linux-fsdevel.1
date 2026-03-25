Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B813A86C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420651; cv=none; b=HbNtNUYHN/QSWRN6Rgp0FvBIPz8pOCvmpB+9cF/NYLfX0ihkJ4i0EGoliOdeioJVWkZ6gTZilVyg4ZnF2DBmnGyLS4rTQM7dTiQo2zu4R2dOo7MDAWWR4H1QWtN0Tp37q0Od7B4CBuOVFLtH85JAvzj3qmEygc8kePCAYPv13OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420651; c=relaxed/simple;
	bh=iWe80Gejz6emcOBlsA1IR3YV2ptjEhz/+/RURgm7I5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmGzmfz1t89D7Bfr3HpL2Giq47/pMJuO9h+yJGU3h+IRuUSyBDzfjqStIjjyVC6WCiaAMl4dpHlO1XXZs1O9ksGdWEDloYjDAODKcN+m2WUvGabjxhtPh3Bw41rmH7LvOxdpyMgpaIZ1fnchE3ili/cBJVB3Er0kgevEgdouZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dhjQpi0v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dhjQpi0v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EayGuNIgS+q6lzYMREuT11aRF49Z2/fgLliqItnlS+E=; b=dhjQpi0vAmfzDTm7ogrA9tU/iz
	mWiBMQumemgCzxJJH7w5MWPEv5qd/W9C9wxkTO0K2ZoilNqPwQqI1ztjGrRswMlYfhghqkvdEdiTQ
	y71scu5Wh/vCGtHLeVi9fDTRwqfQgzMgKCH2ZerU/noaNhF8tw3dQmzxSYYXBaama5QuJNnBUrJbA
	iflXyHMTzkDRgtQ39zkpCWSJhA4vSkh+O6fE6u76yCP9CRLv+2+WhmYXv3CNHJE+442m4pkROS24C
	cKwB+iggMTyPW8w/L3nu47be80a9EoesYmrV5QgQ0vuIebTcMOjiPfhr9Vk+MbdPxK1LfUvaj251n
	j5lvmxRA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5Hrr-00000002nNC-3MCg;
	Wed, 25 Mar 2026 06:37:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] adfs: rename adfs_notify_change to adfs_setattr
Date: Wed, 25 Mar 2026 07:36:49 +0100
Message-ID: <20260325063711.3298685-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325063711.3298685-1-hch@lst.de>
References: <20260325063711.3298685-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Make the function name match the method that it implements.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/adfs/adfs.h  | 4 ++--
 fs/adfs/dir.c   | 2 +-
 fs/adfs/file.c  | 2 +-
 fs/adfs/inode.c | 6 ++----
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 223f0283d20f..0d32b7cd99b4 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -144,8 +144,8 @@ struct adfs_discmap {
 /* Inode stuff */
 struct inode *adfs_iget(struct super_block *sb, struct object_info *obj);
 int adfs_write_inode(struct inode *inode, struct writeback_control *wbc);
-int adfs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
-		       struct iattr *attr);
+int adfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		struct iattr *attr);
 
 /* map.c */
 int adfs_map_lookup(struct super_block *sb, u32 frag_id, unsigned int offset);
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 493500f37cb9..309c0a88cabb 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -454,5 +454,5 @@ adfs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
  */
 const struct inode_operations adfs_dir_inode_operations = {
 	.lookup		= adfs_lookup,
-	.setattr	= adfs_notify_change,
+	.setattr	= adfs_setattr,
 };
diff --git a/fs/adfs/file.c b/fs/adfs/file.c
index cd13165fd904..73486667d6b4 100644
--- a/fs/adfs/file.c
+++ b/fs/adfs/file.c
@@ -32,5 +32,5 @@ const struct file_operations adfs_file_operations = {
 };
 
 const struct inode_operations adfs_file_inode_operations = {
-	.setattr	= adfs_notify_change,
+	.setattr	= adfs_setattr,
 };
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 6830f8bc8d4e..4ac442d0a8c0 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -299,8 +299,7 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
  * later.
  */
 int
-adfs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
-		   struct iattr *attr)
+adfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct super_block *sb = inode->i_sb;
@@ -355,8 +354,7 @@ adfs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
 /*
  * write an existing inode back to the directory, and therefore the disk.
- * The adfs-specific inode data has already been updated by
- * adfs_notify_change()
+ * The adfs-specific inode data has already been updated by * adfs_setattr().
  */
 int adfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
-- 
2.47.3

