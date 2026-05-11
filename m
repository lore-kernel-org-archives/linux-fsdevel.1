Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7033101B2;
	Mon, 11 May 2026 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483863; cv=none; b=WK83N8kdOtHuNd9VU5ednm+7LppaJM8xrAzRshPatIT6bpeaaammk9qQiX3Rpmwqfit6625wbrj+GIsCaldrIxplAh3ciaz8QBo5c3OjEYg3xbfzm7rVz6KokM1JI3iaAmpPdPF6DZasRYrBx3w090552eZOfihca3FSI+wkIvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483863; c=relaxed/simple;
	bh=sdC2hMBu7hjuDMFlFIXDtm1e3n6TT+9hcPgKwweisy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FagvZ2YygwU/0NS3WzgPc68ValeMqJe6nM8ck9DCLFQfDEcHnJTfltSxGXhuYwaBYyR47onr6VRGWqPDZ0RLZqjLGtA216VuNNxB7PTUuh94iNcaGUd8IMeqHqbn3wuiFjIQhmX1aJw+SbLj7KMCwpipgcnOR4pCQQVLn3SasWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vWFJbBxV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vWFJbBxV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VMIOAndFF0mq3mFyT4y9iiTxG7ePizT64fepCcnz0wo=; b=vWFJbBxVJXfBNzdUZY/2aSN/T+
	2FQBE9a8OAlujX7fwtsoeH2YR9h88IVUE2SpGXwDiuurU3xHOLNZ2Qoh8W6ioFGj++vjzkxdCabFb
	9FUoZe6DJcMGtbK8FAVi43nx71QAO8QEqIfj0CBBCEaNq6UEJaupIg3abWkVrRbowKTWeTjVh7ncL
	qiLYqD3JfhjeYGpRI1bO05l2aYGBVOT8f593ydItMD4DFq8Ip94YNq3Dx4dXnSdDLCzFbZESJOGjM
	cWfquz7vyvV2fziMz91QvribcllWtT86mv40yP/gHYqjkUYjeZCOhhmEyaiLm5tgT012EkczqpkXB
	8bwacmig==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKtX-0000000CZyl-0nWa;
	Mon, 11 May 2026 07:17:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Bob Copeland <me@bobcopeland.com>,
	Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net
Subject: [PATCH 06/10] affs: handle set_blocksize failures
Date: Mon, 11 May 2026 09:16:51 +0200
Message-ID: <20260511071701.2456211-7-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511071701.2456211-1-hch@lst.de>
References: <20260511071701.2456211-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

affs uses buffer_heads, which don't handle block size > PAGE_SIZE well.
Without this, mounting we will hit the

        BUG_ON(offset >= folio_size(folio));

in folio_set_bh on the first __bread_gfp call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/affs/affs.h  | 5 -----
 fs/affs/super.c | 6 ++++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index a0caf6ace860..44a3f69d275f 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -227,11 +227,6 @@ static inline bool affs_validblock(struct super_block *sb, int block)
 	       block < AFFS_SB(sb)->s_partition_size);
 }
 
-static inline void
-affs_set_blocksize(struct super_block *sb, int size)
-{
-	sb_set_blocksize(sb, size);
-}
 static inline struct buffer_head *
 affs_bread(struct super_block *sb, int block)
 {
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 079f36e1ddec..b232251aa7bb 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -358,7 +358,8 @@ static int affs_fill_super(struct super_block *sb, struct fs_context *fc)
 	size = bdev_nr_sectors(sb->s_bdev);
 	pr_debug("initial blocksize=%d, #blocks=%d\n", 512, size);
 
-	affs_set_blocksize(sb, PAGE_SIZE);
+	if (!sb_set_blocksize(sb, PAGE_SIZE))
+		return -EINVAL;
 	/* Try to find root block. Its location depends on the block size. */
 
 	i = bdev_logical_block_size(sb->s_bdev);
@@ -374,7 +375,8 @@ static int affs_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (ctx->root_block < 0)
 			sbi->s_root_block = (ctx->reserved + size - 1) / 2;
 		pr_debug("setting blocksize to %d\n", blocksize);
-		affs_set_blocksize(sb, blocksize);
+		if (!sb_set_blocksize(sb, blocksize))
+			return -EINVAL;
 		sbi->s_partition_size = size;
 
 		/* The root block location that was calculated above is not
-- 
2.53.0

