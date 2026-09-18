Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEE503912
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745614; cv=none; b=tnb/07cx3ALn1/YhNGAdxlqlsFv0oyHUhU7HGJIapTj4uL8bycMD4Tt2XWMW5lKJgF8zOvdicoEfyWS7TP7EYBzQ6E5LintPdHfOqZYEY/6GZZvDkdvZ1bpukc/A0ZgF+WX40kqie5AwUUfeTYDn7ehm2jUL5Gt7q7I1yJ5rKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745614; c=relaxed/simple;
	bh=oZ/fvi1k3DBUjyI5jwjRUhQencv56NnJtg/3XEZIHys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DxJYq4FEW8xPkWGbSI1dmsLf5a/t22vP3UpEVwXlcSRPqWEipBlLbtjvGpmqbr/X0aNXDRmEYAT7kKG8KHwcWt4EilZhK4lvD2jBEzAGNsvWoTWe7wdJ3J5VyL0+NFriQjgnCfDIrC0xujxzLtSdFlaUOfm//gLTdmTIzvnKdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9i36t6K; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9i36t6K"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39deda201bcso88438a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789745611; x=1790350411; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lv14f2Ly5jvNlP8xqLAumR3AMqosSrAJIJiLUsY0qSI=;
        b=n9i36t6KbS4CJ5stYwzw0HkXIZXHjaA0Hh6ILrDQEiEejy7c3Xqs4QtWyPFtTgvRlk
         zhsgc/xy/hRSiedZKRgJ0wMW1xsQqXRWruHnvNcqboawv93danlDRXGjpUNEwbcDdrgX
         u9LjewKBF5OTu3fD28sRMUkNht2k+Y0R663hIvz8WbpyrkF72t4LH+MriGEidFOe+5Yf
         jRhm6DaSMjESHyqp1li6ZJLPKf5yPMIwAHqHXJjUwvXb9UBkXmX265GzOG/2RKJN8K9v
         JASbdVMjdCoiC7FpR4jqFxX+l6iYxiTPqyep37wB6w23hNxyvtDui/fKeGJy++r5amaO
         EIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745611; x=1790350411;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lv14f2Ly5jvNlP8xqLAumR3AMqosSrAJIJiLUsY0qSI=;
        b=UJlve88n9CykXK690HLpicus3L0QefEY1kJcbPGnc/G/05pat3YjlsoRav0GWfhRww
         Ct3ZxVEBmtQYBIyHWqr3m+NvwlXxBrHzhz5gB2l9Ndl1mgt7tEvipbm+7Kdaysdd70Wv
         vbIh0zdHwNhOttQCcdIlxAP8y0FYxv0ILzAH7T0ra7R01KQAdngen2V7GDQXB06T8aPV
         mA6CM0WGWAgbY6BmA5sjdjANR0052GRed4KSQtFwI3VPMSn2jxn01R0+o4QtxtFvH0Tc
         ikjWtof1PzyhSdDzcnA9tK4oqYtTZ9QlbEHZ4gAjfbM8U1bTPKar+naD4eGlwiq3vF/r
         X1Cw==
X-Forwarded-Encrypted: i=1; AKwUvBwwrlvCVPaUJjcqkroNezOLUzmc+Q0KCZmtATh3B59bwoEFSb4uXfax7uCLOp7PIbCvIz/qerH9gO+iN5qW@vger.kernel.org
X-Gm-Message-State: AFuF++m+Qre/ENv8n/JdEdcEI+iK/IgCz8654TAgksMDRbq99zgV4TOM
	U3KtMpJau8sFza3Q8+N1HzjkjEWft1hPkClP3T4bpn15sFQOl1vp8LNT36n6YJWnwSBaEtOa/fs
	4vfjK9Q==
X-Received: from dlbcy8.prod.google.com ([2002:a05:7022:b88:b0:143:7b76:ee9c])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d410:b0:39d:f024:c7e2
 with SMTP id 98e67ed59e1d1-39e54cb099bmr6569591a91.4.1789745611342; Fri, 18
 Sep 2026 08:33:31 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:33:16 -0700
In-Reply-To: <20260918153318.758387-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918153318.758387-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918153318.758387-6-surenb@google.com>
Subject: [PATCH v5 5/7] proc/task_mmu: change proc_get_vma() to stop returning
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
index 8f2f302d4563..2c90b91d271b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -240,9 +240,6 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
 		 * found the extended vma with the same vm_start.
 		 */
 		*ppos = vma->vm_end;
-	} else {
-		*ppos = SENTINEL_VMA_GATE;
-		vma = get_gate_vma(priv->lock_ctx.mm);
 	}
 
 	return vma;
@@ -252,6 +249,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
 	struct proc_maps_locking_ctx *lock_ctx;
+	struct vm_area_struct *vma;
 	loff_t last_addr = *ppos;
 	struct mm_struct *mm;
 
@@ -281,19 +279,39 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
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
2.55.0.1082.g2b9226bbc0-goog

