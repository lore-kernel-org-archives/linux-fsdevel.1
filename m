Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774133451AA
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014180; cv=none; b=Tnd4SP4HESZYlYCG4F6MxYUu2C3YnwtR9w0vzPalzCzwt/uljMTqRteJGGnCSVK3dsbNLWCNl9F1b0qvZOCUVCNyKETNkRHm7l1CrjvBEO7Wy2iB6o0b8jW8Zd9neBYR7y6ifALW/HFzKYLR61C54IzUFFw2soKYx0dK3yThsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014180; c=relaxed/simple;
	bh=VYuIwte0GfDMmR5ih5xkZBZaUjo9V52pbxc5tYFhD28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mH5aeUUQcoGV9K8iWpBBykXEDznTMk+ZHAU/zF+77Lmkzpe+Jiv0UMHvGcPwUoTpt74gKSYOTAf2Ttc0oKsYaKzw1eeFMTuM0Vp6xpLehlhIrjsN3/9pJ1x7MW8WcQubP0QKuK+Fk0F3NEok3LQtr/PjJfn5CVTsxCXd7jxx0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTs0B25W; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTs0B25W"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so6774245c88.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777014178; x=1777618978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PKagbOC73AJ/9NwYWLL6SuYKvFB16xXT/WyLTw4llzo=;
        b=OTs0B25WN5dhiBkh4dGHNdYMCBuVpBr+gVC4qAfyVaxb0A4G266hwFpcnxSrHldD9p
         Bmg5c1rUQONR+M/7ULpykNXIH7a91Z253lEfDEOIBP+fd0OgdKLL+M1g6Lt6R49roDwy
         VqqC92f47WodY0vU8YOAvR22X2brML1Gca8XVgptHHOIurmJCoufgYR9+73ArPfqsq7c
         1u+MtMgeDbc/rgN8kH8GGx0Fwu5H+2loDVzpLhVH/PkPJe1M2frX9f2I+pD11OQ6y3zp
         AfKbxw+hu6/iw+k/nvLyLS643wJP/S0+JlU1gvUp45uBKHEaml1jnAuw7dw9wt5Sfh/o
         nzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777014178; x=1777618978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKagbOC73AJ/9NwYWLL6SuYKvFB16xXT/WyLTw4llzo=;
        b=PsNy5aYIYUc1cV8x1KMFNPNocg2QSSqSPp4EPp2merM8pPy4UbhFv4B6J2dbic1epw
         VvSbjs/60Epui47zesjNwrWix3s4D2Yg9XPb89bGE4oAOquDclsPwIGAuQ6w79VmeoR4
         57hItwNW4csc2gKszuFtZO5S034ZvAzeCXBFh6yLHPQJu7gb/c+QD0cq4qDcBVZNg9fe
         dNRR0MAHZK5+6zpKWrmvnhzFwmhmZlXN4ptSFzcE+wGj6pGZUpp+iTOr+asrHyKnrsFE
         ypfpD7GEvGIGFqIFMppGBLzpB7zpdBGfWUmKKLuDkuh5+jGt93SGAYHod9lP3d8afI2d
         HFsA==
X-Forwarded-Encrypted: i=1; AFNElJ/8pEm9vl+nmShe3VF6uPPIYQsigBMZys8d64RzOtqxR8nQ77fMUUWi+qzvvH74+fhrDlsk1+7IZsd2p+ay@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47AXdV23A7xdqDLjowGdL7iz+5oOdBBrkmq71Dp6s89mTSys+
	cqjjrycuAPaM3Z7fOPHuxHKg4HGDBfdw0V8tgXPigOtx/Mz2+hDRN6khS1f31LUpHdKTMuVnvka
	9FtM8dQ==
X-Received: from dlah23.prod.google.com ([2002:a05:701b:2617:b0:12b:f569:153f])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1282:b0:127:366f:8bb7
 with SMTP id a92af1059eb24-12c73f976a5mr12956509c88.25.1777014177368; Fri, 24
 Apr 2026 00:02:57 -0700 (PDT)
Date: Fri, 24 Apr 2026 00:02:32 -0700
In-Reply-To: <20260424070234.190145-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424070234.190145-1-surenb@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424070234.190145-2-surenb@google.com>
Subject: [PATCH 1/3] fs/proc/task_mmu: read proc/pid/{smaps|numa_maps} under
 per-vma lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	shuah@kernel.org, hsukrut3@gmail.com, richard.weiyang@gmail.com, 
	reddybalavignesh9979@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

proc/pid/{smaps|numa_maps} can be read using the combination of RCU and
VMA read locks, similar to proc/pid/maps. RCU is required to safely
traverse the VMA tree and VMA lock stabilizes the VMA being processed
and the pagetable walk.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 193 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 154 insertions(+), 39 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 751b9ba160fb..96cfea252db6 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -132,6 +132,22 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 
 #ifdef CONFIG_PER_VMA_LOCK
 
+static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
+{
+	int ret = mmap_read_lock_killable(lock_ctx->mm);
+
+	if (!ret)
+		lock_ctx->mmap_locked = true;
+
+	return ret;
+}
+
+static inline void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
+{
+	mmap_read_unlock(lock_ctx->mm);
+	lock_ctx->mmap_locked = false;
+}
+
 static void reset_lock_ctx(struct proc_maps_locking_ctx *lock_ctx)
 {
 	lock_ctx->locked_vma = NULL;
@@ -146,25 +162,11 @@ static void unlock_ctx_vma(struct proc_maps_locking_ctx *lock_ctx)
 	}
 }
 
-static const struct seq_operations proc_pid_maps_op;
-
 static inline bool lock_vma_range(struct seq_file *m,
 				  struct proc_maps_locking_ctx *lock_ctx)
 {
-	/*
-	 * smaps and numa_maps perform page table walk, therefore require
-	 * mmap_lock but maps can be read with locking just the vma and
-	 * walking the vma tree under rcu read protection.
-	 */
-	if (m->op != &proc_pid_maps_op) {
-		if (mmap_read_lock_killable(lock_ctx->mm))
-			return false;
-
-		lock_ctx->mmap_locked = true;
-	} else {
-		rcu_read_lock();
-		reset_lock_ctx(lock_ctx);
-	}
+	rcu_read_lock();
+	reset_lock_ctx(lock_ctx);
 
 	return true;
 }
@@ -172,7 +174,7 @@ static inline bool lock_vma_range(struct seq_file *m,
 static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_ctx)
 {
 	if (lock_ctx->mmap_locked) {
-		mmap_read_unlock(lock_ctx->mm);
+		unlock_ctx_mm(lock_ctx);
 	} else {
 		unlock_ctx_vma(lock_ctx);
 		rcu_read_unlock();
@@ -213,17 +215,45 @@ static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 	return true;
 }
 
+static inline void drop_rcu(struct proc_maps_private *priv)
+{
+	if (priv->lock_ctx.mmap_locked)
+		return;
+
+	rcu_read_unlock();
+}
+
+static inline void reacquire_rcu(struct proc_maps_private *priv)
+{
+	if (priv->lock_ctx.mmap_locked)
+		return;
+
+	rcu_read_lock();
+	/* Reinitialize the iterator. */
+	vma_iter_set(&priv->iter, priv->lock_ctx.locked_vma->vm_end);
+}
+
 #else /* CONFIG_PER_VMA_LOCK */
 
+static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
+{
+	return mmap_read_lock_killable(lock_ctx->mm);
+}
+
+static inline void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
+{
+	mmap_read_unlock(lock_ctx->mm);
+}
+
 static inline bool lock_vma_range(struct seq_file *m,
 				  struct proc_maps_locking_ctx *lock_ctx)
 {
-	return mmap_read_lock_killable(lock_ctx->mm) == 0;
+	return lock_ctx_mm(lock_ctx) == 0;
 }
 
 static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_ctx)
 {
-	mmap_read_unlock(lock_ctx->mm);
+	unlock_ctx_mm(lock_ctx);
 }
 
 static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
@@ -238,6 +268,9 @@ static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 	return false;
 }
 
+static inline void drop_rcu(struct proc_maps_private *priv) {}
+static inline void reacquire_rcu(struct proc_maps_private *priv) {}
+
 #endif /* CONFIG_PER_VMA_LOCK */
 
 static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
@@ -538,12 +571,10 @@ static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
 
 static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
 {
-	if (lock_ctx->mmap_locked) {
-		mmap_read_unlock(lock_ctx->mm);
-		lock_ctx->mmap_locked = false;
-	} else {
+	if (lock_ctx->mmap_locked)
+		unlock_ctx_mm(lock_ctx);
+	else
 		unlock_ctx_vma(lock_ctx);
-	}
 }
 
 static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
@@ -1280,16 +1311,64 @@ static const struct mm_walk_ops smaps_shmem_walk_ops = {
 	.walk_lock		= PGWALK_RDLOCK,
 };
 
+#ifdef CONFIG_PER_VMA_LOCK
+
+static const struct mm_walk_ops smaps_walk_vma_lock_ops = {
+	.pmd_entry		= smaps_pte_range,
+	.hugetlb_entry		= smaps_hugetlb_range,
+	.walk_lock		= PGWALK_VMA_RDLOCK_VERIFY,
+};
+
+static const struct mm_walk_ops smaps_shmem_walk_vma_lock_ops = {
+	.pmd_entry		= smaps_pte_range,
+	.hugetlb_entry		= smaps_hugetlb_range,
+	.pte_hole		= smaps_pte_hole,
+	.walk_lock		= PGWALK_VMA_RDLOCK_VERIFY,
+};
+
+static inline const struct mm_walk_ops *
+get_smaps_walk_ops(struct proc_maps_private *priv)
+{
+	if (priv->lock_ctx.mmap_locked)
+		return &smaps_walk_ops;
+	return &smaps_walk_vma_lock_ops;
+}
+
+static inline const struct mm_walk_ops *
+get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
+{
+	if (priv->lock_ctx.mmap_locked)
+		return  &smaps_shmem_walk_ops;
+	return &smaps_shmem_walk_vma_lock_ops;
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+static inline const struct mm_walk_ops *
+get_smaps_walk_ops(struct proc_maps_private *priv)
+{
+	return &smaps_walk_ops;
+}
+
+static inline const struct mm_walk_ops *
+get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
+{
+	return &smaps_shmem_walk_ops;
+}
+
+#endif /* CONFIG_PER_VMA_LOCK */
+
 /*
  * Gather mem stats from @vma with the indicated beginning
  * address @start, and keep them in @mss.
  *
  * Use vm_start of @vma as the beginning address if @start is 0.
  */
-static void smap_gather_stats(struct vm_area_struct *vma,
-		struct mem_size_stats *mss, unsigned long start)
+static void smap_gather_stats(struct proc_maps_private *priv,
+			      struct vm_area_struct *vma,
+			      struct mem_size_stats *mss, unsigned long start)
 {
-	const struct mm_walk_ops *ops = &smaps_walk_ops;
+	const struct mm_walk_ops *ops = get_smaps_walk_ops(priv);
 
 	/* Invalid start */
 	if (start >= vma->vm_end)
@@ -1312,15 +1391,24 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 					!(vma->vm_flags & VM_WRITE))) {
 			mss->swap += shmem_swapped;
 		} else {
-			ops = &smaps_shmem_walk_ops;
+			ops = get_smaps_shmem_walk_ops(priv);
 		}
 	}
 
-	/* mmap_lock is held in m_start */
+	/* Skip walking pages if gate VMA */
+	if (vma == get_gate_vma(priv->lock_ctx.mm))
+		return;
+
+	/*
+	 * Need to drop RCU read lock before the walk due to possibility of sleep.
+	 * Note that the VMA is still locked.
+	 */
+	drop_rcu(priv);
 	if (!start)
 		walk_page_vma(vma, ops, mss);
 	else
 		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
+	reacquire_rcu(priv);
 }
 
 #define SEQ_PUT_DEC(str, val) \
@@ -1369,10 +1457,11 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 
 static int show_smap(struct seq_file *m, void *v)
 {
+	struct proc_maps_private *priv = m->private;
 	struct vm_area_struct *vma = v;
 	struct mem_size_stats mss = {};
 
-	smap_gather_stats(vma, &mss, 0);
+	smap_gather_stats(priv, vma, &mss, 0);
 
 	show_map_vma(m, vma);
 
@@ -1413,7 +1502,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		goto out_put_task;
 	}
 
-	ret = mmap_read_lock_killable(mm);
+	ret = lock_ctx_mm(&priv->lock_ctx);
 	if (ret)
 		goto out_put_mm;
 
@@ -1425,7 +1514,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 	vma_start = vma->vm_start;
 	do {
-		smap_gather_stats(vma, &mss, 0);
+		smap_gather_stats(priv, vma, &mss, 0);
 		last_vma_end = vma->vm_end;
 
 		/*
@@ -1434,8 +1523,8 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		 */
 		if (mmap_lock_is_contended(mm)) {
 			vma_iter_invalidate(&vmi);
-			mmap_read_unlock(mm);
-			ret = mmap_read_lock_killable(mm);
+			unlock_ctx_mm(&priv->lock_ctx);
+			ret = lock_ctx_mm(&priv->lock_ctx);
 			if (ret) {
 				release_task_mempolicy(priv);
 				goto out_put_mm;
@@ -1484,14 +1573,14 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 			/* Case 1 and 2 above */
 			if (vma->vm_start >= last_vma_end) {
-				smap_gather_stats(vma, &mss, 0);
+				smap_gather_stats(priv, vma, &mss, 0);
 				last_vma_end = vma->vm_end;
 				continue;
 			}
 
 			/* Case 4 above */
 			if (vma->vm_end > last_vma_end) {
-				smap_gather_stats(vma, &mss, last_vma_end);
+				smap_gather_stats(priv, vma, &mss, last_vma_end);
 				last_vma_end = vma->vm_end;
 			}
 		}
@@ -1505,7 +1594,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 	__show_smap(m, &mss, true);
 
 	release_task_mempolicy(priv);
-	mmap_read_unlock(mm);
+	unlock_ctx_mm(&priv->lock_ctx);
 
 out_put_mm:
 	mmput(mm);
@@ -3291,6 +3380,31 @@ static const struct mm_walk_ops show_numa_ops = {
 	.walk_lock = PGWALK_RDLOCK,
 };
 
+#ifdef CONFIG_PER_VMA_LOCK
+static const struct mm_walk_ops show_numa_vma_lock_ops = {
+	.hugetlb_entry = gather_hugetlb_stats,
+	.pmd_entry = gather_pte_stats,
+	.walk_lock = PGWALK_VMA_RDLOCK_VERIFY,
+};
+
+static inline const struct mm_walk_ops *
+get_show_numa_ops(struct proc_maps_private *priv)
+{
+	if (priv->lock_ctx.mmap_locked)
+		return &show_numa_ops;
+	return &show_numa_vma_lock_ops;
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+static inline const struct mm_walk_ops *
+get_show_numa_ops(struct proc_maps_private *priv)
+{
+	return &show_numa_ops;
+}
+
+#endif /* CONFIG_PER_VMA_LOCK */
+
 /*
  * Display pages allocated per node and memory policy via /proc.
  */
@@ -3335,8 +3449,9 @@ static int show_numa_map(struct seq_file *m, void *v)
 	if (is_vm_hugetlb_page(vma))
 		seq_puts(m, " huge");
 
-	/* mmap_lock is held by m_start */
-	walk_page_vma(vma, &show_numa_ops, md);
+	drop_rcu(proc_priv);
+	walk_page_vma(vma, get_show_numa_ops(proc_priv), md);
+	reacquire_rcu(proc_priv);
 
 	if (!md->pages)
 		goto out;
-- 
2.54.0.545.g6539524ca2-goog

