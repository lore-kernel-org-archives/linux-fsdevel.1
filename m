Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533E23E0259;
	Mon, 25 May 2026 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698260; cv=none; b=gWJ9JDEAHJxjT2O5rXYQBiSNUlo7Gj50max2MVeQu9dkXH4w1/mPjy1QEMCYNUKsANRIELhp8/GUGOw+Pe5n5wrJ4CnD3shminTh3m4Bun6Vy5fnL6TXBgE96bJcH59JNJEZT60ROdXvNWKE02tRxlkzUSrk1SLHOPh7KeIcVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698260; c=relaxed/simple;
	bh=oZHVznUHASE/81rlNO149FJUAjI13HL0tDiKpaGhpbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2KO3iEAoHeaEBBs/uXFyy4tpZHmGnvwpkTa8/otCuSx17E8jvEYXklbqghlYxuldGOKuEd6jlCV1Wttz36vjaY/00YfaY7PuBd69fF1WKMyasVROuANIHd0Aq2I0AVIPi66qpgvd0BtYMGeotUn5iFEM8W8UeJTTttm/sO0E/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QFV+reBt; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QFV+reBt"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779698255; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fM5SE1333rF5XvXXkmPILOtV+9GPvTKGJed+D55Hqho=;
	b=QFV+reBtAs02OImrfPF2iqvsZRC2xefqHCcos5+2cZq/iOEBZfwsTZgCyTqJ9iCuqeVakZlneADBe2d8fb5Ax1PpvzoLLu8kjKOPFi1OBpclVU6H8+CzHLmHbKk2Wr7GuxXaqocZdTJuLKA9gUP5tnTtL6RYx2RXvQFdYZRRiNM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X3WrLhT_1779698252;
Received: from 30.74.144.135(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X3WrLhT_1779698252 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 May 2026 16:37:33 +0800
Message-ID: <1d8c7c24-b273-4826-9a9e-37fdb0767f2f@linux.alibaba.com>
Date: Mon, 25 May 2026 16:37:32 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260520101538.58745-6-chizhiling@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/20/26 6:15 PM, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> Optimize shmem file read by using filemap_get_folios_contig() to
> batch fetch contiguous folios from the page cache, reducing the
> overhead of repeated shmem_get_folio() calls.
> 
> When the folio batch is exhausted, attempt to refill it with
> filemap_get_folios_contig(). If no folios are found (hole or swapped
> out pages), fall back to shmem_get_folio() to handle these cases
> individually.
> 
> Additionally:
> - Defer folio_put() until the batch is exhausted or on exit
> - Add folio_test_uptodate() check before copying to ensure data
>    validity
> 
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>   mm/shmem.c | 50 ++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 96ea5a4c0aff..e0eacc23cccd 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3355,11 +3355,14 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	struct file *file = iocb->ki_filp;
>   	struct inode *inode = file_inode(file);
>   	struct address_space *mapping = inode->i_mapping;
> +	struct folio_batch fbatch;
>   	pgoff_t index;
>   	unsigned long offset;
>   	int error = 0;
>   	ssize_t retval = 0;
>   
> +	folio_batch_init(&fbatch);
> +
>   	for (;;) {
>   		struct folio *folio = NULL;
>   		struct page *page = NULL;
> @@ -3372,18 +3375,38 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   			break;
>   
>   		index = iocb->ki_pos >> PAGE_SHIFT;
> -		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
> -		if (error) {
> -			if (error == -EINVAL)
> -				error = 0;
> -			break;
> +fetch:
> +		folio = folio_batch_next(&fbatch);
> +		if (!folio) {
> +			pgoff_t start = index;
> +			pgoff_t end = (iocb->ki_pos + to->count - 1) >> PAGE_SHIFT;
> +
> +			if (folio_batch_count(&fbatch)) {
> +				for (int i = 0; i < folio_batch_count(&fbatch); i++)
> +					folio_put(fbatch.folios[i]);
> +				folio_batch_reinit(&fbatch);
> +			}
> +
> +			filemap_get_folios_contig(inode->i_mapping, &start, end, &fbatch);
> +			if (folio_batch_count(&fbatch))
> +				goto fetch;
> +
> +			error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
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
> -		if (folio) {
> -			folio_unlock(folio);
>   
> +		if (folio) {
>   			page = folio_file_page(folio, index);
>   			if (PageHWPoison(page)) {
> -				folio_put(folio);
>   				error = -EIO;
>   				break;
>   			}

I haven't tested it yet, but I'm sure this will break the 
fallback_page_copy mode.

You're fetching from the batch at folio granularity here, but in 
fallback_page_copy mode, we still copy the data at page granularity.
