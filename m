Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390992C21FD;
	Wed, 13 May 2026 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671348; cv=none; b=mpvwrerdezBhSyLy08qlZLvay77QsVRj7p3Idf6Bc7N5u7So59Qbhk9pRv2+nFVxuR9VXFfcWf69nhG+B6pI5FvXJRs464tjDXNojCWlgckyonhvUDZcE762Wb2d5zBhasCflzmqPYgNeiKtAEOCho9wH13DgyrSgpM6jCZj670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671348; c=relaxed/simple;
	bh=57ehCUb8ln12GUYleL0SvSEDRAcrNUcK94TBctYsESs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ej8eyNwKNHMCyMpd9MlshX0rLLt/q56KhoWckUCv6TasIjL9QSUt14SvsCOyZZ+R17HBv96FUmCdnwhf50xfZceKI85eivYguxCuewt2+Jlx+gnnn0Hk/rteUvWEFnM+KuYNZ337lEsUivW7+ggZOKXFtLiS9hAjIvPoUk9MriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm8X53Wf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm8X53Wf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D650C2BCB7;
	Wed, 13 May 2026 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778671345;
	bh=57ehCUb8ln12GUYleL0SvSEDRAcrNUcK94TBctYsESs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gm8X53Wf36vOYsBC+l31Qh15FVkQJKYRrzjLcMxw4k3EHvLYA3bCA08QKhe6G8mxv
	 j/Fko8529+mtezaGInUrD+3yuesncJf9Gbp71d+o1+m6qJi22qpXL8AoFKoiZODOSl
	 yW3Wc99jLS8x9adyNV1Gs1SBdRfwG1kmnHBUJR84bNbvcvouYY6O72A9RzcAZRH45P
	 qTUMtNt5GjiW2WeeC9SejwGEFInfaYdd5RJAXJBpFea33xDnD0JcvDcrjS+M8/okdL
	 h/75OYbFyc/cNZIENiitiTeuKiu6QckcbSPaWD8X1Krk+k97YsSP2ybOFXw1NVtcsJ
	 tyOCUFOyCJrGQ==
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
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 06/11] exfat: add data_start_bytes and exfat_cluster_to_phys() helper
Date: Wed, 13 May 2026 20:21:51 +0900
Message-Id: <20260513112156.9122-7-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260513112156.9122-1-linkinjeon@kernel.org>
References: <20260513112156.9122-1-linkinjeon@kernel.org>
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

