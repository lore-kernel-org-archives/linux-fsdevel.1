Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411944028F2
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763168; cv=none; b=N/5g8s65Boti4FPBlseHoOtUExMzitiAo7CUwDLONzqr1qGCd51UhdEFlZterrHYSo5DxaFZXl/81vz4svJzcXyDxzkvBRPoAaIdXjC4fUO0IOskAhatc+F6KDDre19iN1i3vzUKkDHuIQ35uLYa/76n1n+hth1zhCGCYcdE6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763168; c=relaxed/simple;
	bh=XvZKlwyqByri/054hcrh9tw8Y9rV224J0uA2+z0txnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RZS5PZw9BtHlVAkX2nJfCmgo9gxOysFzZJQcQIDq2EZgGSNL73PNUvVWLBYCSMSYuIIR2x8sbbjrdo6jBXTf5rSEA6hbP1m0ZPpcVd5mhM8IHZFexU9SbMQowg/ziZXQDt252dQCgpP7m4gKn9d9/FX4JgT/Al4KxFaZ4HhWdmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYdN4OFK; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYdN4OFK"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso3872778a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 23:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788763166; x=1789367966; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WAyGHFgPAjMeDjtoxxSVMLam0i0jWSVnA20CIJf1N7E=;
        b=YYdN4OFKG57HIQBHYMhnuulPCJKBgeYSfI0ajPPMZ8wEd0wEGvKNgW7dezPfBPIurt
         JfntccQGotBJBdXhC8dm/djiNPc3Ls5ZgWTS6lVYgkXgOkCv/67Z8eieQf9DsOfh2Uz+
         DHtNUlLUQnvGGRylSUxcOEC10W93TartqpTcy21tAfeG4FP++FmR+1ZC/FgMZBeEW3TA
         GNp7ipGvr4uW2mtAOfb/QefXJt4LGvLVF1sNF7xXPCcGU2PVKwXjiIEMIowYGPkjsiAI
         TYJH2FJYwI+qmcAZUWYngByJQfrDdgCCitx714FUPyMsSG3ZcIPx/e6KBLD4cDWjBN5x
         B97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763166; x=1789367966;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WAyGHFgPAjMeDjtoxxSVMLam0i0jWSVnA20CIJf1N7E=;
        b=TGd5fceBtTMwnKT8cFhyuvBI07fqEymfFuakn53wYAkzh7Ca553IR/QZ5cZDfktqth
         V53y4yCIh4HTn12vJ4VV/JOdLn84NTtk9J0wv7+V+xI+muXbQLlegCzcuxO0E4H4N/c+
         EkQD52y1KK7plssuf78QbVqOO8tgpcSrbw044CJ/M//URXHSJfFO18UE+Do4TbMj2CzX
         cAk7TFYNlKOfp/CD0mgg53M0rBOjAZLzMN1AtLHfLz5YgA1C0FlsdQ5A/ncA642TjglJ
         VTy1j5AocvnCX+Z3Ij9cGfzg3POJoP42ngBH+QxBNIjtjuMIbCdncuquYYQNOWcrRhV+
         hgcQ==
X-Forwarded-Encrypted: i=1; AKwUvByH4K5T8H8erLSQXWt0/MZVUZY2KEZdIMuOfEmbXl3ydH7wgXYKhR2Gtf4YOzHufPb6dTUxUaKrWW1qq8Da@vger.kernel.org
X-Gm-Message-State: AFuF++m0aw6eV5woUg6q3skhjM31oFvnQ5LlJn8vY53Z581TU/XTlfDV
	gwDdfK3JLupyxZEtBr8GFPexYOoYjisVaE7CUqUmfM+O3sf/pvvrYX7bwItAECgJkqawvlmOdq5
	1vm5WNA==
X-Received: from dlea18-n2.prod.google.com ([2002:a05:701b:4212:20b0:141:4de6:26b2])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5246:b0:39a:e983:d4bd
 with SMTP id 98e67ed59e1d1-39b262a3cf7mr34335443a91.24.1788763166262; Sun, 06
 Sep 2026 23:39:26 -0700 (PDT)
Date: Sun,  6 Sep 2026 23:39:15 -0700
In-Reply-To: <20260907063918.3432401-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907063918.3432401-3-surenb@google.com>
Subject: [PATCH v2 2/5] proc/task_mmu: remove unnecessary inlines in function definitions
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

It was pointed out in the previous reviews of this code that many
functions are specified as inline, which is unnecessary as the compile
can make that decision by itself. Cleanup these definitions.

No functional change intended.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2f500d639db5..9908ba32f180 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -130,7 +130,7 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 }
 #endif
 
-static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
+static int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
 {
 	int ret = mmap_read_lock_killable(lock_ctx->mm);
 
@@ -140,7 +140,7 @@ static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
 	return ret;
 }
 
-static inline void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
+static void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
 {
 	mmap_read_unlock(lock_ctx->mm);
 	lock_ctx->mmap_locked = false;
@@ -177,7 +177,7 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
 	return vma;
 }
 
-static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
+static bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 					 loff_t pos)
 {
 	struct proc_maps_locking_ctx *lock_ctx = &priv->lock_ctx;
@@ -194,7 +194,7 @@ static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 	return true;
 }
 
-static inline void drop_rcu(struct proc_maps_private *priv)
+static void drop_rcu(struct proc_maps_private *priv)
 {
 	if (priv->lock_ctx.mmap_locked)
 		return;
@@ -202,7 +202,7 @@ static inline void drop_rcu(struct proc_maps_private *priv)
 	rcu_read_unlock();
 }
 
-static inline void reacquire_rcu(struct proc_maps_private *priv)
+static void reacquire_rcu(struct proc_maps_private *priv)
 {
 	if (priv->lock_ctx.mmap_locked)
 		return;
@@ -1230,7 +1230,7 @@ static const struct mm_walk_ops smaps_shmem_walk_vma_lock_ops = {
 	.walk_lock		= PGWALK_VMA_RDLOCK_VERIFY,
 };
 
-static inline const struct mm_walk_ops *
+static const struct mm_walk_ops *
 get_smaps_walk_ops(struct proc_maps_private *priv)
 {
 	if (priv->lock_ctx.mmap_locked)
@@ -1238,7 +1238,7 @@ get_smaps_walk_ops(struct proc_maps_private *priv)
 	return &smaps_walk_vma_lock_ops;
 }
 
-static inline const struct mm_walk_ops *
+static const struct mm_walk_ops *
 get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
 {
 	if (priv->lock_ctx.mmap_locked)
@@ -1572,7 +1572,7 @@ struct clear_refs_private {
 	enum clear_refs_types type;
 };
 
-static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
+static bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 {
 	struct folio *folio;
 
@@ -1588,8 +1588,8 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
 	return folio_maybe_dma_pinned(folio);
 }
 
-static inline void clear_soft_dirty(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *pte)
+static void clear_soft_dirty(struct vm_area_struct *vma, unsigned long addr,
+			     pte_t *pte)
 {
 	if (!pgtable_supports_soft_dirty())
 		return;
@@ -1620,8 +1620,8 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 }
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
-		unsigned long addr, pmd_t *pmdp)
+static void clear_soft_dirty_pmd(struct vm_area_struct *vma,
+				 unsigned long addr, pmd_t *pmdp)
 {
 	pmd_t old, pmd = *pmdp;
 
@@ -1646,8 +1646,8 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 	}
 }
 #else
-static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
-		unsigned long addr, pmd_t *pmdp)
+static void clear_soft_dirty_pmd(struct vm_area_struct *vma,
+				 unsigned long addr, pmd_t *pmdp)
 {
 }
 #endif
@@ -1846,7 +1846,7 @@ struct pagemapread {
 
 #define PM_END_OF_BUFFER    1
 
-static inline pagemap_entry_t make_pme(u64 frame, u64 flags)
+static pagemap_entry_t make_pme(u64 frame, u64 flags)
 {
 	return (pagemap_entry_t) { .pme = (frame & PM_PFRAME_MASK) | flags };
 }
@@ -3388,7 +3388,7 @@ static const struct mm_walk_ops show_numa_vma_lock_ops = {
 	.walk_lock = PGWALK_VMA_RDLOCK_VERIFY,
 };
 
-static inline const struct mm_walk_ops *
+static const struct mm_walk_ops *
 get_show_numa_ops(struct proc_maps_private *priv)
 {
 	if (priv->lock_ctx.mmap_locked)
-- 
2.55.0.979.g7e5102b832-goog

