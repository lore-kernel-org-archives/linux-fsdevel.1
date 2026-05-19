Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980391A9FA4;
	Tue, 19 May 2026 02:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779157033; cv=none; b=VgbLiehUF08SD+KSdhECzWgHhT0OLv7EkEthlwRbxH9u7PCKpFagbnh8BynQd/IoWHLhNktN+kH/2c6BSUl6NfDfQP0Wzj9CIVLTHTAM5QxRiydkVsY7vtwR500kE5+0BDepEoM1sUeooetPpqVOoWMKQo8NKcc3qHmqbg7Zy+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779157033; c=relaxed/simple;
	bh=DOxEkdzyDBQcX01+Ouu/1Fa+LdEONAnF6aEZr085w9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WovfzpehC7X9homKafZuSRuCgp4oieFIZJO6c9YsCD5spZ626WGv7rNS52YBkXahK8Opm67oXGGWvHj3fiE0oY0Fw1SEDMWICMXJXECa2kN/cpGLED4Sdg+RJSEPxsbE+rwzpBuPeWjLgX+dM1XWNU0leeyDY6FjVFBbwzH8Uvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fcM7N7s8; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fcM7N7s8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=XzmmkuBgPaBy8YbpRGxxnVy0Umz5v/Lt5a9JHtQA5OA=;
	b=fcM7N7s8UfGBVtDcpTBEojPBNC8RWIFpW4MdLK1RWiQrD3zhu1xwHLt/EykxJe
	ceybWGo8J3os+fHc4WZhV4gYBr19oHvgeZToa8Z+RR3ZgN1ie6QAOpUiR3sbY+1u
	Rik0Moi7nrzg+D7jI25MzH+6KIgWIQ89Rj2fN+FUTHLq0=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCXFljCxwtqWi+UCA--.27518S2;
	Tue, 19 May 2026 10:15:32 +0800 (CST)
Message-ID: <402906ba-4080-45a6-88c0-4cb8f88e2fa6@163.com>
Date: Tue, 19 May 2026 10:15:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] mm/shmem: optimize file read with folio batching
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
 <20260515094702.1092355-4-chizhiling@163.com>
 <d1808e75-ccc2-486c-8844-4038e7b707c2@linux.alibaba.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <d1808e75-ccc2-486c-8844-4038e7b707c2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXFljCxwtqWi+UCA--.27518S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryrAF48AFyDWw47GF1ftFb_yoW8urW3pF
	Z5GanxGFWUJr17Crs3Xr48ZF1Yg34kXa1YyFWxG3W7AFn0vFnYkFyxKw15Gry5A34xZ3WI
	vF1jqr97WF1Dt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZJ5wUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+ASAHmoLx8T3bQAA3a

On 5/18/26 14:57, Baolin Wang wrote:
> 
> 
> On 5/15/26 5:47 PM, Chi Zhiling wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> Optimize shmem file read by implementing folio batching in the read
>> iteration path. Only uptodate folios are added to the batch, ensuring
>> all folios in the batch are valid and ready for use without additional
>> checking.
>>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
>>   mm/shmem.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 93 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 767610f78d0d..4bc4e463ca97 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -3348,16 +3348,100 @@ shmem_write_end(const struct kiocb *iocb, 
>> struct address_space *mapping,
>>       return copied;
>>   }
>> +static pgoff_t shmem_get_read_batch(struct address_space *mapping,
>> +        pgoff_t index, pgoff_t max, struct folio_batch *fbatch)
>> +{
>> +    XA_STATE(xas, &mapping->i_pages, index);
>> +    struct folio *folio;
>> +    pgoff_t end = max;
>> +
>> +    rcu_read_lock();
>> +    xas_for_each(&xas, folio, max) {
>> +        if (xas_retry(&xas, folio))
>> +            continue;
>> +        if (xa_is_value(folio)) {
>> +            end = xas.xa_index;
>> +            break;
>> +        }
>> +        if (!folio_try_get(folio))
>> +            goto retry;
>> +
>> +        if (unlikely(folio != xas_reload(&xas)))
>> +            goto put_folio;
>> +
>> +        end = folio_next_index(folio);
>> +
>> +        if (!folio_test_uptodate(folio)) {
>> +            xas_advance(&xas, end - 1);
>> +            folio_put(folio);
>> +            continue;
>> +        }
>> +        if (!folio_batch_add(fbatch, folio))
>> +            break;
>> +        xas_advance(&xas, end - 1);
>> +        continue;
>> +put_folio:
>> +        folio_put(folio);
>> +retry:
>> +        xas_reset(&xas);
>> +    }
>> +    rcu_read_unlock();
>> +
>> +    return end;
>> +}
> 
> I haven't looked at this patch in detail yet, but I feel this part 
> should belong in mm/filemap.c, or perhaps mm/filemap.c already has a 
> similar function implemented? Let's wait for Matthew's comments on this.

You are right. The existing filemap_get_folios_contig can handle this 
with clearer code, nice!


Thanks,

