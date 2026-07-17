Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B73E9C1B
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282127; cv=none; b=O2kxXSPg5T0fBL+aw9hpykYb5bq5cNV/kjf4EQy8Ali5iMtCgS4snIou3LWNhNUk/LE8NQDKvUlOsDbObhiMBimNz3hCghque4S0oeztZZBk7yuzbZq1O0QT0/OAL3bb9I2+xW84dFQoQEcYmtYKpL5e5XA0VltX7aVo8M3KLU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282127; c=relaxed/simple;
	bh=TtlKEQ0wxo7w1DI20u8oorrRVmZ0uCqo0hk85Jwil9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mURC7HzM4RioB6FgA9vTK/tkKNa8AHeVhXWKLh6AhLNvlv9XxZ4dOAAcBCVjmxv/wCUMXzRjco1TiNOwquElCh1UrpRnaAFa9ZgIrQDtw3qftrUSZO0rfrEXCI/DSyHRWWAoyxJgWXHLPKa1HNPtc1h3MSQ16LdPLp4GCHNXDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j2Q+C1xk; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j2Q+C1xk"
Message-ID: <41bc5ca5-08ed-4aba-86a3-d7f44b16e6f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784282113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mK2m3B99lepxQmpUE2cqM6SY8XVxww1y2r5f/OdX7BQ=;
	b=j2Q+C1xkJleCKe9jON6eBE3mwU3B3TNr9aL+L8sLWRwyT5iqJQA4EoFdFSn9STTdPaDCFi
	3caFeT1kkhVaDdDFfDMjqQhsfizV6dRLQMZqNj/MreLAAWqmA8fq4DsbpVWssbQ7DgwXCm
	N3aJD4NEw8JOwAxdZvTO90NJ8FJ/DiI=
Date: Fri, 17 Jul 2026 17:54:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/thp: expose deferred split folio memory usage in
 meminfo
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
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
 <46017e29-48a3-4a74-8c5a-0be9d912deaa@kernel.org>
 <dd037379-cf59-468e-8b42-51546bf2e28c@linux.dev>
 <f041f1e0-8ec4-48d4-8656-a6789c8ad379@kernel.org> <aln6SBHcxBY-9Vfl@lucifer>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <aln6SBHcxBY-9Vfl@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/17 17:48, Lorenzo Stoakes (ARM) 写道:
> On Fri, Jul 17, 2026 at 11:33:05AM +0200, David Hildenbrand (Arm) wrote:
>> On 7/17/26 11:31, Ye Liu wrote:
>>>
>>>
>>> 在 2026/7/17 16:37, David Hildenbrand (Arm) 写道:
>>>> On 7/17/26 08:30, Ye Liu wrote:
>>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>>
>>>>> Folios on the deferred split list hold physical memory that is
>>>>> invisible in meminfo. When a THP becomes partially mapped, the
>>>>> unmapped pages are removed from AnonPages but remain physically
>>>>> allocated until the shrinker splits the folio. This creates a
>>>>> memory accounting gap where used memory cannot be attributed to
>>>>> any meminfo field.
>>>>>
>>>>> Add NR_DEFERRED_SPLIT_PAGES to track the total memory consumed by
>>>>> folios currently on the deferred_split_lru, updated via
>>>>> mod_node_page_state() at all enqueue/dequeue points. The new field
>>>>> DeferredSplitPages is visible in /proc/meminfo, /proc/vmstat, and
>>>>> per-node /sys/devices/system/node/node*/meminfo.
>>>>>
>>>>
>>>> Oh no.
>>>>
>>>> This is really exposing a current implementation detail where we have this
>>>> information easily available in a way that we will not be able to change that
>>>> implementation later.
>>>>
>>>
>>> Yes, `/proc/meminfo` is a user-space ABI.
>>> Adding it there means you can't change the semantics,
>>> and the field will become unmaintainable, yet you can't delete it either.
>>> But I think this information is still necessary.
>>> Where would be a better place to put it?
>>
>> Don't expose it to user space.
> 
> Yeah please stop.
> 
> We don't want this change, it exposes internal implementation details. It's a
> no.
> 
> Next time send an RFC or a discussion thread.
> 
Yes, sending an RFC would be more appropriate.                                                  
                                                                                                
I'd also like to ask if it's possible to implement this in                                      
`/sys/kernel/debug/deferred_split_pages`, or are you completely against querying this statistic?
                                                                                                
How can we quickly identify this situation?                                                     
I believe some people will still be confused: where did the memory go?                          

>>
>> --
>> Cheers,
>>
>> David
> 
> Thanks, Lorenzo

-- 
Thanks,
Ye Liu

