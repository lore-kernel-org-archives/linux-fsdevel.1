Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6C36DA1A;
	Mon, 11 May 2026 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483869; cv=none; b=sSMyjxz7W1VBscw2WULNB6zKrtxJpeQx2pWGb5U13haZ7u6OVej+yvKVUDMvlUd9LrGWPOxEfk6nFkf2QBUu4h8+7EQnyvj9rLru8cL7Vw1wLQQitUI0D/dWfEanFmObImp1n0Mx+OT44GkxO6KuzjOO4tekWsVnZZrF7kD9nUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483869; c=relaxed/simple;
	bh=v+NUEHD7n3eoH7OVLluKH8BUD5N/UhKpCN0GtijnDag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciHsIl7i0SYjTHS3aQojm4XZZmheydegOryh0n9AiZK8CdaqsaJZAbmgUTejEJ9nO+AMUa68YpijVv2P/5hoX1ngTo/hsXUKoa3LsqPn/URwmCvNMXrKd81A2hSqZIJXdOvzfx1EiCgxus63ITInUjWO+oP7BfaSDXEMM3UpK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jJ5UMb8L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jJ5UMb8L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=x2aBBodp7jNDMFHHHvSq1J+gnId3ToV+Bim38+tUTjY=; b=jJ5UMb8L04MYOqGAg+nj9CH7oV
	HAG9bLY3P+HMymLkJ4XrSRtjh28xIAHoSdBwecOUDZlXtMjMYbixNNTV4NDX6hSELRuq+L6YlQzpA
	ZwxEcuqGJXt/tSvLMmVusWPobzYDwr4b/l7VHIwGXCSUBy6MBvrvx5fgOoXvZofFd1rFgcMgemabV
	SVwyd584DlY/L0KIP9yEAdfPfKhvtIPrkG7wo1ypKkL+FIC7AeGlVV0XbQpngRL3cEjI1G0PAkbI4
	h1QYmwWjylQO+JeEp+ebetHGnukH4NPe5U4MNPlXlYjhpX5HagRn3vQQktQPOxVUQgjLx6dhJrKRR
	4yNRGvKA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKtc-0000000CZzr-1noJ;
	Mon, 11 May 2026 07:17:44 +0000
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
Subject: [PATCH 07/10] isofs: handle set_blocksize failures
Date: Mon, 11 May 2026 09:16:52 +0200
Message-ID: <20260511071701.2456211-8-hch@lst.de>
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

isofs uses buffer_heads, which don't handle block size > PAGE_SIZE well.
Without this, mounting we will hit the

        BUG_ON(offset >= folio_size(folio));

in folio_set_bh on the first __bread_gfp call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/isofs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index efee53717f1c..337836a0a170 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -818,7 +818,8 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 	 * entries.  By forcing the blocksize in this way, we ensure
 	 * that we will never be required to do this.
 	 */
-	sb_set_blocksize(s, orig_zonesize);
+	if (!sb_set_blocksize(s, orig_zonesize))
+		goto out_freesbi;
 
 	sbi->s_nls_iocharset = NULL;
 
-- 
2.53.0

