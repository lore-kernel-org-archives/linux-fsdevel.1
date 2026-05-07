Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE923BED23;
	Thu,  7 May 2026 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157901; cv=none; b=T5pa+U4x72KTEKRYHZkHDgDZoCj2SaZ8j4VxqbDxpvoh9qPExdrFH/DxgcwMHqEDhYfIldMY46ZP4n7E3ydJrQ2mAS/ot//vnUAM8C/UbLcLYv0xwYX4UySXCInzJBLlM2Yps0K3gtrQBEicGjwdiJBR07uVuz3O3qOqEm3LYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157901; c=relaxed/simple;
	bh=57ehCUb8ln12GUYleL0SvSEDRAcrNUcK94TBctYsESs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYuD/pDu/xYmFBN8MpOOy+Ai9DjxvQV7x/IHzmO6SSMjJuyOPY8k03I+ib19VXq5YdMLZdMRwX6gubPLGD8H2wdueN4tHzs0Ncc0QBRHFkA8++pfD3oOpbEaXAyv+kXpkCGYNKR8XoJDjR2QrL0topFj4KmgWe1Ns39s9uzCuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViP6UUUG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViP6UUUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804A5C2BCB2;
	Thu,  7 May 2026 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778157901;
	bh=57ehCUb8ln12GUYleL0SvSEDRAcrNUcK94TBctYsESs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ViP6UUUG4sP46/QVb3dSqK/snAMd51xAfe3tl3oyELPfM7IhymmgNoI89Yl+WNrr7
	 YZzKYCKWpBC7j+9d88SXh41/0Uc1jwi4arqIxcbKFmOpSi6Xa2RW50znJmfGz+lxE8
	 CuDyFlbKrP1Oh05pFJHeFqG+2uD9q1A+YX+jNFhM4NnuKoVIX6Vw54yO45Q2nJU3LO
	 JPhBBAjaQVHd6Ot/gmj1ae7NAdVPc8wOp2wP88nXIxg4PLCtXT9YJUNAimcpu0MUTh
	 rWYwDtAgOGk7rzeu4Mp60tUX+6mZo6HSNvKoYnFXayDsVP6HfMpqiVUwZ8pJUA9Ryy
	 Im+an/m9Ydo7Q==
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
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 6/9] exfat: add data_start_bytes and exfat_cluster_to_phys() helper
Date: Thu,  7 May 2026 21:42:35 +0900
Message-Id: <20260507124238.7313-7-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260507124238.7313-1-linkinjeon@kernel.org>
References: <20260507124238.7313-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This caches the data area start offset in bytes (data_start_bytes)
and introduces a helper function exfat_cluster_to_phys() to compute
the physical byte position of a given cluster.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/exfat_fs.h | 8 ++++++++
 fs/exfat/super.c    | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 6e7fd6822b01..415f987afa9a 100644
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
 
+static inline loff_t exfat_cluster_to_phys(struct exfat_sb_info *sbi,
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

