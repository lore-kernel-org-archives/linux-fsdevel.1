Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17911342514
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150187; cv=none; b=WTZE3OGiCjzlyVAcZ7IU/fcbbeyDQqipN7Kj8ODL+FHJ+7+qi1dz1DL5FE072aNaDHmGm/xkwbQU7njpLftX3ZRZlK0ua/Nu27iOO89k3Gfzs7BnhxsprVeHWG5+yLef8y1wYWoLC0IJHAjGA5atcwDOlpfH47PGA/OF1HZcBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150187; c=relaxed/simple;
	bh=4/QC7AaHBjIh7Azi1SmX+NbNRszt5GwbV38UBfa9yG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHekKQWrsqsoMgAKqOadVzLCHsT2VpH3m08DOkgPWJgRns1A+dVvNXKy71fiDItfSv9j/A56e0dK17AmqMF0DyxKCOn6MRqul6bk1S/dJK8zsgRSBT0l5OMbp2noja00i2buaIu77JDHvxomLM2aD//AVKTFGKFa+AOO0qO9noE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nf1yS0S6; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nf1yS0S6"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MHVXDU2338892
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:43:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=px0zdJjCphXpgaXYxO6RZVlv8ocaaxWmwBiPwnMxVmw=; b=nf1yS0S6PmvO
	Pcb05hAdHfTvu6NKXL4whLpDuKl+xNbNI+VIvAIrfeZSLS88xGWgWtgK/3w41YK/
	/6vu9FSUtEdxctZ4pXaAi4SQRh/DB5YtLuciqZy9SmH4j18GS0LOhMcaO0+mGNe/
	ac0Bn/ZQ4PhqtFqWJJ0YEO1T6DjEP7e4KCPN7Q0FB3aNkOTrWtNu9vD5zhcFIkDv
	j/hIGAEVm8cmDCTZG/GtoGOdMKQeT0Gz0f/8Bax/7WFhcVORb6H+HhIO4xd7nDPD
	OihNGOR2Ltum310b6hZ03WS0N36VnPDMZnIkmK9SzPUBDrH8wfB5j11DTTXMd+v0
	yf0vHwGs4w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ewrcd4x2y-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:43:05 -0700 (PDT)
Received: from twshared16795.04.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 22 Jun 2026 17:43:01 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0D82323A15DDB; Mon, 22 Jun 2026 10:42:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <dm-devel@lists.linux.dev>, <hch@lst.de>, <axboe@kernel.dk>,
        <brauner@kernel.org>, <djwong@kernel.org>, <viro@zeniv.linux.org.uk>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/6] block: introduce bio_endio_errno helper
Date: Mon, 22 Jun 2026 10:42:36 -0700
Message-ID: <20260622174241.2299563-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260622174241.2299563-1-kbusch@meta.com>
References: <20260622174241.2299563-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE3MyBTYWx0ZWRfX6JaLLn2f0391
 vl2U81gMWgZ9FZo8ZmS6edUzfOHtMCKqSfKPcFC0cIjkUYelhUGf9v95MgBTW6RvQcsnPhoeUrb
 wtc/DJPRViy/PDZi6munfKfrcYHe+dk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE3MyBTYWx0ZWRfXxz4R9taW6lEz
 yEmbQ8x1uX44JKQVQy+MdA9GJQE1SCHZrWYE4ATsLdUagna2yzEaF2+tjkDMk1dLF5gVFkufXEl
 fuYdhvRgNe7dlpJm0ySLJa0d6gY/R9wgAss8dK7Y+9VYRNZ7qOlvtSRgLq1f3SbXHyfVCtLYFwm
 K1ucP2x37UQAqWMMowij60a5uH9DDfi2CKwW2f4ucfY8hRHhjooBFevFK9ZY+2H6D1UnJCaFpdo
 0QI5WxNrY32mOOcFZRl06uzWhGaIvItYbILzo+d2bj45NmShvQruAxVxJGulTMyigq14yiQdqEk
 4sk3gS+Gmzy5DLNzBulP0YA7NHAtttwXv6Ybjmu9WTfh3z3mZ7j7KxuVRLFhr3QiMAqpPuh+XxV
 8JugIdwe0tbISisLx5YiTaRF3S2EDpfhBAG+uSZkjJHyZ6XNBVOX2P8WxvR5BIZnxF6oAuxg7Xq
 fY2jIKlNUR8uQRMg3oA==
X-Authority-Analysis: v=2.4 cv=VZTH+lp9 c=1 sm=1 tr=0 ts=6a397429 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=L_ds5RVfG79Zq-VKFV0A:9
X-Proofpoint-GUID: JrTxZhBRMLylDAaDSOdI7Ze0fY_i0TMn
X-Proofpoint-ORIG-GUID: JrTxZhBRMLylDAaDSOdI7Ze0fY_i0TMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

No functional change; purely introducing a convenience function.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-merge.c      | 4 ++--
 include/linux/blkdev.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index ab1161ca69f1e..c93170f340977 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -122,7 +122,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, =
unsigned int split_sectors,
 	struct bio *split =3D bio_split(bio, split_sectors, GFP_NOIO, bs);
=20
 	if (IS_ERR(split)) {
-		bio_endio_status(bio, errno_to_blk_status(PTR_ERR(split)));
+		bio_endio_errno(bio, PTR_ERR(split));
 		return NULL;
 	}
=20
@@ -142,7 +142,7 @@ EXPORT_SYMBOL_GPL(bio_submit_split_bioset);
 static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 {
 	if (unlikely(split_sectors < 0)) {
-		bio_endio_status(bio, errno_to_blk_status(split_sectors));
+		bio_endio_errno(bio, split_sectors);
 		return NULL;
 	}
=20
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95a..88e4bd88c3e28 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1047,6 +1047,11 @@ extern const char *blk_op_str(enum req_op op);
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
=20
+static inline void bio_endio_errno(struct bio *bio, int errno)
+{
+	bio_endio_status(bio, errno_to_blk_status(errno));
+}
+
 /* only poll the hardware once, don't continue until a completion was fo=
und */
 #define BLK_POLL_ONESHOT		(1 << 0)
 int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int fl=
ags);
--=20
2.52.0

