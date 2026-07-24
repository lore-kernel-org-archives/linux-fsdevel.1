Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA223D47B2;
	Fri, 24 Jul 2026 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891698; cv=none; b=WYo/+906FeA+VaF6iSAvezCpH+8dUZh8+onXpz3f2H3Iaa8CQYMwlpYotP4piDWlKp5T7qV7jXxNUABSVRhw83iAPjysvZJS+XkK6ubqjDU4zy0NowhQ6dVy8hRTDvT22RxcHMtufQTRSsjJtT1hRCtQ4U8ou9ilYt5534ihzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891698; c=relaxed/simple;
	bh=rCKRoZaVAvYBfidfA6J+WP837/BYIESWmT/BdCHWs90=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eSuKOSnil1kjVSHwUpawqxCC1y9/MzOCwAp+xtNyeABuk5pZSAnweG8958gWfwurM6maA+F43iwlYuWqqA2Gv9hF5HnaFYtzc98nTUTMyclqtonIelmQa2ns0SbXaGEis2FDiUTS4387RKj8NrKbyoT4NEUWIkMmqPjq0lhr0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=uz8ZFwwo; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="uz8ZFwwo"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C051E241;
	Fri, 24 Jul 2026 11:15:12 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=uz8ZFwwo;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5977637;
	Fri, 24 Jul 2026 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1784891692;
	bh=+X30ns/DHvn0q/g9YrdFO1eRmQb4aM9ivnaZPK3pBLw=;
	h=From:To:CC:Subject:Date;
	b=uz8ZFwwotVPYQ8ygSR4b2ybvmzgQ2x/ufnCBsLjE+k6Csv4vKtGQmCWoa9Q+DCNRn
	 GWaFHOyrSzMJsCSr7kh+j3FF5odBL6J+07BrbG7B28se5oJdfJrI4LtN9Ob/Kia1Kl
	 1lFDqC5sKftkkUaIX90ZwgwtTttGcsLYqilNAmFg=
Received: from localhost.localdomain (172.30.20.208) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 24 Jul 2026 14:14:51 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Fix memory leak in indx_find_sort()
Date: Fri, 24 Jul 2026 13:14:43 +0200
Message-ID: <20260724111443.14728-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
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

When popping a level from the index lookup stack, indx_find_sort() frees
the struct indx_node but not the index buffer it owns. Every call that
descends and then pops a level leaks that allocation.

Free n->index before freeing the node itself.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 4afacfc6ff89..689712d3463d 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1325,6 +1325,7 @@ int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
 		/* Pop one level. */
 		if (n) {
 			fnd_pop(fnd);
+			kfree(n->index);
 			kfree(n);
 		}
 
-- 
2.43.0

