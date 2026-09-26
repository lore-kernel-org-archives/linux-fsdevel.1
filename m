Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12B4119FD;
	Sat, 26 Sep 2026 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419300; cv=none; b=b/xE6aLeglNB8QVEy5qLtnjinA/QIZDB1AsBeABO1tHF1LGN9aycq6GkDYxEfKcS/7Rw9UUtsUKAtzTCTdLxUvtCnAUb4vpGdo0mBXw/RprlXYS3lzGB45vcVKBoF4helds9CujzCD9Tvdto7iZ4wY8blrWi/OE8epl19Fz7mVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419300; c=relaxed/simple;
	bh=aOsfkFmD7VJF69fCCB5+yUEH7yaQfQ8RDJypeDOlFt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YemvY3mcSDcxzwFdB6vgaF4qAVqsJ6QnsKeBEgyCahdsksPPS0ktq+Mo9KhcJKt8NKVtR4n2Fdgu0C1xsttediXwKJR2pUyvOosa6RYwxLmj3ffq5GbbjkFhzsJ+VUqQFA89nOtKO93kijIOAh2Z8XABkrzE68eyr10n5djHIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWss9Tur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWss9Tur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09E11F00899;
	Sat, 26 Sep 2026 10:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790419296;
	bh=HMfrQRBnrLeg+i++dUHcC4nFQRW2Nco6Um9SNVy3z0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YWss9TurLVblfmFBXSd9AGmes3IWDon3lgcl2MuRkhPFctXdHvAY/TlIOUzJekG6O
	 pqvqixouOv97YRUycQ2kYvjlTMKu6E8KIMOGCu6kBA0xnHY4gdqpwm8K0szdWqSAYt
	 k71SqyBnLUd7JOx5XeP4bNN7/hl4cfzZes6R2rF1jADJkE4KBnaPVFls10psA5BZ7G
	 zIMx/OSg0UondCCzH6/jyMw2KNR8OMgCfin1wG9ThTf/KbgwpxX++j4XxPqPrIsAAw
	 qVX2nx9LM69Zp6bEMyemnEYqFXOfpq/uMMMLSampQ/o2PWRsVTuJPX8536JP+06CHX
	 XLAasVshLnfuQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 11:41:08 +0100
Subject: [PATCH v3 3/6] mm/vma: only permit MAP_PRIVATE /dev/zero to be
 mapped anonymous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-map-private-dev-zero-v3-3-d4781e84ccfc@kernel.org>
References: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
In-Reply-To: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6825; i=ljs@kernel.org;
 h=from:subject:message-id; bh=aOsfkFmD7VJF69fCCB5+yUEH7yaQfQ8RDJypeDOlFt0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2L/ThZNv1qmvGupU+HG8OtE6dyBHow9fN0aN+dqeaa
 u/Gc4tCO0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCR2U0M/9POTlf0Nfq8dnbU
 cpuT2RduHeo/6rDjSHR1q2n64llH7GsY/uceWKi6ri3pj8KbKUe/rAm7PX3fAivVp2+WPohj6Ku
 TaOIBAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

In order to use mmap_prepare() with MAP_PRIVATE mappings of /dev/zero
without the success_hook hack we explicitly permitted mmap_prepare handlers
to set NULL vm_ops.

However this is dangerous and we really only want to allow this for
MAP_PRIVATE-mapped /dev/zero.

Therefore use the newly introduced file_is_dev_zero() to uniquely identify
MAP_PRIVATE-/dev/zero mappings and only permit this behaviour for them.

Then, remove all ability for mmap_prepare or mmap hooks to set a VMA
anonymous and update mmap_zero_prepare() to leave it to the core mmap code
to do so.

Note that this disallows nested MAP_PRIVATE-mappings of /dev/zero
regions. Doing this would be broken in any case.

We therefore do not need to update the mmap_prepare() compatibility layer
to reflect these changes, as the mmap hook check suffices to disallow this
behaviour.

Now we're setting vma->vm_ops to NULL for an mmap_prepare-initialised
MAP_PRIVATE-/dev/zero mapping, we have to avoid a subtle issue when
updating user-defined fields via set_vma_user_defined_fields().

The default for vma->vm_ops for all mmap_prepare-initialised mappings is
vma_dummy_vm_ops, so map->vm_ops will be set to this and setting
vma->vm_ops to this will render the VMA mistakenly non-anon.

In general, we should never be setting user-defined fields for an anonymous
VMA, so explicitly check for this to avoid doing so for the one case where
a mapping can be both mmap_prepare and anonymous.

In the case of legacy ->mmap hooks some drivers may set vma->vm_ops NULL
believing this is the equivalent of setting no VMA operations. Therefore
update mmap_file() to correct this by setting dummy VMA operations if this
occurs.

An example of this is drm_gem_shmem_mmap() which deliberately clears
vma->vm_ops before handing the VMA to dma-buf. Cases such as this will be
updated when they are converted to mmap_prepare.

Also, in order to avoid a single commit bisection hazard, add a temporary
workaround to set the VMA anonymous only after vma->vm_file is assigned in
__mmap_new_file_vma().

This is because vma_set_range() calls vma_set_pgoff() and
assert_sane_pgoff() in turn, prior to the vma->vm_file being assigned. If
we set the VMA anonymous early then this assert will fail.

This is removed in the subsequent commit.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/char-mem.c |  6 +-----
 mm/internal.h | 17 ++++++++++-------
 mm/vma.c      | 33 +++++++++++++++++++++++++--------
 3 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/mm/char-mem.c b/mm/char-mem.c
index e53e89e6ddd8..c0b5fb019223 100644
--- a/mm/char-mem.c
+++ b/mm/char-mem.c
@@ -508,11 +508,7 @@ static int mmap_zero_prepare(struct vm_area_desc *desc)
 	if (vma_desc_test(desc, VMA_SHARED_BIT))
 		return shmem_zero_setup_desc(desc);
 
-	/*
-	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
-	 * of /dev/zero anonymous, despite it not being.
-	 */
-	vma_desc_set_anonymous(desc);
+	/* MAP_PRIVATE semantics are taken care of for us by core mm. */
 	return 0;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 5d474e5f7709..da14c56fb24e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -226,15 +226,18 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 {
 	int err = vfs_mmap(file, vma);
 
-	if (likely(!err))
-		return 0;
-
 	/*
-	 * OK, we tried to call the file hook for mmap(), but an error
-	 * arose. The mapping is in an inconsistent state and we must not invoke
-	 * any further hooks on it.
+	 * Either we tried to call the file hook for mmap() and an error arose
+	 * or a driver set vma->vm_ops = NULL intending there to be no VMA
+	 * operations.
+	 *
+	 * In the former case the VMA is in an inconsistent state and we mustn't
+	 * invoke any further hooks on it, in the latter case the hook actually
+	 * wanted no further hooks to be invoked, so fix both by setting dummy
+	 * VMA ops.
 	 */
-	vma->vm_ops = &vma_dummy_vm_ops;
+	if (unlikely(err || !vma->vm_ops))
+		vma->vm_ops = &vma_dummy_vm_ops;
 
 	return err;
 }
diff --git a/mm/vma.c b/mm/vma.c
index 35e7a64855fa..a31942c0ad2a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2621,6 +2621,19 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 	return 0;
 }
 
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
+	return !map->file || file_is_dev_zero(map->file);
+}
+
 /*
  * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
  * possible.
@@ -2634,8 +2647,7 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 	struct mmap_action *action)
 {
-	const bool is_anon = !map->file &&
-		!vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
+	const bool is_anon = map_is_anon(map);
 	struct vma_iterator *vmi = map->vmi;
 	int error = 0;
 	struct vm_area_struct *vma;
@@ -2651,7 +2663,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 
 	vma_iter_config(vmi, map->addr, map->end);
 
-	if (is_anon)
+	if (is_anon && !map->file)
 		vma_set_anonymous(vma);
 
 	vma_set_range(vma, map->addr, map->end, map->pgoff, map->anon_pgoff);
@@ -2669,6 +2681,10 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 	else if (!is_anon)
 		error = shmem_zero_setup(vma);
 
+	/* Temporary MAP_PRIVATE-/dev/zero workaround. */
+	if (is_anon && map->file)
+		vma_set_anonymous(vma);
+
 	if (error)
 		goto free_iter_vma;
 
@@ -2777,6 +2793,10 @@ static int call_mmap_prepare(struct mmap_state *map,
 	if (err)
 		return err;
 
+	/* It's invalid for mmap_prepare hooks to clear vm_ops. */
+	if (!desc->vm_ops)
+		return -EINVAL;
+
 	err = call_action_prepare(map, desc);
 	if (err)
 		return err;
@@ -2799,10 +2819,7 @@ static int call_mmap_prepare(struct mmap_state *map,
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
 
@@ -2882,7 +2899,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		allocated_new = true;
 	}
 
-	if (have_mmap_prepare)
+	if (have_mmap_prepare && !map_is_anon(&map))
 		set_vma_user_defined_fields(vma, &map);
 
 	__mmap_complete(&map, vma);

-- 
2.55.0

