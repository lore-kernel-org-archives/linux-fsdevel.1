Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E7420E89
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944500; cv=none; b=ma3pHfg1gSN2Bb+x/uqQeXvFHB5FPkIaBf7jkbjDpDtPKv6Cv86uKZMFzu0oDuZzZok8f/TVVbf0lUVK6KoAbqlzI87++dw5fHG4xBjLQMN4rQ8W7NUrAFIdSAnXkKyenTFn4bXcKZxpACVJuI01zIbySranQsZJaxt84lpCLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944500; c=relaxed/simple;
	bh=Uycl8RnRr9FlkGcP8YpQ97rk1SSGy2RfCcaOvE3xqR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQN4oSXIrC/DGTtu1ihQaGeAMALPv+0c3a/wF44o0giMq5qOSpwc1EwZkJQIXYRJ1gV+2oeVVKIjO3tBzg5MspLHTBjDQmMrun8XfMQCqAVYEZDfJ1nvMFx51vmmUPhVgHcybC4FF43LaQkmCJwwPiuoQ0LK3F82XlDXX/Uo9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OZIHNViw; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OZIHNViw"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8eeb4508f29so8164646d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782944498; x=1783549298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JWJ0GrNM4nyfXD1ju+x4+oy32oP6/tEENp87ryjDBA=;
        b=OZIHNViwE3QARy834+R/WmqHMVaPOZi1J+DeixoJDoBhDX1efvgsGyXc8NxtNCAh/q
         ivB1zJvQyzR+spIjfj1LDuBqwcbdDAmn8+vUer1Zi9B3US7vs5QjKrUyPm9BR5GOia/T
         o7Ve/ZMTAKLmt9AR1LX+KAj0mbErBMj1CX652W8KH3Wmqo+KdsFQFWrCQYOfZJm8JH9y
         eNAt3N76P74+klUdzDKUs2JZJufKWC2CcUhdG1+7BUTPMOGmBGcE2BWka2zu81qFhUKq
         H4xWB3X1Xa142izyxRqMCbZYb4dVn6R5NFOnHjtRqhFb2klklp40SFleuPC85jwhLnvv
         TJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944498; x=1783549298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6JWJ0GrNM4nyfXD1ju+x4+oy32oP6/tEENp87ryjDBA=;
        b=Qkt+p86lfGVfJ7NampP1XWL0IWq+OmXQZOjvcrb7ubFBaf+j4zbKvtADhk+VZWNVud
         1cQ6lSGIO+spuqWOqNE9GW5eHBd9huHR1vcAnQ4Sf/8WTeclsM/+yTqeeJkbReOslSy/
         5psWVaZGfivz4K3fMGivkG9VsO4D6sCGGUFiAATozbHd7+06y91wSd6GrQYFBlmMApNm
         e8e8KJS4M8IreqBJYEoU0ZozjEfwKaooL5nXcq3FSHC/Icd18hAZTLE3SuMevvq+XKIv
         +nqXwEaPiqUQrU4paB3DQ1o1t/dHc0xNy7V7A/g2RA+dkbhIJupGwv+vri7nFZ+wqQyj
         sj2Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro22rNwv1QAqIpK5+oQX2a64kruQj/JZK5BUDxwQVZdQlcD1CqlMXaQ8DoRhCVPympkwsoHNYVDIyTN7dpZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFhAG8DZ2nMZVPwq3+fYm27D7gaPxqYd+pehytyQcFFtfamyz
	LrRokwspl7Ig+z/54UYjbJMQDFeFPCS5xy1hjLy6CoCbFXW2obgN4MgnuqYn15W8eg4=
X-Gm-Gg: AfdE7ck88vaKYPkMZ97Cd3zvioHsY4xf4w1eBP9ykR6MJWDgw7yAPbaDYfwSzb8eBY/
	oQmhkSKtnY0cafedKIMHCmGoeMw3HZeULXmQSfdf5wrNyQIziVqyrIGt1mYnhS4hWgdSilejpv8
	+PzlBZXE0TcwLy4xisW7M3n3Pu1q3vH/ITVk62ml8nb5S3Qpynf9MFn6LIxvADX4o01aqePTMc2
	2EgE+xjyWIWSv7qfzPA/SDuP6CWRJDxkm6gs0B98pZD0TzYUDVWFaDY4Etp8llzuzYDrH18WBEe
	LuTFrwwjVUdksrmeTIw3xmJjq3eAo0afAxB29kp20Nq3aDOR0p/uJ9FMNgVpod5Ov4Ov+FW+UDf
	Mni0lx+NKwHmHjwQ07Tmu+sjm0ejNKbx/ULL2VFEgkH8ZPFTxYanPgWq0uHk8B9J1+In5qIa2O/
	+RG6WL8gTsJOSV9KJmffePIUStF9PWWRt6u9PlNTPDDrHJHkhlq0EsiW5YHmY4GZvMJRtzoHwVd
	A==
X-Received: by 2002:a05:6214:2f89:b0:8ef:e0d0:9fae with SMTP id 6a1803df08f44-8f3c6bbacb3mr51714426d6.14.1782944498337;
        Wed, 01 Jul 2026 15:21:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d137sm9709076d6.9.2026.07.01.15.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:21:37 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 2/2] mm/mempolicy: skip task mempolicy for unmovable unaccounted kernel allocations
Date: Wed,  1 Jul 2026 18:21:12 -0400
Message-ID: <20260701222112.2820098-3-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701222112.2820098-1-gourry@gourry.net>
References: <20260701222112.2820098-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bare calls to alloc_pages / folio_alloc / vmalloc / slab-refill cause
vma-less allocations which fall back to the current task's mempolicy
for a placement hint.  This has the effect of directing incidental,
global, task-unrelated allocations to follow the task's mempolicy.

On uniform multi-socket systems, this is not implicitly harmful.
On tiered memory systems, these incidental allocations can land
on slower memory tiers and actively cause performance regressions.

For example, the code in lib/stackdepot.c allocates a global
resource that sticks around for the life of the system:

  stack_depot_save_flags()
      page = alloc_pages(gfp_nested_mask(alloc_flags));

In this example:
  1) the ownership is global (stackdepot, no association to the task)
  2) The lifetime is forever (the pool is more or less permanent)
  3) Whichever task causes the FIRST allocation to occur dictates
     placement for future users - permanently.
  4) It's unaccounted and unmovable.

While this doesn't prevent fallback allocations occurring and landing
in the same class of memory the same way, a per-task interleave policy
shouldn't dictate placement for such allocations.

Make a new helper, alloc_task_policy(), to identify three classes of
allocations we explicitly do not want to follow the task policy.

 1) in_interrupt() - interrupt allocations are not related to the task
 2) __GFP_THISNODE - caller explicit placement
 3) unmovable, unaccounted kernel allocations
    !(__GFP_MOVABLE | __GFP_ACCOUNT)

The third filter keeps incidental global kernel allocations from being
spread throughout the system when a task has set a mempolicy. The other
two are existing filters consolidated by the helper.

Allowing movable allocations to follow task policy retains existing
non-harmful placement behavior, and cpuset constraints are still
enforced by ALLOC_CPUSET.  Pagecache placement is made explicit by
the preceding patch.

Everything else (unmovable and unaccounted) falls back to node-local.

User-space folios are unaffected: they fall through folio_alloc_mpol().

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/linux-mm/akU2_Mt_JDCxmnc7@cmpxchg.org/
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fc9051e9558b..6c00dc32c8b4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2737,16 +2737,35 @@ struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct
 }
 EXPORT_SYMBOL(vma_alloc_folio_noprof);
 
-struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned order)
+/*
+ * Bare alloc_pages() calls only have task policy as a placement hint.
+ * There are 3 scenarios where we don't want to use the task policy:
+ *  1) interrupt context - these allocations are not related to the task
+ *  2) __GFP_THISNODE - the caller asked for explicit placement
+ *  3) Unmovable (!__GFP_MOVABLE), unaccounted (!__GFP_ACCOUNT) kernel memory
+ *
+ * The third filter keeps incidental global kernel allocations from being
+ * spread throughout the system when a task has set an interleave policy.
+ * This can include cached global metadata for drivers and internal
+ * services that outlives the life of the task.
+ *
+ * Allowing movable allocations to follow task policy retains existing
+ * non-harmful behavior, and cpuset constraints are still respected.
+ *
+ * No reference counting needed for current->mempolicy nor default_policy
+ */
+static struct mempolicy *alloc_task_policy(gfp_t gfp)
 {
-	struct mempolicy *pol = &default_policy;
+	if (in_interrupt() || (gfp & __GFP_THISNODE))
+		return &default_policy;
+	if (!(gfp & (__GFP_MOVABLE | __GFP_ACCOUNT)))
+		return &default_policy;
+	return get_task_policy(current);
+}
 
-	/*
-	 * No reference counting needed for current->mempolicy
-	 * nor system default_policy
-	 */
-	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
-		pol = get_task_policy(current);
+struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned order)
+{
+	struct mempolicy *pol = alloc_task_policy(gfp);
 
 	return alloc_pages_mpol(gfp, order, pol, NO_INTERLEAVE_INDEX,
 				       numa_node_id());
@@ -2964,13 +2983,10 @@ static unsigned long alloc_pages_bulk_preferred_many(gfp_t gfp, int nid,
 unsigned long alloc_pages_bulk_mempolicy_noprof(gfp_t gfp,
 		unsigned long nr_pages, struct page **page_array)
 {
-	struct mempolicy *pol = &default_policy;
+	struct mempolicy *pol = alloc_task_policy(gfp);
 	nodemask_t *nodemask;
 	int nid;
 
-	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
-		pol = get_task_policy(current);
-
 	if (pol->mode == MPOL_INTERLEAVE)
 		return alloc_pages_bulk_interleave(gfp, pol,
 							 nr_pages, page_array);
-- 
2.53.0-Meta

