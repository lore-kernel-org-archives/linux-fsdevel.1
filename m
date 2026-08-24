Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA943A809
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581813; cv=none; b=bLangDq+Om5J54TDEk3jw5eQm1x94lnnx/1ZS/MU8tP6PotqhCTyF9QsHYWIVAG1is9OUQX8Yq7aKlId6QAg/v290AlEFVvo6x67TeS2DS6FWoOcPT+qbQD6h7Xs1mg628Xc1W3lhSVkmR1aBs4v4+QJq0UQ6XsWhhNqXBoQyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581813; c=relaxed/simple;
	bh=9DZojNp3mZvt3EkXO4hFRxVx3MJf/eYMKHBe+MyaBCs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QXPtfCSnOEsKDb3/fiMMH0Zx2mrWu7pqQ4XEHX9sE2nir7aThnO8wCgp63Xso+ICuVz51l9PIDDLyS+N1vXHAgf0N07zI9oydeH/SngIyVBauCo8FL7tXhyVnbBHJBc8cBpF4vRYZMgYL/vFjBMlr7gk9GGo4j+l4P6ncO/9TJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/BVKwms; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/BVKwms"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-84c4d4f68c7so38291337b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787581810; x=1788186610; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkA2C/lQgXcypv6Ly6gx3bJF+pwu7LTevogMVJJ14Qg=;
        b=c/BVKwmskUlMdRTYj31BuO49DkQnZEsVS88LeGTloCLEWl67MFMWY9U6KoXZpWhL40
         eRqUhLiCwNUHpoEAUbBakuEAE2RKa+OlK1PdTbgFZGSU6shJu4ef5s3HBzjKEue10BCh
         UaP72LhLPnPAwjIP/0lrcR7VmeJLeBadr6kBuOisMv3a0sLliDOg1cP7hOGxwMRZjqd4
         IOGkyaDIwLoLH9X+/dH6BzXl5D5dmur3c+IMW6zopQSrIza0DobJfZO/OAnCv5ZqcNn5
         oyszmgqtJojMd1wJIu+uEorStzGdD/KvpdkMbeUZCx0S0fyCX+422ZIVPjWNd6EqqMj2
         Yj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581810; x=1788186610;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkA2C/lQgXcypv6Ly6gx3bJF+pwu7LTevogMVJJ14Qg=;
        b=JMF5+vH0y1G74asD048Ka0cJMfT0H+cUUx06fXU0juepnoOZgKqqbw9hIFzTZLQQTV
         ZTK1TOXoxZMZOZjiWuLW6S7VtXkQ5VOcMrNyc38GOTZdKlM91v7YaWlgym1l9tRN1GP0
         RuldNJ0eDGQiNi9R2OMlxFZ5i0vpVuGGIwSfP6/V4u8fxHcPQyG0krbNrFWSRnU5wEVf
         Ne+xZ5Jm+MN2pbLxsOWmvSaOBkgyPyHjbni1Cx/C9X4IwLFdgmyQ1GcV33qR7nNT30fF
         KeSN0hwbLysgHiRs7eUBhJDXjTpePzTFjRhTorchArklZoC3as4iFVjbqeksTFrP+HWn
         fRBA==
X-Forwarded-Encrypted: i=1; AHgh+RpTFtgBjE6pXAVXW4njB+s/UozO4qNFC+d6KaRM+qOwndspeHs90VoZecVJJrXv1BmExWAPP7LBusXK9/Wj@vger.kernel.org
X-Gm-Message-State: AFuF++nqYQbLRLnXYkNgCvADkQjPsAXT0+wvN0wxYuHw7ogkJ+UFjZSs
	ggWjDf0zN9IOxJMUKzCxEkQeQtLzkaWNQPzqVesAiB86Xu70IgAxyQ6l+wfmSqu7PA==
X-Gm-Gg: AR+sD11U2cf2brRQcg9NCKAfIRh6b3gC+dziGvsC+857+4352F5OHjE5QZjHaZhD6Jn
	hStfuW+9jGjaUJHKzSVhgJDLptchTsG2j2ZLJgE6BKtKAykbEzD73kQg6bCmeIOSb0DG+YFoq5O
	FghPs/QgpsN2KarHNNgRXbhtsNzhjpUfLfbmuIRBLwhmx9TzXiqUwW1n5QffACtSJg+3Tzm/YF/
	wapzJsPp4hdf74RyHMqW7zVWqy+AMn4w6+ewQ/0d8x6jzZ+oXlb3WQHPw8qT56BJwRFzZeLdY+c
	R5uj9zslPHUZ9G2IB08YLFQvqyPcY0EiHnTYsVSl+PN4ygG/qv8eeS+JQVSMne17/MNJF99d1Zi
	TYoggwhc/dxRO/0DuCnatz64nBeFt+g5c/UjJpRFCavomV/cFHQZVwWpElLSsqExv3E9XiXtr8b
	FTXo75Xa1L8XdPeSFwqLf8Z1oqfeiHczfWOi8RFuVgjockzdB3JT0sm1ziYrSO2XMGw3Ag3jKNW
	pSLScGfpA4P1NOPPK4araDi/GYmECb/G+IYeIjvE8BMi/84WiQOtGxhYVg=
X-Received: by 2002:a05:690c:e29a:20b0:81e:eaaa:535b with SMTP id 00721157ae682-849f6c946f8mr72860737b3.35.1787581809761;
        Mon, 24 Aug 2026 07:30:09 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84caabb9e88sm34055617b3.29.2026.08.24.07.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:30:08 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:30:04 -0700 (PDT)
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
Subject: [PATCH 16/25] mm/fbatch: remove lru_cache_disable(() from NUMA folio
 migration
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <a5147dfb-cefb-fb9b-7162-b537e54d9bb1@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Remove lru_cache_disable() from mbind(MOVE), migrate_pages and move_pages
syscall handling. They do not now benefit from lru_add_drain_all() first;
they gain little benefit from invalidating buffer head LRUs first, since
5.0 commit 80409c65e2c6 ("mm: migrate: make buffer_migrate_page_norefs()
actually succeed"); and it's a shame that (even without CAP_SYS_NICE)
they can prevent concurrent tasks from enjoying the use of those caches.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mempolicy.c | 7 -------
 mm/migrate.c   | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 501e0b80d7da..44912d707d57 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1343,8 +1343,6 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	long err = 0;
 	nodemask_t tmp;
 
-	lru_cache_disable();
-
 	/*
 	 * Find a 'source' bit set in 'tmp' whose corresponding 'dest'
 	 * bit in 'to' is not also set in 'tmp'.  Clear the found 'source'
@@ -1425,7 +1423,6 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 			break;
 	}
 
-	lru_cache_enable();
 	if (err < 0)
 		return err;
 	return (nr_failed < INT_MAX) ? nr_failed : INT_MAX;
@@ -1530,8 +1527,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (!new)
 		flags |= MPOL_MF_DISCONTIG_OK;
 
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
-		lru_cache_disable();
 	{
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
@@ -1626,8 +1621,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 		putback_movable_pages(&pagelist);
 mpol_out:
 	mpol_put(new);
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
-		lru_cache_enable();
 	return err;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 534908a0839a..bf9fe533a5fb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2360,8 +2360,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	int start, i;
 	int err = 0, err1;
 
-	lru_cache_disable();
-
 	for (i = start = 0; i < nr_pages; i++) {
 		const void __user *p;
 		int node;
@@ -2440,7 +2438,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	if (err >= 0)
 		err = err1;
 out:
-	lru_cache_enable();
 	return err;
 }
 
-- 
2.51.0

