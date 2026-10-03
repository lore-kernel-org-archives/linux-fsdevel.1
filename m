Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C1E56A
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Oct 2026 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790986744; cv=none; b=gDrDbnHe4HMe1W0xaAgTg7qCTm0LDYweN1gDwwNXAAfwCRqQ7lKcvlhonZuVqO/r9Fz0GeA1ZNcTYEPYp7o9YqnYXWe1SzYP1yYOMVk6LX2x63iRWlzUWxQA4VJpDhokIL4QOCzpXy5xYWHT5HHkyX2n0WT6SW5FfgvTIYBjPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790986744; c=relaxed/simple;
	bh=wV35iyht37CGhA9JbTDXvE5fvysi81hNj3LIhrTYjkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpjuMDMoAwswLHOk5lK8PmhTnpQydkVJmCwyVrKHgTrBI3dDRZe1Q24xaTqvy67VtwfNm03Xwu1VPDVVEodIUETdqgTcVa5cPm89SDukW4pekVWBSB5XZA1+Ddv4/dDzgIlbSFsYggfMHnCCcB6reIeRGWNkanGUbMvelX+40kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMpHzAUf; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMpHzAUf"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a29bf27so178759b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 17:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790986742; x=1791591542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=alzFpna7whc/qd+JNdpZ8QaO0qS27ekiyNGSU2+s5WQ=;
        b=dMpHzAUf1pmwvVxedDHW1fuopqc1q3GPBVvjFfNl8sBwY1Cxanq+IjuQTmGRx/GBn/
         npzRhlCcw2IcIcQXGEt/7lh/3ulI8prws98n06w4/41T8AupiQ98CHHGPtyjDGEW+kew
         /T23J7GPX1Pc8YSw8ngmbpstHhELdUclqIcdaLCZ3iNBCclMVyK4YbX5e6meiTuo23sF
         rvZsIeumBqWUVyE82UZNe1H6q/eU553LShQWj8Eznf/kbyFB2RDWJqNZrWmnn9+8jREE
         lwbaaJMmhr3yiPupjyZKAq82KGJTBaS//zL9hzEOroyc8H1tVYIfHc5ee+7EU55hBXhH
         BNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790986742; x=1791591542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=alzFpna7whc/qd+JNdpZ8QaO0qS27ekiyNGSU2+s5WQ=;
        b=JUaFGIGCmAcga3lhv+AtzqLq+vkykpMaKRNNppnyGlj68UK4JT789mE9nalUgNxAkR
         Vzivt+AlUQ46DDhaHFwp1wItPqEtJ5nWwhQCYKgM+/XyipFW2d1pn1edh2B60rbfK8A6
         gCHKYuIk/Ndq5LQDtLfGFoQIFba6RPus42lyyfVF5J+/CbvtOgm2N1wMmo7RMS9LwSCn
         vqYuC+siyN/ACDzKR9JEHylLQACQrfjvp7qkWDCjUnsvBScP2QFq8m52IwUGH/E4KYnc
         2xk8kYz26Nwz/rda/fYGZxCdE0rySC58YZze6OMKSlrOFe4XIqJh2kAeUUcVLmrdUxJz
         1/uw==
X-Forwarded-Encrypted: i=1; AKwUvBwrxQQzhaCNkQs+LUDs5QmgGFCiReBbUHunrFUP604yCcnstwUJepzGItP0leXSWImW3hS/zOhWSUGsahqL@vger.kernel.org
X-Gm-Message-State: AFuF++nBRvwbX351OX6dM2YAERewuxMNhpf0/okjQpkOKSGHMjy0v+l9
	9uNu6qX9uWFYvtBgi2FU3xrKcHol9ha/IQ8p5dDzbhuMT2iG3twHSoOf
X-Gm-Gg: AYBFou0ry7jJN+HMb3viWAO4tI2DnJZn/igAnr7GY159opGaM1/8dz96Exb+z1LvVwa
	NAUwXyKdar86YLguz5scim/8FW1VN0ZCiSBMB/C1AvXout9qCfLQ/O8gEXhNYQpGUizsNm2TmSq
	ZMVvqzzInKD03Oqa2M3G9okm6RjbkEEaMoOeJfPj9UaTeNRbO7DNlIs+t1vDu7vbtIJSNTx+Wnt
	WTx8qNyotNplA/BKxoqE8LsKMYRCQ8sk5ZPmj3YtzkrGfDWpVLQ+yEAxw5NHKAXIZKZawkHA8FW
	jkEnJD7e5GE/631bMXgZeJ4Yiy+oH37ivl2/8I9JK8EV01bY6d58E3OlSJ5gkd4i8+2PUcrUD7E
	F+y87/KcgNZ6e2JXmr8ryQLpIn3z1Hrr3xkpp8m3g97e8w9pKbYR02+2/kCrTrAPGd6jbbeHJRU
	t3P1hvcPbQ1FbGS4yLBVXWdzTHJP87HP9W0kJqNozxmS6Fj3+XVFl9MR0TMa60MmFfrUJL1M2a3
	NDNgt1BBrB0DOalfUqTuzuByvYt4x1OLVNvOtBfQglLpXsg8A==
X-Received: by 2002:a05:6808:3084:b0:4e9:6a47:be26 with SMTP id 5614622812f47-4f5288bdacamr2628101b6e.22.1790986741784;
        Fri, 02 Oct 2026 17:19:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f5243d47absm3330156b6e.8.2026.10.02.17.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 17:19:00 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	willy@infradead.org,
	jack@suse.cz
Cc: mhocko@suse.com,
	muchun.song@linux.dev,
	david@kernel.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	surenb@google.com,
	riel@surriel.com,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/3] mm: memcontrol: factor reclaim logic out of try_charge_memcg()
Date: Fri,  2 Oct 2026 17:15:53 -0700
Message-ID: <20261003001555.3498357-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261003001555.3498357-1-joannelkoong@gmail.com>
References: <20261003001555.3498357-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move reclaim logic in try_charge_memcg() into helper functions so that
the next patch can reuse them.

In memcg_charge_reclaim(), we can call memcg_memory_event() directly
instead of passing in allow_spinning. allow_spinning must always be true
here since memcg_charge_may_reclaim() has already checked that the gfp
mask allows blocking, which implies spinning is also allowed.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index aad0498a7bd6..1d4b603085a5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2696,6 +2696,46 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	css_put(&memcg->css);
 }
 
+static bool memcg_charge_may_reclaim(gfp_t gfp_mask)
+{
+	if (unlikely(task_in_memcg_oom(current)))
+		return false;
+
+	if (!gfpflags_allow_blocking(gfp_mask))
+		return false;
+
+	/*
+	 * OOM victim still needs to charge memory to exit. OOM reaper should
+	 * help but it might fail on mmap_lock contention. If the victim is a
+	 * large thread group then all exiting threads might compete on oom_lock
+	 * just to learn that there is nothing really killable anymore. Bail
+	 * out early and fail the charge to expedite their exit. They are
+	 * considered fully reclaimed by the oom reaper and they shouldn't
+	 * contribute further charges.
+	 */
+	if (tsk_is_oom_victim(current) &&
+	    mm_flags_test(MMF_OOM_SKIP, current->signal->oom_mm))
+		return false;
+
+	return true;
+}
+
+static unsigned long memcg_charge_reclaim(struct mem_cgroup *memcg,
+					  unsigned long nr_pages,
+					  gfp_t gfp_mask,
+					  unsigned int reclaim_options)
+{
+	unsigned long nr_reclaimed, pflags;
+
+	memcg_memory_event(memcg, MEMCG_MAX);
+	psi_memstall_enter(&pflags);
+	nr_reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask,
+						    reclaim_options, NULL);
+	psi_memstall_leave(&pflags);
+
+	return nr_reclaimed;
+}
+
 static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			    unsigned int nr_pages)
 {
@@ -2708,7 +2748,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned int reclaim_options;
 	bool drained = false;
 	bool raised_max_event = false;
-	unsigned long pflags;
 	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
 	int ret = 0;
 
@@ -2747,33 +2786,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (unlikely(current->flags & PF_MEMALLOC))
 		goto force;
 
-	if (unlikely(task_in_memcg_oom(current)))
-		goto nomem;
-
-	if (!gfpflags_allow_blocking(gfp_mask))
-		goto nomem;
-
-	/*
-	 * OOM victim still needs to charge memory to exit. OOM reaper should
-	 * help but it might fail on mmap_lock contention. If the victim is a
-	 * large thread group then all exiting threads might compete on oom_lock
-	 * just to learn that there is nothing really killable anymore. Bail
-	 * out early and fail the charge to expedite their exit. They are
-	 * considered fully reclaimed by the oom reaper and they shouldn't
-	 * contribute further charges.
-	 */
-	if (tsk_is_oom_victim(current) &&
-	    mm_flags_test(MMF_OOM_SKIP, current->signal->oom_mm))
+	if (!memcg_charge_may_reclaim(gfp_mask))
 		goto nomem;
 
-	__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
+	nr_reclaimed = memcg_charge_reclaim(mem_over_limit, nr_pages, gfp_mask,
+					    reclaim_options);
 	raised_max_event = true;
 
-	psi_memstall_enter(&pflags);
-	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options, NULL);
-	psi_memstall_leave(&pflags);
-
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
 		goto retry;
 
-- 
2.52.0

