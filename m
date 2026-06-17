Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C683033DE;
	Wed, 17 Jun 2026 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717262; cv=none; b=fs0hLGh+EJXSEz4YffUwFEQItjHy5vo7R23K9IOIe0Rw3PAdJ0G6B9Ks7UU/l0uhIos0P8V0xeigBNEdJbdx+2C6DIBmwgjIzrH6goQb58050AVnDdCaJxJ9bNE7HW4VEe9YlKBy3oDVP9Z6jzIAQ9ZHlX9K22bCW0gGfiNKm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717262; c=relaxed/simple;
	bh=Yy95E/nFvLqIM411F3AtlmedWwmD46czselFYjCS0Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kST9AfltwKXTn3eQUqL0dtTZowqfq27d/NpIWJzz/YQDZ9bAaKUjcLA+QbwN9+HlR6fLuLO3tlAJzBbAYOuFMirEc/jaJgRJacToQLoU4JOjxyeykAWO3MikR3O6QsZ9PhC8Fpb95wjhYXGcOhBiWEu+lWfhFOyvqepJ81nV36Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TkfPSTuX; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TkfPSTuX"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEpTrX2364580;
	Wed, 17 Jun 2026 17:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=QzgVr
	wBLp8IJXktshUBMWJeuGythVYw1ADhUnzQfp+I=; b=TkfPSTuXbDp6jHJr3ZM8V
	V2T5jmX/NTroedg/cWYptuRyE+mWJvMwHoMx+0Xal1CN4jiNcX+X1obw+tlFNk0s
	t/xDAC2HpqotcnJpq69rA6O86iQl9w2YE0XZxHjNIA5bNlIgGppGZ25J+p9bmBsy
	9TQA3n1qbObwqr1HKmpm4bzEsCShuEvCYRnh8QMrA1wvNzsVxqj+lu5jL5sU3/Ag
	pOIi6S/PmJpydRA8VxYdHp/6gCGFrMBuBlAOPLGRQBICAl5/UEldFh83vFxZ1bTR
	NTAsneqjfttwwDZ0mz80PD3nq9ZfgaPaVf1aq+f/WE2/rpltd4GOUjngnHKQFPSC
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4euegm1bbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 17:26:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65HHNVP7003778;
	Wed, 17 Jun 2026 17:26:22 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4eudvc0wgy-11;
	Wed, 17 Jun 2026 17:26:22 +0000 (GMT)
From: Jane Chu <jane.chu@oracle.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de,
        david@kernel.org, hughd@google.com, baolin.wang@linux.alibaba.com,
        linmiaohe@huawei.com, nao.horiguchi@gmail.com, lorenzo@kernel.org,
        rppt@kernel.org, peterx@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/11] hugetlb: drop vma_hugecache_offset() in favor of linear_page_index()
Date: Wed, 17 Jun 2026 11:25:31 -0600
Message-ID: <20260617172534.1740152-11-jane.chu@oracle.com>
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
X-Proofpoint-GUID: _2XpTPAb0pPOlVVX2vqjml7rVmYBfAkf
X-Proofpoint-ORIG-GUID: _2XpTPAb0pPOlVVX2vqjml7rVmYBfAkf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2OCBTYWx0ZWRfXwYhGeHbVeG0J
 ViHY/88UQDIzz9RfW+U/aJSDz6gNMoMp6kgvt+KTfVfpZVTtW8zHWVbr4fwnSXhBkShiaKOhT0u
 es5prhNVrNdGTeRlwgDlaNp9PcJ6XfrYN3Za+ucQWk8wCbbK7iCpVw2IilHPB83fBck3P2lxeur
 JCMaOb0vc0wEW+GgWSRTMdPcZjpl4BQNCd2YLO0w3uvmI+tS3ss+GzS+y1H/wDxh4FM+NHaZRxY
 rlL/No4TG/lq1cTzcnHCX0WaTbizkMJS1VcwPcRKXVkbzWY23Pam7AQA2qpNOfxPPyNc6k2fUvA
 yPwZ44mc6kvntLrguE3OX4nff/1sDk9KmdPD1hAF89Tg7hVYBupf8aFEt4M9MXht7XghpRAussc
 Hp4z33GTV4UPPUWd1SfCF2eq1FD5dxiuSlT+g8SZ3UN5099gRoyRT2ui7i7g6gToVtlg20lvZ/E
 W4/BrahvJNTFbtv2Hz8eRUzQjdSnuYYR8bxrGa3A=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2OCBTYWx0ZWRfXwxKHnVXHdZyI
 tLYXcyjS+uOD1UgGTcVjmKSlmowo4S+P9wtPWWJ61zn5rKya4e1EEVSxM15hbdgI+oBoyJdih8Q
 pYANUuF9FbcDeGmluYe1kxhbbd9+pxYP4lnHaCRDopPp2jLvPlDH
X-Authority-Analysis: v=2.4 cv=G4Ys1dk5 c=1 sm=1 tr=0 ts=6a32d8bf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=g8M0rzeWxNo8AqK0pVkA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312

vma_hugecache_offset() converts a hugetlb VMA address into a mapping
offset in hugepage units. While the helper is small, its name is not very
clear, and the resulting code is harder to follow than using the common MM
helper directly.

Use linear_page_index() instead, with an explicit conversion from
PAGE_SIZE units to hugepage units at each call site, and remove
vma_hugecache_offset().

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/hugetlb.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b41e7b8df094..a677ea774143 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1001,17 +1001,6 @@ static long region_count(struct resv_map *resv, long f, long t)
 	return chg;
 }
 
-/*
- * Convert the address within this vma to the page offset within
- * the mapping, huge page units here.
- */
-static pgoff_t vma_hugecache_offset(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long address)
-{
-	return ((address - vma->vm_start) >> huge_page_shift(h)) +
-			(vma->vm_pgoff >> huge_page_order(h));
-}
-
 /*
  * Flags for MAP_PRIVATE reservations.  These are stored in the bottom
  * bits of the reservation map pointer, which are always clear due to
@@ -2437,7 +2426,9 @@ static long __vma_reservation_common(struct hstate *h,
 	if (!resv)
 		return 1;
 
-	idx = vma_hugecache_offset(h, vma, addr);
+	idx = linear_page_index(vma, addr);
+	idx >>= huge_page_order(h);
+
 	switch (mode) {
 	case VMA_NEEDS_RESV:
 		ret = region_chg(resv, idx, idx + 1, &dummy_out_regions_needed);
@@ -4693,8 +4684,10 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 	if (!resv || !is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		return;
 
-	start = vma_hugecache_offset(h, vma, vma->vm_start);
-	end = vma_hugecache_offset(h, vma, vma->vm_end);
+	start = linear_page_index(vma, vma->vm_start);
+	start >>= huge_page_order(h);
+	end = linear_page_index(vma, vma->vm_end);
+	end >>= huge_page_order(h);
 
 	reserve = (end - start) - region_count(resv, start, end);
 	hugetlb_cgroup_uncharge_counter(resv, start, end);
-- 
2.43.5

