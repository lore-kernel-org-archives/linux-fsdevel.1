Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAA36657B
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789256028; cv=none; b=BL0IRap8w2OL1wvV+MxB35szwYUrA4ORVOIeWEgvbR5Ls7WroK2sXIFfTCExIYmYmuTWrD8pDLk9he96Pp5K6LpfOkXrrI3/qbzBfYAEYetrE9w44NFRnsxwvI85AfbsP3IGa09ClhyXzeISXCD9CAomZ5kiVEIY1MLTsQZAPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789256028; c=relaxed/simple;
	bh=1gDPSptQeLj0OPrmt+0JnBYsBhx744ZDgc9Dq15UM34=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TE7xqZGG7j4+EHA0EOvLbY15E4bX30Xx51RYrxpIs/fXfk9AJ7lUKIHXvYvTRruWIbNTsi3JOTI8hUHTL0IQLzdgGsPy8qKrxPk5uUze75lMOALFHNTL+eIxt7nJYrVbK3i8LEvM8WjAq15Wf87s3vgS1nDtmHWbK1Y56IV4Is0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyh9oMnz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyh9oMnz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49e6deb520eso10510165e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789256024; x=1789860824; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GfWZA5VorxPvBHCBstYGbBsoifsqUoZdc3SoHINZf28=;
        b=nyh9oMnzKN5gJFcuwcEpkaedunk0sBKBgBUlUwJc5PrqGF1qkDZrLUJjIzy8NdJj9Q
         NtWgzVCpjMMJvGVJ4zh6rH+5gOkhOFb/ZLelzAmdieXV4cbnIYM/hv47hbrYTJ+qgr33
         lNJB7PfQJA9wKZSJB6NLZnY9oCBQE64yiP0vubK0slD8lGLZNq3vcSyyPWQvTbCwaL6o
         U/kNU+Nmi5KcJFg438aAuvSvsQ/yt88jQN2sYBZ3BVz57/jKyERLRGSY6H9hw/g/8r9b
         0dJPu3B+4uhfrdasItNEZbztisXPCyRElJVK6jC2UAgkNJlMnvMWhChd4q6goPg8Cbzz
         flmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789256024; x=1789860824;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GfWZA5VorxPvBHCBstYGbBsoifsqUoZdc3SoHINZf28=;
        b=gGhCavtBgEFIfvnIh0CPEpnmWBCgdtdZpm5NblQA2JZot7oO9Zm7J6b3JU5FWyl1EY
         DRR8dNfeXzum2RRY9SgYG1Ex8Z4R9qO9rE+5EnqbFbvH0hLYTeQnt/EnA+xTmKnwSni8
         nNmetE/nipZa8RsdBgcl08XIWCrkprFTsN4+XlJLKsi1sUsC4vfGYGoUcQuM8OkpFb8e
         COM5wZ25TxhFiYWzJw8Jz0vaHWGdCIUy/at4aX3dL0SUlyYqa6amxyRZUVu17LYtf55p
         MEFyk+s/l84IEOlZ2yYc4psedTgUbcCZFaOL1XxRgRM364iaKYSkzfFrG+WHBj1BeplB
         Leuw==
X-Forwarded-Encrypted: i=1; AKwUvBwMF1pLOEgHG1qrnpRtuam9TA0q9oMSM7iH4pu8fJ9IDCfYsP9hsnLYgERGQ8yf/VlcHY56VlnxvLXOxk+h@vger.kernel.org
X-Gm-Message-State: AFuF++k4bOcytycfvpkdBQWUiVubXAtoMo2zKh4L4mW9s8fGtiAIc4c+
	XZFW+JqvzhsLV1ZBQe6iUVkVDNvdiE5TphNqjieF4ONzgcO0IWwfVE4LtDrAEev3KA==
X-Gm-Gg: AYBFou1MMU0ViGrwK3AdFhPR5LhjgdDYtxX/T0k1/N7VGd2ZAVC6SYUd7x3wBhf4ayU
	WZGQnMF1UiWd9PqMmTTHUyYUZdphvSKtXxPa+B3gnCY7tUtauWU2qkFTEEJMHswXn9wPimLtWIW
	V3dJ+0f7v36BqOH1lz70t3QXWhO6668FibL4ZTJAA5JOBf35LGiiGRBUZCzFCqk7nb4F9xhC2T+
	uYYsLrUqtKd7Pl+0KodxAFncP4LOuKKNHhmkzypxyUNgQXTvE3u4MXt018ILsGDbnAamQW4D3T/
	OwY4QEvqt1wHfYbKWRyT4PzXSBzt5zPxz5SupwgIYaIlu0kQHkqD+mxy4+lS6iKoJgh4AzcZ5OS
	oVSnwZJZVUYGBdLTipXfGjapLEiwIR3qlv/nt+0vcLrFgooqSQe8RYdvEaQ7a1/b2V93gUI2xYv
	/QWyxGzNnlYAM/z5oBST4kG0B3+XqQS3g8rb8HQEVSkLqRc72mArF/0aMAtbhVxJonzFO+lz6GS
	CZvOYVqUsTCPmTNCYzs
X-Received: by 2002:a05:600c:8b41:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49e6198865dmr137086655e9.8.1789256023669;
        Sat, 12 Sep 2026 16:33:43 -0700 (PDT)
Received: from darker.lan (104.157.125.91.dyn.plus.net. [91.125.157.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26be3e35sm266378545e9.2.2026.09.12.16.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 16:33:41 -0700 (PDT)
Date: Sat, 12 Sep 2026 16:33:39 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kas@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>, 
    Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
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
Subject: Re: [PATCH v2 07/26] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
In-Reply-To: <aqLaa4QvXMbQaIWG@thinkstation>
Message-ID: <84fecd13-f1e4-7d40-94c9-963f5c2f7aee@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com> <c44a34f8-ea3c-48cd-27d5-02df129be685@google.com> <aqLaa4QvXMbQaIWG@thinkstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 10 Sep 2026, Kiryl Shutsemau wrote:
> On Wed, Sep 09, 2026 at 02:55:41AM -0700, Hugh Dickins wrote:
> > Implement an equivalent to the old __lru_cache_activate_folio()
> > optimization, to activate a folio recently put in the lru_add fbatch,
> > without having to put it through the lru_activate fbatch too. Neither
> > lruvec lock nor lru bit can guard this safely and efficiently, so resort
> > to try_cmpxchg() on a further, LRU_NEXT_ACTIVATE bit in folio->lru_next.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  include/linux/mm_inline.h |  4 ++++
> >  mm/folio.c                | 23 ++++++++++++++++++++---
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 8420b1276535..8f5efadf9c7c 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -346,6 +346,7 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
> >  enum {
> >  	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
> >  	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
> > +	LRU_NEXT_ACTIVATE,
> >  	NR_LRU_NEXT_FLAGS
> >  };
> >  
> > @@ -358,6 +359,9 @@ bool lru_add_del_folio(struct folio *folio)
> >  	if (!(lru_next & BIT(LRU_NEXT_BATCHED)))
> >  		return false;
> >  
> > +	if (lru_next & BIT(LRU_NEXT_ACTIVATE))
> > +		folio_set_active(folio);
> > +
> >  	WRITE_ONCE(folio->lru.next, LIST_POISON1);
> >  	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
> >  
> > diff --git a/mm/folio.c b/mm/folio.c
> > index a18d8ef6afd5..0b75c3b69d5a 100644
> > --- a/mm/folio.c
> > +++ b/mm/folio.c
> > @@ -256,15 +256,32 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
> >  
> >  void folio_activate(struct folio *folio)
> >  {
> > +	unsigned long lru_next;
> > +
> >  	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
> >  	    !folio_test_lru(folio))
> >  		return;
> >  
> >  	/*
> > -	 * XXX: It is curiously difficult to recreate safely the old
> > -	 * __lru_cache_activate_folio() optimization (folio_set_active()
> > -	 * directly if it's on the local lru_add fbatch): revisit later.
> > +	 * This optimization is intended for the common case of folio
> > +	 * having been recently added to this CPU's lru_add fbatch.
> > +	 * But since other CPUs can now take it at any instant (after
> > +	 * a folio_test_clear_lru()), and we may be migrated to another
> > +	 * CPU, it is simplest just to extend the optimization to all CPUs.
> > +	 *
> > +	 * folio_set_active() would be unsafe without the lruvec lock, and
> > +	 * a folio_test_clear_lru() here might cause a racing drain of the
> > +	 * lru_add fbatch to skip its lru_add(): so use try_cmpxchg().
> >  	 */
> > +	lru_next = READ_ONCE(folio->lru_next);
> > +	while (lru_next & BIT(LRU_NEXT_BATCHED)) {
> > +		if (lru_next & BIT(LRU_NEXT_ACTIVATE))
> > +			return;
> > +		if (try_cmpxchg(&folio->lru_next, &lru_next,
> > +				lru_next | BIT(LRU_NEXT_ACTIVATE)))
> > +			return;
> 
> Hm. What prevents the folio from becoming unevictable under us here?
> I don't see anything.
> 
> __folio_add_lru() wouldn't like it:
> 
> 	VM_BUG_ON_FOLIO(folio_test_active(folio) &&
> 			folio_test_unevictable(folio), folio);
> 
> folio_lru_list() has the VM_BUG() too.

You're right, thank you. I thought I had deleted all such VM_BUG_ONs:
and indeed I had, but only in a patch I later decided was too much for
this series (removing PG_unevictable, using !folio_evictable() in some
places, or folio_test_unevictable() testing another POISON in lru_next).

That excuse is not enough for this series! Yes, I must send a fixup,
but not today.

> 
> I am not sure what the right fix is.
> 
> Maybe lru_add_del_folio() should only call folio_set_active() on
> !folio_test_unevictable() folios?
> 
> Or should we allow occasional active+unevictable

Yes, that's what I did, just removed the VM_BUG_ONs: but I'll need
to check again whether that other patch also had to fix any ordering
of checks. Offhand, probably not: once the "Unevictable LRU" became
an oopsing fiction, it was important to check unevictable first:
unevictable must take precedence, and then it really doesn't matter
whether active is set or not.

> so if they are
> munlocked, they will go directly to active list?

I didn't think of that, but I don't think that "active", set racily
back when the folio was assigned "unevictable", bears much relation
to whether it ought to be put on active or inactive list when later
made evictable again. We should probably be consistent, and
consistent with existing behaviour, that they go to inactive when
made evictable. (I'm not looking at that other patch at present,
I don't recall where active got cleared in it.)

Hugh
