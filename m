Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1CA4192FE
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103408; cv=pass; b=JzbSewXX70oN/tq3nm+AW1/7ZCir9+lk7nxPaaCokl2WpYUbxr67Z9A6wDu78hLVghbXMD29Q2TO9oUpSBbGQ602fRLc25uGorpm6VbO7JPJAXOjol+mBCjsjgVC1828m9NiPjgn6rzpcpU/9PmDeUPMemK5lGyQp+k5x+G1y3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103408; c=relaxed/simple;
	bh=LH33NIrmEN81KfmsSqSM+ultz3w2SfZZWyouzC91ws8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFiiG6Cs7I01nb1s+ABtrnCR5ncxPsJHgL7ZAJryaW8IwO6966yzK7fm1QlZJmlMPYHW8b1qgytBKA4+BVu84nnouqOehnYeDOavC32hQyP1TguOkhAHHgdIXtvByM7aJkT+eyknvmBPYxHeO+f3C8aRsSXHb0iBZmzJZU8E+No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPOLMhkE; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPOLMhkE"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51765531803so440911cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 07:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781103405; cv=none;
        d=google.com; s=arc-20240605;
        b=cbI3NfN9tLTaVEpnNQmXnCsNQhjbs/+/44As4dvwSm3isFy/tnyNpPhB24r79EsmD9
         JeGFikj29eui8t5AMNIwwVgNy/bhJmuIJTUsQgloj3pywpBUHozthcKf9pAD2n3B8x+0
         RURIu/udJ2kKXyTHuk1Z4lmooHwbueIcpMRsMheNvEBM1GWxStQC9rHGfMbo8U6LdVCe
         6/1faRbl9jOFBL3JmEuqhH7963wcSpfBghzUGrMqioDCv9auhi3csLvSBIVqtsMtxrgh
         mNjNSM+UxfxLkzkhnknr3JuFeduJSbqtlqDbrhgRswVCdW73laAcX5pJWEXW7X3jfktW
         Lk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MxfItaejrPO/EXY9jrIp/mcWPBQwGQ4BozUUIa+QDZc=;
        fh=eKSgxG6uI2x8odcygTtbgrWR3LYHBCfgbMUWH6FVaRU=;
        b=ZsZdqlA4BePT+n46P7C4nIRw8UCNEgODRCbnDZStHb3c23VmxT7i12y5g4tez5hkh0
         ORjUS710Q5tyItsi5jqRJrM4oSxNO1ELkvBeFTk1Ecy/YNOHqcNDWEizsKzQzhbKL+uk
         JDReJyz1QXzx+OMEvqe36ITvSQX8cRr0wNo2jxFSGYNk1bv2WWQjvx+VeTt2ZspvIdwl
         o+klzTUiPNDHT5rwpuREBNnJLZ8jLk62fZObcxFNu/pGc/GzvWpVwXImsOEGWdvqBjgt
         KADkV02SAMVTGw9/ah6xdbmQhjx7wRjRfa730B7N0btFq5d4MOiK6/udvVBlqA8d5vs5
         +Tvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781103405; x=1781708205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxfItaejrPO/EXY9jrIp/mcWPBQwGQ4BozUUIa+QDZc=;
        b=HPOLMhkEfGeFprZgxty+qmMKsrOJms7g2WQ7BuBIuG1tM2q9LFQB7oanNxmojIGe42
         qXnGpv/BEaJZDn9fuLhBOyxnXU7Od0gI8tSG0m3LGlGGNeRJ3zsHm/yLVAWGxzjRsbLF
         awyzAG5NGM7/JyZqK0RiG3dw1wevQ7NqvAKs0St3oEmkjCyQbg5Zi3WlxX73nR/Y+t5y
         sYVmRjM+TImckN1ReAlvckdaKMJawgVp7NamklH2QUT7T1wRFjMHM4/n8h+Eaq/CYIh2
         cZpQSQwHMf7I5Zyl2MG2Amk1j0I2RvMWpYJ198MgwcI9ING9mmiFBe1RS7nV1hAFSw4o
         kMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781103405; x=1781708205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxfItaejrPO/EXY9jrIp/mcWPBQwGQ4BozUUIa+QDZc=;
        b=N18f9DmbMmwV2SWjpWjDnHY+Cuj6OZ++cQu8/YXtmWh/ypfhrBbg+/yutNjP9t36b5
         Sfr9FtE86Mz/+daGgVaUzPAkz11uxZcm7R6VQop6QaYuBPk2LDr41tU24A4lJlTpHwjj
         PWm5U/UATkdOYJ9AMKRZ2Xwh3B75uHvHxyIVnJR7RjIq6bU83uJq0ACDyhb6FlpWY79x
         z1CE4eb0v68A0dymWRtZACF+wBe+wwngR/ab9R4UEsF8RpgbVL9ifpmZ0Fdg4Gnow7yW
         7E3zif90t8o+JMuPR6Iqc69Y/wVrXXr3U+LFA1DH9/taWbcqNsGxgIPwW+pgbgExGtU/
         /hLA==
X-Forwarded-Encrypted: i=1; AFNElJ97J1DwKwgSzLRr+rA6RG2UG4B0OkNnOc9ndjGImy6BW1F9C1ETIsejL3DSVdptMeyCmrCrbRDVa/7gJ6pr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf0JzPVZ4TjEE0Qu3nSim656T9eiPKxtOmsO25+YfQBM5MJ3BQ
	k8Tu8/lxU3+lCewKdDgxCO47UpjyXOFkXr0VbmlvQk/BeRLoJb/DWNCj3oqwdnPv6oEykp0fT1m
	k67zEE9Ju4g2GJ9mQRLHxdv64DWv5cyd28VW4euJL
X-Gm-Gg: Acq92OH+LMJcTANCCvuVxDfG4lHgvl0jQBXE3Et45q41CMo3QJ60RM3Y2cqzquhXXL2
	Qwutxi/y3dLI4RSpr19hUFpZ8kOdB7kxIQbgN5K//4ti/+jxqcwYHubLJrZoOccC4WMr4FCyG00
	Iky054xP/1ulavbabEV+a9e+x2pYpEQAyq2pcSFgcbAWyMjC1hrYVucFMywJ/IdaWP/N1cB1ffm
	4wVpOpI4+4fZgo0EppzhiMdmvkH6xw9R0Az8joQ9bGzSQRKqZsadgO0gXUDoNutS7dpslpnJYe/
	FyaC1LexpN1O4M9gAirxKO506xMuMxe4jNwmRLdMGHHbyX5UEPKKo9PVNsc=
X-Received: by 2002:ac8:66cb:0:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-517e965a38cmr259981cf.16.1781103404001; Wed, 10 Jun 2026
 07:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606015729.1837935-1-surenb@google.com> <20260606015729.1837935-2-surenb@google.com>
 <aifO_rCurVhFRTcl@lucifer> <CAJuCfpFOpvNmV4aHnk3Vi0Jg4vF4Cmsm86h2vODZ84FVLXt9yw@mail.gmail.com>
 <aikLCwuzqBetvDrf@lucifer>
In-Reply-To: <aikLCwuzqBetvDrf@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jun 2026 07:56:32 -0700
X-Gm-Features: AVVi8Cekrphjv0dD52wYmESS-mSo-vnm9lwO1Kmy5ooW4sNmH-7NBDF3R0Ennpw
Message-ID: <CAJuCfpHX5zoaD9XxDGbpXHs5U_8OrRyRuk=Nx8CjDb5qMNy0jA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 12:05=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> w=
rote:
>
> On Tue, Jun 09, 2026 at 10:11:03AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Jun 9, 2026 at 3:00=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org>=
 wrote:
> > >
> > > On Fri, Jun 05, 2026 at 06:57:29PM -0700, Suren Baghdasaryan wrote:
> > > > proc/pid/smaps_rollup can be read using the combination of RCU and
> > > > VMA read locks, similar to proc/pid/{maps|smaps|numa_maps}. RCU is
> > > > required to safely traverse the VMA tree and VMA lock stabilizes th=
e
> > > > VMA being processed and the pagetable walk.
> > > > Note that we have to keep the logic to drop mmap_lock on contention
> > > > because even when using per-VMA locks we might have to fall back to
> > > > holding the mmap_lock.
> > > >
> > > > Running Paul's contention benchmark [1] shows considerable improvem=
ent
> > > > both in median and in the worst case latencies:
> > > >
> > > > Execution command: run-proc-vs-map.sh --nsamples 20 --rawdata -- \
> > > > --busyduration 2 --procfile smaps_rollup
> > > >
> > > > Baseline:
> > > >
> > > >     0.174     0.161     2.553
> > > >     0.174     0.164     2.663
> > > >     0.174     0.165     2.664
> > > >     0.174     0.166     2.679
> > > >     0.174     0.167     2.691
> > > >     0.174     0.168     2.704
> > > >     0.174     0.169     2.729
> > > >     0.174     0.172     2.741
> > > >     0.174     0.174     2.745
> > > >     0.174     0.174     2.755
> > > >     0.174     0.175     2.790
> > > >     0.174     0.177     2.809
> > > >     0.174     0.179     3.096
> > > >     0.174     0.183     3.144
> > > >     0.174     0.184     3.158
> > > >     0.174     0.185     3.175
> > > >     0.174     0.185     4.568
> > > >     0.174     0.198     4.821
> > > >     0.174     0.214     5.143
> > > >     0.174     0.251     5.220
> > > >
> > > > Patched:
> > > >
> > > >     0.007     0.007     1.952
> > > >     0.007     0.007     1.955
> > > >     0.007     0.007     1.955
> > > >     0.007     0.007     1.955
> > > >     0.007     0.007     1.957
> > > >     0.007     0.007     1.969
> > > >     0.007     0.007     2.065
> > > >     0.007     0.007     2.075
> > > >     0.007     0.007     2.146
> > > >     0.007     0.007     2.195
> > > >     0.007     0.007     2.223
> > > >     0.007     0.007     2.259
> > > >     0.007     0.007     2.488
> > > >     0.007     0.007     2.562
> > > >     0.007     0.007     2.599
> > > >     0.007     0.007     2.697
> > > >     0.007     0.007     3.030
> > > >     0.007     0.007     3.075
> > > >     0.007     0.007     3.145
> > > >     0.007     0.007     3.225
> > >
> > > Ohhh lovely!
> > >
> > > >
> > > > [1] https://github.com/paulmckrcu/proc-mmap_sem-test
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Having looked through it carefully the logic looks correct to me, but=
 I
> > > think we can improve how this is implemented, so attach a patch with =
my
> > > suggestions folded up to make life easier!
> > >
> > > > ---
> > > >  fs/proc/task_mmu.c | 134 ++++++++++++++++++++---------------------=
----
> > > >  1 file changed, 59 insertions(+), 75 deletions(-)
> > > >
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index 023422fcee12..c2bd9f5bbbcd 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -233,6 +233,16 @@ static inline void reacquire_rcu(struct proc_m=
aps_private *priv)
> > > >       vma_iter_set(&priv->iter, priv->lock_ctx.locked_vma->vm_end);
> > > >  }
> > > >
> > > > +static inline bool is_mmap_lock_contended(struct proc_maps_private=
 *priv)
> > >
> > > Hmm seems David and I are saying the same things :) but yeah this nam=
e being
> > > very close to mmap_lock_is_contended() is suboptimal.
> > >
> > > Also the inline is pointless here and suppresses the compiler unused =
check which
> > > isn't helpful.
> >
> > Ack.
> >
> > >
> > > But in general, given we already have the lock context I think we can=
 do away
> > > with this altogether, see below.
> > >
> > >
> > > > +{
> > > > +     struct proc_maps_locking_ctx *lock_ctx =3D &priv->lock_ctx;
> > > > +
> > > > +     if (!lock_ctx->mmap_locked)
> > > > +             return false;
> > > > +
> > > > +     return !!mmap_lock_is_contended(lock_ctx->mm);
> > >
> > > As David said, !! is not a necessary incantation any more :)
> >
> > Ack.
> >
> > >
> > > > +}
> > > > +
> > > >  #else /* CONFIG_PER_VMA_LOCK */
> > > >
> > > >  static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_c=
tx)
> > > > @@ -268,6 +278,11 @@ static inline bool fallback_to_mmap_lock(struc=
t proc_maps_private *priv,
> > > >       return false;
> > > >  }
> > > >
> > > > +static inline bool is_mmap_lock_contended(struct proc_maps_private=
 *priv)
> > > > +{
> > > > +     return !!mmap_lock_is_contended(priv->lock_ctx.mm);
> > >
> > > Similarly. But also as above I don't think we need this.
> >
> > Sadly, for now we do (see my later comment).
> >
> > >
> > > > +}
> > > > +
> > > >  static inline void drop_rcu(struct proc_maps_private *priv) {}
> > > >  static inline void reacquire_rcu(struct proc_maps_private *priv) {=
}
> > > >
> > > > @@ -1486,12 +1501,15 @@ static int show_smap(struct seq_file *m, vo=
id *v)
> > > >  static int show_smaps_rollup(struct seq_file *m, void *v)
> > > >  {
> > > >       struct proc_maps_private *priv =3D m->private;
> > > > +     struct proc_maps_locking_ctx *lock_ctx =3D &priv->lock_ctx;
> > > > +     struct mm_struct *mm =3D lock_ctx->mm;
> > > >       struct mem_size_stats mss =3D {};
> > > > -     struct mm_struct *mm =3D priv->lock_ctx.mm;
> > > >       struct vm_area_struct *vma;
> > > > -     unsigned long vma_start =3D 0, last_vma_end =3D 0;
> > > > +     unsigned long vma_start =3D 0;
> > > > +     unsigned long last_vma_end =3D 0;
> > >
> > > I mean I kinda prefer these separate but obviously not necessary :P
> >
> > It looked nicer I think :)
>
> Yeah tbh I think you're right
>
> >
> > >
> > > > +     loff_t pos =3D 0;
> > > >       int ret =3D 0;
> > > > -     VMA_ITERATOR(vmi, mm, 0);
> > > > +
> > >
> > > Yeah extra line as David said :)
> >
> > Ack.
> >
> > >
> > > >
> > > >       priv->task =3D get_proc_task(priv->inode);
> > > >       if (!priv->task)
> > > > @@ -1502,89 +1520,55 @@ static int show_smaps_rollup(struct seq_fil=
e *m, void *v)
> > > >               goto out_put_task;
> > > >       }
> > > >
> > > > -     ret =3D lock_ctx_mm(&priv->lock_ctx);
> > > > +     hold_task_mempolicy(priv);
> > > > +     ret =3D lock_vma_range(m, lock_ctx);
> > > >       if (ret)
> > > >               goto out_put_mm;
> > > >
> > > > -     hold_task_mempolicy(priv);
> > > > -     vma =3D vma_next(&vmi);
> > > > -
> > > > -     if (unlikely(!vma))
> > > > +     vma_iter_init(&priv->iter, mm, 0);
> > > > +     vma =3D proc_get_vma(m, &pos);
> > > > +     if (unlikely(!vma) || vma =3D=3D get_gate_vma(priv->lock_ctx.=
mm))
> > > >               goto empty_set;
> > >
> > > Is the gate VMA check here necessary? We already check it in the loop=
.
> >
> > We need it to avoid resetting vma_start, which is being reported even
> > when no normal VMAs are present.
>
> Well previously smap_gather_stats() would just be a no-op for a gate VMA,=
 as it
> has:
>
>         if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
>                 return;
>
> Not sure if you'd have VMAs past that (is that even possible?) but in tha=
t case
> we would have set vma_start previously.

I should explain this case in more detail. proc_get_vma() returns a
gate VMA once it finds no more VMAs. So, in this case if VMA tree is
empty, the first call to proc_get_vma() will return gate VMA. Now, the
original code was using vma_next() and would return NULL when the VMA
tree is empty and in that case it would bail out early here:
https://elixir.bootlin.com/linux/v7.1-rc7/source/fs/proc/task_mmu.c#L1423.
I need to use proc_get_vma() instead of vma_next() because it works
under RCU. So, the new code matches the previous behavior, but the
condition is different. I'll see if I can resolve this in a nicer way
but that's the gist of it.

>
> >
> > >
> > > >
> > > > +     if (IS_ERR(vma)) {
> > > > +             ret =3D PTR_ERR(vma);
> > > > +             goto out_unlock;
> > > > +     }
> > >
> > > Again this is duplicated.
> > >
> > > > +
> > > >       vma_start =3D vma->vm_start;
> > >
> > > Could just drop the gate check, and replace this with:
> > >
> > >         vma_start =3D IS_ERR(vma) ? 0 : vma->vm_start;
> >
> > Yeah, that would work. I don't have a strong preference but avoiding
> > the loop on error seemed cleaner to me. Will change.
> >
> > >
> > > > -     do {
> > > > -             smap_gather_stats(priv, vma, &mss, 0);
> > > > +     while (vma) {
> > > > +             if (IS_ERR(vma)) {
> > > > +                     ret =3D PTR_ERR(vma);
> > > > +                     goto out_unlock;
> > > > +             }
> > > > +
> > > > +             if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> > > > +                     break;
> > > > +
> > > > +             /*
> > > > +              * If after retaking mmap_lock, already reported VMA =
grew or
> > > > +              * merged with the next one, then iterate from last_v=
ma_end.
> > > > +              */
> > >
> > > Hmm, but if the already reported VMA grew, vma->vm_start would not be=
 <
> > > last_vma_end would it?
> >
> > The scenario is: we reported the VMA before it grew, we set
> > last_vma_end to its vm_end then dropped the lock. Later after VMA grew
> > we searched past the last_vma_end and found the same VMA because now
> > it spans past last_vma_end. In this case vma->vm_start will be less
> > than last_vma_end and I think this would happen either if the VMA grew
> > or got merged with its upper neighbor.
>
> OK yeah, I was thinking in terms of 2 adjacent VMAs, but in that case a '=
grow'
> is a merge, so it's either merge or grew into unmapped space.
>
> >
> > >
> > > So surely this is only covering the merge case?
> > >
> > > > +             smap_gather_stats(priv, vma, &mss,
> > > > +                               vma->vm_start < last_vma_end ? last=
_vma_end : 0);
> > >
> > > I don't love how compressed this is.
> > >
> > > I also don't love that 0 is taken to be 'start from vma->vm_start' an=
d I
> > > also don't love that the code in smap_gather_stats() actually special=
 cases
> > > this...
> > >
> > > How about passing last_vma_end and making smap_gather_stats() more sa=
ne? In
> > > the other invocation of smap_gather_stats() we could pass vma->vm_sta=
rt
> > > here.
> > >
> > > We can then move the comment into smap_gather_stats(). E.g.:
> > >
> > >                 /* Handles the case of VMA merged since mmap locked d=
rop too. */
> > >                 smap_gather_stats(priv, vma, &mss, last_vma_end);
> > >
> > > To make life easier I put all of my suggestions into a patch which I'=
ve
> > > attached :) (though it is untested) let me know what you think.
> >
> > I was trying to minimize changes to the current logic but that would
> > be cleaner. I think it would be better to make this logical change as
> > a separate prerequisite patch. If you agree then I'll do that in my
> > next version.
>
> Yeah makes sense, thanks!
>
> >
> > >
> > >
> > > >               last_vma_end =3D vma->vm_end;
> > > >
> > > >               /*
> > > >                * Release mmap_lock temporarily if someone wants to
> > > > -              * access it for write request.
> > > > +              * take it for write request.
> > >
> > > I think this is better rewritten to reflect the changes. E.g.:
> > >
> > >                 /*
> > >                  * If the VMA lock is not taken, we hold the often co=
ntended
> > >                  * mmap lock. This can be because the arch doesn't su=
pport VMA
> > >                  * locks,or we had to fall back to the mmap lock.
> >
> > I intend to postpone this patchset until after Dave's patchset lands
> > into mm-unstable, so this "arch doesn't support VMA locks" part will
> > not be there, but othereise SGTM.
>
> Yeah that'd be neater, be good to eliminate all the !CONFIG_PER_VMA_LOCK =
stuff.
>
> >
> > >                  *
> > >                  * To relieve pressure, check if it is indeed contend=
ed, then
> > >                  * temporarily release it.
> > >                  */
> > >
> > > >                */
> > > > -             if (mmap_lock_is_contended(mm)) {
> > > > -                     vma_iter_invalidate(&vmi);
> > > > -                     unlock_ctx_mm(&priv->lock_ctx);
> > > > -                     ret =3D lock_ctx_mm(&priv->lock_ctx);
> > > > -                     if (ret) {
> > > > -                             release_task_mempolicy(priv);
> > > > +             if (is_mmap_lock_contended(priv)) {
> > >
> > > We have both mm and lock_ctx already.
> > >
> > > So we could instead do:
> > >
> > >                 if (lock_ctx->mmap_locked && mmap_lock_is_contended(m=
m)) {
> > >                         ...
> > >
> > > Right?
> >
> > Unfortunately not. If you look at the struct proc_maps_locking_ctx
> > definition, mmap_locked will not be there if CONFIG_PER_VMA_LOCK=3Dn.
>
> Ugh. We probably shouldn't have bothered making that conditional :>)
>
> > That's why I have to introduce versions of is_mmap_lock_contended()
> > for both CONFIG_PER_VMA_LOCK and !CONFIG_PER_VMA_LOCK configs. And
> > that's why I'm leaning towards waiting for Dave's cleanup to be posted
> > which will eliminate CONFIG_PER_VMA_LOCK. It will clean up many other
> > similar helpers in this file.
>
> Yeah that simplifies everything.
>
> >
> > I just realized I did not CC Dave to this series before, so adding him =
now.
> >
> > >
> > > > +                     unlock_vma_range(&priv->lock_ctx);
> > >
> > > OK this confuses me - we're gated on lock_ctx->mmap_locked, so this i=
s exactly
> > > the same as unlock_ctx_mm(lock_ctx) right?
> > >
> > > There's no situation here where the VMA lock would be unlocked.
> > >
> > > Surely it'd therefore be clearer to just call unlock_ctx_mm(lock_ctx)
> > > direct?
> >
> > Technically yes but one thing I forgot to do here is to remove the
> > lock_ctx_mm()/unlock_ctx_mm() helpers because after this change there
> > are no direct users for them.
>
> OK, but we do need to make this situation clear as otherwise it's
> confusing. Maybe just move to calling unlock_vma_range() unlock_range() o=
r
> something?
>
> >
> > >
> > > > +                     ret =3D lock_vma_range(m, lock_ctx);
> > > > +                     if (ret)
> > > >                               goto out_put_mm;
> > >
> > >
> > > In the case of VMA locks being supported, but we fell back to mmap lo=
cks, this
> > > seems to just be getting us back to the invariant that the RCU read l=
ock is
> > > held.
> > >
> > > However, it's a bit confusing given we're explicitly checking for the
> > > mmap_locked case, so I think it's worth a comment explaining that we =
might have
> > > fallen back to mmap lock, but could still get the VMA lock on the nex=
t VMA.
> > >
> > > E.g.:
> > >
> > >         /*
> > >          * If we are using VMA locks but fell back to an mmap lock, w=
e may
> > >          * be able to VMA lock the next VMA, so reset the lock and tr=
y again.
> > >          *
> > >          * Otherwise, if the arch doesn't support VMA locks, this sim=
ply
> > >          * retakes the mmap lock.
> > >          */
> >
> > Yeah, I can see now that this case is quite confusing and needs more
> > comments. Will do in the next rev.
>
> Thanks
>
> >
> > >
> > >
> > > > -                     }
> > > > -
> > > > -                     /*
> > > > -                      * After dropping the lock, there are four ca=
ses to
> > > > -                      * consider. See the following example for ex=
planation.
> > > > -                      *
> > > > -                      *   +------+------+-----------+
> > > > -                      *   | VMA1 | VMA2 | VMA3      |
> > > > -                      *   +------+------+-----------+
> > > > -                      *   |      |      |           |
> > > > -                      *  4k     8k     16k         400k
> > > > -                      *
> > > > -                      * Suppose we drop the lock after reading VMA=
2 due to
> > > > -                      * contention, then we get:
> > > > -                      *
> > > > -                      *      last_vma_end =3D 16k
> > > > -                      *
> > > > -                      * 1) VMA2 is freed, but VMA3 exists:
> > > > -                      *
> > > > -                      *    vma_next(vmi) will return VMA3.
> > > > -                      *    In this case, just continue from VMA3.
> > > > -                      *
> > > > -                      * 2) VMA2 still exists:
> > > > -                      *
> > > > -                      *    vma_next(vmi) will return VMA3.
> > > > -                      *    In this case, just continue from VMA3.
> > > > -                      *
> > > > -                      * 3) No more VMAs can be found:
> > > > -                      *
> > > > -                      *    vma_next(vmi) will return NULL.
> > > > -                      *    No more things to do, just break.
> > > > -                      *
> > > > -                      * 4) (last_vma_end - 1) is the middle of a v=
ma (VMA'):
> > > > -                      *
> > > > -                      *    vma_next(vmi) will return VMA' whose ra=
nge
> > > > -                      *    contains last_vma_end.
> > > > -                      *    Iterate VMA' from last_vma_end.
> > > > -                      */
> > > > -                     vma =3D vma_next(&vmi);
> > > > -                     /* Case 3 above */
> > > > -                     if (!vma)
> > > > -                             break;
> > > > -
> > > > -                     /* Case 1 and 2 above */
> > > > -                     if (vma->vm_start >=3D last_vma_end) {
> > > > -                             smap_gather_stats(priv, vma, &mss, 0)=
;
> > > > -                             last_vma_end =3D vma->vm_end;
> > > > -                             continue;
> > > > -                     }
> > > >
> > > > -                     /* Case 4 above */
> > > > -                     if (vma->vm_end > last_vma_end) {
> > > > -                             smap_gather_stats(priv, vma, &mss, la=
st_vma_end);
> > > > -                             last_vma_end =3D vma->vm_end;
> > > > -                     }
> > >
> > > OK so you're rolling all this up into the 'if after retaking mmap_loc=
k'
> > > bit.
> >
> > Yep, because Cases 1-3 and quite natural. Case 4 is the only "special"
> > case here IMO, so we handle it separately with separate comments
> > added.
>
> Yeah.
>
> >
> > >
> > > I don't love that we're losing this information, but also it's maybe =
a
> > > little more than we need here and it's making
> > >
> > > But perhaps could we transfer this into the commit message as a
> > > later-findable justification?
> >
> > Sure, that I can do.
>
> Thanks!
>
> >
> > >
> > > > +                     /* Resume from the last position. */
> > > > +                     pos =3D last_vma_end;
> > > > +                     vma_iter_init(&priv->iter, mm, pos);
> > > >               }
> > > > -     } for_each_vma(vmi, vma);
> > > > +             vma =3D proc_get_vma(m, &pos);
> > > > +     }
> > > >
> > > >  empty_set:
> > > >       show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0=
);
> > > > @@ -1593,10 +1577,10 @@ static int show_smaps_rollup(struct seq_fil=
e *m, void *v)
> > > >
> > > >       __show_smap(m, &mss, true);
> > > >
> > > > -     release_task_mempolicy(priv);
> > > > -     unlock_ctx_mm(&priv->lock_ctx);
> > > > -
> > > > +out_unlock:
> > > > +     unlock_vma_range(&priv->lock_ctx);
> > > >  out_put_mm:
> > > > +     release_task_mempolicy(priv);
> > >
> > > Previously this was done under the mmap lock, now it's not. I don't t=
hink
> > > this should be an issue but just highlighting.
> >
> > Yeah, I looked into that but found no evidence that it's a problem. If
> > anyone knows otherwise please let me know.
> >
> > Thanks for the review, Lorenzo! Much appreciated.
>
> No problem! Thanks for the patch :)
>
> Cheers, Lorenzo
