Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250FF3AA9D4
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 23:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084066; cv=none; b=oqyLV2lGXG5nQNZ89BSuBr1cFIrJz/W92tNZF5RVEkPUIKItS1PPiSn/3qYLFqOAz5Ilq0IszXJW+0/giqo0sN49ir72DCQPNp/ww+K1n5CebOHiCNMXlIPrRJE9pCgxUzCa17L6psW2RPlTwpPvyYJ5qTfsPg6qaeE1jjPAtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084066; c=relaxed/simple;
	bh=hTFVKt75D71OvdXG4pzTXlqYcjNqksLPxYYyQHAZ+yc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iOTi4RvDzsxvc+uWfCs26s7Asl0ZnE8vkMx2SF5nrN1w7e/OdeXBJwauG/byRkUjwRbv+KEru+ecai5zD5Q++fWm6uYrkFELoyHWHiuaziBjYafErJwIr7lkzxj3zefcnTUq/+doDYDc1zeiMlTWtbzjAfbWTiQbXrAkD4tFRLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VGkm5r4N; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGkm5r4N"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3968dfff779so442682a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 16:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789084064; x=1789688864; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xOFXyMArwtdLkzPinOADoZdNqvQDYiollRghSoVraI0=;
        b=VGkm5r4N4kTDvC9a2Y4Uy+fzTGCtOw9ZlTzK4nRa5UWMUFXGLsLN7jSEw/uW6/6y8Y
         tVAVliUd1nj9KTT0Msqj79HkyIyprTabFmPU11klQAFEmwMBoDFuvd3OPP4LBGIJp0uE
         8YOYBpX5PAiwoCqMqg+MCZJ1kBSN/jkpm+kH4TEbsz9fIPjilt2fU54GPVX7XO5DRsTl
         b9Ii8F9fb2awgHY8DVf0cucdIDKb3NHvy3IAp9zRffva+bJoLPcjw5xw2e4V1q5sTzDb
         qSR1b7Skxd2GHnz/ziKBFw4PJeC0kqeq/gEiJc3H5sIAhHsry8iD5oOm35vamjJgpcyR
         G5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084064; x=1789688864;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xOFXyMArwtdLkzPinOADoZdNqvQDYiollRghSoVraI0=;
        b=fACbjySmZFiC8R7eIFujLYQH8+fOH3aYjkJN5Xe2AixoybxokgiEuuvSun9Uu6FJNl
         O1aGkEYSBDo4JZAuquQreqpw38HM0OIEEvNagkW0ZZvSSLU2y5JXA7+6XwZQTN/uxu5r
         RWMjUVpa5PwVuSCtIcKlQGZ8mbR/9Vtd2hUoyD5PFLqNllv6RBvQ3VRD1bzfEVgvn9He
         KMO41441cSdaZW48TOaXLQtVP/9Lp2x+E/OtokaY1JOB4lz0Ga1agbxElpOTYbnbufoV
         1Fpfh4GBZY/HVXmdMH7KB60QBMDsOgbneLj9nuZQTwdfPP9Gp0CRV7PonKKx8gYpEqJE
         oX7w==
X-Forwarded-Encrypted: i=1; AKwUvBzcH+sgURPnkwF4H2dQBuaUEst9L+27VDeZ4Cjgj/gXz/2jw2oYVQEGdkC9wPdE7kKcN98RUQ8PM+JEvxd2@vger.kernel.org
X-Gm-Message-State: AFuF++kJ1BGE959su/c3jx+9VzmzW+NAmY4ubNlEld8PAqwz2H/cKbmy
	SIecH2vZCb4F68WFfKU5ZbTB6doMcP3c3kGdr+D4ZLgbGOE5zvsOBiNgxArTH/fR1+NnhxDK2aU
	ojauYfQ==
X-Received: from dlnn5.prod.google.com ([2002:a05:7022:6185:b0:141:4b41:e0d0])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:bb86:b0:39d:8b8c:3781
 with SMTP id 98e67ed59e1d1-39d8b8c3efamr3490361a91.28.1789084064165; Thu, 10
 Sep 2026 16:47:44 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:47:31 -0700
In-Reply-To: <20260910234737.1340642-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910234737.1340642-2-surenb@google.com>
Subject: [PATCH v3 1/7] proc/task_mmu: remove unnecessary helpers
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	xueyuan.chen21@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com, 
	Usama Arif <usama.arif@linux.dev>, "David Hildenbrand (Arm)" <david@kernel.org>
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

