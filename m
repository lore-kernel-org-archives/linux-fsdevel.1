Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ACB3EFFA1
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671868; cv=none; b=j4D+01j1+Ievt4SVh3/My9ei3M97WDl9SHJQaXRGoAi88dqcyuZWyLQ6zaBPijnxETaMH6ueoXjRzZlJ1HipR4jLhEmi9upaHQNIbU0MExu/uF/wXT6cVP6IvxEc63XNfaAq3bAEUTQGPbUQn8lVU43oiDW+UzHBP0KeX2lV/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671868; c=relaxed/simple;
	bh=HwhvEkxqat43Xn3E6NAymJDvmzKSAfufM7rsYSms4Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NF53AuyAgb7WmN/mq+D7Sxeb6KZKHX3YiO/lu9RwjWE6ykMVPjZrAS7AnDv5yGK9bnJazUb6LCCwWYU8I9vFjvwDma5/dy3rfHNlgk0Gdh3GPF01fVR8xVfadcwnl0hsIR8RrTjdETbiY4om1aryusGwonRu75ITyTDTrnIG42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G0XVHYl3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G0XVHYl3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1656E1D15;
	Fri, 10 Jul 2026 01:24:21 -0700 (PDT)
Received: from [10.174.42.251] (unknown [10.174.42.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 853CC3F85F;
	Fri, 10 Jul 2026 01:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783671865; bh=HwhvEkxqat43Xn3E6NAymJDvmzKSAfufM7rsYSms4Zc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G0XVHYl3glbJJqU3GU1Aasyd6F8eB4lHtfSsljGrI6Id/FiAMcGuBTuxgysiqQnKd
	 MfUeoGtNqzhVoSM/e5qvX1XWjHm4tFklA6QURPAKGToYJVNdSrlec7KiOR/j6siw4G
	 4v6rdYinaL1erVhjTqqKi+tulw6+iTx2r0wDSmJs=
Message-ID: <8182d981-cb4e-4c76-93c8-b48173e2cc12@arm.com>
Date: Fri, 10 Jul 2026 13:54:20 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove wb_writeout_inc
To: Christoph Hellwig <hch@lst.de>, willy@infradead.org, jack@suse.cz
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20260710051052.1839523-1-hch@lst.de>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260710051052.1839523-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/07/26 10:40 AM, Christoph Hellwig wrote:
> Remove this entirely unused but exported function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/backing-dev.h |  2 --
>  mm/page-writeback.c         | 10 ----------
>  2 files changed, 12 deletions(-)
> 
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 5b7d12b40d5e..c2284466e7aa 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -76,8 +76,6 @@ static inline s64 wb_stat_sum(struct bdi_writeback *wb, enum wb_stat_item item)
>  	return percpu_counter_sum_positive(&wb->stat[item]);
>  }
>  
> -extern void wb_writeout_inc(struct bdi_writeback *wb);
> -
>  /*
>   * maximal error of a stat counter.
>   */
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index e98748112d1e..47495be68598 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -584,16 +584,6 @@ static inline void __wb_writeout_add(struct bdi_writeback *wb, long nr)
>  				       wb->bdi->max_prop_frac, nr);
>  }
>  
> -void wb_writeout_inc(struct bdi_writeback *wb)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	__wb_writeout_add(wb, 1);
> -	local_irq_restore(flags);
> -}
> -EXPORT_SYMBOL_GPL(wb_writeout_inc);
> -
>  /*
>   * On idle system, we can be called long after we scheduled because we use
>   * deferred timers so count with missed periods.

