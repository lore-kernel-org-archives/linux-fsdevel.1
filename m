Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840183;
	b=fR/2gQ1EBpCOMhS/Y6dGqwq9OiF1ubRwBSJzYcesjCDry4dpm7HR2VE+0PPK6pj+3rfA
	 n/gx31BQA48Oa8H2A4ZEd2no987vGGIEwnuds+7gibJYuv7b1Y6p7ejonscRHigLYC2tp
	 tm2eAQ5FWEiLCL4dRNjJySatjM6gnOGIly7MCvtzGxtdYU4ipKu0HrxcbcL1VqA1V4Sx2
	 hbcpC2ysyOcH5lNGBajFo9fZGm//jtRDaWcdzBH+kCNq7P4K9gxEJ4BfQyhDFZGkCjKh5
	 9UzkigXLHvqEGOuHG4e02Gae7lR5Q1450A7/ElRhNwe84PUCAN5KI7seok03t48p8PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840183;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H5WAUZ0iTMrFbG45MzH2WhaXFaY0UAYECCJjbW+xqiA=;
	b=Mo+ZM7BpA8jEUCUwkFWptbAT5XqnIn9bm/3Z9fOX+peyKraDmVsZq0J3GyatW5XpfppW
	 NBSuTWvrHM8agnuvwtyCqG1EjM3EmB1PF8vw1ehARZ60+rxVULRw6qyGxOL+erB4w6WOv
	 fPZ3xPOGhAlY1xiOJcz+beXTgJSUvf+MruYieEs27Oo9vE/AwiN9TziWou2smU/tNf+mF
	 0SEZNzO5M9fTkzyXAFCshWfA13xEr9o/MZy8TPtJ0ziNJdMoegnXCqBuzYAjWYXXiDlgT
	 h9e/QBdORcMOPAY3zRNoCVk2eZaHAPcP+bwF//HMiRLPK7caahXNj3Jr+9rQBSpdomw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzKb9Hjm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0956606A331;
	Mon, 16 Nov 2026 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzKb9Hjm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4CE1F000C4;
	Mon, 16 Nov 2026 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794840183;
	bh=H5WAUZ0iTMrFbG45MzH2WhaXFaY0UAYECCJjbW+xqiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VzKb9HjmmBkyEZ4KIpHhIBbGQOEabZMQ85PqbrRJmD19QyZbEbdSCbEyig+iXh23O
	 O+QiOMpcMTKltLYJuQn6uMCw1lZi7mG5/kZA8who5MrZa+OfpF/3qQB20PmKeXVpmK
	 tXx/pPqiTJD/BMmDLNLHeu1TvgmVQjilffpNqbgZSOkHVG+l6d24ESLAJ2jEqoLYyV
	 KKlwj5M1rrPkDnTQD7HE6EwfcOLs9vmgAwfVR6A4bC6AzJcUe4usAEp6Tg+dHhDwQr
	 tiYyhKtuFkRNUELLJBOWSWrATlee8METpbtEyBb3zhnv0qpPEk0BUc3RpRXTmWAnUo
	 mvTQHZkDS7kcw==
Date: Mon, 16 Nov 2026 14:42:51 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/12] mm/userfaultfd: check hugetlb end alignment in
 UFFDIO_UNREGISTER pre-scan
Message-ID: <avsWSRC0zw-zD56x@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-12-00713d368976@columbia.edu>
 <avYVPp7fHNg8WSUB@gremlin>
 <2e812a10-e937-40f2-b250-74ccee5f143e@columbia.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e812a10-e937-40f2-b250-74ccee5f143e@columbia.edu>

On Fri, Nov 13, 2026 at 05:34:51PM -0500, Tal Zussman wrote:
> On 11/12/26 2:52 PM, Lorenzo Stoakes (ARM) wrote:
> >
> > hugetlb vs userfaultfd is a bit like the alien vs. predator of worst mm features
> > of all time (TM)
> >
>
> Alien vs. Predator had a sequel... let's see what the mm version of
> that will be :)

AI vs. Maintainer? :P

>
> > On Wed, Nov 11, 2026 at 12:55:20PM -0500, Tal Zussman wrote:
> >> UFFDIO_REGISTER and UFFDIO_UNREGISTER both scan the VMAs of the range
> >> before changing anything. For a hugetlb VMA, userfaultfd_register()
> >> rejects a range whose start or end is not huge page aligned there.
> >> However, userfaultfd_unregister() only checks the start.
> >>
> >> An unaligned end only fails later, when vma_modify_flags_uffd() cannot
> >> split the VMA there. At that point, userfaultfd_clear_vma() already
> >> cleared the WP or RWP protection. The ioctl returns -EINVAL and the VMA
> >> stays registered, but accesses to its pages are no longer reported. This
> >> requires a caller passing a misaligned range.
> >>
> >> To fix it, check the end of a registered VMA in the pre-scan as well.
> >> The ioctl still returns -EINVAL, but no longer unregisters the VMAs
> >> before the misaligned one first.
> >>
> >> Fixes: cab350afcbc9 ("userfaultfd: hugetlbfs: allow registration of ranges containing huge pages")
> >> Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")
> >> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> >> ---
> >>  mm/userfaultfd.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> >> index bf42fabb5afd..c0076c8b4e9d 100644
> >> --- a/mm/userfaultfd.c
> >> +++ b/mm/userfaultfd.c
> >> @@ -3983,6 +3983,18 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >>  		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
> >>  			goto out_unlock;
> >>
> >> +		/*
> >> +		 * A range ending inside a registered hugetlb vma must end
> >> +		 * huge page aligned, as in userfaultfd_register().
> >> +		 */
> >
> > Hmm I think this is more or less saying what the code is doing :) so I think
> > unnecessary. Maybe worth using the words 'cursed' and 'eldrich' here to describe
> > what's going on? Or possibly just e.g.:
> >
> > 	/* See check in userfaultfd_register(). */
> >
>
> Will cut it down.

Thanks!

>
> >> +		if (cur->vm_userfaultfd_ctx.ctx && vma_is_hugetlb(cur) &&
> >
> > This first check is pretty horrid to spell out loud, maybe do something like:
> >
> > 	do {
> > 		const struct userfaultfd_ctx *vma_ctx = cur->vm_userfaultfd_ctx.ctx;
> > 		...
> > 		if (vma_ctx && vma_is_hugetlb(cur) && end <= cur->vm_end &&
> > 		    end > cur->vm_start) {
> > 		    ...
> > 		}
> >
> >> +		    end <= cur->vm_end && end > cur->vm_start) {
> >> +			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
> >
> > Could be const?
> >
> > Also is vma_kernel_pagesize() right? If the VMA is hugetlb, then that'll end up
> > as hugetlb_vm_op_pagesize() which is huge_page_size(hstate_vma()), but it seems
> > userfaultfd is full of this crap and yeah ok. Fine :)
> >
> >> +
> >> +			if (end & (vma_hpagesize - 1))
> >
> > Could do:
> > 			if (!IS_ALIGNED(end, vma_hpagesize))
> >
> > Instead?
> >
> >
>
> I just took this chunk straight from userfaultfd_register() and added the
> ctx check, but I can clean this up while here. userfaultfd_register()
> probably deserves a follow-up too.

Thanks!

>
> >> +				goto out_unlock;
> >> +		}
> >> +
> >>  		found = true;
> >>  	} for_each_vma_range(vmi, cur, end);
> >>  	VM_WARN_ON_ONCE(!found);
> >>
> >> --
> >> 2.39.5
> >>
> >
> > --
> > Cheers, Lorenzo
> >
>

--
Cheers, Lorenzo
