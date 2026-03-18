Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCAA3D8133;
	Wed, 18 Mar 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841916; cv=none; b=PP1K5WIG4vkP1sRyHz0rxal8KStHn+gA4wn8urHI4yF4NavNIbw5QGAs1r++V7Nyj6VEYBs75fMYFJWZ2O2bE2Haios85+svhgKhVy3bGdM21MLyVA4U/kT4XE3omzsyWUo6ngkprlR6ihfnskHPE1qIs8vDqYnTy30SX8nhXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841916; c=relaxed/simple;
	bh=hkl9TQlUkYf+LaiChWfXYx98pUzkgZ7P3j7aDm7KOIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZdWHvbCLXpltn18ew49Xc8JoAvaSr05ibDD0k+5F8/Z6fW7pCbum5Xt5plaS38NiOP0yMDPlm7y325djwWf5sZulnlNj+7lDQmJReVQyqfE2Q/clTwgfEqsrRKDerBk3JeWm3Sn/mbJ0RvsbUl1r0tfTh/9Uy43v+rBXrs4nYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=uE5yRBl0; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="uE5yRBl0"
Received: from fedora.fritz.box (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id BC152E02F2;
	Wed, 18 Mar 2026 14:45:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1773841502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EPcZ0wJ169ASsdG7FiQXxhE4+Esdif9P9JS9pm3s78I=;
	b=uE5yRBl0b5ZKSJi1vpZWwFHRQN1v+zNTB58ZPYjIm1bgOD9rpSFoY2Q5grNpmSU4h7XD04
	Etga/z6RACoklHII2uLcndIgE1td5fdK4wwyldn5qMzRhOrrkXQATuHzlXB5kvR9vi+2bD
	Njn5FUXDFy5CGZS4gr8zNcy+f/UbFV9y3JIVmRrZx5nsD8tTytQEe0X/raRo/JKxdAXBXd
	uoiB/1P6gsPCncD2jTGYsokhGTqMu9ufGrHbb7PMVR8i+ABxbT2Cs1dEEqfxKxyHRtY0vM
	/FQDPJ1eaJ6PUyH9cC636XOEcsrUPiqxZRdzKRJ1/rShK7tMobkm0zjDTHylvw==
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Wed, 18 Mar 2026 14:43:49 +0100
Subject: [PATCH] fuse: fix inode initialization race
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAwEvyI5G2i1WPEr4iFq1FxaaUWE4t8NH
 oednQKZk3CGoSqQ+JYsMSjYuoLloLAzyqoMjWk609oeN3lQQlx1CHJhooWRnCc/k6PNMujzTKz
 aXx2n9/0A5LcC5mUAAAA=
X-Change-ID: 20260318-fix-inode-init-race-a47a7ba4af1e
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773841501; l=2636;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=FPohgL99x8xvkjT6BGo1bAjcVi69hCtac2k2BeM2/is=;
 b=9gUMKUkxNvsT/Sf/X2zeQVhcSQbeaeGEQN5l4bVeLcCfDn0e20NW4jbYCywIbfRTB3FpKnlVm
 vM8NpiQB+LMDsbOVjAmMgcxlLoI7isyasuF8rLNeJosDUfqsNjV+Hxy
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

From: Horst Birthelmer <hbirthelmer@ddn.com>

Fix a race between fuse_iget() and fuse_reverse_inval_inode() where
invalidation can arrive while an inode is being initialized, causing
the invalidation to be lost.

Add a waitqueue to make fuse_reverse_inval_inode() wait when it
encounters an inode with attr_version == 0 (still initializing).
When fuse_change_attributes_common() completes initialization, it
wakes waiting threads.

This ensures invalidations are properly serialized with inode
initialization, maintaining cache coherency.

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/fuse_i.h | 3 +++
 fs/fuse/inode.c  | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d15e869db4be23a93605098588eda9..1be611472eee276371b3bde1a55257c1116cfedd 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -945,6 +945,9 @@ struct fuse_conn {
 	/** Version counter for attribute changes */
 	atomic64_t attr_version;
 
+	/** Waitqueue for attr_version initialization */
+	wait_queue_head_t attr_version_waitq;
+
 	/** Version counter for evict inode */
 	atomic64_t evict_ctr;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e57b8af06be93ecc29c58864a9c9e99c68e3283b..c6e7e50d80c0edaea57d9342869eaf811786e342 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -246,6 +246,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
 
 	fi->attr_version = atomic64_inc_return(&fc->attr_version);
+	wake_up_all(&fc->attr_version_waitq);
 	fi->i_time = attr_valid;
 
 	inode->i_ino     = fuse_squash_ino(attr->ino);
@@ -567,6 +568,12 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 
 	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
+	while (fi->attr_version == 0) {
+		spin_unlock(&fi->lock);
+		wait_event(fc->attr_version_waitq, READ_ONCE(fi->attr_version) != 0);
+		spin_lock(&fi->lock);
+	}
+
 	fi->attr_version = atomic64_inc_return(&fc->attr_version);
 	spin_unlock(&fi->lock);
 
@@ -979,6 +986,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	atomic_set(&fc->epoch, 1);
 	INIT_WORK(&fc->epoch_work, fuse_epoch_work);
 	init_waitqueue_head(&fc->blocked_waitq);
+	init_waitqueue_head(&fc->attr_version_waitq);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-fix-inode-init-race-a47a7ba4af1e

Best regards,
-- 
Horst Birthelmer <hbirthelmer@ddn.com>

