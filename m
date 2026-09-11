Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151336B91A
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155737; cv=none; b=T/u4mSTb0aa2BvafSUzZx5mS/aPKh6ZQRjr/GPR1wasxfDO7wdvAQOdt6cdBEnbq4MVB3TQeMZa4knZ76XGpQji4q1vmKVmcseIusk2OmupLiMZvqF8VlJ3JXBIsG58S+o/oZ+AMdviU8KInMvPCQBXMyDgnUNcq73GBFct9nps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155737; c=relaxed/simple;
	bh=iwNq5uu3Zcz820eD4nEDR07scSxQngOrG28BzpUpX0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KTub4DwXYWxaAnQOlBChuQXLLeEXQN4IHLNb4zBe8VH4dnJjzTgb+SInwRITliuEC9myoXrAdNlpKGTc1O5ZkMC9asgImfHlmDTvrbxelYqYJTDi4EfnWuUXU8OxVKqoAWJ2GH9Mp1+uPgR7kLKFwfy+vxljcybDX5TgLZ/jqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jf4B3KNd; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jf4B3KNd"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so2495698a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789155719; x=1789760519; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zej03whk2f8tlO07T6d+N4M+kS17EX2Qpuy0D1YVEz0=;
        b=Jf4B3KNdcYS2cJ041SfVt58lvY0wH/q3scN26lfyaeVDfEIuzE6c+Mn6ZR7Zpz1jjN
         CspqNzHq0NGSsmoa7znJwL+iA+qMhzmO5cGHMBvOgGELq6q1K8DOUGPSO11xfrEGeLin
         d9zVxr1EfINgxw+hoc7Q2qkNCVAfPApQZwZ46RV5SX0SEqEjr3jev9PBA1U6alKvXu6l
         1+I50XofIBZ9Wn56ICyZBs3mWEBPEy8iOKIpGqejGvsOz4ARu+Dh0OxA4ku5jbuhRmNF
         3xOkfVOOBGtRwS0PMhRsW2R+Pisxk8frgFwIO301CF+bBs6WL52w33DLoDpne9YLqubW
         E6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155719; x=1789760519;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zej03whk2f8tlO07T6d+N4M+kS17EX2Qpuy0D1YVEz0=;
        b=GSzFnNblmyrp7BV7erPoFWk2nhRT1/yk6rFBB9Ml3gkouuxMqubGRAVb55lpVwhHa2
         /tru+rRbBLwsKzpTMjreu2SNB3yTYpTlF7/s71iSDDWQ3p6YXv3ZvmX1YS6Fig8EMJ1v
         6eYjIAZlohfRNpYa9fpH3h2m7KInTqy95sU2OeFI7y3LFQf6+cWK/DPykC5IM3mVbRck
         foyT4ikXtCI3wPV7EmzbxkKI4YqV/Gz9UjzioFe3RbEqzhdDa44oWyFJCSBaBykFo9h7
         uuXxmKix2AZ0EubxSeCYD4v6chUOS+8DzZR3BTiG9wb+k4LPQ9w/e5cQmMTQnroEtoh+
         6Z8w==
X-Forwarded-Encrypted: i=1; AKwUvBwTqm++CLRFJEdzDVFUmEEJt1ODqwf4+USRSOWD9qTkR/7Lo8vPzvH/vF+vg09wReqHpmoXg6OqIn0Gg+Yw@vger.kernel.org
X-Gm-Message-State: AFuF++l/js6ZLI7J5NoXmCV286LRX/wVVPQ5XMwBGrUjnZ/RgMSx40jq
	36dqH00b33jMaEBkQZkExHsl6fnEkgTpUX0hSpZlT2Lok5OH6DvaMsFy3I04sd4yL3IioirxTOq
	Df/rU8g==
X-Received: from dlzz14.prod.google.com ([2002:a05:7022:48e:b0:143:5477:e9f])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:280e:b0:395:5eec:b932
 with SMTP id 98e67ed59e1d1-39d9beb7248mr9867936a91.11.1789155719169; Fri, 11
 Sep 2026 12:41:59 -0700 (PDT)
Date: Fri, 11 Sep 2026 12:41:43 -0700
In-Reply-To: <20260911194145.1781926-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911194145.1781926-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911194145.1781926-6-surenb@google.com>
Subject: [PATCH v4 5/7] proc/task_mmu: change proc_get_vma() to stop returning
 gate VMA at the end
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@kernel.org, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	xueyuan.chen21@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

proc_get_vma() returning gate VMA at the end is desirable for the its
current m_start/m_next callers, as they need to report a gate VMA at the
end of the address space. This behavior is very specific to these callers
and makes proc_get_vma() hard to use for other purposes.

Move this usage-specific behavior into the callers themselves so that
proc_get_vma() returns either a valid VMA, an error or a NULL when no
more VMAs are available. This makes it more generic, simpler and usable
in the later patches.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/task_mmu.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index a6026ffd07f1..aef7ce659889 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -236,9 +236,6 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
 		 * found the extended vma with the same vm_start.
 		 */
 		*ppos = vma->vm_end;
-	} else {
-		*ppos = SENTINEL_VMA_GATE;
-		vma = get_gate_vma(priv->lock_ctx.mm);
 	}
 
 	return vma;
@@ -248,6 +245,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
 	struct proc_maps_locking_ctx *lock_ctx;
+	struct vm_area_struct *vma;
 	loff_t last_addr = *ppos;
 	struct mm_struct *mm;
 
@@ -277,19 +275,39 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		*ppos = last_addr = priv->last_pos;
 	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
 	hold_task_mempolicy(priv);
+	/*
+	 * If seq_file had to flush its collected data right after m_next() set
+	 * position to SENTINEL_VMA_GATE, m_start() will get that sentinel and
+	 * should return gate_vma without calling proc_get_vma().
+	 */
 	if (last_addr == SENTINEL_VMA_GATE)
 		return get_gate_vma(mm);
 
-	return proc_get_vma(m, ppos);
+	vma = proc_get_vma(m, ppos);
+	if (vma)
+		return vma;
+
+	/* Return gate VMA at the end */
+	*ppos = SENTINEL_VMA_GATE;
+	return get_gate_vma(mm);
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
+	struct proc_maps_private *priv = m->private;
+	struct vm_area_struct *vma;
+
 	if (*ppos == SENTINEL_VMA_GATE) {
 		*ppos = SENTINEL_VMA_END;
 		return NULL;
 	}
-	return proc_get_vma(m, ppos);
+	vma = proc_get_vma(m, ppos);
+	if (vma)
+		return vma;
+
+	/* Return gate VMA at the end */
+	*ppos = SENTINEL_VMA_GATE;
+	return get_gate_vma(priv->lock_ctx.mm);
 }
 
 static void m_stop(struct seq_file *m, void *v)
-- 
2.55.0.1007.g17ff1f9808-goog

