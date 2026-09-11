Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE12EEE6C
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151978; cv=pass; b=Ir8m2gnYNX8aoJ2v7geDw9CDjnGyLlIv8pHY2dnE5LaM+qgJfkGcAx9q+WwrT4qWuHn5jTq9lPbllQw+IKz2/7QhnSk7mQuim64/xwPde7wWyGCokcUexvKZZjxScg/AxcY28VjPgeqp0OWRu53RW84ksGhIimQNX0Mjkh9rpBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151978; c=relaxed/simple;
	bh=Cgpj1qWJ1RnZOPKgwwJvVKoF5HHhj0MpXS92ObJQAuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooDzoRfOvc5chUCxnViy1b8NtzGx+R0o1uCc3Tb6/DEcj3uoNt82fJu/Io+DfF6obDSk/lUxLFSD4p6jJRUtJPLUYmRvK3tcesMTEcqCjhyjmGLNRzSXfpRq+F6yGYJxvCgj08TAw+4rGzn+LkNwOrnM6UjykNbHg2qkt1Ytgfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RH9f90Fe; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RH9f90Fe"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso90681cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 11:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789151976; cv=none;
        d=google.com; s=arc-20260327;
        b=aOlazOg3dlrLNoSGZSVTsCs+EQUPWkGr1CXtCB/oPK0pv3nbV3plcdOQazZ8prIOfN
         7URCAGo2NW/qGp09FlFRCKSkNQMqkXw3DQaiieULTf0tASxHJClWy0GeZVB7RflleW7i
         WHcMdBk+MXKw/+DfQfiMZGCHZba5jPNoiJCy0u3uyJzpMo9qLxi8+Ook6K9fB8cQbpZU
         dRy2tfZTXRPKAn38FO/bmTspevOFAiGCKdC5uhlnQ+9qxcTiOJ54z9xdY2774cxl6qSD
         UBPM+3H19FuMeqr3Nl7NV4TNx6q07pTDe+7BammNGVt3e6BGHhjpPSYhQ0dsljbjiAJG
         ZzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+QDkAqDNHYHbzMD4UzAszEsitYxSsOiRVLmvmyXUE/I=;
        fh=vrdbTyP/CvswBlgeTo+pGnF5xWrfhkUOWkDgJXBM+Kc=;
        b=GF2iEoOp/xB+tcRd960PYW2Y8qIs7fFbM61iggEsJhGMyPNgEGaeKaZ44aRiv26jEV
         5ZaZRikLfBJkSmRYq9hpbGQH1cOgBV/6wtX5kI8Af5y3/TEfuNt8y8MhvuZFe+4akqy/
         cH2JGRlbqwO5SNx/KExmWWyi1CS4JhK+mbZ0xo4wwBsZBivefkNRZSkk7MWyojkqNImV
         I6f7K2t+t74mwzxi7UqH3bh+1OoUSVV3MSSkzLQwcotaRsl82iUEK5ddHdFuC3ohnwhe
         wqCGHJMdRlkzTfbbb2iJMMT7Zo3ckUHXDSWyefLb0OkXIVtKBon1pZlz7e2iLDK/9/73
         yVgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789151976; x=1789756776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+QDkAqDNHYHbzMD4UzAszEsitYxSsOiRVLmvmyXUE/I=;
        b=RH9f90Fef3CONyBuvWikZHY+uezsYtiDKZKiI7vf1JpM+qIDnrifCrn18OWrgWx4BS
         sOBmMyvwchLpF9M/2+SyBNA/wCj3wbCiF2im7I8320iDgZlYPdLDjAgmMF4e2/19J6vY
         AVW0OVdAt5FDKL7LwRbR4hIlx6qRe7jRfIY/NUMs5CpC9tbr2yFoyFxcqpr+SXctiTkI
         Nom1yvlauWTfD3m9wq+VnLEhbTTJS+uH4SxfnIPeTbeDcYnUxe5el9afXUKnIq1uGsNa
         AmUeoNvBFt0yVvls1SerW4YVuIF4PWjZgM2I3jfb/0qO/08oPw+Le+MorCyS21v/bAeN
         ENkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151976; x=1789756776;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QDkAqDNHYHbzMD4UzAszEsitYxSsOiRVLmvmyXUE/I=;
        b=oC5sr6mTjuvXq3HOjFqyX5tITaQpOyqHBJ94EOQ3dordZUkeWZ7Cd449LxMnU4NB6g
         i58Ps0vweDRjet7u3XwQz2m1pm0U14MasmitJAcbypkPgL7E8b6HoFTcVLKEh7bbErFx
         mjbeKOeFi+qRg+z6DBnHRqmw71A1BXqY6agAO93EHecir1ydULU/1/StoIgiQpcN6plZ
         xj3vx8ht3v6Cs27SJaXtUzV7JOQkJFfpqjrI0KQSN/9GFM1gNUcdIscQGE6Wquec7t9J
         oSRmlPhK261RkahD0c/5Y7iC7BKiMGQEH7+ADNjItmRKq0uQQsoDsFnlIRl/oJ8a0DHU
         DzWw==
X-Forwarded-Encrypted: i=1; AKwUvBzIUGEmVBo2wcOVJNlfd7CJKiR4ikIwy5ZvMLGEfL2tfIxDsIZQ71HdAu4HeWdAjA7/g8daAkdKlqliCTHf@vger.kernel.org
X-Gm-Message-State: AFuF++nOfdEZfbT9NfWpsD/f+wlYX+XbbkqZ5PNjgYwU0fYUPL6ueYWS
	qBC6spo1dzvX3X+MF4RT4rrkSXVQrSn+RDsQ8W4mD2nq+Ht64Qfi+bQwOYVSS7UFcADGL4V9aAl
	cc5pbfsS4l3BjRCjiP/HHQSynrKWNh95rfkArWZpv
X-Gm-Gg: AYBFou39x1xqYLeo4yXr38rb9lrQK4MEtwzLHnQjCl1z81Gvq07kfccA71tZ9gyOeE4
	lGnIDngcIFdYjrwDLRhn4TY/eM2jsiV4JcH0qloYNwyB6Hmtt7O4q+n+revAQo15iyW/8k0Tzrc
	tnWPBUmSspWSiyvJNNVp9Sx34W4m3Kb8vQ9vgEfHTLT3skpkbScAPsWyBhxE2fXCtEMLcGijuf7
	BCHP4jr6rqM8UlceWnkQZIH9DUWAWJqzV1tjzT8x7hz1j9W02M1jftKVNsPeHcz4V2Em8cbhxVz
	uBLAFybMZaNZjghpcMzRYdQCAXDgE8b1E7fKiISzMOJPlT1EUfGlUpQkXXoJ/ksX986AJnKfYuy
	EUrHkACA0wQ==
X-Received: by 2002:a05:622a:5218:b0:530:ac23:ff40 with SMTP id
 d75a77b69052e-530e493076bmr1282331cf.5.1789151974931; Fri, 11 Sep 2026
 11:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-6-surenb@google.com>
 <aqRF4YB7Ijk9PmRM@gremlin>
In-Reply-To: <aqRF4YB7Ijk9PmRM@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 11:39:23 -0700
X-Gm-Features: AcwNN1W4dOfkLKGREm-MUH-pM0CR6V-0wgsS0pYyFtiALBPWuaW4-GsVKkWozvE
Message-ID: <CAJuCfpEScgOTK7ymtDrqa52GY-ooeP2boowF=CLpin7hR11iRA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] proc/task_mmu: change proc_get_vma() to stop
 returning gate VMA at the end
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 11:26=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Thu, Sep 10, 2026 at 04:47:35PM -0700, Suren Baghdasaryan wrote:
> > proc_get_vma() returning gate VMA at the end is desirable for the its
> > current m_start/m_next callers, as they need to report a gate VMA at th=
e
> > end of the address space. This behavior is very specific to these calle=
rs
> > and makes proc_get_vma() hard to use for other purposes.
> >
> > Move this usage-specific behavior into the callers themselves so that
> > proc_get_vma() returns either a valid VMA, an error or a NULL when no
> > more VMAs are available. This makes it more generic, simpler and usable
> > in the later patches.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Yes, very good change, thanks!
>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Thanks!

>
> > ---
> >  fs/proc/task_mmu.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index ecce7ce116cb..9a3c996c1d61 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -236,9 +236,6 @@ static struct vm_area_struct *proc_get_vma(struct s=
eq_file *m, loff_t *ppos)
> >                * found the extended vma with the same vm_start.
> >                */
> >               *ppos =3D vma->vm_end;
> > -     } else {
> > -             *ppos =3D SENTINEL_VMA_GATE;
> > -             vma =3D get_gate_vma(priv->lock_ctx.mm);
>
> Yeah this is just so confusing as-was.
>
> >       }
> >
> >       return vma;
> > @@ -248,6 +245,7 @@ static void *m_start(struct seq_file *m, loff_t *pp=
os)
> >  {
> >       struct proc_maps_private *priv =3D m->private;
> >       struct proc_maps_locking_ctx *lock_ctx;
> > +     struct vm_area_struct *vma;
> >       loff_t last_addr =3D *ppos;
> >       struct mm_struct *mm;
> >
> > @@ -280,16 +278,31 @@ static void *m_start(struct seq_file *m, loff_t *=
ppos)
> >       if (last_addr =3D=3D SENTINEL_VMA_GATE)
> >               return get_gate_vma(mm);
> >
> > -     return proc_get_vma(m, ppos);
> > +     vma =3D proc_get_vma(m, ppos);
> > +     if (vma)
> > +             return vma;
> > +
> > +     /* Return gate VMA at the end */
> > +     *ppos =3D SENTINEL_VMA_GATE;
> > +     return get_gate_vma(mm);
> >  }
> >
> >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> >  {
> > +     struct proc_maps_private *priv =3D m->private;
> > +     struct vm_area_struct *vma;
> > +
> >       if (*ppos =3D=3D SENTINEL_VMA_GATE) {
> >               *ppos =3D SENTINEL_VMA_END;
> >               return NULL;
> >       }
> > -     return proc_get_vma(m, ppos);
> > +     vma =3D proc_get_vma(m, ppos);
> > +     if (vma)
> > +             return vma;
>
> OK so I guess the logic is, iterate through every VMA, then once you run =
out,
> report the gate VMA. Makes sense.

Yes, correct.

>
> > +
> > +     /* Return gate VMA at the end */
> > +     *ppos =3D SENTINEL_VMA_GATE;
> > +     return get_gate_vma(priv->lock_ctx.mm);
> >  }
> >
> >  static void m_stop(struct seq_file *m, void *v)
> > --
> > 2.55.0.1007.g17ff1f9808-goog
> >
>
> --
> Cheers, Lorenzo
