Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB359574C;
	Tue,  8 Sep 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890355; cv=none; b=UEIYv7zrNvJYkDMHkXRyVM4jZB9Dc3yS8CoxtdM27Gcc9p53VIrX40k+PnUgYe8t6ddeUcqTvDJ6PhH2nPGETh64vBDsJ9xXvjAVcjDZGLFHlXd8JW1lsPffSKB2lK7V4N5//pwri5/SES9XrHIY4NQhQkxf8kGvIBIeds30KUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890355; c=relaxed/simple;
	bh=32KXrupUTLqnHQC8oRdO8Vkl4XdBfSu/CHBGO6Vpa+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeGVdoXRgSebWYjvVHGAVj4HOIprj1Myexj7Q8ODXQMFnJ4pe2l9qdadfdA7u1+h9KwrQeonFBlKecVgV4iW6+N4w+KiNw69yHZakXlnyfVU5PINmTXiNPFgne/vqvcI5HaS19LS6+Z1IGbSTbKqGcc/u0e9de6eLYZkDcG/Ua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f5D4Cy2E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f5D4Cy2E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vRhCXB5d+1xHpm+rHDVsJTBtyYPUGsVwslLkzk8euVU=; b=f5D4Cy2ENteVaqqdHK2Qw8PBcd
	ge7qhzuCUKrwp3+FuAUV+NnRGTHl8qITS0yLk5+4d9u+OHSLGZb3QmAjowan7mBqZ//bzKve4CeTb
	XUUrhD3lzgxpoZfMMkCTlbtUDcCKqMOwQKSzq6RMP0Nth6d/wFfQUDbjKA/F1Qn8IhepP+I10UYFX
	SjFH04NFhDqGX0ckuS4cyw1LJqd19MhJdLMJM5l1rxakfpKT4khy1/ZtpN1dO8ZEHdZM1SG34UvLO
	LluzgX5rw6RKDldJrK3wVIQTTvRp7trL1ASSxe1wL2FuGiZJSEIlYUKJH4wKrON6S6KPnI69QVuth
	52m+rnaw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4066-00000009v1E-3w6K;
	Tue, 08 Sep 2026 17:59:07 +0000
Date: Tue, 8 Sep 2026 13:58:41 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, ljs@kernel.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] proc/task_mmu: remove unnecessary helpers
Message-ID: <qtx5xilsefyuqmhybk6s4i7pogz36tiara6wfayijj6oahbpu2@vrafyynbnb5d>
References: <20260907063918.3432401-1-surenb@google.com>
 <20260907063918.3432401-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907063918.3432401-2-surenb@google.com>

On 26/09/06 11:39PM, Suren Baghdasaryan wrote:
> When per-vma locks were behind a config option, a number of helper
> functions were needed to simplify the locking code. Now that these
> locks are universally available, we can do a little cleanup.
> Remove lock_vma_range(), unlock_vma_range(), query_vma_setup(),
> query_vma_teardown() helpers.
> 
> No functional change intended.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>

> ---
>  fs/proc/task_mmu.c | 67 ++++++++++++----------------------------------
>  1 file changed, 17 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e671b4fd8ded..2f500d639db5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -160,25 +160,6 @@ static void unlock_ctx_vma(struct proc_maps_locking_ctx *lock_ctx)
>  	}
>  }
>  
> -static inline bool lock_vma_range(struct seq_file *m,
> -				  struct proc_maps_locking_ctx *lock_ctx)
> -{
> -	rcu_read_lock();
> -	reset_lock_ctx(lock_ctx);
> -
> -	return true;
> -}
> -
> -static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_ctx)
> -{
> -	if (lock_ctx->mmap_locked) {
> -		unlock_ctx_mm(lock_ctx);
> -	} else {
> -		unlock_ctx_vma(lock_ctx);
> -		rcu_read_unlock();
> -	}
> -}
> -
>  static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
>  					   loff_t last_pos)
>  {
> @@ -286,13 +267,8 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  		return NULL;
>  	}
>  
> -	if (!lock_vma_range(m, lock_ctx)) {
> -		mmput(mm);
> -		put_task_struct(priv->task);
> -		priv->task = NULL;
> -		return ERR_PTR(-EINTR);
> -	}
> -
> +	rcu_read_lock();
> +	reset_lock_ctx(lock_ctx);
>  	/*
>  	 * Reset current position if last_addr was set before
>  	 * and it's not a sentinel.
> @@ -325,7 +301,12 @@ static void m_stop(struct seq_file *m, void *v)
>  		return;
>  
>  	release_task_mempolicy(priv);
> -	unlock_vma_range(&priv->lock_ctx);
> +	if (priv->lock_ctx.mmap_locked) {
> +		unlock_ctx_mm(&priv->lock_ctx);
> +	} else {
> +		unlock_ctx_vma(&priv->lock_ctx);
> +		rcu_read_unlock();
> +	}
>  	mmput(mm);
>  	put_task_struct(priv->task);
>  	priv->task = NULL;
> @@ -518,21 +499,6 @@ static int pid_maps_open(struct inode *inode, struct file *file)
>  		PROCMAP_QUERY_VMA_FLAGS				\
>  )
>  
> -static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
> -{
> -	reset_lock_ctx(lock_ctx);
> -
> -	return 0;
> -}
> -
> -static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
> -{
> -	if (lock_ctx->mmap_locked)
> -		unlock_ctx_mm(lock_ctx);
> -	else
> -		unlock_ctx_vma(lock_ctx);
> -}
> -
>  static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
>  						     unsigned long addr)
>  {
> @@ -653,12 +619,7 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
>  	if (!mm || !mmget_not_zero(mm))
>  		return -ESRCH;
>  
> -	err = query_vma_setup(&lock_ctx);
> -	if (err) {
> -		mmput(mm);
> -		return err;
> -	}
> -
> +	reset_lock_ctx(&lock_ctx);
>  	vma = query_matching_vma(&lock_ctx, karg.query_addr, karg.query_flags);
>  	if (IS_ERR(vma)) {
>  		err = PTR_ERR(vma);
> @@ -732,7 +693,10 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
>  		vm_file = get_file(vma->vm_file);
>  
>  	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
> -	query_vma_teardown(&lock_ctx);
> +	if (lock_ctx.mmap_locked)
> +		unlock_ctx_mm(&lock_ctx);
> +	else
> +		unlock_ctx_vma(&lock_ctx);
>  	mmput(mm);
>  
>  	if (karg.build_id_size) {
> @@ -773,7 +737,10 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
>  	return 0;
>  
>  out:
> -	query_vma_teardown(&lock_ctx);
> +	if (lock_ctx.mmap_locked)
> +		unlock_ctx_mm(&lock_ctx);
> +	else
> +		unlock_ctx_vma(&lock_ctx);
>  	mmput(mm);
>  out_file:
>  	if (vm_file)
> -- 
> 2.55.0.979.g7e5102b832-goog
> 
