Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F8207A20;
	Sat,  9 May 2026 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778322254; cv=none; b=jRBVlPBDQnrU43vzB2HocmQR9TmwG4j6TivAjVTdooJN4JEsQW5DeTSETQC19ocxyog/l0zVTVR3zfYmisNo2vNp13YhZomU+XNjhn9hdwXUkILP8j38Lc9EjvO8l46d3Il66NQcgcVTB2m7Dhr98BF/AaRupyX0kSvGlGKog8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778322254; c=relaxed/simple;
	bh=effh9FiMCpG/KCbsBZM4y9jBZgDzOBASZ2f730uFOfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sherl+tc5xp8D0ocfPERmTpOO2kEJN/aa4UWBZ6fGiP4Ws+dUD2+yJIqZYAkJX3bCs9182y27MMhqoxVkI4WNMSjg5iMRl8jXkzsbRZK+lQGWjWuIlITM6zpd7/zGOeISoHjcds+1N5YkKgLuynZi179cK5bniQEe4Jo3Oq5KrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 365220e64b9111f1aa26b74ffac11d73-20260509
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
X-CID-O-INFO: VERSION:1.3.12,REQID:636394cb-98d6-41a8-b242-17293e4be515,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:30
X-CID-INFO: VERSION:1.3.12,REQID:636394cb-98d6-41a8-b242-17293e4be515,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:30
X-CID-META: VersionHash:e7bac3a,CLOUDID:f66cd899e010dcf5fc334815cc6aa947,BulkI
	D:260509182409UIY5CZLL,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|898
	,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 365220e64b9111f1aa26b74ffac11d73-20260509
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1407622702; Sat, 09 May 2026 18:24:07 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] fuse: propagate async RELEASE queue errno in fuse_file_put()
Date: Sat,  9 May 2026 18:23:37 +0800
Message-Id: <20260509102337.272593-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_file_put() queues asynchronous FUSE_RELEASE via fuse_simple_background().
When queueing fails, the failure branch always passed -ENOTCONN into
fuse_release_end(). fuse_simple_background() can however fail for multiple reasons
with different return values, such as -ENOMEM or -EINTR. Pass the actual negative
errno into fuse_release_end(). Currently, the callback does not interpret it,
but passing the real value avoids misleading future development or debug printf
that assumes -ENOTCONN meant disconnect.

Add an explicit (void)error in fuse_release_end() so builds that enable
-Wunused-parameter (for example make W=3) stay clean.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/file.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3bdab8d03373..8b7badb7721a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -96,6 +96,8 @@ static void fuse_release_end(struct fuse_args *args, int error)
 {
 	struct fuse_release_args *ra = container_of(args, typeof(*ra), args);
 
+	(void)error;
+
 	iput(ra->inode);
 	kfree(ra);
 }
@@ -117,6 +119,8 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 			fuse_simple_request(ff->fm, args);
 			fuse_release_end(args, 0);
 		} else {
+			int err;
+
 			/*
 			 * DAX inodes may need to issue a number of synchronous
 			 * request for clearing the mappings.
@@ -124,9 +128,10 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 			if (ra && ra->inode && FUSE_IS_DAX(ra->inode))
 				args->may_block = true;
 			args->end = fuse_release_end;
-			if (fuse_simple_background(ff->fm, args,
-						   GFP_KERNEL | __GFP_NOFAIL))
-				fuse_release_end(args, -ENOTCONN);
+			err = fuse_simple_background(ff->fm, args,
+						     GFP_KERNEL | __GFP_NOFAIL);
+			if (err)
+				fuse_release_end(args, err);
 		}
 		kfree(ff);
 	}
-- 
2.34.1

