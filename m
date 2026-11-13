Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567046;
	b=Rx8vYMA2/yFx1JDVj0f6FGlcnEBC6VwhdKcJ8qKj5+QK38LGvULIEmHiAWNR+3WmI8YL
	 HTkOz1YuiBb2WueVp4ZkSG5w7Hw02t7PPzZ16X85mGyQI63/JHEvBz+1asPZS3LiOgi8I
	 S1vQgw8el77pw3U40M3CzFV06QwtQDh7UCEZ0SZTcELR+uukWHPnPG7gVX1frik7sodDz
	 5DqI9v0HrZf571LprSWQz4L4Tvvsh2vwdcbrT498AWOwW3IkDohxHtTLLkcWZBKwKxvwo
	 kVotPtv3OIcILzERBXMXzbGozaRjwZXLgRbiLpcb0Xu7e/+2L+TMGbzmR1Hjy4IYMqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567046;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0JXP8ijEUph+DH7eK7vAJyLP+Bw6tzlYEIbg+5Jovus=;
	b=ZLPperkLy2NbH1YgAW0U75W6RAcSfXxlU6HlS6O/1H6/aTEDikICuH1mce+CWphD7XbK
	 Gh03t/BQ235XY1l5HSlmpqcJhfDmgl4wimgYhI30GHx3/twQ0tk+CwLTdmjjXhehHGXbI
	 3cCEsXNFs5o4eAnOOwJAfZyW9thrXNXzjl/yHkqftiPj00lpJR4rOdS3FCy49cj3EPZ/6
	 hD5hYNqRGaPsslkn4/lwnX3S7KhYu3/Rigaax5D5hVLzHNMT3NI2yJHxH8IwZHS+tLRN7
	 Oyrj5gUMo13z2L+rihttU9I+UAbBc+A6BXhinOl6NqOd012ooEYnDvYcN7DBa197IQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NneODPg5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A260A381D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NneODPg5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4D81F000D2;
	Fri, 13 Nov 2026 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794567045;
	bh=0JXP8ijEUph+DH7eK7vAJyLP+Bw6tzlYEIbg+5Jovus=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NneODPg5Lm7PgKusVQTTjim0GwSW5e0lbqq+NWR9bvLd97yPbNhZe9Y0LmWebgvgL
	 CAOw1Ac+t8trQnJncFKKYqIgJl0yTBlsebndJYxBEBtu5oO/s6z+Azwf8gH7aeUgLH
	 OikDWGvl1iYsa12pbPkUNFWo/BVTZKVL6VA0YhDbEp5pWjYPb6lKn/2+/qR+fOcvdW
	 vYMHEdFGcGtOrsxK/QjxDvOhs8YYEUrxU4gtiJ+DfTGvlbyKCAjYd6k9gyMHsEBf1P
	 XCHGwM3DJvppC4w3ICUq1nllm6XFK6Qbjj8dzvOi4r5KSgPFnetZ8KTT9img7cvlZM
	 MLwoFy43sV16g==
Message-ID: <abbeb2f5-0ce7-4fc4-b16d-6e9226989acd@kernel.org>
Date: Fri, 13 Nov 2026 11:50:39 +0100
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
Subject: Re: [PATCH v2 4/6] mm: drop HIGHPTE support altogether
To: Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Andreas Larsson <andreas@gaisler.com>, Christophe Leroy
 <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Malin Jonsson <malin.jonsson@est.tech>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-5-arnd@kernel.org> <avWo4NrAPX8BisCY@kernel.org>
 <ba23a789-9820-4223-a6db-d9e99ebcf356@app.fastmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ba23a789-9820-4223-a6db-d9e99ebcf356@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 14:26, Arnd Bergmann wrote:
> On Thu, Nov 12, 2026, at 12:54, Mike Rapoport wrote:
>> On Thu, Nov 12, 2026 at 12:25:26PM +0100, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> With both x86 and arm having dropped CONFIG_HIGHPTE support, no
>>> architecture is left using it, so remove the remnants in common code.
>>>
>>> It is likely that further cleanups are possible in the page table
>>> code but those are not obvious from the config options.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  include/linux/hugetlb.h | 5 +----
>>>  include/linux/mm.h      | 1 -
>>>  include/linux/pgtable.h | 9 ---------
>>>  3 files changed, 1 insertion(+), 14 deletions(-)
>>
>> With this and arm HIGHPTE patches applied there are still a few leftovers:
>>
>> $ git grep  HIGHPTE
>> arch/arm/configs/vt8500_v6_v7_defconfig:CONFIG_HIGHPTE=y
> 
> This got dropped in patch 5/6 in v2, but I've moved that here now.
> 
>> mm/memory.c:     * Dumping the PTE would be nice, but it's tricky with 
>> CONFIG_HIGHPTE,
> 
> Added the patch below for this. Untested so far.
> 
>> mm/pgtable-generic.c: * kmapped if necessary (when CONFIG_HIGHPTE), and 
>> locked against concurrent
> 
> Updated the comment and also dropped __pte_map() after I noticed that
> open-coding the only caller in pte_offset_map_rw_nolock() is consistent
> with that comment change:
> 
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -314,7 +314,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
>                 pmd_clear_bad(pmd);
>                 goto nomap;
>         }
> -       return __pte_map(&pmdval, addr);
> +       return pte_offset_kernel(&pmdval, addr);
>  nomap:
>         rcu_read_unlock();
>         return NULL;
> 
> 
>> mm/userfaultfd.c:        * index ordering when CONFIG_HIGHPTE is 
>> enabled. We mapped dst_pte
> 
> Dropped that comment block as it no longer applies.
> 
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Thanks,
> 
>       Arnd
> ---
> Subject: [PATCH] mm: print pte in __print_bad_page_map_pgtable()
> 
> HIGHPTE support is gone now, so it's easy enough to print the
> PTE here along with the upper level entries.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index ec3d9d99ccee..dabeb5568c94 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -528,9 +528,11 @@ static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long add
>  	char p4d_str[PTVAL_STR_MAX];
>  	char pud_str[PTVAL_STR_MAX];
>  	char pmd_str[PTVAL_STR_MAX];
> +	char pte_str[PTVAL_STR_MAX];
>  	p4d_t p4d, *p4dp;
>  	pud_t pud, *pudp;
>  	pmd_t pmd, *pmdp;
> +	pte_t pte, *ptep;
>  	pgd_t *pgdp;
>  
>  	/*
> @@ -567,13 +569,18 @@ static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long add
>  	pmd = pmdp_get(pmdp);
>  	ptval_to_str(pmd_str, pmd_val(pmd));
>  
> -	/*
> -	 * Dumping the PTE would be nice, but it's tricky with CONFIG_HIGHPTE,
> -	 * because the table should already be mapped by the caller and
> -	 * doing another map would be bad. print_bad_page_map() should
> -	 * already take care of printing the PTE.
> -	 */
> -	pr_alert("pgd:%s p4d:%s pud:%s pmd:%s\n", pgd_str, p4d_str, pud_str, pmd_str);
> +	if (!pmd_present(pmd) || pmd_leaf(pmd)) {
> +		pr_alert("pgd:%s p4d:%s pud:%s pmd: %s\n",
> +			 pgd_str, p4d_str, pud_str, pmd_str);
> +		return;
> +	}
> +
> +	ptep = pte_offset_kernel(pmdp, addr);
> +	pte = ptep_get(ptep);
> +	ptval_to_str(pte_str, pte_val(pte));
> +
> +	pr_alert("pgd:%s p4d:%s pud:%s pmd:%s pte:%s\n",
> +		 pgd_str, p4d_str, pud_str, pmd_str, pte_str);
>  }
>  
>  /*

Yeah, that LGTM. I assume you'll send out a v3.

-- 
Cheers,

David
