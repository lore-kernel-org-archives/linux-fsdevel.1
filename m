Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80096254AFF;
	Tue, 25 Aug 2026 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636869; cv=none; b=j/yQJUPqiyihm338PR+12RsTOW/5ioqtEwKsMS/uBDyxnpNYHUhnCF7yUMlzzbREpahA6AnufYaXnbKQUpvv87/s5oI7FLNMQGpd6jMhdoNokHE2sHRMplAH5FM/pm4vf4OFtotBN0aEPAC252YC399XOkOZA+sP055aAP6vtyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636869; c=relaxed/simple;
	bh=7TyKq0Pz34plG+S9NBtxDyIPK3EjqiAo12Jnj5rgtDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P0XuJD77abzalz+nbZUyoa5s3OdCyVifemxQ7d/Z37qV18vnyZeFtNWKY0EIiArcrmblDAg5JBS+zUOjPsZtVtdCeS3r28LnJGfOBeF9RD39FpX+0Xv9QT9sUv/ySIhQ5K+j56JPIGq/dj9SCN3jKO2qrK7lkIGkcF/G0yKNDow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TetTreyV; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TetTreyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787636841;
	bh=/+4S3sOALGFjRBbezfbkmsBdIDkyWibUdwQ2coYo/oI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TetTreyVGPzdtwDpOhMn+woPBHGXi1HSXV8Ns3ldwPdPHRNAaphFwI7090/zOlONM
	 fK9Z4xtXCoa7mXg0v4wF8O0S5lqHW69Bh49GftxybQoSRc68EKHKustov/pkQEG1Wj
	 uwah8+9NPt9wykyOBg36IOwxaJWGem8ha4Y//g6c=
X-QQ-mid: zesmtpsz3t1787636824teded12e0
X-QQ-Originating-IP: 7wmUgRTrE7D1R/UwgJnlnBMT9+GHE2U2lSCnqd4ZNhk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Aug 2026 13:47:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11704938617123575298
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: linkinjeon@kernel.org
Cc: hyc.lee@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] ntfs: treat any nonzero dio zero-range return as an error
Date: Tue, 25 Aug 2026 13:46:59 +0800
Message-Id: <20260825054659.3967694-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MX+1SEN3H+wAYS2t+IWsgNe2LAyuURZC5E2YZJVKuMiF0y2OG2ojTqrc
	prd+zxc3msbQ9Vm68eu1478R7K80SreHt7XrQFSLKSWjRrY8uJjv68fqntcVsA6ZM3fgAQW
	KzrkBKvk9QsgaUWBecS7xce5B14in+1/LiIWfFh9n7mk+bt+qK18mpMcTlrASemsCmL9RH3
	EfVxwvGWJmmgj2wh8W1G8T8MQIoiMI552mYuY7vVJIOpZ9qgiPH8xOiaWvk7VqzzShBDg7W
	8gyeNr7cGqdZYWjBbnyts6fK/s2s2SZQp5oSdrm9Ws6utddb34muW3FfDE7JA3vk/Wun/lG
	bx0ogJ9wkEWaarSNukRooTGO+TxdoJTH2oa98TyYTjmfjoEuys3wU6bL5R7UR6nLKTqAu7q
	UsqgFw9fLcBYW9gB5hs39yjml4xZJTlN9z9MEOip6CSGooEX6E4U/Z+B0SPwGJNxeplYJ1V
	uE7sHPQZDX8jXF7m9NCvOQspNEfmV6CtlUV08BSDk3hoI8ETDpPrMSpG7psPOeN3y1ADZ8w
	FtmA5fgHioghxIuJcmdb5yeYn00PyBxy8lY6tcnZ7I2D8X0Mk+4QD/Y1wWEDa2RHj6qu0bI
	xL531N/dpXLH+kiOfhV00ETQrCUexuIHXubkmPnUlzfkZdcBq4QcjWQLqAESZFPIIhs/tFB
	/PLngYJ2USzTqNwsUAcJixgjGvF1fMHFu/z1cYc/Kj4m9gH2M3PSjYfSrsS7OpsGjDKl4Vb
	o41X01ofZrTg1iJ1xAAfIa7MxLCCcFcnKo5JBylWCAAv0oaxg0CHb5b8oba25aLwpA5kyq2
	TI+GdR0tXorTB17sZg8kckIXmrkZOSmbVuS+f7tQEgWmbJIz+WWGDQxnRTIHKSikE4A7aNg
	OI6sWeZJD29E+e+K6y1Hr8icAvyMmjudRfva1t3wZd6C+SK5j/vWtXqFIrV22Jk3ET55ZAF
	ZSqfa8WDIRmD0YCNxUv5bLcIMtna55yxu3Ek7f0f5RrTaJH/mF+2aiz9olGQMjz5ql+1lJu
	qvO7ISTYVkdpRBdm6mRlj1/GKvbn6OmQLTYn/UxPvweFQRB0S/QBXCI4UN/84=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

ntfs_dio_zero_range() returns either 0 or a negative errno from
blkdev_issue_zeroout(); it never returns a positive value.  The
zeroing failure check in ntfs_attr_fallocate() therefore never fired,
so a failed zeroing operation was silently ignored: the loop kept
going, the newly allocated clusters were folded into initialized_size
and the write could succeed leaving stale on-disk data.

Treat any nonzero return as an error and abort the allocation.

Fixes: 495e90fa33482 ("ntfs: update attrib operations")
Assisted-by: atomcode:deepseek-v4-flash
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/ntfs/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 58f32aac5f614..b50413a5d982f 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -5666,7 +5666,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
 								  lcn << vol->cluster_size_bits,
 								  alloc_cnt <<
 								  vol->cluster_size_bits);
-					if (err > 0)
+					if (err)
 						goto out;
 				}
 
-- 
2.30.2

