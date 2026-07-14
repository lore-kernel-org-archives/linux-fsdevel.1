Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061E3F0AA0;
	Tue, 14 Jul 2026 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014389; cv=none; b=PZh+z4C/rm+uzzeBj170mzZGgVDY9WZHbnmgapaUDcpL96hfaRPZJ8uP3WXbEqE7vYKDrAPCv47GJaeLZKcjMofyHzjXZ5yPxnkYhGlhk9Lpdpoh64QaSPIofLzYT65JUPLuE2EawDHRfR7S/kVhSeov2fB4ajtWh5uBcr723+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014389; c=relaxed/simple;
	bh=wQSv8xHKvdUtKCWQH2iyGZJa7ezSYFevhn+QEfT9j94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dUO7rpcAn98crv4m3+wlpo0iAQDos3MgvoUZs7OH1qgqSS42L28VrKB1eHPAVDs8ROd86uQL/QpBcLE8yXXmJKZ8T7Hpx0WMMj3fc+8/W2dv8uaTDjPdVKP7vLpjmaiEmsiwrxWxbRY/0RsjaPxxWiJcQEfBx75taER0qD47pgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3b6867b87f5611f1aa26b74ffac11d73-20260714
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f1550207-946f-4318-af3b-edcf607d39b5,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:f1550207-946f-4318-af3b-edcf607d39b5,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:2790ff6320d0d800b2491fd764feb558,BulkI
	D:260714153258R6OZM1WW,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	136|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3b6867b87f5611f1aa26b74ffac11d73-20260714
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 768550598; Tue, 14 Jul 2026 15:32:56 +0800
From: Li Wang <liwang@kylinos.cn>
To: Bernd Schubert <bernd@bsbernd.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>,
	Jinxu Du <dujinxiu@kylinos.cn>
Subject: [PATCH] fuse: select alternative io_uring queue if local queue is full
Date: Tue, 14 Jul 2026 15:32:30 +0800
Message-Id: <20260714073230.4324-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_uring_task_to_queue() always maps requests to the queue for
task_cpu(current). A single-threaded submitter with high queue depth
could leave other per-CPU queues idle while one queue handles all
traffic.

Prefer the local queue when it has available ring entries. If the local
queue is full, try other queues on the same NUMA node before falling
back to use the local queue.

Signed-off-by: Li Wang <liwang@kylinos.cn>
Tested-by: Jinxu Du <dujinxiu@kylinos.cn>
---
Benchmark results

Machine: dual 64-core XEON GOLD 6548Y CPUs, 512GB RAM, 4TB NVME
Program: fio ioengine=libaio numjobs=1 direct=1 iodepth=256

Pattern	                  Baseline    Patched    Diff
read bs=512K (MB/s)       1146        1910       66.67%
write bs=512K (MB/s)      1929        2486       28.88%
randread bs=4K (KIOPS)    21.5        29.7       38.14%
randwrite bs=4K (KIOPS)   92.1        134        45.49%

 fs/fuse/dev_uring.c | 47 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 77c8cec43d9c..c36438e79f8d 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -11,6 +11,7 @@
 
 #include <linux/fs.h>
 #include <linux/io_uring/cmd.h>
+#include <linux/topology.h>
 
 static bool __read_mostly enable_uring;
 module_param(enable_uring, bool, 0644);
@@ -1318,10 +1319,46 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
 	}
 }
 
+static inline bool fuse_uring_queue_has_avail_ent(struct fuse_ring_queue *queue)
+{
+	bool has;
+
+	if (!queue)
+		return false;
+
+	spin_lock(&queue->lock);
+	has = !list_empty(&queue->ent_avail_queue);
+	spin_unlock(&queue->lock);
+
+	return has;
+}
+
+static struct fuse_ring_queue *
+fuse_uring_find_avail_queue(struct fuse_ring *ring, int node, unsigned int skip)
+{
+	unsigned int i;
+	struct fuse_ring_queue *queue;
+
+	for (i = 0; i < ring->nr_queues; i++) {
+
+		if (i == skip)
+			continue;
+		if (node >= 0 && cpu_to_node(i) != node)
+			continue;
+
+		queue = ring->queues[i];
+		if (fuse_uring_queue_has_avail_ent(queue))
+			return queue;
+	}
+
+	return NULL;
+}
+
 static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
 {
 	unsigned int qid;
 	struct fuse_ring_queue *queue;
+	int node;
 
 	qid = task_cpu(current);
 
@@ -1331,7 +1368,15 @@ static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
 		qid = 0;
 
 	queue = ring->queues[qid];
-	WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
+	if (fuse_uring_queue_has_avail_ent(queue))
+		return queue;
+
+	node = cpu_to_node(qid);
+	queue = fuse_uring_find_avail_queue(ring, node, qid);
+	if (!queue) {
+		queue = ring->queues[qid];
+		WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
+	}
 
 	return queue;
 }
-- 
2.34.1

