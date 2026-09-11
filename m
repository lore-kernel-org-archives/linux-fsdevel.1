Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2944BC94;
	Fri, 11 Sep 2026 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155950; cv=none; b=X8+eUzA7rbVtTAD0MOWfdxjPEexbwqaSAf+vM8IOUmEqPq2T2ZtAgFGyRLLns9P1YLtXMAblBQrB666s8Ep9XnWKXcfXS03t66gf3Jwe6n47qERmIKJAGBlNML+I6rmS7I+/Unnq+VXb4D8pIcGjM5NYYsS4nBhEcNI7a0g6t+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155950; c=relaxed/simple;
	bh=YNJ9YeSxPjoByAaDIVZsmZrOztcEH6WnAs2id4cpoSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqgaBwjINcgu45U6BuYY5sGlqq2JM12e83Txv7Y1HSQLgdqD4CxlU0pHjkLDpnZfkIluwkkHRh5CMhEzOyZjL479qvaO9iU3JflYcGCNdD43eb6K5tn+rIX3wKczZ6x2LpS6ktS+1f3u8BXL8Z3P2nywogZ/ZszJNZWXrSFAVoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i64kGb/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i64kGb/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EC71F00898;
	Fri, 11 Sep 2026 19:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155925;
	bh=fK4p93/u6AanIHtu5vXzEzaRXDt40DQgX7Ravxuqpxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i64kGb/3X9BQVjACRQTmztK6UN9vfAAH0CDAv2AoWhz2hBGqmDrBgVd3MhMcWzXNO
	 1ctBcxLoO6M9eaVjGcglS+1j6O97tmY2YcHWzkHZDPcEu7r6Y8h604/6HNvNd7InFA
	 bRAtyHJ36NibHuSvj9NC2CeNsn3mDxPZTkAgEAwY/baM1XygvBqU4jWnV+4kWZFiKn
	 UhnfZgglAgptZjfXFwyoojUDhs9WKgwBsVhvuhWJsrFQ9C04ew4ZUCHEesEgIq+SvN
	 uOvRQbnj7fd65dbi5C+7gavgD16qrtTA9Ge0gMxyAh5un2EXZSnXzk/2AmXm/6Eh+2
	 kgp4njV5imiZQ==
Date: Fri, 11 Sep 2026 20:45:20 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
Message-ID: <aqRaONEiklcnblwQ@gremlin>
References: <20260911194145.1781926-1-surenb@google.com>
 <20260911194145.1781926-5-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911194145.1781926-5-surenb@google.com>

On Fri, Sep 11, 2026 at 12:41:42PM -0700, Suren Baghdasaryan wrote:
> smap_gather_stats() interprets its start parameter to mean vma->vm_start
> when it's set to 0. Eliminate this special interpretation and provide two
> separate functions for a partial and complete VMA walk.
>
> Since smap_gather_stats() operates within a single VMA, we can replace
> walk_page_vma()/walk_page_range() calls with walk_page_range_vma()
> which is simpler and also can be called while holding per-VMA lock.
>
> No functional change intended.
>
> Suggested by: Lorenzo Stoakes <ljs@kernel.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  fs/proc/task_mmu.c | 52 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 35 insertions(+), 17 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 0e53eb065a3e..a6026ffd07f1 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1246,20 +1246,26 @@ get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
>  	return &smaps_shmem_walk_vma_lock_ops;
>  }
>
> -/*
> - * Gather mem stats from @vma with the indicated beginning
> - * address @start, and keep them in @mss.
> +/**
> + * smap_gather_stats_range() - Gather mem stats from a portion of the @vma.
> + * @priv: proc maps private state.
> + * @vma: The VMA to gather stats for.
> + * @mss: The accumulated stats.
> + * @start: The address from which to start.
>   *
> - * Use vm_start of @vma as the beginning address if @start is 0.
> + * This gathers stats for the portion of the VMA starting at the @start
> + * address.
>   */
> -static void smap_gather_stats(struct proc_maps_private *priv,
> -			      struct vm_area_struct *vma,
> -			      struct mem_size_stats *mss, unsigned long start)
> +static void smap_gather_stats_range(struct proc_maps_private *priv,
> +		struct vm_area_struct *vma,
> +		struct mem_size_stats *mss,
> +		unsigned long start)
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
> @@ -1278,20 +1284,31 @@ static void smap_gather_stats(struct proc_maps_private *priv,
>  		const unsigned long shmem_swapped = shmem_swap_usage(vma);
>  		const bool is_cow = vma_is_cow_mapping(vma);
>
> -		if (start || (shmem_swapped && is_cow))
> +		if (is_partial || (shmem_swapped && is_cow))
>  			ops = get_smaps_shmem_walk_ops(priv);
>  		else
>  			mss->swap += shmem_swapped;
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
>
> +/**
> + * smap_gather_stats() - Gather mem stats from the entire @vma.
> + * @priv: proc maps private state.
> + * @vma: The VMA to gather stats for.
> + * @mss: The accumulated stats.
> + *
> + * This gathers stats for the whole of the VMA.
> + */
> +static void smap_gather_stats(struct proc_maps_private *priv,
> +		struct vm_area_struct *vma, struct mem_size_stats *mss)
> +{
> +	smap_gather_stats_range(priv, vma, mss, vma->vm_start);
> +}
> +
>  #define SEQ_PUT_DEC(str, val) \
>  		seq_put_decimal_ull_width(m, str, (val) >> 10, 8)
>
> @@ -1342,7 +1359,7 @@ static int show_smap(struct seq_file *m, void *v)
>  	struct vm_area_struct *vma = v;
>  	struct mem_size_stats mss = {};
>
> -	smap_gather_stats(priv, vma, &mss, 0);
> +	smap_gather_stats(priv, vma, &mss);
>
>  	show_map_vma(m, vma);
>
> @@ -1395,7 +1412,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>
>  	vma_start = vma->vm_start;
>  	do {
> -		smap_gather_stats(priv, vma, &mss, 0);
> +		smap_gather_stats(priv, vma, &mss);
>  		last_vma_end = vma->vm_end;
>
>  		/*
> @@ -1454,14 +1471,15 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>
>  			/* Case 1 and 2 above */
>  			if (vma->vm_start >= last_vma_end) {
> -				smap_gather_stats(priv, vma, &mss, 0);
> +				smap_gather_stats(priv, vma, &mss);
>  				last_vma_end = vma->vm_end;
>  				continue;
>  			}
>
>  			/* Case 4 above */
>  			if (vma->vm_end > last_vma_end) {
> -				smap_gather_stats(priv, vma, &mss, last_vma_end);
> +				smap_gather_stats_range(priv, vma, &mss,
> +							last_vma_end);
>  				last_vma_end = vma->vm_end;
>  			}
>  		}
> --
> 2.55.0.1007.g17ff1f9808-goog
>

--
Cheers, Lorenzo
