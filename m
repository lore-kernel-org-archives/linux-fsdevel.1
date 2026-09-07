Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA71519906
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799779; cv=none; b=PUCFBHRIHe4j3VREQLwhNeobJKYhANVg9VKYMTDm2J7URsuBKeE8ebS6CAlrgwoGWjnKGKIkj6NOdJzSTTFwZs8ebDc5hBirLQ93wo20CZDz9YEMv/xLFblAGM4FILoO3FVnHqejQDXSGRAxa/ne8dyjmRKnal1Zgc294JMx4fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799779; c=relaxed/simple;
	bh=aiOV96iWD1E/8/sYj8GdsqnibwPCG/X4Yj+j2mG5QNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr8d52WW60I4SAonGhdEOZhzr8phqKwxDMmmGYPtOQWLCZtwxCwLLnu2GHAAxD8zBHda1lLUaAwlF+m6uI8ym/0u77TvwQ+fi3vEQPDERF7noMpleRdQ8QHvwRF3cybYvsDL6j3OEmYWXzjEyH7VTUPPZQbBaJVcpCDHdhZ8NfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QQpm8w8q; arc=none smtp.client-ip=91.218.175.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QQpm8w8q"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aiOV96iWD1E/8/sYj8GdsqnibwPCG/X4Yj+j2mG5QNs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788799774; v=1; x=1789404574;
 b=QQpm8w8qtlyl4A29Mq6LnWHurYgAMCMDz+IP0s22x/N0nM/hcuEbmZ5o0tzh+VcdNjCr3Reh
 OFnSHnHBZZNkvbzy9FKBNEf0SBsQLLgMuHSlBS+PPYe0YiqW1KLbxCn251Ze/xK9zS4bEAuMvbB
 6T8MKteHfhqzXgK7TUMxIYYY=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id b961d15e53dc88c5;
	Mon, 07 Sep 2026 16:49:34 +0000
X-Mizu-Trace-ID: b961d15e53dc88c5
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
Subject: Re: [PATCH v2 2/5] proc/task_mmu: remove unnecessary inlines in function definitions
Date: Mon,  7 Sep 2026 09:49:30 -0700
Message-ID: <20260907164931.131215-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907063918.3432401-3-surenb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  6 Sep 2026 23:39:15 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> It was pointed out in the previous reviews of this code that many
> functions are specified as inline, which is unnecessary as the compile
> can make that decision by itself. Cleanup these definitions.
> 
> No functional change intended.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/proc/task_mmu.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Most of these functions would be inlined anyways so should be ok.

Curious if there was a change in binary size with this?

Acked-by: Usama Arif <usama.arif@linux.dev>

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
> 
