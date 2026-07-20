Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097A18C02E
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514748; cv=none; b=fHQqQ1S6jpFbECorzV9SVsVx3I1D1Dbdbna7D84lk0fS4kOwjvvPgxncZMKeC5wklVVEhdnfaHhTdrlglHfzTa4BFVDwjOi18RJgFiC/ZJC5vJODuOM3oz2QXOKFIXZDNhHebKjTKd6MBPeTNFcDrHspbyNQQIU/Xry1BHZV/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514748; c=relaxed/simple;
	bh=qNOhA/PhaSYsgLNo3/ZWTl6S6FRyL/UkC7POX8eZWWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrySKhvst1SkhBSwgfIOEuKhHVrmX9WH5q9MKHU/ySq02AuhrfEiRUovBytDUD785GOzVbblvrMUHM3RQsboW+L+rzEk6SahX68mkI8m4lIJxk8f9aZoexOYM76JtMPd193AZnLVluMJagSmnfkOFHLgx7R8tWbL+7MJwr6IlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oYYjtgH3; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oYYjtgH3"
Message-ID: <c32645fe-4c66-428f-b027-0271cd99f76b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784514733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zQIBCc7A0jp8hH0iRn/IpZGk9QLI5Bvnk2tEw8qHXE=;
	b=oYYjtgH3YIMhc0f428t7smjHTRH5wJAoZbkfNarNMiRs81bcV+Hk2K7ci2ydaKrfo42gee
	e+IcpGliv1TIwnBByPrfzyCXXdyy2XFy+CQ/4P7HaLQBP4LrQLSdz5v/+6tk0eb60COEmY
	FRcFzr/eP8OkYGtytAilNXuQVgkS2vg=
Date: Mon, 20 Jul 2026 10:31:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/thp: expose deferred split folio memory usage in
 meminfo
To: Johannes Weiner <hannes@cmpxchg.org>, liuye <liuye@kylinos.cn>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20260717063025.168436-1-ye.liu@linux.dev>
 <alngSdkM6iEGpETe@lucifer> <102bada7-66ae-415d-abc8-12d5939b7ebb@linux.dev>
 <70294b26-86e1-4de0-832f-d5cb488cdb3e@kylinos.cn>
 <20260717102909.GA6843@cmpxchg.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20260717102909.GA6843@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/17 18:29, Johannes Weiner 写道:
> Hello,
> 
> On Fri, Jul 17, 2026 at 05:38:10PM +0800, liuye wrote:
>>
>> 在 2026/7/17 17:24, Ye Liu 写道:
>>>
>>> 在 2026/7/17 16:08, Lorenzo Stoakes (ARM) 写道:
>>>> +cc Johannes
>>>>
>>>> On Fri, Jul 17, 2026 at 02:30:22PM +0800, Ye Liu wrote:
>>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>>
>>>>> Folios on the deferred split list hold physical memory that is
>>>>> invisible in meminfo. When a THP becomes partially mapped, the
>>>>> unmapped pages are removed from AnonPages but remain physically
>>>>> allocated until the shrinker splits the folio. This creates a
>>>>> memory accounting gap where used memory cannot be attributed to
>>>>> any meminfo field.
>>>> Is this really that much of an issue? You're not giving any use cases here.
>>>>
>>>> What real-world use case motivated this?
>>>>
>>> I have indeed encountered this situation in a customer environment,                           
> 
> We have run into this before as well. It's not super
> rare. Applications do partial unmaps or protection changes with no
> awareness for THPs. The issue is likely to stick around with legacy
> software for some time.
> 
> Do note that all information is there if you know how to look for
> it. But it is cumbersome and somewhat inconsistent, so I'm not opposed
> to fixing it:
> 
>>> but the environment is complex, and I cannot clearly explain why this memory                  
>>> black hole occurs in that scenario.                                                           
>>> However, I will provide an example to reproduce it below.                                     
>>> Use case: The system has 100GB of memory. A user-space program requests 80GB of memory.       
>>> For each 2MB block, only one page is retained, and the mapping of all other pages is unmapped,
>>> while the process continues to run.                                                           
>>> You'll find that in meminfo, MemFree: only 12GB remains,                                      
>>> but the process actually uses very little memory.                                             
>>> This creates a memory black hole situation.                                                   
>>> Below is the test program I used, from AI.                                                    
>>>
>>
>> ps -p $(pgrep -d, test) -o pid,comm,%mem,rss,vsz
>>     PID COMMAND         %MEM   RSS    VSZ
>>    9358 test             0.1 165220 166032
>>
>>
>> MemTotal:       101606276 kB
>> MemFree:        13172092 kB
>> MemAvailable:   13569668 kB
>> Buffers:            5352 kB
>> Cached:          1169520 kB
>> SwapCached:            0 kB
>> Active:         84730404 kB
>> Inactive:        1129792 kB
>> Active(anon):   84730404 kB
> 
> This shows actually allocated anon+shmem.
> 
>> Inactive(anon):        0 kB
>> Active(file):          0 kB
>> Inactive(file):  1129792 kB
>> Unevictable:        6192 kB
>> Mlocked:              32 kB
>> SwapTotal:       4194300 kB
>> SwapFree:        4194300 kB
>> Zswap:                 0 kB
>> Zswapped:              0 kB
>> Dirty:                24 kB
>> Writeback:             0 kB
>> AnonPages:        969280 kB
> 
> This shows anon *mapped*.
> 
>> Mapped:           308848 kB
>> Shmem:             45076 kB
> 
> This shows that your (in)active anon *isn't* driven by shmem.
> 
>> KReclaimable:      96144 kB
>> Slab:             269540 kB
>> SReclaimable:      96144 kB
>> SUnreclaim:       173396 kB
>> KernelStack:       27584 kB
>> PageTables:       187408 kB
>> SecPageTables:         0 kB
>> NFS_Unstable:          0 kB
>> Bounce:                0 kB
>> WritebackTmp:          0 kB
>> CommitLimit:    54997436 kB
>> Committed_AS:    6628776 kB
>> VmallocTotal:   261087232 kB
>> VmallocUsed:       38696 kB
>> VmallocChunk:          0 kB
>> Percpu:            42800 kB
>> HardwareCorrupted:     0 kB
>> AnonHugePages:    413696 kB
> 
> This shows anon pmd-mapped.
> 
>> ShmemHugePages:        0 kB
>> ShmemPmdMapped:        0 kB
>> FileHugePages:    172032 kB
>> FilePmdMapped:     28672 kB
> 
> This shows both allocated huge pages and the pmd-mapped portion.
> 
> So you *can* work it out by looking at the LRU ((in)active) and
> cross-checking the shmem position. But it is awkward, granted.
Yes, R&D personnel may be able to draw conclusions through analysis, 
but this is indeed not very intuitive for operations and maintenance personnel.
> 
> IMO if there is a case to be made, it's doing the same split we do for
> file and shmem - AnonHugePages (allocated) and AnonPmdMapped.

This also adds a new field, which doesn't seem to be welcomed.

-- 
Thanks,
Ye Liu

