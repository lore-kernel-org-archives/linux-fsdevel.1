Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A833C3457
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015472; cv=none; b=qvHCwk4XxfodrWLA41qN+sKISSWoehbeqln65X9katdNh73aM+Ay9pKgpE84gqUOzxcdzLNJiPl6KbC1fmaWeli4PSnL2XfqTxBiv2817NmAgw6AbZg+4cXLNg2g1XeQFc5/GiBvMbF7CHTs/Ci1z28UEkVFbLjy1O1KWE3FWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015472; c=relaxed/simple;
	bh=Azeo8ThLUoc2k7CxXfMdXBVB4mZORuec1Wb+C1RnFZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyjCz1EAx9baHAIXowc3CVqTlGIOfhIpD77Q816VdjPY0sAjizG5HuCHWklh//ecAGs6X29dM/M1pkxQXwvuhQEuoJeX1BlZ/InXAcrdBcY5YJJrAYruwdTtqQmrOXbxsYbrWDSfMjMZ7GhD1NcaIwRPp3sRicwRwqCSs8zMZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ju2NswDZ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ju2NswDZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774015466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9emof/mSVBpZqOkniGYRmgnpg6b0NvSs2UalXz8qvvw=;
	b=ju2NswDZNmjBWaAbqAUKq99Ame3jEQiyp7S3PHbaCVpSky1q0JH1sNT/whD+G/JXIaBNJb
	+Hexql1DGIbnnxSaeS0g6QazyGPdqSFYQnbeDbLItd0uV5MvgrYfJOzQOUhe0lg4oOpp1h
	cNiVUgqf28HsJvc4ZX9wsrGKXv98dok=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	willy@infradead.org,
	ryan.roberts@arm.com,
	linux-mm@kvack.org
Cc: r@hev.cc,
	jack@suse.cz,
	ajd@linux.ibm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam.Howlett@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
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
Subject: [PATCH v2 3/4] elf: align ET_DYN base to max folio size for PTE coalescing
Date: Fri, 20 Mar 2026 06:58:53 -0700
Message-ID: <20260320140315.979307-4-usama.arif@linux.dev>
In-Reply-To: <20260320140315.979307-1-usama.arif@linux.dev>
References: <20260320140315.979307-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For PIE binaries (ET_DYN), the load address is randomized at PAGE_SIZE
granularity via arch_mmap_rnd(). On arm64 with 64K base pages, this
means the binary is 64K-aligned, but contpte mapping requires 2M
(CONT_PTE_SIZE) alignment.

Without proper virtual address alignment, readahead patches that
allocate 2M folios with 2M-aligned file offsets and physical addresses
cannot benefit from contpte mapping, as the contpte fold check in
contpte_set_ptes() requires the virtual address to be CONT_PTE_SIZE-
aligned.

Fix this by extending maximum_alignment() to consider the maximum folio
size supported by the page cache (via mapping_max_folio_size()). For
each PT_LOAD segment, the alignment is bumped to the largest
power-of-2 that fits within the segment size, capped by the max folio
size the filesystem will allocate, if:

  - Both p_vaddr and p_offset are aligned to that size
  - The segment is large enough (p_filesz >= size)

This ensures load_bias is folio-aligned so that file-offset-aligned
folios map to properly aligned virtual addresses, enabling hardware PTE
coalescing (e.g. arm64 contpte) and PMD mappings for large folios.

The segment size check avoids reducing ASLR entropy for small binaries
that cannot benefit from large folio alignment.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 fs/binfmt_elf.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 8e89cc5b28200..042af81766fcd 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -49,6 +49,7 @@
 #include <uapi/linux/rseq.h>
 #include <asm/param.h>
 #include <asm/page.h>
+#include <linux/pagemap.h>
 
 #ifndef ELF_COMPAT
 #define ELF_COMPAT 0
@@ -488,19 +489,51 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
 	return 0;
 }
 
-static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
+static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr,
+				       struct file *filp)
 {
 	unsigned long alignment = 0;
+	unsigned long max_folio_size = PAGE_SIZE;
 	int i;
 
+	if (filp && filp->f_mapping)
+		max_folio_size = mapping_max_folio_size(filp->f_mapping);
+
 	for (i = 0; i < nr; i++) {
 		if (cmds[i].p_type == PT_LOAD) {
 			unsigned long p_align = cmds[i].p_align;
+			unsigned long size;
 
 			/* skip non-power of two alignments as invalid */
 			if (!is_power_of_2(p_align))
 				continue;
 			alignment = max(alignment, p_align);
+
+			/*
+			 * Try to align the binary to the largest folio
+			 * size that the page cache supports, so the
+			 * hardware can coalesce PTEs (e.g. arm64
+			 * contpte) or use PMD mappings for large folios.
+			 *
+			 * Use the largest power-of-2 that fits within
+			 * the segment size, capped by what the page
+			 * cache will allocate. Only align when the
+			 * segment's virtual address and file offset are
+			 * already aligned to the folio size, as
+			 * misalignment would prevent coalescing anyway.
+			 *
+			 * The segment size check avoids reducing ASLR
+			 * entropy for small binaries that cannot
+			 * benefit.
+			 */
+			if (!cmds[i].p_filesz)
+				continue;
+			size = rounddown_pow_of_two(cmds[i].p_filesz);
+			size = min(size, max_folio_size);
+			if (size > PAGE_SIZE &&
+			    IS_ALIGNED(cmds[i].p_vaddr, size) &&
+			    IS_ALIGNED(cmds[i].p_offset, size))
+				alignment = max(alignment, size);
 		}
 	}
 
@@ -1104,7 +1137,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 
 			/* Calculate any requested alignment. */
-			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
+			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum,
+						      bprm->file);
 
 			/**
 			 * DOC: PIE handling
-- 
2.52.0

