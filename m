Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D591A554083
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155865; cv=pass; b=VS8CVyP46AyzLTYXGgZFfgYkkx9UKyimV1F5IB/znKa+DFLJImYrTpFRCoH/xW0lZgBwi9autvKaSh/I5EBPZGGZEmyMru4DTLzsGDwY3hOE/aEzn9jkSAD/QiESmo3J8ga5DQmbm0oyYCK6f2JgRH+quWPtepyMgViAWuchkLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155865; c=relaxed/simple;
	bh=yL8N+Dja9aiOO1BJi3EdMBCJn64BdAU1/IDpItLrdro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3Uul0qNIV44n2I4NcbYa3Phu0cXNhL0bPVBhUk780VgcXbQKdSk0fybT/r0N8m/lGhu5BUEhdbnBkjEiyKXt/EKVpombHDDKv7q8bhLSz5ZX/ZrdUJrvOXB4qMhyQhpASPq4oHdu5nXWUGACzdDFeTEpK9Gv0CZR58bNL+onVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVrFG5k0; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVrFG5k0"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so112471cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789155856; cv=none;
        d=google.com; s=arc-20260327;
        b=HsyAh1YfZdzwi9UMKTuIpeIxdcO+dDzWMec6T1aAPLRSu4WetF+ehun66Y5FiI2CEE
         1eNIXVo3upIWeXiW9txP35173QDPNvOucTc2fXz7neE8Oe6wAjGzI0G6hk74ZzKDqtk9
         hQYTvqucReEIW8LCZiUJxiYfTJPTqbweMfjgmmY33hQTr/RdiuV97vhrnFpdlzmAJRmh
         28CIU2wHXLwUAj3NqCxgURqjStrQbDQ/dxmM091KRdT4z7bD2Bv5xfnnJLU9q5OqGW+j
         EHnr6YOpTbotmFI6oNjuYphP9eFs/bGAlRjgRQn4tyFXlAoWR1KcUCsum70jjXHbWmSU
         vOcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kN0XHRUDweJ1/OhG2mXDTF4VMn4i+usHL3piKE2cuME=;
        fh=iBInWbGizrm/MBjNPyoqNI8116pOdzYh7c/nJfqppE8=;
        b=ny3cu/2G7nwsj7OU+KitVF0Aw3V5ZT0s1iKGfe1PkRnHhAQAfxbOgoXy1PnkYCPu9L
         ODkuPKrUOi0sPhCDcbvsPTzlmT5nHgwN9nHLEnMNMn2DNrYTAbe14grNxqZK3DL6Mhpp
         k/390U4DF2J5qlMT9LzDQFhEQtWxhCT+9uZmVzoicwMEgN0hni1cxdpp0qDFudsjl1Ts
         dnsZgIWJvKOK7/vw6tu9Lhdce2fzBb89hkDmBbigaeN3/TgUMy0LMhjWIVWcuZPO27hX
         LXossIyN+kI0beqKoRODApkMpb+femMYuOn9NE92IWoDQsUmEYBO0dW12QCYDVw1o6Hw
         dVUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789155856; x=1789760656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kN0XHRUDweJ1/OhG2mXDTF4VMn4i+usHL3piKE2cuME=;
        b=RVrFG5k0rrqQEYT28pPsbQWSH2A0LQXhYbFzrhkzf/px8bBNFOBTv3A4Ti/iSYfTiy
         gBl9ZVXQAa2mA0NobpLW8UiofcXHbzrwjeOuBXj/muGX0IcqH8SZ5Pnw1B/osViveBtq
         42I36Fv0ocPICXDveUJg1DpujDD7z8WNiEwQinu6sC/jPnLFEL2JxbaqilyVZASUrjAz
         Up31Kg3pcg4U4A4LngWCbILbiRX6rkH2UbUvOSzD6JKcGn1TyoyStqrclHXwx02iZM6X
         zZWNoULsQBHxrBTG5VitZlocSawOY3Cx2nUYeLmiIA4k+ZJnqq79XZZjQKnCghvzCKZu
         BSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155856; x=1789760656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kN0XHRUDweJ1/OhG2mXDTF4VMn4i+usHL3piKE2cuME=;
        b=cnNyAThmGjwqlOaUFsoz54r3FLYtfAdrP7QUq/yaw/d0nbSsue6hCIkGrApSanEOy9
         xPGkgFgsEW1zRPuObV/SWH8NlgZvavmrm8KKU3xGsK0e1Pg0r+SeD61+3h08lB40uFvN
         n9R5ICD1u0uQajSVRzSw7h4/qystuXnUCrK2POmBC/7djRavREMAM7kYzofYEZ6T6cdB
         BsUjQr/L0lbexnqtSV8HdrRt4PpPMgc5XWAxb/iOk40w+ayJyZL/EAX1J6RsBZOks9Ra
         Hg1tuUXMP2lwq+8qbpaq/oIy6PKR0Npgc6iaSQVn0vtrm5ct4Iq/OA8TSFnPTe7vYg0I
         LYEg==
X-Forwarded-Encrypted: i=1; AKwUvBz2q5VNfl34cSIjph2GlpAqKNpc4SJO2+9QErLONxPSprjtUO/6lGtUUo/Tn4/D2ihTNjW53djKBCjBtD8s@vger.kernel.org
X-Gm-Message-State: AFuF++mQ+FwSlMKXMoFU7hbJNFlmYTBVxkBSl8d+5Wk32Fqj8WxEEe89
	yaH637nEPOQz5/ORnhNlj7wC/xfgxj71Hzq6PN1tGUjmSa2wyHhKOj+kKNrWzBeYrLli1j8qRHV
	gtH8LhIwB2QRuIiw9bw+l+5aJH8lVHMuIbk+/DXIU
X-Gm-Gg: AYBFou0T2EgzIJSRTbQqSaRAOJeG0vCIerrJ4idJqfscws4OngItUFplbRwLSm5XByj
	wX1q7RlJwHLQNzVCrOu1mcE1KNhN+4l7vr42KdxvKkJkIlyePJ0fvJTDGGHLWrffyP/BU1MYX+m
	G1DmjF8hlkQFRhyu/1WzgIKONLqahM7nE7bj0LpSM3EThMC+ESy/Kr2q2D+HN2nVGo0v6bF48Uc
	xqMnIBmTzXDhJVkye0OAjX3OkHv1SQUBjj3G0eVhe4NTkAG5z9LFhmuIgS7pLNt9ytpjdQ7m2yT
	2iu/gmnToMmnFwJo/svhc18OQKK9HA/MUVt92wkUg9X05PntisBrkQY6xdp6/WgYfxrAufP9zaQ
	LatKgvs8JAo4=
X-Received: by 2002:a05:622a:cc:b0:52f:9ed4:8d74 with SMTP id
 d75a77b69052e-530e475171amr2444781cf.14.1789155855913; Fri, 11 Sep 2026
 12:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-6-surenb@google.com>
 <aqRF4YB7Ijk9PmRM@gremlin> <aqRPeZH4yeYXfWgS@gremlin> <CAJuCfpG-8sQjg2ECiRQpjn9tBj3AfEXnmgmomdfFGS7JoDhZ4w@mail.gmail.com>
 <aqRSvISJtYrt5Gvp@gremlin> <CAJuCfpGvB4o1HrKsi4zbzKNmdxppW_76xJUbaYeE+sN6w-u6UA@mail.gmail.com>
 <aqRVzecC23YpZeh0@gremlin>
In-Reply-To: <aqRVzecC23YpZeh0@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 12:44:04 -0700
X-Gm-Features: AcwNN1WZAK4AhrgJSaOV-mvzjDcNBoqfmvSShEkPZAg297uHKBFoNS2-TUHAzeE
Message-ID: <CAJuCfpGOR5X6R2NwASMFwp=UtWCCDn64OJNEmzbMh9DDmn2d4Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] proc/task_mmu: change proc_get_vma() to stop
 returning gate VMA at the end
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:26=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Fri, Sep 11, 2026 at 12:18:41PM -0700, Suren Baghdasaryan wrote:
> > On Fri, Sep 11, 2026 at 12:13=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@ker=
nel.org> wrote:
> > >
> > > On Fri, Sep 11, 2026 at 12:11:55PM -0700, Suren Baghdasaryan wrote:
> > > > On Fri, Sep 11, 2026 at 12:03=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs=
@kernel.org> wrote:
> > > > >
> > > > > On Fri, Sep 11, 2026 at 07:26:49PM +0100, Lorenzo Stoakes (ARM) w=
rote:
> > > > > > On Thu, Sep 10, 2026 at 04:47:35PM -0700, Suren Baghdasaryan wr=
ote:
> > > > > > > proc_get_vma() returning gate VMA at the end is desirable for=
 the its
> > > > > > > current m_start/m_next callers, as they need to report a gate=
 VMA at the
> > > > > > > end of the address space. This behavior is very specific to t=
hese callers
> > > > > > > and makes proc_get_vma() hard to use for other purposes.
> > > > > > >
> > > > > > > Move this usage-specific behavior into the callers themselves=
 so that
> > > > > > > proc_get_vma() returns either a valid VMA, an error or a NULL=
 when no
> > > > > > > more VMAs are available. This makes it more generic, simpler =
and usable
> > > > > > > in the later patches.
> > > > > > >
> > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > >
> > > > > > Yes, very good change, thanks!
> > > > > >
> > > > > > Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > > > >
> > > > > > > ---
> > > > > > >  fs/proc/task_mmu.c | 23 ++++++++++++++++++-----
> > > > > > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > > > index ecce7ce116cb..9a3c996c1d61 100644
> > > > > > > --- a/fs/proc/task_mmu.c
> > > > > > > +++ b/fs/proc/task_mmu.c
> > > > > > > @@ -236,9 +236,6 @@ static struct vm_area_struct *proc_get_vm=
a(struct seq_file *m, loff_t *ppos)
> > > > > > >              * found the extended vma with the same vm_start.
> > > > > > >              */
> > > > > > >             *ppos =3D vma->vm_end;
> > > > > > > -   } else {
> > > > > > > -           *ppos =3D SENTINEL_VMA_GATE;
> > > > > > > -           vma =3D get_gate_vma(priv->lock_ctx.mm);
> > > > > >
> > > > > > Yeah this is just so confusing as-was.
> > > > > >
> > > > > > >     }
> > > > > > >
> > > > > > >     return vma;
> > > > > > > @@ -248,6 +245,7 @@ static void *m_start(struct seq_file *m, =
loff_t *ppos)
> > > > > > >  {
> > > > > > >     struct proc_maps_private *priv =3D m->private;
> > > > > > >     struct proc_maps_locking_ctx *lock_ctx;
> > > > > > > +   struct vm_area_struct *vma;
> > > > > > >     loff_t last_addr =3D *ppos;
> > > > > > >     struct mm_struct *mm;
> > > > > > >
> > > > > > > @@ -280,16 +278,31 @@ static void *m_start(struct seq_file *m=
, loff_t *ppos)
> > > > > > >     if (last_addr =3D=3D SENTINEL_VMA_GATE)
> > > > > > >             return get_gate_vma(mm);
> > > > > > >
> > > > > > > -   return proc_get_vma(m, ppos);
> > > > > > > +   vma =3D proc_get_vma(m, ppos);
> > > > > > > +   if (vma)
> > > > > > > +           return vma;
> > > > > > > +
> > > > > > > +   /* Return gate VMA at the end */
> > > > > > > +   *ppos =3D SENTINEL_VMA_GATE;
> > > > > > > +   return get_gate_vma(mm);
> > > > > > >  }
> > > > > > >
> > > > > > >  static void *m_next(struct seq_file *m, void *v, loff_t *ppo=
s)
> > > > > > >  {
> > > > > > > +   struct proc_maps_private *priv =3D m->private;
> > > > > > > +   struct vm_area_struct *vma;
> > > > > > > +
> > > > > > >     if (*ppos =3D=3D SENTINEL_VMA_GATE) {
> > > > > > >             *ppos =3D SENTINEL_VMA_END;
> > > > > > >             return NULL;
> > > > > > >     }
> > > > > > > -   return proc_get_vma(m, ppos);
> > > > > > > +   vma =3D proc_get_vma(m, ppos);
> > > > > > > +   if (vma)
> > > > > > > +           return vma;
> > > > > >
> > > > > > OK so I guess the logic is, iterate through every VMA, then onc=
e you run out,
> > > > > > report the gate VMA. Makes sense.
> > > > >
> > > > > Hmm one thing on this though - m_start() still has:
> > > > >
> > > > >         if (last_addr =3D=3D SENTINEL_VMA_GATE)
> > > > >                 return get_gate_vma(mm);
> > > > >
> > > > > As well as:
> > > > >
> > > > >         vma =3D proc_get_vma(m, ppos);
> > > > >         if (vma)
> > > > >                 return vma;
> > > > >
> > > > >         /* Return gate VMA at the end */
> > > > >         *ppos =3D SENTINEL_VMA_GATE;
> > > > >         return get_gate_vma(mm);
> > > > >
> > > > > Now at the end.
> > > > >
> > > > > Is this correct? Is it maybe duplicated now?
> > > >
> > > > Yeah, I noticed that too but I it's not duplication. The first chec=
k
> > > > handles the case when right after m_next() hit the end of the addre=
ss
> > > > space and set *ppos =3D SENTINEL_VMA_GATE, we ran out of page space=
 and
> > > > had to flush its content. Once that's done, m_start will be called =
and
> > > > last_addr will be set to SENTINEL_VMA_GATE. In that case we should
> > > > return get_gate_vma() and avoid calling proc_get_vma(). That's what
> > > > the first check for sentinel is doing. The second one handles the c=
ase
> > > > when m_start() itself readches the end of the address space and has=
 to
> > > > return SENTINEL_VMA_GATE.
> > > >
> > > > It's possible this can be refactored a bit and made cleaner but I
> > > > would keep that as a separate change.
> > >
> > > Maybe just add a comment to the first one to explain when it'll trigg=
er? That
> > > should suffice, cleanups can be separate yes.
> >
> > Will do. Appreciate the reviews!
> >
> > I'll post the update today because there is some urgency to backport
> > these patches and I want to have a public link when backporting but I
> > don't expect anyone to burn the midnight oil to review the final
> > version. Have a nice weekend!
>
> Well you have tags on most things from me now so it'll only be one patch =
I
> think? That'll be missing mine anyway.

Yep, thanks!

Posted v4 at https://lore.kernel.org/all/20260911194145.1781926-1-surenb@go=
ogle.com/
and the only patch missing your stamp is
https://lore.kernel.org/all/20260911194145.1781926-4-surenb@google.com/

>
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +   /* Return gate VMA at the end */
> > > > > > > +   *ppos =3D SENTINEL_VMA_GATE;
> > > > > > > +   return get_gate_vma(priv->lock_ctx.mm);
> > > > > > >  }
> > > > > > >
> > > > > > >  static void m_stop(struct seq_file *m, void *v)
> > > > > > > --
> > > > > > > 2.55.0.1007.g17ff1f9808-goog
> > > > > > >
> > > > > >
> > > > > > --
> > > > > > Cheers, Lorenzo
> > > > >
> > > > > --
> > > > > Cheers, Lorenzo
> > >
> > > --
> > > Cheers, Lorenzo
>
> --
> Cheers, Lorenzo
