Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734902;
	b=V+D4DLL9fhp5NPqegMHgf7ExuoHZqdjl3Dg7fU1k3/eyBKDOki7XBMyi+dba5awBd0lj
	 CIhzMZzJiLdR7WoX+mE/7iZCj5MzPNL07jln0ODHPWfkNqrHlydvhJNZ9JXhAFhJCQOHN
	 kNYg/E1vHYgdEgQoIFQSdVVU0stfFY7qt5eT/SlXP8Toixl1lZdHWelz+loNil5mdB1ZF
	 PpL+ZK6GSx7Tu/vjYlQ5r6+fm6F3bQqLsxOxtBuypJFrpwb7f9LWquVmJA1Oyskz9oVgf
	 xeEj5fUm+UbhWled+9JDEQiU80PqbF8H/ijtdEJY1Im/z81CibIpv57XnyLu4Bhz3HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xezF0fn8IDQBSoJVFqpD27Lisy+bsjzUf+Sl1jGurIk=;
	b=DrZ4s83wisqC24sNEtQPslbZf3dR0oSrGkNl6jBi4Xf/pYErwWBgftW7z/ZbVqJSJ5iD
	 s5T+tIijERuJa5RciP/afb6p2T9OzoBh3j3Bv/umY3aKiVcIKEkczj0vnUsOJARDRCCoS
	 xhGSTlwWpOOWxDCFYwUBaoqif6In5k21woPmtlrAvPlYecKvK3T25Ix4on9eoMSLBghdU
	 An8+6wUD87yX9BpFjISg2IKKI0/nHHXAsuGa0YmKCwV8e7j8pUExD14qoAqaE9AirJ72M
	 a4B+vNe1eTisiHs+mdIn74sC3pD+EIdv9HtjO0JbrB53brGb3H+0H6e2NkMbFlA9jPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8nbt7Kg;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB922606A31B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 19:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB922606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8nbt7Kg
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-3537f63c9e6so1797375eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 11:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793734901; x=1794339701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xezF0fn8IDQBSoJVFqpD27Lisy+bsjzUf+Sl1jGurIk=;
        b=o8nbt7Kg4VLEAVGwOT3wfSMSaYrtKlxDWnrkTwbt16DwdSREle9viHmSI61W/yEHJ4
         wva+9xyktj9klqdIbCed9fiX6W7X7j/t7YVxMeY6blmFgg0dRRsLH3CXgoLCjViBVCvK
         X83Onfo09mrcdfTkHUvwXHM6eatj+m3dnpxW0im2hhcdKyfMpPrgjUo6M90Rar18p08m
         Le0mXuEgSmxASxlHveGZJPhCbZj9yZiZy0Q4BHJimV0PSg0T9IKX23jNfIcjM6S8iOVt
         fm0MfMcu5JTlvEr2l1dq2um8Msr7j/k0coAHQqT5pZBz0PGK71L6Za9Ewd2oCBlKkTuj
         upOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734901; x=1794339701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xezF0fn8IDQBSoJVFqpD27Lisy+bsjzUf+Sl1jGurIk=;
        b=pNIRAMwkKPH/wL1W6f7Uf3MkSyRP4wYLCeO5ATAWu1XlA+z2+LcP/CZkU/9sTUH6dz
         vUhRqJBfiWmSjK3iECYSQqAFyiuYyuqvK1aoZsLClDGuFB/26OQkHFsYgw3vsh2dxeVf
         a38dZqrRkZUTojSAvP3ydqwTYc2IL7ffUQRACKg61B6dcpiCSecSp3C2VqMc5+H7wdac
         w+J3v1riip37+hZdX8pF/MBW/qCMK9PtiwE8zbLVP77EKBBXqyPexNebfmEI85yNJexz
         cFlVwGzKdzA8pfnKc2KXZDsxgH6JYeu9pvBR8V6bBAa+EDO7AFkJJGx7ErNhfrksVyLr
         WTiA==
X-Forwarded-Encrypted: i=1; AKwUvBwJrg857kDn7A7gc1zlQKov0brnxAOk2GsKrMKGUz21wpb0cFooDnkHDV6yVDTO25eaNP0K4UrMv8Ns2b7A@vger.kernel.org
X-Gm-Message-State: APuU4Z9grHPOsU1DEqgpEcSHug55LlUaeKsPJJ0uyNMYC/GgKERuz3/H
	feCASHJBuIqFcoVzHqT/QEcuPcnRyd/QiLBrBO3wlgEYHrmXJ9WAz/bF
X-Gm-Gg: AYBFou3t3m4IwSoSe8H/dZpkY3LlAAwhxRtGqm4jLHQUNegFlQrs6wjAKIHkJVcfSPA
	0zoeUljgzF6hEAsZFpn3ASs06BmgtWy7xfJieHvui6UPNCo9aMuSZZgtTu3rvpYgNnJOCUge0kt
	GaYc8q5F5zfQKfCpB3IJX2NAP/6da39VXqBtJgoFiFb6yyOUngKvKMFcpM8DPP7JfnMRDftwqOy
	gjxitVCKHK0T+o+/mzjUyYs1ysBVVjVZKUjxyhoAPi6Ih9zTOhmW+IjRhtZo7cawx9F8pWUkdy5
	X3qYnErwuwQhrARjj6ENFG7Bgb87ILMXXV1je0VjQMBGKaBtJweAFHDpjZCYwCt6QSqntmWZWbv
	L+IrqZaZmnOsyW+8L+2FAWiNT+nN2i1zbgrdA+8gSObtsWept9L8bBbLHymS8tMSp9YEIOA3/0l
	rHx/14EDp3AdPcFO2JM603wgKZgq1J7hCaR5ige0WrxPGjz7OAz1yfYutm9kIMrxYOxBRWpYXOA
	RnGwvVlH48jQ5nqPDYyDxBhxWypO5GNYxwFJMPQnW8WsdueK09Ay+/smK+O2GemCk6F2/cVtg/n
	WNvCTYzeZavJq5MWCAM1fBDM3pptVvO1YkUmmrZXFu91VEpCpyCWA0Q/
X-Received: by 2002:a05:7022:1402:b0:193:9568:b42a with SMTP id a92af1059eb24-1ac5c45fd35mr19813397c88.8.1793734901021;
        Tue, 03 Nov 2026 11:41:41 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a54ccsm304564eec.4.2026.11.03.11.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:41:40 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	jack@suse.cz,
	shr@devkernel.io,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] mm/page-writeback: avoid overflow when reporting BDI byte limits
Date: Tue,  3 Nov 2026 19:36:26 +0000
Message-ID: <20261103193627.71959-1-dennylin0707@gmail.com>
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

bdi_get_bytes() multiplies unsigned long operands before assigning the
result to u64. On 32-bit kernels, the intermediate product wraps and
min_bytes and max_bytes report incorrect limits. For example, with
vm.dirty_bytes set to 104857600 and max_ratio set to 100, max_bytes
reports 268 instead of 104857600.

Convert the page count to bytes in u64 and use mul_u64_u32_div() to avoid
overflow in the subsequent multiplication. This also handles large dirty
limits on systems with larger pages. Combining the two divisions keeps
the existing rounding behavior.

Fixes: 00df7d51263b ("mm: add bdi_get_max_bytes() function")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 mm/page-writeback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 499a35473e4f..ddebec79d8d9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -665,7 +665,8 @@ static u64 bdi_get_bytes(unsigned int ratio)
 	u64 bytes;
 
 	global_dirty_limits(&background_thresh, &dirty_thresh);
-	bytes = (dirty_thresh * PAGE_SIZE * ratio) / BDI_RATIO_SCALE / 100;
+	bytes = mul_u64_u32_div((u64)dirty_thresh << PAGE_SHIFT, ratio,
+				100 * BDI_RATIO_SCALE);
 
 	return bytes;
 }
-- 
2.43.0

