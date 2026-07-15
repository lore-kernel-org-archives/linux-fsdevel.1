Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A692931D0
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085617; cv=none; b=Ha2G26C9LiTllii7INCU7ozL+cyBv3IyZRvOvmaxvyDs0KoK3gOjV3OafCDLryPKb8R8lbuURlPc3/R9w64eWtGgG8zaHVcV8zpsisrA+drtiC0JGD1mYoaDTEo+60pxsXurxi/sAyicPd+xrsB/RpSIXR1fiw472uuAgZZg0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085617; c=relaxed/simple;
	bh=+lsgXSMlygpHGBobH8gtQvKhmBf0j97didJf8GO/DS4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DLkNkgVaVsirLekEjUKAo6EJfiqMFlgHpY2ceeCjIDQVLCUqlObKn+KEdE4wS5UMzxiFKTiwEUV4rirt2R0JFiOf1aNCslBK18cqApJFPt7PLcC3XYPs8Cg3ockBy21EZRB6f6JXzJ+k+HsIQYcKbvz8e/feq35J3jDbDME16ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pq4BINNf; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pq4BINNf; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pq4BINNf";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pq4BINNf"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ffXR8uJnFgBdEDOKpZDYO/HUDWw+NBq09FrCbR+s9mI=;
	b=pq4BINNf4lRsBSwRr9pg5n2KLCksDva0NvjjvVoh0EKEX0dCYt0Arq0KXtQ/1I66+CbXkV4vj
	E8lil+L20C3eDlpCIW+EflFfwqmHV5U4iEBhyWdLYi6VbGu/3cC6UwQ0goCyfoSv2GWaICT3SHs
	47uvXrrSq9oUpqdfcqLG4M0=
Received: from canpmsgout08.his.huawei.com (unknown [172.19.92.156])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4h0Lxt0tNsz126LV9
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 11:19:30 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ffXR8uJnFgBdEDOKpZDYO/HUDWw+NBq09FrCbR+s9mI=;
	b=pq4BINNf4lRsBSwRr9pg5n2KLCksDva0NvjjvVoh0EKEX0dCYt0Arq0KXtQ/1I66+CbXkV4vj
	E8lil+L20C3eDlpCIW+EflFfwqmHV5U4iEBhyWdLYi6VbGu/3cC6UwQ0goCyfoSv2GWaICT3SHs
	47uvXrrSq9oUpqdfcqLG4M0=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4h0Llk4FJHzmVX8;
	Wed, 15 Jul 2026 11:10:42 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0283D40586;
	Wed, 15 Jul 2026 11:20:01 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Jul 2026 11:20:00 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Jul 2026 11:19:59 +0800
Subject: Re: [PATCH v2 06/10] memory-failure: Prevent UAF in raw_hwp_page list
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>,
	<linux-mm@kvack.org>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
	<osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <christian@brauner.io>,
	Usama Arif <usama.arif@linux.dev>
References: <20260709184740.1286561-7-willy@infradead.org>
 <20260710150204.1887475-1-usama.arif@linux.dev>
 <alEpBqExnyvBnnxi@casper.infradead.org>
 <alZw5EdYVYCRNyj4@casper.infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3251bb16-be46-f752-a6ff-a6c3181f49b2@huawei.com>
Date: Wed, 15 Jul 2026 11:19:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alZw5EdYVYCRNyj4@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/7/15 1:24, Matthew Wilcox wrote:
> On Fri, Jul 10, 2026 at 06:16:54PM +0100, Matthew Wilcox wrote:
>> I think I'm going to have to change how we track hwpoison in hugetlb
>> in order to make this work.  Let me think out loud here:
>>
>> is_page_hwpoison() can be called without a reference on the folio
>> containing the page.  The answer can be wrong in this case, but any
>> UAF must be benign.
>>
>> Grabbing the mf_mutex inside hugetlb_page_hwpoison() is insufficient
>> because we can't protect against folio_clear_hugetlb_hwpoison() (the
>> approach attempted in this patch).
>>
>> We could add a spinlock for protecting freeing & checking of the list.
>> That's probably simplest.
>>
>> It'd be better to protect the list with RCU.  But then we'd need to
>> put an RCU head inside raw_hwp_page, doubling its size from 2 pointers
>> to 4.
>>
>> We could completely change how we do this; instead of having an llist,
>> we could have an array of 32-bit page indices.  Reallocate it when we
>> run out, doubling its size each time, and put an rcu head in that.
>> That'd give us 32-bytes the first time, space for 4 indices, then double
>> to 64 (space for 12 indices), double again to 128 (28 indices), etc.
>>
>> We could also RCU-free the folio if it's hwpoisoned.  We'd need to
>> clear the hugetlb flag before asking RCU to cover up this problem
>> to ensure that any reader that saw the hugetlb flag set started its
>> grace period before.
>>
>> Probably all too much trouble.  I think I'll add a global spinlock.
> 
> Sashiko pointed out this doesn't work either (ok, I was reading between
> the lines a bit here).
> 
> Since we don't have a refcount on the folio, it can be freed at any
> time, and the hwpoison list head can be reused for literally anything.

Sorry for late but could we hold hugetlb_lock here so hugetlb folio won't be freed
after we fetch the lock? We can recheck that the folio is still hugetlb and hwpoisoned
once we've got the hugetlb_lock.

Thanks.
.
