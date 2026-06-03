Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C660407592
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472909; cv=none; b=D4YwmOmVebcWdMr+nxFLiI5wqBJvoNsyRd38XYyaz62c+VyE+sZYEXj58iTN2B3pcLmQWpl85p5BQuKABpuSouZtyXKhdj7ba1zdV0qtpE50ktaZCsnUpRgjeWOIteflr9/YYpmC89pnbBeh+HtZ/Vo2zLv+4/PHZX6FPVfnksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472909; c=relaxed/simple;
	bh=6nZs+Xx+xIioqT1FY/jQUQ3fFxtVDW+y5E4Qv19kTLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1rCLb9N//6PxqG1v+DLzqn8JFGvm7QeLGD6ho1U/3bxVaRmiyz82++gwSTEMTRBIGevxbPqIYXd95lauM6TVLbQQe5dCzrJDVkzIQ9LSch/ZEseF27AYLKoEBmzcJ20hCk3e8Hb5u79sOHI9l1R2GQ9ru3CTUd9im7hQpJ1EYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VUUE8vX0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VUUE8vX0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=x/FVI+tRGEsGRqFhgQwx6pgHedfJ869tsEfM2Cu8Cxc=; b=VUUE8vX0Pblpn+mKSXljWxap0g
	bvbIl9qU6r+hrxA576zh/V6coikNrKYOYCrY+0dshtCpZyRr6i+D88avknED7eeVP5zRz4jDPZE4u
	mB11ZacRrD0jyBk7BIrjloSpa+zSXmENRzA+vJyW+LhrznNirdeGOJXJIGB++7miON5OYyPavl0oI
	3SXAA9gBCIZ2ZSU575FTdzx87YUkzvv/2iiXuWgzATxdHfztuE1HqrpWZRCAOZ0uSxDGlL3wcf7Hl
	tTAIesm0Q3glMvMSyYiZ4UhTVcai994TXAhWTuotFJeGuv9j5WtiJiBb17VoYkdNEm28uySc2i6F7
	GA0NEHug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKo-0000000CjHK-39rC;
	Wed, 03 Jun 2026 07:48:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 16/18] configs_attach_item(): drop unused parent_item argument
Date: Wed,  3 Jun 2026 08:48:13 +0100
Message-ID: <20260603074815.3033766-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

That argument has been unused since the initial merge in 2005.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index b382d60e7ebc..2f3f3f504e2c 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -856,8 +856,7 @@ static void configfs_detach_item(struct dentry *dentry)
  * clean up the configfs items, and they expect their callers will
  * handle the dcache bits.
  */
-static int configfs_attach_item(struct config_item *parent_item,
-				struct config_item *item,
+static int configfs_attach_item(struct config_item *item,
 				struct dentry *dentry,
 				struct configfs_fragment *frag)
 {
@@ -899,7 +898,7 @@ static int configfs_attach_group(struct config_item *parent_item,
 	int ret;
 	struct configfs_dirent *sd;
 
-	ret = configfs_attach_item(parent_item, item, dentry, frag);
+	ret = configfs_attach_item(item, dentry, frag);
 	if (!ret) {
 		sd = dentry->d_fsdata;
 		sd->s_type |= CONFIGFS_USET_DIR;
@@ -1426,7 +1425,7 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (group)
 		ret = configfs_attach_group(parent_item, item, dentry, frag);
 	else
-		ret = configfs_attach_item(parent_item, item, dentry, frag);
+		ret = configfs_attach_item(item, dentry, frag);
 
 	spin_lock(&configfs_dirent_lock);
 	sd->s_type &= ~CONFIGFS_USET_IN_MKDIR;
-- 
2.47.3

