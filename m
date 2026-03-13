Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F87328B4B;
	Fri, 13 Mar 2026 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408039; cv=none; b=fBVO89iA+dcNyLbsW9ZC2EIn2VZmsxhwYuZzyWT2ZbqKgvkdLMBS8TYtJrp/AYcnmNW0+Hw1zA06b8M+0Q2ChgUNtRgzd7Y2Rbh34TdvKThWsAC9qzFJdrhJsKi8V/rSZP8Y+ZinYz1kOd9gM2ydX5AWdJQuCas/ugP9g2+Cx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408039; c=relaxed/simple;
	bh=ECDmW2RVnagmwfRcq3Xt66rfTo13jyhMFuXzJXSegoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RaUvm4TWNWFqEJZxfWbz/TbIbXB96IU/+52sGzEAHeo+1GsihNvqg3FTmsddUvyrksFOYeKYTksbTVya+NPnewK+sEFQD9IQiLKIS0eBRpMKLiM+5LIiSb9VFXEryDH2xs+jSbLaN3YUar2No04ZahjLQwSHkcNxUdcJgZhiP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfcDfTu5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfcDfTu5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D804FC2BC86;
	Fri, 13 Mar 2026 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773408038;
	bh=ECDmW2RVnagmwfRcq3Xt66rfTo13jyhMFuXzJXSegoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BfcDfTu5kMhfOFwtq2aussdMKxyjF4VYbIYn9mu6LXi4xciiTyoj8dkh0g83w9bDm
	 b4fM2hILOrIZLAnBRF4eYfWBrp6ZVLRGHbbZ9j2xjrwQVaK6hPqpLKzGbeAkpEe+xw
	 nfXM4TBg1aI91r+OT2cwUdWoaJvMRTOnHutn8xwMMtgB0CSReXlf5HCaOUCfD7/PSF
	 Zg5fA7pWT0ekUlTLAQ5zW3uP2+nM9Ikn1iixVJoatyfDUAXfKhhhsN5MDk1NpX/VEG
	 wU6cXDvcEumt6f92G3Zt7PJMo7rIwEeWAG9Z+QbijFCAAgQnzHOnRheZl8QcxhGq2W
	 /vEGRSEgZS2ug==
Message-ID: <608c87ce-10d9-4012-b6e9-298d5a356801@kernel.org>
Date: Fri, 13 Mar 2026 14:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64/mm: contpte-sized exec folios for 16K and 64K
 pages
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, ryan.roberts@arm.com
Cc: ajd@linux.ibm.com, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, brauner@kernel.org,
 catalin.marinas@arm.com, dev.jain@arm.com, jack@suse.cz, kees@kernel.org,
 kevin.brodsky@arm.com, lance.yang@linux.dev, Liam.Howlett@oracle.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, rmclure@linux.ibm.com,
 Al Viro <viro@zeniv.linux.org.uk>, will@kernel.org, willy@infradead.org,
 ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 kernel-team@meta.com
References: <20260310145406.3073394-1-usama.arif@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260310145406.3073394-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/26 15:51, Usama Arif wrote:
> On arm64, the contpte hardware feature coalesces multiple contiguous PTEs
> into a single iTLB entry, reducing iTLB pressure for large executable
> mappings.
> 
> exec_folio_order() was introduced [1] to request readahead at an
> arch-preferred folio order for executable memory, enabling contpte
> mapping on the fault path.
> 
> However, several things prevent this from working optimally on 16K and
> 64K page configurations:
> 
> 1. exec_folio_order() returns ilog2(SZ_64K >> PAGE_SHIFT), which only
>    produces the optimal contpte order for 4K pages. For 16K pages it
>    returns order 2 (64K) instead of order 7 (2M), and for 64K pages it
>    returns order 0 (64K) instead of order 5 (2M). Patch 1 fixes this by
>    using ilog2(CONT_PTES) which evaluates to the optimal order for all
>    page sizes.
> 
> 2. Even with the optimal order, the mmap_miss heuristic in
>    do_sync_mmap_readahead() silently disables exec readahead after 100
>    page faults. The mmap_miss counter tracks whether readahead is useful
>    for mmap'd file access:
> 
>    - Incremented by 1 in do_sync_mmap_readahead() on every page cache
>      miss (page needed IO).
> 
>    - Decremented by N in filemap_map_pages() for N pages successfully
>      mapped via fault-around (pages found in cache without faulting,
>      evidence that readahead was useful). Only non-workingset pages
>      count and recently evicted and re-read pages don't count as hits.
> 
>    - Decremented by 1 in do_async_mmap_readahead() when a PG_readahead
>      marker page is found (indicates sequential consumption of readahead
>      pages).
> 
>    When mmap_miss exceeds MMAP_LOTSAMISS (100), all readahead is
>    disabled. On 64K pages, both decrement paths are inactive:
> 
>    - filemap_map_pages() is never called because fault_around_pages
>      (65536 >> PAGE_SHIFT = 1) disables should_fault_around(), which
>      requires fault_around_pages > 1. With only 1 page in the
>      fault-around window, there is nothing "around" to map.
> 
>    - do_async_mmap_readahead() never fires for exec mappings because
>      exec readahead sets async_size = 0, so no PG_readahead markers
>      are placed.
> 
>    With no decrements, mmap_miss monotonically increases past
>    MMAP_LOTSAMISS after 100 faults, disabling exec readahead
>    for the remainder of the mapping.
>    Patch 2 fixes this by moving the VM_EXEC readahead block
>    above the mmap_miss check, since exec readahead is targeted (one
>    folio at the fault location, async_size=0) not speculative prefetch.
> 
> 3. Even with correct folio order and readahead, contpte mapping requires
>    the virtual address to be aligned to CONT_PTE_SIZE (2M on 64K pages).
>    The readahead path aligns file offsets and the buddy allocator aligns
>    physical memory, but the virtual address depends on the VMA start.
>    For PIE binaries, ASLR randomizes the load address at PAGE_SIZE (64K)
>    granularity, giving only a 1/32 chance of 2M alignment. When
>    misaligned, contpte_set_ptes() never sets the contiguous PTE bit for
>    any folio in the VMA, resulting in zero iTLB coalescing benefit.
> 
>    Patch 3 fixes this for the main binary by bumping the ELF loader's
>    alignment to PAGE_SIZE << exec_folio_order() for ET_DYN binaries.
> 
>    Patch 4 fixes this for shared libraries by adding a contpte-size
>    alignment fallback in thp_get_unmapped_area_vmflags(). The existing
>    PMD_SIZE alignment (512M on 64K pages) is too large for typical shared
>    libraries, so this smaller fallback (2M) succeeds where PMD fails.
> 
> I created a benchmark that mmaps a large executable file and calls
> RET-stub functions at PAGE_SIZE offsets across it. "Cold" measures
> fault + readahead cost. "Random" first faults in all pages with a
> sequential sweep (not measured), then measures time for calling random
> offsets, isolating iTLB miss cost for scattered execution.
> 
> The benchmark results on Neoverse V2 (Grace), arm64 with 64K base pages,
> 512MB executable file on ext4, averaged over 3 runs:
> 
>   Phase      | Baseline     | Patched      | Improvement
>   -----------|--------------|--------------|------------------
>   Cold fault | 83.4 ms      | 41.3 ms      | 50% faster
>   Random     | 76.0 ms      | 58.3 ms      | 23% faster

I'm curious: is a single order really what we want?

I'd instead assume that we might want to make decisions based on the
mapping size.

Assume you have a 128M mapping, wouldn't we want to use a different
alignment than, say, for a 1M mapping, a 128K mapping or a 8k mapping?

-- 
Cheers,

David
