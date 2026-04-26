Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295852E1F06
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777184846; cv=none; b=DuTgL5AgUgyok4lzeRBk1P3pobOsSlnrfzwsKK/CN4ZmhZywflWcQIjJVkqRY+Wdac5fpnBUB9z78RQkuVKV9ci80C6hzDJq4mk8h/sdPuDARdgD27c5tTnH65mPeuu71Wo3OdmoUro1l+kTLWrjr0M1r38RDZ0IxFyUFwzb1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777184846; c=relaxed/simple;
	bh=+BbKZRz1S7LJnqETourImBZXzgj3GdUQlQzX+CvpTN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A5ELYGdwIp0fX2I9SCl+xOf5nqYpUx4s1wiQWSHKQS4pEOuqkVmeOfx8cbwwp9KJbCmVElRAsyCbvSzkcjsgMe5inaZViRGa6f5EXwX0AXVlTU4wGnDbqG+A/vSKqrfJw0ukBr8XFwwKn017LtV0Rmma7ZJGaJr865Y9mQFkUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7m2oF64; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7m2oF64"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2eaf70f3b5fso886623eec.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 23:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777184844; x=1777789644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BL+hMAWdT+RqZveIZy5/Nl5gkg1RzorHCaohLNV+HgQ=;
        b=F7m2oF64HnDLURWvEHr3JP5APOEklJHUJr3sBHI/hOH7QP8ooiLwQYNLVggzuUGkfr
         qUn1+NGw0qXHIbLAzvbXAbxdzhFupjg/gidhbSCYgvAr2Dxl96aME7KNhFmD9pDn30pI
         GcRWW8eI3I+roMrf4yHHEX9wsaTAH49o9Cih/YRHVgn2/78mnbzQpQQIllU9T+oxde/q
         5krWQrr/hHsJMAIhn6J3lJmX8Cr4Cry5E/thRLA55c6+xW/4hhk1Gs00yEhJ52RhasQ1
         9UOVxpVXGrpcMNGcrOEER7Aq1xSXWu/9sStRAj1Eu2uSwSLd2SVK4Rb8/bH8B6KGImFq
         xkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777184844; x=1777789644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BL+hMAWdT+RqZveIZy5/Nl5gkg1RzorHCaohLNV+HgQ=;
        b=XG8na4t01MmoScVVwRrJ1oJRUGwUorls3eHhQCb89dovLlGQ/CjpQ8l8gdn/l/6YTe
         qDWTFA6sP2zQ8bvP9vNMbqvgYcttLVM7IBHJFevG6xbPiKXYgG22e4b7UWMlM8trH/fI
         mocQjJWfoNDkYZzoyNEn++qBDY3Z9PdluDzOVbTrq0quswV1QqG5HprFkQrtaAZsRaAH
         FsEjla4qjV+WVVIpWFUv8bm9qtXxDXPq63V26m2ijAfWl43i9p6hSfO0kUpcfWCIBHF/
         EfeveqxP9AajAOT9ZD0aKwzLfmSpDGsMbOa8Y7IeGF0MdlM3zM/C0eSMRBOkfLn0Ok8Q
         ayew==
X-Forwarded-Encrypted: i=1; AFNElJ+LQ+SiKJKbh8b2DTTRTVEYCZWRijF/z+9zVISncr0POFZIuf8NesBqyBJneCHe0BTABtYyy/uccXU7PQp2@vger.kernel.org
X-Gm-Message-State: AOJu0YzXqbfk4eYmCwj+9GJXYyXo9sDFcO/zot8oM2xA/FQ5/yMBicDU
	w/l9nLA0NMkyF28CSpFy23BokuRPT8GWe1ThMZ4JhrOOeerKMyVO9NEEbGjSVux5858R3NuMkZV
	1b2pXRw==
X-Received: from dlaj2.prod.google.com ([2002:a05:701b:2802:b0:12d:b3e9:aad1])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6606:b0:128:bae0:e044
 with SMTP id a92af1059eb24-12c73fc621dmr20116534c88.30.1777184843993; Sat, 25
 Apr 2026 23:27:23 -0700 (PDT)
Date: Sat, 25 Apr 2026 23:27:16 -0700
In-Reply-To: <20260426062718.1238437-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260426062718.1238437-1-surenb@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260426062718.1238437-2-surenb@google.com>
Subject: [PATCH v2 1/3] fs/proc/task_mmu: read proc/pid/{smaps|numa_maps}
 under per-vma lock
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
Reviewed-by: Liam R. Howlett <liam@infradead.org>
---
 fs/proc/task_mmu.c | 195 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 156 insertions(+), 39 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 751b9ba160fb..1e3a15bf46f4 100644
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
@@ -1280,21 +1311,75 @@ static const struct mm_walk_ops smaps_shmem_walk_ops = {
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
 		return;
 
+	if (vma == get_gate_vma(priv->lock_ctx.mm))
+		return;
+
+	/* Might sleep. Drop RCU read lock but keep the VMA locked. */
+	drop_rcu(priv);
+
 	if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
 		/*
 		 * For shared or readonly shmem mappings we know that all
@@ -1312,15 +1397,16 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 					!(vma->vm_flags & VM_WRITE))) {
 			mss->swap += shmem_swapped;
 		} else {
-			ops = &smaps_shmem_walk_ops;
+			ops = get_smaps_shmem_walk_ops(priv);
 		}
 	}
 
-	/* mmap_lock is held in m_start */
 	if (!start)
 		walk_page_vma(vma, ops, mss);
 	else
 		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
+
+	reacquire_rcu(priv);
 }
 
 #define SEQ_PUT_DEC(str, val) \
@@ -1369,10 +1455,11 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 
 static int show_smap(struct seq_file *m, void *v)
 {
+	struct proc_maps_private *priv = m->private;
 	struct vm_area_struct *vma = v;
 	struct mem_size_stats mss = {};
 
-	smap_gather_stats(vma, &mss, 0);
+	smap_gather_stats(priv, vma, &mss, 0);
 
 	show_map_vma(m, vma);
 
@@ -1413,7 +1500,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		goto out_put_task;
 	}
 
-	ret = mmap_read_lock_killable(mm);
+	ret = lock_ctx_mm(&priv->lock_ctx);
 	if (ret)
 		goto out_put_mm;
 
@@ -1425,7 +1512,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 	vma_start = vma->vm_start;
 	do {
-		smap_gather_stats(vma, &mss, 0);
+		smap_gather_stats(priv, vma, &mss, 0);
 		last_vma_end = vma->vm_end;
 
 		/*
@@ -1434,8 +1521,8 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
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
@@ -1484,14 +1571,14 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
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
@@ -1505,7 +1592,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 	__show_smap(m, &mss, true);
 
 	release_task_mempolicy(priv);
-	mmap_read_unlock(mm);
+	unlock_ctx_mm(&priv->lock_ctx);
 
 out_put_mm:
 	mmput(mm);
@@ -3291,6 +3378,31 @@ static const struct mm_walk_ops show_numa_ops = {
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
@@ -3335,8 +3447,13 @@ static int show_numa_map(struct seq_file *m, void *v)
 	if (is_vm_hugetlb_page(vma))
 		seq_puts(m, " huge");
 
-	/* mmap_lock is held by m_start */
-	walk_page_vma(vma, &show_numa_ops, md);
+	/* Skip walking pages if gate VMA */
+	if (vma != get_gate_vma(proc_priv->lock_ctx.mm)) {
+		/* Might sleep. Drop RCU read lock but keep the VMA locked. */
+		drop_rcu(proc_priv);
+		walk_page_vma(vma, get_show_numa_ops(proc_priv), md);
+		reacquire_rcu(proc_priv);
+	}
 
 	if (!md->pages)
 		goto out;
-- 
2.54.0.545.g6539524ca2-goog

