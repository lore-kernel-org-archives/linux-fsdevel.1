Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6851234964;
	Wed, 15 Apr 2026 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257215; cv=none; b=YnhOuXSzPNkJsdXwkv0eDLD61YC0i/8rEICwnoW6f/rFTEK50q/R72AM2Zab0QeiIcvl5kweLPgTWNun5avcXGoooUp1V3dCFiFQSCb4bFPS2se9pT0s+olDMVR0d9k986VeUYvoRSwf0x7ssWVDHrHA/ZIuPOZdN6V/s+GV7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257215; c=relaxed/simple;
	bh=bugJN+vcyTQ9ryLR7P+3ke1MVgvIBFFn6dT1O5eAwe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RLA2WeoQ6RJAwYJ/PipF9kN2oJ91lZ2n9OmdCMM3SnSfAm/O56BhJHR6uXiv6/8IP721oYUlj5I2lBw5BAR1dqp5Tks2mjv0P/Hm1OMaDHPg2iXWyYp6EBxSiu0654wUG3hUAyWfWstKIAh5EHj54+PxeKLXbzOVDIUBYqN21Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fwgqh674lzJ46ZW;
	Wed, 15 Apr 2026 20:46:08 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id F008440569;
	Wed, 15 Apr 2026 20:46:51 +0800 (CST)
Received: from [10.123.123.226] (10.123.123.226) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 15:46:51 +0300
Message-ID: <54b4144e-57fb-446a-b28e-aac4390cb503@huawei.com>
Date: Wed, 15 Apr 2026 15:46:50 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] filemap: use high-order folios in filemap sync RA
To: Pedro Falcato <pfalcato@suse.de>
CC: <willy@infradead.org>, <akpm@linux-foundation.org>, <david@kernel.org>,
	<ljs@kernel.org>, <Liam.Howlett@oracle.com>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<wangkefeng.wang@huawei.com>, <yanquanmin1@huawei.com>, <zuoze1@huawei.com>,
	<artem.kuzin@huawei.com>, <gutierrez.asier@huawei-partners.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260415192853.3470423-1-stepanov.anatoly@huawei.com>
 <20260415192853.3470423-3-stepanov.anatoly@huawei.com>
 <3cr6ppe6bic47tan2iapuh67s67hiroangvdiap4jbn7ypru2o@rbvqv3sxifwp>
Content-Language: en-US
From: Stepanov Anatoly <stepanov.anatoly@huawei.com>
In-Reply-To: <3cr6ppe6bic47tan2iapuh67s67hiroangvdiap4jbn7ypru2o@rbvqv3sxifwp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 4/15/2026 3:06 PM, Pedro Falcato wrote:
> On Thu, Apr 16, 2026 at 03:28:53AM +0800, Anatoly Stepanov wrote:
>> [Idea]
>>
>> If a mmap'ed file being accessed such that async RA never
>> kicks in, we might end up with only 0-order folios in the page cache.
>>
>> if fault_around_bytes is larger than 1 single page, then
>> it's beneficial to use high-order folios, which brings significant
>> filemap_map_pages() speedup.
>> So, let's just use fault_around_bytes as a starting point here.
> 
> Well, this heuristic looks arbitrary. I don't like to mix different concepts.
> 
> With this, in practice most file folios will be 64K. Why? Why is it related
> to faultaround when faultaround is a separate mechanism that isn't particularly
> relevant here?
> 
>>
>> if an arch supports PTE-coalescing we can get more of those for free.
>> (see arm64 example below)
>>
>> We don't save the new order to "ra->order", so if async RA will happen
>> it would normally start from order-0.
>>
>> [Things to be discussed]
>>
>> But at the same time, i can see drawback for 16K, 64K pages, in this case fault_around will still be 64K by default.
>> In this case, it seems makes sense to make the fault_around_bytes be like order-N of PAGE_SIZE, not fixed bytes number.
>>
>> Another issue is - when fault_around=0, but we'd like to use high-order folios for sync_RA, for cont-PTE for example,
>> For this we can use kind of "max(fault_around_order, cont_pte_order)".
>>
>> Or introduce some dedicated tunable like "sync_mmap_order".
>>
>> [Benchmark]
>>
>> Simple benchmark below reading 100M file in 4M (RA size) chunks
>> such that async RA doesn't kick in and the page cache ends up being
>> filled up with 0-order folios.

> 
> Well, the problem is that you are _never_ getting RA to kick in. Folio
> size is the least of your concern, you are effectively not doing much
> readahead since the kernel thinks you're doing random accesses.
No, that's not true, "sync mmap readahead" actually works in the case
the problem  is that "async RA" doesn't kick in. 

>>
>> The patched kernel gives ~3 times increase in throughput,
>> considering the page cache is filled up at the moment.
>>
>> The main speedup comes from filemap_map_pages() due to high-order
>> folios usage.
>>
>> As a bonus, we get better cont_pte bit coverage for Arm64.
>>
>> Example:
>> // Open 100M file and read every 4M chunk, given max_ra=4M
>> // Perform 10 runs, measure the throughput.
>> ...
>>  char *map = mmap(NULL, filesize, PROT_READ, MAP_PRIVATE, fd, 0);
>>     if (map == MAP_FAILED) {
>>         perror("Error mapping file");
>>         close(fd);
>>         return 1;
>>     }
>>
>>     struct timespec start, end;
>>     clock_gettime(CLOCK_MONOTONIC, &start);
>>
>>     unsigned int size_4M = 4*1024*1024;
>>     unsigned int num_reads = filesize / size_4M;
>>     volatile char val;
>>     for (int i = 0; i < num_reads; i++) {
>>         off_t offset = (off_t)i * size_4M;
>>         val = map[offset];
>>     }
> 
> This doesn't seem like a real issue. And if it is, you can always issue
> readahead manually. But the whole pattern of "every perfectly-sized RA
> window, access 4 bytes and advance" is completely bizarre. And _if_ this
> is your workload, then having order-0 folios at the read site is much better
> than filling your page cache with data you are not accessing.
> 
> Do you have an actual use case for this? Where have you observed these
> problems?
> 


-- 
Anatoly Stepanov, Huawei
