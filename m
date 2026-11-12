Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513170;
	b=nYWFDDCQUvP/7+n1+o9g72XDCgzEACX99SGEcM63kKbbSFH1l6/AQewmb44W1GAQ8GbV
	 1EYjau8ctOLZOQcGYP3TFsH1tuJ3lbdWfU1D8qZ+xMT+UeVYsxqau2TRiZi5mllen162O
	 Fx2c+0lTW5Q+1P8HeDbXQupqNueAVg2HJuyEwbBxe7EdFbrgcxD2UN6kOTOo/MUgvwAAo
	 LzqMD/P/2e6pPwMiBO+35fmRMGizG3pJoPcLky2R5f2y5X6n0seTVAzrNDXguJ4RtzLDW
	 4eJIYt79iUQulis46zQ5WEXu+T4ETbyWIpRtSCucUgK2FfPCGu91YEjjpR8qpxhzIpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513170;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6g6Q2Oc4KxDyRr8E2Y5ffCl+6LA2NNHiXLm26F3enDk=;
	b=aggTOCa50ZcPt+BPEOjHPErjqBLsiUViLLH3xHkY2vaAjq7Ua8t4rJCENWn4cfNa1lgI
	 O7n2+INYhN4+mbrF7tHDaP2q4IDTQXqsQlm3NxXQAtjrqlVqLY2KmMiSyXJmDHhMdu0O/
	 2W0C1GS4doO2ho6D01WtRtbAV28nZUxSdfuM2EC4ls1mYwHUjh3bvH6gdeipv4MpSX3+e
	 UOJ+rsri5KgYojnAeNbVLG4iqGCpBxqCGkEeJhzKu4ZRpy5wUqTatCJqtbJsQCP1e6+Kh
	 MSjDlMcKP+yXscPqfC6Arv9Ddpj0p6eRoQ7AwFWdcCtV5+FnwS1Xh8qpzDau2l4tFxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGVBP0Cq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB3606A31C;
	Thu, 12 Nov 2026 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGVBP0Cq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1991F000C4;
	Thu, 12 Nov 2026 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513169;
	bh=6g6Q2Oc4KxDyRr8E2Y5ffCl+6LA2NNHiXLm26F3enDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PGVBP0Cq7hu3Aw59R/1O0fE7lSUgGcOn3+9OHQCe3HyuoSz6a92FnrAyvz8+EPbPa
	 yu7y63LGnBGu1f4FLWbTpUsdlT+e+MmGDiGfGguzDB9RjfGiByDYmwXctb60H1XVPG
	 n7DhppG2/LGiSGaLWbdmJJmRrqSImkajVb0R4o+3beSJB9cV9l1RB+JiAFg8M2Yz0L
	 cRoI8Wkp4eJiBvBD4QahPkfBYkzL+b1N5rwVevc+qmnKlWXpbFBPflPIlAO/djwqut
	 EGCpFo/7a8c29CELEkIsvGusYTeMFuBAZOzBkMsNP8d3VLHjM0l5iyvVdTVrdUbaH+
	 BPC3+JxTwU8uw==
Date: Thu, 12 Nov 2026 19:52:38 +0000
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
Message-ID: <avYVPp7fHNg8WSUB@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-12-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-12-00713d368976@columbia.edu>

hugetlb vs userfaultfd is a bit like the alien vs. predator of worst mm features
of all time (TM)

On Wed, Nov 11, 2026 at 12:55:20PM -0500, Tal Zussman wrote:
> UFFDIO_REGISTER and UFFDIO_UNREGISTER both scan the VMAs of the range
> before changing anything. For a hugetlb VMA, userfaultfd_register()
> rejects a range whose start or end is not huge page aligned there.
> However, userfaultfd_unregister() only checks the start.
>
> An unaligned end only fails later, when vma_modify_flags_uffd() cannot
> split the VMA there. At that point, userfaultfd_clear_vma() already
> cleared the WP or RWP protection. The ioctl returns -EINVAL and the VMA
> stays registered, but accesses to its pages are no longer reported. This
> requires a caller passing a misaligned range.
>
> To fix it, check the end of a registered VMA in the pre-scan as well.
> The ioctl still returns -EINVAL, but no longer unregisters the VMAs
> before the misaligned one first.
>
> Fixes: cab350afcbc9 ("userfaultfd: hugetlbfs: allow registration of ranges containing huge pages")
> Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  mm/userfaultfd.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index bf42fabb5afd..c0076c8b4e9d 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -3983,6 +3983,18 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
>  			goto out_unlock;
>
> +		/*
> +		 * A range ending inside a registered hugetlb vma must end
> +		 * huge page aligned, as in userfaultfd_register().
> +		 */

Hmm I think this is more or less saying what the code is doing :) so I think
unnecessary. Maybe worth using the words 'cursed' and 'eldrich' here to describe
what's going on? Or possibly just e.g.:

	/* See check in userfaultfd_register(). */

> +		if (cur->vm_userfaultfd_ctx.ctx && vma_is_hugetlb(cur) &&

This first check is pretty horrid to spell out loud, maybe do something like:

	do {
		const struct userfaultfd_ctx *vma_ctx = cur->vm_userfaultfd_ctx.ctx;
		...
		if (vma_ctx && vma_is_hugetlb(cur) && end <= cur->vm_end &&
		    end > cur->vm_start) {
		    ...
		}

> +		    end <= cur->vm_end && end > cur->vm_start) {
> +			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);

Could be const?

Also is vma_kernel_pagesize() right? If the VMA is hugetlb, then that'll end up
as hugetlb_vm_op_pagesize() which is huge_page_size(hstate_vma()), but it seems
userfaultfd is full of this crap and yeah ok. Fine :)

> +
> +			if (end & (vma_hpagesize - 1))

Could do:
			if (!IS_ALIGNED(end, vma_hpagesize))

Instead?


> +				goto out_unlock;
> +		}
> +
>  		found = true;
>  	} for_each_vma_range(vmi, cur, end);
>  	VM_WARN_ON_ONCE(!found);
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
