Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8C470111
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948994; cv=none; b=ETDeRRy7rbyD1FywOmz0DuozwJJunfmt1MtNbKnA5+4b3gnstV8g0tHKzqVn4kkxNNt2l2/1n/vzRDF8exOWDlHFEtbeKuaJxnfhXCHbtqFhVKQegqrsY3MgmSVsynMaCk+LhrWeNtVNDLTTWyvs96P8mPsiPTgiT+UrLXWZvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948994; c=relaxed/simple;
	bh=KEiTze2su0A1vp1BBKEvxCvYQVjhfCLRRoQ/gxsZ1F8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tyb0jiLQDPwXsNkq5z7v88/svR7M9XIW3zLcYekNUXAjo0fBixR7jPnRoD87Kx0JJx7ubCd5nBIwZJy5BVw6xnzFeBK9KbYZN08+kVeQWue2USCQdD1nt+RyVsVd0M79637MhWxLA5D3Z40WeLfZPW4u1eVbJj1t7awpF4RB6Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwyrAzI+; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwyrAzI+"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdccso8725657b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788948982; x=1789553782; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ovd1KkFuD5rQg51sP3+p0bllsBxKk8b6qXB17QYO0U0=;
        b=hwyrAzI+wvUIgVjo6Lx52WtUrdUvT5rei03O1Ho/0BoeeXp8scCzjMRS+8dh4HtB/M
         qEcFwK+SzHFY66p/gIZuPAyijePIhadcM49qboerkYuSo+xJVo7vGaulp5qeP9dw8a9g
         ROJX/n97KeyHT7Rz4/TnCtz7kazdE2QSaIHxgjr9PTtBIQ4mB0j5GPM4bRgLFKRPu0Bb
         u8b9Ovnho6DBsEHFWNRDE/4FVSP4JoxayygM9QL3IyV/yP1JNNINe15Yl1FxspCm75bJ
         ++vDAjdbxpjWtLcYFicLrpBC0SVgMpADfE4NAtuJyDRwa/Ax0L/qdSz8dg/a6gzPwAet
         YJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948982; x=1789553782;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ovd1KkFuD5rQg51sP3+p0bllsBxKk8b6qXB17QYO0U0=;
        b=Wx9Ef5bQJC2ceqYzd22PJGMJlQtvbcznRhGZPD/dTcHLqr2BTN3Rg2JOFkAFzc+Mvz
         4N1S8uD23mOJopCiboVS+Y0PE6FQbRHJN/Ohv85vXqTuJDf+VMsViFVpGKClzXaJKwwU
         7IQFlzXLVE9G+GMRXcHlD9Zj2Ytj3NstnBmVAW0VGM/FGLEZr+eX9VyNu8MkxxksFMGu
         uijGETH90gdVY71dz9FMRQVxN2Nq6QlzHp/NrOtutB/IegnnrzaWTA0cro5mltkjLuiG
         bBSiRbCnsiqp+twCTJ4w15++FZmDjXUcnUXssr/QKlDpV6nYytVJDlGv/e7tByFW9/xt
         0CVA==
X-Forwarded-Encrypted: i=1; AKwUvBxgRklDUA5CpGQQg+Zf7422TnCQQbXEjJCwSmWenmil43bbFVyl3WSbv8f36P2D3Djc9U1qqXXIVEaV0At/@vger.kernel.org
X-Gm-Message-State: AFuF++m5AhucW2jrhGRm6fRd5oeKYqvkTthM1jqfM1cAZdVc03YJrLqK
	8DN/Gis94BeoiVAoGUDDMjPmOckLvxiSrSw41yiwo/uNRHjCHJGcFKgWulZX12liQw==
X-Gm-Gg: AYBFou33o5Au6vi4+xYT/KQqd2mfwzexpgCZWVUpXiSfPyem5xuh0oMB+sjyawl5U3z
	nZ6MJXUJAfCY3gVfDc6U76eTiNjGPnQqCdzPIlesyX04mwaM7NanbBMXenyoqIrEtXbYQuLKfNe
	wmDoe668+/YPi4GRY8XVxY7/0M+czXXFz9AmrFwEguDslFCbd2PzC5jaoJKxAVnuhcagnU8dxmt
	jFcMC4Y01UFxYV4iTkhKbWI7JwSX/cGHQSNBm/FabaUOnnCou8TW9aOT8pzJV/MaAHs9nNu6e6n
	5okilVuSsqcZmgQBD4uxpshrVwa+6rYnP7yIhMQVQ/cm+QIQiJk7ZfX4sdHzO8bqKEfluVdc52N
	uSGVEH47mhj9mwdolqWsQWLzQDyxEIpP9o7DVkqst7U7zFpKbVYkC6JqgQ2SjsKYOn2BPaoO6eU
	FF4YODHv3CpkaiMu4/DlCBiw7CGrrUvfo5IZx3i6XdAc6+CCGjhPP/2uyOOqcFBOSYYhYW3iOMd
	ziUPiHoKlZEchfi88xMQ1XPJTCqZPv2+W7QaozQTpBCpFckttgp661XpEk=
X-Received: by 2002:a05:690e:484b:b0:670:f743:6eb5 with SMTP id 956f58d0204a3-671030a9c66mr1404195d50.19.1788948981459;
        Wed, 09 Sep 2026 03:16:21 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb4912962sm11717181d50.12.2026.09.09.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:16:20 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:16:16 -0700 (PDT)
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
Subject: [PATCH v2 17/26] mm/fbatch: no lru_cache_disable() in
 __alloc_contig_migrate_range()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <84ed3bf8-da32-3447-0577-052c5d1a56b2@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
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
index 12fac9084c48..3e085a25a776 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7147,8 +7147,6 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		.reason = MR_CONTIG_RANGE,
 	};
 
-	lru_cache_disable();
-
 	while (pfn < end || !list_empty(&cc->migratepages)) {
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
@@ -7182,7 +7180,6 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 			break;
 	}
 
-	lru_cache_enable();
 	if (ret < 0) {
 		if (!(cc->gfp_mask & __GFP_NOWARN) && ret == -EBUSY)
 			alloc_contig_dump_pages(&cc->migratepages);
-- 
2.51.0

