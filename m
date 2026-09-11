Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161783939B5
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146483; cv=pass; b=pbgQWHhkfpkZTKbge10fi4b3tjjeFf2GsbGP3JKlN0t0ygMV9/Cw3hcvgACgIBFw6fytBfmnop7sxZryzJOns5W4LM6OBJaX7UDlNRJAuu6L2sC3r+LkmX7+O/4OoeAQQlU2eZpsvrqZM9vnaq0LxK9binN+nblvnMjeW7y6DWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146483; c=relaxed/simple;
	bh=yvIYGfK0j5RKlarxd15M99WA87HKIWW0hFtuYq8YyW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HA5Q2KzcCwJ5DZZABQLUDH8P1S0hf/l2iIHAwIbMKTRbIGFfqhxnmiXcbH8YEzFO0Dvvs1ZInsVpEQdDs3Wr0SFSoyEkOx/nIvx3ULOei3hPhRXtwYSfp3Dl3ogiUin6DX9QCoIyst/GTaUTTnQW+nSRZ8GeB5td5qyeDyEknos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wB+y5zMx; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wB+y5zMx"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so71071cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 10:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789146481; cv=none;
        d=google.com; s=arc-20260327;
        b=G78xUrh7Atn63ivwICa9QyESikkEtgjTu/TjqrKavrkgUazTEnxkGHB/LpQ23URyGs
         vwVyY36rdFog1B84HMmZQkMW2DKAH2Zm/TgC1cPW6QYR3h80tJgDhRksSOmNd37aKKja
         tAELb4DU4xRHGlktP60bBGqAKQiAYlcRZek/nM7W/WWXV8Af0rwsjh2zy6n3l8dGqXh7
         rOoxXypoD9HsGeZ54jn48wtKvH88n6JHa9MekvRiq2RKdIWERqM8NupkJj7958k0jhDw
         LyDByMbGeWecTz0ZPvlzn7rnVl6kAbfdR1nPXjYvlwXg0TgjG2Nwf94Q1IvsTNnLtDqY
         ckDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FfqAnYs9QWvu4t/PRHSywLwXNZCW3SnEDtn5daAsEzM=;
        fh=sRKvZ6wvKPM2mWf255/EMLqN5mg1ATxiT2Oagq1eppI=;
        b=B9vvazv0970bKo2BgS7NLius7Kh3pUTBRaxTsTluZkyFmGX9NGY2bp2IoiyvBkM6Hp
         9uZxgJPd6dktBKyA9R0O+x4mof2JxQClA8itNfIuSPGUwiLw2ndqu79gPIRjRRaMSIyy
         lLTbEzGeUTvefUgcb3P6U5/iaqhqhkks1gMe/RjCZl1rfmnKpHjPr6Xc25CqyheTWidl
         B5gd49usfmSNLCYevDcdjxSCGkDvvBKHM7CoT1GA9k5t1DDTlbV8vscU0htzeKvVPdpe
         R0bYS7hfXa1Fq5kMew0X0xNqWpSZioeU8ICyb3kn/0rE6Jq1pMk63mTs1Kp1VAVJ58Ey
         Ublg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789146481; x=1789751281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FfqAnYs9QWvu4t/PRHSywLwXNZCW3SnEDtn5daAsEzM=;
        b=wB+y5zMxFTnVBd8Q1/vvXTgcxMAAHujFc8iEl8N4MBaPEBMP2mttHQUdLXbjO3I0eL
         dinqUAwxjwlXQsvKmfI3CQY/FK4nzCtRPJ0LN+XkzZg5nrKsVV5F7WPSfCMZ5ZELpbsB
         nNXmuUKSXrKIoNoG/RV1Rxn3ygQO9H/0SpZJiQFbx+qqszGRqBMTPAg63heEPBaXbmy0
         bxGRsR0ctYf/xMYF8ImFtI56tbQtFEMYPrVhTmsxllf3oVJ9icGsAQWrtdYI/pvTgLuK
         YE0UeIQyc7iTuPoj5zQHqU7ZdbfY9Qm7CJvPai3pQv6i2ft7exkW65mA6IpH2LUmV+99
         8egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789146481; x=1789751281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FfqAnYs9QWvu4t/PRHSywLwXNZCW3SnEDtn5daAsEzM=;
        b=HExcX+b9TmQni/mpbXRC1gTvkipL6bMu0IhylfuDljCyaZApFIQgEmje+5wONjrDsU
         sZEE5eS/HVTk6pZTrcyU17hx66Vsjtmu2M76X6Odx31v7gHjxG1yFtfPkv2uM1Hbx2+V
         l3wCD4U/ITsf3mym/tjZalUdC82b865VUgxvuVex8S++oOxU9IFQmGrGIsW3364QSDLv
         UvaVhgTABiYtFcqR+tg0G1iSs9KADtHJvX/Flo15BykJ4j+mNvPZul4ej1zkL19TCyxa
         ZklqeDpJjPuWv/4BGk+1S84qspV3w+ZdUt18H/+Ob6rtjmVv/j2DEwa4s3binWp6yEwT
         onpA==
X-Forwarded-Encrypted: i=1; AKwUvBz8YzWx2HJ96vIYxsa0udub9OeXdJRdMi75J1SqdWs7ZJDmtHhQFwqDpu2Mn83T9mP051HiqQ+AfLlJvi+E@vger.kernel.org
X-Gm-Message-State: AFuF++kbCK1TSSJzQ3XnEE96WBlCFpTMTfdZhoONOpRdfkViZS53fUY9
	GpBexhXhGX+YBc+jl7y1uvOwCY6oSRxF5imdYM0V91qMDcJW8jszej1/nJud8H1M5Wd+kcYfBGG
	GpONevkA2b0FQB3nLKnRNk3a4f0V7MRB1vEhZ1eZ6
X-Gm-Gg: AYBFou0QNBB9wih6+siS0M0pb84yw5JXiLSQgIoVhiDNr7MixkY8Ry8kFz2N+TsIxI2
	Zab+1BgDWm+PEXenqdBDKOyD5G04gclRoRKhmhQlx+lMpJJVittqRfRtEs4bYPr55mR4+N+vsVS
	kISz+pMgKqCG5mdA2HCUl2JHppiOojrjeBfs3NOpKXweo8ZydilhWqpn3k5WTo4acuN5OV5x2yd
	mJYumPESUVgcmeYlmCzKnB7Nfs1wAl1OSYivBgZXg3xS7uvGPZwGk64FISO+TOWdzCU4gonLxL/
	BvQknpd6UDZrSm559+ROU26Cc1E8haT1Qgt7TpVZ4Zu1xpsIskLBsVOu5UYsYVCqc8qFJAHAyP5
	vFomOXUo=
X-Received: by 2002:a05:622a:1b07:b0:527:f08f:56a2 with SMTP id
 d75a77b69052e-530e4652848mr184701cf.8.1789146479942; Fri, 11 Sep 2026
 10:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-5-surenb@google.com>
 <aqQsWNfrBSp4DY_N@gremlin>
In-Reply-To: <aqQsWNfrBSp4DY_N@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 17:07:48 +0000
X-Gm-Features: AcwNN1VmWwBwvdrrzfbSCfPBns6QLN3cVqhymRQ3A0LlyuwTeNE2s_Y0v9LoFOY
Message-ID: <CAJuCfpEEi-9ZqhKR536tJHywprb9RFcx92gK00qp_ecBGH9Fvw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 4:39=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Thu, Sep 10, 2026 at 04:47:34PM -0700, Suren Baghdasaryan wrote:
> > smap_gather_stats() interprets its start parameter to mean vma->vm_star=
t
> > when it's set to 0. Eliminate this special interpretation and pass
> > vma->vm_start explicitly when needed.
> >
> > Since smap_gather_stats() operates within a single VMA, we can replace
> > walk_page_vma()/walk_page_range() calls with walk_page_range_vma()
> > which is simpler and also can be called while holding per-VMA lock.
> >
> > No functional change intended.
> >
> > Suggested by: Lorenzo Stoakes <ljs@kernel.org>
>
> Hmm did I? Where did I suggest this?... I guess a while ago?

In [1] on June 9, 2026.

[1] https://lore.kernel.org/all/aifO_rCurVhFRTcl@lucifer/

>
> I mean I also happen to suggest it in the previous patch review :) but th=
at was
> sent after you sent this...
>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
>
> I don't love hacking a hack for a patch and then unhack it in the next in=
 a
> slightly roundabout way.
>
> Feels like this should be squashed. And a wrapper function for
> start=3Dvma->vm_start should be used rather than duplicating that param
> constantly.
>
> > ---
> >  fs/proc/task_mmu.c | 29 ++++++++++++++++-------------
> >  1 file changed, 16 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 3c40c9cbb9c9..ecce7ce116cb 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1246,21 +1246,27 @@ get_smaps_shmem_walk_ops(struct proc_maps_priva=
te *priv)
> >       return &smaps_shmem_walk_vma_lock_ops;
> >  }
> >
> > -/*
> > - * Gather mem stats from @vma with the indicated beginning
> > - * address @start, and keep them in @mss.
> > +/**
> > + * smap_gather_stats() - Gather mem stats from @vma.
> > + * @priv: proc maps private state.
> > + * @vma: The VMA to gather stats for.
> > + * @mss: The accumulated stats.
> > + * @start: The address from which to start.
> >   *
> > - * Use vm_start of @vma as the beginning address if @start is 0.
> > + * This gathers stats for the whole of the VMA unless the lock was dro=
pped
> > + * and VMA grew or got merged and we found it again, in which case we =
only
> > + * gather stats for the remainder of the VMA range.
>
> This seems to be describing what callers do not what the function does un=
less
> I'm missing something? So that's really the wrong place for it.
>
> I think the description of why it might be a partial walk belongs to the =
bit of
> code that actually tries to do a partial walk.
>
> Anyway as per below I think separate partial/full functions make sense an=
d there
> it can simply be described as walking either the full or part of the VMA.

This is verbatim of what you wrote at the end of [1]

>
> >   */
> >  static void smap_gather_stats(struct proc_maps_private *priv,
> >                             struct vm_area_struct *vma,
> > -                           struct mem_size_stats *mss, unsigned long s=
tart)
> > +                           struct mem_size_stats *mss,
> > +                           unsigned long start)
> >  {
> >       const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv);
> >       const bool is_partial =3D start > vma->vm_start;
> >
> >       /* Invalid start */
> > -     if (start >=3D vma->vm_end)
> > +     if (start < vma->vm_start || start >=3D vma->vm_end)
> >               return;
> >
> >       if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> > @@ -1285,10 +1291,7 @@ static void smap_gather_stats(struct proc_maps_p=
rivate *priv,
> >                       mss->swap +=3D shmem_swapped;
> >       }
> >
> > -     if (!start)
> > -             walk_page_vma(vma, ops, mss);
> > -     else
> > -             walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss)=
;
> > +     walk_page_range_vma(vma, start, vma->vm_end, ops, mss);
>
> I mean obviously am in favour of this as I suggested it in the last patch=
 :)
>
> >
> >       reacquire_rcu(priv);
> >  }
> > @@ -1343,7 +1346,7 @@ static int show_smap(struct seq_file *m, void *v)
> >       struct vm_area_struct *vma =3D v;
> >       struct mem_size_stats mss =3D {};
> >
> > -     smap_gather_stats(priv, vma, &mss, 0);
> > +     smap_gather_stats(priv, vma, &mss, vma->vm_start);
> >
> >       show_map_vma(m, vma);
> >
> > @@ -1396,7 +1399,7 @@ static int show_smaps_rollup(struct seq_file *m, =
void *v)
> >
> >       vma_start =3D vma->vm_start;
> >       do {
> > -             smap_gather_stats(priv, vma, &mss, 0);
> > +             smap_gather_stats(priv, vma, &mss, vma->vm_start);
> >               last_vma_end =3D vma->vm_end;
> >
> >               /*
> > @@ -1455,7 +1458,7 @@ static int show_smaps_rollup(struct seq_file *m, =
void *v)
> >
> >                       /* Case 1 and 2 above */
> >                       if (vma->vm_start >=3D last_vma_end) {
> > -                             smap_gather_stats(priv, vma, &mss, 0);
> > +                             smap_gather_stats(priv, vma, &mss, vma->v=
m_start);
>
> I mean this is all horrible, having to pass vma->vm_start explicitly.
>
> Although better than the hack that gets compounded in patch 3.
>
> There 4 invocations of smap_gather_stats(), only one of them passes a
> non-vma->vm_start start.
>
> So it'd make more sense to just make smap_gather_stats() lose its 3rd par=
am and
> have it call smap_gather_stats_range(), then have 1 invocation of
> smaps_gather_stats_range() directly, as per suggestion in last patch.
>
> Or something similar to that.

Hmm. Ok, I'll wait for you to read your previous suggestions in [1]
and after that let's discuss what the final version should look like.
Thanks,
Suren.

>
>
> >                               last_vma_end =3D vma->vm_end;
> >                               continue;
> >                       }
> > --
> > 2.55.0.1007.g17ff1f9808-goog
> >
>
> --
> Cheers, Lorenzo
