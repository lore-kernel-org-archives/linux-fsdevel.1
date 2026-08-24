Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE44399CC
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581966; cv=none; b=W2rfQPz080FEF4TgSzeMJmMdG3pNmKuxEuxCWjsPQS6Lt2kbmwRRPCty5xbWIbkOkZbvGnteI8QYDonqhHl30NDScCpVBv1etRA5/R7nDAtReFWmETqC0m7OAT1qCdsT+QxxMn+6Rk0rvPFS+k1wQdekVElUjPYVUPpONJrHM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581966; c=relaxed/simple;
	bh=IyiHBlYBydb0+wjSK5zpFY78pBcCj2Msqig9Vh8hGqc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mbbrh97nvv3VrzOtMJZYUJJ2gNIOkmSrX29PbFMJGBs75UhQD9oLR3TJHAV+Z68bSFvSQnE6RDEVEL1k/Ql2dwmYcI9T2oLjKXmxkjV2U9ZvAHetqKL/yp+gusU7kiQyLnuLwOd2km7Qg/51xgz11bYEN1YwSlTZ9YjNJoIVzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ec5CR+rg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ec5CR+rg"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-836ce5d6e85so47810637b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787581964; x=1788186764; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DObH//Sc3+e2cOll9IRNEEzq8JrLC+/wx5igp55m6yw=;
        b=Ec5CR+rgyvv3vc2elUSuTy+DPNhomuft4y+vVpja58FKeJsAp1SD1tCZ+JylsdVUsT
         2QvrtXoAzIK0B0px26LRaYKPScsSxVw6b9FQ3OuCt9pecz0EKz4/Z2PWaODYVAeB+Tux
         Z+Q77ns1SUVNKVJsoVMiF81Bl4j0Mklcv4LsQIY2CZtnaoJrMtcEDxqoaJiuYFQH50cN
         RIRptggEtQ4COT9vmQOtLNHF7I69MxYxAEKMZCS5jTgzCMdFoDOsZppN0yNG/TUkNikU
         7KEtSkL27G3ph3RE6pmzS55nNPm2WXCIXF6BXkGSS/SRreo3r2DEuvx3bIkKG6kjhZP6
         scAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581964; x=1788186764;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DObH//Sc3+e2cOll9IRNEEzq8JrLC+/wx5igp55m6yw=;
        b=BjuLTaCAgWa/X56GQxR3iKgnvHcNmzPrAyC9y2T7W5WXO5Jzkze8Z9GUi+MiacSq6Y
         v8bC5ZYsJtQ5zYis4N8sv5TNUomx/8xNWF6E7rye69cTr+jTF23f3M56tKP3ligd1uXi
         Y7na0KmxJ5G/PmY9RkHNZMpjMN2jTD7ei8bs0MGzHDSnhyTBXK64A41SVtf+YWS2sOhH
         neD/+BvO+hXMpWEQ7+DJ9af6tPLhWBoyc3rGDv2oHfw4h4bYSZJMUOR5oXdmKmXlasg9
         hio3puwnXw2vSZ1M+vizz2p3+UZATe6zaIJ7Ta5BxhfnnbNmLaqvByncCno5aDTr7XfH
         lMFg==
X-Forwarded-Encrypted: i=1; AHgh+Row8XEZZV91RdtnQUHFSvZBDv+UtKvER4o9tjeWFdEQasti2u3zKJHLN2UQrXALfwoW+xXJuVD1JnM64ROZ@vger.kernel.org
X-Gm-Message-State: AFuF++ks5iBytzAnq21jNON7nBsVgKOop7YjPbOX7lRv3LsbRfWtIHsA
	2kG6AMgiz8lCAKTUzyq4smxXNTJpdoZ/YXn7yxAZvvExrVwRBhKh7KaiU8NsOyp7VA==
X-Gm-Gg: AR+sD11JgrWFHvg3pC9rJo4fnJfipYM2Qo5ePyr9hGDqBRfBlIEk71TPTTSdIt/pqZF
	LKkhOQS7Q4VgRAwIPMpJM024oiXWV05KKkZn6vBKdHAU9UIkfEiRAQY4HVcshDK5Vc4ZhZCgak8
	+cNeyoiko7ZDtdX38m8VX5XJSiYV8jgi+05MZGt/KbfDnTqYzEj/Tv7iBX8GFvfo/umaWa6JGmi
	n/TUXEpndoYq+Lob1ThL64IghXqpbUP6t1c9LV3P96L5SgpymVduNkPAdKbMPT3XH+jBN05LLDK
	utMrU2C8nLM/AkKjYL1hERUkeifYQ6xV8V3ZXWEBFu6Vy6nYO5QaPQfoDSiurDHttR2NdToHVoy
	RBmJ40XCg7Qy2uZ0gWuBDUYsKIvpRr18Pcbs3iGD7ChjkblBL0CTFJgQroITN3IzyvNNjQlVUeO
	BfEA4pHeIrV0qVYUtYpj/L+aelzNK2FB0eq0EzvexqwZV2E70sHGUPIbgd2V5GbqsVCDY+K81Zk
	kcJ85dN4fII8lPZkVuhbZvs1w1UIupWRTZKvC+Q2oIPnY2P
X-Received: by 2002:a05:690c:ec7:b0:81d:5155:213b with SMTP id 00721157ae682-84c9587c096mr75848627b3.14.1787581963521;
        Mon, 24 Aug 2026 07:32:43 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cac201719sm34583487b3.43.2026.08.24.07.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:32:42 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:32:38 -0700 (PDT)
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
Subject: [PATCH 17/25] mm/fbatch: no lru_cache_disable() in
 __alloc_contig_migrate_range()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <614c4116-8326-641e-d7bc-534fde0422b9@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Remove lru_cache_disable() from __alloc_contig_migrate_range(). It does
not now benefit from lru_add_drain_all() first; and gains little benefit
from invalidating buffer head LRUs first, since 5.0 commit 80409c65e2c6
("mm: migrate: make buffer_migrate_page_norefs() actually succeed").

This will be more controversial. lru_cache_disable()+lru_cache_enable()
were brought in for CMA page migration, see 5.13 commit d479960e44f2
("mm: disable LRU pagevec during the migration temporarily") through
8cc621d2f45d ("mm: fs: invalidate BH LRU during page migration") - I
guess the testing there must have been on a 4.19-based Android kernel,
without 5.0's buffer_migrate_page_norefs().

It's possible that invalidating BH LRUs perhaps 0 times, perhaps N
times, will average out worse than invalidating 1 time and stopping
everyone else; or that folio_test_clear_lru() failures manifest more
than before (note how folio migration has retries on raised refcount,
but isolate_migratepages_block() no retry on failed test_clear_lru).
But let's give this a try and look out for regressions.

Don't delete lru_cache_disable() yet: leaving stale folio pointers in
the per-cpu fbatches, with folio_try_get() yet to come on them, would be
bad for memory hotremoval: the lru_cache_disable() in offline_pages()
protects from that.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/page_alloc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 083cbcb5bdde..96ab51b78a5f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7135,8 +7135,6 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		.reason = MR_CONTIG_RANGE,
 	};
 
-	lru_cache_disable();
-
 	while (pfn < end || !list_empty(&cc->migratepages)) {
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
@@ -7170,7 +7168,6 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 			break;
 	}
 
-	lru_cache_enable();
 	if (ret < 0) {
 		if (!(cc->gfp_mask & __GFP_NOWARN) && ret == -EBUSY)
 			alloc_contig_dump_pages(&cc->migratepages);
-- 
2.51.0

