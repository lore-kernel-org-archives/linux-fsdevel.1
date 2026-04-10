Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FFB1A9F9B;
	Fri, 10 Apr 2026 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788509; cv=none; b=owne/no0qiBqdJkG+f+FlSduGB3SeftBWrw4GwwXWVzRUSCuCVSF7S2FWcjKWSPx+WIQsexTfQ725DsHx68yVDtcsdh2izqNZjOpt5lI7oxSNjBK7gEMHuEELYtKqNeRYSxp8n95+0i8sAsjyQFJsSMmSxnXbQdbo4hzPj9vq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788509; c=relaxed/simple;
	bh=AB4Jxqj0ONe0klwvup1usz2oF1ZqWalSoS7YlYpt9ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBWFBpT4p9bwpVZnkl8CSd/Z0h66Io37ZJSswvAalS572BW8ZUrm5+UFoMCFVryt/7594JdGQG1tPI2QpMj3cft8H3NlBGemaN5VizqcP2iL6aCwJKFgeaDUgORcWCv/C8zuPe2/uqIBFPrXSwyrx7sUtmJ4nRk16rwbzM24SQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: decf53d8348511f1aa26b74ffac11d73-20260410
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
X-CID-O-INFO: VERSION:1.3.12,REQID:2a534ca5-ba3b-4dc3-ad88-18ebc3dae03d,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:2a534ca5-ba3b-4dc3-ad88-18ebc3dae03d,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:d428b67e9579b3ce2dfb8dceb935a415,BulkI
	D:260410103502EFESI38X,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|1
	27|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: decf53d8348511f1aa26b74ffac11d73-20260410
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2003795267; Fri, 10 Apr 2026 10:34:59 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH v2] fuse: drop redundant err assignment in fuse_create_open()
Date: Fri, 10 Apr 2026 10:34:33 +0800
Message-Id: <20260410023433.18969-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409030457.4632-1-liwang@kylinos.cn>
References: <20260409030457.4632-1-liwang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fuse_create_open(), err is initialized to -ENOMEM immediately before
the fuse_alloc_forget() NULL check. If forget allocation fails,
it branches to out_err with that value. If it succeeds, it falls through
without modifying err, so err is still -ENOMEM at the point where
fuse_file_alloc() is called. The second err = -ENOMEM before
fuse_file_alloc() therefore is redundant.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
Changes since v1:
- Per review, removed the second paragraph of the commit message.


 fs/fuse/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f7443ca37e35..b118cf23d41a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -838,7 +838,6 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	if (!forget)
 		goto out_err;
 
-	err = -ENOMEM;
 	ff = fuse_file_alloc(fm, true);
 	if (!ff)
 		goto out_put_forget_req;
-- 
2.34.1

