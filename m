Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD34A3414;
	Thu, 10 Sep 2026 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054991; cv=none; b=J2KHh3P3KKoS3vUt+J5BcIViv3CDpN5OtHL2lz1zFLzm7//D7KlBRS7L2RaAX8fXxecVe08f2hMrBQ03dokgSkpxZljMklS6q5OFa8JhishhWArnt0yz4dQzd5e1gyebukuOwN88lxPwyfrOwehuUY3DYnIbqOE4MkKPrlPsJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054991; c=relaxed/simple;
	bh=w+0KqQh4wxbH4rrrBfmQMPhNRMQyYOpSoboeeUpwggI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3WeoOn1zk70mHYB6QeC1elbt1kMIpcFvkfBr8myBOOdsaaxxu3GHPJTmq+twfl9VHZrf3F0q4t7uJQHnYMLixnF9Ij7UFt4RJFWY17vpYmv7uFX/CwqctgblYdeckbaCBtdRVwYJ4k85ym6jvcRyNyeH93pW1aElZjuhJZhQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtcfTxtw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtcfTxtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F481F000FF;
	Thu, 10 Sep 2026 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054989;
	bh=jdfnsdvWI0jRNqVLMdcR0r8HJLdhTYwH56oScH4f4Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PtcfTxtw45R5MAhwdS6U8KTXfpVokzs3jxEpTI9fNqRYbNG8tO8oIN6VOk4J/zpDz
	 l7fF5oH34xgjuorX5jaiX4Okbtal8yV2+Ib/6+GIFhJDLrwb322Bveh2+XiuaylYCO
	 AoVYaUg2TSwF1stGN0IDxRm6IkaSSDb3QA6faezOvPq743U0knl01zmkYvEXucPnkg
	 k2ony48DnokaTCyyOYp3/M1dr9W8WQ3Dp8YpTbf8CpSybrx/yDod3z5IgtNcC4cM1u
	 FDlYntAFMq7ttb+PBptS7mI34Tg5IF8nzjCEirqMMhG63KvuJxmnK5W7yvjTISPWaw
	 TLY8z5R14Sm8Q==
Date: Thu, 10 Sep 2026 16:43:03 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] proc/task_mmu: remove unnecessary helpers
Message-ID: <aqLOusjRNlQtQsj-@gremlin>
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

On Sun, Sep 06, 2026 at 11:39:14PM -0700, Suren Baghdasaryan wrote:
> When per-vma locks were behind a config option, a number of helper
> functions were needed to simplify the locking code. Now that these
> locks are universally available, we can do a little cleanup.
> Remove lock_vma_range(), unlock_vma_range(), query_vma_setup(),
> query_vma_teardown() helpers.

Oh nice :)

>
> No functional change intended.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

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

--
Cheers, Lorenzo
