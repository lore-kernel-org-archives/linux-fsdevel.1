Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55702F5328;
	Tue, 19 May 2026 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171996; cv=none; b=rjgZ/7L7Jxxw3vnL0srGGXuxdkeNimdjrVyCQKnyYkGzeGHP4O6MxP+Ca37RPBr2QWNDAIxfocE1uodYc7VvSPCZshUekfvn7CzGf/SZfz33dVMb2e1Y4aRdVA9J+wlrckM11PabAjaU+Ss/Hp46cSauieSwxMm6JxjckBJ9mw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171996; c=relaxed/simple;
	bh=lZPXLIPcAIqKE+o5eYSW3N1+o+4qjk6JzmN+T2oyu4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+eHq+UXe6vG+D2lLrOWAVaN2aPK9x34S5C2zS4bSsXnwjVwDhJ184GBkm9fgRuwtH1zFVgjXHkxrhSNIeja+3dSH1AFhiMq51Xpq0cGytk9fmbaX+BdSlqA5eX4aldN5bUqaoMXXHwVfLSyOUE7vnVChwUCG2Zpir01vqhQT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Bh0ee3r/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Bh0ee3r/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=gqu27ytF92MOWAvtsRZmJQ2pxo1YPz+1gTn7hEWTGH8=;
	b=Bh0ee3r/VQfg+Md6DyonduKKtT34/w+u3tVhfThIchxrnTBuLosNX6wCWGfJre
	p4jDQ/oP4PCX6P1bnVlH4yfE4zH+iDa+NoInyMttIN0xs9I6dvDguaqdnt+gHA+z
	g3e+l4BBdpLBbPSdaXJojjgVn1PRSvuWLqaZ64g/7HpaQ=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3n7kLAgxqBVn_CA--.32397S2;
	Tue, 19 May 2026 14:24:13 +0800 (CST)
Message-ID: <4744e5ec-f7ba-4107-8d2f-63bfe419632f@163.com>
Date: Tue, 19 May 2026 14:24:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm/shmem: use SGP_GET in read operations
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
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
 <e63962ad-55a9-4521-9f88-fd6be0c80434@linux.alibaba.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <e63962ad-55a9-4521-9f88-fd6be0c80434@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3n7kLAgxqBVn_CA--.32397S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFW8Ar4kuw1kZFyDKr1fCrg_yoW5KF48pr
	WrK3ZIkr4kJ34UAry2qw4rXF10934xtF18XasxJ34xu3Z0qFyftrWjq3W5uFy5CrZ7C3W0
	q3WUKrWfZw1YyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcqXQUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9w0hvmoMAg2ckQAA3B

On 5/19/26 11:06, Baolin Wang wrote:
> On 5/18/26 3:42 PM, Chi Zhiling wrote:
>> On 5/18/26 14:39, Baolin Wang wrote:
>>>
>>>
>>> On 5/15/26 5:47 PM, Chi Zhiling wrote:
>>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>>
>>>> Replace SGP_READ with SGP_GET in shmem_file_read_iter(),
>>>> shmem_file_splice_read(), and shmem_get_link(). These functions
>>>> immediately unlock the folio after getting it, making the lock
>>>> acquisition redundant.
>>>>
>>>> Even though folio_lock can protect folio data consistency or prevent
>>>> truncate while holding the lock, these can still happen after unlock.
>>>> Since these functions continue reading data after unlocking, the lock
>>>> does not provide effective protection. The folio reference count is
>>>> what actually prevents reclamation during access, making the lock
>>>> unnecessary.
>>>>
>>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>>> ---
>>>
>>> Thanks for your patch. It would be better to squash patch 1 and patch 
>>> 2 into a one commit, so that the usage of the newly introduced flag 
>>> can be easily seen.
>>
>> Hi, Baolin
>>
>> Thanks for your review. I will squash patches 1 and 2 in the next 
>> version, unless v2 is unnecessary :D
>>
>>>
>>>>   mm/shmem.c | 12 +++---------
>>>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index ef19968cc51c..767610f78d0d 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -3370,15 +3370,13 @@ static ssize_t shmem_file_read_iter(struct 
>>>> kiocb *iocb, struct iov_iter *to)
>>>>               break;
>>>>           index = iocb->ki_pos >> PAGE_SHIFT;
>>>> -        error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>>>> +        error = shmem_get_folio(inode, index, 0, &folio, SGP_GET);
>>>>           if (error) {
>>>>               if (error == -EINVAL)
>>>>                   error = 0;
>>>>               break;
>>>>           }
>>>>           if (folio) {
>>>> -            folio_unlock(folio);
>>>> -
>>>
>>> This is incorrect. Since a shmem folio can still be locked if it is 
>>> being swapped in from the swap device.
>>
>> I don't know how I missed that, that's truly a serious bug. Thanks for 
>> pointing that out.
>>
>>>
>>> Essentially, you need to show reviewers the benefit of introducing a 
>>> new flag. In what scenario would you see overhead from locking the 
>>> folio in shmem_get_folio()? And how much performance improvement does 
>>> your patch bring? Data is the easiest way to convince people:)
>>
>> Honestly, this may not bring significant performance improvements in 
>> single thread scenarios.
>>
>> I think the main benefit is that during concurrent reads and writes, 
>> especially when large folio is enabled, there are more chances that 
>> reads and writes occur in the same folio. Removing the folio lock can 
>> prevent read operations from being blocked by write operations.
>>
>> If necessary, I will include the test data in v2.
>>
>> A more important reason is that folio batches are not suitable for 
>> storing locked folios, as this could lead to some issues.
> 
> If this new flag is necessary, please add these explanations to the 
> commit message.
> 
> However, if there's no obvious performance improvement, I'd prefer not 
> to add an unnecessary flag. Also, looking at the implementation of 
> shmem_get_folio_from_batch() in patch 3, couldn't we unlock the folio 
> after shmem_get_folio()?

I have tested single-thread and multi-thread read and write. Only 
concurrent read and write shows some improvement, but dropping the lock 
is not the main target in this patch series, so I will remove the change 
in next version.

Thanks,

