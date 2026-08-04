Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF94772A3
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862728; cv=none; b=WtvbxmX3B5NHjuVJD3xkxfpcVe9sbAi3kyrQBKBYYaMFw1sibXqACASQuV0qztnxlvcU/l8APiis6rOm1k6lu71JpEceK95OeGoUBa9002vFMbVR9mQAzPDVv4Qpj7+GZ3JV/XJ9l+ILr8V1fzf2lbIxJR2dd7orDjt7Ghsgpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862728; c=relaxed/simple;
	bh=aU1gopZ5E3lIiRZFykslCRAx3GiiKZCKyVhLtJCDR2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgWc888Djl3sHmwMpP9xaqw/y4awjNRkgGf9pXuBoWcwWwS3tK4iUAczO0LuixhGoTbQS0kvxN/3Fufsz5fGOUAoeb4c4KZEOKSlGo+RQFofmysSYu5bF3J1hYD+hTcHIfJKbmcpfC4cB7dNHhu9QqxfZGEZkLmcsmBAw8chaJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dGe+td3k; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dGe+td3k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w0GJoGVxbTlIBAP42YKS4cXI+GskDdJ5ICUAbo2EeCI=; b=dGe+td3k7UwjmVOjPgl3jDZCCu
	CdnD4eYaC6V2CTUkATigem2GiHGmlHomRhH3jIrx5LMmC65izTa6jou+FuAXT8EFvB58hMFtUyPeV
	b292cWiywxz13a4y2kjTMG3QqaipkOoy0gX0mfodrQ8aWTJtlwG/MgC2U7uwmc6MfKPqADKqkSYUu
	xrV+x1MxnkdZIucGQC4RAE0vzePNhUdX9GcqCBlU/lEQPQDpCmv2PjIIBvk/EhS5Jl/iaia2vYBI3
	e7kg6ofl610y5oJNQN0sGj/A9dbMicchAvoeov+Bp8c8DIo92e22n8j3czErH7B0BVhVA87bKDP29
	76NVB/aw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrITC-00000004K3v-2AK3;
	Tue, 04 Aug 2026 16:58:26 +0000
Date: Tue, 4 Aug 2026 17:58:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 09/15] mm: Remove locking mf_mutex in
 is_raw_hwpoison_page_in_hugepage()
Message-ID: <anIaMs7XtXp631QU@casper.infradead.org>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-10-willy@infradead.org>
 <anIUe_Zq8bFX0-Dk@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anIUe_Zq8bFX0-Dk@gourry-fedora-PF4VCD3F>

On Tue, Aug 04, 2026 at 12:36:00PM -0400, Gregory Price wrote:
> On Fri, Jul 31, 2026 at 09:07:54PM +0100, Matthew Wilcox (Oracle) wrote:
> > Sleeping in this kind of predicate is unexpected.  Add a new spinlock
> > to protect access to the list, and turn it into a normal singly linked
> > list now that it doesn't need to be a lockless list.
> 
> Out of curiosity, wouldn't sleeping in this context not just be
> unexpected but theoretically cause issues? (mid-poison, sleep, scheduled
> process generates more poison on the same page...) - at a minimum this
> takes a thread out of the future potential poison-generating pool?

A reasonable question.  We don't try to handle races terribly well --
hwpoison can be generated asynchronously by patrol scrub, so it's always
going to be possible for a thread to hit poison on something that the
kernel didn't know about.

What we're trying to do is avoid touching memory which we already knew
to be poisoned, while also permitting touching memory which we haven't
been told is poison.

I see the locking in here as preventing list corruption and UAF rather
than preventing races.  I'm also considering that we're now exposing this
mutex fairly directly to userspace -- before it was only being touched
through some fairly weird mechanisms like reading kcore.  With this
patch series, every call to read() potentially touches this mutex.
And that could hold off recording any hwpoison for some time, not to
mention serialising all other calls to read() on a given folio.

So we have all manner of protections that prevent us from taking this mutex
-- the folio must have a hwpoison page in it and must be hugetlb, but at
the end of the day, one can still be preempted while holding a mutex and
we never know when we might want to call this from a non-sleepable context.

I'd be open to arguments that this should be an rwlock rather than
a spinlock.  Or figure out a way to shard the lock per folio (lockdep
etc make it very hard to embed a spinlock in struct folio).  I think
it'd also be profitable to change how we record poison for hugetlb to
not need locking or memory allocation.

But this is all a very long way from where I want to be working -- cleaning
up the page fault path.  I think I've made a reasonable set of improvements
here, and somebody else can come along later to make the code even better.
