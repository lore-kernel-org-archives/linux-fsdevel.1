Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F2A2F2910;
	Tue,  9 Jun 2026 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993684; cv=none; b=n/lRewqsGXF/fn7yEYlZPXXX+lBQzGnLd7udND9od/sc0KvBR4IcCN+qlz33qwHfn7N7bVbhgJpYB9+xyIkXAv24OZdOIMmkK1aPBBFbLk/pRiJAHIFdFmpZtupJXPnLmx01CvcTqXlyFDwbmf6grjRDpnN+qQ2h7rrdiRs8iRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993684; c=relaxed/simple;
	bh=J7ffoKHHHfwk3VrhGHgz6HIm/QqvAN8OPo/RlTINeZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8zdvi76I9nn4GKnVQMqDv4LALqZ36vr/NDnkIZOl2ImMbSoqbvrl3bq5CCtiPDplUzzM4681tE9SBOk2+aVXhXSU9nLPmTh2dgvaEV68e+nFEJ3gTqNev/4sRl0Rm2NlGM+wAtgdssf8HsvyEyKSttv18jK1jEwx5xgxSMGMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePD+sA10; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePD+sA10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36681F00893;
	Tue,  9 Jun 2026 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780993682;
	bh=KUTWvkYgd4SUoz3GQ3EreKamUH7kzM6u+lTKw2+UhB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ePD+sA10auk+0GlzUNcXqGiA8HKi9Y2JwdUhisxwcywX35moIyMcANbTc/VRTQR51
	 MFUniUu0p7IYhynxwNLyu9DK2+4bdeMicIOdPck5dsrai7aWkMWZ8Gzqvl14HSbcHy
	 YE5h+kNNN5zaeYqYUloL6UIVR+QXltPLiXsoeqRd8IxXJvKqRZ8/vC/jZP2nacV6tm
	 JF7koe1kXEKnDblzzOl1pQvxXc1S1WrIYcWyOVnXhC2qkVLQYeaHU72h3uc885vivn
	 T2PDleobwrFY4cxvaH2202R6Kv63uQcLtOK9UdL4CUrq1Z8cSLbQJy8vuLu/cH+IjJ
	 enacxdiPUbdgw==
Date: Tue, 9 Jun 2026 09:27:56 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: change lock_vma_range() to return
 error code
Message-ID: <aifEZEisSFABmYiW@lucifer>
References: <20260606015729.1837935-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606015729.1837935-1-surenb@google.com>

On Fri, Jun 05, 2026 at 06:57:28PM -0700, Suren Baghdasaryan wrote:
> To correctly propagate error code from lock_vma_range(), change it to
> return the error code instead of the boolean. This simplifies error
> propagation code.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Logic LGTM, couple nits below, but:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  fs/proc/task_mmu.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index d32408f7cd5e..023422fcee12 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -162,13 +162,13 @@ static void unlock_ctx_vma(struct proc_maps_locking_ctx *lock_ctx)
>  	}
>  }
>
> -static inline bool lock_vma_range(struct seq_file *m,
> -				  struct proc_maps_locking_ctx *lock_ctx)
> +static inline int lock_vma_range(struct seq_file *m,

Could drop the unnecessary inline here while we're here.

> +				 struct proc_maps_locking_ctx *lock_ctx)
>  {
>  	rcu_read_lock();
>  	reset_lock_ctx(lock_ctx);
>
> -	return true;
> +	return 0;
>  }
>
>  static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_ctx)
> @@ -245,10 +245,10 @@ static inline void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
>  	mmap_read_unlock(lock_ctx->mm);
>  }
>
> -static inline bool lock_vma_range(struct seq_file *m,
> +static inline int lock_vma_range(struct seq_file *m,

Same comment as above.

>  				  struct proc_maps_locking_ctx *lock_ctx)
>  {
> -	return lock_ctx_mm(lock_ctx) == 0;
> +	return lock_ctx_mm(lock_ctx);
>  }
>
>  static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_ctx)
> @@ -311,6 +311,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  	struct proc_maps_locking_ctx *lock_ctx;
>  	loff_t last_addr = *ppos;
>  	struct mm_struct *mm;
> +	int err;
>
>  	/* See m_next(). Zero at the start or after lseek. */
>  	if (last_addr == SENTINEL_VMA_END)
> @@ -328,11 +329,12 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  		return NULL;
>  	}
>
> -	if (!lock_vma_range(m, lock_ctx)) {
> +	err = lock_vma_range(m, lock_ctx);
> +	if (err) {
>  		mmput(mm);
>  		put_task_struct(priv->task);
>  		priv->task = NULL;
> -		return ERR_PTR(-EINTR);
> +		return ERR_PTR(err);
>  	}
>
>  	/*
>
> base-commit: e178a530a81621a29efbca49b3b78202a18236e4
> --
> 2.54.0.1032.g2f8565e1d1-goog
>
