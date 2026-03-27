Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF31FDE31
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774578823; cv=pass; b=jE850fuVVVIHzbsF1u1PsOgweEuLnqgABo7zlXc9fnuYrVkdYwKJBNcS3q2wOoVjeG59g5t9UgmEED34jrxH2TB34y0YRY7Q6DZl6Y44MnwNtxaj2F7kRF4qAuAtCzrTX8MVl7gVS7mJatlTj1rFeCxzcAPnyvg9BoV6m8q25yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774578823; c=relaxed/simple;
	bh=V8VCXLly4w5+0+MPhojVHILnNZjHzCfdHzsAew3W6M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8pQUNFe0qtW6LQvoHaqwmSg3FeSj7lh0XKiaILoB1oXcGNt6QHgPU0Tuk4/OAIaW35Y0LlK2Mcqf/il4FWOxagju0yKFDy5QsnS3iM8Ietr5N7Ah0SZLjLbNQliaG50uBFMqtUqoa4PaWhGFK5iiLzuZw92SjvlI2co5nhAyoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNAez2j7; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNAez2j7"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9795ca4e6dso254663066b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 19:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774578820; cv=none;
        d=google.com; s=arc-20240605;
        b=k3IhMW0F4PQS6Fp42hMpqI1IS6I1D6dZ6QMcis29nPhHvKZ7Q9I1RjFo8sEAbUxGvB
         VrmqpbcQ/MeRVHkClc7BhFrO8H3csz5fv+AM0Jn2ksxywoQLmnPSyNGq0p3mersn0fRq
         2w9nk/Kfz1oPcAS1h3CG9puHdE0mn0sFxSYWmp8x1IiWy/kZb3Q4SNmbQXb32cYdVmqR
         gcJxhATElLM2zn6qGXXUK8A0e4RYkxTE6a5/LJ/WJArQ55uToZW1XOVfzEwsRCaydls6
         n0ZfKHk12HUYd6/2zceoJXwE1EZSK/oOoPZ/qESox53QeC+PIFwIyzPncAa0he3WEJ32
         iXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J/j2LL2fzZ3HqKnkSg4Q11VeHoSjD2aRYX2gqfSMp8c=;
        fh=ovNMXHv1XmsFiizlGJ9TfnL/VwwYTJBwFkouA/kTSHA=;
        b=e+tIzE0VFcFtA6494UxSkjTexnskBxVpqdtPsSXq5C+d3HdDcofAGioHjaYQ9nQ2wk
         VA+jttVWU2KF+27a8hDn/G1fao6yUEM53LFsLX0JnaSRJd6X3YByP0sOOUnHBxBD+QW6
         drfuYiWk3kVZFAcilpvApDJGmk4SXyr9CR3im25IkA5y9XIZIGD0TdeUZ/8mGvpCOK7w
         M4rwx0bgN98K+Y8+iDtJIQHVzqngw2qz8ZBUVEtX6YpsmnfPowC6nU5rbURjHS/y+qBU
         hS4Sstlh587Vq/C1/5nIC0TiXl7zKZuAzpPjzg4fX8uaTTipHjj5hOWXLRhM2tBi50G1
         zxew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774578820; x=1775183620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/j2LL2fzZ3HqKnkSg4Q11VeHoSjD2aRYX2gqfSMp8c=;
        b=WNAez2j7Hs+E5z13vNZS8hdcy3gAlLN1o2gKpSHjUFWrW4ShBHkWJ+8oDxMR8qTXk9
         mg5b+ZgXKwi6InYIVPzakcE6xOqmFAgai+JQ9xtT/+gYsg1g3c6XAOQh9Yb/iEscLT4X
         09dUQFCbfpwd3AlzHpXl3ydIZBEu5VSbCEH6QAJcMWpmu5VyGZDecO2XpbabrBywJ7Fz
         zFKDWRSnu46EBDzWBEhluHD4rJiDfE4DtPUUrHJsQUC/IBqzqshdvwWVgpDx6t11bW88
         IQ2Skxlze1MA4TitpUDDxubgEYs0C6E9+PRvqHYcfUmjsr5eia0wf87c9ebwOHlAjLbu
         +Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774578820; x=1775183620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J/j2LL2fzZ3HqKnkSg4Q11VeHoSjD2aRYX2gqfSMp8c=;
        b=nNRQ0O1GTZ4awbx9CzyqmvheeiBbuBURe7oDGHt7kmxSCcTyMi4BH/GelD76Mkgu5i
         v83FRY0kGY/3CVSyrm6TiTh7mbw/bwb8rl1lzpWeYeR3GOjnq9Qy0HqGdvvCTCJb0irY
         cFLUPggI192Qub+B54BmbQjVQ7/5d4S+kz8+YzmEYTwxglwnSui0aAx4gXP7uqFc//TW
         LYKUZFnmmBJgi+B/Hr+t3mQIhLSaPkYYmHYQJOFACBBWV6h1oqkpykJQ6NqLRvAIjbZx
         XIcPFY2aD5uKAqNJeR68kEsALdBTIGbUJ21hu87ke6WG8ER2+0hWyBmKYMBs85KDo+Cp
         JF8A==
X-Forwarded-Encrypted: i=1; AJvYcCV1DLkJFOWzriJwEcQC3c1/LfrKzUTheEyRUDBjkfcJIaF6retKKxJsY3E3dp37eqH8vaul0fXKJgJqBURF@vger.kernel.org
X-Gm-Message-State: AOJu0YzKeMyRXsFt7F+EWEAKdD9soqPCptVNSmRnDmO2o+NYI7o/JROm
	kSHmEiDqKZ3JJ9oxEZL8YigoiohaWD8HN1aRK4BOD8eyMdL4rALeuOepyac5jYUyprJGdEk/ykc
	iGc1clL7Fc0kXXlevi7l9381T3VeMz20WQfmwCWe/
X-Gm-Gg: ATEYQzzoGcm4TEHIfrfUFDpsilxTPD+sH4PZ9xfpJKoR8z3c/C9DzM3DHSLVrlrNJJP
	y5xGUpkmpM96mDng9Lu32FjkyWFAfHj3/TeTnWLf0gtOTfKVjQvn/QqwHlhKMuYcwcb6Q6aPxLH
	lJ9rTVp72Sr4oe1VpqsV7f0GX3sjcUD2PX6S6C+tZwFrO0uAMkQRK3+ioT2G51LoVcRSq+LyweQ
	FGv9Uy/O0sZfQB4IpNqB2IMorHK5qbDYXqKwLpt7IgHzsoFcQlYXPn+fyGup7whAPgvqt2SAE8B
	i16Kyw67NMV7c8QvFLy/esU/VA4YBpxyKamBdt7P3x9gwVQstyGMPNiIw08AOEPsBQGRxQ==
X-Received: by 2002:a17:907:7207:b0:b97:cebd:8273 with SMTP id
 a640c23a62f3a-b9b5032239amr41546366b.24.1774578819995; Thu, 26 Mar 2026
 19:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306171815.3160826-1-rppt@kernel.org> <20260306171815.3160826-14-rppt@kernel.org>
In-Reply-To: <20260306171815.3160826-14-rppt@kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Thu, 26 Mar 2026 19:33:03 -0700
X-Gm-Features: AQROBzBsDaVhxDLiM-NXiOxOeLuYc-OBfbNaKVq7AIOmeniABMQbpvif4NJ_3-8
Message-ID: <CADrL8HViJ_GaRUd-k9MyM0S8b7sz3whGJHNwvFfCk+pw0+kRgA@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] KVM: guest_memfd: implement userfaultfd operations
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
> From: Nikita Kalyazin <kalyazin@amazon.com>
>
> userfaultfd notifications about page faults used for live migration
> and snapshotting of VMs.
>
> MISSING mode allows post-copy live migration and MINOR mode allows
> optimization for post-copy live migration for VMs backed with shared
> hugetlbfs or tmpfs mappings as described in detail in commit
> 7677f7fd8be7 ("userfaultfd: add minor fault registration mode").
>
> To use the same mechanisms for VMs that use guest_memfd to map their
> memory, guest_memfd should support userfaultfd operations.
>
> Add implementation of vm_uffd_ops to guest_memfd.
>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Overall looks fine to me, but I am slightly concerned about in-place
conversion[1], and I think you're going to want to implement a
kvm_gmem_folio_present() op or something (like I was saying on the
previous patch[2]).

[1]: https://lore.kernel.org/kvm/20260326-gmem-inplace-conversion-v4-0-e202=
fe950ffd@google.com/
[2]: https://lore.kernel.org/linux-mm/CADrL8HVUJ5FL97d9ytxp2WXos6HS+U+ycpsi=
5VxffsW9vacr9Q@mail.gmail.com/

Some in-line comments below.

> ---
>  mm/filemap.c           |  1 +
>  virt/kvm/guest_memfd.c | 84 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 83 insertions(+), 2 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6cd7974d4ada..19dfcebcd23f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -262,6 +262,7 @@ void filemap_remove_folio(struct folio *folio)
>
>         filemap_free_folio(mapping, folio);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(filemap_remove_folio, "kvm");
>
>  /*
>   * page_cache_delete_batch - delete several folios from page cache
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 017d84a7adf3..46582feeed75 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -7,6 +7,7 @@
>  #include <linux/mempolicy.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
> +#include <linux/userfaultfd_k.h>
>
>  #include "kvm_mm.h"
>
> @@ -107,6 +108,12 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, s=
truct kvm_memory_slot *slot,
>         return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
>  }
>
> +static struct folio *kvm_gmem_get_folio_noalloc(struct inode *inode, pgo=
ff_t pgoff)
> +{
> +       return __filemap_get_folio(inode->i_mapping, pgoff,
> +                                  FGP_LOCK | FGP_ACCESSED, 0);
> +}

When in-place conversion is supported, I wonder what the semantics
should be for when we get userfaults.

Upon a userspace access to a file offset that is populated but
private, should we get a userfault or a SIGBUS?

I guess getting a userfault is strictly more useful for userspace, but
I'm not sure which choice is more correct.

> +
>  /*
>   * Returns a locked folio on success.  The caller is responsible for
>   * setting the up-to-date flag before the memory is mapped into the gues=
t.
> @@ -126,8 +133,7 @@ static struct folio *kvm_gmem_get_folio(struct inode =
*inode, pgoff_t index)
>          * Fast-path: See if folio is already present in mapping to avoid
>          * policy_lookup.
>          */
> -       folio =3D __filemap_get_folio(inode->i_mapping, index,
> -                                   FGP_LOCK | FGP_ACCESSED, 0);
> +       folio =3D kvm_gmem_get_folio_noalloc(inode, index);
>         if (!IS_ERR(folio))
>                 return folio;
>
> @@ -457,12 +463,86 @@ static struct mempolicy *kvm_gmem_get_policy(struct=
 vm_area_struct *vma,
>  }
>  #endif /* CONFIG_NUMA */
>
> +#ifdef CONFIG_USERFAULTFD
> +static bool kvm_gmem_can_userfault(struct vm_area_struct *vma, vm_flags_=
t vm_flags)
> +{
> +       struct inode *inode =3D file_inode(vma->vm_file);
> +
> +       /*
> +        * Only support userfaultfd for guest_memfd with INIT_SHARED flag=
.
> +        * This ensures the memory can be mapped to userspace.
> +        */
> +       if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
> +               return false;
> +
> +       return true;
> +}
> +
> +static struct folio *kvm_gmem_folio_alloc(struct vm_area_struct *vma,
> +                                         unsigned long addr)
> +{
> +       struct inode *inode =3D file_inode(vma->vm_file);
> +       pgoff_t pgoff =3D linear_page_index(vma, addr);
> +       struct mempolicy *mpol;
> +       struct folio *folio;
> +       gfp_t gfp;
> +
> +       if (unlikely(pgoff >=3D (i_size_read(inode) >> PAGE_SHIFT)))
> +               return NULL;
> +
> +       gfp =3D mapping_gfp_mask(inode->i_mapping);
> +       mpol =3D mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff)=
;
> +       mpol =3D mpol ?: get_task_policy(current);
> +       folio =3D filemap_alloc_folio(gfp, 0, mpol);
> +       mpol_cond_put(mpol);
> +
> +       return folio;
> +}
> +
> +static int kvm_gmem_filemap_add(struct folio *folio,
> +                               struct vm_area_struct *vma,
> +                               unsigned long addr)
> +{
> +       struct inode *inode =3D file_inode(vma->vm_file);
> +       struct address_space *mapping =3D inode->i_mapping;
> +       pgoff_t pgoff =3D linear_page_index(vma, addr);
> +       int err;
> +
> +       __folio_set_locked(folio);
> +       err =3D filemap_add_folio(mapping, folio, pgoff, GFP_KERNEL);

This is going to get more interesting with in-place conversion. I'm
not really sure how to synchronize with it, but we'll probably need to
take the invalidate lock for reading. And then we'll need a separate
uffd_op to drop it after we install the PTE... I think.

> +       if (err) {
> +               folio_unlock(folio);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static void kvm_gmem_filemap_remove(struct folio *folio,
> +                                   struct vm_area_struct *vma)
> +{
> +       filemap_remove_folio(folio);
> +       folio_unlock(folio);
> +}
> +
> +static const struct vm_uffd_ops kvm_gmem_uffd_ops =3D {
> +       .can_userfault     =3D kvm_gmem_can_userfault,
> +       .get_folio_noalloc =3D kvm_gmem_get_folio_noalloc,
> +       .alloc_folio       =3D kvm_gmem_folio_alloc,
> +       .filemap_add       =3D kvm_gmem_filemap_add,
> +       .filemap_remove    =3D kvm_gmem_filemap_remove,
> +};
> +#endif /* CONFIG_USERFAULTFD */
> +
>  static const struct vm_operations_struct kvm_gmem_vm_ops =3D {
>         .fault          =3D kvm_gmem_fault_user_mapping,
>  #ifdef CONFIG_NUMA
>         .get_policy     =3D kvm_gmem_get_policy,
>         .set_policy     =3D kvm_gmem_set_policy,
>  #endif
> +#ifdef CONFIG_USERFAULTFD
> +       .uffd_ops       =3D &kvm_gmem_uffd_ops,
> +#endif
>  };
>
>  static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
> --
> 2.51.0
>
