Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393637F306
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197860; cv=none; b=TZvQQR2eWjSBc63eVmJDNnIJ74hST3n3KNr9n7ZQIIb7fJf6HUoEuGBYXyw/4/3fYP89DxUTrmOpaO+udN/6KolUdju/3icH2BMD3iVUncNWcWg4IZPW0OSGpUy7DVk5W6j9soMB6v0pEbYE9pYez1XNiqe56xBPrfuoi7u/c0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197860; c=relaxed/simple;
	bh=8PRj6qx0RbwILj6Hf9BDGD4tq16yZjFSnmzbs9ElPF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EA94skVrxeK8q191spEgUSAEZrVh/NtfKAGETv/Ucd+G2ioKyDrXEgjBIKMLuLqv4Qlyf+OrT602uWHkei3kaV4JBVDlWPCNg/RF7+URLdtJZ3aKdfLBF4MoPMmpzRDS9wslu1DOi/j6v+VDeZafeROVuh/ozhu4VO9ujc4uOjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XqWnKD2l; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XqWnKD2l"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd6so107311885a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790197852; x=1790802652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ri8dUqYh2ciqE73sjjK4gAgS5aPTyFxGGtfGAJFHdJc=;
        b=XqWnKD2lCOBydJVl5hLCNoWD4kSNYPxz5yg0q4nMFB+Fs2UJldGhArZfkUqsgRPMNX
         pj7NLD4SuRj7MxDS668ZIbHFThAByt0K2d5NT9cUVaxqKsOddhIoVVXfUKzqWAHIHSAV
         yjA8CTA3f27H/ZtduPko9Mom4mm9sIDvu6Rxuhnkk5JWlwXNL2oDKHhyx8HecZT6nxu/
         fF0+Otq5tSFnAa/T3pRWsE94yrgmk04WmoliBdsNm7BeLJIQ6AZC2fyBBQApejS49zWZ
         Msg7WAhzoYhiCrPO+h02gVL9PqMxrxRHBW6sKXvKXVPbb3M9EgfctjkWenA24pelT1qf
         fT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197852; x=1790802652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ri8dUqYh2ciqE73sjjK4gAgS5aPTyFxGGtfGAJFHdJc=;
        b=OTPCyD55xpr6wAxC6qigy/IaE3rt1eOKdoLX4Z6C7ZLVS52vi98xdIO/qiZFvEdF4Q
         jO61iQGaJ18dR79V4xfaj3EdeLH1J140aX8YSCldnfvb13Jye5rUq+76ujM5pYqE82t1
         uHDp2F722T0tqOanrnbCG7ASQ/NA11VI53R9SV5WGTU2N2lg3GpA7ZFpxqkvRP1TiRHW
         CwcIV0ED52z76zbiPQeiysx26n/L9tIlAAkVe+B2T1OeraLpVL0poti39SSc7SHEqAAb
         +tLuQWipz5iCi5/CpSao9NTbkFGZ0V51gC1LYvPNfYnVnEtQFLpD3h4vFUHCM6+LKdaT
         VUqw==
X-Forwarded-Encrypted: i=1; AKwUvBz4+QT9tj1JTD2YuHiE+7E7blUQtE5c51W3fwlRkJTTO/WijjkZg2JcxzzkqUr2AhWzqg4b0z08ChN4SlVP@vger.kernel.org
X-Gm-Message-State: AFuF++kly/fB1KKSRwIlQJk5yBBodrju460BGveZtyrNqe3TfAe5UB77
	G03FTdgfL1SWAD8cfsIHUqNFtZ9mDgfet7E1ZWxM8pJe6MV0XiD4ew2gbq6t+THq/EU=
X-Gm-Gg: AYBFou13hXvb43WOO1TwcTOG+JZZh4qq2qlzyMtCrDjgjlSHdPdjTMDSQpZbkb+keAB
	yQzOL4CrC0w8j4uw2L9vESTLjq+Ff9Ib10OAKJ8Y/4iYtgE3pDOWNPzAIDUlYkMve4g+uWFwkMm
	E/LoqZ42Jz4aapCPX28wLEeHiNPJCp6H33nAeN/Jq8ph3tUvQFBvQq3EuSiZnI9vulM10khgvLA
	NQVjNJJekC5zjWvqp27Tq2A6cXJcq0uJR9FjV24z/KXIAfvGjivL4PaerlKyFBshL2EFbheQQoi
	NFfkmf6ACk2fjYwcduAQD/ptPXNb4gbbYJHKKsP9zxombmB09hVNMZurW3HQiY9i1wBgOdz8bwG
	/yKiZGM6gdh5bO4Wa/gWa7qjIJ5JQcqstGP2PdvMH1JIysN+sNokR7oRKO64rAER9kZFBGadd1l
	sP2xKxMJNLcTVYOqtsQZ5EqwVxUK8w78e5sOz0FnJXhMKIuivndZnKoCzkgVIddbQU5kv21V8X2
	ibJK4afLwnYUv3EoM0uRmjThtVhEZ4t6gBT2PDSsueKq72eAw0gZJL3iEc1FD+epH5kI1Y=
X-Received: by 2002:a05:620a:31a4:b0:93b:d79e:18f3 with SMTP id af79cd13be357-93c34540d1bmr71767185a.54.1790197852086;
        Wed, 23 Sep 2026 14:10:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2485926esm305893085a.19.2026.09.23.14.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:10:51 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	david@kernel.org,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	Brendan Jackman <jackmanb@google.com>
Subject: [RFC PATCH 5/6] mm/filemap: plumb alloc_flags through folio allocation
Date: Wed, 23 Sep 2026 17:10:39 -0400
Message-ID: <20260923211041.3127588-6-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923211041.3127588-1-gourry@gourry.net>
References: <20260923211041.3127588-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brendan Jackman <jackmanb@google.com>

The filemap folio allocator applies NUMA policy and node selection before
reaching the low-level folio allocator. It currently provides no way for
an MM-internal caller to preserve explicit allocator behavior flags across
that selection.

Add an internal filemap folio allocator that accepts alloc_flags and carries
them through every allocation path.

Keep filemap_alloc_folio_noprof() as an ALLOC_DEFAULT wrapper so existing
callers and the exported interface remain unchanged.

No functional change intended.

Link: https://lore.kernel.org/r/20260726-page_alloc-unmapped-v3-26-6f5729aa9832@google.com
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/filemap.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c..3b33cc873b73 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -52,6 +52,8 @@
 
 #include <asm/tlbflush.h>
 #include "internal.h"
+#include "mempolicy.h"
+#include "page_alloc.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/filemap.h>
@@ -995,31 +997,62 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
-		struct mempolicy *policy)
+static inline struct folio *__filemap_alloc_folio_noprof(gfp_t gfp,
+		unsigned int order, struct mempolicy *policy,
+		unsigned int alloc_flags)
 {
 	int n;
 	struct folio *folio;
 
+	/* Task policy and cpuset spreading are not safe in all IRQ contexts. */
+	if (unlikely((alloc_flags & ALLOC_NOLOCK) && !in_task()))
+		return __folio_alloc_flags_noprof(gfp, order, numa_node_id(),
+						 NULL, alloc_flags);
+
 	if (policy)
-		return folio_alloc_mpol_noprof(gfp, order, policy,
-				NO_INTERLEAVE_INDEX, numa_node_id());
+		return __folio_alloc_mpol_noprof(gfp, order, policy,
+				NO_INTERLEAVE_INDEX, numa_node_id(), alloc_flags);
 
 	if (cpuset_do_page_mem_spread()) {
 		unsigned int cpuset_mems_cookie;
+
 		do {
 			cpuset_mems_cookie = read_mems_allowed_begin();
 			n = cpuset_mem_spread_node();
-			folio = __folio_alloc_node_noprof(gfp, order, n);
+			folio = __folio_alloc_flags_noprof(gfp, order, n, NULL,
+							   alloc_flags);
 		} while (!folio && read_mems_allowed_retry(cpuset_mems_cookie));
 
 		return folio;
 	}
-	return folio_alloc_noprof(gfp, order);
+
+	if (in_interrupt() || (gfp & __GFP_THISNODE))
+		return __folio_alloc_flags_noprof(gfp, order, numa_node_id(),
+						 NULL, alloc_flags);
+
+	return __folio_alloc_mpol_noprof(gfp, order, get_task_policy(current),
+			NO_INTERLEAVE_INDEX, numa_node_id(), alloc_flags);
+}
+
+struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *policy)
+{
+	return __filemap_alloc_folio_noprof(gfp, order, policy, ALLOC_DEFAULT);
 }
 EXPORT_SYMBOL(filemap_alloc_folio_noprof);
+#else
+static inline struct folio *__filemap_alloc_folio_noprof(gfp_t gfp,
+		unsigned int order, struct mempolicy *policy,
+		unsigned int alloc_flags)
+{
+	return __folio_alloc_flags_noprof(gfp, order, numa_node_id(), NULL,
+					 alloc_flags);
+}
 #endif
 
+#define __filemap_alloc_folio(...) \
+	alloc_hooks(__filemap_alloc_folio_noprof(__VA_ARGS__))
+
 /*
  * filemap_invalidate_lock_two - lock invalidate_lock for two mappings
  *
-- 
2.55.0

