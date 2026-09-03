Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163E3932EA;
	Thu,  3 Sep 2026 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460280; cv=none; b=d+dertHjjQ4OtPuWyy6FBtRth6t4LCZPeqpBpT30bGCQn9y2VUHB0meFukWYEkqsdDNwe6iIp88Y7HwKdivtW9+/UMtA6XbqLoRN6+jRI45P4rhyVt+9gN4Zrt3e2QpGFM8CZ3olw11IjR05BLd0VK72tw9CKiCmXUPuS/iBEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460280; c=relaxed/simple;
	bh=0+mcuKAkQa9mHcRqV44JCDODeNMWAzheCMo4mO0u9PE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NFxK/9UgnO45J4qreCqy9cXuUD4zRnWh1GqkCCZSvpTSLYjoVUh7OphgSXt1cJxZv7Ss43cY/kMTAtislFcMQE9HDLY0/NtqFLKC4x9knPRoZVIolhxO3qc369ovLiaSBmtk7SHSekCiZmNdjfQrjbFwqK+X3R5zRlgPJN+EZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Pj0F53Yq; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Pj0F53Yq"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id AC1CB1D27;
	Thu,  3 Sep 2026 18:32:08 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=Pj0F53Yq;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 38A0D21DC;
	Thu,  3 Sep 2026 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1788460266;
	bh=P2ffXHGxJvV1lvLjfTUlLDTK9q1bXPteARV+5BDBc0c=;
	h=From:To:CC:Subject:Date;
	b=Pj0F53YqJsl1xWXCXStcUzHScbOpU9K74wOCDnQvvMqlPNmiM7inkgR4kkaMCE1yt
	 eEZMd8Xcqz+AleWfGSYWpgNEYDDJVm1nva2VTjNIamLmE174QKXptuYtu52U9iLMvM
	 1MLlLWJskKyq3ykSkwdKuMj+fllQCsjZY4QAoIV0=
Received: from localhost.localdomain (172.30.20.155) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 3 Sep 2026 21:31:05 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: use MAX_LFS_FILESIZE for maxbytes with 64-bit clusters
Date: Thu, 3 Sep 2026 20:30:57 +0200
Message-ID: <20260903183057.6171-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

When CONFIG_NTFS3_64BIT_CLUSTER is enabled and the cluster count
saturates the 64-bit VCN space, ntfs_init_from_boot() sets
sbi->maxbytes to -1, while maxbytes_sparse and s_maxbytes are both
set to MAX_LFS_FILESIZE just below.

Set maxbytes to MAX_LFS_FILESIZE so all three limits agree.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index f4a42a0c73a4..d3093f72ea38 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1210,7 +1210,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 #ifdef CONFIG_NTFS3_64BIT_CLUSTER
 	if (clusters >= (1ull << (64 - cluster_bits)))
-		sbi->maxbytes = -1;
+		sbi->maxbytes = MAX_LFS_FILESIZE;
 	sbi->maxbytes_sparse = MAX_LFS_FILESIZE;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 #else
-- 
2.43.0

