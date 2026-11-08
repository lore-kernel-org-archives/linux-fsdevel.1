Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794111900;
	b=okoU1cc9MHuNCOQENhqHhB8j8fSjvwhbvXX9S8m2LqGFyT6cTnph2GY7EnhESu3eWjU9
	 GmEX+/Rj4tkEtxJvWQw5nT8EGQQVb1wjPqTp0m/RoJ5E61UAv9RJfF8sJiRgvzn2Q8/YU
	 km5uhOLY9w9ia+rvgCVOQzUbaTy5ftpZ+86f4Iv97z3Q5Pg3WUzD8lT9NK6ddfEirnOcg
	 snNC3vPgkkVImqZLcKoqP2+sLso+m/6iJa4Px2lJtNlnB+6pO0jHSofzsyUkK6QiGOfrz
	 wk/vQh5i9XhcuvdnpJVe86aOwT5tT/mtNin61iRhRG5sEVTAZY2toS/weHZNzZv5GqA==
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
	bh=KZJMLmuXX9sJhrtyIz3QqrKY753KM/thMo2GKlgX/ZY=;
	b=xs29H46YRfz6Aa8DgR0fVLuiCWkDnlkCStHxQuZlfSvY8B2zAbJ24rJgM0Vn87h3iM3+
	 pzEH1H2AFAkcnlmytgOvkvW1k/mVibOqZETPCn8Y80xwu32leyRYw9K2fV+3flOM3DlUz
	 AFvr5N9Vui0pzYRG4OFTF6Tplw+CHNQJrAEkhyPNGS2tGKSmFU2TFJ/nlEvEUUxuionlx
	 I9ENciYV40lb8bUl7+jVRcO2wRmWoz8S5n2Luq7vI9cKymXWWQYIm4jUUwWC3IzoOiHbO
	 9Ems5ocrmFdFlBwEn8hXsFxwHdHXhTezk46EAgMaq0IV/ERDQMJW+6a/Wxkkr5uCGkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=QTlZKnSq;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ii601FQr;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9440606A339
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 04:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9440606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=QTlZKnSq;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ii601FQr
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A83dpTt1884730
	for <linux-fsdevel@vger.kernel.org>; Sat, 7 Nov 2026 23:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=KZJM
	LmuXX9sJhrtyIz3QqrKY753KM/thMo2GKlgX/ZY=; b=QTlZKnSqJMb+trqFGS6U
	AZ7w/DFE0vw9ltjPsMynYi1Q6FrW8Wk5UVmjUTI3JPX0b00cd58UJ5A/0KHMBDYX
	nS7qmIwJA8+eZCe73U2OMUC6VdJHJWMI2dAh3ISkk1IocjjsNwDi54rXFvac97Rb
	FDXnK/gJ5FJIzupP/v7mHqfwRDVXcvE0JakFvXDoWDmM/pmvV/ic7IO3Xq5PyyeQ
	BfPe9Yecxap6gs5+hzDJIiMufH1TNCHF9meVL3X3n871YusaivyUhy/e71tGi/PM
	Y0Jm8LAvs4p/gPZrWroGX6jp2nueUC5J5uPipq2EVvj129G0C++goEgyLu5RM/3V
	Bg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hsxev48et-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 23:24:58 -0500 (EST)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91eacf20364so2967966d6.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 20:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794111898; x=1794716698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZJMLmuXX9sJhrtyIz3QqrKY753KM/thMo2GKlgX/ZY=;
        b=ii601FQr7cfN6jCjSyEFGn7xpVfcpuK8gVH5oYBBcOx+tZH1NLMzB3WxGcC42516LV
         sW2/JO9v4jtqVdGUWAPF9Tp6X70eWK+L3P8F8f6Pm/X694jF1q9hCJHZoXqoBXu9cjAX
         lhXA88TJLN95Dd/HRs5G2jPykW/rRCR2QLdhlZ6MxxB0TV40zivfMhQfXbMYMfXKGCOI
         OMMD0gDKPyzFPyxjBnal/4/0KBar1smOlan7iAzSOU1GdkC9u30TvuifluJapWsdxJ0u
         PVU/Z6yi2PDPSD9qXXcYIQRxatJweYei9mS1XimdS0kCU60d4wGkbRfS1TiHZFzIVBYE
         PKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794111898; x=1794716698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KZJMLmuXX9sJhrtyIz3QqrKY753KM/thMo2GKlgX/ZY=;
        b=lnHKrd/nQe7ErAO+T3hR/k2CUxk7YS6xJmhdgpQUkQv4b5V70jY9y22p/DvBBbWTe9
         535dnQDqKsNjsS1ts0lo5B32TAdaRmLKXNNkVHufcJ3PCxywk8nUN4eMtCCoA1h94Jen
         4o/w9Q3R6zM41j8qKAk5a7eQIDO7tIN9mINj7YgWwby6c+CAuJwOU1EoHex/Xo/vR/b4
         G97DsoES2o0tTU6GJkAE1PYCrRNzfDngE/VQiP+AhKQ7mkLq1QtfkUlTxuy1XKvA4E2p
         kag1QuEgnpkGI14rMBoREQbIV4z+J8l2xnx8AGrd/uMN3rL1MTJUHzf2O15ImWl7b+Zc
         zWWA==
X-Forwarded-Encrypted: i=1; AL+hErFljrTdmT05pA1npOY2ZQE7nsChOkLObmoAOVnqmSRgmrhGWY5Exx+v9CGLYF4XoB+sT6IxKlfQSsICgZZo@vger.kernel.org
X-Gm-Message-State: APuU4Z+VYCGPAeme2ftT5WQ+c52BAzBruZu4zUfKF4vGMjrhsyt68Zmd
	Mi+dlLJQlvL5ZBZybNM+yXwkf0I5xj+FLAIvU8a/fXH2EIes4kUBwnxIW71ouXzLaDWAbi2Tu3/
	2AD1XM73kfy2LoLZK7ODx1XKR/f8BD2KPo+ctdgBpHpHv2oKB2rue/Pjk3KpgK1w=
X-Gm-Gg: AYBFou34bL2oGf2ZRUZJRwJtrOV8n8p7Zc2aAE9nvyyD88vmBPKOTFwhTKwF3w+Qiuj
	psSa30B3wSGfSJftR3HznSFZtJ1eJ1YqiI2qZR5HTA1U13Y3A58sCEPemYBNWvoHPu8ZPdKlguK
	sVrhhjVBTn6bdWz3GYTrO+ynslFZlQIfEAAkvMy053D11jyLcom0pzTTH4ii8X2qt/DXKMy/KZQ
	gvEH3B3CdL7DFoaW+YGN6Lij73JPX9lP5gSeFkg3Q8kTLG1arjhS4Rmo12AxpQ6w/NeW6V31Ufi
	spslt5RlhG9HzPzjE4NZbViSJM8/NaTmAR5wXty16E7kyRvwQJVqXdr5RAx42vIjDHj3YkDMXG+
	Wap0PZH+GFZMwCas7Vh6GISfUfGCKGgMXurl2gSQ1/S0maOCZkOcjgfvSymjXohYuHmVtql6Anx
	1MT/vIDo+4zXqd+jTuBg==
X-Received: by 2002:a05:6214:f2b:b0:917:aa8e:474f with SMTP id 6a1803df08f44-91ed241d308mr5684276d6.23.1794111898124;
        Sat, 07 Nov 2026 20:24:58 -0800 (PST)
X-Received: by 2002:a05:6214:f2b:b0:917:aa8e:474f with SMTP id 6a1803df08f44-91ed241d308mr5684156d6.23.1794111897712;
        Sat, 07 Nov 2026 20:24:57 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eceb56290sm10085586d6.1.2026.11.07.20.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 20:24:57 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 07 Nov 2026 23:24:36 -0500
Subject: [PATCH 2/2] iomap: remove the atomic write length check in
 iomap_dio_bio_iter_one()
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
Message-Id: <20261107-blkdev-atomic-bounce-v1-2-f66344262096@columbia.edu>
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
In-Reply-To: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
Cc: John Garry <john.garry@linux.dev>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794111894; l=1480;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=raAZDoGoyOUdBE+OG2rr/mS13qUOspHTisqUqAlpy7c=;
 b=CLzcS9Tl3wtyGtCIhcgXJGXi+GUmlZBXZqeULwvnGRqHuLjZlROfZcK+k64yvGX7pHkOtdT0O
 kJ+c0z9sJP4BJNuptANA537ABkv5+MZNClcxLmCZoYiCbzo1pJK+689
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 8z9P_cGTK9nrFfzPvO9ktIPo388ipDcH
X-Proofpoint-ORIG-GUID: 8z9P_cGTK9nrFfzPvO9ktIPo388ipDcH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfX3PbwgOABTiIM
 xXP2pwr/JpQEMW7bW9CCUNRRKYpOWAS1zw14XL04G4U5TZeiqIrLhgVZ3p+89xu16wTh4+sHe7/
 XH5oWmiVmoNR/9Mb4p5vW0ImmUnTdEY3qi8FIfK48u9sl9mNzzWlV/2GiwSxpwBhHZ1qfLVIGVT
 r9Hq+UIH6gAdIsOTHJGL1mPbV/1l1ML669Yu5HveMoapfwSa8LCtx1x/UaR996j+qWAWavHs7At
 AY92ibk/ZFNAxc3b9P0ITO5NyGi7msew25Y/KTLldDioH7gZ6g/imnynSxQoi9oKWmToen8phLt
 H/AczkaFf0DcwxqV9/b0Mw3VSRVSMJ10mtQYhYxKEvrHwSXTPMOahv1FHukyupZQ4WrGuyI/Lpi
 E8/xXmKrzBiBITe1jb8T7QVgpkPBJCtfpD3u2RPkAvLg1UAUmBkWGbOJyndflorHA91M4ZVAnqe
 N7Oar3qHz0YLbWFQPVw==
X-Authority-Analysis: v=2.4 cv=BIYmP1QG c=1 sm=1 tr=0 ts=6aeff99a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=I7NSszDGB1yI4--CJuAA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfX/ArC6+j5jYfs
 4TYj9k4C0raMGxyFM0iUlrr4u5om08DudhxgqfdK4qjncZ1QoRf5/MfZ4rlE9JYTS9NfkTw9A38
 TiPJZmgBXoTZcro+56Zl0iZZteu76gn8ChVKHl7gtXzgY1N4joue
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11959
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=10 priorityscore=1501 bulkscore=10 malwarescore=0
 clxscore=1015 lowpriorityscore=10 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080017

bio_iov_iter_get_pages() and bio_iov_iter_bounce_write() now fail a
REQ_ATOMIC bio that doesn't cover the whole iterator, so the bio here
always covers iomap_length() and the check can't trigger. Remove the
check.

Suggested-by: John Garry <john.garry@linux.dev>
Link: https://lore.kernel.org/all/82978d5c-3e08-48e9-bf0a-7913e1cd0507@linux.dev/
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/iomap/direct-io.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ad041ac3252a..aca7cbaea4af 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -370,15 +370,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 		goto out_put_bio;
 	ret = bio->bi_iter.bi_size;
 
-	/*
-	 * An atomic write bio must cover the complete length.  If it doesn't,
-	 * error out.
-	 */
-	if ((op & REQ_ATOMIC) && WARN_ON_ONCE(ret != iomap_length(iter))) {
-		ret = -EINVAL;
-		goto out_bio_release_pages;
-	}
-
 	if (dio->flags & IOMAP_DIO_WRITE)
 		task_io_account_write(ret);
 	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
@@ -393,11 +384,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 	return ret;
 
-out_bio_release_pages:
-	if (dio->flags & IOMAP_DIO_BOUNCE)
-		bio_free_folios(bio);
-	else
-		bio_release_pages(bio, false);
 out_put_bio:
 	bio_put(bio);
 	return ret;

-- 
2.39.5

