Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5B2798F8
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 03:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047659; cv=none; b=kw5vaK4pIfHHwXOfFdYBeLX6i5d2N7TKzPTaLh7fvXyEX35zRH/t4CH7puf0Fdsqedd+3uE8WZQR7A3r5ZYcBYmmvLALRXPLEZ1M+mI6oZFbgTqC9UlTP8FVMyprmk7dSYVtYenLkN1daA2sT/sNQg5DPTtSbO5FB//6bgKXCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047659; c=relaxed/simple;
	bh=4bxq2yeKxZGnAf8D3UK3N3gyeY1jHATYeTe9AmeYXsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K/TMAfqblA3A04CwW4AzCntpvBtX8egOgrXvIMQQwJ7rG568bG824b8rNlaD1sga9tPUULCUXvdiL2XwpmZHypVcBYmOdr4Fm2jySHkSIsF0MivjigSLOK4yBF6LAqs5HJ+czoJPbl0DAxbsggLW97LUi3eT7Eema+Yvp3UxUfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jwVQfYYX; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jwVQfYYX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4bxq2yeKxZGnAf8D3UK3N3gyeY1jHATYeTe9AmeYXsg=;
	b=jwVQfYYXk4TTuhdrDvt53GPiM7wL7RYZTPRovI/DjV/PaigRmtY6FAhXhIOY6TlOvAw0u22sX
	ZVo1D/Cqynjq64QjVVQhKejgIV3qmJyc8IkD3D9hXOYKl6rqU3DdB7W4OlIweO8lnS7mWzVlSh3
	2WZEf5VwYRGfPvhBsUVgKVc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gryvF5L83zRhWb;
	Fri,  3 Jul 2026 10:51:37 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 31BC940561;
	Fri,  3 Jul 2026 11:00:47 +0800 (CST)
Received: from [10.174.178.9] (10.174.178.9) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Jul
 2026 11:00:46 +0800
Message-ID: <5a4fc514-107d-403c-9e22-a25660651700@huawei.com>
Date: Fri, 3 Jul 2026 11:00:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fs: stable_page_flags(): use folio_test_*() helpers
To: "David Hildenbrand (Arm)" <david@kernel.org>, <akpm@linux-foundation.org>,
	<ziy@nvidia.com>, <luizcap@redhat.com>, <willy@infradead.org>,
	<linmiaohe@huawei.com>, <svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20260702110614.2176986-1-tujinjiang@huawei.com>
 <61157b05-b22a-4bcf-942b-05225837b57b@kernel.org>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <61157b05-b22a-4bcf-942b-05225837b57b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500001.china.huawei.com (7.202.194.229)


在 2026/7/2 20:03, David Hildenbrand (Arm) 写道:
> On 7/2/26 13:06, Jinjiang Tu wrote:
>> This series cleans up stable_page_flags(), removing the remaining direct
>> flag manipulation and replacing with folio helpers.
>>
>> Patch 1 replaces the "1 << KPF_*" expressions with BIT_ULL() marco, to
>> avoid -Wshift-count-overflow warning for KPF_* values larger than 32.
>>
>> Patch 2 replaces direct accesses to folio->flags.f with the standard
>> folio_test_*() helper functions, which cleans up stable_page_flags() and
>> hides internal implementation details.
>>
>> This series is based on [1].
>>
>> [1] https://lore.kernel.org/all/20260629033122.774318-1-tujinjiang@huawei.com/
> You should explain the history a bit, and why we converted to the manual checks
> in the first place.
>
> Now that we take a folio+page snapshot, the values cannot change concurrently
> anymore.

Yes, I only metioned commit 476d87d6a061 ("fs: stable_page_flags(): use snapshot_page()")
in patch2. I will update to explain the history in detail.

