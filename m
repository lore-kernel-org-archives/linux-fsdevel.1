Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595996;
	b=hi9TKQmW/nc3wDpv0KMTJdnM5dr1etWiP4IYfyLkiInxKWFUPpq9hS+eDe+Nl+HWxrLw
	 Vc0hKTN1T9K/L6zqg9MXXYbdly17ZupUwg1+jsdUSA/zwCkOL0fJBUoAt0dWux6dgZYKY
	 fFUWMC3x/3G0KYAk5PYENEFjH9yTBIMnNqM3ObQa9C0aUIRxP1o0eVoCCP9iW6yrxlxYE
	 XQIZ+5pBctkAWmQWXTiB7TEVGOkJxmWokqBJfqShuqeEOhwd9Ctoi/mFOrMfDLlE3/3+Z
	 32AIeN9+/BE7T5s7Y/sURZdznpqPgXwXidewq473pHGSAvK6Y6XMEPRRQfX3A3d4VNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595996;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6DABqvPmRZQ9oUhOgSWnNOl71UnHng1Nk40a2Wv2ZOk=;
	b=kqGEcuLjINx1UqY0qMzp+8+jv/KUGI7mAlnZ8E2PuPPoZcIUwDiXxX992WrcosXQojzh
	 wcmUW8xaXeEhspk+tcvgsUQbH/UX9IfeR3QH4hU85WZZ33hlvHiXysve7QYUNH9pZbjEJ
	 KIACwXpP8F5WvZOh5IWyj3cS/0nmsX6PP+NiQOdGLbUuIIkU4d+h+YDZG7RLIfgYjNx4k
	 h4z1mb6ni7prXcVs5qH83F/QubpjNlpeTszDlALaVz8dmtwngLoUxygsYGFui8W5dBEtS
	 XyGZGt1rqWzwty87XQ84z/ybLznFpZ85XYGzxKC1G2z41zUQUCo1WHMsjlHz4pNjS6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZKwDank;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9BD606A32E
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZKwDank
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62B11F000C4;
	Fri, 13 Nov 2026 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794595996;
	bh=6DABqvPmRZQ9oUhOgSWnNOl71UnHng1Nk40a2Wv2ZOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VZKwDankvfuzex2kRsuuyuqHtFOBDmCaX+0WDxsKL/ouO87kgLIB3xb7y6yOm/l4j
	 S2Hzsy3SFJbSAfPNpN5/WCPjXE7lb2e5myi9k1xiqxrHzc763+i64zEJqAuEDsEm7w
	 uMkCEgAbD+8ekgjG4FklqyNU/1b5rvooVJAA1POv4y6HUtbiYHEgQgYDgPoAc+m9Hh
	 ToYoOlC742wO+lulBmOy7vDZnkmacJKxLOREhis/Tt2axILXyzJPa3zG9ixS/CXFAV
	 XBAzB3tDKbseqSfaR/otntCp+rYZDrvbMx/fIiAxtDqSI8W93FtHmyJCo6VYd9sBQy
	 zC+gw78C8+jvw==
Date: Fri, 13 Nov 2026 18:53:09 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Matthew Wilcox <willy@infradead.org>, 
	Malin Jonsson <malin.jonsson@est.tech>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 4/6] mm: drop HIGHPTE support altogether
Message-ID: <avdciuic3FAy6evm@gremlin>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-5-arnd@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112112528.1116405-5-arnd@kernel.org>

On Thu, Nov 12, 2026 at 12:25:26PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> With both x86 and arm having dropped CONFIG_HIGHPTE support, no
> architecture is left using it, so remove the remnants in common code.
>
> It is likely that further cleanups are possible in the page table
> code but those are not obvious from the config options.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

LGTM assuming Mike's changes :)

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/hugetlb.h | 5 +----
>  include/linux/mm.h      | 1 -
>  include/linux/pgtable.h | 9 ---------
>  3 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 58f755e70e96..7c6d191fdf50 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -178,7 +178,6 @@ void hugetlb_bootmem_set_nodes(void);
>
>  /* arch callbacks */
>
> -#ifndef CONFIG_HIGHPTE
>  /*
>   * pte_offset_huge() and pte_alloc_huge() are helpers for those architectures
>   * which may go down to the lowest PTE level in their huge_pte_offset() and
> @@ -193,7 +192,6 @@ static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
>  {
>  	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
>  }
> -#endif
>
>  pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long addr, unsigned long sz);
> @@ -1047,9 +1045,8 @@ static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>  	 */
>  	if (size >= PUD_SIZE)
>  		return pud_lockptr(mm, (pud_t *) pte);
> -	else if (size >= PMD_SIZE || IS_ENABLED(CONFIG_HIGHPTE))
> +	else if (size >= PMD_SIZE)
>  		return pmd_lockptr(mm, (pmd_t *) pte);
> -	/* pte_alloc_huge() only applies with !CONFIG_HIGHPTE */
>  	return ptep_lockptr(mm, pte);
>  }
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6af3b7008f1a..019de55bd796 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4025,7 +4025,6 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>
>  static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
>  {
> -	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
>  	BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
>  	return ptlock_ptr(virt_to_ptdesc(pte));
>  }
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 780fe849ff8b..1352b4cee7ae 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -100,14 +100,6 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
>  #define pte_offset_kernel pte_offset_kernel
>  #endif
>
> -#ifdef CONFIG_HIGHPTE
> -#define __pte_map(pmd, address) \
> -	((pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
> -#define pte_unmap(pte)	do {	\
> -	kunmap_local((pte));	\
> -	rcu_read_unlock();	\
> -} while (0)
> -#else
>  static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
>  {
>  	return pte_offset_kernel(pmd, address);
> @@ -116,7 +108,6 @@ static inline void pte_unmap(pte_t *pte)
>  {
>  	rcu_read_unlock();
>  }
> -#endif
>
>  void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
>
> --
> 2.53.0
>

--
Cheers, Lorenzo
