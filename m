Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729F3890FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395308; cv=none; b=niOUxx0w/7HT8aFZzHJkubmmfO5Ky9oWPAI0MKs2NLXjaPFoxjH6Qd8Hu90oCjmRuj+wLoo3rT7SgG10jsKvYV74FErtso1IoLihvprW2g7RHdXwj1Vov5TynodAe3haovEjh6/Uo9ViNoB+IxljTyJpWdbrH3+WFOE0xFAfT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395308; c=relaxed/simple;
	bh=C39ajD4blPUBlt3rnjRgjRgaIXY+/6owato2hUnI1UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKZeBZJ6UEygaT1pgx3RNJBlN6aJTUg6S/AgbB8Kk3db3Y5wLozdLQabuoANClSab8eSkkyO9C3QhUfNZk1Bz781T8YNJE7Nh7yw8NsIVqKmWCC4mpmA3pP3+UwJlBGMhpxEJy0BSGGYpKk56FGPS8l4TyOajBCwSZvQXsqACj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zjllx+17; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zjllx+17"
Message-ID: <1a886b5b-319c-4f3e-8db1-6af6696f4d84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773395295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEJz35Adc3NsFkK40sxCO0i6EjmFIRWe/WjjQkCGHCg=;
	b=Zjllx+17Jiz/7ga1clp9pCa6VHzQgQMd5fHO2FujvKPSUUg1rEJOFI2Hp2+/8uHpxRbTQx
	vh3Jtnmwko2XXm1olQ/iInZQWIL7me0Gzoai8LfN913QvKIWTBP+X9+bCMbb/6WJvtMpnO
	267U/Y7QfyMTCgsNl2Yf59L7op2lNUU=
Date: Fri, 13 Mar 2026 17:47:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] huge_mm: add stubs for THP-disabled configs
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>, hev <r@hev.cc>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
References: <20260310031138.509730-1-r@hev.cc>
 <20260310031138.509730-2-r@hev.cc>
 <bca4ea00-3052-425b-8f39-729d504fd4db@kernel.org>
 <7937d789-539f-47db-838f-c153ca6cfc50@kernel.org>
 <CAHirt9gpZ98HQCXStEQMMfe6TEnSzmD04BM313h2LJGJ1K-hJw@mail.gmail.com>
 <60ba4311-01f8-4ff3-a2df-e1b3fb6db699@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <60ba4311-01f8-4ff3-a2df-e1b3fb6db699@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/3/13 00:29, David Hildenbrand (Arm) wrote:
> On 3/12/26 17:12, hev wrote:
>> Hi David,
>>
>> On Thu, Mar 12, 2026 at 11:57 PM David Hildenbrand (Arm)
>> <david@kernel.org> wrote:
>>>
>>> On 3/12/26 16:53, David Hildenbrand (Arm) wrote:
>>>>
>>>> There are other ways to enable PMD THP. So I don't quite think this is
>>>> the right tool for the job.
>>>
>>> Ah, you care about file THPs ... gah.
>>>
>>> Why can't we simply do the alignment without considering the current
>>> setting?
>>
>> The main motivation of raising the alignment here is to increase the
>> chance of getting PMD-sized THPs for executable mappings.
>>
>> If THP is not in "always" mode, the kernel will not automatically
>> collapse file-backed mappings into THPs, so the increased alignment
>> would not actually improve THP usage.
>>
>> In that case we would only be introducing additional padding in the
>> virtual address layout, which slightly reduces ASLR entropy without
>> providing a practical benefit.
> 
> Well, that parameter can get toggled at runtime later? Also, I think
> that readahead code could end up allocating a PMD THP (I might be
> wrong about that, the code is confusing).

Right. In do_sync_mmap_readahead(), if the VMA has VM_HUGEPAGE,
force_thp_readahead becomes true and ra->order is set to
HPAGE_PMD_ORDER, IIUC.

	/* Use the readahead code, even if readahead is disabled */
	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
		force_thp_readahead = true;

That order is then passed down to page_cache_ra_order() and finally to
filemap_alloc_folio().

	if (force_thp_readahead) {
[...]
		ra->async_size = HPAGE_PMD_NR;
		ra->order = HPAGE_PMD_ORDER;
		page_cache_ra_order(&ractl, ra);
		return fpin;
	}


For plain VM_EXEC, the code starts from exec_folio_order(), not
HPAGE_PMD_ORDER.

	if (vm_flags & VM_EXEC) {
[...]
		ra->order = exec_folio_order();
[...]
		ra->async_size = 0;
	}

The default exec_folio_order() is small, and arm64 only overrides it
to 64K.

/*
  * Request exec memory is read into pagecache in at least 64K folios. 
This size
  * can be contpte-mapped when 4K base pages are in use (16 pages into 1 
iTLB
  * entry), and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base
  * pages are in use.
  */

#define exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)

> 
> Let's take a look at __get_unmapped_area(), where we don't care about
> ASLR entropy for anonymous memory:
> 
> } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && !file
> 	   && !addr /* no hint */
> 	   && IS_ALIGNED(len, PMD_SIZE)) {

Yeah. For anonymous memory, the kernel is willing to do THP-friendly
alignment, but it is constrained, of course :)

> Interestingly we had:
> 
> commit 34d7cf637c437d5c2a8a6ef23ea45193bad8a91c
> Author: Kefeng Wang <wangkefeng.wang@huawei.com>
> Date:   Fri Dec 6 15:03:45 2024 +0800
> 
>      mm: don't try THP alignment for FS without get_unmapped_area
>      
>      Commit ed48e87c7df3 ("thp: add thp_get_unmapped_area_vmflags()") changes
>      thp_get_unmapped_area() to thp_get_unmapped_area_vmflags() in
>      __get_unmapped_area(), which doesn't initialize local get_area for
>      anonymous mappings.  This leads to us always trying THP alignment even for
>      file_operations which have a NULL ->get_unmapped_area() callback.
>      
>      Since commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
>      boundaries") we only want to enable THP alignment for anonymous mappings,
>      so add a !file check to avoid attempting THP alignment for file mappings.
>      
>      Found issue by code inspection.  THP alignment is used for easy or more
>      pmd mappings, from vma side.  This may cause unnecessary VMA fragmentation
>      and potentially worse performance on filesystems that do not actually
>      support THPs and thus cannot benefit from the alignment.

Looks like this commit does not *ban* file-backed THP-friendly alignment
completely. It only prevents file mappings from getting it accidentally
via the generic fallback path.

Note that some filesystems still explicitly opt in with their own

.get_unmapped_area = thp_get_unmapped_area

for example ext4, xfs, and btrfs.

So explicit filesystem opt-in is still allowed :)

> I'm not sure about the "VMA fragmentation" argument, really. We only consider
> stuff that is already multiples of PMD_SIZE.
>
> Filesystem support for THPs is also not really something you would handle, and it's
> a problem that solves itself over time as more filesystems keep adding support for
> large folios.
> 
> So I think we should try limiting it to IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE),
> but not checking the runtime toggle.

Good point! ELF layout is decided once at exec time, while the runtime 
THP mode
can change later.
