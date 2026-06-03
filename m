Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCF2DA762;
	Wed,  3 Jun 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492825; cv=none; b=q4o1t6AFG4mB9MZPJdYw/+Yv95U//MxO38uHA2azIholuOhOMVCTlji8uzheDECSU7+g3zeC990BP73XOQHYC0fLLy1fsb/FKIYlH7XTtlGQ4Rny1chzzU/M4LSaP0QKwtTX0IpNTW4wZNPbkK7sWm+y/qqA6JpeCEO7obsyygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492825; c=relaxed/simple;
	bh=WaHbM4dw3urwv1FrjUmbn8NaogGwjo6+Z24Au0j2G9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRDqE2yiZRAewOS/a0VeqQT5bEbNb6TA5cnkO3WzgLw3l39sEgCxvy+UoRiHf8BtAEDzgZWeTNxeJ0vhKqrSDzvp7L1sbUHLcZVJoxeAOa5Q1o/EQVGBP1mpVQ2SyKGdxxrbjKNdHF2MHLtzrIy8bLZKCJz054FmWQ5lbhJlz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oGmZHw04; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oGmZHw04"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536J66i2666058;
	Wed, 3 Jun 2026 13:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lp1KorMi22wqtTwgl
	TKotYWaH7qZ40qIUIxuqGxStqc=; b=oGmZHw04B/qDj4BfKLjCIlgezHzvuLKhG
	O3QExKl15RC4Cx4JZLBx3T5N0awI4PT36UWPHNDhfq69Fy59b8UhQ7fRHa548cIx
	tFuUgjLilyW9ZjvKDoAeQoQwRypfNtBr81GVpOoXUNvZPOsDeAGXNdtpWFBdQG9y
	4OYNV7pgbtqszSUL8liyzj78steTPAnBQDBWMIIFS570JxrJdnzhzKenEuYSvGpx
	CQ2IVlYoSjmK3k3GPpikIOgHJNq6X2ZrbC6ai1EVyl8I4lV1/sxpw6w4RNVvECrd
	9H2nSkIvAPtMWLXr+YY7lBg+0Y+xggBS3VOhzBv4shoZ2BX+DWPjA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtaf7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 13:20:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653D9HBD029665;
	Wed, 3 Jun 2026 13:20:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhg7ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 13:20:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653DK7YX51904938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 13:20:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA2ED2004F;
	Wed,  3 Jun 2026 13:20:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 927CB2004E;
	Wed,  3 Jun 2026 13:20:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 13:20:07 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: linkinjeon@kernel.org
Cc: djwong@kernel.org, hch@lst.de, japo@linux.ibm.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, sj1557.seo@samsung.com,
        yuezhang.mo@sony.com
Subject: [PATCH] exfat: add swap_activate support
Date: Wed,  3 Jun 2026 15:19:50 +0200
Message-ID: <20260603131950.321858-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKYAXd80+UfzKaCR9YRK8dAQq9S+kEp_VVwr_p3dj1tEeyqUQA@mail.gmail.com>
References: <CAKYAXd80+UfzKaCR9YRK8dAQq9S+kEp_VVwr_p3dj1tEeyqUQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xtv1KypsmP7mjexfAoGwtjvBKPagL88B
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a202a0a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mSQIsEC6K9nzt2GofAQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyNSBTYWx0ZWRfXxS3og0eO5Qkh
 f1x5W9AMMgIiInvSBVOml4D24VK9Q+baKOGF4scIkkV1D17+2cBshFM6TVUBQcgzR9h9JRK29Km
 T22fVsdLXla7AtbDJteUzN/n/cJfImzVHH7izoO99AJF1wHOjHDkfRrP5nK2qsEqgrxS+O314vC
 f5ySJSghGR5zdzwQMpFkaB+VN8+kBTkTAfHZstDyProi5XMajCVv+AcB4foGu/PCOFjGjEiSFcn
 XwmQ4ln762kaLawLRmAkeJwI1cm8wNLgCp+RrIKCG60SxUgAKDI79c1lWEp2V+wbx+e6D57+asz
 q3dRXRLAmDytzhVE2M/ZNVxveso/6S3Ivt1awYCnL2Yp8ZAcd7LGfNehLV7qw4DIlj3UlAOVLNw
 g1DCeI6NgssgJe2Uk2mE3KWvnRNh21S6mlXnv2FLdnWx5iN5eFLGcTAL8zNGhkJ9sAnkkopUQ5D
 PUcapMgb7RYxVtrGVYQ==
X-Proofpoint-ORIG-GUID: Xtv1KypsmP7mjexfAoGwtjvBKPagL88B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030125

Commit 614f71ca1bdf ("exfat: add iomap buffered I/O support")
converted exfat buffered I/O to iomap, but did not add a
.swap_activate handler to the address_space_operations.

swapon(2) on an exfat swapfile then fails with EINVAL, which causes
LTP swap tests to fail.

Add exfat_iomap_swap_activate() and hook it into exfat_aops so exfat
uses iomap_swapfile_activate() for swapfile activation.

Fixes: 614f71ca1bdf ("exfat: add iomap buffered I/O support")
Closes: https://lore.kernel.org/all/20260603110212.3020276-1-japo@linux.ibm.com/
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 fs/exfat/inode.c | 1 +
 fs/exfat/iomap.c | 6 ++++++
 fs/exfat/iomap.h | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 96ea243c67db..3b3ac722cf07 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -496,6 +496,7 @@ static const struct address_space_operations exfat_aops = {
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.direct_IO		= exfat_direct_IO,
+	.swap_activate		= exfat_iomap_swap_activate,
 };

 static inline unsigned long exfat_hash(loff_t i_pos)
diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 188df8cfac9a..54c724cea1d0 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -213,3 +213,9 @@ const struct iomap_read_ops exfat_iomap_bio_read_ops = {
 	.read_folio_range	= iomap_bio_read_folio_range,
 	.submit_read		= exfat_iomap_bio_submit_read,
 };
+
+int exfat_iomap_swap_activate(struct swap_info_struct *sis,
+			       struct file *file, sector_t *span)
+{
+	return iomap_swapfile_activate(sis, file, span, &exfat_iomap_ops);
+}
diff --git a/fs/exfat/iomap.h b/fs/exfat/iomap.h
index 7f8dcbe20a17..295e36312baf 100644
--- a/fs/exfat/iomap.h
+++ b/fs/exfat/iomap.h
@@ -11,4 +11,7 @@ extern const struct iomap_ops exfat_write_iomap_ops;
 extern const struct iomap_writeback_ops exfat_writeback_ops;
 extern const struct iomap_read_ops exfat_iomap_bio_read_ops;

+int exfat_iomap_swap_activate(struct swap_info_struct *sis,
+			       struct file *file, sector_t *span);
+
 #endif /* _LINUX_EXFAT_IOMAP_H */
--
2.53.0

