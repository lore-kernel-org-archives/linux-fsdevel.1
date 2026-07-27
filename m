Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086CD3D903E
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187608; cv=pass; b=ALAAtQLw5D+r4+CcNMHmB6Q9xvnSfD8fOORiGy/WKYyFVjbJTfyw5e3KpkCfHOlQNuodXwI83CX+/W0FQK52yXInCO3SM+Yn4KdorGuyOf3hNWKkixngvVIwy9z775l2IMcUx+Ld590rVwWhwrTQ2iLZCySpCnOtA9MmXxYCXTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187608; c=relaxed/simple;
	bh=JW5kB5qB30chtuMEzFwn4BgecT+7iXIRLKy94iBqk6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imRTT89FZuMPibZDLTsN3aYxBZQVcDLjQa3KVRwoDPk1VFx9hPVBAMD403lXzhNPBAX86QaZ/AYNt8SaRLdr5AEW6A0FmHiovnkAI1OW/Om2N5f3FxCIOeIs8hwoWNdRwwaXBe7RwfqRXdrKCJzm7wMsQQ9dcREa+2mmAUQ3PhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itMHIBsn; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itMHIBsn"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so410251266b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785187604; cv=none;
        d=google.com; s=arc-20260327;
        b=Ev+TVsz6y+oBDwcFXTXzPI+AwnhbBCc+NQl8TrzrsdXn+ZOR7MbXAWOIIyhGZ3+lz/
         G3XrTdp05FnToVPrKzWr9s7NqF/vk/R+F61LWVMQrX7l5ySlAXXgFBz3jWfOW5tLEcM5
         zqPbpNin0cbB4GGjDkSshkDfN2S8wwFRBIRrR6l+MEcADOJpfh/RZGchJHn4ZRkvYOaH
         Bei/QSWQwcJkJo6BNZ4b0IGwO5QgwQTY3NBgMVPLBZPPc1Sltb7HvK8RuyRPhy8VxnE8
         X/BSG6axcuK8a/ELNYjTzdPMoRbIgahkOwF5brDr29/MHK2qZ+RXiZ0EuUiISn9Cq1MI
         8Q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N9bsPZ3HZQvmOrzVVgTiiLwY68paYMuFlINsGlL75lg=;
        fh=B30z13+VEJP7kfg2/kIAnVBacigpgoatKiuE3P+9NOo=;
        b=l1/o/Uonuc9X/a7rGmPTenaavu/QUHVx0YvcmpM/NklJLfiCw0GhZscUQ75ZT/gnWu
         YrcSM+r02i2upALZd+WdYdbVr+/okOPJmBfrlxLLQyLEXB+7RmGhU7HZxN0r5hVGfw6v
         VcEjQDfBc6iVHJV0NtQO2AV0OLhqjtumlPCpNerD47C6zYFKY3qAM5rkEmjslWQRN5Lw
         zVQ6A/0dHhDeNb2ZpGA6jjQmZ8tRNBoGnXLVA88wXojt4Z+pfypE+1jZlHho5j6pB6qp
         vBNo/fp+I50UvAS4k4nY6oYWk1XiBVnkTdNtnRfYi3by3moGw4OKonts+oOcYV1HZ/GV
         QIQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187604; x=1785792404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N9bsPZ3HZQvmOrzVVgTiiLwY68paYMuFlINsGlL75lg=;
        b=itMHIBsnPMwO/HpiV1sEX7rDv8tpVV2zz4vAYB7iFuRkA5sBbCy9UbOwzVq6FTSPHX
         Be7fe+Opki1puZWEFR8va7ejzCH4ft5B6UlWc/cRDXQuj/SqZ/Me44tbtEO/zPuPDSDn
         j8X30/b6HeUuqxBCXWN+Cy2dp0tmosR1/Wo7qp/habAnPdrGr0Gl0dLYvvUm5snQ17aC
         JrSTXyURQS8rStoX+COUnzBPw0mocF2sK8ItfP+17lVMSYyPxa2qyV/m0OYuH6V0JcFC
         LEImOct+puO02IEY6xGt7pWwpOwZZAENWm0AEOXJMlVRiGlEfN3GejCE2jz/uYtOZ4K4
         oMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187604; x=1785792404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9bsPZ3HZQvmOrzVVgTiiLwY68paYMuFlINsGlL75lg=;
        b=UF4jK5mhLlZKo/dfPVAJKGpP0I3TgU/mvhxwWgVKmPdCR2i10DaHhU1KqYbdvmC5/r
         kcGy287Iyd2WbXj3oSDOfpSbLXqvI5GvPmAPmZ2WFalroMTCNBO1S4lgrI1E+O1DD5Qj
         555ONLX/x7PQUnwAlK1fWfcVj/PJOpqgJubGYCPWWsiFxwh/gP7j9/PpVt63TU8lgjar
         mrgUkRRxVoST5kknStbr2BvJ9Un7EEYf0k6V8D8rG/1+AZQa57vU4rWfva6RGVCFzgZD
         kjH1hE9JRJ9OIa0CLu6kV1X8974Ee99v8gCYdS7zci9AhjjXYiOkMIuhQycRRdblOKbB
         Lo8A==
X-Forwarded-Encrypted: i=1; AHgh+RriRNEiQY6JWmORKIKkoUuZHdfM1dPLy2BfM+BeDyIpFL/yyp6NMUKaM0FbJbhr4/1uUcI2bPj4B43h0Xpo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/pB+dqPMoKc9qGar8gxrOMGW/99a8JZ776f/lPjzAPo439/rW
	I07VNkPSk9HSEV7PN4knefUgI6Sy2UxnDzZg7r8SMk0Ch1LUZ74QA929ett0GUIxn05o4bdiQS0
	joV00jfF8Y81K8A6L1VIldyxUg9RWNhw=
X-Gm-Gg: AR+sD11OstDmr+BwCBT4VSal9w30/9XrHQCfT+B1Nq9K+2txv414EnPQAHNd9OOwCOj
	ATJlnil4LyMZSF6zZQ6D55hXCT5xT5EMxnE4vfB819Pu9CuD6mY/nkm0jn1V/beeXRZOpTUZibU
	2cx9/TLRU9L0C+9D2J3ZLFXEpNbIK+jE1sFbRlb7CqJarfopf4ZEq0uE3ruGQ9jInyYV0kA6eLu
	4CTmQ1pU1AeV4Y8gb/nBIU9MJWn72uyz+JJONTYtfzy+g++IbNGRSdB
X-Received: by 2002:a17:906:7948:b0:c1c:26fd:4f31 with SMTP id
 a640c23a62f3a-c1f1eeacc9emr434831066b.26.1785187603944; Mon, 27 Jul 2026
 14:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org> <20260720-b4-scalable-cow-virt-pgoff-v2-13-2d549757a76f@kernel.org>
In-Reply-To: <20260720-b4-scalable-cow-virt-pgoff-v2-13-2d549757a76f@kernel.org>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 27 Jul 2026 14:26:32 -0700
X-Gm-Features: AUfX_mwcnd_-Gd85nb0fGnZa3ykBWA_00Dmo7Y127h_GI4bez2zlh-yWo1OAW4w
Message-ID: <CAHbLzkrCjALeXSuO7dgho9=W-VZQxD-CXNS8iOva=oCCi1XV1A@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] mm/vma: make MAP_PRIVATE-mapped /dev/zero
 mappings truly anonymous
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 8:30=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> When mapping /dev/zero with MAP_PRIVATE, one ends up with strange VMAs
> originating from Linux's distant past.
>
> These have vma->vm_file set but NULL vma->vm_ops, meaning they satisfy
> vma_is_anonymous() but otherwise resemble a file-backed VMA.
>
> The introduction of virtual page offsets and their subsequent use as
> indexes for MAP_PRIVATE-file-backed mappings mean the rmap does the right
> thing with these but we are left with inconsistencies.
>
> The vma_start_pgoff(vma) =3D=3D vma_start_virt_pgoff(vma) invariant is tr=
ue for
> all other anonymous VMAs, but not these.
>
> These VMAs are also observable as files in /proc/<pid>/[s]maps but
> otherwise behave like anonymous mappings.
>
> Therefore let's make these VMAs actually anonymous at mapping time which
> will activate the anonymous code path for mappings.
>
> This means we no longer have to account for this discrepancy anywhere and
> no longer have to think about these at all.

I'm glad to see this is solved finally. But /proc/<pid>/smaps will not
show /dev/zero anymore. It is user visible. I recalled you were
concerned about it before.
https://lore.kernel.org/linux-mm/c98f68c1-4bfd-4410-9b65-1eb5a1efe271@lucif=
er.local/

Anyway I don't think it is a big deal. It should be harmless. I would
be surprised any real life workload would care whether the anonymous
mapping is backed by /dev/zero or not in 2026.

Thanks,
Yang

>
> A previous commit gave us map_is_dev_zero() to positively identify these
> mappings, so we expressly only do so for these alone.
>
> The impact of this change should be low as likely very few are relying up=
on
> this in any case, and in using them are asking for anonymous memory, so n=
o
> longer seeing these as file mappings in smaps should have no meaningful
> impact.
>
> Update assert_sane_pgoff(), the comment for vma_start_pgoff() and
> linear_virt_page_index() to reflect the change.
>
> We make this change in call_mmap_prepare() alone as /dev/zero has been
> converted to an mmap_prepare hook and we do not permit nested MAP_PRIVATE
> mapping of /dev/zero.
>
> We also remove the now defunct vma_desc_set_anonymous() and eliminate the
> temporary bisection hazard fix from the previous commit.
>
> Also update the VMA userland tests to reflect the change.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  include/linux/mm.h              | 10 ++--------
>  include/linux/pagemap.h         |  3 +--
>  mm/vma.c                        | 26 +++++++++++++++++---------
>  mm/vma.h                        |  3 ---
>  tools/testing/vma/include/dup.h |  3 +--
>  5 files changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7614afe99c96..7fabe6c66b4b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1554,11 +1554,6 @@ static inline void vma_set_anonymous(struct vm_are=
a_struct *vma)
>         vma->vm_ops =3D NULL;
>  }
>
> -static inline void vma_desc_set_anonymous(struct vm_area_desc *desc)
> -{
> -       desc->vm_ops =3D NULL;
> -}
> -
>  static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
>  {
>         return !vma->vm_ops;
> @@ -4352,9 +4347,8 @@ static inline unsigned long vma_pages(const struct =
vm_area_struct *vma)
>   * If @vma is a MAP_PRIVATE file-backed mapping, then this returns the
>   * page offset within the file.
>   *
> - * Edge cases: nommu does not abide by these, MAP_PRIVATE-/dev/zero sati=
sfies
> - * vma_is_anonymous() but has file-backed page offset, and MAP_PRIVATE-p=
fnmap
> - * regions have their page offset set to the first PFN in the range.
> + * Edge cases: nommu does not abide by these and CoW MAP_PRIVATE-pfnmap =
regions
> + * have their page offset set to the first PFN in the range.
>   *
>   * Returns: The page offset of the start of @vma.
>   */
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 3307c0551a0a..4e8b2b29f6d3 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1136,8 +1136,7 @@ static inline pgoff_t linear_virt_page_index(const =
struct vm_area_struct *vma,
>         const pgoff_t pgoff =3D __linear_virt_page_index(vma, address);
>
>         VM_WARN_ON_ONCE(vma_test(vma, VMA_SHARED_BIT));
> -       /* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous=
. */
> -       if (vma_is_anonymous(vma) && !vma->vm_file)
> +       if (vma_is_anonymous(vma))
>                 VM_WARN_ON_ONCE(pgoff !=3D linear_page_index(vma, address=
));
>
>         return pgoff;
> diff --git a/mm/vma.c b/mm/vma.c
> index 103a6a134dec..d3e0457a11a1 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2622,6 +2622,13 @@ static bool map_is_dev_zero(const struct mmap_stat=
e *map)
>         return imajor(inode) =3D=3D MEM_MAJOR && iminor(inode) =3D=3D DEV=
ZERO_MINOR;
>  }
>
> +static void map_set_anon(struct mmap_state *map)
> +{
> +       map->file =3D NULL;
> +       map->vm_ops =3D NULL;
> +       map->pgoff =3D map->addr >> PAGE_SHIFT;
> +}
> +
>  static bool map_is_private(const struct mmap_state *map)
>  {
>         return !vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
> @@ -2629,10 +2636,7 @@ static bool map_is_private(const struct mmap_state=
 *map)
>
>  static bool map_is_anon(const struct mmap_state *map)
>  {
> -       if (!map_is_private(map))
> -               return false;
> -
> -       return !map->file || map_is_dev_zero(map);
> +       return map_is_private(map) && !map->file;
>  }
>
>  /*
> @@ -2664,7 +2668,7 @@ static int __mmap_new_vma(struct mmap_state *map, s=
truct vm_area_struct **vmap,
>
>         vma_iter_config(vmi, map->addr, map->end);
>
> -       if (is_anon && !map->file)
> +       if (is_anon)
>                 vma_set_anonymous(vma);
>
>         vma_set_range(vma, map->addr, map->end, map->pgoff, map->virt_pgo=
ff);
> @@ -2682,10 +2686,6 @@ static int __mmap_new_vma(struct mmap_state *map, =
struct vm_area_struct **vmap,
>         else if (!is_anon)
>                 error =3D shmem_zero_setup(vma);
>
> -       /* Temporary MAP_PRIVATE-/dev/zero workaround. */
> -       if (is_anon && map->file)
> -               vma_set_anonymous(vma);
> -
>         if (error)
>                 goto free_iter_vma;
>
> @@ -2814,6 +2814,14 @@ static int call_mmap_prepare(struct mmap_state *ma=
p,
>         map->vm_ops =3D desc->vm_ops;
>         map->vm_private_data =3D desc->private_data;
>
> +       /*
> +        * MAP_PRIVATE-/dev/zero mappings are an ancient way of getting
> +        * anonymous mappings. Rather than allowing these mappings to be =
odd
> +        * outliers, simply make them truly anonymous.
> +        */
> +       if (map_is_private(map) && map_is_dev_zero(map))
> +               map_set_anon(map);
> +
>         return 0;
>  }
>
> diff --git a/mm/vma.h b/mm/vma.h
> index 94277837ce6e..44fbb50dc3fe 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -267,9 +267,6 @@ static inline void assert_sane_pgoff(struct vm_area_s=
truct *vma, pgoff_t pgoff)
>          */
>         if (!vma_is_anonymous(vma))
>                 return;
> -       /* MAP_PRIVATE-/dev/zero is anon, non-NULL vm_file, but has file =
pgoff. */
> -       if (vma->vm_file)
> -               return;
>         /* If faulted in, could have been remapped. */
>         if (vma->anon_vma)
>                 return;
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index c617ee2532bd..c5191b9718fd 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1648,8 +1648,7 @@ static inline pgoff_t linear_virt_page_index(const =
struct vm_area_struct *vma,
>         const pgoff_t pgoff =3D __linear_virt_page_index(vma, address);
>
>         VM_WARN_ON_ONCE(vma_test(vma, VMA_SHARED_BIT));
> -       /* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous=
. */
> -       if (vma_is_anonymous(vma) && !vma->vm_file)
> +       if (vma_is_anonymous(vma))
>                 VM_WARN_ON_ONCE(pgoff !=3D linear_page_index(vma, address=
));
>
>         return pgoff;
>
> --
> 2.55.0
>
>
