Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A97246BC0
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933408; cv=pass; b=rIWL+ZkYzoL/UoTtAEJW1vP0C7jzRA1rnd//G7JA9S2fmV+LDcLgWt6gulTbN5NID9SzEs6e1bDQcu2IyujfNhOmmu+FuDF0xWlfNOWL3HFf9x8g5EhiHw3l4g3Xc6FiAAEFzq+YvYNN1/kjnZT1AXFQpVlDnmghYUjKf8Qtsjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933408; c=relaxed/simple;
	bh=UQ8d5f84rAAACNaz6QB/fu2R+8Q7kS4Vw3G5+R8HjD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOPbutvNcUSdcK8FtgpJVFZSok0VwThAgu8lcBhVXe6xxy54dRQJ5gA7QX1EN2RNFEXWsaQ/mcV+VhDnduMPgHIJ131wXX4kqQ7DOgU+OHdWZ4azLn+AXWQSBrd1lGN9pjSG6BFS85D3a18p08o+fDse6D0fk/NJkj7hqeSNi+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9TI8p6J; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9TI8p6J"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68ced08613aso30487a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 08:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780933405; cv=none;
        d=google.com; s=arc-20240605;
        b=LeEkoOmLjk5dvsncmwzF7NxPQxrEsUS6m6AvxDfqNJw0l6/O0MPELdthX6VBPWGPJ1
         qsdmEw7AOHRgTTtvug6ce4Vy1AvtfXY8qeXdiy1AjX98kwlHnlhL8k1Nc6YxtIlBPtZ6
         9rrB84O2rxp0Hirgpw3oMc6vAWQp7Qhifz5NzF5kuzzf0ep9kAiNaL3N94HRAtyg1hdm
         AxGjkGstScG1xlh3rSJ6j9EkEWeONmrIIWana3Ko7cdgYEwi6JkaVsjD2TUWsgMw90gO
         8cn+T2xsCz+r/pB9TBwj/GKU83Zwh3e3XRbaLl+Muem2vOmrfOzDjGHuwzhJaE5yWl7e
         diZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ImVZHEvL5DaiMqGQQ7oF61NPY2ecFeN6e1eaZ4yGJGU=;
        fh=LJYhnMZBax9vtKkYeBGyXKkDLQlvftSy8Rtt4xDkwQg=;
        b=I4lV/afsjWy5SWQovr0x5TLgNCWgqndsExAKTSi+pUWUu13VIobB+FmU6Q0homoARC
         WrDKE9dJxE9S+KkEuWnyBLebuRi6QIaAaV4MRfNwepDKS9Fvr2H90SzvdqOpzcXMGhOi
         n9hGxmxbsjaQlDIuFn3Q6Gd/sEBukQ6xcQpJdbBZa5Poc3Rg50jl61rdYhI+GxRvPBKM
         H2/YdFByB44RmGR6CJPf3a1CXDQxalijvbL+8kdaGJBe/UsWQDTV5+HxQRcyRwi8/IjB
         5yzBr8B3JJU265i4nvNc8kv11ap8C+zmNHD865I6cVZh34gJXdZ+vE5GbvlJsCicD2Kb
         P8NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780933405; x=1781538205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImVZHEvL5DaiMqGQQ7oF61NPY2ecFeN6e1eaZ4yGJGU=;
        b=F9TI8p6JqfpHYKZQEXlpelZEK3rtxASiy3UswK0934p3R9QL2xj57SFMec1symiOS5
         6jhX0uEqK5lg6XvhrFRAsMqJ1fIw+PCWFMitnAIbAJw2wevsNZkXGEx1CO4dNlYL4ZJV
         3xXSJp8ug2jugDzqeD+gMlqM6oMqqLVzVz+YiqBWQgfDkrmxSOhB6M1biaC7o7rzhzZi
         36cQRGLlNJPFPHiinfx40SizNKh2EUPE0qHu2tANosmrQVSRdnEWnoLvBF20tcjpkh6z
         pVcxxPqaKoarOLcX6aIIJhe9JetCAkzz+I6a3DLin2Ub+MMMJ1DeqBguw0PJ9VvoASIg
         mnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933405; x=1781538205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ImVZHEvL5DaiMqGQQ7oF61NPY2ecFeN6e1eaZ4yGJGU=;
        b=P72B5uNT94PxHqm0HQk7HJTZxsg5TZsKuAzAyNglKcxnlSpdRxYTlLf7pkixy3/FEk
         Fwk115h4L3ErMaXf1od4hEvdlNIIm8S1lyrniAmmSyqoO6PCH3JLR+n98FwMIF2IE/Eo
         4K0pXZEGOPuK8NUvk0wXSc+ZxNkVfawYhfDEN1N1b5Dv8fAwA3N594JSot5iQj+SXJ3x
         u+mnu/3Df1Z4zHmK7iWfR9Ea/WtZslKsbzJNqNxQddfnMzjdtcW3DvZ2tV/bCC6YihAL
         F06s7DfSs0lKwnoUAh9DI/34g6cHKzjng9ba7GNcGTbK7s8QEAquo2bTXFKebiJ5lZ+4
         8uaw==
X-Forwarded-Encrypted: i=1; AFNElJ9fQzImBMy+z5TwngB6o/WPl9PPQqGooDLzhuPnsEakYiViTewI3odwQyJVyIvnim98JWPFEY8bQ3g+nUfO@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQPNLPV7bjekgaJ6IZxtSJSiVjwWoLGEVMagnMimr5TQkBkNc
	AQiQKw5BxtkelzkwG/vtO6XiOzJ0UPu086/s/jYw0hc+BcNbMERDoBFHrWUd+dVH8DqkETUlQy0
	JomDqFri0pa8t5o4qBBwDkWV7xhbH0OoHtAgH89uJ
X-Gm-Gg: Acq92OHpf8HpPAqm1UWCwGc5xKT+tZsNTblkIX6CJiZOzQqW+IUsfpQR/WFxUvZ60wD
	7UuNFWJW66j/NZYPck06EkWc0yLIzvewj4ksnO8MMmwpnmj18LcH0iHtX0Kjms7MINuHx5QArha
	S69+1eAj1QWGgCAdDJzqUvUGCo4zajX2C1hm3w2g7O6nAsQPOwdck+ovfgk2KsNnA5t7GuQfyzC
	N6ivSrY5tRrCmsNeFrrf09I07MJ7qLx8hm+Ln+kBAO3empOxF/Tl6juLCB5XNAH4ZotCXs8OztE
	6XCx7AioggeqtjVs
X-Received: by 2002:a05:6402:4496:b0:68a:faa8:9564 with SMTP id
 4fb4d7f45d1cf-68fe9272c6cmr228481a12.9.1780933405006; Mon, 08 Jun 2026
 08:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606015729.1837935-1-surenb@google.com> <fb25c5c3-c3b4-44df-acd6-46040ff1027b@kernel.org>
In-Reply-To: <fb25c5c3-c3b4-44df-acd6-46040ff1027b@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 8 Jun 2026 08:43:10 -0700
X-Gm-Features: AVVi8Cc_t40vlw66hgAT5JXUBBtCVUtxAuOHL_CbRtWc8V6kZ3a7TUKFsTPHnxQ
Message-ID: <CAJuCfpHbsAC+kw2B5m=TZv1CN7KCxCUVAcEoTKGSz3DvVUc_9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: change lock_vma_range() to return
 error code
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:38=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
> On 6/6/26 03:57, Suren Baghdasaryan wrote:
> > To correctly propagate error code from lock_vma_range(), change it to
> > return the error code instead of the boolean. This simplifies error
> > propagation code.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index d32408f7cd5e..023422fcee12 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -162,13 +162,13 @@ static void unlock_ctx_vma(struct proc_maps_locki=
ng_ctx *lock_ctx)
> >       }
> >  }
> >
> > -static inline bool lock_vma_range(struct seq_file *m,
> > -                               struct proc_maps_locking_ctx *lock_ctx)
> > +static inline int lock_vma_range(struct seq_file *m,
> > +                              struct proc_maps_locking_ctx *lock_ctx)
> >  {
> >       rcu_read_lock();
> >       reset_lock_ctx(lock_ctx);
> >
> > -     return true;
> > +     return 0;
> >  }
> >
> >  static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock=
_ctx)
> > @@ -245,10 +245,10 @@ static inline void unlock_ctx_mm(struct proc_maps=
_locking_ctx *lock_ctx)
> >       mmap_read_unlock(lock_ctx->mm);
> >  }
> >
> > -static inline bool lock_vma_range(struct seq_file *m,
> > +static inline int lock_vma_range(struct seq_file *m,
> >                                 struct proc_maps_locking_ctx *lock_ctx)
> >  {
> > -     return lock_ctx_mm(lock_ctx) =3D=3D 0;
> > +     return lock_ctx_mm(lock_ctx);
> >  }
> >
> >  static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock=
_ctx)
> > @@ -311,6 +311,7 @@ static void *m_start(struct seq_file *m, loff_t *pp=
os)
> >       struct proc_maps_locking_ctx *lock_ctx;
> >       loff_t last_addr =3D *ppos;
> >       struct mm_struct *mm;
> > +     int err;
> >
> >       /* See m_next(). Zero at the start or after lseek. */
> >       if (last_addr =3D=3D SENTINEL_VMA_END)
> > @@ -328,11 +329,12 @@ static void *m_start(struct seq_file *m, loff_t *=
ppos)
> >               return NULL;
> >       }
> >
> > -     if (!lock_vma_range(m, lock_ctx)) {
> > +     err =3D lock_vma_range(m, lock_ctx);
> > +     if (err) {
> >               mmput(mm);
> >               put_task_struct(priv->task);
> >               priv->task =3D NULL;
> > -             return ERR_PTR(-EINTR);
> > +             return ERR_PTR(err);
>
> Looks good: down_read_killable() would also have returned -EINTR.

Yes. I also use lock_vma_range() in the next patch and this change
makes the code a bit more cleaner.

>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

>
> --
> Cheers,
>
> David
