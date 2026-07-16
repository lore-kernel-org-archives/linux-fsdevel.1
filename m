Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEE2931E5
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191988; cv=none; b=E2gYwf0q0RLtnyOV3+btRoxvNm/ilW5x6gvsTFKyPhoq8SE/Ur7X7fCmY8Iam/Z2AzRDs0BAnJC/5Deqt3M1NrjZMltUMt1hfnd58eg3ztZABqTNN7yxrdjzW2oM0nUkg+lYfN1rAAcf2LW2ciupUK6WOjP8YNt8RvFs3gKO2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191988; c=relaxed/simple;
	bh=MDrNL9+8ZtQIDlOwu7eCSp/4wgdoXDpeJtETqywC/8w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fIvYAfg+57kvy4uTfJhlhZn3mXqud4bbXMG6inrrmj4DfSKXuDiR8jV6D/IbpyPTDW4jVtWtnnL9y1Sg3xk3HDmuwyUE+26bPVxFC0bTc1qaTiCRwZF7kY0oKTowWOkEjXtM3Gvdlje8MOVP37ckjR5YLxnfaEs3j8XZxWR+sqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iBTgfV11; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iBTgfV11"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rFFCoyO/+w1iSUrrWq6Xd9FpGanmaNhN6TuxhtNVXXA=;
	b=iBTgfV1140Hou/n/fA8i7J1618vwGYrOFz7G05l9QhWO5qbTV2CG8LsQbv6Dtzs/x2TPJA2ne
	h5UfZFRqoSfLf3OVRd3jer/fBjugBtA5V+VwGfFHa8AZkbWvR5OrcPt0FF5wiADD106syJhh75o
	rO7z2hHsGwWHcUihifYRlAs=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h165755kdz12LGB;
	Thu, 16 Jul 2026 16:43:23 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id F06572012A;
	Thu, 16 Jul 2026 16:53:00 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Jul 2026 16:53:00 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Jul 2026 16:52:59 +0800
Subject: Re: [PATCH v2 06/10] memory-failure: Prevent UAF in raw_hwp_page list
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>,
	<linux-mm@kvack.org>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
	<osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <christian@brauner.io>,
	Usama Arif <usama.arif@linux.dev>, Jiaqi Yan <jiaqiyan@google.com>, "Naoya
 Horiguchi" <naoya.horiguchi@nec.com>
References: <20260709184740.1286561-7-willy@infradead.org>
 <20260710150204.1887475-1-usama.arif@linux.dev>
 <alEpBqExnyvBnnxi@casper.infradead.org>
 <alZw5EdYVYCRNyj4@casper.infradead.org>
 <3251bb16-be46-f752-a6ff-a6c3181f49b2@huawei.com>
 <alf5a0HI-vkEGUEz@casper.infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c6a5cb57-5ee2-773e-4a58-9fcfa8f74349@huawei.com>
Date: Thu, 16 Jul 2026 16:52:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alf5a0HI-vkEGUEz@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/7/16 5:19, Matthew Wilcox wrote:
> On Wed, Jul 15, 2026 at 11:19:59AM +0800, Miaohe Lin wrote:
>>> Since we don't have a refcount on the folio, it can be freed at any
>>> time, and the hwpoison list head can be reused for literally anything.
>>
>> Sorry for late but could we hold hugetlb_lock here so hugetlb folio won't be freed
>> after we fetch the lock? We can recheck that the folio is still hugetlb and hwpoisoned
>> once we've got the hugetlb_lock.
> 
> Hm, but we still take the mf_mutex in is_raw_hwpoison_page_in_hugepage(),
> and we don't usually like to sleep in predicates like this.

hugetlb_lock is held when hugetlb_update_hwpoison() tries to modify the
raw_hwp_list. So maybe we could use hugetlb_lock in folio_clear_hugetlb_hwpoison()
and is_raw_hwpoison_page_in_hugepage() to fix the UAF? mf_mutex can then be removed
from is_raw_hwpoison_page_in_hugepage().

> 
> We could introduce a spinlock to protect the raw_hwp_page list.  Any
> objection to that?

No objection, just wonder whether hugetlb_lock can do the work.

Thanks.
.
