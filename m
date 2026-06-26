Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE1B3D6CDE
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455290; cv=none; b=oLpGMBuWmoIuIuU9KqtzaZNDDi0gQbHowiHBY7F4l1+q2zX/W2XlISGvH5B+9ZBb8h6P2k8pgOqYbSOTNO7cYCZ5HXfI3DTV4AFm8VscmhAJw05pjGvSlUGaNI8KkhVcvbNgRJZRBnxGtGH2ZsDK/ATeEhbTg+FlNZFGlBdUQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455290; c=relaxed/simple;
	bh=UYgGodnJo4hgkVgeb65Xru8PDW+QQZ8BCjyuGXq2xhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MzwMbaIYhPxhDFoLN76qX/734hvXMP3xtmCdD81nnctEqlwNd1pQ+Fg8l6SlyP7xIemvLkZv7G5P9pDSQbcQbeY0qB79N3wd7YkGiqbQWKOplpMUP66+I4pCPOHsZGHv9hDV15900RvozLcfuxQue8CM8b2BEFAYtVXqaVJBYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=d2VXtxJ/; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="d2VXtxJ/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5xy3UeQtOde3ibok9i44GRzCeqbo5Q19T26Lwk+n438=;
	b=d2VXtxJ/pV347NldSW0ZbGuS8gmd3vVvzbQ8gNBGEH9uHxOQFZXjXoLJJE13G2MyKoyfmcua8
	3OUWuS3faSrAQIxAm21RkF2doyO4GxohwCKu1QUJYVL2Q7j5dbsQwOG8XyPiJjpHj/BhFTjHUH/
	Nlc7mgu3WL4/sgXrjH+lRdM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gmlr54HLvz12LCb;
	Fri, 26 Jun 2026 14:19:17 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id A1B4D203B8;
	Fri, 26 Jun 2026 14:28:03 +0800 (CST)
Received: from [10.174.178.9] (10.174.178.9) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Jun
 2026 14:28:02 +0800
Message-ID: <cc9a18a4-6b9d-49b5-a6c9-a45ba561acc3@huawei.com>
Date: Fri, 26 Jun 2026 14:28:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/proc: fix KPF_KSM reported for all anonymous pages
To: <xu.xin16@zte.com.cn>
CC: <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@kernel.org>,
	<luizcap@redhat.com>, <willy@infradead.org>, <linmiaohe@huawei.com>,
	<svetly.todorov@memverge.com>, <chengming.zhou@linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20260626100902993K04Lc3GM32AnCvCmzGequ@zte.com.cn>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <20260626100902993K04Lc3GM32AnCvCmzGequ@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500001.china.huawei.com (7.202.194.229)


在 2026/6/26 10:09, xu.xin16@zte.com.cn 写道:
>> Reading /proc/kpageflags for any anonymous page returns KPF_KSM set, even
>> when KSM is not in use. As a result, tools misclassify all anonymous pages
>> as KSM merged.
>>
>> In stable_page_flags(), if the page is anonymous, then use (mapping &
>> FOLIO_MAPPING_KSM) check to identify if the anonymous page is KSM page.
>> However, FOLIO_MAPPING_KSM is FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM,
>> (mapping & FOLIO_MAPPING_KSM) check returns true for all nonymous pages.
> "returns true for all nonymous pages."
>
> should %s/nonymous/anonymous ?

Ah, yes

>
>> To fix it, use FOLIO_MAPPING_ANON_KSM instead.
>>
>> Fixes: dee3d0bef2b0 ("proc: rewrite stable_page_flags()")
>> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
>> ---
>> Changelog in v2:
>>   * use FOLIO_MAPPING_KSM to match explictly instead of use FOLIO_MAPPING_ANON_KSM
>> only.
>>
>>   fs/proc/page.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index f9b2c2c906cd..7d9387143435 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -173,7 +173,7 @@ u64 stable_page_flags(const struct page *page)
>>           u |= 1 << KPF_MMAP;
>>       if (is_anon) {
>>           u |= 1 << KPF_ANON;
>> -        if (mapping & FOLIO_MAPPING_KSM)
>> +        if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
>>               u |= 1 << KPF_KSM;
>>       }
>>   
>> -- 
>> 2.43.0
