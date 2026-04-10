Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB83D333F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823572; cv=none; b=amM79NTuyfIWgmNe/57Gek5B+Z18Nw1T+12ZoUPPHoHceusFy9NZ6mb8Kp4k/2FOiiMUJ4sDqbDNTl6ooCr/P9PMLthpO0qGCn9jY/dNhvqPdAUhR6TpOIXHMCYX//8Mxg0jWumabO+Hjx6HpQ/A7UyexAaTh1Q9sWZa6a1VeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823572; c=relaxed/simple;
	bh=CdKL5rcs2lQQ423mm64M2+knqEhsUUVpzPkOskOieog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJyqXq1StW7fE3sIS22c2LNHqRY9o+SVv9Gkce5FGTkj/GBt9fTVRPG/NAfMUgGySJT9mDhUq40RnGPbsyfdqk+r4Qxz5OOrhKJc+Y5GXYXxUAHT7aOVYdCxBFkv6A3JtQjnlwm1S28A8RRWVGw+/aGN0FyNJsgLydm+uwlBxFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ItHIgZPX; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ItHIgZPX"
Message-ID: <5f99b289-629c-47c4-bef0-966d6678a2a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775823558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xA0gQtLpnpN6dJllUvcccJ/r+mNlQ650rHe5aRjH1/Y=;
	b=ItHIgZPXvITZaz44MjQUvDrn8+360iGxPQ4SupGVPlQJSXbTrdOrEoo4Y8x9OckfubKKuC
	WCMKPWu6Y4cbfbIrxy7yYu6g7lZP/gF4pNlezFZTINd4MZl80c4szu9X77x7P2SVip02/X
	skUbST20k2vhZ6MlLVxYCHvrmnVFaWs=
Date: Fri, 10 Apr 2026 13:19:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/4] mm: improve large folio readahead and alignment
 for exec memory
Content-Language: en-GB
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc,
 jack@suse.cz, ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com,
 dev.jain@arm.com, kees@kernel.org, kevin.brodsky@arm.com,
 lance.yang@linux.dev, Liam.Howlett@oracle.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mhocko@suse.com, npache@redhat.com,
 pasha.tatashin@soleen.com, rmclure@linux.ibm.com, rppt@kernel.org,
 surenb@google.com, vbabka@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 leitao@debian.org, kernel-team@meta.com
References: <20260402181326.3107102-1-usama.arif@linux.dev>
 <803a0c15-0a6a-4c00-b6b3-eaae56d5fc15@linux.dev> <adjkCOiLgZ_-zovg@lucifer>
 <adjllNan2vgBNBHJ@lucifer>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <adjllNan2vgBNBHJ@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/04/2026 12:57, Lorenzo Stoakes wrote:
> On Fri, Apr 10, 2026 at 12:55:42PM +0100, Lorenzo Stoakes wrote:
>> On Fri, Apr 10, 2026 at 12:03:03PM +0100, Usama Arif wrote:
>>>
>>>
>>> On 02/04/2026 19:08, Usama Arif wrote:
>>>> v2 -> v3: https://lore.kernel.org/all/20260320140315.979307-1-usama.arif@linux.dev/
>>>> - Take into account READ_ONLY_THP_FOR_FS for elf alignment by aligning
>>>>   to HPAGE_PMD_SIZE limited to 2M (Rui)
>>>> - Reviewed-by tags for patch 1 from Kiryl and Jan
>>>> - Remove preferred_exec_order() (Jan)
>>>> - Change ra->order to HPAGE_PMD_ORDER if vma_pages(vma) >= HPAGE_PMD_NR
>>>>   otherwise use exec_folio_order() with gfp &= ~__GFP_RECLAIM for
>>>>   do_sync_mmap_readahead().
>>>> - Change exec_folio_order() to return 2M (cont-pte size) for 64K base
>>>>   page size for arm64.
>>>> - remove bprm->file NULL check (Matthew)
>>>> - Change filp to file (Matthew)
>>>> - Improve checking of p_vaddr and p_vaddr (Rui and Matthew)
>>>>
>>>
>>> Hello!
>>>
>>> Just wanted to check if there was any feedback/review on the latest
>>> revision?
>>
>> It's -rc7, this is definitely something for next cycle :)
>>
>> On my part, my upstream bandwidth has drastically reduced, and review is
>> probably going to have to be a hobbyist thing at least for now.
>>
>> Also, not to be mean but:
>>
>> $ git log -E -i --grep "(Reviewed|Acked)-by: Usama Arif" --oneline | wc -l
>> 21
>>
>> So... :)
>>
>> Review in mm is very lop-sided, let's try to balance it out a bit!
>>
>>>
>>> Thanks!
>>>
>>
>> Thanks, Lorenzo
> 
> (Note that we're in a 'quiet period' from here until -rc1 of next cycle and
> won't be taking anything new until then. We plan to do this from around rc5 or
> rc6 of each cycle in future).

Thanks! Just wanted to check, as I am always confused about this. Is it ok
to send patches for review for next release at this time? So that they
are in a good state when rc1 comes. I wanted to send PMD swap entries
for review after I am finished testing, but I want them for review for
next release.
