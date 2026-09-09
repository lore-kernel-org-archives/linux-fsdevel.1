Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D658038F
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970397; cv=pass; b=USZL4TM+M7/dJ1uF3xq3asOr4SO9HTNPsx+/b7We7Rv9aTWGYgbK4+m41oe4WANsUfC/PLXXf4Mf54HFESOP/epc3cR/5UiioZ1CbxcwTIGjGzD2+dfW3G7nrZU4KliE2rRB2Q1v9IOwdINkQhnDxRBdO0F/SjE9+R9folfhLTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970397; c=relaxed/simple;
	bh=eGM+GcDm+h33uYIvPf3aPJ4b0Y/RD1lFUWWptJ7tq9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imYiY1IJAS/IHG+bY/5PC8BcHR4x5eWYfLYneN7K17zzJqMPHwBQJowxnWGbmJ7jDUYREwyiUZCrWtmsYmbbxVuJf575MAVTAfyqNydJIvOR77m6pQlP6s4tGrFRpnzIj9Fp8qzDTPgvHvPk4iy9xmTKe8RgcI5H90c2JcmoaW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZCeX7tFI; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCeX7tFI"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so262551cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 09:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788970394; cv=none;
        d=google.com; s=arc-20260327;
        b=UQlXjBUyMn/2zEukR7Kz0uYfqg62yFqG4RRhG+9NEKEJeTjlm9JqRXzwLwcHYa1e/I
         cUwAiv+Zzm0K2IeESIWNvkAkonCwa4c66MVKA6w2xf0HzBnekxSzT0oEa8m9bjj8tKhg
         eadfQ/hhLDGmIdGy9oS5KEjo09BCxF2v4SnHk1L+e4KwdrdvG9YG1xrlFCGOTSCdXYvJ
         w/18i17PvRdSxzAD8mx67B6giE/7H7yEGLCoYCtZWGejfrAFq2HdDfGlxR1esIgHJTZh
         ivlophKEUCzO0Xve8KE6RBBL1lVZf4DwchdWPG5BBa1y6Kcj5dyHdIdh/9j/DBD87dUV
         mVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XwFK4mYyCKUvttrF+B6WpML2yr4ZZ0VuePy6xRS9Uvc=;
        fh=/5OtHorj5+Ra5u7vJN2YJe1TUpTrWJVdqa/7I/MdJP4=;
        b=KoR4enypvbuwVQ1LeI/XgaepCO0GLPWlWNhSc8O4/ge2YyZdbRV8ayJ6eh+cd3hxLz
         OanaAFDey4ATb1LJz8GYxju8+cRo3SR1TsPEbR4QD9ocaElXlv2i9jF1ozg+kDTqDigA
         z+cmIY7UdZMugecU82aVuqt/zYz+IzoFnNGtyOYKDujVfvfzRb7DlCa5gwQbc3oYFw+F
         UEukw8+1LmHYdSRApzG6pPY0QAWOiP8mAPHqsUJWgSGiO9SGjJJmtNNhi/D8Zao4177d
         NHtOuBX3fLiZjCelxNZKXht8mtvHrXchdAvMhIR6kBnnN3whmjw/vRje7jRMxbwBhVNK
         mBTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788970394; x=1789575194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XwFK4mYyCKUvttrF+B6WpML2yr4ZZ0VuePy6xRS9Uvc=;
        b=ZCeX7tFIJcH0+2i95Tdc3wxyPmE2vtadlYA3C8khwxJmpCwtCgxMuMw4bCnqif1aa2
         7/hStc2sf6FgDT1eO/ehlEbltecLrlGdzb9Gz0QNqft317pGIia/PwR27slI0LwJ6sl7
         VQ4j8qGN/ySiVcGF0PQUB2SUKQ5R5tFGEWqGeceMloSCNzNbAPmXmiZS1xVoyZESGtOO
         vUN1rlHNZ4SPxSMaIew/jIzGwAAkvZAOwR0X6DexDC11a01ytdEerjixl+v/g355bPrW
         fFD90PLCWMV2qhmeHwPg5Hpk419kpKqMV8+m+IKOa70Jw0fOFEAYjF2o/EeNY2+CPoe/
         VaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788970394; x=1789575194;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XwFK4mYyCKUvttrF+B6WpML2yr4ZZ0VuePy6xRS9Uvc=;
        b=d1gQ6wuB6O5aXjQhBjLCHoyVyuzDA/eAPLHQVXkDGO0JYpidn9ytpl8O2qTL96bVO3
         eVW/Drtvf1OPZXLXRp+bLFq2lOSRElrwxCqet1QH+n3VLPkcDy6ytok8TCRs73FCWBkj
         y6AjjsEFB3VX1XYrDTjzgV32+9WkmWt70a0rP3VsFx0+l34jNKMJTBpqHGWkllps4DZD
         DQ9cmkYkPn49OisN09AXx9yhHSZish96mhwuDQaIHWIBGb5SUMWcxp0WXt7y9KR+Vi4b
         XcL9NCKGJqc00kKPESEaNg+XCQyplb61bHXAp0MHCqkGaLs4S/Wo361y6yzF+wWGvWSD
         T3eA==
X-Forwarded-Encrypted: i=1; AKwUvBxTuVt73fH5mDUn346tlmjtj2K9kYKsrlEshd5QHxJqCciQ2iSc/AwSJ1Uudhe5GzngJm+aUl5DARWf6HzS@vger.kernel.org
X-Gm-Message-State: AFuF++mUbFIKIbXZZlKd4rif0/R9x2jAcjeOARfX9DvYlV0aAddHlaMQ
	gfEhTx9A7xR1Q90MrlqQ7JjHOR9ciDnj7TWVoEZmWvSW/SidTcQ3rcrwYCkBsu3sgkD+52I7QOD
	5XfMq7jBkVfv6qA/UlDaY14B2VHFiMw+e23P9S6Sp
X-Gm-Gg: AYBFou35ElaOPwnDc5Hs8OxPGoDcLY0PQOad0FmGOEtiGDREvOsQI5GAbjq5k0055Gi
	0+VG/YoYv83lvP1slZQ9yTyTO0bbii6jo8SZCxXVHGiVHkG0IAz95MwFmYStIKQQHvq3Q5+zaBd
	SOYHbntJs5Ld96wuUz66LWCIl3V/vj/sfvyoc70RyeHZlI1mpKr5H4xefL5EImCUGeXTaFBC97e
	fEQSFZ5gjcSi5AzHsnrjYdhK3tOm+3fyiuisz02jPVhP3BjlfqlOm289NkhsbralIYKnKWC0sSe
	pb4oawg/ny4pz5+byBPhvQWYHWv/eJfAErrmjaLMlXSjdfx0rbNonqYicg==
X-Received: by 2002:a05:622a:1453:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-530a5e02d7fmr16768441cf.3.1788970393225; Wed, 09 Sep 2026
 09:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-5-surenb@google.com> <20260909142527.1601051-1-usama.arif@linux.dev>
In-Reply-To: <20260909142527.1601051-1-usama.arif@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Sep 2026 09:13:01 -0700
X-Gm-Features: AcwNN1UYQKF7D0D2WK-_ZwM2Lbn4QfF-4TdU4tR2zDAe1K2ZBIa-EoqKfU4N3fc
Message-ID: <CAJuCfpGOnSMPKMLVCO=JkcaahRvBU_1pNdK7AR5N3QKBARh4Ag@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
To: Usama Arif <usama.arif@linux.dev>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, david@redhat.com, willy@infradead.org, jannh@google.com, 
	paulmck@kernel.org, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 7:25=E2=80=AFAM Usama Arif <usama.arif@linux.dev> wr=
ote:
>
> On Sun,  6 Sep 2026 23:39:17 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
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
> >    Median   Minimum   Maximum
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
> >    Median   Minimum   Maximum
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
> > Remove now unused lock_ctx_mm() and move unlock_ctx_vma() next to
> > unlock_ctx_mm() as they are logically related.
> >
> > Remove a long comment about 4 cases that we handle when dropping the
> > mmap lock in the middle of VMA walk due to contention. The first 3
> > cases explained there are handled naturally and only case 4 needs to
> > be handled in a special way, which is done in smap_gather_stats() by
> > gathering stats from the portion of the VMA that has not yet been
> > processed.
> > For posterity, moving this comment here:
> >
> > After dropping the lock, there are four cases to
> > consider. See the following example for explanation.
> >
> >   +------+------+-----------+
> >   | VMA1 | VMA2 | VMA3      |
> >   +------+------+-----------+
> >   |      |      |           |
> >  4k     8k     16k         400k
> >
> > Suppose we drop the lock after reading VMA2 due to
> > contention, then we get:
> >
> >       last_vma_end =3D 16k
> >
> > 1) VMA2 is freed, but VMA3 exists:
> >
> >    vma_next(vmi) will return VMA3.
> >    In this case, just continue from VMA3.
> >
> > 2) VMA2 still exists:
> >
> >    vma_next(vmi) will return VMA3.
> >    In this case, just continue from VMA3.
> >
> > 3) No more VMAs can be found:
> >
> >    vma_next(vmi) will return NULL.
> >    No more things to do, just break.
> >
> > 4) (last_vma_end - 1) is the middle of a vma (VMA'):
> >
> >    vma_next(vmi) will return VMA' whose range
> >    contains last_vma_end.
> >    Iterate VMA' from last_vma_end.
> >
> > [1] https://github.com/paulmckrcu/proc-mmap_sem-test
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c | 153 ++++++++++++++++++---------------------------
> >  1 file changed, 60 insertions(+), 93 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 3351decd1172..641a155b0c61 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -130,28 +130,12 @@ static void release_task_mempolicy(struct proc_ma=
ps_private *priv)
> >  }
> >  #endif
> >
> > -static int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
> > -{
> > -     int ret =3D mmap_read_lock_killable(lock_ctx->mm);
> > -
> > -     if (!ret)
> > -             lock_ctx->mmap_locked =3D true;
> > -
> > -     return ret;
> > -}
> > -
> >  static void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> >       mmap_read_unlock(lock_ctx->mm);
> >       lock_ctx->mmap_locked =3D false;
> >  }
> >
> > -static void reset_lock_ctx(struct proc_maps_locking_ctx *lock_ctx)
> > -{
> > -     lock_ctx->locked_vma =3D NULL;
> > -     lock_ctx->mmap_locked =3D false;
> > -}
> > -
> >  static void unlock_ctx_vma(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> >       if (lock_ctx->locked_vma) {
> > @@ -160,6 +144,12 @@ static void unlock_ctx_vma(struct proc_maps_lockin=
g_ctx *lock_ctx)
> >       }
> >  }
> >
> > +static void reset_lock_ctx(struct proc_maps_locking_ctx *lock_ctx)
> > +{
> > +     lock_ctx->locked_vma =3D NULL;
> > +     lock_ctx->mmap_locked =3D false;
> > +}
> > +
> >  static struct vm_area_struct *get_next_vma(struct proc_maps_private *p=
riv,
> >                                          loff_t last_pos)
> >  {
> > @@ -1376,12 +1366,14 @@ static int show_smap(struct seq_file *m, void *=
v)
> >  static int show_smaps_rollup(struct seq_file *m, void *v)
> >  {
> >       struct proc_maps_private *priv =3D m->private;
> > +     struct proc_maps_locking_ctx *lock_ctx =3D &priv->lock_ctx;
> > +     struct mm_struct *mm =3D lock_ctx->mm;
> >       struct mem_size_stats mss =3D {};
> > -     struct mm_struct *mm =3D priv->lock_ctx.mm;
> > +     unsigned long last_vma_end =3D 0;
> > +     unsigned long vma_start =3D 0;
> >       struct vm_area_struct *vma;
> > -     unsigned long vma_start =3D 0, last_vma_end =3D 0;
> > +     loff_t pos =3D 0;
> >       int ret =3D 0;
> > -     VMA_ITERATOR(vmi, mm, 0);
> >
> >       priv->task =3D get_proc_task(priv->inode);
> >       if (!priv->task)
> > @@ -1392,89 +1384,60 @@ static int show_smaps_rollup(struct seq_file *m=
, void *v)
> >               goto out_put_task;
> >       }
> >
> > -     ret =3D lock_ctx_mm(&priv->lock_ctx);
> > -     if (ret)
> > -             goto out_put_mm;
> > -
> >       hold_task_mempolicy(priv);
> > -     vma =3D vma_next(&vmi);
> > +     rcu_read_lock();
> > +     reset_lock_ctx(lock_ctx);
> >
> > +     vma_iter_init(&priv->iter, mm, 0);
> > +     vma =3D proc_get_vma(m, &pos);
> >       if (unlikely(!vma))
> >               goto empty_set;
> >
> > -     vma_start =3D vma->vm_start;
> > -     do {
> > -             smap_gather_stats(priv, vma, &mss, vma->vm_start);
> > -             last_vma_end =3D vma->vm_end;
> > +     if (!IS_ERR(vma) && vma !=3D get_gate_vma(lock_ctx->mm))
> > +             vma_start =3D vma->vm_start;
> > +
> > +     while (vma) {
> > +             if (IS_ERR(vma)) {
> > +                     ret =3D PTR_ERR(vma);
> > +                     goto out_unlock;
> > +             }
> > +
> > +             if (vma =3D=3D get_gate_vma(lock_ctx->mm))
> > +                     break;
> >
> >               /*
> > -              * Release mmap_lock temporarily if someone wants to
> > -              * access it for write request.
> > +              * If after retaking the lock, already reported VMA grew =
or
> > +              * merged with the next one, smap_gather_stats() will gat=
her
> > +              * stats for the remaining portion by starting at last_vm=
a_end.
> >                */
> > -             if (mmap_lock_is_contended(mm)) {
> > -                     vma_iter_invalidate(&vmi);
> > -                     unlock_ctx_mm(&priv->lock_ctx);
> > -                     ret =3D lock_ctx_mm(&priv->lock_ctx);
> > -                     if (ret) {
> > -                             release_task_mempolicy(priv);
> > -                             goto out_put_mm;
> > -                     }
> > +             smap_gather_stats(priv, vma, &mss, last_vma_end);
>
> Patch 3 made smap_gather_stats() reject starts below the VMA, while this
> function initializes last_vma_end to zero.
>
> The first ordinary VMA is therefore skipped. lock_next_vma() can also
> return a VMA beginning after the requested position, so the first VMA
> after every unmapped gap is skipped as well. This causes
> smaps_rollup to underreport RSS, PSS, swap, and the other accumulated
> values.
>
> I think you need:
>   unsigned long start =3D max(last_vma_end, vma->vm_start);
>   smap_gather_stats(priv, vma, &mss, start);

Oops, you are right. I didn't realize the first VMA would be silently
skipped. I'll fix it. Thanks!

>
>
>
> > +             last_vma_end =3D vma->vm_end;
> >
> > +             /*
> > +              * If the VMA lock is not taken, we hold the often conten=
ded
> > +              * mmap lock. This can happen if we had to fall back to t=
he
> > +              * mmap lock.
> > +              *
> > +              * To relieve pressure, check if it is indeed contended, =
then
> > +              * temporarily release it.
> > +              */
> > +             if (lock_ctx->mmap_locked &&
> > +                 mmap_lock_is_contended(lock_ctx->mm)) {
> > +                     unlock_ctx_mm(lock_ctx);
> >                       /*
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
> > +                      * Even though we previously fell back to mmap lo=
ck,
> > +                      * we try taking VMA lock for the next VMA, since=
 it
> > +                      * might not be under modification. In the worst =
case
> > +                      * we will fall back to mmap lock again.
> >                        */
> > -                     vma =3D vma_next(&vmi);
> > -                     /* Case 3 above */
> > -                     if (!vma)
> > -                             break;
> > -
> > -                     /* Case 1 and 2 above */
> > -                     if (vma->vm_start >=3D last_vma_end) {
> > -                             smap_gather_stats(priv, vma, &mss, vma->v=
m_start);
> > -                             last_vma_end =3D vma->vm_end;
> > -                             continue;
> > -                     }
> > -
> > -                     /* Case 4 above */
> > -                     if (vma->vm_end > last_vma_end) {
> > -                             smap_gather_stats(priv, vma, &mss, last_v=
ma_end);
> > -                             last_vma_end =3D vma->vm_end;
> > -                     }
> > +                     rcu_read_lock();
> > +                     reset_lock_ctx(lock_ctx);
> > +                     /* Resume from the last position. */
> > +                     pos =3D last_vma_end;
> > +                     vma_iter_init(&priv->iter, mm, pos);
> >               }
> > -     } for_each_vma(vmi, vma);
> > +             vma =3D proc_get_vma(m, &pos);
> > +     }
> >
> >  empty_set:
> >       show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
> > @@ -1483,10 +1446,14 @@ static int show_smaps_rollup(struct seq_file *m=
, void *v)
> >
> >       __show_smap(m, &mss, true);
> >
> > +out_unlock:
> > +     if (lock_ctx->mmap_locked) {
> > +             unlock_ctx_mm(lock_ctx);
> > +     } else {
> > +             unlock_ctx_vma(lock_ctx);
> > +             rcu_read_unlock();
> > +     }
> >       release_task_mempolicy(priv);
> > -     unlock_ctx_mm(&priv->lock_ctx);
> > -
> > -out_put_mm:
> >       mmput(mm);
> >  out_put_task:
> >       put_task_struct(priv->task);
> > --
> > 2.55.0.979.g7e5102b832-goog
> >
> >
