Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5112DEA9D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 04:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773721851; cv=pass; b=fQOpV/hALy5CXOtKgN9ngIvXiieStzK31+Sjys5KapKrhdWUbyffurHnWdyJstkQzHuYNzlfj4N9cI8MH/7hAHIKAIvRHBrUqfTS66/BGePPcveitf6zIhR5SUmIu23NtSbAte0ug1yxOtK9PHBzF/TTkZZXyUxjbw8hETquOg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773721851; c=relaxed/simple;
	bh=+qEdsUsTBQ5PdU99AN+GVBCS7vF9AHbvt2iuwIsGSck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQGgXdx4CDFWeW0TwAjOAP1d9t2TV+UZFHhhPaFDamCAvxO9wQTTBExiBdERtBd/yPSrcFy8ZmMUzkJ8mZH9WrkNMUoh74ammzGS976siffzAPDpj6B7Vol4oyT+BAwcK2RG3Vzrg1e1rO5m67WJkYQSgmKKpBhGmKX5+SI+PAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcHz9jWS; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcHz9jWS"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5091ed02c54so192481cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 21:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773721848; cv=none;
        d=google.com; s=arc-20240605;
        b=fntmbyMWaDXeovibXOetBDgrxUTqYR6Y8YHNK9J1XMSy9eAOjaHCMlAwr3ht2xfnM1
         lHne0FkEIOPMVHAqW94V0tQ9OMR29gNp8lhg/Ji/M/mWn80gnD7cd/tbXxI4/QvJTpEU
         rbUeGxBzO2we57/5V6YgQ49zFibUifdBlfOUgBkVw6aYuyUNl6pWYonC1zpr+9/vo/CN
         AEPpNoERkWBllFXFwK3UarMxK9HpCTSvYjExdo6qto6VvLzQaVrtHXwgAge6846wOcOO
         mZr6YfBh3yNcPjVTYiNm99eyI5t1OY9OzF2pXT+8flxV1UZxxZXWObfd6OdJw1nDF5o6
         wHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pFQPhmx+ISxO6Fn3xc13MwW50zT+1NZPXlLC27SUdek=;
        fh=wdNAxqxqxr1obp3ZVh1iKApZob3nmlm3zwZgwkZlX1s=;
        b=e4zWWLIKHTCvapTCjKztoEIrjmMOJR4018ozNSmj6SmMnXJSfSCLAkzQe9fvPZhg8q
         F69pOt/ONJzcrCoM7F1sPfRnC1PEbQRx6udnz0p38jyGNefFN93ElDG59WsbFlKYhuZW
         D7x/P5PqvNyG0wdsFnjYrjeD8OJcLfAKzaUjNDGPJF0Qc8KwCVZYISmYNhJNwA9scgrI
         9/BtMAFBIjL63rqhfG7t1NZTEu+eQ1vBJQPV+lsNiCp/j7Ej48NrCus9a8D05p5ZGgcI
         GM4ikpL35lewHhmLFzXCDVL+9a5AK3PQCqz9tR1Wvd9H78svyBnk+jvNDTFHU4A2gOI6
         YR0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773721848; x=1774326648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFQPhmx+ISxO6Fn3xc13MwW50zT+1NZPXlLC27SUdek=;
        b=dcHz9jWSigF+3BARnPnbKteLX4VaADjtLsdaMyhGyNJV6JIimRYsLO4x7EbK9BzBKm
         mEBNOo5L0VUPl/dip+HXrZAa92QHbbWUxIR33fHYlLzQokFDwQJjBzeRf/caR0pjg2Mo
         34+rdKlPO1pqvYIaUSk19WaF9PSBtDSVR0MEozQlDzToqkl/jokmLSbZZk4UFJtqHEmi
         kXCC+DmS5SZkg30BADq3NkbtYVryfdZAaKXoYS6JLFIzqMyrVPWUXccsrILfv3Xl/Xkd
         r80MwV7t7nyhZxw2K0hrEcQ6qFdzAhEIEtys7scmuZDaSQSy0hx5l9Sk892/mMBb7UNJ
         O8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773721848; x=1774326648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFQPhmx+ISxO6Fn3xc13MwW50zT+1NZPXlLC27SUdek=;
        b=D0E8iOPemt6UFEyjzcTX/HlvmxoaSqWMitFbzUEqrNQ4gupqLnjbaeKwGcKOHT7W1e
         6xN2jZRYUnN+ModlTCCBQYovsMsfHZrWmTOdbD1x0w2zsJ9tXopXB7iw9T1Iq2YWheZr
         XpWDNqQa/0DlRm5xS2AAuYpvfN/FPsXjdG9ZtWn6smYUuJ8GW4L5x2kTnFF9LaHIrexp
         TaRJP+u4Qvl+zRKfLVKN7sYwXN+PBdRU+uJKM5RxCacW4YnMHxhFky9nFySzLnMqWjEE
         kA6HW96uIzCHJ5O1sHj8JB34K/f1Qr9bSze3PPxJDWbTsIUEDo/Re3Qy3N7PUuA80Kjs
         dZYg==
X-Forwarded-Encrypted: i=1; AJvYcCXzNDjqUZilUahxqFqz/+Dcmgfl3AESctHY9ULM+E84U6P6KBupMnxijaTU31RZJewYKE1QaKlIbYfJ2vUp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrvb3IKWrCLvHI/D3mU/ovIdCZkNFMplSKojUMnpuLPDwkCKkr
	ql6Od75FUy9fYeahK6ylQl+jPddAOI6P/K17HeH1mcT+fElPIx3KeHFf3k/aOfWRoSnceASE9Fi
	wC7wgcQjpvOV50KiC1OaX0J4cjz1jxsEmkYHCvdc3
X-Gm-Gg: ATEYQzwv9LexJkUbaHWskxBKj3aHxfJVBOcEnQDJEytvMAzldZXzfZNYvUMBm8/KW0S
	g3602YpQ14js1Qii4PpnbFK5iMNpGnTIf8uWffRNvuXFTEARYmm8SpeeBHkRJwzl/DO5nrHOI50
	X12igEUP0oS+1XInaH4mpUe08Y8MVJ6GMuc3jVHslOnbR5/n87Xm9E1nj+ojicPGfZGlfLkM2EH
	K0o6h8fr8QOR2qMbTyL1F8N7c2kg0DaZXlluhKuX7q+7mgKtcB86Jg4w+15k0oRFFRxnwlal8x4
	GgNL8w==
X-Received: by 2002:a05:622a:1b92:b0:509:1eca:6d24 with SMTP id
 d75a77b69052e-50998c190femr8741161cf.2.1773721847648; Mon, 16 Mar 2026
 21:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773695307.git.ljs@kernel.org> <77fbdae93f250fa1551f3052fc9034739795ff20.1773695307.git.ljs@kernel.org>
In-Reply-To: <77fbdae93f250fa1551f3052fc9034739795ff20.1773695307.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 16 Mar 2026 21:30:36 -0700
X-Gm-Features: AaiRm50ZCLTl3QDNivnPnY48qRQMsgXcmE9SOEgt_D7vDyjlZ8af9f8bQZf6tcw
Message-ID: <CAJuCfpFdKjix2fEdZ7iSrd_nk4-5e7EUNAoCEgUc5snKzq-3Cg@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] misc: open-dice: replace deprecated mmap hook
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

On Mon, Mar 16, 2026 at 2:13=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> The f_op->mmap interface is deprecated, so update driver to use its
> successor, mmap_prepare.
>
> The driver previously used vm_iomap_memory(), so this change replaces it
> with its mmap_prepare equivalent, mmap_action_simple_ioremap().
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  drivers/misc/open-dice.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
> index 24c29e0f00ef..45060fb4ea27 100644
> --- a/drivers/misc/open-dice.c
> +++ b/drivers/misc/open-dice.c
> @@ -86,29 +86,32 @@ static ssize_t open_dice_write(struct file *filp, con=
st char __user *ptr,
>  /*
>   * Creates a mapping of the reserved memory region in user address space=
.
>   */
> -static int open_dice_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int open_dice_mmap_prepare(struct vm_area_desc *desc)
>  {
> +       struct file *filp =3D desc->file;
>         struct open_dice_drvdata *drvdata =3D to_open_dice_drvdata(filp);
>
> -       if (vma->vm_flags & VM_MAYSHARE) {
> +       if (vma_desc_test(desc, VMA_MAYSHARE_BIT)) {
>                 /* Do not allow userspace to modify the underlying data. =
*/
> -               if (vma->vm_flags & VM_WRITE)
> +               if (vma_desc_test(desc, VMA_WRITE_BIT))
>                         return -EPERM;
>                 /* Ensure userspace cannot acquire VM_WRITE later. */
> -               vm_flags_clear(vma, VM_MAYWRITE);
> +               vma_desc_clear_flags(desc, VMA_MAYWRITE_BIT);
>         }
>
>         /* Create write-combine mapping so all clients observe a wipe. */
> -       vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
> -       vm_flags_set(vma, VM_DONTCOPY | VM_DONTDUMP);
> -       return vm_iomap_memory(vma, drvdata->rmem->base, drvdata->rmem->s=
ize);
> +       desc->page_prot =3D pgprot_writecombine(desc->page_prot);
> +       vma_desc_set_flags(desc, VMA_DONTCOPY_BIT, VMA_DONTDUMP_BIT);
> +       mmap_action_simple_ioremap(desc, drvdata->rmem->base,
> +                                  drvdata->rmem->size);
> +       return 0;
>  }
>
>  static const struct file_operations open_dice_fops =3D {
>         .owner =3D THIS_MODULE,
>         .read =3D open_dice_read,
>         .write =3D open_dice_write,
> -       .mmap =3D open_dice_mmap,
> +       .mmap_prepare =3D open_dice_mmap_prepare,
>  };
>
>  static int __init open_dice_probe(struct platform_device *pdev)
> --
> 2.53.0
>
