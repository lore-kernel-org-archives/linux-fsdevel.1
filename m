Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D273B2FD0
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084076; cv=none; b=CrbaYSZIR3GPI67prsERZWEG9vUM8X87/MGixa2j27XLJlWbaSuIOViR78MCcbqEfTJ0aOSk4aOyWESiSrOjh0dofcW7tMqM+a1u8rPrns6en3uo2n9S/Q4K5OJSHrogNG6iVUSsz0iF7X6Znf9omhI8L1eZYwBUAyeg1ZLxUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084076; c=relaxed/simple;
	bh=KhRCJzmke+4iaURyvggRPxbo/5drXC/+C8xLYAdIcD8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g6k0J/k6wM66w4VQ5E+JqPYawzYvJAr+F2o5Ld6fGYjtjdHJlmBOrmkGf/njm1JR5jPM3lkiGaE5Igvqf/u5GfE55b+awwuUDmxe86n7MeySrbSJER0mSYKGghpqk7RcaL7wYFAjs/mHLOKNkgaS/xu7X4rSOTKWPvCubwplj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TxzcKceL; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxzcKceL"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8696b921ac0so404153b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 16:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789084074; x=1789688874; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfCQoIF9r6drT2/q6iU4FW+cbq+J7ShlN3xdWU35XRs=;
        b=TxzcKceLM7asScqwsrJkgFvfAKa+hDieijvzctqFL2WrzGorzaYthmZGgfO7bFK04o
         pnGQa8D3OHAqPIH4/hheinblOT6NUaPeBi5BHBVdroZrk+0J4yfZ/YZRbAILmrGs3aT5
         vd2Q9OqR5/XxV046N3uPlL2nlBKiMEQ4+36QEJemfPiZZJ2UyR448Z5132oEKZUo79Fm
         zk97j3igXDZhvPI23Ycd+1nvQnuEUAzqzKm07mIt2FeKe1mnlEjw8Y4GbgZy1Q267fes
         MyItsmIfcKJ4JV7eO+ray7Zs35lrJn+0ahB58+0+m4wYr87iZMAlXQCA6ZB1BIiRJPxu
         Pl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084074; x=1789688874;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MfCQoIF9r6drT2/q6iU4FW+cbq+J7ShlN3xdWU35XRs=;
        b=m4Pi80YTqeSI6CX7BkN315JO/8vKC4Rkx93nnChNjRKHc/SsUA80i9mLsvsdWLFiVg
         6f1R2DCN3qUvNFis4MzNrHQB3PvthFlnFDklTirr+goBLmqAbDPKd/QKpUcMxPOb7lbU
         qWsrPC6QbxMg3DBjc+/Cc8mccXO3S0ShJ/DpJUYfdfFUUclZMhRqe1rJQ58NTxWaHgco
         dM2m7wUSsqKYRszsX0nkdSdCiQVYOIVYaXwfaQnTn+4v6g18oelfJjKH6+JnIR/WTWPr
         a4UeM0N48IENB5K1nJy9149sHlfw3M+46H+DuHkSTjQWnCHXhJ+DeoIkNO2eI/e+Pp1t
         kxzA==
X-Forwarded-Encrypted: i=1; AKwUvBzCdErMoKg10R3DtYq3ZK1vHnmF+d+KtvdkCsasFcko3xoW/WOF0CwtLrb/4gKXZ8xM5rl2toTHSCY/xWCR@vger.kernel.org
X-Gm-Message-State: AFuF++kbuqsJ55bRe5JVMSjJh3Cb0JwzHTlimif1klmnkLCyWm51vteR
	rQguTn0/C5fuK00/VX0J+NKBo8CiH2vvE+YSXYgydnNJ8s6I5Xwmgu9YAsYmhjm7Dfy6wk+6/gW
	V2e5zug==
X-Received: from dlk12.prod.google.com ([2002:a05:7022:10c:b0:143:54dd:1d39])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4309:b0:3da:1e7b:ea27
 with SMTP id adf61e73a8af0-3daed3b7eaemr2196858637.21.1789084073982; Thu, 10
 Sep 2026 16:47:53 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:47:35 -0700
In-Reply-To: <20260910234737.1340642-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910234737.1340642-6-surenb@google.com>
Subject: [PATCH v3 5/7] proc/task_mmu: change proc_get_vma() to stop returning
 gate VMA at the end
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
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
---
 fs/proc/task_mmu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ecce7ce116cb..9a3c996c1d61 100644
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
 
@@ -280,16 +278,31 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
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

