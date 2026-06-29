Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5736D51D;
	Mon, 29 Jun 2026 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745445; cv=none; b=YsLkG0CZ3ZcrfciUwGyBPXLFr2Qy00EixOpbP64HpT4FC+9MuOiDQohM31qKFnu9gNrR1rP/BM1xnuqI06hNNE4UcIGj/zLz/elOXxTMxs/BH/oTorrjiENfovVNka6rAYG8IVrKULTeJUfhJm/ecMlDYMys5exEb/9oN9um7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745445; c=relaxed/simple;
	bh=Oxss/ekAuDcXMUouOsVu9ATGH6SwADUBbestb+GE9rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=al/oc2DOFiVeiEG/GBp2mTFyfz98CSxb0d1RdFaDhILRgwc6BSyXh3R/L4tOaMVxkUCBD8Ex4wJifo7VtkK2hJ00xp29faXhA66I7XFvCF1zMoosjhLVG5tm0BfkV0RzpokP25+UyLy7/5Oq+FA2F3iQftIVFDfTVisSmXtl/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2jn/yVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2jn/yVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08701F000E9;
	Mon, 29 Jun 2026 15:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745443;
	bh=FhJ57wjixnXyfz65Ud2mcgvSt6Jn+r9xjHxY5R6qlC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O2jn/yVcJJ2mqZUA30Orcz2uGFpQLJdO2WJ9hUPur3pPLa7moFzYE9SUb918PbEdb
	 MyXn6ShIYGirhXnDeUCmEVvQdsewjITy/LBTHd8Olms6viNugWfKgiMlVhT38HMaet
	 EDH+wWRGtVQNyIQpwwfKCYN1A4mUGwmgGgiHbUQY7HF6YgsMy76EpLC4noF59GbSO/
	 hdAT30kDCbBl6SsSQ5D+h+OdC0VdPdvJ5imAeow4nPUtGXAEqMPS5LuGkODRNR3Dob
	 0YZVEhUjATDyCtM3s4/F2iGMYhvzZ22xHKtVEBhYLtiGU6YnHIhfUP7lJQzwZu5vnU
	 MCPaMd2zaf55w==
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
Subject: [RFC PATCH 01/10] mm/vma: introduce VMA virtual page offset field and add helpers
Date: Mon, 29 Jun 2026 16:03:41 +0100
Message-ID: <fc51a14e71c78047ff9d1b1b8c97cfedb84c77bb.1782745153.git.ljs@kernel.org>
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

This patch establishes fields within the vm_area_struct type to store the
virtual page offset of VMAs.

The virtual page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT if
they are unfaulted or were not remapped, otherwise it is equal to this
value at the point of first fault.

Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
file-backed VMAs are tracked by their file offset. By adding virtual offset
as a property of VMAs, we can now track them by their virtual page offset
instead.

By tracking this, we provide the means by which to eliminate this
inconsistency, and more importantly lay the foundations for future work for
the scalable CoW anonymous rmap rework.

This patch simply adds the fields and some simple helpers. Subsequent
patches will update mm code to make use of these fields correctly.

The fields chosen are packed in the VMA such that, for 64-bit kernel
builds, no additional space is taken up.

The first field is present on cacheline 0 containing key VMA fields, and
the second on cacheline 3, which contains file-backed reverse mapping
fields.

Given the relative time spent accessing reverse mapping fields as well as
updating them, there shouldn't be any performance impact here from false
sharing.

Update the VMA userland tests to account for this change.

No callsites are updated yet, so no functional change intended.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 include/linux/mm.h              | 59 +++++++++++++++++++++++++++++++++
 include/linux/mm_types.h        |  4 +++
 mm/vma.h                        | 14 ++++++++
 mm/vma_init.c                   |  1 +
 tools/testing/vma/include/dup.h | 26 +++++++++++++++
 5 files changed, 104 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 868b2334bff3..cd826c052be1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4335,6 +4335,65 @@ static inline pgoff_t vma_last_pgoff(const struct vm_area_struct *vma)
 	return vma_end_pgoff(vma) - 1;
 }
 
+/**
+ * vma_start_virt_pgoff() - Get the virtual page offset of the start of @vma
+ * @vma: The VMA whose virtual page offset is required.
+ *
+ * If unfaulted, then this is vma->vm_start >> PAGE_SHIFT, if faulted then the
+ * virtual page offset at the time of first fault.
+ *
+ * If the VMA is anonymous, this returns the same value as vma_start_pgoff().
+ *
+ * This value is used for tracking MAP_PRIVATE file-backed mappings by their
+ * virtual page offset.
+ *
+ * Returns: The virtual page offset of the start of @vma.
+ */
+static inline pgoff_t vma_start_virt_pgoff(const struct vm_area_struct *vma)
+{
+	pgoff_t pgoff = 0;
+
+#ifdef CONFIG_64BIT
+	pgoff += vma->__vm_virt_pgoff_hi;
+	pgoff <<= 32;
+#endif
+	pgoff += vma->__vm_virt_pgoff_lo;
+	return pgoff;
+}
+
+/**
+ * vma_end_virt_pgoff() - Get the virtual page offset of the exclusive end of
+ * @vma.
+ * @vma: The VMA whose end virtual page offset is required.
+ *
+ * This returns the virtual exclusive end page offset of @vma, which is useful
+ * for expressing page offset ranges.
+ *
+ * See the description of vma_start_virt_pgoff() for a description of VMA
+ * virtual page offsets.
+ *
+ * Returns: The exclusive end virtual page offset of @vma.
+ */
+static inline pgoff_t vma_end_virt_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_start_virt_pgoff(vma) + vma_pages(vma);
+}
+
+/**
+ * vma_last_virt_pgoff() - Get the virtual page offset of the last page in
+ * @vma.
+ * @vma: The VMA whose last virtual page offset is required.
+ *
+ * See the description of vma_start_virt_pgoff() for a description of VMA
+ * virtual page offsets.
+ *
+ * Returns: The last virtual page offset of @vma.
+ */
+static inline pgoff_t vma_last_virt_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_end_virt_pgoff(vma) - 1;
+}
+
 static inline unsigned long vma_desc_size(const struct vm_area_desc *desc)
 {
 	return desc->end - desc->start;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b18c2b2e7d2c..b1bf3db84ee7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -964,6 +964,7 @@ struct vm_area_struct {
 	 */
 	unsigned int vm_lock_seq;
 #endif
+	unsigned int __vm_virt_pgoff_lo; /* Low 32-bits of virtual pgoff. */
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
 	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
@@ -1038,6 +1039,9 @@ struct vm_area_struct {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map vmlock_dep_map;
 #endif
+#endif
+#ifdef CONFIG_64BIT
+	unsigned int __vm_virt_pgoff_hi;  /* High 32-bits of virtual pgoff. */
 #endif
 	/*
 	 * For areas with an address space and backing store,
diff --git a/mm/vma.h b/mm/vma.h
index f4f885615a92..68fb2f49bbab 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -263,6 +263,20 @@ static inline void vma_set_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
 	vma->vm_pgoff = pgoff;
 }
 
+static inline void __vma_set_virt_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
+{
+#ifdef CONFIG_64BIT
+	vma->__vm_virt_pgoff_hi = pgoff >> 32;
+#endif
+	vma->__vm_virt_pgoff_lo = pgoff & GENMASK(31, 0);
+}
+
+static inline void vma_set_virt_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
+{
+	vma_assert_can_modify(vma);
+	__vma_set_virt_pgoff(vma, pgoff);
+}
+
 static inline void vma_add_pgoff(struct vm_area_struct *vma, pgoff_t delta)
 {
 	vma_assert_can_modify(vma);
diff --git a/mm/vma_init.c b/mm/vma_init.c
index 715feee283f0..710b18849a36 100644
--- a/mm/vma_init.c
+++ b/mm/vma_init.c
@@ -51,6 +51,7 @@ static void vm_area_init_from(const struct vm_area_struct *src,
 	dest->vm_end = src->vm_end;
 	dest->anon_vma = src->anon_vma;
 	dest->vm_pgoff = vma_start_pgoff(src);
+	__vma_set_virt_pgoff(dest, vma_start_virt_pgoff(src));
 	dest->vm_file = src->vm_file;
 	dest->vm_private_data = src->vm_private_data;
 	vm_flags_init(dest, src->vm_flags);
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 5d7d0afd7765..09cfbf9572e8 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -573,6 +573,7 @@ struct vm_area_struct {
 	 */
 	unsigned int vm_lock_seq;
 #endif
+	unsigned int __vm_virt_pgoff_lo;
 
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
@@ -608,6 +609,9 @@ struct vm_area_struct {
 #ifdef CONFIG_PER_VMA_LOCK
 	/* Unstable RCU readers are allowed to read this. */
 	refcount_t vm_refcnt;
+#endif
+#ifdef CONFIG_64BIT
+	unsigned int __vm_virt_pgoff_hi;
 #endif
 	/*
 	 * For areas with an address space and backing store,
@@ -1322,6 +1326,28 @@ static inline pgoff_t vma_end_pgoff(const struct vm_area_struct *vma)
 	return vma_start_pgoff(vma) + vma_pages(vma);
 }
 
+static inline pgoff_t vma_start_virt_pgoff(const struct vm_area_struct *vma)
+{
+	pgoff_t pgoff = 0;
+
+#ifdef CONFIG_64BIT
+	pgoff += vma->__vm_virt_pgoff_hi;
+	pgoff <<= 32;
+#endif
+	pgoff += vma->__vm_virt_pgoff_lo;
+	return pgoff;
+}
+
+static inline pgoff_t vma_end_virt_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_start_virt_pgoff(vma) + vma_pages(vma);
+}
+
+static inline pgoff_t vma_last_virt_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_end_virt_pgoff(vma) - 1;
+}
+
 static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
 {
 	return file->f_op->mmap_prepare(desc);
-- 
2.54.0

