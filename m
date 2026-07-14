Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68574D90D5
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049915; cv=none; b=Pjd+WZnkfaz3HcC8naA+JQmlGllJ/LuPpz28GbChVF2nAEKaAS4E1iibP6OF6z9MkPAm6EYnhWdqQIjCIr7zM1mTXconsPv7rcQv5pApU9A1j9Nu3sKuzw797QWNJBdbJ+gcTOVfOCK6rhqZDViJM5w1U5XnoH1lLMm6K1C88gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049915; c=relaxed/simple;
	bh=0rjRUllXO99qsjwHmgNMvjM5jrrh3sc/obAuzpvuSyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VE8MSPH5ZIQuhmO7IV1+smIGOCWj2Su8C3XD+HuXY8bhpm+Ykzc+wALAc1+kdemllB0ruDgCFSufnZVBUK3pZTetnezNnTRxGWt9CRu/zt9lS+jSJm+fsT203g1UBVqfJLGE9z/BnH1v41l5MwvQ5ReT2XcTfqYCR33y/m/hwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=atzfc17i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="atzfc17i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fsZoDfwIlhAbp3r7mUwgeoodrDtaffoeV+0JAtGpzw4=; b=atzfc17im00kizUwmf4UrzJrhM
	B51VeAg8wl7/56RvIIhi4jrdm3Wr0z2wHzNWXpUa3TBPlhWQmO0n+F3hrdO8Gha5KrCSUn2pEXOud
	D2Nn33Rmn/TeXOYns4lA7SgJS9iBv5usv4xtLimP5rYd88V0Cx9f+ekvoKq/NvE2CrDQCyaCWAsQ0
	LWVHLHY5bY8FbcLbGG1mZlAwSaew7TWZkNZj+p545JnuhhLiIy/NklVCJ0Soko+Vp9hhsBoT8PFNe
	VLYRSgwnpj2fBI8buq0ZcGhh+PACZBx2svipB49TeHlKoPcHgpR01FPueqT3dRt60YJ9+WJpirFk1
	y3u1qVgA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjgsG-0000000Fa2k-3hmU;
	Tue, 14 Jul 2026 17:24:52 +0000
Date: Tue, 14 Jul 2026 18:24:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 06/10] memory-failure: Prevent UAF in raw_hwp_page list
Message-ID: <alZw5EdYVYCRNyj4@casper.infradead.org>
References: <20260709184740.1286561-7-willy@infradead.org>
 <20260710150204.1887475-1-usama.arif@linux.dev>
 <alEpBqExnyvBnnxi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alEpBqExnyvBnnxi@casper.infradead.org>

On Fri, Jul 10, 2026 at 06:16:54PM +0100, Matthew Wilcox wrote:
> I think I'm going to have to change how we track hwpoison in hugetlb
> in order to make this work.  Let me think out loud here:
> 
> is_page_hwpoison() can be called without a reference on the folio
> containing the page.  The answer can be wrong in this case, but any
> UAF must be benign.
> 
> Grabbing the mf_mutex inside hugetlb_page_hwpoison() is insufficient
> because we can't protect against folio_clear_hugetlb_hwpoison() (the
> approach attempted in this patch).
> 
> We could add a spinlock for protecting freeing & checking of the list.
> That's probably simplest.
> 
> It'd be better to protect the list with RCU.  But then we'd need to
> put an RCU head inside raw_hwp_page, doubling its size from 2 pointers
> to 4.
> 
> We could completely change how we do this; instead of having an llist,
> we could have an array of 32-bit page indices.  Reallocate it when we
> run out, doubling its size each time, and put an rcu head in that.
> That'd give us 32-bytes the first time, space for 4 indices, then double
> to 64 (space for 12 indices), double again to 128 (28 indices), etc.
> 
> We could also RCU-free the folio if it's hwpoisoned.  We'd need to
> clear the hugetlb flag before asking RCU to cover up this problem
> to ensure that any reader that saw the hugetlb flag set started its
> grace period before.
> 
> Probably all too much trouble.  I think I'll add a global spinlock.

Sashiko pointed out this doesn't work either (ok, I was reading between
the lines a bit here).

Since we don't have a refcount on the folio, it can be freed at any
time, and the hwpoison list head can be reused for literally anything.
Even if we then recheck that the folio is still hugetlb once we've got
the spinlock, it might have been transformed back to being a hugetlb
folio after we loaded garbage from the list head.

So, complete rework.  Instead of storing the poisoned pages in a list
hanging off the folio, keep a global hashtable.  Patch series coming
soon.
