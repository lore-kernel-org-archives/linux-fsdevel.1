Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD5313520
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576555; cv=pass; b=X99rzmXburL7g7etGkSGSHttcCddO31/pB9XkwERsJE2eQnq4HIjH/VLF9t+tcFsveXoVvmrtv7Sn97RMjKv+GZfoPZIU5TA8BnDiIke6NS8VG3PHbMX9shs2lTot59mTKMd1FWHsAYLqgrEUkpsHgaTvyFXKaUKN0zkDjA3cG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576555; c=relaxed/simple;
	bh=jPoZpmPhJCkyzRyXFyk7PzTJt0cFfh7Y5K5HjBkOV7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0Y2PHErsNfM2S9YUdhB2EA22nzs3pw8vbpn/KE9tLOyxbRkxq8OwX1kudIc8Hpwe+/Xq3U3/YaTS5RN8hPB7vcrDzIVneuablHw5jTHakiO/dLxKcfGTuZjN4LP2jY+vVX2zKY8RA91Naa2W8bYOTWZhQV6xA1hFnwuJysW9v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7yvhTJ0; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7yvhTJ0"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so2212406a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 18:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774576552; cv=none;
        d=google.com; s=arc-20240605;
        b=NcLEWlI4f9yVl4cf4/E90DwEuQcvHFIYr3DUTBPNQWv2xRq3Q6v5zPgIwC0T2yLnrk
         VI8KQJNpjj0KlRVyWEtgZe7/QEwOAr/iApBVjy7bRUo7F6KqR2H9e3O7CX/M2PHI00rc
         wRb8GdyVdGg3cHp93UlhhiWeSkg7GFMgG5as9gnauNIcDgCtEFem7HpnpHCEyaH4qx5K
         1OG0mmgtRKbvSmrBNRhELZO3+sPhlZ53AIoEkXPStg66XPZaZkUnHT3IWcNObHIE4YT0
         vNRvwtc024eq6uBNNNALTXypeDChLx0I5C952dkHiILoW1ImYuP2SO5TdMAH2CRSIi4U
         YN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v4/C6+dxmJ86MqBFYBzHKr+NUyGTfoaoGAJ7iveTtgs=;
        fh=2LkIEUM1u0ISmIQb5dbhzDqyTfJKYj9utRmfHcJ0UA0=;
        b=lvAE1Zpveatv5Dps8DbKBlJaXhWt1frgbNgVKmnVuFjV6ATnPpWoplXLV+2dPeww22
         MDrXx3lD+iCBfyP96biUmWYoGMIQY2gz/MDMA9ii3qP3etQgTdnRQaYZj51HAZsh+0ab
         z4XsM9pSaBKwIGuvi+ZJ6moUwKKFj+JqtSsnUanAssr+FCxhqCE9FAmIFVdkXDU3Ez3F
         lRVdCUxN3ulA+5Rwzjq0pU/IlzbBU+O+jg44iB97m3rdjL2Q6R8u2TIV1N2O6WKl/P0d
         PqvLy2Kpal1xJ+3UhBkpwxyVEPOY0/iE+AC6FLFhT3hobp/QwWddB06HCQ4hyxjohrUn
         vmkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774576552; x=1775181352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4/C6+dxmJ86MqBFYBzHKr+NUyGTfoaoGAJ7iveTtgs=;
        b=k7yvhTJ0xR1+At4yNERyllDfhZOEuCxo6999bLmOvz40tXMbgZx/n//Dkb8MH2OlkX
         Mde1x8W82BQUm0SIM3CmYja1FQ+Ec+qGHxMN7BGCKWBu4tI3JjQaF4gkIgJBQ74hq7mm
         3YsTHq0QtT+wZqjodDrbLoJORsqiftN348zmwTLPp45XwtkHQ9GAyViWWZ41zik7lzL7
         kvJRFdK0w3jP5cLtlU/20/AysnSIHW5vPFq29RRUIE7pP+gkEGvkb4SRPhfrduoAPEgV
         Cet6MHDrGgSTrRrPVY1PWCx4q946lzgzRP2KjRIHesJ34yBkoDxfnlx4vc2guOYYssnX
         JoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774576552; x=1775181352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v4/C6+dxmJ86MqBFYBzHKr+NUyGTfoaoGAJ7iveTtgs=;
        b=HLBNNt9YBVwFUSHhBfE0hxtqDfA0/PhRlxqtC1o9rAytSw7AZT+bdNC/5NuESkKJFe
         xwri4r8OPKw23bYuK7eJNQNC+Bgtrs/i9wREcZCEvGjW54bJ3ryWzC4DpkZ6NMT0FP1a
         z55148dzUrbyxXpp7szFaDQPdIYaFPYOfFglsfQ/BOC8ScZOWDwb9sVljgOXLxmZuQPI
         vHAkIcV9nzqLr2tqZhqJXfcPX4V/DQtqyTYvknKLZKcZnyErSNoiail7MfUOJWPkMtpH
         ZRJRXiQNeMU/7i7W9mTjT1a7HvC+mHvqRLMdp1x7t0Wd0uWUGZ71oICxz5gPATO51fOX
         7sVw==
X-Forwarded-Encrypted: i=1; AJvYcCVP0QAp3Tn5pWcJ+rTWiYBz+vJhNRLERqNmHw6l2JdtnLR4bxSULftLS8wsIl24fSJod0JdqWrG94ba5BqQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLoefS4TFrN136M3HJcM8HN5MgA654xliQYunRPYhSKTEjW0b
	d7E3usFcN0hxjajhxNs631t702F4FnfuRlCPxVwjSzNL6z2wMRegowQ1ZBVjBIdM/oDyNxqzZg2
	rwBEPMrpd1tCPPoeMwQO2V+b7sQTk50sqelfZdGLq
X-Gm-Gg: ATEYQzylaONX3rASKcYCObPz5vWPxjjn/znAfsM8RHbfAS3SNYzFg+Z/VXdNMGzHzOM
	I/IyEr7mlqdZf/o0NgxQS5rhPm1/wdYRlCv0UDyBp50EgSH55PLF+IcmZ8Jr+WGN+s7V+jy1Xty
	hJ3Pqrs8ir5WkY0ZZo+E22Le+URTaQAFwphjx4I98IQ3pT40uMy4oJOPDu2c4w8m2R9ghJZ3x2B
	LWrCxd7B6YYmx23XklcvufoaxQXcEWHSiOfZXo5wTLq1Wul0tt0jjTW22vi4erFWFmkpAjDjatt
	Lfgs+AmdwkURbuyctRtHH/4Wfx3x4nvH4/h4cES9DoeQ50/f9kggNDJ8/nT/8oTaRPDdrw==
X-Received: by 2002:a17:907:e158:b0:b98:c69:f07d with SMTP id
 a640c23a62f3a-b9b5090a9b8mr25881366b.34.1774576551262; Thu, 26 Mar 2026
 18:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306171815.3160826-1-rppt@kernel.org> <20260306171815.3160826-13-rppt@kernel.org>
In-Reply-To: <20260306171815.3160826-13-rppt@kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Thu, 26 Mar 2026 18:55:15 -0700
X-Gm-Features: AQROBzDUg7nnPrShRG0yBUvJphXCQFgkh8YtYxeiIRK_yAgzpeQjdeV5p-bfc2o
Message-ID: <CADrL8HVUJ5FL97d9ytxp2WXos6HS+U+ycpsi5VxffsW9vacr9Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] mm: generalize handling of userfaults in __do_fault()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Oscar Salvador <osalvador@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 9:19=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> From: Peter Xu <peterx@redhat.com>
>
> When a VMA is registered with userfaulfd, its ->fault()
> method should check if a folio exists in the page cache and call
> handle_userfault() with appropriate mode:
>
> - VM_UFFD_MINOR if VMA is registered in minor mode and the folio exists
> - VM_UFFD_MISSING if VMA is registered in missing mode and the folio
>   does not exist
>
> Instead of calling handle_userfault() directly from a specific ->fault()
> handler, call __do_userfault() helper from the generic __do_fault().
>
> For VMAs registered with userfaultfd the new __do_userfault() helper
> will check if the folio is found in the page cache using
> vm_uffd_ops->get_folio_noalloc() and call handle_userfault() with the
> appropriate mode.
>
> Make vm_uffd_ops->get_folio_noalloc() required method for non-anonymous
> VMAs mapped at PTE level.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/memory.c      | 43 +++++++++++++++++++++++++++++++++++++++++++
>  mm/shmem.c       | 12 ------------
>  mm/userfaultfd.c |  8 ++++++++
>  3 files changed, 51 insertions(+), 12 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 07778814b4a8..e2183c44d70b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5328,6 +5328,41 @@ static vm_fault_t do_anonymous_page(struct vm_faul=
t *vmf)
>         return VM_FAULT_OOM;
>  }
>
> +#ifdef CONFIG_USERFAULTFD
> +static vm_fault_t __do_userfault(struct vm_fault *vmf)
> +{
> +       struct vm_area_struct *vma =3D vmf->vma;
> +       struct inode *inode;
> +       struct folio *folio;
> +
> +       if (!(userfaultfd_missing(vma) || userfaultfd_minor(vma)))
> +               return 0;
> +
> +       inode =3D file_inode(vma->vm_file);
> +       folio =3D vma->vm_ops->uffd_ops->get_folio_noalloc(inode, vmf->pg=
off);

If you do away with the change you made to vma_can_userfault(), please
add a WARN_ON_ONCE() here if uffd_ops or uffd_ops->get_folio_noalloc
are not present.

> +       if (!IS_ERR_OR_NULL(folio)) {
> +               /*
> +                * TODO: provide a flag for get_folio_noalloc() to avoid
> +                * locking (or even the extra reference?)
> +                */

I think a whole new op is better than adding a flag. Something like
uffd_ops->folio_present().

> +               folio_unlock(folio);
> +               folio_put(folio);
> +               if (userfaultfd_minor(vma))
> +                       return handle_userfault(vmf, VM_UFFD_MINOR);
> +       } else {
> +               if (userfaultfd_missing(vma))
> +                       return handle_userfault(vmf, VM_UFFD_MISSING);
> +       }
> +
> +       return 0;
> +}
> +#else
> +static inline vm_fault_t __do_userfault(struct vm_fault *vmf)
> +{
> +       return 0;
> +}
> +#endif
> +
>  /*
>   * The mmap_lock must have been held on entry, and may have been
>   * released depending on flags and vma->vm_ops->fault() return value.
> @@ -5360,6 +5395,14 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>                         return VM_FAULT_OOM;
>         }
>
> +       /*
> +        * If this is an userfaultfd trap, process it in advance before

"If this is a userfault"

> +        * triggering the genuine fault handler.
> +        */
> +       ret =3D __do_userfault(vmf);
> +       if (ret)
> +               return ret;
> +
>         ret =3D vma->vm_ops->fault(vmf);
>         if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_R=
ETRY |
>                             VM_FAULT_DONE_COW)))
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 68620caaf75f..239545352cd2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2489,13 +2489,6 @@ static int shmem_get_folio_gfp(struct inode *inode=
, pgoff_t index,
>         fault_mm =3D vma ? vma->vm_mm : NULL;
>
>         folio =3D filemap_get_entry(inode->i_mapping, index);
> -       if (folio && vma && userfaultfd_minor(vma)) {
> -               if (!xa_is_value(folio))
> -                       folio_put(folio);
> -               *fault_type =3D handle_userfault(vmf, VM_UFFD_MINOR);
> -               return 0;
> -       }
> -
>         if (xa_is_value(folio)) {
>                 error =3D shmem_swapin_folio(inode, index, &folio,
>                                            sgp, gfp, vma, fault_type);
> @@ -2540,11 +2533,6 @@ static int shmem_get_folio_gfp(struct inode *inode=
, pgoff_t index,
>          * Fast cache lookup and swap lookup did not find it: allocate.
>          */
>
> -       if (vma && userfaultfd_missing(vma)) {
> -               *fault_type =3D handle_userfault(vmf, VM_UFFD_MISSING);
> -               return 0;
> -       }
> -
>         /* Find hugepage orders that are allowed for anonymous shmem and =
tmpfs. */
>         orders =3D shmem_allowable_huge_orders(inode, vma, index, write_e=
nd, false);
>         if (orders > 0) {
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 7cd7c5d1ce84..2ac5fad0ed6c 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2045,6 +2045,14 @@ bool vma_can_userfault(struct vm_area_struct *vma,=
 vm_flags_t vm_flags,
>             !vma_is_anonymous(vma))
>                 return false;
>
> +       /*
> +        * File backed memory with PTE level mappigns must implement

"File-backed VMAs (except HugeTLB VMAs) must implement
ops->get_folio_alloc() to support userfaults, as all userfaults in
file-backed VMAs wlll call ops->get_folio_alloc() to determine the
userfault type."

> +        * ops->get_folio_noalloc()
> +        */
> +       if (!vma_is_anonymous(vma) && !is_vm_hugetlb_page(vma) &&
> +           !ops->get_folio_noalloc)

With the separate folio_present() (or whatever) op, this check becomes
more obvious. (Looking at this right now, it looks like we're checking
for UFFDIO_CONTINUE/minor fault support here, but that's not really
what's going on.)

Honestly I'm not 100% sure if this check should be here. If it's going
to be here, then we should probably also have checks like these here:

if (vm_flags & VM_UFFD_MINOR && !ops->get_folio_noalloc)

and

if (vm_flags & VM_UFFD_MISSING && !ops->alloc_folio)

So, maybe we should just leave it up to ops->can_userfault() to make
sure we're doing the right thing?

> +               return false;
> +
>         return ops->can_userfault(vma, vm_flags);
>  }
>
> --
> 2.51.0
>
