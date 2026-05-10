Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD039B951;
	Sun, 10 May 2026 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778424898; cv=none; b=K2Sm9pCXHmJbC5fNAvC9pGr1H0R34U+SN/b2nebiEhm9fsYlHDfrDK8neghKN2s1EqvA4HqXuP7Fje5YjnroHXkxPi0Fukp5evQWuuPWMSM9/YIOKo9V8UqZQtyrLE1jUyOajf0z/TQM9Q0kK9V0aekejMZn2U/kK43ao5fY1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778424898; c=relaxed/simple;
	bh=Uy+VhuXM3U5D7xhGtbWtxvB984/Dc6Vx7jr2cPumaZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rl/+oEuJ+bNdAP0hmZSC+Z6qXTbnRF8xSMzkoCcyBJUr0BXC2jBw7eenVhc5NVpv4+cqo2fc1cBwVNQAkRSH6xAaWf07u9M2BXeJoTzAJJQQ9vu+NOjL6tHW9QApKYULHoTC/0H+lXUQxal0p4+0Ao+x7cjzmcu2fEI9VB2wTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2c7c8d284c8011f1aa26b74ffac11d73-20260510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3f09d191-88ed-47a0-a4c3-8aefe452dadb,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:3f09d191-88ed-47a0-a4c3-8aefe452dadb,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:9f539d34b1e59f095587e2a4fa0e354e,BulkI
	D:260510225443B03DEX9C,BulkQuantity:0,Recheck:0,SF:10|66|78|102|123|127|89
	8,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2c7c8d284c8011f1aa26b74ffac11d73-20260510
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(120.228.139.157)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1503282378; Sun, 10 May 2026 22:54:41 +0800
From: zhaoguohan@kylinos.cn
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: use current creds for backing files
Date: Sun, 10 May 2026 22:54:37 +0800
Message-ID: <20260510145437.321141-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

FUSE backing files only need a stable snapshot of the current credentials
for later backing-file I/O. prepare_creds() allocates a mutable copy and
can fail, but this code never modifies or commits the result.

Use get_current_cred() instead and store it as a const pointer. This
matches the rest of the backing-file helpers and avoids an unnecessary
allocation and failure path.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 fs/fuse/backing.c | 2 +-
 fs/fuse/fuse_i.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index d95dfa48483f..8efb43b17c4d 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -118,7 +118,7 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 		goto out_fput;
 
 	fb->file = file;
-	fb->cred = prepare_creds();
+	fb->cred = get_current_cred();
 	refcount_set(&fb->count, 1);
 
 	res = fuse_backing_id_alloc(fc, fb);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 17423d4e3cfa..36041e405bf8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -106,7 +106,7 @@ struct fuse_submount_lookup {
 /** Container for data related to mapping to backing file */
 struct fuse_backing {
 	struct file *file;
-	struct cred *cred;
+	const struct cred *cred;
 
 	/** refcount */
 	refcount_t count;
-- 
2.43.0
