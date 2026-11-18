Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967357;
	b=BHFZtQdyqVszF+iiJm+DkHtmFk/9i7orJOOqucBfuSQY56yJ4fcPK79hXZp95Rbf3XCK
	 OoWlBvmotI6qeaCxt0DyVahzWGGtSUHaoJtCok94T5cXP6QwDZg1MO6jOouOtQSfVKTjn
	 Gnp4eQRs42W8YgUQExldXODfABrT+g9Uw+U/joVqLH8+3kgiKWlKna3E+LRA+aVp1+mz9
	 RH6eahPvNAlaWRnQeB3HyR0FXZ3QW2ZWBnsYxlvkezeMqSJzfVJT1ZtVg8oFgnjumytpV
	 Ixqz7N+AhQUNZTj0Ee61aRW/DWIvL+e9HpFbwuVWffjPhSC4tm1I1VqxalOCRkYZi0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967357;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nLnRn+Vk/UF9pbDsCHPBkd1vk2+4lKNBtdhts2OCNhU=;
	b=TJmUCS+wzgUOagv8gcl2DlbwmIJm9b/kD9kQ6S8s/NTIEzCKiWVV0/jtOX4LWkz3iXET
	 6+2c/kmaYbCGV7Mz+yGbUJAksxwy4Kj0lWdA5NTMz9jgEh0vqO7sKRppOZ2QyHgKOW2aJ
	 RwKqQR4vqMxmN1/deQeUObDynJMzW1HjT3rV5/NX577vlXkZuPh88ZQb4sRjvMnTzYQ9m
	 vC/LOIvB/3XukhZNZ5aN3Umg+VlAlCR1GfliC1pGL6QsZac5Hj9nUZKp2gJ164N3bajgo
	 gp3Fpp4/OzjEiHGvEfQbqQqoeLuWZYGypHSoDUIeLGvdRh8Bc1A3IqVJ4gfv+bt2y3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=GF2VSvoW;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E83D606A32A;
	Wed, 18 Nov 2026 02:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E83D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=GF2VSvoW
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 47D991210EB;
	Tue, 17 Nov 2026 23:02:06 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794967326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLnRn+Vk/UF9pbDsCHPBkd1vk2+4lKNBtdhts2OCNhU=;
	b=GF2VSvoWipoA7/2thvs/MrQtQyuKtv67ybpa4Il5fDd8cEBJfuLvdTbSG1acE5MDPbZELG
	u5+EOTGPDJwDWd3l44OGg8RRtLh3iAMeQdHFl/D9CtSuVZGFJ1FqYEGJu56wgj4xaTT/1F
	LdQpxRArm7vKbfX1X5NAz/wNEC3oETU0AP5qqxBMBUaaTWJ83aukixWvAltFvZ5dH6zmSL
	KeT0ENy5RJ8SjtdpInn2nFX1LL3ALiGBH2Aa0o9rgBQN3vCLSWg+h8CzCVuUklVgHd3ST+
	fywMPJUl+Wb0Ln68OuS+HDmF8+M77nnxpP8mttWSVvKJgDATCSD+m1kazKulxw==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/8] fat: clean stale bdev buffers of newly allocated clusters
Date: Tue, 17 Nov 2026 23:01:44 -0300
Message-ID: <20261118020150.1023865-5-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
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

Directory I/O uses buffer_heads on the block device, which may leave
stale buffers behind when clusters are freed and reused. The buffer_head
I/O paths currently call clean_bdev_aliases() for newly allocated blocks,
preventing stale buffers from overwriting new data.

Buffered iomap I/O does not provide this protection. In preparation for
the buffered iomap conversion, clean bdev aliases on newly allocated
clusters, like exfat patch "exfat: clean stale bdev buffers of newly
allocated clusters".

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/fatent.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index e342b32ed..cdbc15465 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -537,6 +537,21 @@ static int fat_flush_bhs(struct super_block *sb, struct buffer_head **bhs,
 	return 0;
 }
 
+/*
+ * Newly allocated clusters may still have dirty buffer_heads in the block
+ * device mapping, e.g. the dentries of a directory that was just removed.
+ * File data does not go through those buffers, so drop them; otherwise a
+ * later flush of the block device writes them over the new data.
+ */
+static void fat_clean_bdev_aliases(struct super_block *sb,
+				   unsigned int clu, unsigned int count)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	clean_bdev_aliases(sb->s_bdev, fat_clus_to_blknr(sbi, clu),
+			   (sector_t)count * sbi->sec_per_clus);
+}
+
 static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster,
 				bool return_all)
 {
@@ -545,7 +560,7 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 	const struct fatent_operations *ops = sbi->fatent_ops;
 	struct fat_entry fatent, prev_ent;
 	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
-	int i, count, err, nr_bhs, idx_clus;
+	int i, count, err, nr_bhs, idx_clus, cont_start, cont_len;
 
 	lock_fat(sbi);
 	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
@@ -554,14 +569,20 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 		return -ENOSPC;
 	}
 
+	cont_len = 0;
 	err = nr_bhs = idx_clus = 0;
 	count = FAT_START_ENT;
 	fatent_init(&prev_ent);
 	fatent_init(&fatent);
 	fatent_set_entry(&fatent, sbi->prev_free + 1);
 	while (count < sbi->max_cluster) {
-		if (fatent.entry >= sbi->max_cluster)
+		if (fatent.entry >= sbi->max_cluster) {
+			if (cont_len) {
+				fat_clean_bdev_aliases(sb, cont_start, cont_len);
+				cont_len = 0;
+			}
 			fatent.entry = FAT_START_ENT;
+		}
 		fatent_set_entry(&fatent, fatent.entry);
 		err = fat_ent_read_block(sb, &fatent);
 		if (err)
@@ -587,6 +608,10 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 					*cluster = entry;
 				idx_clus++;
 
+				if (cont_len == 0)
+					cont_start = entry;
+				cont_len++;
+
 				if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
 					err = fat_flush_bhs(sb, bhs, &nr_bhs,
 							    inode_needs_sync(inode));
@@ -603,6 +628,9 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 				 * so we can still use the prev_ent.
 				 */
 				prev_ent = fatent;
+			} else if (cont_len) {
+				fat_clean_bdev_aliases(sb, cont_start, cont_len);
+				cont_len = 0;
 			}
 			count++;
 			if (count == sbi->max_cluster)
@@ -617,6 +645,8 @@ static int __fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluste
 
 out:
 	unlock_fat(sbi);
+	if (cont_len)
+		fat_clean_bdev_aliases(sb, cont_start, cont_len);
 	mark_fsinfo_dirty(sb);
 	fatent_brelse(&fatent);
 	if (!err) {
-- 
2.43.0

