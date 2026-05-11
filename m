Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B2372B57;
	Mon, 11 May 2026 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483858; cv=none; b=i0Y4AqjjqAOTx7VSfESqTl5e0t574Xe1+5gES3Q5TP/vub3pNwprVmp0bJrG+8Y/qTiQpMt46WL3ynfyD5EdZTjpYZTrcmucb1Iqp49tivK3WTBYnRJkZ8UdnKpLNIvgRdDuHp7dFeif7Bs4xPHjWZGDGUJEgX0NhMsKk7aMB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483858; c=relaxed/simple;
	bh=Rf/2q7mv82K8XqA71vff0x1G3Y1iXFclTaLvg9Hfy7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jjq4FFKwiu8VIPUjHkgdVYZXLgY3af1j82F9p6j6Apeh8+ImsfYrY37yrJjecIVXkkbWUgcavZ2eBFoDANTssunnPwSAZkm4NTVD37OoujXBccfJNCFmy74IGmbpqe00W4xTNQgAJYP2AmpbmhEYfybgLksmRN9YlO2GHD75eno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2cBMre5h; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2cBMre5h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Qg7de/xNHLpd8gW9gCg6sg81LGLZ1f+tpDaVTtHNriw=; b=2cBMre5h7CV966RfinSK6UrYdj
	EopFf1Mm644j73+NXZYyiYIpABhCJzF6+xvlp3eTA0D+AE9PBzrv4fyxvrrsw7Xm496TW3NhC8gpU
	4xnxogHzFSQDrjxU18cjmoY2etMGXEG4YNEWh7zG3gjZUQUDG0kPr47+p9FENI3k3qCn0zK5IkzJt
	rtdtpe+0rrpVp9+HzR3lmLlgtU0ES3SRJ1aW8SZFi6NaPx9Y0/4m3mOr6ngZz/miSTi8WPKPiapIN
	/FKg5kXmCjPs0yrH1xSAKqwkgI9uBfnmXiJA/crI3wUbMpBvGCA7qvnl7CzdIhZJ/oeJKe3IG0FyE
	NQMvl4Xg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKtR-0000000CZxe-4Ajz;
	Mon, 11 May 2026 07:17:34 +0000
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
Subject: [PATCH 05/10] befs: handle set_blocksize failures
Date: Mon, 11 May 2026 09:16:50 +0200
Message-ID: <20260511071701.2456211-6-hch@lst.de>
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

befs uses buffer_heads, which don't handle block size > PAGE_SIZE well.
Without this, mounting we will hit the

        BUG_ON(offset >= folio_size(folio));

in folio_set_bh on the first __bread_gfp call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/befs/linuxvfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index c12caae9a967..ee0cbae521b9 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -860,7 +860,8 @@ befs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 */
 	sb->s_magic = BEFS_SUPER_MAGIC;
 	/* Set real blocksize of fs */
-	sb_set_blocksize(sb, (ulong) befs_sb->block_size);
+	if (!sb_set_blocksize(sb, (ulong) befs_sb->block_size))
+		goto unacquire_priv_sbp;
 	sb->s_op = &befs_sops;
 	sb->s_export_op = &befs_export_operations;
 	sb->s_time_min = 0;
-- 
2.53.0

