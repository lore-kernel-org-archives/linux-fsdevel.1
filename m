Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356573033DE;
	Wed, 17 Jun 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717179; cv=none; b=EPhdNYPsvS4klgIi7MAjSqMGzWJkYaXtK8JcQEWWsvyHX+j6iO8t/EsMyeiAqnKGUSre4BVEDt+Oh1gliUf+vegPOZKPdeli3xZcTxWPZKbBp/NXBvRtuqOAWZBPzy/VS4voleiF7Xhm35iXV6P+hFeF+8Ia2jZc8i29nWMrt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717179; c=relaxed/simple;
	bh=vX9ngUedyoC4TQseaSuK00/OQwDBwl8dZGyqm7Nqw98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZ5G7sU1f7aRT6QqFZ+xIRBFPgvyGI9lbAU/5rWIWukwfEySO0TEUxy0E7Ecvuao4uJq9+oNFP9l+xi+XacvoZNq5cfpWyjwUTp+BgfWZhSwaQSqcnhoMo1H9CJmripz57HuDQs7Ixs06KAPhN4n/xEr78tWEoL6wW3J3E6ZWxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VHosvTS6; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VHosvTS6"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HErIfs2404431;
	Wed, 17 Jun 2026 17:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rcF/e
	zXviocg3GvZpVWOTn7qX+/93xFFR8ZW0AUPUAg=; b=VHosvTS6OkRCGBpqjw5AX
	LWPtu1MG3LVfQWNq19xf80DwNKnVAPdH16J2YdI68WQWxVMOGLMzuFbTZ/uwBlKA
	3FmQCzktSSRorMatBLfzZBuNADyQ985mpvEZ5HxGWAwJjYFEjFncApzMD/p7Cal6
	IKxi5/UbQga3gWYFCHN0vf/fyPof4bQ1I6IBOuYy3822RDk2dLT9zyi0+0wepp8Y
	gTfnqCHuJ4JsIRs0VAQyuIMfuOTpfwWkE/tUHpmOkuMCRichFYPG/jkReR35P5x0
	SV8BRSUyNTwmw+7Ds/G7Of+JljfrJdh38ddqCPm9rTrslFJ314QyfUFNvwahpaEj
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4euegd1cf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 17:25:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65HHNVOk003778;
	Wed, 17 Jun 2026 17:25:52 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4eudvc0wgy-3;
	Wed, 17 Jun 2026 17:25:52 +0000 (GMT)
From: Jane Chu <jane.chu@oracle.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de,
        david@kernel.org, hughd@google.com, baolin.wang@linux.alibaba.com,
        linmiaohe@huawei.com, nao.horiguchi@gmail.com, lorenzo@kernel.org,
        rppt@kernel.org, peterx@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 02/11] mm: factor out adjust_range_hwpoison() from hugetlbfs
Date: Wed, 17 Jun 2026 11:25:23 -0600
Message-ID: <20260617172534.1740152-3-jane.chu@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NyBTYWx0ZWRfXx9/OCgXsRqDr
 2rEgKHXGec3T7N/G1vEpVJwAJjMfciadtAydtrL17ZfXMpoZQtPzu11/CQFUrVbyl7/c1wkICxG
 4aujPmD3We6K4LQQQ4i4pn8hQQuh9EBrWnuhpmtb1gftCCAe01YNj/pyvDdTKupL+cJ30pVUkwc
 dIvjXVVo9lVnu+baOnxwo5IcEu4y69jTAU7l6pSzLkmXHiBbU6dWW7z5euB4Rcw+zLNm0Xl8lIp
 vFwDh1v1jtO1FpwxiusWzia6fMvdXe3kVnyMBqEga9grVNgsf+jAcRKsTAwNEZEnNgTGKuWCTQT
 G8/uhdeaXmXPeHKre1b2aLw2DngOxjTMuaLzZYjj7uik557hv3IY7qnLcknWzQoXV1k88O53mo6
 kkl4wEPFmlUczh+rJ0mG0pwlfK7dlX+NtZGU3qGAHqldZ31dk55KygWaOwyHiWNNu2uiR0UGHD/
 16lEzo30FS0SrMP76OZkLD9vYCkyxw9tfcm5s7uM=
X-Proofpoint-GUID: RzfqjCgGdYn49Rhq-lRBmyrWXAaJ0bLh
X-Proofpoint-ORIG-GUID: RzfqjCgGdYn49Rhq-lRBmyrWXAaJ0bLh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NyBTYWx0ZWRfX19grh2QRVWpX
 g1VTkw6fIHxiNtw6/sbOgcdMqi3/jPHhyeNi9cEk3MUH71HJf/wM5DPRMj1BYo2wHLZ8jSr0wC3
 3bQJ+gesNkfpbbAjbPyZBnlx3mUSVs6buhd2MuRpCnzDTrHXirha
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a32d8a1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=ugIqsUL2P1XQeEjC6sYA:9 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312

The functionality and implementation of adjust_range_hwpoison() is
generic, so factor it out and make it ready for generic use.

[1] https://lore.kernel.org/linux-mm/aeZwAz6PcdlqSnJ2@casper.infradead.org/

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 fs/hugetlbfs/inode.c    | 25 -------------------------
 include/linux/fs.h      |  2 ++
 include/linux/hugetlb.h |  5 -----
 mm/filemap.c            | 31 +++++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 66520f7c53c6..f1f8c3f7388f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -187,31 +187,6 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	return mm_get_unmapped_area_vmflags(file, addr0, len, pgoff, flags, 0);
 }
 
-/*
- * Someone wants to read @bytes from a HWPOISON hugetlb @folio from @offset.
- * Returns the maximum number of bytes one can read without touching the 1st raw
- * HWPOISON page.
- */
-static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
-		size_t bytes)
-{
-	struct page *page = folio_page(folio, offset / PAGE_SIZE);
-	size_t safe_bytes;
-
-	if (is_raw_hwpoison_page_in_folio(page))
-		return 0;
-	/* Safe to read the remaining bytes in this page. */
-	safe_bytes = PAGE_SIZE - (offset % PAGE_SIZE);
-	page++;
-
-	/* Check each remaining page as long as we are not done yet. */
-	for (; safe_bytes < bytes; safe_bytes += PAGE_SIZE, page++)
-		if (is_raw_hwpoison_page_in_folio(page))
-			break;
-
-	return min(safe_bytes, bytes);
-}
-
 /*
  * Support for read() - Find the page attached to f_mapping and copy out the
  * data. This provides functionality similar to filemap_read().
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11559c513dfb..3876d5beda58 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3052,6 +3052,8 @@ int generic_write_checks_count(struct kiocb *iocb, loff_t *count);
 extern int generic_write_check_limits(struct file *file, loff_t pos,
 		loff_t *count);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
+bool is_raw_hwpoison_page_in_folio(struct page *page);
+size_t adjust_range_hwpoison(struct folio *folio, size_t offset, size_t bytes);
 ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *to,
 		ssize_t already_read);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a9846f043712..218284e80451 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1078,11 +1078,6 @@ void hugetlb_register_node(struct node *node);
 void hugetlb_unregister_node(struct node *node);
 #endif
 
-/*
- * Check if a given raw @page is HWPOISON in a folio of any kind
- */
-bool is_raw_hwpoison_page_in_folio(struct page *page);
-
 static inline unsigned long huge_page_mask_align(struct file *file)
 {
 	return PAGE_MASK & ~huge_page_mask(hstate_file(file));
diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..a27ce4ad6247 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2753,6 +2753,37 @@ static void filemap_end_dropbehind_read(struct folio *folio)
 	}
 }
 
+/**
+ * adjust_range_hwpoison - adjust clean readable range to avoid hwpoison.
+ * @folio: folio that contains hwpoison(s).
+ * @offset: bytes into the folio where subsequent read starts.
+ * @bytes: number of bytes wish to read.
+ *
+ * Return: adjusted total number of bytes starting off @offset that can be
+ * safely read from the @folio.
+ */
+size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
+		size_t bytes)
+{
+	struct page *page = folio_page(folio, offset / PAGE_SIZE);
+	size_t safe_bytes;
+
+	if (is_raw_hwpoison_page_in_folio(page))
+		return 0;
+
+	/* Safe to read the remaining bytes in this page. */
+	safe_bytes = PAGE_SIZE - (offset % PAGE_SIZE);
+	page++;
+
+	/* Check each remaining page as long as we are not done yet. */
+	for (; safe_bytes < bytes; safe_bytes += PAGE_SIZE, page++)
+		if (is_raw_hwpoison_page_in_folio(page))
+			break;
+
+	return min(safe_bytes, bytes);
+}
+EXPORT_SYMBOL_GPL(adjust_range_hwpoison);
+
 /**
  * filemap_read - Read data from the page cache.
  * @iocb: The iocb to read.
-- 
2.43.5

