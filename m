Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956E1FBEB0
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 01:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711055; cv=none; b=hoUwZX7V2UO4ao0AQqF8P4tgCCM1DD3FZaPET19Mk4nJF4CpT6aLBsZJR4eMN7NjShZk9kgmdzLeszU2HFtDJS5+VCdFU6S/QnwijqoNTguIbzA8zWkkaV9G9LVTiqARTU7cdEtNJg2XF6VSoXTxJSdQR0PhGlhrHrLXP1Rajus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711055; c=relaxed/simple;
	bh=0nVvrLAnRlNYu1jJE6KbminAfA3uAQeGlmIUWfgHlaM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lxfEN1H/vDfLEE6VZkegDpf+e0jQWpWK6NC5Jv8e+L+6uexuIEK1lw1Y9xvE0tUT0FsxEjsOyEJy90wAfgjLZdFZ9je4Kzo8+Hwu8VVkCAkzACJ+yHyc6PmjM1Cop10H+cmMjSq7dRV/aGF9PFGyo+5mv6jyJAJmHsyA09/On/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBoF/NCf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBoF/NCf"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so4118742a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 18:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780711053; x=1781315853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1d9I+KVhftNxuemtZnTHQgG/X/rMQMH6c1hS3FXahc0=;
        b=kBoF/NCfVLcNWWWsnoXtiNX5/kuqu1gPCDF+qLCY+0Z+E2OZTpVEyn5lgq0Fl3HQ/z
         LnSvEhoFAapq4Cs2gO7NMrAiwBb6UHpiLwk7zCTCe2bGL+qrW2N1+1HmUJF7GaPUZqxc
         vkEszJTK2GZkGi0OZ6J9HI44Qg34hUNv1v7uLrTGSzpjTXT5RNqHTmAXW97O9RLYoN0S
         7DaWVTBv9hPwMzvXHrElEG6peEfBeMYgwk35snWsREdXg4FO6CWBxpzbKdZHwAM307J9
         r2ErhQolbA+rKkHOWvwVN94JXuYYGM/qlZ/2Jw+QH+mVMQPLJiQqSsDYH2q18P+ZIdaQ
         uxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780711053; x=1781315853;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1d9I+KVhftNxuemtZnTHQgG/X/rMQMH6c1hS3FXahc0=;
        b=l0VfmScPwKKqVfn1jEiGiG4WAINMKzXLid90AsdvMOf5phA43WYOyqUMClbBL6FDMP
         bQCugMAsDf6CbfdPnoT4PN33O18FIZrs75/RyTWqtdFpX2+k7h5awSB4RBi6pdGUWYVY
         N4eaFxm9G1BxBgYN54UVJnWlgU060H2/NNUSDt92e3xF/xSrU3ZTtowgjYBP5eNwDzh7
         i1G2VKLMk10DnJuvVWjkkVzvWKSk01CBMf1ayIlXg/bCSEuPJSed/kmUWVZzK+H8Bn6S
         3WXh1VNl5qU+191nWBDYuyh/O9hZ8qURu6+dhR7I6LDJf0JQYFZILj2Nab6kiwT56mH5
         f4Tw==
X-Forwarded-Encrypted: i=1; AFNElJ/VOAoydBcsgPBGka219G0/3Py1Wi/9BK0l5Ps1gN3ZFVwVRqmjCfgnGtfO5bMoioagcr8ZofaulQ7gDeIK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlnn/rNAGTBvmVB/a1qRAP14P5Vxm23LEk+VyhsNSkLvq5fL8p
	PJnDNDLf55knqD2jVMrSF7YKhYXecFM9QD9Tgm0IU4SGhRfxr0Ugsv33aIEhlimggW+VvxAJvFZ
	qrPx+Ew==
X-Received: from plblv12.prod.google.com ([2002:a17:903:2a8c:b0:2bf:235:ff11])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da4b:b0:2c1:f262:495f
 with SMTP id d9443c01a7336-2c1f2624bcemr52181685ad.26.1780711052790; Fri, 05
 Jun 2026 18:57:32 -0700 (PDT)
Date: Fri,  5 Jun 2026 18:57:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260606015729.1837935-1-surenb@google.com>
Subject: [PATCH 1/2] fs/proc/task_mmu: change lock_vma_range() to return error code
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

To correctly propagate error code from lock_vma_range(), change it to
return the error code instead of the boolean. This simplifies error
propagation code.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d32408f7cd5e..023422fcee12 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -162,13 +162,13 @@ static void unlock_ctx_vma(struct proc_maps_locking_ctx *lock_ctx)
 	}
 }
 
-static inline bool lock_vma_range(struct seq_file *m,
-				  struct proc_maps_locking_ctx *lock_ctx)
+static inline int lock_vma_range(struct seq_file *m,
+				 struct proc_maps_locking_ctx *lock_ctx)
 {
 	rcu_read_lock();
 	reset_lock_ctx(lock_ctx);
 
-	return true;
+	return 0;
 }
 
 static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_ctx)
@@ -245,10 +245,10 @@ static inline void unlock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
 	mmap_read_unlock(lock_ctx->mm);
 }
 
-static inline bool lock_vma_range(struct seq_file *m,
+static inline int lock_vma_range(struct seq_file *m,
 				  struct proc_maps_locking_ctx *lock_ctx)
 {
-	return lock_ctx_mm(lock_ctx) == 0;
+	return lock_ctx_mm(lock_ctx);
 }
 
 static inline void unlock_vma_range(struct proc_maps_locking_ctx *lock_ctx)
@@ -311,6 +311,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	struct proc_maps_locking_ctx *lock_ctx;
 	loff_t last_addr = *ppos;
 	struct mm_struct *mm;
+	int err;
 
 	/* See m_next(). Zero at the start or after lseek. */
 	if (last_addr == SENTINEL_VMA_END)
@@ -328,11 +329,12 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return NULL;
 	}
 
-	if (!lock_vma_range(m, lock_ctx)) {
+	err = lock_vma_range(m, lock_ctx);
+	if (err) {
 		mmput(mm);
 		put_task_struct(priv->task);
 		priv->task = NULL;
-		return ERR_PTR(-EINTR);
+		return ERR_PTR(err);
 	}
 
 	/*

base-commit: e178a530a81621a29efbca49b3b78202a18236e4
-- 
2.54.0.1032.g2f8565e1d1-goog

