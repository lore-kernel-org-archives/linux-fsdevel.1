Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64784AA412
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155728; cv=none; b=SwrqWJQa735nlTZYzZm0T0CFLYJlwuGYrPIRkgcLrRnmiw74cquWtq46r1fnbble8yOj/a6h/Ye0ntltYkJF5d2xEXmtNNcUL3pqJs5dWExuUA3mY8u741gpD1fDc09Xpm6SzYx3kY8W/KagIMzEXNJYYXAYLd7WAWP2VN6BK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155728; c=relaxed/simple;
	bh=hTFVKt75D71OvdXG4pzTXlqYcjNqksLPxYYyQHAZ+yc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o1+LOMCAklHYehHcYRZjnY2fGjjA3qavpi9w/VVAu8j36LJsTbYGvvZnW5Rphiz9Hg+ZuQpvGk+ayvHB5DN82YyGP2iTSFxCe7rDeZYOqgE+o+qXuTx8b8+kdT4RYcj3EpQI7UWO9cgbm6QXBQaLARbBLRIsD0SXHbeCJhgCQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKzVZYg/; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKzVZYg/"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b6416441eso2377377a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789155711; x=1789760511; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xOFXyMArwtdLkzPinOADoZdNqvQDYiollRghSoVraI0=;
        b=TKzVZYg/gyRfvrb8NxOkX1XIF1P1agFnWHyxoh5rRuo6tSeM2vVdSPkjPRNitv/TpL
         ob9I8NrAPC0O+0cI6Zq/aEUUcicoTI46iqErviIkBY7IPPzLq0RP9EH6vQ4i5T+nOg+L
         mTtNfkIec4DHdNiYPrscu6Fo7LzDgSqi8vPE84Qd2SC5cCqFdT6EymKpAaCpNmlipCfK
         tPTppqRYIiSMyKhWKh6MlgggIMNSbc/cl6AgpuAHG1Q5zjgdOHDpjkmcjVndDva8vEgu
         p0aVfYeMMuKDEGMXt8/+9x1nZQ2V4HWLJihWa27LZeHQwImc+phLknGPo34UUCYbBeQR
         retQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155711; x=1789760511;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xOFXyMArwtdLkzPinOADoZdNqvQDYiollRghSoVraI0=;
        b=dOkQFD4YO82zuKdiKctZ1N9wexhBV9szBrsZaF89nMYJLQDbY1skijM/meaYz5Tr05
         mzKb6fLGSLVHdK/OdGpGwyh3VFMBwt64GxkNRjrtyoMkPaIcBf9Z4I5Er5CTpO3C5bhn
         O6uE1508E7Nd0E4KHQG7NREi20ZnNhtKmamwM9MRE8VMahMh2imPNptOFbvTGi8Riew4
         CMCHVEf7SC3q3k8DDw7BNOV36ByDI+l9myXnAxxsdCLEF4lcYLW0tE2cM3tBC0gOXU8C
         Rz61iVjfuSOt8aAWIJUbhyozLZ81mtSh4tkB7DtDoB3vq9FTLE9jy5xMX9cXq0BsjyIH
         5gJQ==
X-Forwarded-Encrypted: i=1; AKwUvByJ70PioO5xNQniuuUEDjcPI0t4/wZ5u1SAkUCFHD/YOTMfwKyzkXII7309xRb/LdRka6xolk2jEyu222zM@vger.kernel.org
X-Gm-Message-State: AFuF++naWhxh/t90ZB8xIaakO4744FObcbRIt/x3WhyNB2nVPqPfk1Ki
	TyMIsdvhyBzrnmjtuK9sB17TgEID7bvqWrGt0ME7TYwcwCXWCRdORV2NvK7lsrLZZKRPcC/ClzR
	ZWlpxKw==
X-Received: from dlbrj7.prod.google.com ([2002:a05:7022:f407:b0:143:5fe6:4e1a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5246:b0:398:d2a0:87ff
 with SMTP id 98e67ed59e1d1-39d9bc67660mr10045684a91.1.1789155711065; Fri, 11
 Sep 2026 12:41:51 -0700 (PDT)
Date: Fri, 11 Sep 2026 12:41:39 -0700
In-Reply-To: <20260911194145.1781926-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911194145.1781926-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911194145.1781926-2-surenb@google.com>
Subject: [PATCH v4 1/7] proc/task_mmu: remove unnecessary helpers
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@kernel.org, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	xueyuan.chen21@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com, 
	Usama Arif <usama.arif@linux.dev>
Content-Type: text/plain; charset="UTF-8"

When per-vma locks were behind a config option, a number of helper
functions were needed to simplify the locking code. Now that these
locks are universally available, we can do a little cleanup.
Remove lock_vma_range(), unlock_vma_range(), query_vma_setup(),
query_vma_teardown() helpers.

No functional change intended.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Usama Arif <usama.arif@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/task_mmu.c | 67 ++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 50 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e671b4fd8ded..2f500d639db5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -160,25 +160,6 @@ static void unlock_ctx_vma(struct proc_maps_locking_ctx *lock_ctx)
 	}
 }
 
-static inline bool lock_vma_range(struct seq_file *m,
-				  struct proc_maps_locking_ctx *lock_ctx)
-{
-	rcu_read_lock();
-	reset_lock_ctx(lock_ctx);
-
-	return true;
-}
-
-static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_ctx)
-{
-	if (lock_ctx->mmap_locked) {
-		unlock_ctx_mm(lock_ctx);
-	} else {
-		unlock_ctx_vma(lock_ctx);
-		rcu_read_unlock();
-	}
-}
-
 static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
 					   loff_t last_pos)
 {
@@ -286,13 +267,8 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return NULL;
 	}
 
-	if (!lock_vma_range(m, lock_ctx)) {
-		mmput(mm);
-		put_task_struct(priv->task);
-		priv->task = NULL;
-		return ERR_PTR(-EINTR);
-	}
-
+	rcu_read_lock();
+	reset_lock_ctx(lock_ctx);
 	/*
 	 * Reset current position if last_addr was set before
 	 * and it's not a sentinel.
@@ -325,7 +301,12 @@ static void m_stop(struct seq_file *m, void *v)
 		return;
 
 	release_task_mempolicy(priv);
-	unlock_vma_range(&priv->lock_ctx);
+	if (priv->lock_ctx.mmap_locked) {
+		unlock_ctx_mm(&priv->lock_ctx);
+	} else {
+		unlock_ctx_vma(&priv->lock_ctx);
+		rcu_read_unlock();
+	}
 	mmput(mm);
 	put_task_struct(priv->task);
 	priv->task = NULL;
@@ -518,21 +499,6 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 		PROCMAP_QUERY_VMA_FLAGS				\
 )
 
-static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
-{
-	reset_lock_ctx(lock_ctx);
-
-	return 0;
-}
-
-static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
-{
-	if (lock_ctx->mmap_locked)
-		unlock_ctx_mm(lock_ctx);
-	else
-		unlock_ctx_vma(lock_ctx);
-}
-
 static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
 						     unsigned long addr)
 {
@@ -653,12 +619,7 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 	if (!mm || !mmget_not_zero(mm))
 		return -ESRCH;
 
-	err = query_vma_setup(&lock_ctx);
-	if (err) {
-		mmput(mm);
-		return err;
-	}
-
+	reset_lock_ctx(&lock_ctx);
 	vma = query_matching_vma(&lock_ctx, karg.query_addr, karg.query_flags);
 	if (IS_ERR(vma)) {
 		err = PTR_ERR(vma);
@@ -732,7 +693,10 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 		vm_file = get_file(vma->vm_file);
 
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
-	query_vma_teardown(&lock_ctx);
+	if (lock_ctx.mmap_locked)
+		unlock_ctx_mm(&lock_ctx);
+	else
+		unlock_ctx_vma(&lock_ctx);
 	mmput(mm);
 
 	if (karg.build_id_size) {
@@ -773,7 +737,10 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 	return 0;
 
 out:
-	query_vma_teardown(&lock_ctx);
+	if (lock_ctx.mmap_locked)
+		unlock_ctx_mm(&lock_ctx);
+	else
+		unlock_ctx_vma(&lock_ctx);
 	mmput(mm);
 out_file:
 	if (vm_file)
-- 
2.55.0.1007.g17ff1f9808-goog

