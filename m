Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A43446A7
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160983; cv=none; b=LsUWSO2CEmI2M9C+XJkqci4va0SRTvof7uclQJaolAjb7Ag1nuALDFfzk5cz+6RAHj4rW/nibOK4OmCWuxCk3krCQXQJ4jMmon285y6v+qerIIcQkh8gDhzPTyzoU7HGoSKHqPi3LcLaFXIFsPKBsD1b/Zfd8X8CIrhnUqiI5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160983; c=relaxed/simple;
	bh=MDPsUYt9jcFfwcf2/fJgKLKuox7vR3+0OZiXYVfUA3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQmhEcwPBZfKroTTyTLxNRlnZl2VL4tCbBP2hAnlidVRkeFMEmfEe3KHAYBXUumNLa1b74uSYbAcDlucKjASLWm/dh3qtTaofbqK1RcJCRy0nqdcoTHDTLk26/owzmL4eHm4sAJyWGoqvohRXC/bGCDlIvf2sm0UOB1Qf1wHjec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hvm1wCYF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hvm1wCYF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=wDNRfPxJom4hwsr7iqZFKVTpaM6PKM4/de7U0/6GInE=; b=hvm1wCYFnu8/Rd8MtVtJDr42eK
	//PqD0gajPbMoJiL6FmMigqjcPInZJngSMv02KGSMFiG3EIknnqo+et668PXhsySRRkbYAU7AG/GT
	ftWmQwotkrcPhlnVCdcI3l6mb4AxTkxhrmDw7MrYRcy0L/g+NCWyn6xO2rnmFuVv4mT4/eXLpD9Kt
	ET/V7kQ4De/vP86WVD2NoebVqVY4g+40lDAYG2L37s6YnPoN5D8H7P+V49rmwx/GyBsMHimsylpMQ
	fBNyOrjL6dt7JOzxiEVaxkmYG5Ipx4hQhz0Fn4bIoRmSMEljmMWTZwjMLWnHzLqjQcbg7hstDenx+
	VFh0JLrw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblTs-00000004uRw-1lzS;
	Mon, 22 Jun 2026 20:42:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [RFC PATCH] shmem: Use invalidate_lock instead of shmem_falloc
Date: Mon, 22 Jun 2026 21:42:47 +0100
Message-ID: <20260622204250.1170280-1-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Block based filesystems also need to exclude fallocate against page
faults (and other activities).  Since commit 730633f0b7f9, we've had
a centralised invalidate_lock for this purpose.  Convert shmem to use
this rwsem instead of its custom shmem_falloc exclusion mechanism.

I may well have missed some subtleties here; I do not understand the
shmem_falloc mechanism in its entirety.  It's certainly a more
coarse-grained solution than shmem_falloc, but maybe it is enough.

Cc: Jan Kara <jack@suse.cz>
Cc: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/shmem.c | 167 +++++------------------------------------------------
 1 file changed, 14 insertions(+), 153 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b51f83c970bb..5d0942cbb717 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -97,19 +97,6 @@ static struct vfsmount *shm_mnt __ro_after_init;
 /* Symlink up to this size is kmalloc'ed instead of using a swappable page */
 #define SHORT_SYMLINK_LEN 128
 
-/*
- * shmem_fallocate communicates with shmem_fault or shmem_writeout via
- * inode->i_private (with i_rwsem making sure that it has only one user at
- * a time): we would prefer not to enlarge the shmem inode just for that.
- */
-struct shmem_falloc {
-	wait_queue_head_t *waitq; /* faults into hole wait for punch to end */
-	pgoff_t start;		/* start of range currently being fallocated */
-	pgoff_t next;		/* the next page offset to be fallocated */
-	pgoff_t nr_falloced;	/* how many new pages have been fallocated */
-	pgoff_t nr_unswapped;	/* how often writeout refused to swap out */
-};
-
 struct shmem_options {
 	unsigned long long blocks;
 	unsigned long long inodes;
@@ -1650,31 +1637,15 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 	 * value into swapfile.c, the only way we can correctly account for a
 	 * fallocated folio arriving here is now to initialize it and write it.
 	 *
-	 * That's okay for a folio already fallocated earlier, but if we have
-	 * not yet completed the fallocation, then (a) we want to keep track
-	 * of this folio in case we have to undo it, and (b) it may not be a
-	 * good idea to continue anyway, once we're pushing into swap.  So
-	 * reactivate the folio, and let shmem_fallocate() quit when too many.
+	 * We have to prevent racing with fallocate, so just block until it's
+	 * done.
 	 */
 	if (!folio_test_uptodate(folio)) {
-		if (inode->i_private) {
-			struct shmem_falloc *shmem_falloc;
-			spin_lock(&inode->i_lock);
-			shmem_falloc = inode->i_private;
-			if (shmem_falloc &&
-			    !shmem_falloc->waitq &&
-			    index >= shmem_falloc->start &&
-			    index < shmem_falloc->next)
-				shmem_falloc->nr_unswapped += nr_pages;
-			else
-				shmem_falloc = NULL;
-			spin_unlock(&inode->i_lock);
-			if (shmem_falloc)
-				goto redirty;
-		}
+		filemap_invalidate_lock_shared(mapping);
 		folio_zero_range(folio, 0, folio_size(folio));
 		flush_dcache_folio(folio);
 		folio_mark_uptodate(folio);
+		filemap_invalidate_unlock_shared(mapping);
 	}
 
 	if (!folio_alloc_swap(folio)) {
@@ -2610,98 +2581,23 @@ int shmem_get_folio(struct inode *inode, pgoff_t index, loff_t write_end,
 }
 EXPORT_SYMBOL_GPL(shmem_get_folio);
 
-/*
- * This is like autoremove_wake_function, but it removes the wait queue
- * entry unconditionally - even if something else had already woken the
- * target.
- */
-static int synchronous_wake_function(wait_queue_entry_t *wait,
-			unsigned int mode, int sync, void *key)
-{
-	int ret = default_wake_function(wait, mode, sync, key);
-	list_del_init(&wait->entry);
-	return ret;
-}
-
-/*
- * Trinity finds that probing a hole which tmpfs is punching can
- * prevent the hole-punch from ever completing: which in turn
- * locks writers out with its hold on i_rwsem.  So refrain from
- * faulting pages into the hole while it's being punched.  Although
- * shmem_undo_range() does remove the additions, it may be unable to
- * keep up, as each new page needs its own unmap_mapping_range() call,
- * and the i_mmap tree grows ever slower to scan if new vmas are added.
- *
- * It does not matter if we sometimes reach this check just before the
- * hole-punch begins, so that one fault then races with the punch:
- * we just need to make racing faults a rare case.
- *
- * The implementation below would be much simpler if we just used a
- * standard mutex or completion: but we cannot take i_rwsem in fault,
- * and bloating every shmem inode for this unlikely case would be sad.
- */
-static vm_fault_t shmem_falloc_wait(struct vm_fault *vmf, struct inode *inode)
-{
-	struct shmem_falloc *shmem_falloc;
-	struct file *fpin = NULL;
-	vm_fault_t ret = 0;
-
-	spin_lock(&inode->i_lock);
-	shmem_falloc = inode->i_private;
-	if (shmem_falloc &&
-	    shmem_falloc->waitq &&
-	    vmf->pgoff >= shmem_falloc->start &&
-	    vmf->pgoff < shmem_falloc->next) {
-		wait_queue_head_t *shmem_falloc_waitq;
-		DEFINE_WAIT_FUNC(shmem_fault_wait, synchronous_wake_function);
-
-		ret = VM_FAULT_NOPAGE;
-		fpin = maybe_unlock_mmap_for_io(vmf, NULL);
-		shmem_falloc_waitq = shmem_falloc->waitq;
-		prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
-				TASK_UNINTERRUPTIBLE);
-		spin_unlock(&inode->i_lock);
-		schedule();
-
-		/*
-		 * shmem_falloc_waitq points into the shmem_fallocate()
-		 * stack of the hole-punching task: shmem_falloc_waitq
-		 * is usually invalid by the time we reach here, but
-		 * finish_wait() does not dereference it in that case;
-		 * though i_lock needed lest racing with wake_up_all().
-		 */
-		spin_lock(&inode->i_lock);
-		finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
-	}
-	spin_unlock(&inode->i_lock);
-	if (fpin) {
-		fput(fpin);
-		ret = VM_FAULT_RETRY;
-	}
-	return ret;
-}
-
 static vm_fault_t shmem_fault(struct vm_fault *vmf)
 {
-	struct inode *inode = file_inode(vmf->vma->vm_file);
-	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
+	struct file *file = vmf->vma->vm_file;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = file_inode(file);
+	gfp_t gfp = mapping_gfp_mask(mapping);
 	struct folio *folio = NULL;
 	vm_fault_t ret = 0;
 	int err;
 
-	/*
-	 * Trinity finds that probing a hole which tmpfs is punching can
-	 * prevent the hole-punch from ever completing: noted in i_private.
-	 */
-	if (unlikely(inode->i_private)) {
-		ret = shmem_falloc_wait(vmf, inode);
-		if (ret)
-			return ret;
-	}
+	/* Exclude fallocate */
+	filemap_invalidate_lock_shared(mapping);
 
 	WARN_ON_ONCE(vmf->page != NULL);
 	err = shmem_get_folio_gfp(inode, vmf->pgoff, 0, &folio, SGP_CACHE,
 				  gfp, vmf, &ret);
+	filemap_invalidate_unlock_shared(mapping);
 	if (err)
 		return vmf_error(err);
 	if (folio) {
@@ -3600,7 +3496,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	struct inode *inode = file_inode(file);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_falloc shmem_falloc;
 	pgoff_t start, index, end, undo_fallocend;
 	int error;
 
@@ -3608,6 +3503,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
+	filemap_invalidate_lock(inode->i_mapping);
 
 	if (info->flags & SHMEM_F_MAPPING_FROZEN) {
 		error = -EPERM;
@@ -3618,7 +3514,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		struct address_space *mapping = file->f_mapping;
 		loff_t unmap_start = round_up(offset, PAGE_SIZE);
 		loff_t unmap_end = round_down(offset + len, PAGE_SIZE) - 1;
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(shmem_falloc_waitq);
 
 		/* protected by i_rwsem */
 		if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
@@ -3626,24 +3521,12 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			goto out;
 		}
 
-		shmem_falloc.waitq = &shmem_falloc_waitq;
-		shmem_falloc.start = (u64)unmap_start >> PAGE_SHIFT;
-		shmem_falloc.next = (unmap_end + 1) >> PAGE_SHIFT;
-		spin_lock(&inode->i_lock);
-		inode->i_private = &shmem_falloc;
-		spin_unlock(&inode->i_lock);
-
 		if ((u64)unmap_end > (u64)unmap_start)
 			unmap_mapping_range(mapping, unmap_start,
 					    1 + unmap_end - unmap_start, 0);
 		shmem_truncate_range(inode, offset, offset + len - 1);
 		/* No need to unmap again: hole-punching leaves COWed pages */
 
-		spin_lock(&inode->i_lock);
-		inode->i_private = NULL;
-		wake_up_all(&shmem_falloc_waitq);
-		WARN_ON_ONCE(!list_empty(&shmem_falloc_waitq.head));
-		spin_unlock(&inode->i_lock);
 		error = 0;
 		goto out;
 	}
@@ -3666,15 +3549,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		goto out;
 	}
 
-	shmem_falloc.waitq = NULL;
-	shmem_falloc.start = start;
-	shmem_falloc.next  = start;
-	shmem_falloc.nr_falloced = 0;
-	shmem_falloc.nr_unswapped = 0;
-	spin_lock(&inode->i_lock);
-	inode->i_private = &shmem_falloc;
-	spin_unlock(&inode->i_lock);
-
 	/*
 	 * info->fallocend is only relevant when huge pages might be
 	 * involved: to prevent split_huge_page() freeing fallocated
@@ -3696,8 +3570,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		 */
 		if (fatal_signal_pending(current))
 			error = -EINTR;
-		else if (shmem_falloc.nr_unswapped > shmem_falloc.nr_falloced)
-			error = -ENOMEM;
 		else
 			error = shmem_get_folio(inode, index, offset + len,
 						&folio, SGP_FALLOC);
@@ -3709,7 +3581,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 				    (loff_t)start << PAGE_SHIFT,
 				    ((loff_t)index << PAGE_SHIFT) - 1, true);
 			}
-			goto undone;
+			goto out;
 		}
 
 		/*
@@ -3722,14 +3594,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		if (!index)
 			index--;
 
-		/*
-		 * Inform shmem_writeout() how far we have reached.
-		 * No need for lock or barrier: we have the page lock.
-		 */
-		if (!folio_test_uptodate(folio))
-			shmem_falloc.nr_falloced += index - shmem_falloc.next;
-		shmem_falloc.next = index;
-
 		/*
 		 * If !uptodate, leave it that way so that freeable folios
 		 * can be recognized if we need to rollback on error later.
@@ -3745,11 +3609,8 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
 		i_size_write(inode, offset + len);
-undone:
-	spin_lock(&inode->i_lock);
-	inode->i_private = NULL;
-	spin_unlock(&inode->i_lock);
 out:
+	filemap_invalidate_unlock(inode->i_mapping);
 	if (!error)
 		file_modified(file);
 	inode_unlock(inode);
-- 
2.47.3

