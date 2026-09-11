Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F9437463
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153937; cv=pass; b=JDLNVqv0npNKuJ6cLH4hrK0bfWmWkKWV22PGjQwWqaNweHm2E/yhBp0LZSnh0Ty0iINVf0fKK7qXwheraeQOyCdvzRTGGWysG1uevVSF97KyOKuqjYFDWrLBDhoPhlSWGV7QnjCZIZXlMQZixvn83G0LmvZ3bQ2xAgUPPSGlPFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153937; c=relaxed/simple;
	bh=cc4a1xNspTXolJI0WCSfnRxb8CzbRjDQYh/QAFhczu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+FP1I1eFkPoKnaDrjvO1blGknxbTiFIsWAJF+ZwAGiq4wx8Kppv3Mb5StxjcHp+YT8i6QohTFqTmSdLh2+o5yq1x8KjkKS2iAkdDc/s6L1aH2Lt6PjBeOETpcF6qAwWC+sBC5mWls5QM+m1HbsX51OKsdf7KKo4cUJfjepDY1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nC3eAX3v; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nC3eAX3v"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5306706e89dso101301cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789153928; cv=none;
        d=google.com; s=arc-20260327;
        b=jgze6SV8PX5A1ocbLDIWUfeu5aP+KbokFabqw05k2TG4/MyuNY4KQaW5xv+EHn7qsH
         r2Gg/0tZHrwP8C2ZsZ/SgvfDLt5jWTRLkXVuyBvwPcJSn0wi1w+zbxWtMgIsjcqXxi3S
         4a7n++fzwqd/oADz2sNIA+4eFXnP0W+Kh/V9gokvJlQMQi50SZ8PIdeQQXDaRfZn+XAc
         atTgdQvv1ZuCh+zUp/ODaqAzV9YOm2eYq7+eJggRaUW/BfQffZKrdVjo4gp3ATcq7GSY
         sTUQVx48q3UYMKISDRrSpQosAr/q7HKYSY72uEBHti7WZqjNUxWn2FeXqwaqayF4H7gU
         nSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=saJSQNQB4V5HEb80TKj8yYWIyI7Lc38n7nBGhE1SZ5s=;
        fh=0zfwgFrWdXwlqBInsZMCBrggHdx+HXYnl6uh4DUhJnk=;
        b=mzvEBQw6IWDWqnnJ450FFFaYoGtNAH2OEvrYnyhGEePkbV15tsv+diNq/1I0yUB4u7
         WV6fHFJyQoBbBdoiE7O5zdOBCoNbuhyTtuUgt0s6p7VpvQtdMrEGCl0320j9GyWc2cCg
         hS0T3DAyvDo8JCZ/vCIArJMDZkmSGkUxyobYIpaQthiOwrpXQuoGI7ZW3PDRS3L700Ac
         CaB5kDwBzREKlzbHtB8N5mtIy0rKbYDFJdHSbW5enPKiyZPhDr2/GSHSZ4puLm0+bfQo
         dvegwzllPkak/FQjPONZo1qGLqBrBeahf4sNADrZ5WYtXsK1cuJG9LeC+rAAWfdXHvZq
         0B+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789153928; x=1789758728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=saJSQNQB4V5HEb80TKj8yYWIyI7Lc38n7nBGhE1SZ5s=;
        b=nC3eAX3vi7jYS79Vmf5jwl0NlwRV8sFLiXZr8ZcODSszFi+1QxgD3X+1z/e05ixClZ
         1kl5fMOP/iWUXPR7/EsHp1aSnrDDqK2s2F7Mw7O57mcogkp9wC2idd97V7rweCSZSKDT
         r947gAIw7UscgU/8IVaszrxTMKMAzeFqKKAhHhBm3KZAkHjtfzmBtxLQiN/My0VLg2Pm
         mMEH+vDE1Qzlrc9Ss+dI+ksrpegXnl3YJ2nDTa6y6DHMukiQA4cKWWvEYalXX44iJduV
         hc2HLpvxW/PjTVSOnjDNKydVnwLcpEEZAKEUVSSTDqQqgIONCWaBYoxIpqehIgTxsM5j
         RkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153928; x=1789758728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=saJSQNQB4V5HEb80TKj8yYWIyI7Lc38n7nBGhE1SZ5s=;
        b=qhzVoCuZNjG1ufVkDin9yxp/0j2JpHu+DP2u6ss8xuO7r5AFA6KqowXKoOxrGOHGVo
         czov/2e5Nj1t00cQGUZ+q+gC5ocQyqQQSGzDJoM1Ax0IVuVzTgCJajqQoctVcE+GXYbZ
         c36Qa9WzJ1cZq59pc6ujod5RZYx/qA6/cOIRarDDM1puPxIw/bIYd/mgyRW9fHRSKU4x
         HnDV+GdKh0F2GKYm259sFbgXcqj4rwn0dkZhDyATnL24F8s4nSP9zztl/YjUZKFXxRQF
         HsASHs8Aq14sZuicfnrhYUSwbB7isIWGGPLaCPX+oFcxid4pOPLa9GvEBF1OYfpzX7DZ
         dzBw==
X-Forwarded-Encrypted: i=1; AKwUvBzSLY4v1sM8M09ikSsrk2ZT9HqokvsRisGOb4jHJ+DS+eGEjaMUXHkDBpxm6+vyGFKa4BsPq2VXPS12Yzbs@vger.kernel.org
X-Gm-Message-State: AFuF++mdk0U0yZuoE465DPmH5yw3YXjZrlJI+WJPYqJXGYJOjf04pwOQ
	35Wsl5kXqPyVE6SB1JUEuzVoIPGnb8ukPk1UlnEu/T8NrQ2XOVhQVwQq3Yoj0jPsuk9Qi94lKgL
	0Nu+HcX1mw8ccBWjSsK/L3C/I2ERWe+pmddy5sLrM
X-Gm-Gg: AYBFou2CnMSAjBGaHhE1elkwkmM8Rke2NWUYCYoCP2l3KbPx7dRvA2mOO1fiqeEFJBN
	XyKfpa1eD65CPaIBckYj/giJBBHEOy4z+/2kkSyEjmkfQ4Ye+2qb8P4945K9GS79zBqW/gzgdY3
	57m/l1U6ltWcgFaqYcZpxZqGTw8aO2S+cL2u8azWAsLREqXX+bPLqox4X3jE39Cx4mJsesISAVl
	cgRFdfCV6AlcBH5BbYsLxpXGzD+kS3We+DyFJiErPUDUc+0d4tdIgNxsUbLG/CuRTyFMonW+Zjm
	W/Ls+HhFFK9rSJHmwj1OqnMzlWxC+/+SW1qAWIGhFO59RM4B+b99+mWRu8gv63Y07uZIu4B6mTl
	ZIz1iqH+drw==
X-Received: by 2002:a05:622a:4d94:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-530e492ef32mr2365241cf.3.1789153927778; Fri, 11 Sep 2026
 12:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-6-surenb@google.com>
 <aqRF4YB7Ijk9PmRM@gremlin> <aqRPeZH4yeYXfWgS@gremlin>
In-Reply-To: <aqRPeZH4yeYXfWgS@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 12:11:55 -0700
X-Gm-Features: AcwNN1Wy-CE4ovXulpkIU8FXd9kbfWYedpTSzKiPANojbqSxgWkXPeoHYX3MZto
Message-ID: <CAJuCfpG-8sQjg2ECiRQpjn9tBj3AfEXnmgmomdfFGS7JoDhZ4w@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] proc/task_mmu: change proc_get_vma() to stop
 returning gate VMA at the end
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:03=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Fri, Sep 11, 2026 at 07:26:49PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Sep 10, 2026 at 04:47:35PM -0700, Suren Baghdasaryan wrote:
> > > proc_get_vma() returning gate VMA at the end is desirable for the its
> > > current m_start/m_next callers, as they need to report a gate VMA at =
the
> > > end of the address space. This behavior is very specific to these cal=
lers
> > > and makes proc_get_vma() hard to use for other purposes.
> > >
> > > Move this usage-specific behavior into the callers themselves so that
> > > proc_get_vma() returns either a valid VMA, an error or a NULL when no
> > > more VMAs are available. This makes it more generic, simpler and usab=
le
> > > in the later patches.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Yes, very good change, thanks!
> >
> > Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > > ---
> > >  fs/proc/task_mmu.c | 23 ++++++++++++++++++-----
> > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index ecce7ce116cb..9a3c996c1d61 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -236,9 +236,6 @@ static struct vm_area_struct *proc_get_vma(struct=
 seq_file *m, loff_t *ppos)
> > >              * found the extended vma with the same vm_start.
> > >              */
> > >             *ppos =3D vma->vm_end;
> > > -   } else {
> > > -           *ppos =3D SENTINEL_VMA_GATE;
> > > -           vma =3D get_gate_vma(priv->lock_ctx.mm);
> >
> > Yeah this is just so confusing as-was.
> >
> > >     }
> > >
> > >     return vma;
> > > @@ -248,6 +245,7 @@ static void *m_start(struct seq_file *m, loff_t *=
ppos)
> > >  {
> > >     struct proc_maps_private *priv =3D m->private;
> > >     struct proc_maps_locking_ctx *lock_ctx;
> > > +   struct vm_area_struct *vma;
> > >     loff_t last_addr =3D *ppos;
> > >     struct mm_struct *mm;
> > >
> > > @@ -280,16 +278,31 @@ static void *m_start(struct seq_file *m, loff_t=
 *ppos)
> > >     if (last_addr =3D=3D SENTINEL_VMA_GATE)
> > >             return get_gate_vma(mm);
> > >
> > > -   return proc_get_vma(m, ppos);
> > > +   vma =3D proc_get_vma(m, ppos);
> > > +   if (vma)
> > > +           return vma;
> > > +
> > > +   /* Return gate VMA at the end */
> > > +   *ppos =3D SENTINEL_VMA_GATE;
> > > +   return get_gate_vma(mm);
> > >  }
> > >
> > >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> > >  {
> > > +   struct proc_maps_private *priv =3D m->private;
> > > +   struct vm_area_struct *vma;
> > > +
> > >     if (*ppos =3D=3D SENTINEL_VMA_GATE) {
> > >             *ppos =3D SENTINEL_VMA_END;
> > >             return NULL;
> > >     }
> > > -   return proc_get_vma(m, ppos);
> > > +   vma =3D proc_get_vma(m, ppos);
> > > +   if (vma)
> > > +           return vma;
> >
> > OK so I guess the logic is, iterate through every VMA, then once you ru=
n out,
> > report the gate VMA. Makes sense.
>
> Hmm one thing on this though - m_start() still has:
>
>         if (last_addr =3D=3D SENTINEL_VMA_GATE)
>                 return get_gate_vma(mm);
>
> As well as:
>
>         vma =3D proc_get_vma(m, ppos);
>         if (vma)
>                 return vma;
>
>         /* Return gate VMA at the end */
>         *ppos =3D SENTINEL_VMA_GATE;
>         return get_gate_vma(mm);
>
> Now at the end.
>
> Is this correct? Is it maybe duplicated now?

Yeah, I noticed that too but I it's not duplication. The first check
handles the case when right after m_next() hit the end of the address
space and set *ppos =3D SENTINEL_VMA_GATE, we ran out of page space and
had to flush its content. Once that's done, m_start will be called and
last_addr will be set to SENTINEL_VMA_GATE. In that case we should
return get_gate_vma() and avoid calling proc_get_vma(). That's what
the first check for sentinel is doing. The second one handles the case
when m_start() itself readches the end of the address space and has to
return SENTINEL_VMA_GATE.

It's possible this can be refactored a bit and made cleaner but I
would keep that as a separate change.

>
> >
> > > +
> > > +   /* Return gate VMA at the end */
> > > +   *ppos =3D SENTINEL_VMA_GATE;
> > > +   return get_gate_vma(priv->lock_ctx.mm);
> > >  }
> > >
> > >  static void m_stop(struct seq_file *m, void *v)
> > > --
> > > 2.55.0.1007.g17ff1f9808-goog
> > >
> >
> > --
> > Cheers, Lorenzo
>
> --
> Cheers, Lorenzo
