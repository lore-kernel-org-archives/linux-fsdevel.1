Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE3309EE9;
	Fri, 27 Mar 2026 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774632552; cv=none; b=gxM67pcnFNYQlVya1IafSNU/2ulyc+JGE8j8zLEaeA/mFc9u2rB0VcDEqkuh8vWV+7b/wR+e3+Q71boAN8rofb3/Qzce5UvmyKq7OS6o365+atTYhsSJ94mSm4woBkayy695v+rsIH0v5Qjjq3BcJ9xr9x4t1LkqQexE/43yRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774632552; c=relaxed/simple;
	bh=sX8g6BW7wuC6sdhaveq2d7QviDJYe9SsaQ0rxEkQR34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bSBI5nUeo2ByQjbwwRlUkmgcvkqUrK2ES2x68tHYF1udFodXjekB56NtpFKzwMVEppHjvNWstyKXpqPW8Spu1LwlxFKO/4d3kshC2chDv+cYUL5DgOwXD5GntL9DAH6c47abfX01Z9iAupanwUpK7CfSTEQvL7EE1g1yUgOestQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=FLsSw90s; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="FLsSw90s"
Received: from fedora.fritz.box (108-141-067-156.ip-addr.inexio.net [156.67.141.108])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id 1EA03E07C3;
	Fri, 27 Mar 2026 18:29:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1774632542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bp39BBZ6UBtvAmRydV6VZqDarNOC6jo6F1yDlYTx4qw=;
	b=FLsSw90syR5rBb2ZarLiWhsxE3Ii5cQh7tMPpj42AR9bk+HG5hpjqwRTSs/IggK7Qhph/P
	xxtjeZzxycIn22pLh2m06OUlLSEc+QNIQVf7T82ds2Dsh/wsqdjK5xLeq+5u4Ake6FpbtW
	RnW1xB6bCJJeLl9SbnozrFgX7WVfUgC3KPi70VAvu+Shafu6OAQgpAKgrswEUz83KN0eGX
	61h2wiX/wFtXUgAveqskqEMtPnTJ/HZVO0zYrezypPngMLamOQ3edNlf2BsilvNDQjoDL/
	4yHMHXCKHY1hBzPJ7gMjWn9G7qmC++CmVw/wOHXPbVSvZ8QfqD9XBUMBNJY1IQ==
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Fri, 27 Mar 2026 18:28:54 +0100
Subject: [PATCH v3] fuse: fix inode initialization race
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-fix-inode-init-race-v3-1-73766b91b415@ddn.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwQ6CMAwG4FchOzvDCjjw5HsYDx0r0oMb2ciiI
 by7g4sejMe//ft1EZECUxTnYhGBEkf2LofqUIh+RHcnyTZnASWcykq1cuCnZOdtXjieZcCeJNY
 atcEaB0UiX06Bcm1Xr7ecR46zD6/9SVLb9L+XlFQSNTWtAWtNhxdr3bH3D7FpCb4E0L8FyAKAU
 brRquyG9iOs6/oG3nilKvYAAAA=
X-Change-ID: 20260318-fix-inode-init-race-a47a7ba4af1e
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>, 
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774632542; l=2465;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=q39VNTJtdgM5QOS2StCzaxk5T1bXeYnsIlDMPMXtiII=;
 b=6f+ZOSYzr+SHGY3NC+Ov09VqOxUYV6mIWnSpbAIWh8ODi/E+O9E7P7W1juxbV9cy10wz+uY6h
 9R+QWNlypTaDHi3YuHtvtb2Bk50hOOSQhZy3ASFhNBK7tR9lSYGxi3p
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
Changes in v3:
- removed unnecessary wait_on_new_inode() in notify path
- Link to v2: https://lore.kernel.org/r/20260327-fix-inode-init-race-v2-1-22b1757109f8@ddn.com

Changes in v2:
- switch from waitq guided by attr_version to wait_on_new_inode() and unlock_new_inode() when
the inode is fully initialized
- Link to v1: https://lore.kernel.org/r/20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com
---
 fs/fuse/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e57b8af06be93ecc29c58864a9c9e99c68e3283b..b6ae3cb533e11421e627b80e53c6d12266bce39a 100644
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
 

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-fix-inode-init-race-a47a7ba4af1e

Best regards,
-- 
Horst Birthelmer <hbirthelmer@ddn.com>

