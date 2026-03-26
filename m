Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5523EF673;
	Thu, 26 Mar 2026 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528889; cv=none; b=XmN9ETZ4Qu+PkVs3GQobM5BAs8tstD3KAGCCCQz5WOjYtS+btKgbKdXM/YN8xN1eOYX14NJgwruwZPOdP3HTGAnF9l1E8mWNeAyMqW+PWbi/9sUUOp8pmDlURtN5twRDuYtFc2Ei0lcOnAsqM0VXWEIikNh32WAliqe+NO4s6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528889; c=relaxed/simple;
	bh=PHVpMfHUkBmtu98jMC4tFXgtYDDt5NlrkimUD2NUec0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmixl/vfcyQQzNrS+cfBi702BvH55Qtg53thMz2uvYIgM2MN2yDoDVEdZ394Hh1HRv6otSUb3z7kRO2PGNHmRfKlb+WlSFUZfi4Pm3Pcz2CDeiGhGwr/rztkRe/D6Wax72Pc9c4qr6fFJ0uURNw+UbD56bCfxjyxt5Y5czrsfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K4yXwAFX; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K4yXwAFX"
Message-ID: <0ce07bc5-6365-4c54-90e2-4e56ad2b7465@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774528885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06KB53lThvomRpyYQxy3Sh2rJb39T5D6WNpA7eb1gCM=;
	b=K4yXwAFXMX0fmJ8EBL0HJNpbjd+3Q1RJx589DnC0Z6DFYmyjstFt8kC+beKS2yTg3QT2AD
	0sT6NpNguoAvjDsNI17ZlCd877xod5JgPcDxp4aJyO9QfJCSdDQETFzDUiubr4AqzwuQ01
	yfW+d4keIyheJf1HUII1d5s6AvtIIOc=
Date: Thu, 26 Mar 2026 08:40:21 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] mm: replace exec_folio_order() with generic
 preferred_exec_order()
To: Jan Kara <jack@suse.cz>, david@kernel.org, ryan.roberts@arm.com
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
 linux-mm@kvack.org, r@hev.cc, ajd@linux.ibm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, brauner@kernel.org,
 catalin.marinas@arm.com, dev.jain@arm.com, kees@kernel.org,
 kevin.brodsky@arm.com, lance.yang@linux.dev, Liam.Howlett@oracle.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
 npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, wilts.infradead.org@quack3,
 ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 kernel-team@meta.com
References: <20260320140315.979307-1-usama.arif@linux.dev>
 <20260320140315.979307-3-usama.arif@linux.dev>
 <k45xs6btmt62uerbglqe665jozrtkeoklu4rek6odgxjdj63ni@ftw6ef3ug33x>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <k45xs6btmt62uerbglqe665jozrtkeoklu4rek6odgxjdj63ni@ftw6ef3ug33x>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 20/03/2026 17:42, Jan Kara wrote:
> On Fri 20-03-26 06:58:52, Usama Arif wrote:
>> Replace the arch-specific exec_folio_order() hook with a generic
>> preferred_exec_order() that dynamically computes the readahead folio
>> order for executable memory. It targets min(PMD_ORDER, 2M) as the
>> maximum, which optimally gives the right answer for contpte (arm64),
>> PMD mapping (x86, arm64 4K), and architectures with smaller PMDs
>> (s390 1M). It adapts at runtime based on:
>>
>> - VMA size: caps the order so folios fit within the mapping
>> - Memory pressure: steps down the order when the local node's free
>>   memory is below the high watermark for the requested order
>>
>> This avoids over-allocating on memory-constrained systems while still
>> requesting the optimal order when memory is plentiful.
>>
>> Since exec_folio_order() is no longer needed, remove the arm64
>> definition and the generic default from pgtable.h.
>>
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ...
>> +static unsigned int preferred_exec_order(struct vm_area_struct *vma)
>> +{
>> +	int order;
>> +	unsigned long vma_len = vma_pages(vma);
>> +	struct zone *zone;
>> +	gfp_t gfp;
>> +
>> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>> +		return 0;
>> +
>> +	/* Cap at min(PMD_ORDER, 2M) */
>> +	order = min(HPAGE_PMD_ORDER, ilog2(SZ_2M >> PAGE_SHIFT));
>> +
>> +	/* Don't request folios larger than the VMA */
>> +	order = min(order, ilog2(vma_len));
> 

Hi Jan,

Thanks for the feedback and sorry for the late reply! I was travelling
during the week.

> Hum, as far as I'm checking page_cache_ra_order() used in
> do_sync_mmap_readahead(), ra->order is the preferred order but it will be
> trimmed down to fit both within the file and within ra->size. And ra->size
> is set for the readahead to fit within the vma so I don't think any order
> trimming based on vma length is needed in this place?

Ack, yes makes sense.

> 
>> +	/* Step down under memory pressure */
>> +	gfp = mapping_gfp_mask(vma->vm_file->f_mapping);
>> +	zone = first_zones_zonelist(node_zonelist(numa_node_id(), gfp),
>> +				    gfp_zone(gfp), NULL)->zone;
>> +	if (zone) {
>> +		while (order > 0 &&
>> +		       !zone_watermark_ok(zone, order,
>> +					  high_wmark_pages(zone), 0, 0))
>> +			order--;
>> +	}
> 
> It looks wrong for this logic to be here. Trimming order based on memory
> pressure makes sense (and we've already got reports that on memory limited
> devices large order folios in the page cache have too big memory overhead
> so we'll likely need to handle that for page cache allocations in general)
> but IMHO it belongs to page_cache_ra_order() or some other common place
> like that.
> 
> 								Honza

So I have been thinking about this. readahead_gfp_mask() already sets
__GFP_NORETRY, so we wont try aggressive reclaim/compaction to satisfy
the allocation. page_cache_ra_order() falls through to the fallback path
faulting in order 0 page when allocation is not satsified.

So the allocator already naturally steps down under memory pressure,
the explicit zone_watermark_ok() loop might be redundant?

What are your thoughts on just setting
ra->order = min(HPAGE_PMD_ORDER, ilog2(SZ_2M >> PAGE_SHIFT))?
We can do the higher orlder allocation with gfp &= ~__GFP_RECLAIM
for the VM_EXEC case.

