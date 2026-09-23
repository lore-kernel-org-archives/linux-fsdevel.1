Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CF93A71A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207838; cv=none; b=gOViS1LU5OUF4DFqCgChTASOAEFOlmCsw1NW5RIsU0NFjlyiU7SmBlGLiNcrA7E7Ucq53ntClUV834YWY4oIehp25Jp1RmEomNaaQug5wUEWvxasX1kupAthMyiiv0gkLwfBH/y2B8dPlGVidaaRNb5p9m82lb0paHArRwW/TM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207838; c=relaxed/simple;
	bh=YMDQDXgHvisSOsY3WQrY2kVt6FOq3O9Ypoh2P+vxzKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNf7iQGsDQn/A2DQLvmO6wUBwkSaHIHA1vl3wjeQdvFNmIVg1j6LBuGU3IPYgQZ9u0ks9WAS43Dg1HEF+voGVYXJIn97xC8ZrobBtKUOf6mEEoMYcMQHL2AEU2CDRCf9SXI8EjdBUhpeoFZhzb3TdR+jbJCAY+TWAFmQwtWSr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=PDW2zhaR; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=d1hDZ1Vz; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="PDW2zhaR";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="d1hDZ1Vz"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNCQvP2170306
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=cc0o
	mFVdeKpkhDBaIU83p8O9yx2QegCmTSxi6DGn1/0=; b=PDW2zhaRmjM/PwcRtiGz
	eZ2hTCCD6j86/uM17aF8r64rYhw73ssG5EIwsHgmc2WZqh3ZAj4B2gaHBBrllJym
	HJiQemEpkr49/l6zx1HsK5MAF1dgwxwY6F4rMZmyyCcDEzys9UoYDByrfwFCvYeF
	3LadGeN0h5eMPgrSjVDkVLcyK+O/DcpcK926aaFVe57qj49wWTB0BvGPFCbyYkxS
	YVOnMfyPnnYzBd0zvQzoeaf1GDH4c9cfbW3la8dsc2/STmFrJHxhycAbB699Lixh
	NpTPNWLQfrMA9MGTls7vwldTjrB+XcGoJhv3Diorn2clMAie7GlBiMTiD7f9eKYe
	5g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvmrat1kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:57:09 -0400 (EDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc73ab90ae7so1178663a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 16:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790207829; x=1790812629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cc0omFVdeKpkhDBaIU83p8O9yx2QegCmTSxi6DGn1/0=;
        b=d1hDZ1VzyJpDXi/AqWmaDPuJSIJXuFs7q0jQDQl9ae4hsl9LHnQhxLEHUL82Y3mGT+
         GZ7v73bSrY5bvqaIS18A0CKA0+cT6EEsRicXaLBWL5hVQ+9UTDrt1ItQJ6Q9BhO0q9N2
         tbIbrKMsptsMSSj4QXJmp3BBfG8cP6fA50knLCY3e2AES4WmVjOC/L/ifaSTxWh2tIZD
         6JaY4NWvlalghQM/8KvCj4fPFVlN8s9u/B2jbWmkvjb7Sa3bd8rdxsCHc/ZQSo2aqoGn
         XzaNucc3jZDmW92K4XId6hRgH8nCTnSePQVKeTfsxmRdNiRBR9pm7FZAsN4Gz6ivLuEy
         WfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207829; x=1790812629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cc0omFVdeKpkhDBaIU83p8O9yx2QegCmTSxi6DGn1/0=;
        b=2EPWldYsWxdkPJaMBkkxfgiWwgZDSqrtlGuGbF+xBMyX0IUXTXbKNj3ZxBB6PskZux
         zstXZG0YP46X0UUaUQxsPMAzJqttp6DTi83ZZLAnBLQEuYinwLs/1lCVmmCaQ3NI0w/v
         cLrMcwmlf1w4y9mjjtE86VyMr+HSR++aeA/WtgaD4XwA3McTWsxyiHTERmmMmVsyPN2L
         NDq8O7ObQvgiAwe8NzC/twLOP/l+1yW+z7VEnGC4G38JPlncX1t8S5tAOrcMNiAPHInM
         YQ5jeZg2DoV1G2BBVrCZNYiWrbbw5KF1mgIFTs8PUsbch8PTmU3DSCszYxaNRDMKYsE3
         R3tA==
X-Forwarded-Encrypted: i=1; AKwUvBy6HAl0qKMUbHd+HAcBgeG91B7Ju0bqgtacGQjSGvoplNOMD/i6dBCc5H2AQ0QiIshyUZZktuWjLnih2QVE@vger.kernel.org
X-Gm-Message-State: AFuF++lp9EzF2SARx/FuJF/BWTx27Esk1nl6pbnCvKK+IaNelokL9Yjl
	8MK5pXsG1pHjDDg7VfWq3KvVgPxba11q8iWGodUQca28wJM5ekRIqG0qLpXsTYcNHlvyeKmqxIR
	ZLdRda2xJiqqdxvR2G9dzX2hNQLB98+mckBZNLkThYJThfgOGnJOOlIAhHEU36kA=
X-Gm-Gg: AYBFou2Clq+ctCAQdrC5GkkqMsoKoPL7IT4sQOemlCFnLHyzX/aOU9JEuZcdrFO4XVw
	AbmXP50r2rr/yid/8kSPXnYyVHhgb3JF0eTPuBeeirZrms5tmYQlfXvBvKJLX5OswyR7PuOu3tj
	3yDxHsoYc+DkzqqXvxpYgy/VeHyHdKWM3NI0qxRuIyyMBLhMe9YvjRXflajP4MWHibY+aQf4+V9
	zUVHkRmJOjwM2z9oL+qeH2iI9pVo0WsaK/qFiV7AoyKEL5ZduCw/jSW7tBYTllN9my1a4HipU4z
	36dTjyUF0vUmmtkbKRKzZI252r3lbO8w/nVxu1yaqBBLtQlX2ewFgESwZVG738/UD6eyg4WKsEe
	UP6d525Q/gS9z+16Uji2j/46LVba5RnXcg76UiBM1YlvzJQ==
X-Received: by 2002:a17:90b:4fc8:b0:39d:f4fd:8075 with SMTP id 98e67ed59e1d1-3a098ce492amr490426a91.19.1790207828820;
        Wed, 23 Sep 2026 16:57:08 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc8:b0:39d:f4fd:8075 with SMTP id 98e67ed59e1d1-3a098ce492amr490405a91.19.1790207828356;
        Wed, 23 Sep 2026 16:57:08 -0700 (PDT)
Received: from [127.0.1.1] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1331613a91.14.2026.09.23.16.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:57:07 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 23 Sep 2026 19:56:42 -0400
Subject: [PATCH v5 9/9] block: remove dead metadata handling from the async
 direct I/O path
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-blkdev-fixes-v5-9-89e60d66eb38@columbia.edu>
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
In-Reply-To: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.garry@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790207813; l=1396;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=YMDQDXgHvisSOsY3WQrY2kVt6FOq3O9Ypoh2P+vxzKE=;
 b=sPILe/kyUbp0UCL4bz6D402nDcKVbwLmg2pPSjHxEY9K3xV0BuZybj9/lGnB5Pvf23U4M1YB2
 0anpPrFDTkYCwMc6vi4Kax3gcCsgrwudHvLW7rNxmggYFs8LnnxxPGg
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX/rM73g3UX2o8
 kImyRqk4bm3FRGR/nOw1Pms5F4KWJqD/R6ynlQlnIRcw+9+wV5HGFmh5SOVxuezBxbOkgjdMXSx
 j6agaHbzRV7yZWtUsi1c+L6X/gcaysPluk417mnJGlXHcB+mpyA0
X-Proofpoint-ORIG-GUID: lbNn65vxSQrqLPXQzIvNCk1YZyJ1AAOW
X-Authority-Analysis: v=2.4 cv=cPp1IVeN c=1 sm=1 tr=0 ts=6ab46755 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=VwQbUJbxAAAA:8 a=IE87Obj3e0A1gCLlgTsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX3SjOEN5annHT
 jV13ShcYD9aBNz9lXaGkQ5l25op6d3ppnKHRCgtP5GHimau8talypFcKVFQS1OUInX99+GYeu2f
 owdaKYDrRolCP3umXlvTLb4jqgZ5zJq1EwC+D3L2u9icO6ToJMxk5LJJB4I8+zVJsl8jOF0EVll
 fl0V2dUUfEFkKVlwQR8yJlGuQLRE6cOgyKeC9DyTPc35+PstmoQg0ZYDXIDGE8U5SSxdt7FfJZz
 e23bQx0Zx4tMJZIWXwlQLXVCCpjN4leLehWOsa9RZCy+3y1+GPunDl/sEHo6frYWYOXRHbhTj3X
 Gmk39/lFXukkG+SRXWPztSSQK9XSaYzZpQ9U59epv9EPQg0C1mAGWyzqMtcIZo7ov9s40GtA1bc
 Yqat/P37f8HDUkhLT3m71thc+E53w4XczEC2wJHbQb4k4cPNCqBMi4yQxhc/k5N14GNoa9gGkxM
 LG3s4vecjFKVDXSGsag==
X-Proofpoint-GUID: lbNn65vxSQrqLPXQzIvNCk1YZyJ1AAOW
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=10 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=10 clxscore=1015 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230100

Since commit 2729a60bbfb9 ("block: don't silently ignore metadata for
sync read/write"), blkdev_direct_IO() sends every IOCB_HAS_METADATA
request to __blkdev_direct_IO(). Remove the now unreachable metadata
mapping in __blkdev_direct_IO_async() and the unmap in its completion
handler.

No functional change.

Assisted-by: Claude:claude-fable-5
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 59af4e808204..b13e8f83ff82 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -306,9 +306,6 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 		ret = blk_status_to_errno(bio->bi_status);
 	}
 
-	if (bio_integrity(bio))
-		bio_integrity_unmap_user(bio);
-
 	iocb->ki_complete(iocb, ret);
 
 	if (dio->flags & DIO_SHOULD_DIRTY) {
@@ -370,13 +367,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
-	if (iocb->ki_flags & IOCB_HAS_METADATA) {
-		ret = bio_integrity_map_iter(bio, iocb->private);
-		WRITE_ONCE(iocb->private, NULL);
-		if (unlikely(ret))
-			goto out_bio_put;
-	}
-
 	if (iocb->ki_flags & IOCB_HIPRI) {
 		bio->bi_opf |= REQ_POLLED;
 		submit_bio(bio);

-- 
2.39.5

