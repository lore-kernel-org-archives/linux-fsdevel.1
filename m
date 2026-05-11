Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45F363C57;
	Mon, 11 May 2026 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483838; cv=none; b=eQFo1JAxyaJID/ju9EMbxUvzPFaMW80SO69XvEeXrsEk9QS95pFwLWEmGkcq/V0PElR0HK0hoZbO2uTfWr3M6yjdhLaXfOa4GhUQwJ3Yw0n0Orwi1S1Zt41yKqZzruVdJxRcW+2tYzWIGH+SWW74kDhxGVucgJ4rH/be64wg7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483838; c=relaxed/simple;
	bh=tT/6m7pjaxHwgaiYcljZonG8+TMUdPOKIfItpTfU16k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFTnwlIrpU16e6JlTWgAthyb3s2JsFOwgq7j9uH4QMy5uu/hSicO0W/biX1cOcOlqCWnuX6h1KeQjiG+zG1mGGWw/Fhz6TxV6DzfZVbhAJd5GBOUQJc9YFMTGQdAP9TbsrBmxe43cIBPkwZypkB+wqPZa0OGKc0YBf1zPTKQtks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1F/Ov/L/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1F/Ov/L/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=f5qEvcBoqMFJDt0NatUzvNykBD4KYdbabCAL3DaZ1Bs=; b=1F/Ov/L/Pd0JWoau27a5gZmF+c
	T1IjA5IImwFGLzfkuNrvfkzsGG/lcNo9R0+VcyUa/1mhIGKKvFM+5abPOzftoHyxP29wQ5KaXAUK5
	o0GjcnGacfF29N+0b3XHDmHpGGPLOUkuu97uSebqHRQ3mZ/sKqS2qdrrj5RwOcCQ3/qyeTz22y672
	/8wMfYKaAtujBHapCN/lNpqOZLoDMBMr6h9Zkb1Gth7C+3w6vZNbnLQeSt+plfkbrqWVN6m/l+g1I
	3h5DDirrMoSsCDQGZtqd4OTgmE2yYz5i1t7rI7QpDzPVFER1USpe9Chemnwvvpm3G434xuFrXXeKh
	T5VW+kRg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKt6-0000000CZu0-3wgd;
	Mon, 11 May 2026 07:17:13 +0000
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
Subject: [PATCH 01/10] bfs: handle set_blocksize failures
Date: Mon, 11 May 2026 09:16:46 +0200
Message-ID: <20260511071701.2456211-2-hch@lst.de>
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

bfs uses buffer_heads, which don't handle block size > PAGE_SIZE well.
Without this, mounting will hit the

	BUG_ON(offset >= folio_size(folio));

in folio_set_bh on the first __bread_gfp call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/bfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 19e49c8cf750..9c3e90390824 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -346,7 +346,8 @@ static int bfs_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 
-	sb_set_blocksize(s, BFS_BSIZE);
+	if (!sb_set_blocksize(s, BFS_BSIZE))
+		goto out;
 
 	sbh = sb_bread(s, 0);
 	if (!sbh)
-- 
2.53.0

