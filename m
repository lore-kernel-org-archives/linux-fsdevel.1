Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CE44B675;
	Fri, 15 May 2026 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838524; cv=none; b=ObVRPwLVui4dXNPsvsRkXVUOrs9Xt/YqIaaQDz2asKznWYUInVKLJwO3AfSJM/qYnDPym6cFYVGdV1j0JDjbgdwQudke16wXh/VjhffepTbzUpgIdnaaYImI4NqqFt32B2eI8h5RNWnqQpSbBZNJ3HnypYG8LfDiVPiESmufJNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838524; c=relaxed/simple;
	bh=QFGY4w9RovPA8CODuoSvEB6kQuqoXM61TrVG9cteS+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j406MhjMLH3/YO/8Zt+mDD/Wag9jUwH02tE2mLD41ec3Ujf9n5KX6a8QJbO3q21lb3h28BD1egF+5c/4+WzGmPtjG/0jZ6s1lmmLXDAW3opxF1/oe7+jE6+thtUdo49ysLHF962LgSGATVg0X+v7UeQi53tgG/Ox84ic/0nXtXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i7WLzVYf; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i7WLzVYf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=JO
	pXXq0yhxeFCV5hNBrcOoYY/AYcpwADf6/pjp5Lkp0=; b=i7WLzVYf0vV3XZUCeZ
	42Slhj+3H1wPtoGcQ/A6IS+HzEFrQ9IpkqShlJrKTuWvXb7yXAaOG6j2ZYMOaX2J
	gXKq8/i1lXOS1O/Gyjht2+wpKFRqQ7f0sl13POg1E9Ptlh/MaUvjHexZHGepQD5h
	0nRvFAA8nhDeYkFhq1rRALm3Q=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnVxek6wZq6RobBg--.38248S6;
	Fri, 15 May 2026 17:47:19 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
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
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 4/4] mm/shmem: make SGP_NOALLOC succeed on hole like SGP_READ
Date: Fri, 15 May 2026 17:47:02 +0800
Message-ID: <20260515094702.1092355-5-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515094702.1092355-1-chizhiling@163.com>
References: <20260515094702.1092355-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnVxek6wZq6RobBg--.38248S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFW5Xr1rAry5Kr1UCr1xZrb_yoW5ZF1Dpr
	97Gr97GrZ5W348Cr1Duws7Zr1UXan3KryUK34agw1vyF98AFy0kr1UAw1j9F18JrW7Ca1F
	qw4jkws8uF4UXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxkucUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9wdA3WoG66dn5QAA3P

From: Chi Zhiling <chizhiling@kylinos.cn>

Change SGP_NOALLOC to return 0 with NULL folio on hole, matching
SGP_READ/SGP_GET behavior. This simplifies the sgp_type handling by
unifying hole semantics across these three types.

Previously, SGP_NOALLOC returned -ENOENT on hole, while SGP_READ/SGP_GET
returned 0. This inconsistency required special handling in callers like
khugepaged and userfaultfd.

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
index 24698faea5a4..6f7f8b9e2a10 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -166,7 +166,7 @@ extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 enum sgp_type {
 	SGP_GET,	/* don't exceed i_size, don't allocate page, don't lock */
 	SGP_READ,	/* don't exceed i_size, don't allocate page, lock folio */
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
index 4bc4e463ca97..41f5e251f7ed 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2531,14 +2531,11 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	/*
-	 * SGP_READ/SGP_GET: succeed on hole, with NULL folio, letting caller zero.
-	 * SGP_NOALLOC: fail on hole, with NULL folio, letting caller fail.
+	 * SGP_READ/SGP_GET/SGP_NOALLOC: succeed on hole, with NULL folio.
 	 */
 	*foliop = NULL;
-	if (sgp == SGP_READ || sgp == SGP_GET)
+	if (sgp <= SGP_NOALLOC)
 		return 0;
-	if (sgp == SGP_NOALLOC)
-		return -ENOENT;
 
 	/*
 	 * Fast cache lookup and swap lookup did not find it: allocate.
@@ -2666,7 +2663,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
  * When no folio is found, the behavior depends on @sgp:
  *  - for SGP_GET, *@foliop is %NULL and 0 is returned
  *  - for SGP_READ, *@foliop is %NULL and 0 is returned
- *  - for SGP_NOALLOC, *@foliop is %NULL and -ENOENT is returned
+ *  - for SGP_NOALLOC, *@foliop is %NULL and 0 is returned
  *  - for all other flags a new folio is allocated, inserted into the
  *    page cache and returned locked in @foliop.
  *
-- 
2.43.0

