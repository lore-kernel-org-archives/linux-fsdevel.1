Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656A5678E4
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155726; cv=none; b=klT6IApFSxKXU+6NyzPd6Qkj7GaGPf3jg2wE42ADA+Y0WFbBuVoYQPZjVkzKwmRND9TlsQwUn8W3BbUA1uzEWjnxtqmm3FKczbcC1kMqvrrUQEIOUrDMdPVpjnLqPxY0bfuVCdgeTkdjKDrLpx1tGde8Ey7NZZesXctkg0LSOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155726; c=relaxed/simple;
	bh=PJrURw2ZScHR+KM9E/4Wk02npY3TbSNhd0d/aZXjmKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WXVV3zW4hwU61ho84sqA+H3Ue/4nlp7CtrdtUg4c+TfxuPytyKodR5Az24MsR51+laIEnvJHIoyUl8Hj3u1+V1Ecn0BZC7QFO5ctcSM4RXuJt4XvgVLPsYmG1W5XniAV+P35nmj8SHbK6cnwcNS45ztyuh7lOR/kkJSQYqB4xe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AlQZ8PaI; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AlQZ8PaI"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc44d708055so1939219a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789155717; x=1789760517; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oS2GLdH94EngI/E4RH9yM/bXq5HOqmtDA5Og7xd7+N8=;
        b=AlQZ8PaIA2eokAZkqSfOakzQO9hh8ftHCIoxT4DQKbogYfDB+PR/WokRbE3u9j5pkS
         8aRa+htZwNK32tVcuGFh7ObERnPvYktrYRRhEColye5NJdGN1U9aY8XGgI2+mmebnZQq
         jSPLj8xzTF6cHQZ5IO14jjB91tmUeN2JDZ2uPgksO6zrZ4ea8dk4BBF3EXcaWhxJVPTK
         eUnziBl0jQGp8TnKjVEa7MJ1ZjTkPv1j2rLtBR0nf7DjdsKybV/hnEjH1w2JvLR7hvDv
         ZJoFYCO3uZp9AwUqUD+ldW2nVx3YMna52EiEtxoBBrs4grmf7iGr85bpOEvuFVw04AcL
         OUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155717; x=1789760517;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oS2GLdH94EngI/E4RH9yM/bXq5HOqmtDA5Og7xd7+N8=;
        b=ma5TnM61ndzPBcDb3OfwO3ClGGhKoSqMktwn0Kw8gWwLANLqUwtMtMRdrCU8YB69Cp
         TF40ffv1o8RccpMvUhK34PfPB62T9KXTgfrihWqAFwFGDq7qwb38Ge7A90tPWuy9Tgd8
         n/TpZc/Lu++HP4gR384UF62cg5FE44HJrbheekljEVLqZUpqz42Ioz6uUweM6LpuGhSm
         QMun6o/7mKGept3AfosF6QRU2i690l6gCsbs8jXKH+n2HzJwnDgetcSWeuS4Sg1jz0Mf
         bVAjb/xk20gz/NVQjR8RUHij+Q8xW6CkwLfK/m+kxvyCoJrC66CegHp28lrPq8RNKgAg
         1eeA==
X-Forwarded-Encrypted: i=1; AKwUvBzdtcCjQyEJm69yIlp5v0YC+wmsbSHjVtQmf+A0jdmLinay4/pn4tl3vWu9Xb5Kw59iuLF3eNzdQienGSvK@vger.kernel.org
X-Gm-Message-State: AFuF++k1r/cYB/f6+GAanYQ0MUfCQjOPAUZVQs2F5wF6E9rfjtG46AqF
	3GrWak6gAyzPoMJSGOEcGFjPh/OPZJ1z/HvAV6GT+vIjlsp7//8uvarJ7bAVhUtLFTXvMRFPRyf
	gngKx0w==
X-Received: from dyvn14-n2.prod.google.com ([2002:a05:693c:864e:20b0:313:fb09:e2c0])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:be8f:b0:3d1:7238:33d9
 with SMTP id adf61e73a8af0-3daed559065mr10930453637.3.1789155717279; Fri, 11
 Sep 2026 12:41:57 -0700 (PDT)
Date: Fri, 11 Sep 2026 12:41:42 -0700
In-Reply-To: <20260911194145.1781926-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911194145.1781926-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911194145.1781926-5-surenb@google.com>
Subject: [PATCH v4 4/7] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@kernel.org, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	xueyuan.chen21@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

smap_gather_stats() interprets its start parameter to mean vma->vm_start
when it's set to 0. Eliminate this special interpretation and provide two
separate functions for a partial and complete VMA walk.

Since smap_gather_stats() operates within a single VMA, we can replace
walk_page_vma()/walk_page_range() calls with walk_page_range_vma()
which is simpler and also can be called while holding per-VMA lock.

No functional change intended.

Suggested by: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 52 +++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 0e53eb065a3e..a6026ffd07f1 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1246,20 +1246,26 @@ get_smaps_shmem_walk_ops(struct proc_maps_private *priv)
 	return &smaps_shmem_walk_vma_lock_ops;
 }
 
-/*
- * Gather mem stats from @vma with the indicated beginning
- * address @start, and keep them in @mss.
+/**
+ * smap_gather_stats_range() - Gather mem stats from a portion of the @vma.
+ * @priv: proc maps private state.
+ * @vma: The VMA to gather stats for.
+ * @mss: The accumulated stats.
+ * @start: The address from which to start.
  *
- * Use vm_start of @vma as the beginning address if @start is 0.
+ * This gathers stats for the portion of the VMA starting at the @start
+ * address.
  */
-static void smap_gather_stats(struct proc_maps_private *priv,
-			      struct vm_area_struct *vma,
-			      struct mem_size_stats *mss, unsigned long start)
+static void smap_gather_stats_range(struct proc_maps_private *priv,
+		struct vm_area_struct *vma,
+		struct mem_size_stats *mss,
+		unsigned long start)
 {
 	const struct mm_walk_ops *ops = get_smaps_walk_ops(priv);
+	const bool is_partial = start > vma->vm_start;
 
 	/* Invalid start */
-	if (start >= vma->vm_end)
+	if (start < vma->vm_start || start >= vma->vm_end)
 		return;
 
 	if (vma == get_gate_vma(priv->lock_ctx.mm))
@@ -1278,20 +1284,31 @@ static void smap_gather_stats(struct proc_maps_private *priv,
 		const unsigned long shmem_swapped = shmem_swap_usage(vma);
 		const bool is_cow = vma_is_cow_mapping(vma);
 
-		if (start || (shmem_swapped && is_cow))
+		if (is_partial || (shmem_swapped && is_cow))
 			ops = get_smaps_shmem_walk_ops(priv);
 		else
 			mss->swap += shmem_swapped;
 	}
 
-	if (!start)
-		walk_page_vma(vma, ops, mss);
-	else
-		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
+	walk_page_range_vma(vma, start, vma->vm_end, ops, mss);
 
 	reacquire_rcu(priv);
 }
 
+/**
+ * smap_gather_stats() - Gather mem stats from the entire @vma.
+ * @priv: proc maps private state.
+ * @vma: The VMA to gather stats for.
+ * @mss: The accumulated stats.
+ *
+ * This gathers stats for the whole of the VMA.
+ */
+static void smap_gather_stats(struct proc_maps_private *priv,
+		struct vm_area_struct *vma, struct mem_size_stats *mss)
+{
+	smap_gather_stats_range(priv, vma, mss, vma->vm_start);
+}
+
 #define SEQ_PUT_DEC(str, val) \
 		seq_put_decimal_ull_width(m, str, (val) >> 10, 8)
 
@@ -1342,7 +1359,7 @@ static int show_smap(struct seq_file *m, void *v)
 	struct vm_area_struct *vma = v;
 	struct mem_size_stats mss = {};
 
-	smap_gather_stats(priv, vma, &mss, 0);
+	smap_gather_stats(priv, vma, &mss);
 
 	show_map_vma(m, vma);
 
@@ -1395,7 +1412,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 	vma_start = vma->vm_start;
 	do {
-		smap_gather_stats(priv, vma, &mss, 0);
+		smap_gather_stats(priv, vma, &mss);
 		last_vma_end = vma->vm_end;
 
 		/*
@@ -1454,14 +1471,15 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 			/* Case 1 and 2 above */
 			if (vma->vm_start >= last_vma_end) {
-				smap_gather_stats(priv, vma, &mss, 0);
+				smap_gather_stats(priv, vma, &mss);
 				last_vma_end = vma->vm_end;
 				continue;
 			}
 
 			/* Case 4 above */
 			if (vma->vm_end > last_vma_end) {
-				smap_gather_stats(priv, vma, &mss, last_vma_end);
+				smap_gather_stats_range(priv, vma, &mss,
+							last_vma_end);
 				last_vma_end = vma->vm_end;
 			}
 		}
-- 
2.55.0.1007.g17ff1f9808-goog

