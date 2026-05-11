Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B606377EDD;
	Mon, 11 May 2026 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483848; cv=none; b=frZyqf5ANgKVUarziOBjnUprp0lR6nI2WKw9MgvM1DLFNkqJmIrVGXOD+D3lE/fZ7vdy7L3+Vwmtp6vEIkeYjya7x7PgyqoNeZF0XyRbHUgYGNhRwvmTsSqEQfoVgKnnzyeniV2CaYFKnPs8E11KvgrgofHDt8kypkBdiqxYOoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483848; c=relaxed/simple;
	bh=9kNaISO7Zb1G3UxeASUyzXGLqpYc33z/fnyXtxiZr8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xt16pIIjH6xX59XvgMXzv4aSgOxvzOrUSXGekSUzY17U5vhhOu5KBvxFzy4WdWntSr7AA+lGVs9y4p63KSVj8kTu6JcLQVZ5g6Y7qf89RuyGDSjg1Uay+aASocn4ShWVPNrsfFWGUxZ4KSayv12rJ4tkUKho8t8IkJEnMRRdOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HFhVMDWw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HFhVMDWw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=e2DDWVvy8JRuP/90YZOyg9BCyoyPey/l7Va7CoZ1HHY=; b=HFhVMDWwkfAKh107MWxzPYctL5
	fLn15ocEFrh/ueyYTPuCbMw7KXbMz34R//uO24CUQuORM9woBwJCoRO++x0OQcC7cuL1szIjRq/Ht
	jc1Kj41Qhm3ksEMi6cZnug9wlaObrX4P9kXl9uMTyeDmLr5+1+XYVNVmQytahHYiROH+rhZFJmwa6
	la6mULN1Hy05X2m/PSl7vFiQcT+XP/VM6begBG8w1Ida9+7bC6vl8rIrCxo3dlY1BtOSwrZzynRKs
	xwFK8ePfBKY1anlrYkRbDBYyeUVRltHl0uVvepXXJjN9sXZw4Q0vRU683sHpKp+zufL/8Hwzw5bO1
	qh9Ag2sA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKtH-0000000CZw4-1zLm;
	Mon, 11 May 2026 07:17:23 +0000
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
Subject: [PATCH 03/10] qnx4: handle set_blocksize failures
Date: Mon, 11 May 2026 09:16:48 +0200
Message-ID: <20260511071701.2456211-4-hch@lst.de>
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

qnx4 uses buffer_heads, which don't handle block size > PAGE_SIZE well.
Without this, mounting will hit the

        BUG_ON(offset >= folio_size(folio));

in folio_set_bh on the first __bread_gfp call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/qnx4/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 4deb0eeadbde..42fcd500fad2 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -202,7 +202,8 @@ static int qnx4_fill_super(struct super_block *s, struct fs_context *fc)
 		return -ENOMEM;
 	s->s_fs_info = qs;
 
-	sb_set_blocksize(s, QNX4_BLOCK_SIZE);
+	if (!sb_set_blocksize(s, QNX4_BLOCK_SIZE))
+		return -EINVAL;
 
 	s->s_op = &qnx4_sops;
 	s->s_magic = QNX4_SUPER_MAGIC;
-- 
2.53.0

