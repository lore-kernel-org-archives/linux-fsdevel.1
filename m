Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52528433050
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579942; cv=none; b=AdlIrcgkoFBp5CD5D66h86ZBdqdkqbA8WnWk4bczd4RE6WusbhCby5YVEp98b3bQrxh4O7Pd7BJ/7qQ0RK1amqrLROH7HpYdu4ZrvALcA0UfbFpm8WHs4jTataqYA4cBTu4UKYJpvnbQQmEpePhIyWm0bQqotEKDdzYKIKRS1Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579942; c=relaxed/simple;
	bh=VyXPha22ahQxc4HIlWxvGyHCTBNhScu/VLpt/eHz32A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VcWsqPabtm3wAcesn/bqt3sdek9gCOlrZCh+mu39L3EbvnUReo01OEuS62a8A4JlGLKe79WAH84DCQ4zhJR4LqOsQwOMYMvVkK+efC2FSgD0OemrwlVKZ8Tuwe6NCLj0EjZ2yuH7QNbhO5s6KJRytLcSWebWa7V7l7+y6/1SNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFNBQcft; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFNBQcft"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66d110aaa7cso227956d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787579940; x=1788184740; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8DePtEtd6bTjy8gbPPUEJydq7WmfU3cohWIB8nVvJ4g=;
        b=EFNBQcftqm3mUxQIObkidigTaDAlKV7NioBcsr6/HJ/6XySrMXtY0aI4mbeNkNC2gZ
         BBY3gb0o1DKjAcMAE/mq+uxnsfL55YIg7SQLA8tg+ObId46P1xR+I7f3M9vXrCXo6z9F
         fN7LxcHgSQDb/L6LCZbq/Y0NvwzcKRU/TVcsssudYspXWq1EznzHpxnm9edhZzIVtW2n
         iBJxUkRowhpuWMAC/r03p9cuCxHiGIuvjWdXuLfN5ch3nyhrUxPXWMOcIXdz98/UH8mQ
         EIH4FFWeveO5cluEDLxFm0z9keEAqarc+nc4DZEeVREAPeYYLUqxiuGJzG5qIL5Y2FC+
         hezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579940; x=1788184740;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8DePtEtd6bTjy8gbPPUEJydq7WmfU3cohWIB8nVvJ4g=;
        b=C4jxPqq/KaplAZrli+52hpfgFxquxd6uZz4DedwdMtLkKCqrzaEw9p1vj4vWl4Y8fa
         EJAPJ1ZvL1j4sb7m1lFc5TjII7f8nmhOOlgnAUJy+UfY7kDghR1rqmmmDUFrLopYTc1H
         VVGWwI2WORxqw5cSWp3+30HL+0sU5rx2E0317Vwf96zH3U5i66ctgQxVEOKkbjADu4Ge
         umlw1qZkKGiLoqZ0kLKEECHK+UtRNTYB/XDPNB6bmy/jVtqgZqdDhofGdEwaECZBAm6I
         2B38fjRk58qyMSSR16n+G1YEJX49ueo1lDI0BacoPeeC/UWzTXt7ba53pZ7g5V+MIG4m
         d/9A==
X-Forwarded-Encrypted: i=1; AHgh+RokIjdpfEOkCoyOhLnwnWngiwvb1L9U9GPYTqPtzJmstU4lSqbV4ITIZC9x7bEEV9VtwDTn1iIaz555MdNs@vger.kernel.org
X-Gm-Message-State: AFuF++kZ9BkgnFtr6mlHhyVwEumAaXBKPjyzW5MHjG8dEFAMZZIRSnxJ
	iJjFS/9WJ3v6QG7QtNawq9NT1l41MgkfG6WVEB2ilz5Sc2xAdl4S+pyqD9ygqJWtQA==
X-Gm-Gg: AR+sD11LBT+98OHrSy/91et79XUAN8xS+RBaPfhrsPxSXFjlhqxB4e4v+MMpvrEENH3
	TW7wZz6eqPbbQQf7Xy4mFyYM0cQ5RROBaEL1fuohzuUVTHNZO0iLZiYRqvuJ63QcCDEYTSAZBtf
	KFaHqxuX1yJcynQRjRGetP80Tx3tfYo2oyk9p19xToi1hlcWbZ5kfOqBzvU7AFLouj2XAPKD+KL
	WAm1X0tuKyVhU3a0nGJvh29a0CTj9jq8F8/f/02Pb20garR2Khjeh40537e+69AEJlxgD89rWmS
	mLdS33PKU5uzLOdj7cdpK9jGF/wsMRpaQ5nMhq3N+A2fK+Piv6i7Vb++hkAUmgyUJylvZw2iclp
	zztv6nP4QWR6eftQRtmjthpLq8/xk7ExXsbE/ilrizLYGBYd6NbcHgSzdBFNrAeBha7kSDMJ/2a
	NZRuhznrI0Yc4k+X0geEutPKcAIxqVG5WL/c+8Tp1JpEJrXroMTrtUTz5vcM40QFa3SjcHVuz8j
	pTm1u38RKR65MqrcUJQQT/tQHOGPII41iCsbv0HIOsEc3jzg3K+SJGRn54=
X-Received: by 2002:a53:ac9c:0:b0:66c:fb45:77e2 with SMTP id 956f58d0204a3-66cfb457872mr3574386d50.28.1787579939500;
        Mon, 24 Aug 2026 06:58:59 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca68c1b14sm34163727b3.21.2026.08.24.06.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:58:58 -0700 (PDT)
Date: Mon, 24 Aug 2026 06:58:54 -0700 (PDT)
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
Subject: [PATCH 03/25] mm/fbatch: temporarily disable lazyfree and mlock+munlock
 batching
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <9593975e-8732-999a-73d1-37fd332eb840@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

It will not matter if we occasionally get activation or deactivation
wrong; but a mistaken lazyfree (MADV_FREE) would likely cause dataloss.
So disable its batching while reworking the per-cpu fbatch handling,
then re-enable it with more thought afterwards.

Similarly disable mlock+munlock batching temporarily: they will need
some redesign before re-enabling. Just insert one disabling line for
now, leaving the rest of the code as it was, for consideration later.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/folio.c | 2 ++
 mm/mlock.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/mm/folio.c b/mm/folio.c
index b2bce6b77498..a7010ae3edff 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -218,6 +218,8 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		local_lock(&cpu_fbatches.lock);
 
 	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
+			/* XXX Temporarily disable lazyfree batching */
+			fbatch == &cpu_fbatches.lru_lazyfree ||
 			!folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
diff --git a/mm/mlock.c b/mm/mlock.c
index efa6716e4dfb..14c02e155d68 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -255,6 +255,7 @@ void mlock_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
+	    true || /* XXX Temporarily disable mlock batching */
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
@@ -278,6 +279,7 @@ void mlock_new_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
+	    true || /* XXX Temporarily disable mlock_new batching */
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
@@ -299,6 +301,7 @@ void munlock_folio(struct folio *folio)
 	 */
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, folio) ||
+	    true || /* XXX Temporarily disable munlock batching */
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
-- 
2.51.0

