Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E531441A4E6;
	Mon,  3 Aug 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767477; cv=none; b=M2yue75+51T8ncxV0hXydce6o4lTdW7sUOcIqe1hcBzRzCJ5qFBthdVBRNflhzWyF+bwKIVj0Y4szV0n6c1n4pvIsGomsvzW/WY7oXHqqseGdkVeLYYY9xsMGnmM0CsLEGbTQG7iG9WeB2RiC9uLFAFAsT9sSfTifEtAV4v5Hw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767477; c=relaxed/simple;
	bh=aSvBdZE6nlq4BFeRZftVWQJSTAiu0La2CT5cfBp3/aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJieO6r5lW7MbAa9g/GbGQAOkd1wib6Njpy3hPSiXS0Ji1mfXo4HX/eZAV5cgbcewYN/N3eJ3B74BQWRKBNLPsJ9vBlaJQkfLuvid8ExIIHrqKf0+64HFShbuI7rgjjBovFJJ/KpH6CG2DACGUV4MmIo3hh5hdU7BraC+KU+Sbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obVZjkzy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obVZjkzy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A356D1F000E9;
	Mon,  3 Aug 2026 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767475;
	bh=xoBv2nwiA6fR0PFFvYiaUTbf96aV+HIT6crNJ9hQRXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=obVZjkzyBlC4ebjSPgpLrFzutHmHmx3WA28Hq8K+rLLNYCJLpmzrs7+w3PN7t6jyu
	 qBH8DH0ReVhGkw8hODhe7iwvMmL9cd9RC3HPOaCSjmjt3dyIhc3yIFIyr4V9olVidB
	 b50rmP3ozLWFwCPCgjznmA34bO0afGshTLnonO9t9IHuoEmZ3Og2+VfTPT6nHayGTN
	 HXWJmOdwRWXmL07ijHyFXpPOxvTdT56u+h11L7hDUHHPnxP1UxTGinauu6mSeGewXX
	 8o94HmtlWcruO23UIzv/hND55yLYwCVLvceS6tm7ZaUIRvGa/+bmLTgWF54vLiO2oY
	 3KOOt/YQ2aQqw==
Date: Mon, 3 Aug 2026 15:30:53 +0100
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
Subject: Re: [PATCH v3 09/15] mm/rmap: use anon pgoff to track MAP_PRIVATE
 file-backed anon folios
Message-ID: <anCmEhfZPfWI8TGt@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-9-e8ecfefea812@kernel.org>
 <5dcf29d5-2fb4-4550-a3e9-a39645d736c8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dcf29d5-2fb4-4550-a3e9-a39645d736c8@kernel.org>

On Mon, Aug 03, 2026 at 01:32:50PM +0200, David Hildenbrand (Arm) wrote:
> On 7/29/26 18:48, Lorenzo Stoakes (ARM) wrote:
> > Currently anonymous folios belonging to CoW'd MAP_PRIVATE file-backed
> > mappings are indexed by their page offset within the file in which they
> > were originally mapped.
> >
> > This differs from anonymous folios belonging to pure anon mappings which
> > are indexed by their anonymous page offset (the address at which they'd
> > belong in the VMA when first faulted).
> >
> > This change fixes this inconsistency, always indexing anonymous folios by
> > their anonymous page offset regardless of the VMA to which they belong.
> >
>
> Yes, this is great.
>
> > The foundations have been laid such that we need only switch this
> > functionality on such by:
> >
> > * Using linear_anon_page_index() in __folio_set_anon() to assign the
> >   folio's index to the anonymous linear index rather than the file-backed
> >   one.
> >
> > * Otherwise using linear_anon_page_index() in all instances where
> >   anonymous folios are being referenced or manipulated.
> >
> > * Replacing vma_address() with vma_filebacked_address() or
> >   vma_anon_address() as appropriate.
> >
> > * Updating the merging logic to check that anonymous page offsets are
> >   aligned as well as filebacked ones for MAP_PRIVATE file-backed VMAs,
> >   introducing needs_adjacent_anon_pgoff() to figure out when this is
> >   required.
> >
> > * Updating linear_folio_page_index() to invoke linear_anon_page_index()
> >   if the folio is anonymous.
> >
> > * Updating vma_address_end() to use the VMA's anonymous page offset when
> >   pvmw->pgoff is anonymous.
> >
> > * Correcting folio_within_range() to use anonymous page offset for
> >   anonymous folios.
> >
> > This will have no impact on merging of anonymous VMAs, whose page offset
> > and anonymous page offset are identical, nor will it impact shared
> > file-backed VMAs, which will continue to be merged based on the file-backed
> > page offset.
> >
> > However, MAP_PRIVATE file-backed mappings must now be aligned on anonymous
> > page offset as well.
> >
> > In most instances this should have no impact on merging of file-backed
> > mappings, which are usually not merged all that often, let alone
> > MAP_PRIVATE mapped ones, and rarely remapped and faulted before being moved
> > back in place (the case in which a merge may now fail).
>
> Agreed.
>
> [...]
>
> >
> >  /**
> > - * vma_address - Find the virtual address a page range is mapped at.
> > - * @vma: The vma which maps this object.
> > - * @pgoff: The page offset within its object.
> > - * @nr_pages: The number of pages to consider.
> > - *
> > - * If any page in this range is mapped by this VMA, return the first address
> > - * where any of these pages appear.  Otherwise, return -EFAULT.
> > - */
> > -static inline unsigned long vma_address(const struct vm_area_struct *vma,
> > -		pgoff_t pgoff, unsigned long nr_pages)
> > -{
> > -	return __vma_address(vma, pgoff, vma_start_pgoff(vma), nr_pages);
> > -}
>
> Good to see this go.
> [...]
>
> >  	rmap_item->anon_vma = vma->anon_vma;
> > -	rmap_item->linear_page_index = linear_page_index(vma, rmap_item->address);
> > +	/* The VMA is always anon/MAP_PRIVATE-file backed so use anon index. */
> > +	rmap_item->linear_page_index = linear_anon_page_index(vma, rmap_item->address);
>
> You can drop this comment: It's an anon_vma + linear_page_index pair, so the
> anon_page_index is implied.

Ack will do.

>
> [...]
>
> >  	WRITE_ONCE(folio->mapping, (struct address_space *) anon_vma);
> > -	folio->index = linear_page_index(vma, address);
> > +	folio->index = linear_anon_page_index(vma, address);
>
>
> Apart from the LGTM.

Thanks!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
