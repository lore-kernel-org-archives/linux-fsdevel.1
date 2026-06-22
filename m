Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE96283FE6
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156083; cv=none; b=fgmC3xJ0GOqN0v4aDk1VFW+k8aSqK0C1dufE5b6V9EsQDcBuNEg46rkecGxjedcrROgL+93Jb8wG1FylWm36qq7kaDW+kb6xbRrxg5DS+CJebn2t0gmt+tBAks5/nCM1tote+vMLv3tzFDNRoGeE/R5AzJA0vyzvuJak4Ekt73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156083; c=relaxed/simple;
	bh=rgbJOVI2391Q9hVpc56QY8HVbIm2fxv4Ot3cC7Xujmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPXfTqJjeDkK98Rj/RS5eowbRWZxwR0iUU/aL/TuQF1nMxlHSHrJeu9fqzge14w1D8yFwO658VVzAYa4QgtvjKjw2fvwqenJvnOUIoFGMuGLfWVnc0P3AgWxy9/aiMPMNJiSPp7mtvgPdJ0lXD6imOFoucIs0c4uJIV7Sq9JVkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bWmq5dLT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bWmq5dLT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=mb90/CtIiKrLnzucDBUG+lbblo8nEGwxt0h8xz1Qh6g=; b=bWmq5dLTJyRiyqaLK70xKmavEZ
	prTvHVJcqTAx57BvHaiDcvLnGsFZLT2m6fyyXSxzCCP+YaCEUz+ke5XlNYtXe5uRdfEEZXRYGvtXm
	+VDWGW1F9ire5hWZ5HHb34e5hL1Wq+SVrITvbWnzk1NqIOlEWUPxLkG1xrC2u9oamxEjuFezMEBfg
	d97Z4+PCIZgi2yuku+u6/To2eFbbsEeZa1gIdbjzosMwpY5FIsOl2yaBQbDn5T8YZnPrg8ep8RMjl
	Rztw2CkVDNaN5fej86IWlSrUeVDD4AkZSj7r4hAxvvwDix9UZxO0lhPhgSszi88zYp0wGAQQd40QH
	1GrvFCGA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbkCq-00000004oS5-3WeB;
	Mon, 22 Jun 2026 19:21:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [RFC PATCH] filemap: Remove file pinning during fault handling
Date: Mon, 22 Jun 2026 20:21:12 +0100
Message-ID: <20260622192114.1147198-1-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that faults are protected by a per-VMA lock instead of a process-wide
mmap lock, it is far less important to avoid holding the fault lock while
performing file reads.  The per-VMA lock does not prevent operations
on other VMAs, nor does it prevent iterating through /proc (see commits
6b4c9f446981 and a75d4c333772 for the original motivations behind dropping
the fault lock).

We will now submit I/O and wait for I/O to complete while holding the
fault lock.  This removes the need to return VM_FAULT_RETRY which means
we won't fall back to the mmap_lock from the VMA lock just because we
had to wait for I/O.

This should result in improved lock contention, although it is possible
that some workloads will find themselves contending on the VMA locks
due to them being held for longer.

Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |   8 +-
 mm/filemap.c            | 167 +++++++++-------------------------------
 2 files changed, 40 insertions(+), 135 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1f50991b43e3..e6ac221ee54d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -695,9 +695,6 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
  * * %FGP_CREAT - If no folio is present then a new folio is allocated,
  *   added to the page cache and the VM's LRU list.  The folio is
  *   returned locked.
- * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
- *   folio is already in cache.  If the folio was allocated, unlock it
- *   before returning so the caller can do the same dance.
  * * %FGP_WRITE - The folio will be written to by the caller.
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
  * * %FGP_NOWAIT - Don't block on the folio lock.
@@ -714,9 +711,8 @@ typedef unsigned int __bitwise fgf_t;
 #define FGP_WRITE		((__force fgf_t)0x00000008)
 #define FGP_NOFS		((__force fgf_t)0x00000010)
 #define FGP_NOWAIT		((__force fgf_t)0x00000020)
-#define FGP_FOR_MMAP		((__force fgf_t)0x00000040)
-#define FGP_STABLE		((__force fgf_t)0x00000080)
-#define FGP_DONTCACHE		((__force fgf_t)0x00000100)
+#define FGP_STABLE		((__force fgf_t)0x00000040)
+#define FGP_DONTCACHE		((__force fgf_t)0x00000080)
 #define FGF_GET_ORDER(fgf)	(((__force unsigned)fgf) >> 26)	/* top 6 bits */
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
diff --git a/mm/filemap.c b/mm/filemap.c
index 7e467c81d213..13a861b38621 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1995,7 +1995,7 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 			gfp &= ~GFP_KERNEL;
 			gfp |= GFP_NOWAIT;
 		}
-		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
+		if (WARN_ON_ONCE(!(fgp_flags & FGP_LOCK)))
 			fgp_flags |= FGP_LOCK;
 
 		if (order > mapping_max_folio_order(mapping))
@@ -2042,12 +2042,6 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 				err = -EAGAIN;
 			return ERR_PTR(err);
 		}
-		/*
-		 * filemap_add_folio locks the page, and for mmap
-		 * we expect an unlocked page.
-		 */
-		if (folio && (fgp_flags & FGP_FOR_MMAP))
-			folio_unlock(folio);
 	}
 
 	if (!folio)
@@ -3259,52 +3253,6 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 
 #ifdef CONFIG_MMU
 #define MMAP_LOTSAMISS  (100)
-/*
- * lock_folio_maybe_drop_mmap - lock the page, possibly dropping the mmap_lock
- * @vmf - the vm_fault for this fault.
- * @folio - the folio to lock.
- * @fpin - the pointer to the file we may pin (or is already pinned).
- *
- * This works similar to lock_folio_or_retry in that it can drop the
- * mmap_lock.  It differs in that it actually returns the folio locked
- * if it returns 1 and 0 if it couldn't lock the folio.  If we did have
- * to drop the mmap_lock then fpin will point to the pinned file and
- * needs to be fput()'ed at a later point.
- */
-static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
-				     struct file **fpin)
-{
-	if (folio_trylock(folio))
-		return 1;
-
-	/*
-	 * NOTE! This will make us return with VM_FAULT_RETRY, but with
-	 * the fault lock still held. That's how FAULT_FLAG_RETRY_NOWAIT
-	 * is supposed to work. We have way too many special cases..
-	 */
-	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
-		return 0;
-
-	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
-	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__folio_lock_killable(folio)) {
-			/*
-			 * We didn't have the right flags to drop the
-			 * fault lock, but all fault_handlers only check
-			 * for fatal signals if we return VM_FAULT_RETRY,
-			 * so we need to drop the fault lock here and
-			 * return 0 if we don't have a fpin.
-			 */
-			if (*fpin == NULL)
-				release_fault_lock(vmf);
-			return 0;
-		}
-	} else
-		__folio_lock(folio);
-
-	return 1;
-}
-
 /*
  * Synchronous readahead happens when we don't even find a page in the page
  * cache at all.  We don't want to perform IO under the mmap sem, so if we have
@@ -3312,13 +3260,12 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
  * that.  If we didn't pin a file then we return NULL.  The file that is
  * returned needs to be fput()'ed when we're done with it.
  */
-static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
+static void do_sync_mmap_readahead(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
 	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
-	struct file *fpin = NULL;
 	vm_flags_t vm_flags = vmf->vma->vm_flags;
 	bool force_thp_readahead = false;
 	unsigned int thp_order = 0;
@@ -3348,15 +3295,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		 * VM_EXEC case below is already intended for random access.
 		 */
 		if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
-			return fpin;
+			return;
 
 		if (!ra->ra_pages)
-			return fpin;
+			return;
 
 		if (vm_flags & VM_SEQ_READ) {
-			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 			page_cache_sync_ra(&ractl, ra->ra_pages);
-			return fpin;
+			return;
 		}
 	}
 
@@ -3371,13 +3317,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		 * stop bothering with read-ahead. It will only hurt.
 		 */
 		if (mmap_miss > MMAP_LOTSAMISS)
-			return fpin;
+			return;
 	}
 
 	if (force_thp_readahead) {
 		unsigned long folio_nr_pages = 1UL << thp_order;
 
-		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		ractl._index &= ~(folio_nr_pages - 1);
 		ra->size = folio_nr_pages;
 		/*
@@ -3389,7 +3334,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		ra->async_size = folio_nr_pages;
 		ra->order = thp_order;
 		page_cache_ra_order(&ractl, ra);
-		return fpin;
+		return;
 	}
 
 	if (vm_flags & VM_EXEC) {
@@ -3427,29 +3372,24 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		ra->order = 0;
 	}
 
-	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	ractl._index = ra->start;
 	page_cache_ra_order(&ractl, ra);
-	return fpin;
 }
 
 /*
- * Asynchronous readahead happens when we find the page and PG_readahead,
- * so we want to possibly extend the readahead further.  We return the file that
- * was pinned if we have to drop the mmap_lock in order to do IO.
+ * Asynchronous readahead happens when we find the folio and it has the
+ * readahead flag set so we want to possibly extend the readahead further.
  */
-static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
-					    struct folio *folio)
+static void do_async_mmap_readahead(struct vm_fault *vmf, struct folio *folio)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
-	struct file *fpin = NULL;
 	unsigned short mmap_miss;
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
-		return fpin;
+		return;
 
 	/*
 	 * If the folio is locked, we're likely racing against another fault.
@@ -3470,10 +3410,8 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 
 	if (folio_test_readahead(folio)) {
 		ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
-		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_ra(&ractl, folio, ra->ra_pages);
 	}
-	return fpin;
 }
 
 static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
@@ -3530,15 +3468,9 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
  * it in the page cache, and handles the special cases reasonably without
  * having a lot of duplicated code.
  *
- * vma->vm_mm->mmap_lock must be held on entry.
- *
- * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
- * may be dropped before doing I/O or by lock_folio_maybe_drop_mmap().
- *
- * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
- * has not been released.
- *
- * We never return with VM_FAULT_RETRY and a bit from VM_FAULT_ERROR set.
+ * Context: May sleep waiting for I/O.  Can be interrupted by fatal
+ * signals if @vmf flags permit.  The caller must hold the fault lock
+ * (either mmap_lock or VMA lock).
  *
  * Return: bitwise-OR of %VM_FAULT_ codes.
  */
@@ -3546,7 +3478,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 {
 	int error;
 	struct file *file = vmf->vma->vm_file;
-	struct file *fpin = NULL;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	pgoff_t max_idx, index = vmf->pgoff;
@@ -3566,15 +3497,31 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	folio = filemap_get_folio(mapping, index);
 	if (likely(!IS_ERR(folio))) {
 		/*
-		 * We found the page, so try async readahead before waiting for
-		 * the lock.
+		 * We found the folio, so try async readahead before
+		 * waiting for the lock.
 		 */
 		if (!(vmf->flags & FAULT_FLAG_TRIED))
-			fpin = do_async_mmap_readahead(vmf, folio);
+			do_async_mmap_readahead(vmf, folio);
 		if (unlikely(!folio_test_uptodate(folio))) {
 			filemap_invalidate_lock_shared(mapping);
 			mapping_locked = true;
 		}
+
+		if (!folio_trylock(folio)) {
+			if (vmf->flags & FAULT_FLAG_KILLABLE) {
+				if (__folio_lock_killable(folio) < 0)
+					return VM_FAULT_SIGBUS;
+			} else {
+				__folio_lock(folio);
+			}
+		}
+
+		/* Did it get truncated? */
+		if (unlikely(folio->mapping != mapping)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			goto retry_find;
+		}
 	} else {
 		ret = filemap_fault_recheck_pte_none(vmf);
 		if (unlikely(ret))
@@ -3584,7 +3531,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
-		fpin = do_sync_mmap_readahead(vmf);
+		do_sync_mmap_readahead(vmf);
 retry_find:
 		/*
 		 * See comment in filemap_create_folio() why we need
@@ -3595,25 +3542,13 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 			mapping_locked = true;
 		}
 		folio = __filemap_get_folio(mapping, index,
-					  FGP_CREAT|FGP_FOR_MMAP,
-					  vmf->gfp_mask);
+					  FGP_CREAT | FGP_LOCK, vmf->gfp_mask);
 		if (IS_ERR(folio)) {
-			if (fpin)
-				goto out_retry;
 			filemap_invalidate_unlock_shared(mapping);
 			return VM_FAULT_OOM;
 		}
 	}
 
-	if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
-		goto out_retry;
-
-	/* Did it get truncated? */
-	if (unlikely(folio->mapping != mapping)) {
-		folio_unlock(folio);
-		folio_put(folio);
-		goto retry_find;
-	}
 	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
 
 	/*
@@ -3625,7 +3560,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		/*
 		 * If the invalidate lock is not held, the folio was in cache
 		 * and uptodate and now it is not. Strange but possible since we
-		 * didn't hold the page lock all the time. Let's drop
+		 * didn't hold the folio lock all the time. Let's drop
 		 * everything, get the invalidate lock and try again.
 		 */
 		if (!mapping_locked) {
@@ -3642,21 +3577,12 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		goto page_not_uptodate;
 	}
 
-	/*
-	 * We've made it this far and we had to drop our mmap_lock, now is the
-	 * time to return to the upper layer and have it re-find the vma and
-	 * redo the fault.
-	 */
-	if (fpin) {
-		folio_unlock(folio);
-		goto out_retry;
-	}
 	if (mapping_locked)
 		filemap_invalidate_unlock_shared(mapping);
 
 	/*
-	 * Found the page and have a reference on it.
-	 * We must recheck i_size under page lock.
+	 * Found the folio and have a reference on it.
+	 * We must recheck i_size under folio lock.
 	 */
 	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 	if (unlikely(index >= max_idx)) {
@@ -3675,10 +3601,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * because there really aren't any performance issues here
 	 * and we need to check for errors.
 	 */
-	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
-	if (fpin)
-		goto out_retry;
 	folio_put(folio);
 
 	if (!error || error == AOP_TRUNCATED_PAGE)
@@ -3686,20 +3609,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	filemap_invalidate_unlock_shared(mapping);
 
 	return VM_FAULT_SIGBUS;
-
-out_retry:
-	/*
-	 * We dropped the mmap_lock, we need to return to the fault handler to
-	 * re-find the vma and come back and find our hopefully still populated
-	 * page.
-	 */
-	if (!IS_ERR(folio))
-		folio_put(folio);
-	if (mapping_locked)
-		filemap_invalidate_unlock_shared(mapping);
-	if (fpin)
-		fput(fpin);
-	return ret | VM_FAULT_RETRY;
 }
 EXPORT_SYMBOL(filemap_fault);
 
-- 
2.47.3

