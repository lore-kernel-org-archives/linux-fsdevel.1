Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38442EEBA;
	Mon, 29 Jun 2026 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745465; cv=none; b=rMr4QCR+MLHP3IYdXb9IVyec0+K9NzD3SEnf62qQQCqA5DB3qIHW6mPQx59DBZcACJ/9//jQQMDNoYj+IbSyjeWqbCwryViWfzhE8tMvZIlXXnAUPsyg7l0wcDSCWjljuM5jSc2bZWii7FKypTcCeWQeb9qq/DAQgTMBNwvt/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745465; c=relaxed/simple;
	bh=SYaVXt+IV8k9IprMmFlL40jrqkI+bjDFhw+L/e/x6c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDUcbKhXU9iewW1hIYqKvy4Hti8xJJmYQGZOuEMBWmoaQYT48TEx+UglRxtNrudL+Qoevsz3I2A+DQk9Et/aFuovYPQbA29NPokwF0s70babqqzqFau6bZJ6/Jy7yWXZwScc2ET0XKlTUqP2GHHVfKTqWfWH0CQ22UZXbpg0TKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFio7RIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFio7RIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7841C1F000E9;
	Mon, 29 Jun 2026 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745464;
	bh=njjcJ09hvKJm4DFqkApGQjO9fSrNvBtEtkEmL7ywa5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QFio7RIWh9qUVn1KVNLiBit78SH4LLPizL9FqW44jft3Vr2XWCwkPsbHTRqAbVO4i
	 DJXgerUwodYxfWKcGXfcssCek5si/ANwdkXnMZhQgEMPxruwf5PA6K88Y+YLkWYmPN
	 pqun5hdQ0I/Y2M9MfQ0ZvZe9JaGaCs26z9fzx3WJ4pk3cJhdxcqGKMPujyWgU3gMQ7
	 sgnf68WV4U9Hr9uUvEskGcjMWVcyQ/J+lolia5Ft96QzWnOSu1bbBaokxkY7TsUtjJ
	 PqkHMy1ywX/SP9fteMIBK0hpuqMI8GsM2dHkxcyofmZO9SiMt9YQnJl0R1Rsj0OhmM
	 NA6OfaQrULYbA==
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 08/10] mm: introduce and use linear_folio_page_index()
Date: Mon, 29 Jun 2026 16:03:48 +0100
Message-ID: <58b4246bd0cd8b58f86ae7ce2acd54f9f478445a.1782745153.git.ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782745153.git.ljs@kernel.org>
References: <cover.1782745153.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is, for now, a placeholder; it will be used in future to
determine whether to use the virtual page index or not, based on whether
the folio is anonymous or not.

Currently it simply wraps linear_page_index(), so this does not change
behaviour.

We update callers that will, once the change is introduced to track
anonymous folios by virtual page offset if MAP_PRIVATE file-backed, need to
determine which index to use based on folio type.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 include/linux/pagemap.h | 18 ++++++++++++++++++
 mm/huge_memory.c        |  3 ++-
 mm/migrate.c            |  6 ++++--
 mm/userfaultfd.c        |  6 ++++--
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 6e0d719d639a..e2affa57dadd 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1146,6 +1146,24 @@ static inline pgoff_t linear_virt_page_index(const struct vm_area_struct *vma,
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
index e94f56487225..1b3456a9ff74 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2832,7 +2832,8 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		}
 
 		folio_move_anon_rmap(src_folio, dst_vma);
-		src_folio->index = linear_page_index(dst_vma, dst_addr);
+		src_folio->index = linear_folio_page_index(src_folio, dst_vma,
+							   dst_addr);
 
 		_dst_pmd = folio_mk_pmd(src_folio, dst_vma->vm_page_prot);
 		/* Follow mremap() behavior and treat the entry dirty after the move */
diff --git a/mm/migrate.c b/mm/migrate.c
index d9b23909d716..4250a56e09c0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -358,8 +358,10 @@ static bool remove_migration_pte(struct folio *folio,
 		unsigned long idx = 0;
 
 		/* pgoff is invalid for ksm pages, but they are never large */
-		if (folio_test_large(folio) && !folio_test_hugetlb(folio))
-			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
+		if (folio_test_large(folio) && !folio_test_hugetlb(folio)) {
+			idx += linear_folio_page_index(folio, vma, pvmw.address);
+			idx -= pvmw.pgoff;
+		}
 		new = folio_page(folio, idx);
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bf4518f4449d..9c6b1a678ca6 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1283,7 +1283,8 @@ static long move_present_ptes(struct mm_struct *mm,
 		}
 
 		folio_move_anon_rmap(src_folio, dst_vma);
-		src_folio->index = linear_page_index(dst_vma, dst_addr);
+		src_folio->index = linear_folio_page_index(src_folio, dst_vma,
+							   dst_addr);
 
 		orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
 		/* Set soft dirty bit so userspace can notice the pte was moved */
@@ -1352,7 +1353,8 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
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
2.54.0

