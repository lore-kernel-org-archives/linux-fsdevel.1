Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DC339708
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467074; cv=none; b=jTu/eLoO6DweJEHlIfb+e225gYiq2//XvmAP4U00asbrHdN6a4YOFonfOUVFZzE5vOzWG138IgJ2h61UKar8qDfucFP0BVJ0ua/6LR0oBILyYR8okUjbzDdCfTNhZcre1YJDFNAkFsSgO3cGxqOvaxzUUj+NLDAYcCAShRgjnI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467074; c=relaxed/simple;
	bh=wLB2H8NN+dWvQK4ClJo3NvKlybYmlW2bqekd+M9gWhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWtMsXp2Qkd9hmSoH+pAeDu2gxAYgjS/NJg/qIAA3EzgAdV+qWSBaPD4AAuGp6PJSqTIA3tOgmSlQ/9gPgJUGk5LUAwxHIffLurcymY2iNaskApwQY13jwJQttTtmcTE7tNUWBN0gYaEGoZZwIV8+6eXSg7zuTVPHjzeXlUeaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lMNCd9XR; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lMNCd9XR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779467070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eUEQkfCpS48vhd7pG3LWfZQvlZUUwQD6sQuoo1yRhAc=;
	b=lMNCd9XRdfAveCRrAZVzZGtFHR+8BsTSPcCiUD2gffC1zj+IJ41AGwd7nC7/37XTySS+s/
	+hRTJ0xdtmfvIQHJ7SI+REBFiBoehAxHB3RSlvfJPSzmzJWDYUr3kl/awo58EEq7/58BmP
	stsTkvN4x6Y+lbbb+JdldPwshzI90OA=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	willy@infradead.org,
	ryan.roberts@arm.com,
	linux-mm@kvack.org
Cc: r@hev.cc,
	jack@suse.cz,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam R. Howlett <liam@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ljs@kernel.org,
	mhocko@suse.com,
	npache@redhat.com,
	pasha.tatashin@soleen.com,
	rmclure@linux.ibm.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	wilts.infradead.org,
	linux-fsdevel@vger.kernel.l@kernel.org,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v5 0/2] mm: improve large folio readahead for exec memory
Date: Fri, 22 May 2026 09:23:46 -0700
Message-ID: <20260522162422.3856502-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Two checks in do_sync_mmap_readahead() limit large-folio readahead:

  1. The mmap_miss heuristic is meant to throttle wasteful speculative
     readahead. It is currently also applied to the VM_EXEC readahead
     path, which is targeted rather than speculative. Once mmap_miss exceeds
     MMAP_LOTSAMISS, exec readahead - including the large-folio
     order requested by exec_folio_order() - is disabled. On
     configurations where the mmap_miss decrement paths are not
     active (see patch 1) the counter only grows, so exec readahead
     is permanently disabled after the first 100 faults.

  2. The force_thp_readahead path is gated only on
     HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER and always drives the
     readahead at HPAGE_PMD_ORDER. Configurations where
     HPAGE_PMD_ORDER exceeds MAX_PAGECACHE_ORDER never reach this
     path, even when the mapping itself supports usefully large
     folios well below the cap.

Both issues are most visible on arm64 with a 64K base page size,
where HPAGE_PMD_ORDER is 13 (512MB) -- above MAX_PAGECACHE_ORDER
(11) -- and where fault_around_pages collapses to 1 disabling
should_fault_around() (one of the two mmap_miss decrement sites).
However the fixes are architecture-agnostic: patch 1 reflects the
nature of VM_EXEC readahead regardless of base page size, and
patch 2 generalises the gate so any mapping advertising a usefully
large maximum folio order can benefit.

I created a benchmark that mmaps a large executable file and calls
RET-stub functions at PAGE_SIZE offsets across it. "Cold" measures
fault + readahead cost. "Random" first faults in all pages with a
sequential sweep (not measured), then measures time for calling random
offsets, isolating iTLB miss cost for scattered execution.

The benchmark results on Neoverse V2 (Grace), arm64 with 64K base pages,
512MB executable file on ext4, averaged over 3 runs:

  Phase      | Baseline     | Patched      | Improvement
  -----------|--------------|--------------|------------------
  Cold fault | 83.4 ms      | 41.3 ms      | 50% faster
  Random     | 76.0 ms      | 58.3 ms      | 23% faster

The patches are based on fb61d7dda82e416a89e1f918a08535ee38976995 (akpm/mm-unstable)
from 22 May.


v3 -> v4: https://lore.kernel.org/all/20260402181326.3107102-1-usama.arif@linux.dev/
- Drop patches for elf thp unmapped area alignment and deal with them
  separately. These patches will just bring folios smaller than PMD
  at the same level as PMD. The 2 patches now should be much easier
  to merge.
- Tackle size of THP for exec pages at the same point as PMD instead
  of tackling using exec_folio_order() (Ryan during LSFMM, Thanks!)
  pr_err("KKK %s %s %d\n", __FILE__, __func__, __LINE__);

v2 -> v3: https://lore.kernel.org/all/20260320140315.979307-1-usama.arif@linux.dev/
- Take into account READ_ONLY_THP_FOR_FS for elf alignment by aligning
  to HPAGE_PMD_SIZE limited to 2M (Rui)
- Reviewed-by tags for patch 1 from Kiryl and Jan
- Remove preferred_exec_order() (Jan)
- Change ra->order to HPAGE_PMD_ORDER if vma_pages(vma) >= HPAGE_PMD_NR
  otherwise use exec_folio_order() with gfp &= ~__GFP_RECLAIM for
  do_sync_mmap_readahead().
- Change exec_folio_order() to return 2M (cont-pte size) for 64K base
  page size for arm64.
- remove bprm->file NULL check (Matthew)
- Change filp to file (Matthew)
- Improve checking of p_vaddr and p_vaddr (Rui and Matthew)

v1 -> v2: https://lore.kernel.org/all/20260310145406.3073394-1-usama.arif@linux.dev/
- disable mmap_miss logic for VM_EXEC (Jan Kara)
- Align in elf only when segment VA and file offset are already aligned (Rui)
- preferred_exec_order() for VM_EXEC sync mmap_readahead which takes into
  account zone high watermarks (as an approximation of memory pressure)
  (David, or atleast my approach to what David suggested in [1] :))
- Extend max alignment to mapping_max_folio_size() instead of
  exec_folio_order()
 
Usama Arif (2):
  mm: bypass mmap_miss heuristic for VM_EXEC readahead
  mm: use mapping_max_folio_order() for force_thp_readahead order

 mm/filemap.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

-- 
2.52.0

