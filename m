Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B22F7F0E
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321613; cv=none; b=nN0Ye6tlElAZuBnrHj3JHa1ntxkuLpA1OMRe9WK/F5TYadr6IkqCVzPMMfDldmhjWw8PxGt9Ciwpzn1DBxQPrQkQsGrCTf9wNphCQu215qYsOM2gwH4LM0yGWFyb8cPi+98BCh10HmXQvWztjY9dQPTdktbf2vCYTKEd0dRRjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321613; c=relaxed/simple;
	bh=21MLgX1uN99mVVRG294peMLFmjCNl7Y0KFU0cQ7knmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzOibITachuPdqTcbAIFs1tsyPZdWCqenQZldDNDbEHYiQ4fL+PyJpQlRFRAwwT8wgbPZPNFpKjEjxPC0gW5vj5SGJbPA/ShS9qNCLBIaeai1oPLmCd+lIpHd1hSQJcjGN5tYXpVUbFVYrU23cpiYUqK544kW2afNfxrnOrE5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JGVowSPN; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JGVowSPN"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEjNDh3972569
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 10:20:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=FBCbMs5JtmrQ3uFAyVG1ihvmyqsWua8nUu8THP3MFfY=; b=JGVowSPNmINn
	BmqAGkbmVaFWwbzV6EDykQaDoZJB30kvd/kLkvOIzVaCDsGA+zEDDUAH0YejreWv
	XV1pR/QWUe/Ram/6f2S4MQMLxtR5enslLx1t0eBEBoEtcTAZE+qhrn2i/5OD1T3i
	CH8i/x9b8gEXpFXvosauS0/G9+7TJh4jUUFKh7aiAbcrXu8OPAu4JKcfPToCpIJB
	oT4s+zH8z9rv3bVG5CkeWvHFUnj2P6Dqdo0dLIuIKX+XQWXkJ16drmqhKxcd+uYH
	4EDW65Ku9+amzrWJ5jb4jO6atvYCm4mTZGX2Stw24PNti5noSm7eTX5TWf7UUuG5
	isDbecH2lQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eyumssxq6-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 10:20:09 -0700 (PDT)
Received: from twshared25719.01.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 24 Jun 2026 17:19:52 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 1D9AC23C452BB; Wed, 24 Jun 2026 10:09:08 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <dm-devel@lists.linux.dev>, <hch@lst.de>, <axboe@kernel.dk>,
        <brauner@kernel.org>, <djwong@kernel.org>, <viro@zeniv.linux.org.uk>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH v3 2/5] block: fix dio leak on metadata mapping error
Date: Wed, 24 Jun 2026 10:09:02 -0700
Message-ID: <20260624170905.3972095-3-kbusch@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624170905.3972095-1-kbusch@meta.com>
References: <20260624170905.3972095-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=eoTvCIpX c=1 sm=1 tr=0 ts=6a3c11c9 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=hePQWg9M9jSv14wK35YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfXyQ/++Vjo3wYv
 dNxjA/L4PDeoTYxmQJSOrHnaU6HIvSrYLs/00fKQi10ufvi3rBEFsmDAg/NwmgQ5KZZREonnVJD
 2otYYNncZmZBtT2d5dnzrQsu9SRKt78B5zZOCSyJXJUozLhbf48NZTBNa+ZSghRq9y+rKpHY4FH
 yGk4A4QImU7DgN0AV3Lw6FvhkEHIXxrru7CIwbLu3ob4gGi6vqBH/7vn9pHvmvSGREP6i5ANIrX
 Q4tERQtYGVVN/HZAIPU/zyAl37MoYhT3uzYE+zLooXOFm/3QHVDMowk6V+OWe0L8ZLnMf8yMcbq
 SXXjuybbRCJt8K8w0InEPjY9Lkek05SbI/M1PcGiN9pTH/vn18uiparbeMgmxqy21sjF+ZK031A
 CWo2kEvKL3GuuzyG9bVyk+pT3oIp2g==
X-Proofpoint-ORIG-GUID: ePy9YfDljXP2eR_ETXq8ykeI7ijca2ad
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfX0q8UL/gPNNZl
 xY0BjANA3LKgDgHhdCGhqeYbYZW0p4z8q3Zp70qPjc8gprrHUAVnEQ00svgzcBPiSsNRBYP6XxS
 42HUojdw+MnrLsYlahB97cRs6SvODaw=
X-Proofpoint-GUID: ePy9YfDljXP2eR_ETXq8ykeI7ijca2ad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A failed integrity mapping holds a dio reference, so we need to go
through the full bio ending in case there were previously submitted
bio's in the sequence.

Fixes: 2729a60bbfb92 ("block: don't silently ignore metadata for sync rea=
d/write")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 0827bb884d473..0098a90a956e1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -238,8 +238,10 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb=
, struct iov_iter *iter,
 		}
 		if (iocb->ki_flags & IOCB_HAS_METADATA) {
 			ret =3D bio_integrity_map_iter(bio, iocb->private);
-			if (unlikely(ret))
-				goto fail;
+			if (unlikely(ret)) {
+				bio_endio_status(bio, errno_to_blk_status(ret));
+				break;
+			}
 		}
=20
 		if (is_read) {
--=20
2.53.0-Meta

