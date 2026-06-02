Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CBE395AC7;
	Tue,  2 Jun 2026 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379663; cv=none; b=fCd5AR+H/PW1nPBdBh2I+XtdkRzuhmHg2XvPzYnm9LjHhygGrx4OjPu0FShTqzukrUiswB393jGxuo8nsDL/ftcxZZvR3va414cT+6SZLx3d47F7kQEuvx+TE+csO/OvDp6MAXVeKZfG5qr3XXSlVmeNZTrIeB/s7vKLIAsYals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379663; c=relaxed/simple;
	bh=XkazPbioCnGqtiTM2RADbd3BFcOna5JB6WYHvf/gk7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmUOheYF4iK9aB1cDWWjnFBxrEndibWAw6gT7sy+HF/iIkAIKutq/Igaxf6QqPifZQZ5NMgYJW3qV2DWMorzSFxJTCJvxyKUSBc2L+HTcrGCThO+qBK4n+wO1rTNKz24wREJHwNKHPt5O4aeHIOwLuRa5Sf1+GHh82U1DcqK3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GlZ1k9au; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GlZ1k9au"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780379650; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ANoWApNy7HClVP2oRbGsYE3SlFLFzfccZW33ESPs2Qg=;
	b=GlZ1k9aunmZZnzYqyPtD3zKs7dmu/fRK/bB373NN5sOgWdcWb52V1ftU8pqoJX1WqJwgWnRI9sUS5rPmy2pDYSnPFVcJ1b4WJmfVBdqFsBM7xlsnpXU8WEKQorRbIjj0hs9+TyPIegMWVCRnSYgDk1BSTZmGSKHNYUZAnjm16zQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X43HI8B_1780379649;
Received: from 30.166.17.138(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X43HI8B_1780379649 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 13:54:10 +0800
Message-ID: <6af198e3-89aa-4d31-b596-3a1b623513fa@linux.alibaba.com>
Date: Tue, 2 Jun 2026 13:54:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm/shmem: optimize file read with folio batching
To: Chi Zhiling <chizhiling@163.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-6-chizhiling@163.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260601055704.167436-6-chizhiling@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/1/26 1:57 PM, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> Optimize shmem file read by using filemap_get_folios_contig() to batch
> fetch contiguous folios from the page cache, reducing the overhead of
> repeated shmem_get_folio() calls.
> 
> This patch checks the uptodate flag without holding the folio lock, so
> it may observe a non-uptodate state on a locked folio that is still
> being initialized. This is safe because only zero-filled data can be
> copied to the user buffer in that scenario.
> 
> A non-uptodate folio in the swap cache cannot be added to the shmem page
> cache. This creates a semantic conflict, as shmem zeroes the folio out,
> but the swap cache would fill it by reading from the swap backing store.
> 
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>   mm/shmem.c | 57 ++++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 42 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index cac355685e49..61937582f08c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -891,6 +891,14 @@ int shmem_add_to_page_cache(struct folio *folio,
>   	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>   	VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio), folio);
>   
> +	/*
> +	 * Don't add a non-uptodate folio that is in swap cache to page
> +	 * cache, since shmem will zero it instead of reading from swap
> +	 * backing.
> +	 */
> +	VM_BUG_ON_FOLIO(folio_test_swapcache(folio) &&
> +			!folio_test_uptodate(folio), folio);

It's impossible for a folio to be in both the swap cache and the shmem 
page cache. We can drop this.

>   	folio_ref_add(folio, nr);
>   	folio->mapping = mapping;
>   	folio->index = index;
> @@ -3382,11 +3390,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	struct file *file = iocb->ki_filp;
>   	struct inode *inode = file_inode(file);
>   	struct address_space *mapping = inode->i_mapping;
> -	pgoff_t index;
> +	struct folio_batch fbatch;
>   	unsigned long offset;
>   	int error = 0;
>   	ssize_t retval = 0;
>   
> +	folio_batch_init(&fbatch);
> +
>   	for (;;) {
>   		struct folio *folio = NULL;
>   		unsigned long nr, ret;
> @@ -3395,15 +3405,33 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   
>   		if (unlikely(iocb->ki_pos >= i_size))
>   			break;
> +fetch:
> +		folio = folio_batch_next(&fbatch);
> +		if (!folio) {
> +			pgoff_t start = iocb->ki_pos >> PAGE_SHIFT;
> +			pgoff_t end = (iocb->ki_pos + to->count - 1) >> PAGE_SHIFT;

You should consider the inode size when calculating the 'end'. You can 
reuse the 'end_offset':

end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);

then pass 'end_offset - 1' to filemap_get_folios_contig().

> +
> +			if (folio_batch_count(&fbatch)) {
> +				for (int i = 0; i < folio_batch_count(&fbatch); i++)
> +					folio_put(fbatch.folios[i]);
> +				folio_batch_reinit(&fbatch);
> +			}
>   
> -		index = iocb->ki_pos >> PAGE_SHIFT;
> -		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
> -		if (folio)
> -			folio_unlock(folio);
> -		if (error) {
> -			if (error == -EINVAL)
> -				error = 0;
> -			break;
> +			filemap_get_folios_contig(inode->i_mapping, &start, end, &fbatch);
> +			if (folio_batch_count(&fbatch))
> +				goto fetch;
> +
> +			error = shmem_get_folio(inode, start, 0, &folio, SGP_READ);
> +			if (unlikely(error)) {
> +				if (error == -EINVAL)
> +					error = 0;
> +				break;
> +			}
> +			if (folio) {
> +				folio_unlock(folio);
> +				folio_batch_add(&fbatch, folio);
> +				fbatch.i++;
> +			}
>   		}
>   
>   		/*
> @@ -3411,17 +3439,15 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		 * are called without i_rwsem protection against truncate
>   		 */
>   		i_size = i_size_read(inode);
> -		if (unlikely(iocb->ki_pos >= i_size)) {
> -			if (folio)
> -				folio_put(folio);
> +		if (unlikely(iocb->ki_pos >= i_size))
>   			break;
> -		}
> +
>   		fsize = folio ? folio_size(folio) : PAGE_SIZE;
>   		offset = iocb->ki_pos & (fsize - 1);
>   		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
>   		nr = min_t(loff_t, end_offset - iocb->ki_pos, fsize - offset);
>   
> -		if (folio) {
> +		if (folio && folio_test_uptodate(folio)) {
>   			/*
>   			 * If users can be writing to this page using arbitrary
>   			 * virtual addresses, take care about potential aliasing
> @@ -3443,7 +3469,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   				ret = copy_folio_to_iter(folio, offset, nr, to);
>   			else
>   				ret = copy_pages_to_iter(folio, offset, nr, to, &error);
> -			folio_put(folio);
>   		} else if (user_backed_iter(to)) {
>   			/*
>   			 * Copy to user tends to be so well optimized, but
> @@ -3474,6 +3499,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		cond_resched();
>   	}
>   
> +	for (int i = 0; i < folio_batch_count(&fbatch); i++)
> +		folio_put(fbatch.folios[i]);
>   	file_accessed(file);
>   	return retval ? retval : error;
>   }

