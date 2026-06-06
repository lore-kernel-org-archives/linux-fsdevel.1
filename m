Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A38233723
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 01:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711062; cv=none; b=aFraAzhAqR8kmhCDR+Ug8jOCqavrR/e6/Il+nvWAczpzfyJzxC/BrhNpYkcTucPcy2lgy/dXyAhi/Dp4qoQa0DAekK3y/AIvuiaaD7z8nsLNBZ+HazEgc6sDQQ3jePPcT/RI1SPHldibHAVteL6mlSY99Rv8G94/26NmoELQ1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711062; c=relaxed/simple;
	bh=Xgh0devgYbJ9v4P85L8UTuyDRF/8EpIXVf5zhK9WkuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iH1S1fayt5EbAdCCaKXWCgKJqo6VgAwflISnIucPk1W6386AK8+nGT8GUjwdIR87rwvUENKKW12LZGbXj8omSMOaaI36+x+/Q7es2HQuwtSDN6n5UD5KQPCpQ4V0/Js75tiG7ubR8K+SKBM1N/hpAeprMxXpPp0Zu/dcvKDCnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OO8t9nGF; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OO8t9nGF"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ed777a96so1436421eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 18:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780711060; x=1781315860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LskI7o3bjkNbR0+FjqKAOKBLRy4mR1cF+3UOhyNarXg=;
        b=OO8t9nGFkrTUxv4D7QJ/XpUc619mNM+DnlzRzqIGS1UQGSUFmcWCeJQMSmgHoXkyf9
         Di7mTFwfawd9TjPwlCBcdQFS4X2LD7NbKB/xLZ6CJetc7ciyGkPUCGp6380A1/Jwl3bB
         rhtBBePUhQIcVCrIoQ8U1bcySPgy5bDOXCo4nyQ+JOc0YAit7KMpmsvn4/b9sU/uR3sQ
         +f5sLqJqi/wfvtJnnR0OudiLBsA1ZtNu1EvY9emZ/4C79WZlgXH9wuxPVcEHzCWRMgNw
         UHZ4wdE7k7PZraAlDHnRJvwaPJEdp2TGGKeGQpJQZ5RUMMKAAp4hpW1vAKvXzLDO6gsn
         fEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780711060; x=1781315860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LskI7o3bjkNbR0+FjqKAOKBLRy4mR1cF+3UOhyNarXg=;
        b=lZk/0DLm8DwS01yLE4Luv1p9QoNtuAhwLSBITiAYLot+7csryXvF5P44axwtRzmdAq
         zSleswWGzAqdp6CAax4OWhxCecTbylr9t59N+K8fJGxRQl6rxXrX0ufpITZGuhph55cz
         fp3cIAOBSFhePFHIOIGsaWCCHoTHR5eoMaYh9ANCZtr+/zSZwOFxr2/UDACXustWr7t4
         LGjaiNol93FK/NWUR+zVEpOENKR4iXB9/q2aB8PXeU9+P8dryRT+25rIigXY+WBefOHn
         NMt/Up1XvOxvHtV2SEmCom9GzobNQhNdwy1PPbrZU0Lg1zCQQeKZDPhXyS62CWBvcRa8
         MqcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+g6BsoL3mDo/FUHJdVOg663BzV9HKSdOMSfoMPHVMB6FGBYdWPC1DPCWBQoFjauZL7Rq56+MPcV8YhYpYV@vger.kernel.org
X-Gm-Message-State: AOJu0YwER4u4YTwosZhHOKOrbkhBpdTyfKTm14IYgsuqAMinf3Rat8Sy
	PwGcVVM+HXtYJ5kHUOCuYwjnjQ+8SKU70XM6ZpQu3ZJVe13LoxDOFmQhieZFbBOZsjOLED9E+J4
	+WqJpxQ==
X-Received: from dyblc27.prod.google.com ([2002:a05:7301:131b:b0:303:98b0:efec])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fe04:b0:304:70d0:4f03
 with SMTP id 5a478bee46e88-3077fe1125emr2807002eec.6.1780711059900; Fri, 05
 Jun 2026 18:57:39 -0700 (PDT)
Date: Fri,  5 Jun 2026 18:57:29 -0700
In-Reply-To: <20260606015729.1837935-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260606015729.1837935-1-surenb@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260606015729.1837935-2-surenb@google.com>
Subject: [PATCH 2/2] fs/proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

proc/pid/smaps_rollup can be read using the combination of RCU and
VMA read locks, similar to proc/pid/{maps|smaps|numa_maps}. RCU is
required to safely traverse the VMA tree and VMA lock stabilizes the
VMA being processed and the pagetable walk.
Note that we have to keep the logic to drop mmap_lock on contention
because even when using per-VMA locks we might have to fall back to
holding the mmap_lock.

Running Paul's contention benchmark [1] shows considerable improvement
both in median and in the worst case latencies:

Execution command: run-proc-vs-map.sh --nsamples 20 --rawdata -- \
--busyduration 2 --procfile smaps_rollup

Baseline:

    0.174     0.161     2.553
    0.174     0.164     2.663
    0.174     0.165     2.664
    0.174     0.166     2.679
    0.174     0.167     2.691
    0.174     0.168     2.704
    0.174     0.169     2.729
    0.174     0.172     2.741
    0.174     0.174     2.745
    0.174     0.174     2.755
    0.174     0.175     2.790
    0.174     0.177     2.809
    0.174     0.179     3.096
    0.174     0.183     3.144
    0.174     0.184     3.158
    0.174     0.185     3.175
    0.174     0.185     4.568
    0.174     0.198     4.821
    0.174     0.214     5.143
    0.174     0.251     5.220

Patched:

    0.007     0.007     1.952
    0.007     0.007     1.955
    0.007     0.007     1.955
    0.007     0.007     1.955
    0.007     0.007     1.957
    0.007     0.007     1.969
    0.007     0.007     2.065
    0.007     0.007     2.075
    0.007     0.007     2.146
    0.007     0.007     2.195
    0.007     0.007     2.223
    0.007     0.007     2.259
    0.007     0.007     2.488
    0.007     0.007     2.562
    0.007     0.007     2.599
    0.007     0.007     2.697
    0.007     0.007     3.030
    0.007     0.007     3.075
    0.007     0.007     3.145
    0.007     0.007     3.225

[1] https://github.com/paulmckrcu/proc-mmap_sem-test

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 134 ++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 75 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 023422fcee12..c2bd9f5bbbcd 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -233,6 +233,16 @@ static inline void reacquire_rcu(struct proc_maps_private *priv)
 	vma_iter_set(&priv->iter, priv->lock_ctx.locked_vma->vm_end);
 }
 
+static inline bool is_mmap_lock_contended(struct proc_maps_private *priv)
+{
+	struct proc_maps_locking_ctx *lock_ctx = &priv->lock_ctx;
+
+	if (!lock_ctx->mmap_locked)
+		return false;
+
+	return !!mmap_lock_is_contended(lock_ctx->mm);
+}
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline int lock_ctx_mm(struct proc_maps_locking_ctx *lock_ctx)
@@ -268,6 +278,11 @@ static inline bool fallback_to_mmap_lock(struct proc_maps_private *priv,
 	return false;
 }
 
+static inline bool is_mmap_lock_contended(struct proc_maps_private *priv)
+{
+	return !!mmap_lock_is_contended(priv->lock_ctx.mm);
+}
+
 static inline void drop_rcu(struct proc_maps_private *priv) {}
 static inline void reacquire_rcu(struct proc_maps_private *priv) {}
 
@@ -1486,12 +1501,15 @@ static int show_smap(struct seq_file *m, void *v)
 static int show_smaps_rollup(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
+	struct proc_maps_locking_ctx *lock_ctx = &priv->lock_ctx;
+	struct mm_struct *mm = lock_ctx->mm;
 	struct mem_size_stats mss = {};
-	struct mm_struct *mm = priv->lock_ctx.mm;
 	struct vm_area_struct *vma;
-	unsigned long vma_start = 0, last_vma_end = 0;
+	unsigned long vma_start = 0;
+	unsigned long last_vma_end = 0;
+	loff_t pos = 0;
 	int ret = 0;
-	VMA_ITERATOR(vmi, mm, 0);
+
 
 	priv->task = get_proc_task(priv->inode);
 	if (!priv->task)
@@ -1502,89 +1520,55 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		goto out_put_task;
 	}
 
-	ret = lock_ctx_mm(&priv->lock_ctx);
+	hold_task_mempolicy(priv);
+	ret = lock_vma_range(m, lock_ctx);
 	if (ret)
 		goto out_put_mm;
 
-	hold_task_mempolicy(priv);
-	vma = vma_next(&vmi);
-
-	if (unlikely(!vma))
+	vma_iter_init(&priv->iter, mm, 0);
+	vma = proc_get_vma(m, &pos);
+	if (unlikely(!vma) || vma == get_gate_vma(priv->lock_ctx.mm))
 		goto empty_set;
 
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto out_unlock;
+	}
+
 	vma_start = vma->vm_start;
-	do {
-		smap_gather_stats(priv, vma, &mss, 0);
+	while (vma) {
+		if (IS_ERR(vma)) {
+			ret = PTR_ERR(vma);
+			goto out_unlock;
+		}
+
+		if (vma == get_gate_vma(priv->lock_ctx.mm))
+			break;
+
+		/*
+		 * If after retaking mmap_lock, already reported VMA grew or
+		 * merged with the next one, then iterate from last_vma_end.
+		 */
+		smap_gather_stats(priv, vma, &mss,
+				  vma->vm_start < last_vma_end ? last_vma_end : 0);
 		last_vma_end = vma->vm_end;
 
 		/*
 		 * Release mmap_lock temporarily if someone wants to
-		 * access it for write request.
+		 * take it for write request.
 		 */
-		if (mmap_lock_is_contended(mm)) {
-			vma_iter_invalidate(&vmi);
-			unlock_ctx_mm(&priv->lock_ctx);
-			ret = lock_ctx_mm(&priv->lock_ctx);
-			if (ret) {
-				release_task_mempolicy(priv);
+		if (is_mmap_lock_contended(priv)) {
+			unlock_vma_range(&priv->lock_ctx);
+			ret = lock_vma_range(m, lock_ctx);
+			if (ret)
 				goto out_put_mm;
-			}
-
-			/*
-			 * After dropping the lock, there are four cases to
-			 * consider. See the following example for explanation.
-			 *
-			 *   +------+------+-----------+
-			 *   | VMA1 | VMA2 | VMA3      |
-			 *   +------+------+-----------+
-			 *   |      |      |           |
-			 *  4k     8k     16k         400k
-			 *
-			 * Suppose we drop the lock after reading VMA2 due to
-			 * contention, then we get:
-			 *
-			 *	last_vma_end = 16k
-			 *
-			 * 1) VMA2 is freed, but VMA3 exists:
-			 *
-			 *    vma_next(vmi) will return VMA3.
-			 *    In this case, just continue from VMA3.
-			 *
-			 * 2) VMA2 still exists:
-			 *
-			 *    vma_next(vmi) will return VMA3.
-			 *    In this case, just continue from VMA3.
-			 *
-			 * 3) No more VMAs can be found:
-			 *
-			 *    vma_next(vmi) will return NULL.
-			 *    No more things to do, just break.
-			 *
-			 * 4) (last_vma_end - 1) is the middle of a vma (VMA'):
-			 *
-			 *    vma_next(vmi) will return VMA' whose range
-			 *    contains last_vma_end.
-			 *    Iterate VMA' from last_vma_end.
-			 */
-			vma = vma_next(&vmi);
-			/* Case 3 above */
-			if (!vma)
-				break;
-
-			/* Case 1 and 2 above */
-			if (vma->vm_start >= last_vma_end) {
-				smap_gather_stats(priv, vma, &mss, 0);
-				last_vma_end = vma->vm_end;
-				continue;
-			}
 
-			/* Case 4 above */
-			if (vma->vm_end > last_vma_end) {
-				smap_gather_stats(priv, vma, &mss, last_vma_end);
-				last_vma_end = vma->vm_end;
-			}
+			/* Resume from the last position. */
+			pos = last_vma_end;
+			vma_iter_init(&priv->iter, mm, pos);
 		}
-	} for_each_vma(vmi, vma);
+		vma = proc_get_vma(m, &pos);
+	}
 
 empty_set:
 	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
@@ -1593,10 +1577,10 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 	__show_smap(m, &mss, true);
 
-	release_task_mempolicy(priv);
-	unlock_ctx_mm(&priv->lock_ctx);
-
+out_unlock:
+	unlock_vma_range(&priv->lock_ctx);
 out_put_mm:
+	release_task_mempolicy(priv);
 	mmput(mm);
 out_put_task:
 	put_task_struct(priv->task);
-- 
2.54.0.1032.g2f8565e1d1-goog

