Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD25389E18
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780409; cv=pass; b=TmbJGnjdg9o/pM4XC04iFKtKrMZjeLpLgP14vohwIN80h1j7/Qjr2bQcjiRFpdTpyQ2u046L/Lg9n5xiNAGR7Wu9HFCXID/5HK7F8ZZTJkxqLZmirR36q3ySTcYrMadzy6hyMdYKkZY5o0fFquOjrzJkQxCdiE201CGa8cNznV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780409; c=relaxed/simple;
	bh=RK/TCms+LvhqFMYFVVVIbiPX2SpvDGczeYFrHJlFfsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwMbLWDHTyq8V5nWzvvm55V0C8C8vJ5Z87uAbHe00qdIrNSBzvyUpp6ImNA5IfDt9v0BWvbWVtwrSz4imx1mMFQnOzVSUDdPutnInszHOlxQqg3owoBH+ona/udObROKPajjh7Ev7Ft+QEd0BBAo6iAfcpBDbi7eMylXzTvaFB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R7wwizPP; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7wwizPP"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50906a98ffeso149881cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 13:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773780407; cv=none;
        d=google.com; s=arc-20240605;
        b=Z/WNdHBN6gY5PTuDopsKIV4dOWgNzs0+qX6hasnp9KqFETDHGeT2SMLoBt0KpwiwyU
         kfPjCzULrJIlJ87mCevGKUOyy2F4jLhWL3G3AdhNSVeZbJCwJ+d2hS75KqbhdSmOiLO6
         zATjHCU53fI0DQM1dK9t3nlcUwN69ey/DV7LccHux6NaRY6/n+txhwwUoUJYJAu6mPlR
         8BW7OOylCUFBv9yGyQB1g4XBR56GTxwGxMsE59EMXo4SiIEcyaJDWICBCYoAGsnf4jR4
         zDBwtEWYt49VL409hvJmFWGlo/p+3wXkqlcPS25gCEmx8TjvebGr/gpFv9OQ6l+xBj2I
         750w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=puh87Pmz2QIedt98QmYFqHshzK8OJIco1FTLmkjNO+s=;
        fh=YIqZfZC9zDOdjBrP/WXf1YP7LueS0WU3B6FOWjFA78w=;
        b=FvSlVJUQ7fksqQqIdJuug8t1yNGAgxrpza7RTT5/gU+h4775vu2zhh2/YlQ9ihG0ZP
         Fs00aJvWPyuFbgqW0YwcbcuTLyCWY+n8nhfjp576dW6jGSQNYAFZaxOmMDTOem2vZI1b
         7YyBiGbL2swyRenjiuzoOAHX+7P6Lntkg/xF4KG8axdCbOxoqDVIIM90V2VTMJ+pgZRA
         u7FJo3ckakj/K3txeKOUD9V4tZPF86m3X3I/vM2xvrwJGeVX/MAaFZf6IsWv4ggQmUEc
         ZBC/uYAnrd6t3cDLK23fprvQA8F4/cbU9fIbd+lLCKObh1tawmzlRedU+N3mJ4blHuw9
         efJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773780407; x=1774385207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puh87Pmz2QIedt98QmYFqHshzK8OJIco1FTLmkjNO+s=;
        b=R7wwizPP7dIx2oPvncRf5HBKNPKyAaVPKVkYmDRMxz0B46r+fPFmPBqna9GPZ7ifl7
         GOGmPQyLNsC2D+dHxvnj7L/nFYjMYOX/uN2un6bKHtLyQrbLVqro2DG8Ns+L/uuYldfE
         gNofHLRtSGWY0uigMa2awoJOlXvX33szc5mINax+vPuq3Ur9RwutTYt236NNI2+CUi3X
         E58UFuY+bM2rUL4cDdcWDsoQ0JMcMkNqMWLGvVCYMiyoT5pQQ8PhyXwZdT/Yu9SnPTWA
         LWmqRfmCDhx+tlZKoAYQILEY1NepardJAzZxu3KxNP0moF+PWsxvbPQLNCg2f9UKMTCx
         YrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773780407; x=1774385207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=puh87Pmz2QIedt98QmYFqHshzK8OJIco1FTLmkjNO+s=;
        b=gmsid+s4E2UyO8wNieqs0LEOnH0tSQzUcGJKOPi1Zi5dsX5IBovZudltfWyNEdsPIp
         dfd4YA34jN7e4Wgvnqj6rsBvKIZnOfT4QDmVlBgAluOxJYC7pYURq2YsjB5/61gksBut
         0JoIBzcu+Q1xHJ3QEjajdJ0qNbZzPmKyHHfw32o1j51bAHB4xBZS+Qr5LEj5pYKVBP7M
         GIMFoKROVmKbezUqYY9PaZB9/wRWDk/givS2uzSozrVon65DOUXYCcyoytW/A+MDhf4Q
         Eo0yEQPyjxGN3Nv6TQWUNVjCM0/Ge0aVdj7CgfR2z0NamgI8+hC2kJajPz70BGt2xv2B
         QsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVyDJfQeIrA9TtQVQO+OT46Gy73cyryv/a6ArQ8IeWlcrALmRedvsrVU7isyu8MimxKf2yjOqgOVm1N1ua@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGNlCmkLBbh0lh7BjL82KUWYnQndbdqhR0YB8UZV5aVf6/VMc
	TPgC4DEatPDe7MBDOfyfkRdhI0rDWMzUt8lzPYv5NkJsQGwLPYUJaXBzbwkHxPAujl7xIQIRbv2
	davZGwDL2jGnH4k7c7MTAi09D6pPyZb+vR7QXoMcH
X-Gm-Gg: ATEYQzwtiPv1FArLBcx5gRR0S/4jtAx9bMjc4WzUq+Hv9qpv2y5csKu1sA3oraoVK3a
	Ejh+QCv/sM4v9xcnsG6i8dm0Ll4ynlZwFbKfKwvlEBMQdnougs6qDAvgaGKN2gSE268K9Dwyefp
	crEUJuzv2ajfHn1gBO//4WfWbRFeBXpWrcweukZGkicVK7zngUGe8T1ROdKMz/P2NJr31N+4uCI
	V1fXBbYE6MXloauxUWpFcR/jwDwPotXybsVhQ0d8cuQpHuhgjPv4HUhXtiiAlRIp8cC2/xyOX3H
	Akg6yhgAUPAEuQPfQqWbWDB5XmPpHckWHExzbw==
X-Received: by 2002:a05:622a:130f:b0:509:371:f2ab with SMTP id
 d75a77b69052e-50b14848d70mr3924821cf.16.1773780406374; Tue, 17 Mar 2026
 13:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773695307.git.ljs@kernel.org> <d34056a65bd387286f4e155d52449106ddc99f78.1773695307.git.ljs@kernel.org>
In-Reply-To: <d34056a65bd387286f4e155d52449106ddc99f78.1773695307.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 17 Mar 2026 13:46:34 -0700
X-Gm-Features: AaiRm50ZSv0JOBEsyaTpLpUZLAlSOUqng_UaLNmSO0lPuUbLHyEvRlv0uikpAUM
Message-ID: <CAJuCfpH653zdE=mXArpx8BUszVVC1PoN+rvp+WxdM3aAUbpqRw@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] stm: replace deprecated mmap hook with mmap_prepare
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

On Mon, Mar 16, 2026 at 2:14=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> The f_op->mmap interface is deprecated, so update driver to use its
> successor, mmap_prepare.
>
> The driver previously used vm_iomap_memory(), so this change replaces it
> with its mmap_prepare equivalent, mmap_action_simple_ioremap().
>
> Also, in order to correctly maintain reference counting, add a
> vm_ops->mapped callback to increment the reference count when successfull=
y
> mapped.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  drivers/hwtracing/stm/core.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index 37584e786bb5..f48c6a8a0654 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -666,6 +666,16 @@ static ssize_t stm_char_write(struct file *file, con=
st char __user *buf,
>         return count;
>  }
>
> +static int stm_mmap_mapped(unsigned long start, unsigned long end, pgoff=
_t pgoff,
> +                          const struct file *file, void **vm_private_dat=
a)
> +{
> +       struct stm_file *stmf =3D file->private_data;
> +       struct stm_device *stm =3D stmf->stm;
> +
> +       pm_runtime_get_sync(&stm->dev);
> +       return 0;
> +}
> +
>  static void stm_mmap_open(struct vm_area_struct *vma)
>  {
>         struct stm_file *stmf =3D vma->vm_file->private_data;
> @@ -684,12 +694,14 @@ static void stm_mmap_close(struct vm_area_struct *v=
ma)
>  }
>
>  static const struct vm_operations_struct stm_mmap_vmops =3D {
> +       .mapped =3D stm_mmap_mapped,
>         .open   =3D stm_mmap_open,
>         .close  =3D stm_mmap_close,
>  };
>
> -static int stm_char_mmap(struct file *file, struct vm_area_struct *vma)
> +static int stm_char_mmap_prepare(struct vm_area_desc *desc)
>  {
> +       struct file *file =3D desc->file;
>         struct stm_file *stmf =3D file->private_data;
>         struct stm_device *stm =3D stmf->stm;
>         unsigned long size, phys;
> @@ -697,10 +709,10 @@ static int stm_char_mmap(struct file *file, struct =
vm_area_struct *vma)
>         if (!stm->data->mmio_addr)
>                 return -EOPNOTSUPP;
>
> -       if (vma->vm_pgoff)
> +       if (desc->pgoff)
>                 return -EINVAL;
>
> -       size =3D vma->vm_end - vma->vm_start;
> +       size =3D vma_desc_size(desc);
>
>         if (stmf->output.nr_chans * stm->data->sw_mmiosz !=3D size)
>                 return -EINVAL;
> @@ -712,13 +724,12 @@ static int stm_char_mmap(struct file *file, struct =
vm_area_struct *vma)
>         if (!phys)
>                 return -EINVAL;
>
> -       pm_runtime_get_sync(&stm->dev);
> -
> -       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> -       vm_flags_set(vma, VM_IO | VM_DONTEXPAND | VM_DONTDUMP);
> -       vma->vm_ops =3D &stm_mmap_vmops;
> -       vm_iomap_memory(vma, phys, size);
> +       desc->page_prot =3D pgprot_noncached(desc->page_prot);
> +       vma_desc_set_flags(desc, VMA_IO_BIT, VMA_DONTEXPAND_BIT,
> +                          VMA_DONTDUMP_BIT);
> +       desc->vm_ops =3D &stm_mmap_vmops;
>
> +       mmap_action_simple_ioremap(desc, phys, size);
>         return 0;
>  }
>
> @@ -836,7 +847,7 @@ static const struct file_operations stm_fops =3D {
>         .open           =3D stm_char_open,
>         .release        =3D stm_char_release,
>         .write          =3D stm_char_write,
> -       .mmap           =3D stm_char_mmap,
> +       .mmap_prepare   =3D stm_char_mmap_prepare,
>         .unlocked_ioctl =3D stm_char_ioctl,
>         .compat_ioctl   =3D compat_ptr_ioctl,
>  };
> --
> 2.53.0
>
