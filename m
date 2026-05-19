Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14D4502A;
	Tue, 19 May 2026 03:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779159980; cv=none; b=AC5RmtgfO+X3WHVxf7pprCTNNZSlt0nfbS3GLE1/Lyfh5i4CJ7n1zJMej1FHrjclFZFLjR+sAnmm264UkL+mGvSpDv3ZsFLfM2TtYR2pi4JIZZxj7Csyzvzf/McbevWgrDe77DLVutkCvaitHOHqfFKDYSLq/oYUEGWUJU4v2Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779159980; c=relaxed/simple;
	bh=p5Rsswt77JlEPlQJA5zggMOZ/1SV8tQQEZ0FvlqfCCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktk3vc7P4TDfDp45szvgHMZobCN4DkN48exRqkwd0GC3CJrN9Ox/7/a5bTXLZvHzvS8bOPnIB4G2/3lVnL7ia7LWizBlr6GpF0cd6Gj/NuWhmqq0z5G/wujcKYgqL8i+ODW8BfPzLkM4TDu4mUS6cbbwkrPsOVNaFy9gRO6spy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cTJSLSdv; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cTJSLSdv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779159969; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2ks+qUZy85ASQha921hZs00t//cX4J3vYp69MZtes08=;
	b=cTJSLSdvvk4IkUIrJyOaxsz0E7F9ffuxje+n3qzzdclBUNFAbh6/D0F64xfk9m2TRq2kaBczKnucjA/v/3eJIP2ZeZfiPFPr6jGzdIonokdvoeVrRQUd1XuOPD3M0HPN0GZBmzyM1DtsNsSr3uPHwGkE+oqvx7exSHouYgz+m88=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X3E4Pw5_1779159967;
Received: from 30.74.112.128(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X3E4Pw5_1779159967 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 11:06:07 +0800
Message-ID: <e63962ad-55a9-4521-9f88-fd6be0c80434@linux.alibaba.com>
Date: Tue, 19 May 2026 11:06:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm/shmem: use SGP_GET in read operations
To: Chi Zhiling <chizhiling@163.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260515094702.1092355-1-chizhiling@163.com>
 <20260515094702.1092355-3-chizhiling@163.com>
 <c0a6e4ea-3ca5-4efc-af5e-b5abc968308b@linux.alibaba.com>
 <f5cfe918-8bf1-4494-80ea-32863df1d1df@163.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <f5cfe918-8bf1-4494-80ea-32863df1d1df@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/18/26 3:42 PM, Chi Zhiling wrote:
> On 5/18/26 14:39, Baolin Wang wrote:
>>
>>
>> On 5/15/26 5:47 PM, Chi Zhiling wrote:
>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>
>>> Replace SGP_READ with SGP_GET in shmem_file_read_iter(),
>>> shmem_file_splice_read(), and shmem_get_link(). These functions
>>> immediately unlock the folio after getting it, making the lock
>>> acquisition redundant.
>>>
>>> Even though folio_lock can protect folio data consistency or prevent
>>> truncate while holding the lock, these can still happen after unlock.
>>> Since these functions continue reading data after unlocking, the lock
>>> does not provide effective protection. The folio reference count is
>>> what actually prevents reclamation during access, making the lock
>>> unnecessary.
>>>
>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>> ---
>>
>> Thanks for your patch. It would be better to squash patch 1 and patch 
>> 2 into a one commit, so that the usage of the newly introduced flag 
>> can be easily seen.
> 
> Hi, Baolin
> 
> Thanks for your review. I will squash patches 1 and 2 in the next 
> version, unless v2 is unnecessary :D
> 
>>
>>>   mm/shmem.c | 12 +++---------
>>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index ef19968cc51c..767610f78d0d 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -3370,15 +3370,13 @@ static ssize_t shmem_file_read_iter(struct 
>>> kiocb *iocb, struct iov_iter *to)
>>>               break;
>>>           index = iocb->ki_pos >> PAGE_SHIFT;
>>> -        error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>>> +        error = shmem_get_folio(inode, index, 0, &folio, SGP_GET);
>>>           if (error) {
>>>               if (error == -EINVAL)
>>>                   error = 0;
>>>               break;
>>>           }
>>>           if (folio) {
>>> -            folio_unlock(folio);
>>> -
>>
>> This is incorrect. Since a shmem folio can still be locked if it is 
>> being swapped in from the swap device.
> 
> I don't know how I missed that, that's truly a serious bug. Thanks for 
> pointing that out.
> 
>>
>> Essentially, you need to show reviewers the benefit of introducing a 
>> new flag. In what scenario would you see overhead from locking the 
>> folio in shmem_get_folio()? And how much performance improvement does 
>> your patch bring? Data is the easiest way to convince people:)
> 
> Honestly, this may not bring significant performance improvements in 
> single thread scenarios.
> 
> I think the main benefit is that during concurrent reads and writes, 
> especially when large folio is enabled, there are more chances that 
> reads and writes occur in the same folio. Removing the folio lock can 
> prevent read operations from being blocked by write operations.
> 
> If necessary, I will include the test data in v2.
> 
> A more important reason is that folio batches are not suitable for 
> storing locked folios, as this could lead to some issues.

If this new flag is necessary, please add these explanations to the 
commit message.

However, if there's no obvious performance improvement, I'd prefer not 
to add an unnecessary flag. Also, looking at the implementation of 
shmem_get_folio_from_batch() in patch 3, couldn't we unlock the folio 
after shmem_get_folio()?
