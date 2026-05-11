Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832637268F;
	Mon, 11 May 2026 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483873; cv=none; b=UZzT/eJ5P8LjLM57gqUAfcf+cv30MiODEV+C5DK4sH2H+ohI5bu1FJks9MQnLYrfi/FMUddGLRTCgmtjPMOGu8KicIO7Kzv4K1hSZlndy+BR+bB+Jc1vi6Kgw8nZ2b0HA3GkGCCx9Ra+roz87w9kY22BYYFMmv5fPnTrr5fSBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483873; c=relaxed/simple;
	bh=EqtEj0jVhLBbvyKL0EUUQDEiN6WeKrI/IRNKP/WznjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7r8AxigP9KyedNwMXjHJ8uyyZ8rtwvdNjDNZmYZLjlMPSNL+1PbluPi0YSrNDp/cNissv7hb7BU0kHkNCIOzGpcQmyY6bhbbm3UTOCEFK0IJ/AxFT3+VbxH4kA87SDZXPSfNMU+X1qotZFtXxTSyL6OdU9KOM9qSC+FCX/OwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4hFWTz+w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4hFWTz+w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aR2RFmte/Kb5tmI5Q0KcYXAlh5RXiaf7zjwxXol8fSs=; b=4hFWTz+wdl7TIAVGV4XqAfjE0W
	Z6VUV1AVfAiSqlp3NDfXcw7Yp7RoOqHWuObOIimxyQQF3ECo4X4vSUGTNXFbX+d0usdk51RSj/xq2
	LKx1OMu/Fb9XJlzqgL47OKuK+4fbd+N1l219h7Ua6lXmIWFMvdbHFYZVHD2bQjAxA2VgvnSbKE+AK
	goVX0HenEdDARcC5WC/HLA09RJlPuVu8uUxiiC9kyLtnn9HFmebGzfXswOTtrhGrDjGFBMt+P9ApR
	OEsboh4QgB71qS6hYKMf6EccB0+OFwTnaT8KDkFV4TXTaWwhGSbXufKMNsh/GWAJnUDN0pmBtjLpU
	NrBF6Ang==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKth-0000000Ca1A-2lcv;
	Mon, 11 May 2026 07:17:50 +0000
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
Subject: [PATCH 08/10] minix: handle set_blocksize failures
Date: Mon, 11 May 2026 09:16:53 +0200
Message-ID: <20260511071701.2456211-9-hch@lst.de>
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

minix uses buffer_heads, which don't handle block size > PAGE_SIZE well.
Without this, mounting we will hit the

        BUG_ON(offset >= folio_size(folio));

in folio_set_bh on the first __bread_gfp call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/minix/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 9c6bac248907..03a69b13950d 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -292,7 +292,8 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 		sbi->s_namelen = 60;
 		sbi->s_version = MINIX_V3;
 		sbi->s_mount_state = MINIX_VALID_FS;
-		sb_set_blocksize(s, m3s->s_blocksize);
+		if (!sb_set_blocksize(s, m3s->s_blocksize))
+			goto out;
 		s->s_max_links = MINIX2_LINK_MAX;
 	} else
 		goto out_no_fs;
-- 
2.53.0

