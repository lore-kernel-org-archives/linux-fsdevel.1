Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E983AFCF2
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084073; cv=none; b=qk4Xr4IOCJDpMZs0Du8eA+ecsOUzquRH2qX2a/y053hAEs1Onb1FQbTUmCjbUloB2/1zB8B7AD4NSebsOEs6lcxLWJnuF0eYcmzmUWCOwripQWpfxu/QEywhkC18GhzBovcwd64FB5oPR2nNMyOwZ1eSo97JyEl3SBPMWCJ/SyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084073; c=relaxed/simple;
	bh=nxUjcuynGltbYuaJwcnnVoLQs4OJN0lo92nfhwCqV2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l3xs21lA6Mg0SOBQuhlACNifowzTDPl3oBjXYl9navbyHAHI8VXu3z3wOSCIQ/fuMSc4QJ3gG62hTRguev24C4CKMPQ83ldqmfqnO1Qx0ykwMXH9k5CvbyTY40qc8/VJR3909xc9VdYthSkbvoR85WAIxd6yQ9JRbDa30lhCDrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PX4sK0E1; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PX4sK0E1"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-385d2703b64so1684388a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789084072; x=1789688872; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qU0KV0gIPZqolm93iR//P4qXqNLqAOfvp4joEi9Yvyk=;
        b=PX4sK0E1kYNezqddwB+TVCJRphZqDqvvh4wSGGWcPjJMGaqxSNlb97M2kKMt/wV75P
         LnNxbip7o4QGQsazWM5PN3fzn29GhCnlrwsX10TXNqOG51Z+sUt62YDKpKDQqZPQYJlS
         hdaFUmgBpuW7xexRbpI8NTxyEFx3KpyHnTlu/VjTWmgbRYfkAT5gMyndK3pMV04rjdKa
         HInEGQoJISd8kwEd2qA6xcTIyOkvj+r/K9eGY0DBCR5yhhgtA4ZEJlLFJ0DtOI4agU/Q
         UnyTtwrVQe5eJjVdxTq9Mqx0AO5BGFcBw++KRJc0Q589wM5cVNu9lTyMBPHcsTTKVeAi
         Aslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084072; x=1789688872;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qU0KV0gIPZqolm93iR//P4qXqNLqAOfvp4joEi9Yvyk=;
        b=K8t2wQw9uhPXeHGmPrO2gjWKoYAH4QtgTUdo8kMv1lKKVo7MaOCpGsHNrFm6O+tYLn
         NSD93aoElgVUyao2Y18AOLeJr+9b5escO0mPEJvJs6H25fEE/f3KXuRBaD0gbw+qt9ss
         ZfobOfbuTabcYQozLloH/nmrtEb49uk2g0PDG/r91ysyXe99+BLXGlGn0+KhGqH2yHmc
         RGq7CRXVCXfiEIA4yk8210aPtMkrSXDr66Kg3MVMf7qaQaLfDY93eBcP5AWvxbmCXmBP
         4R9lgs8I9miVhGLfd7gxPI9yv75KIHsNHqKd4jX0451pXaBy9mA1SBDlil2J+kGaNvud
         whsQ==
X-Forwarded-Encrypted: i=1; AKwUvByDSZKAQ/3s0vxLk9qfRYsX5qVRt9oIPu3onKhVC1+mQ2Q8KzC9iIZ2dgX50ORLa7BlL/iO+r8TeMSgH1bI@vger.kernel.org
X-Gm-Message-State: AFuF++lBUMlNHnoLP5rKIRK3iJ+XcMGBUk/8UuxTxgHXSJK7kYr4ZAVY
	50JP7Pp1BVfOJbN3vsLPtzmg1GKNBDDOsphleqMRUXYbqiQe45mhHabvOfEQ8HDH2dJUAmydVRu
	xrlnduQ==
X-Received: from dlbbq8.prod.google.com ([2002:a05:7022:6708:b0:143:6807:5e3b])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c85:b0:38f:cfe2:fd3a
 with SMTP id 98e67ed59e1d1-39d77b1c383mr8988591a91.15.1789084071601; Thu, 10
 Sep 2026 16:47:51 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:47:34 -0700
In-Reply-To: <20260910234737.1340642-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910234737.1340642-5-surenb@google.com>
Subject: [PATCH v3 4/7] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	xueyuan.chen21@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

smap_gather_stats() interprets its start parameter to mean vma->vm_start
when it's set to 0. Eliminate this special interpretation and pass
vma->vm_start explicitly when needed.

Since smap_gather_stats() operates within a single VMA, we can replace
walk_page_vma()/walk_page_range() calls with walk_page_range_vma()
which is simpler and also can be called while holding per-VMA lock.

No functional change intended.

Suggested by: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
---
 fs/proc/task_mmu.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3c40c9cbb9c9..ecce7ce116cb 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1246,21 +1246,27 @@ get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
 	return &smaps_shmem_walk_vma_lock_ops;
 }
 
-/*
- * Gather mem stats from @vma with the indicated beginning
- * address @start, and keep them in @mss.
+/**
+ * smap_gather_stats() - Gather mem stats from @vma.
+ * @priv: proc maps private state.
+ * @vma: The VMA to gather stats for.
+ * @mss: The accumulated stats.
+ * @start: The address from which to start.
  *
- * Use vm_start of @vma as the beginning address if @start is 0.
+ * This gathers stats for the whole of the VMA unless the lock was dropped
+ * and VMA grew or got merged and we found it again, in which case we only
+ * gather stats for the remainder of the VMA range.
  */
 static void smap_gather_stats(struct proc_maps_private *priv,
 			      struct vm_area_struct *vma,
-			      struct mem_size_stats *mss, unsigned long start)
+			      struct mem_size_stats *mss,
+			      unsigned long start)
 {
 	const struct mm_walk_ops *ops = get_smaps_walk_ops(priv);
 	const bool is_partial = start > vma->vm_start;
 
 	/* Invalid start */
-	if (start >= vma->vm_end)
+	if (start < vma->vm_start || start >= vma->vm_end)
 		return;
 
 	if (vma == get_gate_vma(priv->lock_ctx.mm))
@@ -1285,10 +1291,7 @@ static void smap_gather_stats(struct proc_maps_private *priv,
 			mss->swap += shmem_swapped;
 	}
 
-	if (!start)
-		walk_page_vma(vma, ops, mss);
-	else
-		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
+	walk_page_range_vma(vma, start, vma->vm_end, ops, mss);
 
 	reacquire_rcu(priv);
 }
@@ -1343,7 +1346,7 @@ static int show_smap(struct seq_file *m, void *v)
 	struct vm_area_struct *vma = v;
 	struct mem_size_stats mss = {};
 
-	smap_gather_stats(priv, vma, &mss, 0);
+	smap_gather_stats(priv, vma, &mss, vma->vm_start);
 
 	show_map_vma(m, vma);
 
@@ -1396,7 +1399,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 	vma_start = vma->vm_start;
 	do {
-		smap_gather_stats(priv, vma, &mss, 0);
+		smap_gather_stats(priv, vma, &mss, vma->vm_start);
 		last_vma_end = vma->vm_end;
 
 		/*
@@ -1455,7 +1458,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 			/* Case 1 and 2 above */
 			if (vma->vm_start >= last_vma_end) {
-				smap_gather_stats(priv, vma, &mss, 0);
+				smap_gather_stats(priv, vma, &mss, vma->vm_start);
 				last_vma_end = vma->vm_end;
 				continue;
 			}
-- 
2.55.0.1007.g17ff1f9808-goog

