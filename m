Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14A43DEBB
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150538; cv=pass; b=qThvpRMeK4Frjhu3XfplF3CFBS/zPmQRl/wVm7IJIi8pGpcKBfq534nW8sGzNtiJBEcmzYCOoJZzBV5bk9vQpN9a7R2JBU1Iph+BEdcNwbR+Fb6XPxj9fjqNTz2J67w/dQQcrDu0LpW3El9W/PB1Ki82lvTcuirUZBebmqs3U4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150538; c=relaxed/simple;
	bh=o87OCAl6KEAncyjWlPhRc2kkBIIYX58QzgRfCdRKol0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbyOjjdQcdpWseBo+ku9B0XvGGQ/R7rMYmCdrZcHgLy+TMdar4DjutQeEfFSKPBq/kdiUO9aEK2IH/9lRuaIDlUbOU7hoO/ecCWmPFP+KUXJ8W+uRb6XOp3tHpSl07vhF0leuFviQem4hhMsxLLdOLml0THdW/vbFgQGnKJILjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hygNzYdK; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hygNzYdK"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d5fc2cd8so76501cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 11:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150535; cv=none;
        d=google.com; s=arc-20260327;
        b=euwi2raHR60DnlAe/FNy49VbiGMPYn9qbsGM1dd/7HYreEkVw3pewFz2EdU2nkMXhI
         ftava2GZRLZYykEtJtUq8DzEcB3k2kQrljTJqkz+GINrtMQWqJDgaFAY9MMADQTz48Bj
         SF+5lneZJAkTuveCgFMjPFWwWCCxR1t5KDpqBWFcawCpiupXcse4N3/vttgK0q0TeH1k
         Iaxh5+P3X22dohSOTbmunqwJUx2DNw5q8yPIZL+1MExj/yJo30aQXvtP/OeXp7gxppd5
         1EAidr62hMI7HSI7A000RS/shaGDmGv0FtYnvh6fukp6CdpwWQjPNNpCrQFm/Nqwtkr2
         +3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SsUdzBV0WoHiJJ6Nt8zSUSskXe/EFmoaeRcNUlFxtf4=;
        fh=gQJbHB/cGjhvjA4dY2ZiHdQxiaKdXbiBZFYJr4KJZWE=;
        b=rQ0m7uTfwjxr9o4skvBpC//nH+3f7JFgm+TUq0FVzGl3fYKBbSEamfYRgwpyTdHO3J
         Ap39/ixxgf+T2JLfH34PwZO3KB9bSaDzYLdQT7ehhEXEZnkyp0PZuUtvHOSqLDQ/XdUi
         KNlSse3ReyaK0KIKRwwKA4Fx25bjnOlTxXagd9dstJ3URAn/L6qXbJZjinFpKyiS0TT7
         Qe64qviEwUHNaGprXPpocosTnr7jcYBqYMX138dM/xamQO3Puv2Cia12lfpQO3PwDIBy
         GMq0E0eA+RzNdJy36uw7c4iCqG4jgTbnUIyqUE7XxnrgRp3o7EH10cR8fs+4Z4uLKZ2a
         hXXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789150535; x=1789755335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SsUdzBV0WoHiJJ6Nt8zSUSskXe/EFmoaeRcNUlFxtf4=;
        b=hygNzYdKeElznV1bPX/nIXPRcCheeyazoNhPzwquOOr9kMDspW4/UkaXpzVlzpkLg6
         FOJ3bHko2D8mgOCmNbGVQiGmea2bTw3UPxWPM7v8YxSWYOnPFXj58KM8bPfARsnJh+YF
         hiGSkjv1uYe7QI1Zx9tFIWC2OaSiUyKRDR9T3JR3qdRo3ym9iD2MT83V/8fSX5JXc/cI
         LeSv1vjAEYkxe6AwvVYY1v/ccidXh4nGEZlQu/w8WHUMfs2f1Kco3e196pVa9PALYWIc
         559RsAQzSM/rBloYcGCsAh4qMh46EhBmI8LYXmhVMOPA/z0ipQBV5gLL/qrIapeZfUvz
         VlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150535; x=1789755335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SsUdzBV0WoHiJJ6Nt8zSUSskXe/EFmoaeRcNUlFxtf4=;
        b=pnRl5skVd90hsxLxNC7nEWdIhMUqaIhgoOGyTyR11NAYGfhOwiHRDt134Nb6G7dEaM
         Z9dej7kWkPBkaNXGbUYueF3T+v3fHzP2XmEhs6962llJ3Mr9IsFgCjKAjHgr3WCJwlaK
         0+na4BS39rbMtioYF7Oc+zDR83Ll1IHYTcHW9166TOSAl6TDxIwyHLxahvkEjpCU+WNr
         VlUV4YVNI8Z3YL4kPM11Y7AfWzHvc2EAqlcA864TTmre9ND/5twlx9nTiOl/+jKpN50i
         L2QrooXGaOMRUaK/AuSGltPscHuH9jaYWKm6IbBWZ4s4Tk6joYNbJaFhz4fU1l4ktQjw
         S+xA==
X-Forwarded-Encrypted: i=1; AKwUvBw+MgMNbeLlvY/j6l1sQ9TyRZtBRIasW2IalW5H6HEfrBl83j1ynh79WBYgE/cvuBNAAPZ2rM/dY2KdtYSM@vger.kernel.org
X-Gm-Message-State: AFuF++lb/99iHg0aWW9+y1JyVTQrzYVVruf1O3h85mUSPRcQ+/IQ0M3d
	KZ3feb5N5PJnHZQO1ioBS9ms4+Um+jmhs/Gv4bBkfIY+OguGIznZj7mLTCtVWAfjVP5okrlCgN/
	FWnXRYMlYJFIG7OnqJpiBWNjZVfv3cy6ySpRyO5MQ
X-Gm-Gg: AYBFou0/k7uBC6kC4GVPH6ELvSPGlUnz/g+Fi+BZruZ2HnCSfamXtsVFjYbglZlkLp9
	MH11jS0J0eLsnVK0TuIgIg48HxzUw//4KIIkfB8Fv4A6/1sYyObwP8/6N2dqKzZ0F131tYpjAV3
	tHHxgo+xT8gFZpGbpG+gBsES89Ayr6QYkiXdY880gUiPMhl9fH0nWcYsX6U7RVjzXMquZEdvWAx
	mtFxFN9lfpXM34i+Vgo12Y4IVqFJF3fPFAmGDbN4Oc34odKk5VmoCx/eAKoovbhCb4v9knTSYJt
	uXaUmaBQIMSnxshBNeGORlATIvaQQfnnqHO9gT31LGVGpPBoRpaJuDBfPUVoCOXGi12PmN7vo71
	XKM98INenFA==
X-Received: by 2002:a05:622a:1b07:b0:527:f08f:56a2 with SMTP id
 d75a77b69052e-530e4652848mr1537081cf.8.1789150534090; Fri, 11 Sep 2026
 11:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-5-surenb@google.com>
 <aqQsWNfrBSp4DY_N@gremlin> <CAJuCfpEEi-9ZqhKR536tJHywprb9RFcx92gK00qp_ecBGH9Fvw@mail.gmail.com>
 <aqQ2M5bZv4k43j91@gremlin> <CAJuCfpG21qzef-yag3A9d22BUXnx2EFmbSvT=Zi5uRx_h7BxbA@mail.gmail.com>
 <aqREAsJK72xwXSzK@gremlin>
In-Reply-To: <aqREAsJK72xwXSzK@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 11:15:22 -0700
X-Gm-Features: AcwNN1WgElVhcS2wqqourqlrpP3HGCgXdW4_YR2F2gcH7VKNhfp3ud7rRD_kq_g
Message-ID: <CAJuCfpGxoFPgs2pN96VsTtWJE+aN5e94woAGCeyp92+geVxOrA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 11:11=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Fri, Sep 11, 2026 at 11:06:28AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Sep 11, 2026 at 10:49=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@ker=
nel.org> wrote:
> > >
> > > On Fri, Sep 11, 2026 at 05:07:48PM +0000, Suren Baghdasaryan wrote:
> > > > On Fri, Sep 11, 2026 at 4:39=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@=
kernel.org> wrote:
> > > > >
> > > > > On Thu, Sep 10, 2026 at 04:47:34PM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > smap_gather_stats() interprets its start parameter to mean vma-=
>vm_start
> > > > > > when it's set to 0. Eliminate this special interpretation and p=
ass
> > > > > > vma->vm_start explicitly when needed.
> > > > > >
> > > > > > Since smap_gather_stats() operates within a single VMA, we can =
replace
> > > > > > walk_page_vma()/walk_page_range() calls with walk_page_range_vm=
a()
> > > > > > which is simpler and also can be called while holding per-VMA l=
ock.
> > > > > >
> > > > > > No functional change intended.
> > > > > >
> > > > > > Suggested by: Lorenzo Stoakes <ljs@kernel.org>
> > > > >
> > > > > Hmm did I? Where did I suggest this?... I guess a while ago?
> > > >
> > > > In [1] on June 9, 2026.
> > > >
> > > > [1] https://lore.kernel.org/all/aifO_rCurVhFRTcl@lucifer/
> > >
> > > Yup a while ago :)
> > >
> > > >
> > > > >
> > > > > I mean I also happen to suggest it in the previous patch review :=
) but that was
> > > > > sent after you sent this...
> > > > >
> > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
> > > > >
> > > > > I don't love hacking a hack for a patch and then unhack it in the=
 next in a
> > > > > slightly roundabout way.
> > > > >
> > > > > Feels like this should be squashed. And a wrapper function for
> > > > > start=3Dvma->vm_start should be used rather than duplicating that=
 param
> > > > > constantly.
> > > > >
> > > > > > ---
> > > > > >  fs/proc/task_mmu.c | 29 ++++++++++++++++-------------
> > > > > >  1 file changed, 16 insertions(+), 13 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > > index 3c40c9cbb9c9..ecce7ce116cb 100644
> > > > > > --- a/fs/proc/task_mmu.c
> > > > > > +++ b/fs/proc/task_mmu.c
> > > > > > @@ -1246,21 +1246,27 @@ get_smaps_shmem_walk_ops(struct proc_ma=
ps_private *priv)
> > > > > >       return &smaps_shmem_walk_vma_lock_ops;
> > > > > >  }
> > > > > >
> > > > > > -/*
> > > > > > - * Gather mem stats from @vma with the indicated beginning
> > > > > > - * address @start, and keep them in @mss.
> > > > > > +/**
> > > > > > + * smap_gather_stats() - Gather mem stats from @vma.
> > > > > > + * @priv: proc maps private state.
> > > > > > + * @vma: The VMA to gather stats for.
> > > > > > + * @mss: The accumulated stats.
> > > > > > + * @start: The address from which to start.
> > > > > >   *
> > > > > > - * Use vm_start of @vma as the beginning address if @start is =
0.
> > > > > > + * This gathers stats for the whole of the VMA unless the lock=
 was dropped
> > > > > > + * and VMA grew or got merged and we found it again, in which =
case we only
> > > > > > + * gather stats for the remainder of the VMA range.
> > > > >
> > > > > This seems to be describing what callers do not what the function=
 does unless
> > > > > I'm missing something? So that's really the wrong place for it.
> > > > >
> > > > > I think the description of why it might be a partial walk belongs=
 to the bit of
> > > > > code that actually tries to do a partial walk.
> > > > >
> > > > > Anyway as per below I think separate partial/full functions make =
sense and there
> > > > > it can simply be described as walking either the full or part of =
the VMA.
> > > >
> > > > This is verbatim of what you wrote at the end of [1]
> > >
> > > OK, I guess I disagree with myself of 3 months ago?
> > >
> > > The technical point being made here, which I think is the more constr=
uctive one
> > > to engage with, is that this is a function that can be called with di=
fferent
> > > parameters for whatever reason.
> > >
> > > Somebody might decide to call it for another reason, putting somethin=
g in the
> > > description of the function that assumes what callers will do when th=
at code can
> > > change is asking for bit rot.
> >
> > Yeah, that makes sense.
>
> Thanks.
>
> >
> > >
> > > So as I suggested above:
> > >
> > >         I think the description of why it might be a partial walk bel=
ongs to the
> > >         bit of code that actually tries to do a partial walk.
> > >
> > > I.e. I guess past me's description is apt, but belongs with the parti=
al case.
> >
> > Ok, sounds like you want two separate functions supporting complete or
> > partial walk. I don't have a strong preference here and it's easy to
> > do like this:
> >
> > staic void smap_gather_stats_range(priv, vma, &mss, start)
> > {
> >         ....
> > }
> >
> > staic void smap_gather_stats(priv, vma, &mss)
> > {
> >         smap_gather_stats_range(priv, vma, &mss, vma->vm_start);
> > }
> >
> > Does that sound good?
>
> Yeah that's the idea.
>
> >
> > >
> > > >
> > > > >
> > > > > >   */
> > > > > >  static void smap_gather_stats(struct proc_maps_private *priv,
> > > > > >                             struct vm_area_struct *vma,
> > > > > > -                           struct mem_size_stats *mss, unsigne=
d long start)
> > > > > > +                           struct mem_size_stats *mss,
> > > > > > +                           unsigned long start)
> > > > > >  {
> > > > > >       const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv=
);
> > > > > >       const bool is_partial =3D start > vma->vm_start;
> > > > > >
> > > > > >       /* Invalid start */
> > > > > > -     if (start >=3D vma->vm_end)
> > > > > > +     if (start < vma->vm_start || start >=3D vma->vm_end)
> > > > > >               return;
> > > > > >
> > > > > >       if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> > > > > > @@ -1285,10 +1291,7 @@ static void smap_gather_stats(struct pro=
c_maps_private *priv,
> > > > > >                       mss->swap +=3D shmem_swapped;
> > > > > >       }
> > > > > >
> > > > > > -     if (!start)
> > > > > > -             walk_page_vma(vma, ops, mss);
> > > > > > -     else
> > > > > > -             walk_page_range(vma->vm_mm, start, vma->vm_end, o=
ps, mss);
> > > > > > +     walk_page_range_vma(vma, start, vma->vm_end, ops, mss);
> > > > >
> > > > > I mean obviously am in favour of this as I suggested it in the la=
st patch :)
> > > > >
> > > > > >
> > > > > >       reacquire_rcu(priv);
> > > > > >  }
> > > > > > @@ -1343,7 +1346,7 @@ static int show_smap(struct seq_file *m, =
void *v)
> > > > > >       struct vm_area_struct *vma =3D v;
> > > > > >       struct mem_size_stats mss =3D {};
> > > > > >
> > > > > > -     smap_gather_stats(priv, vma, &mss, 0);
> > > > > > +     smap_gather_stats(priv, vma, &mss, vma->vm_start);
> > > > > >
> > > > > >       show_map_vma(m, vma);
> > > > > >
> > > > > > @@ -1396,7 +1399,7 @@ static int show_smaps_rollup(struct seq_f=
ile *m, void *v)
> > > > > >
> > > > > >       vma_start =3D vma->vm_start;
> > > > > >       do {
> > > > > > -             smap_gather_stats(priv, vma, &mss, 0);
> > > > > > +             smap_gather_stats(priv, vma, &mss, vma->vm_start)=
;
> > > > > >               last_vma_end =3D vma->vm_end;
> > > > > >
> > > > > >               /*
> > > > > > @@ -1455,7 +1458,7 @@ static int show_smaps_rollup(struct seq_f=
ile *m, void *v)
> > > > > >
> > > > > >                       /* Case 1 and 2 above */
> > > > > >                       if (vma->vm_start >=3D last_vma_end) {
> > > > > > -                             smap_gather_stats(priv, vma, &mss=
, 0);
> > > > > > +                             smap_gather_stats(priv, vma, &mss=
, vma->vm_start);
> > > > >
> > > > > I mean this is all horrible, having to pass vma->vm_start explici=
tly.
> > > > >
> > > > > Although better than the hack that gets compounded in patch 3.
> > > > >
> > > > > There 4 invocations of smap_gather_stats(), only one of them pass=
es a
> > > > > non-vma->vm_start start.
> > > > >
> > > > > So it'd make more sense to just make smap_gather_stats() lose its=
 3rd param and
> > > > > have it call smap_gather_stats_range(), then have 1 invocation of
> > > > > smaps_gather_stats_range() directly, as per suggestion in last pa=
tch.
> > > > >
> > > > > Or something similar to that.
> > > >
> > > > Hmm. Ok, I'll wait for you to read your previous suggestions in [1]
> > > > and after that let's discuss what the final version should look lik=
e.
> > >
> > > I don't really think that's hugely constructive.
> >
> > I wasn't trying to offend in any way. Just wanted to give you some
> > time to recall previous conversation and consolidate your position.
> >
> > >
> > > I'm sorry I'm (mildly) disagreeing with my past self, I've sent tens =
of
> > > thousands of words of review since then so I think it can be forgiven=
.
> >
> > Definitely. Again, I wasn't trying to blame or anything like that.
> > Just pointing out our previous discussion and want to make sure we are
> > on the same page (while having some fun in the process).
> >
> > >
> > > In any case, I really do think:
> > >
> > >         smap_gather_stats(priv, vma, &mss);
> > >         smap_gather_stats(priv, vma, &mss);
> > >         smap_gather_stats(priv, vma, &mss);
> > >         smap_gather_stats_range(priv, vma, &mss, last_vma_end);
> > >
> > > Works better than:
> > >
> > >         smap_gather_stats(priv, vma, &mss, vma->vm_start);
> > >         smap_gather_stats(priv, vma, &mss, vma->vm_start);
> > >         smap_gather_stats(priv, vma, &mss, vma->vm_start);
> > >         smap_gather_stats(priv, vma, &mss, last_vma_end);
> > >
> > > ?
> > >
> > > I usually come back on review very quickly so I don't think this seri=
es
> > > will be held up with any such change.
> > >
> > > But let me know if you think it's not a good idea technically.
> >
> > TBH I don't have strong preference but if you like it this way, it will=
 be done.
> > I'll post an update today since I don't think there will be more
> > controversial parts. The biggest blunder on my part was the way I
> > split patch 3 and 4.
> > Thanks for the review!
>
> I'd quite like to have a look through the rest of the series first.

Ok, I'll wait for you to finish.

>
> >
> > >
> > > > Thanks,
> > > > Suren.
> > >
> > > --
> > > Cheers, Lorenzo
>
> --
> Cheers, Lorenzo
