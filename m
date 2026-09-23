Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F864137BF
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197858; cv=none; b=LhFTWvAUYSZeN/wTYmhkTBT8cxSR2cd+wXiOu68XJCR5jc84OPLIFRaf90Zqa1F3qAUYpF2HgYx4S4I4BHvdEHPsSBMNthRxU2bByodcrWrhWddhWDLAuxfcYpoMpdfmmccfdOtmJNonW6P4OeMX7VvpmPxPRxdsTapBmzdkn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197858; c=relaxed/simple;
	bh=f7jLp3wHPMKJ2uLRlkyduFLNcqp1N3nkDtlgrZmrOxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsV0+WrzXj4izl00M3IQv9FBllexhP+cwXdIGIDCzohwUVulmTuUWh9bIfaIIKFW+DOvIgF8JrfOi2K9VJc6s5kb5ogIuCHNFo+PYLhp7kPtI0tj2T5o+HEAWKA1V8s3+HTGgT5qF+mf61REMI067TWMgsoKIcaoiCH/9OrM0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BHqR8XBl; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BHqR8XBl"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109fafd6so107310585a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790197850; x=1790802650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/Ioh0E0wp4TmybDNX/mkYZyZ5cUYapYs7dOai2tJpk=;
        b=BHqR8XBlbOtqtefjkV+fJT9SncSAw/sxdhOfw+7rGGaU41TwxJnLH3+2XV/i6CP8jR
         b46a4XbDeN6LOLro5NCa2eIE5WYkGSnkHnj1Dlk4yjYAa1XY9fIofA/gosw9NLVIY9x1
         cawnmAganxt31/QJb0rDtPVvB9oESgZ5u3qKZrkPxGyX17v34wKtOSNqHX5Olve7wtZA
         3TMIfSDsuujPly4Ht/d/eEax6E1M27bZVUZD2moFbwconVDTpo2IIIcmbJ8K7Nl6Be/e
         TW3LdHgG9CRG/Ek6MEhRiHMZyBB0/oaVnUaT4/71ukzaSBJBGlxO4WI3gOwq8b4i/eF3
         ZrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197850; x=1790802650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/Ioh0E0wp4TmybDNX/mkYZyZ5cUYapYs7dOai2tJpk=;
        b=Xw1TijZk99z779zEsZJrWh9TetFBBfIlxmWP5EKp6m08a8SM220y0pufdnYp1aV4h4
         KiNew7bmZcFcFbH2hPY1u5iXImHEQL30542KtYnFnHWcnnet1mvYbynlFUS+BgixR1fx
         QBOxt1JwVsdEAnuHcv++NnaGxJti+47yVnMWTV9vBbj0UGQU5uDuj5E6i7VdNqotrElA
         rhW58ihfk7k0Gz8pf/sZBylEQ1KezeyJYK0N1ZMwzOqszuHAU+UG+xjZN9SPBpIFrsiq
         lXm1H3/GREq0kLEbvKTfLla6/c3q+CrIi16RRpccfBtxqhqk6mr7uzl2QJ/ruI9qJZoz
         anUg==
X-Forwarded-Encrypted: i=1; AKwUvBzmcyTrLnkyZ6R1rniGO3hfYGVjvwU29XQhPsFHGohSTR8vS2ncBrpBSRWsgNgKN6hbN+oKv6S6jvG+FsOY@vger.kernel.org
X-Gm-Message-State: AFuF++lvzv7W/CoeOUUQ9nc0pG7MANd/v+qtEHMuSgrEdopj42nfyNSU
	68xyZUY3T74D+AP53kQgAjGQfbeaEQNB4PHYalcnIvlqpb+5kz+u3R0IvNuyoOlLcqg=
X-Gm-Gg: AYBFou1tG0Em8HZcgn78locGXrVbE22j6h2rYSABb9z5Wx0FXHVXAKYi/Jm/vSXMirw
	8Nx9kA2uedd3U25iMyGZ/IZ0C4bztFcZpRHF8ZTnvZMja/5AC+idm/OjfN8QVicZzCRAjbCudSk
	GZRfpmcA6qLgNw0vJe4iXv2ujNhS4C0EwZ5wTl3CNcNvfhhKu6zNEJrASHJbMIdaOqd/F9jAUEV
	hxUJ5k0k7+rZ/rkPcy2kxgHbl/bKP2toZl0ijWW2P84jAVIWkIF9Y21SpZFrlM9mG13ZjIZCcCo
	x5Tko+55Z4ufXO4J83TvHYhrf1Hw4fVvVQVJW5ZP8l4h+nvpgewp0V2Lv0DlfK10FsMEO9gNVVF
	7t2BLU5VoEUNzAolrmLkjV/q08WaRjrlg8nk0OlRJN3FTxbBv51fkNneVg4hvN9o0a8yxzkSdBh
	kYbgSVhKZg20s1hBejfMY36Zpyncu1Sp9MX7uSppcy/nk7RsleZE9EJJI+xdf6YRd0/0DgUbyHS
	+G52XES7wPdQQziX006fnuRSqMI61+Bo5wD35OL1aVz58DNrHRADETAcQpQVg==
X-Received: by 2002:a05:620a:2690:b0:939:b55a:3c7 with SMTP id af79cd13be357-93c344ef4famr76423385a.41.1790197850184;
        Wed, 23 Sep 2026 14:10:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2485926esm305893085a.19.2026.09.23.14.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:10:49 -0700 (PDT)
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
	Brendan Jackman <brendan.jackman@google.com>
Subject: [RFC PATCH 4/6] mm/mempolicy: plumb alloc_flags through folio allocation
Date: Wed, 23 Sep 2026 17:10:38 -0400
Message-ID: <20260923211041.3127588-5-gourry@gourry.net>
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

From: Brendan Jackman <brendan.jackman@google.com>

The NUMA policy allocation paths hard-code ALLOC_DEFAULT before reaching
the page allocator.

Add an alloc_flags argument to the MM-internal policy allocator and carry
it through preferred-many, huge-page, and general policy allocation paths.
Keep the public mempolicy folio interface as an ALLOC_DEFAULT wrapper.

Task policy selection is not safe in every interrupt context, so non-task
ALLOC_NOLOCK requests bypass it and use the supplied preferred node
directly.

No existing caller behavior is changed.

Link: https://lore.kernel.org/r/20260726-page_alloc-unmapped-v3-25-6f5729aa9832@google.com
Signed-off-by: Brendan Jackman <brendan.jackman@google.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 44 ++++++++++++++++++++++++++++++++------------
 mm/mempolicy.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 12 deletions(-)
 create mode 100644 mm/mempolicy.h

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4c0b8ff1a7e6..2c01699081b7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -120,6 +120,7 @@
 #include <linux/memory.h>
 
 #include "internal.h"
+#include "mempolicy.h"
 #include "page_alloc.h"
 
 /* Internal flags */
@@ -2437,7 +2438,8 @@ bool mempolicy_in_oom_domain(struct task_struct *tsk,
 }
 
 static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
-						int nid, nodemask_t *nodemask)
+						int nid, nodemask_t *nodemask,
+						unsigned int alloc_flags)
 {
 	struct page *page;
 	gfp_t preferred_gfp;
@@ -2451,10 +2453,10 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
 	preferred_gfp = gfp | __GFP_NOWARN;
 	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 	page = __alloc_frozen_pages_noprof(preferred_gfp, order, nid, nodemask,
-					   ALLOC_DEFAULT);
+					   alloc_flags);
 	if (!page)
 		page = __alloc_frozen_pages_noprof(gfp, order, nid, NULL,
-						   ALLOC_DEFAULT);
+						   alloc_flags);
 
 	return page;
 }
@@ -2466,11 +2468,13 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
  * @pol: Pointer to the NUMA mempolicy.
  * @ilx: Index for interleave mempolicy (also distinguishes alloc_pages()).
  * @nid: Preferred node (usually numa_node_id() but @mpol may override it).
+ * @alloc_flags: ALLOC_* flags.
  *
  * Return: The page on success or NULL if allocation fails.
  */
 static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
-		struct mempolicy *pol, pgoff_t ilx, int nid)
+		struct mempolicy *pol, pgoff_t ilx, int nid,
+		unsigned int alloc_flags)
 {
 	nodemask_t *nodemask;
 	struct page *page;
@@ -2478,7 +2482,8 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
 
 	if (pol->mode == MPOL_PREFERRED_MANY)
-		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
+		return alloc_pages_preferred_many(gfp, order, nid, nodemask,
+					  alloc_flags);
 
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
 	    /* filter "hugepage" allocation, unless from alloc_pages() */
@@ -2502,7 +2507,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 			 */
 			page = __alloc_frozen_pages_noprof(
 				gfp | __GFP_THISNODE | __GFP_NORETRY, order,
-				nid, NULL, ALLOC_DEFAULT);
+				nid, NULL, alloc_flags);
 			if (page || !(gfp & __GFP_DIRECT_RECLAIM))
 				return page;
 			/*
@@ -2514,7 +2519,8 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 		}
 	}
 
-	page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask, ALLOC_DEFAULT);
+	page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask,
+					   alloc_flags);
 
 	if (unlikely(pol->mode == MPOL_INTERLEAVE ||
 		     pol->mode == MPOL_WEIGHTED_INTERLEAVE) && page) {
@@ -2530,11 +2536,18 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 	return page;
 }
 
-struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
-		struct mempolicy *pol, pgoff_t ilx, int nid)
+struct folio *__folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *pol, pgoff_t ilx, int nid,
+		unsigned int alloc_flags)
 {
-	struct page *page = alloc_pages_mpol(gfp | __GFP_COMP, order, pol,
-			ilx, nid);
+	struct page *page;
+
+	if (unlikely((alloc_flags & ALLOC_NOLOCK) && !in_task()))
+		return __folio_alloc_flags_noprof(gfp, order, nid, NULL,
+						 alloc_flags);
+
+	page = alloc_pages_mpol(gfp | __GFP_COMP, order, pol, ilx, nid,
+				alloc_flags);
 	if (!page)
 		return NULL;
 
@@ -2542,6 +2555,13 @@ struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
 	return page_rmappable_folio(page);
 }
 
+struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *pol, pgoff_t ilx, int nid)
+{
+	return __folio_alloc_mpol_noprof(gfp, order, pol, ilx, nid,
+					 ALLOC_DEFAULT);
+}
+
 /**
  * vma_alloc_folio - Allocate a folio for a VMA.
  * @gfp: GFP flags.
@@ -2586,7 +2606,7 @@ struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned order)
 		pol = get_task_policy(current);
 
 	return alloc_pages_mpol(gfp, order, pol, NO_INTERLEAVE_INDEX,
-				       numa_node_id());
+			       numa_node_id(), ALLOC_DEFAULT);
 }
 
 /**
diff --git a/mm/mempolicy.h b/mm/mempolicy.h
new file mode 100644
index 000000000000..8d2c07868f6e
--- /dev/null
+++ b/mm/mempolicy.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * mm-internal API for mempolicy.c. Public API lives in
+ * include/linux/mempolicy.h.
+ */
+#ifndef __MM_MEMPOLICY_H
+#define __MM_MEMPOLICY_H
+
+#include <linux/gfp.h>
+#include <linux/mempolicy.h>
+
+#include "page_alloc.h"
+
+#ifdef CONFIG_NUMA
+struct folio *__folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *pol, pgoff_t ilx, int nid,
+		unsigned int alloc_flags);
+#else
+static inline struct folio *__folio_alloc_mpol_noprof(gfp_t gfp,
+		unsigned int order, struct mempolicy *pol, pgoff_t ilx, int nid,
+		unsigned int alloc_flags)
+{
+	return __folio_alloc_flags_noprof(gfp, order, numa_node_id(), NULL,
+					 alloc_flags);
+}
+#endif
+
+#endif
-- 
2.55.0

