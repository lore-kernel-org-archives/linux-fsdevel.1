Received: from mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DF50C282
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799528; cv=none; b=FUj02v8X4ZwbsD6DfJp/LCdmHhYQEEi2BfgePDYMvVBBmrFZhBSrfJ7UdljjQJtXC3gss6iujCM9PazREkkDvQP5uxuqz3vQMZ419cz4Yabm6Kk+3Jix07Ic9UQC893OXWozqSYNqr16Ev6Sl9lH4pVxo7Q6JdH3AHi0Qjlj83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799528; c=relaxed/simple;
	bh=mA7P/Qe1tvxUEQLZlPrgfbJg0c6VIZe0R0iXWMkfLmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGPCDel3T7GRtQdhTv1erMunR59HTTgkX6/XiVOQ2KDaDLHQLnqvkmMhtlkLrG4G6fu1OmB+FkWTvjyUFmn4vygVwLNcp4u3cFG7IoFAoosXoA6L9XfTvyadFJfis5k7hWuN0HLvq1sOHLIIfOlhodVWEHq5BWOaz//aS/konpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E11nSGYU; arc=none smtp.client-ip=95.215.58.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E11nSGYU"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mA7P/Qe1tvxUEQLZlPrgfbJg0c6VIZe0R0iXWMkfLmM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788799523; v=1; x=1789404323;
 b=E11nSGYUdFDOKkZEOPkTm2YxFAzEOKlNI8sSZFUvCSIyQLC1YygSwlGE1iHVJFpLwtucE0Fu
 YYktdxxUDnVQwqq3ue65c/Yo6t0OAYZjFqLPLh2RH9D8nxDUdxFacmtLDoLfdt4YSJlymhzQF7j
 ea+Dmb7tbknUTrQYlJ+hOm2g=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id f0a5260ef7ab4742;
	Mon, 07 Sep 2026 16:45:04 +0000
X-Mizu-Trace-ID: f0a5260ef7ab4742
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	david@redhat.com,
	willy@infradead.org,
	jannh@google.com,
	paulmck@kernel.org,
	pfalcato@suse.de,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] proc/task_mmu: remove unnecessary helpers
Date: Mon,  7 Sep 2026 09:44:57 -0700
Message-ID: <20260907164500.3920334-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907063918.3432401-2-surenb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  6 Sep 2026 23:39:14 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> When per-vma locks were behind a config option, a number of helper
> functions were needed to simplify the locking code. Now that these
> locks are universally available, we can do a little cleanup.
> Remove lock_vma_range(), unlock_vma_range(), query_vma_setup(),
> query_vma_teardown() helpers.
> 
> No functional change intended.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/proc/task_mmu.c | 67 ++++++++++++----------------------------------
>  1 file changed, 17 insertions(+), 50 deletions(-)

Change makes sense independent of the series as well.

Acked-by: Usama Arif <usama.arif@linux.dev>

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
> 
