Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F3330B30;
	Wed, 17 Jun 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717179; cv=none; b=FMDMc7HLcaZCZfQpbp4gidsYRowEsavF444k/8aqVEP0ZJeqXBFnGnXzPiIJ7GPjj6f+syssLz3OJN7HKWTul4W9t5tZ1sinG+Lp80Xy5dN91stAGcbSIAxU3LsuWHRfUsb4cCINL5XD0y1O5ZoWM2uAh+6gS3aM58LSs0he8OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717179; c=relaxed/simple;
	bh=7jCbGveGidbqtNPotdr/ZBopdaWETxlaiqeM8CnQ1Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUkm7+/XUXXHgK58J3hb8i+VSJHs3zo5CHqN8ZH0/+TkJ6bkqyw7CgU0X03EllipONJH70omk8mTBb9oC5c4rweR3oJmkjZe4L4dTJQ+Br8u1ORVP5v8tJ6CPENgyUTHi5l5sr0AyQKvNAsWEltQYXC9xXyLj4J8M0AHqYRSKxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E45PcdJT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E45PcdJT"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEsR4f2367895;
	Wed, 17 Jun 2026 17:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=zDEdJ
	auVMqtcYMksWd/HaiAwhAj1eYV9erFp/52IWEw=; b=E45PcdJT1xJEOVCzXExoo
	sJ95a+kw7K3Qd/2mdalW8S5fs/SVwqmJrOHljFAhxUR8xy/9rE5BO8t/PpMWpgcM
	Jk9wTrZ4c3lu/+EwHGtoFwC9nPDmMmd0uTEi9igdobk0IdxY3ZJzGohCxBwbF5Ag
	sm/D9mwI4MVgLuRfNb//df7WxH0f9uej3f3D4z54Y11BOoio1juUNRCquE8BT13M
	zNqc33foT9huQWVqeso82RfsmEV6aZXSiBMaIKO+6vBj7YwDiPJLnlgmTRedhWwZ
	zOfrrKbG8pJ88thH6anZBJ5QYsVzCpbGw2lGsCvi30beo7LcEfcPI3IGSg+zhlTf
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eueg31c32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 17:25:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65HHNVOj003778;
	Wed, 17 Jun 2026 17:25:49 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4eudvc0wgy-2;
	Wed, 17 Jun 2026 17:25:48 +0000 (GMT)
From: Jane Chu <jane.chu@oracle.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de,
        david@kernel.org, hughd@google.com, baolin.wang@linux.alibaba.com,
        linmiaohe@huawei.com, nao.horiguchi@gmail.com, lorenzo@kernel.org,
        rppt@kernel.org, peterx@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/11] mm/memory-failure: make is_raw_hwpoison_page_in_hugepage() general purpose
Date: Wed, 17 Jun 2026 11:25:22 -0600
Message-ID: <20260617172534.1740152-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260617172534.1740152-1-jane.chu@oracle.com>
References: <20260617172534.1740152-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606150000 definitions=main-2606170167
X-Authority-Analysis: v=2.4 cv=I8VVgtgg c=1 sm=1 tr=0 ts=6a32d89e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=Mb7NiH9OEEZ03nqYuncA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-GUID: 592cje2o6CRkX_6JHYwFOwZa5T7CjXZw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NyBTYWx0ZWRfX1YtkOhEQgCUq
 GcdoVQJTP+BKkLEGPlkd0LncsiyH7jmj0W7JobTH6WmS8E1Oskl33n64G8nqHGrMw2ddPWQjS/2
 1hvmaGruGdeJIfFlGKghi4accZgdugeDL0MYokaXTH+hU5LcvUyN+6bgK97Ap7ouCDaPwSLbB9H
 qXgubHTVYYZ0bMWqtZBNEiHbnMt3iTj5lsXUBlZb9+O8BM6JfkKVXzoJf9QfTmHPxj70kN4p8hQ
 7cCcnsCa/yMcA8HBMYQzvf3ixLtaYtHGc56VyBjYqlhGw4Kaq+4ipZsruAs/8NwwLmZEvEjmffB
 Jrbarf+aP1Tfjj3T9Va+g+/TGl+9zE6WrQQ6uD5zlZEYbkHTqsQfDT4ctoBXCgc+GqYEluNPJEH
 AvnW0+H0OD+xSCsrnFFO0RRFHUy/vKLFWoJs/BGOE0+P1YPgPuctcBvFAcX9b74fbfFZlaQ4iUc
 UPvH35w2rbtyTZt2rTwfqLOpC7IiPHwNyXJhpo5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NyBTYWx0ZWRfXzZOd+Jkjz6C7
 j2nmXzltI73PPbg9vJ/2Z5EUP8lHyDrVA7O+jXmnrM/Tz/5NPZdt/FsMi47dXLkNdHq2K7ZW/zq
 74c/p43HUlTqk2MjuW/b+NhJzOX5g/TRp9W+XZfiSvhAxKt+jAlS
X-Proofpoint-ORIG-GUID: 592cje2o6CRkX_6JHYwFOwZa5T7CjXZw

Make is_raw_hwpoison_page_in_hugepage() general for checking whether
a given raw page within any kind of folio is HW poisoned. Thus,
replace folio_test_hwpoison() with folio_contain_hwpoisoned_page().
Also rename to is_raw_hwpoison_page_in_folio().

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 fs/hugetlbfs/inode.c    |  4 ++--
 include/linux/hugetlb.h |  4 ++--
 mm/memory-failure.c     | 12 ++++++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 78d61bf2bd9b..66520f7c53c6 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -198,7 +198,7 @@ static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
 	struct page *page = folio_page(folio, offset / PAGE_SIZE);
 	size_t safe_bytes;
 
-	if (is_raw_hwpoison_page_in_hugepage(page))
+	if (is_raw_hwpoison_page_in_folio(page))
 		return 0;
 	/* Safe to read the remaining bytes in this page. */
 	safe_bytes = PAGE_SIZE - (offset % PAGE_SIZE);
@@ -206,7 +206,7 @@ static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
 
 	/* Check each remaining page as long as we are not done yet. */
 	for (; safe_bytes < bytes; safe_bytes += PAGE_SIZE, page++)
-		if (is_raw_hwpoison_page_in_hugepage(page))
+		if (is_raw_hwpoison_page_in_folio(page))
 			break;
 
 	return min(safe_bytes, bytes);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5957bc25efa8..a9846f043712 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1079,9 +1079,9 @@ void hugetlb_unregister_node(struct node *node);
 #endif
 
 /*
- * Check if a given raw @page in a hugepage is HWPOISON.
+ * Check if a given raw @page is HWPOISON in a folio of any kind
  */
-bool is_raw_hwpoison_page_in_hugepage(struct page *page);
+bool is_raw_hwpoison_page_in_folio(struct page *page);
 
 static inline unsigned long huge_page_mask_align(struct file *file)
 {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee42d4361309..40129e0b8213 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1834,14 +1834,21 @@ static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
 	return (struct llist_head *)&folio->_hugetlb_hwpoison;
 }
 
-bool is_raw_hwpoison_page_in_hugepage(struct page *page)
+/**
+ * is_raw_hwpoison_page_in_folio - answers the question whether a given
+ * page is indeed hwpoisoned.
+ * @page: given page, maybe base page, part of a large folio or hugetlb.
+ *
+ * Return: true if @page is the raw hwpoisoned page; else, false.
+ */
+bool is_raw_hwpoison_page_in_folio(struct page *page)
 {
 	struct llist_head *raw_hwp_head;
 	struct raw_hwp_page *p;
 	struct folio *folio = page_folio(page);
 	bool ret = false;
 
-	if (!folio_test_hwpoison(folio))
+	if (!folio_contain_hwpoisoned_page(folio))
 		return false;
 
 	if (!folio_test_hugetlb(folio))
@@ -1868,6 +1875,7 @@ bool is_raw_hwpoison_page_in_hugepage(struct page *page)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(is_raw_hwpoison_page_in_folio);
 
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
-- 
2.43.5

