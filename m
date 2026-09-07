Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F5400963
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763166; cv=none; b=TnlMbjoNUeyWBqZW+vpT35iLUkCZQGnTkrMBdjtg/YYKQjqwEX07PQa0N3te3sCrYjn2906JLNU4lfueZRPk/bfDN0TWifs7YtvVNtbv5P945lITedIVpdYKtRtlkvQegHqgYqTCOYxKCTY3eMbwzqX9Ysst7tBHiWOcnTyxs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763166; c=relaxed/simple;
	bh=3OjcKa0V3SVb9pxz6PWF4t6frVrFTR1l1Lz6h9HZkQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K0BZUmMc6Pc35gZdljI/JOdfsnxcZRC95CXMuvDmGlW4l4cdAOPHqisUaHZ+JA4AdpnmSKkkYH/5hWgIj3WHpBv5W5r8FYgsLi9/nvMSkVa6SmwE0wazhtYmadJIhknxbbTbgAgnuKpJvtpe9X1RzkJFoPMpw6OGCTNL391r2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jN0S3UDt; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jN0S3UDt"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85798977dcso4904419a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 23:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788763164; x=1789367964; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4B0N/rPIgypiVNXAn0XPbbBc+Skfopg6i5mY1KeQYA=;
        b=jN0S3UDtKmdNH2JWpgrWQpmNmEUJwMBhzTL7f3yFfcLFW6yuoZAHMrVaDTF/IV92uj
         2hdwKGCVuPULttBlXvObtIcFgdzqkebJC9i3LN45bfD37P0H4GadgVyDNNNr2zIRB+pu
         GfHfjxZanpeNNMPm5yTjpYCpeo6ZapHBkVaT7MEYMxGvN3S/JSyT74DXLvjQteqgrC7/
         WCyP3BT+o27WnhY7qkpuEd8A/dVq0q787UvRmKU15TdCGO265F6u4TzCRumldjizKpwt
         DlV5zVcaOtwhL0nJ+KOb70IPcTkQkM7VX0MgIsU5BeNME1HzMFmAjrwF07j0lATMm5UC
         db0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763164; x=1789367964;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4B0N/rPIgypiVNXAn0XPbbBc+Skfopg6i5mY1KeQYA=;
        b=T5IKzg2AiBQykZlPZz1oITNmZgidHGY8pOzCIOeUoFwPgflRvsyjO2+fShMrnTOlKD
         a0vl8xov3c9ltJFob1K8ObSghrkwCzfTmF4X4WxTCjFCqvp7xxepTfqPOjxJ15dkhQ35
         vfiWPsKUO7M3CfUAWztD1QQbHWpBec0EqwBVWA5qQbbggN9/ngklhc94DPgjXfXj+Th5
         E17ohdPncd9zhXm90eJwkbJf1X4ddZYTaxOpaGCcpgAR+6zjtdCyiD9bmsYhf5DaLCBU
         jsH7Xh++dF/G4tejqWnGy6vTVPAnbBN99gfqftxHVeLtFK6UoQqPm5n7uiak/dhXDWXs
         wLdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzyrQVJN64loG8LhIsWG2+/TBvRECjtPlFvZTSgor0JegR8KMhGC78v1ohcudBodsQju3Yb47YfDVPD/MLe@vger.kernel.org
X-Gm-Message-State: AFuF++kik35KrVqCukhtq/nG5WbOXb9vCZpkSmWIOjnfnwLt8A1OOz40
	mrVSM92uk3ySWcFRcNsgwXc3ZDXE3s68WQrhm5YBV2gxp+kMP1Q5URq1hxUEsqfqEsDtYwmhCVM
	DYhRCUg==
X-Received: from dlbro6.prod.google.com ([2002:a05:7022:1586:b0:141:ac8:b5ae])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca8:b0:3c4:46ca:334b
 with SMTP id adf61e73a8af0-3da39cf4744mr31781029637.9.1788763164089; Sun, 06
 Sep 2026 23:39:24 -0700 (PDT)
Date: Sun,  6 Sep 2026 23:39:14 -0700
In-Reply-To: <20260907063918.3432401-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907063918.3432401-2-surenb@google.com>
Subject: [PATCH v2 1/5] proc/task_mmu: remove unnecessary helpers
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

When per-vma locks were behind a config option, a number of helper
functions were needed to simplify the locking code. Now that these
locks are universally available, we can do a little cleanup.
Remove lock_vma_range(), unlock_vma_range(), query_vma_setup(),
query_vma_teardown() helpers.

No functional change intended.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
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
2.55.0.979.g7e5102b832-goog

