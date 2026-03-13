Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D952F6910
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398819; cv=none; b=fi53lGVpriONIqdNjIVeuTbqDJ1GEgSnEwaa7JT3HXlJwvXT+DIm9O/rkhUajbut9pzx0HddKVXaE/iJdf+k6pWvDRfe5g9t1rndQciPGtab4N/ewZwhwbn3wvoavaOvu0Kyf0FCIwVCIVnZuWTEbU5vdGgQyjarXuQK1HJclLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398819; c=relaxed/simple;
	bh=l+28NFlKaF6Ge28q40ZoU3YaNU6+LFfgEeFeZn1/vp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCt8Z77PH+d2SK4ythNNFAVzdHNRWZrxD3les7ztOKiO4X1Ay8fw4FIKq7AAPAvN0/kSkMUBuxSy0yS4p7zE2N6iNzdxn4wZJEe6FsC64b2A6SW/pXF6pLFGArwTxkjhBQdlQXcQCJFvCOdrG5uTx9DssO7zF0CVbTdry1seUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BVDd7MlF; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BVDd7MlF"
Message-ID: <1405ca44-a629-4152-9c87-4e63954bfed4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773398816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMlGBf2OWloMdso6OZPAQ/moNlC+lzmEsASkl2aA/OA=;
	b=BVDd7MlFKbVeADMnMFdEl3yGl2aDtjqZ/P5JEg4n+z0M7IuHFIrtNIpU9+z0xI+X+KY3FU
	uMkhJc6cCvm4GGMkPNFQI+YE8+gAc9rSJMsWtmXldC8X4vXPdzHFdq3FpFwetl3QM/qQ6z
	YOa9nsuCyOAXPgydKfcWMXifGUUInMs=
Date: Fri, 13 Mar 2026 13:46:47 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/2] binfmt_elf: Align eligible read-only PT_LOAD
 segments to PMD_SIZE for THP
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, WANG Rui <r@hev.cc>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@kernel.org>, Dev Jain <dev.jain@arm.com>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260310031138.509730-1-r@hev.cc>
 <349671d5-f5aa-48a2-9bba-00aef167b836@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <349671d5-f5aa-48a2-9bba-00aef167b836@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 13/03/2026 11:41, Baolin Wang wrote:
> CC Usama
> 
> On 3/10/26 11:11 AM, WANG Rui wrote:
>> Changes since [v3]:
>> * Fixed compilation failure under !CONFIG_TRANSPARENT_HUGEPAGE.
>> * No functional changes otherwise.
>>
>> Changes since [v2]:
>> * Renamed align_to_pmd() to should_align_to_pmd().
>> * Added benchmark results to the commit message.
>>
>> Changes since [v1]:
>> * Dropped the Kconfig option CONFIG_ELF_RO_LOAD_THP_ALIGNMENT.
>> * Moved the alignment logic into a helper align_to_pmd() for clarity.
>> * Improved the comment explaining why we skip the optimization
>>    when PMD_SIZE > 32MB.
>>
>> When Transparent Huge Pages (THP) are enabled in "always" mode,
>> file-backed read-only mappings can be backed by PMD-sized huge pages
>> if they meet the alignment and size requirements.
>>
>> For ELF executables loaded by the kernel ELF binary loader, PT_LOAD
>> segments are normally aligned according to p_align, which is often
>> only page-sized. As a result, large read-only segments that are
>> otherwise eligible may fail to be mapped using PMD-sized THP.
>>
>> A segment is considered eligible if:
>>
>> * THP is in "always" mode,
>> * it is not writable,
>> * both p_vaddr and p_offset are PMD-aligned,
>> * its file size is at least PMD_SIZE, and
>> * its existing p_align is smaller than PMD_SIZE.
>>
>> To avoid excessive address space padding on systems with very large
>> PMD_SIZE values, this optimization is applied only when PMD_SIZE <= 32MB,
>> since requiring larger alignments would be unreasonable, especially on
>> 32-bit systems with a much more limited virtual address space.
>>
>> This increases the likelihood that large text segments of ELF
>> executables are backed by PMD-sized THP, reducing TLB pressure and
>> improving performance for large binaries.
>>
>> This only affects ELF executables loaded directly by the kernel
>> binary loader. Shared libraries loaded by user space (e.g. via the
>> dynamic linker) are not affected.
> 
> Usama posted a similar patchset[1], and I think using exec_folio_order() for exec-segment alignment is reasonable. In your case, you can override exec_folio_order() to return a PMD‑sized order.
> 
> [1] https://lore.kernel.org/all/20260310145406.3073394-1-usama.arif@linux.dev/
> 

Thanks for the CC Baolin! Happy to see someone else noticed the same issue!

Yeah I agree, I think piggybacking off exec_folio_order() as done in 1 should be
the right appproach.

I also think there is maybe a bug in do_sync_mmap_readahead that needs to be fixed
when it comes to mmap_miss counter [2].


[1] https://lore.kernel.org/all/20260310145406.3073394-1-usama.arif@linux.dev/
[2] https://lore.kernel.org/all/20260310145406.3073394-3-usama.arif@linux.dev/

>> Benchmark
>>
>> Machine: AMD Ryzen 9 7950X (x86_64)
>> Binutils: 2.46
>> GCC: 15.2.1 (built with -z,noseparate-code + --enable-host-pie)
>>
>> Workload: building Linux v7.0-rc1 vmlinux with x86_64_defconfig.
>>
>>                  Without patch        With patch
>> instructions    8,246,133,611,932    8,246,025,137,750
>> cpu-cycles      8,001,028,142,928    7,565,925,107,502
>> itlb-misses     3,672,158,331        26,821,242
>> time elapsed    64.66 s              61.97 s
>>
>> Instructions are basically unchanged. iTLB misses drop from ~3.67B to
>> ~26M (~99.27% reduction), which results in about a ~5.44% reduction in
>> cycles and ~4.18% shorter wall time for this workload.
>>
>> [v3]: https://lore.kernel.org/linux-fsdevel/20260310013958.103636-1-r@hev.cc
>> [v2]: https://lore.kernel.org/linux-fsdevel/20260304114727.384416-1-r@hev.cc
>> [v1]: https://lore.kernel.org/linux-fsdevel/20260302155046.286650-1-r@hev.cc
>>
>> WANG Rui (2):
>>    huge_mm: add stubs for THP-disabled configs
>>    binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for
>>      THP
>>
>>   fs/binfmt_elf.c         | 29 +++++++++++++++++++++++++++++
>>   include/linux/huge_mm.h | 10 ++++++++++
>>   2 files changed, 39 insertions(+)
>>
> 

