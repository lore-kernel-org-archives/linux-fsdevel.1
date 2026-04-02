Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E53DCD9A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153653; cv=none; b=nLv6XONuOsT1ET3dlPbJwyjhNc6iVuLsavxGAJSJuyo0yXzCiZuzVZ8G2BvOYAemTy/MVnVCLBAxY3GozDZDlQv56X0guOKc+D6GTc8XVqtYSiF/DsTyLK+GyhHKY4jYsZmKEsNTUpVyQfSfkiiM82WmntVcMr6nLqYHp+M7wWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153653; c=relaxed/simple;
	bh=OhZbU4NVFupE4pyVzCcACZj5uc3jtjdhtQ5T10gNhGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5iRf5ndUNB9Yidba0kIXHDDBOmIyoOTbFhB9wqGiHee3AluJmYEGyU1sUp2pJ/7DRQyzoGWAEcirjqxplFW2UTQ4H6o0NRQuDbOHZdUc81paliTxKrbqN8jmiMyMF/auM+lP+VhJDf4yaiymoWq404wplSl+gitbngA6sZoPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GCgY7W2u; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GCgY7W2u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775153646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkczfxtSF84VSlTks10/GwIlblAMIDiieRoVjs+yTko=;
	b=GCgY7W2uOZ9JOJ9TKL9rwScooWJa3NSfsWsGckrshtUKYLwLenqw8/WjLx0Z4uA+sAWq/i
	MP9pHdN5k++FTE7QpoVImIQJ6P5w7BhPS+mm4Ls/yGqPdljUkJoVqO+6UMRhlpVlz5ICYl
	7egdHS89vNwD+WdCQpSsbvwFDNYj6ok=
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
Subject: [PATCH v3 4/4] mm: align file-backed mmap to exec folio order in thp_get_unmapped_area
Date: Thu,  2 Apr 2026 11:08:25 -0700
Message-ID: <20260402181326.3107102-5-usama.arif@linux.dev>
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

thp_get_unmapped_area() is the get_unmapped_area callback for
filesystems like ext4, xfs, and btrfs. It attempts to align the virtual
address for PMD_SIZE THP mappings, but on arm64 with 64K base pages
PMD_SIZE is 512M, which is too large for typical shared library mappings,
so the alignment always fails and falls back to PAGE_SIZE.

This means shared libraries loaded by ld.so via mmap() get 64K-aligned
virtual addresses, preventing contpte mapping even when large folios are
allocated with properly aligned file offsets and physical addresses.

Add a fallback in thp_get_unmapped_area_vmflags() that uses
exec_folio_order() to determine alignment, matching the readahead
allocation strategy. This aligns mappings to the hardware TLB
coalescing size (e.g. 2M for contpte on arm64 64K pages, 64K for
contpte/HPA on arm64 4K/16K pages), capped to the mapping length via
rounddown_pow_of_two(len).

The fallback is naturally a no-op on architectures where
exec_folio_order() returns 0, and skips the retry when the alignment
would equal PMD_SIZE (already attempted above) incase another
architecture changes exec_folio_order() in the future.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/huge_memory.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b2a6060b3c20..ad97ac8406dc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1218,6 +1218,19 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
 	if (ret)
 		return ret;
 
+	if (filp && exec_folio_order()) {
+		unsigned long exec_folio_size = PAGE_SIZE << exec_folio_order();
+		unsigned long size = rounddown_pow_of_two(len);
+
+		size = min(size, exec_folio_size);
+		if (size > PAGE_SIZE && size != PMD_SIZE) {
+			ret = __thp_get_unmapped_area(filp, addr, len, off,
+						      flags, size, vm_flags);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return mm_get_unmapped_area_vmflags(filp, addr, len, pgoff, flags,
 					    vm_flags);
 }
-- 
2.52.0

