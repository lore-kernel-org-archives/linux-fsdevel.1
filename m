Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E3735A39F
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178685; cv=none; b=CdC4xROvZ7Wc3BjMfyt4xVETmh6h9/cMMtAMVUehk/X6F9l5LtKSUfGFuCpxrVTUIehUcxVZ1QXGC6Z3yqbgSo4D2ADQPiXm5WlvQRGfAB7JWX34xs3n4XqipN9/uMDUilxWufNCviO6420lkfKpKqzjJrrccS1EQoxbSdN+J5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178685; c=relaxed/simple;
	bh=tfQAr48YthmE1xus4eyK9S6jU0r8xKOYcveCoBmm8vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bqsWzcihiY1AVJpI9a4Q1K/u/OrRUZRu/OZ1QxAufWKpxj8LETlE3NzNqhp7EuiL8AcOO7macy0O6t6DyaJDtwz7YFT6XjLP2I4Ae1090qsWjcI9xwquE/IUfwkoNdtquUkRWtQfgoUdty6MW2AdOVE3sY/yO3ZE1T4aujb35uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cuCO3gs5; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cuCO3gs5"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=G1HxnYaFAzm8U5OOXij8ylCTKpYTXv8afbfuywpH9SU=;
	b=cuCO3gs5UxA6mkL0Q+gGsNlSTLv6cKrzcE8xO7/C3WY0gpCEs8C0Cw82KjiRM9y9swYNSk2DL
	g+LyODIB6By+Gg3gt4triFmGTiOXdO2JUGqfRFP/7g+Hir/3/Ss79wgifEEyQqeOht7DHBoAu9s
	kpQYL2wBOlXN/cMXANpY7zE=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gknYZ2zmhzKm73;
	Tue, 23 Jun 2026 09:29:54 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id E0EE24055B;
	Tue, 23 Jun 2026 09:37:58 +0800 (CST)
Received: from [10.174.178.9] (10.174.178.9) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Jun
 2026 09:37:58 +0800
Message-ID: <601fb5dd-18e1-4a6c-bc99-dc2a655240e2@huawei.com>
Date: Tue, 23 Jun 2026 09:37:57 +0800
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
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <93e9c643-f6fb-4377-ac5a-d91e203ad1a6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500001.china.huawei.com (7.202.194.229)


在 2026/6/22 19:45, David Hildenbrand (Arm) 写道:
> On 6/22/26 11:15, Jinjiang Tu wrote:
>> Reading /proc/kpageflags for any anonymous page returns KPF_KSM set, even
>> when KSM is not in use. As a result, tools misclassify all anonymous pages
>> as KSM merged.
>>
>> In stable_page_flags(), if the page is anonymous, then use (mapping &
>> FOLIO_MAPPING_KSM) check to identify if the anonymous page is KSM page.
>> However, FOLIO_MAPPING_KSM is FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM,
>> (mapping & FOLIO_MAPPING_KSM) check returns true for all nonymous pages.
>>
>> To fix it, use FOLIO_MAPPING_ANON_KSM instead.
>>
>> Fixes: dee3d0bef2b0 ("proc: rewrite stable_page_flags()")
> Right,
>
> #define PAGE_MAPPING_KSM       (PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
>
> Which we later renamed to FOLIO_MAPPING_KSM.
>
>
> Before switching to manual flag checks, PageKsm() translated to folio_test_ksm()
> that checked whether the values actually matched:
>
> ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) == PAGE_MAPPING_KSM;
>
>
> This only affects /proc/kpageflags (well, and hwpoison inject on a weird testing
> interface), so it's not really that relevant for real workloads (debugging and
> testing).
>
> So not sure whether we should CC:stable. Likely not.

/proc/kpageflags is generally used only for analysis and is unlikely to be
used in production environments. I found this issue due to I was analyzing
pfns allocated by which stacks are KSM-merged. So I think it's unnecessary
to CC:stable.

>> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
>> ---
>>   fs/proc/page.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index f9b2c2c906cd..cef8ded97610 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -173,7 +173,7 @@ u64 stable_page_flags(const struct page *page)
>>   		u |= 1 << KPF_MMAP;
>>   	if (is_anon) {
>>   		u |= 1 << KPF_ANON;
>> -		if (mapping & FOLIO_MAPPING_KSM)
>> +		if (mapping & FOLIO_MAPPING_ANON_KSM)
>
> Wonder whether we should just do
>
> 		if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
>
> To match what we have in folio_test_ksm.
>
> (although I doubt we would reuse this flag for other purposes, likely
> it's more future proof to check it like that)

Both are ok. The following check has checked FOLIO_MAPPING_ANON,

	if (is_anon) {
		if (mapping & FOLIO_MAPPING_ANON_KSM)
	}

So it's equivalent to do
	if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
or
	if (mapping & FOLIO_MAPPING_ANON_KSM)

>
