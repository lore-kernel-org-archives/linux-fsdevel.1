Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2FD4A43F3;
	Fri, 11 Sep 2026 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144780; cv=none; b=RJMYuXVQ2oIq/yFLDIZNhzlkyA9mvCFqECtoGhT1AJwfc5FgYQ7Wyu5iKqVtai6gQ1wsiHf93uYF49AwUmAgLen5Qy0OqjgOErta4HYqySc/4QjJiUqMKNfYONK8D1USZdkL7QVkhmFA4fiRcjraijCAoab73E9lV4Scjoykrtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144780; c=relaxed/simple;
	bh=zMi6M00P9+gGP2DawlzmK4x5D4ChpCE+33j6eEaXlcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy/Tgl9yqk4cR4KgMvzXjYzmK5UAaDLleF7St9XlHh3ZwmsmCqXHWgxnlq5uFPx2/MM2+kFWfY5/bceHeQYKJzsXXaiic6R9dDDGk0HfYhlekByBxPQpo62kCLwfpd6jZQVkBv8k1OaIUxuM0VVfkjlgZ5d2LGDEAGYg09GZTMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGl9I60x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGl9I60x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEF91F000FF;
	Fri, 11 Sep 2026 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789144774;
	bh=OkTP2UvkR9L4UOg/cpBiigVG7rpJsSBTG6KbmpAnG+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MGl9I60xY3Z2sFqyyRhad6HQLSNPVGaSdlpegFKSLHpF3B3rGo1tqdouOTEkjKNip
	 alC0sHkDBVQbR5AEBqEpVXXiaUDQ8piArAQN5p42Uf1l1mEGXfrtfdPkLcc8DWVFHd
	 uxS1/6MHrVb2aPWYKFqB25mTgla33/lPHoIXtpv+R5dEuU8fMbmQDpBzQdyMHTIgLR
	 ALkurPnDO51TkRfpCizQmi+qxoWpwbCM+Hq/OSW+ug31KUDVs44DDpIXjCG2ElxENH
	 1ciplIL2LP9dQiie4EW5MnBVvWvk7S/EMinDR/7sok2kQu9Vsord0jwYfSmqNZPT/N
	 iV4NFGY3TFsVg==
Date: Fri, 11 Sep 2026 17:39:28 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
Message-ID: <aqQsWNfrBSp4DY_N@gremlin>
References: <20260910234737.1340642-1-surenb@google.com>
 <20260910234737.1340642-5-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910234737.1340642-5-surenb@google.com>

On Thu, Sep 10, 2026 at 04:47:34PM -0700, Suren Baghdasaryan wrote:
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

Hmm did I? Where did I suggest this?... I guess a while ago?

I mean I also happen to suggest it in the previous patch review :) but that was
sent after you sent this...

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>

I don't love hacking a hack for a patch and then unhack it in the next in a
slightly roundabout way.

Feels like this should be squashed. And a wrapper function for
start=vma->vm_start should be used rather than duplicating that param
constantly.

> ---
>  fs/proc/task_mmu.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3c40c9cbb9c9..ecce7ce116cb 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1246,21 +1246,27 @@ get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
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

This seems to be describing what callers do not what the function does unless
I'm missing something? So that's really the wrong place for it.

I think the description of why it might be a partial walk belongs to the bit of
code that actually tries to do a partial walk.

Anyway as per below I think separate partial/full functions make sense and there
it can simply be described as walking either the full or part of the VMA.

>   */
>  static void smap_gather_stats(struct proc_maps_private *priv,
>  			      struct vm_area_struct *vma,
> -			      struct mem_size_stats *mss, unsigned long start)
> +			      struct mem_size_stats *mss,
> +			      unsigned long start)
>  {
>  	const struct mm_walk_ops *ops = get_smaps_walk_ops(priv);
>  	const bool is_partial = start > vma->vm_start;
>
>  	/* Invalid start */
> -	if (start >= vma->vm_end)
> +	if (start < vma->vm_start || start >= vma->vm_end)
>  		return;
>
>  	if (vma == get_gate_vma(priv->lock_ctx.mm))
> @@ -1285,10 +1291,7 @@ static void smap_gather_stats(struct proc_maps_private *priv,
>  			mss->swap += shmem_swapped;
>  	}
>
> -	if (!start)
> -		walk_page_vma(vma, ops, mss);
> -	else
> -		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
> +	walk_page_range_vma(vma, start, vma->vm_end, ops, mss);

I mean obviously am in favour of this as I suggested it in the last patch :)

>
>  	reacquire_rcu(priv);
>  }
> @@ -1343,7 +1346,7 @@ static int show_smap(struct seq_file *m, void *v)
>  	struct vm_area_struct *vma = v;
>  	struct mem_size_stats mss = {};
>
> -	smap_gather_stats(priv, vma, &mss, 0);
> +	smap_gather_stats(priv, vma, &mss, vma->vm_start);
>
>  	show_map_vma(m, vma);
>
> @@ -1396,7 +1399,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>
>  	vma_start = vma->vm_start;
>  	do {
> -		smap_gather_stats(priv, vma, &mss, 0);
> +		smap_gather_stats(priv, vma, &mss, vma->vm_start);
>  		last_vma_end = vma->vm_end;
>
>  		/*
> @@ -1455,7 +1458,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>
>  			/* Case 1 and 2 above */
>  			if (vma->vm_start >= last_vma_end) {
> -				smap_gather_stats(priv, vma, &mss, 0);
> +				smap_gather_stats(priv, vma, &mss, vma->vm_start);

I mean this is all horrible, having to pass vma->vm_start explicitly.

Although better than the hack that gets compounded in patch 3.

There 4 invocations of smap_gather_stats(), only one of them passes a
non-vma->vm_start start.

So it'd make more sense to just make smap_gather_stats() lose its 3rd param and
have it call smap_gather_stats_range(), then have 1 invocation of
smaps_gather_stats_range() directly, as per suggestion in last patch.

Or something similar to that.


>  				last_vma_end = vma->vm_end;
>  				continue;
>  			}
> --
> 2.55.0.1007.g17ff1f9808-goog
>

--
Cheers, Lorenzo
