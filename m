Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343340861C
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154343; cv=pass; b=hlZmJ4+9GRd48f4Nn5Mp5P4XZ3L0st51BlVwbFrZJyCIVmkzCtCu5zYdhrQRMrDR4cKrMCDE/KCz1dohkHzAZuyLa2Mg78jFqcBNYNtYTkQic9bQ99uZJw+qxBfy2bf1Mj0Beg0mB3xU7eU42s0w07gC1m8uUDVz9y+TpvQw3Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154343; c=relaxed/simple;
	bh=ovCn0bXnyVc2xzgwQBoKl7i+qzDQJtyekBT95i4IyCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9P+ABMqy2S+RMDFQiwHOyVZNx1sXLwHBF5uxHBPHKn2EL0nF2Zgor0KYgJqH37YaaYp4zpnZYit/R649BIlp9kKAfiqU0jOz9fDicoaVlkH/o3MaRgRO7dLnqoVAhT7dNEbShXNgkYYqWzoXVArQ/frmAeEznYtMwdACzLwPbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0eBjAd6; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0eBjAd6"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so118321cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789154334; cv=none;
        d=google.com; s=arc-20260327;
        b=gWpmjwVxZx1EgxMR+OlTPxUFVpBVPgQ01hbbvVhBmraDmTZfWGots23nv2w7aGdT1y
         k5Kaz6fN5JxuHK94cWXrPVfisUbY/NDekyA7Hmo3uLjj7uL4QlUqGwszDoHDKp6M8592
         GDjA7ba1tCdI259AZapZvaVWW4oS90CqySzoVWLFT1bIlRGKhZrdmEbAQe+FqbsGGhRC
         Pv8wnZCXG89vkZN2T45PyDFWZMb+c2viif5UfAGKw6kcEgi3X+jcrzEbaqJnDpcS+ENQ
         nk9L76oqhLjFmWGT0ejMhE/wi8yP/WVO9OpCxK+6AdfR2CWROJBLoKcGRxu2taE3oGd0
         dymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vIEx8uU8IqjffSSCDEyJeKQJtwuejUussKszKVj30XA=;
        fh=36ghuAFZTaZ27fGOI7/oi28yVTU9GeBR3cahIpWbxP4=;
        b=SujoeE2pEPbKKbAMRAHkvIed19ebrRLADDCAcFrnBAtla7YHO/WiijXqAuJiF2c+wR
         8xbqC3aB4LaKZwyfMakjNHY8j0AiLkhB1mLCz4ejU/Hz4W6rjqYvAWV805aeXwMxhKaH
         kA5z5T/OKekDrFgLn81ng7hGfC8kUowK4DEUmXMabUa8CWpxZFJ8L7M3AuMTZUXAuPAS
         2uSonWGsR7QpnVMpt8L38+xVSWiOq0wLn3kC3J2B2f4kpnd1Q3gBPONUuv1dqO3GrDHC
         lW9np4icp+fSCIlrF1r6J8l9s1jGNcMj8RqRBlNoHppDOQLZ0/IUim5qFWu7uJSZ2O3k
         KCRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789154334; x=1789759134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vIEx8uU8IqjffSSCDEyJeKQJtwuejUussKszKVj30XA=;
        b=U0eBjAd6s7qNVl3Jb8SnQQD62BwqTaYmcoxudekwRd7XocCkf8+aamTaNEpiFjO9Uj
         Idvy3x+rEfTs77BGDqffmMk+M8I1dfmOaNRvs6+dg+Jeu6hdljqjk2MW1bVnbDaQoQeJ
         1UoCeNm8QJGEj915cqOn+ogLTOO9xMiavkqec4sTGSziSiORGd2X5yHVRlE4fwztmEds
         919pHQZg9cz5Cer6x7xreubEub71Uw8e0jkodd834oTVw8e4uHiMuW89a1aulGq/QCvt
         UrjujLIQQJpwX2Xwtn3q63OyoEDqwz9ecEU9g9VpnvSTE6aA0eNk1KqIM+ejapPQORVY
         2ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789154334; x=1789759134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vIEx8uU8IqjffSSCDEyJeKQJtwuejUussKszKVj30XA=;
        b=aaPPI5IEXjBBfFRreR44cmsTjyNhvgDv2Lbyj0vJeKHtQ6r5ZhrVbMr30WpIyoF/9a
         EwGln9hexL6UHf4LnXDfvnmc0aPXIZWphKcRIonqhy2L4g08EE7XYmpDs0I8VUUnPxym
         O1vyurEHP4zuBwN7CPiMf765y7R+atjDNPh/mXpS6cg657irgssmo6d0rAIoU0bM1xWB
         HAgZ8P8bPiJO9AopftEftl04mynJmk7zZqdx9Ith7gLi/WP6j9RQDOKTEujlz5er1Sqz
         mWHPUwPnJTzi1wFoOn8J/B4wIEeCBivsFO9jsfcoiiwyyAwycuFRvbToEs/wC1vrs+yU
         NVuw==
X-Forwarded-Encrypted: i=1; AKwUvBwaSx7J+hNslFy8NDpRZ9+C1a9glgkbCZMgwKkxYJcychd3mkccVDOU6sEXZfCRay955lDmoDwDPcPEhabI@vger.kernel.org
X-Gm-Message-State: AFuF++mDWyz7sl5ztN3Yca3TmtgDPkUPC1j6F4AOzVZ7xAehRlTwrtMw
	GUuZ0KUwRdynItpry+KYP6EV8aBlefNGmLMpeD5r9ru4jRQlQfTdNUUp3NAU+DvcMhZ++9GZURk
	zjzQktVNYGcqE69MTzv2NOYSTBuH5QoAiZ+zYzkOm
X-Gm-Gg: AYBFou3CVcXgi83PYIs+ppINKxYUodARpK15sY28v5ta4B+5Q8Zy1wi999vuWIJZdmV
	KC+WByKQjgm+WpvtP1ARbGUFItZvH5PeoiWnIKBblgoiZgfOj2Q9EfW96lDu0QN7dHyCjxPLv2K
	1v+TNTG20S5dAJFML073lbdMByfjYAwdbYH1TvNUMAIBkYw6YgJ36eMSLdTb8vgLnOKhd+FpADO
	gvzNPQguJfvgo0uAAK5XP0Pf31RYx0LMlmlFNcinG3IGwf5KpFDiaVzlBUIjo+s4F59HAWKLyj2
	yl0u9RnPBkZXfFsxMUSOFSU3vwwlt/f7wsDbwwyYq+2xovLvWCKhmz/M8E1hi/3BLPKRN2zJadw
	P476wgsj70g==
X-Received: by 2002:ac8:5c85:0:b0:530:4182:5a68 with SMTP id
 d75a77b69052e-530e498be91mr2143731cf.15.1789154332936; Fri, 11 Sep 2026
 12:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-6-surenb@google.com>
 <aqRF4YB7Ijk9PmRM@gremlin> <aqRPeZH4yeYXfWgS@gremlin> <CAJuCfpG-8sQjg2ECiRQpjn9tBj3AfEXnmgmomdfFGS7JoDhZ4w@mail.gmail.com>
 <aqRSvISJtYrt5Gvp@gremlin>
In-Reply-To: <aqRSvISJtYrt5Gvp@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 12:18:41 -0700
X-Gm-Features: AcwNN1WG2bylStI11oz5hgwXcx_h9MCQ-S7zrTZGjslGEl7r32QMSMJo4pyGgXI
Message-ID: <CAJuCfpGvB4o1HrKsi4zbzKNmdxppW_76xJUbaYeE+sN6w-u6UA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] proc/task_mmu: change proc_get_vma() to stop
 returning gate VMA at the end
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:13=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Fri, Sep 11, 2026 at 12:11:55PM -0700, Suren Baghdasaryan wrote:
> > On Fri, Sep 11, 2026 at 12:03=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@ker=
nel.org> wrote:
> > >
> > > On Fri, Sep 11, 2026 at 07:26:49PM +0100, Lorenzo Stoakes (ARM) wrote=
:
> > > > On Thu, Sep 10, 2026 at 04:47:35PM -0700, Suren Baghdasaryan wrote:
> > > > > proc_get_vma() returning gate VMA at the end is desirable for the=
 its
> > > > > current m_start/m_next callers, as they need to report a gate VMA=
 at the
> > > > > end of the address space. This behavior is very specific to these=
 callers
> > > > > and makes proc_get_vma() hard to use for other purposes.
> > > > >
> > > > > Move this usage-specific behavior into the callers themselves so =
that
> > > > > proc_get_vma() returns either a valid VMA, an error or a NULL whe=
n no
> > > > > more VMAs are available. This makes it more generic, simpler and =
usable
> > > > > in the later patches.
> > > > >
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > >
> > > > Yes, very good change, thanks!
> > > >
> > > > Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > >
> > > > > ---
> > > > >  fs/proc/task_mmu.c | 23 ++++++++++++++++++-----
> > > > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > index ecce7ce116cb..9a3c996c1d61 100644
> > > > > --- a/fs/proc/task_mmu.c
> > > > > +++ b/fs/proc/task_mmu.c
> > > > > @@ -236,9 +236,6 @@ static struct vm_area_struct *proc_get_vma(st=
ruct seq_file *m, loff_t *ppos)
> > > > >              * found the extended vma with the same vm_start.
> > > > >              */
> > > > >             *ppos =3D vma->vm_end;
> > > > > -   } else {
> > > > > -           *ppos =3D SENTINEL_VMA_GATE;
> > > > > -           vma =3D get_gate_vma(priv->lock_ctx.mm);
> > > >
> > > > Yeah this is just so confusing as-was.
> > > >
> > > > >     }
> > > > >
> > > > >     return vma;
> > > > > @@ -248,6 +245,7 @@ static void *m_start(struct seq_file *m, loff=
_t *ppos)
> > > > >  {
> > > > >     struct proc_maps_private *priv =3D m->private;
> > > > >     struct proc_maps_locking_ctx *lock_ctx;
> > > > > +   struct vm_area_struct *vma;
> > > > >     loff_t last_addr =3D *ppos;
> > > > >     struct mm_struct *mm;
> > > > >
> > > > > @@ -280,16 +278,31 @@ static void *m_start(struct seq_file *m, lo=
ff_t *ppos)
> > > > >     if (last_addr =3D=3D SENTINEL_VMA_GATE)
> > > > >             return get_gate_vma(mm);
> > > > >
> > > > > -   return proc_get_vma(m, ppos);
> > > > > +   vma =3D proc_get_vma(m, ppos);
> > > > > +   if (vma)
> > > > > +           return vma;
> > > > > +
> > > > > +   /* Return gate VMA at the end */
> > > > > +   *ppos =3D SENTINEL_VMA_GATE;
> > > > > +   return get_gate_vma(mm);
> > > > >  }
> > > > >
> > > > >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> > > > >  {
> > > > > +   struct proc_maps_private *priv =3D m->private;
> > > > > +   struct vm_area_struct *vma;
> > > > > +
> > > > >     if (*ppos =3D=3D SENTINEL_VMA_GATE) {
> > > > >             *ppos =3D SENTINEL_VMA_END;
> > > > >             return NULL;
> > > > >     }
> > > > > -   return proc_get_vma(m, ppos);
> > > > > +   vma =3D proc_get_vma(m, ppos);
> > > > > +   if (vma)
> > > > > +           return vma;
> > > >
> > > > OK so I guess the logic is, iterate through every VMA, then once yo=
u run out,
> > > > report the gate VMA. Makes sense.
> > >
> > > Hmm one thing on this though - m_start() still has:
> > >
> > >         if (last_addr =3D=3D SENTINEL_VMA_GATE)
> > >                 return get_gate_vma(mm);
> > >
> > > As well as:
> > >
> > >         vma =3D proc_get_vma(m, ppos);
> > >         if (vma)
> > >                 return vma;
> > >
> > >         /* Return gate VMA at the end */
> > >         *ppos =3D SENTINEL_VMA_GATE;
> > >         return get_gate_vma(mm);
> > >
> > > Now at the end.
> > >
> > > Is this correct? Is it maybe duplicated now?
> >
> > Yeah, I noticed that too but I it's not duplication. The first check
> > handles the case when right after m_next() hit the end of the address
> > space and set *ppos =3D SENTINEL_VMA_GATE, we ran out of page space and
> > had to flush its content. Once that's done, m_start will be called and
> > last_addr will be set to SENTINEL_VMA_GATE. In that case we should
> > return get_gate_vma() and avoid calling proc_get_vma(). That's what
> > the first check for sentinel is doing. The second one handles the case
> > when m_start() itself readches the end of the address space and has to
> > return SENTINEL_VMA_GATE.
> >
> > It's possible this can be refactored a bit and made cleaner but I
> > would keep that as a separate change.
>
> Maybe just add a comment to the first one to explain when it'll trigger? =
That
> should suffice, cleanups can be separate yes.

Will do. Appreciate the reviews!

I'll post the update today because there is some urgency to backport
these patches and I want to have a public link when backporting but I
don't expect anyone to burn the midnight oil to review the final
version. Have a nice weekend!

>
> >
> > >
> > > >
> > > > > +
> > > > > +   /* Return gate VMA at the end */
> > > > > +   *ppos =3D SENTINEL_VMA_GATE;
> > > > > +   return get_gate_vma(priv->lock_ctx.mm);
> > > > >  }
> > > > >
> > > > >  static void m_stop(struct seq_file *m, void *v)
> > > > > --
> > > > > 2.55.0.1007.g17ff1f9808-goog
> > > > >
> > > >
> > > > --
> > > > Cheers, Lorenzo
> > >
> > > --
> > > Cheers, Lorenzo
>
> --
> Cheers, Lorenzo
