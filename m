Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792955452;
	b=r+ahz0kWYtku+QAEY1pNd1V+au7CyLsEh6TNnpNhdTeTkslSBAEKNipyzT7DXpPkR1OG
	 XV76UsRo4HrDy7rZryxR11/m9888K5Q/GWvI/PGF9bynwal6Ezs7VghXPOcrt9uClzZno
	 aVGAbRJAvoosRPDNL+uTQiEM80CqTxuQLD9ij+H2y/BOT9syqa4pla84qI6Zu0tAnFdU9
	 XlzTPCTUGHegkragToMeE9xdnl0kpmaKyerElx8MsftnKmYn69lxNRhcDdRo7O+qoYUhG
	 1lqI1YuyssGEVUiTUdipQ0StGgGJ4C9HLK1o5XR5dCpepBcSG2zaY7fbVUEblcl1QaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955452;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LBZW4ftrWOFPrkTKVEiEMaJhDqWgK5/US4CxAZhMnpA=;
	b=kcLJu5FDtkcrdxcBGTOGVo2j3/G2FmvEu3KIpTPJfv1FeZLWVCEqzpesxPNmqRPKcJCl
	 zz5yjd5aLrriTZQ+dXqI43nS4MgNxNKB+/L9+5CpHEMq4/dkHTpm80IYSubl4V82nOhVG
	 KRIBXSylbZTb7Zhejz/GSeIbmSVfz1OgJtn42xeLx6qa7J/Po8QGurAeDtjBGR1CVrnuB
	 IbEXvaebrHXAH9+knKT/MYsJ5i0yeWvw0h8Vq5P8R+LPVojKukIcs+T2LLy+KUnoEeqUd
	 oj7bNsbNb8wU0XXCA1LlQYmJrvBaey/1XxIgn0lPa3eEd8AYcY9L5vKAPdY3PwlUxdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=5GHskevW;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63F606A31F;
	Sun, 25 Oct 2026 19:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F63F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=5GHskevW
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 381891210B1;
	Sun, 25 Oct 2026 16:10:40 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1792955440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBZW4ftrWOFPrkTKVEiEMaJhDqWgK5/US4CxAZhMnpA=;
	b=5GHskevWkqGW40QnRvUXhEToUw9q/Wtmg72x8LzvrmHIJOoR5Ts2cparRUzA7saSTe8u1A
	2SHhRcKqhqZv8jhel0WglkpUHwtiThLRxrU5kgd6WmdNq1H9lxeCxnLJkUwya4O5Cd6S/0
	T5baz3+vtJQ9zEG0/kY0h5c3Hu3iXCx/JTl/iRBo+R9NHoiwKFVfvNSrbtdyGSX08HnqzD
	nZ/E9BrvNApLVUijxtwAobuO62mdz+6GhezA9XJhtCWY/hIQ3glHeFnpItRvHVxddjLym8
	9JsBk6RkMQl+A5M+n+pa+F+9UjzTKuTblyLzANMIy15y+1mGiLB+vkYFvlw+Gw==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH 1/2] fat: batch synchronous mirror writes
Date: Sun, 25 Oct 2026 16:10:05 -0300
Message-ID: <20261025191006.407209-2-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025191006.407209-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261025191006.407209-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fat_mirror_bhs() currently synchronizes buffer-by-buffer on synchronous
mounts, serializing I/O and degrading performance.

Make fat_mirror_bhs() batch dirty buffer heads and use fat_sync_bhs()
to sync several at once. Add a fat_brelse_array() helper that releases
buffer heads in an array.

Benchmarking was done under QEMU/KVM with a virtio-blk device using
cache=directsync. Each result is the arithmetic mean of 10 samples.

start = now_ns();
for (unsigned i = 0; i < count; i++) {
	fallocate(fds[i], FALLOC_FL_KEEP_SIZE, 0, bytes);
}
elapsed = now_ns() - start;

Sync-mounted FAT32 using count=16 files:
File size    Cluster size    Before    After    Improvement
256MiB       512B            49.81s    12.26s   4.06x
1MiB         512B            0.198s    0.057s   3.50x
256MiB       4096B           7.060s    1.640s   4.31x
1MiB         4096B           0.073s    0.028s   2.60x

Asynchronous mounts were also benchmarked with no noticeable performance
change.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/fat.h    |  1 +
 fs/fat/fatent.c | 81 +++++++++++++++++++++++++++++++++++--------------
 fs/fat/misc.c   |  6 ++++
 3 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index b18385461de8..5086c35230ac 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -479,6 +479,7 @@ void fat_truncate_time(struct inode *inode, struct timespec64 *now,
 int fat_update_time(struct inode *inode, enum fs_update_time type,
 		unsigned int flags);
 extern int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs);
+void fat_brelse_array(struct buffer_head *bhs[], int n);
 
 int fat_cache_init(void);
 void fat_cache_destroy(void);
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 8897a5dd522d..4fa1fae5abf9 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -376,39 +376,74 @@ int fat_ent_read(struct inode *inode, struct fat_entry *fatent, int entry)
 	return ops->ent_get(fatent);
 }
 
-/* FIXME: We can write the blocks as more big chunk. */
-static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
-			  int nr_bhs)
+static int fat_mirror_one(struct super_block *sb, struct buffer_head **bhs,
+			  int nr_bhs, int target)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	sector_t backup_fat = sbi->fat_length * target;
+	/*
+	 * Use the value of MAX_BUF_PER_PAGE for 4K pages. This reduces stack
+	 * usage on large-page architectures as callers may already have a
+	 * MAX_BUF_PER_PAGE-sized array in their stack.
+	 */
+	struct buffer_head *dirty[8];
 	struct buffer_head *c_bh;
-	int err, n, copy;
+	int err, err2, n, nr_dirty;
 
+	nr_dirty = 0;
 	err = 0;
-	for (copy = 1; copy < sbi->fats; copy++) {
-		sector_t backup_fat = sbi->fat_length * copy;
-
-		for (n = 0; n < nr_bhs; n++) {
-			c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
-			if (!c_bh) {
-				err = -ENOMEM;
-				goto error;
+	for (n = 0; n < nr_bhs; n++) {
+		c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
+		if (!c_bh) {
+			err = -ENOMEM;
+			goto error;
+		}
+		/* Avoid race with userspace read via bdev */
+		lock_buffer(c_bh);
+		memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
+		set_buffer_uptodate(c_bh);
+		unlock_buffer(c_bh);
+		mmb_mark_buffer_dirty(c_bh,
+			&MSDOS_I(sbi->fat_inode)->i_metadata_bhs);
+		if (sb->s_flags & SB_SYNCHRONOUS) {
+			dirty[nr_dirty] = c_bh;
+			++nr_dirty;
+			if (nr_dirty == ARRAY_SIZE(dirty)) {
+				err = fat_sync_bhs(dirty, nr_dirty);
+				fat_brelse_array(dirty, nr_dirty);
+				nr_dirty = 0;
+				if (err)
+					goto error;
 			}
-			/* Avoid race with userspace read via bdev */
-			lock_buffer(c_bh);
-			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
-			set_buffer_uptodate(c_bh);
-			unlock_buffer(c_bh);
-			mmb_mark_buffer_dirty(c_bh,
-				&MSDOS_I(sbi->fat_inode)->i_metadata_bhs);
-			if (sb->s_flags & SB_SYNCHRONOUS)
-				err = sync_dirty_buffer(c_bh);
+		} else {
 			brelse(c_bh);
-			if (err)
-				goto error;
 		}
 	}
+
 error:
+	if (nr_dirty) {
+		err2 = fat_sync_bhs(dirty, nr_dirty);
+		if (!err)
+			err = err2;
+		fat_brelse_array(dirty, nr_dirty);
+	}
+
+	return err;
+}
+
+static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
+			  int nr_bhs)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	int err, copy;
+
+	err = 0;
+	for (copy = 1; copy < sbi->fats; copy++) {
+		err = fat_mirror_one(sb, bhs, nr_bhs, copy);
+		if (err)
+			break;
+	}
+
 	return err;
 }
 
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index e79762cf1975..f8f89b947baf 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -365,3 +365,9 @@ int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
 	}
 	return err;
 }
+
+void fat_brelse_array(struct buffer_head *bhs[], int n)
+{
+	while (--n >= 0)
+		brelse(bhs[n]);
+}
-- 
2.43.0

