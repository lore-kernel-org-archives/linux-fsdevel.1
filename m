Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A222F0C7E;
	Tue, 28 Apr 2026 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341685; cv=none; b=A56KG1wfWJRYnZLMcPBowlK3tZKMNv4Ft6ka6DxMqiQtNq8hLcZCkXoHp8sKhFd+4u60ZI6wjSb/0i5duxGbFodd+GWBeClzgIHYF/H2aiKpPZhbXNFOvedsZTzN5gQEdovfvzjoUJiwJsW3y5g5Rs4s+04TClV9SCj721IlcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341685; c=relaxed/simple;
	bh=ON/LTOfd7N6SGxxokcY690rP8hmyvvroPukLShq4gbM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CFSGE0OgNbDP8H4H0+6xBlQ02izY8Fzc7PnpYJko4uCOHn2gdpRSPSwbhGmVWGtab5NSvvWjVWp99T7mumROn5yNbBVcrO9jGz7f1uBjsOPNI1Ys0NlPhuwyEumQUuXeuIOLBjSQ1zlLx9vbW6l/2C6JNaWLQ6t0te7DAnf2ULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZyljiXWj; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZyljiXWj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777341675; bh=tIhs7KOvtXPo+KkXEuH+z18wnhpzKdZNCS4mhfcCYpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZyljiXWjxzcWDXYnuLfqkjtHOSnOEGjUElfofq5T9OIsuugZtZRcgsIcGgw1aCi44
	 Oj8ip+e3A6kP2hq6vvMvxAzWy4iqbWzs2uiUT5w1V/Y7RMYDP+Tgy7gEb0RlMMSULf
	 yeQNxjOnZtaJTNo5IE/d5FD9rOb+IK3YLbLZlFOU=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id EEC31E8E; Tue, 28 Apr 2026 09:59:44 +0800
X-QQ-mid: xmsmtpt1777341584trxdbo8fy
Message-ID: <tencent_756F151FE66F3D80479A6F982C0AB8569F09@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLTfXYCCGR5SAhhLKp9mXDAazq3Jm4W2Gih1xXMIJvi8FfKsm264
	 FvQf9c1Rf9lvGbCXsPriH1nRSJLJmv47yjTvKc7EDhV0JuVrMqN6irIQ6jLG7C7bQ2wj8dJ+EgEd
	 +wU7CrTCsjM4efSqVW4iX7B16tAyIR7nXszBrRLQ/BTp585FzovFE/ZHel7ufmUSk5DcNbZeNx7G
	 sB6Z0EMRlHAbAiy1eTKbT0HebCR7txFyrbQSyVLXzVTjOgQ0ANVDh9Z7mwbD0m+qAFosN7zhmDe6
	 uywres83J8U1WcLlaS/FzZ1CTLxm7bYOu83vx6cSac5ukQh8QK2Tlql86rbZ7GYyxA0l2+rzN7WZ
	 3zAzQ7FZOhsiEfjl3uerOi3/B5vteaHVsY1ml2c5nRcR3QqnGok2hIz0SBqCjZrbwC/5CpX9UXbT
	 xq/9DMpOoHbXGZFZuKZOirx1E05lQoKxZ1JD0Vi3xTwxqlh4DHKHylQyUICJg0N0upc8V/Juyr4z
	 OR+KZ+t7JXMuSdrbb3ZKDoVNSPWrwR+ARdH6Scvf64Kw3hwdSxAIgBoPWP8xdb/w0hfDP0v4CaRb
	 rRbaL+IVaHy5DCXaGJD9jc7oa80JOoJYJ1rRBRSBKFUj8k5+Abqxf2QPZ/v+RBipnQF3MtnaANFp
	 Pl+1uLVe24Yp1HDWhAf7d2YhwddbHYGAXC8DeZ55f8+nNtrkPnZAo74V33QqtIwaCXK4uI0y2udk
	 F8L9RliIIA9jy5maut1Jr3QGmU7+p2EuXxKGGBoh5fkA6UuknrzhO4gPPJ/fDGY6ozAu5zAY7cvh
	 fZRosb/SYXhtwsi5u1U90yoaaBTqIUd54x2KieHt3Hte74HXv+0UjlVkk1oUwWOMPQmsDVvfD1wf
	 PnqC/fRzhA32I03csPc2QUDF1GVdE7AS4AznbN+C35OmmjwxZNS+FoF4WI6YCvwceql8HfmTa1Es
	 puDDH0lzLArfgOqBa/naffSCM81CGsqVbKoFxXMy12+Z/nSFny4ecBqQySI+ILH4d3hgpqqm5MSX
	 XdwqUsfg2refeFismyJ4U8E/56tIKeXEsuCvpdy4zskOgO5nR1Phvufnwtb4CxRhpa19SDGE+cbz
	 pdQfWB
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: fujunjie <fujunjie1@qq.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Haoran Zhu <zhr1502@sjtu.edu.cn>
Subject: [PATCH v3 1/2] mm/filemap: count only the faulting address as a mmap hit
Date: Tue, 28 Apr 2026 01:59:43 +0000
X-OQ-MSGID: <20260428015944.2601099-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_AA501E9A238337BD167E5C2ACF948A1AF308@qq.com>
References: <tencent_AA501E9A238337BD167E5C2ACF948A1AF308@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

filemap_map_pages() reduces file->f_ra.mmap_miss when fault-around maps
folios that are already present in the page cache.  That hit accounting
is too generous because fault-around can install PTEs around the
faulting address even though the fault only proves that the faulting
address was accessed.

Move the mmap_miss update back into filemap_map_pages(), drop the
mmap_miss argument from the helper functions, and decrement mmap_miss
only when the helper return value shows that the faulting address was
mapped.  Keep the existing workingset-folio behavior unchanged.

Signed-off-by: fujunjie <fujunjie1@qq.com>
---
 mm/filemap.c | 62 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c1..543e51c32397 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3747,8 +3747,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			struct folio *folio, unsigned long start,
 			unsigned long addr, unsigned int nr_pages,
-			unsigned long *rss, unsigned short *mmap_miss,
-			pgoff_t file_end)
+			unsigned long *rss, pgoff_t file_end)
 {
 	struct address_space *mapping = folio->mapping;
 	unsigned int ref_from_caller = 1;
@@ -3780,16 +3779,6 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		if (PageHWPoison(page + count))
 			goto skip;
 
-		/*
-		 * If there are too many folios that are recently evicted
-		 * in a file, they will probably continue to be evicted.
-		 * In such situation, read-ahead is only a waste of IO.
-		 * Don't decrease mmap_miss in this scenario to make sure
-		 * we can stop read-ahead.
-		 */
-		if (!folio_test_workingset(folio))
-			(*mmap_miss)++;
-
 		/*
 		 * NOTE: If there're PTE markers, we'll leave them to be
 		 * handled in the specific fault path, and it'll prohibit the
@@ -3836,7 +3825,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 
 static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 		struct folio *folio, unsigned long addr,
-		unsigned long *rss, unsigned short *mmap_miss)
+		unsigned long *rss)
 {
 	vm_fault_t ret = 0;
 	struct page *page = &folio->page;
@@ -3844,10 +3833,6 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 	if (PageHWPoison(page))
 		goto out;
 
-	/* See comment of filemap_map_folio_range() */
-	if (!folio_test_workingset(folio))
-		(*mmap_miss)++;
-
 	/*
 	 * NOTE: If there're PTE markers, we'll leave them to be
 	 * handled in the specific fault path, and it'll prohibit
@@ -3882,7 +3867,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	vm_fault_t ret = 0;
 	unsigned long rss = 0;
 	unsigned int nr_pages = 0, folio_type;
-	unsigned short mmap_miss = 0, mmap_miss_saved;
 
 	/*
 	 * Recalculate end_pgoff based on file_end before calling
@@ -3921,6 +3905,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	folio_type = mm_counter_file(folio);
 	do {
 		unsigned long end;
+		vm_fault_t map_ret;
 
 		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		vmf->pte += xas.xa_index - last_pgoff;
@@ -3928,13 +3913,34 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		end = folio_next_index(folio) - 1;
 		nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
 
-		if (!folio_test_large(folio))
-			ret |= filemap_map_order0_folio(vmf,
-					folio, addr, &rss, &mmap_miss);
-		else
-			ret |= filemap_map_folio_range(vmf, folio,
-					xas.xa_index - folio->index, addr,
-					nr_pages, &rss, &mmap_miss, file_end);
+		if (!folio_test_large(folio)) {
+			map_ret = filemap_map_order0_folio(vmf, folio, addr,
+							   &rss);
+		} else {
+			unsigned long start = xas.xa_index - folio->index;
+
+			map_ret = filemap_map_folio_range(vmf, folio, start,
+							  addr, nr_pages, &rss,
+							  file_end);
+		}
+		ret |= map_ret;
+
+		/*
+		 * If there are too many folios that are recently evicted
+		 * in a file, they will probably continue to be evicted.
+		 * In such situation, read-ahead is only a waste of IO.
+		 * Don't decrease mmap_miss in this scenario to make sure
+		 * we can stop read-ahead.
+		 */
+		if ((map_ret & VM_FAULT_NOPAGE) &&
+		    !folio_test_workingset(folio)) {
+			unsigned short mmap_miss;
+
+			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
+			if (mmap_miss)
+				WRITE_ONCE(file->f_ra.mmap_miss,
+					   mmap_miss - 1);
+		}
 
 		folio_unlock(folio);
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
@@ -3944,12 +3943,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 out:
 	rcu_read_unlock();
 
-	mmap_miss_saved = READ_ONCE(file->f_ra.mmap_miss);
-	if (mmap_miss >= mmap_miss_saved)
-		WRITE_ONCE(file->f_ra.mmap_miss, 0);
-	else
-		WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss_saved - mmap_miss);
-
 	return ret;
 }
 EXPORT_SYMBOL(filemap_map_pages);
-- 
2.34.1

