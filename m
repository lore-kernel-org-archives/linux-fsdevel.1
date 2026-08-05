Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288513E49F7;
	Wed,  5 Aug 2026 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920381; cv=none; b=u3MSFVEPNc34JFQM+H2MQr1lyYWqt/EJLiOTxCE8XkNnWns+nOGGXNOJVG+vrM7EeN/uaNeHlGfw38VkHkH1FHvsv6YePCb+LFOwcVCs/3XN1ztJ0RMxt4iUEAJlH7uxYSxGOYj0ZOUbuMVdutkz70Zhr6cQIjnUl4aBopYJYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920381; c=relaxed/simple;
	bh=1Zpye7X5O3XNwKDO5om4yeP7kri9nwvCpDEG6m/bpWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTCMeqo+4GWQzzBJPyIEPZlQsg6nsWQEaR7vQWb57k5L3FlWxOJ1/QqYOcp7Dsee11+SuTsjzYA8t7BYgexk5CdgvS1aU4mSyAZ1+NgEbZuHweHqlIazLVBUUCp3CR+WVxcedgPuItQOLsIqcdnydbCR1lduW5fubu5Dl165ifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+1Rt2ao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+1Rt2ao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018091F000E9;
	Wed,  5 Aug 2026 08:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785920379;
	bh=1yRpRg/YjcbX7C2paRrZom5mhwTrr0QvF5ECsYRO/+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K+1Rt2aozvXZ6W3FHxtBV97CQTGhnvf409HxCGwFj1X7JitOXG86TUEDPv2k6/x1G
	 9O21hqeZLoY80QDCALep3ZAzkMnjq2H4JgVfTCNCL3LSyWqgHDPxpQkvn6OEdCzSTP
	 nFTo5dTvUmevSjaaFR31pHViXEAjraEDTdHwz8ddfwS+yWdKF9/yRqpRB/xSbt/oU/
	 9gsWhKTBxLM2/PQ9fPfZu+Y5waWH5MhkyPQergkWmtzoLZgE1MUZ+ljzvSOkksvxg9
	 P3PI82Af/rplRRKV01PYALUmNe+GNe41JF0++hzkt1334sQRaqV8XOvJxYe66oAdn7
	 Fn3FDMZalFhGg==
Date: Wed, 5 Aug 2026 09:59:17 +0100
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
Subject: Re: [PATCH v3 06/15] mm: propagate VMA anonymous page offset on map,
 remap, split + merge
Message-ID: <anLyhaI6kW-EWk13@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-6-e8ecfefea812@kernel.org>
 <4ad4b17b-bae6-4169-8649-bff4a29e7fde@kernel.org>
 <anB9MWSSITYpDibA@lucifer>
 <6ea7cdad-afb1-45af-a63c-30b760fe160d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ea7cdad-afb1-45af-a63c-30b760fe160d@kernel.org>

On Wed, Aug 05, 2026 at 09:35:56AM +0200, David Hildenbrand (Arm) wrote:
> On 8/3/26 15:46, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Aug 03, 2026 at 12:52:42PM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/29/26 18:48, Lorenzo Stoakes (ARM) wrote:
> >>> We must correctly update VMA anonymous page offset state on all VMA
> >>> operations that would result in it changing, with special attention given
> >>> to remapping.
> >>>
> >>> We cover most cases by simply updating vma_set_range() to do so (with a new
> >>> anonymous page offset parameter), but also notably must update the merging
> >>> and mapping logic to propagate this parameter correctly.
> >>>
> >>> The remap logic remains the same - we may update the anonymous page offset
> >>> if the VMA is unfaulted, but now this applies to MAP_PRIVATE file-backed
> >>> mappings too, so we update the code to reflect this.
> >>>
> >>> Note that we use __linear_anon_page_index() upon remap as the VMA may be
> >>> shared, in order that we update the field consistently regardless of VMA
> >>> type.
> >>>
> >>> Similarly, pass through anon page offset to the merge logic, updating the
> >>> vma_merge_struct struct to propagate it, and also use
> >>> __linear_anon_page_index() to obtain the anonymous page index so it can be
> >>> safely used for both shared and MAP_PRIVATE file-backed mappings.
> >>>
> >>> Finally, we update insert_vm_struct() to correctly set the anonymous page
> >>> offset on insertion of a VMA.
> >>>
> >>> We simply ensure state is correctly propagated here, so no functional
> >>> changes are intended.
> >>>
> >>> Also while we're here, replace a VM_BUG_ON_VMA() with a
> >>> VM_WARN_ON_ONCE_VMA().
> >>>
> >>> Also update VMA userland tests to reflect this change.
> >>>
> >>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >>
> >>
> >> [...]
> >>
> >>>  	struct vm_area_struct *vma = *vmap;
> >>>  	unsigned long vma_start = vma->vm_start;
> >>> @@ -1919,11 +1929,14 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> >>>  	VMG_VMA_STATE(vmg, &vmi, NULL, vma, addr, addr + len);
> >>>
> >>>  	/*
> >>> -	 * If anonymous vma has not yet been faulted, update new pgoff
> >>> -	 * to match new location, to increase its chance of merging.
> >>> +	 * If a vma has not yet been faulted, update its anonymous pgoff to
> >>> +	 * match the new location to increase its chance of merging.
> >>>  	 */
> >>> -	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
> >>> -		pgoff = addr >> PAGE_SHIFT;
> >>> +	if (!vma->anon_vma && !vma_test(vma, VMA_SHARED_BIT)) {
> >>
> >> Could we also use is_cow_mapping() ?
> >
> > No this would be incorrect.
> >
> > A read-only mapping would become unmergeable here. So this is something apart
> > from the rmap aspect,
>
> I'd assume that we should never even consider anon_pgoff when merging
> !is_cow_mapping(), it doesn't make any sense.
>
> No anon folios -> no anon_vma -> no anon_pgoff

You can merge unfaulted ranges is the thing here.

But anyway I actually wonder whether this whole branch shouldn't be:

	if (!vma->anon_vma) {
		...
	}

Because that way we keep anon_pgoff updated even for MAP_SHARED mappings. This
isn't necessary and doesn't impact anything _except_ print_bad_page_map which
outputs both pgoffs.

But it'd be consistent, avoid any confusion about gating on VMA_SHARED, and
simplify the code :)

>
> But I think I am missing one detail here:
>
> > and it is a contract that upon move of an unfaulted
> > mapping (which for read-only anon would always be unfaulted) that vma->vm_pgoff
> > is updated.
>
> "read-only anon": I assume you mean an anon mapping that does not have
> VM_MAYWRITE set?

A MAP_SHARED mapping of a read-only file becomes a MAP_PRIVATE !VMA_MAYWRITE_BIT
mapping and must adhere to the same contract.

Also mmap hooks can clear the VMA_MAYWRITE_BIT.

However:

- If you're a driver clearing VMA_MAYWRITE_BIT you should only be doing this for
  'special' mappings anyway (I have a series I've not sent yet that establishes
  this as an invariant also) - and these are not mergeable anyway.

- If you're a !VMA_MAYWRITE_BIT MAP_PRIVATE-file backed mappings you never set
  vma->anon_vma and always update anon pgoff so you always have alignment for
  purposes of merge.

So I think also we can then change needs_adjacent_anon_pgoff() to:

static bool needs_adjacent_anon_pgoff(const struct vma_merge_struct *vmg)
{
	return vmg->file && is_cow_mapping(...);
}

[I have to create a vma_flags_t variant of is_cow_mapping()]

With those two changes we gate on VMA_SHARED_BIT nowhere :)

>
> I recall that that's a combination that cannot be created. While you can create
> something that does not have VM_WRITE set, IIRC VM_MAYWRITE is always set for
> anon vmas.

For pure anon yeah, see above for the MAP_SHARED->MAP_PRIVATE-file backed weird
case.

>
> --
> Cheers,
>
> David

(It's funny to me that if you want a truly read-only MAP_PRIVATE file-backed
mapping (no idea why you would but anyway) you have to MAP_SHARED, but an
actually MAP_PRIVATE file-backed mapping of a read-only file is writable [which
makes sense obviously] :)

--
Cheers, Lorenzo
