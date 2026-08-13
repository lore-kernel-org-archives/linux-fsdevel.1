Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3CC367293
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609768; cv=none; b=T3VltahEDyJxeQDyY5why9rb4rOKT6Bfh9KBJefogk05dh8Oi/9QLRSctufZPiAypjgG7znR6QkZLx4GuVPvDssumOcoxvRJaIIgP0hHDb15pkQkdOk53V8iNfW0GnU30NWaLxHVDp2raqVmPduL0p3zhMxVo3rYyZ0h0VYPcKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609768; c=relaxed/simple;
	bh=/K/bkOzgL7780DZQOn2/eC0ywKf/4sKD3SzPx0oqdEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/3N22VUamjkbdJnY0qy7FwGPARSO/GxfUTjz3VKy3BdNdChqq1Cghy+tA30gLoPvK4byySNHAPpfh6WQCht0Uhs8Bwo6ShdHzyoZPd7VzH2Vgs9T6ubhm0zKdWh2bVPubJpn8ONuHfsHEc1NiZg04iOKhFtFajQWWOrKbuwu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPH7IB6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPH7IB6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC001F000E9;
	Thu, 13 Aug 2026 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786609765;
	bh=D0j2EWmhCM0P00w1S22i5WnZMePeZSUmS6q+/vdBi8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iPH7IB6rdaiorylVVpDDyRgdfQPy21XCoWB5/8jOtXHcfDCl5FdyYnftVKD/W10tM
	 +uQfpx7HGEYF2Gx6BeedfWKky+JEoz9IgDddbJlxzjK9LBNafJ03II47qRkCx4JaOF
	 e3m6GRuws8olyQRzpShxe4vcMgLp/VhKGXsEwBISDuN3xBbh+81gtiROQBtZJYMAW8
	 JL9u1tcXlJ8WbOXYa6X9BLdCTPHEtFprD767Ya+gtX/ZYjuQpGQLwMry5ap5LzcvMz
	 +3fWJkL2a41X1jElyeh5MrcYA2DdUy7opm0Q8adu66j/NPRYhzvyiino1p/mJprTab
	 wqi2Bz8vljeqw==
Message-ID: <a51a6236-8881-4479-8f04-39676e0e1f14@kernel.org>
Date: Thu, 13 Aug 2026 10:29:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/15] hugetlb: Use the has_hwpoisoned flag
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>,
 linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <christian@brauner.io>,
 Jiaqi Yan <jiaqiyan@google.com>, "Gregory Price (Meta)" <gourry@gourry.net>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-9-willy@infradead.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260805210557.1118966-9-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 23:05, Matthew Wilcox (Oracle) wrote:
> Other large folios use the has_hwpoisoned flag.  Convert hugetlb to match.
> This will help us use the per-page hwpoison flag in the future.

Currently, the first thing we do in hugetlb_update_hwpoison() is:

	int ret = folio_test_set_hwpoison(folio);

So a hugetlb folio *always* has folio_test_hwpoison() set.

So we can locklessly check whether a hugetlb folios has the flag set simply by
... checking whether it's a hugetlb folio and has the flag set.

Then you write:

"This closes a gap where a page in a previously-poisoned hugetlb folio
could be observed to not have the hwpoison bit set."

When does the race you describe become relevant? When freeing the hugetlb folio
or when demoting it? in both cases, we should be holding the hugetlb lock that
nasty hwpoison code could sync with (if it doesn't already do that).


I can understand that we want something that covers both scenarios: an
indication whether any large folio has any hwpoisoned page. Such a unification
would be good.

But then, special-casing hugetlb *again* through folio_test_huge_poison(),
that's rather odd, no?

(what on earth is "huge_poison" is this supposed to be "hugetlb_poison" ? Why
"poison" and not "hwpoison"? Really odd)

I'd expect that we actually get rid of folio_test_hwpoison entirely and
exclusively work on per-page state and has_hwpoison. But IIUC, now it's some
mixture of folio checks, page checks, folio_has, mixed with some hugetlb oddity.

I am not quite clear whether the change you propose here is actually required
for the remainder of this series?

	[PATCH v9 00/15] Use generic_file_read_iter() in hugetlbfs

IOW, do we really need all this hugetlb hwpoison handling just to accomplish
that, or could some of that (bigger hwpoison rework) be done separately?


[...]

> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1978,6 +1978,22 @@ static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
>  				     FPB_RESPECT_WRITE | FPB_RESPECT_SOFT_DIRTY);
>  }
>  
> +/*
> + * Since we cannot split a hugetlb folio, we want to insert a poison
> + * entry into the page table for the whole folio even if only one page
> + * is poisoned.  Otherwise, we've split down to the PTE level and we only
> + * want to poison the precise page
> + */
> +static bool ttu_create_hwpoison(const struct folio *folio,
> +		const struct page *page, enum ttu_flags flags)
> +{
> +	if (!(flags & TTU_HWPOISON))
> +		return false;

Why not keep the flag in the caller? Really looks weird given that we have two
users and one of them doesn't even need the check and must fake it.

I also don't quite enjoy the function name, and it's likely the reason why we
need 4 lines of doc for a simple internal helper that checks whether the thing
(page table entry) we are unmapping/migarting is hwpoisoned. This function is
not involved at all in any kind of splitting.

Some of that code is getting reworked by Dev to better separate out all the
hugetlb oddities. At least for the try_to_unmap() path that helper will not be
required. Staring at the abomination we call try_to_migrate_one(), I assume
we'll do something similar.

I'd just call this "ttu_page_is_hwpoisoned()", and add a short

/*
 * hugetlb folios are always entirely mapped, so any
 * hwpoisoned page is problematic.
 */

> +	if (folio_test_hugetlb(folio))
> +		return folio_test_has_hwpoisoned(folio);
> +	return PageHWPoison(page);
> +}
> +
>  /*
>   * @arg: enum ttu_flags will be passed to this argument
>   */
> @@ -1993,7 +2009,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  	enum ttu_flags flags = (enum ttu_flags)(long)arg;
>  	unsigned long nr_pages = 1, end_addr;
>  	unsigned long pfn;

[...]

>  				dec_mm_counter(mm, mm_counter(folio));
>  				set_pte_at(mm, address, pvmw.pte, pteval);
> @@ -2423,7 +2436,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  	struct mmu_notifier_range range;
>  	enum ttu_flags flags = (enum ttu_flags)(long)arg;
>  	unsigned long pfn;
> -	unsigned long hsz = 0;

While these size changes are reasonable, they make this patch harder to review
and are not even described in the patch desription.

-- 
Cheers,

David
