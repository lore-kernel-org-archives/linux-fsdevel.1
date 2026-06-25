Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86993C2B9C
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386495; cv=none; b=AJxN41XrAmW+a7IjsqX5B9GOxFD2MBLewq/GEEMG1CgXWm+axnvHmVQXxfnHjS+kdm7Z2BdYcyvscpvwEeWVTHKYT+Bf78DIiRUhRt5kwrRDX/3H9FYSPCGHh45/Ey8L81AE4FWpedSTDngBvE+2AuB2UioDIA1i2/Lzh41KhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386495; c=relaxed/simple;
	bh=3QBtjH/EgKVJ3Ic9ZYGxBszlfTGQV74hAOzBqHH2qdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ms/EkkRw3E+83Ya576QiglAo4LHDCmUgKOSmWHGoWbhc9YaXTyMw8mIVnIdDjWWTwJYZdb98di9C0SRxH/gXhrHOP1VxW6W8mkOLN1EqPzgJ7Cc2VJJ3V5MVV9Ea1g1PMHdQP6eUR0OlYiUdtyRJqwbiZsGGTQ1sFDlaFXSoYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hR+WW9gI; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hR+WW9gI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jAMw0WFN0U7V7evmhPHKbIT2IAgGFjbUT+BVVUGge8s=;
	b=hR+WW9gIb2huIy52YgGEmqoLuxHxrNZZonc+KFdrPEaVQfA/Qs6wt/AFrpiR83W0fgJl/XLso
	9tvdrHNOJ/Ymn71n6+5W/i7uJX+q2ob+4Yn+2DyhENl6zM9UBfY63X9PDqTytVIPDy0y7V8Bncp
	2DhvKCLCHg2b8yxFH5gntv4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gmGNc2zVczLlVM;
	Thu, 25 Jun 2026 19:12:16 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B38C40565;
	Thu, 25 Jun 2026 19:21:22 +0800 (CST)
Received: from [10.174.178.9] (10.174.178.9) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Jun
 2026 19:21:21 +0800
Message-ID: <c9ddee42-143a-4957-adf1-b302504a14cc@huawei.com>
Date: Thu, 25 Jun 2026 19:21:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc: fix KPF_KSM reported for all anonymous pages
To: "David Hildenbrand (Arm)" <david@kernel.org>, <akpm@linux-foundation.org>,
	<ziy@nvidia.com>, <luizcap@redhat.com>, <willy@infradead.org>,
	<linmiaohe@huawei.com>, <svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20260622091539.836531-1-tujinjiang@huawei.com>
 <93e9c643-f6fb-4377-ac5a-d91e203ad1a6@kernel.org>
 <601fb5dd-18e1-4a6c-bc99-dc2a655240e2@huawei.com>
 <6e39171c-8333-463d-9ea6-db331965d2c4@kernel.org>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <6e39171c-8333-463d-9ea6-db331965d2c4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500001.china.huawei.com (7.202.194.229)


在 2026/6/25 14:39, David Hildenbrand (Arm) 写道:
> On 6/23/26 03:37, Jinjiang Tu wrote:
>> 在 2026/6/22 19:45, David Hildenbrand (Arm) 写道:
>>> On 6/22/26 11:15, Jinjiang Tu wrote:
>>>> Reading /proc/kpageflags for any anonymous page returns KPF_KSM set, even
>>>> when KSM is not in use. As a result, tools misclassify all anonymous pages
>>>> as KSM merged.
>>>>
>>>> In stable_page_flags(), if the page is anonymous, then use (mapping &
>>>> FOLIO_MAPPING_KSM) check to identify if the anonymous page is KSM page.
>>>> However, FOLIO_MAPPING_KSM is FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM,
>>>> (mapping & FOLIO_MAPPING_KSM) check returns true for all nonymous pages.
>>>>
>>>> To fix it, use FOLIO_MAPPING_ANON_KSM instead.
>>>>
>>>> Fixes: dee3d0bef2b0 ("proc: rewrite stable_page_flags()")
>>> Right,
>>>
>>> #define PAGE_MAPPING_KSM       (PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
>>>
>>> Which we later renamed to FOLIO_MAPPING_KSM.
>>>
>>>
>>> Before switching to manual flag checks, PageKsm() translated to folio_test_ksm()
>>> that checked whether the values actually matched:
>>>
>>> ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) == PAGE_MAPPING_KSM;
>>>
>>>
>>> This only affects /proc/kpageflags (well, and hwpoison inject on a weird testing
>>> interface), so it's not really that relevant for real workloads (debugging and
>>> testing).
>>>
>>> So not sure whether we should CC:stable. Likely not.
>> /proc/kpageflags is generally used only for analysis and is unlikely to be
>> used in production environments. I found this issue due to I was analyzing
>> pfns allocated by which stacks are KSM-merged. So I think it's unnecessary
>> to CC:stable.
>>
>>>> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
>>>> ---
>>>>    fs/proc/page.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>>>> index f9b2c2c906cd..cef8ded97610 100644
>>>> --- a/fs/proc/page.c
>>>> +++ b/fs/proc/page.c
>>>> @@ -173,7 +173,7 @@ u64 stable_page_flags(const struct page *page)
>>>>            u |= 1 << KPF_MMAP;
>>>>        if (is_anon) {
>>>>            u |= 1 << KPF_ANON;
>>>> -        if (mapping & FOLIO_MAPPING_KSM)
>>>> +        if (mapping & FOLIO_MAPPING_ANON_KSM)
>>> Wonder whether we should just do
>>>
>>>          if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
>>>
>>> To match what we have in folio_test_ksm.
>>>
>>> (although I doubt we would reuse this flag for other purposes, likely
>>> it's more future proof to check it like that)
>> Both are ok. The following check has checked FOLIO_MAPPING_ANON,
>>
>>      if (is_anon) {
>>          if (mapping & FOLIO_MAPPING_ANON_KSM)
>>      }
>>
>> So it's equivalent to do
>>      if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
>> or
>>      if (mapping & FOLIO_MAPPING_ANON_KSM)
> As I said, matching precisely what we have in folio_test_ksm() is clearer. We
> don't have any users of FOLIO_MAPPING_ANON_KSM outside of page-flags.h for a
> reason :)

Indeed, I will send v2.

>
