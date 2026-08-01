Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE922E3F0;
	Sat,  1 Aug 2026 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785576983; cv=none; b=Wn6QW0so0akl81rcCVH5LSm6E4ghE0HhRYKG2NGgEMAgd86OafglRsGurYCtt2DF0TwdDEvt/Ye+vYTJfMHQvKDnVRm4YBHksXh+kwQebMpXFY7TzFJgLfHDqF1Am2Qf3hoRsQw4MMLLBx5wos3H7n8/OJrIEaw46r57eEqATCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785576983; c=relaxed/simple;
	bh=CEe/FRprcKODc2y9BNtL9FlextKV3tyXyPlJXZJA/Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecvS4kThZ0ff8vE+Xg7giijwnetkX8KYqIJHp5L2ed5a/pQm49nW4Q4vRKnVkPnm9YewDzrFXtu/NNgOVjnbRRLHJYy1MyAqkEC/1raaFFnZC4TtNlvBQddISuoC0wl8yFqr+qMrcEjPeRhPvrb0gajOdv/DLTXSwUtNMa4cY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZaAr1pW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZaAr1pW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154941F00AC4;
	Sat,  1 Aug 2026 09:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785576981;
	bh=709PrRE4T6mqHxV2NldJPDtfXEbe8pwqFIDr7kni5hQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mZaAr1pWTIuDLBtCszvPR8u1+iDcJ95gaenhrfArddi5Uu4gBhXOIyw/4zH7JfxXI
	 5l2zs5HbYWmIj6FsSB00mOpWBEvqjRrOmyozQlsFES9VE3iwdUSkINUJKb/0E5iHC9
	 dkT/beAsMUAHwXIYHraJ/X8arV7DA2dxu/t+94Ds5t23AN9ys2S1+g6wc96k3RKRf2
	 3qMIAMLEyZ+6d+hMmPIRtHkaB70dB18NWQBxjcyzRzMo2dcBoxiiGR8zd/xfxGqw22
	 Eb/w8ugVZkU5p18je3Sc34gGWTAqVH6v/nWLiwUvTFeTDFZYN18droYQ6KA/dE8+E6
	 zn6/ma2FuClxw==
Date: Sat, 1 Aug 2026 10:36:03 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	William Kucharski <william.kucharski@oracle.com>, David Hildenbrand <david@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm/huge_memory: use folio's memcg inside
 __folio_split()
Message-ID: <am28pV2PEfHsi4p-@lucifer>
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
 <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>

On Thu, Jul 30, 2026 at 10:18:00PM -0400, Zi Yan wrote:
> During a pagecache folio split, an xarray node allocation can happen and
> needs to charge at folio's memcg instead of folio split invoker's memcg,
> because for example folio split can happen during reclaim and reclaim's
> active memcg might not be folio's memcg. Switch to folio's memcg at the
> beginning and switch back afterwards.

I assume this is the only allocation? I guess in general it makes sense to have
the folio's memcg be active here regardless.

>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")

Cc: stable?

> Signed-off-by: Zi Yan <ziy@nvidia.com>

Change seems reasonable overall.

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/huge_memory.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 04e8a6b553435..b9c2d8908e564 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4063,34 +4063,42 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>  	struct folio *end_folio = folio_next(folio);
>  	bool is_anon = folio_test_anon(folio);
> +	struct mem_cgroup *memcg, *old_memcg;
>  	struct address_space *mapping = NULL;
>  	struct anon_vma *anon_vma = NULL;
>  	int old_order = folio_order(folio);
>  	struct folio *new_folio, *next;
>  	int nr_shmem_dropped = 0;
>  	enum ttu_flags ttu_flags = 0;
> -	int ret;
>  	pgoff_t end = 0;
> +	int ret;
>
>  	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
>  	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
>
>  	if (folio != page_folio(split_at) || folio != page_folio(lock_at)) {
>  		ret = -EINVAL;
> -		goto out;
> +		goto out_no_memcg;
>  	}
>
>  	if (new_order >= old_order) {
>  		ret = -EINVAL;
> -		goto out;
> +		goto out_no_memcg;
>  	}
>
>  	ret = folio_check_splittable(folio, new_order, split_type);
>  	if (ret) {
>  		VM_WARN_ONCE(ret == -EINVAL, "Tried to split an unsplittable folio");
> -		goto out;
> +		goto out_no_memcg;

This function really badly needs splitting up and probably some cleanup.h work :)

>  	}
>
> +	/*
> +	 * switch to folio's memcg as xarray node allocation can happen and
> +	 * needs to charge to it.
> +	 */
> +	memcg = get_mem_cgroup_from_folio(folio);
> +	old_memcg = set_active_memcg(memcg);
> +
>  	if (is_anon) {
>  		/*
>  		 * The caller does not necessarily hold an mmap_lock that would
> @@ -4231,6 +4239,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	if (mapping)
>  		i_mmap_unlock_read(mapping);
>  out:
> +	/* restore to caller's old_memcg */
> +	set_active_memcg(old_memcg);
> +	mem_cgroup_put(memcg);
> +out_no_memcg:
>  	xas_destroy(&xas);
>  	if (is_pmd_order(old_order))
>  		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
>
> --
> 2.53.0
>

--
Cheers, Lorenzo
