Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673F39B497
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788006656; cv=none; b=RL5MzX23Yy3nZmfIlo3b2S96X43bheYnGcxwrJEPprrGpUfmT938YQB4bF3UhY7tKsOK2IiavNBuAyJ0gkSXNkddKnXR2l8+14AA+RDDw/ndfdlcu45FuXc8tal96HChuyW29lAih45bRDq8pFv/E+HiMGYk+CarQCuW/R2+qsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788006656; c=relaxed/simple;
	bh=6RjjuNI82tkMK06bJbjyQ8Ok9HORZ6UIOGcYAghL8bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4c879S/wTdQ19rJzBbdzTFhef7K4CnySJ4mm+b7fzERCO6MGr+XAbQRjYk+rCu430hzIXNLRh0vG+8yMYBdUp2OLLuChQ9jPguaws/kvmjc9sCJhZ85r0aCCJ/MoC2QLlhLyVbGJBsP3lHJ2fFBiZNo5HeK9FCN/SNYVXrvO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQdpWwAO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQdpWwAO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d5cad1a6baso17792145ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788006653; x=1788611453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5fr4WGpkpz0g/RZv8ki2EXdEf5V5M5mLF4YRCrDVH0E=;
        b=qQdpWwAOXRHS31fgC+659gwIcv/HZBfqTWI4ryxqZlBXDxkEkCkM31EqBIUHfivnVB
         /0JCVMi7c8x4mT8nRlQJmPGosrvsw42EEQrQS0cKO771G2kK4l1s+mYYLscbytnSoPYw
         VY/+Sb3RXUNF0pPy7ATHkzuZRqn/wJlAoD81J2hqBg/THh5hCB+5ZGFwsjy0SX1lm/kq
         UkRmVf2PE8cDvmOC9jTVSxijeNdunsLxwCLnXCBOGwxDI8R//IHkYeJ0s476N341S2ap
         i6ZkBwK5FZmJESceDlI/lH4DFIP2HZ1tMZlohuJ/8AE5zLypjy2kQ34l2Yi6iC7+FNVp
         yvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788006653; x=1788611453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fr4WGpkpz0g/RZv8ki2EXdEf5V5M5mLF4YRCrDVH0E=;
        b=rx96/pIg88eCoN2aPprofnqwx5nNZKcSeMLmOZfnQrQLwagV3Q4Cel199KI/roEo9z
         L0SVXY4KgphfRWyJsAimnllh7SzVZAfGW8TwTeViUMneCHlO6uaDHdLFnCNgNc69sNWR
         GC7Z+czdvEyZC8AfuzxmJr5axEk446OfxyFmC5OOhTAqCKoX/OqDQe7VjZsf2LBU0Gu2
         0yCnr/zkk9c6U6BFaRTlwP6Yu+f1lDydJYReQQCssYgtqM5VEDEPN6IuLASfbwRowlOG
         wKjtwD3HMGeflzjHJhzkg7GUC2crLkBcIGiKLHaZB7TdpO3mPT9sVH55S7UaPhEHqBsA
         ldyQ==
X-Gm-Message-State: AFuF++mPapkWJitU9mD/NhvSLpMMax9R8N3hCP7WJttZzzRxfc3q1HAT
	MDbeDZobVBUotsrZkYN0RXM+kEooyY56+tgkibejkG/RLb9cAJBghTlq
X-Gm-Gg: AYBFou3YiN9HWxM5mbHrFBWAHb4gC70l8HH9oHryrjJNes5zbJRF8nz8EMhzG9/BJow
	LSdfdYYusMjIL6qJozjJ3bkJ4ShMGCt457LcUgsCP/twJsQ5Nm3f1epiGfuYU9YgIhbPtIeJVTd
	J38ogQOkoMKwtLq6MBhVs07wgsRS3FDUZaUtJNvbMXBk5CLqewYbttycKQ3GNldBXCASR69OAEf
	WLtvGBE9xX0pF02XLP7Um1d/+WyKtV+BP1SdruK7zoqjG4tWAQEuOQFcZghWECVkiAs1LnGF99o
	fb9G5xrt6V4xfH39p9m6Gn9ox4O+kvP+hHPBiwJ8+r8TPan9NJJGeZxuVWcJrOQeDXgzDiOCDdT
	pwXlGCN+TF3Nihl9GtcBAAKLsbw++C+p+LujiQ4Pb+3nW0o3t9wAoOu417zleoJDJXYGqDK7Lkn
	KOzaEAWy7IW9GbCMOnCVbHpj9sDYqJneTKxiIqXI3vwsedRw0TPk7+Wln0uyyi83a4zAbrXklE0
	nvRBm26Rbdfnbi20qaANg==
X-Received: by 2002:a17:90b:50cf:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-396d0ed78e5mr24088912a91.8.1788006652964;
        Sat, 29 Aug 2026 05:30:52 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-398b18b4074sm2596059a91.12.2026.08.29.05.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 05:30:52 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baohua@kernel.org,
	axboe@kernel.dk,
	trond.myklebust@hammerspace.com,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v2] mm: filemap: retain mapped dropbehind folios
Date: Sat, 29 Aug 2026 20:30:47 +0800
Message-ID: <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qiwenjie@xiaomi.com>

Fault-around can map ready dropbehind folios without going through the
normal page-cache lookup that clears dropbehind. A mapping represents a
competing cached user, so retain the folio instead of forcibly unmapping it
when writeback completes.

Unmapped dropbehind folios continue through the existing invalidation path.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v1:
- Retain mapped folios instead of adding a stricter context predicate.
- Remove the private helper and RCU include.

 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6afec636881f..00fd89cf6f55 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1616,7 +1616,7 @@ static void filemap_end_dropbehind(struct folio *folio)
 		return;
 	if (!folio_test_clear_dropbehind(folio))
 		return;
-	if (mapping)
+	if (mapping && !folio_mapped(folio))
 		folio_unmap_invalidate(mapping, folio, 0);
 }
 
-- 
2.43.0

