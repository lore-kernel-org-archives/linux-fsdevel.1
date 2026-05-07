Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F533E345;
	Thu,  7 May 2026 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157883; cv=none; b=jNj4a1Q/KLaUGsV0ADi4+QtFK+PHgkyuwhFz1MmJ6XneJv6lUB9Mox5lga3Mc/jueK3nfVVi34Q4oKMHWIX6KUI+9qApUq455WxoJP6UQCp5AnV48YVHOQXXjoBBuF6CTbs8o0vtluwi4ibY6RihLS7E+2UqEYYmok03metkFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157883; c=relaxed/simple;
	bh=q7iu0mK6wq0YpbKSRRtPEDTqgZmAcPHb4MPNaT5DtPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HBsHUrL7hBFJ9eszx5b/Y+eBGB0tkVYjSLexNooS771SqDTdvhSya6tmf88GNLdzNff4pvPtzTARnMXJ82rM4nfgRaN9FCasBa/Nsg6Gq3ypKIqzWFHFkS5uan5CdmQvCv40yqN34F9/yuOlagvfhRkUpsMnY6qLBovu+4mAyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FX/RQVk1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FX/RQVk1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0722C2BCB8;
	Thu,  7 May 2026 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778157881;
	bh=q7iu0mK6wq0YpbKSRRtPEDTqgZmAcPHb4MPNaT5DtPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FX/RQVk1xHQhetl4dL6RcESpJqC9i868f0B4Vxzs2Y3nAXJh157DWRt5JKEPqthBG
	 FGpfy/uHK5ck+/by9ZoV0xU3Uj0hmDkmtRhC2iAtzcAyU7QRvJMzKg0pzNW1c3OpGC
	 obVF7PRAsqAce898j8FQr5v7eQqA6fpnZeo94J1/2tlG8PE2YSah2k7vbuzGLlUU7D
	 lpLesmb1bfhg10Q67Ttb6sIeTN88EaYgIMdlN0h8sh2TdoHy5NhxyUt1gi7YrxQKIs
	 MEAEv3xkaqSbDjhDn2babuR7roLBubDSeQGlAmBSXiEa9ORUaiwvuG3QGiWKtJYYDQ
	 mr1vES0Dl3Wkg==
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
Subject: [PATCH v2 2/9] exfat: add balloc parameter to exfat_map_cluster() for iomap support
Date: Thu,  7 May 2026 21:42:31 +0900
Message-Id: <20260507124238.7313-3-linkinjeon@kernel.org>
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

In preparation for supporting the iomap infrastructure, we need to know
whether a new cluster was allocated or not in exfat_map_cluster().

Add an optional 'bool *balloc' output parameter. When a new cluster is
allocated, *balloc is set to true. Pass NULL from exfat_get_block() to
preserve the existing behavior.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index d25e0a69865b..1246713567a5 100644
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

