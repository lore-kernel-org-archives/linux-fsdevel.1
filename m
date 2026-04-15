Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA43AEF5F;
	Wed, 15 Apr 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260036; cv=none; b=JWZSu4jTvD/xMlVH0x/68TSnEBCg3z8idbzqfxtfkXE/iMlu+GxjmWbjLf+dFPFYRLvHo8F7SnbKzr9t8amOIcd9lLAGCu6JKGKgSl++/8ehPdii2Z89TWo3J3Hh7tmoV3bhbMk7O4Yr6GL+JiS9Bfde4sj9GOH+wTL4HYt8ASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260036; c=relaxed/simple;
	bh=yBi0Yrmhb10F8gr6z6MQ55nQsM0/cedOlYVD1Whnk4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gDgkwfmPOgr5VNEe8XMJHA+QePgvQT34EGKYFlHYS2HXta9okLgK9tfdV8rXvvBrYxGwLutwhNYoa+emal+khXr/JeVsuB71d8RhUAtNuVYjga52YMtYQ0EPIIdOsv+GWj02C+I4TR1aapDp5+T/ihHOeDeQdeZkyuX6h8ObKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fwhtP2rLzzHnGk5;
	Wed, 15 Apr 2026 21:33:33 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 81D204057A;
	Wed, 15 Apr 2026 21:33:49 +0800 (CST)
Received: from [10.123.123.226] (10.123.123.226) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 16:33:48 +0300
Message-ID: <972b8365-60cf-4f29-ac4d-05e6c50f573c@huawei.com>
Date: Wed, 15 Apr 2026 16:33:48 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Use high-order folios in mmap sync RA
To: Matthew Wilcox <willy@infradead.org>
CC: <akpm@linux-foundation.org>, <david@kernel.org>, <ljs@kernel.org>,
	<Liam.Howlett@oracle.com>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <artem.kuzin@huawei.com>,
	<gutierrez.asier@huawei-partners.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20260415192853.3470423-1-stepanov.anatoly@huawei.com>
 <ad-QQwctxvJVHW4U@casper.infradead.org>
Content-Language: en-US
From: Stepanov Anatoly <stepanov.anatoly@huawei.com>
In-Reply-To: <ad-QQwctxvJVHW4U@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 4/15/2026 4:18 PM, Matthew Wilcox wrote:
> On Thu, Apr 16, 2026 at 03:28:51AM +0800, Anatoly Stepanov wrote:
>> When "fault around" is enabled, 0-order folios might significantly
>> slowdown filemap_map_pages().
> 
> There's a lot of "might" in this patchset.  I'd like to know that there
> is a real workload that benefits from this, and if so by how much.
> 
Actually, no real workload at the moment.
The intention is to highlight the filemap_map_pages issue,
i found it during my experiments with the page cache.

> You raise an interesting point that faultaround may be slow, and maybe
> we should start out with 0 faultaround until we've determined (somehow)
> that faultaround would be beneficial for this particular mapping.  Like
> we adjust the readahead window.
> 
Sounds nice, 
looks like, there should be kind of "virtual readahead" or smth like this.

BTW, for the benchmark i posted, if fault_around is disabled (4K)
then the throughput is even higher.


>> For example when async RA won't be able to start,
>> we might end up with a large mmap'ed file with 0-orders.
> 
> That is a feature, not a bug.  If access is random, then we don't want
> to do any async readahead because we don't know where the next access
> will be.  We just end up occupying large chunks of memory with
> never-used data.
> 
> 
Yes, i understand the logic behind this, what i mean is that it can actually happen.


-- 
Anatoly Stepanov, Huawei
