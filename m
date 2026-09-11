Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F1B55D876
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155950; cv=pass; b=VG2lyi8r9R1RMkez2k2tX1p7H7BBs93ZGrOqNEYtTZn3D9dN0g7zt4EslaxRwZiq645dpBPvoQDVC8WXJsou2nmvRrdm0gVGXN5koShhtGcGq7ROsEdB1DFC7EaFXOYAzyT9/w+geQi+Qp8GU3Ttydp6C8WO3D2dhSTHEbk+gBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155950; c=relaxed/simple;
	bh=t6bnlkEkq0x3EDRE+pMdPsgc03pbQO6nQ+JtRlR0Jq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXLPRztkS9rkts1yL5h89EK8Iu/VSTUhvsXns5HuskCP2Er5Idr08Rxxz7RSEb+kYXemSyDmUIYRd2/Hoa4+E8hMSXlxZ1HnHBz1Js9GB/u20Ajfy7gCDQwe7oSHnYi5f6hP/uPdarNzViQO+kEXjsyMbTYwz9ZHBJhoSVGMLBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3l3Qu1J; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3l3Qu1J"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d5fc2cd8so102021cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789155921; cv=none;
        d=google.com; s=arc-20260327;
        b=B+n+ciBhiFdVT9CM6dg+nWjxYgJ7yuqUfE/JMrIf5Pt4Nif6i9m1WHS7BcN7EuwL7B
         Y0o/ARgdUesYs93B1GkCptSm1/i/4L2x/BGrMScJc8uPk3AwkvJ1HY1RdTPrlQMPtjSP
         zvMZjvDyDIYuXDMHwzXWQsXToONq22+1YUr0Hx2dYs/gVHB9L/WMSZqsMjWfKNREZyZE
         w2ewcRMUIt/gEbs/uqxlKgjfIn4+6nVIC88d5vVZQUomT8d83+j2lTIA4a8uJmBiv/So
         obiyep24UYZNyutJ1Aqz9H07QQknCmNSh0uaqYcIRDgznabGPMhT7dtRl8YQQT1wwN4z
         YiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pGrPjSb9GRO+ZgaFFa5EElvDumbPFInkcUYffxOe9sg=;
        fh=EFhdyb9je5EN8VawTI6THLBSPvKW97F/y4yyXYLKT4s=;
        b=jU8jBD9rGci3NpmTR9+dOK2Ph0qhSljDKDjde+rWIdxgzlGPW3SeHgSvOpeG+pFDUg
         oGhDNF0SWrrGGDhjYaGrKH8IdIH4zp5XXEGMRtkBeH1mNIVRvgz3PUpQEKpH8UGNiQFW
         bIdIwR/vQIgpWrqA5QHks+m/UX3KduH0AcnyFzJD/BJv5C+xQzEBX7VrOz0ZpZoOtowF
         a9775QiT1QvXRQVVP5ruEBtQC1GLtIKyPvbcjoi9pfESYOPcuWabjld32jELnoPK5FXa
         dqgUiqObEN26Jg9egM/36jK98SmNqT7H1c6cw2172hjpqlQO0L0siSc7AcDGYf9YQard
         NJLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789155921; x=1789760721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pGrPjSb9GRO+ZgaFFa5EElvDumbPFInkcUYffxOe9sg=;
        b=M3l3Qu1Jy2fDlJe8N6QfIj2S/tfnyMy2/LrKFuG4OyIh3+AnsSNfDWcGbe4O4g9x+p
         Qwoo7qpw++4JKPLBkrNpJdC3fFe8OWbXPwAJyXjJ027TCHht0FDZ2LjuY+hMos3deSwx
         qVtzynd6iygHNyqPf5K/EwZpZ5yi1eIG/p9ePCAUrac+B0A9Q/xho59aLrEEIWA6cLts
         lVOlVEaCDSNfneqoF1NF6lM4MV5dduEXapZ7W1vlF0xUtPGzuDHzXEXjTCe0hBnqXZ50
         si8IHzyVBRSZKDjpvwgrMnAi4F7+PasgPmEViconVjZvbqxxVAEi1M3XELYPJrA2fxrU
         m8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155921; x=1789760721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGrPjSb9GRO+ZgaFFa5EElvDumbPFInkcUYffxOe9sg=;
        b=qnFse92ZEuTOuK8gfPYQV+c/svehJRxYMf209mnlO3svQRiBdrLVtvSiGks6Ku6oCe
         MdlY9TaORoXvWmg02VYp4E8sJZudbMiOwrKqC4j4aKei92DLqTxs/7Ck4q6FGjXVggyC
         gR/qr4oCl6ycDXo2wwJ/NWStJYzZuh9OJtv1xZ4u38qz7wvWwoG+9e055EQShI4gfuAz
         cXmKm/6ZjGByDaKN+pnNWDeZ4i+4VqU0v98GQ9q2eV7pEghzJxJ7gkP1hYMC6aow2QLT
         lMPDzOutZt3bubVkMoHt9pI/XxHVnsovFWlJpSZtwhg63whAKEEEYH5FXMjsClz6/7LZ
         mtDA==
X-Forwarded-Encrypted: i=1; AKwUvByVetTFUNJejunz5vMrnhKKk/aAF6p55KeslJmpMbEYw7zLLqUpjJ/u6LAi51/UxVBY29ZiM6nOROj3DS9N@vger.kernel.org
X-Gm-Message-State: AFuF++mpCB/vYL2G8SQxxvp8ucVihSmBIKwPI79Nbiwy8eFApRmc2fvf
	rBl9hs3avKbtnpUX8vebn6Ja0m5GwwpRiOAuoX3opup3DQBLyGrby+nbuMAuWW8GOeU9BlsKquv
	VcbYBnITsIQvB2CWQQafMvTANIrQrYctcmDQlwog1
X-Gm-Gg: AYBFou2O+KOhg/azpyRLetLJ9IBnneWMxQh6BXthTllC8J0UTLPjZ2fNA4Uc8pS4++L
	rTWnXWFlRi4o43jgPz7d2dRawrgjiudSX5PIPAXKNAllpJ3spJ80Wxm3rZy5+1IWmSQ+cVpQOoT
	GrGx/lQYA2KQQsrJBlZ6NpPxzCFrHm13/8epXHlNv8nVEQq4c/HGR2qT7V9VW095yM3IQtKgAFu
	KfIMC0700rhVZYqDLT0YFd4Go27DNGlYTubjlm/Nb4eCRu55vrKaQoFa5IhcUyUWenMPvnWGS9I
	d04mC+Iv2mzyVrlAgFyT9edKzEs2m5JYdIca7sM+BpYaqo0RsdlUIwB3jfE8Y5GZCAejm/KcLA6
	JsX5JC1RaUQ==
X-Received: by 2002:a05:622a:87:b0:530:d9fc:253d with SMTP id
 d75a77b69052e-530e46521edmr2823151cf.6.1789155920731; Fri, 11 Sep 2026
 12:45:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-6-surenb@google.com>
 <aqRF4YB7Ijk9PmRM@gremlin> <aqRPeZH4yeYXfWgS@gremlin> <CAJuCfpG-8sQjg2ECiRQpjn9tBj3AfEXnmgmomdfFGS7JoDhZ4w@mail.gmail.com>
 <aqRSvISJtYrt5Gvp@gremlin> <CAJuCfpGvB4o1HrKsi4zbzKNmdxppW_76xJUbaYeE+sN6w-u6UA@mail.gmail.com>
 <aqRVzecC23YpZeh0@gremlin> <CAJuCfpGOR5X6R2NwASMFwp=UtWCCDn64OJNEmzbMh9DDmn2d4Q@mail.gmail.com>
In-Reply-To: <CAJuCfpGOR5X6R2NwASMFwp=UtWCCDn64OJNEmzbMh9DDmn2d4Q@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 12:45:09 -0700
X-Gm-Features: AcwNN1V3wd_DRFhQoDAVPV55rR1lWbHmfqoCJKHGvI1cpuMNSdgNmX8FA14BwPI
Message-ID: <CAJuCfpH0bDKabXqPRTQ0vHVeVwNZ9K2qgtwaJcCJD7v0ua-ZaQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] proc/task_mmu: change proc_get_vma() to stop
 returning gate VMA at the end
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:44=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Fri, Sep 11, 2026 at 12:26=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kerne=
l.org> wrote:
> >
> > On Fri, Sep 11, 2026 at 12:18:41PM -0700, Suren Baghdasaryan wrote:
> > > On Fri, Sep 11, 2026 at 12:13=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@k=
ernel.org> wrote:
> > > >
> > > > On Fri, Sep 11, 2026 at 12:11:55PM -0700, Suren Baghdasaryan wrote:
> > > > > On Fri, Sep 11, 2026 at 12:03=E2=80=AFPM Lorenzo Stoakes (ARM) <l=
js@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Sep 11, 2026 at 07:26:49PM +0100, Lorenzo Stoakes (ARM)=
 wrote:
> > > > > > > On Thu, Sep 10, 2026 at 04:47:35PM -0700, Suren Baghdasaryan =
wrote:
> > > > > > > > proc_get_vma() returning gate VMA at the end is desirable f=
or the its
> > > > > > > > current m_start/m_next callers, as they need to report a ga=
te VMA at the
> > > > > > > > end of the address space. This behavior is very specific to=
 these callers
> > > > > > > > and makes proc_get_vma() hard to use for other purposes.
> > > > > > > >
> > > > > > > > Move this usage-specific behavior into the callers themselv=
es so that
> > > > > > > > proc_get_vma() returns either a valid VMA, an error or a NU=
LL when no
> > > > > > > > more VMAs are available. This makes it more generic, simple=
r and usable
> > > > > > > > in the later patches.
> > > > > > > >
> > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > >
> > > > > > > Yes, very good change, thanks!
> > > > > > >
> > > > > > > Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > > > > >
> > > > > > > > ---
> > > > > > > >  fs/proc/task_mmu.c | 23 ++++++++++++++++++-----
> > > > > > > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > > > > index ecce7ce116cb..9a3c996c1d61 100644
> > > > > > > > --- a/fs/proc/task_mmu.c
> > > > > > > > +++ b/fs/proc/task_mmu.c
> > > > > > > > @@ -236,9 +236,6 @@ static struct vm_area_struct *proc_get_=
vma(struct seq_file *m, loff_t *ppos)
> > > > > > > >              * found the extended vma with the same vm_star=
t.
> > > > > > > >              */
> > > > > > > >             *ppos =3D vma->vm_end;
> > > > > > > > -   } else {
> > > > > > > > -           *ppos =3D SENTINEL_VMA_GATE;
> > > > > > > > -           vma =3D get_gate_vma(priv->lock_ctx.mm);
> > > > > > >
> > > > > > > Yeah this is just so confusing as-was.
> > > > > > >
> > > > > > > >     }
> > > > > > > >
> > > > > > > >     return vma;
> > > > > > > > @@ -248,6 +245,7 @@ static void *m_start(struct seq_file *m=
, loff_t *ppos)
> > > > > > > >  {
> > > > > > > >     struct proc_maps_private *priv =3D m->private;
> > > > > > > >     struct proc_maps_locking_ctx *lock_ctx;
> > > > > > > > +   struct vm_area_struct *vma;
> > > > > > > >     loff_t last_addr =3D *ppos;
> > > > > > > >     struct mm_struct *mm;
> > > > > > > >
> > > > > > > > @@ -280,16 +278,31 @@ static void *m_start(struct seq_file =
*m, loff_t *ppos)
> > > > > > > >     if (last_addr =3D=3D SENTINEL_VMA_GATE)
> > > > > > > >             return get_gate_vma(mm);
> > > > > > > >
> > > > > > > > -   return proc_get_vma(m, ppos);
> > > > > > > > +   vma =3D proc_get_vma(m, ppos);
> > > > > > > > +   if (vma)
> > > > > > > > +           return vma;
> > > > > > > > +
> > > > > > > > +   /* Return gate VMA at the end */
> > > > > > > > +   *ppos =3D SENTINEL_VMA_GATE;
> > > > > > > > +   return get_gate_vma(mm);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static void *m_next(struct seq_file *m, void *v, loff_t *p=
pos)
> > > > > > > >  {
> > > > > > > > +   struct proc_maps_private *priv =3D m->private;
> > > > > > > > +   struct vm_area_struct *vma;
> > > > > > > > +
> > > > > > > >     if (*ppos =3D=3D SENTINEL_VMA_GATE) {
> > > > > > > >             *ppos =3D SENTINEL_VMA_END;
> > > > > > > >             return NULL;
> > > > > > > >     }
> > > > > > > > -   return proc_get_vma(m, ppos);
> > > > > > > > +   vma =3D proc_get_vma(m, ppos);
> > > > > > > > +   if (vma)
> > > > > > > > +           return vma;
> > > > > > >
> > > > > > > OK so I guess the logic is, iterate through every VMA, then o=
nce you run out,
> > > > > > > report the gate VMA. Makes sense.
> > > > > >
> > > > > > Hmm one thing on this though - m_start() still has:
> > > > > >
> > > > > >         if (last_addr =3D=3D SENTINEL_VMA_GATE)
> > > > > >                 return get_gate_vma(mm);
> > > > > >
> > > > > > As well as:
> > > > > >
> > > > > >         vma =3D proc_get_vma(m, ppos);
> > > > > >         if (vma)
> > > > > >                 return vma;
> > > > > >
> > > > > >         /* Return gate VMA at the end */
> > > > > >         *ppos =3D SENTINEL_VMA_GATE;
> > > > > >         return get_gate_vma(mm);
> > > > > >
> > > > > > Now at the end.
> > > > > >
> > > > > > Is this correct? Is it maybe duplicated now?
> > > > >
> > > > > Yeah, I noticed that too but I it's not duplication. The first ch=
eck
> > > > > handles the case when right after m_next() hit the end of the add=
ress
> > > > > space and set *ppos =3D SENTINEL_VMA_GATE, we ran out of page spa=
ce and
> > > > > had to flush its content. Once that's done, m_start will be calle=
d and
> > > > > last_addr will be set to SENTINEL_VMA_GATE. In that case we shoul=
d
> > > > > return get_gate_vma() and avoid calling proc_get_vma(). That's wh=
at
> > > > > the first check for sentinel is doing. The second one handles the=
 case
> > > > > when m_start() itself readches the end of the address space and h=
as to
> > > > > return SENTINEL_VMA_GATE.
> > > > >
> > > > > It's possible this can be refactored a bit and made cleaner but I
> > > > > would keep that as a separate change.
> > > >
> > > > Maybe just add a comment to the first one to explain when it'll tri=
gger? That
> > > > should suffice, cleanups can be separate yes.
> > >
> > > Will do. Appreciate the reviews!
> > >
> > > I'll post the update today because there is some urgency to backport
> > > these patches and I want to have a public link when backporting but I
> > > don't expect anyone to burn the midnight oil to review the final
> > > version. Have a nice weekend!
> >
> > Well you have tags on most things from me now so it'll only be one patc=
h I
> > think? That'll be missing mine anyway.
>
> Yep, thanks!
>
> Posted v4 at https://lore.kernel.org/all/20260911194145.1781926-1-surenb@=
google.com/
> and the only patch missing your stamp is
> https://lore.kernel.org/all/20260911194145.1781926-4-surenb@google.com/

Oh, and this one:
https://lore.kernel.org/all/20260911194145.1781926-5-surenb@google.com/

These were kinda related.

>
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > > +
> > > > > > > > +   /* Return gate VMA at the end */
> > > > > > > > +   *ppos =3D SENTINEL_VMA_GATE;
> > > > > > > > +   return get_gate_vma(priv->lock_ctx.mm);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static void m_stop(struct seq_file *m, void *v)
> > > > > > > > --
> > > > > > > > 2.55.0.1007.g17ff1f9808-goog
> > > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Cheers, Lorenzo
> > > > > >
> > > > > > --
> > > > > > Cheers, Lorenzo
> > > >
> > > > --
> > > > Cheers, Lorenzo
> >
> > --
> > Cheers, Lorenzo
