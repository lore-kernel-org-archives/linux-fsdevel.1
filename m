Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451587;
	b=5YV0WEysgD3wOG2smxISyME+MPs1Fd99LASD9j3KpRSHrfsRYlgfwmypFijOEi2bCgHK
	 Tfbiy7mInhnEeiLwYNfNuBfiQM+8PIISfpgZ1ZocQHw+9wMZ60R6hp8BUOsZ23ZdFJn1r
	 LU9AngP13nq+Bf7LoE7v7ZtfZ7hhPNjDd10jKDGGeWuc3P6P3d47/3H4KDLtusw9NWE4W
	 AdjZdycTV11UtXOjLEvSkhXmttRZ+HVN5apEOGJH1oByH0v3ZoTREb+BFT70egB+wAO9O
	 T3W2kQRfPRgow+XEWWikxEequnc0JfEJilMtz5TmkwuC3ZL2lyv7oMObpYw2wAy5wBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451587;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Yxw4jJMrXMbkk4luKeDVY6n7aca2oniv7pBaMvqCZZo=;
	b=p4VEVmbP3tcfVLIPLuwlLzdiyXE0SIYpGZY7/tZQ8ivkxgkeNvjxfNYBtc7QSUpTdUgw
	 snVLbOjtiK0Y+iJUpt230tikMkfk20jI0EJ/PCpP490B+ouFqmMfJvQlsEcypRwu2jusm
	 0t93UN0Gg/6JpCPidX1UQQGOxY+sEqEGJ0QogOKpGkIwRASwgF04V3wKZFtzlr3YXOW4W
	 zfOBZJd+U8kCkPbHA+qB6I6v5tj/VUxzy8HLMLOURfDbmA65nBRuSY3pMDy3ezv8+pRfz
	 O0VCiDcrRinNnHAD6HVw2Yh4l3QZMlGlR5rf2KXDpJhGGeIOeK80ELo3keTyzlOnEqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cCSzGCIE;
	arc=none smtp.remote-ip=91.218.175.174
Received: from mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B3606A31E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 16:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C85B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cCSzGCIE
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6YY+UofGcLZaF/R74H86RLjvpi/i0YIea2eJqVNxlwM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795451584; v=1; x=1796056384;
 b=cCSzGCIE/QjLliANYvylQEWazlGZm9EVizcQ4xXViyPxaB99uhPwmAHJ6wJ1UzoKk7HH3Bth
 FW3/DeedHockO6KXBwAI+A/ofoRvPLKtInKiis4G1wgy87EdbGEK/e97qPyxYpBApfOT0SJN6Yr
 VNyEovSYKItkcZr9WBeuk4NQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 3c27a325c15f0747;
	Mon, 23 Nov 2026 16:33:04 +0000
X-Mizu-Trace-ID: 3c27a325c15f0747
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
Subject: [PATCH v3 0/5] mm: fixes for THP migration, swap-in and device-private smaps
Date: Mon, 23 Nov 2026 08:32:06 -0800
Message-ID: <20261123163301.1568240-1-usama.arif@linux.dev>
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

This series contains four fixes for existing THP migration, PTE swap-in
and smaps paths, plus one cleanup. They were extracted from the work on
PMD swap entries for anonymous THPs [1] and can be merged independently.

1. Avoid a folio reference leak when concurrent MADV_DONTNEED clears
   or splits a migration PMD before the device migration split helper
   acquires the PMD lock.

2. Prevent PTE swap-in batching from mapping a hardware-poisoned page
   of a large anon swap-cache folio.

3. Read the PMD once in smaps_pmd_entry(), the way smaps_pte_entry()
   already does. No functional change.

4. Stop reading the accessed and dirty bits out of a non-present PMD
   in smaps, where they encode the softleaf entry rather than
   accessed/dirty state.

5. Account device-private PMDs using mapcounts in smaps, matching the
   PTE path. Shared mappings get proportional PSS, and exclusive
   mappings are counted as private.

This applies on top of mm-new (87cdbd9bd631).

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
 
Usama Arif (5):
  mm/migrate_device: avoid leaking folio references during THP splitting
  mm: don't PTE-batch a swap-in of a folio with a hardware-poisoned page
  fs/proc/task_mmu: read the PMD once in smaps_pmd_entry()
  fs/proc/task_mmu: don't read young/dirty from a non-present PMD in
    smaps
  fs/proc/task_mmu: account device-private PMDs as present in smaps

 fs/proc/task_mmu.c  | 21 +++++++++++++--------
 mm/memory.c         |  5 +++++
 mm/migrate_device.c |  7 +------
 3 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.53.1-Meta

