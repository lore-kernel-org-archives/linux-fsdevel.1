Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794111900;
	b=pMk06YyRtm7+yy5q0sbS0O1bqM2oODs9gNhooZqib+/H7KtNJ910UL2p6agXZIPh7lqR
	 igjHKjUkfSVjTyi7rW0sDAr0W/3y7+5POycy+Q3OrlcDjOmGqy5+oS7d/cu3faDmH9X0s
	 8p5m2gR6Mq3y5S+dNKTL2VLKmSrtSSPX/D5Wl3soUbrxyTbi6mkiD6w3k62x74EhTGdF5
	 IVb77mWSVSZ+vw2Yxn3EkMlDUBWPTvrvLkTiutRaOU7QMEK/vrZaygKE7TTAUvqvBBSTk
	 k+KTsSK7zcmRyPgU0f2Qwsw+mRIPScWSxk4vjI4R6Zi5nPk6/jjzakDxzsw7nelVV9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794111900;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nr2Wdm4cU+m3pqBJ2boexNpwuovYPWeiRQ6Ijfa/2ao=;
	b=iMsac43VfI0KiUMUw+tescIZI3F+7eFGPMEpZG1T2BmuA4UxPOWCy3yO5xHa/zFJrqB/
	 BIAVitz5t9k5rX+m0P8SYxnvmk66DzVV1g6sQ4oLEXuiFQplep6dmrw4z+HD+/fitTfjW
	 fD9lYx2FIhY6kZw5s8Qj2gaAWNaA5MA99D+49m5VlhqN1ntI51zpdH7N1GiwZXKB9UMhT
	 CA5D2ul7vsF5PM3pNlC4D0kr3ZmduVMDOmSLnHZhnisuEZLE/3wQNQAt9/BovdiV4mcOp
	 52ZSQh7Rqo3Vw7xGNxrYwqxHuLLfGyn4ZFvxlJ677Rfa2O+7wJPGL5B2I74dUo3ATCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=r0Tut1ve;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xTksu3W2;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E7606A321
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 04:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E58E7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=r0Tut1ve;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xTksu3W2
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A83eK2e1838880
	for <linux-fsdevel@vger.kernel.org>; Sat, 7 Nov 2026 23:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=nr2W
	dm4cU+m3pqBJ2boexNpwuovYPWeiRQ6Ijfa/2ao=; b=r0Tut1veybdZKVhIjzNS
	f/LbH4m79onai7u+naDj1RMu+HNEuFy4EW25wgHYDwUimFujDwGDDoGf6N117nf5
	uxobIRKETpZGhznp3u34Tl5TgHaqv0bnQ8Wuzu7uZkKLM/biJeU7cKhNU/33t13Q
	WN0PyPJrrTIUmjAY8gvvn1HaK9/iKxwCbfbfQuMH2BKmEpafDbP0y4AyFwysGrBM
	/p3onW7+72iw/NbhjSgF9lWLBEUhinDoL7ACcEGUSGewPnLfn9RvyFZAjUcKzz7r
	3d9LPmAppzpzs5jypgm2G/Cf0Y3WFYa+F9wr7TGDC2fzDzKBNEpmXzUYEoaeif/I
	PA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ht0x4421y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 23:24:58 -0500 (EST)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5358515b4easo4844521cf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 20:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794111897; x=1794716697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nr2Wdm4cU+m3pqBJ2boexNpwuovYPWeiRQ6Ijfa/2ao=;
        b=xTksu3W2zbddPSvYXw1KCEPKyQ8qBoo9EWhExte8YiKEgvH/b1uqj54lAPkSUtshxz
         R0nQWjqIpjdswYs1BztX33DSElMaiTU3SOLuC9DUMt3IKglPtsTtvi85lBSBRqoD7n4r
         pIe11e2KTT/0akPhVzS6SeVzTcPXY1RAuiFrwXQ/6pgfHtqq8BUP+89OHUX+G6NddL+2
         1A0+Lj6OambObz9K8O2BuQhPGgvuQWVJnKC0mGnhSeg7/S4JZqAzjFECylaVaWgZQCKZ
         E4O5SAuehNTnsWNfYBMLHvjcPujC6u3iqbDA84/Un2enK7AH6GttY6Iv333XOhaB6GTT
         bQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794111897; x=1794716697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nr2Wdm4cU+m3pqBJ2boexNpwuovYPWeiRQ6Ijfa/2ao=;
        b=jLkw/QwWDq9mb1/9lVpgsl8z3qUlyevrLT7zuxuwC5RWSW2v5hRkH5ZMTNQpwthr1d
         kSHvkkPw0lndzRFsZhl2OOfPioqiIh4Ax2qyx7vXDUbEQL+vPz8cNOp3/LFE5H8Z4PO9
         WC4oHg5KLfR2qxxEoRkFMiqVm1kqRWCkuRZ1jHVCpIGDmCY9eXgAwV+IY8QggvRCrHSN
         Gon8j+/mdGii6aELDpo5RvtxKiuBb5GHCywcT2c5VftFQaudXI+YxfHl2bYkFHM23ONy
         ajGa6FZHwQLWaqN8oGEPN6ASc2buh9wLNKXUX1kWZv7fXu3aTNdWtcP8+tvhv2dBYIun
         jX0w==
X-Forwarded-Encrypted: i=1; AKwUvBzdzpaQA8eufSiIyX5Iezb/7id8DGgqWTpLEP+nDSt08y/CprnedwUg1ZvHG/GQ3h1n2IwG8vNSdaWXZZtf@vger.kernel.org
X-Gm-Message-State: APuU4Z8mWGiBl5tIlnhD43WuF1mprEV9e07inMBmQipVHAjkgrG9NMJO
	q62n2iZKhB/eHc8s/fyXtoXwKaovjzTEQALc6giWuYqCWw/4fEednsQFDNEBiexV3iMP4CIJfMk
	XKJxs5qmIhxAxbHOb3vW9tLUzqfFn7POLzsJ6tRsAEggvX4UfZH89VmqHSaN2M2E=
X-Gm-Gg: AYBFou0n8j0KyZs+1vHlQ2U9QzMf/8zP65QPIf/VdNjh90S+9e0QUgEdp7ZK3X+rWzP
	EzIvjXFzQFADvzYE1AWXwhYQ/wA2i/YvzyHQeDXLT6oRgIPmylR4fyNlI0R43hkSvtzSwP4UCSL
	NHSOaVNEvWJ+NuIv6ArckmeZlzNROH5dI3Q4G9+3p82ZWnB1BfIHv6YunQRgDHmNA4aNDyznrDm
	etS79mL/SO8aQc/i18jaog2sRLhPIPWdmfzHWD8DwaEFxFYBBoJwWY8QfCeBPJfhvf+e1/pyOOD
	7ZNpo8WAY6hqzxA3o18p/3PD0S2lUXvI7p7B22PfINzSmOdUyZ3l11yVcfWCWaYLsovkCeU4KPN
	3xmb9gvpX0ay56lB/diLBGAy1HJzBz6e51kPPvXX63P1fHjXyQGuGesNxVglp0JEgF/vBKA8F0F
	OyEL9UGexTI6mTtFcWvQ==
X-Received: by 2002:a05:622a:5507:b0:535:36d:dd97 with SMTP id d75a77b69052e-552a50afd9cmr5945801cf.48.1794111897267;
        Sat, 07 Nov 2026 20:24:57 -0800 (PST)
X-Received: by 2002:a05:622a:5507:b0:535:36d:dd97 with SMTP id d75a77b69052e-552a50afd9cmr5945671cf.48.1794111896856;
        Sat, 07 Nov 2026 20:24:56 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eceb56290sm10085586d6.1.2026.11.07.20.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 20:24:56 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 07 Nov 2026 23:24:35 -0500
Subject: [PATCH 1/2] block: fail a short atomic bounce in
 bio_iov_iter_bounce_write()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-blkdev-atomic-bounce-v1-1-f66344262096@columbia.edu>
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
In-Reply-To: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
Cc: John Garry <john.garry@linux.dev>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794111894; l=1259;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=7TVx2/mnFenAz9IetxnT56jaB8MDSx8eh+EB+HeZVY0=;
 b=gtfq1Uu5lL/o51CiwuZdW8JnZsS7EQmgCr/CjLWHC40wFPmi8TmuWNFXBbg1XMM4G8/JGXrcj
 IRjI+Ygqmz+Ci2lYcH5eeFDgH5zKF0bslDSMzRf7bm3ZBsZZc9/7jcr
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: IoHSAk5xpgN-XdD_Du5alCZaPdu1-AJV
X-Proofpoint-ORIG-GUID: IoHSAk5xpgN-XdD_Du5alCZaPdu1-AJV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfXwi+0d/iH5cGC
 Zk5Q6m3QqT/ruH31ZhBv0rRATpUYKZgdS8BbWLwk+5f1DsEYFlypst4DwTBf0Gg2MMp3EjFcND3
 yhiCqtOPA7JLY9cuBc3MonbPW0DV05iHuUlI4ffNg67M0Sba5zJ5GUnO68RNXXMOuiCuC7xDpGP
 P7TkTxR6827xEg4franoho5CuUE+IqJqRf6I5tmPdusvQrkFsimDJoeJ9emmei/kkBN36udYgVQ
 ET6fHTnnQt3H0gouWecd6u48NtT1MnQMYwo795ESQk99kk3sAyc8rXCqvIlQrVvYouLa+TYdt0N
 vtPb44MM0WoTOp4fVQLVWnMT9j/Ff2sVbHfPH9iJ/FQsmXox1SDBx077v72VVxCPufHV7IGGZ6b
 dWRgBmevfGtpDjTNTI634C5A4AsQCn/C4qF50Cugj9XZdQ/aCndDfy/UVctSXhJevWzjM/tulq8
 mMM7YzLX6d6KiEZduxw==
X-Authority-Analysis: v=2.4 cv=dbgVTnXe c=1 sm=1 tr=0 ts=6aeff99a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=zEHqqOqeF9Yo6E5rROsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfX7w167nyzi3Ds
 ZkVfhN1E5/Nui++1JpEhPHi6Z8Iuc3dUJdmANAkkSu63XIwL5skuF/VD458bLQCbZc2eld7g/J6
 GrVfIsWBykC3SRNfnQFbXdWOgeNFl7IRHylWSyvjLCi4QU6GuGiy
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11959
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 priorityscore=1501 bulkscore=10 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=10 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080017

bio_iov_iter_get_pages() fails a REQ_ATOMIC bio that doesn't cover the
whole iterator, since an atomic write is submitted as a single bio, and
submitting only part of it would tear the write. In contrast,
bio_iov_iter_bounce_write() doesn't. If a folio allocation fails partway
through, it returns a short bio, which for an atomic write triggers a
WARN_ON_ONCE() in iomap_dio_bio_iter_one().

Make bio_iov_iter_bounce_write() also check that a REQ_ATOMIC bio covers
the whole iterator, and clean up and return -EINVAL if it doesn't.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/bio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index b0fcc69de653..61a3812520a2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1523,6 +1523,16 @@ int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
 		}
 	}
 
+	/*
+	 * An atomic write is submitted as a single bio, so it has to cover
+	 * the whole iterator or it would be torn.
+	 */
+	if ((bio->bi_opf & REQ_ATOMIC) && iov_iter_count(iter)) {
+		iov_iter_revert(iter, total_copied);
+		bio_free_folios(bio);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_bounce_write);

-- 
2.39.5

