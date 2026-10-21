Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546586;
	b=VnR5wyanVLFnLWQJMTb1M/FBho2fJcgii/QHOHpBhLsUDKUUsBnJN3/VlSsOiA5mlyvb
	 WPkrurEVmJcUNTjE93snbKv2vQXxJ1Hcp6qCM+s3Hzo/b9dIzl6wX61R3SLRqxfio9qUM
	 Y+7P2bgJ9i6OwjECElB1ZBqqJT36cwtkp5lKkOuIpDe2atnlE1SfhjdiObRzFaF9OYQKO
	 UAGM7b7Fs2ZGYKZg4lJ7ayVSZmtnuQSDzHd/3hbVy4ZsGk5ery66CuCV4Y3btej9GHbSG
	 s0N5iqYHg4en8q7pz19PsGA+J64TyRCU8GwKOodFOtoEtUN1T1sKMI7SgbggoYZpzrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ax/MKBRp76FWn3h/ZPK32Hkl8AkiS00UsCUGIQD4n0E=;
	b=gpTCPAarr1otvF58oHXiC9ilosSjQELi51NQNxfDBQgg+36mN2cWnYIyiGmW+mpnRuIw
	 9LsVN+83wUzps/Ag7G+d5m+Rr7uvVHKnn8MGAtEh2ZK4jjKV3EHcWYd7t0nuDzJZsiKNH
	 ZGHvJSsatgcPmJ5APuFL0/YHhMp37t28MG9zuUxoGqWc8L45UI0kA9KKYBQZ6vxBGPi0R
	 2FWvLAYHbSI/Odu+SOnjdaVupMYq1LhWt1KOaVGwFt6fUSA7UTmy3XgOMnOQQPknjEPO/
	 SJsMwHKky1ltlStM76p3mLcBquE8W3d6FKuflrNpZvhfLd4P02FK6oRyPVWxMcGwD8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ou9lYyav;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4A606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 01:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53B4A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ou9lYyav
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35dc2af1f2fso63032eec.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 18:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792546584; x=1793151384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ax/MKBRp76FWn3h/ZPK32Hkl8AkiS00UsCUGIQD4n0E=;
        b=Ou9lYyavZBg15vkdakrlmd0FU6/TQ0XKtiphUaKiLjVJYw8DX8HQImOgtJvkvpTOFb
         WrnHn2nCKay6lGUOfRAdPwEAHJWLdLJG10TmCjutc6vj/n2K6rYmYf3gbMDYQL6NkTHj
         tadho/B+QJqjY+k9jtTed01CVh9zhA4pQ2pD4Ho/MFmefusfa7rW/mkoBCVyrf7v8ujI
         snd+7YP2pY2HzTs+NNNVUEhJiTCChcsXo1HsgiAqwgbMv7OlzIM8tZtdE53/jRMFyLE/
         MRiglMdmSTh946wRJh+jcnwyBg+XLDpzVPydwo830LEZsNUt8XIh8wLm8kKXpXPkityE
         4UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792546584; x=1793151384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ax/MKBRp76FWn3h/ZPK32Hkl8AkiS00UsCUGIQD4n0E=;
        b=MEkr62215p3vbH5yDySMaIyWOBQ83Q18J9TQJXW3L4OiRVMy0FlC22VofJTbUbCmdP
         P3cFB7OrWwAWm2Aw6GyuAGfQ1enIg8sJ3UkSWj/YHPtecw2huvSwwyMSSdn7rgXLFlQg
         tcPdg+CAPVkkDZ3rvP821skJFsZjgF+YpsnYCqnp9KZai3nID2KfuhcAVcEFPkkBrwes
         YYnojqJ5KN3qTG23B4Ni7QkZdjmlko0wlCwa7SU0JQHq40b004ZBsvMzkd1oSbHb0h4F
         VX7MQPHWMDViaY660oQ9W6kpBjLJfQ1n/0bghJEGq80kIBeYh9n8LczIoL782uB/EmaR
         FkFA==
X-Forwarded-Encrypted: i=1; AKwUvBzn6Q2O87jM/vMHXyyMs3YgnQTLuwq9pz40rDeRa2GxcfelQrPYAmy8Jy+B5SqxWdRAfVQtIpoXUHC3G5X+@vger.kernel.org
X-Gm-Message-State: AFq9FYJJ5fJ2W/RutB8ytfB2SZAQN+aGKZH7za731XRmXR+wS3EOoSqC
	fiH4vkz4rB6mCxNC1+paO45xEDGIUC0QSRTKMQaK9JHGlPiD9dzrFoVM
X-Gm-Gg: AYBFou012SMM+yp9VmbCLLVaipJTUGOecQg1fuZm3dWbIhjd4T7KUBB4zztl7tcD2oE
	R0D+uKPeFTfv5reVVoPka3wOHp3LUZVm/RrEn7d/GJ9UXO1LpcAPTGkRrAGqwnr3OBM0+cS72pu
	4hoEWRIs3Pxf1GRV5UgRzhrekcI3r4BEnsDk6oVxw733cJr+bQeysqiWZWfn8rwtMxiDV9BNT+R
	/z/Q0rPGsm2QkK4U/vtLgCPPw9iNC4lCxOWBRymnwFZYZHsRB3vhPUo6QB1ID38e9K38f4czkOC
	Zr0ueMKwLlcYykQMYt3q400ak3K7yMx55N4RJ8lTX0DaOPGJmXk2r/WsXWqzSKoqeFH4wuq2yzW
	h/Ws62X9snre9IJX6IofNcSr9ZzDIjkNdZ2ozUjaTXX9huw37k5oShR08LARA/n3t7o/ZzHdbZO
	OCzL8txCk7r5bLj24V1liFBKl3SjipBj3kyooRSawp27mHeAZ0I0VdBXizwXMHx6NORW2gnng3e
	btG5WxyCqFcxkwyfF+p+pSdgWOGPc1vWTPkMdUPMySvx6ydNXu68OFNJEm01dMTDaR2x5TEi3SL
	fLZIQA8=
X-Received: by 2002:a05:7023:a8b:b0:143:72b1:9004 with SMTP id a92af1059eb24-190a87a3b70mr819537c88.45.1792546584157;
        Tue, 20 Oct 2026 18:36:24 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm2991870c88.5.2026.10.20.18.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:36:23 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: willy@infradead.org,
	jack@suse.cz
Cc: akpm@linux-foundation.org,
	shr@devkernel.io,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] mm/page-writeback: avoid 32-bit overflow in dirty threshold shares
Date: Wed, 21 Oct 2026 01:30:46 +0000
Message-ID: <20261021013046.23997-1-dennylin0707@gmail.com>
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

Promote the threshold before each ratio multiplication and use
div_u64() to retain the existing division order and rounding.

Fixes: ae82291e9ca4 ("mm: use part per 1000000 for bdi ratios")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 mm/page-writeback.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eeab25d6ce36..451750df8b74 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -894,13 +894,14 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
 			      &numerator, &denominator);
 
-	wb_thresh = (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100 * BDI_RATIO_SCALE);
+	wb_thresh = div_u64((u64)thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio),
+			    100 * BDI_RATIO_SCALE);
 	wb_thresh *= numerator;
 	wb_thresh = div64_ul(wb_thresh, denominator);
 
 	wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
 
-	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
+	wb_thresh += div_u64((u64)thresh * wb_min_ratio, 100 * BDI_RATIO_SCALE);
 
 	/*
 	 * It's very possible that wb_thresh is close to 0 not because the
@@ -916,7 +917,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
 	}
 
-	wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+	wb_max_thresh = div_u64((u64)thresh * wb_max_ratio, 100 * BDI_RATIO_SCALE);
 	if (wb_thresh > wb_max_thresh)
 		wb_thresh = wb_max_thresh;
 
-- 
2.43.0

