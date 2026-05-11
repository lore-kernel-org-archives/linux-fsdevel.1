Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB803101B2;
	Mon, 11 May 2026 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483879; cv=none; b=PQLhxuTkWR1pwaOnjJ0J1qlN6R5iOG+r2GnkVUyLaRBPqGqfrMPtP3Fk/14eXYe7c9gyUbxYbCih0BE59ZLh9Wcw/95IEZS4j3t1EIbmzx6IKUjFIuS2GdbNpO2yQRQ87W2LV2mRquXY6aGFnnLLct8rYvE6/Wt7EbEEo7lnCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483879; c=relaxed/simple;
	bh=5s/I/VAas71UKCP2N8JjbdyUvmb7fNMNiDWM3x+qASM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bX6Gi0D2aQc8ZNyXzZ9ClAnzweY2CkjqDLuOoMRn6+lXVOQ/q2nkLtH2bIbtWukV7NUKXCAJnG683xx5Gq5Ygw+fsi7KY1RSGCXvxC8T111gyJkIthM74wxySdpBWynvGOPFMpQjXcN7zSr/1zn6/0lvH3HDFbGYFez2WRgD178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c775Qoy5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c775Qoy5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gy0ISygSO1i5I4zKXO2a4cG9sgvq69E0+YNiM5bffwQ=; b=c775Qoy5XIzKXhIA3JCHOqefJc
	zCAgCQTgxCQGidoY0by17WN1bnrFzaipSrqz3LuLitB53ZG7Bd1X9GryLU6Eq8PNPy1Kxx878cj9L
	dS3jgDvoSJtniXNPpQNCcZmgYCXjMQnNBkEk5iOJjnKRaSjO9BXXF3g9RhSUxPl2kGkSorocEhO5v
	iv/mj3wFcA3Yt/rBsDrD+XumjPKFMJ9A5yBQsuoH5Y6SJoKA26Ifw1EI4aRcZJVODWggIxl5NHOT3
	N1qYVdVhKqTUnBBQyDCholRWrJXd5vv7oHb9WHwQ5OdlEAKFl6M6NQahXmqaEUCZh7nv+NrVUtqmr
	BglEMgEw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKtm-0000000Ca1k-3S8j;
	Mon, 11 May 2026 07:17:55 +0000
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
Subject: [PATCH 09/10] ntfs3: handle set_blocksize failures
Date: Mon, 11 May 2026 09:16:54 +0200
Message-ID: <20260511071701.2456211-10-hch@lst.de>
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

ntfs3 uses buffer_heads, which don't handle block size > PAGE_SIZE well.
Without this, mounting we will hit the

        BUG_ON(offset >= folio_size(folio));

in folio_set_bh on the first __bread_gfp call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ntfs3/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 004f59937559..3305fe406cb2 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1174,7 +1174,10 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	rec->total = cpu_to_le32(sbi->record_size);
 	((struct ATTRIB *)Add2Ptr(rec, ao))->type = ATTR_END;
 
-	sb_set_blocksize(sb, min_t(u32, sbi->cluster_size, PAGE_SIZE));
+	if (!sb_set_blocksize(sb, min_t(u32, sbi->cluster_size, PAGE_SIZE))) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	sbi->block_mask = sb->s_blocksize - 1;
 	sbi->blocks_per_cluster = sbi->cluster_size >> sb->s_blocksize_bits;
@@ -1225,7 +1228,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 			/*
 			 * Try alternative boot (last sector)
 			 */
-			sb_set_blocksize(sb, block_size);
+			if (!sb_set_blocksize(sb, block_size))
+				return -EINVAL;
 			hint = "Alternative boot";
 			dev_size = dev_size0; /* restore original size. */
 			goto read_boot;
-- 
2.53.0

