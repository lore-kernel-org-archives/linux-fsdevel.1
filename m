Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12027A462
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392560; cv=none; b=IcfjrdKz1FdVbXIy8leuJkSWNRLl1LKPx+3/V5rb0tX3t94HazqAHu3UY1ZJ1zD8HgEEVm1dcgilW8ddlAnqj3Q5aRQsWMb3Xjpwls5aKHKDulE5t9CqtcgdWvDsFhKm4VaAf7hPsTBsqplNU7KfgWN1G+DKtb1C6cBzXJCYNII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392560; c=relaxed/simple;
	bh=5i77ger88zezVroL5G7P1+2TsKTxWgK4e37XO/nKq00=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pz449yP8Z0C49KZQiPIuvTHIy+RTbkXY+6jeHWfuEJod0jwX4Dka6L/+redeJu1MKPgW1PTS9jm753+ICbkBsf/QbinjJ1lYJBNfBOg8cyknxEgbpMcf/g5cwG709RVkTgbEPIALoAGzbKK2GpzZ8lo+XcRAkkw7Nqs3lh15Z2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IDuxi9vq; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IDuxi9vq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5i77ger88zezVroL5G7P1+2TsKTxWgK4e37XO/nKq00=;
	b=IDuxi9vq1VQpihcnFfGXqwl38ueqQ2n/pwuhiwA3jcWXZUfOCRnfMPEquUhZAgeZTIRkGj1+h
	DwxwvKL9hpelqOOnsiEerb0UPIPaQNg9piMGX8b3Qdy0glKEio86/jyycgnvwcxyUhOVFWdYZ5f
	3pNnKRhr2FiguoUA6WybSpk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gvQSb0HWkz12LJK;
	Tue,  7 Jul 2026 10:40:31 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id EC2F64057D;
	Tue,  7 Jul 2026 10:49:10 +0800 (CST)
Received: from [10.174.178.9] (10.174.178.9) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Jul
 2026 10:49:10 +0800
Message-ID: <2b4b3fec-18e4-48da-8ead-82d0c4970c08@huawei.com>
Date: Tue, 7 Jul 2026 10:49:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/task_mmu: count KSM-placed zero pages in smaps
To: "David Hildenbrand (Arm)" <david@kernel.org>, <akpm@linux-foundation.org>,
	<liam@infradead.org>, <ljs@kernel.org>, <vbabka@kernel.org>,
	<jannh@google.com>, <pfalcato@suse.de>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20260706121323.1149847-1-tujinjiang@huawei.com>
 <6ef49a9f-af0c-4bce-8402-16926424ea7a@kernel.org>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <6ef49a9f-af0c-4bce-8402-16926424ea7a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500001.china.huawei.com (7.202.194.229)


在 2026/7/6 21:40, David Hildenbrand (Arm) 写道:
> On 7/6/26 14:13, Jinjiang Tu wrote:
>> When KSM deduplicates a page to the kernel zero page (i.e. when
>> /sys/kernel/mm/ksm/use_zero_pages=1), it places a zero PTE with the dirty
>> bit set. vm_normal_page() returns NULL for such PTEs, so smaps_pte_entry()
>> bails out before reaching smaps_account() and these pages are never counted
>> into mss->ksm. As a result /proc/<pid>/smaps and smaps_rollup report a KSM
>> value of 0 even though the region is fully merged.
>>
>> Count KSM-placed zero pages directly in smaps_pte_entry() using
>> is_ksm_zero_pte().
> Hm.
>
> We do expose "ksm_zero_pages" in /proc/<pid>/ksm_stat for calculating the KSM
> profit.
>
> Why would we want to expose it here as KSM pages?
>
> An application will notice the difference between "zeropage enabled vs.
> disabled" either way because we'll also not account zerpages towards e.g.,
> "Anonymous".
>
> So faking that something consumes memory when it actually doesn't consume memory
> is wrong?

Indeed. As Documentation/filesystems/proc.rst says, smaps shows the memory consumption of
each mapping and flags associated with it. KSM-placed zero pages shouldn't be accounted.

