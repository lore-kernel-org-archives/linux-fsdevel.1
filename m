Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81A33A9E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150134; cv=pass; b=jloSihkHHeXOLCQWuNmj0DxM1hYE9LFEwwKLKGh9dTJIn4/J69iPNVhi1hkKCEpv9KzsO8/MnOX2glBGvH4iYbdykb2gQeg6SWXqt0XSkXf3ekSOa5sHZZi78+UeqqOLCjvQGcepRlyXGJkStGpDAlpTTkAwnCDS4nThX9xITc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150134; c=relaxed/simple;
	bh=esaZDH15yD25FQT2YqEEZjt4AYj47K/MD2LJEILFV5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2MMMU2YORaZlUu/yg6V/FCz9W9C6Lkyg3iJ1q8dcq06ygzX2ohuhBrr/5n5F2Ci2+xIo/pNPv3SiRYLG/WR0tcDBn/09EGK0nOMfURL+4BkBuBDMHnGkmC5PvKYIp8tDsMVRn67PoxDa7FIv+nnnFj8ZPtjI++UHcbHH+I7smA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wjuhqj08; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wjuhqj08"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so84531cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 11:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150131; cv=none;
        d=google.com; s=arc-20260327;
        b=QMbgE0o3dGebwGeG3SajcYN/WV6dcPOWeORhqTaDSXCf8TmZI9Ps88Nn1ZHM9F3m4B
         XqBA0Gjz+y5QG2z/U+a51RGVTbqWkgKqOjZ6qJOtlAMIrctXqO6/nKf9Za4S7/lGodIa
         Sl8EVv4gjT1Je/YaYsqGUDtRtw3docvZHR1QYSx5nFLl67DnrdlaSlMfhwoW7OorptEi
         /nypX+OM4cftypW6NS9Arf7Ip1WEaJ1mSz4zfyaavIpJyawaMohyiiyU7K/txYx9rtuq
         HOdzbeBpiod3NfiTbesOEQ5oUM+a43jHTpmm0WzxIbJPSRF/gKj/a+F6ilTcbaNsW4og
         Hwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G3lYyGqHKOjMfd0nQzQBuRt7mmmFYg8CXav6CCXPIUY=;
        fh=DtPGlilZm6tJlarhodNMcCBxdJWr1Jp7omRCxymKOec=;
        b=QsiBb1FCQEVS4PtEq2xWKw+u68T1pI+e7aV6a5W8nn0ODDFMutv5K7SKc7JzPf9bk8
         OALk6yCbmMbNofbL0OxMycBhPsyTW2LejIyW7GnBvpx1wBRbYBsw5iwkS5SYBDptHUpW
         z/ERqBiQct09D0iKseamgjJlYFHghJ6hEsYYGOCpEoOl5Ln37UrKvrVyJ28AYScBlCL0
         5RPd3wDAUX5U4J65QTmLEvCiyrcIrtIuGiK12pux+ApTiW+w0VFnukiBMVOT7ct3fsmq
         /S11YrVXgoUcH9V3MsdbGLN57I54O7Po13IOZxl4b2pPxFP20bM8gCWrjHqm0kHAuzoH
         9Jqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789150131; x=1789754931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G3lYyGqHKOjMfd0nQzQBuRt7mmmFYg8CXav6CCXPIUY=;
        b=Wjuhqj088LkulcllFptD69DgPsx+jaZoBXNHsoz1MuxY+bclW6d6apTBsR9vUu6pcO
         fIjWaVMtPvC9DBCI2+s3LyY3Ufz1PxEt+s1MFYpxHMtjUKp+JhQAJl9OowZWIs7FnPLA
         uzrxf0a9RynwEyk+tpsLCpF07wszkBAN/9tziyZaj6gmFvZOHd2buXjIA7Ftg8mmbOPt
         aRCklfdWWw4unyVhlaq1pyn3Pxzsdg6XU1MRs4to+rXHvHJ/DbYFZCcdzFN8AXPbhZqz
         JXjral68lISAw+4PoHzwuN+Wq63QIWUpSzSvlFsMJuxlPFP4bhgwfKzyyIIMpPlTxvph
         0grA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150131; x=1789754931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G3lYyGqHKOjMfd0nQzQBuRt7mmmFYg8CXav6CCXPIUY=;
        b=i8ysocDfVa1HInTpAxJK62AVQuDek1oYi1G0eOD8ZXifUvW41Kf+PlGxW8saeW/YsN
         hwdigVSW9CPzGwa2JBZjEm/bcYKe5/yVAfUnpPcc3X0x/IRrseatSq9nHAMCalH6aanS
         pJJkPBWh6sZuSVEuSjycAluIvqQR5ntlgAIbW+JFu7uwwNeHUuV7LPUr136dDA/8eTD0
         7kSsmh/CDfhQ1he1/gkA3i34lCiSmreFMTQ6aoOclwBJ1b0R9P2p7JK553owOWIDV7Ur
         2K7uFp/K3RuiA7I1/zZF5u+gvVyjXpGKd+XYB3Q/SvPTxGcbwqG3cZ6Pyo2Gz8LST5bt
         n3uQ==
X-Forwarded-Encrypted: i=1; AKwUvBwH1zNNCD28+H7glXsR+hjSktKZr2R+ATTYqJ8tMkrVY2e5MIVJTJf4zeCI4uxABc5OzRPahb5/KHtXe2ac@vger.kernel.org
X-Gm-Message-State: AFuF++kw5wRtCfC3voS73L8hGxcABiTfr9cc9X4zshtqVo9FgK4gqHDM
	SgAtJyaV3uaOkTLRjEa3rk8Eb9UTO1rNl/opEUbCLKOMLkxcBGk+7fnz5dSrkyt09q8tUr/4Sx6
	PWLYfWoXD1q5XlZ9x4iLrPsr3bAgHLUvg/duD0sVq
X-Gm-Gg: AYBFou2LcLpwpYtfpWAzSx54JWnp8xx8Ls6ls37+7TkhKECXlPFenn0p4KxIIYwJP2E
	u0z9RLq5kFLQ5X4sxs2nOy8A2323Otx+EQhPZaQCQJbPl/IjKzwHAem5fckudqC3s8j30tFKdme
	K8L/9u0s0c6r3tMDsvuWO/+BIUXbukGrQpyohgtsILWrogQUwfjmyclzTk1O81CARCvLv1QwZJS
	lZSfmAJ31L+43bsou3scZ1EDMJpw/4Vn2ZDMOhT+fENPndm6MF3CXxsdG5xPsiy2oGfTuKTDC6R
	TBJ/JHyuSueSaPs8mg8pvOfD4UWNCplXyYd51AhYHhYmhXW8izyu8WMZOgaPS08p6kagPY1oCnq
	+owzZX5Tq4Q==
X-Received: by 2002:a05:622a:124e:b0:530:d8ce:c26f with SMTP id
 d75a77b69052e-530e46f45camr1234961cf.6.1789150125329; Fri, 11 Sep 2026
 11:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-4-surenb@google.com>
 <aqQoPTTUC9M5HkYb@gremlin> <CAJuCfpEHeFSMamNhf=FLvFjh9D8DBwZtbKwL0zi=x-2g8B+ENw@mail.gmail.com>
 <aqQzk2AT05r6rOyT@gremlin> <CAJuCfpEMd=hVtwe_9Rp1kqigYJwqEUGCD+ViQmoacAZONCR6DA@mail.gmail.com>
 <aqQ_cPerswqY9ZPL@gremlin>
In-Reply-To: <aqQ_cPerswqY9ZPL@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 11:08:33 -0700
X-Gm-Features: AcwNN1XgFF_qGTm7m9tvRDVhYFWJVU8m1f8OKlmITfXyXo13YNbSPwvOnx3S2VE
Message-ID: <CAJuCfpHzjvd6wKT9XN5BUSWnrGHhcaPVOyr1rb0bJ-fetkKhvw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] proc/task_mmu: clarify shmem mapping walk
 conditions in smap_gather_stats()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:56=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Fri, Sep 11, 2026 at 10:39:01AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Sep 11, 2026 at 10:10=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@ker=
nel.org> wrote:
> > >
> > > On Fri, Sep 11, 2026 at 04:58:40PM +0000, Suren Baghdasaryan wrote:
> > > > On Fri, Sep 11, 2026 at 4:28=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@=
kernel.org> wrote:
> > > > >
> > > > > On Thu, Sep 10, 2026 at 04:47:33PM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > smap_gather_stats() optimizes stats gathering by skipping the w=
alk for
> > > > > > shmem mappings in certain conditions. Update the comment to cla=
rify
> > > > > > these conditions and use vma_is_cow_mapping() for COW identific=
ation
> > > > > > instead of open-coding it.
> > > > > > Instead of using (start !=3D 0) condition to identify partial w=
alks, use
> > > > > > more semantically correct (start > vma->vm_start) check.
> > > > >
> > > > > I don't agree what you're doing is semantically correct, it's a h=
ack really.
> > > > >
> > > > > Callers are passing start=3D0 to indicate that the entire VMA sho=
uld be
> > > > > processed and that happens to fulfil your criteria but in a surpr=
ising way.
> > > > >
> > > > > And the start in these cases is corrupted.
> > > >
> > > > Well, the "other" Lorenzo does not agree with you and suggested thi=
s
> > > > approach in [1]. Specifically, see the comment:
> > > > ```
> > > > I also don't love that 0 is taken to be 'start from vma->vm_start' =
and I
> > > > also don't love that the code in smap_gather_stats() actually speci=
al cases
> > > > this...
> > >
> > > I'm not sure what part of this is disagreement?
> > >
> > > It's saying passing 0 is a hack, which is one that is still in place =
and which
> > > this patch makes worse, because instead of explicitly calling out the=
 invalid
> > > value, you're treating it as if it were valid.
> > >
> > > >
> > > > How about passing last_vma_end and making smap_gather_stats() more =
sane? In
> > > > the other invocation of smap_gather_stats() we could pass vma->vm_s=
tart
> > > > here.
> > >
> > > Yup, well me of 3 months ago should have suggested what I suggested r=
e: wrapper
> > > (I think you cut that suggestion out of my reply).
> > >
> > > > ```
> > > >
> > > > [1] https://lore.kernel.org/all/aifO_rCurVhFRTcl@lucifer/
> > >
> > > >
> > > > >
> > > > > >
> > > > > > No functional change intended.
> > > > > >
> > > > > > Suggested by: David Hildenbrand (Arm) <david@kernel.org>
> > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > ---
> > > > > >  fs/proc/task_mmu.c | 24 ++++++++++--------------
> > > > > >  1 file changed, 10 insertions(+), 14 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > > index cfc7af1b551d..3c40c9cbb9c9 100644
> > > > > > --- a/fs/proc/task_mmu.c
> > > > > > +++ b/fs/proc/task_mmu.c
> > > > > > @@ -1257,6 +1257,7 @@ static void smap_gather_stats(struct proc=
_maps_private *priv,
> > > > > >                             struct mem_size_stats *mss, unsigne=
d long start)
> > > > > >  {
> > > > > >       const struct mm_walk_ops *ops =3D get_smaps_walk_ops(priv=
);
> > > > > > +     const bool is_partial =3D start > vma->vm_start;
> > > > >
> > > > > Yeah not in love with this, without changing how it's called.
> > > >
> > > > See [1]. This is exactly how you wrote it at the end of that reply.
> > >
> > > Assuming you passed vma->vm_start, not 0? Passing 0 makes it really s=
trange.
> >
> > Ah! Now I see the problem you are pointing out. Ok, in v2 [2] this was
> > done correctly and that's the way you want it!
> > Okay, I agree this split was incorrect. I think I'll move is_partial
> > conversion completely into the next patch and this one will only
> > update the comment and use vma_is_cow_mapping() instead of open-coding
> > it.
>
> OK, it probably makes sense to have the CoW change separate.
>
> I replied on 4/7 about how I think that should look re: wrapper functions=
.

Yep, refactoring the patchset as we speak. Should be ready shortly. Thanks!

>
> >
> > [2] https://lore.kernel.org/all/20260907063918.3432401-4-surenb@google.=
com/
>
> --
> Cheers, Lorenzo
