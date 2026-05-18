Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A59D3CCA11;
	Mon, 18 May 2026 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086363; cv=none; b=gQS6QlbK/+5h2ggJd4i+PGB7rvY1bdDErTR/jtOz7+QygqSu8ChbTk2pUYu+QDiXtHD2aMA9xTAtSzTBeIflP/rtKZiUZ0Ud3X1lnqJBLdW+ZIH8Yu98cM5QHumu2sg3i2/aAoExD+H1vxyiBViv9aWGkQkfOrnbuoON7u2tbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086363; c=relaxed/simple;
	bh=pRx6pEweDuOf18SQO5MrVK/RTJYRzNQKJPnsOpEw0D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lU+tTD3/vGN8u3l9CD8dBHdYDyow6/ExidYC6ZJyGa86FPROJl+Fr4lsiciyHEuQtmZ1nJdX7necR4azYH55v891fPWdfcaIcK3E20V5tDySnt/RN99B6leZw5rFK35E5c6UxvtMZYkrS0sk+yG6G9Ot7auJlCeySlwkfRBuyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lRTiFQOl; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lRTiFQOl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779086356; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lUBLwiSnJ+yN8ROsUfa/+tX1XkZcgIDIxGet+HC+cC0=;
	b=lRTiFQOlmqq+ks0Jiwusy9FW4PIfkLr9WPB9dPFmuU3iiYH01Cxcp//poNQ1AxUA0NzjQs3M0NhyEInHXNBaawRWRQqaCyynWqyhBPKnogCVf5izrjoSce5YoWad6bF0PbZcI0I74iIbeY/3fk9XpGoTt4YUsI/ikMTOmA5dd0I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X34EaX1_1779086354;
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X34EaX1_1779086354 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 14:39:14 +0800
Message-ID: <c0a6e4ea-3ca5-4efc-af5e-b5abc968308b@linux.alibaba.com>
Date: Mon, 18 May 2026 14:39:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm/shmem: use SGP_GET in read operations
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
 <20260515094702.1092355-3-chizhiling@163.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260515094702.1092355-3-chizhiling@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/26 5:47 PM, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> Replace SGP_READ with SGP_GET in shmem_file_read_iter(),
> shmem_file_splice_read(), and shmem_get_link(). These functions
> immediately unlock the folio after getting it, making the lock
> acquisition redundant.
> 
> Even though folio_lock can protect folio data consistency or prevent
> truncate while holding the lock, these can still happen after unlock.
> Since these functions continue reading data after unlocking, the lock
> does not provide effective protection. The folio reference count is
> what actually prevents reclamation during access, making the lock
> unnecessary.
> 
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---

Thanks for your patch. It would be better to squash patch 1 and patch 2 
into a one commit, so that the usage of the newly introduced flag can be 
easily seen.

>   mm/shmem.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ef19968cc51c..767610f78d0d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3370,15 +3370,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   			break;
>   
>   		index = iocb->ki_pos >> PAGE_SHIFT;
> -		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
> +		error = shmem_get_folio(inode, index, 0, &folio, SGP_GET);
>   		if (error) {
>   			if (error == -EINVAL)
>   				error = 0;
>   			break;
>   		}
>   		if (folio) {
> -			folio_unlock(folio);
> -

This is incorrect. Since a shmem folio can still be locked if it is 
being swapped in from the swap device.

Essentially, you need to show reviewers the benefit of introducing a new 
flag. In what scenario would you see overhead from locking the folio in 
shmem_get_folio()? And how much performance improvement does your patch 
bring? Data is the easiest way to convince people:)
