Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD73A9DA3
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406565; cv=none; b=dLUba/A8J2gMSlojiiVlGGP/sIepiCoK23Dl42NaRYRVkQRjqsmc/hKLtoxPRrbF+kxbc1C4tSOMhFibW5F9iEU8gtVEW4fncDtDCiV9Zyu9Mejx7bGXtePO6rNHydwe/ZyyBYmT3MXcK8NeEZBGEzElyTKEohxoqtnrSG3c7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406565; c=relaxed/simple;
	bh=6v+ghItK7ul3adjRGUNabgeElM/A5NB7kggjLSChwns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qIiRstbWd54Q8gbpS0r8wPgG/eiHTk2/vAgQf3cGUufFuP6B11Z7urt7q5tsfxVjJzPxHJrV5MgBweYvfrNXiEhUDbpwjVaUKd3QD0LCm7Tq3s65VPu0KS/3MgpJM9DcCu0C+JzDiXdojHOzzttBrKQGe7cl2xY8ElIOS3xs/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODB2sXvq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODB2sXvq"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38108fb9d83so2682626a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 23:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783406564; x=1784011364; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mr0Imss8jl6Lql5T0sFpczm9SFtWuez0AZQ8VASrGcw=;
        b=ODB2sXvq/FKHS7Nfs7qksDH1zvy1bzy6TSBzHUifsqtU4mGJEwLRNDmt+Ujgw/e0Gq
         UZtY87RLnNY5runMMeMY1sOq3ulvg2cFMpog2nj4ORm8pBnmCmHpL9pjXSRYQpdSHppB
         hWPYzU8g7eVskRlmGBcQWReHK992tOGAiMCGvHRfSytG/zMgTPLMgEbtVJWxlackULfc
         WJ7585bYzfsT7Eix6Sik1CK7PpmsVnqAHh/Puwm5MQvpS8eKB2jLw57xguGIV4ri4pin
         M0JFh45Lhyl/Kye09fPCHcDNmhEi4Ykr5SrM3rs5FlBNAsIY5jOKvDVjeF/IYQnKok7U
         YKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783406564; x=1784011364;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mr0Imss8jl6Lql5T0sFpczm9SFtWuez0AZQ8VASrGcw=;
        b=lvkOn9idHPl6sNmftZtHF+7wRp37gQVmgAau+aLbFjI12FdrQmDYxylhgx5E1glK3/
         T4WehJPXlI9RP5Uy1Ufp+BGFYv4Am3aUgnHzR+5vKF1jgBoBHLd7wDvZpR1E3Hz0Ryds
         97pHWsKintd7eAhwjQ9P2Urx9rbykyn2JUOufX1RDznjscnNylUTUEbV/aAMwHjMdL04
         xr6fD00af2Aqpv5dKfeCCHnR0Yqls4N4UV+vmXQ32iXG70L/Q2vk/fMJpOXMlu6QXFYy
         bgzi1gtVryYaXZPrjvvmsAB6kEKdsh8ssvAqcAAqbjuRd9+hY+x0+F/YEkB/S6eq0FBQ
         u5wA==
X-Forwarded-Encrypted: i=1; AHgh+RrpOubRUJRT3YkCPxfO6Uq1mEb0d+2niK/hrTNeFwDtmEdyzx1qwCb7hOQQWlcVayvAndlCDgVdj20iv2cR@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6XUadZairlJpI0AxDwEsNNtAorwgFl8PodS2NTSCc4Fb2x1k
	CdpDc2RVs3OOUDoMCP3LHQ1HbDzI+5R/1dvoBeewSwpKyKf7vj6LNSOkGTssPuV4Ek+hZFv0LHU
	SmfqLQJvJCooTuv0Q8WQAAPszYg==
X-Received: from pjui23.prod.google.com ([2002:a17:90a:cf97:b0:382:3fe5:7a9b])
 (user=souravpanda job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:570d:b0:37f:eaf9:4682 with SMTP id 98e67ed59e1d1-3875586394cmr3986337a91.14.1783406563403;
 Mon, 06 Jul 2026 23:42:43 -0700 (PDT)
Date: Tue,  7 Jul 2026 06:42:34 +0000
In-Reply-To: <20260707064235.1386552-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707064235.1386552-1-souravpanda@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260707064235.1386552-6-souravpanda@google.com>
Subject: [PATCH 5/6] Documentation/admin-guide/mm/hugetlbpage.rst: document
 cache interfaces
From: Sourav Panda <souravpanda@google.com>
To: muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org
Cc: david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, mst@redhat.com, 
	mhklinux@outlook.com, souravpanda@google.com, fvdl@google.com, 
	gthelen@google.com, mike.kravetz@oracle.com, pasha.tatashin@soleen.com, 
	rientjes@google.com, riel@surriel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document the newly introduced sysfs interfaces for the HugeTLB
dynamic cache. This includes max_cached_huge_pages,
nr_cached_hugepages and their NUMA/mempolicy variants.

Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst | 34 ++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 67a941903fd2..6b96779e2584 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -264,6 +264,10 @@ pages may exist::
 	free_hugepages
 	resv_hugepages
 	surplus_hugepages
+	max_cached_huge_pages
+	max_cached_huge_pages_mempolicy
+	nr_cached_hugepages
+	nr_cached_hugepages_mempolicy
 
 The demote interfaces provide the ability to split a huge page into
 smaller huge pages.  For example, the x86 architecture supports both
@@ -286,8 +290,28 @@ demote
         actually demoted, compare the value of nr_hugepages before and after
         writing to the demote interface.  demote is a write only interface.
 
-The interfaces which are the same as in ``/proc`` (all except demote and
-demote_size) function as described above for the default huge page-sized case.
+max_cached_huge_pages
+        is the maximum number of cached hugepages for this size (global).
+        Surplus hugepages freed by applications are recycled into this cache
+        instead of being released back to the buddy allocator immediately.
+        Subsequent allocations for surplus pages will prefer this cache.
+        A user with root privileges can write to this file to set the limit.
+        This interface accepts absolute values as well as relative adjustments
+        using +1 or -1.
+
+max_cached_huge_pages_mempolicy
+        is the same as max_cached_huge_pages, but the nodes from which pages
+        are cached are controlled by the memory policy of the task.
+
+nr_cached_hugepages
+        reports the current number of cached hugepages. Writing to this file
+        allows manual expansion or contraction of the cache.
+        A user with root privileges can write to this file.
+        This interface accepts absolute values as well as relative adjustments
+        using +1 or -1.
+
+nr_cached_hugepages_mempolicy
+        is the same as nr_cached_hugepages, but obeys the memory policy.
+
+The interfaces which are the same as in ``/proc`` (all except demote,
+demote_size, and the cache interfaces) function as described above
+for the default huge page-sized case.
 
 .. _mem_policy_and_hp_alloc:
 
@@ -372,6 +396,8 @@ contains the following attribute files::
 	nr_hugepages
 	free_hugepages
 	surplus_hugepages
+	nr_cached_hugepages
+	max_cached_huge_pages
 
 The free\_' and surplus\_' attribute files are read-only.  They return the number
 of free and surplus [overcommitted] huge pages, respectively, on the parent
@@ -382,6 +408,10 @@ specified node.  When this attribute is written, the number of persistent huge
 pages on the parent node will be adjusted to the specified value, if sufficient
 resources exist, regardless of the task's mempolicy or cpuset constraints.
 
+The ``nr_cached_hugepages`` and ``max_cached_huge_pages`` attributes return the
+number of cached huge pages and the max limit on the specified node, respectively.
+Writing to these attributes adjusts the cache on the parent node.
+
 Note that the number of overcommit and reserve pages remain global quantities,
 as we don't know until fault time, when the faulting task's mempolicy is
 applied, from which node the huge page allocation will be attempted.
-- 
2.55.0.rc0.799.gd6f94ed593-goog

