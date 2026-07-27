Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441443D1713
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180607; cv=none; b=FwJG5r8bFKR9JAdQ0V+k47wJbpKUFeX0ENXrZr72hyNLVVv2/rypFJ/6zxgU6zVcLFDaJBSHPrkPAdeGIvaBA21e1OacEUk+vRDQAdn3Kp8FRvQyNacWSY85tf/MJPzbfQ2FoF72hkeqh2UFViWliAKv+uqHVro7JZGvDCbx24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180607; c=relaxed/simple;
	bh=GmIeKk3yq9keCm/8IlQLYkkVUfO/N/RkBFwxXhvmnsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt7TrMcXQeZHsSMILdL86ffK8XrM0cA0gn7h11es/PxuAdQC2uBM8xKKPPnqSrSMgji5f8cHPmY8xHqin80ASdBQ6WYr9wPJCoLhawZc7/nH3jxKrYlr6mMGC5M7FVmUANpW3N9qbWiMy/bDqhtgLi9sFZyBJMEjFNQAbVicYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dECcdZ3E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dECcdZ3E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RXQQvCKPFegovPWBYsHPfyk2YJzL2wBgSj2tapMk4TQ=; b=dECcdZ3EiKFQUVB+L02fve8Jau
	IQlzRYmIde1dgB6atfX9k14pjnwP178ZV7VfKeOqJx4BitXMpKa3gsQxyh8bAI9yoes2n5AqcCW85
	QvR8kVfSZ5awT6mWidhI+atOY0dtBHqRXmQ4HxbVrxv0cR4FKfNwfmjpkvY16Fa+s37FKIxKCfE7g
	/vHloSPg0Xd2qL52vVYVUOwfwq/xEq/60PMXAz7+DAFyYSAoow46lmxqWka09bElkSddSzPAgZKZc
	FI6Zun/sE7d9MOKYhc0IyAvap2xLqdxLfe/yN5mxSn5EVlAzoufOA4mBIzrD5ymEXiKzB8JQeaTFF
	V467TZ/w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woR1N-0000000BJnR-1515;
	Mon, 27 Jul 2026 19:29:53 +0000
Date: Mon, 27 Jul 2026 20:29:53 +0100
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
Subject: Re: [PATCH v6 06/12] mm: Remove locking mf_mutex in
 is_raw_hwpoison_page_in_hugepage()
Message-ID: <amexseZ43DyZjFoE@casper.infradead.org>
References: <20260727181310.2671972-1-willy@infradead.org>
 <20260727181310.2671972-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181310.2671972-7-willy@infradead.org>

Sashiko:
> --- Patch [6]: [PATCH v6 06/12] mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage() ---
> commit dd77b291442dd4b4a9034d9d1b8338037122f7fd
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage()
> 
> This commit replaces the sleeping mf_mutex with a new hwp_page_lock spinlock 
> to protect the linked list of hwpoisoned pages in hugetlb folios. It also 
> converts the list to a normal singly linked list instead of a lockless list.
> 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> 
> [ ... ]
> 
> > @@ -1838,16 +1838,17 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
> >  {
> > -	struct llist_node *head;
> > -	struct raw_hwp_page *p, *next;
> > +	struct hwp_page *p, *next;
> >  	unsigned long count = 0;
> >  
> > -	head = llist_del_all(raw_hwp_list_head(folio));
> > -	llist_for_each_entry_safe(p, next, head, node) {
> > +	next = folio->hugetlb_hwpoison;
> > +	folio->hugetlb_hwpoison = NULL;
> > +
> > +	while (next) {
> > +		p = next;
> > +		next = p->next;
> >  		if (move_flag)
> >  			SetPageHWPoison(p->page);
> >  		else
> >  			num_poisoned_pages_sub(page_to_pfn(p->page), 1);
> >  		kfree(p);
> >  		count++;
> >  	}
> >  	return count;
> >  }
> 
> [ ... ]
> 
> > @@ -1959,7 +1966,11 @@ static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
> >  	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
> >  		return 0;
> >  
> > -	return __folio_free_raw_hwp(folio, move_flag);
> > +	spin_lock_irqsave(&hwp_page_lock, flags);
> > +	count = __folio_free_raw_hwp(folio, move_flag);
> > +	spin_unlock_irqrestore(&hwp_page_lock, flags);
> > +
> > +	return count;
> >  }
> 
> Could this cause IRQ latency spikes by executing a loop of kfree() calls
> inside an IRQ-disabled spinlock?
> 
> Since __folio_free_raw_hwp() detaches the list at its start by setting
> folio->hugetlb_hwpoison = NULL, would it be better to only hold hwp_page_lock
> during the detachment, and perform the while loop that frees the elements
> after dropping the lock?

I think rearranging the lock & freeing would be unutterably ugly.  Since
the lock is held by the caller (check hugetlb_update_hwpoison()), we'd
have to eithr have a calling contract where __folio_free_raw_hwp()
drops the lock, or __folio_free_raw_hwp() returns the list and it's
the caller's responsibility to free the list after dropping the lock.

Until we actually have data that this is a problem, I will respectfully
decline to follow Sashiko's advice here.
