Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF05367B79;
	Wed, 17 Jun 2026 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717198; cv=none; b=Xxh5DpUvs6vLPgej0CdinG0HDABsFvS7bSIdMgIEyV7HZMlVKkacjpI3bRQX3Ue8rNO/DELyhXKFjj4mZv5ld7sJk4Q6rq8rbDbAjeWCDLoEr7lDNRj850+fokfpRzVrvzbnF3F0cZjBP5x454oPxWsk9QgBCUL3J8iNCQaXPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717198; c=relaxed/simple;
	bh=tFo87Sb/bT/LV9C7SNvFVmq8k87LV+RuDj/biyBykkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7MmsVOQYq4RdN65qSnl4z171M0rvYHNgJC9Rb7VUe8FkRPVtEx+OYhkjsKYrfZyCjrfcg7N0lmhLSKWyi7sgB3kVMu86AuOkTKrryX5YIKnIyoucrzT0urxn9yTeVjDUDdA608RmEktjI4M0tC/4IDP8Hom1pgJvkMPd8Osu/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MQvsvO6d; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MQvsvO6d"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEsR2u2367890;
	Wed, 17 Jun 2026 17:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=bJqO5
	j89RevMNiZ+aQEzjbYrz/l5E1nZ80jmdhRo+NA=; b=MQvsvO6dGAlctPle1MySc
	PV2G+uHUAF9VPsDq312QWrLkHZeNygZEivhTE+10lWufGcCvf/jG7gMmF0R+mOjg
	xS1QATS+iW/nR0hQ2ptdk7k6SDFAVnHClwQ749jnZWsBuhOjIv97+GQZz+glDb9r
	dt8qXoU+iNKTz0sFCQQ9atQNXpXA45lZ00nIOO9G8O0cJif60SCVlJ+Z1PS0X0fT
	5TSqAQSfgl6HCi7Qkce5Mkb+n6m60zmJLi2YqWGu44VSUvs6plVgX23Mq1U8xhhZ
	eHbjN+cmculbXSz42ZQ0WfJgTP9RSjp9AIP311Yl2vX8NHNWsNe2pV3CGNKLyc2+
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eueg31c41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 17:26:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65HHNVP0003778;
	Wed, 17 Jun 2026 17:26:11 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4eudvc0wgy-8;
	Wed, 17 Jun 2026 17:26:11 +0000 (GMT)
From: Jane Chu <jane.chu@oracle.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de,
        david@kernel.org, hughd@google.com, baolin.wang@linux.alibaba.com,
        linmiaohe@huawei.com, nao.horiguchi@gmail.com, lorenzo@kernel.org,
        rppt@kernel.org, peterx@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/11] hugetlb: replace filemap_lock_hugetlb_folio with filemap_lock_folio
Date: Wed, 17 Jun 2026 11:25:28 -0600
Message-ID: <20260617172534.1740152-8-jane.chu@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=I8VVgtgg c=1 sm=1 tr=0 ts=6a32d8b4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=FRHgpwYkufxqq0dH4jgA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12312
X-Proofpoint-GUID: j23aEEVfp7e5rJ6HrmdclfWpIL4KwnkK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2OCBTYWx0ZWRfX3x0t1wV30z5R
 Lj9AFYRoMKgo+U1nr7n7g0b1HcjdnorYBd/DilCQuNw1xwaTS/eQE3K5p3aKl0QxfqO4p4aGiV6
 E18io8rwrhek+dnaGEAKbWknReZwHZwexIfhwusQDF40+p2ROUiClk8nqN/OGlCZg1aFkC+jIRf
 yjzOeEb6KqEZXebgNQm+rc+A2bW1VGjvF+h6V6kYlx6dLOuFevgs1F06nTbrJ+0ai4DwZq7YgsJ
 kecMWB6BsMa41/VwMKqEeie/gwV7HBHNFsLxzslU0PelS+jNWz+XWn/yhLw+Tkoc1lP9kWxjKXf
 yqrz6SJT4btFkZlbPegfwoeI29/TRCI5GhJgPjsRCF8QAB8xeIY1x1WzmBrARcAW6xBK82ERMDI
 TeST/T/OXpJ5RH8TNUsfgqSo99OqB9wWzHJ8nyXpLeHBDxADocYn/ZkK/UUgAeRHxYd6Yyuhztx
 9qaYO6CN3jHY0qqEbqCz3KgNgawH8SNcVZtFCtTQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2OCBTYWx0ZWRfX6cR4pX/6SkdK
 bzWdPkpbFGxGWP8d0yBNDNMZ7FKqXKMjvlC//OfHl5Hutm4MN0reMR5A+neXEPS258IYQ8MjUx8
 koHHsbcm0C7Unvo9BjwPiKu6sjTeGuyjr02mOlptn3EQgBUQMI8r
X-Proofpoint-ORIG-GUID: j23aEEVfp7e5rJ6HrmdclfWpIL4KwnkK

The problem with filemap_lock_hugetlb_folio() is redundancy, replace
it with the generic filemap_lock_folio().

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 fs/hugetlbfs/inode.c    |  3 +--
 include/linux/hugetlb.h | 12 ------------
 mm/hugetlb.c            |  4 ++--
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 02cb265a580e..6c883478f7e7 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -518,10 +518,9 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
 					loff_t start,
 					loff_t end)
 {
-	pgoff_t idx = start >> huge_page_shift(h);
 	struct folio *folio;
 
-	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
+	folio = filemap_lock_folio(mapping, start);
 	if (IS_ERR(folio))
 		return;
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cae5cdd3ea00..e78d0f706681 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -824,12 +824,6 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
 	return huge_page_size(h) / 512;
 }
 
-static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
-				struct address_space *mapping, pgoff_t idx)
-{
-	return filemap_lock_folio(mapping, idx << huge_page_order(h));
-}
-
 #include <asm/hugetlb.h>
 
 #ifndef is_hugepage_only_range
@@ -1096,12 +1090,6 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return NULL;
 }
 
-static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
-				struct address_space *mapping, pgoff_t idx)
-{
-	return NULL;
-}
-
 static inline int isolate_or_dissolve_huge_folio(struct folio *folio,
 						struct list_head *list)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ecd1d1322fda..5484e78fe72e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5715,7 +5715,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
+	folio = filemap_lock_folio(mapping, vmf->pgoff);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> PAGE_SHIFT;
 		if (vmf->pgoff >= size)
@@ -6201,7 +6201,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 
 	if (is_continue) {
 		ret = -EFAULT;
-		folio = filemap_lock_hugetlb_folio(h, mapping, idx);
+		folio = filemap_lock_folio(mapping, idx << huge_page_order(h));
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
-- 
2.43.5

