Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B6369D68;
	Wed, 20 May 2026 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272391; cv=none; b=Wwe86pRpftOsQLj5fYI06yMb67Y+3QuDO3uwjEPGa6BOzcw+pDsRJiCPb4qopjsmgwDmRKQmu1YSqmTGs7r020+NO6nQ7WwwinMtUjGthD5TgcY18iw7hl9jhf/fUnXsqmXGYf6MTxwVkhvhmikPZanSUd9ji5eQ43Mjxuod9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272391; c=relaxed/simple;
	bh=p8Ki2orvcNd7P/MQkjn4RdNRgzdigcU4LQDNFRtpKFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7D64tiLaJdnCfkldnNg914YjtKThSaW1r/nq9dfSxsOa/lduayByyGL/0x20/BSj8FnW/ydAJeg/LLRQ1J1LIHJocJIyKOLOe0bU5L8yCU8BfwL/IhQVllpWi28gvk2ID9V9ypuuCRFhKGd3RqiodfhoL7JhzLkNSIkjt6CTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V/5qubSD; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V/5qubSD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hK
	/M4mH8Af7RP/R8Z/X9FqFJJChjz35upJb+IeYgpMA=; b=V/5qubSDLft5TwdJtV
	ji/UPnm6o8HUMhqxwbmT67iJuxFHpfcZP5qyyF6H40TTnmtfUxWlLAwYaMvVlUYX
	KvCkiSUNznp6I8G0qB2lrlumzeg7mkGMy90uKxfybGcrJEagKkxViXGlyj9EuiEK
	qE5pyR6+iAk31H6TCbfM6L3bM=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXbbprig1qQK31EQ--.641S5;
	Wed, 20 May 2026 18:18:25 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 3/5] mm/shmem: make SGP_NOALLOC succeed on hole like SGP_READ
Date: Wed, 20 May 2026 18:15:36 +0800
Message-ID: <20260520101538.58745-4-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520101538.58745-1-chizhiling@163.com>
References: <20260520101538.58745-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXbbprig1qQK31EQ--.641S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFW5Xr1rAry5Kr1UGry8Zrb_yoW5CrW3pr
	9rG3s7GrWYg348Cr1DZws7Zr1UXan3tryUKryIg34qvF98AF10k347Aw1j9F18ArW8Ca1F
	qFWjkws8uF1UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jpApnUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2xKcOmoNinJltQAA3g

From: Chi Zhiling <chizhiling@kylinos.cn>

Change SGP_NOALLOC to return 0 with NULL folio on hole, matching
SGP_READ behavior. This simplifies the sgp_type handling by unifying
hole semantics across these types.

Previously, SGP_NOALLOC returned -ENOENT on hole, while SGP_READ
returned 0. This inconsistency required special handling in callers
like khugepaged and userfaultfd.

After this change:
- khugepaged: behavior unchanged (checks both error and NULL folio)
- userfaultfd: behavior unchanged (both -ENOENT and NULL are converted
  to -EFAULT before returning to userspace)

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 include/linux/shmem_fs.h | 2 +-
 mm/khugepaged.c          | 2 +-
 mm/shmem.c               | 9 +++------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 93a0ba872ebe..d461713c095b 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -165,7 +165,7 @@ extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 /* Flag allocation requirements to shmem_get_folio */
 enum sgp_type {
 	SGP_READ,	/* don't exceed i_size, don't allocate page */
-	SGP_NOALLOC,	/* similar, but fail on hole or use fallocated page */
+	SGP_NOALLOC,	/* like SGP_READ, but accept fallocated page */
 	SGP_CACHE,	/* don't exceed i_size, may allocate page */
 	SGP_WRITE,	/* may exceed i_size, may allocate !Uptodate page */
 	SGP_FALLOC,	/* like SGP_WRITE, but make existing page Uptodate */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b8452dbdb043..3309d1c094df 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1950,7 +1950,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 				xas_unlock_irq(&xas);
 				/* swap in or instantiate fallocated page */
 				if (shmem_get_folio(mapping->host, index, 0,
-						&folio, SGP_NOALLOC)) {
+						&folio, SGP_NOALLOC) || !folio) {
 					result = SCAN_FAIL;
 					goto xa_unlocked;
 				}
diff --git a/mm/shmem.c b/mm/shmem.c
index 3b5dc21b323c..458853c506ea 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2524,14 +2524,11 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	/*
-	 * SGP_READ: succeed on hole, with NULL folio, letting caller zero.
-	 * SGP_NOALLOC: fail on hole, with NULL folio, letting caller fail.
+	 * SGP_READ/SGP_NOALLOC: succeed on hole, with NULL folio.
 	 */
 	*foliop = NULL;
-	if (sgp == SGP_READ)
+	if (sgp <= SGP_NOALLOC)
 		return 0;
-	if (sgp == SGP_NOALLOC)
-		return -ENOENT;
 
 	/*
 	 * Fast cache lookup and swap lookup did not find it: allocate.
@@ -2657,7 +2654,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
  *
  * When no folio is found, the behavior depends on @sgp:
  *  - for SGP_READ, *@foliop is %NULL and 0 is returned
- *  - for SGP_NOALLOC, *@foliop is %NULL and -ENOENT is returned
+ *  - for SGP_NOALLOC, *@foliop is %NULL and 0 is returned
  *  - for all other flags a new folio is allocated, inserted into the
  *    page cache and returned locked in @foliop.
  *
-- 
2.43.0

