Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8644237D
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197864; cv=none; b=oenhbTFH5WQQBxpQfDPrTAKyREFNUlI3FL0Ncg8mJzsk1FqVEJlcGW0xWg81ZbEBcNe+yjDBnEqNyvVptHmhkvfhNKyPX9E18TFLRx2tnUMqFrdMSQ31+WtDHx3olljGri5rJwG0yKh+OWoIxJM4zbYHhgI8keEYrEDfEX6R9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197864; c=relaxed/simple;
	bh=vJCC8feguoeyY1Gu7GMMIAn/XZEg2QFDZSQSJ2H/ge0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0p+4SdX5qnD9vKeP8Xb9AFIlV/WbLgSq3F02NRZo5PDMGh/VHzdc/kkMIHgFrTQOi8ZheMM+7Tt+E/AEz0Xt4+kPr9zuQ9Xtn7o6TM5IblSQWPOFZsj7RurYfSyrl2+j+zibknIrUdo+V69DJH6XY4fxGJ9UyB9O/dUkXRVtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G1AB8eJx; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G1AB8eJx"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939eb3249c1so109775685a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 14:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790197854; x=1790802654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z68SIWaMimWKPBbcPzrXpDhBMBPzNt9VtEr/ioTExD4=;
        b=G1AB8eJx1/1uzS2vlnhekJbGmQ+IKUs5MR/YxJ9FCbCU0E7vc1aP4jEbZoTEBw+Ki2
         Drq9Cybukp3V7SzKwgv2+47JN9G+woIMI5mf0vuTE6ddsB+IEby796P2wrwIjl+lSCzX
         lVl3RIkRNwVoXKTdQqI3GixRZNxAS9+npffxU5w/Lm62rmqHyM7s75aiJGjhRPghm4ZO
         iOljVVYcZN3MT4Vz460RXSv2YcNEoIhfWxNVlffhQKzIWzOM4DGB3sFKR46ekaMkA/Yt
         +ZFXNvVIVNh6yIQLTVd3hyxUYUbV6iFsL54VgRgdJqM3xRk5djrSqAl8b9jcP/Hhowej
         UPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197854; x=1790802654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z68SIWaMimWKPBbcPzrXpDhBMBPzNt9VtEr/ioTExD4=;
        b=rWYfMZeuGEmdLuyww7fK18ovTAOkUyrRoEos0YYMxu0o7eC7rmr/9zDzOrzoj73f6d
         j2AHKAOLBv2+32yyCrOWpOghdKCW/hQR+VRKXIontlGrYVmgRl+hhdzeBbUWYQw1du3D
         xSb/XDKP/q5ngpMpcRkFpxdq6vc2JNvpleycAFGUwj29DblotscmAJKFBfLovhAgS/TA
         NnmbGUYn8i4xDYsLtbqY4nddFiqQN7elGzxECPgfhF+6KWQ8yhafPz0JOdY2eGsFGFc/
         6a2t+o4WJYCZNC35BqarF9HJ7y+EE7GSQC0MC9n/U1wwO/+NIa6ak49X9qu8jJW7lZAA
         KXzA==
X-Forwarded-Encrypted: i=1; AKwUvByW11b6tQ2pukrMYrHPuKU1+bgCKq8TrbATgdsdn9cYFV8ZiqGUAob8ru/Jz8hex4deZIgKrdjAMTqVfSkY@vger.kernel.org
X-Gm-Message-State: AFuF++n6wTN4K5yF8XEFIGcCUx8KlzA3skXpIp0tsofa6+ZjpY6Qbmmm
	d3SKoyYf9IWDImP7UoIxHueU5GZSnLTmKZQN6jt7uTxBZBpxi0rBX1NlkSR/o2OKqm0=
X-Gm-Gg: AYBFou0SNl8/8ChZQn9c7v6I4B1OIRg38fHLFI6z1bmBBoqEaffAyNJ8u4hCpJNmQw5
	1mwtpLlr6GekwYrxd76ElZYmAxs2DtD4GZIISfhJso3SczzMgAStS7c98CMpvhUuTD4SL7c6gpq
	UvX3I52zOss1OkjurIa1NUdnhKA/Ie17K80niIvF3ZLFQETPd901osb8z0cAZkBG6Biya6qUB8H
	m/PTCoEujbmjHYDoTNcei4ms2yW9+OkOEfLh4stvj0QoWMqoPsHmTedIM/sTvaDrTat9bNSHfad
	sFWqtr8rr9ROIDuJXYNigeCF1yw6srsuCvlP1+M2Q1GtJ53sDVPjUQf1tJw7q2C4aQDXwZ2d90S
	gBkwScAzKluTXPP/wUCesyOcsk9jnUfwbKOQrTnmn/FuzWm35Q3rET2ZRFV76948rdR9UL11Jbn
	QP0dIzBhFFkUN+Eoghj8AaqMOhpm62/KAq1BL4YBbZPozM+36qbBlnlBMl6kkXvjBfWnxJi1pkI
	jpGlgOjdIuHSqfLI2GGcRUhu/8TXNeWxmjBuvlC2kXc9iEQUU8/rRuSaa/Z
X-Received: by 2002:a05:620a:25ce:b0:93b:d79a:c464 with SMTP id af79cd13be357-93c3480c8famr61505485a.60.1790197853636;
        Wed, 23 Sep 2026 14:10:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2485926esm305893085a.19.2026.09.23.14.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:10:53 -0700 (PDT)
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
Subject: [RFC PATCH 6/6] mm/page_alloc: let the bulk allocator carry alloc_flags
Date: Wed, 23 Sep 2026 17:10:40 -0400
Message-ID: <20260923211041.3127588-7-gourry@gourry.net>
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

__alloc_pages_noprof() accepts explicit allocator behavior flags, but the
bulk allocator does not. Internal callers therefore cannot select those
behaviors through the bulk interface.

Add __alloc_pages_bulk_noprof() for flag-carrying MM callers. Keep
alloc_pages_bulk_noprof() as a flag-free wrapper passing ALLOC_DEFAULT, so
existing callers and the exported interface remain unchanged.

Preserve the original GFP mask for the single-page fallback so it repeats
flag preparation from the caller inputs, and pass the prepared fast-path
flags to prep_new_page().

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/page_alloc.c | 28 +++++++++++++++++++---------
 mm/page_alloc.h |  4 ++++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index feb9c64efd84..8fa2522ef418 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5219,6 +5219,7 @@ static __always_inline bool prepare_alloc_flags(gfp_t *gfp, unsigned int order,
 /*
  * __alloc_pages_bulk - Allocate a number of order-0 pages to an array
  * @gfp: GFP flags for the allocation
+ * @alloc_flags: Allocation behavior flags
  * @preferred_nid: The preferred NUMA node ID to allocate from
  * @nodemask: Set of nodes to allocate from, may be NULL
  * @nr_pages: The number of pages desired in the array
@@ -5237,15 +5238,16 @@ static __always_inline bool prepare_alloc_flags(gfp_t *gfp, unsigned int order,
  * @page_array were set to %NULL on entry, the slots from 0 to the return value
  * - 1 will be filled.
  */
-unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
-			nodemask_t *nodemask, int nr_pages,
-			struct page **page_array)
+unsigned long __alloc_pages_bulk_noprof(gfp_t gfp, unsigned int alloc_flags,
+		int preferred_nid, nodemask_t *nodemask, int nr_pages,
+		struct page **page_array)
 {
 	struct page *page;
 	struct zone *zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
+	gfp_t orig_gfp = gfp;
 	struct alloc_context ac;
 	unsigned int fastpath_alloc_flags;
 	int nr_populated = 0, nr_account = 0;
@@ -5285,7 +5287,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		goto failed;
 #endif
 
-	if (!prepare_alloc_flags(&gfp, 0, ALLOC_DEFAULT, &ac.alloc_flags,
+	if (!prepare_alloc_flags(&gfp, 0, alloc_flags, &ac.alloc_flags,
 				 &fastpath_alloc_flags))
 		goto out;
 
@@ -5296,7 +5298,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 				 &fastpath_alloc_flags))
 		goto out;
 
-	/* Find an allowed local zone that meets the low watermark. */
+	/* Find an allowed local zone that meets the required watermark. */
 	z = ac.preferred_zoneref;
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
 		unsigned long mark;
@@ -5332,8 +5334,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	}
 
 	/*
-	 * If there are no allowed local zones that meets the watermarks then
-	 * try to allocate a single page and reclaim if necessary.
+	 * If there are no allowed local zones that meet the watermarks, try the
+	 * single-page allocator.
 	 */
 	if (unlikely(!zone))
 		goto failed;
@@ -5366,7 +5368,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		}
 		nr_account++;
 
-		prep_new_page(page, 0, gfp, ALLOC_DEFAULT);
+		prep_new_page(page, 0, gfp, fastpath_alloc_flags);
 		trace_mm_page_alloc(page, 0, gfp, ac.migratetype);
 		kmsan_alloc_page(page, 0, gfp & ~__GFP_RECLAIM);
 		set_page_refcounted(page);
@@ -5382,11 +5384,19 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	return nr_populated;
 
 failed:
-	page = __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask, ALLOC_DEFAULT);
+	page = __alloc_pages_noprof(orig_gfp, 0, preferred_nid, nodemask,
+				    alloc_flags);
 	if (page)
 		page_array[nr_populated++] = page;
 	goto out;
 }
+
+unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
+		nodemask_t *nodemask, int nr_pages, struct page **page_array)
+{
+	return __alloc_pages_bulk_noprof(gfp, ALLOC_DEFAULT, preferred_nid,
+					 nodemask, nr_pages, page_array);
+}
 EXPORT_SYMBOL_GPL(alloc_pages_bulk_noprof);
 
 /*
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index 986e733b586e..a09bfd201c3b 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -264,6 +264,10 @@ struct folio *__folio_alloc_flags_noprof(gfp_t gfp, unsigned int order,
 #define __folio_alloc_flags(...) \
 	alloc_hooks(__folio_alloc_flags_noprof(__VA_ARGS__))
 
+unsigned long __alloc_pages_bulk_noprof(gfp_t gfp, unsigned int alloc_flags,
+		int preferred_nid, nodemask_t *nodemask, int nr_pages,
+		struct page **page_array);
+
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
-- 
2.55.0

