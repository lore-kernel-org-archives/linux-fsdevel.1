Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A63F88B6;
	Mon, 18 May 2026 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104936; cv=none; b=t70LKW2vhjqc71r73Kf9FxyHkt5pD14BEI4/7zyHwxowCN69Lb6P9zgXeCTLBb9bCqFgtP1eraIMM0kC86vYFend+Z7RokGZgMBMJx0Us76dPQaXtnsTgKE7oygjMIYRV1mKKSd7ddJjguj4XUIM93XxMLSkxU2itZ1JPgj3g3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104936; c=relaxed/simple;
	bh=HtrVfA5bNSbExzd+ImfH9F8YbOrLboCObnFy+jSpZCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LIYRr4DnVXcUYgZ5OCYbixYcstsXmDqf4eSBJ/JJxzvpH289wTK7vyXFIkvWyodqY2B24aLuuXV5sm/BdUrNSqp8KSIO/H4PvLd2giKod7BWa15ZgZweTbc2q2vyuwSrHN0kT1d29p8wkr7c7gDpmoD1KzWisympl+wDgOSuaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/LbNs4a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/LbNs4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5B8C2BCC6;
	Mon, 18 May 2026 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104936;
	bh=HtrVfA5bNSbExzd+ImfH9F8YbOrLboCObnFy+jSpZCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u/LbNs4aNm8385PzdNZ9veN3jI6uRyetBS0iSvyJC8xHRqB77YTOoHzOr/QnulcfR
	 uWBPf9taWk211G+IZPCBClAqbS1G8ZxnAJKu5VKFvUe9VGhRNfkUUnj0qNSfpVec8z
	 83V7EwipVO0HOGoFWBPaJMCjqcwgIoH5+hCTv73jSx2ePT+Ejr8vq7mkEQeaLqmPB6
	 OHk1fesg7fAM1u5b0uy2bie2ktpiK3dMbL0PUmZl9Yxxs9L6f5TkuOQNvGsc54nxlO
	 PWJL3iGkupTxl0kQd59NxMKa/fSm7KoyUlm3AMe1wXkgfgiat0+Cr0GrePHmItLWH1
	 NpZr5yT7RYrUQ==
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	chizhiling@163.com,
	linux-kernel@vger.kernel.org,
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v4 06/11] exfat: add data_start_bytes and exfat_cluster_to_phys_bytes() helper
Date: Mon, 18 May 2026 20:47:00 +0900
Message-Id: <20260518114705.9601-7-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260518114705.9601-1-linkinjeon@kernel.org>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This caches the data area start offset in bytes (data_start_bytes)
and introduces a helper function exfat_cluster_to_phys_bytes() to compute
the physical byte position of a given cluster.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/exfat_fs.h | 8 ++++++++
 fs/exfat/super.c    | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 6e7fd6822b01..cd38e71d3e8a 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -227,6 +227,7 @@ struct exfat_sb_info {
 	unsigned long long FAT1_start_sector; /* FAT1 start sector */
 	unsigned long long FAT2_start_sector; /* FAT2 start sector */
 	unsigned long long data_start_sector; /* data area start sector */
+	unsigned long long data_start_bytes;
 	unsigned int num_FAT_sectors; /* num of FAT sectors */
 	unsigned int root_dir; /* root dir cluster */
 	unsigned int dentries_per_clu; /* num of dentries per cluster */
@@ -400,6 +401,13 @@ static inline loff_t exfat_ondisk_size(const struct inode *inode)
 	return ((loff_t)inode->i_blocks) << 9;
 }
 
+static inline loff_t exfat_cluster_to_phys_bytes(struct exfat_sb_info *sbi,
+		unsigned int clus)
+{
+	return ((loff_t)(clus - EXFAT_RESERVED_CLUSTERS) << sbi->cluster_size_bits) +
+		sbi->data_start_bytes;
+}
+
 /*
  * helpers for cluster size to byte conversion.
  */
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index cb2f8eefff99..388db271c6bf 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -499,6 +499,7 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	if (p_boot->num_fats == 2)
 		sbi->FAT2_start_sector += sbi->num_FAT_sectors;
 	sbi->data_start_sector = le32_to_cpu(p_boot->clu_offset);
+	sbi->data_start_bytes = sbi->data_start_sector << p_boot->sect_size_bits;
 	sbi->num_sectors = le64_to_cpu(p_boot->vol_length);
 	/* because the cluster index starts with 2 */
 	sbi->num_clusters = le32_to_cpu(p_boot->clu_count) +
-- 
2.25.1

