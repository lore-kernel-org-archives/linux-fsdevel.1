Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02D48382C;
	Thu,  1 Oct 2026 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837865; cv=none; b=BqQ0KQkxkx2/MGJ//lyS4hzGHQGgb/vR/NonLWwc98LIWUNGp/UqA6IlZm1yAlHUfgf76jUoLKmyWIyMlcsjg5meKxI3R1+0WLUrX3Lnq9lnHBTa8AZbnS/pfO3oJXzd0EV0V8TOBCDRNOqcvKdyGRsJTfKr3jfF9ETStjYU0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837865; c=relaxed/simple;
	bh=Ovgx4yE0Nv8I4zUhnxVypT5WiUdj9t7zSHLC/ou6c9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4pok+ANrDHC+7wi77I4tjlJQ6rqFDqC6jl3munUokYDFLAzOCr72V26oF6fgonCommu1xyFhm9D0QJFC5DZ33qJ/+4wlPufSiXSts5yOVMMID81jhFsOLIMQMq7scSumkwK5QZNTZSHUj51NNck5tGo309cMkXAQyETsZ6+8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IxfcBS+0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IxfcBS+0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69145k9g545173;
	Thu, 1 Oct 2026 06:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sB9Kl98M4g05Q6Zod
	zeARAcgBjB/j7Y3a1Jqm0dpHAs=; b=IxfcBS+0diz1tj1/+8iDJXWZot+lpmkvD
	O/z3eu4I7Unz7F4hXA3P74BK8MplFtFDmblwZkXJ9s2DZXIaxQFi0tjQLBvmZ8iw
	Sx6vVN1ErLgG8IAzLcxkdZqC+WkE5Zl74ypUoK1POIypwlDjD6V+2+jVp+LeljLa
	j1+9/nvWBim+qYhve94M5FTpTFRAoCSgtBBuQi2sSguNltKL5nJTjxYyP777/IK7
	v4MvopDjXdhk/Vfzj8F85DtXFj0ScGaa0nQ6uwTXWC4kGU/mE8gF0HVpAV39N0FS
	J0+cX1ZExCKGvjJ7Fd5xvYQZ4Xbq4FM6MA5nj/NGvXXPWUvOL4H6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkgvsp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 06:57:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6913lXsN306133;
	Thu, 1 Oct 2026 06:57:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpfhuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 06:57:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6916vcJn56164736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 06:57:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BF6C20043;
	Thu,  1 Oct 2026 06:57:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AF8920040;
	Thu,  1 Oct 2026 06:57:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.119])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 06:57:36 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: brauner@kernel.org, shuah@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 2/2] selftests/empty_mntns: use unused bit in unknown_flags_rejected test
Date: Thu,  1 Oct 2026 12:27:28 +0530
Message-ID: <20261001065728.90239-2-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20261001065728.90239-1-disgoel@linux.ibm.com>
References: <20261001065728.90239-1-disgoel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TMS33rbI5svjczjIRfe86hXb0xAmWl5O
X-Proofpoint-GUID: TMS33rbI5svjczjIRfe86hXb0xAmWl5O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAyNiBTYWx0ZWRfX+aHvgk2VWNGG
 /eKvokQEcmW15Md4EeHkwRNJjz4GU14gkX1Tjf2gZiglTWqkZkJwJygTbd7FLvYG4eNaIoMNwL7
 1VLLlnRg081PIZdr2mFV0csRsDnrNbY=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe0465 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=73pJN9SDiJRU2kfIkCIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAyNiBTYWx0ZWRfX0NFI4MrLfEbr
 lCMMstLgOvB32yey6X9JlfqLXYqrsOpS9C3uATyPp9KHzGTKoRvokrOis29PT2ljStC4kg4vZ3d
 w5nYCmy52SHv9V8oxpVEUPoDgD/Tc5nD9SRxG+Lbq5WV8rX0c4YELyByqKlUZpIgT0XEyou17eT
 UfCgfowx95ehR7yM7tLmOEKZ/ivuVhffAa6NTundccuuv4pGxYymZNpPXXZDbNvWs+y0yXS5Pum
 cs+1L7gkvPs7YIgPssDsnb9xWDXZGoOJY5XZrEOCCqHEGkvRyInoUu1rHtYDNpSOW3hBK6WepTW
 A4nN9rnY5Y+CLb2hCGXyPv9hEfij9kH2DGnbtREqD7yTD3rcNb5rmd5Tpd/HRrN7ZTjIL28nHGi
 p5rP6tXLJ1VWy1PZUWrqrX85rTx2whGly8tIDLYxgKL5lrkt1vDpVmrXRglWb/9nJGSPXmAjwJ/
 RBLZ4jmq661oPGdYh4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010026

The unknown_flags_rejected test uses 0x800000000ULL (1ULL << 35) to test
that clone3() rejects unknown 64-bit flags with -EINVAL.

However, bit 35 has been allocated to CLONE_NNP, causing clone3() to
succeed and the assertion expecting failure to fail.

Switch to (1ULL << 63) which is an unused high bit so the test
consistently expects -EINVAL.

Fixes: 5b8ffd63fbd9 ("selftests/filesystems: add clone3 tests for empty mount namespaces")
Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
 .../selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c b/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
index de0cbd1a5ee0..b271fed3ae70 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
+++ b/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
@@ -868,7 +868,7 @@ TEST(unknown_flags_rejected)
 
 	if (pid == 0) {
 		struct __clone_args args = {
-			.flags		= 0x800000000ULL,
+			.flags		= (1ULL << 63),
 			.exit_signal	= SIGCHLD,
 		};
 		pid_t ret;
-- 
2.45.1

