Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626562;
	b=5L6Lz5N0ISWXorQrCxH6PuE0lY4BAey0sXMWbO1mdI25Fnt10zjAuhCfg6Y/f8uGOHhg
	 ieiWPve6OD84kDWSYPUU7q5/zV/miE9/m8+/VU7xom85QaBGbnHQuz1NS6Tztt1OgZTvh
	 KtLq/nxtuNmMqrkUdM7rwiH1qveuUUKvRFySWxtb6fhTcyv+dOEkL2JUtxMCKZIXTGYzU
	 1sYiPU0Ojjv3i7m6jYgW44preBBGp92xxP4lkxdRfQAg7tvdjV0LRkXMc4b+r5V+l+ulm
	 cBrTl/4jjMV8TFAWzy+nEX1GMVZspg8+9a1sHh0VPCKSsgTIui/OojCPVIrkqOXm8NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626562;
	h=DMARC-Filter:Received:From:Date:To:Cc:Subject:Message-ID;
	bh=WBBm0zhB0s2uFMKDgwrR0/RI1MLnMKTKikU+uMziPVw=;
	b=QvZnJjjI2LTiFSP+mu8RUpQyakX6vzyX59A1OA31XEuX+QR1JvdvbVb77uWAZcLUZVJZ
	 R1C9Ma68igdIpKtYBjlHC46hV7cDXnD9B1ke3RAMWywINXSZx4qkggl5rw/BI3u9exCb6
	 ytvzZruF0JQCh9KlK8sNDVDurdWkj/sBEVPsQGV3JtRU3hKTRcazq1snqVtVpqHi4YMCq
	 jEcbsJFA2y+iA4fkt+RCk+9bybovpdGTmFyaT/ZKhn3qUOKg+mtIg2peOXYo4ame3rNco
	 2+BhiS51wiheS0rvzK1mUFlCMI51LYGYX56YP5SI++2VNbKwwUZkZZcRjoelHlyyQ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E1A606A31E;
	Wed, 25 Nov 2026 17:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E1A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id 038FDC9300; Thu, 26 Nov 2026 02:09:20 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Date: Thu, 26 Nov 2026 02:08:59 +0900
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH] ufs: zero new data fragments with one request
Message-ID: <20261126-ufs-05-v1@snowrabbit.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

A block taken for a page being written is zeroed on the device with
sync_dirty_buffer(), one fragment at a time.  That is a synchronous
write for every fragment of every new block, and most of the time spent
writing a new file.

Zero the run with one sb_issue_zeroout(), after cleaning what the block
device's cache holds over it, and keep the old loop for when that fails.

Metadata stays with the loop, with -o sync too.  An indirect block is
read back through the block device's cache, so it has to be zeroed
there.

Writing 128 MiB with dd conv=fsync to virtio-blk, five times, in MB/s:
12-13 before and 87-89 after with 1K fragments, 47-50 before and
272-284 after with 4K fragments.  Creating and removing files of 128 KiB
to 1.4 MiB with -o sync, none differed from what was written, also after
a remount.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 fs/ufs/balloc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 628edfde3..44ff268fd 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -17,6 +17,7 @@
 #include <linux/capability.h>
 #include <linux/bitops.h>
 #include <linux/bio.h>
+#include <linux/blkdev.h>
 #include <asm/byteorder.h>
 
 #include "ufs_fs.h"
@@ -311,12 +312,32 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 	UFSD("EXIT\n");
 }
 
+/*
+ * Zero @n fragments from @beg, taken for a page being written, on the
+ * device itself.  Such a block is larger than the page when the block is,
+ * and its other fragments may be read back from the device before anything
+ * else writes them, so the zeroes have to be there already.
+ *
+ * Only for data.  A buffer the block device's cache has over the fragments
+ * is cleaned, not zeroed, and an indirect block is read through it.
+ */
+static int ufs_zero_frags_now(struct inode *inode, sector_t beg,
+			      unsigned int n)
+{
+	struct super_block *sb = inode->i_sb;
+
+	clean_bdev_aliases(sb->s_bdev, beg, n);
+	return sb_issue_zeroout(sb, beg, n, GFP_NOFS);
+}
+
 static void ufs_clear_frags(struct inode *inode, sector_t beg, unsigned int n,
 			    int sync)
 {
 	struct buffer_head *bh;
 	sector_t end = beg + n;
 
+	if (sync && !ufs_zero_frags_now(inode, beg, n))
+		return;
 	for (; beg < end; ++beg) {
 		bh = sb_getblk(inode->i_sb, beg);
 		lock_buffer(bh);

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
