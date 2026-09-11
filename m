Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413848E0FF;
	Fri, 11 Sep 2026 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146659; cv=none; b=MzHVb4WwUXy9OIoey+OGb/O9LzHlWc1pG5Ag8jLQfMTUW78YSLzDgWFz6swTCWXftYfGjsMsBvBTmGv5B4voMv4R5fghyQEC9R9yn1wUs7lTUE0UbGOOB9eEplRA+o0B2o73DmtNj+Ugdag7w8FAjCv9XWx0FOsHCqf/uT5J5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146659; c=relaxed/simple;
	bh=IaHk/s4tXB2TrWBRowZgGqZv4ArAs/ezKZNmua23xp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0k7cEfWvjGR+2m0ki46AYIV6dNi2qs7ITIq2CE2KHA4uPfI3hL4vodfe3a6JvjHXo51HaESZcqM5tJEYvpMZF3PH8P6HtkCLqVe23dtdtqA2grzRdhfGBTdvfxTB/90xnWA50OuOl8arMbkocgP3QUOCdCy1PkhoWnvkkAxH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILJKIini; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILJKIini"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495361F00898;
	Fri, 11 Sep 2026 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146657;
	bh=iabiJzFuMBssAfyHTa9WjeB2ndYSQf+7FBqT74/kVEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ILJKIinisqw0ioqYDzn6nsffUP6igzwaiG1ztbYuzd1b9ozZoSM/Jq6t4GS11YyCI
	 ko5fTxgbqXI3kof2+Y1gZibK1BUQ7Nz/Z/zKkoOX74zEhLk2XSOqo4VVb0cyGWpxQG
	 v14SKBX0BFfg+VdskI0Ob+NYl/FWGXGsAcHc8QB5qBhe/3RCSFUHOgHpXI6PaJUATA
	 9K0aZxtzhkZMRdjvZIgXhuXRaILAxKp8L0EbCM35NHzAc1SVjXQrZT94PZu6LbrHOa
	 0SzJj7IvmXsPfSsrVbeg+EsdVOy9tP56jWCpJQgScjuhrdRIO0E3kyxLgqwx5PxpT/
	 biR9hxrgcu34A==
Date: Fri, 11 Sep 2026 18:10:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] proc/task_mmu: clarify shmem mapping walk
 conditions in smap_gather_stats()
Message-ID: <aqQzk2AT05r6rOyT@gremlin>
References: <20260910234737.1340642-1-surenb@google.com>
 <20260910234737.1340642-4-surenb@google.com>
 <aqQoPTTUC9M5HkYb@gremlin>
 <CAJuCfpEHeFSMamNhf=FLvFjh9D8DBwZtbKwL0zi=x-2g8B+ENw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEHeFSMamNhf=FLvFjh9D8DBwZtbKwL0zi=x-2g8B+ENw@mail.gmail.com>

On Fri, Sep 11, 2026 at 04:58:40PM +0000, Suren Baghdasaryan wrote:
> On Fri, Sep 11, 2026 at 4:28 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > On Thu, Sep 10, 2026 at 04:47:33PM -0700, Suren Baghdasaryan wrote:
> > > smap_gather_stats() optimizes stats gathering by skipping the walk for
> > > shmem mappings in certain conditions. Update the comment to clarify
> > > these conditions and use vma_is_cow_mapping() for COW identification
> > > instead of open-coding it.
> > > Instead of using (start != 0) condition to identify partial walks, use
> > > more semantically correct (start > vma->vm_start) check.
> >
> > I don't agree what you're doing is semantically correct, it's a hack really.
> >
> > Callers are passing start=0 to indicate that the entire VMA should be
> > processed and that happens to fulfil your criteria but in a surprising way.
> >
> > And the start in these cases is corrupted.
>
> Well, the "other" Lorenzo does not agree with you and suggested this
> approach in [1]. Specifically, see the comment:
> ```
> I also don't love that 0 is taken to be 'start from vma->vm_start' and I
> also don't love that the code in smap_gather_stats() actually special cases
> this...

I'm not sure what part of this is disagreement?

It's saying passing 0 is a hack, which is one that is still in place and which
this patch makes worse, because instead of explicitly calling out the invalid
value, you're treating it as if it were valid.

>
> How about passing last_vma_end and making smap_gather_stats() more sane? In
> the other invocation of smap_gather_stats() we could pass vma->vm_start
> here.

Yup, well me of 3 months ago should have suggested what I suggested re: wrapper
(I think you cut that suggestion out of my reply).

> ```
>
> [1] https://lore.kernel.org/all/aifO_rCurVhFRTcl@lucifer/

>
> >
> > >
> > > No functional change intended.
> > >
> > > Suggested by: David Hildenbrand (Arm) <david@kernel.org>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  fs/proc/task_mmu.c | 24 ++++++++++--------------
> > >  1 file changed, 10 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index cfc7af1b551d..3c40c9cbb9c9 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -1257,6 +1257,7 @@ static void smap_gather_stats(struct proc_maps_private *priv,
> > >                             struct mem_size_stats *mss, unsigned long start)
> > >  {
> > >       const struct mm_walk_ops *ops = get_smaps_walk_ops(priv);
> > > +     const bool is_partial = start > vma->vm_start;
> >
> > Yeah not in love with this, without changing how it's called.
>
> See [1]. This is exactly how you wrote it at the end of that reply.

Assuming you passed vma->vm_start, not 0? Passing 0 makes it really strange.

I see that in the patch I suggested I didn't update the other callers like I
said you should in the reply, my bad from 3 months ago, but I don't think that
invalidates what's been raised here.

>
> >
> > If you're reworking it all already, the actually semantically correct thing
> > I think would be to do something like:
> >
> > static void smap_gather_stats_range(struct proc_maps_private *priv,
> >                 struct vm_area_struct *vma, struct mem_size_stats *mss,
> >                 unsigned long start)
> > {
> >         ...
> > }
> >
> > Then to drop a parameter in smap_gather_stats() like:
> >
> > static void smap_gather_stats_range(struct proc_maps_private *priv,
> >                 struct vm_area_struct *vma, struct mem_size_stats *mss)
> > {
> >         smap_gather_stats_range(priv, vma, mss, vma->vm_start);
> > }
> >
> > And then you remove the hack and make is_partial not be accidentally true for an
> > invalid start parameter.
> >
> > >
> > >       /* Invalid start */
> > >       if (start >= vma->vm_end)
> > > @@ -1270,23 +1271,18 @@ static void smap_gather_stats(struct proc_maps_private *priv,
> > >
> > >       if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
> > >               /*
> > > -              * For shared or readonly shmem mappings we know that all
> > > -              * swapped out pages belong to the shmem object, and we can
> > > -              * obtain the swap value much more efficiently. For private
> > > -              * writable mappings, we might have COW pages that are
> > > -              * not affected by the parent swapped out pages of the shmem
> > > -              * object, so we have to distinguish them during the page walk.
> > > -              * Unless we know that the shmem object (or the part mapped by
> > > -              * our VMA) has no swapped out pages at all.
> > > +              * CoW mappings might map anon folios that do not belong to
> > > +              * shmem. Perform a less efficient page table walk in this
> > > +              * situation, unless we know that the shmem object (or the
> > > +              * part mapped by our VMA) has no swapped out pages at all.
> > >                */
> > > -             unsigned long shmem_swapped = shmem_swap_usage(vma);
> > > +             const unsigned long shmem_swapped = shmem_swap_usage(vma);
> > > +             const bool is_cow = vma_is_cow_mapping(vma);
> >
> > Nice to see this helper naturally slot in to new stuff :)
> >
> > >
> > > -             if (!start && (!shmem_swapped || (vma->vm_flags & VM_SHARED) ||
> > > -                                     !(vma->vm_flags & VM_WRITE))) {
> > > -                     mss->swap += shmem_swapped;
> > > -             } else {
> > > +             if (is_partial || (shmem_swapped && is_cow))
> > >                       ops = get_smaps_shmem_walk_ops(priv);
> > > -             }
> > > +             else
> > > +                     mss->swap += shmem_swapped;
> > >       }
> > >
> > >       if (!start)
> >
> > Also not absolutely in love with the fact you only use is_partial above and
> > leave:
> >
> >         if (!start)
> >                 walk_page_vma(vma, ops, mss);
> >         else
> >                 walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
> >
> > As-is.
> >
> > Should be:
> >
> >         if (is_partial)
> >                 walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
> >         else
> >                 walk_page_vma(vma, ops, mss);
>
> True, that can be changed here too. This whole block is replaced in
> the next patch though.

Yep I think that should be squashed into this one, as I say there.

>
> >
> > But I also wonder whether, with start not being corrupted (!) you could
> > just replace this with:
> >
> >         walk_page_range_vma(vma, start, vma->vm_end, ops, mss);
>
> Yep, that's done in the very next patch.

As above.

>
> >
> > Looking at the pagewalk.c implementations I don't know why
> > walk_page_range_vma() doesn't just forward [vma->vm_start, vma->vm_end) to
> > walk_page_range_vma()... but that's another thing :)
> >
> > > --
> > > 2.55.0.1007.g17ff1f9808-goog
> > >
> >
> > --
> > Cheers, Lorenzo

--
Cheers, Lorenzo
