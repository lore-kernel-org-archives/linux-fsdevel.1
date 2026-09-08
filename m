Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CFD59B68D;
	Tue,  8 Sep 2026 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890858; cv=none; b=EJ2eU79cknU49S1WFZmsH04xgaMxsDraqaNJQEeVW3QEbxCIGTcbGXm08lvc3eds8mgz+8cRzpkagkGluKIP16NPc/U2qS3M+shr88cN0ptxpUIrlIcWo03/mapuJV9r7afgOm3rfuNYbVvcXc3sF047VLH8qSf1bx4a+DMD5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890858; c=relaxed/simple;
	bh=WE49m+T4YArfiEZEezGmAyk+RK98nBHr3/w8sIwKjoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3wz0BdJXtXybWg6shDA1BZ5bNg60q+GsS8mgEabhhc7WW8MFVN4rDfUMQl81HabtIE1ExLvq/DT3x3k+5oFeV2a7XrRb8yZHgCIXYSHVdNgMlan59sozlUnjgPzCi/7B5+V+fEzrJiV6T5S/2A65dD+BlyJKT4p+aub44mqoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TF8pTfzY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TF8pTfzY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yGDxn8k8FaV9OYqO8qqylmLTXbLKQyP9aBdywz0C2Zk=; b=TF8pTfzY7mPKoBPoJ8Fioy5HMW
	+JuKD4tWkAiJAWzQRBXPUcazg8AitZwIkYva5qvIhYC2+1TIZPBRD1yLvgfsPlnO39Zuj31cX31LH
	cun+UiZW6P78LGKn6aFXmz+00/69JQYx/UJpV+8c7IhFUNiGlad2ylfVX1N6Jc0/9X5Ha9Mdib5xU
	ZDV1COL5zVTD5YFOmYS+VWYbsCJ4QdLqvL7LCE/rhkZ+JY8OryGY+oJpdqIXXoZFk8v4JMNH0sQ1c
	ZXyuzxBkSU9ECoLQPwc2vqv6J6mzdChw/N/MHSPD/g7Bsck3eqjxdFHKK5OCXIsYpbKjIguhwmxnA
	ve+GXbZQ==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40EB-00000009w4t-1GCM;
	Tue, 08 Sep 2026 18:07:27 +0000
Date: Tue, 8 Sep 2026 14:07:25 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, ljs@kernel.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
Message-ID: <2kj54k3hscnsswjwernucsgd3ipv6tt7tp2wmukp6w5ltkanpv@iy4obfoaasp2>
References: <20260907063918.3432401-1-surenb@google.com>
 <20260907063918.3432401-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907063918.3432401-4-surenb@google.com>

On 26/09/06 11:39PM, Suren Baghdasaryan wrote:
> smap_gather_stats() interprets its start parameter to mean vma->vm_start
> when it's set to 0. Eliminate this special interpretation and pass
> vma->vm_start explicitly when needed.
> 
> Since smap_gather_stats() operates within a single VMA, we can replace
> walk_page_vma()/walk_page_range() calls with walk_page_range_vma()
> which is simpler and also can be called while holding per-VMA lock.
> 
> No functional change intended.
> 
> Suggested by: Lorenzo Stoakes <ljs@kernel.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>

> ---
>  fs/proc/task_mmu.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 9908ba32f180..3351decd1172 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1246,20 +1246,27 @@ get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
>  	return &smaps_shmem_walk_vma_lock_ops;
>  }
>  
> -/*
> - * Gather mem stats from @vma with the indicated beginning
> - * address @start, and keep them in @mss.
> +/**
> + * smap_gather_stats() - Gather mem stats from @vma.
> + * @priv: proc maps private state.
> + * @vma: The VMA to gather stats for.
> + * @mss: The accumulated stats.
> + * @start: The address from which to start.
>   *
> - * Use vm_start of @vma as the beginning address if @start is 0.
> + * This gathers stats for the whole of the VMA unless the lock was dropped
> + * and VMA grew or got merged and we found it again, in which case we only
> + * gather stats for the remainder of the VMA range.
>   */
>  static void smap_gather_stats(struct proc_maps_private *priv,
>  			      struct vm_area_struct *vma,
> -			      struct mem_size_stats *mss, unsigned long start)
> +			      struct mem_size_stats *mss,
> +			      unsigned long start)
>  {
>  	const struct mm_walk_ops *ops = get_smaps_walk_ops(priv);
> +	const bool is_partial = start > vma->vm_start;
>  
>  	/* Invalid start */
> -	if (start >= vma->vm_end)
> +	if (start < vma->vm_start || start >= vma->vm_end)
>  		return;
>  
>  	if (vma == get_gate_vma(priv->lock_ctx.mm))
> @@ -1279,20 +1286,17 @@ static void smap_gather_stats(struct proc_maps_private *priv,
>  		 * Unless we know that the shmem object (or the part mapped by
>  		 * our VMA) has no swapped out pages at all.
>  		 */
> -		unsigned long shmem_swapped = shmem_swap_usage(vma);
> +		const unsigned long shmem_swapped = shmem_swap_usage(vma);
> +		const bool shared_or_ro = vma_test(vma, VMA_SHARED_BIT) ||
> +					  !vma_test(vma, VMA_WRITE_BIT);
>  
> -		if (!start && (!shmem_swapped || (vma->vm_flags & VM_SHARED) ||
> -					!(vma->vm_flags & VM_WRITE))) {
> +		if (!is_partial && (!shmem_swapped || shared_or_ro))
>  			mss->swap += shmem_swapped;
> -		} else {
> +		else
>  			ops = get_smaps_shmem_walk_ops(priv);
> -		}
>  	}
>  
> -	if (!start)
> -		walk_page_vma(vma, ops, mss);
> -	else
> -		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
> +	walk_page_range_vma(vma, start, vma->vm_end, ops, mss);
>  
>  	reacquire_rcu(priv);
>  }
> @@ -1347,7 +1351,7 @@ static int show_smap(struct seq_file *m, void *v)
>  	struct vm_area_struct *vma = v;
>  	struct mem_size_stats mss = {};
>  
> -	smap_gather_stats(priv, vma, &mss, 0);
> +	smap_gather_stats(priv, vma, &mss, vma->vm_start);
>  
>  	show_map_vma(m, vma);
>  
> @@ -1400,7 +1404,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  
>  	vma_start = vma->vm_start;
>  	do {
> -		smap_gather_stats(priv, vma, &mss, 0);
> +		smap_gather_stats(priv, vma, &mss, vma->vm_start);
>  		last_vma_end = vma->vm_end;
>  
>  		/*
> @@ -1459,7 +1463,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  
>  			/* Case 1 and 2 above */
>  			if (vma->vm_start >= last_vma_end) {
> -				smap_gather_stats(priv, vma, &mss, 0);
> +				smap_gather_stats(priv, vma, &mss, vma->vm_start);
>  				last_vma_end = vma->vm_end;
>  				continue;
>  			}
> -- 
> 2.55.0.979.g7e5102b832-goog
> 
