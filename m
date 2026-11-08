Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070893;
	b=AWFTnXcLp84BpHw28SGTB6ByDFLAmb7nNT1tJUtQhfudRCUgpE+GmSuRwMRGLxfItWo4
	 8v07W+ThP59wkuyIUvw8i/Sw7/T6J4ZLpt34w5XSd7wDWeg1NVYrknDApCXXiZdbmdK99
	 gbyiP5mecyh/f+vFagZkffqTH1cjR1HRSWA38ZCnBzJJpUhKFSVMnfXH20P9sL25mQsr0
	 MDQvSg0NKpejwIZj3s9K4gdH7wfI4V/palXExWbCaF4tjTq158H8mYtWTvh7H/TvGoevA
	 hi3Ye1Y/KFmTODTndkvXwLOSU80s1ZicZle2hW8+gnr5/bO6si1UWesZVPgmz+yvU5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070893;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=puiDWva68t/nBSAljGVXrMVIkkqCBXfuvA08W8pFV60=;
	b=lN43d060qkNntHOfBwNke0/IQ8GJW+oChJkpFL92vkPhEcUariFtvuqHn+FUZa8bvuZr
	 4t1y+Y0hSOUbiGZv5dLyJIW+0A2Ru9szZWlk5DqwIZKsy9pAfmRiSjuJgZ9qtb4WuVgYG
	 0UAZWAsyBzKKCGJdV0+AjuZzzSTW4dzeCGvma/E+Vc56SqcC2zXhK+hwOFX2tTLhS4Wqr
	 GgF+MSIONMaBKwnj0jsS1g4CjTfZcMGU652Kir9Qywu0Fc/EAqFu6M7OCgwJnYgETMPEn
	 4Z30Z2+VPk5fo6gyR5PhtWilgjm00Nw1yVnDIzKKhyiBbkNFkZmjf/rHT48dmQ8IGeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=epahJ1dU;
	arc=none smtp.remote-ip=203.205.221.236
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFC606D81C;
	Sat,  7 Nov 2026 17:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05CFC606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=epahJ1dU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794070883; bh=puiDWva68t/nBSAljGVXrMVIkkqCBXfuvA08W8pFV60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=epahJ1dUWc3RS2RCSsRoctaIOekPyW/8tYXVgiBO5hHcDz3a2bFZJDePInd6VAgrb
	 oCnuuBDsKROuEpBZ0rxuMqmRrJo1Fw7WOp3s/eusCXN7Q6Gb+3naiuc0jzWMCtIlmd
	 v5nmwJxVW5P842wox5PsluykWLtK/Bk697KlfKYc=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 55014FA; Sun, 08 Nov 2026 01:01:21 +0800
X-QQ-mid: xmsmtpt1794070881temyhvmk8
Message-ID: <tencent_EBEADAF7CF88B39381E959548BCF46146006@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLTqLnB0FOBJXnACMgTIeP71lHhMrysP0OZY3przdDZkmY41g8tS
	 dyiR8iKxHd3t1cXlica5RDzYXrdAB/xk2EISR45WkQ2X9awR01aq+fCrXYNg3P4vojYQIOd8OiD7
	 Z80KqyL6uBl1CrIIRsCQat+ozsizI8lpQDi4q8/iKUc4yCT7z9NyIRyF/eQr0il/h8LOXRuQqbOB
	 2T6fEDF4Zv+x2jsAZFW0EnckIcdAfP0UXbVsH2F6Db1yl+Uim+Np3f4n/JfAiYcWAZMQFx2OeS0R
	 AGwwC0+ldbxGEdqFUEK5in7hiL1HeFEo+7kBueZnrhliCQosEcnBXhzIjF1W62Z70ibvSNZcHF4T
	 +lgax6tRyTAzlh/h5Szz5tvlSS9wMT87EPzZAokpQV5wuzg0pWP7WUP1jrRVTBndJRUe0UbbKwho
	 l9qHj/opL21k7/tE/V8lm5lebY9x84ecoC/nv5fuq2ZB0FFDbmQqixdqKNb1L/TexOpKutHqAu1W
	 a6jmH95VteuWYp14/h7t9wp7VknxxmrOtLm8JptZFEbJypslU48/kEPGDNyJEzG5rnojfB9v+flG
	 fZnAWXCB2sXOgUfJbOmIJg2SomKyQwcqB2QVAm7yy2c2d1epi/Y4XT4l6B8fObd9Wa58oVoxerKX
	 rygzudvIiVnAnk5ACeyzh1+AOV1iYUq/gjvrH8PG0q85uWVTvpxihLJYDiR9sTIPhMuOjvV0Ffac
	 JyERkv2i5Ji1Nu/idl1K5wynXmIv1w941Quba1nx1JeqJe8K5Ru6qit0E5HRsIu3eN9REg73I+JG
	 lUMZy4nEYH3EjORRQ3AjZrSPIQMEgUXqgyPv7uoBc1q0X2itpPTzr58zTrkVXjpCK4ltsO27YZTd
	 8Hv6VlLZZndfgurQsZyMTAbVgfHeBVH5b7nxvq1YrILpPc8EbOwUqcL4cRqHIKwe/VtoX+nt0WSd
	 L8ZiIUU4utGCtekZH9JlzgYoxLjTfcmYSWOv2iVBoSSuEY3HbGBFyX1cvtSs9rHwXAZx9CwQHaU5
	 vnfLmvaO26q1rRW9LFfrnLkbOsYpoi9+1x9RuWhM2RDpYZB9SqHf6eWPoPDM7Ne6MZYMaNrHpZDC
	 Btg8eUUt/sqggXobwAMW2w1Rya7R1kG2fgztMy
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Guikun Yang <yangguikun19@qq.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: validate fs_cgsize when reading the superblock
Date: Sun, 08 Nov 2026 10:00:00 +0800
X-OQ-MSGID: <patch-ufs-cgsize-20261108@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <c5-ufs-cgsize-ubsan-20261031@qq.com>
References: <c5-ufs-cgsize-ubsan-20261031@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

fs_cgsize is read from disk into uspi->s_cgsize without any check.
Its only consumer derives a buffer count from it:

	UCPI_UBH(ucpi)->count =3D uspi->s_cgsize >> sb->s_blocksize_bits;
	...
	for (i =3D 1; i < UCPI_UBH(ucpi)->count; i++) {
		UCPI_UBH(ucpi)->bh[i] =3D sb_bread(...);

struct ufs_buffer_head.bh[] has UFS_MAXFRAG (8) entries, so a crafted
fs_cgsize whose block shift exceeds 8 writes past the array while
loading a cylinder group. fs_cgsize of zero, or smaller than the
fragment size, produces a zero count and leaves the cylinder group in
a half-initialized state.

Reject those values where the rest of the geometry is already
validated.

Reported-by: Guikun Yang <yangguikun19@qq.com>  (bug report of 2026-10-31, <c=
5-ufs-cgsize-ubsan-20261031@qq.com>)
Signed-off-by: Guikun Yang <yangguikun19@qq.com>
---
 fs/ufs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 1111111..2222222 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1140,6 +1140,14 @@ static int ufs_fill_super(struct super_block *sb, void=
 *data, int silent)
 	uspi->s_cgsize =3D fs32_to_cpu(sb, usb1->fs_cgsize);
+	if (!uspi->s_cgsize ||
+	    uspi->s_cgsize < uspi->s_fsize ||
+	    (uspi->s_cgsize >> sb->s_blocksize_bits) > UFS_MAXFRAG) {
+		pr_err("%s(): invalid cylinder group size (%u)\n",
+		       __func__, uspi->s_cgsize);
+		goto failed;
+	}
 	uspi->s_ntrak =3D fs32_to_cpu(sb, usb1->fs_ntrak);

Tested on the image from the bug report: the crafted fs_cgsize is now
rejected at mount with the message above instead of writing past
bh[]; the unmodified image still mounts.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
--
2.43.0

