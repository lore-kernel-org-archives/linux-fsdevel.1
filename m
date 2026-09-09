Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA80367285
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974139; cv=pass; b=F6dSQOjouTbqY+c8WS6u33kuav0c9Qj5G04+81roQ7h91UCpETwSUSuoSUQv1jcXlsTwPGBMKpo5IrQdC2S750l57yU+ZkQY3oXkPYilbZqO7TQr0R78J2qDhnqS9gNucVvd6TnJnlUQ2EaJbXuCtFOO9Hwqk+Wby3e1qGsgEvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974139; c=relaxed/simple;
	bh=1YAIaeDyLVpEvvzFwuUJMbazAMt3NzSDWCDFujkL5lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/OPT+AeeSKcIqmNhVfhCbP48nWO0jiq1MzoUhgAXEU6l95Y4p23JrRPVppwQsiqFwI13bmosTXJ9+k3D9pnFRpGUjHKio7f6zsChgh22ITLe2NtJ8PQHlmCSDRWL+mLlrmhPPNj2dzuqBgJC2Uzo91gKnl1hPmbmgOvn+GHlXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbY3TdbX; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbY3TdbX"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso329871cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 10:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788974137; cv=none;
        d=google.com; s=arc-20260327;
        b=lrsh/UPY2lBXerjn7G2Q/J8nr0ABd0CmDgSSCbgUm8eY/I5iZJp3XTVCLQyT5OKzfV
         frDxQVyGWFbTQ9Bjs1jihp5JQa52r7TIZnEjOXurj1fG59mVvfr+jolwByQOK0TyqMTM
         FMf1L+wPO6aq/TNq0je9MH4gYfGYYDfcNB22EGEx5tNSe+D5pNstId0A6Tf0LJALOoto
         Yw0PUSlsi9H4QQAgQBSBW8egIGUtniod8LwccMYKGQYm5g1hV/8kEkx8qnBgk8pM+rej
         ttm2TpqAoI8645dsjgZPvX6IqbaFiZG1PQ+rG2ymysxwCrM/uCX1/ECdDadwvFRGPiBF
         2ZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mKUmBDe2b4FLQdJcR20tHldduUrJACzKAwyQg26uG2s=;
        fh=TAGswkMyQlrxHCYJGEJxuCfV8iGPtGRvrbeOuyTacqg=;
        b=Drlumbe12h4WDTOZcVmaotHe0JOsSh8ElmPsHDkZVkZkl2+rK8uLHKHo8dB5bTOj7D
         AYYxJpyATxrUmdcJJb99Zak2ZWgMgGdy/A55oMzGiga+vEBEqNgJEtXCSrkmMILAq5/Z
         gVWNskEVUcRz6/GHvcbox6mwRxrsecsHlV/Vc6X492kCE72S8gigHdLlzKjPSNA5ahb1
         3/QhoAR3UuU+9dgLjIzWeJeoPCs1jYrBAa+PaOFusVWefQZgrhPSpckVjC0+ab4ZwCfN
         yg9saAKTZCzpi+wra9CxVJd/DBQyM32mRxuZeB2YvBUHMHhx/XWie+BZC7EMIaX/JLca
         lDEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788974137; x=1789578937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mKUmBDe2b4FLQdJcR20tHldduUrJACzKAwyQg26uG2s=;
        b=HbY3TdbXh1HeDA1CISRM4vFgBbshMEJ3Y41MetmpizeACtcBFvrnZ42fCa9kRsD4Yy
         1nq49pEpk9a9R7roEUh04FoZyRnL2UY9tUOCtzRkPFxxq5DC/yj5VHvuqWDZ6ylzKTov
         st8IaztaYCk8hGWmc/IC6wda/nUzsp1Zr2lBekrthUV/mj6pbio6ylScmUI/qyDDWp2r
         H6O5BcgnCS3YHlvVCrS/+Q8b0yMKZR74q5FO/aNdBR0HoD1zepE8Lar1oheT9iawpvM9
         01x2ghk4163U0s/6GRxybf4YAdDJHeE/d4foFb61WDP4WST7Epq38O0FNKjpspvhdP27
         cKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974137; x=1789578937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mKUmBDe2b4FLQdJcR20tHldduUrJACzKAwyQg26uG2s=;
        b=Wrg5IrSe7pjoRA5N+jVa0XXQkumSxVqmhMcWSLoISO6D1f0vxCyORXWr01dTF0eJuH
         N/kmyP4qECKEi6s6FgPsjCuk32PQaoDxqVJe/ihljVbJVPsS779aYNPmAGlIz3iqmVTB
         1bzA1gOFztO5PoOWivQdskZG66gg/7zvfFAwVxGUysZQErVHsWlD3uf+pFyLSdFzjzoA
         ydn9jdgrOjmPcuB/89c3RSVWveEYmyLi4h3rCjPawRsWWxXJ4pZWzW8LdmVNDAZ2U3rY
         xv01ym4DX45b3JoNTk+wiuf5T+Yx7j3gvnQ+Tf/1IKiflt4RyTbG38XjmdKsWkffPePq
         VaqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxn3yiNR2xNBYwrbhcP+MC52cDrRpOfwB1BPJ3CyYbYYwnADkTjtPNAk0EelFwYwK2WiTJUtb3Ucmg0IcV2@vger.kernel.org
X-Gm-Message-State: AFuF++mfnAMG2DYwd+QIjvz5Tx6tz7Al8dyMdHnAlHZJ2u05fygAV1hE
	t0m88GkXtWf1jiSz8ucK1fZeQELJ0LyI4f6GdEZsmhmGjyqUxajDEIYy2bvDPAUWkfwCYQHRx/J
	r2/9h9ahXGy9MoD3Uj/E0223PT+nasf5iRbe1YcRY
X-Gm-Gg: AYBFou1Im8G1V/nofKCt9jFMp1hvshQ/fNC7zuDz8LIgO51U87jIK1aGuySuw9YM5Cu
	bqTbNxhtU2XlwSsb7lMahNhxel9iesBU1KsefFJS9ji6R4LkMScYCdhrj8OHi9msF7B3fsQ/E0k
	dAsz6yolnWctkcI3xscD7KcC1KlUxnDdKN66QApULqz2CTX8cm3SXJka26tpP1qeycIizA21p9l
	k0Z28AmPaEZWso6AbrFxrKHMbG6oRNUmG9nmyxfCWSoceMyCeWVc0812qWJKe9Hvc2MBvgzu8zk
	GWCceIR1RgqGyHjaUvYX9X7WRG2W/XBY2MK6lq11h7CoFS2v3lYVtFkQe8P800QJF4Y9
X-Received: by 2002:a05:622a:a1b:b0:530:5ed7:50f0 with SMTP id
 d75a77b69052e-530a5f51176mr89211cf.13.1788974135518; Wed, 09 Sep 2026
 10:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260907063918.3432401-3-surenb@google.com>
 <4964f874-3f3c-464c-9977-0d004f6ffdbd@kernel.org>
In-Reply-To: <4964f874-3f3c-464c-9977-0d004f6ffdbd@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Sep 2026 10:15:24 -0700
X-Gm-Features: AcwNN1WWr8U2hfUDprfzdhTtlvlOsxUFMQbj8KtH7xWoq0JQsfsSVRf58XyzXHk
Message-ID: <CAJuCfpFJHNq_iCHuzDC0a8CT-AsPLHgnZ0=hVAvVhax_Q6GjOQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] proc/task_mmu: remove unnecessary inlines in
 function definitions
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 10:07=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/7/26 08:39, Suren Baghdasaryan wrote:
> > It was pointed out in the previous reviews of this code that many
> > functions are specified as inline, which is unnecessary as the compile
> > can make that decision by itself. Cleanup these definitions.
> >
> > No functional change intended.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c | 32 ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 2f500d639db5..9908ba32f180 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -130,7 +130,7 @@ static void release_task_mempolicy(struct proc_maps=
_private *priv)
> >  }
> >  #endif
> >
> > -static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
> > +static int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> >       int ret =3D mmap_read_lock_killable(lock_ctx->mm);
> >
> > @@ -140,7 +140,7 @@ static inline int lock_ctx_mm(struct proc_maps_lock=
ing_ctx *lock_ctx)
> >       return ret;
> >  }
> >
> > -static inline void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ct=
x)
> > +static void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> >       mmap_read_unlock(lock_ctx->mm);
> >       lock_ctx->mmap_locked =3D false;
> > @@ -177,7 +177,7 @@ static struct vm_area_struct *get_next_vma(struct p=
roc_maps_private *priv,
> >       return vma;
> >  }
> >
> > -static inline bool fallback_to_mmap_lock(struct proc_maps_private *pri=
v,
> > +static bool fallback_to_mmap_lock(struct proc_maps_private *priv,
> >                                        loff_t pos)
>
> If you touch these, please convert them to two-tab indent.

Ack. I didn't realize that's the preferred formatting.

>
> --
> Cheers,
>
> David
>
