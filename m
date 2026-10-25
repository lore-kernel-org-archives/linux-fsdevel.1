Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=189.12.192.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965845;
	b=PeHOOM3Q4Ot3vGZGDt2JEbgcnnKa+e2rH4gNpw9u2oefNUkN4ddQzGu6WOhzhxbFO90N
	 pL9zBfv4o9ghXndhN5N5lfgMadm0JzkON24EObBS8QG5ys1ZGvDt954uBHbds+vvl/M2E
	 loTYnDZ+gdECw0dj2jWQhdtUFDWQMqs/cjJ+mirZMl2HJ/XzK1HfKQg3UAAlzCb5fyYKp
	 88SDDoF07VJ+YZ+heteCWyaty1cetQKdK0KPqABMFqCsphFA8soSNj+QyW8wpn+pdReVr
	 2o1UnT/UkqI5RiA9UhZhhYeoy6sRv7l5d3MF/WrZXp3RUVjo4wJ7t/bYHBJo881C9pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965845;
	h=DMARC-Filter:X-Hostinger-Mail-Ref:DKIM-Signature:Feedback-ID:
	 X-Hostinger-Mail-Id:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:X-CM-Envelope:X-CM-Analysis;
	bh=h8BEVcgJKZj09m7WRqROF/3Lhsg67yJKrVv0xUXnEwc=;
	b=LBMUIhbqjTtTxElLfKt7PL5p/viGFp3sVIpCF1nVYem+D1dOchIPdyOkQVpKrMQjemOi
	 YsmHqneBfHRWmO/QvX7mjg7dT/2Mfq4BcIEAJ7agxsSwcuMhpvsklmRsNADs3p20wF1P0
	 bozXjMx3SFDkftIqN4mfQ9z6ghgrkd8zyRQ0Fk9344zlykV1mzv8B9uG1wrxHaubbUB93
	 CwSWKTN0i9752to4dOHxHBNXTEs/XKEqVqOwZlkqFean+8iv2dEOkgmSl1pm+v4TgcbBw
	 /jet9tsczlH3Qppb0uILyY1gEpucq7SnHuq+oRSX7QfsoZfzuII4cVROlQlOH5HFTHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=espilon.net;
	spf=pass smtp.mailfrom=espilon.net;
	dkim=pass header.d=relay.mail.hostinger.com header.i=@relay.mail.hostinger.com header.a=rsa-sha256 header.s=oak202607 header.b="oLl+/bJd";
	dkim=pass header.d=espilon.net header.i=@espilon.net header.a=rsa-sha256 header.s=hostingermail1 header.b=gQccjs0S;
	arc=none smtp.remote-ip=189.12.192.5
Received: from oak4.relay.mail.hostinger.com (oak4.relay.mail.hostinger.com [189.12.192.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD1606A325
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 22:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1CD1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=espilon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=espilon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=relay.mail.hostinger.com header.i=@relay.mail.hostinger.com header.a=rsa-sha256 header.s=oak202607 header.b=oLl+/bJd;
	dkim=pass (2048-bit key, unprotected) header.d=espilon.net header.i=@espilon.net header.a=rsa-sha256 header.s=hostingermail1 header.b=gQccjs0S
X-Hostinger-Mail-Ref: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoibGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc
	iLCJ0ZW5hbnQiOiJldW4wdXM9ZXNwaWxvbi5uZXQiLCJ4X2N1c3RvbWVyIjoiZXVuMHVzQGVzcG
	lsb24ubmV0In0=
DKIM-Signature: v=1; a=rsa-sha256; d=relay.mail.hostinger.com; s=oak202607;
	c=relaxed/relaxed; bh=h8BEVcgJKZj09m7WRqROF/3Lhsg67yJKrVv0xUXnEwc=;
	h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:
		content-type:date:date:feedback-id:feedback-id:from:from:in-reply-to:
		list-id:list-unsubscribe:list-unsubscribe-post:message-id:message-id:
		mime-version:mime-version:references:reply-to:subject:subject:to:to:
		x-hostinger-mail-id:x-hostinger-mail-id; t=1792965837;
	b=oLl+/bJd537dGr7Ef3RWCRILmpkjxtrC6IwHfyGVpwqHXW++ODuiTjxCrNs5/knG36k6jZzNM
	Q7Ne7jahKvvifP5EdEbVnPXiJftJzYo/18MD7/7EXOrv2MWzptpCrDNcc6GwuuQTse+UDATfuGW
	O5xsIl74NgCHI6AySdMYA/O3vpv/PAKlvLc386vjRoe6teKTHUzliVQDZ3xf9I80O2Otk7nO3s+
	Frpa2RDjTwoNzA6thpm+ztTgIM4yHAlbodNQ1mbWmrm4wqr8xnol1asQIakdKLOA7SBEZsTDbgW
	ErBWDpFLPqv3y/g4YhaBc+TXWFmV11y9+Lj93ugXYqgg==;
Feedback-ID: oak202607:espilon.net:hmail
X-Hostinger-Mail-Id: f9d4f8b8d0bf11f19309bc241188ec74
Received: from fr-int-smtpout22.hostinger.io (::ffff:148.222.54.26)
  by fr-int-hmail-krelay8.hostinger.io (KumoMTA ::ffff:148.222.54.51) 
  with ESMTPS (TLSv1_3:TLS13_AES_256_GCM_SHA384)  id f9d4f8b8d0bf11f19309bc241188ec74 for <linux-fsdevel@vger.kernel.org>;
  Sun, 25 Oct 2026 22:03:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espilon.net;
	s=hostingermail1; t=1792965836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h8BEVcgJKZj09m7WRqROF/3Lhsg67yJKrVv0xUXnEwc=;
	b=gQccjs0S6r4nDFdWPxf25s89aT3IoEOBOHGkG8rbtFTYcmip7IXsrCwKnpv6BN7o2wCLbq
	p8NX1lVYWpUdwrCmnYkHZmHDVj+9mozHGUFpVGyKqATLDu5xL9p1ad29qP8zSLD23M5a+V
	CH5Pca/Nvng61pmAMDvsp4eREjozSVlFU7mFxjQpekwl1/LnTGD5oMtqW90jn4Jr99GTjJ
	Toi62x0cExoGPMZ5Z/nFvt7MUpfmSmoaDBu4ZoMN29EcmFoOxCp6eJOGH3ccvl9Ivmrg8e
	PMAjR1xWVISH/jJEJS5lNknQGsW2lNUBK8XeFEJK50BHYhY6MXtDlq/wGLEwPg==
Received: from [127.0.1.1] (unknown [IPv6:2001:861:5b02:4810:d535:8293:aee4:a9e])
	(Authenticated sender: eun0us@espilon.net)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4jCW4D2PXkzyxG;
	Sun, 25 Oct 2026 22:03:56 +0000 (UTC)
From: Marouane El Moufid <eun0us@espilon.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/freevxfs: reject immed inode larger than the inline area
Message-ID: <179296581973.931625.6479067928730594410@espilon.net>
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
Date: Sun, 25 Oct 2026 22:03:56 +0000 (UTC)
X-CM-Envelope: MS4xfLJKJZio+7K+hwx5zqexbzvIhMRa6zZWKpYpwa+f8hgZ1s9Bl5AWOuun93v5WFH7sbPVpabDlxnHJzG0RI8eQ3BjpMfYNyeviImU6GiGeMK3UWbcMBH/ S8s+zlFP1Jc4stLBNZkrfAaNkltCX806nPMrTYN4iUxPnOUHxSq7cizJAgeCYpCdqExEyMQjhfg0Pr3liLCvKJSvVi2fI/bxhYEglRybpgPP7Dc54+ZbHLOo 7onfKgA+b1bxFfNrbC+7QU31hrCtvLiTPhqPHRgJNVrfHsx7lhHRdFaksaapPsX9bOdQVVn3BTOYq2Mew8BwFdIXFdiAjY90Fge9qvu987jrnCm6eaJphB5z T9YomK4H
X-CM-Analysis: v=2.4 cv=P6tohTAu c=1 sm=1 tr=0 ts=6ade7ccc a=NNrdi8j+18+XpAC5aQBFGw==:617 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=ICNSGLm3AAAA:8 a=alPJPtAgaqeobNmZSTEA:9 a=CjuIK1q_8ugA:10 a=-W5iAdWQbIJCsXvgvhpT:22

vxfs_immed_read_folio() copies a full PAGE_SIZE from the 96-byte inline
immed area (vii_immed.vi_immed) without clamping to the inode size. An
"immed" inode whose on-disk size exceeds 96 bytes therefore causes an
out-of-bounds read of the vxfs_inode slab, and the bytes are returned to
userspace by read() (KASAN: slab-out-of-bounds, read of size 4096),
reachable from a mounted crafted VxFS image by read() of the file.

An immed inode stores its data inline and is always <= VXFS_NIMMED (96)
bytes; reject at iget time any immed inode that claims a larger size.

Signed-off-by: Marouane El Moufid <eun0us@espilon.net>
---
 fs/freevxfs/vxfs_inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -268,6 +268,11 @@
 		return ERR_PTR(error);
 	}

+	if (VXFS_ISIMMED(vip) && ip->i_size > sizeof(vip->vii_immed.vi_immed)) {
+		iget_failed(ip);
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (VXFS_ISIMMED(vip))
 		aops = &vxfs_immed_aops;
 	else
