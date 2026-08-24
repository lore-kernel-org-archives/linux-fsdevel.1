Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65972417BF9
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581673; cv=none; b=Yop911YXia4GbnswvCpun2o3yXqO2MPDh4XSJMtReiU1VmmlOjy8jMqSdbnQ7qNV/s5Bxbyu0QsZCaY1DMT7T14jmcdgYcTF8TRXkXNHNzKrOTg29Ml8qA53GNzbL7jiLFlqbnojc2lpuzwlbRdO2Kyv16mq9fM7MWcNBI71nRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581673; c=relaxed/simple;
	bh=K5tiLB2R8cTQP87kSzydxOBlV+RGaP+4Wl5t2pez52c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZAbLZpRVMj3Quu5kU1aXekQjh3FQac+WGNgGO6S6DHwSNyuplE5rUXYEcctwX7L9YkhmYO7jJgKnmGf0GLLuO4kNsUS1AkjYKgasVyR9rDaX21tIvgCL90JZDsLHc2HHb3H6qpsM8O77N6aSd+RbKbW7V25BL25hqy5l48Vq5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jABRjcEF; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jABRjcEF"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81dfdbd86d1so45455367b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787581671; x=1788186471; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M66vr5Wj9LfuIyfBX17/YRcr9cErJu0CoiHB0PAp+Bg=;
        b=jABRjcEF/5TjwJko1iCIOR8dVyjMem4iahZMg4fJIuUiUIgSGqpWMDL3AeDBrOcA1e
         JUbYqoDsQUUK+OLz5uZmjuKDGbmLy51AYdJ0FsgiME3QQw7FnshKxODGY6pV39e5Mr61
         o2AsY5bXVAJrivZfZZvxaW/bYNOE6mbpezsEgSanQquVE9LYUqvT5hWlS2ueqgES2w+r
         7cPp0pWQ855xC1rK94DmRjToW6jEvyQ/lZLLLYQYhUHjcc9OIsqIATwmWdW01Vz8KiQ0
         T8xydmUk7A0a1wtxF021HYsVou6pNjG0e9UNI66a6YQKXIYjvrWEK19/zaIZUFqYVmLa
         PN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581671; x=1788186471;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M66vr5Wj9LfuIyfBX17/YRcr9cErJu0CoiHB0PAp+Bg=;
        b=IquiysA77TdA48q6RQKkGnoIuT+NZUwiyTVztiCi6iXmpxzNaRddR2K0AY4SMuuTAZ
         oR4n3wXzN+2j2BlQU8GzN137i2nf3hbVz2ni38C1V6NzQ5TVQ/ZBAkRNV0EuATeODLg2
         AuGd8y67W++WF7b4JZ3XzfW1UkTYXkbBRP5p7T729uucskn2aynCU9qMczjLXYRzntt0
         L4+b9c3WccUbhL5C4pyCq92GgBgZjP10+cgLCwnGLMD2Zc62hq51TjPzIxEUjmheTmey
         TfJ7Jttn5efE0cDg50AZ+1gB7W0Y9YCNWzgcRhllkJT/2w7FfOgdVGg+fWslgH/2OcSb
         4PIg==
X-Forwarded-Encrypted: i=1; AHgh+RpxqfR/GqyCD4v/ROTWZ1AX7/1KJVfuPJbW8YmCvN8oDFeQnExcrC1v5XQpWHEMbn8DVBuV6qUOGIyxcXj/@vger.kernel.org
X-Gm-Message-State: AFuF++nFMyIGVDIzhcbe23PPeMlhgAwL7jKtuRrEG8kVWjkKiU0TMaIC
	eYyD1DnRmcfOTRYnlHiLHpmSlHHLl+Y54MY+1SSUiKjYRHB+Ro5yHwsh/MtnqVcIPw==
X-Gm-Gg: AR+sD11kCHC1poAwFMGs7a8SIhbpcS0BenJ//n94pQQ+2Jg1ZkuaJ2nMxIdMo8vU2wa
	iadLzU6b2fQqU2rNrgcOhIX2ER2vpKNTBOjIrN6UPSVp3JM5mFAxzUzhjRMHnJDqJ6wJDRYzCGe
	ruCp6CrcC3RxglBnyuRwj8s8PUOTDs0MimIBf4aflltPiNzPQ916vw2EaR/+l0Lj5YisLQ6MOvO
	dlyaSGqAx8AwLh2oTuMDfelujlBnTNpk2sjIMw7bEB8nvOzNL+6b3WgM7GlRdFwbNnfyZLgLsky
	fB3Yxsu1QxiUcVe3SGSs3TIaZs4EeDTzg9HGGpf1f+c1tyLzRzFBROsvBtW/E7dIb0c7quG6Hsc
	to275YvvWsQzniqpXUfk8wN4pNmIcmasTQiEU35P/z6CqKOvhNU2MJunBcDwEkW0xsMh+nMky+G
	IQOSeTqayJLXv5JkAc/Owf4PvF7oFUdRkV9XMBoWVpPwsded7XtUPo8tU/tU44bhfaVnftiI7FZ
	l5pUe3JxgrQWCEVkTJIEYvOXihn+SJKL9CzH88I4LRJiMHO
X-Received: by 2002:a05:690c:6d81:b0:851:5445:ad5b with SMTP id 00721157ae682-8515445b0cfmr26010647b3.1.1787581670595;
        Mon, 24 Aug 2026 07:27:50 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cacacb78fsm33749697b3.49.2026.08.24.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:27:48 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:27:44 -0700 (PDT)
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
Subject: [PATCH 15/25] mm/fbatch: remove shake_folio() shake_page() from
 memory-failure
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <213f92b1-7ac2-189c-4656-ba7d00cc7666@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

shake_folio()'s lru_add_drain_all() no longer serves a purpose, now that
the per-cpu fbatch references are gone. Are the retries in get_any_page()
then still useful? Not obvious, so keep them.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/hwpoison-inject.c |  1 -
 mm/internal.h        |  1 -
 mm/memory-failure.c  | 38 +-------------------------------------
 3 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index a11222572f97..9eab4b7d25b2 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -118,7 +118,6 @@ static int hwpoison_inject(void *data, u64 val)
 	if (!hwpoison_filter_enable)
 		goto inject;
 
-	shake_folio(folio);
 	/*
 	 * This implies unable to support non-LRU pages except free page.
 	 */
diff --git a/mm/internal.h b/mm/internal.h
index ff4bd3a14539..9a25552cbd83 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1140,7 +1140,6 @@ static inline bool node_reclaim_enabled(void)
  */
 #ifdef CONFIG_MEMORY_FAILURE
 int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
-void shake_folio(struct folio *folio);
 typedef int hwpoison_filter_func_t(struct page *p);
 void hwpoison_filter_register(hwpoison_filter_func_t *filter);
 void hwpoison_filter_unregister(void);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index aaf14608b30e..2a6a01e260ed 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -310,30 +310,6 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 	return ret;
 }
 
-/*
- * Unknown page type encountered. Try to check whether it can turn PageLRU by
- * lru_add_drain_all.
- */
-void shake_folio(struct folio *folio)
-{
-	if (folio_test_hugetlb(folio))
-		return;
-	/*
-	 * TODO: Could shrink slab caches here if a lightweight range-based
-	 * shrinker will be available.
-	 */
-	if (folio_test_slab(folio))
-		return;
-
-	lru_add_drain_all();
-}
-EXPORT_SYMBOL_GPL(shake_folio);
-
-static void shake_page(struct page *page)
-{
-	shake_folio(page_folio(page));
-}
-
 static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 		unsigned long address)
 {
@@ -1459,10 +1435,8 @@ static int get_any_page(struct page *p, unsigned long flags)
 			 * We raced with (possibly temporary) unhandlable
 			 * page, retry.
 			 */
-			if (pass++ < GET_PAGE_MAX_RETRY_NUM) {
-				shake_page(p);
+			if (pass++ < GET_PAGE_MAX_RETRY_NUM)
 				goto try_again;
-			}
 			ret = -EIO;
 			goto out;
 		}
@@ -1477,7 +1451,6 @@ static int get_any_page(struct page *p, unsigned long flags)
 		 */
 		if (pass++ < GET_PAGE_MAX_RETRY_NUM) {
 			put_page(p);
-			shake_page(p);
 			count_increased = false;
 			goto try_again;
 		}
@@ -1627,7 +1600,6 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	LIST_HEAD(tokill);
 	bool unmap_success;
 	bool forcekill;
-	bool mlocked = folio_test_mlocked(folio);
 
 	/*
 	 * Here we are interested only in user-mapped pages, so skip any
@@ -1658,13 +1630,6 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
 		       pfn, folio_mapcount(folio));
 
-	/*
-	 * try_to_unmap() might put mlocked page in lru cache, so call
-	 * shake_page() again to ensure that it's flushed.
-	 */
-	if (mlocked)
-		shake_folio(folio);
-
 	/*
 	 * Now that the dirty bit has been propagated to the
 	 * struct page and all unmaps done we can decide if
@@ -2554,7 +2519,6 @@ int memory_failure(unsigned long pfn, int flags)
 	 * The check (unnecessarily) ignores LRU pages being isolated and
 	 * walked by the page reclaim code, however that's not a big loss.
 	 */
-	shake_folio(folio);
 
 	folio_lock(folio);
 
-- 
2.51.0

