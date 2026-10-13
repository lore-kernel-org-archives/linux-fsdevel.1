Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58414535FD2
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906783; cv=none; b=j+J5hXc/BW+iuzbyKCwnAVFM8X7uHWSmBb/Dh8kk74b2e0U4CB3P0xDc0nvEdSUGGCRAYdEzBdeIK4FnsWb7+AOHjNBxswTfDtSWWxPfzDWdllLq+cvXemmKjw2AX4MT/NofJD4IfFQTMdGa5aEEW7U9LARvCitrQYmYrb6h7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906783; c=relaxed/simple;
	bh=ChTKHUNjFcnORbYAjC4fkDktrNorx4Hi2ieqGgB8B4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFhodGCsF307Lrwt/661HGUazLVNFePAwKa/ef2+KJgBJRDmqpMJuvpBxdNX8V2wF7ay1kXqxRRwl1EZIu48OTraW3RMfAJ6HVQCvRcGgkF5DMBYHVCD6G0+H3wCzQTqurKxfJPdOEryIQE3FCBnogQjDUj6lnhHyjF3QsFo764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzYGwpt+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzYGwpt+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso1486371a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791906782; x=1792511582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fxh5ACR280mENbrJ33S86tfaesko80xm9BtlJSjT/L8=;
        b=jzYGwpt+6o6fcWnuBtA8+UuLLuKpNkFl5t/iu6pz1r8RlXN4m78IAwOa66ZrsbeEoR
         W6A8wufPktxpOlMToOBtk3dBqk+WMNMH+Z3VMRx3ZJVlluutnvEj5hUWkZ4VMgmeluAy
         Txz+P5lslH9SNtJ7ZSxmeZOiM4ggq6WI03w5TJhd6ARyqVLdrunE0Ey5e835D+3/KmuW
         isrZZBElQ/HUKMyIlSHb3jL23RtDkz8Sbv9y4ZoOmv11wsWBSWg+ANdlOnkj2dk+sr/X
         2PBuqMFjHw+2K/kgNHNOS4QCwnKDlGAga4zLL9wqQzCcZ27ZabyIgoDpLvKbYmUOuWX7
         rtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906782; x=1792511582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fxh5ACR280mENbrJ33S86tfaesko80xm9BtlJSjT/L8=;
        b=LcrABTGrz1RHG6gdLrhEb2dj1oYDmYxYMUCUVmwv5CThStsvNg5mebC8teihqeN5yV
         5IKMS6dPU/ftdDDa9vQERP9WiBW62KSn2UIN3hovVujDyrEBmEcwpBsYQ/aFwoy4ELm7
         iZTS7ssqoBRgQDci5OUPFJEpZkRcimlGUaj1aewZh/znBr1hLcpblzvWWBC2Cjb7+QNj
         1cnjdHvFZPDLkGKWN0E0j0/eqjlyYHULlbCz43RvXnUt+7L/BsCKF7fkJ3KUMD25vOgc
         pcV50LT8sFqChiF3elSjoQ2byigEiBa8Mz+MSKSqviAzNx8IxVIcXVLqhHsEALeo7DzT
         WdGw==
X-Gm-Message-State: AFq9FYIO+GwKY6PcotHDzNxozWlaU7UJg7i510OeAQ0Er5xYYGqdIAqz
	zERlOjT5uNyXbX2XnBLOI/mOGTPG+0H5QCCFjPWQhQm2PNTUFU46MyF3l67ZJnM0
X-Gm-Gg: AYBFou0SG1OgjDj7eXGd69JaxfpKfqIA+0tuhzsrw+CaDR9eZwynbfaYvIkz6xMXcJN
	KH98HrOWIlTsc+iLiOiIS/wF5IgifY39QOy0+GC30SWAzPt9K6TqwWIxgPy4Ou4WzTfnh1KeoO8
	xFguyjOvCCJRIuqmRTqiuRIIqa6ViHrvjAZnSf4y3d17mq7bLv5Ib/myWEZcb+KffTbVGJvbgC8
	9StAvuUvMG6n/YGl1eJNf3LwkWHv+Fbv6SuUvE8Wh/ESxdxdBPpJaah02vzH4lA5tEVmqNL9aHV
	9+2ewLZqhILkes2A0ipkj7DPBdaMcJiL1nwnTAQelAwvd4OflEbxW607zfQh+36wuikN0fxtDer
	4pVT2PruyVXLvMprnfZxTbYsn7B0f70Dpprc8fTrRMfIqfU3yKnYsCDQOv6lASkp2ltCASnN2aA
	7RQoRkqUyUv6yi7Ckgyn0SHv0VG/5pMHa+IA+g0TSW4ca9kbN6rOvGyP47MCUtq2+oDUMBCbQ=
X-Received: by 2002:a17:90b:384c:b0:3ab:f38:2b43 with SMTP id 98e67ed59e1d1-3ab3ac86fbamr11259302a91.34.1791906781573;
        Tue, 13 Oct 2026 08:53:01 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:2e1e::498:f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac6006280dsm95480a91.6.2026.10.13.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:53:01 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	syzbot+d35de3666410c93fd821@syzkaller.appspotmail.com
Subject: [PATCH] minix: keep the pinned bitmap buffers uptodate when dirtying them
Date: Tue, 13 Oct 2026 22:52:57 +0700
Message-ID: <20261013155257.46532-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

minix reads the inode and zone bitmap buffer heads at mount time, keeps
them pinned and modifies them in place. If a write to the backing device
fails, bh_end_write() clears BH_Uptodate on the buffer. The next
allocation or free then calls mark_buffer_dirty() on it and trips:

  WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410
  !buffer_uptodate(bh)
  Call Trace:
   evict+0x624/0xb50 fs/inode.c:822
   add_nondir fs/minix/namei.c:18 [inline]
   minix_mknod fs/minix/namei.c:50 [inline]
   minix_create+0x88/0xb0 fs/minix/namei.c:69
   lookup_open+0xc0d/0x1a40 fs/namei.c:4596

Reproduced by mounting a minix image on a loop device, making all writes
to it fail with fail_make_request, syncing and creating a file; the
warning then comes from minix_new_inode(), and from minix_free_inode()
when the creation fails and the inode is evicted.

The in-memory bitmap is the only up to date copy, so it is still valid
after a failed write. Mark it uptodate again before dirtying it, so that
the bit is written out once the device recovers.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+d35de3666410c93fd821@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d35de3666410c93fd821
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 fs/minix/bitmap.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/minix/bitmap.c b/fs/minix/bitmap.c
index abec438330a7..011063a8999b 100644
--- a/fs/minix/bitmap.c
+++ b/fs/minix/bitmap.c
@@ -39,6 +39,16 @@ static __u32 count_free(struct buffer_head *map[], unsigned blocksize, __u32 num
 	return sum;
 }
 
+/*
+ * The bitmap buffers are pinned and modified in place, so they stay
+ * authoritative even if an earlier write failed and cleared BH_Uptodate.
+ */
+static void minix_dirty_bitmap(struct buffer_head *bh)
+{
+	set_buffer_uptodate(bh);
+	mark_buffer_dirty(bh);
+}
+
 void minix_free_block(struct inode *inode, unsigned long block)
 {
 	struct super_block *sb = inode->i_sb;
@@ -64,7 +74,7 @@ void minix_free_block(struct inode *inode, unsigned long block)
 		printk("minix_free_block (%s:%lu): bit already cleared\n",
 		       sb->s_id, block);
 	spin_unlock(&bitmap_lock);
-	mark_buffer_dirty(bh);
+	minix_dirty_bitmap(bh);
 	return;
 }
 
@@ -83,7 +93,7 @@ int minix_new_block(struct inode * inode)
 		if (j < bits_per_zone) {
 			minix_set_bit(j, bh->b_data);
 			spin_unlock(&bitmap_lock);
-			mark_buffer_dirty(bh);
+			minix_dirty_bitmap(bh);
 			j += i * bits_per_zone + sbi->s_firstdatazone-1;
 			if (j < sbi->s_firstdatazone || j >= sbi->s_nzones)
 				break;
@@ -207,7 +217,7 @@ void minix_free_inode(struct inode * inode)
 	if (!minix_test_and_clear_bit(bit, bh->b_data))
 		printk("minix_free_inode: bit %lu already cleared\n", bit);
 	spin_unlock(&bitmap_lock);
-	mark_buffer_dirty(bh);
+	minix_dirty_bitmap(bh);
 }
 
 struct inode *minix_new_inode(const struct inode *dir, umode_t mode)
@@ -243,7 +253,7 @@ struct inode *minix_new_inode(const struct inode *dir, umode_t mode)
 		return ERR_PTR(-ENOSPC);
 	}
 	spin_unlock(&bitmap_lock);
-	mark_buffer_dirty(bh);
+	minix_dirty_bitmap(bh);
 	j += i * bits_per_zone;
 	if (!j || j > sbi->s_ninodes) {
 		iput(inode);
-- 
2.43.0

