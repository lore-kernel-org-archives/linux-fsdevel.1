Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2641B362
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682988; cv=none; b=P7zELbOGX9t6j16c7l3b16BAGSF2CQGT/5d6awIvCy8CSHUvxxtq1lbui0ogQutSuy6/v0OFCLI3mzpafawVfqOSBLQAwN5+Lw01QjFwu66KWfUasMdAFmRLTtEFCCVy59CgQ6BajjfKqjd6XvW84JJjS2In6SbaR0IemPKT3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682988; c=relaxed/simple;
	bh=yM4mBnlTCjWQKlKfD+n5mx4+w5IOF843xqrIk/cdPTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyziXlkr/LDgwhvnjZATaEKS2Qkuh5AeiJvjI98j+lr8rje4oy6HTfsE9vsrIJlmQhBEZxWUhpe5PXQOo3jTNKB6te+diGL3P2w6+HRaTHN0JaYSeHnbMvxVoyxVPljtULP3xlrCyWQIgA0YcxPMAJQzxcmdF0dDu8TKHsiIeqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2E3mUXJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2E3mUXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765101F000E9;
	Fri, 10 Jul 2026 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783682978;
	bh=lTXqQqM4zep6luYNuf2HCeZ+pADRJ8jSNccCf2alJVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i2E3mUXJY51s+WNjMg+CmKCUPUnJf1olJ8H/R/xiLPc6+XHEgwTJYusGFpMufCsN0
	 95rwaCHaC4e5cliEEnF1DNm/u4yF0i2wK80Kf/x4toZ6xJx7bZ25+B6GWEYhgRRotU
	 GGw6WXcwl8hf60LAmTOdpXvYP13UMZxpr+25MQbfQvbKd1M+HdqfJ8+9Qqq7+bL5kn
	 4JjCv/S48QJAc67JqDoAHnS1ElmywHkWo+27tJIVDJRWBktGoQgwsw5QF1yC6WL2sJ
	 zKNPyZIviUtCm2fXttkLUs1p+uQ6pXr9qj4LOjddJIJnbTd8r6spb0tGGG6xcnF/Qs
	 WZ5QAI2pjdD3w==
Message-ID: <905c7dc9-a0d5-4b28-a899-53798fc4628e@kernel.org>
Date: Fri, 10 Jul 2026 13:29:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fs: stable_page_flags(): use folio_test_*() helpers
To: Jinjiang Tu <tujinjiang@huawei.com>, akpm@linux-foundation.org,
 ziy@nvidia.com, luizcap@redhat.com, willy@infradead.org,
 linmiaohe@huawei.com, svetly.todorov@memverge.com, xu.xin16@zte.com.cn,
 chengming.zhou@linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc: wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20260702110614.2176986-1-tujinjiang@huawei.com>
 <20260702110614.2176986-3-tujinjiang@huawei.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260702110614.2176986-3-tujinjiang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/2/26 13:06, Jinjiang Tu wrote:
> stable_page_flags() currently accesses folio->flags.f directly. Since
> commit 476d87d6a061 ("fs: stable_page_flags(): use snapshot_page()"), we
> can replace these raw flag accesses with the existing folio_test_*()
> helpers, thereby cleaning up the open‑coded flag handling.
> 
> For KPF_IDLE, set_ps_flags() already handles both 64‑bit and 32‑bit
> cases, so the duplicate code in stable_page_flags() that deals with
> CONFIG_PAGE_IDLE_FLAG for the 64‑bit case is removed.
> 
> The flag bits that has no folio_test_*() helpers are left unchanged,
> including PG_owner_priv_1, PG_arch_*.
> 
> No functional change is intended.
> 
> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
> ---
>  fs/proc/page.c | 94 ++++++++++++++++++++++++++------------------------
>  1 file changed, 49 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 2717dbb0431b..0dbd46fa84ea 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -148,8 +148,6 @@ u64 stable_page_flags(const struct page *page)
>  	const struct folio *folio;
>  	struct page_snapshot ps;
>  	unsigned long k;
> -	unsigned long mapping;
> -	bool is_anon;
>  	u64 u = 0;
>  
>  	/*
> @@ -163,17 +161,14 @@ u64 stable_page_flags(const struct page *page)
>  	folio = &ps.folio_snapshot;
>  
>  	k = folio->flags.f;
> -	mapping = (unsigned long)folio->mapping;
> -	is_anon = mapping & FOLIO_MAPPING_ANON;
> -
>  	/*
>  	 * pseudo flags for the well known (anonymous) memory mapped pages
>  	 */
>  	if (folio_mapped(folio))
>  		u |= BIT_ULL(KPF_MMAP);
> -	if (is_anon) {
> +	if (folio_test_anon(folio)) {
>  		u |= BIT_ULL(KPF_ANON);
> -		if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
> +		if (folio_test_ksm(folio))
>  			u |= BIT_ULL(KPF_KSM);
>  	}

These make sense.

>  
> @@ -181,10 +176,12 @@ u64 stable_page_flags(const struct page *page)
>  	 * compound pages: export both head/tail info
>  	 * they together define a compound page's start/end pos and order
>  	 */
> -	if (ps.idx == 0)
> -		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
> -	else
> +	if (ps.idx == 0) {
> +		if (folio_test_head(folio))
> +			u |= BIT_ULL(KPF_COMPOUND_HEAD);


Once we decouple folios from pages, we will have compound pages that are not
folios. PG_head is not folio specific.

But then, some of the flags below are used in other context outside of folios.

I would focus here only on converting things to use folios that will actually be
folio-specific: like the folio_test_anon() above.


> +	} else {
>  		u |= BIT_ULL(KPF_COMPOUND_TAIL);
> +	}
>  	if (folio_test_hugetlb(folio))
>  		u |= BIT_ULL(KPF_HUGE);
>  	else if (folio_test_large(folio) &&
> @@ -201,6 +198,9 @@ u64 stable_page_flags(const struct page *page)
>  	if (ps.flags & PAGE_SNAPSHOT_PG_BUDDY)
>  		u |= BIT_ULL(KPF_BUDDY);
>  
> +	if (ps.flags & PAGE_SNAPSHOT_PG_IDLE)
> +		u |= BIT_ULL(KPF_IDLE);
> +

That looks like an independent cleanup, right? Should probably go in a separate
patch then.

>  	if (folio_test_offline(folio))
>  		u |= BIT_ULL(KPF_OFFLINE);
>  	if (folio_test_pgtable(folio))
> @@ -208,42 +208,46 @@ u64 stable_page_flags(const struct page *page)
>  	if (folio_test_slab(folio))
>  		u |= BIT_ULL(KPF_SLAB);
>  
> -#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
> -	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
> -#else
> -	if (ps.flags & PAGE_SNAPSHOT_PG_IDLE)
> -		u |= BIT_ULL(KPF_IDLE);
> -#endif
> -
> -	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
> -	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
> -	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
> -	u |= kpf_copy_bit(k, KPF_WRITEBACK,	PG_writeback);
> -
> -	u |= kpf_copy_bit(k, KPF_LRU,		PG_lru);
> -	u |= kpf_copy_bit(k, KPF_REFERENCED,	PG_referenced);
> -	u |= kpf_copy_bit(k, KPF_ACTIVE,	PG_active);
> -	u |= kpf_copy_bit(k, KPF_RECLAIM,	PG_reclaim);
> -
> -#define SWAPCACHE ((1 << PG_swapbacked) | (1 << PG_swapcache))
> -	if ((k & SWAPCACHE) == SWAPCACHE)
> -		u |= 1 << KPF_SWAPCACHE;
> -	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
> -
> -	u |= kpf_copy_bit(k, KPF_UNEVICTABLE,	PG_unevictable);
> -	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
> -
> -#ifdef CONFIG_MEMORY_FAILURE
> -	if (u & (1 << KPF_HUGE))
> -		u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
> -	else
> -		u |= kpf_copy_bit(ps.page_snapshot.flags.f, KPF_HWPOISON, PG_hwpoison);
> -#endif
> +	if (folio_test_locked(folio))
> +		u |= BIT_ULL(KPF_LOCKED);
> +	if (folio_test_dirty(folio))
> +		u |= BIT_ULL(KPF_DIRTY);
> +	if (folio_test_uptodate(folio))
> +		u |= BIT_ULL(KPF_UPTODATE);
> +	if (folio_test_writeback(folio))
> +		u |= BIT_ULL(KPF_WRITEBACK);
> +
> +	if (folio_test_lru(folio))
> +		u |= BIT_ULL(KPF_LRU);
> +	if (folio_test_referenced(folio))
> +		u |= BIT_ULL(KPF_REFERENCED);
> +	if (folio_test_active(folio))
> +		u |= BIT_ULL(KPF_ACTIVE);
> +	if (folio_test_reclaim(folio))
> +		u |= BIT_ULL(KPF_RECLAIM);
> +
> +	if (folio_test_swapcache(folio))
> +		u |= BIT_ULL(KPF_SWAPCACHE);
> +	if (folio_test_swapbacked(folio))
> +		u |= BIT_ULL(KPF_SWAPBACKED);
> +	if (folio_test_unevictable(folio))
> +		u |= BIT_ULL(KPF_UNEVICTABLE);
> +	if (folio_test_mlocked(folio))
> +		u |= BIT_ULL(KPF_MLOCKED);
> +
> +	if ((folio_test_hugetlb(folio) && folio_test_hwpoison(folio))
> +		|| PageHWPoison(&ps.page_snapshot))
> +		u |= BIT_ULL(KPF_HWPOISON);
> +
> +	if (folio_test_reserved(folio))
> +		u |= BIT_ULL(KPF_RESERVED);

That is not a pure folio flag.

> +	if (folio_test_owner_2(folio))
> +		u |= BIT_ULL(KPF_OWNER_2);
> +	if (folio_test_private(folio))
> +		u |= BIT_ULL(KPF_PRIVATE);
> +	if (folio_test_private_2(folio))
> +		u |= BIT_ULL(KPF_PRIVATE_2);

These as well.

So I'd probably leave the page bit checking alone for now and focus on the
mapping only.

-- 
Cheers,

David
