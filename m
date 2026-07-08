Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263101D5160;
	Wed,  8 Jul 2026 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477062; cv=none; b=cvMoe3QWTPw1VZfz4y6IdT+GfZ8wDBMp6z/8N/n+0XJxdIJZmX/zPfUDfJ5FUCr6nGxc50C/BK8nJ4aL9yfQPFiJo65Indrla8nQ6JevtfsRwblyWyF3KboxUOJPntBRn3iEYeCX1ZczEzLJw5PiIFwYHppWKThQzHW5OLdQZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477062; c=relaxed/simple;
	bh=VTpuXugbb3driSBNByNtnQMoPDWn2BXFDTWYR9hWO0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FjqvVYK+2J5Bld2XxhV2pJS4oqx9AlvcuVm/9UcADryJ7IrB1i6cvhcYrAn/2n5Io7tSKCzq7j6rxYOSBWJtNlgqhJQdgaWmy/c6eYbu627WVzNLEPMVFlZLDsM5KG3N3Hy9CK6aGPAPA+NN9crhV5+MsGrOmbGFGgN1XSfd/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2d70450a7a7311f1aa26b74ffac11d73-20260708
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c4543caa-e37a-41ab-9817-4137638980be,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:c4543caa-e37a-41ab-9817-4137638980be,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:3afa366ae6f3ad8bd8e6f7dcf514b09c,BulkI
	D:260708101733F4N6G4QB,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2d70450a7a7311f1aa26b74ffac11d73-20260708
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1372840259; Wed, 08 Jul 2026 10:17:32 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Amir Goldstein <amir73il@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] fuse: drop redundant err assignments in fuse_dev_do_write()
Date: Wed,  8 Jul 2026 10:17:05 +0800
Message-Id: <20260708021705.3436-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After fuse_copy_one() succeeds, err is set to -EINVAL before validating
oh.len. When oh.len equals nbytes, err is already -EINVAL, so the extra
assignments before the notification and oh.error checks are redundant.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3b37..7813f6214d0e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1887,7 +1887,6 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		 * Only allow notifications during while the connection is in an
 		 * initialized and connected state
 		 */
-		err = -EINVAL;
 		if (!fch->initialized || !fch->connected)
 			goto copy_finish;
 
@@ -1898,7 +1897,6 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		goto copy_finish;
 	}
 
-	err = -EINVAL;
 	if (oh.error <= -512 || oh.error > 0)
 		goto copy_finish;
 
-- 
2.34.1

