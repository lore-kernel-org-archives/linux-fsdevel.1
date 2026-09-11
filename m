Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A153B47CB;
	Fri, 11 Sep 2026 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148983; cv=none; b=kqXKSra+vos5id1dL8+kQ/YRDz+blTPrp48W/zpSY686houLO5DoKkS8J7kilNzDR70Xc0EJjFN1TIJ8LcPPmZIp6LP99gAB4o2DM/kTZv3OW5Jl37eg7J9egSEOY4pOK/imxMqzBSd4sFZ/ne74TX8Ertxpl2PD7HFIp3B/cHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148983; c=relaxed/simple;
	bh=ZhSG6K4HP7Q9Fgg7cKBvW83nDt14UjaHbdiU13J9KSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAPiMayqK6ncpd4WfKJuwvsEThU0MQncEdzUgMYslwY/XsXcVS1+G+I4fwqPdPE4Sdc54e8WFL0jxFQNwdkI3eM4VLt6rcPHNq+jtMcajb+NYRfJROUURmr1GptgLwQnk1ASq8x2KehkL8dBhZ9sxT7ul83wxFk/VLoUmt9Gjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4MufMKH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4MufMKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B032F1F000FF;
	Fri, 11 Sep 2026 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789148980;
	bh=KhUmfw14OYrCY7IYDxm+oE9osdfjxhnvTL/bmLLDDXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M4MufMKHUE993PXmFUa5//tS1MwXXRI6RVYsEHwtGUtRTOmWBIADiF636pIJtIfsS
	 AWycC7rI/z172W22vhObsiUQCBLTomS5Yzl1uoLb5k30NaKuBd1uuNM2L7qPBtlcZW
	 DyellxC9QuDTLeV0nfksC+JHQ+Lwh/OkPhdPgroYgGyFQi651C0yFVjx99yaMcQhpu
	 jDssGCF/o4sMiabHw9KMHtV3bY/VRey1g1NlJR4EG6qrEEJmxTLbvuV9Yw+aKLXHgy
	 0jem5CyXSLwqujHjWKv0Hn+o7KhRqtWnfJLC70QH59GOABByK8dfkFarH5fzU7HHp7
	 iQDGeshUWiJaA==
Date: Fri, 11 Sep 2026 18:49:35 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
Message-ID: <aqQ2M5bZv4k43j91@gremlin>
References: <20260910234737.1340642-1-surenb@google.com>
 <20260910234737.1340642-5-surenb@google.com>
 <aqQsWNfrBSp4DY_N@gremlin>
 <CAJuCfpEEi-9ZqhKR536tJHywprb9RFcx92gK00qp_ecBGH9Fvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEEi-9ZqhKR536tJHywprb9RFcx92gK00qp_ecBGH9Fvw@mail.gmail.com>

On Fri, Sep 11, 2026 at 05:07:48PM +0000, Suren Baghdasaryan wrote:
> On Fri, Sep 11, 2026 at 4:39 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > On Thu, Sep 10, 2026 at 04:47:34PM -0700, Suren Baghdasaryan wrote:
> > > smap_gather_stats() interprets its start parameter to mean vma->vm_start
> > > when it's set to 0. Eliminate this special interpretation and pass
> > > vma->vm_start explicitly when needed.
> > >
> > > Since smap_gather_stats() operates within a single VMA, we can replace
> > > walk_page_vma()/walk_page_range() calls with walk_page_range_vma()
> > > which is simpler and also can be called while holding per-VMA lock.
> > >
> > > No functional change intended.
> > >
> > > Suggested by: Lorenzo Stoakes <ljs@kernel.org>
> >
> > Hmm did I? Where did I suggest this?... I guess a while ago?
>
> In [1] on June 9, 2026.
>
> [1] https://lore.kernel.org/all/aifO_rCurVhFRTcl@lucifer/

Yup a while ago :)

>
> >
> > I mean I also happen to suggest it in the previous patch review :) but that was
> > sent after you sent this...
> >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
> >
> > I don't love hacking a hack for a patch and then unhack it in the next in a
> > slightly roundabout way.
> >
> > Feels like this should be squashed. And a wrapper function for
> > start=vma->vm_start should be used rather than duplicating that param
> > constantly.
> >
> > > ---
> > >  fs/proc/task_mmu.c | 29 ++++++++++++++++-------------
> > >  1 file changed, 16 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 3c40c9cbb9c9..ecce7ce116cb 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -1246,21 +1246,27 @@ get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
> > >       return &smaps_shmem_walk_vma_lock_ops;
> > >  }
> > >
> > > -/*
> > > - * Gather mem stats from @vma with the indicated beginning
> > > - * address @start, and keep them in @mss.
> > > +/**
> > > + * smap_gather_stats() - Gather mem stats from @vma.
> > > + * @priv: proc maps private state.
> > > + * @vma: The VMA to gather stats for.
> > > + * @mss: The accumulated stats.
> > > + * @start: The address from which to start.
> > >   *
> > > - * Use vm_start of @vma as the beginning address if @start is 0.
> > > + * This gathers stats for the whole of the VMA unless the lock was dropped
> > > + * and VMA grew or got merged and we found it again, in which case we only
> > > + * gather stats for the remainder of the VMA range.
> >
> > This seems to be describing what callers do not what the function does unless
> > I'm missing something? So that's really the wrong place for it.
> >
> > I think the description of why it might be a partial walk belongs to the bit of
> > code that actually tries to do a partial walk.
> >
> > Anyway as per below I think separate partial/full functions make sense and there
> > it can simply be described as walking either the full or part of the VMA.
>
> This is verbatim of what you wrote at the end of [1]

OK, I guess I disagree with myself of 3 months ago?

The technical point being made here, which I think is the more constructive one
to engage with, is that this is a function that can be called with different
parameters for whatever reason.

Somebody might decide to call it for another reason, putting something in the
description of the function that assumes what callers will do when that code can
change is asking for bit rot.

So as I suggested above:

	I think the description of why it might be a partial walk belongs to the
	bit of code that actually tries to do a partial walk.

I.e. I guess past me's description is apt, but belongs with the partial case.

>
> >
> > >   */
> > >  static void smap_gather_stats(struct proc_maps_private *priv,
> > >                             struct vm_area_struct *vma,
> > > -                           struct mem_size_stats *mss, unsigned long start)
> > > +                           struct mem_size_stats *mss,
> > > +                           unsigned long start)
> > >  {
> > >       const struct mm_walk_ops *ops = get_smaps_walk_ops(priv);
> > >       const bool is_partial = start > vma->vm_start;
> > >
> > >       /* Invalid start */
> > > -     if (start >= vma->vm_end)
> > > +     if (start < vma->vm_start || start >= vma->vm_end)
> > >               return;
> > >
> > >       if (vma == get_gate_vma(priv->lock_ctx.mm))
> > > @@ -1285,10 +1291,7 @@ static void smap_gather_stats(struct proc_maps_private *priv,
> > >                       mss->swap += shmem_swapped;
> > >       }
> > >
> > > -     if (!start)
> > > -             walk_page_vma(vma, ops, mss);
> > > -     else
> > > -             walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
> > > +     walk_page_range_vma(vma, start, vma->vm_end, ops, mss);
> >
> > I mean obviously am in favour of this as I suggested it in the last patch :)
> >
> > >
> > >       reacquire_rcu(priv);
> > >  }
> > > @@ -1343,7 +1346,7 @@ static int show_smap(struct seq_file *m, void *v)
> > >       struct vm_area_struct *vma = v;
> > >       struct mem_size_stats mss = {};
> > >
> > > -     smap_gather_stats(priv, vma, &mss, 0);
> > > +     smap_gather_stats(priv, vma, &mss, vma->vm_start);
> > >
> > >       show_map_vma(m, vma);
> > >
> > > @@ -1396,7 +1399,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
> > >
> > >       vma_start = vma->vm_start;
> > >       do {
> > > -             smap_gather_stats(priv, vma, &mss, 0);
> > > +             smap_gather_stats(priv, vma, &mss, vma->vm_start);
> > >               last_vma_end = vma->vm_end;
> > >
> > >               /*
> > > @@ -1455,7 +1458,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
> > >
> > >                       /* Case 1 and 2 above */
> > >                       if (vma->vm_start >= last_vma_end) {
> > > -                             smap_gather_stats(priv, vma, &mss, 0);
> > > +                             smap_gather_stats(priv, vma, &mss, vma->vm_start);
> >
> > I mean this is all horrible, having to pass vma->vm_start explicitly.
> >
> > Although better than the hack that gets compounded in patch 3.
> >
> > There 4 invocations of smap_gather_stats(), only one of them passes a
> > non-vma->vm_start start.
> >
> > So it'd make more sense to just make smap_gather_stats() lose its 3rd param and
> > have it call smap_gather_stats_range(), then have 1 invocation of
> > smaps_gather_stats_range() directly, as per suggestion in last patch.
> >
> > Or something similar to that.
>
> Hmm. Ok, I'll wait for you to read your previous suggestions in [1]
> and after that let's discuss what the final version should look like.

I don't really think that's hugely constructive.

I'm sorry I'm (mildly) disagreeing with my past self, I've sent tens of
thousands of words of review since then so I think it can be forgiven.

In any case, I really do think:

	smap_gather_stats(priv, vma, &mss);
	smap_gather_stats(priv, vma, &mss);
	smap_gather_stats(priv, vma, &mss);
	smap_gather_stats_range(priv, vma, &mss, last_vma_end);

Works better than:

	smap_gather_stats(priv, vma, &mss, vma->vm_start);
	smap_gather_stats(priv, vma, &mss, vma->vm_start);
	smap_gather_stats(priv, vma, &mss, vma->vm_start);
	smap_gather_stats(priv, vma, &mss, last_vma_end);

?

I usually come back on review very quickly so I don't think this series
will be held up with any such change.

But let me know if you think it's not a good idea technically.

> Thanks,
> Suren.

--
Cheers, Lorenzo
