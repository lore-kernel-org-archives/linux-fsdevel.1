Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B43B5826;
	Tue, 26 May 2026 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779641; cv=none; b=XFD+pETJdbfAlMEvjQ2Xeij8r4gKiVwZEi0gp2PZ7Ntgw/lzZa3ZWYx6WtWhR6GqFhPHiYASuNLv7X/SuNwDMTaieuOJ4MoY87d8h2EFuCkCgBSDmjfTmTOxKpSELgkO7EVSafrJm/DJWZJ9jZBKTsQbGTUgcxGhm30oRyvStNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779641; c=relaxed/simple;
	bh=ObIkP57M4lIOY7lXGae9io5Tlfngtb8Bqes2/5/lRHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo6YDWxDk7Fdu/ebrgCsYrQVRuW1ZJ7U4/G7w1HamAH0zSMPsY15xEnwcxq2jz237yZuZt27yLPpBtVneP/qgDH8Tf/YHyjA7MrcB7bHTqTcrEZhtW0lUhWk1+vLzT2KVOvJW+uh1AYlSVG7aXlLK5+3axaggLZ93/0wR+MCEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OTW337En; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OTW337En"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=OsrxvTynmtU2f3TXx1zK/ZSLAbOC+Ly6ZdLq2+fEK+8=;
	b=OTW337EnCAtXlkpIeJ8xfNJpeemySjNDOND9jWwTXcCBuxr/g6Ff/rV/9k3z0K
	njjzwpOpMtUizhmxpY8P5DWkWz4SwEuk7+9yMl4xwLwjWNFFuWmeV3z+jURVk2GG
	oHTrYJd4XhKvqqBF5leXC+w/cf1coNNS575j8idzMZmyg=
Received: from [10.42.0.216] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnP2LNRxVql9VVDw--.30187S2;
	Tue, 26 May 2026 15:12:15 +0800 (CST)
Message-ID: <5f1a3e69-c090-42ac-913e-1e8ce2702e9a@163.com>
Date: Tue, 26 May 2026 15:12:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] mm/shmem: optimize file read with folio batching
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
 <20260520101538.58745-6-chizhiling@163.com>
 <1d8c7c24-b273-4826-9a9e-37fdb0767f2f@linux.alibaba.com>
 <1fd099de-97d9-4a54-a97f-062fbae1d88e@163.com>
 <6881f92c-972a-4b7a-b3c0-93a91ff38b88@linux.alibaba.com>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <6881f92c-972a-4b7a-b3c0-93a91ff38b88@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnP2LNRxVql9VVDw--.30187S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr47Kry7Gr13GrWkJw4fZrb_yoWrtFWUpr
	WrG3ZxKrWkWrW7Ar1Sqw1FvFn3t34xtF4rXa4fG3W7AFn0vFn3Kr15tw15uFWrAr4rGr10
	qr10krW7WF1jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRU5rcUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9w-kgmoVR88KPwAA3c

On 5/26/26 11:11 AM, Baolin Wang wrote:
> 
> 
> On 5/25/26 5:47 PM, Chi Zhiling wrote:
>> On 5/25/26 4:37 PM, Baolin Wang wrote:
>>>
>>>
>>> On 5/20/26 6:15 PM, Chi Zhiling wrote:
>>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>>
>>>> Optimize shmem file read by using filemap_get_folios_contig() to
>>>> batch fetch contiguous folios from the page cache, reducing the
>>>> overhead of repeated shmem_get_folio() calls.
>>>>
>>>> When the folio batch is exhausted, attempt to refill it with
>>>> filemap_get_folios_contig(). If no folios are found (hole or swapped
>>>> out pages), fall back to shmem_get_folio() to handle these cases
>>>> individually.
>>>>
>>>> Additionally:
>>>> - Defer folio_put() until the batch is exhausted or on exit
>>>> - Add folio_test_uptodate() check before copying to ensure data
>>>>    validity
>>>>
>>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>>> ---
>>>>   mm/shmem.c | 50 ++++++++++++++++++++++++++++++++++++--------------
>>>>   1 file changed, 36 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index 96ea5a4c0aff..e0eacc23cccd 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -3355,11 +3355,14 @@ static ssize_t shmem_file_read_iter(struct 
>>>> kiocb *iocb, struct iov_iter *to)
>>>>       struct file *file = iocb->ki_filp;
>>>>       struct inode *inode = file_inode(file);
>>>>       struct address_space *mapping = inode->i_mapping;
>>>> +    struct folio_batch fbatch;
>>>>       pgoff_t index;
>>>>       unsigned long offset;
>>>>       int error = 0;
>>>>       ssize_t retval = 0;
>>>> +    folio_batch_init(&fbatch);
>>>> +
>>>>       for (;;) {
>>>>           struct folio *folio = NULL;
>>>>           struct page *page = NULL;
>>>> @@ -3372,18 +3375,38 @@ static ssize_t shmem_file_read_iter(struct 
>>>> kiocb *iocb, struct iov_iter *to)
>>>>               break;
>>>>           index = iocb->ki_pos >> PAGE_SHIFT;
>>>> -        error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>>>> -        if (error) {
>>>> -            if (error == -EINVAL)
>>>> -                error = 0;
>>>> -            break;
>>>> +fetch:
>>>> +        folio = folio_batch_next(&fbatch);
>>>> +        if (!folio) {
>>>> +            pgoff_t start = index;
>>>> +            pgoff_t end = (iocb->ki_pos + to->count - 1) >> 
>>>> PAGE_SHIFT;
>>>> +
>>>> +            if (folio_batch_count(&fbatch)) {
>>>> +                for (int i = 0; i < folio_batch_count(&fbatch); i++)
>>>> +                    folio_put(fbatch.folios[i]);
>>>> +                folio_batch_reinit(&fbatch);
>>>> +            }
>>>> +
>>>> +            filemap_get_folios_contig(inode->i_mapping, &start, 
>>>> end, &fbatch);
>>>> +            if (folio_batch_count(&fbatch))
>>>> +                goto fetch;
>>>> +
>>>> +            error = shmem_get_folio(inode, index, 0, &folio, 
>>>> SGP_READ);
>>>> +            if (unlikely(error)) {
>>>> +                if (error == -EINVAL)
>>>> +                    error = 0;
>>>> +                break;
>>>> +            }
>>>> +            if (folio) {
>>>> +                folio_unlock(folio);
>>>> +                folio_batch_add(&fbatch, folio);
>>>> +                fbatch.i++;
>>>> +            }
>>>>           }
>>>> -        if (folio) {
>>>> -            folio_unlock(folio);
>>>> +        if (folio) {
>>>>               page = folio_file_page(folio, index);
>>>>               if (PageHWPoison(page)) {
>>>> -                folio_put(folio);
>>>>                   error = -EIO;
>>>>                   break;
>>>>               }
>>>
>>> I haven't tested it yet, but I'm sure this will break the 
>>> fallback_page_copy mode.
>>>
>>> You're fetching from the batch at folio granularity here, but in 
>>> fallback_page_copy mode, we still copy the data at page granularity.
>>
>> Yes, that's a bug, Sashika has already reported it. I’ll fix it in the 
>> next version.
> 
> Good.
> 
>> Sashika also reported another potential issue below, but I think that 
>> is a misunderstanding, because a folio fetched from the swap cache is 
>> already marked Uptodate before being added to the page cache. What do 
>> you think?
> 
> I'm not concerned about swap-in folios, since we already ensure the 
> folio is uptodate when swapping out.
> 
> What I'm worried about is that this change moves the 
> folio_test_uptodate() check outside of the folio lock, which could 
> introduce some race? Of course, with the original logic, the folio state 
> could also transition from !uptodate to uptodate after the folio
> is unlocked (I need more thought).
> 
> Another race condition that needs to be addressed is, when getting the 
> folio locklessly via filemap_get_folios_contig(), there could be a 
> concurrent race with swap-out (because you removed the folio->mapping 
> check under folio lock). This could result in reading zero data when it 
> shouldn't (the folio actually needs to be swapped in).

Sorry, I don't fully understand what you mean. It seems that swap-out 
does not clear the uptodate flag, and the folio cannot be freed during 
the read operation because its reference count is held. So a swapped-out 
folio should not be mistaken for a zero-filled folio. Right?


