Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB83EEAF9
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900486; cv=none; b=BuunKwYK3tM4qnDi3Dq6VmJcihtUGJTJJJGRjvQWXe3niCAx8Xt/ESuC7pLubiRYUxGuBRuGZKrVofn+apXsyQYaWnuzCMKnE5+CCF2rlpO4CyYl6vpc4rH0VrJF7mgpL88uWFBOPOEPhWiUotoSmyJ3B6cazzv89qgxgT0UbCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900486; c=relaxed/simple;
	bh=ZCv5Qi096f1Eumq1LyPI741coh2cKoZ4il8WBRAbV6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHVCja952i0UUgI3yy64UubcXPfWGyJ8e5qhj2jW7lBNRjKdWuHlc8i5+oHVjWV9aJG/UiRqQXc2/TaOTwbSSa/OO/uuGXWZVvlCdwllj+sOiz7dbV0GnF2LR5or121LMYdITSoCzzpXYzdtZohlGLrMofTuGg2n+oN5eOK+El8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fjUMa1+b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fjUMa1+b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2oFbcbP9GUrTzCBiqlNDgP43sOQHVXZdlfi2dyJMC18=; b=fjUMa1+bvke2jKzKthKkemhDUm
	Zbl1OGeBkqqkfzRZDRU+H4Sk4I41atce5K3Cme1OQFlyunDlvCg9ttew66CnAJs8Nfzqa8rySK9Oo
	eK4dmC8LpXq5vPS/n1opBpefbBQNO5POCutw7OnfWx/eCia4gSfuYVu+8Kq2Psm4vatrlkVTfd10G
	csrBeWzR00412/bUjYnUdJNAJuGmnyrLAsmFnnFDnC/GR3aNby9iRTyIQlu89+YyVDwzWbFOWJQMS
	PPZLtAr88sEesBwFThVSndwy228sXXs0kJens6Z5v6QXobJnSKRv52qRpDfobvuCKD8YZYoxRZYfl
	pgIo3Naw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnG9N-00000003b4v-3FmK;
	Fri, 24 Jul 2026 13:41:17 +0000
Date: Fri, 24 Jul 2026 14:41:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v4 08/14] mm: Remove locking mf_mutex in
 is_raw_hwpoison_page_in_hugepage()
Message-ID: <amNrfc_FDfEdPaD6@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-9-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-9-willy@infradead.org>

Sashiko review:
> --- Patch [8]: [PATCH v4 08/14] mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage() ---
> commit c0f68557b399585852271ea0bc6a590caa47b3ad
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage()
> 
> This commit removes the mf_mutex protection from the raw hwpoison list
> iteration in hugetlb_page_hwpoison(), relying on lockless llist traversal
> using READ_ONCE(). It also renames the function and modifies it to take a
> folio.
> 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 4200deab2c3c4..5076ee5d4788d 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> [ ... ]
> > @@ -1817,37 +1817,30 @@ struct raw_hwp_page {
> >  	struct page *page;
> >  };
> >  
> > -bool is_raw_hwpoison_page_in_hugepage(struct page *page)
> > +/*
> > + * Check if a given @page in a hugetlb folio is HWPOISON.
> > + */
> > +bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page)
> >  {
> [ ... ]
> > -	mutex_lock(&mf_mutex);
> > -
> > -	llist_for_each_entry(p, folio->hugetlb_hwpoison.first, node) {
> > -		if (page == p->page) {
> > -			ret = true;
> > -			break;
> > -		}
> > +	llist_for_each_entry(p, READ_ONCE(list->first), node) {
> > +		if (page == p->page)
> > +			return true;
> >  	}
> 
> Is the assumption in the commit message that updates only add to the head of
> the list accurate?
> 
> Looking at __folio_free_raw_hwp() in mm/memory-failure.c, the entire list can
> be concurrently detached and its nodes freed via kfree() without an RCU grace
> period:
> 
>     head = llist_del_all(&folio->hugetlb_hwpoison);
>     llist_for_each_entry_safe(p, next, head, node) {
>         ...
>         kfree(p);
>     }
> 
> This freeing can happen while the folio is still in active use. For example,
> if a subsequent memory failure on the same folio fails a GFP_ATOMIC allocation
> in hugetlb_update_hwpoison():
> 
>     } else {
>         folio_set_hugetlb_raw_hwp_unreliable(folio);
>         __folio_free_raw_hwp(folio, false);
>     }
> 
> Since callers like hugetlbfs_read_iter() explicitly drop the folio lock before
> calling adjust_range_hwpoison() (which triggers this lockless traversal),
> could a concurrent memory failure free these list nodes while this loop is
> still accessing them, leading to a use-after-free?
> 
> > -	mutex_unlock(&mf_mutex);
> > -
> > -	return ret;
> > +	return false;
> >  }

argh.  I give up on this cleverness.  I'm going with the new spinlock
approach (like I did in v3) but retaining the per-folio list of pages
rather than having a global hash table.
