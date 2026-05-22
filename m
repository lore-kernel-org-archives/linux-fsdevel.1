Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4D28F948;
	Fri, 22 May 2026 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779432899; cv=none; b=h77qKcItVnSa1Gb+MVVttBWnYjEKYPJno6ifVi0lRzSva8rbwa8NbTZvxN6KMNppakSq50pOFF2y1IlY5A8CBlsHVo7oepDfgeBo7AWiFqmSPh9uISCv2LoNciku9TFsZremUkCmV0bTuZPSxCmXLr3OITvyfgX53icy+1njX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779432899; c=relaxed/simple;
	bh=U5sOVv/yNCyRcglTVjW3xvEQXAs7OJ4PjmQztL1SYWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TalOJfZhm6VyrlLzQRgnMnORjqDZhG8LztDyKbsxghg7LIEnxluHVStK7Xsb0tOOrdfbD5BgxDPjdRYTclxCXiHPkMhhEi+w28atRo9mUAmpkoYrH9Wqcd3hzx4iT+Xpj7lsotx7soxHdxUnZvJjyoPNp6EjRleL9rxVUnFvr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1f149a1655ab11f1aa26b74ffac11d73-20260522
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
X-CID-O-INFO: VERSION:1.3.12,REQID:baf8d973-c655-4cb2-a8d0-980327f340d8,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:baf8d973-c655-4cb2-a8d0-980327f340d8,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:a4a861ee5bf5291101ab7399b71da166,BulkI
	D:260522145450X93SMSB0,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1f149a1655ab11f1aa26b74ffac11d73-20260522
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 612030211; Fri, 22 May 2026 14:54:47 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Amir Goldstein <amir73il@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] fuse: drop redundant initializer in process_init_limits()
Date: Fri, 22 May 2026 14:54:21 +0800
Message-Id: <20260522065421.385129-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local max_background variable was declared with a duplicated
assignment (max_background = max_background = arg->max_background).
Remove the redundant assignment.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0897f8e62b4d..c3689f4f7beb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1246,7 +1246,7 @@ static void process_init_limits(struct fuse_conn *fc, struct fuse_init_out *arg)
 	sanitize_global_limit(&max_user_congthresh);
 
 	if (arg->max_background) {
-		unsigned int max_background = max_background = arg->max_background;
+		unsigned int max_background = arg->max_background;
 
 		if (!cap_sys_admin && max_background > max_user_bgreq)
 			max_background = max_user_bgreq;
-- 
2.34.1

