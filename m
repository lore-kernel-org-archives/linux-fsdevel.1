Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73EC3370E4;
	Fri, 17 Jul 2026 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312644; cv=none; b=BiBejW+MHZUdM8o6M1/PE6WojPxRaFS82U91r0kcUfwN4iEUF54AzWk1+Ezz+cVcxt4zPaDJcjoxyRAMOwjZSSCVxDqEBvwgkzSuxGMp0RFoL4vmq6tFjCuU8cYMAvjePONE0KRuKcbqKXNr/nA7kNF7NtDHKzAxLsz9EIMLnDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312644; c=relaxed/simple;
	bh=efwTnIHzkKX0RplIWXulhNQpbVQxVROQFPLdI6z77uY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5djMWAt2dhFA6UMaR6OYm3puszpK434N9v+PYxFXv6OlKIeEvAhTRAQBNliuo8nIJFzgpS46vs4BgMeU7AtDUU6wOEwjALsRW+BCVjyAL3ubbSmZQfI+qRUt81X4FPUmRDnV+BKkGOL4WeinsCgL5AFFDQDJJURabo+bJOK9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odkRKlJj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odkRKlJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31EB1F00A3D;
	Fri, 17 Jul 2026 18:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784312642;
	bh=AMXMZPPGRWd9Xw8i5HYWkiF0Bq2ZcnqCXrjlidS4hik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=odkRKlJjGCbmUafVPgYl86ptaM4bULyKnomTxwVv6fOeiTnjQV945B301hF7qZsHd
	 ckdjpBgNXQYY6Zq2c2G1UQIo5+TffcppfpHiAErGoz3l8soQ9NVDcxD5s3ugi/8Un7
	 42nBwEuAkoE6M2UkQyAsJRq0AyNHhzE052DIRJqEB+o+7cMfdkqHL+rLU9bW7lQN/0
	 RgcLWReYD8LNeeYwCQ7MbjNg8KM21a7NkxUa/6N0s655halOIB9hsQhzJOEMpet7xn
	 y4qEnEEPiSedlrJZc79XLDTfrkBqyUbWQArVD1TIw6ZNQqkZZ2jp187OcABa2Kzf0O
	 kebbKXvGg6tew==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 17 Jul 2026 19:19:50 +0100
Subject: [PATCH 12/15] mm/vma: only permit MAP_PRIVATE /dev/zero to be
 mapped anonymous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-b4-scalable-cow-virt-pgoff-v1-12-cf24910ef094@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7326; i=ljs@kernel.org;
 h=from:subject:message-id; bh=efwTnIHzkKX0RplIWXulhNQpbVQxVROQFPLdI6z77uY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKiivbZxV65PsvQ7eQ/v50PLQRT1V9m1xm82xq40yxZx
 WqDjOPdjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzkkS4jw7l94f/FtS4vthdm
 8bXWfX/nbPKsv1NVtauTY1+9dt9bJcnIcHjnB2cFsQ05Lu7H380JP864Tm2Z7c53p2e9eO9sZ77
 oNDsA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

In order to use mmap_prepare() with MAP_PRIVATE mappings of /dev/zero
without the success_hook hack we explicitly permitted mmap_prepare handlers
to set NULL vm_ops.

However this is dangerous and we really only want to allow this for
MAP_PRIVATE-mapped /dev/zero.

Make it possible to explicitly identify /dev/zero by setting a global
DEVZERO_MINOR device minor number then explicitly check for this in mmap
code for a MAP_PRIVATE mapping and only set the VMA anonymous if we have
positively identified it.

Then remove all ability for mmap_prepare or mmap hooks to set a VMA
anonymous and update mmap_zero_prepare() to leave it to the core mmap code
to mark the VMA anonymous.

Note that this disallows nested MAP_PRIVATE-mappings of /dev/zero
regions. Doing this would be broken in any case.

We therefore do not need to update the mmap_prepare() compatibility layer
to reflect these changes, as the mmap hook check suffices to disallow this
behaviour.

Also update the VMA userland tests to reflect the change.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/char/mem.c              |  8 ++------
 include/linux/mm.h              |  3 +++
 mm/internal.h                   |  4 ++++
 mm/vma.c                        | 33 +++++++++++++++++++++++++++------
 mm/vma_internal.h               |  1 +
 tools/testing/vma/include/dup.h | 28 ++++++++++++++++++++++++++++
 6 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 63253d1de5d7..dcfd896b733d 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -506,11 +506,7 @@ static int mmap_zero_prepare(struct vm_area_desc *desc)
 	if (vma_desc_test(desc, VMA_SHARED_BIT))
 		return shmem_zero_setup_desc(desc);
 
-	/*
-	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
-	 * of /dev/zero anonymous, despite it not being.
-	 */
-	vma_desc_set_anonymous(desc);
+	/* MAP_PRIVATE semantics are taken care for us by core mm. */
 	return 0;
 }
 
@@ -698,7 +694,7 @@ static const struct memdev {
 #ifdef CONFIG_DEVPORT
 	[4] = { "port", &port_fops, 0, 0 },
 #endif
-	[5] = { "zero", &zero_fops, FMODE_NOWAIT, 0666 },
+	[DEVZERO_MINOR] = { "zero", &zero_fops, FMODE_NOWAIT, 0666 },
 	[7] = { "full", &full_fops, 0, 0666 },
 	[8] = { "random", &random_fops, FMODE_NOWAIT, 0666 },
 	[9] = { "urandom", &urandom_fops, FMODE_NOWAIT, 0666 },
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b6503b5f0010..7614afe99c96 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -740,6 +740,9 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
 	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
 
+/* /dev/zero minor device number. Special due to MAP_PRIVATE semantics. */
+#define DEVZERO_MINOR	5
+
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
  * ->fault function. The vma's ->fault is responsible for returning a bitmask
diff --git a/mm/internal.h b/mm/internal.h
index 22f63cb85bd3..41561fdeb56d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -240,6 +240,10 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 {
 	int err = vfs_mmap(file, vma);
 
+	/* Hooks cannot mark themselves anonymous. */
+	if (WARN_ON_ONCE(vma_is_anonymous(vma)))
+		err = -EINVAL;
+
 	if (likely(!err))
 		return 0;
 
diff --git a/mm/vma.c b/mm/vma.c
index 6dc095d03382..6ccd097b8813 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2612,6 +2612,27 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 	return 0;
 }
 
+static bool map_is_dev_zero(const struct mmap_state *map)
+{
+	const struct file *file = map->file;
+	const struct inode *inode = file_inode(file);
+
+	return imajor(inode) == MEM_MAJOR && iminor(inode) == DEVZERO_MINOR;
+}
+
+static bool map_is_private(const struct mmap_state *map)
+{
+	return !vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
+}
+
+static bool map_is_anon(const struct mmap_state *map)
+{
+	if (!map_is_private(map))
+		return false;
+
+	return !map->file || map_is_dev_zero(map);
+}
+
 /*
  * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
  * possible.
@@ -2625,8 +2646,7 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 	struct mmap_action *action)
 {
-	const bool is_anon = !map->file &&
-		!vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
+	const bool is_anon = map_is_anon(map);
 	struct vma_iterator *vmi = map->vmi;
 	int error = 0;
 	struct vm_area_struct *vma;
@@ -2768,6 +2788,10 @@ static int call_mmap_prepare(struct mmap_state *map,
 	if (err)
 		return err;
 
+	/* Hooks cannot mark themselves anonymous. */
+	if (!desc->vm_ops)
+		return -EINVAL;
+
 	err = call_action_prepare(map, desc);
 	if (err)
 		return err;
@@ -2790,10 +2814,7 @@ static int call_mmap_prepare(struct mmap_state *map,
 static void set_vma_user_defined_fields(struct vm_area_struct *vma,
 		struct mmap_state *map)
 {
-	if (map->vm_ops)
-		vma->vm_ops = map->vm_ops;
-	else	/* Only /dev/zero should do this. */
-		vma_set_anonymous(vma);
+	vma->vm_ops = map->vm_ops;
 	vma->vm_private_data = map->vm_private_data;
 }
 
diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index 4d300e7bbaf4..385c0ab13777 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -23,6 +23,7 @@
 #include <linux/ksm.h>
 #include <linux/khugepaged.h>
 #include <linux/list.h>
+#include <linux/major.h>
 #include <linux/maple_tree.h>
 #include <linux/mempolicy.h>
 #include <linux/mm.h>
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 51605ade06fb..93049241b297 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -15,6 +15,15 @@ struct task_struct *get_current(void);
 #define MMF_HAS_MDWE	28
 #define current get_current()
 
+#define MINORBITS	20
+#define MINORMASK	((1U << MINORBITS) - 1)
+
+#define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
+#define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
+
+#define MEM_MAJOR		1
+#define DEVZERO_MINOR	5
+
 /*
  * Define the task command name length as enum, then it can be visible to
  * BPF programs.
@@ -45,6 +54,9 @@ struct address_space {
 	unsigned long		flags;
 	atomic_t		i_mmap_writable;
 };
+struct inode {
+	dev_t			i_rdev;
+};
 struct file_operations {
 	int (*mmap)(struct file *, struct vm_area_struct *);
 	int (*mmap_prepare)(struct vm_area_desc *);
@@ -52,6 +64,7 @@ struct file_operations {
 struct file {
 	struct address_space	*f_mapping;
 	const struct file_operations	*f_op;
+	struct inode			*f_inode;
 };
 struct anon_vma_chain {
 	struct anon_vma *anon_vma;
@@ -1632,3 +1645,18 @@ static inline pgoff_t linear_virt_page_index(const struct vm_area_struct *vma,
 
 	return pgoff;
 }
+
+static inline struct inode *file_inode(const struct file *f)
+{
+	return f->f_inode;
+}
+
+static inline unsigned iminor(const struct inode *inode)
+{
+	return MINOR(inode->i_rdev);
+}
+
+static inline unsigned imajor(const struct inode *inode)
+{
+	return MAJOR(inode->i_rdev);
+}

-- 
2.55.0

