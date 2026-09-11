Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598F326928
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150004; cv=pass; b=WShQXev+09xweqoYMfUPDbPPMTu4AREkVn0JPllWDJBwBKtSBOBgZfkQEUD2VyK7UZih+GiUtPyBTw+lwlblVka4degkujeUloxIPdniO9CmrFQ417RQU/I2cq53Sm3K9u606JuBGWdBoC/KuBmTh1bentewk95ZGWQyjAtVY3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150004; c=relaxed/simple;
	bh=98hvdYUQRAQnArtgHRxFqpAw52ijLzkKM/9cnlXcpGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLGr0IbsdkUQ8XVFt2n9m9T+PteW/IYoWlL57wkrfiiINPb/8jyRM7hvGpyxmiJkb5ofiZewFM45QjPAKBO2/ZwJMP18K6ylfxhdI+QYa0MH/82ii7W8hllD9gpYV1Ww+GSNKE2oSRjTVhElotr0EeoVv8vbnIiXdcs1y8HNN14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1CFuIS0; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1CFuIS0"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so92511cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 11:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150001; cv=none;
        d=google.com; s=arc-20260327;
        b=GTbxAbuxVS5n4ca4mIUwdWcaUeaN+ymE0vbCOqfWfAmxYxI9DHwFOJvxir+hpRdFH2
         W/NrePKmeKeKLy0hD+07aj2h0aGIxAndJMXHtI/HOpicl+UtrCDOUfR1XALicWQrnJA0
         LOn05oqQGia6xvB+XoZ6G/oKBbmjrJaRVDkdhnypMd1s0MzYQ41ucjgPdtOJsP5cRO2K
         nVHVBFoXmMIiXDbqZPkifVr2o4NlEObBcALRIsOlfdDaqPNvxuM3r7ZoG477sya4k9Gx
         ZxKps7A5+BrClK/0IQRMazQTtLB/ORfco+2aSQqf5XgBJKQPskJs3M2LMk3AHCZLVP7n
         n3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L0Iac+7+1XRJVGRm7qhhyrQds1DwdpS7YmgEfvKp+Z4=;
        fh=R10+qC7FZ4F49/UsWZKbR5XIb5F56zjtzevrrnNhuJA=;
        b=EA8CjAEjkZ4kWgEqhj1BNOJH5jRt1L4pBPQmLBz3es7OUBltzb7o5ykLZA5Yd9pz9M
         0MGywI/xJkAQWiC4SVAQWrQ9VwA5lI3v5dA7z/Db5A7VLdNm1dVO2gfVjnroE5o9r1aC
         JDMm9X5/B9/4qxFGPUZysj5B1bpS9XYjnQoZohXmAlQBrphHG84gIEjjLg6fXVaXt3SO
         VHMRVO2ymvh0/ZA8CruKmkG49YgnrsbFuWIoZXCmuJc/ew5KpX6DjypA+4dByG3Y/Lyp
         MJ0bsNyexAMOsr/ENHZwrnW71ND/xtjtEadAp+nQ3eE7VFIfGlZVMvLHo7CWj/BeHEdW
         8ZlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789150001; x=1789754801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L0Iac+7+1XRJVGRm7qhhyrQds1DwdpS7YmgEfvKp+Z4=;
        b=c1CFuIS0r/GhPWuU59t8+1u9a8NPHVQkTpFpq9FkjLK6vzHOk3SXqdHl8KPdoi4eSg
         1n3AeJE/XNrMUcmTE+/6/GwvYmX03GvKOl4XBmYdJ+zbOlIqCQnZVmtD0oL99HJE+A6f
         onYYQd92UFHi96AB1AqkhVNS4swqM0SXXnF6Loeehk6C30IteM/oNF235Co4JaApaIA+
         /bSRYIMr1byjHFPBsm9LhmHZoJr8s+EY70z/lfaVoIYFFKAKgYBjb7/ufC9exGboKN/d
         k8Pb6HxhAZKkCbsdU45rucWX8Ooc7QaZ/ZhqTUed8u0pbDYiXFsmeIU8Fb7mujj2Hare
         9FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150001; x=1789754801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L0Iac+7+1XRJVGRm7qhhyrQds1DwdpS7YmgEfvKp+Z4=;
        b=MThc4R4+HiNTPPIDWU6QsA1RTjuazdAPfy9HFboe3k+2/ZYfL/Foeqf1Coa+1Fk9I2
         S8a5qFctxE70+3xKSAFLaUfjLWG2VGBv9RRh8om0EgJaOXdMKixXh0R3nf6zvnBTrHJ2
         VGCK/mz0la6tFY9w3o4cRYgxnOP+H8PaAu19LGVOm6Sk8mUB0Op6jUu2FRD8U+ZvI2tI
         7CF+y7hEynUDUzOjxYj3s5VoXpwO4u0fWNOnmBaB+HSEmnIU1r9ZqnaObaxQHvKQbFkT
         uHHUvDOQly7hALboTsQrEH+iJZFIAO+k/gbhyO+DOuGQa6QCcw3g6ii/IGRm6vQb9YxK
         OKHw==
X-Forwarded-Encrypted: i=1; AKwUvBypAVAPp920YAHOqnhXk8VaSmjxjUMr4N1o5G4teB34hh32weg3tDayDMRT+QH8VGY0ptMBGP4TcEjTjp0S@vger.kernel.org
X-Gm-Message-State: AFuF++n+Flg/OzfJcRrH2SMJoexwaoFGeLRB8iUsSfAggoz1Tk+9lElz
	nRvSVsLEFJMZEtWIqkIB70kDUzOFJ40vaasFf2+LEVcepLwyBar+fnwGzcBN/nOwYwF1pxJ67sj
	1xJKg3zw5GsoltgwrN3785xjAHokc9lh6dT44eM/b
X-Gm-Gg: AYBFou2Xp3yQJb4qMoaf3RlUYi/e6PixzIrVYOH8u7viEwOHw6CJW61twp3cKmGCgVm
	1zIM0PLiye6egkehKjeWKZwvpU8YTjNjEmnMDc7RocDN16jYfIcUtowU10TyY8cv3pji+7ADT0w
	A+tiLohkwgLdk0secUgTNTxOAwEVvmMpG9pTGGff06NIENQJQXqQHoU5xxiUej/3hyttZfR03wP
	J9aqkkVIg4C2MKlK3PDIMZDgVx5OADffIo18qRmz7P8uAqQGDTJZ1z5EEmCM7tcDTS2jNFc+inx
	fHlIDE31sh68B5+00IDMaL+XarnsBKjXY6yBKUPowx1uTjopS+yjq4MugNJFJu8MGAKXKxZZwgT
	M/bG3huKP1Q==
X-Received: by 2002:a05:622a:c0c:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-530e468d6f2mr1048401cf.12.1789150000015; Fri, 11 Sep 2026
 11:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-5-surenb@google.com>
 <aqQsWNfrBSp4DY_N@gremlin> <CAJuCfpEEi-9ZqhKR536tJHywprb9RFcx92gK00qp_ecBGH9Fvw@mail.gmail.com>
 <aqQ2M5bZv4k43j91@gremlin>
In-Reply-To: <aqQ2M5bZv4k43j91@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 11:06:28 -0700
X-Gm-Features: AcwNN1XJcFI1qpSul5kFpPRx9O73QUYS1FieU23uJkjNgjnxdeFXxY6hqfMzzMg
Message-ID: <CAJuCfpG21qzef-yag3A9d22BUXnx2EFmbSvT=Zi5uRx_h7BxbA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:49=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Fri, Sep 11, 2026 at 05:07:48PM +0000, Suren Baghdasaryan wrote:
> > On Fri, Sep 11, 2026 at 4:39=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > >
> > > On Thu, Sep 10, 2026 at 04:47:34PM -0700, Suren Baghdasaryan wrote:
> > > > smap_gather_stats() interprets its start parameter to mean vma->vm_=
start
> > > > when it's set to 0. Eliminate this special interpretation and pass
> > > > vma->vm_start explicitly when needed.
> > > >
> > > > Since smap_gather_stats() operates within a single VMA, we can repl=
ace
> > > > walk_page_vma()/walk_page_range() calls with walk_page_range_vma()
> > > > which is simpler and also can be called while holding per-VMA lock.
> > > >
> > > > No functional change intended.
> > > >
> > > > Suggested by: Lorenzo Stoakes <ljs@kernel.org>
> > >
> > > Hmm did I? Where did I suggest this?... I guess a while ago?
> >
> > In [1] on June 9, 2026.
> >
> > [1] https://lore.kernel.org/all/aifO_rCurVhFRTcl@lucifer/
>
> Yup a while ago :)
>
> >
> > >
> > > I mean I also happen to suggest it in the previous patch review :) bu=
t that was
> > > sent after you sent this...
> > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
> > >
> > > I don't love hacking a hack for a patch and then unhack it in the nex=
t in a
> > > slightly roundabout way.
> > >
> > > Feels like this should be squashed. And a wrapper function for
> > > start=3Dvma->vm_start should be used rather than duplicating that par=
am
> > > constantly.
> > >
> > > > ---
> > > >  fs/proc/task_mmu.c | 29 ++++++++++++++++-------------
> > > >  1 file changed, 16 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index 3c40c9cbb9c9..ecce7ce116cb 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -1246,21 +1246,27 @@ get_smaps_shmem_walk_ops(struct proc_maps_p=
rivate *priv)
> > > >       return &smaps_shmem_walk_vma_lock_ops;
> > > >  }
> > > >
> > > > -/*
> > > > - * Gather mem stats from @vma with the indicated beginning
> > > > - * address @start, and keep them in @mss.
> > > > +/**
> > > > + * smap_gather_stats() - Gather mem stats from @vma.
> > > > + * @priv: proc maps private state.
> > > > + * @vma: The VMA to gather stats for.
> > > > + * @mss: The accumulated stats.
> > > > + * @start: The address from which to start.
> > > >   *
> > > > - * Use vm_start of @vma as the beginning address if @start is 0.
> > > > + * This gathers stats for the whole of the VMA unless the lock was=
 dropped
> > > > + * and VMA grew or got merged and we found it again, in which case=
 we only
> > > > + * gather stats for the remainder of the VMA range.
> > >
> > > This seems to be describing what callers do not what the function doe=
s unless
> > > I'm missing something? So that's really the wrong place for it.
> > >
> > > I think the description of why it might be a partial walk belongs to =
the bit of
> > > code that actually tries to do a partial walk.
> > >
> > > Anyway as per below I think separate partial/full functions make sens=
e and there
> > > it can simply be described as walking either the full or part of the =
VMA.
> >
> > This is verbatim of what you wrote at the end of [1]
>
> OK, I guess I disagree with myself of 3 months ago?
>
> The technical point being made here, which I think is the more constructi=
ve one
> to engage with, is that this is a function that can be called with differ=
ent
> parameters for whatever reason.
>
> Somebody might decide to call it for another reason, putting something in=
 the
> description of the function that assumes what callers will do when that c=
ode can
> change is asking for bit rot.

Yeah, that makes sense.

>
> So as I suggested above:
>
>         I think the description of why it might be a partial walk belongs=
 to the
>         bit of code that actually tries to do a partial walk.
>
> I.e. I guess past me's description is apt, but belongs with the partial c=
ase.

Ok, sounds like you want two separate functions supporting complete or
partial walk. I don't have a strong preference here and it's easy to
do like this:

staic void smap_gather_stats_range(priv, vma, &mss, start)
{
        ....
}

staic void smap_gather_stats(priv, vma, &mss)
{
        smap_gather_stats_range(priv, vma, &mss, vma->vm_start);
}

Does that sound good?

>
> >
> > >
> > > >   */
> > > >  static void smap_gather_stats(struct proc_maps_private *priv,
> > > >                             struct vm_area_struct *vma,
> > > > -                           struct mem_size_stats *mss, unsigned lo=
ng start)
> > > > +                           struct mem_size_stats *mss,
> > > > +                           unsigned long start)
> > > >  {
> > > >       const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv);
> > > >       const bool is_partial =3D start > vma->vm_start;
> > > >
> > > >       /* Invalid start */
> > > > -     if (start >=3D vma->vm_end)
> > > > +     if (start < vma->vm_start || start >=3D vma->vm_end)
> > > >               return;
> > > >
> > > >       if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> > > > @@ -1285,10 +1291,7 @@ static void smap_gather_stats(struct proc_ma=
ps_private *priv,
> > > >                       mss->swap +=3D shmem_swapped;
> > > >       }
> > > >
> > > > -     if (!start)
> > > > -             walk_page_vma(vma, ops, mss);
> > > > -     else
> > > > -             walk_page_range(vma->vm_mm, start, vma->vm_end, ops, =
mss);
> > > > +     walk_page_range_vma(vma, start, vma->vm_end, ops, mss);
> > >
> > > I mean obviously am in favour of this as I suggested it in the last p=
atch :)
> > >
> > > >
> > > >       reacquire_rcu(priv);
> > > >  }
> > > > @@ -1343,7 +1346,7 @@ static int show_smap(struct seq_file *m, void=
 *v)
> > > >       struct vm_area_struct *vma =3D v;
> > > >       struct mem_size_stats mss =3D {};
> > > >
> > > > -     smap_gather_stats(priv, vma, &mss, 0);
> > > > +     smap_gather_stats(priv, vma, &mss, vma->vm_start);
> > > >
> > > >       show_map_vma(m, vma);
> > > >
> > > > @@ -1396,7 +1399,7 @@ static int show_smaps_rollup(struct seq_file =
*m, void *v)
> > > >
> > > >       vma_start =3D vma->vm_start;
> > > >       do {
> > > > -             smap_gather_stats(priv, vma, &mss, 0);
> > > > +             smap_gather_stats(priv, vma, &mss, vma->vm_start);
> > > >               last_vma_end =3D vma->vm_end;
> > > >
> > > >               /*
> > > > @@ -1455,7 +1458,7 @@ static int show_smaps_rollup(struct seq_file =
*m, void *v)
> > > >
> > > >                       /* Case 1 and 2 above */
> > > >                       if (vma->vm_start >=3D last_vma_end) {
> > > > -                             smap_gather_stats(priv, vma, &mss, 0)=
;
> > > > +                             smap_gather_stats(priv, vma, &mss, vm=
a->vm_start);
> > >
> > > I mean this is all horrible, having to pass vma->vm_start explicitly.
> > >
> > > Although better than the hack that gets compounded in patch 3.
> > >
> > > There 4 invocations of smap_gather_stats(), only one of them passes a
> > > non-vma->vm_start start.
> > >
> > > So it'd make more sense to just make smap_gather_stats() lose its 3rd=
 param and
> > > have it call smap_gather_stats_range(), then have 1 invocation of
> > > smaps_gather_stats_range() directly, as per suggestion in last patch.
> > >
> > > Or something similar to that.
> >
> > Hmm. Ok, I'll wait for you to read your previous suggestions in [1]
> > and after that let's discuss what the final version should look like.
>
> I don't really think that's hugely constructive.

I wasn't trying to offend in any way. Just wanted to give you some
time to recall previous conversation and consolidate your position.

>
> I'm sorry I'm (mildly) disagreeing with my past self, I've sent tens of
> thousands of words of review since then so I think it can be forgiven.

Definitely. Again, I wasn't trying to blame or anything like that.
Just pointing out our previous discussion and want to make sure we are
on the same page (while having some fun in the process).

>
> In any case, I really do think:
>
>         smap_gather_stats(priv, vma, &mss);
>         smap_gather_stats(priv, vma, &mss);
>         smap_gather_stats(priv, vma, &mss);
>         smap_gather_stats_range(priv, vma, &mss, last_vma_end);
>
> Works better than:
>
>         smap_gather_stats(priv, vma, &mss, vma->vm_start);
>         smap_gather_stats(priv, vma, &mss, vma->vm_start);
>         smap_gather_stats(priv, vma, &mss, vma->vm_start);
>         smap_gather_stats(priv, vma, &mss, last_vma_end);
>
> ?
>
> I usually come back on review very quickly so I don't think this series
> will be held up with any such change.
>
> But let me know if you think it's not a good idea technically.

TBH I don't have strong preference but if you like it this way, it will be =
done.
I'll post an update today since I don't think there will be more
controversial parts. The biggest blunder on my part was the way I
split patch 3 and 4.
Thanks for the review!

>
> > Thanks,
> > Suren.
>
> --
> Cheers, Lorenzo
