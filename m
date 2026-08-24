Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE727A91D
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583348; cv=none; b=UOp128ALDXbVHeWgfNt/mqiZrivcZzP1s3lMNzvm7saUlHiGDwTX2w/Bdo3eF2LUJYF3iTwkSWIyfCJ1ST2be1XYqZlNuLFFN6/44s62o9pwKszfz5+TTnndjNRvJg34vtwSkzXAGXg3ji9mSTdjBg7+V51Yen+qjt/GH/KyRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583348; c=relaxed/simple;
	bh=knm7pNivTIqFlTYKZzBy1Fjr0y42IVz+KXlnpElvreo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dQP/ldwciU7lzQfCZG3LwFliFNHytJZe7641gdQieqfDHKZaiP9ipbkG1kVjfiYWBO/1upB7pMLuntLCND8JpP4DbuXzvhnDv9i9o9hr86s44GKQTbb1HEoTrPeifLrPfvwLWU5LQLavTrdOr1hY4W12BFt2aFjNmdt8bEkuFVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8hsbrbg; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8hsbrbg"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836c4474028so41618137b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787583345; x=1788188145; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z3p4N+WdGfy0YyEKXl3GFU0ih7nRgZs+zJqtEvKEyhU=;
        b=I8hsbrbgAAmY8zEWm6yN3s2tydzvsexhIsqS5axTXsiPjqZmWrBrbpgjRxjYJpheHi
         b3jZUbaSx0pQ3NmciCmGaU96IjLJ57GGaXomC/QKP5lRWFyjLDW1qG+tVUNOUL3EuWHy
         CN5Lm+JdOkUPVIh1f2HjYc2+qFYEHBid6+g+U26B0lkzdpXtANpROwewBL/0e84hP4fY
         M6xWKtW/XPxD+5b5ZBiLqutnvdEpeMupUPgolBhU6i6ZDn5+Xhs1SlKB7enTEzX6EQVm
         qmmhXH5Wg9zhzCBiBnd9oVbZFZ7vedAoP0D+xs2YsZIcWnYZudWtldo0Xe7Btrfe6Arb
         UoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583345; x=1788188145;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z3p4N+WdGfy0YyEKXl3GFU0ih7nRgZs+zJqtEvKEyhU=;
        b=KBG5UxX1vG+Va6HrYemR4dGFpHy+cip4SCyHjfkdnszQNVcHseTxPlp7A4utPOaNmr
         7L1mg/YInN/Uzx1TGUv21l857oEm3WSKxt6gO3Zaf8UbbsOgGlKMnYi+gcKZJkEYgumy
         qMgdNdUvS/Sa/s/nHNzOMz/0G7CSapSNXy73xomVv4VCKvlFu/SCnuoldI3YIiv+4fc9
         HaEco4Twn4ZK6d0UN1ElR0N+oo8WDLMqMGrUwelDmyutKPd0Vhta4wq0C9ZJpX/fXDvH
         iUxUiXh0kaqYPYJ+I3FvsV+NUmxEylDnSshkR7qm46DZbK/NYOLUS/1cqSGJg5LY6WqL
         nKmg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5/lpYfS8wgoTb8OuM0AYktLWGf3OAe4XkJVi8SL1MUHovuPbRYwtFhJkcZEf4O5y+YbmtkAeWbpJdPGkz@vger.kernel.org
X-Gm-Message-State: AFuF++lyubDAYAnXK54ed9OBzWw5ueUZ5yxSiC2ehCAX+aPk11Bh+Jnr
	cNmfbtBQmI5M/d2sxVEPmWYLot0cH9DY2iQn9LZcf9GT2vSW20Okh7OA4y4BBYqkWw==
X-Gm-Gg: AR+sD12sJzOGE9P5zyQwpxKf0DZoq4kj4WJjhBR125Ecxwd85+n2m2+Oj1JcUFaFLXM
	FeQjyoAR62FBcVSEGI8Xkqo372q0HTkGVUHraabz49bUmLr2RL2oLbwtTWnaSReoHUrefygIwAB
	5mMn/BAOVOLkMllJ0vMXvEIFpKObNdqXkJW14PLXdYDoxoMFskrM7hWL3mWQCB8pmiu5bxXr9PD
	JsNFUWD9pjGb8EDbnSoSE5tWN75m3CU+VMSMvd1ourzOuU+vq2stvpkdZhe3vO+4NhuEEm7mzsu
	i9gPOxEvBhVoWpAGnBrXn9wvSmbO2WsYS/yMrwuQqZrvdtXtL0heXXEkPs4opYSorNGwLIgr+0b
	g5Y1a3NSqYcpGS1pN85w7ss+Lf5BOAmVEZ4GgO0UGD5kza0vW19rfLtwslGNlSGv+OPO/DLMUT7
	5OarUmAJyQgJoiyBvmTXe0gjp7JHCqum6CGt8favQL/jvKVQxht49MKh/dwERZtcF6iiPp066W9
	sH32B/6icXBRn5UEdU3K8c18gV/x8d/X0/kTpTfwurPDJ+o
X-Received: by 2002:a05:690c:b96:b0:845:ddf4:a399 with SMTP id 00721157ae682-849f3007b00mr110178637b3.11.1787583344519;
        Mon, 24 Aug 2026 07:55:44 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca5c2c52csm35086077b3.11.2026.08.24.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:55:43 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:55:39 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH alt 13/25] mm/fbatch: no lru_add_drain() to
 collect_longterm_unpinnable_folios()
In-Reply-To: <fbf3fa74-c646-8855-17e4-e8b35dfd9c14@google.com>
Message-ID: <333bb765-a36d-e07e-d3c4-5ea2f1cadfcb@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <fbf3fa74-c646-8855-17e4-e8b35dfd9c14@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

collect_longterm_unpinnable_folios() has no use for lru_add_drain() nor
lru_add_drain_all(), now that the per-cpu fbatch references are gone.
So remove the recently added lru_cache_drain_for_folio().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Alternate version for use once David Hildenbrand's two commits
here have been pulled from mm.git into linux.git for 7.3-rc1.

 include/linux/swap.h |  8 --------
 mm/folio.c           | 46 --------------------------------------------
 mm/gup.c             |  9 ---------
 3 files changed, 63 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 17c60956c553..ecb877fe61ed 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -302,14 +302,6 @@ static inline void folio_add_lru(struct folio *folio)
 void folio_mark_accessed(struct folio *folio);
 void lru_add_drain_all(void);
 
-enum lru_cache_drained {
-	LRU_CACHE_NOT_DRAINED,
-	LRU_CACHE_DRAINED,
-	LRU_CACHE_DRAINED_ALL,
-};
-void lru_cache_drain_for_folio(const struct folio *folio,
-		unsigned int extra_refs, enum lru_cache_drained *drained);
-
 /* linux/mm/folio-compat.c */
 void mark_page_accessed(struct page *page);
 
diff --git a/mm/folio.c b/mm/folio.c
index 1c03b44362c1..7b309059b302 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -842,52 +842,6 @@ void lru_add_drain_all(void)
 }
 #endif /* CONFIG_SMP */
 
-/**
- * lru_cache_drain_for_folio() - drain LRU caches if the caches might hold
- *				 folio references
- * @folio: The folio.
- * @extra_refs: Extra folio references held by the caller.
- * @drained: Drain status for batch folio processing.
- *
- * Drain LRU caches if the caches might hold folio references. Start
- * with a local LRU cache drain, to then drain LRU caches on all CPUs if
- * local draining was insufficient.
- *
- * This function detects LRU cache references by comparing the folio refcount
- * with the sum of the expected folio refcount + extra references held by the
- * caller. Note that we cannot rely on PG_lru to reliably detect all LRU
- * cache references, and there are rare scenarios (concurrent folio (un)mapping)
- * where this function might miss detecting LRU cache references.
- *
- * If @drained is not NULL, the function will avoid re-draining LRU caches
- * when processing multiple folios in a row. In that case, the variable
- * @drained points at must be initialized to LRU_CACHE_NOT_DRAINED before
- * the first invocation by the caller.
- */
-void lru_cache_drain_for_folio(const struct folio *folio,
-		unsigned int extra_refs, enum lru_cache_drained *drained)
-{
-	if (!folio_may_be_lru_cached(folio))
-		return;
-
-	if (!drained || *drained == LRU_CACHE_NOT_DRAINED) {
-		if (folio_ref_count(folio) ==
-		    folio_expected_ref_count(folio) + extra_refs)
-			return;
-		lru_add_drain();
-		if (drained)
-			*drained = LRU_CACHE_DRAINED;
-	}
-	if (!drained || *drained == LRU_CACHE_DRAINED) {
-		if (folio_ref_count(folio) ==
-		    folio_expected_ref_count(folio) + extra_refs)
-			return;
-		lru_add_drain_all();
-		if (drained)
-			*drained = LRU_CACHE_DRAINED_ALL;
-	}
-}
-
 atomic_t lru_disable_count = ATOMIC_INIT(0);
 
 /*
diff --git a/mm/gup.c b/mm/gup.c
index 98fdf7b7baca..e87a77dacdb6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2273,14 +2273,12 @@ static unsigned long collect_longterm_unpinnable_folios(
 		struct list_head *movable_folio_list,
 		struct pages_or_folios *pofs)
 {
-	enum lru_cache_drained drained = LRU_CACHE_NOT_DRAINED;
 	unsigned long collected = 0;
 	struct folio *folio;
 	long i = 0;
 
 	for (folio = pofs_get_folio(pofs, i); folio;
 	     folio = pofs_next_folio(folio, pofs, &i)) {
-		const int pin_refs = folio_has_pincount(folio) ? 1 : GUP_PIN_COUNTING_BIAS;
 
 		if (folio_is_longterm_pinnable(folio))
 			continue;
@@ -2295,13 +2293,6 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		/*
-		 * We drain not only to make the folio_isolate_lru() succeed,
-		 * but also to remove any other folio references from LRU
-		 * caches.
-		 */
-		lru_cache_drain_for_folio(folio, pin_refs, &drained);
-
 		if (!folio_isolate_lru(folio))
 			continue;
 
