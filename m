Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7C3A0B2E;
	Fri, 17 Jul 2026 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284161; cv=none; b=iZCYwKT7nw0vrjaq/Ixw9NGlibbDInSX75ULVNpPxUAkL1bMgzL0W77HLS9w7MncfWVfEltJRifFcRfUtyX55lcyxNAc0wt8eW3QDeudZDFzkpG+6NyvSSo3GTtlSrYWFn87S4BOd5xtNmEtubWvRJIVRDuX6UyQ1zeb3UtiyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284161; c=relaxed/simple;
	bh=2HToOcZv1T+lM9dO0dd2A4apjhiZwSISh71QgKydfWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5VbGnTKosy2ZZFhw4Y2ZNlKLIdu124lOJXJYXw/SKOmxSaYQsXoIPUgAuo1rr6192gYIFNhcsq4d1y70irKCnhnAeBoWFmjUldYJ0vZxeRz0te755U2jUgiLNPvH9SXTfJAe8Q7SjanbygPz6L1L/TVVuTnxoTUA8iAQ3RpOjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX/Zzy4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX/Zzy4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1101F000E9;
	Fri, 17 Jul 2026 10:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784284159;
	bh=5gkJj8mPn7DXvf10vpMFMt+lKH5hJcxAoz+8Yfk7BJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QX/Zzy4fhOl/Rfn6xnO/2b0c0XsiG9jzb2Bxl3fIG1PmBlPJWpflRdzs9oU1Hd7uK
	 LrgePrC5eehD95jM7GQepotJkHH/pZoMMLhXM6utYMmqQm2i76OyKtrJhnjxkuEexz
	 3Li9npc+Q5i3mQI15i2qVZNrnOyO/llaCVDjBUaGGESvze8Sa9k1+M/cUusl0V8AsV
	 QYl9FocD9ItGf6bGWakbcSu1QfkhjYJOdzIamNXPf1oCVc7oQAj3udWK6+8KwHChjW
	 1aHxuspgpWpRN+CuGi2ke/qLI5AVSMl7dsThjRU5FzZsxAObriLZb7gmnrb5ueoWpj
	 zv7ocnQ7IDw4w==
Message-ID: <676b9fa3-947d-42d2-b4e2-192e372be110@kernel.org>
Date: Fri, 17 Jul 2026 12:29:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/thp: expose deferred split folio memory usage in
 meminfo
Content-Language: en-US
To: Ye Liu <ye.liu@linux.dev>, "David Hildenbrand (Arm)" <david@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <liam@infradead.org>,
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
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <dd037379-cf59-468e-8b42-51546bf2e28c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/17/26 11:31, Ye Liu wrote:
> 在 2026/7/17 16:37, David Hildenbrand (Arm) 写道:
>> On 7/17/26 08:30, Ye Liu wrote:
>>> From: Ye Liu <liuye@kylinos.cn>
>>>
>>> Folios on the deferred split list hold physical memory that is
>>> invisible in meminfo. When a THP becomes partially mapped, the
>>> unmapped pages are removed from AnonPages but remain physically
>>> allocated until the shrinker splits the folio. This creates a
>>> memory accounting gap where used memory cannot be attributed to
>>> any meminfo field.
>>>
>>> Add NR_DEFERRED_SPLIT_PAGES to track the total memory consumed by
>>> folios currently on the deferred_split_lru, updated via
>>> mod_node_page_state() at all enqueue/dequeue points. The new field
>>> DeferredSplitPages is visible in /proc/meminfo, /proc/vmstat, and
>>> per-node /sys/devices/system/node/node*/meminfo.
>>>
>> 
>> Oh no.
>> 
>> This is really exposing a current implementation detail where we have this
>> information easily available in a way that we will not be able to change that
>> implementation later.
>> 
> 
> Yes, `/proc/meminfo` is a user-space ABI.                                
> Adding it there means you can't change the semantics,                    
> and the field will become unmaintainable, yet you can't delete it either.
> But I think this information is still necessary.                         
> Where would be a better place to put it?                                 

I once added KReclaimable to /proc/meminfo, its value used to be
SReclaimable plus ION allocator (I think), but that one was later removed so
it's now equivalent and I regret adding it and it stays there.

If the deferred split folios are just waiting for a memory pressure kick a
shrinker to reclaim them, the KReclaimable counter could however be a
sensible fit and wouldn't need adding a new user-visible output.

However I assume there's tradeoff with having to track this (complexity,
overhead) and possibly overhead of reading /proc/meminfo so it's not
clear-cut. Just pointing it out as a possibility.


