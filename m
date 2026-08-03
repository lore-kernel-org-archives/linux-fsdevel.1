Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540AF30C174;
	Mon,  3 Aug 2026 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767600; cv=none; b=bIQvH9M+mbAmtNDk08cz/G0zc2+Sz0xtHwiOE/GCzqXFwZdOdX1FCjBRw4z9fa48BnwtJM8/RF4O2elH/QnItk1cWZ1C8RPpgSi7ly/Ik0gzK62rSdTeb/HGD3vOLMnZB2JRVNg3JlK7GC4je8L9zOVxkc7tjv4feDruL8pxFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767600; c=relaxed/simple;
	bh=xlN3HMZp7/A1/QoZkhYzXS4toxq0AXF6sxtOeXogk6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYRqRDdb9UskAXObj3jxl9S6qQssaoPREIUEzFs1F09yX53oRVmWqaGkQsAb6zr49ohHCcPMW/11lprUNEsIjUGwwkDCroGa+an9RRYfDQsKfnJfSuh4UycTO82Sfo8JwLrmXWNFz3PZBBYkrmGYQ9qwpiKupsMuzIXSOBZItyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbmNiW3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbmNiW3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F94F1F000E9;
	Mon,  3 Aug 2026 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767599;
	bh=mphLP5S8b/9n/v2PFE9M1KkdjdKyrA/jY3VZr3lL4rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MbmNiW3/tIvlutcDN45W36ceGJ2hcM79xennooUYVZBeIVDH0aG/tT9HWNKOWm+xh
	 G/r0e2vBuWTrZI/VUsJYQZ8SANxl6iIw5Y1jmVW5+dj0izkc6EuYTcrRwfVaAVg3vS
	 64SK04ven+xr+o9Exw3nTVdXa9avymUeBspH8jnoyFDrT38dgW08ABefRcxDFSxY0V
	 wDe+RsJeUwV/j3WaWqNtiqWDpd6x8tSwtufta7hgLv07MfpBDMjSleZyrdlVugbui3
	 UGj2iD5YIX/WvXdNTGOPqq1oxyntG6uGXvQFZSqtWFzAH23kAwJgpfihRlffNDWoKq
	 r2L2Sgc5AEvOA==
Date: Mon, 3 Aug 2026 15:32:57 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 07/15] mm/rmap: track whether the page VMA mapped
 pgoff is anonymous
Message-ID: <anCmQdKzZFRMqcxs@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-7-e8ecfefea812@kernel.org>
 <1b48cf7d-8906-43d4-a85d-5cfad10a12ac@kernel.org>
 <anCcMvnsux22LaWU@lucifer>
 <007258ed-3fd7-4d90-b909-6fdda15e0485@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007258ed-3fd7-4d90-b909-6fdda15e0485@kernel.org>

On Mon, Aug 03, 2026 at 04:02:45PM +0200, David Hildenbrand (Arm) wrote:
> On 8/3/26 15:51, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Aug 03, 2026 at 12:57:44PM +0200, David Hildenbrand (Arm) wrote:
> >>>  /*
> >>> - * Then at what user virtual address will none of the range be found in vma?
> >>> + * At what user virtual address will none of the range be found in vma?
> >>>   * Assumes that vma_address() already returned a good starting address.
> >>>   */
> >>>  static inline unsigned long vma_address_end(struct page_vma_mapped_walk *pvmw)
> >>>  {
> >>> -	struct vm_area_struct *vma = pvmw->vma;
> >>> -	pgoff_t pgoff;
> >>> +	const struct vm_area_struct *vma = pvmw->vma;
> >>> +	const pgoff_t pgoff = pvmw->pgoff;
> >>> +	pgoff_t pgoff_vma_start;
> >>>  	unsigned long address;
> >>> +	pgoff_t pgoff_end;
> >>>
> >>>  	/* Common case, plus ->pgoff is invalid for KSM */
> >>>  	if (pvmw->nr_pages == 1)
> >>>  		return pvmw->address + PAGE_SIZE;
> >>>
> >>> -	pgoff = pvmw->pgoff + pvmw->nr_pages;
> >>> +	pgoff_vma_start = vma_start_pgoff(vma);
> >>> +	pgoff_end = pgoff + pvmw->nr_pages;
> >>>  	address = vma->vm_start +
> >>> -		((pgoff - vma_start_pgoff(vma)) << PAGE_SHIFT);
> >>> +		((pgoff_end - pgoff_vma_start) << PAGE_SHIFT);
> >>>  	/* Check for address beyond vma (or wrapped through 0?) */
> >>>  	if (address < vma->vm_start || address > vma->vm_end)
> >>>  		address = vma->vm_end;
> >>
> >> Am I wrong or are all all changes here completely irrelevant for this patch?
> >>
> >> You mention
> >>
> >> "This is necessary in order to determine the correct VMA page
> >> offset in vma_address_end() when pvmw->nr_pages > 1."
> >>
> >> But I don't spot an effective change here.
> >
> > As per commit message:
> >
> > 	This is laying the groundwork for eventually using anonymous page offsets
> > 	as the index for all anonymous folios.
> >
> > 	No functional change intended.
> >
> > I cannot enable an effective change here, because if I did I'd break the kernel
> > and introduce a bisection hazard.
>
> You can just throw in a patch that cleans that up and avoids messing with confusing pgoff?

You mean do a separate patch for this change?

The existing code is already very confusing :) it becomes worse with the
anon stuff added, hence the change.

I will separate it out assuming this is what you mean?

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
