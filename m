Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601534751B;
	Wed, 13 May 2026 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671337; cv=none; b=s3kc9olP8JrCOKp783/drO/TjkSHUhtr6wu92Y5yi1FQJmGStkm4U+R6hRsfeGjmknfugQLXwmMQwkpL9c0SxezYHepiuEGKMdCJ5VBfWQfu3Jmrot3u+3xTrvPb1Ut2fdkjijJq9eWggfLL2vWq3f1PX3sL2qmJX+I8iRognIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671337; c=relaxed/simple;
	bh=GAmD2Yh1HN4OUfgVgM4w/GzKMor/Yl/+uXcUhBDJYqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUpmAxgftTGUbY0Wr5lnOXLDv6U4ZWy07GCkf8dYXirpgi+6uWNbD9fRzCuYkCqL/wg6mn5tgWgdiW7x7K1iB6kO5bYDNOoZ2cJdn+n5bb9bk0iO3lqLiYhgEwtWuSz0RyvGNwlggzF1mIgIjCQW/mG/dFgUfiuFA9CF6lpNAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM8YUzdN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM8YUzdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3D6C2BCB7;
	Wed, 13 May 2026 11:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778671336;
	bh=GAmD2Yh1HN4OUfgVgM4w/GzKMor/Yl/+uXcUhBDJYqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM8YUzdNqlP7/PLP1h1AwVPCxJb7ZLfoNXb10jpyBbfULQyU5A5Idw5gig5HbM58z
	 SG0W00VRL48iSI5AJDnqUjHmz4z/ZVRc5lqrHsZ8+/NNXvzUNv5J58EJnn1TQ33v3C
	 kglvivWujJektI0DQIscaVKltxoTCxpoN/LGHR9Hg54R9nI0Qh1mlR+yGbFdd5zli+
	 wlr0boHsEKdMzKnqUi9fLIfSZ8GjX0CLLiBRTxgzdKGw8Nkn51Ndgqj/9o0SKPBMvX
	 NfKejBDFT8CpZLsnrAJoyCOp9hn0Z+4LPpCbrQYVrNGIK8opVozw8QvGY/H83sFp9F
	 VCSEV02aICR3A==
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
Subject: [PATCH v3 03/11] exfat: add balloc parameter to exfat_map_cluster() for iomap support
Date: Wed, 13 May 2026 20:21:48 +0900
Message-Id: <20260513112156.9122-4-linkinjeon@kernel.org>
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

