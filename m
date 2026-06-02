Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C13290AA;
	Tue,  2 Jun 2026 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378796; cv=none; b=kZ2b0IdgTLQQiQtyY8KWo/m0PyqVXPHoZlQDojPV5PFZpxXjyqkjK8Xh8ZYmr3yZO+jKsI7Md1A95YVyt1Bq4gw5xcRcRwIuvBY2ZaAVYi9Rw/da5L4/fes8b5NN97GgLO5sWPP/ZdqCCa9r/dr8gcJrvMK+9unuilij8IsjloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378796; c=relaxed/simple;
	bh=L7AQuuljj9UiGwdGtllEk8NGRM5Mb2dNrw/7En8BxEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEURr6XvY2fpnj7EPBrInSvWSjp1K2th22iOeLovl88lav327d3HgOwu2Jmpvzb5ZkBaZnsQzAZYv2BWjmotfrn1E1oVzVzErH+176jQS7WVdArnmdfN98DLmXEnMXJHJuuqdv0z6A6XxRoEuj0dIMGRR3Qrvhrkm6yGoBl3VQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QJ+oOvT/; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QJ+oOvT/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780378791; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=unxcZd6GYt51N38x4c/HfZOzbOu1xMEFtXv9s+df9k8=;
	b=QJ+oOvT/8nVkqc/z6Q7pbU7e6R0WtJgHAtDYVZTxHGjmVTDxBY6amiCxxRax0vbW/0hzR85k2BG3eayNImywHtKIBkjal5fdRNK7EoHVph+6xbQPu1TCMs1Qf/3CO0s7LapkFX75gGAvSgkr9cKZjZlmsFzxw4TvfhFh8qlkNPE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X43EdUH_1780378790;
Received: from 30.166.17.138(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X43EdUH_1780378790 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 13:39:50 +0800
Message-ID: <06a4c4a0-fc3c-488e-9015-04f0532650f2@linux.alibaba.com>
Date: Tue, 2 Jun 2026 13:39:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm/shmem: remove page-copy fallback in shmem read
 path
To: Chi Zhiling <chizhiling@163.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-5-chizhiling@163.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260601055704.167436-5-chizhiling@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/1/26 1:57 PM, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> This is perp patch for folio batch support which removing the fallback
> to page-copy mode from shmem reads.
> 
> The existing hwpoison fallback would require fetching the same folio
> multiple times to read its each pages, which complicates the
> batching model. Instead, move hwpoison handling into
> copy_each_pages_to_iter(), allowing the error path to be centralized.
> 
> This simplifies the shmem fast read path and avoids special-case
> handling that conflicts with folio batching support.
> 
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>   mm/shmem.c | 63 +++++++++++++++++++++++++++++-------------------------
>   1 file changed, 34 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b08118fbd275..cac355685e49 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3353,6 +3353,30 @@ static size_t copy_zero_to_iter(size_t bytes, struct iov_iter *i)
>   	return written;
>   }
>   
> +static size_t copy_pages_to_iter(struct folio *folio, size_t offset,
> +		size_t bytes, struct iov_iter *i, int *error)
> +{
> +	struct page *page;
> +	unsigned long off, nr, ret, written = 0;
> +
> +	do {
> +		page = folio_page(folio, offset >> PAGE_SHIFT);
> +		if (PageHWPoison(page)) {
> +			*error = -EIO;
> +			break;
> +		}
> +
> +		off = offset_in_page(offset);
> +		nr = min(PAGE_SIZE - off, bytes - written);
> +
> +		ret = copy_page_to_iter(page, off, nr, i);
> +		offset += ret;
> +		written += ret;
> +	} while (written < bytes && ret == nr);
> +
> +	return written;
> +}
> +
>   static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   {
>   	struct file *file = iocb->ki_filp;
> @@ -3365,10 +3389,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   
>   	for (;;) {
>   		struct folio *folio = NULL;
> -		struct page *page = NULL;
>   		unsigned long nr, ret;
>   		loff_t end_offset, i_size = i_size_read(inode);
> -		bool fallback_page_copy = false;
>   		size_t fsize;
>   
>   		if (unlikely(iocb->ki_pos >= i_size))
> @@ -3376,25 +3398,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   
>   		index = iocb->ki_pos >> PAGE_SHIFT;
>   		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
> +		if (folio)
> +			folio_unlock(folio);
>   		if (error) {
>   			if (error == -EINVAL)
>   				error = 0;
>   			break;
>   		}
> -		if (folio) {
> -			folio_unlock(folio);
> -
> -			page = folio_file_page(folio, index);
> -			if (PageHWPoison(page)) {
> -				folio_put(folio);
> -				error = -EIO;
> -				break;
> -			}
> -
> -			if (folio_test_large(folio) &&
> -			    folio_test_has_hwpoisoned(folio))
> -				fallback_page_copy = true;
> -		}
>   
>   		/*
>   		 * We must evaluate after, since reads (unlike writes)
> @@ -3406,12 +3416,9 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   				folio_put(folio);
>   			break;
>   		}
> -		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
> -		if (folio && likely(!fallback_page_copy))
> -			fsize = folio_size(folio);
> -		else
> -			fsize = PAGE_SIZE;
> +		fsize = folio ? folio_size(folio) : PAGE_SIZE;
>   		offset = iocb->ki_pos & (fsize - 1);
> +		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);

Do not add this unnecessary change.

>   		nr = min_t(loff_t, end_offset - iocb->ki_pos, fsize - offset);
>   
>   		if (folio) {
> @@ -3420,12 +3427,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   			 * virtual addresses, take care about potential aliasing
>   			 * before reading the page on the kernel side.
>   			 */
> -			if (mapping_writably_mapped(mapping)) {
> -				if (likely(!fallback_page_copy))
> -					flush_dcache_folio(folio);
> -				else
> -					flush_dcache_page(page);
> -			}
> +			if (mapping_writably_mapped(mapping))
> +				flush_dcache_folio(folio);

I'm not sure this is safe for all architectures (it's safe for arm64 
since no actual data cache flush happens here), but for architectures 
that do perform an actual data cache flush, if the page has already been 
hwpoisoned, flushing the cache could trigger a RAS error?

I think you should move this into copy_pages_to_iter() for hwpoisoned 
folios.
