Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5601E51E0
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141971; cv=none; b=tDVNOn+OenTAkXn7ND658S+k02Hk5nnK6ZO6QJ0y397FVMXiy7liL+9hTBYzDd80/m1FhmMWv8+uHTJwoZghzZqCF135D+LOWfUMpvmwGiP4SDMLx3Hrt0myNVjFg04eyRgCSh+ZP+uu3ASTVB2KAyDGruRtqHwt755F3nQhYeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141971; c=relaxed/simple;
	bh=BjyACDhK2iMjtJtP1QUzxghUJly+kB4eAL2PpuozZV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gX1I33x1SHSPTvT3XKZ3KfnLEg6u0Rawa/I5IgzLw8b35X7o3uYlFVS9F0tqmvHBI0JibhbO8eknXxzugPVDrNc8keQOreF5Q1tJ0JQOovGQjOmrQru3mCi1DQETweU49yppuRH1sjpEH+TXMdDzNBbNPIqu5G5D+yqgbHIe9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLsbwDit; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLsbwDit"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3964e480f76so1394935a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789141969; x=1789746769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LNQ5H8myUqx1tWJQeg5MIIwa9og+am+x86iyfUFxIuw=;
        b=lLsbwDitLTCNxmL0hVg/r6vj5dpn8HnIbkeS82NAY+LlQJelwRjB7jhYaggfKRZE0D
         h8UFWwFVZVE57Tq30YbBq50rVelWtUZWs+/tFe3jdD60rQtIggHnKIcC6/OdSww2miqm
         gSWuuu9hPHr5UN6fK1IdkKHjAq1jKgKV5fzTug/axN+Wfb2ULgovoIYQjea2II7O2zqk
         48rSkmYMPq3gqpuB6NV5+PeFlv3RROjxx+v4Psr3LShJmiR5TzhiRJGbiIKhILSjKJYu
         sv60qK1Dpa0XkwoyeXWGV7ndV3AvGBkiJfB6XN+R4VFaM4OYj8wy0EJ9NgPJ81hCblAt
         Y++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141969; x=1789746769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNQ5H8myUqx1tWJQeg5MIIwa9og+am+x86iyfUFxIuw=;
        b=Cl+/6otaitpSlGxBoJKgcjPqBpYCmpt1TY5ugkmH2jtAJVjo8uLMwxcI2qC+AuI5Lm
         gKfzXjOfATECa7gWciZFp0xDAJqF1M67MszOWb6sd6YgtW7SfW2CUOciNFc0vo1txgFL
         eM6RhWn/2j5BZ9h8BXL2fe3ZcURDFTrHkYaUk9y5JVdapc9+f9x7Pk//3PetXrXFa5dx
         fx7bK4FxZZ2827pbNewsSmY56s753iLdTYUcUaGAETZBN7hKNZ0olxoxJxXBLmXTvej7
         o+PCJIV582lR+Ggn8mxsUTCA41v7X3CktAhO7afSCPh/wUXvk9zt2PjYT5i1Ms9iBXqS
         /s/w==
X-Forwarded-Encrypted: i=1; AKwUvBzUeB4dH8PvYH2cyJF9ImdVUWgk+CZJsC3b0sbsJJi7j16+vOISg2AIMTI51F9nzk8srUcgJTTZNh8iW+6r@vger.kernel.org
X-Gm-Message-State: AFuF++kfO9inUku2J7/EAp7FNSuDcK75QglHf5kEzymnQKnlKrbLBWVm
	C/nX98P9lGToQprRSpaYRLQBHKXK+RxJJrU3qBiNhmiTLw7i9Sp6fIK4
X-Gm-Gg: AYBFou0tWY/J3x+GEHg6FWUoK7i+GkQpihLKm4zMdBEnwWOmR1Gz5zHoTAuZVCzLYy3
	B3LwDqSxKC1U6y5ckmYKYvTNG8z9PFD+rr8W9CSNzCJmKTiUK4r9oAIX+uCInpPij6PGl/9aCfa
	wHBq1eU/gzuwE30bO3rdHk9nTuCN4tovhUmLIX7MIzUHPxRDi0FEqve7SrhdfKqIKd16/R6Vh8j
	+nPdDMNYw3iiz+TcUKwdWPTkz6YwxEBrH1qr+QYcetP1HUoWWkGme3gU0tpH++YXlyDT/OLFfDg
	UYC0TxBeM7wcHaZPVEcJkIdxnKNQVuB9c/zF8qDw+nmMTOUOKPTDxpgGypOdyP4nvczxZzgsDKo
	Qx099rtWiyskNpbPT0dzXYhViXRIuaoIgFj+OTJdLvhkAhrAy/OsBA8PyO/+PFLIIkr9SH3cWPV
	xS5q4PyiAhg5sZf5Da2EuOlx404utHq72TrIJnK8n07JdTcOgbuC+gb4CmSuNWyyLdXSs=
X-Received: by 2002:a17:90b:4b0e:b0:398:9be5:b41d with SMTP id 98e67ed59e1d1-39d9c368348mr7982154a91.24.1789141969010;
        Fri, 11 Sep 2026 08:52:49 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b97994sm13853172c88.12.2026.09.11.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:52:48 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: "Liam R. Howlett" <liam@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Eliot Courtney <ecourtney@nvidia.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH] lib: fix lock initialization in region allocation benchmark
Date: Fri, 11 Sep 2026 11:52:43 -0400
Message-ID: <20260911155244.1406122-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Maple Tree benchmark uses MTREE_INIT() for a stack-allocated tree.
Its static spinlock initializer leaves lockdep to use the lock address
as the class key. Since the address is on the stack, the first allocation
triggers "INFO: trying to register non-static key" and disables lockdep.

The IDA benchmark has the same problem through IDA_INIT(), but runs after
Maple Tree and therefore encounters an already disabled lockdep.

Use mt_init_flags() and ida_init() to initialize the locks with persistent
lock-class keys. Keep initialization outside the timed allocation paths.

Fixes: f4806cc63cc6 ("lib: test bitmap vs IDA vs Maple Tree performance for region allocations")
Closes: https://lore.kernel.org/oe-lkp/202609101106.771b567e-lkp@intel.com
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 lib/region_alloc_benchmark.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/region_alloc_benchmark.c b/lib/region_alloc_benchmark.c
index e88b4cf55c62..a644f3d5431a 100644
--- a/lib/region_alloc_benchmark.c
+++ b/lib/region_alloc_benchmark.c
@@ -78,11 +78,13 @@ static size_t __init ida_size(unsigned long nr_ids)
 
 static unsigned long __init benchmark_ida(unsigned long cap)
 {
-	struct ida ida = IDA_INIT(ida);
+	struct ida ida;
 	unsigned long cnt, idx, off, nr_ids = 0;
 	ktime_t alloc_time, free_time;
 	int id = -ENOSPC;
 
+	ida_init(&ida);
+
 	alloc_time = ktime_get();
 	for (cnt = 0; cnt <= cap; cnt++) {
 		for (off = 0; off < reg_sz[cnt]; off++) {
@@ -125,12 +127,14 @@ static unsigned long __init benchmark_ida(unsigned long cap)
 
 static unsigned long __init benchmark_maple_tree(unsigned long cap)
 {
-	struct maple_tree mt = MTREE_INIT(mt, MT_FLAGS_ALLOC_RANGE);
+	struct maple_tree mt;
 	unsigned long cnt, idx;
 	ktime_t alloc_time, free_time;
 	size_t sz;
 	int ret;
 
+	mt_init_flags(&mt, MT_FLAGS_ALLOC_RANGE);
+
 	alloc_time = ktime_get();
 	for (cnt = 0; cnt <= cap; cnt++) {
 		ret = mtree_alloc_range(&mt, &idx, xa_mk_value(cnt + 1),
-- 
2.53.0

