Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A260A4B0497
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948514; cv=none; b=Vcpr/A6LPdCmqfUfEIMyE+VFM5p6SFRSTmly2KaLifLkFJ4WcgHbzI9kRFpMmMBB9ssy5kiKzo2/DuUB2HGG47+MiLKW6mEc2luiC9HWhtNzWmoqdQ3/hbF88Jg9Y32ghVnsuw45ZXbB1tIrHsr9dQhqctX0351qjbj193zHjKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948514; c=relaxed/simple;
	bh=sZg+Qi8C9DDFoJlNdlSunXk4grOh7FnoNGg+LOx/5FY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aYCqk5MsVa1+NLcSUJPUdOSyDkgdIfKGxpjmcEAD5ZvuXb7OSoBJIWu7FKm32/idUR/4yg6nsqMXMjWvtPRXQfF8Vz+pe4gaiK2IcOLETg5kSEbSS2kK5ULfckDEZh/BJEOJchGkRFwkLO7SoizSfC5O+fRNwvP7zeB7wVhECZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ts3BOSId; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ts3BOSId"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8623b1e7cb2so36952617b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788948511; x=1789553311; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZP7Izy7OCFS/wAqshdE6rdYOBHqDiQ7cVSskEfKxxg=;
        b=Ts3BOSIdv1kztefoL4iHjCMF8LGMbDIR3PiCq9ZBMOkmakYDnYhZxf2zJe9ChlenVH
         hZ7HyBCXFK2YYUOEPi2iXKgU6bfBipMDLTYFpPLHldzDBdhQgANeVW5Ajn865KrB2SIx
         MzbC1j+Gl/xVDPx0lg+VkdEP1gMB4qYMzIclaJoIa2O51cKzf+RYaFa0d5E41Zah2mWu
         WrTftsSHEjDK80aU3+RzDU98hPnsOQtm9EtzlgecnmIaH7DtgVfgzf0k3t44hQHMK9DL
         mIx9wfH1+l6+KVPF1N3x5yWnDAzLutD1uHaFcfctNnB/U/6xtjBnTQ3E/CwqM3A/IOoz
         x4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948511; x=1789553311;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XZP7Izy7OCFS/wAqshdE6rdYOBHqDiQ7cVSskEfKxxg=;
        b=aV0eWl6MLQzwpr1jPNEE4Np3WmcLBRjsiBzZyZju3oBBGN+m7oWXMj4HbCRNBlYdfu
         GfzYgSPgvvlJL+9FJwEVp6B2PBIZtJ1o3dnhPZSCh9xPFF9KMAU69m3E+lELgr4EVdjw
         OhZnlSWP86Xy6NwOpQvtGdD2rYnQ/FmqnFaYS02zhilACe6FAh1LXBNttwI5gcYDvR9M
         Jg03pPVdMniUQPJnSWsREihPuBjYiUE0YPYhXqfVr7u892H6AC3ecF/9ktxN6Dpg5m/Y
         kPl9aYcZOrUeQUmcAP1ZXU4kos0AaB8ujlSKH050csRncY6hiba1sqkQOyVEaWI1XsgZ
         2NTA==
X-Forwarded-Encrypted: i=1; AKwUvBzAyIZOZcCmhWAO9Vb0PW4Rnqh6lRRq8tdE8TgbmgYxwPE8yhkB6mFiyX85xIGj/eM4XTMI1QCpPMru544f@vger.kernel.org
X-Gm-Message-State: AFuF++nRWfeZYFzjKBHC60GT/cyNwptr6dV+qq4ACe4LKgzUWog/acwm
	i2BNBemKFS1603oR6OZDDIgR+ZmezE9QJAqhtfQNmuV0Ynj2dtIT8WWiuGQtbstMBA==
X-Gm-Gg: AYBFou0EW7cpdg0pn6fBqdnQlNntV+FIe9atNxU1mo76JdFh+TdWbvp4m02UhJe28XW
	/scBOLdx2a59EbRv/WYvbK1LPYpV6RcFNA5Hb759FFkXLAhzAOlIUeMridNlDTdY54Vwz7cC0bg
	rxRTcHlk1LTLbxlhiADG/XeLkCo2ocjUoWuliiMFT7+E/OHjAF30xPKvZi9MzvK5yui8k6VIUzy
	8kS5olPuc2eI/RLk6DTMgRDc++fKqRU5X3wvDH4qLJZC28rTegae/Jd9+/v0vXd4L5VKwmlQwQc
	aT6IRohno7pBLMF1UE5hwgjZZJD1qh4jQ5dHFTmo77R1qFZ6TsLt+fvXFMoETWKP+3y4bxg+zgc
	KsSctjF9yHDScfn7UYAI+Y1sp+lIoQYTn+pRKnvG8tr/PIZmsOKV2IZ9nb54lZ9px9VZUk/tDHe
	dfSGddBj0eUKHx4WAajcGI7pyo5d8bEnXaTkhT62VZJe65hjVWqwKkzVCbjP1zyv/tKWdrklvY3
	18u5DwV+6P6BFORWCpiENSC/5rGMAz0DUpF3CyZMFu/GGUOphVqPddnWHU=
X-Received: by 2002:a05:690e:12c8:b0:66f:bdef:7d95 with SMTP id 956f58d0204a3-66fbdef8a7bmr8856733d50.20.1788948510918;
        Wed, 09 Sep 2026 03:08:30 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8b8fsm12160676d50.2.2026.09.09.03.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:08:29 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:08:23 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
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
Subject: [PATCH v2 13/26] mm/fbatch: no lru_add_drain to
 collect_longterm_unpinnable_folios()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <716d267e-11ea-f400-2cfe-d8775e6ac027@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

collect_longterm_unpinnable_folios() has no use for lru_add_drain() nor
lru_add_drain_all(), now that the per-cpu fbatch references are gone.

Replace the recently added lru_cache_drain_for_folio() by a temporary
stub, so any callers outside mm may build independently of this series.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/swap.h |  9 +++++----
 mm/folio.c           | 48 --------------------------------------------
 mm/gup.c             |  9 ---------
 3 files changed, 5 insertions(+), 61 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a6fad5127118..0052a6890435 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -304,11 +304,12 @@ void lru_add_drain_all(void);
 
 enum lru_cache_drained {
 	LRU_CACHE_NOT_DRAINED,
-	LRU_CACHE_DRAINED,
-	LRU_CACHE_DRAINED_ALL,
 };
-void lru_cache_drain_for_folio(const struct folio *folio,
-		unsigned int extra_refs, enum lru_cache_drained *drained);
+static inline void lru_cache_drain_for_folio(const struct folio *folio,
+		unsigned int extra_refs, enum lru_cache_drained *drained)
+{
+	/* Temporary stub for callers' build independent of mm/fbatch series */
+}
 
 /* linux/mm/folio-compat.c */
 void mark_page_accessed(struct page *page);
diff --git a/mm/folio.c b/mm/folio.c
index 5021639c5494..d66aa2469e86 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -33,7 +33,6 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
-#include <linux/kvm_types.h>
 
 #include "internal.h"
 #include "page_alloc.h"
@@ -843,53 +842,6 @@ void lru_add_drain_all(void)
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
-EXPORT_SYMBOL_FOR_KVM(lru_cache_drain_for_folio);
-
 atomic_t lru_disable_count = ATOMIC_INIT(0);
 
 /*
diff --git a/mm/gup.c b/mm/gup.c
index eb898ea1ee22..fa17f99cbb60 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2266,14 +2266,12 @@ static unsigned long collect_longterm_unpinnable_folios(
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
@@ -2288,13 +2286,6 @@ static unsigned long collect_longterm_unpinnable_folios(
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
 
-- 
2.51.0

