Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD823E325;
	Mon, 25 May 2026 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702553; cv=none; b=QWYjxHmV9N6YhrRafG3Bnl3snWCV7oVxjsFDEjmyhaq23z6OHD0MOv6qCV/7oKXOWBWEuTrRrLAuz5y0vmvNaFqpB311Mo90GnbxOKc20yizHO43Rt3/nu0CInlV4WkQGvB9v1bl/mI9nsl78fPGCuITIBo4CKg+W9jLUHTFeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702553; c=relaxed/simple;
	bh=gCFj/1oAYWHhuyN9A9gmE+D9o/6dFiSWCmylEY4Ju3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gam5nZ/PMHpjGTJf0k2iAv8w6pa2Ro3OSo4p4z4vdmKnqMilgvsmnVggRmodmwYBEr8xy4kwTabYllJPkkiqSHMfSJ4nfKXpTk/xweMs2c47KkhvOQ6WATnsi51roJ4cS2JoCx6IdaDloWxcKkj0FBdOD31czGtgrJSJgvWHHmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ULNlomqK; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ULNlomqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=R6hlBJJtNF534RxCFHIXSbAD2k3XslcVc3B58swSDEM=;
	b=ULNlomqKN5q4kNrJHlZAG1fyjcwyRasTgaODhW+KfNMx/8bVSGLk6u3ywINmzc
	SQEJjstMiaD11VQDCgiJlL5AWI08AO+S1bUXBXn/V5e+S5ZwMsNpL0wsxircEqUr
	SNg6xUNQBcpEYWu9jmiy/N8VCWIpgqK9RnZ6rJPQfmPEI=
Received: from [10.42.0.218] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnHz6tGhRq4LleDA--.43041S2;
	Mon, 25 May 2026 17:47:27 +0800 (CST)
Message-ID: <1fd099de-97d9-4a54-a97f-062fbae1d88e@163.com>
Date: Mon, 25 May 2026 17:47:25 +0800
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
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <1d8c7c24-b273-4826-9a9e-37fdb0767f2f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnHz6tGhRq4LleDA--.43041S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw48JF4kXr18tFWrWFy7Awb_yoWrXF4kpF
	W3G3ZxKrWkGay7ur1Sqw48Zr1Sg3s3JF4rCayfG3W7A3Z8Za9Ykr1rKw15uFW5ArWrG3WI
	9r18Kry7u3WqyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uu6wZUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BBS72oUGrAMQgAA3P

On 5/25/26 4:37 PM, Baolin Wang wrote:
> 
> 
> On 5/20/26 6:15 PM, Chi Zhiling wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> Optimize shmem file read by using filemap_get_folios_contig() to
>> batch fetch contiguous folios from the page cache, reducing the
>> overhead of repeated shmem_get_folio() calls.
>>
>> When the folio batch is exhausted, attempt to refill it with
>> filemap_get_folios_contig(). If no folios are found (hole or swapped
>> out pages), fall back to shmem_get_folio() to handle these cases
>> individually.
>>
>> Additionally:
>> - Defer folio_put() until the batch is exhausted or on exit
>> - Add folio_test_uptodate() check before copying to ensure data
>>    validity
>>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
>>   mm/shmem.c | 50 ++++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 36 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 96ea5a4c0aff..e0eacc23cccd 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -3355,11 +3355,14 @@ static ssize_t shmem_file_read_iter(struct 
>> kiocb *iocb, struct iov_iter *to)
>>       struct file *file = iocb->ki_filp;
>>       struct inode *inode = file_inode(file);
>>       struct address_space *mapping = inode->i_mapping;
>> +    struct folio_batch fbatch;
>>       pgoff_t index;
>>       unsigned long offset;
>>       int error = 0;
>>       ssize_t retval = 0;
>> +    folio_batch_init(&fbatch);
>> +
>>       for (;;) {
>>           struct folio *folio = NULL;
>>           struct page *page = NULL;
>> @@ -3372,18 +3375,38 @@ static ssize_t shmem_file_read_iter(struct 
>> kiocb *iocb, struct iov_iter *to)
>>               break;
>>           index = iocb->ki_pos >> PAGE_SHIFT;
>> -        error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>> -        if (error) {
>> -            if (error == -EINVAL)
>> -                error = 0;
>> -            break;
>> +fetch:
>> +        folio = folio_batch_next(&fbatch);
>> +        if (!folio) {
>> +            pgoff_t start = index;
>> +            pgoff_t end = (iocb->ki_pos + to->count - 1) >> PAGE_SHIFT;
>> +
>> +            if (folio_batch_count(&fbatch)) {
>> +                for (int i = 0; i < folio_batch_count(&fbatch); i++)
>> +                    folio_put(fbatch.folios[i]);
>> +                folio_batch_reinit(&fbatch);
>> +            }
>> +
>> +            filemap_get_folios_contig(inode->i_mapping, &start, end, 
>> &fbatch);
>> +            if (folio_batch_count(&fbatch))
>> +                goto fetch;
>> +
>> +            error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>> +            if (unlikely(error)) {
>> +                if (error == -EINVAL)
>> +                    error = 0;
>> +                break;
>> +            }
>> +            if (folio) {
>> +                folio_unlock(folio);
>> +                folio_batch_add(&fbatch, folio);
>> +                fbatch.i++;
>> +            }
>>           }
>> -        if (folio) {
>> -            folio_unlock(folio);
>> +        if (folio) {
>>               page = folio_file_page(folio, index);
>>               if (PageHWPoison(page)) {
>> -                folio_put(folio);
>>                   error = -EIO;
>>                   break;
>>               }
> 
> I haven't tested it yet, but I'm sure this will break the 
> fallback_page_copy mode.
> 
> You're fetching from the batch at folio granularity here, but in 
> fallback_page_copy mode, we still copy the data at page granularity.

Yes, that's a bug, Sashika has already reported it. I’ll fix it in the 
next version.

Sashika also reported another potential issue below, but I think that is 
a misunderstanding, because a folio fetched from the swap cache is 
already marked Uptodate before being added to the page cache. What do 
you think?

~~~
Sashika:

Can this lockless check cause readers to receive spurious zeros instead
of the actual data?

Since filemap_get_folios_contig() fetches locklessly, a folio that is
currently being allocated and initialized, or swapped in by another
thread, might not yet be marked uptodate.

By checking folio_test_uptodate() without holding the folio lock, this falls
through to the zero-fill paths if the folio isn't uptodate yet. The original
code avoided this by using shmem_get_folio() which waits for the folio lock
and I/O completion.
~~~

link: 
https://sashiko.dev/#/patchset/20260520101538.58745-1-chizhiling@163.com

Thanks,


