Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A922DF3FD
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154483; cv=none; b=fXFKWFcYKxCT9QAX5axj5uLXxUWl8CI150pwyvnf1rPXZK8Hrf4vASSHwO9Xy+aOIfEvVLEr2kuXpz5KP2eKtQ+MEzNDrCUaEs8pIKMu5BsQ9In7WQi27FpLs1KbF//t3KmhCsqzazf9AkOoDqynGznnwotzBime7wWeub3NEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154483; c=relaxed/simple;
	bh=UNdhYhcWjV3ZZ8KNfNO1NqUySGXdFU0kugLx3JPYp10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQfx7YDf51Si2VvFDUKRcGNVwrdDGqdt5YoM2uArUAn7IJuXW9y5K5dSWqRH7q1L0KLuG5A2xyzg0R7Sg5ZSQIuagkqUMjPufwK2gv26F92taFDVTBvMHAgrOE2RKRBcDLgbbOPcTIyZho0HmO/wMGqjKyc8/JEOaKD9kdf3c6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=taHmAdo3; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="taHmAdo3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773154479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGWvFNNHbAVQyTUs3YvCDY0GyMiml7VfROhcweab0g8=;
	b=taHmAdo34oCwjQFIaRdmRojINXQm081BWLVpiG89JRPghIcpldJ2rwOWU0KURRrhy5yjpf
	19sWjb7mkMYRCePOGCQXpG9Wc5IKYu1fi/V6HuLIH/qnuv0qdwjurQ0tE2yqYewmgWxhBS
	i69FLwkpsJPKnJP2wwNrpkeBXTBIoAo=
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
Subject: [PATCH 1/4] arm64: request contpte-sized folios for exec memory
Date: Tue, 10 Mar 2026 07:51:14 -0700
Message-ID: <20260310145406.3073394-2-usama.arif@linux.dev>
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

exec_folio_order() was introduced [1] to request readahead of executable
file-backed pages at an arch-preferred folio order, so that the hardware
can coalesce contiguous PTEs into fewer iTLB entries (contpte).

The current implementation uses ilog2(SZ_64K >> PAGE_SHIFT), which
requests 64K folios. This is optimal for 4K base pages (where CONT_PTES
= 16, contpte size = 64K), but suboptimal for 16K and 64K base pages:

Page size | Before (order) | After (order) | contpte
----------|----------------|---------------|--------
4K        | 4 (64K)        | 4 (64K)       | Yes (unchanged)
16K       | 2 (64K)        | 7 (2M)        | Yes (new)
64K       | 0 (64K)        | 5 (2M)        | Yes (new)

For 16K pages, CONT_PTES = 128 and the contpte size is 2M (order 7).
For 64K pages, CONT_PTES = 32 and the contpte size is 2M (order 5).

Use ilog2(CONT_PTES) instead, which directly evaluates to contpte-aligned
order for all page sizes.

The worst-case waste is bounded to one folio (up to 2MB - 64KB)
at the end of the file, since page_cache_ra_order() reduces the folio
order near EOF to avoid allocating past i_size.

[1] https://lore.kernel.org/all/20250430145920.3748738-6-ryan.roberts@arm.com/

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 arch/arm64/include/asm/pgtable.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b3e58735c49bd..a1110a33acb35 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1600,12 +1600,11 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 #define arch_wants_old_prefaulted_pte	cpu_has_hw_af
 
 /*
- * Request exec memory is read into pagecache in at least 64K folios. This size
- * can be contpte-mapped when 4K base pages are in use (16 pages into 1 iTLB
- * entry), and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base
- * pages are in use.
+ * Request exec memory is read into pagecache in contpte-sized folios. The
+ * contpte size is the number of contiguous PTEs that the hardware can coalesce
+ * into a single iTLB entry: 64K for 4K pages, 2M for 16K and 64K pages.
  */
-#define exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
+#define exec_folio_order() ilog2(CONT_PTES)
 
 static inline bool pud_sect_supported(void)
 {
-- 
2.47.3

