Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082D33B955;
	Fri, 27 Mar 2026 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597002; cv=none; b=i+6gB2Qgrc3UdNQCVfnWdzvUlFlPNxA6QY6k/sQvEDq8GwBQa0XugL/7gRLmZ5cRPYT+o6OuJyish1VyfET6RpgWS24VdIv0L03zxfAs5dtP/04ZQr+qpokkNjOTB9BCgC/YevkPWxv5CcumhWDE+X8fGAnqrppl3qxVdGaislY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597002; c=relaxed/simple;
	bh=CNxZ6BBRwXGxbPCP5u/vOn1ZhBmbJUKAdG1aLVb3pUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MI3aa2++3mEPH87/PF06B+x97aNNkHRbL8rvL1Ar5YKvm1ero4kvlr1z8w8/WUq+Vmx3Qm9imvzOh97SC9LVIaW5B9Z9sS6+DqrK9BZv9VRYPeBWLX5lG5KhM7faAQsLmqB1Pqw03gK1sEsGheRwEXxELlHIvWSWpRUaIjMUFqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=IrqboW2o; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="IrqboW2o"
Received: from [192.168.178.110] (108-141-067-156.ip-addr.inexio.net [156.67.141.108])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id EFAB3E0367;
	Fri, 27 Mar 2026 08:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1774596994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cYADJ2bhfZxpR8MQhodrOpyziSQvdQveFNgUSBLbaxk=;
	b=IrqboW2ojXT78mUj/EqXeess0QsL+f/MXkvNJfLbzh6Fu1UD1Uz/+6jvF9mvRBWMTos1wR
	V3RRjnx5MCVdE6yY9gUOILwtCUN7MOwsvQHHidEyPRQkKdQlTzwGuAF89Zjnf+LmEckuhy
	jl7oUcVgIGBRJIWCGAD0vY/xhvmrANe/JPBKFXsxHR8wWkjFDyQFF7cbIw1ZvN2BBL7dLw
	o+TyDL4BjF9vwGolfSdn/a57BEynAfj/MCi5Q2hFoq2x7cSKZnrOsuRqd0+U7YIOxP7NQH
	EAK5LYBnFxNyJybFHypQcvmb6yWDR2GC7LIs5PDh9+HCXk98n/rf89l8U0A6vw==
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Fri, 27 Mar 2026 08:36:31 +0100
Subject: [PATCH v2] fuse: fix inode initialization race
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-fix-inode-init-race-v2-1-22b1757109f8@ddn.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NSw7CIBCGr9LM2jEFq1RX3sN0MZSpnYXQQEM0D
 XcXewCX3//cIHEUTnBrNoicJUnwFfShgXEm/2QUVxl0qy/tSfU4yRvFB1cNLytGGhmpM2QsdTQ
 phtpcItfYvvoYKs+S1hA/+0lWP/X/XlaokAyfe6uds1e6O+ePY3jBUEr5AswMrA20AAAA
X-Change-ID: 20260318-fix-inode-init-race-a47a7ba4af1e
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>, 
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774596993; l=2620;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=v/K9pYmmubK1YKdlD9evkj6xhfPI+xuqiGzndGTLII8=;
 b=GAHWjsjq3Za0TOfaG9/jB1gznWDrHg+j2BGo2E9WiRGIHCaDtswp3tFKwu1izX78KQYvIvDGM
 qsKlZvQoC+GCyey5hmVsAp6vgXB/yJzKVzk0mhCw/KfBOtVzqBW+7Ao
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

From: Horst Birthelmer <hbirthelmer@ddn.com>

Fix a race between fuse_iget() and fuse_reverse_inval_inode() where
invalidation can arrive while an inode is being initialized, causing
the invalidation to be lost.
By keeping the inode state I_NEW as long as the attributes are not valid
the invalidation can wait until the inode is fully initialized.

Suggested-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
Changes in v2:
- switch from waitq guided by attr_version to wait_on_new_inode() and unlock_new_inode() when
the inode is fully initialized
- Link to v1: https://lore.kernel.org/r/20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com
---
 fs/fuse/inode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e57b8af06be93ecc29c58864a9c9e99c68e3283b..fa0adc2bbe58cee6f63153c60c401b78ec3695bf 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -470,6 +470,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	struct inode *inode;
 	struct fuse_inode *fi;
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	bool is_new_inode = false;
 
 	/*
 	 * Auto mount points get their node id from the submount root, which is
@@ -505,13 +506,13 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	if (!inode)
 		return NULL;
 
-	if ((inode_state_read_once(inode) & I_NEW)) {
+	is_new_inode = inode_state_read_once(inode) & I_NEW;
+	if (is_new_inode) {
 		inode->i_flags |= S_NOATIME;
 		if (!fc->writeback_cache || !S_ISREG(attr->mode))
 			inode->i_flags |= S_NOCMTIME;
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr, fc);
-		unlock_new_inode(inode);
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
 		fuse_make_bad(inode);
@@ -528,6 +529,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 done:
 	fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_version,
 				 evict_ctr);
+	if (is_new_inode)
+		unlock_new_inode(inode);
 	return inode;
 }
 
@@ -565,6 +568,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 	if (!inode)
 		return -ENOENT;
 
+	/* Wait for inode initialization to complete */
+	wait_on_new_inode(inode);
+
 	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
 	fi->attr_version = atomic64_inc_return(&fc->attr_version);

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-fix-inode-init-race-a47a7ba4af1e

Best regards,
-- 
Horst Birthelmer <hbirthelmer@ddn.com>

