Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115A43FD2B
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947752; cv=none; b=UDMmHmlJaIGhD9NNt+a8XiyTmAoaFSUTxfHE3/k/XsG2tcGuYzkG5sot9Uyfw36Ds+IoqVNElVGn6bdi+z4VTtdRXMQNTc/Ca62Cf/el5GecUupuiAnZZ0ftbGc3VmhuOe3jqp0z7u/NUO0x9xF6DagB//HKfJUNRgx+xNC4u0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947752; c=relaxed/simple;
	bh=kbaqt5hPDumKhXkheDk4P0vgQgXUA4ehrbmFU/MMECM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ddq9Yr4S8jZ2Dbhi2M+KVRlNFE257LZ2KonKNYoGCAPOMBc3thnPMI3U1qS9PEIpX/8/9AyZLRxcDvoBZPDFh/TOOgsqrK6ozXo4myjFP9+THjWIl+gMDQFGqo7nivh8HSruhmolHQBJEhVqaRkDBPtYCgRVH3G0hVXWmUDu7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPq81nAg; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPq81nAg"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcbso7573957b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788947748; x=1789552548; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9OZ5HJWp6Sq+cHPfV8As3zDywlXal3eQY4p7OoCaDH4=;
        b=UPq81nAgi1NHwETvvlhae7DRR7pQB7Uux4kDjmUA4a8HfV1dnf/uEzAX+acThrkBOu
         lk9L8p9cEGe8MJGhGONrVADoSFcTg4UuLmL4nEfwaea00NQ+zO82DDIDsaAvh7AHAd/n
         ec82RprQTxXaWXZyamg7ECdIPzIH4LIyuMefDOIU8/IJGup5MxBRc5AF0MsXQ7duRVSC
         b8pk+xDTtOD/fDLbZBSKkqqRNOyNzo+SzuuN1TdkbbF6iKWwFr990VE41P+n6bRQPkj6
         CN7IJQkGNWD13IcE7pjIxdouomIM89MvCsf9KhXd9Buadb/Z+lYa812ZbPkYnqa10ngg
         24XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788947748; x=1789552548;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9OZ5HJWp6Sq+cHPfV8As3zDywlXal3eQY4p7OoCaDH4=;
        b=lMlrt7SsWWXPCKK9NcKww0em5Enx4Z3SAAszKy5wp5eAq/H6ZQz67rcx/RgkILia4n
         tusOxOdld6Q0vcTzHoVUvZykdn3zTNzxHhf5qintkZNsbkJUla7mA5/ywjTF26PTPuIw
         OJmgZEZY/zpuaVokY5TORry+dkY28Sc4rAVEHJxjkc4NjQ98eGeph3iexb07Ak7CHywD
         n64NFYofiiaVXy6wiZa7g1dUWjXwepVs1hKkFadfkmNXyV6utItGF0S8VG4K3LwBO6LS
         nmp0k5xi3N1BvFjcE1JoRQFkLIv19hGb+KquhkdnwBoMZ4eKFpOoz77RqRArtSaBigNE
         KyDg==
X-Forwarded-Encrypted: i=1; AKwUvBwVQtisbHrRCkWfpKm1sC1iZdJ9MPETdKp2n6qrCo2gTV/vDK6uyTDCZKoBW3+FvLSjnCUFqKCvCDMmoffJ@vger.kernel.org
X-Gm-Message-State: AFuF++nCJ2seVQuNv9WDG8qgDokzzq0zKykv+2J815k8XbEx/2DV/p2s
	+UHaiw6brRrcnD37lpQdZIopezoZvdnNW7TAoDqsO3QhE7DOxBhCUp/CJmhNtZrC2g==
X-Gm-Gg: AYBFou2tIM/nddCx4qypXiIq2QVhH4iuUKP8AenNNqb8nASoLV5moWZHX4e9S6/D3Ct
	oJBsUN2pstoET5qbQr9QUfUba6ljOvvryPMURYFqCc1uUF46HEdrCBWVonPhyRzzJuFcvTajnco
	ARC+DKM9ygqdCcXNn93CqLp6/0Mx1UPkYLMTQPzriWJiTm4+ZG0KlWqN00CaMtHHf/mhIV5y+6J
	pATlXzuxgrPHAZ3dTPgGC/H2RORz511DKntnCtd4nxkMArUgvfBu4CA0Cc4sSD9JBN0U5HRxmgU
	OZI+M6/BTlgn1ZhbI385ndPDtN/tVm04mRBmzsBjpd/kZuWvoPTRx6OkrvMuvaKMIMJubbKnzgG
	9hrbtDbFtDl+ELbZ9lBgTk6o7L16lJOKzSK9kCMm+SGbSB10tOputzfZr7UCSOlWL0IT7wMMnxG
	6x+Bv7NP2yRfK9B+wHaaLlrIAMY++Ja7vhGzJ2F9EQMWE/YVDaXep0HhRzNN1Nwi9FbLuWb+1th
	9GDI0mNZRxN4xR7A2+4ZOjE4NZgromi5Nvwm+x5A0yh7ItM66xuZsQAWQwwgw2rADc5Hw==
X-Received: by 2002:a05:690c:5885:b0:854:9062:73ae with SMTP id 00721157ae682-87f29d02667mr18443457b3.33.1788947747384;
        Wed, 09 Sep 2026 02:55:47 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714ab77c5csm107163607b3.32.2026.09.09.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:55:46 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:55:41 -0700 (PDT)
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
Subject: [PATCH v2 07/26] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <c44a34f8-ea3c-48cd-27d5-02df129be685@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Implement an equivalent to the old __lru_cache_activate_folio()
optimization, to activate a folio recently put in the lru_add fbatch,
without having to put it through the lru_activate fbatch too. Neither
lruvec lock nor lru bit can guard this safely and efficiently, so resort
to try_cmpxchg() on a further, LRU_NEXT_ACTIVATE bit in folio->lru_next.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm_inline.h |  4 ++++
 mm/folio.c                | 23 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 8420b1276535..8f5efadf9c7c 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -346,6 +346,7 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
 enum {
 	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
 	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
+	LRU_NEXT_ACTIVATE,
 	NR_LRU_NEXT_FLAGS
 };
 
@@ -358,6 +359,9 @@ bool lru_add_del_folio(struct folio *folio)
 	if (!(lru_next & BIT(LRU_NEXT_BATCHED)))
 		return false;
 
+	if (lru_next & BIT(LRU_NEXT_ACTIVATE))
+		folio_set_active(folio);
+
 	WRITE_ONCE(folio->lru.next, LIST_POISON1);
 	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
 
diff --git a/mm/folio.c b/mm/folio.c
index a18d8ef6afd5..0b75c3b69d5a 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -256,15 +256,32 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
 
 void folio_activate(struct folio *folio)
 {
+	unsigned long lru_next;
+
 	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
 	    !folio_test_lru(folio))
 		return;
 
 	/*
-	 * XXX: It is curiously difficult to recreate safely the old
-	 * __lru_cache_activate_folio() optimization (folio_set_active()
-	 * directly if it's on the local lru_add fbatch): revisit later.
+	 * This optimization is intended for the common case of folio
+	 * having been recently added to this CPU's lru_add fbatch.
+	 * But since other CPUs can now take it at any instant (after
+	 * a folio_test_clear_lru()), and we may be migrated to another
+	 * CPU, it is simplest just to extend the optimization to all CPUs.
+	 *
+	 * folio_set_active() would be unsafe without the lruvec lock, and
+	 * a folio_test_clear_lru() here might cause a racing drain of the
+	 * lru_add fbatch to skip its lru_add(): so use try_cmpxchg().
 	 */
+	lru_next = READ_ONCE(folio->lru_next);
+	while (lru_next & BIT(LRU_NEXT_BATCHED)) {
+		if (lru_next & BIT(LRU_NEXT_ACTIVATE))
+			return;
+		if (try_cmpxchg(&folio->lru_next, &lru_next,
+				lru_next | BIT(LRU_NEXT_ACTIVATE)))
+			return;
+	}
+
 	folio_batch_add_and_move(folio, lru_activate);
 }
 
-- 
2.51.0

