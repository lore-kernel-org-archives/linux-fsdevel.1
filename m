Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4303EE1F8
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153646; cv=none; b=b7TEW59LoaPHF2KeHXmufUpRWnQ7GKQaX41IFqnDYMcf9K45GX/mMZY1LzbrUbSrVxAZaOrvhR1/UrUoDPrNysbKZc0hAs5CckkJNC++HMK7uB8sMOczGlrlfPJYHb0hr/5CQ5ey+dmKU+mO7hEfU4p4fSC3g1zGJQEGRIiN0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153646; c=relaxed/simple;
	bh=nRBmxJB/7GRpWb5d2BCFt6u7jlEI7TiQO3zjJNshFpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T86MpNPFmjhmCWP65qZqS9xfWU/g3HrHivUGtaxROQyEKDKSovHKgzcYbAvzwVaJeNR/g1zbpAx5knE8KrZ0Wbl1RRmJpf2ntNUKR/71z+GU04FBr/LpK34GF9So46K53ZBCX8HhPNF8kGQhfq2gHHNJGY/XcDYQ4qFi/H4pal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wZmGPz/E; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wZmGPz/E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775153640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRxmwuc22mXtXN7oNLaBJ1zevopumUc49+eNnxlzmvs=;
	b=wZmGPz/E3h1QCqlt8sX2GdYj4k09LPK0QNGPYb3BVlteyZONPgM/wSFv41PdjD4AUddHEQ
	oOcjHpYxQzCi1PvsfXC2bhs3iCu2FCmJtm+N1VuxurAiQtvgeWZNr8mav9sHwyKO7sfTw7
	jxGAuXnrdImExXI92M71xlZAunfPyhg=
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
	Lorenzo Stoakes <ljs@kernel.org>,
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
	leitao@debian.org,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v3 3/4] elf: align ET_DYN base for PTE coalescing and PMD mapping
Date: Thu,  2 Apr 2026 11:08:24 -0700
Message-ID: <20260402181326.3107102-4-usama.arif@linux.dev>
In-Reply-To: <20260402181326.3107102-1-usama.arif@linux.dev>
References: <20260402181326.3107102-1-usama.arif@linux.dev>
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
allocate large folios with aligned file offsets and physical addresses
cannot benefit from contpte mapping, as the contpte fold check in
contpte_set_ptes() requires the virtual address to be CONT_PTE_SIZE-
aligned.

Fix this by extending maximum_alignment() to consider folio alignment
at two tiers, matching the readahead allocation strategy:

- HPAGE_PMD_SIZE, so large folios can be PMD-mapped on
  architectures where PMD_SIZE is reasonable (e.g. 2M on x86-64
  and arm64 with 4K pages).

- exec_folio_order(), the minimum order for hardware TLB
  coalescing (e.g. arm64 contpte/HPA).

For each PT_LOAD segment, folio_alignment() tries both tiers and
returns the largest power-of-2 alignment that fits within the segment
size, with both p_vaddr and p_offset aligned to that size. This
ensures load_bias is folio-aligned so that file-offset-aligned folios
map to properly aligned virtual addresses, enabling hardware PTE
coalescing and PMD mappings for large folios.

The segment size check in folio_alignment() avoids reducing ASLR
entropy for small binaries that cannot benefit from large folio
alignment.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 fs/binfmt_elf.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 16a56b6b3f6c..f84fae6daf23 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -488,6 +488,54 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
 	return 0;
 }
 
+/*
+ * Return the largest folio alignment for a PT_LOAD segment, so the
+ * hardware can coalesce PTEs (e.g. arm64 contpte) or use PMD mappings
+ * for large folios.
+ *
+ * Try PMD alignment so large folios can be PMD-mapped. Then try
+ * exec_folio_order() alignment for hardware TLB coalescing (e.g.
+ * arm64 contpte/HPA).
+ *
+ * Use the largest power-of-2 that fits within the segment size, capped
+ * by the target folio size.
+ * Only align when the segment's virtual address and file offset are
+ * already aligned to that size, as misalignment would prevent coalescing
+ * anyway.
+ *
+ * The segment size check avoids reducing ASLR entropy for small binaries
+ * that cannot benefit.
+ */
+static unsigned long folio_alignment(struct elf_phdr *cmd)
+{
+	unsigned long alignment = 0;
+	unsigned long seg_size;
+
+	if (!cmd->p_filesz)
+		return 0;
+
+	seg_size = rounddown_pow_of_two(cmd->p_filesz);
+
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		unsigned long size = min(seg_size, HPAGE_PMD_SIZE);
+
+		if (size > PAGE_SIZE &&
+		    IS_ALIGNED(cmd->p_vaddr | cmd->p_offset, size))
+			alignment = size;
+	}
+
+	if (!alignment && exec_folio_order()) {
+		unsigned long size = min(seg_size,
+					PAGE_SIZE << exec_folio_order());
+
+		if (size > PAGE_SIZE &&
+		    IS_ALIGNED(cmd->p_vaddr | cmd->p_offset, size))
+			alignment = size;
+	}
+
+	return alignment;
+}
+
 static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
 {
 	unsigned long alignment = 0;
@@ -501,6 +549,8 @@ static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
 			if (!is_power_of_2(p_align))
 				continue;
 			alignment = max(alignment, p_align);
+			alignment = max(alignment,
+					folio_alignment(&cmds[i]));
 		}
 	}
 
-- 
2.52.0

