Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AC43934D
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990686; cv=pass; b=o9Nibpv64TodgckNHcjIDQzOLiW64CK8O8K+jzIXUrMwPjCQEUJbMKKj1+jGFPCFw7JdjVpD9iE5GV7d5WvnXugulXJGDk++eYU32zs8TkCbRaWunkXwqYcRCne2YrQ9d5kcr6+WyjOGT0PD5SZQvp1/SHO7+XVHFp8oDpE9/FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990686; c=relaxed/simple;
	bh=oGSL5ZNrRrIcFVKDXpFvslxtC08mY6cmJRWkDCy+QXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzZCuPZ44wVnQKirEoyiXRK/YiAg6+d8fEbPgdvtfDDyk8nZHv10U92EhxM07C1dUUzkzAsafo3Pli/J2oAn5NjDg6UgfvjIsiEarinyI2xH+tweEWh7mey2hzBVctQSv4Xy5/Ty7skUg0GYd6YbP0SvnO7uIaEnQ4iTPk7rYUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INHOTf6u; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INHOTf6u"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so38721cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 14:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788990682; cv=none;
        d=google.com; s=arc-20260327;
        b=TEJvtfqrIzWWClXpRGo3Mi2nQ9Nidi0khH7D4AfehKC+pMKcuPaV8P4KHxGs/nZV35
         U0pa/LzIOqxOHZRdp3cn4biHlN8Y0BV+mtyKj3vEXdYYkyP1GCf2USe3vmYUiRfKrUxE
         LcUCzKiRcCudIhWNErGiLHzOzUwqqXiS9GGf5r/Nvsfw8a/Q7bHDJt08qzuG2MfPy+hy
         XaqERoW7lf5xJ8xr8q1mZWfYS1Yxc2+2LVnQJPIWC6cdGseXPTUrK8xTwbEbnAP+Bvfp
         Z5f3wQg+bsWwxA+Pz4T1WJ3A57cHRDkkcPtUJyDzLvdR2U8+hJH5M48MDtmYBirvnvQ/
         4Z8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A7p9WWZeWPUSCEcOXg2XJofz7nmB+pP1oglnGvljEvQ=;
        fh=HzoJOjRE4TFsuh+EwrvWXMHnndA3IfYAcPDYKf3pPH4=;
        b=DVpPPEC/ZExgzzdMHV6reLkozEVll5gKGdWzRD48FSuyY2H5mf1WYdv3Px1kvAHdfD
         REmyEwPmz5XfUKMuojB8njaV8xcIV1fzZEUsFWCi1Bv5YSf/HrIcpWivEMR4sQzzO0GY
         VgkllqbHPyeABPWyu5vmqy7ebC3ixwHZc+z6LlsDbi46KTk5zNu/eD+6B12W3ip5sK+e
         kS0zlbXfPU0uuWwn2r7q/WDBC0mg+ZAyIbi3+m7+W5cEctpI/ITpHKnFw31VSQsp7Xh1
         rQhyC8ND2iX6pmICsJQbIKGHDY08clWFoEtPaE3jqc5TsTHCDeZfoTViG2Hp/1SMsY0k
         dsMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788990682; x=1789595482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A7p9WWZeWPUSCEcOXg2XJofz7nmB+pP1oglnGvljEvQ=;
        b=INHOTf6uLKoiWJE3oMLPAjRFPBnVSFPLK96SgWFMRvdLwdQPHOaj7NMol0W5A4gsBk
         MtKqMbavARKgLFzrJNr2Gz+l2KWKvKuaw8uqe325ilHZSgV66q5RhxYlpUgPQHD4LZSd
         zeo2x1BL83ZWGwxgog2FZBOeDrXiqcSx8+2AhsLrC0x5kHhIkJNENhrt1vPONtKaZzz4
         iq80jUXeeP8ysHvgDDAbf0amAInA3CAGc7bi2iaSnfCCpZdHtjmoEMchEjTuBTFMKwxa
         vrb/PoOt5uRYbh6A3HIO7F3JSCOJ9zK1/Kr0VfRh6hc45a2uGyB2oVehqnUOS0Y0BoDQ
         T6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788990682; x=1789595482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7p9WWZeWPUSCEcOXg2XJofz7nmB+pP1oglnGvljEvQ=;
        b=OGvQBgpN/LpmMss6RiDjAxEqWEKct41aejCwIF27bqTWjHz8bchm4Z5pm9ePkBJnBz
         LwI8kfp0d0+TcusBmqUGqhXo6wmNuSpHKI0gT+lS/50jChL3qlDqHWZ7FAX7dXXuGUXD
         egz2RO6COL88dxtZIQLrOdFifO+ob18FxVcw1mnDJckAQfKEFpAPZ2Tepvwfk9g4to6V
         OYcPiNQnqGPGqgU7rtf8iKYAcQh44g4EXkuNCaRM6mt41ZWJDmZ+FhLxwTV9kXck1pHv
         ODl2sc3PrfKhRYx7A3I96itzNg5TYnPr1GRg/ovbUE3MkYPAMPtRXtzj8NL6VKVGFwgk
         clag==
X-Forwarded-Encrypted: i=1; AKwUvBww0+Beqt3JO3geWCrvxWW2+z3HZ7DZs3AnKSCVnIjMvi3Neg8Cs7UIZK3qH4C+ULvWl17QhLZ+IPW8GAOZ@vger.kernel.org
X-Gm-Message-State: AFuF++m58dDVJeHACgyscJIrAyRERjOJjaexoVX+C1rHQdeIpMqQjpNp
	3aF4yVwMfm+z3BStTId3xsJhX6B8u7s6g8ZiE1EDZJXBd/ihZ0T9gLfTcj2/4meR1Zg4NxSvqH5
	CH36W48SBNTkCUeZT/G4jlM30VWTGk/Y7mNBIa4oJ
X-Gm-Gg: AYBFou150csFzXmQsO5pDZVcIKGIs4uewJlQyLwLZ7EklhuykatQJf/MJXqfWwpG7zP
	hsk0/wJ9iYXXwZ97Q/9MSEUpjnH8P2kwQEoIuv1La6XcvV8tdgyoEfZ/Ymy7jwZ+jgwuSi4woAl
	DZbwk1SpPIQj86n0mkBLAnohXpuQvrY5pbiLS0QE7Ov5lDkAwELF2vchzPKdCOKIaYqe4/q5oSW
	auTjNpW6m2Q7MAxI80BrY5dyo98dlHA6eMN4z6x3mt1WG7Yw0y47xSQHMajyd3yr5M/cxn4pvwJ
	g42w0A1Wbiyq0lJAGrvNsovbWxR3KssRNC7q8LSIXcYlH7rg9AKGn9pjgg==
X-Received: by 2002:ac8:7f81:0:b0:52e:1e8:21f4 with SMTP id
 d75a77b69052e-530b62adb08mr929301cf.5.1788990680995; Wed, 09 Sep 2026
 14:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260907063918.3432401-4-surenb@google.com>
 <4825a2fe-f064-45d7-a7c9-e98de7efe86c@kernel.org> <CAJuCfpFL_g7tELjT8p8ExM3tX_v2gNDM9rRKwwefPV_KW=fHfA@mail.gmail.com>
 <8e643f51-a47f-428e-9443-678326288fa6@kernel.org>
In-Reply-To: <8e643f51-a47f-428e-9443-678326288fa6@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Sep 2026 14:51:09 -0700
X-Gm-Features: AcwNN1WhVGNfB-pxrRcwKFTO2y3J4tLY_kHnkGoYanjTzogNBsN7pKUja62KieY
Message-ID: <CAJuCfpEYdj=u0wczKRrsB8uDkbSzPy+hrsCo9TW9-3J3r3p0xQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:16=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/9/26 20:28, Suren Baghdasaryan wrote:
> > On Wed, Sep 9, 2026 at 10:16=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 9/7/26 08:39, Suren Baghdasaryan wrote:
> >>> smap_gather_stats() interprets its start parameter to mean vma->vm_st=
art
> >>> when it's set to 0. Eliminate this special interpretation and pass
> >>> vma->vm_start explicitly when needed.
> >>>
> >>> Since smap_gather_stats() operates within a single VMA, we can replac=
e
> >>> walk_page_vma()/walk_page_range() calls with walk_page_range_vma()
> >>> which is simpler and also can be called while holding per-VMA lock.
> >>>
> >>> No functional change intended.
> >>>
> >>> Suggested by: Lorenzo Stoakes <ljs@kernel.org>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> ---
> >>>  fs/proc/task_mmu.c | 40 ++++++++++++++++++++++------------------
> >>>  1 file changed, 22 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >>> index 9908ba32f180..3351decd1172 100644
> >>> --- a/fs/proc/task_mmu.c
> >>> +++ b/fs/proc/task_mmu.c
> >>> @@ -1246,20 +1246,27 @@ get_smaps_shmem_walk_ops(struct proc_maps_pri=
vate *priv)
> >>>       return &smaps_shmem_walk_vma_lock_ops;
> >>>  }
> >>>
> >>> -/*
> >>> - * Gather mem stats from @vma with the indicated beginning
> >>> - * address @start, and keep them in @mss.
> >>> +/**
> >>> + * smap_gather_stats() - Gather mem stats from @vma.
> >>> + * @priv: proc maps private state.
> >>> + * @vma: The VMA to gather stats for.
> >>> + * @mss: The accumulated stats.
> >>> + * @start: The address from which to start.
> >>>   *
> >>> - * Use vm_start of @vma as the beginning address if @start is 0.
> >>> + * This gathers stats for the whole of the VMA unless the lock was d=
ropped
> >>> + * and VMA grew or got merged and we found it again, in which case w=
e only
> >>> + * gather stats for the remainder of the VMA range.
> >>>   */
> >>>  static void smap_gather_stats(struct proc_maps_private *priv,
> >>>                             struct vm_area_struct *vma,
> >>> -                           struct mem_size_stats *mss, unsigned long=
 start)
> >>> +                           struct mem_size_stats *mss,
> >>> +                           unsigned long start)
> >>>  {
> >>>       const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv);
> >>> +     const bool is_partial =3D start > vma->vm_start;
> >>>
> >>>       /* Invalid start */
> >>> -     if (start >=3D vma->vm_end)
> >>> +     if (start < vma->vm_start || start >=3D vma->vm_end)
> >>>               return;
> >>>
> >>>       if (vma =3D=3D get_gate_vma(priv->lock_ctx.mm))
> >>> @@ -1279,20 +1286,17 @@ static void smap_gather_stats(struct proc_map=
s_private *priv,
> >>>                * Unless we know that the shmem object (or the part ma=
pped by
> >>>                * our VMA) has no swapped out pages at all.
> >>>                */
> >>> -             unsigned long shmem_swapped =3D shmem_swap_usage(vma);
> >>> +             const unsigned long shmem_swapped =3D shmem_swap_usage(=
vma);
> >>> +             const bool shared_or_ro =3D vma_test(vma, VMA_SHARED_BI=
T) ||
> >>> +                                       !vma_test(vma, VMA_WRITE_BIT)=
;
> >>>
> >>> -             if (!start && (!shmem_swapped || (vma->vm_flags & VM_SH=
ARED) ||
> >>> -                                     !(vma->vm_flags & VM_WRITE))) {
> >>> +             if (!is_partial && (!shmem_swapped || shared_or_ro))
> >>>                       mss->swap +=3D shmem_swapped;
> >>> -             } else {
> >>> +             else
> >>>                       ops =3D get_smaps_shmem_walk_ops(priv);
> >>> -             }
> >>
> >> Horrible, horrible code, really. But not your fault :)
> >>
> >> I think we can just make the shared_or_ro less odd by just checking fo=
r cow
> >> mappings (as described in the comment).
> >>
> >>         const bool is_cow =3D vma_is_cow_mapping(vma);
> >>
> >> ...
> >>
> >>         if (is_partial || (shmem_swapped && is_cow))
> >>                 ops =3D get_smaps_shmem_walk_ops(priv);
> >>         else
> >>                 mss->swap +=3D shmem_swapped;
> >>
> >> That's almost in a form that I could understand what's happening.
> >
> > Hmm. So, are you saying that !is_cow always implies shared_or_ro? Or
> > maybe you are stating that vma_is_cow_mapping() was the actual intent
> > here?
>
> So the comment says:
>
> "For private writable mappings, we might have COW pages that  .."
>
> Which translates to:
>
>         private writable =3D=3D vma_is_cow_mapping()

Ok, just want to make sure I'm not missing something subtle.

>
> >
> > shared_or_ro =3D VMA_SHARED_BIT || !VMA_WRITE_BIT
> >
> > is_cow =3D !VMA_SHARED_BIT && VMA_MAYWRITE_BIT
> > !is_cow =3D VMA_SHARED_BIT || !VMA_MAYWRITE_BIT
> >
> > so, !is_cow would impy shared_or_ro only if !VMA_MAYWRITE_BIT always
> > implies !VMA_WRITE_BIT. But I think it's possible to have a VMA that
> > has VMA_WRITE_BIT but not VMA_MAYWRITE_BIT, right?
>
> VMA_WRITE should imply VMA_MAYWRITE

Ah, good to know.

>
> (in sanitize_fault_flags() we even disallow write faults entirely if VM_M=
AYWRITE
> is missing)

I see.

>
> For example, a
> > driver can create such a VMA to allow writing to the VMA but to lock
> > its content once mprotect(PROT_READ) gets called.
>
> I don't think that would be valid for a driver to do. But it wouldn't mat=
ter
> here because
>
>         shmem_mapping(vma->vm_file->f_mapping)

I was obviously overthinking this :)

>
>
> I think we could simplify the comment as well to:
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e671b4fd8dedd..4b7e7089cafa7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1303,12 +1303,10 @@ static void smap_gather_stats(struct proc_maps_pr=
ivate
> *priv,if (is_partial || (shmem_swapped && is_cow))
>
>         if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
>                 /*
> -                * For shared or readonly shmem mappings we know that all
> -                * swapped out pages belong to the shmem object, and we c=
an
> -                * obtain the swap value much more efficiently. For priva=
te
> -                * writable mappings, we might have COW pages that are
> -                * not affected by the parent swapped out pages of the sh=
mem
> -                * object, so we have to distinguish them during the page=
 walk.
> +                * In CoW mappings, we might have anon folios that are
> +                * independent of the shmem object. So fallback to the le=
ss
> +                * efficient mechanism in such mappings.
> +                *

Sounds good. Will update.

>                  * Unless we know that the shmem object (or the part mapp=
ed by
>                  * our VMA) has no swapped out pages at all.
>                  */
>
> --
> Cheers,
>
> David
