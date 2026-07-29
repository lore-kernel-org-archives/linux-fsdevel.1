Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D03EC80D;
	Wed, 29 Jul 2026 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343765; cv=none; b=V0NtI8HM6exY6xq7IzhVlPcrfwFx/1xcmP8RaJO7qw/dbN6IaUfxy/yz5pgev98ubhyp12I7vaWbTgdPa8VMxWL9kZTksdUxbkHxLOTWkh1Qx5ZcUj+r0Ac+2o2kwF5TlijU/O/Awcos9QKtcdch/mprLNu+1kGEj/4yiNDn3w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343765; c=relaxed/simple;
	bh=uUkE9gAhysK/nnjLeZ8l8BrdRNA2q/dMcD1c2dbX+2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=boEiPAAg8ayaVpcpYCufx6Ms0BFkb8EmfFY5FNiPQdl26efqPJfrureEnHa8RnEePQ06gAw31fW6kmEIyQgoWLCc8zXroDAxos6OWZ9TsVp3w4TenEK9oEaDApcjU9Mb+oT8i2sV2VbffY4WVx872XNb6PJsynS6g/foQgdChoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYyk+Q+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYyk+Q+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490331F00A3F;
	Wed, 29 Jul 2026 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343763;
	bh=WPbLai49bH0v33Ittvjqr9WRlcy9Qzii1B24A4wQ6as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FYyk+Q+GfJ6Vft2X2fBlBKfdEczY/qlaSQvavtfzu4DmEBkiTNufI29uSQVLX/5Ds
	 fTmRW6UM/CxkH662WCO7VzpwKPZ4JBna//mI7WBEB8QbKf5U52FBtNA4YcdBkq/I5E
	 R8wCw2KqnoBBgGS3LUtgFfp9OAmFO/eDSXcuf5SfWb0jrpMeyKNLbzqmByK4GGvuqJ
	 UfLByhQ84TF4QzQAmM0mlfYQR4OAGUz5kUQ3VX6BSp+0ja6zKjEsDUJ/QJOo2g7A5I
	 dkb2evTYBkNLupa2i+aGYMV74iArsg0jo4kV9iiT9k7BeldydYaOwnz7T4Ew65z1ad
	 Tzn0GfPEwujKg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 29 Jul 2026 17:48:36 +0100
Subject: [PATCH v3 01/15] mm/vma: introduce VMA anon page offset field and
 add helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-b4-scalable-cow-virt-pgoff-v3-1-e8ecfefea812@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7771; i=ljs@kernel.org;
 h=from:subject:message-id; bh=uUkE9gAhysK/nnjLeZ8l8BrdRNA2q/dMcD1c2dbX+2g=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKy9H7kanw5HpX61rBUvq62/sjzeUGPlJzm/79QkDCXq
 8nl0Om1HaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZjIDkWG/3XuK97dUb1ZzXLF
 w5w95Iep1IYVW0L2xVdbRW6/dF6A+THD/zChmKl7d129sML0q49nxp8Nyjvm1aXOOpp14afW8Qe
 GG5gA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

This patch establishes fields within the vm_area_struct type to store the
anonymous page offset of VMAs.

The anonymous page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT
if they are unfaulted or were not remapped, otherwise it is equal to this
value at the point of first fault.

Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
file-backed VMAs are tracked by their file offset. By adding anonymous
offset as a property of VMAs, we can now track them by their anonymous page
offset instead.

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
 include/linux/mm_types.h        | 12 +++++++++
 mm/vma.h                        | 14 ++++++++++
 mm/vma_init.c                   |  1 +
 tools/testing/vma/include/dup.h | 26 ++++++++++++++++++
 5 files changed, 112 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 87feaa5a2b78..df78847f5f07 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4393,6 +4393,65 @@ static inline pgoff_t vma_last_pgoff(const struct vm_area_struct *vma)
 	return vma_end_pgoff(vma) - 1;
 }
 
+/**
+ * vma_start_anon_pgoff() - Get the anonymous page offset of the start of @vma
+ * @vma: The VMA whose anonymous page offset is required.
+ *
+ * If unfaulted, then this is vma->vm_start >> PAGE_SHIFT, if faulted then the
+ * anonymous page offset at the time of first fault.
+ *
+ * If the VMA is anonymous, this returns the same value as vma_start_pgoff().
+ *
+ * This value is used for tracking MAP_PRIVATE file-backed mappings by their
+ * anonymous page offset.
+ *
+ * Returns: The anonymous page offset of the start of @vma.
+ */
+static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *vma)
+{
+	pgoff_t pgoff = 0;
+
+#ifdef CONFIG_64BIT
+	pgoff += vma->__vm_anon_pgoff_hi;
+	pgoff <<= 32;
+#endif
+	pgoff += vma->__vm_anon_pgoff_lo;
+	return pgoff;
+}
+
+/**
+ * vma_end_anon_pgoff() - Get the anonymous page offset of the exclusive end of
+ * @vma.
+ * @vma: The VMA whose end anonymous page offset is required.
+ *
+ * This returns the anonymous exclusive end page offset of @vma, which is useful
+ * for expressing page offset ranges.
+ *
+ * See the description of vma_start_anon_pgoff() for a description of VMA
+ * anonymous page offsets.
+ *
+ * Returns: The exclusive end anonymous page offset of @vma.
+ */
+static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_start_anon_pgoff(vma) + vma_pages(vma);
+}
+
+/**
+ * vma_last_anon_pgoff() - Get the anonymous page offset of the last page in
+ * @vma.
+ * @vma: The VMA whose last anonymous page offset is required.
+ *
+ * See the description of vma_start_anon_pgoff() for a description of VMA
+ * anonymous page offsets.
+ *
+ * Returns: The last anonymous page offset of @vma.
+ */
+static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_end_anon_pgoff(vma) - 1;
+}
+
 static inline unsigned long vma_desc_size(const struct vm_area_desc *desc)
 {
 	return desc->end - desc->start;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 939b5ea8c9e0..ebf0d912be7d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -967,6 +967,11 @@ struct vm_area_struct {
 	 */
 	unsigned int vm_lock_seq;
 #endif
+	/*
+	 * Low 32-bits of anonymous page offset.
+	 * See vma_start_anon_pgoff() comment for details.
+	 */
+	unsigned int __vm_anon_pgoff_lo;
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
 	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
@@ -1041,6 +1046,13 @@ struct vm_area_struct {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map vmlock_dep_map;
 #endif
+#endif
+#ifdef CONFIG_64BIT
+	/*
+	 * High 32-bits of anonymous page offset.
+	 * See vma_start_anon_pgoff() comment for details.
+	 */
+	unsigned int __vm_anon_pgoff_hi;
 #endif
 	/*
 	 * For areas with an address space and backing store,
diff --git a/mm/vma.h b/mm/vma.h
index 0bc7d521e976..54ed7c744e3b 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -283,6 +283,20 @@ static inline void vma_set_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
 	vma->vm_pgoff = pgoff;
 }
 
+static inline void __vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
+{
+#ifdef CONFIG_64BIT
+	vma->__vm_anon_pgoff_hi = pgoff >> 32;
+#endif
+	vma->__vm_anon_pgoff_lo = pgoff & GENMASK(31, 0);
+}
+
+static inline void vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
+{
+	vma_assert_can_modify(vma);
+	__vma_set_anon_pgoff(vma, pgoff);
+}
+
 static inline void vma_add_pgoff(struct vm_area_struct *vma, pgoff_t delta)
 {
 	vma_assert_can_modify(vma);
diff --git a/mm/vma_init.c b/mm/vma_init.c
index 715feee283f0..baa7e82f47e3 100644
--- a/mm/vma_init.c
+++ b/mm/vma_init.c
@@ -51,6 +51,7 @@ static void vm_area_init_from(const struct vm_area_struct *src,
 	dest->vm_end = src->vm_end;
 	dest->anon_vma = src->anon_vma;
 	dest->vm_pgoff = vma_start_pgoff(src);
+	__vma_set_anon_pgoff(dest, vma_start_anon_pgoff(src));
 	dest->vm_file = src->vm_file;
 	dest->vm_private_data = src->vm_private_data;
 	vm_flags_init(dest, src->vm_flags);
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index c52b23773cd2..26d9210b1e8b 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -577,6 +577,7 @@ struct vm_area_struct {
 	 */
 	unsigned int vm_lock_seq;
 #endif
+	unsigned int __vm_anon_pgoff_lo;
 
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
@@ -612,6 +613,9 @@ struct vm_area_struct {
 #ifdef CONFIG_PER_VMA_LOCK
 	/* Unstable RCU readers are allowed to read this. */
 	refcount_t vm_refcnt;
+#endif
+#ifdef CONFIG_64BIT
+	unsigned int __vm_anon_pgoff_hi;
 #endif
 	/*
 	 * For areas with an address space and backing store,
@@ -1320,6 +1324,28 @@ static inline pgoff_t vma_end_pgoff(const struct vm_area_struct *vma)
 	return vma_start_pgoff(vma) + vma_pages(vma);
 }
 
+static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *vma)
+{
+	pgoff_t pgoff = 0;
+
+#ifdef CONFIG_64BIT
+	pgoff += vma->__vm_anon_pgoff_hi;
+	pgoff <<= 32;
+#endif
+	pgoff += vma->__vm_anon_pgoff_lo;
+	return pgoff;
+}
+
+static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_start_anon_pgoff(vma) + vma_pages(vma);
+}
+
+static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_end_anon_pgoff(vma) - 1;
+}
+
 static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
 {
 	return file->f_op->mmap_prepare(desc);

-- 
2.55.0

