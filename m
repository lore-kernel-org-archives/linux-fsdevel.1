Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AFC2DFF3F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739050; cv=none; b=S+B+95cVyaWOs64ZL3kyCcwGgT9gshS75IT04IxtBm82pv4hXKA2FcGfUSHzBZgq3YFCejj3NbPQJ8zvbVviEDVwSBR7nj/xKcBcp7db3uub5l9xXtRJfBEJz+zQHw9QEjugtfG97FY4dKQu9/cmdZMhf5MsfTmvNxTBesOsCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739050; c=relaxed/simple;
	bh=v8gZ/CXYQZck+YDATEXpKe2ylgLSVj4qZ2hEz4Zpt90=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fpma3iODtPjVujfo77Z0jNgnjsH+S6DadhIxaMytR06XDeavAjuTqIwMFssIZLer1OaUVvls0EBTned4U7MjdZhktsAgt8lVzIdt8lPgAFBHXSY6OOdvHVks1Mj16zPQ98KPFKOvgNUFXAsFoynZMjti7RFzxROY6IWY3gjbJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jr1w2Lb+; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jr1w2Lb+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KE4eT7YcrT++12c/obGpJYqag96lO0J1UNDibfVOhpA=;
	b=jr1w2Lb+N3vZPTEFDElACQMA6h5rDgN8VQXEOB8wa1u3Sr6XbfzJvM8fu4Ea9zuaiDMLOILNf
	bOKS8e6m6ezGljzENQ0R0UCWPCMNTbCk5HhaXK+9xOhDdgZtjUf6DP+g36FHlneYudVV9iHTLYZ
	Z5RSJ/sZ3AhkAqLCedtGYiE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fs04s751Mz1T4Gp;
	Thu,  9 Apr 2026 20:44:45 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 6037C40561;
	Thu,  9 Apr 2026 20:50:38 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Apr 2026 20:50:37 +0800
Message-ID: <95bc0034-a72b-449c-9be4-b691fd03dc1e@huawei.com>
Date: Thu, 9 Apr 2026 20:50:33 +0800
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
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <adeFBKzNq9rNzbHk@tiehlicka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 4/9/2026 6:52 PM, Michal Hocko wrote:
> On Thu 09-04-26 16:54:48, Kefeng Wang wrote:
>>
>>
>> On 4/9/2026 4:22 PM, Michal Hocko wrote:
>>> On Thu 09-04-26 16:08:37, Kefeng Wang wrote:
>>> [...]
>>>> To use the reclaim interface, there are two differences,
>>>>
>>>> 1) we need to input the reclaim numbers and swappiness, this is not a big
>>>> problem
>>>> 2) for reclaim, it supports swappiness=max to only reclaim anonymous pages,
>>>> but cannot only reclaim file pages,
>>>
>>> Why is 2) a real constrain?
>>
>> This should not be a restriction, but a strategy. Our product wants to
>> migrate anonymous pages to the local instead of swapping them out. However,
>> the current per-node-reclaim interface does not support reclaiming only file
>> pages.
> 
> Yes, I do understand that you want to keep your hot anonymous pages
> resident on some node. Those shouldn't be reclaimed by the user space
> triggered reclaim anyway, right? Migration will then happen during the
> memory offlining.

Yes, that we need.
> 
> This will certainly require some fine tuning but I do not see any reason
> this should be completely impossible. Certainly a more robust way (from
> API POV) than the suggested drop_caches. I am also not convinced we need
> page-cache-only reclaim for the existing reclaim interface. I believe it
> makes more sense to look at the reclaim from hotness POV rather than
> anon vs. file.

It is already support only reclaim file pages when swappiness = 0 for
memcg.reclaim, but not for per-node-reclaim, so we can just make a few
small changes to enable it(no tested)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 84eba9ab5d25..46254ae9b8df 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2515,7 +2515,7 @@ static void get_scan_count(struct lruvec *lruvec, 
struct scan_control *sc,
          * using the memory controller's swap limit feature would be
          * too expensive.
          */
-       if (cgroup_reclaim(sc) && !swappiness) {
+       if ((cgroup_reclaim(sc) || sc->proactive) && !swappiness) {
                 scan_balance = SCAN_FILE;
                 goto out;
         }

or

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 84eba9ab5d25..e2998b61f78b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2515,7 +2515,7 @@ static void get_scan_count(struct lruvec *lruvec, 
struct scan_control *sc,
          * using the memory controller's swap limit feature would be
          * too expensive.
          */
-       if (cgroup_reclaim(sc) && !swappiness) {
+       if (sc->proactive && !swappiness) {
                 scan_balance = SCAN_FILE;
                 goto out;
         }



