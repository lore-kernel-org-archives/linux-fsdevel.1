Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F97568FA6
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156098; cv=pass; b=eqnjvZSZ0VHkLK9aaqNw7ob8I5aZDdKv7fmJwvMmWpHipNQmL8nOGFKTovgRcJITZWDi0pqcujNp9GyyZ0Y/WsvLTUzYeBXLqii9vzSw9gVXgFqyfOJpsIZkYKZ3ZAZ0tmH0/P8O4kCHJ++OysXgpGir6NnaUoCJM0ntB6u3QMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156098; c=relaxed/simple;
	bh=wAIi5p+WM3xE4xReewx/Myw5rsTFIcQhwdeVujOwHtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOwf/CBRlPuJVezVawhBufehC1z+fIari2un7uEsUUehMnjJ4LBxtcNdFsumsceAwSYl5DwGXmU+Oa7X/LTdGrAaf2JaRHcQDb2/FPP1kvl/EO7MrIhQwUHJLX2KF5xtqUpjpBYG/m8LfQ/9UBtYN3ZNTMAlwJl/J4erGHekANk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5EeClik; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5EeClik"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d5fc2cd8so102811cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789156077; cv=none;
        d=google.com; s=arc-20260327;
        b=djCTTvi9x9V1FrJjko6nNVAxwuLwxjwZZOJGhsxLFV3O3T7kbkHMeTN6LrfdaCB1xQ
         4lgJED3vbHrch9mVbFadyGjMESOxrnvYYaAUVCKxYil2SrQWt7k84Y1eY/LKpSxIbEG0
         hNCvxOHznFcxeRGEJ27jlr7cfFmXTPxoJ/CzbjQwfP+tj/uHLB1tBFaN8gi/XTW/nZiL
         7Dl2ATLp3BcI3fsiQMvStCe8n6i7pmp1h3sHuin0Z8857uIIWl8XKcAqmxmcwz9hnopw
         P4+OVP8EEg3Bqgoa6N3EGvE0AZf9KLpIaCco2u7g28Y2tdA2MjDchxfGQVeXXiAxaP3c
         Nzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vrYQ8fif4AyPdCzj9gAZ4OwR6V4iYcgiDS5Z8k+S3YA=;
        fh=nSMNADC/6TUwj/s57OrT44Y74nVfx4gYxijnAGpM1sc=;
        b=oX1xrL7cnoQppZt5fowRGvH3hJVYuLbAFJLqvFkFJxxNkv3XmYubZ+tRUoAloH0dco
         FNzAyoSUIglUK+S2/58rluiv27T2eO0rM7DRafzZwPKW11NiQaqFxGyvj9mo66ERmUnt
         1TCxlYe0dtnlLr5+doBIrxmWVPVOZoprsk5fB6OKmU6jE3/S7GwkTUhBQ8zEoZPvDjSC
         XDbIcccQ/4RKpVA4jGodRcBHT5tYg9/sqWJ16xg9HtZ1CPgrcvHkQeeS8bmXfO6yaEKL
         j1rhPc5Wz3ynViAhdLeKGQ1AkaS7UKakG4eQ76o8iiSl7/Iwp3onrFhvpYePhQ0EUpWC
         38PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789156077; x=1789760877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vrYQ8fif4AyPdCzj9gAZ4OwR6V4iYcgiDS5Z8k+S3YA=;
        b=s5EeClikFDEmYndGQY1j8zLmf7RSdfuKhZbJZA/a0IBubB/DT+Kj0ue7pUSAIRGR5w
         sHizzZRc/FbYtKcOoXAKfKl2O7sW2ymIUdD47ctpqUhqJ/g57Fk+ySlUFoP1UQ6N6cx1
         A7BY07YSmgJGzyMt31CUwlkkImYKBHXPuIPHQ2bt08FdvW4Jrku/M71uBxzp+IWRuzMW
         Ab4545d+ij//GLSmK1Shl2cthm2elKl/H+s1v3I9CZFYVBb7bi8s5Hb0u+vUONOLl1ub
         0KbLMTn3SHTbV1wf3x96oO3KgnYZrNU6eYnN+bkqhtrWonwy9ZSyEsgAYZ6puPnuRA60
         c0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789156077; x=1789760877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vrYQ8fif4AyPdCzj9gAZ4OwR6V4iYcgiDS5Z8k+S3YA=;
        b=Rsj1xJyWUXfhbaGOUIwRZhtFrAifT3WMM7hZ32bi+wNmFWRvdDlL8nu/cinpvTRoVQ
         NCQb2S/3UPgh5nQ0lwga4YvyePLIl8F8VgwNGd4JnHbhCG8EdY0nQlMRhjxkcd5LXWeI
         RFP0Wvr0ZKclaa3Q0sdOLnvHva57cz6e325Ndh2PQ7J2WPldYFmOBNRHvtCfkMFNZZgg
         sxZK/x0P5ajzmO06qYY/KwiHBvwaqgf71t3wOBKRZypDSLcEcwwFLYJPuElyUycee8yq
         pcJn9yZ1E6iTIdvo8Go4Q1Lhjrt5Gyv9K7ORCmwP/bahR6Q8+LVlHSeQHcQ/tYn9y/0K
         YogA==
X-Forwarded-Encrypted: i=1; AKwUvByaLIEx8jB3N3Zoy7oi+ak5BSanvEgoJbawXp1bA88Ec8+64hOPTVzuxd+1lTqwdTN3WvI+wpvQidRQgIyg@vger.kernel.org
X-Gm-Message-State: AFuF++k9bN/Pj8Gv+0/Epu4xZG69ogXmeBGKHu9zhHxPwWA2z6Il6sEZ
	r7Pqxure+xyyY5j2T+XHcmT0OwLGGpQPHTNznZ0rpQZpN2/KWX7PiSSxB3fLkrf/MzYdKkava6A
	oQEGPsT/JEdpi5KI4eU/Fg6vYbG8TYtwEc8KNOcDF
X-Gm-Gg: AYBFou39OE/kIcxavqkx8Ja/6NrV36hrL2sg6prrowNgwpAB36egev7hSTn87uWz6VN
	8UQf8WFHVmkKwqXAJ29s0xyYRJqizLKvmef4nOIXHybqNTPlnr7gRY6TC5w559EGDEN7ZngBgez
	tHnInwl9x2EPgjl5ERJwxtvmW3tFP8emjq+HsSSv1z0SEnlhuWVHXHIICk6LMzHklzlc6JR0cFA
	jM09oBMG5EA67IpFd3MATIARny6K3nh03PjETmX6xouA/BT4N2zsiQ59YKyQ2F44dItjKj5slDs
	p9CU6gJF63yj3geqXQsXLXddFnuO6gF6cErFpbbl+UFSLV3HrOFIf2bBiOn3clXhu1iVZolpMzE
	DLhhIVYewHA==
X-Received: by 2002:ac8:5749:0:b0:530:39d7:ef48 with SMTP id
 d75a77b69052e-530e612de23mr89771cf.3.1789156074760; Fri, 11 Sep 2026 12:47:54
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911194145.1781926-1-surenb@google.com> <20260911194145.1781926-5-surenb@google.com>
 <aqRaONEiklcnblwQ@gremlin>
In-Reply-To: <aqRaONEiklcnblwQ@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 12:47:43 -0700
X-Gm-Features: AcwNN1XsaY36agWBMGEWlskBvCYjftnblVqAHV0x5LuDyqQXoH6GyBmbsL07NFo
Message-ID: <CAJuCfpFRmDJ=hu8et-M+tZtTmYoNcebaHgDqMz1V03eM7WL0LQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:45=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Fri, Sep 11, 2026 at 12:41:42PM -0700, Suren Baghdasaryan wrote:
> > smap_gather_stats() interprets its start parameter to mean vma->vm_star=
t
> > when it's set to 0. Eliminate this special interpretation and provide t=
wo
> > separate functions for a partial and complete VMA walk.
> >
> > Since smap_gather_stats() operates within a single VMA, we can replace
> > walk_page_vma()/walk_page_range() calls with walk_page_range_vma()
> > which is simpler and also can be called while holding per-VMA lock.
> >
> > No functional change intended.
> >
> > Suggested by: Lorenzo Stoakes <ljs@kernel.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> LGTM so:
>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Thanks!

>
> > ---
> >  fs/proc/task_mmu.c | 52 +++++++++++++++++++++++++++++++---------------
> >  1 file changed, 35 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 0e53eb065a3e..a6026ffd07f1 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1246,20 +1246,26 @@ get_smaps_shmem_walk_ops(struct proc_maps_priva=
te *priv)
> >       return &smaps_shmem_walk_vma_lock_ops;
> >  }
> >
> > -/*
> > - * Gather mem stats from @vma with the indicated beginning
> > - * address @start, and keep them in @mss.
> > +/**
> > + * smap_gather_stats_range() - Gather mem stats from a portion of the =
@vma.
> > + * @priv: proc maps private state.
> > + * @vma: The VMA to gather stats for.
> > + * @mss: The accumulated stats.
> > + * @start: The address from which to start.
> >   *
> > - * Use vm_start of @vma as the beginning address if @start is 0.
> > + * This gathers stats for the portion of the VMA starting at the @star=
t
> > + * address.
> >   */
> > -static void smap_gather_stats(struct proc_maps_private *priv,
> > -                           struct vm_area_struct *vma,
> > -                           struct mem_size_stats *mss, unsigned long s=
tart)
> > +static void smap_gather_stats_range(struct proc_maps_private *priv,
> > +             struct vm_area_struct *vma,
> > +             struct mem_size_stats *mss,
> > +             unsigned long start)
> >  {
> >       const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv);
> > +     const bool is_partial =3D start > vma->vm_start;
> >
> >       /* Invalid start */
> > -     if (start >=3D vma->vm_end)
> > +     if (start < vma->vm_start || start >=3D vma->vm_end)
> >               return;
> >
> >       if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> > @@ -1278,20 +1284,31 @@ static void smap_gather_stats(struct proc_maps_=
private *priv,
> >               const unsigned long shmem_swapped =3D shmem_swap_usage(vm=
a);
> >               const bool is_cow =3D vma_is_cow_mapping(vma);
> >
> > -             if (start || (shmem_swapped && is_cow))
> > +             if (is_partial || (shmem_swapped && is_cow))
> >                       ops =3D get_smaps_shmem_walk_ops(priv);
> >               else
> >                       mss->swap +=3D shmem_swapped;
> >       }
> >
> > -     if (!start)
> > -             walk_page_vma(vma, ops, mss);
> > -     else
> > -             walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss)=
;
> > +     walk_page_range_vma(vma, start, vma->vm_end, ops, mss);
> >
> >       reacquire_rcu(priv);
> >  }
> >
> > +/**
> > + * smap_gather_stats() - Gather mem stats from the entire @vma.
> > + * @priv: proc maps private state.
> > + * @vma: The VMA to gather stats for.
> > + * @mss: The accumulated stats.
> > + *
> > + * This gathers stats for the whole of the VMA.
> > + */
> > +static void smap_gather_stats(struct proc_maps_private *priv,
> > +             struct vm_area_struct *vma, struct mem_size_stats *mss)
> > +{
> > +     smap_gather_stats_range(priv, vma, mss, vma->vm_start);
> > +}
> > +
> >  #define SEQ_PUT_DEC(str, val) \
> >               seq_put_decimal_ull_width(m, str, (val) >> 10, 8)
> >
> > @@ -1342,7 +1359,7 @@ static int show_smap(struct seq_file *m, void *v)
> >       struct vm_area_struct *vma =3D v;
> >       struct mem_size_stats mss =3D {};
> >
> > -     smap_gather_stats(priv, vma, &mss, 0);
> > +     smap_gather_stats(priv, vma, &mss);
> >
> >       show_map_vma(m, vma);
> >
> > @@ -1395,7 +1412,7 @@ static int show_smaps_rollup(struct seq_file *m, =
void *v)
> >
> >       vma_start =3D vma->vm_start;
> >       do {
> > -             smap_gather_stats(priv, vma, &mss, 0);
> > +             smap_gather_stats(priv, vma, &mss);
> >               last_vma_end =3D vma->vm_end;
> >
> >               /*
> > @@ -1454,14 +1471,15 @@ static int show_smaps_rollup(struct seq_file *m=
, void *v)
> >
> >                       /* Case 1 and 2 above */
> >                       if (vma->vm_start >=3D last_vma_end) {
> > -                             smap_gather_stats(priv, vma, &mss, 0);
> > +                             smap_gather_stats(priv, vma, &mss);
> >                               last_vma_end =3D vma->vm_end;
> >                               continue;
> >                       }
> >
> >                       /* Case 4 above */
> >                       if (vma->vm_end > last_vma_end) {
> > -                             smap_gather_stats(priv, vma, &mss, last_v=
ma_end);
> > +                             smap_gather_stats_range(priv, vma, &mss,
> > +                                                     last_vma_end);
> >                               last_vma_end =3D vma->vm_end;
> >                       }
> >               }
> > --
> > 2.55.0.1007.g17ff1f9808-goog
> >
>
> --
> Cheers, Lorenzo
