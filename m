Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0371250254C
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745609; cv=none; b=lfFW4s51sfJSOYL+wOFMz9RHMJWH3xA5AcuCJGQhcun6jrVZ2lML11N1NNFkwxwHQ+0Sx7aMdFuLyOzZ5HGE4Jt/ZDq+gEXW8SvtN86fUvJ96gvt6/JPjWH4I8q/3HCTufSQygmFh/cf5A6yr1zyFuS5AzVmfq+Xv/dB8vGW1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745609; c=relaxed/simple;
	bh=rN+E4/FWjcs5I7cZl7CmbMADuFHOc37MDHiG5PLssiM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t0KC9QLzv6OUW1UF6+kChVOe7H22nSWw9tU7viJ8RZ0IhMdmNw8nuwTWxLH3+7BZOD2y2wuZHwUAvKrjfCqS4P3mvGaF9qFm/bjVeyVe+OlXl83zg/G/1jSOJG+rvi9RcpAon/stGcU+ETMoQDE6a9i7IoKR/1/9cIrOW34z4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Se+S8G68; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Se+S8G68"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39533bb224cso1804201a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789745607; x=1790350407; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31y1T2wCgzpuS+JdcRd/GVSVXNd4Xu5+lzNmsg6bK28=;
        b=Se+S8G68oVIA79n1uHICdL1hSRiKVACNImzOu2avfAXMGEWLYy5J0+43diH9su/S+K
         6pIM4z2iRrzTo2/DjHvc+9eEymTIw4vITyNPK94Xe1hx1epA81CsBu2M1n24+cuRA3Xf
         /5YAvr/rlj3+ntEgbn5RXkJ6gezl7T2JnvKO37oTb3+tus0pSyvagAAAlSftPUn7adAE
         qo58fXFAcPx78aefdisUCLFYtZTy/Sg6gUMt7Ma3bbHVrtlJeZeT16jCjhv63ST/wf2G
         KcoT8JlLhk1X4OIhaUYnvLsUqYPgimxOWFwCk4V1nTieRqZ7leVeRLMun+nd4baMlqRo
         lYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745607; x=1790350407;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31y1T2wCgzpuS+JdcRd/GVSVXNd4Xu5+lzNmsg6bK28=;
        b=eey+V9g9CH+1DepZtSyI5xROHhPXA/j4q7zcu+2+1t6jImBQxM2zOyoPpLFajWjaiy
         gqBUfPWPrLCeA2ws/sfxYcNJgn0nXTthHZeP73M+bQBIDo006k5sVbvi6wlzsSzvllJm
         k2I85BbXtHrciDpYrfxFotJf557d0Rd4l1tLbaI9aEm3xf6xBJOi5RRykADRAtAwhQJB
         w47Yc4TNqCPVSDHm5M9SESxBXUgBD0k0p3kkMA7T+ZPY4KkndMX3dhXzMxEO778BrP3w
         ki1ZjvMmb2JpvpU6KZiGPn5d+U0veqt58pW9yIzs449YmXTWb7vE51jrsJqGmEpRHy2y
         eebA==
X-Forwarded-Encrypted: i=1; AKwUvBz15/5NQptRtcd1ck7bRDArFQOJzKZ/ZVFhTXWBlNRTRdXg0GMpDwpwfRRstu+Xpb/W+y9mqkqa5KCqJ04A@vger.kernel.org
X-Gm-Message-State: AFuF++lNK7Dc1OzEvW3yj0tt47YJOZIS4ufXQKO9xfOQEYd3XePNuUC9
	dvDGdj+bl54a6X0h0uu3/MYy4j2XWZjyIcG+ZXQaVIUB4beJzc4sUATu5h0RcfvfRbkueyMkDJb
	JbZRArg==
X-Received: from dlan4-n2.prod.google.com ([2002:a05:7022:eb44:20b0:144:d2ba:3139])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecb:b0:39e:31ec:ba55
 with SMTP id 98e67ed59e1d1-39e54d36b09mr7394741a91.7.1789745607146; Fri, 18
 Sep 2026 08:33:27 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:33:14 -0700
In-Reply-To: <20260918153318.758387-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918153318.758387-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918153318.758387-4-surenb@google.com>
Subject: [PATCH v5 3/7] proc/task_mmu: clarify shmem mapping walk conditions
 in smap_gather_stats()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@kernel.org, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	xueyuan.chen21@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

smap_gather_stats() optimizes stats gathering by skipping the walk for
shmem mappings in certain conditions. Update the comment to clarify
these conditions and use vma_is_cow_mapping() for CoW identification
instead of open-coding it.

No functional change intended.

Suggested by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/task_mmu.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a72dc0dc945..f1ce15981253 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1274,23 +1274,18 @@ static void smap_gather_stats(struct proc_maps_private *priv,
 
 	if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
 		/*
-		 * For shared or readonly shmem mappings we know that all
-		 * swapped out pages belong to the shmem object, and we can
-		 * obtain the swap value much more efficiently. For private
-		 * writable mappings, we might have COW pages that are
-		 * not affected by the parent swapped out pages of the shmem
-		 * object, so we have to distinguish them during the page walk.
-		 * Unless we know that the shmem object (or the part mapped by
-		 * our VMA) has no swapped out pages at all.
+		 * CoW mappings might map anon folios that do not belong to
+		 * shmem. Perform a less efficient page table walk in this
+		 * situation, unless we know that the shmem object (or the
+		 * part mapped by our VMA) has no swapped out pages at all.
 		 */
-		unsigned long shmem_swapped = shmem_swap_usage(vma);
+		const unsigned long shmem_swapped = shmem_swap_usage(vma);
+		const bool is_cow = vma_is_cow_mapping(vma);
 
-		if (!start && (!shmem_swapped || (vma->vm_flags & VM_SHARED) ||
-					!(vma->vm_flags & VM_WRITE))) {
-			mss->swap += shmem_swapped;
-		} else {
+		if (start || (shmem_swapped && is_cow))
 			ops = get_smaps_shmem_walk_ops(priv);
-		}
+		else
+			mss->swap += shmem_swapped;
 	}
 
 	if (!start)
-- 
2.55.0.1082.g2b9226bbc0-goog

