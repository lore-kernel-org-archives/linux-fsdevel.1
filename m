Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607539;
	b=hwKbeSxsE0IgjqQT1obIUx+zaT7ZUT6yVMwsWzkHYno/urfmZ1hQhqgq3DPR8k0IpKOQ
	 CWTAjruSr2PR3y3wVc6Av/qpuBBZTBqgjTkL+S4XgcG4zwk5kOfJjIYT3wxeevsDwDog0
	 B/u9zwlkRrYDlerAGBbfzQZxvyyFsya3XgeODKklf5BPBGIievxWgvBSzPxr3E/LD0UE1
	 zgWzNSynCBUciABXNdmkuhfaPJcWNMF7dXJaxxV5MJJMd3js4gfgoKt96ua02JEHcnvt3
	 b6ErwRTC12a7GzW2HDCxCo9CQ/EsmNEucqZB8sQpLQdMPjSC+d/r+RfSpZsEHHX1UTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607539;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=S1YMVyf7QK6He1+IyuB7Pm33iIetDfvYmZuuN7H0dqQ=;
	b=HT2HPycC2E7IvI9b/bdt3Q+MUxmbbMIAuCnBHbVtvNqb8y4tQBfB7dnpjZZHebAp0+8B
	 B/NxzlDQQtCmggO3OmIf8t5QWdcgusXB5w1J73A+YBwZjqGtebJAopbXrSvTvPGeeK3p3
	 WP/2PF6zaISBHZf3BO1bADb4cHtZ7TvZP4XgoLXeiLujwZ7vGBonqj29n5c/Gm1uUUGbJ
	 OGDAp2cKvmLZSuaJUo760phTh6ajfIyblpgQvCfEjDDsPZ7TFiP2zl1Je8CGsluzYj4yJ
	 jli6uj8PEwJf7XgQYAfhLl9a2pQYpRC9dSKy+uz40f25FM5IiHtio6RgTUMAPBrFMVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tPgSojfu;
	arc=none smtp.remote-ip=91.218.175.47
Received: from mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BDA606A333
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 11:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7BDA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tPgSojfu
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z2CkT54kqOKU8KO1wfVbTT+XpYAEM4nHWLOF/HfPCiY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795607536; v=1; x=1796212336;
 b=tPgSojfuEuVoGk0j32eGGhBR9EsilOWfRlLfRAqEWE9srgW5jCUcvIgCk2O8IompGsr4F252
 UIDEJMjPLzHQ947AuWj19VyWRAKZOZA0SUi4nyBvAbNQppYVHA5EwGoL0n8X7eynLfdvDmZyNc+
 ehEZ2O/RvYyJjZKUgGoJxAwQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 3cd877cfbc249f6d;
	Wed, 25 Nov 2026 11:52:16 +0000
X-Mizu-Trace-ID: 3cd877cfbc249f6d
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	byungchul@sk.com,
	david@kernel.org,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	liam@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v4 0/3] fs/proc/task_mmu: smaps fixes for non-present and device-private PMDs
Date: Wed, 25 Nov 2026 03:49:56 -0800
Message-ID: <20261125115014.4014507-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains two fixes for the smaps PMD path, plus the cleanup
they build on. They were extracted from the work on PMD swap entries for
anonymous THPs [1] and can be merged independently.

1. Read the PMD once in smaps_pmd_entry(), the way smaps_pte_entry()
   already does. No functional change.

2. Stop reading the accessed and dirty bits out of a non-present PMD
   in smaps, where they encode the softleaf entry rather than
   accessed/dirty state.

3. Account device-private PMDs using mapcounts in smaps, matching the
   PTE path. Shared mappings get proportional PSS, and exclusive
   mappings are counted as private.

This applies on top of mm-new (5bd93e4b0b35).

v3 -> v4: https://lore.kernel.org/r/20261123163301.1568240-1-usama.arif@linux.dev/
- Patches 1 and 2 of v3 have been picked up in mm/core.git
  (migrate-7.5.misc and core-7.5.misc), so this revision only carries
  the three smaps patches, renumbered 1-3 (David). The patch numbers in
  the older entries below are the ones from the five patch series.
- Patch 1: make pmdval const (Lorenzo).
- Collect the Reviewed-by tags from v3.

v2 -> v3: https://lore.kernel.org/r/20261116063624.1382944-1-usama.arif@linux.dev/
- Patch 2: move the hwpoison check to the top of the batching block, so
  the two bit tests run before the page table scan rather than after
  it (David, Zi Yan, Kiryl).
- Patch 3 is new: read the PMD once with pmdp_get(), so patch 4 only
  has to move pmd_young() and pmd_dirty() under the present branch
  (Kiryl). Patch 4 is unchanged in effect and keeps its v2 tags.
- Collect the Reviewed-by tags from v2.

v1 -> v2: https://lore.kernel.org/r/20261111113904.650722-1-usama.arif@linux.dev/
- Patch 2: use the existing folio_contain_hwpoisoned_page()
  rather than adding a helper that scans every page of the folio
  (Lorenzo, David). Only skip batching for anon folios, since
  falling back for a freshly read folio frees it with the poisoned
  page in it, and the retried fault can get the same block back.
- Collect the Reviewed-by and Acked-by tags from v1.

[1] PMD-level swap entries for anonymous THPs:
https://lore.kernel.org/r/20261002095503.3585565-1-usama.arif@linux.dev/
 
Usama Arif (3):
  fs/proc/task_mmu: read the PMD once in smaps_pmd_entry()
  fs/proc/task_mmu: don't read young/dirty from a non-present PMD in
    smaps
  fs/proc/task_mmu: account device-private PMDs as present in smaps

 fs/proc/task_mmu.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.53.1-Meta

