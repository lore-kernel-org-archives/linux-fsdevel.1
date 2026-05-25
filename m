Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A13E16B4;
	Mon, 25 May 2026 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697000; cv=none; b=WE0iRDdx1OC9OuQfrloIoZ+S6YdovGE7hqEY6fX60WWg6qzBcn8ACT00vjEjZDHiMQYkEJTTyw2b9HNgD6EplNPcMJtjtcSK9jpBIeClbUYb+SG2+00mPXdJH3LN6ujI9oFHoFL7GgYmk9oQdjnO6AlUhGv7k1mLrlklB6kY7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697000; c=relaxed/simple;
	bh=DOHJCSZnyNciLCpzfoaIXVazO/NB/Tdq3+3Aa+zFmHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVmAgGSAWWKJK2b1chr1tBkthnXhjzie4+BcuxiPncsGoIE0KN8n5C/1u5ZETjk+8UyQUErracfXAOmIe/KqJkDfd9LJH9Ox0Xre9vHg623MjWqK2uNKhen8vhOM055x3nXkbbjYk4bxO/FjCrY1T3m9pcz8OBAnHpX66d7GJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ORW8XnXQ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ORW8XnXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=mZcOAXzhq3cI3XWIfG5s5cOD4qHUIgWC2naRLxKB3PY=;
	b=ORW8XnXQ78h6t1ovXEQmoqHsib1bGONWt9cvu5j3gV3DFlhSJf7GjpCuumaLuh
	Qv/5xuoPvDkljMvGXprfJdCiU9LtpP3DLFY5CjfrpDNrF4j5QhIjB3gqCwTNnnyH
	3VVyyVw80c59aOk8B22Q+rVCMfDK9ewnMv5A+hZp0wwhk=
Received: from [10.42.0.218] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBXh6_0BBRqVw7SDA--.11722S2;
	Mon, 25 May 2026 16:14:46 +0800 (CST)
Message-ID: <87efc5ef-9fef-4cfb-a129-bf8ca373683d@163.com>
Date: Mon, 25 May 2026 16:14:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] mm/shmem: make SGP_NOALLOC succeed on hole like
 SGP_READ
To: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20260520101538.58745-1-chizhiling@163.com>
 <20260520101538.58745-4-chizhiling@163.com>
 <772f7bcb-eb78-4439-b94b-1a096a01dc51@linux.alibaba.com>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <772f7bcb-eb78-4439-b94b-1a096a01dc51@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXh6_0BBRqVw7SDA--.11722S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1kuw18ZFWkWFWxKryrXrb_yoWruw43pF
	WxGas7KrZYgryUCFnrZws7ZF15Wws5KryUKFySq34YvFn0yF1vkr17Aw1j9F1rArW8Ca1F
	qF4qka9xua1DX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZNVgUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3Bbde2oUBPZJ-gAA3X

On 5/25/26 3:10 PM, Baolin Wang wrote:
> On 5/20/26 6:15 PM, Chi Zhiling wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> Change SGP_NOALLOC to return 0 with NULL folio on hole, matching
>> SGP_READ behavior. This simplifies the sgp_type handling by unifying
>> hole semantics across these types.
>>
>> Previously, SGP_NOALLOC returned -ENOENT on hole, while SGP_READ
>> returned 0. This inconsistency required special handling in callers
>> like khugepaged and userfaultfd.
> 
> This patch doesn't seem to be a performance optimization, and I'm not 
> convinced.

Hi, baolin

This is not an optimization patch, and it is not related to this patch 
series either.

> 
>> After this change:
>> - khugepaged: behavior unchanged (checks both error and NULL folio)
> 
> But this adds an extra check to khugepaged, and I'm not sure it's worth it.

You are right, I will drop this patch in v2.

> 
>> - userfaultfd: behavior unchanged (both -ENOENT and NULL are converted
>>    to -EFAULT before returning to userspace)
> 
> No, this will break userfaultfd, cause userfaultfd currently returns an 
> error code directly in this case (please update to the latest 
> codebase.). See:
> 
> static struct folio *shmem_get_folio_noalloc(struct inode *inode, 
> pgoff_t pgoff)
> {
>      struct folio *folio;
>      int err;
> 
>      err = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
>      if (err)
>          return ERR_PTR(err);
> 
>      return folio;
> }

The return value of shmem_get_folio_noalloc() will change, but it seems 
this does not affect the logic in mfill_atomic_pte_continue().

```
	folio = ops->get_folio_noalloc(inode, pgoff);
	/* Our caller expects us to return -EFAULT if we failed to find folio */
	if (IS_ERR_OR_NULL(folio))
		return -EFAULT;
```

No matter whether get_folio_noalloc() returns an error or NULL, the 
error code is converted to -EFAULT here, and mfill_atomic_pte_continue() 
is currently the only caller of get_folio_noalloc().

Did I miss something?


Thanks,

> 
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
>>   include/linux/shmem_fs.h | 2 +-
>>   mm/khugepaged.c          | 2 +-
>>   mm/shmem.c               | 9 +++------
>>   3 files changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
>> index 93a0ba872ebe..d461713c095b 100644
>> --- a/include/linux/shmem_fs.h
>> +++ b/include/linux/shmem_fs.h
>> @@ -165,7 +165,7 @@ extern unsigned long 
>> shmem_partial_swap_usage(struct address_space *mapping,
>>   /* Flag allocation requirements to shmem_get_folio */
>>   enum sgp_type {
>>       SGP_READ,    /* don't exceed i_size, don't allocate page */
>> -    SGP_NOALLOC,    /* similar, but fail on hole or use fallocated 
>> page */
>> +    SGP_NOALLOC,    /* like SGP_READ, but accept fallocated page */
>>       SGP_CACHE,    /* don't exceed i_size, may allocate page */
>>       SGP_WRITE,    /* may exceed i_size, may allocate !Uptodate page */
>>       SGP_FALLOC,    /* like SGP_WRITE, but make existing page 
>> Uptodate */
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index b8452dbdb043..3309d1c094df 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1950,7 +1950,7 @@ static enum scan_result collapse_file(struct 
>> mm_struct *mm, unsigned long addr,
>>                   xas_unlock_irq(&xas);
>>                   /* swap in or instantiate fallocated page */
>>                   if (shmem_get_folio(mapping->host, index, 0,
>> -                        &folio, SGP_NOALLOC)) {
>> +                        &folio, SGP_NOALLOC) || !folio) {
>>                       result = SCAN_FAIL;
>>                       goto xa_unlocked;
>>                   }
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 3b5dc21b323c..458853c506ea 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2524,14 +2524,11 @@ static int shmem_get_folio_gfp(struct inode 
>> *inode, pgoff_t index,
>>       }
>>       /*
>> -     * SGP_READ: succeed on hole, with NULL folio, letting caller zero.
>> -     * SGP_NOALLOC: fail on hole, with NULL folio, letting caller fail.
>> +     * SGP_READ/SGP_NOALLOC: succeed on hole, with NULL folio.
>>        */
>>       *foliop = NULL;
>> -    if (sgp == SGP_READ)
>> +    if (sgp <= SGP_NOALLOC)
>>           return 0;
>> -    if (sgp == SGP_NOALLOC)
>> -        return -ENOENT;
>>       /*
>>        * Fast cache lookup and swap lookup did not find it: allocate.
>> @@ -2657,7 +2654,7 @@ static int shmem_get_folio_gfp(struct inode 
>> *inode, pgoff_t index,
>>    *
>>    * When no folio is found, the behavior depends on @sgp:
>>    *  - for SGP_READ, *@foliop is %NULL and 0 is returned
>> - *  - for SGP_NOALLOC, *@foliop is %NULL and -ENOENT is returned
>> + *  - for SGP_NOALLOC, *@foliop is %NULL and 0 is returned
>>    *  - for all other flags a new folio is allocated, inserted into the
>>    *    page cache and returned locked in @foliop.
>>    *

