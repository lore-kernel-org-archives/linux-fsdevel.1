Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60213A86C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420646; cv=none; b=JzsHPW9pytKPOQERe3EcZdYr7o1om+4vWGCw87onAI3uaiXLlZ+/kLXzFn4hhvAVMxAl2iYjRQSFadw/XB5/Tue/YaP3cYkqONCDBpKY6Li/OwBgwL+Kfk7j1DvR2oFhVff/n+MQ+FHL1wRQM8Mnoa+xgR6uhV+k5BRW7/ybFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420646; c=relaxed/simple;
	bh=QXpMe5N+5yDK8yJiJNQuQyiGuv1OwBiNFuau3+CzjKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdpj0vUsCuhHegXVpBbvPtNZx0sAQpVjDQwl/PW3AUCbfxkZjKMaopGBbNyV/F1xw5ziD8n+cxZIImMNkLuuBh1bc6boh/vLlfpll7hqk2915S49dY+1WATHzMV+02AW//O6qd7lPXZQqCnoj9uJRp878tOIaZWnyfwfQ9qkDds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fFRVVKty; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fFRVVKty"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uRggKMxjHjxU9pB5qQK5Lxm2tzHyy2ferCMMaQg10Oc=; b=fFRVVKtyah4ORDhw6JDdcQDJW1
	+9lgFshmE85gRmJuvOcGSRo1gUnO0FaYgnqT0zjfwDRpCtVMsYGzL4h5U054py6WSuPLxOx3/OSsG
	72XW+L3i55qJIQQ1MIvc1omgCILd+oV69ilrrdTJGTmQVHVSQW+HjVbrfG+ev811B6RMl2uAVN5kv
	aVTrjGDwMmx6W+7ORrmi0EQqS90vaLWtqkn5+7USCtrIrgM8eOCcr3w5jOKqfQKbXzBuEX7yp5vCc
	5NmYEli+d7a9RU3Hh59rtFZGKM2CkbPcFqbWFkny21WrRxO5bdCCbYQfWd/w8Gh0Dcoe8t3ZGxaxS
	vI95UrBw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5Hrm-00000002nMa-3L6t;
	Wed, 25 Mar 2026 06:37:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] hfs: update comments on hfs_inode_setattr
Date: Wed, 25 Mar 2026 07:36:48 +0100
Message-ID: <20260325063711.3298685-2-hch@lst.de>
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

The top of function comment about hfs_inode_setattr is severely out
of date and reference a previous name for this function.  Remove it,
and update the comments in the file to record the still relevant bits
directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/hfs/inode.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535db64d6..72948eb2fadc 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -622,23 +622,6 @@ static int hfs_file_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-/*
- * hfs_notify_change()
- *
- * Based very closely on fs/msdos/inode.c by Werner Almesberger
- *
- * This is the notify_change() field in the super_operations structure
- * for HFS file systems.  The purpose is to take that changes made to
- * an inode and apply then in a filesystem-dependent manner.  In this
- * case the process has a few of tasks to do:
- *  1) prevent changes to the i_uid and i_gid fields.
- *  2) map file permissions to the closest allowable permissions
- *  3) Since multiple Linux files can share the same on-disk inode under
- *     HFS (for instance the data and resource forks of a file) a change
- *     to permissions must be applied to all other in-core inodes which
- *     correspond to the same HFS file.
- */
-
 int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		      struct iattr *attr)
 {
@@ -646,8 +629,7 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
 	int error;
 
-	error = setattr_prepare(&nop_mnt_idmap, dentry,
-				attr); /* basic permission checks */
+	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -663,6 +645,7 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return hsb->s_quiet ? 0 : error;
 	}
 
+	/* map file permissions to the closest allowable permissions in HFS */
 	if (attr->ia_valid & ATTR_MODE) {
 		/* Only the 'w' bits can ever change and only all together. */
 		if (attr->ia_mode & S_IWUSR)
-- 
2.47.3

