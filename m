Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=189.12.192.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965845;
	b=V9STM/FJTHWBKBR3ProCbOQWCwGuUtZg6TvG/q5ZljggkAKH8115rbxTIa4peIsMVtR4
	 3Q5zt+birRm9Jy3Ab4E2VcIKqKrPGhUqNWYw+TrC2wVT2uTHvd2XT+pFYtIBC67Op2Gqo
	 mOGTq+JarKSyFqEOMf3n/EjWY68uXOgcy5zb1oaRfVldi05cp9Y3KkKWLl78uwnP/EVkK
	 r4WFPbe8AbNHjhtp/Mnm7hxKPylRg6HjjDLUEb8dDUZd1D/SQtmFIjEZVjegjY63T1zTD
	 k4Fq74JT9nJYBWkfr+1+4Nc5nfR+mSOKRq2epTCDc9vYr/SzQb+jCrct9bIYFRdS0lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965845;
	h=DMARC-Filter:X-Hostinger-Mail-Ref:DKIM-Signature:Feedback-ID:
	 X-Hostinger-Mail-Id:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:X-CM-Analysis:X-CM-Envelope;
	bh=QdUdWKI7gemfcyeHi5uKu4TGwE/B8K8A/8p+9RAy1oU=;
	b=HMKoRtmhQbEaCM72GaB27F11dHPKuthJnqKViOI2lguv5faqTvBJgnCdGCMpsKVG7IAQ
	 gPZGkmUUdG3XhqeRSRgrWpkC4DeNJEY44PVnZRdXfMXv5v36wBcjE8Ono2M4L16VwOfRU
	 TPxg7UQ5gIbgXxFvIbBD+TTaJuXns2U+s2sBCHe6KBmlx7LBRXdgQqBEzWdQrdDVcnqtW
	 yrOaC4yRiuC2ldVQj7Z51yv0mFqWEUvNrI2QCtpVXcJ1fqa/oO19H6kiGS2ybKVQc/sXv
	 Q3/D90dDePQs/ptzWDx1thG6i2bdn3/i7oatKKFFn/0EmuH1iu6m1wd6cVyKBe1Sy0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=espilon.net;
	spf=pass smtp.mailfrom=espilon.net;
	dkim=pass header.d=relay.mail.hostinger.com header.i=@relay.mail.hostinger.com header.a=rsa-sha256 header.s=oak202607 header.b=mKYJJFxc;
	dkim=pass header.d=espilon.net header.i=@espilon.net header.a=rsa-sha256 header.s=hostingermail1 header.b=z1bsC494;
	arc=none smtp.remote-ip=189.12.192.8
Received: from oak1.relay.mail.hostinger.com (oak1.relay.mail.hostinger.com [189.12.192.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225A606A324
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 22:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A225A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=espilon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=espilon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=relay.mail.hostinger.com header.i=@relay.mail.hostinger.com header.a=rsa-sha256 header.s=oak202607 header.b=mKYJJFxc;
	dkim=pass (2048-bit key, unprotected) header.d=espilon.net header.i=@espilon.net header.a=rsa-sha256 header.s=hostingermail1 header.b=z1bsC494
X-Hostinger-Mail-Ref: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoibGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc
	iLCJ0ZW5hbnQiOiJldW4wdXM9ZXNwaWxvbi5uZXQiLCJ4X2N1c3RvbWVyIjoiZXVuMHVzQGVzcG
	lsb24ubmV0In0=
DKIM-Signature: v=1; a=rsa-sha256; d=relay.mail.hostinger.com; s=oak202607;
	c=relaxed/relaxed; bh=QdUdWKI7gemfcyeHi5uKu4TGwE/B8K8A/8p+9RAy1oU=;
	h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:
		content-type:date:date:feedback-id:feedback-id:from:from:in-reply-to:
		list-id:list-unsubscribe:list-unsubscribe-post:message-id:message-id:
		mime-version:mime-version:references:reply-to:subject:subject:to:to:
		x-hostinger-mail-id:x-hostinger-mail-id; t=1792965837;
	b=mKYJJFxcIKyKvq+5LouDinFGUdbQDheYDXpD5RXULT/32qV4a606BPDcIG6S/mY6eYWSjAbBk
	QjY5Uf4k/UCyHvb8B4xVb953+FOpni+ko6Mj/eqEUm8NzaMqr3QBqFofB0/nuko1Yhpteya7NTZ
	2lAX8/uPurjCRf7Aqt08xlfWgUnl0gnnS6tnb1IjD7f1d6XUsb/RlGi1lsfWOYarwOgqVpApjV4
	xC4Vd++Cmj7ex2Id0VR66Q2L4nXOX+3BgqnlxAeEeLowOAP85b2uBZRLCNRFktd/FxeZr2oaU41
	uauMRAAhAlztpm4xH88l/KFvd8Quqsa+xtQVcFXQ+VZA==;
Feedback-ID: oak202607:espilon.net:hmail
X-Hostinger-Mail-Id: fa02225cd0bf11f19e88bc24115bb549
Received: from fr-int-smtpout22.hostinger.io (::ffff:148.222.54.26)
  by fr-int-hmail-krelay2.hostinger.io (KumoMTA ::ffff:148.222.54.54) 
  with ESMTPS (TLSv1_3:TLS13_AES_256_GCM_SHA384)  id fa02225cd0bf11f19e88bc24115bb549 for <linux-fsdevel@vger.kernel.org>;
  Sun, 25 Oct 2026 22:03:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espilon.net;
	s=hostingermail1; t=1792965837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QdUdWKI7gemfcyeHi5uKu4TGwE/B8K8A/8p+9RAy1oU=;
	b=z1bsC494emwgfutNkyhhCDQ9iVNmKan9eTK0Hchfd3F0Yh6iBDr5cvkjBFgRZDvQ2hc3kt
	nf4gMkBpPCqUe7qy0tk2663FyiUUgOvWLXvuuis/fjlNAJsrDM8lRi2MSoEKOde0kmOlqI
	oWq2VgiGg8qCEDoRqaPA+NOP7b3v3YWC+gn8BgTIm/0+xfFfgMN5h1YlLsg9/GAvwMvTpr
	yJ1/3G/C5TCe4JR1iteqNIHjAXQOuBi3EjNc9cKp8tRRKEDqb+R9ZwSKrXcv+P9IVSvDHG
	oZn1qOa4gmDGe0JZ31rYOE/BDariFhlo0msAWmTwWdJS0iAyl1Zs9cXRct3umg==
Received: from [127.0.1.1] (unknown [IPv6:2001:861:5b02:4810:d535:8293:aee4:a9e])
	(Authenticated sender: eun0us@espilon.net)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4jCW4F0Nl3z1003;
	Sun, 25 Oct 2026 22:03:57 +0000 (UTC)
From: Marouane El Moufid <eun0us@espilon.net>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/adfs: bound F+ directory entry name length
Message-ID: <179296581973.931625.5260582703376775024@espilon.net>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 25 Oct 2026 22:03:57 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=CoDtcW4D c=1 sm=1 tr=0 ts=6ade7ccd a=NNrdi8j+18+XpAC5aQBFGw==:617 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=ICNSGLm3AAAA:8 a=KJVV_1SJKfEbDMfVY7UA:9 a=CjuIK1q_8ugA:10 a=-W5iAdWQbIJCsXvgvhpT:22
X-CM-Envelope: MS4xfKJfFyJwkKSy0bzPvsDDfK2FTGcWurSuC3L597x1Lx5iwjjRV7/7nOoPf6U/8dyrEGmy3FnKosDJAUsX677jWZkOCCgThGVImaYB+aNR5adfebRKR6fF 4GytyD2etpujbQPjIrXKy2MNHtEqPFIvjI3pcfKgFYlmO1na6S+WBN0V4qkHBuBYSLG/pSe4op07OojgrGlAIVFnb+0xSjPVsHS9Yu485m36bX6s1khgySwa I/mmytzlenUMD10wGIV83oV6cvSQuEMryNeEXn85AFYzHQdYGngQ5cRmGHBxc13yTG4VRgo6PBU43q6NCcWlq//oIxiFWKnvj7UwLyidRsQ=

adfs_fplus_getnext() reads the entry name length (bigdirobnamelen, u32)
from disk and passes it to adfs_dir_copyfrom() as the length to copy into
the fixed 260-byte on-stack obj->name buffer. adfs_dir_copyfrom() bounds
only the source, so a crafted F+ directory entry overflows the stack
(KASAN: stack-out-of-bounds, write; stack-protector panic), reachable
from a mounted crafted ADFS image by a readdir (ls).

Reject an entry whose name does not fit in obj->name, leaving room for
the optional ",xyz" filetype suffix appended by adfs_object_fixup().

Signed-off-by: Marouane El Moufid <eun0us@espilon.net>
---
 fs/adfs/dir_fplus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -192,6 +192,8 @@
 	obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
+	if (obj->name_len > ADFS_MAX_NAME_LEN - 4)
+		return -EINVAL;

 	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
 	offset += le32_to_cpu(bde.bigdirobnameptr);
