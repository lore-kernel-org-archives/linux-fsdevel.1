Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CDF4DB57D;
	Wed, 29 Jul 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343811; cv=none; b=XS4SPh+YzG5nk5fhL96L/TEl7xme242M4y6dBnpM7yvKE3IZ44W8s3a9VSvZOtTcFzr3mX5U7+S+PvRsmUS41wKAymCjz5btr5PVYCDYxY38BLZRu2j7I2lgjLfjFO+5c1Oma/xv2q6GBuom+BNyf83sVRxz8EEarbxT1zjFN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343811; c=relaxed/simple;
	bh=lc1b2FwyMDkTfqYOJvePy8Z7MxKUBNOu6A6vqoiPYz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7cF9yJJdUvUiYy+jmn+00vFBaVEz4q9QmbrTAkkEVxsTSsPrDAsuL3krhnPISEzvV3m9KWXR1dHdD6FmpJQg/yix1p2FTCweEvE4pZzO5VO1glkmPU/uHq6kelr0pzlYE7XFuWgh4EQYYLtpmA2Nbg/BHAsj0goMAkcoD7e0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL5u3VHv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL5u3VHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74A11F00A3D;
	Wed, 29 Jul 2026 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343809;
	bh=2frCCTlxfdZhl2Q9hCXWFmqticNPmIEH4CLCsGGzpUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jL5u3VHv67bTva7n3vFw64jcekSbG56ZcwC9S160bcGGoc6vXPo3E5IVdaTP1TGtF
	 QMHFqfMG0YGdKF3neRRSpb1K3cS43NMPsF/z+kl4FYNb7wb6vbvzVlYrya6sNsBCXP
	 zENeYsVP+ChPU2WQ4wWknBwx5TSAXtdDyOCGrHSHSnHSPLcTBn8EOCcMMvUgXud9Wm
	 NkxbkoJpSFdcb3nlbWKrmkDEMdro+WeY6HpdlC0jzCDBgPcFfehcRDl7L49U5VA3DZ
	 m5UA4FX0qr1xPWy0qD0Yzs6RXMAJRBJJpeAxcuve3rkNmeqTZEjVIHD7C9TxLrlZt7
	 Dr3uPkh/20h8Q==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 29 Jul 2026 17:48:43 +0100
Subject: [PATCH v3 08/15] mm: introduce and use linear_folio_page_index()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-b4-scalable-cow-virt-pgoff-v3-8-e8ecfefea812@kernel.org>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
In-Reply-To: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4026; i=ljs@kernel.org;
 h=from:subject:message-id; bh=lc1b2FwyMDkTfqYOJvePy8Z7MxKUBNOu6A6vqoiPYz8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKy9H7Myms88S6d87vEtz32x1KW+/M8V7vrnb988uMva
 mH6p0RPdJSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiNu4M/wsuhnB7s+08PrFY
 /aTS94jfvjNyAxoluvUd4+S+XnqZXcrwP7BMIH+q0W2X58G1m1dNU58gpjM5MvpJenP8f6/Vx46
 d4gYA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

This function is, for now, a placeholder; it will be used in future to
determine whether to use the anonymous page index or not, based on whether
the folio is anonymous or not.

Currently it simply wraps linear_page_index(), so this does not change
behaviour.

We update callers that will, once the change is introduced to track
anonymous folios by anonymous page offset if MAP_PRIVATE file-backed, need
to determine which index to use based on folio type.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/pagemap.h | 18 ++++++++++++++++++
 mm/huge_memory.c        |  3 ++-
 mm/migrate.c            |  6 ++++--
 mm/userfaultfd.c        |  6 ++++--
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 259177544b03..6eb8d811ba4c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1143,6 +1143,24 @@ static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
 	return pgoff;
 }
 
+/**
+ * linear_folio_page_index() - Determine the absolute page offset of
+ * @address within @vma from @folio.
+ * @folio: The folio whose linear page index is sought.
+ * @vma: The VMA in which @address resides.
+ * @address: The address whose absolute page offset is required.
+ *
+ * For compatibility, currently identical to linear_page_index().
+ *
+ * Returns: The absolute page offset of @address within @vma.
+ */
+static inline pgoff_t linear_folio_page_index(const struct folio *folio,
+					      const struct vm_area_struct *vma,
+					      const unsigned long address)
+{
+	return linear_page_index(vma, address);
+}
+
 struct wait_page_key {
 	struct folio *folio;
 	int bit_nr;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9b1f3b24f7e0..abc65d608c23 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2887,7 +2887,8 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		}
 
 		folio_move_anon_rmap(src_folio, dst_vma);
-		src_folio->index = linear_page_index(dst_vma, dst_addr);
+		src_folio->index = linear_folio_page_index(src_folio, dst_vma,
+							   dst_addr);
 
 		_dst_pmd = folio_mk_pmd(src_folio, dst_vma->vm_page_prot);
 		/* Follow mremap() behavior and treat the entry dirty after the move */
diff --git a/mm/migrate.c b/mm/migrate.c
index 222c8c15f782..37fe7a9b3fac 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -363,8 +363,10 @@ static bool remove_migration_pte(struct folio *folio,
 		unsigned long idx = 0;
 
 		/* pgoff is invalid for ksm pages, but they are never large */
-		if (folio_test_large(folio) && !folio_test_hugetlb(folio))
-			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
+		if (folio_test_large(folio) && !folio_test_hugetlb(folio)) {
+			idx += linear_folio_page_index(folio, vma, pvmw.address);
+			idx -= pvmw.pgoff;
+		}
 		new = folio_page(folio, idx);
 
 #ifdef CONFIG_ARCH_HAS_PMD_SOFTLEAVES
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8fd24c8b428e..258b03182a78 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1352,7 +1352,8 @@ static long move_present_ptes(struct mm_struct *mm,
 		}
 
 		folio_move_anon_rmap(src_folio, dst_vma);
-		src_folio->index = linear_page_index(dst_vma, dst_addr);
+		src_folio->index = linear_folio_page_index(src_folio, dst_vma,
+							   dst_addr);
 
 		orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
 		/* Set soft dirty bit so userspace can notice the pte was moved */
@@ -1428,7 +1429,8 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	 */
 	if (src_folio) {
 		folio_move_anon_rmap(src_folio, dst_vma);
-		src_folio->index = linear_page_index(dst_vma, dst_addr);
+		src_folio->index = linear_folio_page_index(src_folio, dst_vma,
+							   dst_addr);
 	} else {
 		/*
 		 * Check if the swap entry is cached after acquiring the src_pte

-- 
2.55.0

