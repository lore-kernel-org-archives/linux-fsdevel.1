Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476913;
	b=F/Ja3CCWezNXjuIjsE0szv2eR4pGRcgU16dLgnNFKXWJVgZpWEyc1EPctsyfW0qVul7j
	 UVYhaqzH3TAcubUwFPCtDl+sm86u2KJB3y3xNkPoRUwLDyQr52M/1fofAUVcsaNFzdGzm
	 3b6xfWjsGttWV5iUPkcRwJ8CEjNl2h/lLme8Tk5r8gbzz0MOkMAnBd81CGffkbZvhd4D7
	 Yaz0qB6VNBSG5ksrKrxGVNzmpPmwGMx9dqjQriikC3IMbVdtV0W6QPu62+D+OD+bV0ZcH
	 iDkd92cJ3PTj9MQtjnjU+cQwXifEyE3ZuOy6bCXtztsGmzxsnYp2zbLaqB9P+Q3Q6WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476913;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gwA8u9VJ9m6gnHnzfW8zxz5hofEESJUkeHdy358lFOg=;
	b=HW+71fEpjMl54i9/PjuzOmsRVQcTaUxIudP/G+0NuNvfbnE6CCNsmMHJijbQbn1uculs
	 pE07yiQlGh0ATsRSADDbQ/1WvPupyOD5c0HmEzIgFeHbUvxvNqXfGEGPBnFAsjt/8eJ3c
	 kqJSqxHxkZQ0fGC13Jkuu2LtRyTuy9RzCm1oofq9Kf9lF/YkL0EGOeaZ7waWe0hlmwwsS
	 UgPh3qsRM+kwgfH6DcRzlcsDoPJLdCStcIlmaiUSkSYG7kyA720lY6hz3UhulRBEPt2Hb
	 ez4iEHFc1BLN54Pwk9wm4GONAWA3Ayxcke+rNJ3QgKDAljn0IKAiBeX98yW7AoMDw0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="O+LJ/p6u";
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C08606A31C;
	Thu, 12 Nov 2026 09:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C08606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O+LJ/p6u
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794476903; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gwA8u9VJ9m6gnHnzfW8zxz5hofEESJUkeHdy358lFOg=;
	b=O+LJ/p6unoiczwOurYE1h69jPza1sB1K4uQ16LK8SdTnL9KntQwk3w0mfDLYvjaues8f4RCxYph4GbWHFJrUOHatFnwkheeU1ebrWk/TBYTY9fDMLo9NGe3U7k/SG+0ENbMqj2VJd1WRiIom3Wk7M1I+ztfnTvl9NgDJdRM1xDI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0XEbbDux_1794476902;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEbbDux_1794476902 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 17:48:22 +0800
Message-ID: <bd25f767-1f74-4721-9264-92f3031d9109@linux.alibaba.com>
Date: Thu, 12 Nov 2026 17:48:21 +0800
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
Subject: Re: [PATCH v3] mm/shmem: remove truncated folios from the page cache
 in batches
To: Qiliang Yuan <qiliang.yuan@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20261112-bug-mm-shmem-undo-batch-v3-1-212db8c24058@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261112-bug-mm-shmem-undo-batch-v3-1-212db8c24058@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/26 5:05 PM, Qiliang Yuan wrote:
> truncate_inode_pages_range() takes the folios it finds out of the page
> cache with delete_from_page_cache_batch(), which takes the inode's
> i_lock and the i_pages lock once for each batch of up to
> FOLIO_BATCH_SIZE folios.
> 
> shmem_undo_range() calls truncate_inode_folio() on each folio instead,
> so filemap_remove_folio() takes and drops both locks once per folio.
> Truncating, punching or freeing a tmpfs file or memfd made of small
> folios, such as a large /dev/shm segment, pays for that on every page.
> 
> Clean each folio up as truncate_inode_folio() does and, once the swap
> entries are gone, pass the batch to delete_from_page_cache_batch(),
> which needs truncate_cleanup_folio() outside mm/truncate.c. Undoing a
> failed fallocate() only removes the folios that are not uptodate, so
> keep removing those one at a time.
> 
> Dropping an 8 GiB file of 4K folios in a 32 vCPU VM takes (median of
> five runs, averaged over two boots of each kernel):
> 
>    operation           before (ms)  after (ms)  change
>    ftruncate() to 0           1144         901    -21%
>    hole punch                 1148         906    -21%
>    close() of a memfd         1139         912    -20%
>    unlink()                   1142         914    -20%
> 
> Files of PMD-sized folios take 18-31 ms with or without this change.
> 
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
