Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D7599A54;
	Tue,  8 Sep 2026 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890494; cv=none; b=ZAWPY08xfROcHQs7W2gQ7Fnm51cDuP4uGPkdQRkPYkAh4x9tY0Nl7GzAWUlyzhVm7HUdCH/eLOur9Ryqx1eET/2JWfRiBS/JGnsOBexClR8ZRe22m4RTOB/H6gIC9C46MaerNRtmZLmB3fuI6Gkv7qvfSDh2Wny76zDwrp5H80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890494; c=relaxed/simple;
	bh=jffbcJjZyX533plaH+t/Ntmk9wQ5IIOAWoTO7+heVIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTxP0Irvng7oyOl3p8qq+WS6s8QsBm09gYLrDT80sa4rd/uqw0Zo5OgqZjKV2WJSFLORr6I4C6S/wbvoOgrBikCmv7DFrteudU1yDx8yI2MLrWdoshoVj3Xv9seHSwZWq4EBexzpxnsxiF4INjfKhjusSIfMSokHKK0yNTDgHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Va7qD+HD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Va7qD+HD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EQMndwLikicf9hMmUikVbvPjGR5uBr5nZgfo2OLpEtE=; b=Va7qD+HDw3S4h9aSPyQgnAlWnU
	N1idi8rRpV89fjRp3sDqjI9VStixM0V1+4mBocGHspRDoVGeIXfmU3Y/VwdfFm0MuqRSdUTsUuJe0
	buTdYA5WIPNZ4Or8P4nnZCWBV+UL1bYy6GNzeB+CK2ocU89druwaY3XSUaYa/RBF3M4DBiVyy6ACZ
	KQVemV0z3nmOqBkKuga0vVSO5WDCF5+GmCSr9WpU++vDRhCM7R7pThpe2uxKfqIir//U98OaXYpTo
	K3bhM9kKfYHIWUWu22Yfr5FaHdh2MVTdLYAE4I5DYkuBqOERsBalvGWSgCJODbQskviWhTpTXYofD
	xroXNtWw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x408L-00000009vMt-2T8F;
	Tue, 08 Sep 2026 18:01:26 +0000
Date: Tue, 8 Sep 2026 14:01:23 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, ljs@kernel.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] proc/task_mmu: remove unnecessary inlines in
 function definitions
Message-ID: <ow26rkswn72mwjcdo65sv5nahsnas3csgntapnavqiwtqhoosu@oswbvxqcglu5>
References: <20260907063918.3432401-1-surenb@google.com>
 <20260907063918.3432401-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907063918.3432401-3-surenb@google.com>

On 26/09/06 11:39PM, Suren Baghdasaryan wrote:
> It was pointed out in the previous reviews of this code that many
> functions are specified as inline, which is unnecessary as the compile
> can make that decision by itself. Cleanup these definitions.
> 
> No functional change intended.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I'd rather two tabs for the multiple lines of arguments to a function,
but it's fine either way.

Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>


> ---
>  fs/proc/task_mmu.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 2f500d639db5..9908ba32f180 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -130,7 +130,7 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
>  }
>  #endif
>  
> -static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
> +static int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
>  {
>  	int ret = mmap_read_lock_killable(lock_ctx->mm);
>  
> @@ -140,7 +140,7 @@ static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
>  	return ret;
>  }
>  
> -static inline void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
> +static void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
>  {
>  	mmap_read_unlock(lock_ctx->mm);
>  	lock_ctx->mmap_locked = false;
> @@ -177,7 +177,7 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
>  	return vma;
>  }
>  
> -static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
> +static bool fallback_to_mmap_lock(struct proc_maps_private *priv,
>  					 loff_t pos)
>  {
>  	struct proc_maps_locking_ctx *lock_ctx = &priv->lock_ctx;
> @@ -194,7 +194,7 @@ static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
>  	return true;
>  }
>  
> -static inline void drop_rcu(struct proc_maps_private *priv)
> +static void drop_rcu(struct proc_maps_private *priv)
>  {
>  	if (priv->lock_ctx.mmap_locked)
>  		return;
> @@ -202,7 +202,7 @@ static inline void drop_rcu(struct proc_maps_private *priv)
>  	rcu_read_unlock();
>  }
>  
> -static inline void reacquire_rcu(struct proc_maps_private *priv)
> +static void reacquire_rcu(struct proc_maps_private *priv)
>  {
>  	if (priv->lock_ctx.mmap_locked)
>  		return;
> @@ -1230,7 +1230,7 @@ static const struct mm_walk_ops smaps_shmem_walk_vma_lock_ops = {
>  	.walk_lock		= PGWALK_VMA_RDLOCK_VERIFY,
>  };
>  
> -static inline const struct mm_walk_ops *
> +static const struct mm_walk_ops *
>  get_smaps_walk_ops(struct proc_maps_private *priv)
>  {
>  	if (priv->lock_ctx.mmap_locked)
> @@ -1238,7 +1238,7 @@ get_smaps_walk_ops(struct proc_maps_private *priv)
>  	return &smaps_walk_vma_lock_ops;
>  }
>  
> -static inline const struct mm_walk_ops *
> +static const struct mm_walk_ops *
>  get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
>  {
>  	if (priv->lock_ctx.mmap_locked)
> @@ -1572,7 +1572,7 @@ struct clear_refs_private {
>  	enum clear_refs_types type;
>  };
>  
> -static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
> +static bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
>  {
>  	struct folio *folio;
>  
> @@ -1588,8 +1588,8 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
>  	return folio_maybe_dma_pinned(folio);
>  }
>  
> -static inline void clear_soft_dirty(struct vm_area_struct *vma,
> -		unsigned long addr, pte_t *pte)
> +static void clear_soft_dirty(struct vm_area_struct *vma, unsigned long addr,
> +			     pte_t *pte)
>  {
>  	if (!pgtable_supports_soft_dirty())
>  		return;
> @@ -1620,8 +1620,8 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
>  }
>  
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
> -static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
> -		unsigned long addr, pmd_t *pmdp)
> +static void clear_soft_dirty_pmd(struct vm_area_struct *vma,
> +				 unsigned long addr, pmd_t *pmdp)
>  {
>  	pmd_t old, pmd = *pmdp;
>  
> @@ -1646,8 +1646,8 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>  	}
>  }
>  #else
> -static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
> -		unsigned long addr, pmd_t *pmdp)
> +static void clear_soft_dirty_pmd(struct vm_area_struct *vma,
> +				 unsigned long addr, pmd_t *pmdp)
>  {
>  }
>  #endif
> @@ -1846,7 +1846,7 @@ struct pagemapread {
>  
>  #define PM_END_OF_BUFFER    1
>  
> -static inline pagemap_entry_t make_pme(u64 frame, u64 flags)
> +static pagemap_entry_t make_pme(u64 frame, u64 flags)
>  {
>  	return (pagemap_entry_t) { .pme = (frame & PM_PFRAME_MASK) | flags };
>  }
> @@ -3388,7 +3388,7 @@ static const struct mm_walk_ops show_numa_vma_lock_ops = {
>  	.walk_lock = PGWALK_VMA_RDLOCK_VERIFY,
>  };
>  
> -static inline const struct mm_walk_ops *
> +static const struct mm_walk_ops *
>  get_show_numa_ops(struct proc_maps_private *priv)
>  {
>  	if (priv->lock_ctx.mmap_locked)
> -- 
> 2.55.0.979.g7e5102b832-goog
> 
