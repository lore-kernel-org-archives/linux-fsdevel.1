Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51393806B0
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721317; cv=none; b=qZJXImB5TVexLCEv0wOH1DHHczx3Ar45cyHePaarEfZ9n8nNOk8hgjZqY4rlUxP70ZhTJUScDw23eDFiXV/3FR3z2uYVrNi0z4h9ekIzhaQYFKug5YUtzyFID80cbSXL4hf9ru0jFLkgwV9Fq3AewI33+V6euJhUFdTPb4czQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721317; c=relaxed/simple;
	bh=HFbkS0uEydiczYh7P5tXmXKuDdgk9/k4vID1HeaNMOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTjMHWhpaAguh1ny3iONSnDB9wVFpYz9a9iBBF7F2hbUTt0sAYxrNgT5tSYPolJTzw/3/h0byRwW+naxv+NOiBHWMjQUkDbLp2X7nmyPRPuXjtbqMpjXwl2b2UAX2xZBRO28GZ0IUXwwIlu9o9/Z+hIXmTlxBT5yIvanSKNoHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fsSvL3R+; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fsSvL3R+"
Message-ID: <8edc8cd0-f65c-4456-9b3f-362e744c9a96@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779721303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AzwE9k9QJF7DUyRnk+qmGDQkXJ2+kA/q8Ntjxx3//vI=;
	b=fsSvL3R+HyOLiJBlzetIGjmPzu1GfueYA9lAtGy2Z8SL3+P0kPz1vyGsKd+ewF7+yPqqfC
	/iuy4xlG2sBfvGWm8UGvpe2AWMCyGuQUPrUGljCAmlQ3kSIJHpayjMw01YvtZ7vJP62/sE
	FqH9kKksxanHmBQ196JOJTJSIlyErtA=
Date: Mon, 25 May 2026 16:01:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/2] mm: improve large folio readahead for exec memory
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, willy@infradead.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, r@hev.cc, jack@suse.cz,
 Andrew Donnellan <andrew+kernel@donnellan.id.au>, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, brauner@kernel.org,
 catalin.marinas@arm.com, dev.jain@arm.com, kees@kernel.org,
 kevin.brodsky@arm.com, lance.yang@linux.dev,
 "Liam R.Howlett" <liam@infradead.org>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ljs@kernel.org,
 mhocko@suse.com, npache@redhat.com, pasha.tatashin@soleen.com,
 rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com,
 vbabka@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 wilts.infradead.org@hp2.hsd1.ca.comcast.net, ziy@nvidia.com,
 hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 kernel-team@meta.com
References: <20260522162422.3856502-1-usama.arif@linux.dev>
 <20260522122052.7b4ad7c482a0e4826296e392@linux-foundation.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260522122052.7b4ad7c482a0e4826296e392@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 22/05/2026 20:20, Andrew Morton wrote:
> On Fri, 22 May 2026 09:23:46 -0700 Usama Arif <usama.arif@linux.dev> wrote:
> 
>> Two checks in do_sync_mmap_readahead() limit large-folio readahead:
>>
>>   1. The mmap_miss heuristic is meant to throttle wasteful speculative
>>      readahead. It is currently also applied to the VM_EXEC readahead
>>      path, which is targeted rather than speculative. Once mmap_miss exceeds
>>      MMAP_LOTSAMISS, exec readahead - including the large-folio
>>      order requested by exec_folio_order() - is disabled. On
>>      configurations where the mmap_miss decrement paths are not
>>      active (see patch 1) the counter only grows, so exec readahead
>>      is permanently disabled after the first 100 faults.
>>
>>   2. The force_thp_readahead path is gated only on
>>      HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER and always drives the
>>      readahead at HPAGE_PMD_ORDER. Configurations where
>>      HPAGE_PMD_ORDER exceeds MAX_PAGECACHE_ORDER never reach this
>>      path, even when the mapping itself supports usefully large
>>      folios well below the cap.
>>
>> Both issues are most visible on arm64 with a 64K base page size,
>> where HPAGE_PMD_ORDER is 13 (512MB) -- above MAX_PAGECACHE_ORDER
>> (11) -- and where fault_around_pages collapses to 1 disabling
>> should_fault_around() (one of the two mmap_miss decrement sites).
>> However the fixes are architecture-agnostic: patch 1 reflects the
>> nature of VM_EXEC readahead regardless of base page size, and
>> patch 2 generalises the gate so any mapping advertising a usefully
>> large maximum folio order can benefit.
>>
>> I created a benchmark that mmaps a large executable file and calls
>> RET-stub functions at PAGE_SIZE offsets across it. "Cold" measures
>> fault + readahead cost. "Random" first faults in all pages with a
>> sequential sweep (not measured), then measures time for calling random
>> offsets, isolating iTLB miss cost for scattered execution.
>>
>> The benchmark results on Neoverse V2 (Grace), arm64 with 64K base pages,
>> 512MB executable file on ext4, averaged over 3 runs:
>>
>>   Phase      | Baseline     | Patched      | Improvement
>>   -----------|--------------|--------------|------------------
>>   Cold fault | 83.4 ms      | 41.3 ms      | 50% faster
>>   Random     | 76.0 ms      | 58.3 ms      | 23% faster
> 
> Well that's nice.
> 
> AI review might have found a few things:
> 	https://sashiko.dev/#/patchset/20260522162422.3856502-1-usama.arif@linux.dev
> 

Thanks Andrew! So sashiko seems to have brought out some interesting problems,
some of which are pre-existing. For example, the decrement sites for mmap_miss
in do_async_mmap_readahead() and filemap_map_pages() dont skip for VM_SEQ_READ.

I have sent this as an independent patch in [1].

I will send the next version of this series on top of [1] in a few days
addressing the rest of the issues raised by sashiko.

[1] https://lore.kernel.org/all/20260525145751.2671248-1-usama.arif@linux.dev/


