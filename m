Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3536492A;
	Wed, 17 Jun 2026 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717190; cv=none; b=bKFSQ83ZW5ivFGwOLJUfCTUc2JGbU88J1vFMf87tmDGb9L0CFOR8HJgfdnfmpvYku/bWrjze516BTaw5OqDCVxygziH5bpS+SrWVpDLmD3cmRVCgjpftTO/0AUGUiliH25xBh3v3GGrsIyAO9TaVKFGS5RcBb/zo/+3ObnTTLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717190; c=relaxed/simple;
	bh=WFnLAakn9wof+kg3+oXb6fGDP+VrqLx9Y+hXOTS6s0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBAmxDAopC+NuqENB7YZJw2fji5e6OXPIX0TANwxfFqbsXWLxLBJwf4V7OIqOgRqFIkR0EB/XnkYFBP5Lj3JPkYvoKJe90v25lTZFldOwQaJ7cyn8HcnWJETivqV49btN+k9/FiDDs3ixrHhZ9lKHr4mjW5AjkJyqwzFCtDgv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PWN1OwnG; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PWN1OwnG"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HErMpC2404748;
	Wed, 17 Jun 2026 17:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=UQeQx
	AcUdLbL6Y0Naou7oU4dol5Li4R1AlhXhddZwME=; b=PWN1OwnGxtREmeIBJ5QhH
	/vxETOJHI7XXyiaQj3OqnH81JmayjLekwigSAgnQDW2sUESkLLLudDQtv7+RMKSU
	VSD3k7O1W6UY1L8nS/F3TpEdaFtsBbzmatzfq3vaocZ/loLE2nkoOCEAU95ndZ1P
	siVIfDamlX1xzAN/dm+qr6feC1/6yiIRzgPpHoMl9HUbv2gWLrXJMYaBSmO7OVkQ
	jdXldkN4kqjexg277UoPCpdBwt2aCgXo9MKdPWBBOARkVyGDPhfLcXwQQzmRoRCX
	6fXZ4xuttWrMKi+u97RtDOuj4G4/DtJM6FpiVmFHj4q28Q6fR8eHBXt4Qx/kt2X+
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4euegd1cfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 17:26:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65HHNVOq003778;
	Wed, 17 Jun 2026 17:26:03 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4eudvc0wgy-6;
	Wed, 17 Jun 2026 17:26:03 +0000 (GMT)
From: Jane Chu <jane.chu@oracle.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de,
        david@kernel.org, hughd@google.com, baolin.wang@linux.alibaba.com,
        linmiaohe@huawei.com, nao.horiguchi@gmail.com, lorenzo@kernel.org,
        rppt@kernel.org, peterx@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/11] hugetlb: Convert the vmf->pgoff to PAGE_SIZE granularity
Date: Wed, 17 Jun 2026 11:25:26 -0600
Message-ID: <20260617172534.1740152-6-jane.chu@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2OCBTYWx0ZWRfXygkvXvjvs7Vn
 LCw2qPAuQ2/NaP0rCP+fpE18JwqpNR/h4imOXUkDnQvxvnuN/wYj3lhjOSSX+Rd8Ty+nMxepz4K
 PBgW1GPAzaiLxMbNYCZsPE6kjYp6jPFRHvluvhsDXJ28DZAEP7IJaR9PPYHC9GC4M+LbAkUgpcM
 mxLmgAYEKZQ2ConwRVql1FkKG1He4w/lGcRNMAw8a3/QfCRjMuZQi7TS6a+1z97sPlh3Ze55DRc
 zuxsXDTmhpgGMDspgwrhxajxV00pK3oF8Vg7lBAD4VM6ZCGBzn6hQTJGlEhJeWicIFWPCZxUE9M
 Ox++ZkA4bHaVALKQT7mwMQ9i/cabMa7IagkTPzdZ6gug/NBDbMlh8pl02LUNn+qojrO3Gz+WJty
 hxhkWJ0RVuzpwzy3nLG5oYGatq4j7bcdij5HTQj2zOVjtqyVMSpCtfoCh3Sf3KrOL7/kFMNX/9q
 Mc151jnTRWDfxZ0fMKOsOTrTuav2yd8CcER/Sa4g=
X-Proofpoint-GUID: B2Tr8yMNHDrOaIGpYqPqsR7LgzjOaFBQ
X-Proofpoint-ORIG-GUID: B2Tr8yMNHDrOaIGpYqPqsR7LgzjOaFBQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2OCBTYWx0ZWRfXzi5v5kV0H5F8
 snal7r9uyQdX692nUEnaae2oQGTh/sFAH+jhSoF5d1Geue7EYRAi7AvsMMpgRzrPeD6L1NIa7ZG
 SflPMeMat2OHIiZvNHOP6YnGppSsHnqQNsQ+obRqpGdMMrM5jL6R
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a32d8ac b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=1hYGCskXSv9HRHmUw6IA:9 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312

Everywhere else in MM, the page fault vmf->pgoff is in PAGE_SIZE
granularity, except in hugetlbfs, it's in hugepagesize granularity.
This is really unnecessary.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/hugetlb.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4b80b167cc9c..3255f6b762c9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5654,6 +5654,8 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_fault *vmf,
 						  unsigned long reason)
 {
 	u32 hash;
+	struct hstate *h = hstate_vma(vmf->vma);
+	pgoff_t idx = vmf->pgoff >> huge_page_order(h);
 
 	/*
 	 * vma_lock and hugetlb_fault_mutex must be dropped before handling
@@ -5661,7 +5663,7 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_fault *vmf,
 	 * userfault, any vma operation should be careful from here.
 	 */
 	hugetlb_vma_unlock_read(vmf->vma);
-	hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
+	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	return handle_userfault(vmf, reason);
 }
@@ -5686,7 +5688,7 @@ static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm, unsigned
 static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			struct vm_fault *vmf)
 {
-	u32 hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
+	u32 hash;
 	bool new_folio, new_anon_folio = false;
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
@@ -5696,6 +5698,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	struct folio *folio;
 	unsigned long size;
 	pte_t new_pte;
+	pgoff_t idx = vmf->pgoff >> huge_page_order(h);
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5714,9 +5717,9 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_hugetlb_folio(h, mapping, vmf->pgoff);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio)) {
-		size = i_size_read(mapping->host) >> huge_page_shift(h);
+		size = i_size_read(mapping->host) >> PAGE_SHIFT;
 		if (vmf->pgoff >= size)
 			goto out;
 		/* Check for page in userfault range */
@@ -5778,8 +5781,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		new_folio = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = hugetlb_add_to_page_cache(folio, mapping,
-							vmf->pgoff);
+			int err = hugetlb_add_to_page_cache(folio, mapping, idx);
 			if (err) {
 				/*
 				 * err can't be -EEXIST which implies someone
@@ -5894,6 +5896,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	if (unlikely(ret & VM_FAULT_RETRY))
 		vma_end_read(vma);
 
+	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	return ret;
 
@@ -5947,8 +5950,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		.address = address & huge_page_mask(h),
 		.real_address = address,
 		.flags = flags,
-		.pgoff = vma_hugecache_offset(h, vma,
-				address & huge_page_mask(h)),
+		.pgoff = linear_page_index(vma, address),
 		/* TODO: Track hugetlb faults using vm_fault */
 
 		/*
@@ -5963,7 +5965,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * the same page in the page cache.
 	 */
 	mapping = vma->vm_file->f_mapping;
-	hash = hugetlb_fault_mutex_hash(mapping, vmf.pgoff);
+	hash = hugetlb_fault_mutex_hash(mapping, vmf.pgoff >> huge_page_order(h));
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	/*
-- 
2.43.5

