Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833F30D3FE;
	Mon,  5 Oct 2026 05:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178114; cv=none; b=AtmdiNjdInpEsf2bhiNBnwhg6szZy1wW7PIAypSi0ZboCvIfeBTl0O+GpLn3Cyx599O+WhNc/0+NlnRNwtgIQmFwbvzRYxsCoRax+2YmnVy2wEbhAJ2D5w98Fi3VVk5jbpb2Xcjvge7isYfpEl8T7J/sFS6ZtoYej7W8cDZAH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178114; c=relaxed/simple;
	bh=BSvLA8UYIc7DgC8JwFdwNw9pz+87ezvmuLz6ySurQZ8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cKspjHNJCaxf4ZDJ0+2dc9SUl+0eFUv6GvI3QDqT2Ddnp79PEmQKa+t25RPfY47yQbzu0blqWiDvvgUe3kO+Fj7Nu7T+usSE1K0STkQu4WsJhNZsCHWErI/44Iw7S+Sm8HpVu3TyKguxdvBbzBingD3JUdHMrZ/qx/NJT83F+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J0AUaOTS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J0AUaOTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BC21F000FF;
	Mon,  5 Oct 2026 05:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791178112;
	bh=/AbI6aiQv0q0ubJ9FMKBNe/Rn1IMhw37If5/SzZ9nl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J0AUaOTSJyOUBdnKaYJ27RfHiTmlcQWaqN4uLvpUd73xVbR108/OBQlFMU7hRoYRB
	 GDCSom7+8HiWw58v7h4+9ejEvMC7onVbGWgmfYnv0nkhrQbP6w0E3bV049hQJweae5
	 nayRApGuB1es+0tW69f1/VjhWXm4tuCNJVx9v+cg=
Date: Sun, 4 Oct 2026 22:28:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ayush Ranjan <ayushr@modal.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>,
 Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts
 page cache / rss counters
Message-Id: <20261004222831.bdd648a2b406f02747dd9e40@linux-foundation.org>
In-Reply-To: <20261003033107.1488699-1-ayushr@modal.com>
References: <20260924061708.1645968-1-ayushr@modal.com>
	<arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
	<20260925053027.1998394-1-ayushr@modal.com>
	<20260925065013.3682431-1-ayushr@modal.com>
	<20261003033107.1488699-1-ayushr@modal.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 03:31:03 +0000 Ayush Ranjan <ayushr@modal.com> wrote:

> Hi all,
> 
> Gentle ping on this. The reproducer in my previous mail [1] triggers
> "Bad page cache ... still mapped when deleted" on 6.18.46 within a
> couple of minutes on a 128-CPU bare-metal box, with no fork() and no
> gVisor involved.
> 
> We continue to hit this in production at low frequency, so I am happy
> to test patches or collect more data if that would help.
> 

fwiw I made gpt and gemini argue about this for a while and ended up
with the below.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm: shmem: serialize fault-around against hole punching
Date: Sun Oct 4 09:05:31 PM PDT 2026

shmem uses filemap_map_pages() for fault-around.  Unlike shmem_fault(),
filemap_map_pages() does not participate in shmem's fallocate exclusion
protocol.

During a partial hole punch of a large shmem folio, the folio can be split
and the resulting smaller folios can remain temporarily visible in the page
cache while shmem_undo_range() restarts its walk.  Fault-around can then map
one of those folios again before the hole-punch path removes it.

shmem_undo_range() may subsequently delete that folio from the page cache
despite the new userspace mapping.  This can trigger "still mapped when
deleted" warnings and leave stale mappings or inconsistent RSS/page-table
accounting behind.

The race dates back to d7c1755179b8 ("mm: implement ->map_pages for
shmem/tmpfs"), which enabled generic fault-around for shmem without making
it participate in shmem's hole-punch exclusion protocol.

Serialize shmem fault-around against the hole-punch unmap/truncate sequence
with mapping->invalidate_lock.  The hole-punch side holds the lock
exclusively while unmapping and removing pages.

do_fault_around() invokes ->map_pages() under rcu_read_lock(), so the
fault-around side cannot block on invalidate_lock.  Use the shared trylock
instead.  If the trylock fails, skip fault-around and let the normal shmem
fault path handle the fault.  Otherwise hold the shared lock while
filemap_map_pages() installs mappings.

This preserves fault-around in the uncontended case while ensuring that
pages in a punched range cannot be remapped between unmap_mapping_range()
and shmem_truncate_range().

Fixes: d7c1755179b8 ("mm: implement ->map_pages for shmem/tmpfs")
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/shmem.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

--- a/mm/shmem.c~a
+++ a/mm/shmem.c
@@ -2938,6 +2938,27 @@ static vm_fault_t shmem_fault(struct vm_
 	return ret;
 }
 
+/*
+ * A hole punch can temporarily leave split folios visible in the page cache
+ * after it has unmapped the range.  Do not let fault-around map them again
+ * before shmem_truncate_range() removes them.  ->map_pages() runs under
+ * rcu_read_lock(), so this exclusion must be non-blocking.
+ */
+static vm_fault_t shmem_map_pages(struct vm_fault *vmf,
+				  pgoff_t start_pgoff, pgoff_t end_pgoff)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	vm_fault_t ret;
+
+	if (!filemap_invalidate_trylock_shared(mapping))
+		return 0;
+
+	ret = filemap_map_pages(vmf, start_pgoff, end_pgoff);
+	filemap_invalidate_unlock_shared(mapping);
+
+	return ret;
+}
+
 unsigned long shmem_get_unmapped_area(struct file *file,
 				      unsigned long uaddr, unsigned long len,
 				      unsigned long pgoff, unsigned long flags)
@@ -3865,10 +3886,12 @@ static long shmem_fallocate(struct file
 		WRITE_ONCE(inode->i_private, &shmem_falloc);
 		spin_unlock(&inode->i_lock);
 
+		filemap_invalidate_lock(mapping);
 		if ((u64)unmap_end > (u64)unmap_start)
 			unmap_mapping_range(mapping, unmap_start,
 					    1 + unmap_end - unmap_start, 0);
 		shmem_truncate_range(inode, offset, offset + len - 1);
+		filemap_invalidate_unlock(mapping);
 		/* No need to unmap again: hole-punching leaves COWed pages */
 
 		spin_lock(&inode->i_lock);
@@ -5467,7 +5490,7 @@ static const struct super_operations shm
 
 static const struct vm_operations_struct shmem_vm_ops = {
 	.fault		= shmem_fault,
-	.map_pages	= filemap_map_pages,
+	.map_pages	= shmem_map_pages,
 #ifdef CONFIG_NUMA
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
@@ -5479,7 +5502,7 @@ static const struct vm_operations_struct
 
 static const struct vm_operations_struct shmem_anon_vm_ops = {
 	.fault		= shmem_fault,
-	.map_pages	= filemap_map_pages,
+	.map_pages	= shmem_map_pages,
 #ifdef CONFIG_NUMA
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
_

