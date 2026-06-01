Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A31397AFD
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309351; cv=none; b=rr69KMS/0ghSgvrF1VEb2pThkmBOyajgQyTgC4A6vp0Pm8MJHbxxBUrgDP1Mn9bwvR4jg59pnpeoUvoEAlKn+/ieDYhK+W8xI8ECkvyl1QVH/kXDAa9uulHNF6owxsTZuBSf3Cau0YPnocuGQ7DdwWTJ3lPAKrkKNjYjm900EnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309351; c=relaxed/simple;
	bh=+t9Uz8K2fgatcPcurXf1CyVaCMXFRJXBj8HAC1ULp2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhGxq4HO7bPEVlwqqxocDKcbtOTlWRe0+WWaar7BRyi8hGICs8EAQubYvgivqMZ/YgHgK8h4LpmaUDefYjbMruYuAOX1SE4nWfQ55ZIHsAotHaHxblOIpWG78WMB6SuTdy3g7cgRhpFjTmDbnmAOOVObatSJ+obO40xIWRRxAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R7fgqcQV; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R7fgqcQV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780309335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M9bUPwvZD9u+pXGLJ1fAR+BJ7vzqCtQEZJfnSjvNvKg=;
	b=R7fgqcQVY5jCgl30o6B3AMBNCnrDFm3oUwmQn/8UW8Noi8QzcZOUODBKPgofez/OUTwzR2
	aQBDsIkuDJJYBI5h743LyGgd5oSw/LMcXItwktw5q+FUUpCn07CYGIX5sfxSuPAUpqI4rM
	K2H1QMzqyvmkISqjU3CFTP434/VtYF8=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	willy@infradead.org,
	ryan.roberts@arm.com,
	linux-mm@kvack.org
Cc: pfalcato@suse.de,
	r@hev.cc,
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
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v7 0/2] mm: improve large folio readahead for exec memory
Date: Mon,  1 Jun 2026 03:21:16 -0700
Message-ID: <20260601102205.3985788-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hopefully this is the last revision. The only change from the previous
revision is that the logic for deciding THP order was simplified and
the max is now capped to 2M. Thanks Pedro and Jan for the suggestion
and the dicusssion!

The benchmark results on Neoverse V2 (Grace), arm64 with 64K base pages,
512MB executable file on ext4, averaged over 3 runs:

  Phase      | Baseline     | Patched      | Improvement
  -----------|--------------|--------------|------------------
  Cold fault | 83.4 ms      | 41.3 ms      | 50% faster
  Random     | 76.0 ms      | 58.3 ms      | 23% faster

The patches are on top of mm-unstable from 28 May
(8a74e22643189e0ae339afc91110ddb4cab1941b) which include patch [1]
that make mmap_miss accounting symmetric for VM_SEQ_READ which was pointed
out by sashiko in the previous revision.

[1] https://lore.kernel.org/all/20260525145751.2671248-1-usama.arif@linux.dev/ 

v6 -> v7: https://lore.kernel.org/all/20260528165635.2068012-1-usama.arif@linux.dev/
- Simplify logic and just cap the max THP order to 2M (Pedro and Jan)

v5 -> v6: https://lore.kernel.org/all/20260522162422.3856502-1-usama.arif@linux.dev/
- Based on top of patch [1] (sashiko)
- Changes to commit message to make it more accurate for patch 1 and skip
  mmap_miss decrement as well. (sashiko)
- Keep old behaviour if large folio mappings is not enabled (sashiko).
- sashiko pointed to a TOCTOU data race that was pre-existing. My patch
  could make it worse. Dont make it worse by introducing thp_order local
  variable.

v3 -> v5: https://lore.kernel.org/all/20260402181326.3107102-1-usama.arif@linux.dev/
- (Looks like I messed up the versioning here and went directly form
  v3 to v5.)
- Drop patches for elf thp unmapped area alignment and deal with them
  separately. These patches will just bring folios smaller than PMD
  at the same level as PMD. The 2 patches now should be much easier
  to merge.
- Tackle size of THP for exec pages at the same point as PMD instead
  of tackling using exec_folio_order() (Ryan during LSFMM, Thanks!)

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

 mm/filemap.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

-- 
2.52.0

