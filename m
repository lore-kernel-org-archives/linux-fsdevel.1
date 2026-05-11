Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FBA3101B2;
	Mon, 11 May 2026 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483885; cv=none; b=ARGL68o0x4iLIIR8MtXVxGjNHdOAqnU/j6UkOVYfPcisTY0T0gWYrFNiU0Vh6sseNx4YdjTVsEZ7L3RjzQyJbyBUKhazTvWSpVACXkcWD7CTFbqVWK+koY89KEVlWI7AsP+WRHp6hPqnKjP6vTDOwsQIUh8Qk8CaOvTcnOg3RJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483885; c=relaxed/simple;
	bh=Z1tY7DCnTF4fvNmpVoYo6PgxV2UMwG5/X2hWVBhPjyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/UR4l6qK75cv0FB+ywUMHG3DGz6zmL1RSWT7Zo0moPYx3f15G9FRbZaa+mT3xwZV/7pD2o8qMRoH4fE8l1Mf3VS2ho0JpCpye7XGvSApIPKuHqGJ1YzS3NF7INBg2VvAj7lHEzCiCk5BcyBM2XFc66S4Otm8AGKPmZqBZXP3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F2FpEAzq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F2FpEAzq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Cp8rbwo7FkiiWRmmG8poiJjkYOPgF+/p/j3c3hDMw34=; b=F2FpEAzqRi3hV5dX/6Ww5VJ+UN
	YK1JHyorwXwbyHpd/gKwJjsalAIoZSQb5ElH9/jF/olSclJH0aAZiNJhpX/grEfP4+Bqu5/Z2b+TM
	x1R5lbhHFVbY/4TFSyzFRMw066EHdQJp36O9XVJEil37yjnVWRFnVufvUomjsABPHD7ZNT1RAYSV6
	QD9OIypKAQxnqrhEnhWhRSzN6XypMiW3SN4Y/kwZAXCipkpSJ7g0+GExcmBN0n/M8zUaj2ChWPdHl
	/osVjE2CidQF5zsCyj4ZY0zuOwJY+k7MQF1KV4QV05G1zzCVWbkzg4mU4jYNg3gxBIx5mjC3sI8p+
	i3bb2csQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKtr-0000000Ca2M-44EF;
	Mon, 11 May 2026 07:18:00 +0000
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
Subject: [PATCH 10/10] omfs: handle set_blocksize failures
Date: Mon, 11 May 2026 09:16:55 +0200
Message-ID: <20260511071701.2456211-11-hch@lst.de>
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

omfs uses buffer_heads, which don't handle block size > PAGE_SIZE well.
Without this, mounting we will hit the

        BUG_ON(offset >= folio_size(folio));

in folio_set_bh on the first __bread_gfp call.

Signed-off-by: Christoph Hellwig <hch@lst.de>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/omfs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 834cae1e6223..1d915ef72119 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -478,7 +478,8 @@ static int omfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_time_min = 0;
 	sb->s_time_max = U64_MAX / MSEC_PER_SEC;
 
-	sb_set_blocksize(sb, 0x200);
+	if (!sb_set_blocksize(sb, 0x200))
+		goto end;
 
 	bh = sb_bread(sb, 0);
 	if (!bh)
@@ -530,7 +531,8 @@ static int omfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * Use sys_blocksize as the fs block since it is smaller than a
 	 * page while the fs blocksize can be larger.
 	 */
-	sb_set_blocksize(sb, sbi->s_sys_blocksize);
+	if (!sb_set_blocksize(sb, sbi->s_sys_blocksize))
+		goto out_brelse_bh;
 
 	/*
 	 * ...and the difference goes into a shift.  sys_blocksize is always
-- 
2.53.0

