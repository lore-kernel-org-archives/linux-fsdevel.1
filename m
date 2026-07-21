Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C93C4B81
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611148; cv=none; b=sP/jElTZagCFFke7lvpEGtOsd/ftu+5/nNBM2BGgoyt7NW2GPivMGWvx2UIzj+RhXzL4XHJkVz+/Ax8mDOgpGk+HhO+hyWoIDIMYNYKmq2U35WTFTigqe8/kH0zW1aSq1knkpWBGGZ4IZ8RqiElyePW1NF3JEQcdgqLPEBLm6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611148; c=relaxed/simple;
	bh=ToZGtb20CKq4evOR51P6gOwjgh3R0XxqXiT/B9R3T5A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hf6BudBpVvZVefnI7QYYeGhf9z8pdDmC3nxUApsRz/z/nHNcP2zIKfTEd6RKDUz1llfWaCBxU9wQEuv8G/80GPV+0I78vewy3q0I1bQ2s8bxa3D97Bdd+m4+66hlLQqQGzZ7aZdgNWz8+zIcdt/8rcXSw+fsrlG3fsty/OXG4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JwZn2HFZ; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwZn2HFZ"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so7648350a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 22:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784611146; x=1785215946; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TV+Y8XsBdBXL7khfi7GOI5Bku1aKo0kWKoXNOlZBFC4=;
        b=JwZn2HFZ0bT51IcTs1NIKcey0KPskl24cail/iYR/qJtHi5Ypy2MMrIhlE4gZ31fTZ
         BcawyzuItUMIXgLHAmO4QoL6ugxZetW4VK/EKuuFK+If0pPWFioLX8cBOS9Yzv+GB9CF
         onB5xZcIcuJRD20JtXClBAaBrUSPh7f1eHolU8a6COksux0yVEKm0MddBFGLhBk4PZT5
         mye02BT9SHXVxbLsCEOegcOXUNg+wTCzi1uGDi9Wi2ZPfgQRkojDo4ZLytJfyWrxYlFH
         BFDuEMoHjgNnDp/s/u77i0r1q1Kzqgf9Ps+MFqvrYBUQTJS5tmhwBKyraI2XPIcAj0KB
         h94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784611146; x=1785215946;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TV+Y8XsBdBXL7khfi7GOI5Bku1aKo0kWKoXNOlZBFC4=;
        b=K7RiikSNXhVcPei6MtG9+eb63nF3/UnAu+m28ZXCplDGHeaHNHW3s5yms4bOatx9WW
         gS2FYmgjqK/bO9dRhBSn43KdKTu7bzx1d16sRpk6iRTG4hR0cuJYN+IYCUJWJVBOsNj+
         PLOgzyHWiz37sAcWyKakFKsuoVBxNUoVfjwkkz2Rujx0U4/DEE+Z2K++s0SYUt423ory
         Gvw/HOIdqKcBPZJmpXADT1Zs7x+0p8kmzBrqOgdh6VpBCZj7alcSAVK21mroobh1Zcs+
         UDm3Q3LBVPsBkCrha27MGkY6lW8J9wL9+FhO3A3i80ybO4bu08SYz39xbjlv3qDzp6jE
         DC2Q==
X-Forwarded-Encrypted: i=1; AHgh+RqCyH9miWZXtrVa+vmwNns8wEzbDDMfcOiz5qVrhyO37U49QGCllPR4dBvq/ouGWmXCCuO1d6F03nL8gqeY@vger.kernel.org
X-Gm-Message-State: AOJu0YyziSltV0jcONvDQOEb9COcBQBFo+B/PZNGSCBS5rh/zM+JmPVk
	N2OhfAzuK4gmyJcIMQea6hdWa1Hw4ba9I4ebnPiRQCphV3c0Ei4TkeXydKa0O0FhFR2RobRSeA9
	Qx2LuUa/xKeeQ4uDvIMh7gnU/iw==
X-Received: from dyvs16.prod.google.com ([2002:a05:693c:42d0:b0:311:5a71:d53c])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9785:b0:3c3:af85:85e7 with SMTP id adf61e73a8af0-3c3af85b991mr13297408637.34.1784611145830;
 Mon, 20 Jul 2026 22:19:05 -0700 (PDT)
Date: Tue, 21 Jul 2026 05:19:02 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721051903.691848-1-kaleshsingh@google.com>
Subject: [PATCH] mm: proc/task_mmu: Use walk_page_range_vma() for smaps
From: kaleshsingh@google.com
To: surenb@google.com, akpm@linux-foundation.org
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kalesh Singh <kaleshsingh@google.com>

Modify smap_gather_stats() to use walk_page_range_vma() instead of
walk_page_range() when walking page tables.

walk_page_range() internally calls find_vma(), which asserts that
mmap_lock is held. This assertion fails when reading /proc/pid/smaps
under per-VMA locks (where mmap_lock is not held).

walk_page_range_vma() walks a range within a single VMA and does not
use find_vma(). It relies on the VMA lock instead (when configured
with PGWALK_VMA_RDLOCK_VERIFY), making it compatible with per-VMA
locks.

Fixes: ea3085dd7a4e ("fs/proc/task_mmu: read proc/pid/{smaps|numa_maps} under per-vma lock")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 fs/proc/task_mmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d32408f7cd5e..5d301bdd05fc 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1369,9 +1369,12 @@ static void smap_gather_stats(struct proc_maps_private *priv,
 			      struct mem_size_stats *mss, unsigned long start)
 {
 	const struct mm_walk_ops *ops = get_smaps_walk_ops(priv);
+	unsigned long end = vma->vm_end;
+
+	start = start ?: vma->vm_start;
 
 	/* Invalid start */
-	if (start >= vma->vm_end)
+	if (start >= end)
 		return;
 
 	if (vma == get_gate_vma(priv->lock_ctx.mm))
@@ -1401,10 +1404,7 @@ static void smap_gather_stats(struct proc_maps_private *priv,
 		}
 	}
 
-	if (!start)
-		walk_page_vma(vma, ops, mss);
-	else
-		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
+	walk_page_range_vma(vma, start, end, ops, mss);
 
 	reacquire_rcu(priv);
 }

base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
-- 
2.55.0.229.g6434b31f56-goog

