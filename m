Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B45346AC0;
	Wed,  5 Aug 2026 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922194; cv=none; b=UdRFYRvF95tTKlp//NFbCLetc6dA2m2sgW3oSk8F5yclPxko0ZEdGHLXyX+AV0RnhkfoMDVUdM7t8YvTRTtp5JUmyNhrMMyZ1KajpiAh5Cxr3zTDFkfwepItAh5OaZTGVw+45ofhBO9UOT3ZuJhUUpazLVLk1WqIoheTHAjA6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922194; c=relaxed/simple;
	bh=PYNJT8vFG7Wp9GRzPv1qzS9fMJddCPuQjB8CIEbc2Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXhXe7jPLizMtic2mkgu4k1xQ7kZPNTD9D6bGaU0oAbGDxHSikdTuE+AoqGL2srCED8bwiTShiXCyukWmnOkrYu+qpJjHzphwbzfESdl6muQWCJBxdoLU5M9oFXzS/bmrduxuyaQdPkmyOn2z4AthPhFfjJz1f0A3PlAuyWHPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag2H6Enn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag2H6Enn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CEF1F000E9;
	Wed,  5 Aug 2026 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922193;
	bh=/gjtDrTd3eRi22+TbpqZHqyTIg00RD4cowSNfL//SUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ag2H6EnnFi4b+rjAY/vOuSJSppombJiw6yEHEy7W/bgMRsj6+S4B3EhWbErU4pYX7
	 S/nUW4Om/ISFjyJ5TLWoQxid9jVaN4NTRu1/HmvCQQdrfFiIVpGCQ2PKjOcsZFKbWx
	 dGsB6hzGq0UoOE95Cq1AwT+O95gAcTcmYnZcUBQ984wiE+110RP5FFe1DF1ry0Rd8h
	 W57wr2rOnjHXUH06E8Pah5rdwcPf4a3re/C/qRj7I56Op/IKZJ0qri623UPEmi0Sq5
	 2Ehn5nEPZJSyU1L6GNRn0jYgOpJMzCB4nl18Zr20xgDWMXBYkxWD8Ap43Hy0b9xNTK
	 dClMMia43hoJg==
Date: Wed, 5 Aug 2026 10:29:31 +0100
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
Message-ID: <anMBoUbb2_lqiP4d@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-6-e8ecfefea812@kernel.org>
 <4ad4b17b-bae6-4169-8649-bff4a29e7fde@kernel.org>
 <anB9MWSSITYpDibA@lucifer>
 <6ea7cdad-afb1-45af-a63c-30b760fe160d@kernel.org>
 <anLyhaI6kW-EWk13@lucifer>
 <aba0e91c-ab9c-4420-9ed4-9e42cf03ecfb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aba0e91c-ab9c-4420-9ed4-9e42cf03ecfb@kernel.org>

On Wed, Aug 05, 2026 at 11:19:20AM +0200, David Hildenbrand (Arm) wrote:
> On 8/5/26 10:59, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Aug 05, 2026 at 09:35:56AM +0200, David Hildenbrand (Arm) wrote:
> >> On 8/3/26 15:46, Lorenzo Stoakes (ARM) wrote:
> >>>
> >>> No this would be incorrect.
> >>>
> >>> A read-only mapping would become unmergeable here. So this is something apart
> >>> from the rmap aspect,
> >>
> >> I'd assume that we should never even consider anon_pgoff when merging
> >> !is_cow_mapping(), it doesn't make any sense.
> >>
> >> No anon folios -> no anon_vma -> no anon_pgoff
> >
> > You can merge unfaulted ranges is the thing here.
> >
> > But anyway I actually wonder whether this whole branch shouldn't be:
> >
> > 	if (!vma->anon_vma) {
> > 		...
> > 	}
> >
> > Because that way we keep anon_pgoff updated even for MAP_SHARED mappings. This
> > isn't necessary and doesn't impact anything _except_ print_bad_page_map which
> > outputs both pgoffs.
>
> Agreed.
>
> >
> > But it'd be consistent, avoid any confusion about gating on VMA_SHARED, and
> > simplify the code :)
> >
> >>
> >> But I think I am missing one detail here:
> >>
> >>> and it is a contract that upon move of an unfaulted
> >>> mapping (which for read-only anon would always be unfaulted) that vma->vm_pgoff
> >>> is updated.
> >>
> >> "read-only anon": I assume you mean an anon mapping that does not have
> >> VM_MAYWRITE set?
> >
> > A MAP_SHARED mapping of a read-only file becomes a MAP_PRIVATE !VMA_MAYWRITE_BIT
> > mapping and must adhere to the same contract.
>
> Right, but that is not an anon mapping, it's a file mapping that similarly
> cannot have anon folios, ever.
>
> >
> > Also mmap hooks can clear the VMA_MAYWRITE_BIT.
>
> Right, but again, if we'd have that being done to anon mappings, other things in
> MM would already be broken.
>
> We assume that anon folios can only ever end up in cow mappings.
>
> >
> > However:
> >
> > - If you're a driver clearing VMA_MAYWRITE_BIT you should only be doing this for
> >   'special' mappings anyway (I have a series I've not sent yet that establishes
> >   this as an invariant also) - and these are not mergeable anyway.
>
> Jup.
>
> >
> > - If you're a !VMA_MAYWRITE_BIT MAP_PRIVATE-file backed mappings you never set
> >   vma->anon_vma and always update anon pgoff so you always have alignment for
> >   purposes of merge.
>
> Jup.
>
> >
> > So I think also we can then change needs_adjacent_anon_pgoff() to:
> >
> > static bool needs_adjacent_anon_pgoff(const struct vma_merge_struct *vmg)
> > {
> > 	return vmg->file && is_cow_mapping(...);
> > }
>
> Agreed.
>
> >
> > [I have to create a vma_flags_t variant of is_cow_mapping()]
> >
> > With those two changes we gate on VMA_SHARED_BIT nowhere :)
>
> That's much clearer.

Yes agreed :)

>
> I was thinking for a second whether to have a more expressive
> "mapping_might_have_anon_folio" or sth like that. But it's a bit mouthful.
>
> Most instances of is_cow_mapping() in memory.c want to know exactly that.

Yeah and obviously once scalable CoW is in even that name will be wrong :)

I think the semantics are a non-obvious but I do like that we are explicit in
saying 'is a CoW mapping'. We just maybe need to be more consistent with that.

Maybe once scalable CoW is in can work to improve consistency of that...

>
> >
> >>
> >> I recall that that's a combination that cannot be created. While you can create
> >> something that does not have VM_WRITE set, IIRC VM_MAYWRITE is always set for
> >> anon vmas.
> >
> > For pure anon yeah, see above for the MAP_SHARED->MAP_PRIVATE-file backed weird
> > case.
> >
>
> Agreed.

Cool will make the changes as above then! :)

>
> >>
> >> --
> >> Cheers,
> >>
> >> David
> >
> > (It's funny to me that if you want a truly read-only MAP_PRIVATE file-backed
> > mapping (no idea why you would but anyway) you have to MAP_SHARED, but an
> > actually MAP_PRIVATE file-backed mapping of a read-only file is writable [which
> > makes sense obviously] :)
> I guess this boils down to
>
> MAP_PRIVATE of a read-only file allows you to COW. Which is usually what you
> want when placing breakpoints / letting the debugger go wild.
>
> MAP_SHARED of a read-only file doesn't allow you to COW, and can consequently
> never become writable.
>
> It's confusing, yes.

Yeah indeed, it's just amusing to think about, but in practice makes perfect
sense.

Though honestly I wish we didn't remove VMA_SHARED_BIT in this situation and
then rely on the hugely-confusingly-named VMA_MAY_SHARE_BIT for stuff where we
_really_ need to figure out whether it was mapped shared.

But that's another thing :)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
