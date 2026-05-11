Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D03C9EF3;
	Mon, 11 May 2026 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494451; cv=none; b=ODg7HONjM/dXCilSTRiKBzO8gg/j3EqCGkh+5kc2HHgZQtY1huA3mwTA/2IwaWjUlHqAak44XYU4kku3zr9VRAqQNv/sldGuC/qN34BBiXC+BoLpdw71rw5BAeiPvaDbiqH17w35TLkmwq1+9M/RAVTHUQ/lmjDiiZaR8IDsRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494451; c=relaxed/simple;
	bh=05av6KJq1yTpxBLFcHZhzYV5qEukIOQZdTXG+GRby/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tV2RsXGiuZpzEjq2eY93gYOZNXiiuTMWQeJPvzAdKhg2x02pDhI9AkHo8kDsKcnaeF6ctJVhpiB4k4MkTBzvmke94F8EeY3To/W8MAw1MpqSYnGNlkPQVdJeS7mMw78/cZhDVgit2B8GDmm8wX17yCX5zvaBdQll5SXVfbgacTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 22f894484d2211f1aa26b74ffac11d73-20260511
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bb4d37cd-f074-406a-8014-f754a2ef0544,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:30
X-CID-INFO: VERSION:1.3.12,REQID:bb4d37cd-f074-406a-8014-f754a2ef0544,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:30
X-CID-META: VersionHash:e7bac3a,CLOUDID:16c47ec44ea30feb92352783515ffd0c,BulkI
	D:26051118140545RNM1LR,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 22f894484d2211f1aa26b74ffac11d73-20260511
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1250879310; Mon, 11 May 2026 18:14:03 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH v2] fuse: propagate async RELEASE queue errno in fuse_file_put()
Date: Mon, 11 May 2026 18:13:37 +0800
Message-Id: <20260511101337.746510-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509102337.272593-1-liwang@kylinos.cn>
References: <20260509102337.272593-1-liwang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_file_put() queues asynchronous FUSE_RELEASE via fuse_simple_background().
When queueing fails, the failure branch always passed -ENOTCONN into
fuse_release_end(). fuse_simple_background() can however fail for multiple
reasons with different return values, such as -ENOMEM or -EINTR. Pass the
actual negative errno into fuse_release_end(). A similar pattern occurs
when fuse_send_readpages() calls fuse_readpages_end(). In that case,
if sending the request fails, fuse_readpages_end() is invoked
directly using the error value returned by the sending function as an argument.
Furthermore, the same applies to fuse_async_req_send() calling
fuse_aio_complete_req(). This patch aligns with those cases.

The parameter "error" is currently unused in fuse_release_end().
While removing it seems like the better choice, however, while fuse_file_put()
calls fuse_release_end() directly if sending the async request fails, it also
registers fuse_release_end() as the success callback. Consequently,
fuse_release_end() must strictly adhere to the callback signature; removing
any parameter would trigger a compilation error. Add an explicit
(void)error in fuse_release_end() so builds that enable
-Wunused-parameter (for example make W=3) stay clean.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
Changes since v1:
- Amend commit message to clarify the reasoning behind the code changes.

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

