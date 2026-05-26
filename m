Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531353AB28E;
	Tue, 26 May 2026 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765114; cv=none; b=OdN9B06PtGVvkFwWGdRZIo0BYraUSoTIdlulEHxE4CiJLnw5XAlDhAhrHT3J08c+h8dvRUcQfAovjRd6kpNACTgnk6VLhH4qPQ3Qn9Pi69icy4HZAdqfowQOBCLjDaeuZ0DexyrOls1ciFlP0zwl6kjqiVOhgvphiwXp49Nf1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765114; c=relaxed/simple;
	bh=8u9iPCANh4ky3itDk6vuVI5SabKRQuw60+c3a8Crkbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJk2prPQ2r7w/NuikAiEaV1xlSy0Qlqq0bnBgRj/Rh9JPEi2ntgTkJhZtIAWHAXktG8BOhjfmX/RyGjN/lKdXBbuUDXnHifr2R2MZD34Vmi7GvbiJ38eX5zuzhgbZ3o6c+VV+FIy2FdbkwDAD+4UZkJRUPQN0hNe6XooOWrXGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vW5feQWS; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vW5feQWS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779765102; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=W7v33FftUcaSJVVadLdgHYBmh6TcIYmBJ6C9+IhpAVE=;
	b=vW5feQWSt5yxOfhU04FB1GfmyEYxXsa17xGRUPIcaK2oc7s1T+99QQaezcvIB2+qStmR7NepLA/guD4nEYUgmbZZmohG0dz/2HVLStL1id8jrwGaqMnP5ErlubQV4nl3z0Vehi2oXF7AlTAxtecEGEbcgUlYA4NEuc7Chamiq3A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X3eu4Cu_1779765099;
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X3eu4Cu_1779765099 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 11:11:40 +0800
Message-ID: <6881f92c-972a-4b7a-b3c0-93a91ff38b88@linux.alibaba.com>
Date: Tue, 26 May 2026 11:11:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] mm/shmem: optimize file read with folio batching
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
 <20260520101538.58745-6-chizhiling@163.com>
 <1d8c7c24-b273-4826-9a9e-37fdb0767f2f@linux.alibaba.com>
 <1fd099de-97d9-4a54-a97f-062fbae1d88e@163.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1fd099de-97d9-4a54-a97f-062fbae1d88e@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/25/26 5:47 PM, Chi Zhiling wrote:
> On 5/25/26 4:37 PM, Baolin Wang wrote:
>>
>>
>> On 5/20/26 6:15 PM, Chi Zhiling wrote:
>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>
>>> Optimize shmem file read by using filemap_get_folios_contig() to
>>> batch fetch contiguous folios from the page cache, reducing the
>>> overhead of repeated shmem_get_folio() calls.
>>>
>>> When the folio batch is exhausted, attempt to refill it with
>>> filemap_get_folios_contig(). If no folios are found (hole or swapped
>>> out pages), fall back to shmem_get_folio() to handle these cases
>>> individually.
>>>
>>> Additionally:
>>> - Defer folio_put() until the batch is exhausted or on exit
>>> - Add folio_test_uptodate() check before copying to ensure data
>>>    validity
>>>
>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>> ---
>>>   mm/shmem.c | 50 ++++++++++++++++++++++++++++++++++++--------------
>>>   1 file changed, 36 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 96ea5a4c0aff..e0eacc23cccd 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -3355,11 +3355,14 @@ static ssize_t shmem_file_read_iter(struct 
>>> kiocb *iocb, struct iov_iter *to)
>>>       struct file *file = iocb->ki_filp;
>>>       struct inode *inode = file_inode(file);
>>>       struct address_space *mapping = inode->i_mapping;
>>> +    struct folio_batch fbatch;
>>>       pgoff_t index;
>>>       unsigned long offset;
>>>       int error = 0;
>>>       ssize_t retval = 0;
>>> +    folio_batch_init(&fbatch);
>>> +
>>>       for (;;) {
>>>           struct folio *folio = NULL;
>>>           struct page *page = NULL;
>>> @@ -3372,18 +3375,38 @@ static ssize_t shmem_file_read_iter(struct 
>>> kiocb *iocb, struct iov_iter *to)
>>>               break;
>>>           index = iocb->ki_pos >> PAGE_SHIFT;
>>> -        error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>>> -        if (error) {
>>> -            if (error == -EINVAL)
>>> -                error = 0;
>>> -            break;
>>> +fetch:
>>> +        folio = folio_batch_next(&fbatch);
>>> +        if (!folio) {
>>> +            pgoff_t start = index;
>>> +            pgoff_t end = (iocb->ki_pos + to->count - 1) >> PAGE_SHIFT;
>>> +
>>> +            if (folio_batch_count(&fbatch)) {
>>> +                for (int i = 0; i < folio_batch_count(&fbatch); i++)
>>> +                    folio_put(fbatch.folios[i]);
>>> +                folio_batch_reinit(&fbatch);
>>> +            }
>>> +
>>> +            filemap_get_folios_contig(inode->i_mapping, &start, end, 
>>> &fbatch);
>>> +            if (folio_batch_count(&fbatch))
>>> +                goto fetch;
>>> +
>>> +            error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>>> +            if (unlikely(error)) {
>>> +                if (error == -EINVAL)
>>> +                    error = 0;
>>> +                break;
>>> +            }
>>> +            if (folio) {
>>> +                folio_unlock(folio);
>>> +                folio_batch_add(&fbatch, folio);
>>> +                fbatch.i++;
>>> +            }
>>>           }
>>> -        if (folio) {
>>> -            folio_unlock(folio);
>>> +        if (folio) {
>>>               page = folio_file_page(folio, index);
>>>               if (PageHWPoison(page)) {
>>> -                folio_put(folio);
>>>                   error = -EIO;
>>>                   break;
>>>               }
>>
>> I haven't tested it yet, but I'm sure this will break the 
>> fallback_page_copy mode.
>>
>> You're fetching from the batch at folio granularity here, but in 
>> fallback_page_copy mode, we still copy the data at page granularity.
> 
> Yes, that's a bug, Sashika has already reported it. I’ll fix it in the 
> next version.

Good.

> Sashika also reported another potential issue below, but I think that is 
> a misunderstanding, because a folio fetched from the swap cache is 
> already marked Uptodate before being added to the page cache. What do 
> you think?

I'm not concerned about swap-in folios, since we already ensure the 
folio is uptodate when swapping out.

What I'm worried about is that this change moves the 
folio_test_uptodate() check outside of the folio lock, which could 
introduce some race? Of course, with the original logic, the folio state 
could also transition from !uptodate to uptodate after the folio
is unlocked (I need more thought).

Another race condition that needs to be addressed is, when getting the 
folio locklessly via filemap_get_folios_contig(), there could be a 
concurrent race with swap-out (because you removed the folio->mapping 
check under folio lock). This could result in reading zero data when it 
shouldn't (the folio actually needs to be swapped in).
