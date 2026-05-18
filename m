Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9163F39C7;
	Mon, 18 May 2026 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104925; cv=none; b=iID4rRa4qLAOu/jniRkktunsd/vZ7EVStSrlsL11OXdMPBY0eCs2AHDtRQu7blngZvPu1NNwWmWSLNJ6UZY6+psWy0QnLJhu9pFp8t5JSagz3BhXbOFLIhl6iAyvFaEdfQ6YpGSwmInEguOhuELLiqDSb0S8yGQYSLZY1/2Dbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104925; c=relaxed/simple;
	bh=cd+4hZhTTrTQU+72c3MpfuD0R2Y61+Br4OnP+AIFKkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AajJbGYlTs6KbN+Susq0CMKQEFVbwrLoai3D46u8B4MbSc72le3MajJwtecOInuYX1l/mC2yuG2m8lATNP9DBPU6fEqbDCdTTkFs/QA+muHXg7UHbfAZXld4Adi3g6O/6t0+SjhoFzJEjmRmvT2kLeRYhRIEYi2byDa1p4V9zEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFFFOFWf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFFFOFWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3E9C2BCC7;
	Mon, 18 May 2026 11:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104925;
	bh=cd+4hZhTTrTQU+72c3MpfuD0R2Y61+Br4OnP+AIFKkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFFFOFWfUtlPvZQLKdEpDs/qBw1ww3Wt6ASnNbK8BBgwAU848kwbMq3WFc03tzKGi
	 dc2//NeY1fkzr4IH/CEy7oLHkLMFv76Ngz/qj9fejA3iakT58OTJ/aMXikyL/s+TQB
	 Satxb0AEHgbZKj9/znvAPNo6vjSyRL5vBmvObmfE25eoVdv6JZ6vZeQoDFyNOOBKNV
	 pvoh/tYQqgexkJXHQHhANZq7qWWnlJ1VNjtcc+YEYbaOCB9S9rsYIzi99O7DRBlOWG
	 nbEOS5A1N7/3/6bja91hGqB2tDJ+liknXP8AiFKSphORsXfZuO3dAPsVHB5EiYD5eK
	 60GqkJW7ZFtqQ==
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
Subject: [PATCH v4 03/11] exfat: add balloc parameter to exfat_map_cluster() for iomap support
Date: Mon, 18 May 2026 20:46:57 +0900
Message-Id: <20260518114705.9601-4-linkinjeon@kernel.org>
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

In preparation for supporting the iomap infrastructure, we need to know
whether a new cluster was allocated or not in exfat_map_cluster().

Add an optional 'bool *balloc' output parameter. When a new cluster is
allocated, *balloc is set to true. Pass NULL from exfat_get_block() to
preserve the existing behavior.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 249a35e2b4b2..a10d4f3c66a1 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -124,7 +124,8 @@ void exfat_sync_inode(struct inode *inode)
  * *clu = (~0), if it's unable to allocate a new cluster
  */
 static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
-		unsigned int *clu, unsigned int *count, int create)
+		unsigned int *clu, unsigned int *count, int create,
+		bool *balloc)
 {
 	int ret;
 	unsigned int last_clu;
@@ -229,6 +230,8 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		if (exfat_cluster_walk(sb, clu, num_to_be_allocated - 1, ei->flags))
 			return -EIO;
 		*count = 1;
+		if (balloc)
+			*balloc = true;
 	}
 
 	/* hint information */
@@ -262,7 +265,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	/* Is this block already allocated? */
 	count = exfat_bytes_to_cluster_round_up(sbi, bh_result->b_size);
 	err = exfat_map_cluster(inode, iblock >> sbi->sect_per_clus_bits,
-			&cluster, &count, create);
+			&cluster, &count, create, NULL);
 	if (err) {
 		if (err != -ENOSPC)
 			exfat_fs_error_ratelimit(sb,
-- 
2.25.1

