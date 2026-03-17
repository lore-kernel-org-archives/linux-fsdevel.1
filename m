Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F839282B
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783153; cv=pass; b=dA9UFx8EeU8g/xJSLvT57REVvFxs3efOceNea0gV0U9OpBjh8vnXIVYhy6Kl5Rx8IdXWYcZTZ+oDZIZZREUQ6Fg9enkHDujd6vR9rf5otO49PrLNaS3BaFFYxXA51ElDe1mgycDvg6RSAF0UiLBm4qaiTvmwIBoSLZtFof9tgUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783153; c=relaxed/simple;
	bh=amSdOF8iP43yuio3xfh7J21wSaqCQ2v/F+hUcALmjDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FM+CJY9zH738uYtZK0r+BBTmLwLL3WqZ6ZQapJIUvyb/zGrJ7Ab6mjUUTVeScR5he2Q8/uTGA66fsSe1mQdlb9ToUYIuwTfPInjZpiHIz4o+ia5uOx0htuo6hKFoP7vLBN59Y1l3XQU0yVVjGstKLNNLMcKHkdr/sJIfaqFPcX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9ZcXAed; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9ZcXAed"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5091ed02c54so88891cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 14:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773783149; cv=none;
        d=google.com; s=arc-20240605;
        b=C4UAm3UFjYM9L3DgFfRmCkyBdw3WfmudS3mkEyQzVbsD36zhfhMJLsjHcZANfoTFrH
         cfcZU0tgk+ua8YaiveYYmC0NgWZdRBdDk+TVvHxtLyJe6PbqpQrHJL+uS13ytPnTh5Jl
         G+nfJXuFCIvMFGvZq7Qe05uOa2ComztJfdDP5Aqcq4SatyDItgcxgblPpLWBrhIXgknL
         3RwaLDY33xqthibkSqa3NoR/iEn4pSBVcKlPN3zk2vxHEGPwaxU651v0NBCO2tp8fa4h
         yJtD3McewaI03YKK4JamkIAX59OLCxTYJ0bKU6/80hUV56RJT/z/JnNHxO3AOyxDLmea
         OnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eaVVTt78dt2IOUr/WJrEfVNvHIkRI9uCxJf+IAlfUTo=;
        fh=U3lqxJL0tLrGS8Yp+/ILdrThdWeVZe1+8yduIbcqlA0=;
        b=QEPpSns9QaqdzU83qUvEzErYm1r694FfLEJD7PHIg//vmRqjiYvPL6lJdFAmxrl9u8
         CmWtfI5jqwV1irgyFAZYSexf2inFHC1yuW2AUZHBK7rWKYg946HNpZyqtxJWOOSDTIK6
         pDiQ4lmDVDp7ZcDNO4RjLkJB/7GkwmvtGuLiuZ6rC16v/iP5EtE7bJtsX2gc8IOUPFP1
         Ru5sgk4serD7HbHJCk8pctVvapL/oQrA0dT0Dyt+0IxXaWyAqmB0MnJS9pmlFOtZp26A
         dcP4cBr5ooYdTFuSs2nb+109AyFPQlmXOR+x0RS/ebKCzp7DrP8TTP1W14nTos/YAvXW
         Uk+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773783149; x=1774387949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaVVTt78dt2IOUr/WJrEfVNvHIkRI9uCxJf+IAlfUTo=;
        b=A9ZcXAedtBA37VJ4Oq7nTy8F7ZmNiAG6IT3pgFvi+CJ83OstmjsjzzCgzIXAKUyVne
         3HQAf4rWY+IGjQMXBG/PPRQ6FhqZP7iXBkhKVUGg5zbLTI4NYLGgQFpHBQ3hV6KUF6w8
         Ij+/eXT4MZLE91S5l7w65sg6A3toIsczJuGiGpVAnmXpXoxEJotPW6/ugabO2rveSKKC
         sTSo821St7+g6zI+Z3x9w0UlySp7EJ/eDzDT0d2RIa3PC3SuPtWdULr3g6j8CGgo3cBG
         GvTe4aY19g2elueq1kGENMPkEY27T3Lo/gNeoHpPAngyDrt/fLnDHCiMwjZeHACq0+Sh
         3glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773783149; x=1774387949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eaVVTt78dt2IOUr/WJrEfVNvHIkRI9uCxJf+IAlfUTo=;
        b=Wh/9d2mAn+GMhRC+2WApHIQfRnfCWlxM5tZJ0yeMC1INTg9oyBSP46H0A6NODIBaH3
         3kqerToXU6NwMLzPqSqSmNX53+N5OrlxMKBSK8OnrO7X9VkH23/4+TUfUeDcSazpH9+Q
         4Uh650/WvdMBZM0Hecp+/zHQvAk7o1ajQUqeNs7JP+9dzehWP1Wkq5ZEi8tYvrpIZ211
         fpBJ8+WQ6zuAzVFnSKDwDyPZxZ4kWBJSacBG1Cu3a3OVx2kiCmLinoO87MHkd+hqhp6f
         uyCeS3NTh/Ct9AiWfontEp8rgDe29PEYaglCEBxJbmEWyjZo51u0tIgDlMGTsXWUWDAS
         cLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNI4g7d5o9V+/CeC3XpAyGsKwOL+NRTQs5HmjEcndwSkIcZRYWuQSt6dO0bR+kNxcWOgWD8sDlLdLZkQpj@vger.kernel.org
X-Gm-Message-State: AOJu0YxVP5+1PnaydtLQ8U5AwIRviSLDZT+J2XhDnr9pxELPM7QHTgpg
	Ldpl+rRo4s+IO86J4kBDU7bfshJj9Ypf67lk6z6ebEPisfTubtiZQkrR0b1yDzr1S+gSCuuTHFs
	E0u358uzmQlCCrD8KBRI4508umVKsDmtIIQ+PJSYA
X-Gm-Gg: ATEYQzwycBuWtgjkF/xofocF3MxnGxzuGH5EA9n/1jSDISAW9OoqDBxNZRnd3E3J81g
	HcWkvC0yqVmkNZPt5arctG7Q5ly1RmCIoSA10hCCLJJvKaEcHGOTS8B4GU8guD06zp3DmBktQKl
	3GwaQEPuY7JNy6iF7KU58B5FWxX8myEcxbA7AtY7yGBUpIPGeOCAgA7n8Lu0GC4qwnUtGrjfQ2S
	FLg6tWTrXd65XNcoVYGM25iKEEoy3sDIuYcMB9x+7sMxtQFy5O1ytMrdffT5vINEjaBaD9q1lh/
	Dlr8UH5uOLr9DQszhZ3QzD/EmF0VbRFZKEuzDg==
X-Received: by 2002:a05:622a:1a9b:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-50b1480564fmr4695911cf.8.1773783147340; Tue, 17 Mar 2026
 14:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773695307.git.ljs@kernel.org> <48c6d25e374b57dba6df4fdddd4830d3fc1105be.1773695307.git.ljs@kernel.org>
 <CAJuCfpFXuHg4KPY27pqMC-xV5y9ZY2W72_R8_rxO0DvrJ=_yvw@mail.gmail.com>
In-Reply-To: <CAJuCfpFXuHg4KPY27pqMC-xV5y9ZY2W72_R8_rxO0DvrJ=_yvw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 17 Mar 2026 14:32:16 -0700
X-Gm-Features: AaiRm50LOaxRG8hnm9GByPrpi5KQ-jnLdYLBR44IEnVyj1qDMmlGA-pMovuTqLE
Message-ID: <CAJuCfpE5qZmi43EeZiRcy78pD6YvJb5n_xnoUJfwEjomowu0=A@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] staging: vme_user: replace deprecated mmap hook
 with mmap_prepare
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Bodo Stroesser <bostroesser@gmail.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
	linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 2:26=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Mar 16, 2026 at 2:14=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@ker=
nel.org> wrote:
> >
> > The f_op->mmap interface is deprecated, so update driver to use its
> > successor, mmap_prepare.
> >
> > The driver previously used vm_iomap_memory(), so this change replaces i=
t
> > with its mmap_prepare equivalent, mmap_action_simple_ioremap().
> >
> > Functions that wrap mmap() are also converted to wrap mmap_prepare()
> > instead.
> >
> > Also update the documentation accordingly.
> >
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > ---
> >  Documentation/driver-api/vme.rst    |  2 +-
> >  drivers/staging/vme_user/vme.c      | 20 +++++------
> >  drivers/staging/vme_user/vme.h      |  2 +-
> >  drivers/staging/vme_user/vme_user.c | 51 +++++++++++++++++------------
> >  4 files changed, 42 insertions(+), 33 deletions(-)
> >
> > diff --git a/Documentation/driver-api/vme.rst b/Documentation/driver-ap=
i/vme.rst
> > index c0b475369de0..7111999abc14 100644
> > --- a/Documentation/driver-api/vme.rst
> > +++ b/Documentation/driver-api/vme.rst
> > @@ -107,7 +107,7 @@ The function :c:func:`vme_master_read` can be used =
to read from and
> >
> >  In addition to simple reads and writes, :c:func:`vme_master_rmw` is pr=
ovided to
> >  do a read-modify-write transaction. Parts of a VME window can also be =
mapped
> > -into user space memory using :c:func:`vme_master_mmap`.
> > +into user space memory using :c:func:`vme_master_mmap_prepare`.
> >
> >
> >  Slave windows
> > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/=
vme.c
> > index f10a00c05f12..7220aba7b919 100644
> > --- a/drivers/staging/vme_user/vme.c
> > +++ b/drivers/staging/vme_user/vme.c
> > @@ -735,9 +735,9 @@ unsigned int vme_master_rmw(struct vme_resource *re=
source, unsigned int mask,
> >  EXPORT_SYMBOL(vme_master_rmw);
> >
> >  /**
> > - * vme_master_mmap - Mmap region of VME master window.
> > + * vme_master_mmap_prepare - Mmap region of VME master window.
> >   * @resource: Pointer to VME master resource.
> > - * @vma: Pointer to definition of user mapping.
> > + * @desc: Pointer to descriptor of user mapping.
> >   *
> >   * Memory map a region of the VME master window into user space.
> >   *
> > @@ -745,12 +745,13 @@ EXPORT_SYMBOL(vme_master_rmw);
> >   *         resource or -EFAULT if map exceeds window size. Other gener=
ic mmap
> >   *         errors may also be returned.
> >   */
> > -int vme_master_mmap(struct vme_resource *resource, struct vm_area_stru=
ct *vma)
> > +int vme_master_mmap_prepare(struct vme_resource *resource,
> > +                           struct vm_area_desc *desc)
> >  {
> > +       const unsigned long vma_size =3D vma_desc_size(desc);
> >         struct vme_bridge *bridge =3D find_bridge(resource);
> >         struct vme_master_resource *image;
> >         phys_addr_t phys_addr;
> > -       unsigned long vma_size;
> >
> >         if (resource->type !=3D VME_MASTER) {
> >                 dev_err(bridge->parent, "Not a master resource\n");
> > @@ -758,19 +759,18 @@ int vme_master_mmap(struct vme_resource *resource=
, struct vm_area_struct *vma)
> >         }
> >
> >         image =3D list_entry(resource->entry, struct vme_master_resourc=
e, list);
> > -       phys_addr =3D image->bus_resource.start + (vma->vm_pgoff << PAG=
E_SHIFT);
> > -       vma_size =3D vma->vm_end - vma->vm_start;
> > +       phys_addr =3D image->bus_resource.start + (desc->pgoff << PAGE_=
SHIFT);
> >
> >         if (phys_addr + vma_size > image->bus_resource.end + 1) {
> >                 dev_err(bridge->parent, "Map size cannot exceed the win=
dow size\n");
> >                 return -EFAULT;
> >         }
> >
> > -       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> > -
> > -       return vm_iomap_memory(vma, phys_addr, vma->vm_end - vma->vm_st=
art);
> > +       desc->page_prot =3D pgprot_noncached(desc->page_prot);
> > +       mmap_action_simple_ioremap(desc, phys_addr, vma_size);
> > +       return 0;
> >  }
> > -EXPORT_SYMBOL(vme_master_mmap);
> > +EXPORT_SYMBOL(vme_master_mmap_prepare);
> >
> >  /**
> >   * vme_master_free - Free VME master window
> > diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/=
vme.h
> > index 797e9940fdd1..b6413605ea49 100644
> > --- a/drivers/staging/vme_user/vme.h
> > +++ b/drivers/staging/vme_user/vme.h
> > @@ -151,7 +151,7 @@ ssize_t vme_master_read(struct vme_resource *resour=
ce, void *buf, size_t count,
> >  ssize_t vme_master_write(struct vme_resource *resource, void *buf, siz=
e_t count, loff_t offset);
> >  unsigned int vme_master_rmw(struct vme_resource *resource, unsigned in=
t mask, unsigned int compare,
> >                             unsigned int swap, loff_t offset);
> > -int vme_master_mmap(struct vme_resource *resource, struct vm_area_stru=
ct *vma);
> > +int vme_master_mmap_prepare(struct vme_resource *resource, struct vm_a=
rea_desc *desc);
> >  void vme_master_free(struct vme_resource *resource);
> >
> >  struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route);
> > diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_=
user/vme_user.c
> > index d95dd7d9190a..11e25c2f6b0a 100644
> > --- a/drivers/staging/vme_user/vme_user.c
> > +++ b/drivers/staging/vme_user/vme_user.c
> > @@ -446,24 +446,14 @@ static void vme_user_vm_close(struct vm_area_stru=
ct *vma)
> >         kfree(vma_priv);
> >  }
> >
> > -static const struct vm_operations_struct vme_user_vm_ops =3D {
> > -       .open =3D vme_user_vm_open,
> > -       .close =3D vme_user_vm_close,
> > -};
> > -
> > -static int vme_user_master_mmap(unsigned int minor, struct vm_area_str=
uct *vma)
> > +static int vme_user_vm_mapped(unsigned long start, unsigned long end, =
pgoff_t pgoff,
> > +                             const struct file *file, void **vm_privat=
e_data)
> >  {
> > -       int err;
> > +       const unsigned int minor =3D iminor(file_inode(file));
> >         struct vme_user_vma_priv *vma_priv;
> >
> >         mutex_lock(&image[minor].mutex);
> >
> > -       err =3D vme_master_mmap(image[minor].resource, vma);
> > -       if (err) {
> > -               mutex_unlock(&image[minor].mutex);
> > -               return err;
> > -       }
> > -
>
> Ok, this changes the set of the operations performed under image[minor].m=
utex.
> Before we had:
>
> mutex_lock(&image[minor].mutex);
> vme_master_mmap();
> <some final adjustments>
> mutex_unlock(&image[minor].mutex);
>
> Now we have:
>
> mutex_lock(&image[minor].mutex);
> vme_master_mmap_prepare()
> mutex_unlock(&image[minor].mutex);
> vm_iomap_memory();
> mutex_lock(&image[minor].mutex);
> vme_user_vm_mapped(); // <some final adjustments>
> mutex_unlock(&image[minor].mutex);
>
> I think as long as image[minor] does not change while we are not
> holding the mutex we should be safe, and looking at the code it seems
> to be the case. But I'm not familiar with this driver and might be
> wrong. Worth double-checking.

A side note: if we had to hold the mutex across all those operations I
think we would need to take the mutex in the vm_ops->mmap_prepare and
add a vm_ops->map_failed hook or something along that line to drop the
mutex in case mmap_action_complete() fails. Not sure if we will have
such cases though...

>
> >         vma_priv =3D kmalloc_obj(*vma_priv);
> >         if (!vma_priv) {
> >                 mutex_unlock(&image[minor].mutex);
> > @@ -472,22 +462,41 @@ static int vme_user_master_mmap(unsigned int mino=
r, struct vm_area_struct *vma)
> >
> >         vma_priv->minor =3D minor;
> >         refcount_set(&vma_priv->refcnt, 1);
> > -       vma->vm_ops =3D &vme_user_vm_ops;
> > -       vma->vm_private_data =3D vma_priv;
> > -
> > +       *vm_private_data =3D vma_priv;
> >         image[minor].mmap_count++;
> >
> >         mutex_unlock(&image[minor].mutex);
> > -
> >         return 0;
> >  }
> >
> > -static int vme_user_mmap(struct file *file, struct vm_area_struct *vma=
)
> > +static const struct vm_operations_struct vme_user_vm_ops =3D {
> > +       .mapped =3D vme_user_vm_mapped,
> > +       .open =3D vme_user_vm_open,
> > +       .close =3D vme_user_vm_close,
> > +};
> > +
> > +static int vme_user_master_mmap_prepare(unsigned int minor,
> > +                                       struct vm_area_desc *desc)
> > +{
> > +       int err;
> > +
> > +       mutex_lock(&image[minor].mutex);
> > +
> > +       err =3D vme_master_mmap_prepare(image[minor].resource, desc);
> > +       if (!err)
> > +               desc->vm_ops =3D &vme_user_vm_ops;
> > +
> > +       mutex_unlock(&image[minor].mutex);
> > +       return err;
> > +}
> > +
> > +static int vme_user_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > -       unsigned int minor =3D iminor(file_inode(file));
> > +       const struct file *file =3D desc->file;
> > +       const unsigned int minor =3D iminor(file_inode(file));
> >
> >         if (type[minor] =3D=3D MASTER_MINOR)
> > -               return vme_user_master_mmap(minor, vma);
> > +               return vme_user_master_mmap_prepare(minor, desc);
> >
> >         return -ENODEV;
> >  }
> > @@ -498,7 +507,7 @@ static const struct file_operations vme_user_fops =
=3D {
> >         .llseek =3D vme_user_llseek,
> >         .unlocked_ioctl =3D vme_user_unlocked_ioctl,
> >         .compat_ioctl =3D compat_ptr_ioctl,
> > -       .mmap =3D vme_user_mmap,
> > +       .mmap_prepare =3D vme_user_mmap_prepare,
> >  };
> >
> >  static int vme_user_match(struct vme_dev *vdev)
> > --
> > 2.53.0
> >
