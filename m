Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997761FA272;
	Thu, 30 Apr 2026 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777548927; cv=none; b=sZf5nB58+0aFInq8RyuLvlngCxYHeD7bZ4OFRX4wmBciHRznL3yXFBBgD3P1QUX74isVFYRqKwSI1mOoiO6Jjb5evcSl4caFTPO0KkVJTgTLUJRqy6J7QHyi+liPNaCMLXwGNahii6bun5no9gKa4nqmIGBFifuMApjCgRvd/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777548927; c=relaxed/simple;
	bh=bisZnB1OIt5GIX54D6y0n4Kk5oWYXeYGQtm/I2nETOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6p5+sR+O9YfJfUOwQI3Wotvk1G1mrLceDlo5eSBoDO3h8sJd0HIIXtuERS7YUsnHVQ6P0OwzhnqmjpF6cfp1WraRGpf92YrW0fwOU1ZSUeYlxTjmdjnfmxG08CU5V7clc1e8N+aKAvc+W7i1ceq6vr2w0A0saj3064CnixYFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX7NHood; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX7NHood"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127F1C2BCB4;
	Thu, 30 Apr 2026 11:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777548926;
	bh=bisZnB1OIt5GIX54D6y0n4Kk5oWYXeYGQtm/I2nETOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IX7NHoodLLg0dGiTyVYt9H9YfLJOCH4NlBZZzkdOwmyBN6XzfYNywvIAWNfRyEwM8
	 NLLIJQrM8tHvvk+CzwKIIyrGfqAu0yNtZ5r3xF2QwkDfGXPInSTPd8jqiYRPOeE4r+
	 U95kWfcDOBUkGJlmmQqRZepGt/HoiWvKf6Lu3aou7A1WtVK1yP6hgOz9kEjPYb55mw
	 MNBzqVHMMvQygmzCf45orrd6109MeQJemSZkZ9NEhmQAm7241maVM9xm2lfyJkrZ5W
	 XdNABd5FOByoIzzgCabKxA46asJSyutcg4cxltqKk7h5/84IMruzC/1lETnTTw5XWE
	 4NPyQqyYjxW0w==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] userfaultfd: make functions that are not used outside uffd static
Date: Thu, 30 Apr 2026 14:35:12 +0300
Message-ID: <20260430113512.115938-3-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430113512.115938-1-rppt@kernel.org>
References: <20260430113512.115938-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

After merging fs/userfaultfd.c into mm/userfaultfd.c, several functions
that were previously shared between the two files are now only used within
mm/userfaultfd.c.

Make them static and remove their declarations from
include/linux/userfaultfd_k.h.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Assisted-by: Copilot:claude-opus-4-6
---
 include/linux/userfaultfd_k.h | 36 -----------------------------------
 mm/userfaultfd.c              | 24 +++++++++++------------
 2 files changed, 12 insertions(+), 48 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index d2920f98ab86..3ec8e1071673 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -147,26 +147,12 @@ static inline uffd_flags_t uffd_flags_set_mode(uffd_flags_t flags, enum mfill_at
 /* Flags controlling behavior. These behavior changes are mode-independent. */
 #define MFILL_ATOMIC_WP MFILL_ATOMIC_FLAG(0)
 
-extern ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long dst_start,
-				 unsigned long src_start, unsigned long len,
-				 uffd_flags_t flags);
-extern ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
-				     unsigned long dst_start,
-				     unsigned long len);
-extern ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned long dst_start,
-				     unsigned long len, uffd_flags_t flags);
-extern ssize_t mfill_atomic_poison(struct userfaultfd_ctx *ctx, unsigned long start,
-				   unsigned long len, uffd_flags_t flags);
-extern int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
-			       unsigned long len, bool enable_wp);
 extern long uffd_wp_range(struct vm_area_struct *vma,
 			  unsigned long start, unsigned long len, bool enable_wp);
 
 /* move_pages */
 void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
 void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
-ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
-		   unsigned long src_start, unsigned long len, __u64 flags);
 int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
 			struct vm_area_struct *dst_vma,
 			struct vm_area_struct *src_vma,
@@ -239,9 +225,6 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
-bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
-		       bool wp_async);
-
 static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
 {
 	struct userfaultfd_ctx *uffd_ctx = vma->vm_userfaultfd_ctx.ctx;
@@ -271,25 +254,6 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
 extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
 
-void userfaultfd_reset_ctx(struct vm_area_struct *vma);
-
-struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
-					     struct vm_area_struct *prev,
-					     struct vm_area_struct *vma,
-					     unsigned long start,
-					     unsigned long end);
-
-int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
-			       struct vm_area_struct *vma,
-			       vm_flags_t vm_flags,
-			       unsigned long start, unsigned long end,
-			       bool wp_async);
-
-void userfaultfd_release_new(struct userfaultfd_ctx *ctx);
-
-void userfaultfd_release_all(struct mm_struct *mm,
-			     struct userfaultfd_ctx *ctx);
-
 static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
 {
 	/* Only wr-protect mode uses pte markers */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d0cf44aec1c4..f089ffa39722 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -958,7 +958,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	return copied ? copied : err;
 }
 
-ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long dst_start,
+static ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 			  unsigned long src_start, unsigned long len,
 			  uffd_flags_t flags)
 {
@@ -966,7 +966,7 @@ ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 			    uffd_flags_set_mode(flags, MFILL_ATOMIC_COPY));
 }
 
-ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
+static ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
 			      unsigned long start,
 			      unsigned long len)
 {
@@ -974,7 +974,7 @@ ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
 			    uffd_flags_set_mode(0, MFILL_ATOMIC_ZEROPAGE));
 }
 
-ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned long start,
+static ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned long start,
 			      unsigned long len, uffd_flags_t flags)
 {
 
@@ -990,7 +990,7 @@ ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned long start,
 			    uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTINUE));
 }
 
-ssize_t mfill_atomic_poison(struct userfaultfd_ctx *ctx, unsigned long start,
+static ssize_t mfill_atomic_poison(struct userfaultfd_ctx *ctx, unsigned long start,
 			    unsigned long len, uffd_flags_t flags)
 {
 	return mfill_atomic(ctx, start, 0, len,
@@ -1026,7 +1026,7 @@ long uffd_wp_range(struct vm_area_struct *dst_vma,
 	return ret;
 }
 
-int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
+static int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
 			unsigned long len, bool enable_wp)
 {
 	struct mm_struct *dst_mm = ctx->mm;
@@ -1856,7 +1856,7 @@ static void uffd_move_unlock(struct vm_area_struct *dst_vma,
  * in the regions or not, but preventing the risk of having to split
  * the hugepmd during the remap.
  */
-ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
+static ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 		   unsigned long src_start, unsigned long len, __u64 mode)
 {
 	struct mm_struct *mm = ctx->mm;
@@ -2031,7 +2031,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 	return moved ? moved : err;
 }
 
-bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
+static bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 		       bool wp_async)
 {
 	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
@@ -2088,12 +2088,12 @@ static void userfaultfd_set_ctx(struct vm_area_struct *vma,
 				 (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags);
 }
 
-void userfaultfd_reset_ctx(struct vm_area_struct *vma)
+static void userfaultfd_reset_ctx(struct vm_area_struct *vma)
 {
 	userfaultfd_set_ctx(vma, NULL, 0);
 }
 
-struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
+static struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 					     struct vm_area_struct *prev,
 					     struct vm_area_struct *vma,
 					     unsigned long start,
@@ -2132,7 +2132,7 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 }
 
 /* Assumes mmap write lock taken, and mm_struct pinned. */
-int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
+static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 			       struct vm_area_struct *vma,
 			       vm_flags_t vm_flags,
 			       unsigned long start, unsigned long end,
@@ -2196,7 +2196,7 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 	return 0;
 }
 
-void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
+static void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
 {
 	struct mm_struct *mm = ctx->mm;
 	struct vm_area_struct *vma;
@@ -2211,7 +2211,7 @@ void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
 	mmap_write_unlock(mm);
 }
 
-void userfaultfd_release_all(struct mm_struct *mm,
+static void userfaultfd_release_all(struct mm_struct *mm,
 			     struct userfaultfd_ctx *ctx)
 {
 	struct vm_area_struct *vma, *prev;
-- 
2.53.0

