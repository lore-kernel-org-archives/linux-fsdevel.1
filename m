Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2784B4868;
	Thu, 10 Sep 2026 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057648; cv=none; b=QqCEw+3ZSMH2+8YrKz97Vm3rDW8v0/BZbE8JyQRHGAkpluC3su8jTwcaTrnlim7x4ClOb15BxEz0jL3vWLeqW/2DbTvK1nGfiNTCA4vhLDsVlG+QBHQlY/0OeLwI1wgvQTlFhKeSu7Lz9C08gokQdl1Dv5ETEU6hAicTlfjn+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057648; c=relaxed/simple;
	bh=pKxlCUwTpZe1wTSeVu5fsTltRdASXRnyRRfWh8pz6p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6QQA0RxxufzlQC5x4Mz6v8WnAQ7YzS48m0K/hmMv8m55SivYuRrgQk2sT15nompN0Q3TB9SsYDotcY/ENwS2J3KhjLUTIzlu1S/ZZ8kw2pH58TosHzgpVpMupOhJzjli6G7/7skNLfkFxDggRnxQnx4eNU/ZHGJKAwiygMpWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv3jVlGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv3jVlGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430AC1F000FF;
	Thu, 10 Sep 2026 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789057637;
	bh=3aTGXI/vDH2A0yENDYRp5mBzUsR6PSfcXx9+o09dZsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dv3jVlGCtFEukBdJPnDyi0S9viaPBNEJ7EPE5diPLU/5eJtPhZH2flBsSFScJ/Ga8
	 LermgRTeEUvLmypfEdZd1t5Ip1ra2wmjEs71hq82nmsSdf9BYO8einEhPF2lzGqh9P
	 gDrGEfZGe4kLF1qUJEUdenxUtvu/jJ5gCldCFFvxY7kORb8kBtlu4FDs427OdYO8uu
	 1aacUpMWuMmZT5wvcUAkW4WSUlwq6wswm8Rl2cLyqEpcPSSAy+HFhStdQ3LtZxrKjC
	 8pb4PjO03HhHfacjkAvhrtc+RM2F+TPCaiM3Q7LjwBNjCxuA8FtYIQ6WTRg49L2wYY
	 ZOeQb2Uz/OMIA==
Date: Thu, 10 Sep 2026 17:27:11 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, willy@infradead.org, jannh@google.com, 
	paulmck@kernel.org, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
Message-ID: <aqLUqsoMDfVtjRuN@gremlin>
References: <20260907063918.3432401-1-surenb@google.com>
 <20260907063918.3432401-4-surenb@google.com>
 <4825a2fe-f064-45d7-a7c9-e98de7efe86c@kernel.org>
 <CAJuCfpFL_g7tELjT8p8ExM3tX_v2gNDM9rRKwwefPV_KW=fHfA@mail.gmail.com>
 <8e643f51-a47f-428e-9443-678326288fa6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e643f51-a47f-428e-9443-678326288fa6@kernel.org>

On Wed, Sep 09, 2026 at 09:16:23PM +0200, David Hildenbrand (Arm) wrote:
> On 9/9/26 20:28, Suren Baghdasaryan wrote:
> > On Wed, Sep 9, 2026 at 10:16 AM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 9/7/26 08:39, Suren Baghdasaryan wrote:
> >>> smap_gather_stats() interprets its start parameter to mean vma->vm_start
> >>> when it's set to 0. Eliminate this special interpretation and pass
> >>> vma->vm_start explicitly when needed.
> >>>
> >>> Since smap_gather_stats() operates within a single VMA, we can replace
> >>> walk_page_vma()/walk_page_range() calls with walk_page_range_vma()
> >>> which is simpler and also can be called while holding per-VMA lock.
> >>>
> >>> No functional change intended.
> >>>
> >>> Suggested by: Lorenzo Stoakes <ljs@kernel.org>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> ---
> >>>  fs/proc/task_mmu.c | 40 ++++++++++++++++++++++------------------
> >>>  1 file changed, 22 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >>> index 9908ba32f180..3351decd1172 100644
> >>> --- a/fs/proc/task_mmu.c
> >>> +++ b/fs/proc/task_mmu.c
> >>> @@ -1246,20 +1246,27 @@ get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
> >>>       return &smaps_shmem_walk_vma_lock_ops;
> >>>  }
> >>>
> >>> -/*
> >>> - * Gather mem stats from @vma with the indicated beginning
> >>> - * address @start, and keep them in @mss.
> >>> +/**
> >>> + * smap_gather_stats() - Gather mem stats from @vma.
> >>> + * @priv: proc maps private state.
> >>> + * @vma: The VMA to gather stats for.
> >>> + * @mss: The accumulated stats.
> >>> + * @start: The address from which to start.
> >>>   *
> >>> - * Use vm_start of @vma as the beginning address if @start is 0.
> >>> + * This gathers stats for the whole of the VMA unless the lock was dropped
> >>> + * and VMA grew or got merged and we found it again, in which case we only
> >>> + * gather stats for the remainder of the VMA range.
> >>>   */
> >>>  static void smap_gather_stats(struct proc_maps_private *priv,
> >>>                             struct vm_area_struct *vma,
> >>> -                           struct mem_size_stats *mss, unsigned long start)
> >>> +                           struct mem_size_stats *mss,
> >>> +                           unsigned long start)
> >>>  {
> >>>       const struct mm_walk_ops *ops = get_smaps_walk_ops(priv);
> >>> +     const bool is_partial = start > vma->vm_start;
> >>>
> >>>       /* Invalid start */
> >>> -     if (start >= vma->vm_end)
> >>> +     if (start < vma->vm_start || start >= vma->vm_end)
> >>>               return;
> >>>
> >>>       if (vma == get_gate_vma(priv->lock_ctx.mm))
> >>> @@ -1279,20 +1286,17 @@ static void smap_gather_stats(struct proc_maps_private *priv,
> >>>                * Unless we know that the shmem object (or the part mapped by
> >>>                * our VMA) has no swapped out pages at all.
> >>>                */
> >>> -             unsigned long shmem_swapped = shmem_swap_usage(vma);
> >>> +             const unsigned long shmem_swapped = shmem_swap_usage(vma);
> >>> +             const bool shared_or_ro = vma_test(vma, VMA_SHARED_BIT) ||
> >>> +                                       !vma_test(vma, VMA_WRITE_BIT);
> >>>
> >>> -             if (!start && (!shmem_swapped || (vma->vm_flags & VM_SHARED) ||
> >>> -                                     !(vma->vm_flags & VM_WRITE))) {
> >>> +             if (!is_partial && (!shmem_swapped || shared_or_ro))
> >>>                       mss->swap += shmem_swapped;
> >>> -             } else {
> >>> +             else
> >>>                       ops = get_smaps_shmem_walk_ops(priv);
> >>> -             }
> >>
> >> Horrible, horrible code, really. But not your fault :)
> >>
> >> I think we can just make the shared_or_ro less odd by just checking for cow
> >> mappings (as described in the comment).
> >>
> >>         const bool is_cow = vma_is_cow_mapping(vma);
> >>
> >> ...
> >>
> >>         if (is_partial || (shmem_swapped && is_cow))
> >>                 ops = get_smaps_shmem_walk_ops(priv);
> >>         else
> >>                 mss->swap += shmem_swapped;
> >>
> >> That's almost in a form that I could understand what's happening.
> >
> > Hmm. So, are you saying that !is_cow always implies shared_or_ro? Or
> > maybe you are stating that vma_is_cow_mapping() was the actual intent
> > here?
>
> So the comment says:
>
> "For private writable mappings, we might have COW pages that  .."
>
> Which translates to:
>
> 	private writable == vma_is_cow_mapping()
>
> >
> > shared_or_ro = VMA_SHARED_BIT || !VMA_WRITE_BIT
> >
> > is_cow = !VMA_SHARED_BIT && VMA_MAYWRITE_BIT
> > !is_cow = VMA_SHARED_BIT || !VMA_MAYWRITE_BIT
> >
> > so, !is_cow would impy shared_or_ro only if !VMA_MAYWRITE_BIT always
> > implies !VMA_WRITE_BIT. But I think it's possible to have a VMA that
> > has VMA_WRITE_BIT but not VMA_MAYWRITE_BIT, right?
>
> VMA_WRITE should imply VMA_MAYWRITE

Yup it's illegal to set VMA_WRITE_BIT without VMA_MAYWRITE_BIT.

>
> (in sanitize_fault_flags() we even disallow write faults entirely if VM_MAYWRITE
> is missing)
>
> For example, a
> > driver can create such a VMA to allow writing to the VMA but to lock
> > its content once mprotect(PROT_READ) gets called.

I'm not even sure how a driver would achieve that but drivers in general are not
permitted to alter VMA flags after map time.

>
> I don't think that would be valid for a driver to do. But it wouldn't matter
> here because
>
> 	shmem_mapping(vma->vm_file->f_mapping)

Yup :)

>
>
> I think we could simplify the comment as well to:
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e671b4fd8dedd..4b7e7089cafa7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1303,12 +1303,10 @@ static void smap_gather_stats(struct proc_maps_private
> *priv,
>
>         if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
>                 /*
> -                * For shared or readonly shmem mappings we know that all
> -                * swapped out pages belong to the shmem object, and we can
> -                * obtain the swap value much more efficiently. For private
> -                * writable mappings, we might have COW pages that are
> -                * not affected by the parent swapped out pages of the shmem
> -                * object, so we have to distinguish them during the page walk.
> +                * In CoW mappings, we might have anon folios that are
> +                * independent of the shmem object. So fallback to the less
> +                * efficient mechanism in such mappings.
> +                *

Maybe tweak to 'CoW mappings might map anon folios that do not belong to shmem,
so perform a less efficient page table walk in this situation' or something like
that?


>                  * Unless we know that the shmem object (or the part mapped by
>                  * our VMA) has no swapped out pages at all.
>                  */



>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
