Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC838E8A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148356; cv=pass; b=bBOjws+9f6F4UPxzU+yg/Hs8XmVdEpBh6oSwCcA8BaKeXRAS0J0XoWXR4L8Ie5PU42SiQW8lrG2uf5/gGBqjer9siV1IfArSp4uJvU9XKqgtbSjcUMDz3B0MyL3bBDqFPiQBzg6RnEXcN075t97CDLU1THLaYhe4ZQl0O67KLcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148356; c=relaxed/simple;
	bh=KCGYW2GHPcvrqVDEgpPBD0E79LfvQTj6L1Ekmrlsn2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jj6+8OfWe1NNHCVz6+yJUM9rgQgFyncnV/442l1Ghb9r51NTt8Ne5Wkd4Qk8V1q3UgX34N0zeaR8/Hr5YhQnKHQ6+ZUzqpEGCtikriTYwE3+NhWKBaPaduHEErvX9BEArkKdH5jJGX3f2whS4c5/3vrd/QT//oQgob0nZwqW5oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohbAC5S0; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohbAC5S0"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5306706e89dso70461cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 10:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789148354; cv=none;
        d=google.com; s=arc-20260327;
        b=FBW4Ts8z0uL/DLrz8MydWY/4o/h4/J8q8j+td8IrxWM/DI22FVDMBrz7HWRXU+Gipy
         zEi6s7i1xbj6D46RCo0AeGRioQkgwuAXpHec+Oa3cidB91i/f5wT8oHxj7SqrIo0wma9
         sA4jxbxmf5cKs5w9nzO4H2qw+55qf49ceA3EX0fUCrZdPziaFjaeaZKvzK/nrBd4zZ3h
         Cgz6kaxgsgOUtfYqNbIadRs91BJ3lEBLwrh476M1QekzvC2wDxxPMeVjvzO3Jb6Oj+qH
         CCQLp3Edw4m0viDBt9dgL7pdxIAOI+ahnXSu8mVUROxqajoPA8NOVs6dKSHfDkz+1K/k
         nh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lDyI28LyXxLbVi5W3K5kzQ8tDJnYvbGU2xd2J7fxK38=;
        fh=imoWGiB1cJSduhKtHmoWZVv5Jz6KFrlLQWFB8Qw+vWM=;
        b=ULDdDaG038ZM87w3oUTCp3+zk09AMO0wdDGPnK8U66K2OJgACEBfy3ikAvAif7qvbm
         pzbpDQS0K8d8b/dPhk9sr1YpyRzuFcPEqJz/CjWAt4tcSwvO9g/uNwg7NKZZNCvVcWQn
         x2cCjfxSt3KinuvXznA5KQsELDaZfNq/VW0WPsAC4nXMtkn7VqoiJs9hCTD2/ZcvCbIK
         0BDR3jQGlC/Z0n050s/Qt+4RgrTd7x9vzf6NKDeUp7iD8db8axo5lvjzERPdUaIhRKEW
         aRXuxENwgT0hyx5l4BVFljBFACiKudTSQk/5KizLc3cn/ydPT7CSPc3r+6fVcFXbQ7Hl
         Tc5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789148354; x=1789753154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lDyI28LyXxLbVi5W3K5kzQ8tDJnYvbGU2xd2J7fxK38=;
        b=ohbAC5S0IRU7GYjLjGakM+p8ffXNgFi7QbpxYv47VuhDAAcUzr3SJStPvJoWrPnBSK
         7d8OGu3WNwhw1UNCJ06fzBHaz+f+wMjB7CJ+iEuddhbaurPpG/y1mWLrTEETRq5nE8lU
         koVUsGloU1f7t5SMBO83m5L8hcfv+r6/b1fwBOW9sCyVKmY5IvtNvJFCG716AiemP3Yy
         xl8G9Q/xYPdfAsb/AAvb2iR7ovonz7EYdKBVL4s7HoOBmaUHTjFl44JmLTCMjPh/Xj3o
         JKf/cFDTaDl/lUr3FZ8v/QmGXY03T47ItjDspb8Y5nFdSxvtuTrAoBGoI65Hq74rBBi7
         YoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789148354; x=1789753154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lDyI28LyXxLbVi5W3K5kzQ8tDJnYvbGU2xd2J7fxK38=;
        b=o1lDcS2e+tCrO8xooB5nIriabRcwJ46dxX44q/8KaFcAn72CNlh1R/mvTh7TTp2bmi
         ibpd1nIPgMqBqpgeCIVkZJBEIFA/2QfkpTmkUqe+Zi6dwaVJ1eIty581Qb7CxT1qskfK
         s16dVeAeshoLiodVXGL+Aosp9ZAegb4UV8Kh7HzMmTkVkYviKn1VANJJ4oZ3Iz3eza6b
         zXsncjPzjSMTCJjKXyvyZX3poKJH4wVveQVITTz7IkCR5u8CeobmHh6U8iaFe4XY9Ooi
         fG7xFqQk5p5xC+CFNOfP9jpXOxIrab3TjwxoKl5vHLIP0T6gViiy1NaQFyik+V6cNOHb
         IRDg==
X-Forwarded-Encrypted: i=1; AKwUvBxWbIfPRuo9Y9WBplp8O2prBM208ti+PAuNFtjZPJcArF4bbb2oDwpd6YOyiK23Bvp4tEExgkPTiJp1MWyj@vger.kernel.org
X-Gm-Message-State: AFuF++nsP/Z3nmlq1rXUh7ph/RB3JKjYImP81AqGu43xmrFg5dRZgpa0
	H/rhgT3MLDK0tWJMOWqp1jtvjJ9t1PxigU8HD+r/q9RCdG/GjoIaQZ3ZyLMjCzEbeCvSKzyb1uF
	vGDWrGquzhrPoeJ4KPLo4fJJDR+KedF9p6rB/p4hm
X-Gm-Gg: AYBFou3iBDwxVzYoofk/TngcvA4feVSEqh2VhwxmDH41937q1q8XcY0snyP7/u7tbUC
	eR9vlNpZz/T0wLtQ6rAuJ2Gj+rruIcmKxm9q/6fSm7KKLwrCf2MBWLwIzOd4bl6piZwO39u+eDP
	JTof7maaqIpl4BAC4I1ygQO+iSmcNKzNX8GGF+g7RBByGtMW7GsU9Lh/fD14pz2b4mdS1cwROqI
	DhMzZ9VHtPxjXoN+ZTsP/km/MdKu2I8zlx/DYXbM00WEmRsuWGJhk/vmxQs3cFUnQ+Xe081xljL
	o0aoVKZMKK2QzYo1woEv2uKbLWRnAlrHqIfyMLJNyNMghfmBVTbdeA==
X-Received: by 2002:a05:622a:124e:b0:530:d8ce:c26f with SMTP id
 d75a77b69052e-530e46f45camr675921cf.6.1789148352915; Fri, 11 Sep 2026
 10:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-4-surenb@google.com>
 <aqQoPTTUC9M5HkYb@gremlin> <CAJuCfpEHeFSMamNhf=FLvFjh9D8DBwZtbKwL0zi=x-2g8B+ENw@mail.gmail.com>
 <aqQzk2AT05r6rOyT@gremlin>
In-Reply-To: <aqQzk2AT05r6rOyT@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 10:39:01 -0700
X-Gm-Features: AcwNN1XkyBoM4HG4ag-rjvAtmsYry_LOY1Kt-_sjnaCPmrsfivCEhhSHxjviJXs
Message-ID: <CAJuCfpEMd=hVtwe_9Rp1kqigYJwqEUGCD+ViQmoacAZONCR6DA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] proc/task_mmu: clarify shmem mapping walk
 conditions in smap_gather_stats()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:10=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Fri, Sep 11, 2026 at 04:58:40PM +0000, Suren Baghdasaryan wrote:
> > On Fri, Sep 11, 2026 at 4:28=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > >
> > > On Thu, Sep 10, 2026 at 04:47:33PM -0700, Suren Baghdasaryan wrote:
> > > > smap_gather_stats() optimizes stats gathering by skipping the walk =
for
> > > > shmem mappings in certain conditions. Update the comment to clarify
> > > > these conditions and use vma_is_cow_mapping() for COW identificatio=
n
> > > > instead of open-coding it.
> > > > Instead of using (start !=3D 0) condition to identify partial walks=
, use
> > > > more semantically correct (start > vma->vm_start) check.
> > >
> > > I don't agree what you're doing is semantically correct, it's a hack =
really.
> > >
> > > Callers are passing start=3D0 to indicate that the entire VMA should =
be
> > > processed and that happens to fulfil your criteria but in a surprisin=
g way.
> > >
> > > And the start in these cases is corrupted.
> >
> > Well, the "other" Lorenzo does not agree with you and suggested this
> > approach in [1]. Specifically, see the comment:
> > ```
> > I also don't love that 0 is taken to be 'start from vma->vm_start' and =
I
> > also don't love that the code in smap_gather_stats() actually special c=
ases
> > this...
>
> I'm not sure what part of this is disagreement?
>
> It's saying passing 0 is a hack, which is one that is still in place and =
which
> this patch makes worse, because instead of explicitly calling out the inv=
alid
> value, you're treating it as if it were valid.
>
> >
> > How about passing last_vma_end and making smap_gather_stats() more sane=
? In
> > the other invocation of smap_gather_stats() we could pass vma->vm_start
> > here.
>
> Yup, well me of 3 months ago should have suggested what I suggested re: w=
rapper
> (I think you cut that suggestion out of my reply).
>
> > ```
> >
> > [1] https://lore.kernel.org/all/aifO_rCurVhFRTcl@lucifer/
>
> >
> > >
> > > >
> > > > No functional change intended.
> > > >
> > > > Suggested by: David Hildenbrand (Arm) <david@kernel.org>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  fs/proc/task_mmu.c | 24 ++++++++++--------------
> > > >  1 file changed, 10 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index cfc7af1b551d..3c40c9cbb9c9 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -1257,6 +1257,7 @@ static void smap_gather_stats(struct proc_map=
s_private *priv,
> > > >                             struct mem_size_stats *mss, unsigned lo=
ng start)
> > > >  {
> > > >       const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv);
> > > > +     const bool is_partial =3D start > vma->vm_start;
> > >
> > > Yeah not in love with this, without changing how it's called.
> >
> > See [1]. This is exactly how you wrote it at the end of that reply.
>
> Assuming you passed vma->vm_start, not 0? Passing 0 makes it really stran=
ge.

Ah! Now I see the problem you are pointing out. Ok, in v2 [2] this was
done correctly and that's the way you want it!
Okay, I agree this split was incorrect. I think I'll move is_partial
conversion completely into the next patch and this one will only
update the comment and use vma_is_cow_mapping() instead of open-coding
it.

[2] https://lore.kernel.org/all/20260907063918.3432401-4-surenb@google.com/

>
> I see that in the patch I suggested I didn't update the other callers lik=
e I
> said you should in the reply, my bad from 3 months ago, but I don't think=
 that
> invalidates what's been raised here.
>
> >
> > >
> > > If you're reworking it all already, the actually semantically correct=
 thing
> > > I think would be to do something like:
> > >
> > > static void smap_gather_stats_range(struct proc_maps_private *priv,
> > >                 struct vm_area_struct *vma, struct mem_size_stats *ms=
s,
> > >                 unsigned long start)
> > > {
> > >         ...
> > > }
> > >
> > > Then to drop a parameter in smap_gather_stats() like:
> > >
> > > static void smap_gather_stats_range(struct proc_maps_private *priv,
> > >                 struct vm_area_struct *vma, struct mem_size_stats *ms=
s)
> > > {
> > >         smap_gather_stats_range(priv, vma, mss, vma->vm_start);
> > > }
> > >
> > > And then you remove the hack and make is_partial not be accidentally =
true for an
> > > invalid start parameter.
> > >
> > > >
> > > >       /* Invalid start */
> > > >       if (start >=3D vma->vm_end)
> > > > @@ -1270,23 +1271,18 @@ static void smap_gather_stats(struct proc_m=
aps_private *priv,
> > > >
> > > >       if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
> > > >               /*
> > > > -              * For shared or readonly shmem mappings we know that=
 all
> > > > -              * swapped out pages belong to the shmem object, and =
we can
> > > > -              * obtain the swap value much more efficiently. For p=
rivate
> > > > -              * writable mappings, we might have COW pages that ar=
e
> > > > -              * not affected by the parent swapped out pages of th=
e shmem
> > > > -              * object, so we have to distinguish them during the =
page walk.
> > > > -              * Unless we know that the shmem object (or the part =
mapped by
> > > > -              * our VMA) has no swapped out pages at all.
> > > > +              * CoW mappings might map anon folios that do not bel=
ong to
> > > > +              * shmem. Perform a less efficient page table walk in=
 this
> > > > +              * situation, unless we know that the shmem object (o=
r the
> > > > +              * part mapped by our VMA) has no swapped out pages a=
t all.
> > > >                */
> > > > -             unsigned long shmem_swapped =3D shmem_swap_usage(vma)=
;
> > > > +             const unsigned long shmem_swapped =3D shmem_swap_usag=
e(vma);
> > > > +             const bool is_cow =3D vma_is_cow_mapping(vma);
> > >
> > > Nice to see this helper naturally slot in to new stuff :)
> > >
> > > >
> > > > -             if (!start && (!shmem_swapped || (vma->vm_flags & VM_=
SHARED) ||
> > > > -                                     !(vma->vm_flags & VM_WRITE)))=
 {
> > > > -                     mss->swap +=3D shmem_swapped;
> > > > -             } else {
> > > > +             if (is_partial || (shmem_swapped && is_cow))
> > > >                       ops =3D get_smaps_shmem_walk_ops(priv);
> > > > -             }
> > > > +             else
> > > > +                     mss->swap +=3D shmem_swapped;
> > > >       }
> > > >
> > > >       if (!start)
> > >
> > > Also not absolutely in love with the fact you only use is_partial abo=
ve and
> > > leave:
> > >
> > >         if (!start)
> > >                 walk_page_vma(vma, ops, mss);
> > >         else
> > >                 walk_page_range(vma->vm_mm, start, vma->vm_end, ops, =
mss);
> > >
> > > As-is.
> > >
> > > Should be:
> > >
> > >         if (is_partial)
> > >                 walk_page_range(vma->vm_mm, start, vma->vm_end, ops, =
mss);
> > >         else
> > >                 walk_page_vma(vma, ops, mss);
> >
> > True, that can be changed here too. This whole block is replaced in
> > the next patch though.
>
> Yep I think that should be squashed into this one, as I say there.
>
> >
> > >
> > > But I also wonder whether, with start not being corrupted (!) you cou=
ld
> > > just replace this with:
> > >
> > >         walk_page_range_vma(vma, start, vma->vm_end, ops, mss);
> >
> > Yep, that's done in the very next patch.
>
> As above.
>
> >
> > >
> > > Looking at the pagewalk.c implementations I don't know why
> > > walk_page_range_vma() doesn't just forward [vma->vm_start, vma->vm_en=
d) to
> > > walk_page_range_vma()... but that's another thing :)
> > >
> > > > --
> > > > 2.55.0.1007.g17ff1f9808-goog
> > > >
> > >
> > > --
> > > Cheers, Lorenzo
>
> --
> Cheers, Lorenzo
