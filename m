Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46932F4A05;
	Tue,  2 Jun 2026 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381131; cv=none; b=BuwjVSxmfiMY40AHm7BK39X+eokEQR8ciz4As0yVkLuWYiRfDG/Jp0bZjuwaqlhQ8/aw+d2SKmKPGO5ZWLkocXsVKIfumIo5DqscY5HX5ZTv8no5U4jJxo4olSbVLyzWmhPxsTSciAfJvAweReM6tkFyUXhEDfZ3hU2+5R7WprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381131; c=relaxed/simple;
	bh=uUcKjBTXt9dUiOINmH+SKi/SwXCQbQyEIqPWNVfk1ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJcrupnnCA7kYRy1Q/VSo8QgYvHhJNUKbmVwVeudMWnitQJxWG7deFW/NR+5xHoulXy72Pua7f2Ll+l9zu/Wbsv2hKEA85ywCXE/p4glrg3OO3ldcdFlH+0l/rHX92YfnMU6tSAbmsr1C7laWs5X9m/mpuE5IojNqc75XpPV+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nUL0AUC2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nUL0AUC2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=6w4mGCqzHENp4jk9gAMrbzBGsGOC3Xwp2PsWkL6dAbU=;
	b=nUL0AUC2+jQxRt/bvguX2SP9uUUfQzw6gpNHzKGGXGbVfkM/f+M4OUSAy6RBIG
	9ncdXe7dHndpRiLUHY7PPRmK5dzfO6U3UUgApeJTOvumOU4+TmFXLI+NFDgXMmUA
	NgP+u0w46AKgIDsZhbFX1ef7uWkMcTLJlOAC4IG/YgNss=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3nwKBdR5qZ6nqAw--.5050S2;
	Tue, 02 Jun 2026 14:17:37 +0800 (CST)
Message-ID: <59de56ad-585e-43da-a6c9-7107c6433bdd@163.com>
Date: Tue, 2 Jun 2026 14:17:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm/shmem: remove page-copy fallback in shmem read
 path
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-5-chizhiling@163.com>
 <06a4c4a0-fc3c-488e-9015-04f0532650f2@linux.alibaba.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <06a4c4a0-fc3c-488e-9015-04f0532650f2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nwKBdR5qZ6nqAw--.5050S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1xtw4kCw1xuw47ur4Durg_yoWrZr1Upr
	WfKanIyF48Jay7Cr13XF4DZryrt3s3JFW8JayfG3WfJ3ZFyF95KFWUt3409FW3A347A3WI
	gw4qkr9rua1Ut3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5kuxUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+AGfPWoedYHd1AAA3S

On 6/2/26 13:39, Baolin Wang wrote:
> 
> 
> On 6/1/26 1:57 PM, Chi Zhiling wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> This is perp patch for folio batch support which removing the fallback
>> to page-copy mode from shmem reads.
>>
>> The existing hwpoison fallback would require fetching the same folio
>> multiple times to read its each pages, which complicates the
>> batching model. Instead, move hwpoison handling into
>> copy_each_pages_to_iter(), allowing the error path to be centralized.
>>
>> This simplifies the shmem fast read path and avoids special-case
>> handling that conflicts with folio batching support.
>>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
>>   mm/shmem.c | 63 +++++++++++++++++++++++++++++-------------------------
>>   1 file changed, 34 insertions(+), 29 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index b08118fbd275..cac355685e49 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -3353,6 +3353,30 @@ static size_t copy_zero_to_iter(size_t bytes, 
>> struct iov_iter *i)
>>       return written;
>>   }
>> +static size_t copy_pages_to_iter(struct folio *folio, size_t offset,
>> +        size_t bytes, struct iov_iter *i, int *error)
>> +{
>> +    struct page *page;
>> +    unsigned long off, nr, ret, written = 0;
>> +
>> +    do {
>> +        page = folio_page(folio, offset >> PAGE_SHIFT);
>> +        if (PageHWPoison(page)) {
>> +            *error = -EIO;
>> +            break;
>> +        }
>> +
>> +        off = offset_in_page(offset);
>> +        nr = min(PAGE_SIZE - off, bytes - written);
>> +
>> +        ret = copy_page_to_iter(page, off, nr, i);
>> +        offset += ret;
>> +        written += ret;
>> +    } while (written < bytes && ret == nr);
>> +
>> +    return written;
>> +}
>> +
>>   static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct 
>> iov_iter *to)
>>   {
>>       struct file *file = iocb->ki_filp;
>> @@ -3365,10 +3389,8 @@ static ssize_t shmem_file_read_iter(struct 
>> kiocb *iocb, struct iov_iter *to)
>>       for (;;) {
>>           struct folio *folio = NULL;
>> -        struct page *page = NULL;
>>           unsigned long nr, ret;
>>           loff_t end_offset, i_size = i_size_read(inode);
>> -        bool fallback_page_copy = false;
>>           size_t fsize;
>>           if (unlikely(iocb->ki_pos >= i_size))
>> @@ -3376,25 +3398,13 @@ static ssize_t shmem_file_read_iter(struct 
>> kiocb *iocb, struct iov_iter *to)
>>           index = iocb->ki_pos >> PAGE_SHIFT;
>>           error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>> +        if (folio)
>> +            folio_unlock(folio);
>>           if (error) {
>>               if (error == -EINVAL)
>>                   error = 0;
>>               break;
>>           }
>> -        if (folio) {
>> -            folio_unlock(folio);
>> -
>> -            page = folio_file_page(folio, index);
>> -            if (PageHWPoison(page)) {
>> -                folio_put(folio);
>> -                error = -EIO;
>> -                break;
>> -            }
>> -
>> -            if (folio_test_large(folio) &&
>> -                folio_test_has_hwpoisoned(folio))
>> -                fallback_page_copy = true;
>> -        }
>>           /*
>>            * We must evaluate after, since reads (unlike writes)
>> @@ -3406,12 +3416,9 @@ static ssize_t shmem_file_read_iter(struct 
>> kiocb *iocb, struct iov_iter *to)
>>                   folio_put(folio);
>>               break;
>>           }
>> -        end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
>> -        if (folio && likely(!fallback_page_copy))
>> -            fsize = folio_size(folio);
>> -        else
>> -            fsize = PAGE_SIZE;
>> +        fsize = folio ? folio_size(folio) : PAGE_SIZE;
>>           offset = iocb->ki_pos & (fsize - 1);
>> +        end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
> 
> Do not add this unnecessary change.

Okay,

> 
>>           nr = min_t(loff_t, end_offset - iocb->ki_pos, fsize - offset);
>>           if (folio) {
>> @@ -3420,12 +3427,8 @@ static ssize_t shmem_file_read_iter(struct 
>> kiocb *iocb, struct iov_iter *to)
>>                * virtual addresses, take care about potential aliasing
>>                * before reading the page on the kernel side.
>>                */
>> -            if (mapping_writably_mapped(mapping)) {
>> -                if (likely(!fallback_page_copy))
>> -                    flush_dcache_folio(folio);
>> -                else
>> -                    flush_dcache_page(page);
>> -            }
>> +            if (mapping_writably_mapped(mapping))
>> +                flush_dcache_folio(folio);
> 
> I'm not sure this is safe for all architectures (it's safe for arm64 
> since no actual data cache flush happens here), but for architectures 
> that do perform an actual data cache flush, if the page has already been 
> hwpoisoned, flushing the cache could trigger a RAS error?
> 
> I think you should move this into copy_pages_to_iter() for hwpoisoned 
> folios.

Okay, will fix it, thanks!

