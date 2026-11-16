Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862622;
	b=jV2XgSwioICfi2ZfV/20u8eg4arSPZJdBl6oQlg4XtiHu2I1s7/GQCAxMv9DBgaTzSnJ
	 1YG3a5Jyl0OPrQx50OnGmiVkyMEKpqVVPlm2/rE06pw3IAnqihB/HkpWM1hmPvrtGqxIG
	 4V/5FH4+uSUNoTiZKdf5SI9MWTkMQ5v9ntsTYkHQkuT6fXbJUIZ9IP8E3ASW4w/viAJPh
	 A/ypr0KJyGLMzkpEnZiBBzIyerEgCyx71Db2kGRQlpIx9+REClyMUbNMnndAPQqOIM+Z4
	 cE3x1Io/PtNEQ5UYneERMGtXx+nf7+8ChTk/nboGR5JQeYgAFLG24wfqRpomqjglQFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862622;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MtRGWIC2vir7npOOqtBcJjVE7mLonnCdITKCBiWXfn8=;
	b=bQ42/vaFmjnN+o8E8HQQ3d3gseT2oN8nHt8czNkPgGGZAFoi4Pp1w+JQnz6HmKzmRoXx
	 jLstxCidwSrsnPZgOI/J/r2BKJSoiM+uC20O0lxvM/EF/Rkgu+EKp3lWWlKRgkZm3S6wX
	 6eFZZFjqTb2UM+g49qUYM/3K+IcFxXk1nMgvM+dc2RJISytZGCfaMcAOpCNfK29cSORue
	 CsjpqpQFXq8PtkEZRsMXHJARiWZI/qAHTGqvsblxK9I23qull1E0Xy0JmHjsJZE6TiFjc
	 0l4QYvfqsLDihtSUE6U7Vb8q6VrUTKpV5W1NoB6ErTKl8jNd/gDwKX/Rg6C0MUT7JdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZIrd9/0w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11C606A329;
	Mon, 16 Nov 2026 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIrd9/0w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD351F000C4;
	Mon, 16 Nov 2026 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794862622;
	bh=MtRGWIC2vir7npOOqtBcJjVE7mLonnCdITKCBiWXfn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZIrd9/0ww/GnH4ovEs2bI18NsQ4JxS4tZCjL+VYVz8r8SGlJu1vI/1l8v8zlq8gyf
	 FToW6J2hOXKZ6WGMKc9ht5LWZ+edDkQBGfH5wI/3ypkQaSTiaFNZCU3fhCEk4xPp3/
	 7DacL0Cj3337gnbrXJdYJr8gmvvJ4P9gvuPu8uxbx1zPyphV2OocCXkPMtynM76xn1
	 lAnsQC3bf3vMJ9woYr2+NIfQmBx0iQs4jDwOccZ/8pqUlS3TA01EDoH8gCAjY54n7h
	 9Awd+h4xGPj2Vc2/+pkbMhaQpB8LYbfkc6NAZwzNSBSvl2apCDGwqhcqBor1dVpH0j
	 8bwl0Z9qf+/qA==
Message-ID: <2837958f-5a9d-46ad-b6ff-5a922b09e81a@kernel.org>
Date: Mon, 16 Nov 2026 21:56:48 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] mm/userfaultfd: check hugetlb end alignment in
 UFFDIO_UNREGISTER pre-scan
To: Tal Zussman <tz2294@columbia.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Michal Hocko <mhocko@suse.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Andrei Vagin <avagin@gmail.com>, Muhammad Usama Anjum <usama.anjum@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
 <20261116-uffd-state-fixes-v2-9-4397a0196479@columbia.edu>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261116-uffd-state-fixes-v2-9-4397a0196479@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 21:02, Tal Zussman wrote:
> UFFDIO_REGISTER and UFFDIO_UNREGISTER both scan the VMAs of the range
> before changing anything. For a hugetlb VMA, userfaultfd_register()
> rejects a range whose start or end is not huge page aligned there.
> However, userfaultfd_unregister() only checks the start.
> 
> An unaligned end only fails later, when vma_modify_flags_uffd() cannot
> split the VMA there. At that point, userfaultfd_clear_vma() already
> cleared the WP or RWP protection. The ioctl returns -EINVAL and the VMA
> stays registered, but accesses to its pages are no longer reported. This
> requires a caller passing a misaligned range.
> 
> To fix it, check the end of a registered VMA in the pre-scan as well.
> The ioctl still returns -EINVAL, but no longer unregisters the VMAs
> before the misaligned one first.
> 
> Fixes: cab350afcbc9 ("userfaultfd: hugetlbfs: allow registration of ranges containing huge pages")
> Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Okay, I assume it's not a stable kernel, so we can fix this in a cleaner way.

> ---
>  mm/userfaultfd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index bf42fabb5afd..d8abc24353e1 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -3960,6 +3960,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	found = false;
>  	cur = vma;
>  	do {
> +		const struct userfaultfd_ctx *vma_ctx = cur->vm_userfaultfd_ctx.ctx;
> +
>  		cond_resched();
>  
>  		VM_WARN_ON_ONCE(!!cur->vm_userfaultfd_ctx.ctx ^
> @@ -3983,6 +3985,15 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
>  			goto out_unlock;
>  
> +		/* See the check in userfaultfd_register(). */
> +		if (vma_ctx && vma_is_hugetlb(cur) &&

I'm not sure if we really need the vma_ctx. I'd just fail this consistently if
someone passes hugetlb VMAs, independent of if they are registered or not.

> +		    end <= cur->vm_end && end > cur->vm_start) {
> +			const unsigned long vma_hpagesize = vma_kernel_pagesize(cur);

vma_kernel_pagesize(), yuk. :)

> +
> +			if (!IS_ALIGNED(end, vma_hpagesize))
> +				goto out_unlock;
> +		}
> +
>  		found = true;
>  	} for_each_vma_range(vmi, cur, end);
>  	VM_WARN_ON_ONCE(!found);


Can we clean all this up into something simple like:

--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3669,6 +3669,19 @@ static __always_inline int validate_range(struct
mm_struct *mm,
 	return validate_unaligned_range(mm, start, len);
 }

+static bool vma_uffd_range_aligned(struct vm_area_struct *vma,
+	unsigned long start, unsigned long end)
+{
+	unsigned long size;
+
+	if (!vma_is_hugetlb(vma))
+		return true;
+
+	size = huge_page_size(hstate_vma(vma));
+	return IS_ALIGNED(max(start, vma->vm_start), size) &&
+	       IS_ALIGNED(min(end, vma->vm_end), size);
+}
+
 static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
@@ -3747,17 +3760,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	if (!vma)
 		goto out_unlock;

-	/*
-	 * If the first vma contains huge pages, make sure start address
-	 * is aligned to huge page size.
-	 */
-	if (vma_is_hugetlb(vma)) {
-		unsigned long vma_hpagesize = vma_kernel_pagesize(vma);
-
-		if (start & (vma_hpagesize - 1))
-			goto out_unlock;
-	}
-
 	/*
 	 * Search for not compatible vmas.
 	 */
@@ -3774,6 +3776,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		ret = -EINVAL;
 		if (!vma_can_userfault(cur, vm_flags, wp_async))
 			goto out_unlock;
+		if (!vma_uffd_range_aligned(cur, start, end))
+			goto out_unlock;

 		/*
 		 * RWP uses protnone as an access-tracking marker. PROT_NONE
@@ -3797,20 +3801,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		ret = -EPERM;
 		if (unlikely(!(cur->vm_flags & VM_MAYWRITE)))
 			goto out_unlock;
-
-		/*
-		 * If this vma contains ending address, and huge pages
-		 * check alignment.
-		 */
-		if (vma_is_hugetlb(cur) && end <= cur->vm_end &&
-		    end > cur->vm_start) {
-			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
-
-			ret = -EINVAL;
-
-			if (end & (vma_hpagesize - 1))
-				goto out_unlock;
-		}
 		if ((vm_flags & VM_UFFD_WP) && !(cur->vm_flags & VM_MAYWRITE))
 			goto out_unlock;

@@ -3920,17 +3910,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx
*ctx,
 	if (!vma)
 		goto out_unlock;

-	/*
-	 * If the first vma contains huge pages, make sure start address
-	 * is aligned to huge page size.
-	 */
-	if (vma_is_hugetlb(vma)) {
-		unsigned long vma_hpagesize = vma_kernel_pagesize(vma);
-
-		if (start & (vma_hpagesize - 1))
-			goto out_unlock;
-	}
-
 	/*
 	 * Search for not compatible vmas.
 	 */
@@ -3959,6 +3938,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		 */
 		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
 			goto out_unlock;
+		if (!vma_uffd_range_aligned(cur, start, end))
+			goto out_unlock;

 		found = true;
 	} for_each_vma_range(vmi, cur, end);

-- 
Cheers,

David
