Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA1253950;
	Tue, 21 Apr 2026 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776742729; cv=none; b=RtYEGAQR/Fii2gQhgK69nlp4Fc6pzLFG+CitCMlITAN8bSaSdMUpxmYNj0/bUFNkBYGjg/BtZZ+n3JMJ4Z9RrbXExuafca4pWzMPREb6VNwkkoCtT05fG8p5OQnsiP9l+PXyzXFhqg4hOy3MonuSjby3DyonccDk71ygK48r1fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776742729; c=relaxed/simple;
	bh=D9zMQ/773OJR/dc88qDEBvUgr5UgNov9DUSR3EZHqQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l72BVPhOcSjA3cW4uX+NU2ySqCumZN+3dYGP7rI/lmeEyLWYnZ4PlQrmRqybbBeN+MB8V5wC4kONxDELtyjFwZJKuaotnkWsZw4SOft2S28keiUk2Rcqw8MsSKWypayhaDKdAKtfd3XrobpVy/01+mnW4LYVrdl+AjM10OWVuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 92ad6baa3d3311f1aa26b74ffac11d73-20260421
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:dba5c631-efed-4345-b160-88cbcaeef477,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:dba5c631-efed-4345-b160-88cbcaeef477,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:87479b67e444e61b2a547804cc45fe23,BulkI
	D:260421113836UDFK82QM,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|1
	27|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 92ad6baa3d3311f1aa26b74ffac11d73-20260421
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1594863276; Tue, 21 Apr 2026 11:38:33 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH v2] fuse: drop redundant check in fuse_sync_bucket_alloc()
Date: Tue, 21 Apr 2026 11:38:16 +0800
Message-Id: <20260421033816.6546-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420030900.4944-1-liwang@kylinos.cn>
References: <20260420030900.4944-1-liwang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kzalloc_obj with __GFP_NOFAIL is documented to never return failure,
and checking for NULL is redundant (__GFP_NOFAIL in gfp_types.h).

Signed-off-by: Li Wang <liwang@kylinos.cn>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
Changes since v1:
- Per review, removed the last two sentences of the commit message.

 fs/fuse/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 33009227e91d..e5069d2f8e90 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -676,11 +676,9 @@ static struct fuse_sync_bucket *fuse_sync_bucket_alloc(void)
 	struct fuse_sync_bucket *bucket;
 
 	bucket = kzalloc_obj(*bucket, GFP_KERNEL | __GFP_NOFAIL);
-	if (bucket) {
-		init_waitqueue_head(&bucket->waitq);
-		/* Initial active count */
-		atomic_set(&bucket->count, 1);
-	}
+	init_waitqueue_head(&bucket->waitq);
+	/* Initial active count */
+	atomic_set(&bucket->count, 1);
 	return bucket;
 }
 
-- 
2.34.1

