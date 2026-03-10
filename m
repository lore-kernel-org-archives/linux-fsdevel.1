Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE229B78D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154497; cv=none; b=AWJSR94q45ok63+5K8rl9hQeoK+Ns082jzt6EEg6DOuMgmQrJ/rKPzwe9/WiMJ7+k8hQf552POpry8QnrhZgjy9opJV1PpRJxWQ3WCgiP1fBXINpUQRr0/akOVjrSPLdh5RKvBYwqXPCB9nb2iuBa3Kv4NfCflVFz75x7zUhGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154497; c=relaxed/simple;
	bh=Ahdjpp5tmOKnolDDyNj+hSgqgzjJXUblKpC03uLryBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujs8ANb1ayKcwXQEVboaiNuD1xU58HrdqbaWrGGcZIXKdjN2kk324k4uPxdsn40yqvPIRiRGTYET38/BN1OI6sWne4dYF+do9u079QDVabeaGa6U0pYw09w+fRbW1ia98O3+ky1sK/dsPt/CE1SX08XlYFPwCs4sZ2jVKkZLdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gD0zzF1Z; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gD0zzF1Z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773154493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pwf6Nc7CaGHddB3FSw2OYM6VouGq/Ldl0n4v0DGTvQM=;
	b=gD0zzF1ZzkpibyiRY+w+AjVdGRw9wPyUFI+y5FS68pAmCO1c1M9m41DEaxy2QyJUSTMhzg
	P5XvbFOUZoVyZubGSqW0JOoPKegDPZYBJmxRz5fKJnH3JtcIuHIQQfgUEkfvTqhC9I4zI7
	8e/PuxvBlI2swPY3tUz0PqrlB4hUlJQ=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	ryan.roberts@arm.com,
	david@kernel.org
Cc: ajd@linux.ibm.com,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	jack@suse.cz,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam.Howlett@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	npache@redhat.com,
	rmclure@linux.ibm.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	will@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 3/4] elf: align ET_DYN base to exec folio order for contpte mapping
Date: Tue, 10 Mar 2026 07:51:16 -0700
Message-ID: <20260310145406.3073394-4-usama.arif@linux.dev>
In-Reply-To: <20260310145406.3073394-1-usama.arif@linux.dev>
References: <20260310145406.3073394-1-usama.arif@linux.dev>
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

Without proper virtual address alignment, the readahead patches that
allocate 2M folios with 2M-aligned file offsets and physical addresses
cannot benefit from contpte mapping. The contpte fold check in
contpte_set_ptes() requires the virtual address to be CONT_PTE_SIZE-
aligned, and since the misalignment from vma->vm_start is constant
across all folios in the VMA, no folio gets the contiguous PTE bit
set, resulting in zero iTLB coalescing benefit.

Fix this by bumping the ELF alignment to PAGE_SIZE << exec_folio_order()
when the arch defines a non-zero exec_folio_order(). This ensures
load_bias is aligned to the folio size, so that file-offset-aligned
folios map to properly aligned virtual addresses.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 fs/binfmt_elf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 8e89cc5b28200..2d2b3e9fd474f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -49,6 +49,7 @@
 #include <uapi/linux/rseq.h>
 #include <asm/param.h>
 #include <asm/page.h>
+#include <linux/pgtable.h>
 
 #ifndef ELF_COMPAT
 #define ELF_COMPAT 0
@@ -1106,6 +1107,20 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			/* Calculate any requested alignment. */
 			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
 
+			/*
+			 * If the arch requested large folios for exec
+			 * memory via exec_folio_order(), ensure the
+			 * binary is mapped with sufficient alignment so
+			 * that virtual addresses of exec pages are
+			 * aligned to the folio boundary. Without this,
+			 * the hardware cannot coalesce PTEs (e.g. arm64
+			 * contpte) even though the physical memory and
+			 * file offset are correctly aligned.
+			 */
+			if (exec_folio_order())
+				alignment = max(alignment,
+					(unsigned long)PAGE_SIZE << exec_folio_order());
+
 			/**
 			 * DOC: PIE handling
 			 *
-- 
2.47.3

