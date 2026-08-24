Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F80430CE2
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579570; cv=none; b=GGVUiYN7QrzOREOIvqQKm/OBdEJ/D1AV35VwAjBWAwfF8SIRAuOe0nSAjyUrzFuw45FPZoij0tZwdxVTUKdAXAvJLB2+husrGo1LZo+z2B88j/d/3J9i2QmcFlcW79WbKpJ/cuGtPrxw30Ci1IeNRRGwjClAi3OK9bikCBu1a38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579570; c=relaxed/simple;
	bh=INQpY4vkmtPsJDoCs8IyTHaF6Ew7wSWtqA9unZfAs40=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YHrW0j4MQ3ds73NYUVYOH9lvXJ50s8XyuK6Ib63RTNuMkQOiGxWFDDYNRVETUSa10WwF7rYimeSGkKbn1mgGdgGfv/JS22j7rClpUqej/Bk93jjsFFv18hvDdy3Aa5tSH/fFThFJzJckmCq+JQkWClySUu3e8grVIIoywbfHdSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hu6X3jGD; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hu6X3jGD"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66ceaade3f1so2138526d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787579568; x=1788184368; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n94V7wbjjjBLybhmkw6p8j8STOH0bCJCKxuuQhNVBOI=;
        b=hu6X3jGDHFD05LuNeJDhlU+vZjMv+Tu2gevXiip4LPrM1pwMF9fjU48iE3OeoCqad0
         sDJg1f9GIkJYdmNuP0hlr3AH5D60sX56d9LSbeDKqG/SVyR21/who9KZKZla2z90wQY6
         zD4Mk6ovSgUncPfhddvClr1Y2hX0t3HrSdB4ksSrawyN5AB4ah4U9qbr2kXCVmpe44TA
         bHJGzyB4wN3le1XTBP/9jQrQK4k3iQw1rIie37nFAGiT02/kwQgl2NWcxaFcc7TvEl7p
         iJD+7cEGcAzuIizJF44H8m69FlNALUnW/Ys1o2KYXs+PNy+0ZKuNzEvRf9qcbE2Lx3kv
         waww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579568; x=1788184368;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n94V7wbjjjBLybhmkw6p8j8STOH0bCJCKxuuQhNVBOI=;
        b=OI2Dq+e0TROygKK389KwVDLz8x+GF/bg0/gC+TuEZAP+JA7R0/pdRapjMUe2t0jFzD
         5YqFIEv9yvNMkkXwdKDi7f8NUdykwK+qtalIdfBUEu8DEYrzWNOqeps8XPgh3Uto5YbW
         V7UyLoatS5BC8/rRYxkt1bbupCCYd96SpdVgME5rQEe1URFK4H1g5lh0jLwZA7O0PJyE
         kBa9QkF9zFEORwVJJ6yL1HBtzS53F8Li/wFU7e/Kka0J7GSo5K0trTzeViehBI6BXiAl
         B2RpQmr5cOP6udSolEoOj71/YO+150Ze6LMmuscmN/zyBlskxi9u+2DcUacUOfc0Bu6x
         r3sA==
X-Forwarded-Encrypted: i=1; AHgh+RrVT0wo3T8DY/9xbObnhThwxy+cVv5h9D54YKXoJNQ5+zKfXanrHnKF8jtD+ecYxB5LdaDcdrl8qy+Hbs6r@vger.kernel.org
X-Gm-Message-State: AFuF++lRtLf1f809/fq+1ynJb+TEEJTPhyUoYvytPMdcDM3MLqEbkoC2
	U/hPr9x1Mwf68ReU6iupzWl2NqzK5Ilx6HhPMAg43tejKGaJ39x/vmHvjxgUA3Fa4A==
X-Gm-Gg: AR+sD10WKkrA8pB7knWYNAzqYqrkg/hudYrS1YtbrAa0gISdVRQOWiVo8ZVXjBEHjgB
	A/PRkK06LBGBLUBUSBbVc3ftKKXM/ajUf4NcJIQg/hb2aaFNdnEgb1/YK1fX1JjeqDIQDDAbSgH
	W61/YqgBCAZ6mr4IehJkM6Jy093Vbg5/ndd86Tu4TnDM6qgDAMX7op1hlxlVjP0euH6Jbo6thIA
	YsXUTkq+8zQmtuwlQRT1ILEnDtFhPJyQL/IIuvznC1wyJahF8tupjkk4gswRs1KbCwDk1VMnf2q
	5SzRD/kaGRfR0KScaenWQWack3X2Qg5jn+B0Gd88dP/jBhBkijN2RUXntixSouoo+EMXv1xs6Q1
	g0ErN5pJ463fUWNZJhgjVAbvzta/M/3vDar5hym9sr/WNyZpdO5N5nMxPnk01ZZZKlLAy0oC4CL
	JbKl8ZY//v1ZDsgMUkKr9QB6I7bosXDLxB6w+4djnwsqIflG5HlCRZQbiH3qS0Ey+aDl3eVqV4Z
	Dwyoc+GNs1j+3jTTqogqWQoWiSfA3eEl3wd6mQq93WZTuJ23XiBndBTmCPgzLsZVAGMgg4=
X-Received: by 2002:a53:cdcf:0:b0:667:b314:aea4 with SMTP id 956f58d0204a3-66ce4a56db4mr7162361d50.16.1787579567501;
        Mon, 24 Aug 2026 06:52:47 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4624f47sm3724257d50.4.2026.08.24.06.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:52:46 -0700 (PDT)
Date: Mon, 24 Aug 2026 06:52:41 -0700 (PDT)
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
Subject: [PATCH 01/25] mm/fbatch: remove !CONFIG_SMP special case of
 folio_activate()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <3f18ab7d-c12a-d2a3-4d3e-f9908f94f27d@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

3.0 commit eb709b0d062e ("mm: batch activate_page() to reduce lock
contention") brought in an ifdef CONFIG_SMP around activate batching:
https://lore.kernel.org/linux-mm/20100805140755.501af8a7.akpm@linux-foundation.org/
shows a sensitivity to bloat that day, not any incompatibility with UP.

No other batching here has a UP alternative, and it's a bit confusing:
simplify mm/folio.c a little by removing it now.

Certainly we can reduce UP bloat (and/or 32-bit bloat) by, say, lowering
FOLIO_BATCH_SIZE from 31: traditionally 16, 14, 15, then raised to 31 by
6.9 commit 9cecde80aae0 ("mm: increase folio batch size"); or by giving
just the static per-cpu folio batches a type of their own with a smaller
array size on UP (1? or a little batching worthwhile even on UP?). But
not right now, it's orthogonal to this series.

And I suspect that the old ifdef led to lru_activate being placed last,
whereas it's usually the second most popular fbatch: move it there, to
match cpu_needs_drain() comment "Check these in order of likelihood that
they're not zero".

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/folio.c | 40 ++++++----------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/mm/folio.c b/mm/folio.c
index d2937600cf72..62b96c9ce19e 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -47,12 +47,10 @@ struct cpu_fbatches {
 	 */
 	local_lock_t lock;
 	struct folio_batch lru_add;
+	struct folio_batch lru_activate;
 	struct folio_batch lru_deactivate_file;
 	struct folio_batch lru_deactivate;
 	struct folio_batch lru_lazyfree;
-#ifdef CONFIG_SMP
-	struct folio_batch lru_activate;
-#endif
 	/* Protecting the following batches which require disabling interrupts */
 	local_lock_t lock_irq;
 	struct folio_batch lru_move_tail;
@@ -349,15 +347,6 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
 	count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
 }
 
-#ifdef CONFIG_SMP
-static void folio_activate_drain(int cpu)
-{
-	struct folio_batch *fbatch = &per_cpu(cpu_fbatches.lru_activate, cpu);
-
-	if (folio_batch_count(fbatch))
-		folio_batch_move_lru(fbatch, lru_activate);
-}
-
 void folio_activate(struct folio *folio)
 {
 	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
@@ -367,25 +356,6 @@ void folio_activate(struct folio *folio)
 	folio_batch_add_and_move(folio, lru_activate);
 }
 
-#else
-static inline void folio_activate_drain(int cpu)
-{
-}
-
-void folio_activate(struct folio *folio)
-{
-	struct lruvec *lruvec;
-
-	if (!folio_test_clear_lru(folio))
-		return;
-
-	lruvec = folio_lruvec_lock_irq(folio);
-	lru_activate(lruvec, folio);
-	lruvec_unlock_irq(lruvec);
-	folio_set_lru(folio);
-}
-#endif
-
 static void __lru_cache_activate_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
@@ -694,6 +664,10 @@ void lru_add_drain_cpu(int cpu)
 		trace_mm_lru_add_drain_tp(cpu, nr_folios);
 	}
 
+	fbatch = &fbatches->lru_activate;
+	if (folio_batch_count(fbatch))
+		folio_batch_move_lru(fbatch, lru_activate);
+
 	fbatch = &fbatches->lru_move_tail;
 	/* Disabling interrupts below acts as a compiler barrier. */
 	if (data_race(folio_batch_count(fbatch))) {
@@ -716,8 +690,6 @@ void lru_add_drain_cpu(int cpu)
 	fbatch = &fbatches->lru_lazyfree;
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_lazyfree);
-
-	folio_activate_drain(cpu);
 }
 
 /**
@@ -825,11 +797,11 @@ static bool cpu_needs_drain(unsigned int cpu)
 
 	/* Check these in order of likelihood that they're not zero */
 	return data_race(folio_batch_count(&fbatches->lru_add) ||
+			 folio_batch_count(&fbatches->lru_activate) ||
 			 folio_batch_count(&fbatches->lru_move_tail) ||
 			 folio_batch_count(&fbatches->lru_deactivate_file) ||
 			 folio_batch_count(&fbatches->lru_deactivate) ||
 			 folio_batch_count(&fbatches->lru_lazyfree) ||
-			 folio_batch_count(&fbatches->lru_activate) ||
 			 need_mlock_drain(cpu)) ||
 		has_bh_in_lru(cpu, NULL);
 }
-- 
2.51.0

