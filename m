Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871720;
	b=KB58IzZWR/v561mRohTddKLBgllY93wf8cMy9k/ugAWV7GK9RMrPCpPFyKpAJdOMB7li
	 f300yJwGP8l9fhvsGYOXMKXCaf6t/oA9GuoJ2bRMvFQMH12xu/P9XDvSNBN0GcxucOv8N
	 1pWKRThp6MuuVt7qI4/FyMGqUAvqKDUIMBv8nIDCyK3b0aa/Wn/ZVHXG1RK6+uZrfNtZX
	 tyUdMIodrDpCRXbgtbarSuusmFXjbbyskcUKYF7pXkXwbTEmcaVC0HKE17MAT7ltlon8M
	 M9KvU61ACkod7pWi1yNEKzMY4WAnuT6AHj73KusWAJOJMuVT1CrdNY7ZAhpfiWkaAqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871720;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=PuufadtnrE0xPdkd4gRyzuQkUWzXAX5d0S4WuZODUDg=;
	b=lgfGrTmhJLmbEC3q5qp/Yuyts5u9WSfie0DqPBPnotzKwPKcihL/gi3RBLiNhdHDNogF
	 OiTnt7dP1OuIRpI9PuRVM1MUxgkJOhaG7JkdOirweG8oRcFDNX1ZKvjtiFP4aAAUOuYbc
	 vWZN0tJqUJJDqBD6o/7jGwjN2G1aEboASfuNIAifMBWV4BGIJRWWPL9vBRgnZjXzGMNb5
	 pLZvJ4dqN6XnTKijVwsDIJbDANQKrMOgEINLFh/IhOx8QpfmeQsxFJXMBL0xC0KDfye5a
	 98Vm6bTl4IIrABPoO311OGL9kv8OYnmU07i0wGyEKU8CQnU7tfutKlUtDW8TSGPdHfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7DFiWlP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E21606A328;
	Thu,  5 Nov 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7DFiWlP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039801F00919;
	Thu,  5 Nov 2026 09:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871720;
	bh=PuufadtnrE0xPdkd4gRyzuQkUWzXAX5d0S4WuZODUDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E7DFiWlPXN+jU3UEAtnhc15nZ+zLEwXM61RKCdGBvxvuJ0zqYZfnE0qrzWTr1klqX
	 jFmVvTMJV7STZZpP9mCGdXuhG+WtnAsEq/WJaZ3z6xGC05yOYvRmWLYoMEDBfY0J8n
	 b1vxaNRoV9fAHLglExUTkjXKA6EcpstFU+zUCZk2QcYjAPHy9rRdDOTMuraP3xDiK3
	 2ea8yEPPjAJ2jQEu/VSzJICu1Yd9xc07F2P4XhwxSiqlSnOHmJrhq3jFlaQQPkvUdD
	 EGUpaIPE6FTx5ZuynzsW+0PRFaUzeAJZG1Cc+G2ZgDt9/nu4g3GtkzznhB3xlW5SWq
	 3CHDn2w30Jdwg==
Message-ID: <a29912a1-ccf5-4b3e-84dd-367de4849032@kernel.org>
Date: Thu, 5 Nov 2026 10:41:53 +0100
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
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20261029-bug-mm-shmem-undo-batch-v1-1-59b34212fe78@gmail.com>
 <dru32b7k62tbur7kmk6vv52zd6jnglnzzz4pvhlsqez6smcjip@gjuh6fud4nir>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <dru32b7k62tbur7kmk6vv52zd6jnglnzzz4pvhlsqez6smcjip@gjuh6fud4nir>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 22:46, Jan Kara wrote:
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
>>                         before    after
>>   ftruncate() to 0     1163 ms   913 ms
>>   hole punch           1155 ms   914 ms
>>   close() of a memfd   1161 ms   914 ms
>>   unlink()             1162 ms   916 ms
>>
>> Files of PMD-sized folios take 20-25 ms with or without this change.
>>
>> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
>> ---
>> To see it, fill and remove a large /dev/shm file:
>>
>>   fallocate -l 8G /dev/shm/f && time rm /dev/shm/f
> 
> Looks sensible. Just one nit below. Otherwise feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>> @@ -1352,6 +1352,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>>  	index = start;
>>  	while (index < end && find_lock_entries(mapping, &index, end - 1,
>>  			&fbatch, indices)) {
>> +		struct folio_batch remove;
>> +
>> +		folio_batch_init(&remove);
>>  		for (i = 0; i < folio_batch_count(&fbatch); i++) {
>>  			folio = fbatch.folios[i];
>>  
>> @@ -1363,9 +1366,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>>  				continue;
>>  			}
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
> 

@Quiliang, can you resend with that?

-- 
Cheers,

David
