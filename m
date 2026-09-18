Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F033F8CA
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745608; cv=none; b=evmrNg9AqHoNui8NfjR7V1DaW+K06SnegFAmyn7STxzC9JtalO2+5yx2BxownWqKAzB8YNhTkFZJPP4kKkQD0/QSuFTeG8U3gmjKmb3HV8TjCL/4w2Lr65N2RE8nTI4MOVp4k31BUjSX0kAPtZFDnfBko03aJFUGLhlCWLXojuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745608; c=relaxed/simple;
	bh=ZATjr9vGIRP9OJ8ChECjJEnnBK9wQJMcxZJyHJQjVtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IVyS3YZy8theyPVZgLRmgnfA3fCVgl25thGEU/I3k1hTUPSjYWrMqnpKV79DS57/r2sw0E4Jiq0QiObfOEVweRkl6crRvvyHrGcbnnUV5bsVr/7LB3yODBeKzAJSFJCVgsiTqCjKD+ZxtvOuL5kEBTiaLwRRKtcPHeBOhYHJ4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jbi4SaKD; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jbi4SaKD"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so1799696a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789745605; x=1790350405; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CWMWdX0M04Ux74D6qkwQk3CE9vSTuvtr+k+ENnhVHRs=;
        b=Jbi4SaKDJnoj7+oL7aOgG5N7stSClc24YawhC3gJLGTjWM2cLx7WK0l4NO0tzrp9+b
         CxQ+T8bwKlcddit8pqgyt9UiyZBSINpPK4GJkxhpiJSF9huJZ6mmu9UKU0EREwryTa5Z
         wlXxJQYd2vrEB/Zb+JOwXze15MqgK8oo8jpqwJmESx5pVamg5lkz97FMEmjFbCn0FDpF
         lAaxBbh2NXGQGLNrXxcNawzS/hdwBdAnAThMkVusIc1/TtRXkXTIYKyRWKYScoZspdqN
         x0YgmboI+abv1+u/rrGw6xNSPDom0I5Zq7yDz6TQycKYCryUz1aRIAx7n3dSaI4nq7Va
         iQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745605; x=1790350405;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWMWdX0M04Ux74D6qkwQk3CE9vSTuvtr+k+ENnhVHRs=;
        b=CpQM3TOKWlCcsHfmiPmSd7zH7Caxv0EdEWn1YtRM/dXIWrioROd5sDX6B2nPynYLqx
         /3FfUUmvy04KwEJTLMR3Ruq2725fQXFAcuPL99A0DReekQyXtC/ZH4wtZPbS6nOzCwkg
         VduNlsHA2/VGM1XKIAGKp7pv4QI+TUcU0zEcr6/ZuISGUSSjws2hXuGJQUTNEN2lBfB2
         6f3fU41Qbx7DzmeTovB5G3K9lKMDSuBI1QqrBxwCwbSI7dyUNgjFnjCMM3Gct3/NcZ4J
         e88H+VgfNPNCAxAX+N2zhqTL/g/o6P6CyIJ57bpMwkaNw5/TjJ09WoC/4i4L9LqX5z4l
         pDoA==
X-Forwarded-Encrypted: i=1; AKwUvBxb0HcriO7UJvIhDecruVyPH1L0SEIcaghj2OwTuep5NDweNu4s8Qj1Do3Y4KnV9+H9J5r/auIPPeGBvtyT@vger.kernel.org
X-Gm-Message-State: AFuF++kRQK0PxRG2q2B3Q5i95LE6EXmgD9pqpqQQdZHIWVz7zU5D6HiI
	hDBtA3drsLeojvoPBTW2rheQl/bQJeyIapFUespnvHorCMXKjZ8ehJF2hcgmwE8xZhrYZ5vl7vu
	ICXFOTA==
X-Received: from dlev11.prod.google.com ([2002:a05:701b:464b:b0:143:966c:32eb])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d47:b0:39e:6a81:5a91
 with SMTP id 98e67ed59e1d1-39e6a815e2cmr504732a91.37.1789745605293; Fri, 18
 Sep 2026 08:33:25 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:33:13 -0700
In-Reply-To: <20260918153318.758387-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918153318.758387-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918153318.758387-3-surenb@google.com>
Subject: [PATCH v5 2/7] proc/task_mmu: remove unnecessary inlines in function definitions
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@kernel.org, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	xueyuan.chen21@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com, 
	Usama Arif <usama.arif@linux.dev>
Content-Type: text/plain; charset="UTF-8"

It was pointed out in the previous reviews of this code that many
functions are specified as inline, which is unnecessary as the compiler
can make that decision by itself. Cleanup these definitions.

No change in the resulting binary file size with gcc v15.2.0.
No functional change intended.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Usama Arif <usama.arif@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/task_mmu.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 191a054d7e40..8a72dc0dc945 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -130,7 +130,8 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 }
 #endif
 
-static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
+#ifdef CONFIG_PROC_PAGE_MONITOR
+static int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
 {
 	int ret = mmap_read_lock_killable(lock_ctx->mm);
 
@@ -139,8 +140,9 @@ static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
 
 	return ret;
 }
+#endif
 
-static inline void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
+static void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
 {
 	mmap_read_unlock(lock_ctx->mm);
 	lock_ctx->mmap_locked = false;
@@ -177,8 +179,8 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
 	return vma;
 }
 
-static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
-					 loff_t pos)
+static bool fallback_to_mmap_lock(struct proc_maps_private *priv,
+		loff_t pos)
 {
 	struct proc_maps_locking_ctx *lock_ctx = &priv->lock_ctx;
 
@@ -194,7 +196,8 @@ static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 	return true;
 }
 
-static inline void drop_rcu(struct proc_maps_private *priv)
+#ifdef CONFIG_PROC_PAGE_MONITOR
+static void drop_rcu(struct proc_maps_private *priv)
 {
 	if (priv->lock_ctx.mmap_locked)
 		return;
@@ -202,7 +205,7 @@ static inline void drop_rcu(struct proc_maps_private *priv)
 	rcu_read_unlock();
 }
 
-static inline void reacquire_rcu(struct proc_maps_private *priv)
+static void reacquire_rcu(struct proc_maps_private *priv)
 {
 	if (priv->lock_ctx.mmap_locked)
 		return;
@@ -211,6 +214,7 @@ static inline void reacquire_rcu(struct proc_maps_private *priv)
 	/* Reinitialize the iterator. */
 	vma_iter_set(&priv->iter, priv->lock_ctx.locked_vma->vm_end);
 }
+#endif
 
 static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
 {
@@ -1230,7 +1234,7 @@ static const struct mm_walk_ops smaps_shmem_walk_vma_lock_ops = {
 	.walk_lock		= PGWALK_VMA_RDLOCK_VERIFY,
 };
 
-static inline const struct mm_walk_ops *
+static const struct mm_walk_ops *
 get_smaps_walk_ops(struct proc_maps_private *priv)
 {
 	if (priv->lock_ctx.mmap_locked)
@@ -1238,7 +1242,7 @@ get_smaps_walk_ops(struct proc_maps_private *priv)
 	return &smaps_walk_vma_lock_ops;
 }
 
-static inline const struct mm_walk_ops *
+static const struct mm_walk_ops *
 get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
 {
 	if (priv->lock_ctx.mmap_locked)
@@ -1572,7 +1576,7 @@ struct clear_refs_private {
 	enum clear_refs_types type;
 };
 
-static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
+static bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 {
 	struct folio *folio;
 
@@ -1588,8 +1592,8 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
 	return folio_maybe_dma_pinned(folio);
 }
 
-static inline void clear_soft_dirty(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *pte)
+static void clear_soft_dirty(struct vm_area_struct *vma, unsigned long addr,
+		pte_t *pte)
 {
 	if (!pgtable_supports_soft_dirty())
 		return;
@@ -1620,7 +1624,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 }
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
+static void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmdp)
 {
 	pmd_t old, pmd = *pmdp;
@@ -1646,7 +1650,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 	}
 }
 #else
-static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
+static void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmdp)
 {
 }
@@ -1848,7 +1852,7 @@ struct pagemapread {
 
 #define PM_END_OF_BUFFER    1
 
-static inline pagemap_entry_t make_pme(u64 frame, u64 flags)
+static pagemap_entry_t make_pme(u64 frame, u64 flags)
 {
 	return (pagemap_entry_t) { .pme = (frame & PM_PFRAME_MASK) | flags };
 }
@@ -3390,7 +3394,7 @@ static const struct mm_walk_ops show_numa_vma_lock_ops = {
 	.walk_lock = PGWALK_VMA_RDLOCK_VERIFY,
 };
 
-static inline const struct mm_walk_ops *
+static const struct mm_walk_ops *
 get_show_numa_ops(struct proc_maps_private *priv)
 {
 	if (priv->lock_ctx.mmap_locked)
-- 
2.55.0.1082.g2b9226bbc0-goog

