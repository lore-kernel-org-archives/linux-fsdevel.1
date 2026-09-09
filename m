Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB6039B969
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978524; cv=pass; b=oOT1oMoY08yRavrOCBO/d8WCrMTMMRWRRwskuiwSrTdsWiUIDD9N6wvDEyRQeCPtn78DDqAgSsHa1bwWITQLPlfXeNiYiq2dOlQzwXbCqkyC5Jq3TV2UlBK9r82U8V3Sv6177MAsL/HbUkOiQUo9UmnSu6bhGtvnsarutjkkpZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978524; c=relaxed/simple;
	bh=jOYWbqbGjEZ74DbR/7Sly5b/bgYTeI+rrk8WcUJjSkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQGv6h7hbyxu4ifYYzeoNIt52e9VtKtTuNqSrxeCDGtfA65HaWduTYL7xLF/h4gD/rpcN1IdQg/MVLfw5l+3LvDRpQ+29ytN/K4NHBxulaloazMHOPILzx4+jSxWzoBIvJPYTcSnIbKO5aN8oJzcEK+kv3ItMg8TPf+QESODp6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4/q/isB; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4/q/isB"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5307425f44bso332921cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 11:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788978521; cv=none;
        d=google.com; s=arc-20260327;
        b=FBjygJR5eCke+7742ClpCUJsYZBLyWLR/nzw4Xqzh67Ub+wSsfUV7UGJQf4iv76i89
         CgLPR2sUIR6gu8C7Odn0i8r3KC9CCuVLqqlV63ILiIZBWgV1krbI46Lp0sfTq7bazMVi
         q/6jd04c5S6t71JxI9QheAbMeULh3iZTN7dAcIf8uY50/KMkcUqgWrHejJAx5sFosZJs
         M6UxRlXrIZce7u5lmvuBzhVdfyvLxsxfeCEV5oDpGyxNX91UabHC4PIiGTCLrx3qfrBQ
         vP2bdqeLHrp1F7wv+YA6Ur8WVJDsGpiTQ48HWbNI4Yqs1jg5FE8Qi6wj3tEvTdmu98PS
         kGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cJDbFOIPiBEjqRCw5Yx9h+UnhUPff8j+dBiof+7K4sg=;
        fh=3rDgxuPUNj4m9U/qkxTA37+QorMWPs+bMZr59mF0S64=;
        b=dK010x1PAyu3KcIKaTrV4hylcchLdTrbmwBilK0coLTsSHf1KRjolLH95x9g24SmKb
         2zRpVyeqoT9ZmdoFsj4CRyjKknu+tYH1blh0fSyw6HrxHbmArWhoIkkSdRxd0sWI1XZQ
         LjrdmcTtjmSSwMiF6zQqZupKYq5FaT6R6mmsvJ9urB3TKPUZdXZO2EI3nZ49omgEITcJ
         NdZxvr66Y+rJxjZZi5AtKAFMF5LtlMqhhJ8sXr5sVd43HC7k4gkKSU8x2IJY+ckVtX7r
         0iiZEUGll4HrzPVsaRMMR30DsDeeiXmGP0Bn1teYxPecHKKFvoXHBvw26G1KF3Joa2+k
         jggQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788978521; x=1789583321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cJDbFOIPiBEjqRCw5Yx9h+UnhUPff8j+dBiof+7K4sg=;
        b=p4/q/isBk5lROf1RGTUomRWvG2hT/11iSCXoMxc4ZseD3B9E00yHQ51ywEJTRyYC2w
         orMHTe6UMqsXAJVvLeG0GleJaXTMiMfMb/fCvEt+db3j98vBnPZwofjsT7942JflPOws
         6xTrqPN/5e7r14p9DyLFnSFAaeCTqzeOtM+30sbMv5SpDKFTDWfzzbqrfGqCqgKXvvdM
         tw2f4WPyeJxbS9SAPvBUNpNigMI82RLxYizDPIv9cNulFFd77R4a11/Gu0hNy/s0bD/Q
         04DUS1qU1CroHAwbUfiNibYf6cTzQw2InAA8SR5MHoluS5w2UTLXBltz0Q2aZi6H6fIR
         v/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978521; x=1789583321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cJDbFOIPiBEjqRCw5Yx9h+UnhUPff8j+dBiof+7K4sg=;
        b=nc+9gc2Z74OscYLhsVslXy+iiU2A0Jqa/TqGCsXiSOkmQ5a8sbGtm5TEOTT9XkfCdV
         0BqP/13PTPMy5bUrOaDVEgExl8gfluY7/kq4IL+k/98ZOOU1Z9JBA+Fa0WHWxRN1Detw
         1hLnebOXRUrOm4FQiT//usLsJuet0z+wMG1da+zXI95BhsC4BQi+VS+9whd6arnGdOCE
         tzgbJf/1ITaO53zEu0ncmBv++gyhHf7xoO7hbhGFUosJHp1x6nO1WW6ScICckauzDBjE
         85HJ5sq4C2uWneafe4/9GbMUNrk+47jge9wi9QfSc9Rr8aPEq0etiqMdK+vegJJr7gGj
         m/Uw==
X-Forwarded-Encrypted: i=1; AKwUvBx4wbk+18LykD7jx+YGkzFiE5eo0hYWl7sIFJpNC3DittVwFz4Ix/ULA8VnrUs4KxlkrQwZn2nCkK0aD/ft@vger.kernel.org
X-Gm-Message-State: AFuF++lYShtggMbIgunkHOvHkWcba7dE+2E/z9yz/6fEUyZz6j+XTTCs
	0VDQZRD03vLIzdl7dZl1uQ8da0FRsRoSGWSaIyAG3Ltf5l5fj9tjt6xGnju31l5AqfGOWPyOONE
	Vr39HZQRDVsTyk3buV6orl0WYvbuGXb6zuUkKDX0W
X-Gm-Gg: AYBFou3mOBRX7NV/AvSjKqnZDA+flyG23uw+sMtxc0aIYLq8e3wnRVBcH63uZTgiAdW
	XPm6NojMqVr0Y8i5L8jNWzkZdQPr7nhwBI3TIkxiU3foCwHYpGIFRoSrUNzLJCp7495/n52/jOk
	lPTCWYgnpfXNUyq4YXHPO2JyLWFYu2es51jNdsudoXw0iHmznniESeDalSzcsufmlio90sOtPJW
	h2Ry66Y6zBRoi+xRBIeYJMMuUWW4TP3NULUL1BuVEaiKdaF/OrPah9aYCBDU59PwubnLJH8sJ3G
	NK2T1hAQaxoJvQomq6ULHWD1TglI3aewWZDr4gP1HaulIxoGr6m2EiAlWg==
X-Received: by 2002:a05:622a:4a8f:b0:530:4381:e745 with SMTP id
 d75a77b69052e-530b48fe16amr625971cf.10.1788978520364; Wed, 09 Sep 2026
 11:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260907063918.3432401-4-surenb@google.com>
 <4825a2fe-f064-45d7-a7c9-e98de7efe86c@kernel.org>
In-Reply-To: <4825a2fe-f064-45d7-a7c9-e98de7efe86c@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Sep 2026 11:28:29 -0700
X-Gm-Features: AcwNN1UhCxMjsN-ZvXY1SXXIlCU2WXXFiLWmPzRsbEUiUvDAd79GPKH9ucEAeVU
Message-ID: <CAJuCfpFL_g7tELjT8p8ExM3tX_v2gNDM9rRKwwefPV_KW=fHfA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:16=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/7/26 08:39, Suren Baghdasaryan wrote:
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
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c | 40 ++++++++++++++++++++++------------------
> >  1 file changed, 22 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 9908ba32f180..3351decd1172 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1246,20 +1246,27 @@ get_smaps_shmem_walk_ops(struct proc_maps_priva=
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
> >   */
> >  static void smap_gather_stats(struct proc_maps_private *priv,
> >                             struct vm_area_struct *vma,
> > -                           struct mem_size_stats *mss, unsigned long s=
tart)
> > +                           struct mem_size_stats *mss,
> > +                           unsigned long start)
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
> > @@ -1279,20 +1286,17 @@ static void smap_gather_stats(struct proc_maps_=
private *priv,
> >                * Unless we know that the shmem object (or the part mapp=
ed by
> >                * our VMA) has no swapped out pages at all.
> >                */
> > -             unsigned long shmem_swapped =3D shmem_swap_usage(vma);
> > +             const unsigned long shmem_swapped =3D shmem_swap_usage(vm=
a);
> > +             const bool shared_or_ro =3D vma_test(vma, VMA_SHARED_BIT)=
 ||
> > +                                       !vma_test(vma, VMA_WRITE_BIT);
> >
> > -             if (!start && (!shmem_swapped || (vma->vm_flags & VM_SHAR=
ED) ||
> > -                                     !(vma->vm_flags & VM_WRITE))) {
> > +             if (!is_partial && (!shmem_swapped || shared_or_ro))
> >                       mss->swap +=3D shmem_swapped;
> > -             } else {
> > +             else
> >                       ops =3D get_smaps_shmem_walk_ops(priv);
> > -             }
>
> Horrible, horrible code, really. But not your fault :)
>
> I think we can just make the shared_or_ro less odd by just checking for c=
ow
> mappings (as described in the comment).
>
>         const bool is_cow =3D vma_is_cow_mapping(vma);
>
> ...
>
>         if (is_partial || (shmem_swapped && is_cow))
>                 ops =3D get_smaps_shmem_walk_ops(priv);
>         else
>                 mss->swap +=3D shmem_swapped;
>
> That's almost in a form that I could understand what's happening.

Hmm. So, are you saying that !is_cow always implies shared_or_ro? Or
maybe you are stating that vma_is_cow_mapping() was the actual intent
here?

shared_or_ro =3D VMA_SHARED_BIT || !VMA_WRITE_BIT

is_cow =3D !VMA_SHARED_BIT && VMA_MAYWRITE_BIT
!is_cow =3D VMA_SHARED_BIT || !VMA_MAYWRITE_BIT

so, !is_cow would impy shared_or_ro only if !VMA_MAYWRITE_BIT always
implies !VMA_WRITE_BIT. But I think it's possible to have a VMA that
has VMA_WRITE_BIT but not VMA_MAYWRITE_BIT, right? For example, a
driver can create such a VMA to allow writing to the VMA but to lock
its content once mprotect(PROT_READ) gets called.

>
> --
> Cheers,
>
> David
>
