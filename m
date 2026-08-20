Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102B6455171
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236208; cv=none; b=VvJJqwoyljA5pJkdhhHbCov4UeDOlbiBCfwu6qEyPVREJ0nTjK0ouk71VvYd8wEHzdDheeEiSDXxvFatrQw3Sd4/+W3onr/3sm64ayiFMEAW1D6bi+lHy2C9ZxlV+eOctLrXyy60ri/+YfWGO1ZDxCI8pyNghsFDgi7priY36rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236208; c=relaxed/simple;
	bh=3Ycqs740UmpuwtFIi1z1jCcBP48DTkncFAGT3S8Vglo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riDzXEwyoK4zs/5rM0yUIOf+yhGD/GKH0vI0NaWULSXCsJoLroVwjKl4QDgF+sxEVRGqu/76nowaR+mDS64oBTFJwbUukr+Aweu1PK90YwHbTC6FTXK5UUJRKXhujXfZ1q724RATff+wvz/P+ICbOukcUGyUVigH6icyXJTlGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pP1GQ6bl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP1GQ6bl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2818840a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787236205; x=1787841005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwOwRzT4HLDPVaiVOwZWwo/iTTnMhyol3+iVtiyVzuY=;
        b=pP1GQ6bl+qD+9cn9z8I/W3YWIGkiewJlC59EbyEk0I7GCfgrBYr8GFRUlK9c2Kce3s
         B7o1FyqsO8csy1ocEk9r8nHJOBDxnZUzGEIb6GhBYGWhdHurX7MfMdrc/na2nKo/pLLQ
         TTOHhoDhfkH4TEnPAxoK5ckRVXLo1SGQSeSIm53vGsUF49h+aNbBtjPRkD6VtkdUMxC2
         5DzYUu6RYDTKCppu2b1VXUCab5ZvCr4WqjCf+HbYu9Ofo5nXTvjYMgLaoMWUSHkSDSm4
         zx0au0JkKSMGaXEmrxS3+ooJpwZyB5Q3FcABjrFxMnEOCeYeiUPxrRvdgBCi3maTXL28
         bpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236205; x=1787841005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwOwRzT4HLDPVaiVOwZWwo/iTTnMhyol3+iVtiyVzuY=;
        b=s9yKUEc8p7Q8xmW/lZTigSCrLbDFjOuJYZnyp7Zo+6+pLY5n5wdRmi6dy+h/FkWBPx
         t7ALB0ryjBvonAiSzmZ4qT1HyN+iFxLmHrO432UECLTcraKRwuAmJGyWgbMwfN6nKWWN
         yVXHZfJgsNQPJv3KVmSsPikujdrVfJ5gQeUnJEH3R71COPN1UZq783Dzv2A8kdPZ3dRR
         ULWOIkynM1mIxDPv98aj3xN0153Q7ggA+S5ric7R3tjy+ovTV+rQVGcXNEz2fnTAtgpN
         uIvRTzOE8abcnXA0REpktPbjFmMAb81brA7olMDyviVQm9RCdnycOMEf8nC8TcAE0oZm
         B/bw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8z/NWw+nfN1JBnrT+ZL8zDiZmD2ZxcA2RgtQGFxZGQmBZpZlZ9+z8HDS5SrZENuO7+IeUCpIVv+WoxHF7@vger.kernel.org
X-Gm-Message-State: AFuF++m0xOHB526ZDls0QMCSszkIALWnVt119jI9ppjT/TAD2fNvvLO/
	evaD46QifxsIqHIwzDp7fanKoGhPlFQu3Tz+t8bDyFG2qqgmZc7iq/SW
X-Gm-Gg: AR+sD117wJaVSSfLw0LANYRTSilWMwqRIHb8XVBxKq3jsyVO2jxKrULUEpBFNRPEjEI
	+praKqca8ComwOdxiAo5PlFrB1BkS2nsFxtp1sZLcQxKBFD2qSpqAqQ6BmfO9NCPprLqoG7NvfN
	EyAcxLg8U5rDMNOAvSdi33F44eF3OXm76ecz7Xdw2I1shd/m5S6FTtq7xNcD6vbF7H2+srzf+h6
	6D0r9zOCpYdoSSSoo8yFzECWdZ1DZNUa9TsCqu7PXnJEF/OttCYqFiaBzRWc0WOzgBQea/o4zkP
	EZQ5GkQj2Ezbv0EPVviM8LnIKvHzwZXYJVh862d1gfpHh6SPHetBbE4MZx6u4vOXs5RE+l35+Zf
	hizBIPJFhNfj1IRqDhcGeJweGmotJ7zL9avu/CuhTTmQEimzAHBguL0jDREmBEGE6jkzSsNWO+j
	JC49MZRI0Rbdni2HiUNPYvs76wyjLL2/t7g6V8k2zUOQ/FayklxdoYaCBHm35BtxSLwxRD+hU64
	A3ZBUTtAJqupstQxhdGu6rKYA==
X-Received: by 2002:a17:90b:2b8e:b0:38e:75f3:ad4d with SMTP id 98e67ed59e1d1-39580f03c97mr25649224a91.7.1787236205247;
        Thu, 20 Aug 2026 07:30:05 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395a9bc47ffsm1036780a91.0.2026.08.20.07.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:30:04 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baohua@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>
Subject: [PATCH] mm: filemap: tighten dropbehind completion context check
Date: Thu, 20 Aug 2026 22:29:56 +0800
Message-ID: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

folio_end_dropbehind() uses in_task() to keep folio invalidation out of
interrupt context. Task context alone is not sufficient: preemption can
still be disabled, or the task can be in a preemptible RCU read-side
critical section, while filemap_end_dropbehind() may reach
folio_unmap_invalidate() and sleep.

Use the established conservative three-part atomic-context test: reject
preemptible RCU read-side sections, reject configurations without
PREEMPT_COUNT, and otherwise require a preemptible context. Unsafe
completions retain the existing best-effort behavior and skip invalidation.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 mm/filemap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6afec6368..0616057e6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -45,6 +45,7 @@
 #include <linux/migrate.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/splice.h>
+#include <linux/rcupdate.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/mm.h>
 #include <linux/sysctl.h>
@@ -1620,6 +1621,15 @@ static void filemap_end_dropbehind(struct folio *folio)
 		folio_unmap_invalidate(mapping, folio, 0);
 }
 
+static bool folio_dropbehind_in_atomic(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
+		return true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return true;
+	return !preemptible();
+}
+
 /*
  * If folio was marked as dropbehind, then pages should be dropped when writeback
  * completes. Do that now. If we fail, it's likely because of a big folio -
@@ -1631,13 +1641,12 @@ void folio_end_dropbehind(struct folio *folio)
 		return;
 
 	/*
-	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
-	 * but can happen if normal writeback just happens to find dirty folios
-	 * that were created as part of uncached writeback, and that writeback
-	 * would otherwise not need non-IRQ handling. Just skip the
+	 * Hitting an atomic context should not happen from RWF_DONTCACHE
+	 * writeback, but can happen if normal writeback just happens to find
+	 * dirty folios created as part of uncached writeback. Just skip the
 	 * invalidation in that case.
 	 */
-	if (in_task() && folio_trylock(folio)) {
+	if (!folio_dropbehind_in_atomic() && folio_trylock(folio)) {
 		filemap_end_dropbehind(folio);
 		folio_unlock(folio);
 	}
-- 
2.43.0

