Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BF2F84F;
	Thu,  9 Apr 2026 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703963; cv=none; b=lpygOwafBUKkKJPmhFoA2nmoTaV02Lvvd5c0ji4uOXMLHHbxBxUBoUpaiIGzlj+qvipScaNz/G/4pv+knxwGPGFVutb0dBKH6X76rOQKVyohd8LFt5wDpW2/CLeEjmFLyzeODoUSb7zfREtzfKCkJxwJcYgvlZFW3nu2JJ7mAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703963; c=relaxed/simple;
	bh=/B3wYGv6hNrVQLFN+vO+rg1HAtXwVzm6twn/XIgFd1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=II0JC0g1ZG4GdOn3DMdyVg6cZZBJwWy3W8hyIUt/vVzdRuDOHFVEoDRe1T/qsWOYAIeEfYP0Z4CV4ySiwdSjyDtfWioq0KYgp4mOns/lVng44kLQVL4ldHLInTR5k4vzpJ0kA3LHXGuBiAPe2s03x6xgU7XTP1twStH+WckwUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 05ffd5d833c111f1aa26b74ffac11d73-20260409
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
X-CID-O-INFO: VERSION:1.3.12,REQID:9352e855-de0c-422b-b691-7cbe150b86cb,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:9352e855-de0c-422b-b691-7cbe150b86cb,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:d683bf1bee2005505f7a6e012e58f104,BulkI
	D:260409110555QNJ4QMI8,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|898
	,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 05ffd5d833c111f1aa26b74ffac11d73-20260409
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1308210033; Thu, 09 Apr 2026 11:05:54 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] fuse: drop redundant err assignment in fuse_create_open()
Date: Thu,  9 Apr 2026 11:04:57 +0800
Message-Id: <20260409030457.4632-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
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

Removing this redundant assignment not only improves performance
but also makes the intended error semantics obvious: a single ENOMEM
initialization covers both allocation failure exits that share
this prelude.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
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

