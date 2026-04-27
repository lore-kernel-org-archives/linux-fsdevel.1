Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFE4374E5C;
	Mon, 27 Apr 2026 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309087; cv=none; b=Q7ge+bhgp43rFQQ5KEL2SIV7BW6aiyJL76yTNZ02RJHKz0vcNgFB4oujBG8c2sUPqCox0MJhWP75dEHlIUHvm9QlY2HOZiOkSjyVb+w2yOz77xxzmswIpUgieHx4+GEUeWCHCjCBWiQGbZ7EGSII8caifIfIbL8snv74lEfM3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309087; c=relaxed/simple;
	bh=hUx1Xhz3lO4ZGLf/9+bzT4Hgv7XvTEcHoSSy49gP1zY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OzMD86X3nu8fzv6ytY1WPWilzlq81fhWW1Cm4j61/XgrwzARkeHL5EvqWNMm/i/gLydw19DYDHDpTOd5rucwSWhw9DG6QdAhUNQmyE5UKbRG8s7TcTTs5QyXRF+hi5HXTnPe65/YWCu0cJfwQgdgI4W7AVNCxvge13RpqsOzBX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gQXLJUyI; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gQXLJUyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777309075; bh=+1JvSeF30219RBk+xbUaNaVTMY2zuIFNzkHsiaJcAUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gQXLJUyIm5qOEHJ/B58iHD/yFGhxGdYsH8j5nwwvG22zXoUskg33/4HdRs/kdT3S+
	 tZDOyPmdu9ssgKwABbdZChmShvXduyyU26LrQfOJ8MsHIS1a1ZBnHFCxer/s1hmAWA
	 he/8fyZzErehb86ZA3hajls0D1m2ny5GEnJaQ2QQ=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id E73AA4C8; Tue, 28 Apr 2026 00:57:51 +0800
X-QQ-mid: xmsmtpt1777309073to1iceus8
Message-ID: <tencent_949F3B157FE71D3C7247AE6FAE2C5AB82809@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUALqh99JbrUzyKqrytGQhvISUP2SJ+lBCQnAMZx+Ah4KMdLXmAp/
	 CYkVWiEAjpgSPZ+AP27Kda4iF/pd6tMH3yioFtTwwaGx3s1yYPOAmfQDkoclFRWL82QDH7sek5OI
	 RlUXYkrXU+EPk2Fn3F2Ad6RFJnrQNPq+WlBoy9DQKpgeQ7JtiKwZxQ3S77zt3qpTuVixEnOL5Ss7
	 SwUgxaq0GaTG2wD5NbrsvNvRGjtDV7cfPTkUqtaGgXkTFLqJkaxcVa5CZYc7noQex/SCI8k6EmIq
	 VFU8sixXlICQAubYrkZq7IiI4lHlK9SQMeA2C4c8RrC1etJHaN9GuL4ts9qWqGznnZ7ThzpURkOm
	 3LKl9USwzVyTZSoaGUCWYP+8TzxK6CSUd3xjQKwoGC7S34wm6MHrDI2dO4yr2YHpJ7s6XeeCNR69
	 xFytxtEqB68URvc3RQjw0pF6YNQC7CxoHtdTdq3ACcmAi2xH83AIgVaJd3GqEjtF+hy9rCgVp0OV
	 aBj8onayxhOxufZ/dSuJ/nnhJAYPG6NMOcfUE1dTM6vRvUSrZNQU5z+DP78mjnYT53mKwy6/tKJS
	 ySrMq64g8xcak3JQwQoQtZU9doXWMhw/cMshFi/UmfelF6oPrPoLR1tBpt4D3Bds7vwWTQdnj7xm
	 A/NQyDr3qDBrJ7HJfM5OYF/zy0wnd9tyT3mZNiOkpVgxl2Ino+ufpN11fC3/QCYYZOGqTqrYGRJH
	 AMQRXSt+Tvx9TWP/Fmdb8K5qCXX/AqfYRSXCUy+lfPoEYBpPgQGRZdh4mUVFqezHj+v3oCa5v4x+
	 fypNi9y6QZtU9rRy7UnQTZ1la8CGg7orPL1FkH9XlX7pzITwt1SNmwPxhAne9/+f4VMJBTdR2s0N
	 kF8QYNU1L7PhX7SknKwCvS3gqNq3lhKIKdY1/V6C71z7IAXFKXfmwc9bm65vZaCH9pVuoSGQyrYa
	 b0hfD7ZTkK/l8owIE9LwT5MQbKjeK9d15bRKMujp2hsJ+cp6Dt08Pl80LGixqbSPTf5vcw1AhWV6
	 VGqAOkqNpitWBMzveS
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: fujunjie <fujunjie1@qq.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Haoran Zhu <zhr1502@sjtu.edu.cn>
Subject: [PATCH v2 1/2] mm/filemap: count only the faulting address as a mmap hit
Date: Mon, 27 Apr 2026 16:57:50 +0000
X-OQ-MSGID: <20260427165751.746502-2-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427165751.746502-1-fujunjie1@qq.com>
References: <20260427165751.746502-1-fujunjie1@qq.com>
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
 mm/filemap.c | 55 +++++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c1..41ffe9036c96e 100644
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
@@ -3928,13 +3913,27 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
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

