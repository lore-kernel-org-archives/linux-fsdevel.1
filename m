Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25679386C1F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724901; cv=none; b=pM9hL80OUF6VwJoS2iEi9tAwE3yAv+YLMIFhztW2Etw7Bgr/w8EKK6QciyLtZk6b8pX++7eT7GydldkPhbpofvcbWhOT/5mTPsbypp0SZVKomGAgag82FzUZ7IRTtZbwDYg/ca0CSNegVerhIDQc3GzaQz+p1+IJ2WTfEM1mDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724901; c=relaxed/simple;
	bh=GjinFiOGwLarVoATRmMWigzha3NBvpalUZ9U65a98Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SdT8qT0/XehbQFjhI4Cjbzg1ZmqkL0Cy9fR+1YXEa+Q+/yuPVHo7XBLYpO4+FQt1Aj6cHWw6OzmtPVHdGc/WOebphYnzZtRkErsQImXgyVkPPRTEFe8+8j6bmbzzOHiO6U2J2mNXv4jYN+G/N9pvZvIk/xIR6joJ3xEmO1npYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ylb3kxaT; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ylb3kxaT"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sdrsHSwCRgZ6uS9xoPl86hpy3G8uYrU07GQUvhHy4KY=;
	b=ylb3kxaTKjTEwhB2+nK78hg3owDGCr5AAKr964qMrhpr3j3fRZ4FgDYp/gvOMkCs2cFU/zJFd
	fpkpYgJaYUkLqU23EB1JNQq9V/jkH2xEfz8BzuQ/jxl7j9X8/c/rC8O3ug9NxVcSNTI2KP4B0bQ
	863Z36N9tL+/AhR5MMHe/a8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4frtrM5hhgzcbNR;
	Thu,  9 Apr 2026 16:48:35 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id E2A8E40538;
	Thu,  9 Apr 2026 16:54:54 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Apr 2026 16:54:53 +0800
Message-ID: <bdd49511-9b84-42cc-a286-9fdf2ef531a7@huawei.com>
Date: Thu, 9 Apr 2026 16:54:48 +0800
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
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <addhuRqrB-u7oDp8@tiehlicka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 4/9/2026 4:22 PM, Michal Hocko wrote:
> On Thu 09-04-26 16:08:37, Kefeng Wang wrote:
> [...]
>> To use the reclaim interface, there are two differences,
>>
>> 1) we need to input the reclaim numbers and swappiness, this is not a big
>> problem
>> 2) for reclaim, it supports swappiness=max to only reclaim anonymous pages,
>> but cannot only reclaim file pages,
> 
> Why is 2) a real constrain?

This should not be a restriction, but a strategy. Our product wants to
migrate anonymous pages to the local instead of swapping them out. 
However, the current per-node-reclaim interface does not support 
reclaiming only file pages.

