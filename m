Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527494;
	b=IthLkgn1TwR8zQlNLInFqE8a3buLdeC7b1iox75ka350Zb0S+C91d0xEx+iCaQw8GyLB
	 hOj+sEmN6Llg5BisniQPcmwJfUjNNke0X5omj3CpopS86YGdHUrc+MzLb+thy9wEM71Km
	 ntQrLeDfHTtorlYxEMPw+wjlulccP14WgFxiomh9PVdwOjlz8+atr6u5AM9OeLuWzn3NW
	 4KYHf/UXEXJIf/S5TZwTeXuqckHOEvJ+OJ05jBgovinby/Mmz770qvSNr7aAzWaUOIuG3
	 tnPKDKPmjsBDoWT54c0/4JJCc9KEaqqHkaV9//kvFnP9YOv74rmq/+UGaj0Kbl7oHDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527494;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=yBtnh/PrTD0vWkLbv0v8FR9NeX0uK3j7OGuMrAdvBkg=;
	b=AmCvJqDjA8Wd+xbm53JCsWIhOkT4/b5PcPE3WigFSKWPJrHl1AareAWDG+imotoYHEOF
	 YbC4YNhn0u395mzEiARU2LJP7ZS1zMgNB/vHV3hA95z6aivG365PuvjyPlBW224iiFbYM
	 mDQE6W+kTc+tUwoxhSueEVWrO2dYWEGCWDJSNoUYo3+aQX8pw/TO0y63EiZv4pA8YgZ8k
	 s0SHt2UBHfUq444necnEUEuomhxTuuhT99vYoS7/o1yE3xYumTTG2bLjC7Tqnw8LXFyL2
	 GaqTj+gAgF/iRm0bwNP22V3V1/cmYK0PsaTkgi4rwdqjVTF51kGWicHP91HGRw1wbTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=ten7e389;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0619606A31A;
	Tue, 20 Oct 2026 20:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0619606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=ten7e389
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id EEEBA1202B5;
	Tue, 20 Oct 2026 17:18:00 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1792527482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yBtnh/PrTD0vWkLbv0v8FR9NeX0uK3j7OGuMrAdvBkg=;
	b=ten7e389JINRmDfXOaJSFXJxOdY/WFQwOVaj8EIVtWAu7Jcs10Fc5RNFNjyPIl8HZ/P/1X
	66J6zAOj3ftopBuyxGW6PedZTNyq+Yqq8cAiSqEVXXUjGKjP7/EWvI5NIHtsFovR50ivqZ
	ckYn7alcTtQd1X094Y+8M+qBJJw9wEYg5940eFuy3vwGa+WQslsRF/8IHQH9ORLt0iKQ1a
	D1HwK//wVo/RZGhtLxDcGROMX3INC/K2+Ju3yHkOAecTQ1xG0k8n29eyeoxh+mMnjLYEgS
	qrWw6/DjyQUA4yQQ5U+XkmtZItW1pAbAaSWaW/6jMSx63vOq17kONUfCE6bqWQ==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH] fat: preallocate space before expanding in fat_cont_expand()
Date: Tue, 20 Oct 2026 17:17:52 -0300
Message-ID: <20261020201752.52557-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
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

The fat_cont_expand() implementation leaves allocation of new clusters
to generic_cont_expand_simple(). This path does many small cluster
allocations, harming performance.

Preallocate cluster space in fat_cont_expand(). Move preallocation to
a new fat_preallocate() helper used by both fat_cont_expand() and
fat_fallocate(FALLOC_FL_KEEP_SIZE).

Benchmarking was done under QEMU/KVM with a virtio-blk device using
cache=none. Each result is the arithmetic mean of the listed samples.

start = now_ns();
for (unsigned i = 0; i < count; i++) {
    if (truncate_mode)
        ftruncate(fds[i], bytes);
    else
        fallocate(fds[i], 0, 0, bytes);
}
elapsed = now_ns() - start;

16 files, 512-byte clusters:
length    mode      sync?    before    after    improvement    samples
256MiB    ftruncate no       9.576s    5.345s   1.79x          10
256MiB    fallocate no       9.634s    5.640s   1.71x          10
1MiB      ftruncate yes      58.66s    0.362s   162.15x        5
1MiB      fallocate yes      61.36s    0.390s   157.15x        5

128 files, 512-byte clusters:
length    mode      sync?    before    after    improvement    samples
512KiB    ftruncate no       0.433s    0.352s   1.23x          10
512KiB    fallocate no       0.446s    0.393s   1.13x          10
64KiB     ftruncate yes      31.32s    0.429s   73.00x         10
64KiB     fallocate yes      29.59s    0.410s   72.42x         10

16 files, 4096-byte clusters:
length    mode      sync?    before    after    improvement    samples
256MiB    ftruncate no       5.181s    4.417s   1.17x          10
256MiB    fallocate no       5.166s    4.442s   1.16x          10
1MiB      ftruncate yes      9.294s    0.111s   84.06x         10
1MiB      fallocate yes      8.710s    0.110s   79.36x         10

The biggest improvement is on filesystems with a small cluster size and
on synchronous mounts.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---

This patch depends on:
https://lore.kernel.org/linux-fsdevel/20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br/T/#t

 fs/fat/file.c | 54 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 3aa541c6b127..33cef46ce1a0 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -217,15 +217,48 @@ const struct file_operations fat_file_operations = {
 	.setlease	= generic_setlease,
 };
 
+static int fat_preallocate(struct inode *inode, loff_t new_size)
+{
+	int nr_cluster; /* Number of clusters to be allocated */
+	loff_t mm_bytes; /* Number of bytes to be allocated for file */
+	loff_t ondisksize; /* block aligned on-disk size in bytes*/
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	ondisksize = inode->i_blocks << 9;
+	if (new_size <= ondisksize)
+		return 0;
+
+	/* First compute the number of clusters to be allocated */
+	mm_bytes = new_size - ondisksize;
+	nr_cluster = (mm_bytes + (sbi->cluster_size - 1)) >>
+		     sbi->cluster_bits;
+
+	/* Allocate the clusters. We are not zeroing them out */
+	return fat_add_clusters(inode, nr_cluster);
+}
+
 static int fat_cont_expand(struct inode *inode, loff_t size)
 {
 	struct address_space *mapping = inode->i_mapping;
 	loff_t start = inode->i_size, count = size - inode->i_size;
 	int err;
 
-	err = generic_cont_expand_simple(inode, size);
+	/*
+	 * Preallocating space here is more efficient than during
+	 * generic_cont_expand_simple() because of batching.
+	 */
+	err = inode_newsize_ok(inode, size);
 	if (err)
 		goto out;
+	err = fat_preallocate(inode, size);
+	if (err)
+		goto out;
+	err = generic_cont_expand_simple(inode, size);
+	if (err) {
+		fat_truncate_blocks(inode, inode->i_size);
+		goto out;
+	}
 
 	fat_truncate_time(inode, NULL, FAT_UPDATE_CMTIME);
 	mark_inode_dirty(inode);
@@ -263,12 +296,7 @@ static int fat_cont_expand(struct inode *inode, loff_t size)
 static long fat_fallocate(struct file *file, int mode,
 			  loff_t offset, loff_t len)
 {
-	int nr_cluster; /* Number of clusters to be allocated */
-	loff_t mm_bytes; /* Number of bytes to be allocated for file */
-	loff_t ondisksize; /* block aligned on-disk size in bytes*/
 	struct inode *inode = file->f_mapping->host;
-	struct super_block *sb = inode->i_sb;
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int err = 0;
 
 	/* No support for hole punch or other fallocate flags. */
@@ -281,19 +309,7 @@ static long fat_fallocate(struct file *file, int mode,
 
 	inode_lock(inode);
 	if (mode & FALLOC_FL_KEEP_SIZE) {
-		ondisksize = inode->i_blocks << 9;
-		if ((offset + len) <= ondisksize)
-			goto error;
-
-		/* First compute the number of clusters to be allocated */
-		mm_bytes = offset + len - ondisksize;
-		nr_cluster = (mm_bytes + (sbi->cluster_size - 1)) >>
-			sbi->cluster_bits;
-
-		/* Allocate the clusters. We are not zeroing them out */
-		err = fat_add_clusters(inode, nr_cluster);
-		if (err)
-			goto error;
+		err = fat_preallocate(inode, offset + len);
 	} else {
 		if ((offset + len) <= i_size_read(inode))
 			goto error;
-- 
2.43.0

