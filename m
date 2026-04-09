Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D933A3819
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722915; cv=none; b=HF3utkmMHcHKig9+WBAp/z9pk9wAqqwugwTo0fFp9C+mv+VSelOLvqpHdW/6zuBlAjRR/BUqaQiko0+hOaNWuOAG0tYLw05N/eA6QncdzxZSe2158C2Q/A2rFRTXCahJPEIVjs7Iv8K1xYwDajwFGSJylyZ42KyfZcw+Y8HR71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722915; c=relaxed/simple;
	bh=3FxaH2pi07HgAkXVkNgGDiddMMES0joFDRHSKGaRFLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=idQXFsLHuHBqzuU/VyUGD7CvUP957D8PS2ag4TbXWWsgh3W8SFAJnM1UfVQmUdPdJ52S5bY3lJ2Tc1rvncbwu7bvzVUBgZqCtWvC69XJc7Wj2uAv/j+azWEi66g7oVcsDkv05FxYOTMHMvDJAn16x0+HbXo1NXT86F4vhpcSrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dim/9D+M; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dim/9D+M"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/ZlzV1lahyhPp5qrzpmqEvqVy8chzzw12TKhbe+CN4U=;
	b=dim/9D+M2GD9R4GhDwj+ZpwfpOH4fyiOOmIVuBzFLQZjzqAqqxGdOpBsR3yeu/e5JZCvEnx3+
	JtUWTg1cG2YUZsexEXFAPseukS5VzNAtBccmuouasTh96zwKbA1e4kod3akFNUmcfY9iKnx497E
	LnFegr1QictsYhTPjHvhkFo=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4frt6H6sjwz1cySK;
	Thu,  9 Apr 2026 16:15:35 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id CA48B4056C;
	Thu,  9 Apr 2026 16:21:49 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Apr 2026 16:21:48 +0800
Message-ID: <f8eec130-efe5-4e08-b5b4-a9701ccc7056@huawei.com>
Date: Thu, 9 Apr 2026 16:21:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
To: Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Christian Brauner <brauner@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil
 Babka <vbabka@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
 <addP4MKmA8zfSN1o@tiehlicka> <addRr9Vn_LNiXp11@lucifer>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <addRr9Vn_LNiXp11@lucifer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 4/9/2026 3:19 PM, Lorenzo Stoakes wrote:
> On Thu, Apr 09, 2026 at 09:06:08AM +0200, Michal Hocko wrote:
>> On Thu 09-04-26 14:35:03, Kefeng Wang wrote:
>>> Add a sysfs interface at /sys/devices/system/node/nodeX/drop_caches
>>> to allow dropping caches on a specific NUMA node.
>>>
>>> The existing global drop_caches mechanism (/proc/sys/vm/drop_caches)
>>> operates across all NUMA nodes indiscriminately, causing,
>>> - Unnecessary eviction of hot cache on some nodes
>>> - Performance degradation for applications with NUMA affinity
>>> - Long times spent on large systems with lots of memory
>>>
>>> By exposing a per-node interface, admistrator can,
>>> - Target specific nodes experiencing memory pressure
>>> - Preserve cache on unaffected nodes
>>> - Perform reclamation with finer granularity
>>
>> Quite honestly drop_caches is not the best interface to build any new
>> functionality on top of. It has backfired a lot in the past and we have
>> tried to make it extra clear that this should be used for debugging
>> purposes only. Extending it further sounds like a bad step.
> 
> Agreed, there is still _huge_ confusion out there as to what this is for.
> 
> (If I hear another person tell me this is a way to 'free up memory' I'll scream
> :)
> 
> Really I think it should be seen as a legacy thing for, as Michal says,
> debug purposes (it would have been a good idea to put this in debugfs tbh).
> 
> And adding something to sysfs as a permanent, maintained interface for this
> purpose seems problematic.
> 
> What is the use-case for this? Why are you dropping the caches? Presumably
> for debugging/perf measuring/etc. purposes? The cover letter is lacking
> that.

Our use case is as follows, for hot-pluggable nodes, for anon pages,
migrating them to other nodes, but for pagecaches, just evicting them
since pages could be refaulted. For mem-tiering, a large amount of cold
memory is stored in the low tier, we think that evicting pagecache is
better than migrating them back to high tier, also this avoid the risk
of accessing potentially faulty memory.


> 
> I wonder, if this is something we should move forward with, whether we
> might be better off putting it in debugfs as a result?
> 
>>
>>> One use cases is hot-pluggable NUMA nodes, during hot-remove, simply
>>> dropping pagecache is far more efficient than migrating large amounts
>>> of pages to other nodes, which also eliminating the risk of accessing
>>> potentially faulty memory.
>>
>> Does the per-node reclaim interface can help with this by
>> any means?
>>
>> --
>> Michal Hocko
>> SUSE Labs
> 
> Thanks, Lorenzo

