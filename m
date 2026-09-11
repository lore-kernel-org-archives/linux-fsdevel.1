Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F4424D46
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155734; cv=none; b=XqVyV9DwCS4ID96lRuAgEujGfVyAOcci04sXgQX7Ur7Bsi7hd+BA1LO/FJPK4Rp3YFPwY13GrNNOwYUdJvjQZm6uxp9aQDnSteVYaWHIPlJC0A64a+1cj5gh20J6wW+u2SlSJxsu2pPvaYvtyEY8pWVTrLvrJ2HyyZK/X/0JyiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155734; c=relaxed/simple;
	bh=fUxXDYw3T1gUirTrhaVtgZWtvxsAdhHi4+wohdyk030=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cpjb7H1aFQoBSIgiS1X2VAS7yB89BRucp4RR9V97vCZSVqqAnZ0YKdp6P523Qb+hG07QDrHkz2qaMZ7reWNVmCqj/RGs+l6qzwjr1muK3G7RUPPlA2U8SF83dg7CCVi/0NeBItZm8gLvvHHJu0zEIRpdqNgojo9Y3xjnHQFkNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YX9IOoyD; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YX9IOoyD"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dff6253so27441435ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789155713; x=1789760513; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YI2R/SdoKPqweMYYzjbXGeDWKwn1DHCKfjSC8BU4ikg=;
        b=YX9IOoyDHCtVX5kYiuXg61qs2GEN+0EzGzp3ouuKpfKmmSFdCKlxir45/tB6dvV+oQ
         bfo2KoZQh9rwm5mkEKJwmGh8oQbhQJpo6I7sxEDzbxzrEUeFTZNCTRzWVmmhb4WHaiMm
         UKo9Sv/2ErmESr2us9G9G9ak5hVORfhdF1U53U4ulYfK6mDuLQdFexKnACiHg1IRkib1
         VvcCs/psqtcoOZHBCMr24cm6kYZyg7LcSabhxGKjTIl3bSKJtmmy1zLetid30OEMGsCM
         IvLZ9pf/+rxokGKXyaIqjSGO0wEQ5+RiL/L1VLNwS0itW27H7hUfXQXaB7AS0Ax9YqsC
         EYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155713; x=1789760513;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YI2R/SdoKPqweMYYzjbXGeDWKwn1DHCKfjSC8BU4ikg=;
        b=oC/IUVwYjAZ/5i8v/N3pFbe4E1T8UwwbfuOQ7+xPqGvyjvMA9LrPA37MTYeBcDR5wA
         junTCeYK5rsqfmCVOSqQoyBTUNBoRAnmQkRdgB/g5gx4btvn0Sr6e7r+NORf3gzpbjJ2
         R0cAf4uRE19P3TsPiv/Aq1gbfpO/cV0lHj91cv9VkDkUqKaVCPixvsou9ye7q6yR1bbu
         7kQtnNWSX7Kcwtasv4MDcufKO8POk4iamljUAG5aLoisP5L6QSpJa5mgO+GVDBxg+eIa
         ZmAeRjwMsTdMyllET1MkAg6uUAvMIgLf18aB4UW9LVflunKbfeg3dCoBL4wke5S6bjAD
         de7w==
X-Forwarded-Encrypted: i=1; AKwUvBym/7dQj0QYAD5nuzgk6eZs6oQ/03W4zOJLyNbzxdDIwFc9PEehqGQB8oETwxrdapxl23Y6C3X4wCMwuYJv@vger.kernel.org
X-Gm-Message-State: AFuF++l/HxnqPFulvhrOKkzG8KbbgqyfHPl8fsTcxSETcsrB+wErLazB
	mg4C1r4QalPw/nVzXsCZWoWMsqsKJLt5LM0thW44SjLpINYwOf3NWCbL+ybWyQLAFEIAQYYTWBP
	ovU3epw==
X-Received: from dybrp10.prod.google.com ([2002:a05:7301:460a:b0:339:7bd3:e896])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:38cc:b0:2db:3734:cfa4
 with SMTP id d9443c01a7336-2dd0e8a0ef6mr117429835ad.5.1789155713246; Fri, 11
 Sep 2026 12:41:53 -0700 (PDT)
Date: Fri, 11 Sep 2026 12:41:40 -0700
In-Reply-To: <20260911194145.1781926-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911194145.1781926-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911194145.1781926-3-surenb@google.com>
Subject: [PATCH v4 2/7] proc/task_mmu: remove unnecessary inlines in function definitions
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@kernel.org, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	xueyuan.chen21@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com, 
	Usama Arif <usama.arif@linux.dev>
Content-Type: text/plain; charset="UTF-8"

It was pointed out in the previous reviews of this code that many
functions are specified as inline, which is unnecessary as the compile
can make that decision by itself. Cleanup these definitions.

No change in the resulting binary file size with gcc v15.2.0.
No functional change intended.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Usama Arif <usama.arif@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/task_mmu.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2f500d639db5..cfc7af1b551d 100644
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
@@ -177,8 +177,8 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
 	return vma;
 }
 
-static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
-					 loff_t pos)
+static bool fallback_to_mmap_lock(struct proc_maps_private *priv,
+		loff_t pos)
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
+		pte_t *pte)
 {
 	if (!pgtable_supports_soft_dirty())
 		return;
@@ -1620,7 +1620,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 }
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
+static void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmdp)
 {
 	pmd_t old, pmd = *pmdp;
@@ -1646,7 +1646,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 	}
 }
 #else
-static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
+static void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmdp)
 {
 }
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
2.55.0.1007.g17ff1f9808-goog

