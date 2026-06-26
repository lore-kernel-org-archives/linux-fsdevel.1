Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC07F3AC0EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464576; cv=none; b=pBB7UgA33XDhK1DYFiIhWMwiPqxQCJ1jraXn3ebCqav6RQ2+nTAL8oeuLVFSy9Ct3fDTFOQzhAeupnld337crghMg+JopCBKyT9EBACjGUQDjuWtvOgIYr6p1T704V+Fqw3J+DEsHe5NuTs03pzbyU9BF7aDoxj0s+GdHB70iw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464576; c=relaxed/simple;
	bh=0FmHvDLaa2RCl7vvyihcGV8T554t1KTf1jeCpH+Yfxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kqps2zGmI91wx2xx/EWok3oo2ivmzmRC8YGuplA8j2x1+DaXTmk8uodALo9vX3k7n4OIQp8neb903kt51g4f7iwleIQnVJBcqlHpLNWE2VgvbiPGafAIx/HiZty2J8iaFgzF+w4yi9RBVLdC2577fGoxKt+8IAZaCz+PYtzF38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xOsqfN68; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xOsqfN68"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0FmHvDLaa2RCl7vvyihcGV8T554t1KTf1jeCpH+Yfxw=;
	b=xOsqfN68PenTtQ5tfYxVbyUkbtXrG4r+WiWVkMVN6P24VTF9p6GNP61DCw8inQiHcqjn8Tnvc
	Mr5pyO92rr8kuPhh9C1oX9Yq+HIYxynVRiFWW0L/ClBdXOLDuCxw4sOtjR5vwkXFVWGVTJFrhdW
	XWHhnkeY6vISQ7fy7IiysI0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gmqG76YmTzLlYp;
	Fri, 26 Jun 2026 16:53:35 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C27540573;
	Fri, 26 Jun 2026 17:02:42 +0800 (CST)
Received: from [10.174.178.9] (10.174.178.9) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Jun
 2026 17:02:41 +0800
Message-ID: <6dfe38f0-0df3-429d-ba26-66bb3f94965c@huawei.com>
Date: Fri, 26 Jun 2026 17:02:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/proc: fix KPF_KSM reported for all anonymous pages
To: "David Hildenbrand (Arm)" <david@kernel.org>, <akpm@linux-foundation.org>,
	<ziy@nvidia.com>, <luizcap@redhat.com>, <willy@infradead.org>,
	<linmiaohe@huawei.com>, <svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20260626013252.2846774-1-tujinjiang@huawei.com>
 <a63b7138-617f-46de-96f9-e56528aee3aa@kernel.org>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <a63b7138-617f-46de-96f9-e56528aee3aa@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500001.china.huawei.com (7.202.194.229)


在 2026/6/26 16:13, David Hildenbrand (Arm) 写道:
> On 6/26/26 03:32, Jinjiang Tu wrote:
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
>> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
>> ---
> With spelling fix
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks.

> And I'd appreciate if someone could look into cleaning up the code to switch
> back to folio helpers now that we have folio+page snapshots.

I would like to do it.

>
