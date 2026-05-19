Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A874502A;
	Tue, 19 May 2026 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779160005; cv=none; b=TJv8+Q2iAGLLxY2heR8Fb4GEUL4YOyPHQykdmoxeQ6pQi+fKXciCBFF8Qe3Io3rW1lBIt/G8uZvp8CfjU1ZBLDPAqMx4dazeKj5Yc58yFh5xCKH2KZDotCfcAlHI7cbwM1SeECnRMdmEo8Vm96ns326mJ/tD1Jbfn7Ggxmk+JS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779160005; c=relaxed/simple;
	bh=eIhmUnNwKy6HvW+m0XchQwOsQOAlr/HTOA+UFnNoeDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axmVAV0mfl9NCUTLNzShBkVeEf8LHskbr85wFcfDHB8Dn6oF104fCKqgUSoFPFTDWv7m3eFyhTj0DomdV7fFHRgFgZqVBCN1bGXaz09br9aGmaMR/bl72na56bk+DjJiDsS2K+J47T3rzE7tI2tJHHDz+EnTCOCpK8DjMByMajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gHckrrI3; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gHckrrI3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779159995; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nQvrIQXtNeMkklqeqloILPseAkEANFqz6VFL0VVNri0=;
	b=gHckrrI3P5LA614uu37+IiIz2sm4gwU/S0PB5VfiVrqJ66OeqWjXObH4ffwVGfWTsKi3LsAKcwee6q4vHIBmuchQzpZbIhRJVfQkchEUCmncsGLhaRJkf5pfmm7v0I1+0A3HjfPNLbhPbMJp582+ujFUZCijuOB1CkMGH85cQQQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X3E892L_1779159993;
Received: from 30.74.112.128(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X3E892L_1779159993 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 11:06:33 +0800
Message-ID: <7db5253f-7cb7-45a7-91b6-8869ab9beb34@linux.alibaba.com>
Date: Tue, 19 May 2026 11:06:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] mm/shmem: optimize file read with folio batching
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
 <20260515094702.1092355-4-chizhiling@163.com>
 <d1808e75-ccc2-486c-8844-4038e7b707c2@linux.alibaba.com>
 <402906ba-4080-45a6-88c0-4cb8f88e2fa6@163.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <402906ba-4080-45a6-88c0-4cb8f88e2fa6@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/19/26 10:15 AM, Chi Zhiling wrote:
> On 5/18/26 14:57, Baolin Wang wrote:
>>
>>
>> On 5/15/26 5:47 PM, Chi Zhiling wrote:
>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>
>>> Optimize shmem file read by implementing folio batching in the read
>>> iteration path. Only uptodate folios are added to the batch, ensuring
>>> all folios in the batch are valid and ready for use without additional
>>> checking.
>>>
>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>> ---
>>>   mm/shmem.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 93 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 767610f78d0d..4bc4e463ca97 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -3348,16 +3348,100 @@ shmem_write_end(const struct kiocb *iocb, 
>>> struct address_space *mapping,
>>>       return copied;
>>>   }
>>> +static pgoff_t shmem_get_read_batch(struct address_space *mapping,
>>> +        pgoff_t index, pgoff_t max, struct folio_batch *fbatch)
>>> +{
>>> +    XA_STATE(xas, &mapping->i_pages, index);
>>> +    struct folio *folio;
>>> +    pgoff_t end = max;
>>> +
>>> +    rcu_read_lock();
>>> +    xas_for_each(&xas, folio, max) {
>>> +        if (xas_retry(&xas, folio))
>>> +            continue;
>>> +        if (xa_is_value(folio)) {
>>> +            end = xas.xa_index;
>>> +            break;
>>> +        }
>>> +        if (!folio_try_get(folio))
>>> +            goto retry;
>>> +
>>> +        if (unlikely(folio != xas_reload(&xas)))
>>> +            goto put_folio;
>>> +
>>> +        end = folio_next_index(folio);
>>> +
>>> +        if (!folio_test_uptodate(folio)) {
>>> +            xas_advance(&xas, end - 1);
>>> +            folio_put(folio);
>>> +            continue;
>>> +        }
>>> +        if (!folio_batch_add(fbatch, folio))
>>> +            break;
>>> +        xas_advance(&xas, end - 1);
>>> +        continue;
>>> +put_folio:
>>> +        folio_put(folio);
>>> +retry:
>>> +        xas_reset(&xas);
>>> +    }
>>> +    rcu_read_unlock();
>>> +
>>> +    return end;
>>> +}
>>
>> I haven't looked at this patch in detail yet, but I feel this part 
>> should belong in mm/filemap.c, or perhaps mm/filemap.c already has a 
>> similar function implemented? Let's wait for Matthew's comments on this.
> 
> You are right. The existing filemap_get_folios_contig can handle this 
> with clearer code, nice!

Good.
