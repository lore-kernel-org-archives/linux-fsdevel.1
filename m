Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F7340A6F
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150177; cv=none; b=k2Z9bSnBzmv8JWmzHokA9/S4aHBVKAJt1oLb38/t5u2QuCjlssU38RvXPQAJ8RcgzNZHtwEdr1oq/a2MOZ4JAvDFXU5//xWMhvN7EXSckiyuIKCcnzvZJN9tZSBxZZ4IrIuBGL2w3p1bRcfIHz5bJ/7mufHe4wB8ShCZ7W/Bcps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150177; c=relaxed/simple;
	bh=fV+p6UsXYYz/7f3n6GNtfT1kU/l0GVybqjGmA7bt8fU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaC168lRz/CrdeDfQCJqRpdqzW24xHonY+jXRV9LB28bxylwfGPbzkeBxHov+0o0rz+ZU81HIGN04uRtelPmfQEdSQlV5+1Ic9beko6vnIt2amyI5sQunZpM27fZKfTicW/rfuygXL1YgPvdIZQjGBDdwqrMwBIxtLcXzjrW9UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=G9uuN+hn; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="G9uuN+hn"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MHVSAY2185484
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:42:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=j7+niTVZQ3CWvHIyJ2q81+nHoh9pKOXH/b9PSs634io=; b=G9uuN+hn0fbs
	g1jIxJS+pumpdDQ/wxEa0uxvaJiyeU8T24L6RquViZ5NgIQZ0jZd7MkfByD9E7WY
	uwfRXVzXehl+hLMkuCeKFXws7Ahsc/UZyc3bjQsBlz+AsHmuAEEUu4PRfwtocPAy
	kQouTKYydyG5gSxI00sYXoD7pHFc5euFPN7ooOZIv8NNWiUgcbjsStUmTV1vJ6gF
	JwNTWCGh488qXdP5CU72BbzUKqAIIpo+/Zs9LjWEloi4ib5zOlvaPEc64GEOdN/m
	pd8Tge2m6kV2Lvb52bmKIwiFNYU7AEOvOAEo/WSUWbVyzISE87wG+jvA7jy33+Rs
	JmLNWo0Ygg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ewp61whqu-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:42:55 -0700 (PDT)
Received: from twshared17215.34.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 22 Jun 2026 17:42:49 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A91FE23A15DE0; Mon, 22 Jun 2026 10:42:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <dm-devel@lists.linux.dev>, <hch@lst.de>, <axboe@kernel.dk>,
        <brauner@kernel.org>, <djwong@kernel.org>, <viro@zeniv.linux.org.uk>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/6] block: fix dio leak on metadata mapping error
Date: Mon, 22 Jun 2026 10:42:38 -0700
Message-ID: <20260622174241.2299563-4-kbusch@meta.com>
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
X-Proofpoint-GUID: _f7qwTGQMzzrYc5EmLt2gbkAgEVzz9hT
X-Proofpoint-ORIG-GUID: _f7qwTGQMzzrYc5EmLt2gbkAgEVzz9hT
X-Authority-Analysis: v=2.4 cv=BuitB4X5 c=1 sm=1 tr=0 ts=6a39741f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8 a=hePQWg9M9jSv14wK35YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE3MyBTYWx0ZWRfX6e3C57jiuThm
 DwcmDYmfviblzQrR2C55gyBHo0/ok5zBAsjMSE/cdP7cgcGvHf7efPl/Tv6V0melZT1MX7QkvNP
 FBV2axg5Tf3ea+HISsSnI4VGq9ZCco9GgJ7Rnr46/mcRefiWEjvB5GFhXTdk0EAtHRkqUsIc22X
 BkpdH3E59w7+oVSXx7jFXEkre4bGj/0Z8pGPoBiSgdk5C9QE0YZFV0Xe8Virl1cWh8K+Qg+QJlY
 oeFR0uHm6gBjmDLZkXCFBVHJDH2IXn2MB8miN45E/QLd07hnFXQkJaNwtm0X2AfQio428OtdCPL
 tHM8ho5HPhWec2+LYDIfmmp8ws446MTgVzuqXbwx6o10t2MZiGmYy8RqGVWUnp4ncuVqrkazaXg
 lzu3rQTQAnjylbG5pHt0+kJj0AcsEvsy8tYPo476z/qZ22pt9OaY5kYRXX5heBEm/S4jvjfhg/C
 qJts+kpdCfAcTs0njRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE3MyBTYWx0ZWRfX3aO6AyPrfz4A
 j4FhmRC63duiSEvLvytHtuPLXFNPIX7f+hbNZijgwk2HsDxTZat259lHkHcltTmr/0C22GVAMKH
 y4bOrxUMz8461M/MZiT9iCjensx270g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A failed integrity mapping holds a dio reference, so we need to go
through the full bio ending in case there were previously submitted
bio's in the sequence.

Fixes: 2729a60bbfb92 ("block: don't silently ignore metadata for sync rea=
d/write")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index f237d6cab8975..b5c320da28123 100644
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
+				bio_endio_errno(bio, ret);
+				break;
+			}
 		}
=20
 		if (is_read) {
--=20
2.52.0

