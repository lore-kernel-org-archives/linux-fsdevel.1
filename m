Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63127363C57;
	Mon, 11 May 2026 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483842; cv=none; b=s+qGNCBp8FqPMgpbIQHx3RF7+hzzIRzEsFsray1gptprI6Sg4uPwCuiuZTllPiO2+pqKeV31wFHAIwqrH733JOESc4gz0rRTzy7ZICx0hxZNp4OBPvpb6D9Z6Ysm96DHIGXVbeT3Ah1jIDehe0V6DxbVIRPh4vppRXJ7Ai4EWqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483842; c=relaxed/simple;
	bh=nse0vMbW6MKvWnSRYdBc2H25gsSOkXmlC7feS6yRxtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0xlbw+b/W1zsLZsq3OQJM8HJmOPaAUnPihz4h/+M83wqSSN8PjldNK6DaaZhPxNNyHJcS8H3qB1wyxwNvXIp9h/6g8EkVfGJ6DrgShKRwKlMIL0eQXp2ISNZPVqwfs19uNk8n7HDM1po78cvV71W4UklGMevu8upCwurcN0VCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oC4WoaiJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oC4WoaiJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UyJTIykBug8gdVgrUJu6+OKLU/Wr/DRs5y3NvvS7QYo=; b=oC4WoaiJAZ91nlpQ0wu7VCxart
	18YfXt4SDBxTlAdkItzJqD1kF8ASNmbD4V+/Qc2mveXZDU9VQJVIlv0kicCERBdXRMCEJSwzmMVFH
	sGiqhvTFmBoM/+MkBq22dbIfQLumWZP/ZXU1h+UIeqMteTlWKrTp1u6ddNb3e48s6NLyKFJGBIzfg
	f/2Y1miK+eWG2DqBGHOwCLtSJMZi4HMwQYuUF+KzS99yMihNjUCqhxR7DoSvdl3fE/5tITRrAY8G4
	k+zytBueG5u/TLF6WcG1lfTNwkrlpV2Swb54/R9BFbrgef7c6/Q3DNPQG9J2P8TLlFd8ofY/4ujVy
	vHkKJjhg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKtC-0000000CZv8-07Bj;
	Mon, 11 May 2026 07:17:18 +0000
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
Subject: [PATCH 02/10] hpfs: handle set_blocksize failures
Date: Mon, 11 May 2026 09:16:47 +0200
Message-ID: <20260511071701.2456211-3-hch@lst.de>
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

hpfs uses buffer_heads, which don't handle block size > PAGE_SIZE well.
Without this, mounting will hit the

        BUG_ON(offset >= folio_size(folio));

in folio_set_bh on the first __bread_gfp call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/hpfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index c16d5d4caead..8fbdbf080627 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -523,7 +523,8 @@ static int hpfs_fill_super(struct super_block *s, struct fs_context *fc)
 	hpfs_lock(s);
 
 	/*sbi->sb_mounting = 1;*/
-	sb_set_blocksize(s, 512);
+	if (!sb_set_blocksize(s, 512))
+		goto bail0;
 	sbi->sb_fs_size = -1;
 	if (!(bootblock = hpfs_map_sector(s, 0, &bh0, 0))) goto bail1;
 	if (!(superblock = hpfs_map_sector(s, 16, &bh1, 1))) goto bail2;
-- 
2.53.0

