Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950D3FC5AD;
	Tue, 26 May 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803380; cv=none; b=J+kt1CJYV3Sx8o5dO5zW8k+EDP11/KJ+M1oI3ZUQQ0WjFC3g+JbE1v1HmmDKlZTGwQhc2SsjbqGntzP7ToLObxAbKep/idgtkl5LCPR1EicoHba0ZXwGzbdPqXdnWrPxc3VAbC2WQCwPWckjReBvdUM6l7FdGyQevRaIR2qRGeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803380; c=relaxed/simple;
	bh=et8wV0+Dbpjc2PWdiG74EPolYrWNCm3p+kN/uSHQpxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEp0uTJEJMDSs1Rmn8DODV+nKyiBetVeUgPo058DaIgA+w2BMFbOKQwx0FokxVdUj/1qFAf/eIKDrzdNGce5Ipu6OktXlIiixaFadf+oTIC/8ml+++43KxdlrED7VKK2EA/OkFVIDnKDriYRTQWI+XQp30qzDl04yhkdYI9fMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=MUYleGbA; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="MUYleGbA"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 257AF1D40;
	Tue, 26 May 2026 13:49:40 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=MUYleGbA;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 642611E07;
	Tue, 26 May 2026 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1779803373;
	bh=yBaQf8E1u4/5HLFmn2hNEFmldxSLk3zJlkLM3MEVQUA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MUYleGbAKlFpfi2kPa4Z17BvsK9c5Bwh0xZRl+YgM+H8+Bnxp3043YdKh8p51jbcu
	 y+4lQxZJa7939YKI0mnbwb9vTqwCHUOzjCwICEkCRrmLw42PYRSgtZY/SYq8GtXnj+
	 b9JThA0j38p4XSxtwj7gsejftIeqqPuCz9LpNtB0=
Received: from localhost.localdomain (172.30.20.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 May 2026 16:49:32 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 5/6] fs/ntfs3: force waiting for direct I/O completion
Date: Tue, 26 May 2026 15:49:06 +0200
Message-ID: <20260526134907.11402-6-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526134907.11402-1-almaz.alexandrovich@paragon-software.com>
References: <20260526134907.11402-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

It makes ntfs3 wait for direct I/O completion before returning to the
caller, instead of allowing the write path to complete asynchronously.

The issue was discovered during internal tests.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2d1de3739ffe..26bec5be248e 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1398,7 +1398,8 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 	}
 
-	ret = iomap_dio_rw(iocb, from, &ntfs_iomap_ops, NULL, 0, NULL, 0);
+	ret = iomap_dio_rw(iocb, from, &ntfs_iomap_ops, NULL,
+			   IOMAP_DIO_FORCE_WAIT, NULL, 0);
 
 	if (ret == -ENOTBLK) {
 		/* Returns -ENOTBLK in case of a page invalidation failure for writes.*/
-- 
2.43.0

