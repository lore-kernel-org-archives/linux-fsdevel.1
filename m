Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D139E16B;
	Fri, 25 Sep 2026 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790310847; cv=none; b=H1UbhYIggkF7Y6d5bIZGwBCNwrd8EUdWEKfudhgAgmDJbbtzdIi1j0A66k6gcxOY0lq2NHUTzRtcbyyOhOVFvMUSQF2MVy5m8nzck9zXbuKeB+FxtkiQTRZyQCWcSPjI9m4XM1k25595LIUsF1JaJ7GLaS/Ax6V3FQSqIWkJZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790310847; c=relaxed/simple;
	bh=hmoJ8ZwSFjMMJARSXLhDx182hMYcFXMtTuhtgRY51xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0/YUIlJNPljdem8SLS1n0f+N8KDYYXkwq2onoGPpkIxC5nL29NoiSeTNsFtENuGB+frXCi0rW9mNf9YgijY1Xfc/R4FBHySRtvZDiyHP6aP8DhBhqk4oeS6qgKFHJjNAeylMznGzF/vQMe02p7QdtKhOW4f3BhJ6Zp8zdTBs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=1RqtgHvY; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="1RqtgHvY"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [201.48.143.134])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 7C1D41210F5;
	Fri, 25 Sep 2026 01:33:39 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1790310821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZkEezres29Esv4sS76RHtMxXk3an/L2iFac2K+n+ZWQ=;
	b=1RqtgHvYIk5bCLpbAbNtoWQQnnqpBhfdwRoMs8LP4Ebq7xt9Vnrak2S6iU8nevNyTgrCV4
	98XCHlDODWtQD9cUMv9wlhNIidoEfIgHVQ0Uod1y0kmM+N3FK0TEnGuzHqsAm2us6A5yj8
	3dtnG7Zo3XmT+PAOYOQIg2Ib1sBT0NnEYyTPp/pOVcN4CC6p6EifLYPCQo1DntGy5QIk1G
	KhjF9e835Q6kc+6+XG5JyzB6pD+25wOB+2dPOdAVHv3QhoSZj/HNATNmnCKi3rFe4Ty8Qw
	1L7mLfv68zvmrWvHhhFnBt0PEEMRDU571Seh/BALbjhGfcR8E6mXwrZZtHUemA==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5585f47221c0de04168d@syzkaller.appspotmail.com,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH] ufs: validate block and fragment shifts
Date: Fri, 25 Sep 2026 01:33:37 -0300
Message-ID: <20260925043337.87879-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, ufs_fill_super() accepts images with an fs_bshift and an
fs_fshift that do not match their respective size fields. This causes
UBSAN shift-out-of-bounds issues in the bad fs_bshift case and an
out-of-bounds read and kernel oops in the bad fs_fshift case.

Make the ufs_fill_super() function check that these fields agree with
their size counterparts.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+5585f47221c0de04168d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5585f47221c0de04168d
Cc: stable@vger.kernel.org
Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/ufs/super.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 3569ac92b..7df3eedd9 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1001,7 +1001,10 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 	uspi->s_fsize = fs32_to_cpu(sb, usb1->fs_fsize);
 	uspi->s_sbsize = fs32_to_cpu(sb, usb1->fs_sbsize);
 	uspi->s_fmask = fs32_to_cpu(sb, usb1->fs_fmask);
+	uspi->s_bshift = fs32_to_cpu(sb, usb1->fs_bshift);
 	uspi->s_fshift = fs32_to_cpu(sb, usb1->fs_fshift);
+	UFSD("uspi->s_bshift = %d,uspi->s_fshift = %d", uspi->s_bshift,
+		uspi->s_fshift);
 
 	if (!is_power_of_2(uspi->s_fsize)) {
 		pr_err("%s(): fragment size %u is not a power of 2\n",
@@ -1018,6 +1021,11 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 		       __func__, uspi->s_fsize);
 		goto failed;
 	}
+	if (uspi->s_fshift != ilog2(uspi->s_fsize)) {
+		pr_err("%s(): fragment size shift %u does not match fragment size %u\n",
+		       __func__, uspi->s_fshift, uspi->s_fsize);
+		goto failed;
+	}
 	if (!is_power_of_2(uspi->s_bsize)) {
 		pr_err("%s(): block size %u is not a power of 2\n",
 		       __func__, uspi->s_bsize);
@@ -1028,6 +1036,11 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 		       __func__, uspi->s_bsize);
 		goto failed;
 	}
+	if (uspi->s_bshift != ilog2(uspi->s_bsize)) {
+		pr_err("%s(): block size shift %u does not match block size %u\n",
+		       __func__, uspi->s_bshift, uspi->s_bsize);
+		goto failed;
+	}
 	if (uspi->s_bsize / uspi->s_fsize > 8) {
 		pr_err("%s(): too many fragments per block (%u)\n",
 		       __func__, uspi->s_bsize / uspi->s_fsize);
@@ -1117,10 +1130,6 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 	uspi->s_minfree = fs32_to_cpu(sb, usb1->fs_minfree);
 	uspi->s_bmask = fs32_to_cpu(sb, usb1->fs_bmask);
 	uspi->s_fmask = fs32_to_cpu(sb, usb1->fs_fmask);
-	uspi->s_bshift = fs32_to_cpu(sb, usb1->fs_bshift);
-	uspi->s_fshift = fs32_to_cpu(sb, usb1->fs_fshift);
-	UFSD("uspi->s_bshift = %d,uspi->s_fshift = %d", uspi->s_bshift,
-		uspi->s_fshift);
 	uspi->s_fpbshift = fs32_to_cpu(sb, usb1->fs_fragshift);
 	uspi->s_fsbtodb = fs32_to_cpu(sb, usb1->fs_fsbtodb);
 	/* s_sbsize already set */
-- 
2.43.0

