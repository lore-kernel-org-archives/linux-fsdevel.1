Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3181AB6F1;
	Fri, 22 May 2026 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439115; cv=none; b=scksdL6QWRqbge0YvGVqkBJBBSpdXv365iIEsSohFiFNWtsn91sxCtQ0FcoxWwGVMt0H9c2+YzNEecX+hjW20SPLwp9CBuzBt41GA/RAUc95he2hVvTxwzJLRFHaRbMyBbdR4CNoRC74AcF+pAHEgDILwZxdxxVIByAm5TkNHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439115; c=relaxed/simple;
	bh=aFeiWHHjwplmtqR86PbVfh26F2Yjo6+t+uRET83jyOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pGzZswJz7Gs8xqWbleu07GvBnqPXD03uWctwQAGDMfICeDgrFURz2KglXjfz8J6DFiLSrjpC9GZuuCc9RCnGOSvuVUXALIxR2YTq8bRSITZaLknOLIA+BkpfKtyh6xla4bRakeJB9wZFjMRwQn3VpC8G7K9Xba6lGoFmRtlb69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9696fd8255b911f1aa26b74ffac11d73-20260522
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
X-CID-O-INFO: VERSION:1.3.12,REQID:b2a463b7-03f3-4b19-85dd-2b9ef2b180ea,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:b2a463b7-03f3-4b19-85dd-2b9ef2b180ea,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:4a09e9b9540fcc9e8441bc7c26fc0e3f,BulkI
	D:26052216382141C37NUY,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9696fd8255b911f1aa26b74ffac11d73-20260522
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 164961715; Fri, 22 May 2026 16:38:20 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Amir Goldstein <amir73il@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] fuse: use READ_ONCE in fuse_chan_num_background()
Date: Fri, 22 May 2026 16:38:05 +0800
Message-Id: <20260522083805.569007-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_chan_num_background() is called without holding fch->bg_lock (for
example from fuse_writepages() to compare against fc->congestion_threshold),
while fch->num_background is updated under bg_lock in dev.c and dev_uring.c.
This is the same locked-write/lockless-read pattern already used for
max_background in fuse_chan_max_background().

Use READ_ONCE() on the read side so that:

- The compiler does not cache or coalesce loads of a value that may change
  concurrently on another CPU.
- Prevent KCSAN from reporting an unexpected race.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6254307c07e6..69fcfdfed409 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -401,7 +401,7 @@ EXPORT_SYMBOL_GPL(fuse_dev_chan_new);
 
 unsigned int fuse_chan_num_background(struct fuse_chan *fch)
 {
-	return fch->num_background;
+	return READ_ONCE(fch->num_background);
 }
 
 unsigned int fuse_chan_max_background(struct fuse_chan *fch)
-- 
2.34.1

