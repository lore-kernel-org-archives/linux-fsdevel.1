Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.58
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810996;
	b=h2iPRp1sMdlCtVMGuiT8r8ghdyq2OIvRWBPXGfrmmgMPqJnMWtlCTvJQuCDjnAoWlcf1
	 lairG3Kp3Ol30gy/Iq2Vo2g+uy16nAeYpaOuYAkLcJ725qMSIBOOIbdjO6JxWiKHNlv/5
	 acYju7Q+edJf53s3b+dHnKMAhRbma2xYJjg8c2NsD9imMgEidVlUe86T7fJIHFuDno117
	 bgCz4A04GDy7yKcCkUFaitTjMRHWJ9nykINttPzg6KyQH78ibzaVn9LyrXiLUw81Xrblz
	 ETAzGf3Ir6ejIQdA+a/sqYZDZHqI0FuBBe+ZyBi0QC9nmZBxCRZGQpAtBDhsfYMrlPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810996;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Oak5ZxZZQ9yAlOt97hpJszLVfzeQCeMnkPpNvWPUmfA=;
	b=chOHf6QmQXaJDz1BaEsb6yKxaptXnzLZaV8xaKYltVQx90P1u1ypkVk5GN6JkW9aP1Yd
	 /qph1Bg10eYpJdJh2nArDUjOll4Yl+zvow8OKuEpcayBIxMVu+QdbJgVn0BEIcAoIeVtF
	 s0w4flG+5Hmcnk39twXGpcgg4pZbO2hvf/7cjCZOOZkAMorHWDx9Ae4FHVjtLHD11DFFF
	 gytSz19u3WGrw5v2bynYtVFy2Sj7HhGGAUxw9CUoTfjQEJp6KHxrHMmMThEDYSqMhWGVu
	 RFMG8Dp9LXI9S5cirfQKjBGpxoQoRGp3RHfyaVLEqzd7ucQ+y7sJxX4vC8MbKtzbLWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pdWIoeJK;
	arc=none smtp.remote-ip=91.218.175.58
Received: from mta0.migadu.com (out-58.mta0.migadu.com [91.218.175.58])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1860606A334
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 06:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1860606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pdWIoeJK
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nFtAVBIgHW9ME6KU/nYjzXvPWwBZ3oZMIdJ78uXuQ5A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794810994; v=1; x=1795415794;
 b=pdWIoeJKU229pcjctC9fKotKlaTPb+qH15F4+ET7g6wfkje41+ThtZ+yLI8TNiX+dXbIYNQ7
 c9uFgnHvvibN/feGp5N/xIdj2X6W8tJKiJyMNY9FkzXMojh/AON9EATcGehDylgCBNBm4tkvaW2
 Pzdj4ZouRYC9x8ufJj+qkcmM=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id f08f631b902eb383;
	Mon, 16 Nov 2026 06:36:34 +0000
X-Mizu-Trace-ID: f08f631b902eb383
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
Subject: [PATCH v2 0/4] mm: fixes for THP migration, swap-in and device-private smaps
Date: Sun, 15 Nov 2026 22:34:54 -0800
Message-ID: <20261116063624.1382944-1-usama.arif@linux.dev>
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

This series contains fixes for existing THP migration, PTE swap-in
and smaps paths. They were extracted from the work on PMD swap entries
for anonymous THPs [1] and can be merged independently.

1. Avoid a folio reference leak when concurrent MADV_DONTNEED clears
   or splits a migration PMD before the device migration split helper
   acquires the PMD lock.

2. Prevent PTE swap-in batching from mapping a hardware-poisoned page
   of a large anon swap-cache folio.

3. Stop reading the accessed and dirty bits out of a non-present PMD
   in smaps, where they encode the softleaf entry rather than
   accessed/dirty state.

4. Account device-private PMDs using mapcounts in smaps, matching the
   PTE path. Shared mappings get proportional PSS, and exclusive
   mappings are counted as private.

This applies on top of mm-new (0bce4c3c7589).

v1 -> v2: https://lore.kernel.org/r/20261111113904.650722-1-usama.arif@linux.dev/
- Patch 2: use the existing folio_contain_hwpoisoned_page()
  rather than adding a helper that scans every page of the folio
  (Lorenzo, David). Only skip batching for anon folios, since
  falling back for a freshly read folio frees it with the poisoned
  page in it, and the retried fault can get the same block back.
- Collect the Reviewed-by and Acked-by tags from v1.

[1] PMD-level swap entries for anonymous THPs:
https://lore.kernel.org/r/20261002095503.3585565-1-usama.arif@linux.dev/
 
Usama Arif (4):
  mm/migrate_device: avoid leaking folio references during THP splitting
  mm: don't PTE-batch a swap-in of a folio with a hardware-poisoned page
  fs/proc/task_mmu: don't read young/dirty from a non-present PMD in
    smaps
  fs/proc/task_mmu: account device-private PMDs as present in smaps

 fs/proc/task_mmu.c  | 12 ++++++++----
 mm/memory.c         |  5 +++++
 mm/migrate_device.c |  7 +------
 3 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.53.1-Meta

