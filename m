Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EDD3C13FD
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601191; cv=pass; b=FP6miczRtBCNkXfjlBbzSpkgE/YhvlhIKNr0M6DtBgrrrevzo6Pk4dbnRSZqINfu24OyZ/XyEWtBI0d+8pZ4c5HKJaZ97Mp0FFWCSm7XAMy1gi3C7Z16OyeRTLqUwDILt5pF13TR3qDAMGXXFjORK57SXZ/lRBepU0eADHn5bsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601191; c=relaxed/simple;
	bh=kEF9Ei2YsSRLGZixjkWOR6wX/M+xz6FF17rppl8xZ4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4S6sK5Eh+xEJx8P+dNLrkGAdvl2/EvrTuRZscBN4e1wfLaSWyOLP4iufUaYJrN56Ou7z4dSqGTNYAkVAga8IAl3Olk2WuWaNmZBMO6Wk4ck5O5CVHTTx99k3M5hV/H5TG5YZGsSL2e9nRk+uY2q7ZZEJ8F1QP0KI34GO3tiTOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAnQgemb; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAnQgemb"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5175d339e8bso96341cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 12:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780601187; cv=none;
        d=google.com; s=arc-20240605;
        b=jiU3jv/yCy+K5W8DMvDDDH+5IuDjEASIqqWVjoHjftLDxx84lYnQrI9Jg/lSbi7sJs
         T9mr2q/cjx+2zB2mZlzdxY1Bci1vnxwxBUQgCwLDryVJcoDljSXpHXB7oYzhL4r/t9LD
         81x6ier/l1XRiUjELzJr0jwCOpTTLGwLA2+EPw5ZwRhluGhZioGF1ZpXv0mYkCUtHgzI
         rEWO32OqZWPkLlPFWPC49i9B1hNQlwTl0nI/4CRxC/WmesavnLLIoRO+c2Qa0ZRbRczJ
         vlTd5B7D/arCA9vxWSPcOc+5PnhmsZixeYSani9OJyqGyxk2Dl+fxdDC/VaXsY1JJXzA
         2VKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W244zF0LrajchLI6hQjM9YMPBGg1nmKsffDjR7F4q1E=;
        fh=qQbgS3mlVqksybm94OYUvx1eXXmiUXYNfdJ9zwta/tQ=;
        b=G+BuLjDtQgPJa20obMJw7xuQJHBUeTieG2n0x1l90IveimOBkGAehV2cz5TwFFKJ9d
         Fz8iB3M5mGl8TKnZsEMozdPyiwms+oR2K4gOh2TPP8Xgyc78IxmNEwi8P29EcbxLcTZ8
         Vva+n5/TSS4fJO9wuZo+Yh8+U4IcQAT+P0P7sgalLkwI7SoB8LV3IbwD2W0kHmbfTgq5
         TlFnP3LChdKCdTPDoYzGvm7h+hfo0vrVK0XAKy71JgoUiKtAZl6WN2Kvx+xIYQrtsYU5
         HQk52bMxIAYIuEIQbBfcrVtNW2WcDXYgy6BX7OASgKfTQCN/XSGYzEx3O4A+/6TmeADH
         LcNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780601187; x=1781205987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W244zF0LrajchLI6hQjM9YMPBGg1nmKsffDjR7F4q1E=;
        b=oAnQgembWKe941bNoY/fjLYFZcGvLG/ZNqsl9iNKEiro+n8dhDt+eg5TXvEmDiGGMg
         MpI+fhTGtedBSAHwL3jVJ+WEFv0dzbBcPjy62H59k48rJ52+EhhwQ5G5gMprcZ8MerRK
         guHl5gcTJqDx4TN+yhgs9adDAEfDFhCE/sbEmt85YkIA2rr1/6yMNMhBVkqJH+cdvk5s
         FVL4VhKJzhKPLEOotq0thwu230LBElACcfi+W+L5oNsRpPa4vzDGxZufBEHAup0K/jaK
         sAO0F76MjtuiOe/03xVqf0AZC/iZSIl6kZeAPdRzFzcLGX/dBdfWdkFaNIARuPbRyrxT
         W09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780601187; x=1781205987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W244zF0LrajchLI6hQjM9YMPBGg1nmKsffDjR7F4q1E=;
        b=qxFyFyf+VpyQnCEncpUE7qR30S9bG8rwQywranB86HCVop9VwIgXfUssmjKgCjRd21
         jMMTH1DNaJk8Ew45Q1/PhD6XeJWBKK1ISRjZyIHpFU4qLKnSyxzsslZ1JOgC0E/dVKCh
         V0Qjuwkui3KyHc4WP10Kp28WL+IlzkGSntnqy2pViLSAQSsfwflmqW5AV8HiIoN00t/b
         sHSJiqWWtCLsmJOcUD2Mgi9Pm6atFKTRJgteBCQHnAoyL/QqzAYURxNsleXUsk8/jCPt
         3dx8BpICWrPYbWBlQlge6MOqhKS3va0TW/ZRjrI/MXobBpZsM+uUH4L6EQdfDySstG8y
         ekVw==
X-Forwarded-Encrypted: i=1; AFNElJ+EmKtNQp1LihmSULsbj8yzvnEaL+VGpUunwzkD7M0LSBlTg/5X8URog3YZWmaBc8maXH4JhAw5KaaYsnIo@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWvVHfu4hNQtMJOix5HF9t0LYmWtho+wMCt22n/QGXJHdFspP
	VhGHMrlU8e7wcpnkkpj9v0J9ftQZaaYQXBbV+/rMRNP8rS2NDSSZ0ogo8whAcQNT8c7JmqR3+I1
	1OKVxJKqz/Tckt/3p4AtpMBIbyeT983XT3YiVQ5Nr
X-Gm-Gg: Acq92OF6gKkC/k/vK0KVB2DDNaj3zKxQIS3RR81AJq1BoZqG8WirbsrP456wjFMEx8n
	Ic6cPmE/MPP13NcvJGbMpLwrq/0TXsAdLakpkmgqdGy52pEQDmcjlRRzuB+EJgOQQnVRmOo98SA
	P4SN9+o2a+XsY0Nvvnu5qmrdiu3LA1LjfiUKluNHihec6FWRlgtCEmBtY9AKA66yHamBPMt3ZCK
	AHLAkZWij29SEsypOmMNQ/kzCqt7sf+0CRxS9v9fuIH+zeQYBO7zN/y0BBWoXzljyrjydevy6y+
	Q0t6yxdYjYxP4WRjMAJ6gXfoaJFXfj1aCR/J0Ml5OTHg8UtQPifMHPv05g==
X-Received: by 2002:a05:622a:a950:b0:510:fa1:73c5 with SMTP id
 d75a77b69052e-5179542f418mr1158581cf.16.1780601186114; Thu, 04 Jun 2026
 12:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426062718.1238437-1-surenb@google.com> <20260426062718.1238437-2-surenb@google.com>
 <ahhMEBYM9bixF2Lg@lucifer> <CAJuCfpFJvuFZkgKwJ11RjDXYhTz-a31HO9-5C+Yc=KxbsGvB-w@mail.gmail.com>
 <aiElxkLHn2yC3W_3@lucifer>
In-Reply-To: <aiElxkLHn2yC3W_3@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Jun 2026 12:26:14 -0700
X-Gm-Features: AVVi8Cc-CWjsfctvx8_6qqwKKd85h79SSC-SUCCSMuyGDG9ngwwbB7Bwu_Kzo5E
Message-ID: <CAJuCfpGWeLz7RBVYHTnMpH2O77yb9MtjMKRK1LrgijafC_0mSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs/proc/task_mmu: read proc/pid/{smaps|numa_maps}
 under per-vma lock
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, shuah@kernel.org, hsukrut3@gmail.com, 
	richard.weiyang@gmail.com, reddybalavignesh9979@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 12:14=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Wed, Jun 03, 2026 at 04:49:48PM -0700, Suren Baghdasaryan wrote:
> > On Thu, May 28, 2026 at 8:17=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org=
> wrote:
> > >
> > > On Sat, Apr 25, 2026 at 11:27:16PM -0700, Suren Baghdasaryan wrote:
> > > > proc/pid/{smaps|numa_maps} can be read using the combination of RCU=
 and
> > > > VMA read locks, similar to proc/pid/maps. RCU is required to safely
> > > > traverse the VMA tree and VMA lock stabilizes the VMA being process=
ed
> > > > and the pagetable walk.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Reviewed-by: Liam R. Howlett <liam@infradead.org>
> > >
> > > The logic LGTM, some nitty things below but in general:
> > >
> > > Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> >
> > Thanks!
> >
> > >
> > > > ---
> > > >  fs/proc/task_mmu.c | 195 ++++++++++++++++++++++++++++++++++++-----=
----
> > > >  1 file changed, 156 insertions(+), 39 deletions(-)
> > > >
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index 751b9ba160fb..1e3a15bf46f4 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -132,6 +132,22 @@ static void release_task_mempolicy(struct proc=
_maps_private *priv)
> > > >
> > > >  #ifdef CONFIG_PER_VMA_LOCK
> > > >
> > > > +static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_c=
tx)
> > >
> > > NIT: But these inlines are unnecessary in a C file. At the kernel opt=
imisation
> > > level the compiler already decides whether to inline or not.
> > >
> > > However in the kernel we redefine this so we lose function tracing an=
d also we
> > > don't get warnings about unused functions [0], so this is actually a =
bit harmful
> > > - you can end up with dead code and not know abou tit.
> > >
> > > Same goes for all the other static inline's in task_mmu.c.
> >
> > I see. There are a bunch of these small inline functions. Once the
> > dust settles, I can clean them up. Dave's series and my folloup patch
> > to change smaps_rollup will be changing this code. Maybe after all
> > that is done?
>
> Yeah that's fine this obviously isn't urgent! :) tiny nits really.
>
> >
> > >
> > > [0]: https://elixir.bootlin.com/linux/v7.0.10/source/include/linux/co=
mpiler_types.h#L235
> > >
> > > > +{
> > > > +     int ret =3D mmap_read_lock_killable(lock_ctx->mm);
> > > > +
> > > > +     if (!ret)
> > > > +             lock_ctx->mmap_locked =3D true;
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static inline void unlock_ctx_mm(struct proc_maps_locking_ctx *loc=
k_ctx)
> > > > +{
> > > > +     mmap_read_unlock(lock_ctx->mm);
> > > > +     lock_ctx->mmap_locked =3D false;
> > > > +}
> > > > +
> > > >  static void reset_lock_ctx(struct proc_maps_locking_ctx *lock_ctx)
> > > >  {
> > > >       lock_ctx->locked_vma =3D NULL;
> > > > @@ -146,25 +162,11 @@ static void unlock_ctx_vma(struct proc_maps_l=
ocking_ctx *lock_ctx)
> > > >       }
> > > >  }
> > > >
> > > > -static const struct seq_operations proc_pid_maps_op;
> > > > -
> > > >  static inline bool lock_vma_range(struct seq_file *m,
> > > >                                 struct proc_maps_locking_ctx *lock_=
ctx)
> > > >  {
> > > > -     /*
> > > > -      * smaps and numa_maps perform page table walk, therefore req=
uire
> > > > -      * mmap_lock but maps can be read with locking just the vma a=
nd
> > > > -      * walking the vma tree under rcu read protection.
> > > > -      */
> > > > -     if (m->op !=3D &proc_pid_maps_op) {
> > > > -             if (mmap_read_lock_killable(lock_ctx->mm))
> > > > -                     return false;
> > > > -
> > > > -             lock_ctx->mmap_locked =3D true;
> > > > -     } else {
> > > > -             rcu_read_lock();
> > > > -             reset_lock_ctx(lock_ctx);
> > > > -     }
> > > > +     rcu_read_lock();
> > > > +     reset_lock_ctx(lock_ctx);
> > > >
> > > >       return true;
> > > >  }
> > > > @@ -172,7 +174,7 @@ static inline bool lock_vma_range(struct seq_fi=
le *m,
> > > >  static inline void unlock_vma_range(struct proc_maps_locking_ctx *=
lock_ctx)
> > > >  {
> > > >       if (lock_ctx->mmap_locked) {
> > > > -             mmap_read_unlock(lock_ctx->mm);
> > > > +             unlock_ctx_mm(lock_ctx);
> > > >       } else {
> > > >               unlock_ctx_vma(lock_ctx);
> > > >               rcu_read_unlock();
> > > > @@ -213,17 +215,45 @@ static inline bool fallback_to_mmap_lock(stru=
ct proc_maps_private *priv,
> > > >       return true;
> > > >  }
> > > >
> > > > +static inline void drop_rcu(struct proc_maps_private *priv)
> > > > +{
> > > > +     if (priv->lock_ctx.mmap_locked)
> > > > +             return;
> > > > +
> > > > +     rcu_read_unlock();
> > > > +}
> > > > +
> > > > +static inline void reacquire_rcu(struct proc_maps_private *priv)
> > > > +{
> > > > +     if (priv->lock_ctx.mmap_locked)
> > > > +             return;
> > > > +
> > > > +     rcu_read_lock();
> > > > +     /* Reinitialize the iterator. */
> > > > +     vma_iter_set(&priv->iter, priv->lock_ctx.locked_vma->vm_end);
> > >
> > > OK good that we reset this :)
> > >
> > > > +}
> > > > +
> > > >  #else /* CONFIG_PER_VMA_LOCK */
> > > >
> > >
> > > We need to pull out the patches from Dave's series and remove this op=
tion and
> > > default VMA locks on by default :)
> >
> > I didn't see any followup after Dave posted his v1. I agree it would
> > make things much simpler but I don't want to delay these changes too
> > much.
> > I'll ask Dave if he plans to continue his cleanup. If not, I'll pick it=
 up.
>
> Great thanks!

I checked with Dave and he will post the next version in a week or so.

>
> >
> >
> > >
> > > > +static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_c=
tx)
> > > > +{
> > > > +     return mmap_read_lock_killable(lock_ctx->mm);
> > > > +}
> > > > +
> > > > +static inline void unlock_ctx_mm(struct proc_maps_locking_ctx *loc=
k_ctx)
> > > > +{
> > > > +     mmap_read_unlock(lock_ctx->mm);
> > > > +}
> > > > +
> > > >  static inline bool lock_vma_range(struct seq_file *m,
> > > >                                 struct proc_maps_locking_ctx *lock_=
ctx)
> > > >  {
> > > > -     return mmap_read_lock_killable(lock_ctx->mm) =3D=3D 0;
> > > > +     return lock_ctx_mm(lock_ctx) =3D=3D 0;
> > > >  }
> > > >
> > > >  static inline void unlock_vma_range(struct proc_maps_locking_ctx *=
lock_ctx)
> > > >  {
> > > > -     mmap_read_unlock(lock_ctx->mm);
> > > > +     unlock_ctx_mm(lock_ctx);
> > > >  }
> > > >
> > > >  static struct vm_area_struct *get_next_vma(struct proc_maps_privat=
e *priv,
> > > > @@ -238,6 +268,9 @@ static inline bool fallback_to_mmap_lock(struct=
 proc_maps_private *priv,
> > > >       return false;
> > > >  }
> > > >
> > > > +static inline void drop_rcu(struct proc_maps_private *priv) {}
> > > > +static inline void reacquire_rcu(struct proc_maps_private *priv) {=
}
> > > > +
> > > >  #endif /* CONFIG_PER_VMA_LOCK */
> > > >
> > > >  static struct vm_area_struct *proc_get_vma(struct seq_file *m, lof=
f_t *ppos)
> > > > @@ -538,12 +571,10 @@ static int query_vma_setup(struct proc_maps_l=
ocking_ctx *lock_ctx)
> > > >
> > > >  static void query_vma_teardown(struct proc_maps_locking_ctx *lock_=
ctx)
> > > >  {
> > > > -     if (lock_ctx->mmap_locked) {
> > > > -             mmap_read_unlock(lock_ctx->mm);
> > > > -             lock_ctx->mmap_locked =3D false;
> > > > -     } else {
> > > > +     if (lock_ctx->mmap_locked)
> > > > +             unlock_ctx_mm(lock_ctx);
> > > > +     else
> > > >               unlock_ctx_vma(lock_ctx);
> > > > -     }
> > > >  }
> > > >
> > > >  static struct vm_area_struct *query_vma_find_by_addr(struct proc_m=
aps_locking_ctx *lock_ctx,
> > > > @@ -1280,21 +1311,75 @@ static const struct mm_walk_ops smaps_shmem=
_walk_ops =3D {
> > > >       .walk_lock              =3D PGWALK_RDLOCK,
> > > >  };
> > > >
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +
> > > > +static const struct mm_walk_ops smaps_walk_vma_lock_ops =3D {
> > > > +     .pmd_entry              =3D smaps_pte_range,
> > > > +     .hugetlb_entry          =3D smaps_hugetlb_range,
> > > > +     .walk_lock              =3D PGWALK_VMA_RDLOCK_VERIFY,
> > > > +};
> > > > +
> > > > +static const struct mm_walk_ops smaps_shmem_walk_vma_lock_ops =3D =
{
> > > > +     .pmd_entry              =3D smaps_pte_range,
> > > > +     .hugetlb_entry          =3D smaps_hugetlb_range,
> > > > +     .pte_hole               =3D smaps_pte_hole,
> > > > +     .walk_lock              =3D PGWALK_VMA_RDLOCK_VERIFY,
> > > > +};
> > > > +
> > > > +static inline const struct mm_walk_ops *
> > > > +get_smaps_walk_ops(struct proc_maps_private *priv)
> > > > +{
> > > > +     if (priv->lock_ctx.mmap_locked)
> > > > +             return &smaps_walk_ops;
> > > > +     return &smaps_walk_vma_lock_ops;
> > > > +}
> > > > +
> > > > +static inline const struct mm_walk_ops *
> > > > +get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
> > > > +{
> > > > +     if (priv->lock_ctx.mmap_locked)
> > > > +             return  &smaps_shmem_walk_ops;
> > > > +     return &smaps_shmem_walk_vma_lock_ops;
> > > > +}
> > > > +
> > > > +#else /* CONFIG_PER_VMA_LOCK */
> > > > +
> > > > +static inline const struct mm_walk_ops *
> > > > +get_smaps_walk_ops(struct proc_maps_private *priv)
> > > > +{
> > > > +     return &smaps_walk_ops;
> > > > +}
> > > > +
> > > > +static inline const struct mm_walk_ops *
> > > > +get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
> > > > +{
> > > > +     return &smaps_shmem_walk_ops;
> > > > +}
> > > > +
> > > > +#endif /* CONFIG_PER_VMA_LOCK */
> > > > +
> > > >  /*
> > > >   * Gather mem stats from @vma with the indicated beginning
> > > >   * address @start, and keep them in @mss.
> > > >   *
> > > >   * Use vm_start of @vma as the beginning address if @start is 0.
> > > >   */
> > > > -static void smap_gather_stats(struct vm_area_struct *vma,
> > > > -             struct mem_size_stats *mss, unsigned long start)
> > > > +static void smap_gather_stats(struct proc_maps_private *priv,
> > > > +                           struct vm_area_struct *vma,
> > > > +                           struct mem_size_stats *mss, unsigned lo=
ng start)
> > > >  {
> > > > -     const struct mm_walk_ops *ops =3D &smaps_walk_ops;
> > > > +     const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv);
> > > >
> > > >       /* Invalid start */
> > > >       if (start >=3D vma->vm_end)
> > > >               return;
> > > >
> > > > +     if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> > > > +             return;
> > > > +
> > > > +     /* Might sleep. Drop RCU read lock but keep the VMA locked. *=
/
> > > > +     drop_rcu(priv);
> > > > +
> > > >       if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
> > > >               /*
> > > >                * For shared or readonly shmem mappings we know that=
 all
> > > > @@ -1312,15 +1397,16 @@ static void smap_gather_stats(struct vm_are=
a_struct *vma,
> > > >                                       !(vma->vm_flags & VM_WRITE)))=
 {
> > > >                       mss->swap +=3D shmem_swapped;
> > > >               } else {
> > > > -                     ops =3D &smaps_shmem_walk_ops;
> > > > +                     ops =3D get_smaps_shmem_walk_ops(priv);
> > > >               }
> > > >       }
> > > >
> > > > -     /* mmap_lock is held in m_start */
> > > >       if (!start)
> > > >               walk_page_vma(vma, ops, mss);
> > > >       else
> > > >               walk_page_range(vma->vm_mm, start, vma->vm_end, ops, =
mss);
> > > > +
> > > > +     reacquire_rcu(priv);
> > >
> > > OK I was going to say that this RCU lock dance is a bit iffy, but I s=
ee
> > > that we're sharing code such that this is necessary.
> > >
> > > >  }
> > > >
> > > >  #define SEQ_PUT_DEC(str, val) \
> > > > @@ -1369,10 +1455,11 @@ static void __show_smap(struct seq_file *m,=
 const struct mem_size_stats *mss,
> > > >
> > > >  static int show_smap(struct seq_file *m, void *v)
> > > >  {
> > > > +     struct proc_maps_private *priv =3D m->private;
> > > >       struct vm_area_struct *vma =3D v;
> > > >       struct mem_size_stats mss =3D {};
> > > >
> > > > -     smap_gather_stats(vma, &mss, 0);
> > > > +     smap_gather_stats(priv, vma, &mss, 0);
> > > >
> > > >       show_map_vma(m, vma);
> > > >
> > > > @@ -1413,7 +1500,7 @@ static int show_smaps_rollup(struct seq_file =
*m, void *v)
> > > >               goto out_put_task;
> > > >       }
> > > >
> > > > -     ret =3D mmap_read_lock_killable(mm);
> > > > +     ret =3D lock_ctx_mm(&priv->lock_ctx);
> > > >       if (ret)
> > > >               goto out_put_mm;
> > > >
> > > > @@ -1425,7 +1512,7 @@ static int show_smaps_rollup(struct seq_file =
*m, void *v)
> > > >
> > > >       vma_start =3D vma->vm_start;
> > > >       do {
> > > > -             smap_gather_stats(vma, &mss, 0);
> > > > +             smap_gather_stats(priv, vma, &mss, 0);
> > > >               last_vma_end =3D vma->vm_end;
> > > >
> > > >               /*
> > > > @@ -1434,8 +1521,8 @@ static int show_smaps_rollup(struct seq_file =
*m, void *v)
> > > >                */
> > > >               if (mmap_lock_is_contended(mm)) {
> > > >                       vma_iter_invalidate(&vmi);
> > > > -                     mmap_read_unlock(mm);
> > > > -                     ret =3D mmap_read_lock_killable(mm);
> > > > +                     unlock_ctx_mm(&priv->lock_ctx);
> > > > +                     ret =3D lock_ctx_mm(&priv->lock_ctx);
> > > >                       if (ret) {
> > > >                               release_task_mempolicy(priv);
> > > >                               goto out_put_mm;
> > > > @@ -1484,14 +1571,14 @@ static int show_smaps_rollup(struct seq_fil=
e *m, void *v)
> > > >
> > > >                       /* Case 1 and 2 above */
> > > >                       if (vma->vm_start >=3D last_vma_end) {
> > > > -                             smap_gather_stats(vma, &mss, 0);
> > > > +                             smap_gather_stats(priv, vma, &mss, 0)=
;
> > > >                               last_vma_end =3D vma->vm_end;
> > > >                               continue;
> > > >                       }
> > > >
> > > >                       /* Case 4 above */
> > > >                       if (vma->vm_end > last_vma_end) {
> > > > -                             smap_gather_stats(vma, &mss, last_vma=
_end);
> > > > +                             smap_gather_stats(priv, vma, &mss, la=
st_vma_end);
> > > >                               last_vma_end =3D vma->vm_end;
> > > >                       }
> > > >               }
> > > > @@ -1505,7 +1592,7 @@ static int show_smaps_rollup(struct seq_file =
*m, void *v)
> > > >       __show_smap(m, &mss, true);
> > > >
> > > >       release_task_mempolicy(priv);
> > > > -     mmap_read_unlock(mm);
> > > > +     unlock_ctx_mm(&priv->lock_ctx);
> > > >
> > > >  out_put_mm:
> > > >       mmput(mm);
> > > > @@ -3291,6 +3378,31 @@ static const struct mm_walk_ops show_numa_op=
s =3D {
> > > >       .walk_lock =3D PGWALK_RDLOCK,
> > > >  };
> > > >
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +static const struct mm_walk_ops show_numa_vma_lock_ops =3D {
> > > > +     .hugetlb_entry =3D gather_hugetlb_stats,
> > > > +     .pmd_entry =3D gather_pte_stats,
> > > > +     .walk_lock =3D PGWALK_VMA_RDLOCK_VERIFY,
> > > > +};
> > > > +
> > > > +static inline const struct mm_walk_ops *
> > > > +get_show_numa_ops(struct proc_maps_private *priv)
> > > > +{
> > > > +     if (priv->lock_ctx.mmap_locked)
> > > > +             return &show_numa_ops;
> > > > +     return &show_numa_vma_lock_ops;
> > > > +}
> > > > +
> > > > +#else /* CONFIG_PER_VMA_LOCK */
> > > > +
> > > > +static inline const struct mm_walk_ops *
> > > > +get_show_numa_ops(struct proc_maps_private *priv)
> > > > +{
> > > > +     return &show_numa_ops;
> > > > +}
> > > > +
> > > > +#endif /* CONFIG_PER_VMA_LOCK */
> > > > +
> > > >  /*
> > > >   * Display pages allocated per node and memory policy via /proc.
> > > >   */
> > > > @@ -3335,8 +3447,13 @@ static int show_numa_map(struct seq_file *m,=
 void *v)
> > > >       if (is_vm_hugetlb_page(vma))
> > > >               seq_puts(m, " huge");
> > > >
> > > > -     /* mmap_lock is held by m_start */
> > > > -     walk_page_vma(vma, &show_numa_ops, md);
> > > > +     /* Skip walking pages if gate VMA */
> > > > +     if (vma !=3D get_gate_vma(proc_priv->lock_ctx.mm)) {
> > > > +             /* Might sleep. Drop RCU read lock but keep the VMA l=
ocked. */
> > > > +             drop_rcu(proc_priv);
> > > > +             walk_page_vma(vma, get_show_numa_ops(proc_priv), md);
> > > > +             reacquire_rcu(proc_priv);
> > > > +     }
> > > >
> > > >       if (!md->pages)
> > > >               goto out;
> > > > --
> > > > 2.54.0.545.g6539524ca2-goog
> > > >
