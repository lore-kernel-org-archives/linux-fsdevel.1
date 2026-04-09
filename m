Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225E355F43
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739648; cv=none; b=TT3X3peoLKnQPPxQIIsw/nP5g+UYUl4igJthwuOzeNeGPIPpxfyySL/V8Bd+eTePDmcpqFQIt4jA/KfiORAdaCO+xf4dFaxboXSJloLqSJpBDLttTngtw0Q02IGw5SXrT1HhPn1skWVfQYd5h3Y+PPcpt+z/dPQpv6WrSCgZ6ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739648; c=relaxed/simple;
	bh=JiZkkpT6uDwItVOp7mdIRtSVdod6amSN3/dylLRXmDA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=pakv4EaZV0bQCbew5AHBOLYXSTU8r53MmKUfamydNXP+wu792d6Daev3BMuZ5P7xUO7YHcd7eXXLTgiNtOOSNrvAOUGs/qSiTmotzExaSQYJqWv71XKpRJuHBhChm0cvwO6AS1Uu8KDwQyANY8VT+YMiQQDkBrDKKacaUMoBCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=byvCiLOR; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=byvCiLOR; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="byvCiLOR";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="byvCiLOR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8K8dTYIfBr95gka4SMFnnmH0LLrhv1YdGgZUi+F6W98=;
	b=byvCiLORt6Rcx6RN+BTI3johy8ZtXi9h5eFA88EulocIa2qHGeV98yUyIcLfEY0H0akJyseF3
	syp95/e3v8DF6r25GGTFVBSRNq4Cx//hCVrZmGFClDZXvwb1R8ew38qT0iLLnMDO7rd2p/LqgSt
	seYoSeUZq9Os/DhKcIBbIlQ=
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fs0Qh1k5Lz1BGBt
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 21:00:12 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8K8dTYIfBr95gka4SMFnnmH0LLrhv1YdGgZUi+F6W98=;
	b=byvCiLORt6Rcx6RN+BTI3johy8ZtXi9h5eFA88EulocIa2qHGeV98yUyIcLfEY0H0akJyseF3
	syp95/e3v8DF6r25GGTFVBSRNq4Cx//hCVrZmGFClDZXvwb1R8ew38qT0iLLnMDO7rd2p/LqgSt
	seYoSeUZq9Os/DhKcIBbIlQ=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fs0Hw0yzjzRhTw;
	Thu,  9 Apr 2026 20:54:20 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id DFA1440538;
	Thu,  9 Apr 2026 21:00:34 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Apr 2026 21:00:33 +0800
Message-ID: <0cc07f96-641a-43e1-b90d-641962d9459d@huawei.com>
Date: Thu, 9 Apr 2026 21:00:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
From: Kefeng Wang <wangkefeng.wang@huawei.com>
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
Content-Language: en-US
In-Reply-To: <95bc0034-a72b-449c-9be4-b691fd03dc1e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 4/9/2026 8:50 PM, Kefeng Wang wrote:
> 
> 
> On 4/9/2026 6:52 PM, Michal Hocko wrote:
>> On Thu 09-04-26 16:54:48, Kefeng Wang wrote:
>>>
>>>
>>> On 4/9/2026 4:22 PM, Michal Hocko wrote:
>>>> On Thu 09-04-26 16:08:37, Kefeng Wang wrote:
>>>> [...]
>>>>> To use the reclaim interface, there are two differences,
>>>>>
>>>>> 1) we need to input the reclaim numbers and swappiness, this is not 
>>>>> a big
>>>>> problem
>>>>> 2) for reclaim, it supports swappiness=max to only reclaim 
>>>>> anonymous pages,
>>>>> but cannot only reclaim file pages,
>>>>
>>>> Why is 2) a real constrain?
>>>
>>> This should not be a restriction, but a strategy. Our product wants to
>>> migrate anonymous pages to the local instead of swapping them out. 
>>> However,
>>> the current per-node-reclaim interface does not support reclaiming 
>>> only file
>>> pages.
>>
>> Yes, I do understand that you want to keep your hot anonymous pages
>> resident on some node. Those shouldn't be reclaimed by the user space
>> triggered reclaim anyway, right? Migration will then happen during the
>> memory offlining.
> 
> Yes, that we need.
>>
>> This will certainly require some fine tuning but I do not see any reason
>> this should be completely impossible. Certainly a more robust way (from
>> API POV) than the suggested drop_caches. I am also not convinced we need
>> page-cache-only reclaim for the existing reclaim interface. I believe it
>> makes more sense to look at the reclaim from hotness POV rather than
>> anon vs. file.
> 
> It is already support only reclaim file pages when swappiness = 0 for
> memcg.reclaim, but not for per-node-reclaim, so we can just make a few
> small changes to enable it(no tested)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 84eba9ab5d25..46254ae9b8df 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2515,7 +2515,7 @@ static void get_scan_count(struct lruvec *lruvec, 
> struct scan_control *sc,
>           * using the memory controller's swap limit feature would be
>           * too expensive.
>           */
> -       if (cgroup_reclaim(sc) && !swappiness) {
> +       if ((cgroup_reclaim(sc) || sc->proactive) && !swappiness) {
>                  scan_balance = SCAN_FILE;
>                  goto out;
>          }
> 

Sorry, the changes below are incorrect，please ignore.

> or
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 84eba9ab5d25..e2998b61f78b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2515,7 +2515,7 @@ static void get_scan_count(struct lruvec *lruvec, 
> struct scan_control *sc,
>           * using the memory controller's swap limit feature would be
>           * too expensive.
>           */
> -       if (cgroup_reclaim(sc) && !swappiness) {
> +       if (sc->proactive && !swappiness) {
>                  scan_balance = SCAN_FILE;
>                  goto out;
>          }
> 
> 
> 
> 

