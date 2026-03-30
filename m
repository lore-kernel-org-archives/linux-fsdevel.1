Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4C250C06
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879249; cv=none; b=mcVzeyjNJW9gyzP7LcL0KeZc5sK8Qgh+c/pzQ9GHF8ORSNrxHwfIiKQDOJPSMjqb+CBQADo0SHbWeAMCVH3zLY4Ex+b8x2YpBgg/ulANZ7nyBWQ/Bp5+mrlSV7uD2Ywrf34Y0IQqRA5Z0GcqEURIi1TAGLDcaiVFQqpTc22neP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879249; c=relaxed/simple;
	bh=0bxmeEBdumtkjkUmzo8TEamj26GWMWBpr/G5qpLChGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FI5KlNSz5Z9W528jXp1QhJ7o1lBijCJxGuxnfLOmstDyK1cIEqlHKb/M2i95vGR1GGeeQl+KXGeLBg2tucznREWmOAA2r3nmuqECxVrQkWI1nMXi/QuBmCKnjjS4OKTgdgFJUCTRtvtWVtI0Zdrb9NOfjHDCNr1tRzvs5WCJjnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lS9w9BPl; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lS9w9BPl"
Message-ID: <e3876d3f-0e86-4542-861d-2de3d0cbf66e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774879244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaGpJgvU7fzaZHNV9egMJ09PF1OrT8PBmReLhVLOy8s=;
	b=lS9w9BPlpn3w7Y6et2LBOIXHgvvaMn9p28qX39J+x4F8xAvdXoNIWXQtnIFst7cGSn4B8i
	lEUcuiFbizFcrIFZoDdU/tj2oIyK1tlAj28oBGq0wenPC6w5RPlSLYdxJN2bXYd0fqqi/3
	hAOTBN1N5ysSW5IbJMAZcoTn0ZQ4JsI=
Date: Mon, 30 Mar 2026 15:00:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] elf: align ET_DYN base to max folio size for PTE
 coalescing
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, WANG Rui <r@hev.cc>
Cc: Liam.Howlett@oracle.com, ajd@linux.ibm.com, akpm@linux-foundation.org,
 apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 brauner@kernel.org, catalin.marinas@arm.com, david@kernel.org,
 dev.jain@arm.com, jack@suse.cz, kees@kernel.org, kevin.brodsky@arm.com,
 lance.yang@linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
 npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com,
 rppt@kernel.org, ryan.roberts@arm.com, surenb@google.com, vbabka@kernel.org,
 viro@zeniv.linux.org.uk
References: <0725ce97-b8a3-47c9-952f-7b512873cc35@linux.dev>
 <20260329043700.19355-1-r@hev.cc> <acpy6DLjPVXXzwJX@casper.infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <acpy6DLjPVXXzwJX@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 30/03/2026 15:56, Matthew Wilcox wrote:
> On Sun, Mar 29, 2026 at 12:37:00PM +0800, WANG Rui wrote:
>>> mapping_max_folio_size() reflects what the page cache will actually
>>> allocate for a given filesystem, since readahead caps folio allocation
>>> at mapping_max_folio_order() (in page_cache_ra_order()). If btrfs
>>> reports PAGE_SIZE, readahead won't allocate large folios for it, so
>>> there are no large folios to coalesce PTEs for, aligning the binary
>>> beyond that would only reduce ASLR entropy for no benefit.
>>>
>>> I don't think we should over-align binaries on filesystems that can't
>>> take advantage of it.
>>
>> Ah, it looks like this might be overlooking another path that can create
>> huge page mappings for read-only code segments: even when the filesystem
>> (e.g. btrfs without experimental) didn't support large folios,
>> READ_ONLY_THP_FOR_FS still allowed read-only file-backed code segments
>> to be collapsed into huge page mappings via khugepaged.

ah yes, Thank you for pointing this out!

Maybe we should rename mapping_max_folio_size() to mapping_fault_max_folio_size().

>>
>> As Wilcox pointed out, it may take quite some time for many filesystems
>> to gain full large folio support? So what I'm trying to clarify is that
>> using mapping_max_folio_size() on this path is not favorable for
>> khugepaged-based optimizations.

ack

I am worried that 32M is too large and we lose out on a lot of ASLR bits.
Instead of PMD_ORDER, should we do max(SZ_2M, PMD_ORDER)?

> Nono, that's not what I'm pointing out!  btrfs is simply not putting
> in the effort to support large folios, and that needs to change.
> READ_ONLY_THP_FOR_FS unnecessaily burdens the rest of the kernel.
> It was a great hack for its time and paved the path for a lot of what
> we have today, but it's time to remove it.

