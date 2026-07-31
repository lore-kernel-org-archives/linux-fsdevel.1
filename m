Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835E362153
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528501; cv=none; b=sBXrBUXXfn5OtSaeXepiVklNpPowIn3vylps4oeBM02VnChXKlLP7Mij7bNbXZpcbMMkqT3lLEiVsrgHofhq2dNDGCrdUMdzho/StXDwUvPazUGjbnol65TlDdEN+tXMbu82pkvIgAUFL0jbVOukY65pYMJYHijrBU+YPGO92to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528501; c=relaxed/simple;
	bh=wGlWUzIFQTWtavaqwcGvPKJ5s76dEKzdmc4eVvcdK60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1lw1VTwYAcvDtOzjF7RJ2/B2Fd4640Mh9kl4bhxqY6qyBfSXQDCzFwNy9TUh+S3dHwlhhMPGaC8jcGP6DmIlfABzH0MZ+lhxXVc5pNhOiBePxB/+0vtWgxl/+3TFRhxOBQ3nt4YYyqobrFQqz12wNfDS8OxiLFpYPb9bK+J0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v9Rd9esF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v9Rd9esF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BCsINWgR/sLHMztmR7oqLBuFdownCBpUvKqPC33EfA4=; b=v9Rd9esF5j7rF7lYwdR0jpBrdc
	SfB8cFx53mZDx5AznEFYfHxedw4a7e9lgnp/FLjFrof7YKh4jczzIox/qXdXPKgC+bId7zOs9ccJJ
	DZD+UCk2vwyuEr5k2BBdukp7YdMfRkKBypfAInQJ4EN8bZFKXs6un9ON38S554HzbahaxbRDP9FkJ
	pUlUs7S7ffzRX2vH3wdJ1zwptCph02Pf1ec3kiQ63RoF+H6sjNpw8f/VvkUqARa85XeBJjhD1wXWh
	ewaVnmjjSuIEm6r/iXLZPxx7QkA+U6seBXu7GW6aiqXa5L0KUF/12y37ThhzOIu76FlcVsfbl+rqD
	PrMvYnsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wptWW-00000002Phy-20Ne;
	Fri, 31 Jul 2026 20:08:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>,
	Usama Arif <usama.arif@linux.dev>,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH v8 04/15] hugetlb: Mark some function arguments as const
Date: Fri, 31 Jul 2026 21:07:49 +0100
Message-ID: <20260731200802.574821-5-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731200802.574821-1-willy@infradead.org>
References: <20260731200802.574821-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions do not modify their folio argument, so we can mark them
as being const which will allow for some minor optimisations and let us
mark other function arguments as being const in the future.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/hugetlb.h | 19 +++++++++----------
 mm/hugetlb.c            |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 50eab2c23299..e200c93088bc 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -176,7 +176,7 @@ bool hugetlbfs_pagecache_present(struct hstate *h,
 				 struct vm_area_struct *vma,
 				 unsigned long address);
 
-struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio);
+struct address_space *hugetlb_folio_mapping_lock_write(const struct folio *folio);
 
 extern int movable_gigantic_pages __read_mostly;
 extern int sysctl_hugetlb_shm_group __read_mostly;
@@ -311,8 +311,7 @@ static inline unsigned long hugetlb_total_pages(void)
 	return 0;
 }
 
-static inline struct address_space *hugetlb_folio_mapping_lock_write(
-							struct folio *folio)
+static inline struct address_space *hugetlb_folio_mapping_lock_write(const struct folio *folio)
 {
 	return NULL;
 }
@@ -614,8 +613,8 @@ enum hugetlb_page_flags {
 #ifdef CONFIG_HUGETLB_PAGE
 #define TESTHPAGEFLAG(uname, flname)				\
 static __always_inline						\
-bool folio_test_hugetlb_##flname(struct folio *folio)		\
-	{	void *private = &folio->private;		\
+bool folio_test_hugetlb_##flname(const struct folio *folio)	\
+	{	const void *private = &folio->private;		\
 		return test_bit(HPG_##flname, private);		\
 	}
 
@@ -635,7 +634,7 @@ void folio_clear_hugetlb_##flname(struct folio *folio)		\
 #else
 #define TESTHPAGEFLAG(uname, flname)				\
 static inline bool						\
-folio_test_hugetlb_##flname(struct folio *folio)		\
+folio_test_hugetlb_##flname(const struct folio *folio)		\
 	{ return 0; }
 
 #define SETHPAGEFLAG(uname, flname)				\
@@ -746,7 +745,7 @@ static inline struct hugepage_subpool *subpool_inode(struct inode *inode)
 	return HUGETLBFS_SB(inode->i_sb)->spool;
 }
 
-static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
+static inline struct hugepage_subpool *hugetlb_folio_subpool(const struct folio *folio)
 {
 	return folio->_hugetlb_subpool;
 }
@@ -876,7 +875,7 @@ static inline bool arch_has_huge_bootmem_alloc(void)
 }
 #endif
 
-static inline struct hstate *folio_hstate(struct folio *folio)
+static inline struct hstate *folio_hstate(const struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	return size_to_hstate(folio_size(folio));
@@ -1107,7 +1106,7 @@ static inline unsigned long huge_page_mask_align(struct file *file)
 	return 0;
 }
 
-static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
+static inline struct hugepage_subpool *hugetlb_folio_subpool(const struct folio *folio)
 {
 	return NULL;
 }
@@ -1176,7 +1175,7 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
 	return NULL;
 }
 
-static inline struct hstate *folio_hstate(struct folio *folio)
+static inline struct hstate *folio_hstate(const struct folio *folio)
 {
 	return NULL;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 571212b80835..cc8d98399913 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1775,7 +1775,7 @@ void init_new_hugetlb_folio(struct folio *folio)
  * stable.  Due to locking order, we can only trylock_write.  If we can
  * not get the lock, simply return NULL to caller.
  */
-struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio)
+struct address_space *hugetlb_folio_mapping_lock_write(const struct folio *folio)
 {
 	struct address_space *mapping = folio_mapping(folio);
 
-- 
2.47.3

