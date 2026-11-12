Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484052;
	b=NMDcgSgi4wKLQdw3yat7B9QdXjaOndXlv2ar5XMSbQnS2UoyAez58G4prmGT3sXZdZRn
	 jlO5Yuq2H8/Sc281QAvJWWgq7AZmGVOGC8htx+NhnPLZV4/IbHCbcVUMbyroouqHQnEss
	 +o5Qs3cfR6oVeIlF2AeQxvqw+zcSCuHrfADptPZjsOGzrwnqbQv94CqIf6Yqst9qSx4Uu
	 yyH4RmhNYL2CtRev3p5uND71CQ/DeyKg/OIO5nYcjJHR4VHK4MuyCZNUXuDijSbFtxJqw
	 lWBBlkVbjIETPRixzJjObEGKC8LODoW2AaZf/1RLZwCWFtjl5OunV7jzdw9TwSvqwNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484052;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vM+TmZTTVlgAseJteA04V2b5gZJJ/nPwoEE1QOkg22k=;
	b=38vdFPHno3FH7bedRs/Lo3A0Cp3jSZL/IDRSKQJqXRtRAhBWVOI4MWfZb1aEUmCHz2jQ
	 whHrlIkyp5a9LrwdpAqnMhAFWDyI3DjWojs2VrjUdn+Kj6bZ8DnGYcT56aRl79j4FboQn
	 B6mM87cUlD4FQ6E5Y+zXwyA+xXLpHcelnB/Q9yd7/FBNYUaCfcrXoYKq1h7YRFDWhKz/B
	 PP6cJJKOGAluW3/faazttREIeTOYkh6BF489wS6q0nC+7mOtHjP2U01ztKCxoBtTS3/HL
	 niw4UqZnGHEEOjcjHeYlXyAs+8N7GekFLS+Ph8JzofxhZhjZREGZ5B3cKGe5ujFSA9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXSfiJSW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C8606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXSfiJSW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D011A1F00A05;
	Thu, 12 Nov 2026 11:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484052;
	bh=vM+TmZTTVlgAseJteA04V2b5gZJJ/nPwoEE1QOkg22k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QXSfiJSWVRJXBEP0SekW5iZErSus3IhESAmYYSoJ6gFHXzQa0SEJVUdZvq5ukRZDB
	 zIPjxW4etzEDjGqnuJfKbNVNZxoFMvzhZDS9m81YSp76lOMl2N4adQE3QXfqhBMfvA
	 9l5NsWktPRODSt3io3E2kVXyTOFCfLLIH6vAn1opAIncFXGuHBQ6cxmjLB2/4yrd/K
	 8UPGjOH77gUkh2AZC4I0bJ+fOkkAs2wHOmfKqa1zHKPt6SB7Ec0zuKXHtEtOnpQS1O
	 7Akv52un3uHhlY5kipQTVVs4WyWo7GPo7w0EOGpELT6Sn1Y9ieNLHwwZ5DbqObaFtC
	 55nWb1rCIF09g==
Date: Thu, 12 Nov 2026 13:47:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 3/6] ARM: drop CONFIG_HIGHPTE support
Message-ID: <avWnS7MLyPaJLaLR@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-4-arnd@kernel.org>
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
In-Reply-To: <20261112112528.1116405-4-arnd@kernel.org>

On Thu, Nov 12, 2026 at 12:25:25PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_HIGHPTE was added in linux-2.6.32, a few years before 64-bit
> support. At the time it made sense, as the CONFIG_ARM_LPAE option allowed
> systems with 16GB of memory that made lowmem a particularly scarce
> resource, and the HIGHPTE implementation gave feature parity with 32-bit
> x86 and frv machines.
> 
> Since Arm is the last architecture remaining that uses this, and almost
> no 32-bit machines support more than 4GB of RAM, the cost of continuing
> to maintain HIGHPTE seems unjustified, so remove it here to allow
> simplifying the generic page table handling.
> 
> Link: https://lore.kernel.org/lkml/20241204103042.1904639-8-arnd@kernel.org/T/#u
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I sent a patch to drop HIGHPTE support on x86 today, see
> https://lore.kernel.org/lkml/20241210144945.2325330-9-arnd@kernel.org/T/#u
> 
> If that one gets merged, we can merge this one instead of the one
> that makes HIGHPTE depend on !PREEMPT_RT, but if we decide against
> the x86 change, then we probably don't want this one either.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig               | 11 -----------
>  arch/arm/include/asm/pgalloc.h |  8 +-------
>  2 files changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fd01ccab9c12..fc66d52d847e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1225,17 +1225,6 @@ config HIGHMEM
>  
>  	  If unsure, say n.
>  
> -config HIGHPTE
> -	bool "Allocate 2nd-level pagetables from highmem" if EXPERT
> -	depends on HIGHMEM && !PREEMPT_RT
> -	default y
> -	help
> -	  The VM uses one page of physical memory for each page table.
> -	  For systems with a lot of processes, this can use a lot of
> -	  precious low memory, eventually leading to low memory being
> -	  consumed by page tables.  Setting this option will allow
> -	  user-space 2nd level page tables to reside in high memory.
> -
>  config ARM_PAN
>  	bool "Enable privileged no-access"
>  	depends on MMU
> diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
> index a17f01235c29..ef6cb3e6d179 100644
> --- a/arch/arm/include/asm/pgalloc.h
> +++ b/arch/arm/include/asm/pgalloc.h
> @@ -85,18 +85,12 @@ pte_alloc_one_kernel(struct mm_struct *mm)
>  	return pte;
>  }
>  
> -#ifdef CONFIG_HIGHPTE
> -#define PGTABLE_HIGHMEM __GFP_HIGHMEM
> -#else
> -#define PGTABLE_HIGHMEM 0
> -#endif
> -
>  static inline pgtable_t
>  pte_alloc_one(struct mm_struct *mm)
>  {
>  	struct page *pte;
>  
> -	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
> +	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
>  	if (!pte)
>  		return NULL;
>  	if (!PageHighMem(pte))

With HIGHPTE out this can be 

	if (pte)
		clean_pte_table(pte);

	return pte;

Otherwise

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>


> -- 
> 2.53.0
> 

-- 
Sincerely yours,
Mike.
