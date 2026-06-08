Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455933A9E1
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935648; cv=pass; b=JBohvGEEiV+9b9LwpreOzDocqETWDYSNKHdmCE0iU5hDo94IAJqUgsok4IKGDwX87to81oIwTEQITASW+EsycndiMgXrcPjz4tQVCmh1i3heiiPQ7Cop8X/mvt3gNU5wcJ4+SQ0XEW7Y24iMHJlCz2M3GLzDY9g1b+ZbRN2ARy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935648; c=relaxed/simple;
	bh=fNfINfVL/Q/kC5dFiexQulYEi3oMgmSr/ZoyjjoPxEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7dBIScwmLWdF6hKgm6WKbcXbN72xYbYms8d1bIG3DVP9flMpXBLQ4JkxUta7RSOxAy4AgZv6+LJ+OpJBImhMJVgrX056QbQhLOBGOPNeh1Bt9fdns6HCzx57t64mWPKURP8cldSTymCkg4WufNBPxUWobu5omaiWMGwQKzZNIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDLPHYRe; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDLPHYRe"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51765331535so1782051cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 09:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780935645; cv=none;
        d=google.com; s=arc-20240605;
        b=hZR8tK7114gwS8FDkTOSyi+llallci6N9qvvE5lgRgERSvTLAur3xVdw45d2/crTT3
         vOYuZbP5pMRmC3X3gzLiuz3IRzExZxyPc08rKDhuaL35b7ez7yLzmKj2ee7w3Y18z3IF
         iMLa8YPQFJx4KL6e0tBuFCRFAerX4NR8UiIBsvcO8j0KNZrOC9dA6xpLkd6w1z168FvW
         Ne+AzJ92PF64xBViIepwTNffMrp8HgiGq62liw4OJcRt9XySNhg8/VJ20Fv6gj3XBO23
         fNIw0wixlSvzJD28XeoUkoQECdmQqEZkpssxRHme21XndwQrFIXOo25LGDABiuE1ZePd
         J0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZELcPlf12Yzmbyn4ebaNsKuSouoT7BC2a4NKxUUWCk=;
        fh=pQCH1dkUf/M60CcChU3cvUmVww+BB58lCvoRxBNUDIg=;
        b=J9IHffGlTCF5q2v22mCdmiAciAthcDEUoSQfs3JFpEYttFQzfmnh1BwEsp4UIFPKHX
         Q1pOTYhiXEok7PduiMjgAAN1RnAcg7UPHQS4mP8D9Z/qJBGkmvCLtfOA9M/M0ic/Z6lD
         3BugLhzDg0AX5Z0zJVCYbn2oM0bK0xd4jLszlyhEAp0sk/Nw+jSerZawNCFO2EJJ4p4q
         I3CipWqCo1yaEAbzQAiebVfPUb+tHofaQ++Uerjn1v+nLmnpV0COjSo88gsh2GHA7hgk
         7wDxuQ9uIkqen3tdDA3CdcKGaqUhbshtYgdhDVLl6tm9L906Fc3g4CtCv0NUQB3qHczv
         9iNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780935645; x=1781540445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZELcPlf12Yzmbyn4ebaNsKuSouoT7BC2a4NKxUUWCk=;
        b=nDLPHYRe08484X1vUDvQZPXYRRLIJpqI32mMLC09UZY/zdpM1QxphhTqd/zBDwd/T5
         Mwxmuc3nMIbfDesPqelVlN9/ysMexRi7dIv5EfoRsAB80iOjTTDsP14CGhZnEKO3OEZI
         ZPfmi6JN3Oftbz/LahKVZJDn7nwaotObCy30X34oFsEdO06dycsweb4RxCgDhFyQp6Xg
         bPFzvjjaTNZ6dTWU+F36/tgOTMqwPvB1gAbP5hVfop13yhtirZXAl1I+gq+e7SB7DZ2t
         n2dFiN4DCvV3l9S13p2spGAp1v1Z7aHXlHoB8+njh6fs/BPvSHQP3nSyTXdNkqk2sZPE
         Nb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935645; x=1781540445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZELcPlf12Yzmbyn4ebaNsKuSouoT7BC2a4NKxUUWCk=;
        b=dobGoq3zVXEi+ZnRY8IlT5s82k6Vvn/27dxAckHU1jE8cVHCVZ5tXRg5bbDiWha8Kf
         rH5F4IeT3NvHwV6Exl+CzhZVwc/2t0UY3RVQcbszjpJwkV+vh0HERXgOJqoO3/YMG0Zy
         PPFQ12blkns+TJ4EmOHLAocCWbdTRQmxma85t2JbA1vJRjj+hfe65SshSE1xtKcz6nTY
         XKDC79HpOodtEzUhF12wub55NlU/UJE5Fkk5KR38IwRz2ABZSm1IwkcWugiPwHoXRs1y
         GL6cQ4JWalmYw4CXBnKbjmkhj/J0PsQAS02EWLl+nq4RyDQlbiQiKZCo4u/UC1QhGqU1
         DeKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MQ9mAUKmDO67TwBGT0fl9BHrdnlALIU3+ghOf+Wo+K760e8whvT1akFcn0fvXGO1u4U4V7WM7FjrLtF7R@vger.kernel.org
X-Gm-Message-State: AOJu0YwuQ9Xw9CTHseGc1DZduepzhdTGEggRPcAaI4wXmcu27dKg/U4O
	mx0c9G6zmIr5nMeSm5KjJ4qoCvpsQ4cD+U3+OMSDJDe/nSGb5M6FI1YQuYMqaKPbcKy88hNPA06
	QllMQ1Wdrr/lhNIL6HGUbsrjoKG+DGsoE9eU2tGRv
X-Gm-Gg: Acq92OF7sy271KGHV4Oh4PhTd4oAmpoxxoRF3oHqfvcBTBwubVzmx5Me0igrhMgobEE
	5NoTd+IsegmvOKxJM84wGRGwnMk8sWzD6aMpyUiUvnMg25BCEJdtZvFZERPOOgO60+o/fPOh/gY
	LDartki0lF+pSH24tJVy7t8Xgm2YJ8d4V32nPT8pU1xYvKhtI75HCjSBH6O8sTrHwZgIKFwNFyx
	yUht2304hWm4m6Yt4olO5HLf0BerElogReLw3R+C4orkE/nmDBAZFVDvPtzV6uZJIgWhbyne9Px
	Cej0D8bgVuNl0xao
X-Received: by 2002:a05:622a:58b:b0:516:cc18:4760 with SMTP id
 d75a77b69052e-517982a0d84mr29047771cf.21.1780935644687; Mon, 08 Jun 2026
 09:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606015729.1837935-1-surenb@google.com> <20260606015729.1837935-2-surenb@google.com>
 <0d103616-56e5-4a31-abfc-f50f03253588@kernel.org>
In-Reply-To: <0d103616-56e5-4a31-abfc-f50f03253588@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 8 Jun 2026 09:20:33 -0700
X-Gm-Features: AVVi8CcoFyhnB1XjOcW5rIv4uaFa6g1DxGIO-CMd7PQfm-mRDJ6e3bxepTbhj0g
Message-ID: <CAJuCfpFYG1Y_K683w0eZF3hDPZYCFkxe_YZNmt8UVmDU7_6LRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:52=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
> On 6/6/26 03:57, Suren Baghdasaryan wrote:
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
> >
> > [1] https://github.com/paulmckrcu/proc-mmap_sem-test
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
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
> is_mmap_lock_contended() vs. mmap_lock_is_contended() ... really nasty.

Agree. Once Dave Hansen's cleanup patchset is posted we will be able
to remove most of this nastiness. Maybe I should wait for it before
posting this patch.


>
> > +{
> > +     struct proc_maps_locking_ctx *lock_ctx =3D &priv->lock_ctx;
> > +
> > +     if (!lock_ctx->mmap_locked)
> > +             return false;
> > +
> > +     return !!mmap_lock_is_contended(lock_ctx->mm);
>
> !! is not required anymore, the compiler nowadays knows how to handle boo=
leans
> correctly.

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
> > +     loff_t pos =3D 0;
> >       int ret =3D 0;
> > -     VMA_ITERATOR(vmi, mm, 0);
> > +
> >
>
> Is there now a double-empty line? (it's getting late here)

Oops. Right. Will fix.

>
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
> >
> > +     if (IS_ERR(vma)) {
> > +             ret =3D PTR_ERR(vma);
> > +             goto out_unlock;
> > +     }
> > +
> >       vma_start =3D vma->vm_start;
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
>
> Can you refresh my brain why we now have to check for gate VMAs explicitl=
y?

smap_gather_stats() skips the gate VMA anyway and after the gate we
will be terminating the loop. So, once we see the gate VMA we can exit
the loop. I could teach proc_get_vma() to handle the gate VMA but this
early termination seemed simpler.

>
> > +             /*
> > +              * If after retaking mmap_lock, already reported VMA grew=
 or
> > +              * merged with the next one, then iterate from last_vma_e=
nd.
> > +              */
> > +             smap_gather_stats(priv, vma, &mss,
> > +                               vma->vm_start < last_vma_end ? last_vma=
_end : 0);
> >               last_vma_end =3D vma->vm_end;
> >
> >               /*
> >                * Release mmap_lock temporarily if someone wants to
> > -              * access it for write request.
> > +              * take it for write request.
> >                */
> > -             if (mmap_lock_is_contended(mm)) {
> > -                     vma_iter_invalidate(&vmi);
> > -                     unlock_ctx_mm(&priv->lock_ctx);
> > -                     ret =3D lock_ctx_mm(&priv->lock_ctx);
> > -                     if (ret) {
> > -                             release_task_mempolicy(priv);
> > +             if (is_mmap_lock_contended(priv)) {
> > +                     unlock_vma_range(&priv->lock_ctx);
> > +                     ret =3D lock_vma_range(m, lock_ctx);
> > +                     if (ret)
> >                               goto out_put_mm;
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
> That's quite the simplification.

True, that's why I decided to remove this comment. I handle this Case
4 in the new code and Cases 1-3 are handled naturally, nothing special
about them.

>
> > +                     /* Resume from the last position. */
> > +                     pos =3D last_vma_end;
> > +                     vma_iter_init(&priv->iter, mm, pos);
>
> I'll leave checking the VMA locking details to VMA locking experts :)

This is the same pattern we now use for reading maps/smaps/numa_maps.
lock_vma_range() takes rcu_read_lock and proc_get_vma() locks the VMA
under that RCU.

Thanks for the feedback!

>
> --
> Cheers,
>
> David
