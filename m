Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A929B78D
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742321; cv=none; b=hZtXbfSgL/+z8nIcxJGSPo6WeMPYb+t21RuWDBhHirAm+Zr5NH7hzoZ2AQAcobdQqctMTUO4RwqVitOK802VK0bJSD9ZyFDd9LSwYGv6aNc4EQxNsmJsRIzRMOz134dt88/4EKMZBvV19gbRD8sfD8xet8xJrwMgZLEVzseJnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742321; c=relaxed/simple;
	bh=/Q8XhsKUf9+1RZBBNCrZXZbKX/wirTtKJz8rnNQZLn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VyaO1dDIcYvGlZjhXASICkNR0C42ULD5IuXa3yWNhH3RvunQSs2ecdEI5Uo7gT7TCvESRoz4Bu4nWAFMyuIDjetPvib6lgxOw6yGcCqrlTwZm0VTw4BEZSPA8lfMv+73DKYFgCeZzqvm/30n2wj6UjBqS7BE114TzbphTTp36p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QqozcRe0; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QqozcRe0"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gJ3AK0pFALltuMA1doiDwlpqhRI344SC4WJuiz5X1dY=;
	b=QqozcRe0aKq0MNTlS8Hpb0XYFDQ4Bt6buwo6ox398OnNhv5CnKMRSYyPq/jF6/dPTdUhMn2ge
	u2q+qYnbUZb1sKawAVk7hxVOD1D2bMnDnubvnDZahA9guoqsqJSQ6QjlmEGpxqKIcvdLHf6rX/D
	aznrGZ3Y+1+JUPYzRv518fc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fs1HR34HTzmV6X;
	Thu,  9 Apr 2026 21:38:59 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id AC28F4048B;
	Thu,  9 Apr 2026 21:45:15 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Apr 2026 21:45:13 +0800
Message-ID: <1141f0ca-3b43-455f-bfa3-39c6da68ee58@huawei.com>
Date: Thu, 9 Apr 2026 21:45:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
To: Michal Hocko <mhocko@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Christian Brauner <brauner@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo
 Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
 <addP4MKmA8zfSN1o@tiehlicka>
 <dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>
 <addhuRqrB-u7oDp8@tiehlicka>
 <bdd49511-9b84-42cc-a286-9fdf2ef531a7@huawei.com>
 <adeFBKzNq9rNzbHk@tiehlicka>
 <95bc0034-a72b-449c-9be4-b691fd03dc1e@huawei.com>
 <adejDzw8Mf6407-a@tiehlicka>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <adejDzw8Mf6407-a@tiehlicka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 4/9/2026 9:01 PM, Michal Hocko wrote:
> On Thu 09-04-26 20:50:33, Kefeng Wang wrote:
>>
>>
>> On 4/9/2026 6:52 PM, Michal Hocko wrote:
>>> On Thu 09-04-26 16:54:48, Kefeng Wang wrote:
>>>>
>>>>
>>>> On 4/9/2026 4:22 PM, Michal Hocko wrote:
>>>>> On Thu 09-04-26 16:08:37, Kefeng Wang wrote:
>>>>> [...]
>>>>>> To use the reclaim interface, there are two differences,
>>>>>>
>>>>>> 1) we need to input the reclaim numbers and swappiness, this is not a big
>>>>>> problem
>>>>>> 2) for reclaim, it supports swappiness=max to only reclaim anonymous pages,
>>>>>> but cannot only reclaim file pages,
>>>>>
>>>>> Why is 2) a real constrain?
>>>>
>>>> This should not be a restriction, but a strategy. Our product wants to
>>>> migrate anonymous pages to the local instead of swapping them out. However,
>>>> the current per-node-reclaim interface does not support reclaiming only file
>>>> pages.
>>>
>>> Yes, I do understand that you want to keep your hot anonymous pages
>>> resident on some node. Those shouldn't be reclaimed by the user space
>>> triggered reclaim anyway, right? Migration will then happen during the
>>> memory offlining.
>>
>> Yes, that we need.
>>>
>>> This will certainly require some fine tuning but I do not see any reason
>>> this should be completely impossible. Certainly a more robust way (from
>>> API POV) than the suggested drop_caches. I am also not convinced we need
>>> page-cache-only reclaim for the existing reclaim interface. I believe it
>>> makes more sense to look at the reclaim from hotness POV rather than
>>> anon vs. file.
>>
>> It is already support only reclaim file pages when swappiness = 0 for
>> memcg.reclaim, but not for per-node-reclaim, so we can just make a few
>> small changes to enable it(no tested)
> 
> This might be small changes wrt code impact but they are changing the
> semantic of the interface and that needs proper analysis of impact,
> potential regression risk and also evaluate whether this is what we
> really want/need. Memcg has been special in this regards from early on
> and we pretty much had to keep the status quo IIRC.


For proactive reclaim, there are three interface for now,
1) lru_gen:  called lru_gen_seq_write()
2) memcg.reclaim/per-node-reclaim :  called user_proactive_reclaim（）


I think it is reasonable to provide more strategic options for user 
proactive reclaim. The new code changes the semantic of lru_gen/per-
node-reclaim, but not memcg, so if we do need to avoid potential
regression, maybe add something like swappiness=min to only reclaim
file page.



