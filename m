Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08136C9EC;
	Mon, 11 May 2026 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483852; cv=none; b=lyOm++/gg4E/lDyyu2Febece7oUCKikAhWmYql8YF10mXfEhwjMVUUfFh6QdwV9YYGRFdPH+p+YhIWQBe5KKnYi90l+9jQCF0MysLOWo6Uk7Ww+lnz+rG10L1tww6Jpe/q2qzJKpPSloB1MVch+LIyIv4vVw3TVBHqu7nvvbBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483852; c=relaxed/simple;
	bh=As8fOX4w2FjkDcSkRAFuJ74dc3Ao0CDC+Anij1o4lTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0BbA458dt7jRsrD6rjmZ7xkn1czOY8yZyODndbpBOVY4VoOuHklSUDTtggUvyjCm1jio/y7iAk8pLja32aMekW774asJs137bm8OJFsYIsA6xpmTtAmVcRlWK6+2nRiUA4u9FPaCKvAXox6n0ZPYCDHcSy4iZOd9W+UAviBK3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i3DBC18l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3DBC18l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AlW4VrYLCvGKcn7QA9iXAFO1IinR2oezEBIhHW/ZBXQ=; b=i3DBC18ljidO5LwloqcWHLtEr4
	RVENEa1gWjHAdupRf0eZ6Z1f33IgPXXxFmX8zPHEv15mzOt6BBxu5+MOVGMvBcz4aupKpug6F6NHB
	DxPE223AlTNnpm7Mf7w2kMBn9x2KTIoMd6pApmFzyiyzwen/wdv04H/eg0cQi8EKZa/vusdG7vtvg
	cOaDb+Jqy1HCpfCmHz1oWi4Uf/fzsFECplOL0vvc6xsqFZgnwHnSxIaJHarTc3r91zd4wLyAI0Btd
	MmN3wvkuN0gUU5XRQTKx5Y915vopy8K0hbDvBG7cODMYCdQLmp4x5cNNKQMh86bXk7+DxqSN0glhR
	LNTdcckg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKtM-0000000CZx3-3pqC;
	Mon, 11 May 2026 07:17:29 +0000
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
Subject: [PATCH 04/10] jfs: handle set_blocksize failures
Date: Mon, 11 May 2026 09:16:49 +0200
Message-ID: <20260511071701.2456211-5-hch@lst.de>
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

jfs uses buffer_heads, which don't handle block size > PAGE_SIZE well.
Without this, mounting we will hit the

        BUG_ON(offset >= folio_size(folio));

in folio_set_bh on the first __bread_gfp call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/jfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 61575f7397ae..8180d83d33fe 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -491,7 +491,8 @@ static int jfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/*
 	 * Initialize blocksize to 4K.
 	 */
-	sb_set_blocksize(sb, PSIZE);
+	if (!sb_set_blocksize(sb, PSIZE))
+		goto out_unload;
 
 	/*
 	 * Set method vectors.
-- 
2.53.0

