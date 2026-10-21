Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562837;
	b=tXzNMkCE81iHX7dVI6+q9F+5iKMbGy360iHij/b5BoJUuRZ2cF71bo298YDjhUdJUNtz
	 Q12JY6vLKcDeA0ouQhzKEU2zdk18GSBCTlrGW0YaqrDjGA2iyYudYYPMssT0F2feq3y7z
	 WhYlvxI4a9mIne+F343TClUUgDcV1UNkMMeQ+ydjuRaRP0iNo+wpHbvTgCdkzwL9eYjPp
	 Q2hsL/6ENUutbkzxVwr01rBogAwJjZoCRdTPbaFGMzgntd8yNYpnVku+hoL5u+UOjp6MB
	 ugoxwx6ickuCQqj9MUcTq+VnfXCkEv3qZsI8gNGqH4xu8wXPhk3MXZI3WH3Gi7GEHWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fKaDERhzPbkXN7Gq1dg6sjNw7qQA/V1PTTySjHjN2d4=;
	b=NdDkAqqlsI2Mp9aTTdI/rEPVXR0vjOZRP89isnFVJWGHq861iqMI2a/Z2XXrFCZX4UP6
	 ZGbOj4D/8sSe2W+hPQBz+5fQ/DU9jzHFywkg/OdTe4ioWwLHlqJgoeoW7iXYGc9tGnhfe
	 pREYoqhZ41daIl7EMCXKm/NJNRL39TDTpH9xYgxxCpQK4uKNdLgV0Y0vjIZ5oR3Dt0KYm
	 wN6fYpcx3Xnsl/EDO6G712pXSZ/yP3bqH/AutDkD+iRfUh6fMdOx9LzsGsPnh0WcNqZD5
	 KhkKgNr5FtN8rK1hpqaWHUEPBNYI5yaVd0H4aRbUny6XXU7/vLpHAxyTFJ/5vRLmRkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gmPsU5A0;
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D560A2610
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 06:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E31D560A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gmPsU5A0
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-327b1d5824fso250184eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 23:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792562836; x=1793167636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKaDERhzPbkXN7Gq1dg6sjNw7qQA/V1PTTySjHjN2d4=;
        b=gmPsU5A0udQnjW1Kk0RVwWRDw1aGaaWBl5groR9VnSYKEnmFFRbNIZ8vk8OI+w/gFs
         OfHFHESQOQRlKcAd5c12KWmNuTupXgcf3tk0YSkkRfW3QmA3o9PFqKyGXdScEmt4AFa+
         P96V452jEG4+bTEN52okYDYh87RDYuEFt9LpDELgL9Nj36iC39moEROlZh8zVw/aXAHe
         NYD2TAKMMoRtnsFsSzTFvpT0OCvuIjJZrywmDeslm0NS15QS4RnQvPhEK+9A4gsONefN
         W25LiRMSXTSOPj5JiPA0VT7+vWNtT8qBdewth11rD/S/3diFP5RwEMIAxCKhnkbnVTSs
         3OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792562836; x=1793167636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKaDERhzPbkXN7Gq1dg6sjNw7qQA/V1PTTySjHjN2d4=;
        b=G3btvVOGFIW4wxHVCkjkmnrgYmJpq2l1vQesm0VRi8LHieXZtWdhERXK48t327Ovwh
         z45Eyv/IzDujy5FFALa/QxwQj7M3xbzzv69YDk4M5iiXdguOnBBy+3HZIkZpennbl8gv
         kXQOTe1zU2CVn1hbFSyNjYuATemoydvte+8vA8N3V2qcMYEmQSYrhS8qh3tqGxo9XwQT
         ZD7PHUp9VsqIyXUD/PyrYCOomwZp00FiSlsoTrXJETD9S92nCay4eaOlSFIoipe8Zy3P
         3RaEoT+U5br+97jkT31CU1yGO0CnuD2Y93daUZAxgU2Auc1nVyN2BYB/WNyvVe3vIBw0
         3/DQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxmbmYxdcCRQMhufDGPSE1KWIG89W2L31/Jq1JEmHEG2y+VFKR8MTBG07AYW2vsJFCQlUuFeer9n2Dy+1k@vger.kernel.org
X-Gm-Message-State: AFq9FYLdlKYJoDSzWyUlbMl/+AZ9Q3oTwjTg7NxVfv1CvWu10YahmOwe
	3iF8QDfPcJC/Oc/UA37foqS1/XFgGEURibcweM8EOCx4P/wWJsluWJ2V
X-Gm-Gg: AYBFou2bSWneHHnqY+ecp7+4b+RNVOXqCFiuVAPVW2zJTZU7yjAAIv1/Xu1m7sq0S7S
	XzCLE2drRZ+0oLef5+Mn82VZWDmMsbT7p9SiIxsrebdno9rJCepxNiGIt9nljndWM1VZFmj8Zzy
	RESWmjFhiA9mCHngghs+27mh2u7hOLY7X++hV6+iPSmud7HiyA2WYSyoBVAaugPrvKLbqoBzyQM
	7kbjLxJVPr2dFybJI3w4obFNrdMuqr9V61+AKJ74MdkcEyx03tUqDj2ueiM3Loz9rbAKVFSF8lc
	Zh19X1OzJ6sJYW+X2ij2FUQfvVL9LNVKbOTz6WEIVt/qCSEQhIomLKpeT/4a+taR1MDkVv7A/eK
	lKeHFSReiOAcp7INu+UTZdcnU3K+oFhiVytQKdxgNMBedJzC7wnEvg6lqM2tWOMS51Wyb2w/BRf
	u9cflBJGX/9mW7eIRfjfbUC7gSfdNdQsmSv35W+roNe4rDqV0sU4jiLfinVoqbfV2f9ejO0ovyW
	ECQ+TkvEuueRFq/lvbNMDfLTu/v7suDGFU7reLzzgdyx2M1RMDOScZWQhXXWQ2fPnTgcPrUbMJ6
	xsv3Ojk=
X-Received: by 2002:a05:701b:2608:b0:144:c127:dd1b with SMTP id a92af1059eb24-190a7f02797mr1363525c88.39.1792562835846;
        Tue, 20 Oct 2026 23:07:15 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm3504720c88.3.2026.10.20.23.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:07:15 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	jack@suse.cz,
	shr@devkernel.io,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] mm/page-writeback: avoid 32-bit overflow in dirty threshold shares
Date: Wed, 21 Oct 2026 06:06:54 +0000
Message-ID: <20261021060654.27855-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ratios used by __wb_calc_thresh() are scaled to parts per million,
but the threshold and ratio operands are unsigned long. On 32-bit
kernels, their multiplication can wrap before the result is assigned
to u64.

For example, with a threshold of 25600 pages and the default maximum
ratio of 1000000, wb_max_thresh becomes 4125 pages instead of 25600.
The shared threshold and minimum share calculations can overflow in
the same way, producing incorrect per-writeback dirty limits.

Use a u64 threshold for the three ratio multiplications and div_u64()
to retain the existing division order and rounding.

Fixes: ae82291e9ca4 ("mm: use part per 1000000 for bdi ratios")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Use a u64 threshold variable instead of repeated casts, as suggested by
  Andrew Morton.

 mm/page-writeback.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eeab25d6ce36..1d6aab8781a5 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -883,6 +883,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 {
 	struct wb_domain *dom = dtc_dom(dtc);
 	struct bdi_writeback *wb = dtc->wb;
+	u64 threshold = thresh;
 	u64 wb_thresh;
 	u64 wb_max_thresh;
 	unsigned long numerator, denominator;
@@ -894,13 +895,14 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
 			      &numerator, &denominator);
 
-	wb_thresh = (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100 * BDI_RATIO_SCALE);
+	wb_thresh = div_u64(threshold * (100 * BDI_RATIO_SCALE - bdi_min_ratio),
+			    100 * BDI_RATIO_SCALE);
 	wb_thresh *= numerator;
 	wb_thresh = div64_ul(wb_thresh, denominator);
 
 	wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
 
-	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
+	wb_thresh += div_u64(threshold * wb_min_ratio, 100 * BDI_RATIO_SCALE);
 
 	/*
 	 * It's very possible that wb_thresh is close to 0 not because the
@@ -916,7 +918,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
 	}
 
-	wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+	wb_max_thresh = div_u64(threshold * wb_max_ratio, 100 * BDI_RATIO_SCALE);
 	if (wb_thresh > wb_max_thresh)
 		wb_thresh = wb_max_thresh;
 
-- 
2.43.0

