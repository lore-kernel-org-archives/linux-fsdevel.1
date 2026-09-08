Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709E51476A;
	Tue,  8 Sep 2026 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866710; cv=none; b=FE3pCy5T8XqHLpIBehurgXp+OKapxwAVDPn+tBdxPE07yY/bOncxwihFBBnb5s+pbkCetbdI1mDJ02C+dNdgcIdp8reMB6NDXTuhPJDxHVpzPKnMKLkj0VRovBnkloipSm8gPLgp8MNEaxzw6uEoKMACdF+pZtHMB4jMhDTY3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866710; c=relaxed/simple;
	bh=fzX9QdUHMfVqyUp8LMONbNp4Wr4hn8wKnpReBWJOVJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDLNzvi6giYK9pvzJCIKy0CtI3QOycZnHdoxBUNLZXGqtWu1Pg47gXlF4scPWNC2s4Aht6dBwBpksj1GouAHsNd+OiV71MSFtU7JV1KJil4QIUAPmr2oyVc5/ujY8YB56gRWz2iqaK7riP8f/+hzAoJAaKlC+KfK2M85gp7zxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Shx6TYO9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Shx6TYO9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5D41F00A3A;
	Tue,  8 Sep 2026 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788866699;
	bh=yazDYPGF74/He2HfY4z5SarPY7lHKoZZ4RLl0CKyvnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Shx6TYO9mvVknBiNeE1awVt5bACs63+IwluoLqEbILXwSV0GnAGg/zCQYguEZPV3/
	 YSG/XwVcfKeoUwCEbzJGinZmaoim/xwflGCpdp7rgDPfytGeAyyqYAlvDnCzqi8s71
	 6gfz67uNjCjekFJZdCUUlBETd6R6NHl2KzziwNV36s6E8G8vqsClpw1qGKheiWo3DH
	 vdZ5VAhLQDMhTw5b+XwH9EF9gP1B7ZYV2M9SehZ9SEnMqNGfTdYxhYnCoDm8SGv8UI
	 ejd8G/zNy67z0o4CVUdfw6j8OtfnbDI6SfkKCtp3qM/Nx/u+BNJ+IdLxGJniUCeuOt
	 vyf/ZI0B/sPCw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 08 Sep 2026 12:23:41 +0100
Subject: [PATCH v2 4/6] mm/vma: make MAP_PRIVATE-mapped /dev/zero mappings
 truly anonymous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-map-private-dev-zero-v2-4-acc7b5625305@kernel.org>
References: <20260908-map-private-dev-zero-v2-0-acc7b5625305@kernel.org>
In-Reply-To: <20260908-map-private-dev-zero-v2-0-acc7b5625305@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8751; i=ljs@kernel.org;
 h=from:subject:message-id; bh=fzX9QdUHMfVqyUp8LMONbNp4Wr4hn8wKnpReBWJOVJ4=;
 b=kA0DAAoWz53NioHifxQByyZiAGqf8HGhBHI1/4E1m+mlBR2WBnzPmZM3BFyoWgm5ixrBuXusp
 4h1BAAWCgAdFiEE5/QXv1IUVp6J0E9Gz53NioHifxQFAmqf8HEACgkQz53NioHifxSYkQD/Zkkv
 vcbHKVb39aHTglqLTcA17mnJTgpVr4MM1HNCObMA/AvlmIqB6vU8C/V4+tHgRqUReLRpOOrMMc4
 TBhcDWPkA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

When mapping /dev/zero with MAP_PRIVATE, one ends up with strange VMAs
originating from Linux's distant past.

These have vma->vm_file set but NULL vma->vm_ops, meaning they satisfy
vma_is_anonymous() but otherwise resemble a file-backed VMA.

The introduction of anonymous page offsets and their subsequent use as
indexes for MAP_PRIVATE-file-backed mappings mean the rmap does the right
thing with these but we are left with inconsistencies.

The vma_start_pgoff(vma) == vma_start_anon_pgoff(vma) invariant is true for
all other anonymous VMAs, but not these.

These VMAs are also observable as files in /proc/<pid>/[maps, smaps,
map_files] but otherwise behave like anonymous mappings.

Therefore let's make these VMAs actually anonymous at mapping time which
will activate the anonymous code path for mappings.

This means we no longer have to account for this discrepancy anywhere and
no longer have to think about these at all.

This is user-observable, as MAP_PRIVATE-/dev/zero will no longer appear in
procfs as a file-backed mapping, but the impact of this change should be
low as likely nobody is relying upon this.

However in any case, in using MAP_PRIVATE-/dev/zero they are explicitly
asking anonymous memory, so no longer seeing these as file mappings is in
fact correct.

A previous commit gave us file_is_dev_zero() to positively identify these
mappings, so we expressly only do so for these alone.

Update assert_sane_pgoff(), the comment for vma_start_pgoff() and
linear_anon_page_index() to reflect the change.

We make this change in call_mmap_prepare() alone as /dev/zero has been
converted to an mmap_prepare hook and we do not permit nested MAP_PRIVATE
mapping of /dev/zero.

We also remove the now defunct vma_desc_set_anonymous() and eliminate the
temporary bisection hazard fix from the previous commit.

Also update the VMA userland tests to reflect the change.

Finally, update the procfs self tests proc-self-map-files-001 and
proc-self-map-files-002 which both intend to map an arbitrary file
MAP_PRIVATE then assert procfs state, but happen to choose /dev/zero.

Fix them by updating these to /proc/self/exe which is guaranteed to be
present if procfs is mounted.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h                                 | 10 ++------
 include/linux/pagemap.h                            |  3 +--
 mm/vma.c                                           | 28 ++++++++++++++--------
 mm/vma.h                                           |  3 ---
 .../selftests/proc/proc-self-map-files-001.c       |  2 +-
 .../selftests/proc/proc-self-map-files-002.c       |  2 +-
 tools/testing/vma/include/dup.h                    |  3 +--
 7 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1b28e6fc8d5d..9238b7d52198 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1539,11 +1539,6 @@ static inline void vma_set_anonymous(struct vm_area_struct *vma)
 	vma->vm_ops = NULL;
 }
 
-static inline void vma_desc_set_anonymous(struct vm_area_desc *desc)
-{
-	desc->vm_ops = NULL;
-}
-
 static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
 {
 	return !vma->vm_ops;
@@ -4405,9 +4400,8 @@ static inline unsigned long vma_pages(const struct vm_area_struct *vma)
  * If @vma is a MAP_PRIVATE file-backed mapping, then this returns the
  * page offset within the file.
  *
- * Edge cases: nommu does not abide by these, MAP_PRIVATE-/dev/zero satisfies
- * vma_is_anonymous() but has file-backed page offset, and MAP_PRIVATE-pfnmap
- * regions have their page offset set to the first PFN in the range.
+ * Edge cases: nommu does not abide by these and CoW MAP_PRIVATE-pfnmap regions
+ * have their page offset set to the first PFN in the range.
  *
  * Returns: The page offset of the start of @vma.
  */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0adfa6605653..939f3a5e973f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1128,8 +1128,7 @@ static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
 	const pgoff_t pgoff = __linear_anon_page_index(vma, address);
 
 	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
-	/* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous. */
-	if (vma_is_anonymous(vma) && !vma->vm_file)
+	if (vma_is_anonymous(vma))
 		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
 
 	return pgoff;
diff --git a/mm/vma.c b/mm/vma.c
index 4b8d430d9619..6fdce4852ce6 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2621,6 +2621,13 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 	return 0;
 }
 
+static void map_set_anon(struct mmap_state *map)
+{
+	map->file = NULL;
+	map->vm_ops = NULL;
+	map->pgoff = map->addr >> PAGE_SHIFT;
+}
+
 static bool map_is_private(const struct mmap_state *map)
 {
 	return !vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
@@ -2628,10 +2635,7 @@ static bool map_is_private(const struct mmap_state *map)
 
 static bool map_is_anon(const struct mmap_state *map)
 {
-	if (!map_is_private(map))
-		return false;
-
-	return !map->file || file_is_dev_zero(map->file);
+	return map_is_private(map) && !map->file;
 }
 
 /*
@@ -2663,7 +2667,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 
 	vma_iter_config(vmi, map->addr, map->end);
 
-	if (is_anon && !map->file)
+	if (is_anon)
 		vma_set_anonymous(vma);
 
 	vma_set_range(vma, map->addr, map->end, map->pgoff, map->anon_pgoff);
@@ -2681,10 +2685,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 	else if (!is_anon)
 		error = shmem_zero_setup(vma);
 
-	/* Temporary MAP_PRIVATE-/dev/zero workaround. */
-	if (is_anon && map->file)
-		vma_set_anonymous(vma);
-
 	if (error)
 		goto free_iter_vma;
 
@@ -2793,7 +2793,7 @@ static int call_mmap_prepare(struct mmap_state *map,
 	if (err)
 		return err;
 
-	/* Hooks cannot mark themselves anonymous. */
+	/* It's invalid for mmap_preprare hooks to clear vm_ops. */
 	if (!desc->vm_ops)
 		return -EINVAL;
 
@@ -2813,6 +2813,14 @@ static int call_mmap_prepare(struct mmap_state *map,
 	map->vm_ops = desc->vm_ops;
 	map->vm_private_data = desc->private_data;
 
+	/*
+	 * MAP_PRIVATE-/dev/zero mappings are an ancient way of getting
+	 * anonymous mappings. Rather than allowing these mappings to be odd
+	 * outliers, simply make them truly anonymous.
+	 */
+	if (map_is_private(map) && file_is_dev_zero(map->file))
+		map_set_anon(map);
+
 	return 0;
 }
 
diff --git a/mm/vma.h b/mm/vma.h
index 024fabe63560..e97bd2dfa786 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -267,9 +267,6 @@ static inline void assert_sane_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
 	 */
 	if (!vma_is_anonymous(vma))
 		return;
-	/* MAP_PRIVATE-/dev/zero is anon, non-NULL vm_file, but has file pgoff. */
-	if (vma->vm_file)
-		return;
 	/* If faulted in, could have been remapped. */
 	if (vma->anon_vma)
 		return;
diff --git a/tools/testing/selftests/proc/proc-self-map-files-001.c b/tools/testing/selftests/proc/proc-self-map-files-001.c
index 4209c64283d6..bbca9f9e2743 100644
--- a/tools/testing/selftests/proc/proc-self-map-files-001.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-001.c
@@ -51,7 +51,7 @@ int main(void)
 	int fd;
 	unsigned long a, b;
 
-	fd = open("/dev/zero", O_RDONLY);
+	fd = open("/proc/self/exe", O_RDONLY);
 	if (fd == -1)
 		return 1;
 
diff --git a/tools/testing/selftests/proc/proc-self-map-files-002.c b/tools/testing/selftests/proc/proc-self-map-files-002.c
index e6aa00a183bc..5786cdffbbf6 100644
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -57,7 +57,7 @@ int main(void)
 	int fd;
 	unsigned long a, b;
 
-	fd = open("/dev/zero", O_RDONLY);
+	fd = open("/proc/self/exe", O_RDONLY);
 	if (fd == -1)
 		return 1;
 
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 0d1a2ac88922..16c09dac59d9 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1635,8 +1635,7 @@ static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
 	const pgoff_t pgoff = __linear_anon_page_index(vma, address);
 
 	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
-	/* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous. */
-	if (vma_is_anonymous(vma) && !vma->vm_file)
+	if (vma_is_anonymous(vma))
 		VM_WARN_ON_ONCE(pgoff != linear_page_index(vma, address));
 
 	return pgoff;

-- 
2.55.0

