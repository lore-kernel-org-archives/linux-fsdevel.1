Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2446D37E5FD;
	Fri, 17 Jul 2026 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312542; cv=none; b=OJTFdn0uIg6GmUTgs+o9p5I4VRmbmNt3rTP9S1P107dgOS32q91bMlk3rXIwjEeBl0ll58ZrT/JtYnLjKcB2xyeKZUlAqJwibIlrrWGSZac+4U8lldlyKuA+HYbXlAjoabo55cp6HJwuwyM+6kHxweF6RXepHEzbBDG8xBf6+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312542; c=relaxed/simple;
	bh=YXEfVWh2K58M+fDJD08jE97qBHPU4vg8rEAVLna7Ku4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eqju9M+AbdTTdiBn7b3Hdbi+mbQXQOG59Bab6lL2NlqaPurhT7U74uFbJ8TD5am2RE18lHq4X1s6SxegVyCpP69awl9TZqKU7NsqO2IbvG5c0kDyTbfmnxmYg5zLAkGxkDMW5EAG6BSgD85dccJCSHICuo9rVQ66LjipRvB3pvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8eIgB7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8eIgB7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6751F00A3A;
	Fri, 17 Jul 2026 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784312539;
	bh=TBERY1CFqX0D7t50CAbelyZ+L1fjNG+q7nyi8SSJxkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c8eIgB7QeydVoinrdlpcbGKnB55ieFOn62QyloUFSD/xDwVImtEpD1Uc6MjxCaPAZ
	 DZO3S9lVGYz8Zsd2OyvF2CCi/7g6ZvOhyIQmpetfb39EXpqZl69WbWiXJqF2wNhlYD
	 9BUIAH5kVtQrz7GZhGbhH21OAjE2/rphIeArw9PRPf4hJ/ZzqA1Rc6vbdRxdgvPFUw
	 /O9JtubscUgSdUVRM58U1xPiRDDye0Vdkyb2FU/J9x+Ce3X+bq+9Uif/ENzHO3iwj7
	 YDJEwmvXl2M94/Lux5lXAXJieBsCZ8/fCQcHsp6kkGQRuWSwAw34W9BeHqXThCf2Ae
	 6lYMHXjLnQoAA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 17 Jul 2026 19:19:39 +0100
Subject: [PATCH 01/15] mm/vma: introduce VMA virtual page offset field and
 add helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-b4-scalable-cow-virt-pgoff-v1-1-cf24910ef094@kernel.org>
References: <20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org>
In-Reply-To: <20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7578; i=ljs@kernel.org;
 h=from:subject:message-id; bh=YXEfVWh2K58M+fDJD08jE97qBHPU4vg8rEAVLna7Ku4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKiivZqG/FtFZhhy1e24Vpp0o5/93M/T/xeLvvOriQrg
 kvBev/xjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEwkZjEjw4zN7Id9mz9d9RQz
 rXA98rNj95pNe5juJTP05vU1Lvv0mIfhf0jhxhlLu725b5zePG3itCiX2e/M0p43P2wU3ezTZfh
 agRUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

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

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h              | 59 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h        |  4 +++
 mm/vma.h                        | 14 ++++++++++
 mm/vma_init.c                   |  1 +
 tools/testing/vma/include/dup.h | 26 ++++++++++++++++++
 5 files changed, 104 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 87feaa5a2b78..59b98cc60402 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4393,6 +4393,65 @@ static inline pgoff_t vma_last_pgoff(const struct vm_area_struct *vma)
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
index 939b5ea8c9e0..2710628059b1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -967,6 +967,7 @@ struct vm_area_struct {
 	 */
 	unsigned int vm_lock_seq;
 #endif
+	unsigned int __vm_virt_pgoff_lo; /* Low 32-bits of virtual pgoff. */
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
 	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
@@ -1041,6 +1042,9 @@ struct vm_area_struct {
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
index 0bc7d521e976..04c5c1c546f6 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -283,6 +283,20 @@ static inline void vma_set_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
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
index c52b23773cd2..00d416d79ec1 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -577,6 +577,7 @@ struct vm_area_struct {
 	 */
 	unsigned int vm_lock_seq;
 #endif
+	unsigned int __vm_virt_pgoff_lo;
 
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
@@ -612,6 +613,9 @@ struct vm_area_struct {
 #ifdef CONFIG_PER_VMA_LOCK
 	/* Unstable RCU readers are allowed to read this. */
 	refcount_t vm_refcnt;
+#endif
+#ifdef CONFIG_64BIT
+	unsigned int __vm_virt_pgoff_hi;
 #endif
 	/*
 	 * For areas with an address space and backing store,
@@ -1320,6 +1324,28 @@ static inline pgoff_t vma_end_pgoff(const struct vm_area_struct *vma)
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
2.55.0

