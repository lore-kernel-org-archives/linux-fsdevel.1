Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595320;
	b=Q1P2A/o1TsSG4x5lNTfqJAGV1PoBFNMYZ3UphwGj+i/ffVBKPZ8ElrWUb8Grz+/LYCCQ
	 vTbKxk2eR4XkwcmfAnjjmmiucGzZgyir+OXApeNmx0gFeFPvSwp6T/Y5z91T2r8I4Wsuj
	 01JjaF5ejDe4xz3zWBbOxzscl0OEtMi05k72h+Q4dqsVn7yxkTjoxfupznhoacozSgECM
	 lTuixg+WjoWbllnZ4D0c4jopYGtHWCvBwSAtMxdqmylmJk2dHPi7/7Y+ULDkcj6mpXY1V
	 ip/YqqY3iASfG/yNGznsLncEO/5knh4L12rWgHw/RCaHfi6lXi8CRyBqRR946WLecuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595320;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VytgQi4p8wcmmELrEfY15mVmpLYzi4XAlS7bqFMpaOA=;
	b=o722jlAENY61mM9P4BFITebrL+JZMqWlWqgIuCEwwqdzLBdAgEp5w0emgamRvRrfyHJG
	 DWdn6Hw+i+R3jaKZYHx1upTvhy2jXRv/fYI3MUzQZt4uH/9ldHo4YTqIFrdQzAHzPIyx9
	 Qa8qejfC6GeMjc3TC5ShvPqTGqjjX+Rv9Oj41kY9mzfG/hpaE9VVq6j5DsPFeQgGuNCpn
	 Xyc67olA9N2p/jmVeRN9+38jvq/MHN7ruv0DR1+ktcvujQ0CPwwtKEpdYSQx/UiCv3vPY
	 Im0Gcfee+82Aa7ZcZhonqW9sscDy3ZQobtzwYISif5P7sJMgvdDU4CasvUpLUAI4x2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cfI/L2eY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6F606A330
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfI/L2eY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0221F000C4;
	Fri, 13 Nov 2026 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794595319;
	bh=VytgQi4p8wcmmELrEfY15mVmpLYzi4XAlS7bqFMpaOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cfI/L2eY2qjwVL7APHC67QJOIGk/JNOUabcKBMNTHVN19Rcz72eUV6Yh3y5Ea/LHZ
	 z5QbQ0lofex0YKPkP/CrCot0WtLB3Iun9cb9TpGzWGq7i0diBi7RiTfH+PMAtEzL2+
	 C0j/tS7srsbkDAQQkLK7ashTa4LxtBlawzOcVQduTw15A7JC0FoBx70BE+lVHeY9Dq
	 c07fq9ZOjzPKmREqLefO5blbiTlVapyN80u0xRg/xm4Y01ZY7klw7sdg1ydyXEPskb
	 46DP+YMZNRJ2jvH8liJQifBhGUdO/X8ERo88dTaNWRmserH3XKGKSg7PzJ1GdT/0k3
	 sU3CZpk80JuTg==
Date: Fri, 13 Nov 2026 18:41:52 +0000
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
Subject: Re: [PATCH v2 3/6] ARM: drop CONFIG_HIGHPTE support
Message-ID: <avdZ5SCLnUg29Te8@gremlin>
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

With Mike's change applied, LGTM and:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

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
> --
> 2.53.0
>

--
Cheers, Lorenzo
