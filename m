Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348B4BC005
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025083; cv=pass; b=mWMlOmpX82TL2g1y4HvhU8I7VdRtzZQcjHD4cTRykvrG5t4XPyo80uA18aH/nTu6sCfbNOScgwK5pUlwCboCjb0LHaZwFFLMNf3qfHkJIvPoNfEfFW2Od80niZT7mJFSun7DtbsJrldMs6/LSofwUsg6Tn+JVlOFWmfPM/IWMdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025083; c=relaxed/simple;
	bh=hLwFlRKRDbQypcbQastbCyJh451200T+DSUSorqCB84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMgu7yb885fALpKg+3afgf34hnTyK9Pm2fVdHKW8We2paXyR67ozSiitzA60ih8H3awTGLN8AxxX0+H9QnzQ6RSQMMYm8EeRQtRn/Es1D1Znkwmqr7Jzf8SI8oy806aMdL/g3TSy1O0gI6V5kA937J5QO7DwBH4oDspK1m3S4B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVU/chcI; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVU/chcI"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51765331535so2588971cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 10:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781025077; cv=none;
        d=google.com; s=arc-20240605;
        b=XbF+1NGZ33Qkph9sSLH+DqHCDwUM/j873734Ks+h92zXua6NwJZO0eNyYYiNI8VOMi
         ENxxuZnSEGHgQB04P9TXYI/DEuq9LpqPXzTQW/SHO0MypijxtGVeolR6O8cyoUMDJmUk
         6rTzBz4BrlKefP6IUESsu6SIfIi1YyN0AvUpDcb0QOtnaL5AQpRr5AQBS64dHJ4osXTT
         uBi71I786oDwSOHbyPM6SvX/WDJayP7JeD3Ubv/s5GcW9omSMy0wUfRYUVqi01EEox5z
         2ve+vIeJZa/BD5BbRVRl5bpO/jK9ZSVs7IrP6kSH6rmPM4/4iT3sozQ+0Yh+a8c3C0Fr
         jkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zfGkBJ5Fm1NrFbMLvYuWYFCroOOz9I8fe5IPw1jVMW4=;
        fh=zG1WfqbONKNC8ymRsiIb1RbxMu6ncOGYDFovHbDCFCQ=;
        b=fTHf+vFZbRYo5ziCUoNPs4EdB566p/tTHklfuFbjN9lIyT30jquEOLsaR2tIpLlfaQ
         +gCNK7ra/9WfzfMt2ZL/oNYDLlJLlhEytQH3k+Tj93AhjIsoL9mhewqkNTcThQUFlUvo
         8WBmEoss2Q82EbKcrBSAVY8KgXfc4IFtC7OlWwsAnMAr/6WFK9/UfOiFKZr+wT+tG5j4
         okw4WAc8pUAq9dXQmi4y/vXbRZE1wPCnrc6Y3RAUZ0c7WdZwuSvIb6ulAWqeKfLoHgjT
         5C+5t3HBGFYijCMfSoZgTNqui7yb3OuUTPDLbdFWabOf/fNa4v56p2h7id9zgHFd28qJ
         2GLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781025077; x=1781629877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfGkBJ5Fm1NrFbMLvYuWYFCroOOz9I8fe5IPw1jVMW4=;
        b=pVU/chcITZ5GJA6EKUSyJFhFynQzYCR7Lfvwh+I1As+8mJPe9DrvlmLgBnWsyMfYIi
         l+mIc5OFspgSg7BE7BDnmuyf/eBJdtRbdpcObTbWXsJaucRY1ZtcFuR29/WhoOTlMJg1
         e/61Zoe3MK0ZBC2xJL+zTYuznAOx2Jqbv0iSKmrQq8r0p68/7RSL7ESCa0tAD36B5ahy
         UoL+rZ42vaFPBxMD3oX9e4tXGeQtPgC1F3FrHaEThtReu+5njA1wXa/6bf26Smy9bZu4
         nBNwr6plpUhqJHGzZ9NK8oSqJguCa3/9ajZyYxqWpjqzvsGYum4BeCJKeHqX+nIOi4id
         twkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025077; x=1781629877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zfGkBJ5Fm1NrFbMLvYuWYFCroOOz9I8fe5IPw1jVMW4=;
        b=K58Bw1e7buh0/WIRfDEVKdvf6MI3sRYSvGMbDy/Xjy82MFytYCYWPL1/OxDnIH1ACH
         IoW3zLEubaUddkh1+kggrCpJh++qxGdXZEqkVEnEXCeb19rI/lVf+b4fX7QZ0yaDhB2d
         eI0FjtmEUw1NUPexcsETz6L+pePrsPQd38MUrtYAoqngx3ddmmXPOsTBwXjR21fMnLqp
         XD1g1DCzFlOSO3w0q6h7LRuZEHkOJXot3PKvB813/StMNs2GGWRLZjxQRyBwY6Qe6SVs
         Ea2lZyuAEFTCWGOGZyP2GJBcXTsvYvEQqI/bRll1fWxQgFXS0SSy5nuI644OmAA0XIld
         DK0w==
X-Forwarded-Encrypted: i=1; AFNElJ+9NS0KCYOiiYJa3KgAww7vbZNCaPKrfDGQRtozMvA8uHTI54qi28prfSjZ7nzVNEJ4DRGhpxxSdwV9lTK2@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGqC+i5KpVkEtU1CpCg3xbZaJz6bFjJ8/Izr1JG5v+pe5Rm1W
	WkX/Q9sUC1AR6TqfkUgDBiD3pHwLK2/jDLue++SCMjyN2ImRBzNgoEeAeiJgJv4WhmiyUf8xbSI
	P7kM49SLadbLr68Xwpq+DLJRdhmcBcd+mvKBWSO4H
X-Gm-Gg: Acq92OGd4z9c/Ux81V5W1kaKM9LOl1lnLDlqkY2e2E7N4WjJZ6aR064+04lgzXANah1
	AGmqqU6Z26Udp6f4PxVICyJUemCofmgrY+KnmVVTM4K2Vwm5glYsvLZGmY8hRL9lFCOuOCxk0U+
	LeCMEqLDZBlpCDXuxCvPccL1ixEwXC2R9jKeV7cjFF5oLReq3VrBd7duLrq7mk3Jzx2auUufGy8
	CriutNlMWBMLlbyIKnv/13xQxXGJo4zQEiiQ+YSi9MwY0FQZsQOpiNUNxMHcPYxhZ5sDEYRynFf
	s5mYXoiQDylHhzGBefI/wn1B1oSUl8D/Wc2haiStt+seuUnc
X-Received: by 2002:a05:622a:791a:10b0:50f:af60:3496 with SMTP id
 d75a77b69052e-51797ffc93amr34624171cf.1.1781025076678; Tue, 09 Jun 2026
 10:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606015729.1837935-1-surenb@google.com> <20260606015729.1837935-2-surenb@google.com>
 <aifO_rCurVhFRTcl@lucifer>
In-Reply-To: <aifO_rCurVhFRTcl@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Jun 2026 10:11:03 -0700
X-Gm-Features: AVVi8Cdb4sw7pcdyLxqv9_1tsBavo9y-1kuiXo0oLzRUxvha-xuFVAATc7XWfDw
Message-ID: <CAJuCfpFOpvNmV4aHnk3Vi0Jg4vF4Cmsm86h2vODZ84FVLXt9yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 3:00=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wro=
te:
>
> On Fri, Jun 05, 2026 at 06:57:29PM -0700, Suren Baghdasaryan wrote:
> > proc/pid/smaps_rollup can be read using the combination of RCU and
> > VMA read locks, similar to proc/pid/{maps|smaps|numa_maps}. RCU is
> > required to safely traverse the VMA tree and VMA lock stabilizes the
> > VMA being processed and the pagetable walk.
> > Note that we have to keep the logic to drop mmap_lock on contention
> > because even when using per-VMA locks we might have to fall back to
> > holding the mmap_lock.
> >
> > Running Paul's contention benchmark [1] shows considerable improvement
> > both in median and in the worst case latencies:
> >
> > Execution command: run-proc-vs-map.sh --nsamples 20 --rawdata -- \
> > --busyduration 2 --procfile smaps_rollup
> >
> > Baseline:
> >
> >     0.174     0.161     2.553
> >     0.174     0.164     2.663
> >     0.174     0.165     2.664
> >     0.174     0.166     2.679
> >     0.174     0.167     2.691
> >     0.174     0.168     2.704
> >     0.174     0.169     2.729
> >     0.174     0.172     2.741
> >     0.174     0.174     2.745
> >     0.174     0.174     2.755
> >     0.174     0.175     2.790
> >     0.174     0.177     2.809
> >     0.174     0.179     3.096
> >     0.174     0.183     3.144
> >     0.174     0.184     3.158
> >     0.174     0.185     3.175
> >     0.174     0.185     4.568
> >     0.174     0.198     4.821
> >     0.174     0.214     5.143
> >     0.174     0.251     5.220
> >
> > Patched:
> >
> >     0.007     0.007     1.952
> >     0.007     0.007     1.955
> >     0.007     0.007     1.955
> >     0.007     0.007     1.955
> >     0.007     0.007     1.957
> >     0.007     0.007     1.969
> >     0.007     0.007     2.065
> >     0.007     0.007     2.075
> >     0.007     0.007     2.146
> >     0.007     0.007     2.195
> >     0.007     0.007     2.223
> >     0.007     0.007     2.259
> >     0.007     0.007     2.488
> >     0.007     0.007     2.562
> >     0.007     0.007     2.599
> >     0.007     0.007     2.697
> >     0.007     0.007     3.030
> >     0.007     0.007     3.075
> >     0.007     0.007     3.145
> >     0.007     0.007     3.225
>
> Ohhh lovely!
>
> >
> > [1] https://github.com/paulmckrcu/proc-mmap_sem-test
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Having looked through it carefully the logic looks correct to me, but I
> think we can improve how this is implemented, so attach a patch with my
> suggestions folded up to make life easier!
>
> > ---
> >  fs/proc/task_mmu.c | 134 ++++++++++++++++++++-------------------------
> >  1 file changed, 59 insertions(+), 75 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 023422fcee12..c2bd9f5bbbcd 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -233,6 +233,16 @@ static inline void reacquire_rcu(struct proc_maps_=
private *priv)
> >       vma_iter_set(&priv->iter, priv->lock_ctx.locked_vma->vm_end);
> >  }
> >
> > +static inline bool is_mmap_lock_contended(struct proc_maps_private *pr=
iv)
>
> Hmm seems David and I are saying the same things :) but yeah this name be=
ing
> very close to mmap_lock_is_contended() is suboptimal.
>
> Also the inline is pointless here and suppresses the compiler unused chec=
k which
> isn't helpful.

Ack.

>
> But in general, given we already have the lock context I think we can do =
away
> with this altogether, see below.
>
>
> > +{
> > +     struct proc_maps_locking_ctx *lock_ctx =3D &priv->lock_ctx;
> > +
> > +     if (!lock_ctx->mmap_locked)
> > +             return false;
> > +
> > +     return !!mmap_lock_is_contended(lock_ctx->mm);
>
> As David said, !! is not a necessary incantation any more :)

Ack.

>
> > +}
> > +
> >  #else /* CONFIG_PER_VMA_LOCK */
> >
> >  static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
> > @@ -268,6 +278,11 @@ static inline bool fallback_to_mmap_lock(struct pr=
oc_maps_private *priv,
> >       return false;
> >  }
> >
> > +static inline bool is_mmap_lock_contended(struct proc_maps_private *pr=
iv)
> > +{
> > +     return !!mmap_lock_is_contended(priv->lock_ctx.mm);
>
> Similarly. But also as above I don't think we need this.

Sadly, for now we do (see my later comment).

>
> > +}
> > +
> >  static inline void drop_rcu(struct proc_maps_private *priv) {}
> >  static inline void reacquire_rcu(struct proc_maps_private *priv) {}
> >
> > @@ -1486,12 +1501,15 @@ static int show_smap(struct seq_file *m, void *=
v)
> >  static int show_smaps_rollup(struct seq_file *m, void *v)
> >  {
> >       struct proc_maps_private *priv =3D m->private;
> > +     struct proc_maps_locking_ctx *lock_ctx =3D &priv->lock_ctx;
> > +     struct mm_struct *mm =3D lock_ctx->mm;
> >       struct mem_size_stats mss =3D {};
> > -     struct mm_struct *mm =3D priv->lock_ctx.mm;
> >       struct vm_area_struct *vma;
> > -     unsigned long vma_start =3D 0, last_vma_end =3D 0;
> > +     unsigned long vma_start =3D 0;
> > +     unsigned long last_vma_end =3D 0;
>
> I mean I kinda prefer these separate but obviously not necessary :P

It looked nicer I think :)

>
> > +     loff_t pos =3D 0;
> >       int ret =3D 0;
> > -     VMA_ITERATOR(vmi, mm, 0);
> > +
>
> Yeah extra line as David said :)

Ack.

>
> >
> >       priv->task =3D get_proc_task(priv->inode);
> >       if (!priv->task)
> > @@ -1502,89 +1520,55 @@ static int show_smaps_rollup(struct seq_file *m=
, void *v)
> >               goto out_put_task;
> >       }
> >
> > -     ret =3D lock_ctx_mm(&priv->lock_ctx);
> > +     hold_task_mempolicy(priv);
> > +     ret =3D lock_vma_range(m, lock_ctx);
> >       if (ret)
> >               goto out_put_mm;
> >
> > -     hold_task_mempolicy(priv);
> > -     vma =3D vma_next(&vmi);
> > -
> > -     if (unlikely(!vma))
> > +     vma_iter_init(&priv->iter, mm, 0);
> > +     vma =3D proc_get_vma(m, &pos);
> > +     if (unlikely(!vma) || vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> >               goto empty_set;
>
> Is the gate VMA check here necessary? We already check it in the loop.

We need it to avoid resetting vma_start, which is being reported even
when no normal VMAs are present.

>
> >
> > +     if (IS_ERR(vma)) {
> > +             ret =3D PTR_ERR(vma);
> > +             goto out_unlock;
> > +     }
>
> Again this is duplicated.
>
> > +
> >       vma_start =3D vma->vm_start;
>
> Could just drop the gate check, and replace this with:
>
>         vma_start =3D IS_ERR(vma) ? 0 : vma->vm_start;

Yeah, that would work. I don't have a strong preference but avoiding
the loop on error seemed cleaner to me. Will change.

>
> > -     do {
> > -             smap_gather_stats(priv, vma, &mss, 0);
> > +     while (vma) {
> > +             if (IS_ERR(vma)) {
> > +                     ret =3D PTR_ERR(vma);
> > +                     goto out_unlock;
> > +             }
> > +
> > +             if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> > +                     break;
> > +
> > +             /*
> > +              * If after retaking mmap_lock, already reported VMA grew=
 or
> > +              * merged with the next one, then iterate from last_vma_e=
nd.
> > +              */
>
> Hmm, but if the already reported VMA grew, vma->vm_start would not be <
> last_vma_end would it?

The scenario is: we reported the VMA before it grew, we set
last_vma_end to its vm_end then dropped the lock. Later after VMA grew
we searched past the last_vma_end and found the same VMA because now
it spans past last_vma_end. In this case vma->vm_start will be less
than last_vma_end and I think this would happen either if the VMA grew
or got merged with its upper neighbor.

>
> So surely this is only covering the merge case?
>
> > +             smap_gather_stats(priv, vma, &mss,
> > +                               vma->vm_start < last_vma_end ? last_vma=
_end : 0);
>
> I don't love how compressed this is.
>
> I also don't love that 0 is taken to be 'start from vma->vm_start' and I
> also don't love that the code in smap_gather_stats() actually special cas=
es
> this...
>
> How about passing last_vma_end and making smap_gather_stats() more sane? =
In
> the other invocation of smap_gather_stats() we could pass vma->vm_start
> here.
>
> We can then move the comment into smap_gather_stats(). E.g.:
>
>                 /* Handles the case of VMA merged since mmap locked drop =
too. */
>                 smap_gather_stats(priv, vma, &mss, last_vma_end);
>
> To make life easier I put all of my suggestions into a patch which I've
> attached :) (though it is untested) let me know what you think.

I was trying to minimize changes to the current logic but that would
be cleaner. I think it would be better to make this logical change as
a separate prerequisite patch. If you agree then I'll do that in my
next version.

>
>
> >               last_vma_end =3D vma->vm_end;
> >
> >               /*
> >                * Release mmap_lock temporarily if someone wants to
> > -              * access it for write request.
> > +              * take it for write request.
>
> I think this is better rewritten to reflect the changes. E.g.:
>
>                 /*
>                  * If the VMA lock is not taken, we hold the often conten=
ded
>                  * mmap lock. This can be because the arch doesn't suppor=
t VMA
>                  * locks,or we had to fall back to the mmap lock.

I intend to postpone this patchset until after Dave's patchset lands
into mm-unstable, so this "arch doesn't support VMA locks" part will
not be there, but othereise SGTM.

>                  *
>                  * To relieve pressure, check if it is indeed contended, =
then
>                  * temporarily release it.
>                  */
>
> >                */
> > -             if (mmap_lock_is_contended(mm)) {
> > -                     vma_iter_invalidate(&vmi);
> > -                     unlock_ctx_mm(&priv->lock_ctx);
> > -                     ret =3D lock_ctx_mm(&priv->lock_ctx);
> > -                     if (ret) {
> > -                             release_task_mempolicy(priv);
> > +             if (is_mmap_lock_contended(priv)) {
>
> We have both mm and lock_ctx already.
>
> So we could instead do:
>
>                 if (lock_ctx->mmap_locked && mmap_lock_is_contended(mm)) =
{
>                         ...
>
> Right?

Unfortunately not. If you look at the struct proc_maps_locking_ctx
definition, mmap_locked will not be there if CONFIG_PER_VMA_LOCK=3Dn.
That's why I have to introduce versions of is_mmap_lock_contended()
for both CONFIG_PER_VMA_LOCK and !CONFIG_PER_VMA_LOCK configs. And
that's why I'm leaning towards waiting for Dave's cleanup to be posted
which will eliminate CONFIG_PER_VMA_LOCK. It will clean up many other
similar helpers in this file.

I just realized I did not CC Dave to this series before, so adding him now.

>
> > +                     unlock_vma_range(&priv->lock_ctx);
>
> OK this confuses me - we're gated on lock_ctx->mmap_locked, so this is ex=
actly
> the same as unlock_ctx_mm(lock_ctx) right?
>
> There's no situation here where the VMA lock would be unlocked.
>
> Surely it'd therefore be clearer to just call unlock_ctx_mm(lock_ctx)
> direct?

Technically yes but one thing I forgot to do here is to remove the
lock_ctx_mm()/unlock_ctx_mm() helpers because after this change there
are no direct users for them.

>
> > +                     ret =3D lock_vma_range(m, lock_ctx);
> > +                     if (ret)
> >                               goto out_put_mm;
>
>
> In the case of VMA locks being supported, but we fell back to mmap locks,=
 this
> seems to just be getting us back to the invariant that the RCU read lock =
is
> held.
>
> However, it's a bit confusing given we're explicitly checking for the
> mmap_locked case, so I think it's worth a comment explaining that we migh=
t have
> fallen back to mmap lock, but could still get the VMA lock on the next VM=
A.
>
> E.g.:
>
>         /*
>          * If we are using VMA locks but fell back to an mmap lock, we ma=
y
>          * be able to VMA lock the next VMA, so reset the lock and try ag=
ain.
>          *
>          * Otherwise, if the arch doesn't support VMA locks, this simply
>          * retakes the mmap lock.
>          */

Yeah, I can see now that this case is quite confusing and needs more
comments. Will do in the next rev.

>
>
> > -                     }
> > -
> > -                     /*
> > -                      * After dropping the lock, there are four cases =
to
> > -                      * consider. See the following example for explan=
ation.
> > -                      *
> > -                      *   +------+------+-----------+
> > -                      *   | VMA1 | VMA2 | VMA3      |
> > -                      *   +------+------+-----------+
> > -                      *   |      |      |           |
> > -                      *  4k     8k     16k         400k
> > -                      *
> > -                      * Suppose we drop the lock after reading VMA2 du=
e to
> > -                      * contention, then we get:
> > -                      *
> > -                      *      last_vma_end =3D 16k
> > -                      *
> > -                      * 1) VMA2 is freed, but VMA3 exists:
> > -                      *
> > -                      *    vma_next(vmi) will return VMA3.
> > -                      *    In this case, just continue from VMA3.
> > -                      *
> > -                      * 2) VMA2 still exists:
> > -                      *
> > -                      *    vma_next(vmi) will return VMA3.
> > -                      *    In this case, just continue from VMA3.
> > -                      *
> > -                      * 3) No more VMAs can be found:
> > -                      *
> > -                      *    vma_next(vmi) will return NULL.
> > -                      *    No more things to do, just break.
> > -                      *
> > -                      * 4) (last_vma_end - 1) is the middle of a vma (=
VMA'):
> > -                      *
> > -                      *    vma_next(vmi) will return VMA' whose range
> > -                      *    contains last_vma_end.
> > -                      *    Iterate VMA' from last_vma_end.
> > -                      */
> > -                     vma =3D vma_next(&vmi);
> > -                     /* Case 3 above */
> > -                     if (!vma)
> > -                             break;
> > -
> > -                     /* Case 1 and 2 above */
> > -                     if (vma->vm_start >=3D last_vma_end) {
> > -                             smap_gather_stats(priv, vma, &mss, 0);
> > -                             last_vma_end =3D vma->vm_end;
> > -                             continue;
> > -                     }
> >
> > -                     /* Case 4 above */
> > -                     if (vma->vm_end > last_vma_end) {
> > -                             smap_gather_stats(priv, vma, &mss, last_v=
ma_end);
> > -                             last_vma_end =3D vma->vm_end;
> > -                     }
>
> OK so you're rolling all this up into the 'if after retaking mmap_lock'
> bit.

Yep, because Cases 1-3 and quite natural. Case 4 is the only "special"
case here IMO, so we handle it separately with separate comments
added.

>
> I don't love that we're losing this information, but also it's maybe a
> little more than we need here and it's making
>
> But perhaps could we transfer this into the commit message as a
> later-findable justification?

Sure, that I can do.

>
> > +                     /* Resume from the last position. */
> > +                     pos =3D last_vma_end;
> > +                     vma_iter_init(&priv->iter, mm, pos);
> >               }
> > -     } for_each_vma(vmi, vma);
> > +             vma =3D proc_get_vma(m, &pos);
> > +     }
> >
> >  empty_set:
> >       show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
> > @@ -1593,10 +1577,10 @@ static int show_smaps_rollup(struct seq_file *m=
, void *v)
> >
> >       __show_smap(m, &mss, true);
> >
> > -     release_task_mempolicy(priv);
> > -     unlock_ctx_mm(&priv->lock_ctx);
> > -
> > +out_unlock:
> > +     unlock_vma_range(&priv->lock_ctx);
> >  out_put_mm:
> > +     release_task_mempolicy(priv);
>
> Previously this was done under the mmap lock, now it's not. I don't think
> this should be an issue but just highlighting.

Yeah, I looked into that but found no evidence that it's a problem. If
anyone knows otherwise please let me know.

Thanks for the review, Lorenzo! Much appreciated.

>
> >       mmput(mm);
> >  out_put_task:
> >       put_task_struct(priv->task);
> > --
> > 2.54.0.1032.g2f8565e1d1-goog
> >
>
> Cheers, Lorenzo
>
> ----8<----
> From d94e7a192242f2cefb10bbfa12495e46c3d4c973 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <ljs@kernel.org>
> Date: Tue, 9 Jun 2026 10:39:39 +0100
> Subject: [PATCH] ideas
>
> ---
>  fs/proc/task_mmu.c | 89 ++++++++++++++++++++++------------------------
>  1 file changed, 42 insertions(+), 47 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index c2bd9f5bbbcd..16bf3cd8c7c7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -233,16 +233,6 @@ static inline void reacquire_rcu(struct proc_maps_pr=
ivate *priv)
>         vma_iter_set(&priv->iter, priv->lock_ctx.locked_vma->vm_end);
>  }
>
> -static inline bool is_mmap_lock_contended(struct proc_maps_private *priv=
)
> -{
> -       struct proc_maps_locking_ctx *lock_ctx =3D &priv->lock_ctx;
> -
> -       if (!lock_ctx->mmap_locked)
> -               return false;
> -
> -       return !!mmap_lock_is_contended(lock_ctx->mm);
> -}
> -
>  #else /* CONFIG_PER_VMA_LOCK */
>
>  static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
> @@ -278,11 +268,6 @@ static inline bool fallback_to_mmap_lock(struct proc=
_maps_private *priv,
>         return false;
>  }
>
> -static inline bool is_mmap_lock_contended(struct proc_maps_private *priv=
)
> -{
> -       return !!mmap_lock_is_contended(priv->lock_ctx.mm);
> -}
> -
>  static inline void drop_rcu(struct proc_maps_private *priv) {}
>  static inline void reacquire_rcu(struct proc_maps_private *priv) {}
>
> @@ -1375,17 +1360,24 @@ get_smaps_shmem_walk_ops(struct proc_maps_private=
 *priv)
>
>  #endif /* CONFIG_PER_VMA_LOCK */
>
> -/*
> - * Gather mem stats from @vma with the indicated beginning
> - * address @start, and keep them in @mss.
> +/**
> + * smap_gather_stats() - Gather mem stats from @vma.
> + * @priv: proc maps private state.
> + * @vma: The VMA whoms stats we wish to gather.
> + * @mss: The accumulated stats.
> + * @start: The address from which to start.
>   *
> - * Use vm_start of @vma as the beginning address if @start is 0.
> + * This gathers stats for the whole of the VMA unless the mmap lock was =
dropped
> + * and we raced a VMA merge, in which case we only gather stats for the
> + * remainder of the merged range.
>   */
>  static void smap_gather_stats(struct proc_maps_private *priv,
>                               struct vm_area_struct *vma,
> -                             struct mem_size_stats *mss, unsigned long s=
tart)
> +                             struct mem_size_stats *mss,
> +                             unsigned long start)
>  {
>         const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv);
> +       const bool is_partial =3D start > vma->vm_start;
>
>         /* Invalid start */
>         if (start >=3D vma->vm_end)
> @@ -1408,20 +1400,20 @@ static void smap_gather_stats(struct proc_maps_pr=
ivate *priv,
>                  * Unless we know that the shmem object (or the part mapp=
ed by
>                  * our VMA) has no swapped out pages at all.
>                  */
> -               unsigned long shmem_swapped =3D shmem_swap_usage(vma);
> +               const unsigned long shmem_swapped =3D shmem_swap_usage(vm=
a);
> +               const bool shared_or_ro =3D vma_test(vma, VMA_SHARED_BIT)=
 ||
> +                       !vma_test(vma, VMA_WRITE_BIT);
>
> -               if (!start && (!shmem_swapped || (vma->vm_flags & VM_SHAR=
ED) ||
> -                                       !(vma->vm_flags & VM_WRITE))) {
> +               if (!is_partial && (!shmem_swapped || shared_or_ro))
>                         mss->swap +=3D shmem_swapped;
> -               } else {
> +               else
>                         ops =3D get_smaps_shmem_walk_ops(priv);
> -               }
>         }
>
> -       if (!start)
> -               walk_page_vma(vma, ops, mss);
> -       else
> +       if (is_partial)
>                 walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss)=
;
> +       else
> +               walk_page_vma(vma, ops, mss);
>
>         reacquire_rcu(priv);
>  }
> @@ -1476,7 +1468,7 @@ static int show_smap(struct seq_file *m, void *v)
>         struct vm_area_struct *vma =3D v;
>         struct mem_size_stats mss =3D {};
>
> -       smap_gather_stats(priv, vma, &mss, 0);
> +       smap_gather_stats(priv, vma, &mss, vma->vm_start);
>
>         show_map_vma(m, vma);
>
> @@ -1510,7 +1502,6 @@ static int show_smaps_rollup(struct seq_file *m, vo=
id *v)
>         loff_t pos =3D 0;
>         int ret =3D 0;
>
> -
>         priv->task =3D get_proc_task(priv->inode);
>         if (!priv->task)
>                 return -ESRCH;
> @@ -1527,15 +1518,10 @@ static int show_smaps_rollup(struct seq_file *m, =
void *v)
>
>         vma_iter_init(&priv->iter, mm, 0);
>         vma =3D proc_get_vma(m, &pos);
> -       if (unlikely(!vma) || vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> +       if (unlikely(!vma))
>                 goto empty_set;
>
> -       if (IS_ERR(vma)) {
> -               ret =3D PTR_ERR(vma);
> -               goto out_unlock;
> -       }
> -
> -       vma_start =3D vma->vm_start;
> +       vma_start =3D IS_ERR(vma) ? 0 : vma->vm_start;
>         while (vma) {
>                 if (IS_ERR(vma)) {
>                         ret =3D PTR_ERR(vma);
> @@ -1545,20 +1531,29 @@ static int show_smaps_rollup(struct seq_file *m, =
void *v)
>                 if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
>                         break;
>
> -               /*
> -                * If after retaking mmap_lock, already reported VMA grew=
 or
> -                * merged with the next one, then iterate from last_vma_e=
nd.
> -                */
> -               smap_gather_stats(priv, vma, &mss,
> -                                 vma->vm_start < last_vma_end ? last_vma=
_end : 0);
> +               /* Handles the case of VMA merged since mmap locked drop =
too. */
> +               smap_gather_stats(priv, vma, &mss, last_vma_end);
>                 last_vma_end =3D vma->vm_end;
>
>                 /*
> -                * Release mmap_lock temporarily if someone wants to
> -                * take it for write request.
> +                * If the VMA lock is not taken, we hold the often conten=
ded
> +                 * mmap lock. This can be because the arch doesn't suppo=
rt VMA
> +                 * locks,or we had to fall back to the mmap lock.
> +                *
> +                * To relieve pressure, check if it is indeed contended, =
then
> +                 * temporarily release it.
>                  */
> -               if (is_mmap_lock_contended(priv)) {
> -                       unlock_vma_range(&priv->lock_ctx);
> +               if (lock_ctx->mmap_locked && mmap_lock_is_contended(mm)) =
{
> +                       unlock_ctx_mm(lock_ctx);
> +
> +                       /*
> +                        * If we are using VMA locks but fell back to an =
mmap
> +                        * lock, we may be able to VMA lock the next VMA,=
 so
> +                        * reset the lock and try again.
> +                        *
> +                        * Otherwise, if the arch doesn't support VMA loc=
ks,
> +                        * this simply retakes the mmap lock.
> +                        */
>                         ret =3D lock_vma_range(m, lock_ctx);
>                         if (ret)
>                                 goto out_put_mm;
> --
> 2.54.0
