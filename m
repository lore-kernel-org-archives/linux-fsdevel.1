Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15061C84DE
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773621836; cv=pass; b=jXaWEQqMXaqdkSPtl9GGP/R5wCF/KyqgvOq9Hgweot1GKRaMaptBm1qh0xLIAB346Z92E9fJhnSm8Wxh3uL0YCq2+DnoOT63fU2KHW/ZsAfu93/HAjL+jmkPJOw2sYpkSckvZYsMAxJs8nQf57IXnTbZm77pE7GvtMYz/v+dvKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773621836; c=relaxed/simple;
	bh=7LEG6GSfAF3VAhLmKNS+zMMoXAkVfIwRn9mYIfi1rWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2tSV8qh35gZIQG0c8MWreY4x51YhZS5vN/pIa0Grq8NPR/GEnVTOfg5NMkUIaKwEwDIGC5qpb8DMJMpInf5LvOyJl384VS3fJX78ABb2wi77hXxUMy8aW8580iBAD8zZOD6Bl2+7vOwmMEv98dLyYl7fRUfSAZI6m1iw+0brcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bISgmRPH; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bISgmRPH"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-509062d829dso680141cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 17:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773621834; cv=none;
        d=google.com; s=arc-20240605;
        b=dOuOIWMlpYl6D/jWb1qoNAVyDtMGsgwKCs2Q5MYt9HS2KEETxeNnFB9to8451eFi5K
         jM5zyN1/Y9b1uziP9GUQKQwAuGEWylIDYuk1Lj1tFbtydA+sWIIQVC5XksgdNLPw5cnC
         /+cFrGa186rSi9jwb6A5UMFdNOS7Pnyt1BwZ4tYUhGNVZyzZkqweCnHPh2F7zC6UehLx
         Fat2B+3TDOsaD2V5hS/Zrs+ZxxklifNoQeW+Y5fOFKfnu6VLB/aOPJ60nkfrR8XHMSkr
         3M2KW3YPKD1Br5DaazkR79hMwkbtKo96DgQK/4IghGfZAEXlzTEfgG6/5cLOu9yh8JxO
         I5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B4iLbVdU6UwNcjWJZqb9n6er3BcFb6HsfZvwCgpauBo=;
        fh=bYvYBadU+85GLr04IbuAC+FgKJ0k+wZq9OLX6QFgYAQ=;
        b=VPRqVvmZCdde3yR5fxrybCdphi4Lli1Tfe6q83bwsC059bCGtbBr1GY13WxNXHbWGa
         93qHA1r0aw8/dhjFz3+ph1Kgwc0pnkleWwZvwGaCS8p3tvs2y+R5sky0focBZhFWyduw
         +YOHIQ9SXArjXukNLlDZPmVrpHmi7KDtZaiRbwuq+KUfMiTmqLuOVnrtl7ifEQS0ckHT
         FITtt2loOpv2b4QKAsM7KPWRj5LhgV9hHZpDpgdmHtHv2CxZo0IufO1JHq/cWUZic4nJ
         h/Nn5USQMGNafeXBR+JYhRFrjV7ilmH3ZUA/P4A3NdT2vDhfJYXwRyaToDAS+5k0l89T
         TLIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773621834; x=1774226634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4iLbVdU6UwNcjWJZqb9n6er3BcFb6HsfZvwCgpauBo=;
        b=bISgmRPHe1Sfdsvy6ngj1NvbPI5bCE4DfMr53m6zdg7zHA/OxjYsVgkGZ6mmp9AdYR
         gnlYG3eKj1cbFgEJrKs+y/ifQndl/7jdxcksA6ZyDvnvB0ptVSOL8mI5/wNl5TIIZCQr
         kkIn9S+93uEe7phvawobD7GXH8YDsDCrjsu6ubRO4YfCD0Vq17bZ1QDCx9UWyEOT6ab3
         i6sJcQSr8KI0VyUFZPfQC0VVAEssE2QJMPIBwT5CuK2BGhScJ4zFMWcGrbXmwoovk9Ab
         OhOnUEFAKyjD4ZV8Q4+5RXTrS8X7c61GaFvLviA+kMeb2dBiEpQdhPK2U4kVqS/79xXF
         NsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773621834; x=1774226634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4iLbVdU6UwNcjWJZqb9n6er3BcFb6HsfZvwCgpauBo=;
        b=MEQCHXqDgAlOwMpYU485Nfw8y0jKFtWKTtaiXcgmqJbnEjYfmoBTTD4JzyVpzrtO9G
         crVhr0YuPZQXgitHChANkg8rqHewY2aI5lSE8YCsdprm0L+RezmYpWUO1uoFcGS/r2pt
         Ld4F9YV2lmZua+WHGV1VkX+WwS58aIY7g/vQBE0hpzvOEmwl524LYVu7YrOg7EZs7aux
         wdNz/T1v2zEPh1enx8Q01ayxfOjbLVKOyZkV+vvHQ7Kp4Yn9gIhUBYWqBX/3pt1r9Hsl
         Otcxnj9mW38TSMy3s/hk47yiV2ga7N1GGG2fenXxDHvJKVn3HH/dPd6q6l018Kmid5jA
         /nag==
X-Forwarded-Encrypted: i=1; AJvYcCW/AZph3AiJExAwIxFICcr0pZIooYNqZ+5isK2UO1bvZcoBYJziOs2zmoUhLFf+afyOwZ8HhcBRgnGM/WHL@vger.kernel.org
X-Gm-Message-State: AOJu0YysahSfPCE1oNoLoFh6w4pY9zQwvuNCMCyQkzJpdECfihxfPRKd
	56OB+GpGOn6yRr1wkm2IvhXAwb5k9bqMNOP9SZz5kJ+dalbr4ZrEzNy91WLeeDf4jZT1mbFgCtl
	5P+/cNVx42m3lEmtiYOCYiBunckU1YdWGbtAabu/w
X-Gm-Gg: ATEYQzyjqUr2nYq9Z91UtLx8I/L0LpgyH+nHLwqp5az0rLFb47PNIp1hOWx5TGDdF7b
	BpZEj0m/6IbWeQHYk+QXzj9dhdmdrBVCeL892zMq1QAGoV4gaUaU4ZwdRT0h+cBvWiq0UBSmGPP
	IKavLM0hiiss/9j6u2/7RmcVr+kPgqSVlj6pag7Ak+WU4aqERtIs3LlQjP+ygLsM4to6J8DbR0M
	wx2xsod2B/u/gOCcxKa6y+3VDIvQb/77BKuE6yZ+nlH6mMl9ok2fMtkCAcCaxHlagc2GECSLwDu
	M3QuYg==
X-Received: by 2002:ac8:590e:0:b0:503:4bc:c925 with SMTP id
 d75a77b69052e-5096aa2ae2cmr17578141cf.13.1773621833001; Sun, 15 Mar 2026
 17:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773346620.git.ljs@kernel.org> <52a7b9a003ea51521ab3c0baf30337a7800a3af7.1773346620.git.ljs@kernel.org>
In-Reply-To: <52a7b9a003ea51521ab3c0baf30337a7800a3af7.1773346620.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 15 Mar 2026 17:43:41 -0700
X-Gm-Features: AaiRm51H9IsCynzRpnxAc6_DrzYXD9cjd8fR558hmylwDQfMj5FrJzUnU5dorNw
Message-ID: <CAJuCfpHVN66abFrJgorXKBsjv7Ut=CP-E4NpLMC4SW613tJwtw@mail.gmail.com>
Subject: Re: [PATCH 03/15] mm: document vm_operations_struct->open the same as close()
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

On Thu, Mar 12, 2026 at 1:27=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> Describe when the operation is invoked and the context in which it is
> invoked, matching the description already added for vm_op->close().
>
> While we're here, update all outdated references to an 'area' field for
> VMAs to the more consistent 'vma'.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> ---
>  include/linux/mm.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cc5960a84382..12a0b4c63736 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -748,15 +748,20 @@ struct vm_uffd_ops;
>   * to the functions called when a no-page or a wp-page exception occurs.
>   */
>  struct vm_operations_struct {
> -       void (*open)(struct vm_area_struct * area);
> +       /**
> +        * @open: Called when a VMA is remapped or split. Not called upon=
 first
> +        * mapping a VMA.

It's also called from dup_mmap() which is part of forking.

> +        * Context: User context.  May sleep.  Caller holds mmap_lock.
> +        */
> +       void (*open)(struct vm_area_struct *vma);
>         /**
>          * @close: Called when the VMA is being removed from the MM.
>          * Context: User context.  May sleep.  Caller holds mmap_lock.
>          */
> -       void (*close)(struct vm_area_struct * area);
> +       void (*close)(struct vm_area_struct *vma);
>         /* Called any time before splitting to check if it's allowed */
> -       int (*may_split)(struct vm_area_struct *area, unsigned long addr)=
;
> -       int (*mremap)(struct vm_area_struct *area);
> +       int (*may_split)(struct vm_area_struct *vma, unsigned long addr);
> +       int (*mremap)(struct vm_area_struct *vma);
>         /*
>          * Called by mprotect() to make driver-specific permission
>          * checks before mprotect() is finalised.   The VMA must not
> @@ -768,7 +773,7 @@ struct vm_operations_struct {
>         vm_fault_t (*huge_fault)(struct vm_fault *vmf, unsigned int order=
);
>         vm_fault_t (*map_pages)(struct vm_fault *vmf,
>                         pgoff_t start_pgoff, pgoff_t end_pgoff);
> -       unsigned long (*pagesize)(struct vm_area_struct * area);
> +       unsigned long (*pagesize)(struct vm_area_struct *vma);
>
>         /* notification that a previously read-only page is about to beco=
me
>          * writable, if an error is returned it will cause a SIGBUS */
> --
> 2.53.0
>
