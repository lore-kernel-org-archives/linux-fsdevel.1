Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E793A545E
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197851; cv=none; b=i4Cdjt/duEnIdWekVsdcvhBF38Mxdk1iVY/e7tcxjeA8Da7pN0k9piDNs9OkS69Izl51QCOH3p74APWP6zB5H+5q2Tk685J5LsmqYVJhTmtJsOHMuhumWGqeyiyG+5kFVPZ1VSOP2UQbJR0v872OeclnQEe07Al4MjN5SpD0duY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197851; c=relaxed/simple;
	bh=Tvs161wK/s6K/mulS/cEIE9S02EbKDqru6nU3kHzh6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBZrPchwZPUMtw4FlTu8PBzr0UklrqhGMndinaLjnah8AP6aLakXc6pd+EjsV4rt1L0ckKsHZBwEMPJJjvpTaLvXR2ZZdvPH6fuc2ifzwvxr4Vtt2A5O6a/I9UzPPIqxKxYVSdzf/f/JWc+ySDi1b4nItHyKmtIrVJzE52lVB8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Dc8mP499; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Dc8mP499"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43db0c29so20634247b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790197845; x=1790802645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zePS8k8rZkvT//tsMfFKaNJkinJJhgZrZUtUQPvClt0=;
        b=Dc8mP499sNbmnrwOL4gT4CpT2VbCFbNCphPOI87/uJX5psAthH/0OoenOq4HkR3pnl
         /4vuPmJK1h2EUZWLzzkCYj7dtsIMwDQgAbkbO6MwZHl+J7csg8Yms2UkY/MurchPwKeW
         lX3KHT0jXNoWe1gCwXWhxSe82pFGtdLfTU50mQSXK4tKAbXavJtptfA2o6B+V60/Lp3z
         7qaDDrw19T4yDZqdQS9D9AVgGxG0PIXnbtMgAokmNTOATdUCoO3iuAq9L/7Wk6DJ96oC
         sYiSwzfiCbM5iwBLx1x+EOZhdkabnK46sBPexTtJ+PAaJePHG44m4v3iD/rx6vfmSAMk
         lLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197845; x=1790802645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zePS8k8rZkvT//tsMfFKaNJkinJJhgZrZUtUQPvClt0=;
        b=y/NVVZSYyqKzo8ABAzSM3CbqwnTGZekL7vCodNt0jV9uoXCC1S5fQ3LPZsXiM/S2wL
         JHy7LlhjAGKI/QfAYxIEJONjRPTTIlVVluLWfqxeQ11gN0yEmDhZCCtm6tKr+IhLj125
         0YaJ+wCrgN5v/P4m/YXGfv8Ik4nEwLT/jkjbXmUnFBvqM8YgsKE0yvvLL8oYfGEEWLSC
         gThBSlzUwT11Xh33OBt8fhhNpulRC+y6P+IMgsmDcR64NHs0j5CGWb2btf3Ybeso/SRI
         Sqsp34ipbZ4pD3TvFVHv9XXfoTCd5naPXyfDQueu1Fh9ZUJrnhktonvtk/ecFvSlfJCb
         Hm9g==
X-Forwarded-Encrypted: i=1; AKwUvBxg+4ZT8iLw4eTLkqpbSXGNhW0p0Dx84t392uG3ZkobTARgVJb45/7eVmb7xhPfxOE3f4CZyAN6EBNvK5f+@vger.kernel.org
X-Gm-Message-State: AFuF++m7Y3SglJ8d/cgcTrVnLKz0fzkwZybN8E6O+qLM5iVzaHvAgvcA
	V53yRuQpQTHyduGTn8ryqbJxgDf9EqyFV0F88HnhwgVEFd08Kxws2HFJcSzPaQbGUUE=
X-Gm-Gg: AYBFou1HexS/SoNTnYXYx9p1v4BakuUrl1uhZSyWHNtJjIVyirMkaUR/bi3wZdKQIXO
	TXkrku02sU9xOFYkqgIADv2+XxDdABTUPH+yjVgg1BP2zdzqyvl7HJ9xCQ7rSmDNKmHhbfxTnGF
	diWTn+LV+gvy2IoIs1oRcDfMRrxLgIy1IX+XTxmRN2xEDGCg8R/vTMRwJU5P3ur69dBYY5BrwgA
	HIUbvAEGt0+0vOSJZqZwxfhhKPdtDbL569qZMfhhY2pgNB2TrU1XROwSQuZUprKvSzzte53cJYy
	82finwj2L7ZJjxeBYl059YaThDAxQzzsvWT+jzn5Ua08oj9v9HnydyPF8uD8p1UwQ29yO6pFFuh
	UKXqH2xuiwDFaHDv3Y55xZX2u9xzDtyVymlgKpCXCSHXHLDHSmPkKEvor7t5lVHRZmJkUv5Ca3F
	vI22UoaKMPH8ddjJrA42iMfNlbCV2qzs6BGy742C6rdbh9oPFIAK/G8204/INeapdOSgUmFRvIB
	BJbK8RiU24xS8XFiDQJPMvgjQfaYf9DLs8Tl/r9dp+VjnrlkEK7qonbzQwB
X-Received: by 2002:a05:690c:6610:b0:873:17c9:b054 with SMTP id 00721157ae682-8a648505a0dmr2839327b3.21.1790197845286;
        Wed, 23 Sep 2026 14:10:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2485926esm305893085a.19.2026.09.23.14.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:10:44 -0700 (PDT)
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
	hannes@cmpxchg.org
Subject: [RFC PATCH 1/6] mm/page_alloc: clarify bulk allocator flag scope
Date: Wed, 23 Sep 2026 17:10:35 -0400
Message-ID: <20260923211041.3127588-2-gourry@gourry.net>
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

alloc_pages_bulk_noprof() uses its local alloc_flags for fast-path
watermark, cpuset, and CMA decisions. These are distinct from the
allocator behavior flags stored in alloc_context.

Rename the local variable to fastpath_alloc_flags.

No change in functionality.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/page_alloc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 07e03c7c7771..728dd1a36f0f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5169,7 +5169,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
 	struct alloc_context ac;
-	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int fastpath_alloc_flags = ALLOC_WMARK_LOW;
 	int nr_populated = 0, nr_account = 0;
 
 	/*
@@ -5210,7 +5210,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
 	gfp = current_gfp_context(gfp);
-	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
+	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp,
+				 &fastpath_alloc_flags))
 		goto out;
 
 	/* Find an allowed local zone that meets the low watermark. */
@@ -5218,7 +5219,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
 		unsigned long mark;
 
-		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
+		if (cpusets_enabled() && (fastpath_alloc_flags & ALLOC_CPUSET) &&
 		    !__cpuset_zone_allowed(zone, gfp)) {
 			continue;
 		}
@@ -5228,16 +5229,17 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			goto failed;
 		}
 
-		cond_accept_memory(zone, 0, alloc_flags);
+		cond_accept_memory(zone, 0, fastpath_alloc_flags);
 retry_this_zone:
-		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages - nr_populated;
+		mark = wmark_pages(zone, fastpath_alloc_flags & ALLOC_WMARK_MASK) +
+		       nr_pages - nr_populated;
 		if (zone_watermark_fast(zone, 0,  mark,
 				zonelist_zone_idx(ac.preferred_zoneref),
-				alloc_flags, gfp)) {
+				fastpath_alloc_flags, gfp)) {
 			break;
 		}
 
-		if (cond_accept_memory(zone, 0, alloc_flags))
+		if (cond_accept_memory(zone, 0, fastpath_alloc_flags))
 			goto retry_this_zone;
 
 		/* Try again if zone has deferred pages */
@@ -5269,8 +5271,9 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
-								pcp, pcp_list);
+		page = __rmqueue_pcplist(zone, 0, ac.migratetype,
+					 fastpath_alloc_flags, pcp,
+					 pcp_list);
 		if (unlikely(!page)) {
 			/* Try and allocate at least one page */
 			if (!nr_account) {
-- 
2.55.0

