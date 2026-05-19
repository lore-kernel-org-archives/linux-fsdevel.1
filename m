Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DA1A6802
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152530; cv=none; b=cBkmSUyaJoeeJER44C5jCkUeseY3L1unxYPeneThz0STki1avFZar9g1zswu2sBm3L6NHdEpHB6NWXTuArcD/xssDmsWBd63e6wGkTB2D+6fjLqsj3bE/70Kq+AYxDMhd+RF31a2zTrHlAXsdHwfI7T36TBOgn12oLPApKvFhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152530; c=relaxed/simple;
	bh=sFjrRvAohemTGAICXNsDy2rEpZvFtYRAzT/w6ypFXFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LcKAQVEtfmmQ5kz4bQX+FotEl2POunDkBVXeXUHUOjawdSzCA+2urqbtCRx9XXV5x3W6EmdULagTF3CnxFiJf8t3hDOk6sjSDdw/W1D9MAMh6b2mMopqOEJAgWuCbiBcSQqFuKYpmpLPzYmVgKayqj20sX+uezeRkD70AyJiJho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5727d04c531e11f1aa26b74ffac11d73-20260519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1736a90e-d848-40b5-bcb5-84ea3f633ee4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:c13033a02d884dee569b79117f4e7bd4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5727d04c531e11f1aa26b74ffac11d73-20260519
X-User: xieyi@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xieyi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1030367960; Tue, 19 May 2026 09:02:00 +0800
From: Yi Xie <xieyi@kylinos.cn>
To: linux-fsdevel@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Yi Xie <xieyi@kylinos.cn>
Subject: [PATCH] exportfs: fix error handling in expfs.c
Date: Tue, 19 May 2026 09:01:40 +0800
Message-Id: <20260519010140.37251-1-xieyi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dentry_open() and fh_to_parent() were calling PTR_ERR() before
checking IS_ERR().  Drop the redundant sched.h include too, cred.h
already pulls it in.

Signed-off-by: Yi Xie <xieyi@kylinos.cn>
---
 fs/exportfs/expfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index fbd45e7ae706..e2c5fe252606 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -15,7 +15,6 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
-#include <linux/sched.h>
 #include <linux/cred.h>
 
 #define dprintk(fmt, args...) pr_debug(fmt, ##args)
@@ -310,9 +309,10 @@ static int get_name(const struct path *path, char *name, struct dentry *child)
 	 * Open the directory ...
 	 */
 	file = dentry_open(path, O_RDONLY, cred);
-	error = PTR_ERR(file);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		error = PTR_ERR(file);
 		goto out;
+	}
 
 	error = -EINVAL;
 	if (!file->f_op->iterate_shared)
@@ -524,9 +524,10 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 				fh_len, fileid_type);
 		if (!target_dir)
 			goto err_result;
-		err = PTR_ERR(target_dir);
-		if (IS_ERR(target_dir))
+		if (IS_ERR(target_dir)) {
+			err = PTR_ERR(target_dir);
 			goto err_result;
+		}
 
 		/*
 		 * And as usual we need to make sure the parent directory is
-- 
2.25.1

