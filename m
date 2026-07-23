Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCB044C4E6;
	Thu, 23 Jul 2026 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834393; cv=none; b=sS2fIjwcURx7j4zAsAMHYcgfM/Lbsd1L/dbMBg9sLxdqLVtD4MZQfqfcDGc8SS3dqI0FnvPaZPQXJx8uxpSKkE7QLBHLGSk1oeTSTdoYrdFa5ObU81t5sPxH46/rbVGzWl1YFDhGuqpVPJi0Cj2ruPhpIS1Q6TO81o6WgJCb4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834393; c=relaxed/simple;
	bh=KamDcgJXrnUB0u+JSPwMm4rEqF7tQssKZmQp7GoCVcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dO8ChUfo5QLE4PBXzWlP4UQiC1VyOjO3s/p+4GOTVnaTP8QmEs3MN72G4cac2UcDZXwX6r2gSMyyDGMtoYIBL90Ep6hzmhpKZV/KDLuGK/htc1JmETFFcfZ2crK+OjFqcWYATao7Vg8YYrsgIBEeCvlMXoc43G9/QbuirE7BSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b4DqJSY2; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b4DqJSY2"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NFvUGt1441239;
	Thu, 23 Jul 2026 19:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=V+m/iIR7hJb7+JiQgNr+itgQf56uj
	pPbnQ4UEVHzrcM=; b=b4DqJSY2UWbH4gZqoGl1dPLS4T/qGsFnl82ZhZZyoaRYj
	EIprkDpDScE+6r5tR6nufDS9bN+56RpS9colcXQwSSSXY0Ob9p0B2vOchz2zo4cT
	yRx8N88WgP5+/X11grhBVRD3OtDdTM4OujcnL8H+hiFi7/LqvH4f+Qz1ll9yG4pC
	6MpyMiFi29VXjhqAzHva9OtN13J9qe9oMcRO+2fhPIH/xEGz5ffra8OT8wnqiuUZ
	3VQMY+Mi4J6Z6Yuiewomz8zbSxqJevBA/dKflxoF6e+wjMB7yvtoO2NZuYUNR7Qu
	J4402CDXHttSIVDL9ZJnCMmsfIfwHubZ0e0Hfh2DA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1sqqkyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 19:19:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66NJIAbP037062;
	Thu, 23 Jul 2026 19:19:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxdqevh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 19:19:40 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66NJJeuP003266;
	Thu, 23 Jul 2026 19:19:40 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ffyxdqev6-1;
	Thu, 23 Jul 2026 19:19:40 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] exfat: preserve allocated extents for swap activation
Date: Thu, 23 Jul 2026 12:19:36 -0700
Message-ID: <20260723191936.2419799-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607230188
X-Proofpoint-ORIG-GUID: 05S5oXHD7BWBvlfb9x-gbdoVZCLlW_5a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE4OCBTYWx0ZWRfXz4XaxMY02xOp
 7GeOsZTCdJ58MKzVngg6YAfR3Yhc+Qa/BH/R2QafCqe8It4EHSFxfHMR+PDOfnMx9DBY/vrzB+k
 YAgHWBXofFdCg0zRNQP5aeaIDbK+L+JxcKkRppS5Y7QaNwJXJo9Nd3/px/2OwWYNrl0GlKP9L2G
 V5Tns8j7f7xJCQunZP0+JIHVs+Kzu9H/yZ2R9h0elAjb386VNjEtflLfdo2CXhaMRYJE4stAF1k
 HBZ6Y8e6EA2EtCzNRU5oOtkLPyy2Xxu1EuMo2necrw9OYp3EZgjrOPi20ah9c06ivt99+UFsAOX
 Jo/QuQKWWRVAkQGtRmuQm0YfnZfZsB6ntJpigRZgloO8cAbvFT9txJaEOQEIvU2IiDxjAivr2ln
 QmnshrbdWgHRpGxLxms1khkJah7uOVhgMB8+S+atpU7YeIn6VKkjr2V6o2SQjWk/fuHOBU8VFYk
 bM2wo8g2+fvd4+38U7w==
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a62694d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=Mx0dAVE1lt_1lDOAWLwA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: 05S5oXHD7BWBvlfb9x-gbdoVZCLlW_5a
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE4OCBTYWx0ZWRfX6xLxfaMxRYhO
 AEKTBgULQrO9mzhFjT2uBLZ9nJopISqCp+vbSsOcI1LK9SXa6Rm+QXEuikPr/e1lnhAl4f4gjWx
 /Yowo1PnYP12Q6o9eum4Iivd1CiV3Tx1XW8bauKMvyavWstWR7k9

exFAT reports allocated ranges beyond valid_size as IOMAP_HOLE whenever
IOMAP_REPORT is set. iomap_swapfile_activate() also uses IOMAP_REPORT
while collecting a swapfile's physical extents, so it treats the
preallocated tail as unallocated and rejects the file with -EINVAL.

Allocated space beyond valid_size is not a hole. Keep it as
IOMAP_UNWRITTEN so iomap consumers that need physical extent identity,
such as swap activation, can still use it. The iomap seek helpers
already handle unwritten extents appropriately for SEEK_HOLE and
SEEK_DATA.

Fixes: b4b7fe2c7cbf ("exfat: add support for SEEK_HOLE and SEEK_DATA in llseek")
Assisted-by: Codex:GPT-5.6
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
LTP swapon/swapoff tests failed on exFAT, with this patch the tests
pass.
---
 fs/exfat/iomap.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 190fc6471f84..24d93288a432 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -105,18 +105,14 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 		 * marks the exact boundary between valid data and
 		 * holes (or unwritten space).
 		 *
-		 * When IOMAP_REPORT is set (used by lseek(SEEK_HOLE)
-		 * and SEEK_DATA), we return IOMAP_HOLE. This allows
-		 * iomap_seek_hole_iter() to directly return the
-		 * precise byte position.
-		 *
-		 * For normal I/O paths (without IOMAP_REPORT) we
-		 * return IOMAP_UNWRITTEN so the write path can
-		 * distinguish it from a real hole.
+		 * Allocated space beyond valid_size is not a hole. Report it
+		 * as IOMAP_UNWRITTEN so iomap consumers that need physical
+		 * extent identity, such as swap activation, can still use it.
+		 * The iomap seek helpers already handle unwritten extents
+		 * appropriately for SEEK_HOLE and SEEK_DATA.
 		 */
 		if (offset >= ei->valid_size) {
-			iomap->type = flags & IOMAP_REPORT ?
-				IOMAP_HOLE : IOMAP_UNWRITTEN;
+			iomap->type = IOMAP_UNWRITTEN;
 		} else if (offset + iomap->length > ei->valid_size) {
 			if (flags & IOMAP_REPORT) {
 				/*
-- 
2.50.1

