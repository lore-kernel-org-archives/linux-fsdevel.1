Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871843;
	b=mntPzWzh+kPkAzBDxF9Q+Pj4Oem2fbDUzkrfQcWMd4OJQWFMFLRC/+zMkLQ4+/ASdf3/
	 2dSL/QZ1zV6wI3QkUji0dcblKfwNpmcHzShvOirAUp6FKOYvS+k83jDDf7BsjHf6xhv6k
	 PWhMgE29T4l4U7vw2UecP717r1L2XCtMS6F+ZR2rj188SoIKS5xYdVilE2HuLclYeVFVN
	 I8n0K+5OMl1obsCzzpdvig9f5+PVd6m/JZQLckVpIhv+w1r4/O5T5NsDU6j6RigpSiErN
	 iSTvxSkxexYDy0vW4DS1IgaH7tfGKouOb6NXbMoNdLIR8pn9oIS3qMz90bvu4rSz7Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871843;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=STorCUhXaoDz/2gFAzSUGoMuWNMkUjkM6y8lMs0dRfg=;
	b=5nnEwGtGofXT389faOZRv+8LH2VFvGlflLjxCD5pxdDZmNlkDJXJGmdt6Nuk0jqiyPwt
	 wWMUXoVFej2XMQpbFoAluRdGc8QjNNELe7yJbSTyT3qgLUXIJgjedWrz67yeJztRzAyLO
	 HTUCiFoaqHyiXQl2tAY0FJsjCTZiZEkdniBl9jJm5ESO6GWiMGu3HEhtkUwwF7Lr/d/hi
	 hDm8wUn9+ZWkqw69ECYgb5dLvDTJoIz0FNAD17JYSd0iWHkHOr7k1iGUxLMJhBoN666f0
	 SloSBNeUuq7a5QVt83Bbi/fqiWqjykeqSUM4/pANLyC/dacd7OmiBYfdNiGAQsD7wnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MyhOtMbx;
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79579606A328;
	Thu,  5 Nov 2026 09:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79579606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MyhOtMbx
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793871837; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=STorCUhXaoDz/2gFAzSUGoMuWNMkUjkM6y8lMs0dRfg=;
	b=MyhOtMbxWYaZ8sK24vNJTypC0chpbXTO2caNGZAT6AcWVtcq2UUuJylNbA7rumITLcYtKYn/3d+pPKcrzHlI3Qq8Tzatmh3ii6IcUQWT1rAkvArlkfH5bTMGcbuGj4/QjJv1jisQ5BOX/ChL+3aTUVGdCql2arlnyYT+a1AbQ+s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0XE8QPCN_1793871836;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XE8QPCN_1793871836 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 17:43:57 +0800
Message-ID: <c064d145-e085-4380-aa95-286a4bc396a8@linux.alibaba.com>
Date: Thu, 5 Nov 2026 17:43:55 +0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem: remove truncated folios from the page cache in
 batches
To: Jan Kara <jack@suse.cz>, Qiliang Yuan <odys.yuan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20261029-bug-mm-shmem-undo-batch-v1-1-59b34212fe78@gmail.com>
 <dru32b7k62tbur7kmk6vv52zd6jnglnzzz4pvhlsqez6smcjip@gjuh6fud4nir>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <dru32b7k62tbur7kmk6vv52zd6jnglnzzz4pvhlsqez6smcjip@gjuh6fud4nir>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/26 5:46 AM, Jan Kara wrote:
> On Thu 29-10-26 23:44:57, Qiliang Yuan wrote:
>> truncate_inode_pages_range() takes the folios it finds out of the page
>> cache with delete_from_page_cache_batch(), which takes the inode's
>> i_lock and the i_pages lock once for each batch of up to
>> FOLIO_BATCH_SIZE folios.
>>
>> shmem_undo_range() calls truncate_inode_folio() on each folio instead,
>> so filemap_remove_folio() takes and drops both locks once per folio.
>> Truncating, punching or freeing a tmpfs file or memfd made of small
>> folios, such as a large /dev/shm segment, pays for that on every page.
>>
>> Clean each folio up as truncate_inode_folio() does, collect the ones to
>> remove and take them out with delete_from_page_cache_batch(), which
>> needs truncate_cleanup_folio() outside mm/truncate.c. Swap entries, and
>> the folios kept when undoing a failed fallocate(), stay out of the
>> batch. Dropping an 8 GiB file of 4K folios, median of five runs,
>> averaged over two boots of each kernel, in a 32 vCPU VM:
>>
>>                          before    after
>>    ftruncate() to 0     1163 ms   913 ms
>>    hole punch           1155 ms   914 ms
>>    close() of a memfd   1161 ms   914 ms
>>    unlink()             1162 ms   916 ms
>>
>> Files of PMD-sized folios take 20-25 ms with or without this change.
>>
>> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
>> ---
>> To see it, fill and remove a large /dev/shm file:
>>
>>    fallocate -l 8G /dev/shm/f && time rm /dev/shm/f
> 
> Looks sensible. Just one nit below. Otherwise feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>> @@ -1352,6 +1352,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>>   	index = start;
>>   	while (index < end && find_lock_entries(mapping, &index, end - 1,
>>   			&fbatch, indices)) {
>> +		struct folio_batch remove;
>> +
>> +		folio_batch_init(&remove);
>>   		for (i = 0; i < folio_batch_count(&fbatch); i++) {
>>   			folio = fbatch.folios[i];
>>   
>> @@ -1363,9 +1366,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>>   				continue;
>>   			}
>>   
>> -			if (!unfalloc || !folio_test_uptodate(folio))
>> -				truncate_inode_folio(mapping, folio);
>> -			folio_unlock(folio);
>> +			if (!unfalloc || !folio_test_uptodate(folio)) {
>> +				truncate_cleanup_folio(folio);
>> +				folio_batch_add(&remove, folio);
>> +			}
>> +		}
>> +		delete_from_page_cache_batch(mapping, &remove);
>> +		for (i = 0; i < folio_batch_count(&fbatch); i++) {
>> +			folio = fbatch.folios[i];
>> +			if (!xa_is_value(folio))
> 
> You can move this loop after folio_batch_remove_exceptionals() and drop
> this condition.

+1. With this addressed,
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
