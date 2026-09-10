Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF239B970
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083018; cv=pass; b=H5WV3m6MbC2JD40XgUFCuYqSMbErTvWfJLn3WUfnZs4ygrbx+FzM/GvGpBU5h2fH1qTttzRuENWWFxwudPVBXE3j7pioTbf3DJAHMTojXxyhrzjJGdwxv7av4QZoqJovj/xk6qiuUFnrS4uS60M0hLdY5/ywo8EHvT3Im5amtSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083018; c=relaxed/simple;
	bh=U617IjwK/DTXXMWR/2jdA00pv95iK+IC+ENWc5RiNb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFnNR5osqh09kDmU6B89jpV7jlETIrNh0CchLg5TS2g5uEeP82uCh6x66eRYyxZmwJzO5xjZYap1QLf9Edur/nwHNiPMNzvfkJFaS4d1txfKp8HsJ7XuIGuLsXYznaNGSOSLt8700FITgjZUhtCwSpzqKktMNy9eFZR+ORNTFng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmpcVaIe; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmpcVaIe"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so59581cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 16:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789083016; cv=none;
        d=google.com; s=arc-20260327;
        b=lSck2XjhTj7rVzgRfUDxlgCcSFZNxSoMimJ0bSbFbVeOygly6NC+F2kzRluuy67eys
         Sg3BuX8v560EYSAB28NayG95/195MXBpEUVDLK0f3nmx/U1FCF8ub/MO4qQ58r/8d+e9
         pQ6QcOm0JV6e1ZLWIMCfg0iQZqtgdt5/jClCp8W/qlHyFiKI93bOUQs3cosQ6jrRtxn9
         EWZ46JANWHSzBskmCgdlYc18Vk358mb6vyDh4lgjshyQBrzVGEBCDX44L1HRn/FmGSI9
         46JnbB+kYbpNPT9J5WAfhPzY/CvntjEcjcjBicz5t+vruFUybUjhMK5wz6S0Ol3eo1dj
         HLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KfEFjV7pufys+8nogVzTsTnHyxO087XXXuxAAwRJqeE=;
        fh=WsvonbrAwiKtpIc0pilBwi5u404TKWiYAM0w4tF9GU4=;
        b=IZcwHy2sA/0i/jaUTAM+I9TXaQ1n1wcXuSJGzPlBuPCnOdK5kNKbc+S1nLYkS9E9tV
         JWcY6dtB1ERQh5lvW9W5BbOud4+aHr0Hc8A3XpBOlNPzcASHIJF0Vq84S8AbtF6xj7f1
         bJnoP4Zpmp/lFMj29/iQM3rJRhSZggMw2q7W/QWu4jWU1xUgs3PhB+EYqoRl5KGjSDWR
         QYueQCE3J+F9tn7wQ3ycgUUucdTm5za0vujCggbB5EfpafzUEDsVQ0zuAAqS74BV5PRX
         aYF+iDWUwzMfKyo6+pXvUTtKYZCKy0KPiir66w4LgCTNAnUddMU65cvmk1gODRDl7wUA
         t3bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789083016; x=1789687816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KfEFjV7pufys+8nogVzTsTnHyxO087XXXuxAAwRJqeE=;
        b=rmpcVaIet+AL8IXdQSepdNWCApYHLTzudUh3G7Hwxhn8ADgShwtCk21QWODBx1S24p
         5BdvfkV1dyttqeG0CVkXOlhK91DS6Tmt3IBtg8mGlqOwNCyzZ7UBv4YSnWkJBH2O4UwC
         R1uZ4reguszY0CiI4GB1u/Tcp4Rap6+9LOj/9GHKUkIYJSdAwlfRu+aad/mWV58mOZb7
         dODnUbjYQlXc2J7Y9eNTGGNWCsjIJx32xN0k5Fm/SgyI3CXl7nRp7cDOQzUmyWslThmW
         joNIurFYF5k+jwjdnaNGNkqXr+9ZFccI2NQZGWVP3CdnJKnc/5GAFuSNIvfHhgU+p4kV
         +wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789083016; x=1789687816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KfEFjV7pufys+8nogVzTsTnHyxO087XXXuxAAwRJqeE=;
        b=AHwJG4bCS4AhLwJHX0lCW0+42iy/ZVAbErWs3OdJ7ByVRA5kiiEL9jpbg0wJYFv9pY
         +aiLvjfb4RNQhUVAYvgBOJniKGrsOmC/XIYYHDU3hkGPiljvi7tPSPC3eoAy0DyFv3H6
         qp9ny20avxHK0lnTLv9aCH/Dgky9KYVFz3WKpIvktpr0VQ6GRVrimLtROzEGz/IOb/5d
         hr0IPdwAi0TsrwsbgbPyEBP/xOp3gEvlpelC+7oZdOSKdJhZAntx0C865vxaz5PGKkBU
         jLQ9xfdgRmPW4OHnwoXcyACf3XyXfNSgAqLvdQNg5Wd1fLLkHHi66B7woeQo5Kgv3Eym
         oFRw==
X-Forwarded-Encrypted: i=1; AKwUvBxZCrR3+mNmxDZ0KiDfjl6K5evRfHPvrcsTm6sl77F+ktscPn60OyDNFVQLOQtQgQI0+KGsR7sIUkds1qK2@vger.kernel.org
X-Gm-Message-State: AFuF++nQLil8mygPvCMp3cjWfRY844jj/7eoE7eDWoTW4784l86y4EN9
	TQOU6YXv8paS9avqdYBWNtDimd4VAUQtyNwXE0m3Ib3Z4COIKzaAmutS9Y7yrOQX5DV2Mv8gHI/
	NkgXgZb/xN26AbRL7/SRBGgT79SKIxCI0QeaIpwvF
X-Gm-Gg: AYBFou3f/rbhZhC48TS2Jxmzhdq2wwMs+DE7gdMSXKsuPAp7YDGb7GNOR9CC3z7q3dG
	RqF0GntJ0mAqv4PFYR0zz7dLrmZntkZwLnufUB9zIH4WJCpzVRtsRtiPGllV+9d2h8AdK7pcPnG
	hYsbVR+RvuGkMaUqxwtEEb062LryUKNAuGYrurQQ5JsK1plKLgMmCvmgRv6DbyR0V70lyc5yLLf
	mzQxvd9lz1aILPpdc9UVK5JTUvvDuR4Bph7V7RDbkWa6EphD++unnX1Ypy4eK7Rx/SwZgbNM1cs
	AmpI+ygwOaddyICpXNYk8ymSs8pctjr6MPrZ8iGd2GL9WT/IoDVPAFGvQO4emfl8L+EZHDTkWJY
	79T2Lwoa79KE=
X-Received: by 2002:a05:622a:17c5:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-530cb488208mr4688201cf.3.1789083014965; Thu, 10 Sep 2026
 16:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260907063918.3432401-4-surenb@google.com>
 <4825a2fe-f064-45d7-a7c9-e98de7efe86c@kernel.org> <CAJuCfpFL_g7tELjT8p8ExM3tX_v2gNDM9rRKwwefPV_KW=fHfA@mail.gmail.com>
 <8e643f51-a47f-428e-9443-678326288fa6@kernel.org> <aqLUqsoMDfVtjRuN@gremlin>
In-Reply-To: <aqLUqsoMDfVtjRuN@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 10 Sep 2026 16:30:03 -0700
X-Gm-Features: AcwNN1W4yJUYStTy2CGNJdnxaH7FRdF38u1M6kpzgz8yoKPhhVSmpMzOaXNoWCY
Message-ID: <CAJuCfpH_t5xOm_=QkKJs+GWH92ThKwifC7Ruo8xx5LKRp6gjaQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org, liam@infradead.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 9:27=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Wed, Sep 09, 2026 at 09:16:23PM +0200, David Hildenbrand (Arm) wrote:
> > On 9/9/26 20:28, Suren Baghdasaryan wrote:
> > > On Wed, Sep 9, 2026 at 10:16=E2=80=AFAM David Hildenbrand (Arm)
> > > <david@kernel.org> wrote:
> > >>
> > >> On 9/7/26 08:39, Suren Baghdasaryan wrote:
> > >>> smap_gather_stats() interprets its start parameter to mean vma->vm_=
start
> > >>> when it's set to 0. Eliminate this special interpretation and pass
> > >>> vma->vm_start explicitly when needed.
> > >>>
> > >>> Since smap_gather_stats() operates within a single VMA, we can repl=
ace
> > >>> walk_page_vma()/walk_page_range() calls with walk_page_range_vma()
> > >>> which is simpler and also can be called while holding per-VMA lock.
> > >>>
> > >>> No functional change intended.
> > >>>
> > >>> Suggested by: Lorenzo Stoakes <ljs@kernel.org>
> > >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >>> ---
> > >>>  fs/proc/task_mmu.c | 40 ++++++++++++++++++++++------------------
> > >>>  1 file changed, 22 insertions(+), 18 deletions(-)
> > >>>
> > >>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > >>> index 9908ba32f180..3351decd1172 100644
> > >>> --- a/fs/proc/task_mmu.c
> > >>> +++ b/fs/proc/task_mmu.c
> > >>> @@ -1246,20 +1246,27 @@ get_smaps_shmem_walk_ops(struct proc_maps_p=
rivate *priv)
> > >>>       return &smaps_shmem_walk_vma_lock_ops;
> > >>>  }
> > >>>
> > >>> -/*
> > >>> - * Gather mem stats from @vma with the indicated beginning
> > >>> - * address @start, and keep them in @mss.
> > >>> +/**
> > >>> + * smap_gather_stats() - Gather mem stats from @vma.
> > >>> + * @priv: proc maps private state.
> > >>> + * @vma: The VMA to gather stats for.
> > >>> + * @mss: The accumulated stats.
> > >>> + * @start: The address from which to start.
> > >>>   *
> > >>> - * Use vm_start of @vma as the beginning address if @start is 0.
> > >>> + * This gathers stats for the whole of the VMA unless the lock was=
 dropped
> > >>> + * and VMA grew or got merged and we found it again, in which case=
 we only
> > >>> + * gather stats for the remainder of the VMA range.
> > >>>   */
> > >>>  static void smap_gather_stats(struct proc_maps_private *priv,
> > >>>                             struct vm_area_struct *vma,
> > >>> -                           struct mem_size_stats *mss, unsigned lo=
ng start)
> > >>> +                           struct mem_size_stats *mss,
> > >>> +                           unsigned long start)
> > >>>  {
> > >>>       const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv);
> > >>> +     const bool is_partial =3D start > vma->vm_start;
> > >>>
> > >>>       /* Invalid start */
> > >>> -     if (start >=3D vma->vm_end)
> > >>> +     if (start < vma->vm_start || start >=3D vma->vm_end)
> > >>>               return;
> > >>>
> > >>>       if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> > >>> @@ -1279,20 +1286,17 @@ static void smap_gather_stats(struct proc_m=
aps_private *priv,
> > >>>                * Unless we know that the shmem object (or the part =
mapped by
> > >>>                * our VMA) has no swapped out pages at all.
> > >>>                */
> > >>> -             unsigned long shmem_swapped =3D shmem_swap_usage(vma)=
;
> > >>> +             const unsigned long shmem_swapped =3D shmem_swap_usag=
e(vma);
> > >>> +             const bool shared_or_ro =3D vma_test(vma, VMA_SHARED_=
BIT) ||
> > >>> +                                       !vma_test(vma, VMA_WRITE_BI=
T);
> > >>>
> > >>> -             if (!start && (!shmem_swapped || (vma->vm_flags & VM_=
SHARED) ||
> > >>> -                                     !(vma->vm_flags & VM_WRITE)))=
 {
> > >>> +             if (!is_partial && (!shmem_swapped || shared_or_ro))
> > >>>                       mss->swap +=3D shmem_swapped;
> > >>> -             } else {
> > >>> +             else
> > >>>                       ops =3D get_smaps_shmem_walk_ops(priv);
> > >>> -             }
> > >>
> > >> Horrible, horrible code, really. But not your fault :)
> > >>
> > >> I think we can just make the shared_or_ro less odd by just checking =
for cow
> > >> mappings (as described in the comment).
> > >>
> > >>         const bool is_cow =3D vma_is_cow_mapping(vma);
> > >>
> > >> ...
> > >>
> > >>         if (is_partial || (shmem_swapped && is_cow))
> > >>                 ops =3D get_smaps_shmem_walk_ops(priv);
> > >>         else
> > >>                 mss->swap +=3D shmem_swapped;
> > >>
> > >> That's almost in a form that I could understand what's happening.
> > >
> > > Hmm. So, are you saying that !is_cow always implies shared_or_ro? Or
> > > maybe you are stating that vma_is_cow_mapping() was the actual intent
> > > here?
> >
> > So the comment says:
> >
> > "For private writable mappings, we might have COW pages that  .."
> >
> > Which translates to:
> >
> >       private writable =3D=3D vma_is_cow_mapping()
> >
> > >
> > > shared_or_ro =3D VMA_SHARED_BIT || !VMA_WRITE_BIT
> > >
> > > is_cow =3D !VMA_SHARED_BIT && VMA_MAYWRITE_BIT
> > > !is_cow =3D VMA_SHARED_BIT || !VMA_MAYWRITE_BIT
> > >
> > > so, !is_cow would impy shared_or_ro only if !VMA_MAYWRITE_BIT always
> > > implies !VMA_WRITE_BIT. But I think it's possible to have a VMA that
> > > has VMA_WRITE_BIT but not VMA_MAYWRITE_BIT, right?
> >
> > VMA_WRITE should imply VMA_MAYWRITE
>
> Yup it's illegal to set VMA_WRITE_BIT without VMA_MAYWRITE_BIT.
>
> >
> > (in sanitize_fault_flags() we even disallow write faults entirely if VM=
_MAYWRITE
> > is missing)
> >
> > For example, a
> > > driver can create such a VMA to allow writing to the VMA but to lock
> > > its content once mprotect(PROT_READ) gets called.
>
> I'm not even sure how a driver would achieve that but drivers in general =
are not
> permitted to alter VMA flags after map time.
>
> >
> > I don't think that would be valid for a driver to do. But it wouldn't m=
atter
> > here because
> >
> >       shmem_mapping(vma->vm_file->f_mapping)
>
> Yup :)
>
> >
> >
> > I think we could simplify the comment as well to:
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index e671b4fd8dedd..4b7e7089cafa7 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1303,12 +1303,10 @@ static void smap_gather_stats(struct proc_maps_=
private
> > *priv,
> >
> >         if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
> >                 /*
> > -                * For shared or readonly shmem mappings we know that a=
ll
> > -                * swapped out pages belong to the shmem object, and we=
 can
> > -                * obtain the swap value much more efficiently. For pri=
vate
> > -                * writable mappings, we might have COW pages that are
> > -                * not affected by the parent swapped out pages of the =
shmem
> > -                * object, so we have to distinguish them during the pa=
ge walk.
> > +                * In CoW mappings, we might have anon folios that are
> > +                * independent of the shmem object. So fallback to the =
less
> > +                * efficient mechanism in such mappings.
> > +                *
>
> Maybe tweak to 'CoW mappings might map anon folios that do not belong to =
shmem,
> so perform a less efficient page table walk in this situation' or somethi=
ng like
> that?

I ended up with this:

/*
 * CoW mappings might map anon folios that do not belong to
 * shmem. Perform a less efficient page table walk in this
 * situation, unless we know that the shmem object (or the
 * part mapped by our VMA) has no swapped out pages at all.
 */

Hope this explains the condition clearly.

>
>
> >                  * Unless we know that the shmem object (or the part ma=
pped by
> >                  * our VMA) has no swapped out pages at all.
> >                  */
>
>
>
> >
> > --
> > Cheers,
> >
> > David
>
> --
> Cheers, Lorenzo
