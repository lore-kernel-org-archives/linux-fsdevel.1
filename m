Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F3481FA3
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025197; cv=pass; b=XiXC2DambBbe795HzXwoZ2/43IPwo3xjWd1nxPr5N1J41/QJvtBHGxaq09cQ4Zf1Y99W6nrPZqtsEt6P2kQ+umstpf0Wv2PsQy7eIwiriFjfeHW0lalW4syqZ3KTuiyMqUtJMy+GQVujqDuykjPoo7F9h9ugsRt0LVKgGSkdJLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025197; c=relaxed/simple;
	bh=bh8xzMucIYKJR4AkQkH4nnCVrt/Jnl3SesAonh/RAVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzLk6j7kPcvXq9KYTki6Q2wGzp2Q7N0fYQfxPsugDErVfSyjN68tiLQdIHpQPiraIKsclsMXBfWN/g8ozHlhkYCElb1SFXrooTc+kWpP+igs9o1uS+lo0M/AD48JKSlQTdJxZBSPO2x1VyAor1JH1qIbBtON9BpbC2YiHxUEVBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQaa8jKG; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQaa8jKG"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51765531803so2767651cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 10:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781025196; cv=none;
        d=google.com; s=arc-20240605;
        b=S6JKf/kqf4MhxwkEFdGP7WDWXngsUkiqr9I/lo19hK17r3cgNyeXvqTKEhxwSuzusQ
         CI6GkWjm5LWNj82aMOPA/Rqhl0iwU95fLkoaNmK+7xEWmSdpKfqdtdTOSV916Hzr/547
         /8gDaRyzvxoPMuqcJDexCiwyKzeRGV5SeyCmZAS5zXDJbCsVp+wUqSaGlxrBMRQ/vUKB
         bZx1oTxJUsfysh1lJlU5vGkWlsBf+RuEpAKb2Ud5ZV2AtA8hKIQbQpwo7VtncmZAWs+i
         IZxJWbHzZWzOFgSkKcEMbRw49CjHgDxhQKGH4VSbU7crpWUPPCTYGRzAKzKh43GigbR8
         XmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+NodRxI3YJX6R0sNnZQ3DKxsEFXXpQE4gpXdGBbhjZc=;
        fh=xSEGhHkCgqrxzX2ppowSPJFkHQGO99m8QugdPpPHQLc=;
        b=cf8WCP+hDzV4c97lI6ZbEiTHbytto7tRL3Gp0Rb1QqUZGGMknXHaEQr2jZAZOVpyIA
         k1uY2tQeLo1Ugs8KIkMNUMXNlQ2sHKoENiFUaXx8GtvniliOSBjnkpjK/6/kd4Cr0VCy
         f/3aMMPGE4jd/k+k/WaIK61WJ3dvcjgzduc+iNK7ee/kAMab9B2TRtDVOG0Q9xr33Y1/
         hCUiAHGogwz5kBRVGrLMjsTdFmgvh4ZrW6V+DcEpehUo9qCwlkOP7l8q1lGjSkyudhCI
         LPaxKZ9RWD8VKw+lOHI22jcfDmTidSBDJQ6bj6LkSis2krFvczocQdO5ASjLlW3xRrv+
         r+OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781025196; x=1781629996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NodRxI3YJX6R0sNnZQ3DKxsEFXXpQE4gpXdGBbhjZc=;
        b=cQaa8jKG4lVto0ivJ9xyB5YbCQ8EJpMOqd5OJDPcuk249BGz/XTy6CnzJG+eGABxkI
         NRqiC5ciFLzjfMr19ZfncYtKbzzDsMrQ9DQJcpiYMZCE9rW9hLgmKHrmmbprkGRyRDQz
         uzNt6QL2nL4/LWj9ZFHrQg/DEihwxtekYhPsADzIs5txoOJzyIbV24E2LJwj8n3SloS6
         NI5zwgvG70FwAcIfkfN+YVsR+ulmaQIgK7ldq/+9PjQzXz7lRd73jv3dUaqa3fPKPKLh
         1C5EQYGrG2qEAavky2uVBDCSNI92ln5+gpNzmKf9zZTclEqhVxzuFCZM2vTCQd776l+L
         w4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025196; x=1781629996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+NodRxI3YJX6R0sNnZQ3DKxsEFXXpQE4gpXdGBbhjZc=;
        b=B/wvRoTxe+ahg5rlxMosjS65Own8LGeAVGtt0YBIOVkOehq3ZNgELDXBGGFEj5LYhw
         m2g/5lc4TjalO5myrS3hq6nfgzgx2ToW/Fdp4QD64NPGEJ3EzDZVkSkMDH+fQjwTpWMM
         mohv1cBfAKpKlH20q851vBJq2l4DchskzjVeAmCrsmnWEcKR10yvPZNnPyhdi7kCV5TR
         7h5FxySTOZTpqmdNS4Q2Wjlf8XR/eZkUHuruFBGQoBaHmqK6s0HsuwtWTCbXt8RLYyVq
         Zia/4yXWX6IP24+MzT9d5EC43FV6LcGiA5kv5Yg35JFXQ8Fu5NrGLhIZsBqjsEMLq13V
         JrXA==
X-Forwarded-Encrypted: i=1; AFNElJ902EclTOeJiC6QUDOzl9qi9PlnuQcocuKfV3rEhimZQmz3JD31Dv/70YHjZrQL3/3Fur6SXg/PbkpLjPuT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv/4DHIZCf/tWaICKrio/E44Efdkag2LY3hg6Rmwj3amYivD80
	CTSTSf2y4zjqr/ZBCWnjAXsMM/MNjXhZzDiO/fR2J7hNeRaC2ZpHz8Y34VgtmFuEe+o1Z7f5upC
	eMfx1BftmU6JOQTB9xIrZUx1S4gW688DpVSwDE7w5
X-Gm-Gg: Acq92OHVKVFx7BZBVeXGDw/xlSsuM2P8lciQWXxu8XGgIgLj8rLZt5aIGEAD6Kz+/yY
	O5D4nlM9iTFkONyiFENN2gJpGUueGL+QIdcBiQxtDHJo2O9TusD3b3uK8H79yDcFXVpbtz96zTd
	FHtPmEKeeLEY5ZP+FpUtRUBNWFT/e8hoIEz9r7JBL/6ZvbdTNEQ4mcrnNLp6DwfoKOJ1970bcev
	E+ZVUUtRFGneVyh7+t/dfG8q8fV0DiFQB9HfKQP1hdxG8YMSVpE2ZSdr0nYls6xq41JDxNxiz/O
	6CTzYPAPyruq1IdFL3D9l026r9e1wUGPNC+pSLDqEnHB+bUgwjJm5rwBUSE=
X-Received: by 2002:a05:622a:eda:b0:517:6dc0:698d with SMTP id
 d75a77b69052e-51797f67f73mr37747371cf.0.1781025194743; Tue, 09 Jun 2026
 10:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606015729.1837935-1-surenb@google.com> <aifEZEisSFABmYiW@lucifer>
In-Reply-To: <aifEZEisSFABmYiW@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Jun 2026 10:13:03 -0700
X-Gm-Features: AVVi8Cc11jTgQ-bPSJkt8toevaR0OaWZcsAO6_AhL8y9iGLJOxbwkljrmIEXYfU
Message-ID: <CAJuCfpEvAPPm1RSOpXvtsYUi9hr3j0ST098k2RF8pUp7J7RY5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: change lock_vma_range() to return
 error code
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 1:28=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wro=
te:
>
> On Fri, Jun 05, 2026 at 06:57:28PM -0700, Suren Baghdasaryan wrote:
> > To correctly propagate error code from lock_vma_range(), change it to
> > return the error code instead of the boolean. This simplifies error
> > propagation code.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Logic LGTM, couple nits below, but:
>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Thanks!

>
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
>
> Could drop the unnecessary inline here while we're here.

Will do.

>
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
>
> Same comment as above.
>
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
> >       }
> >
> >       /*
> >
> > base-commit: e178a530a81621a29efbca49b3b78202a18236e4
> > --
> > 2.54.0.1032.g2f8565e1d1-goog
> >
