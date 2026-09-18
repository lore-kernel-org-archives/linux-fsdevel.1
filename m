Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498813CF039
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745606; cv=none; b=TNY+MC7BkYrlX2u8ji8PSrIEfKmwPDywIMK0Rzy5gsV7J6Bp/0YNdtOhZX3k7gFYPKxSU+GQ1jktk7QJtweBgc8t3GNWtCY4PNEPbJnE25NW9SHstnMwOxsX5gXnEPZYIiSB+uQnAQsIixPL2kT4VZOSKIliea1+FPTdOOOxVlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745606; c=relaxed/simple;
	bh=sNhtugPm/JmXICxKXp9aPTYjkThuZCpeqE7pnXcsG/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vit70n7oePg8mJLXRGFy//XtUcH5p1Hok36Wh//GxCQVCX/SYplBxKZwqif5LvxUKFgBPZQJAqUsaCymMoxXs3i7frO1klrKLMqyaL75BsOZ9Jj0JxV2wjADXuUTQbY5OWXRXHFPuRSLTJe8L2qojLegGS91VyKOcR+/1JE/+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghIJPijE; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghIJPijE"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso921762a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 08:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789745603; x=1790350403; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G76+KNo+7dCD80CEXVYRdrJvlcvMXRNfZh0Z210UNpw=;
        b=ghIJPijEWsiBuU67vV0aYHO4lX8qRfIUfuht8tF3ByfvMV4Wvw6HO1D6sXjUBrov3p
         rT48R3AoNfD5+j9mCEBLhH8KIfZnllKm2bs0CFY+mcxdMqkYj5EuO+63CmuAh+BEOi/y
         UCYabTcWDX3GQvm1SqVAojYzwlRFji07fhnJ1HLLAo6nhKjDdVbWZibKV1gvx7mn00Uj
         uA7RUN3EbFtXSHFiQK63IspYz8bOdYsC0gJWnlG6Y/7uJnI+hD1GmSC9c1V29qr46q1i
         supX1L9eMgl/VBcYniF+3k7fFdSniCEOa5a2u/UendcckIUjxAY+GWHFdPcXVhTZ2z/X
         4zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745603; x=1790350403;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G76+KNo+7dCD80CEXVYRdrJvlcvMXRNfZh0Z210UNpw=;
        b=XDtTXZY3PUhicdpHZoqwrwcunk7MHFgg2WrvkeZF6aCiO/xbAPdX+nUhR1gqFhFtii
         I9OZAnX0ma6dD2gOziNL+My1zNP96YUadZHs4EO6sV2iss5PQltuWzUvvHUPK4HKygph
         G4SF3SOYGuckM981XlprbLYKAl2/f0jRFbsVwFRnKqRYB+IoWd0UEHaMbrKAfIpgQtgX
         4Y0TlcSD+nwKvk6Oulhom8ryAWWVlYssi/DKtdH7X2mWa2OGOEW1g7G5CyMRd5l6tq6B
         2wI9Amdy+H6B5exHu00UIi/8ZbSWloYYn8IL9cOWhlfafdBCBuBRgo4rkU5pIdifsEas
         oDUA==
X-Forwarded-Encrypted: i=1; AKwUvBx0MkndNFpHgz7VbH/5l2nnaiXhhWZXc/ycwCo91sBmeIG0rTNDNm2yF1BvlU6abVYAWiP/nCE5VG2QO8Sp@vger.kernel.org
X-Gm-Message-State: AFuF++kcKA4uzHe+YItaweOCF2cUz3G3MxA1ZAtoMbL5lJYf874eRVg/
	FC0fePviTqqFHsrEuEmZokma4OzYgCNzygmjrVmDttW+VDo7SsUuY+3x+e1FAT7hHDNceseLN5A
	91sFKTQ==
X-Received: from dldd2.prod.google.com ([2002:a05:701a:c902:b0:144:d109:6356])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac7:b0:39e:6c6a:4b6b
 with SMTP id 98e67ed59e1d1-39e6c6a56acmr25332a91.53.1789745603281; Fri, 18
 Sep 2026 08:33:23 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:33:12 -0700
In-Reply-To: <20260918153318.758387-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918153318.758387-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918153318.758387-2-surenb@google.com>
Subject: [PATCH v5 1/7] proc/task_mmu: remove unnecessary helpers
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
index 052e8dc796bc..191a054d7e40 100644
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
2.55.0.1082.g2b9226bbc0-goog

