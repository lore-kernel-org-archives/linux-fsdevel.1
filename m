Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8E3264C3
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341888; cv=none; b=DBS0tMWxp8ssKFHfcPMPl2Yg2XRqx+noWLy6vOAJKwgQdCHUs7DBzNOLAa7VPWzG+2z3llf4oldkjZam/+xndEAJQVljSSxW1jFmamItZumMRrYOU+9LbVKXmo29/IUwFqRgEPnTclX1jFayk0uC+QF7vYj/++JU7tSaZLY9gLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341888; c=relaxed/simple;
	bh=ZrSHaTEVIBPbuivLDqnR0pLvUByzbJKwc91bLjLDWKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rjov47xdYrGKqI0W+4eNgtW3/7VT8btJWM6bYixpSUF0mD4fZ/d9wbcRmELBcqNOSfDzzEe3n1djnHQ246sz1rqGq2w33WET9Lda3HGB95h5oU5Jf+gNXdhD4e8Sio9tqc+QRxkn/lFj9deOQQv7os3IZDStv7Gq1z8+w6n9oNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
	by 156.147.23.51 with ESMTP; 28 Apr 2026 10:34:42 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: hyc.lee@gmail.com
Received: from unknown (HELO hyunchul-PC02.lge.net) (10.177.111.62)
	by 156.147.1.125 with ESMTP; 28 Apr 2026 10:34:42 +0900
X-Original-SENDERIP: 10.177.111.62
X-Original-MAILFROM: hyc.lee@gmail.com
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cheol.lee@lge.com
Subject: [PATCH] ntfs: drop nlink once for WIN32/DOS aliases
Date: Tue, 28 Apr 2026 10:34:10 +0900
Message-ID: <20260428013410.2025736-1-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NTFS could store a filename as paired WIN32 and
DOS $FILE_NAME attributes for directories.
But ntfs_delete() deleted both attributes for
unlinking a directory, but it also called
drop_nlink() for each attributes.

This could trigger warnings when unlinking
directories.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/namei.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 10894de519c3..96c450e62efc 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -945,7 +945,8 @@ static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 
 	ni_mrec = actx->base_mrec ? actx->base_mrec : actx->mrec;
 	ni_mrec->link_count = cpu_to_le16(le16_to_cpu(ni_mrec->link_count) - 1);
-	drop_nlink(VFS_I(ni));
+	if (!S_ISDIR(VFS_I(ni)->i_mode))
+		drop_nlink(VFS_I(ni));
 
 	mark_mft_record_dirty(ni);
 	if (looking_for_dos_name) {
@@ -955,6 +956,13 @@ static int ntfs_delete(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 		goto search;
 	}
 
+	/*
+	 * For directories, Drop VFS nlink only when mft record link count
+	 * becomes zero. Because we fixes VFS nlink to 1 for directories.
+	 */
+	if (S_ISDIR(VFS_I(ni)->i_mode) && !le16_to_cpu(ni_mrec->link_count))
+		drop_nlink(VFS_I(ni));
+
 	/*
 	 * If hard link count is not equal to zero then we are done. In other
 	 * case there are no reference to this inode left, so we should free all
@@ -1221,7 +1229,8 @@ static int __ntfs_link(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 	}
 	/* Increment hard links count. */
 	ni_mrec->link_count = cpu_to_le16(le16_to_cpu(ni_mrec->link_count) + 1);
-	inc_nlink(VFS_I(ni));
+	if (!S_ISDIR(vi->i_mode))
+		inc_nlink(VFS_I(ni));
 
 	/* Done! */
 	mark_mft_record_dirty(ni);
-- 
2.43.0

