Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF03C3BF1;
	Mon, 18 May 2026 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090295; cv=none; b=PE301msK3b8LtQdbjGTb/c504l3WW0bbagJFzVMMvEHuFWID0JaMYPyJWHQwrtOuyCJ7WcMFic5+QTaeuEXCZG3WGEahgaIMtfriwR+MXxwlBONX+whZ8PFDfWT6ov7x3GezcGqMgAB7XNX3UXm/KXy4iQKOaYZy5GOCz9IU3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090295; c=relaxed/simple;
	bh=3FI3uSBEPEpsmblNat0qNXjD0Wtu3If238RsRoXHwZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLqW9+RY5Tp2acAoCDqn/p69pGejYFjPfC6BJjhUGtDythqbjRPLFfqhqhhmSjZ9pc+FoIxU4tWfLRmvTho2uDvgTwpecQgeo3g0O1InwvTaaxeGv4C0Q+hzpA13S0jGiEGOUfmCJ8MNElUps229wzQ1y9OoUXfVbhAoy49FxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BS9VvLCu; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BS9VvLCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=CvxCUqPx5MzhsfmsS+WFjrFDeZc/GotbEpJ6mkFhxeE=;
	b=BS9VvLCuUcnGKQ8t9nen4Bp4R24JlIdnZFeIXsQMAEr496e2PjDKxufIBFvP01
	7aMi4GVVY4r2dYfl28Z2PMPjhDY7rSPaYbnWpWFMF0wD0YrljDFhdjdI141CQ3u5
	PUffXZXKvSpPGQBVgeAqhvWJ3ud+bDyYjsJaPo84Chhcc=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3P2_cwgpqtTEtCA--.6564S2;
	Mon, 18 May 2026 15:42:22 +0800 (CST)
Message-ID: <f5cfe918-8bf1-4494-80ea-32863df1d1df@163.com>
Date: Mon, 18 May 2026 15:42:20 +0800
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
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <c0a6e4ea-3ca5-4efc-af5e-b5abc968308b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P2_cwgpqtTEtCA--.6564S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw18tw18ArWDZFyftF1xGrg_yoW5XFyxpr
	W3KasIkr4kJ347Zry2vay8Za4093yxJFW8Ja43t34xZFn8XF1fKrWIg3Wrua45CrZ7A3W0
	q3W093y0v3WYyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcqXQUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9x4FomoKwt4pWgAA3B

On 5/18/26 14:39, Baolin Wang wrote:
> 
> 
> On 5/15/26 5:47 PM, Chi Zhiling wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> Replace SGP_READ with SGP_GET in shmem_file_read_iter(),
>> shmem_file_splice_read(), and shmem_get_link(). These functions
>> immediately unlock the folio after getting it, making the lock
>> acquisition redundant.
>>
>> Even though folio_lock can protect folio data consistency or prevent
>> truncate while holding the lock, these can still happen after unlock.
>> Since these functions continue reading data after unlocking, the lock
>> does not provide effective protection. The folio reference count is
>> what actually prevents reclamation during access, making the lock
>> unnecessary.
>>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
> 
> Thanks for your patch. It would be better to squash patch 1 and patch 2 
> into a one commit, so that the usage of the newly introduced flag can be 
> easily seen.

Hi, Baolin

Thanks for your review. I will squash patches 1 and 2 in the next 
version, unless v2 is unnecessary :D

> 
>>   mm/shmem.c | 12 +++---------
>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index ef19968cc51c..767610f78d0d 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -3370,15 +3370,13 @@ static ssize_t shmem_file_read_iter(struct 
>> kiocb *iocb, struct iov_iter *to)
>>               break;
>>           index = iocb->ki_pos >> PAGE_SHIFT;
>> -        error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>> +        error = shmem_get_folio(inode, index, 0, &folio, SGP_GET);
>>           if (error) {
>>               if (error == -EINVAL)
>>                   error = 0;
>>               break;
>>           }
>>           if (folio) {
>> -            folio_unlock(folio);
>> -
> 
> This is incorrect. Since a shmem folio can still be locked if it is 
> being swapped in from the swap device.

I don't know how I missed that, that's truly a serious bug. Thanks for 
pointing that out.

> 
> Essentially, you need to show reviewers the benefit of introducing a new 
> flag. In what scenario would you see overhead from locking the folio in 
> shmem_get_folio()? And how much performance improvement does your patch 
> bring? Data is the easiest way to convince people:)

Honestly, this may not bring significant performance improvements in 
single thread scenarios.

I think the main benefit is that during concurrent reads and writes, 
especially when large folio is enabled, there are more chances that 
reads and writes occur in the same folio. Removing the folio lock can 
prevent read operations from being blocked by write operations.

If necessary, I will include the test data in v2.

A more important reason is that folio batches are not suitable for 
storing locked folios, as this could lead to some issues.


Thanks,

