Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62753AB273;
	Mon, 25 May 2026 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698686; cv=none; b=goOrR7raBeCY77+6hPQmx27bFydSvKnMneGn3aNgEsTuNH6erf6uJT/WUpyGuJj5sOisexnLIm2WGMxPx5V+xHxPY61gBrV02/8bnhOjMDX6pt06+4BONfkRQiUfduTDSMWw8bGHQlTUggj4wiZNyxcS5Jns3L8I6JGQjL0X4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698686; c=relaxed/simple;
	bh=887bbBtUAj1/ZCusm1vH8WdhVZR+9kCRgBKFnVgIDTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVZSiph0YWAGkwwW1Xn6k4ZbZps/6TjW9lZxpJLytMR0apt/8qVvqXI0HGtby1hIhANKrRVczrB1Sk8TiYWDfnllygZuZ2KT63gmJCIZvVtrsof2cf+mARsiP0J1RiuHCl7qgBUoxaY0K5C9OHIIINmnqmaOKXVrtgjG+pO90/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=blMSx19k; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="blMSx19k"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779698675; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8PU4DCnB+MwemnNbQ7J/hgQBpqjXOqzi0eDu1txdPKk=;
	b=blMSx19k6erh91bt/vjUU4gCbtELoRaVXUe2hjvw/9WDxuaqX/+LH71+/Y+pfr2dK/aGPyz3vpCjcNFkidImt45ZTcJc5oXymsM+LJEJxSO50xAMjqt5bLO8vPUvBE2WoK6B4beBmZNWXkdQX8GoVT6mto0A6jSqFjIwd3b6g88=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X3WrO7q_1779698672;
Received: from 30.74.144.135(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X3WrO7q_1779698672 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 May 2026 16:44:33 +0800
Message-ID: <32556db2-c4b3-4e58-88cf-ec0d03ab8791@linux.alibaba.com>
Date: Mon, 25 May 2026 16:44:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] mm/shmem: make SGP_NOALLOC succeed on hole like
 SGP_READ
To: Chi Zhiling <chizhiling@163.com>, linux-mm@kvack.org,
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
 <87efc5ef-9fef-4cfb-a129-bf8ca373683d@163.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87efc5ef-9fef-4cfb-a129-bf8ca373683d@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/25/26 4:14 PM, Chi Zhiling wrote:
> On 5/25/26 3:10 PM, Baolin Wang wrote:
>> On 5/20/26 6:15 PM, Chi Zhiling wrote:
>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>
>>> Change SGP_NOALLOC to return 0 with NULL folio on hole, matching
>>> SGP_READ behavior. This simplifies the sgp_type handling by unifying
>>> hole semantics across these types.
>>>
>>> Previously, SGP_NOALLOC returned -ENOENT on hole, while SGP_READ
>>> returned 0. This inconsistency required special handling in callers
>>> like khugepaged and userfaultfd.
>>
>> This patch doesn't seem to be a performance optimization, and I'm not 
>> convinced.
> 
> Hi, baolin
> 
> This is not an optimization patch, and it is not related to this patch 
> series either.
> 
>>
>>> After this change:
>>> - khugepaged: behavior unchanged (checks both error and NULL folio)
>>
>> But this adds an extra check to khugepaged, and I'm not sure it's 
>> worth it.
> 
> You are right, I will drop this patch in v2.
> 
>>
>>> - userfaultfd: behavior unchanged (both -ENOENT and NULL are converted
>>>    to -EFAULT before returning to userspace)
>>
>> No, this will break userfaultfd, cause userfaultfd currently returns 
>> an error code directly in this case (please update to the latest 
>> codebase.). See:
>>
>> static struct folio *shmem_get_folio_noalloc(struct inode *inode, 
>> pgoff_t pgoff)
>> {
>>      struct folio *folio;
>>      int err;
>>
>>      err = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
>>      if (err)
>>          return ERR_PTR(err);
>>
>>      return folio;
>> }
> 
> The return value of shmem_get_folio_noalloc() will change, but it seems 
> this does not affect the logic in mfill_atomic_pte_continue().
> 
> ```
>      folio = ops->get_folio_noalloc(inode, pgoff);
>      /* Our caller expects us to return -EFAULT if we failed to find 
> folio */
>      if (IS_ERR_OR_NULL(folio))
>          return -EFAULT;
> ```
> 
> No matter whether get_folio_noalloc() returns an error or NULL, the 
> error code is converted to -EFAULT here, and mfill_atomic_pte_continue() 
> is currently the only caller of get_folio_noalloc().
> 
> Did I miss something?

OK.

But I still wonder if it's worth changing the definition of a flag, 
especially when there's no obvious bug here and this is merely a 
cleanup. Yet this cleanup requires adding an extra check for khugepaged, 
which makes me feel it is not worth it. Unless Hugh prefers to change 
the meaning of this flag:).
