Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0B36A004;
	Wed, 17 Jun 2026 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717187; cv=none; b=ZpbI9yJHaIuzl/7l3+0LaOVUgG9csuFPU+TPr/V6qT4LujVsWpq7LNrwu/ipvTYEwvQuyo/Ni6V4bI+68fjeowPNNscaZYtqhPhOAlea7lrD5zUcz25TDXia0CdSHf3QqsjY1kcZikpwaa6UCAxhRnPK0dhg+QYCUbtLEEL0Zt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717187; c=relaxed/simple;
	bh=7pmmzu6+6dwb5chyCi72VL5pTFpnmyVekuE2TZvRr7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGZldP1Cc7PGBQuNKrs88i+3YDVVNE0G2p2pZ5el7ptf26qFppeaLEwVVY1HFfhrWky/wQNK9WzFHLuEt312UZLY0wlCdXKdMzD6MAQ2LXSueJpCpBf87R/hl5hVLUT6+gNiy7xRzxfyNbHpsrKd4Tu5d/UVYQIkXXxCCBDigHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b8MSN0wJ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b8MSN0wJ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEsHJi2481167;
	Wed, 17 Jun 2026 17:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=i32Zv
	W+vpI4Ko63/BjKa2UU88DSctsuX+gkqMrOcxsk=; b=b8MSN0wJtsM/2xk/jI79P
	i7ZKVbXTKFSjb5Sr+KBAem0iGSCieNVTytgA/XI82qoFS387KhhQUOFB0vz09ppt
	x+nfUMLOonQ4kql349gIyE7a0XvtNyedq7PgzY37h9WEC6xsJZ2HzC7bH5/sT/30
	umGsZWXJtUYaLHPhoBlnZwlHxQOSvndhAcQQFxmec/XlqTWyXGtr9/N5GMugmlm/
	Dmb5OGj1qdoqX6h0LhXRWcUczmr5GIGQ53DyJh6xvwefAv22L067vrbKbesWh65g
	LzdsPXbHDh9svsuEJZAiTKOqwT3cTfaYklHfSJUyvDgiOKFlldv5i6f93jK2FtIw
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eueg2hcgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 17:26:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65HHNVOm003778;
	Wed, 17 Jun 2026 17:25:59 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4eudvc0wgy-5;
	Wed, 17 Jun 2026 17:25:58 +0000 (GMT)
From: Jane Chu <jane.chu@oracle.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de,
        david@kernel.org, hughd@google.com, baolin.wang@linux.alibaba.com,
        linmiaohe@huawei.com, nao.horiguchi@gmail.com, lorenzo@kernel.org,
        rppt@kernel.org, peterx@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 04/11] hugetlbfs,filemap: replace hugetlbfs_read_iter() with generic_file_read_iter()
Date: Wed, 17 Jun 2026 11:25:25 -0600
Message-ID: <20260617172534.1740152-5-jane.chu@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2OCBTYWx0ZWRfXwdXLKCCqgDf2
 Pe5YRVq597paTPzxgB9CdqMg1ST6XMgesE1zf3q34PBckZuyysijv0YjwqN/qmrA/9QrAYA8Mzz
 8KMYuZBbppGDkK9kTvVAQGho/QoMnlZOrWVq47Vy2w9xqRS4FlLKx3MngeUVVqDnwhMdnXJ/WKP
 3b2KxWv/J0vylL1iQyOefZtqsAm/G0o0msT2K1P2eags7mCe6GfQkz50BTzne1rIOUhds6RP2Ap
 5FIf9QGL5tRCTffntMm+H75Mi7PFy/CEecDwvfIIRs1DhkyeJYJHsSGhxVWVFmwpoUKXxh8njHt
 0Fup0VJaOg2y2aG6HtzQzoIddD097tmk5IyG6YG/blt1WEDWMg9LZKj04oAKz+ruo5O82lseiLT
 v4NTkYJZjiLDk8XrBqELaORIlbLv5szBplW/pRf4K/l6mv/5cdE1gBEQ7EBPYw7kglMx1IrbfKo
 FFfIFg5blOnmmkfv/+bAcova0u1Icw0x6nAd0bqQ=
X-Proofpoint-GUID: QQjsk5quOBfyFwEZf0gQ9eQofZvvKb7S
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2OCBTYWx0ZWRfX1JRL9Etm08Jq
 olXbWlzE0Zelg34my9bxrpeTmqEsBLI6DfUldLPRlBZEV+YtqRopIdhrF26CFi8a33AIe3P9fZ9
 zhm87Shz1z91C9vnGP712mOVPY+Osmfm51wluLxIazjcUOAHJqX6
X-Proofpoint-ORIG-GUID: QQjsk5quOBfyFwEZf0gQ9eQofZvvKb7S
X-Authority-Analysis: v=2.4 cv=UY1hjqSN c=1 sm=1 tr=0 ts=6a32d8a8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=BVX3X0w32c5Jxbss9mcA:9 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312

Replace hugetlbfs_read_iter() with generic_file_read_iter(),
teach filemap_get_pages() to be aware of hugetlb pagesize while
calculating 'last_index'.

[1] https://lore.kernel.org/linux-mm/aeZwAz6PcdlqSnJ2@casper.infradead.org/

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 fs/hugetlbfs/inode.c | 84 +-------------------------------------------
 mm/filemap.c         | 15 ++++++--
 2 files changed, 14 insertions(+), 85 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f1f8c3f7388f..1c25485c91b9 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -187,88 +187,6 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	return mm_get_unmapped_area_vmflags(file, addr0, len, pgoff, flags, 0);
 }
 
-/*
- * Support for read() - Find the page attached to f_mapping and copy out the
- * data. This provides functionality similar to filemap_read().
- */
-static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
-{
-	struct file *file = iocb->ki_filp;
-	struct hstate *h = hstate_file(file);
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	unsigned long index = iocb->ki_pos >> huge_page_shift(h);
-	unsigned long offset = iocb->ki_pos & ~huge_page_mask(h);
-	unsigned long end_index;
-	loff_t isize;
-	ssize_t retval = 0;
-
-	while (iov_iter_count(to)) {
-		struct folio *folio;
-		size_t nr, copied, want;
-
-		/* nr is the maximum number of bytes to copy from this page */
-		nr = huge_page_size(h);
-		isize = i_size_read(inode);
-		if (!isize)
-			break;
-		end_index = (isize - 1) >> huge_page_shift(h);
-		if (index > end_index)
-			break;
-		if (index == end_index) {
-			nr = ((isize - 1) & ~huge_page_mask(h)) + 1;
-			if (nr <= offset)
-				break;
-		}
-		nr = nr - offset;
-
-		/* Find the folio */
-		folio = filemap_lock_hugetlb_folio(h, mapping, index);
-		if (IS_ERR(folio)) {
-			/*
-			 * We have a HOLE, zero out the user-buffer for the
-			 * length of the hole or request.
-			 */
-			copied = iov_iter_zero(nr, to);
-		} else {
-			folio_unlock(folio);
-
-			if (!folio_test_hwpoison(folio))
-				want = nr;
-			else {
-				/*
-				 * Adjust how many bytes safe to read without
-				 * touching the 1st raw HWPOISON page after
-				 * offset.
-				 */
-				want = adjust_range_hwpoison(folio, offset, nr);
-				if (want == 0) {
-					folio_put(folio);
-					retval = -EIO;
-					break;
-				}
-			}
-
-			/*
-			 * We have the folio, copy it to user space buffer.
-			 */
-			copied = copy_folio_to_iter(folio, offset, want, to);
-			folio_put(folio);
-		}
-		offset += copied;
-		retval += copied;
-		if (copied != nr && iov_iter_count(to)) {
-			if (!retval)
-				retval = -EFAULT;
-			break;
-		}
-		index += offset >> huge_page_shift(h);
-		offset &= ~huge_page_mask(h);
-	}
-	iocb->ki_pos = ((loff_t)index << huge_page_shift(h)) + offset;
-	return retval;
-}
-
 static int hugetlbfs_write_begin(const struct kiocb *iocb,
 			struct address_space *mapping,
 			loff_t pos, unsigned len,
@@ -1181,7 +1099,7 @@ static void init_once(void *foo)
 }
 
 static const struct file_operations hugetlbfs_file_operations = {
-	.read_iter		= hugetlbfs_read_iter,
+	.read_iter		= generic_file_read_iter,
 	.mmap			= hugetlbfs_file_mmap,
 	.fsync			= noop_fsync,
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
diff --git a/mm/filemap.c b/mm/filemap.c
index df8543573570..eb03b31791fc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2672,20 +2672,30 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
+	bool is_hugetlbfs = is_file_hugepages(filp);
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct folio *folio;
 	unsigned int flags;
+	size_t min_folio_bytes;
 	int err = 0;
 
 	/* "last_index" is the index of the folio beyond the end of the read */
-	last_index = round_up(iocb->ki_pos + count,
-			mapping_min_folio_nrbytes(mapping)) >> PAGE_SHIFT;
+	if (is_hugetlbfs)
+		min_folio_bytes = huge_page_size(hstate_file(filp));
+	else
+		min_folio_bytes = mapping_min_folio_nrbytes(mapping);
+	last_index = round_up(iocb->ki_pos + count, min_folio_bytes) >> PAGE_SHIFT;
+
 retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
 	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
+
+	if (is_hugetlbfs)
+		goto done;
+
 	if (!folio_batch_count(fbatch)) {
 		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
 
@@ -2724,6 +2734,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			goto err;
 	}
 
+done:
 	trace_mm_filemap_get_pages(mapping, index, last_index - 1);
 	return 0;
 err:
-- 
2.43.5

