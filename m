Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E63126DF
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109418; cv=none; b=G7/w5ntqHvsY32hSLoKwQCCAJAysoBBdaP5hA1W+8cNobhasO/qId7rn4UWiajJL1tvtYDhEQYCPdQhMGarKRODL44PPzrtDvsDn0QFjI1Vc1u2fQLrbUsgLUvR9tMABuynzgDN5mZoExCjSoxfJCPAVHEm8XbWYVqIDofzi2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109418; c=relaxed/simple;
	bh=M12ZxE182cZ+ohOgBfzqrF7MN/q042sMCCrx1eF37zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlQhAI9Q0XmPxEDSBNKwqBbdcoNmnJGGN3kL0wCZ3I6drNL2v5qRuA+2IduZPxR33OBBXLpEE5Nf2r8NRu/eI/adksHHOCSVzNjnNiHO+G8sfTfAy774SKPoocP15Tl1BnJJIUjC9AP5OpE6RGhdv/3fYgTLAD+6quU3LL2p+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YR7RZXYQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YR7RZXYQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4KrPXhKGthJCzGIsn7TtJijtm2DEtDrrvSsuQcOZOis=; b=YR7RZXYQWOOyO6RcR7kl2q14ff
	IuM7bNhd+FLZvSN3b5gJDbHx3GfSmb7e7x0MGMic+6ASIaXOk8Z/a1I6L+RZwItqcKajRbIYgzISI
	XOBp2UMp+mq83+jh4/LVVi/r5SjckRLhBf15PV/1gTz1aSLhoKtOUWoGTFLSEbFMKMPIEJIWUL1Wu
	3L+RAIkEDaMCRnfAhqsBaz/YtAz0F8AId1PV7tXadbd8+cPr3eGq3y7EaIf2BumhdJzx03raBsdtj
	oKymUhFHiU4lmjH4vl35KDbm0dIFdCQ6zPLhujl5Sf8RJE7zNLLIcj6ODvsVpJ4/bh2B86ShG6drF
	1CTXLS/A==;
Received: from 213-147-166-214.nat.highway.webapn.at ([213.147.166.214] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxd8-0000000FkIX-0Z1a;
	Mon, 18 May 2026 13:03:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] minix: release the sb buffer_head when setting the v3 block size fails
Date: Mon, 18 May 2026 15:03:30 +0200
Message-ID: <20260518130330.529085-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

At this point the superblock is already read, so jump to the label that
releases the buffer_head for it.

Fixes: d893fc670546 ("minix: handle set_blocksize failures")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/minix/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 03a69b13950d..c30cc590698d 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -293,7 +293,7 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 		sbi->s_version = MINIX_V3;
 		sbi->s_mount_state = MINIX_VALID_FS;
 		if (!sb_set_blocksize(s, m3s->s_blocksize))
-			goto out;
+			goto out_release;
 		s->s_max_links = MINIX2_LINK_MAX;
 	} else
 		goto out_no_fs;
-- 
2.53.0

