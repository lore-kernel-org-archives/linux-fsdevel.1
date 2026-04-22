Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2AF3B27E2;
	Wed, 22 Apr 2026 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854250; cv=none; b=Dnym/On8tjDN+NvmtMgVQGDnUPXksnXSP0M2LT1E/eC9NIW+a0fGLUsY7fS1HNef7d8Q69JuYC9FdL9PH00QU0alwLLULN/gO5KKppw5vtJqxiXg2APSwQfRgxPoqTVMgnd0Up3VoSn5tEN1mU+GcCjlKdS+TC9Z4g9EeIiMsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854250; c=relaxed/simple;
	bh=Hsn56gQl8OLUgVaCHZwSNyXcpBAS0FnqDgFBa3Sivf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KCe4vOCkcsDXGJgdpSPRualpC/H3+SzyhgJnilc9ySVAu2he6ay9XqUlP0FbVm71q+CxztHwE6XaTVH4HwYw5eSdGPxzF1BR8+ovQuVD4JxlliNNLo2CTRzaCIsD5NP2C7/eV0+NVVw7RFRDw7BLdD2TuB9w5Yf4IJGU5fWzCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3dcf3f0a3e3711f1aa26b74ffac11d73-20260422
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
X-CID-O-INFO: VERSION:1.3.12,REQID:137653ef-4fec-44df-9657-d2a6a04fa10d,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:137653ef-4fec-44df-9657-d2a6a04fa10d,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:2c7f83b62d76a36bf9a570ab185a9832,BulkI
	D:2604221837235NKR3L9U,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|898
	,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3dcf3f0a3e3711f1aa26b74ffac11d73-20260422
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 131166995; Wed, 22 Apr 2026 18:37:20 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] fuse: fix kernel NULL pointer dereference in fuse_uring_add_to_pq()
Date: Wed, 22 Apr 2026 18:36:03 +0800
Message-Id: <20260422103603.4554-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A kernel NULL pointer dereference was triggered when testing the
'fuse over io_uring' feature with passthrough_ll. The call trace
is as follows:
  BUG: kernel NULL pointer dereference, address: 0000000000000878
  RIP: 0010:fuse_uring_add_req_to_ring_ent+0x89/0xd0 [fuse]
  Call Trace:
  <TASK>
  fuse_uring_queue_fuse_req+0x82/0x100 [fuse]
  fuse_chan_send+0xe6/0x180 [fuse]
  fuse_lookup_name+0x131/0x2b0 [fuse]
  fuse_lookup+0x78/0x1a0 [fuse]
  fuse_atomic_open+0xfc/0x140 [fuse]
  atomic_open+0x4b/0xf0
  path_openat+0x746/0x1080
  do_file_open+0xc9/0x180

fuse_uring_create_queue() must initialize struct fuse_pqueue before assigning
the per-hash processing table:

- Call fuse_pqueue_init() before setting fpq.processing. fuse_pqueue_init()
  clears fpq.processing; assigning the kcalloc'd bucket array must happen
  afterwards.

- After allocating the processing bucket array with kzalloc_objs(), initialize
  each list head with INIT_LIST_HEAD(), matching fuse_pqueue_alloc() in dev.c.
  Zeroed list_head values are not valid empty lists; list_move_tail() would
  dereference NULL prev/next.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 fs/fuse/dev_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index d6d75e024b35..b765c1ff5e2d 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -282,6 +282,8 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 		kfree(queue);
 		return NULL;
 	}
+	for (int i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+		INIT_LIST_HEAD(&pq[i]);
 
 	queue->qid = qid;
 	queue->ring = ring;
@@ -295,8 +297,8 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	INIT_LIST_HEAD(&queue->fuse_req_bg_queue);
 	INIT_LIST_HEAD(&queue->ent_released);
 
-	queue->fpq.processing = pq;
 	fuse_pqueue_init(&queue->fpq);
+	queue->fpq.processing = pq;
 
 	spin_lock(&fch->lock);
 	if (ring->queues[qid]) {
-- 
2.34.1

