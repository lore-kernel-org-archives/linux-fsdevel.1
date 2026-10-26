Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032802;
	b=vxw/LBNzE5CQVted8XC53oQU7VjkRLHkoecHZOfK8G453DTSou1PVrRNpMIiKnm6KYsm
	 sv0ufdCdDrOI/6wFY/KNfAgv4vu+TTLXLhl4d93b2PBD/6uBebr4CEgj8x0x3FjbSqLBB
	 /voHZ5BalgqkVVGCvvfpiYZCDbaNc+/FfCkQLKryJ27nc785Xk1GPaCjz6IIQpeD9csK5
	 +M1v5ET32Hhe5w9T0GcTHoHjTGSvaFmlQPWehTSXD1cAfmuRut5e/xnwHVi31IwZfxHrS
	 iK+hwajqUyKNs/ncx7ppW0uker4362jdYN+qPJdAVoz1uiUDuQIXDU/E5hTxU9/8e6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032802;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zJTuxmueA1I8RP0C4FCElC+ZduPoStcXVxpKPRKHNIE=;
	b=KdK+DlYKe+C+y2kNVyw1HA6Pu8x+VcQQrTTUhkZDR8rkpTPjzINk5h4+uVt8WkhnnXnp
	 lieHqmr99edVkKskgX3NZB6epe6zKyWCKGLJBQKeaJH81EOXHi6vVWV+cVOee6MveGb0+
	 zIKFpc6UiQ4wB2m/9onaZO8S5rJ6yb7vuyQoWh5zsGfkILX0kf/2oKj7tVSsj5gdDL/Da
	 yAswxUZaC3dNcEJGZZGs5Gl0/h/DY7OOftGdjlHkwqsmCHzAI3vLe3ETXvx6pMoSvtXAK
	 fFEXDfh2QKAYxhoNOcHy++tR4GJEUQFRSNZjAeWaVvV1wgNRRn5b+QX5mwKppSR04Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=oxjjma+x;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E84606A31F;
	Mon, 26 Oct 2026 16:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E84606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=oxjjma+x
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 5840D1210EE;
	Mon, 26 Oct 2026 13:39:45 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793032785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJTuxmueA1I8RP0C4FCElC+ZduPoStcXVxpKPRKHNIE=;
	b=oxjjma+xYJ7JoI8Fp17TKmq/u0I9+Jj+rtVJh3pbn1ZQ8jlr0RtKnWuOoK0XS/paygMFIZ
	Q2nd+vtcQBLcD4gmEHTdj/bg7O2/2MKL/SVV97fmGWtuKu0aqYNn6+HYnJmOF0PFM76WAS
	c8dZkRNbFAQKqqirh1MkX1VgVkOipcLqImneWJwDcYns6UENLLrccgc0SZQEO8Eq0T5LGI
	hQjv6T02R1WuKy3PEmtk44R/YzljmGZ8YRjGHIGJncGgIerhelUsOVV8NlVq0cKIKYWmI0
	aYFP6NtjIDP9MX20aJamNtXlSk9PQw3kZeTk8ffYcvwzxo0pZp5CHWXCo8kVWg==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH v2 1/2] fat: batch synchronous mirror writes
Date: Mon, 26 Oct 2026 13:39:40 -0300
Message-ID: <20261026163941.495833-2-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026163941.495833-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261026163941.495833-1-matheus.aalmeida@inf.ufrgs.br>
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
 fs/fat/fatent.c | 80 +++++++++++++++++++++++++++++++++++--------------
 fs/fat/misc.c   |  6 ++++
 3 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 1d051d0628b6..204c7b87108f 100644
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
index 8897a5dd522d..d42b5324531a 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -376,42 +376,76 @@ int fat_ent_read(struct inode *inode, struct fat_entry *fatent, int entry)
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
+	int err, n, nr_dirty;
 
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
+		int err2 = fat_sync_bhs(dirty, nr_dirty);
+		if (!err)
+			err = err2;
+		fat_brelse_array(dirty, nr_dirty);
+	}
+
 	return err;
 }
 
+static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
+			  int nr_bhs)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	int copy;
+
+	for (copy = 1; copy < sbi->fats; copy++) {
+		int err = fat_mirror_one(sb, bhs, nr_bhs, copy);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
 		  int new, int wait)
 {
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 0d04228f916e..b6a9e2e122cd 100644
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

