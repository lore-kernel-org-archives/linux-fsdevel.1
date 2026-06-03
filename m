Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE163988F8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472911; cv=none; b=Zt9vHLyxw9UzxA/N7QgTxtGMhXmCwha8rfnZipFwmC+gxiU0bLO57P0scRrscXDmkKk8JD0VEaV9OWe7TcYHnIZEjsrtc1k5Iin2R5SwA7JH/2MHBHUbJrfThr1CCd+/QluCs8C/gxgsK5sbEdT0LRJ5qe91TZk67fsk6sa86Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472911; c=relaxed/simple;
	bh=TWmcSA6B0DMY7jKJNiVI9qCiP9UtwpdiiUFr6lxS/X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjZeSm3QfyaeFVGNfDei/M8InsPz1MaTLfSr6nicWA7Ud8ZovOvu6s8/Suo/mqObBBfMjAwlOeEA6ydeMdTNhQUOW8SAbVguJDZFGVY6vw34T0GthftX7EErSLMhLzCgdPOw+3macla2FgsjHThq723Qfwy8GFe89Qm7uDtBoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DC1YMC58; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DC1YMC58"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=B7aZpHmCgBBjZ00wkejsDBxQbxriKeKh6dsVOWKjBtg=; b=DC1YMC587kUfr1OJtSLYa2zCBw
	Y9ZNCy/m7g8vxfXjg1WWpg5JTzhni1FO4ZsyCr6TLzuZITDfZxWZ2lDUlW3n9OeuVFENU11zha9gh
	qEXZVV8bpFwNatiNjV9md7ZXcyOnZ/Jyi7KQKDnOCSE3MrvmIl27ybd2HFrgtkXXlp2uL+qsy7kq+
	9FjRdOsV6jA+tfdLflCC3GkXtgqP6lsc1ysAVewLYdfCH9ZBPrVgM2POE0WhF3XN5EI7ytoyK4w1/
	gswwcsBMQK6iYx1bNc+1yCAXKqPu8tSjj3lFWeO38+1M1JDPBZ+RBMdpLNMZt1UDFQaNuvguSvX0+
	EdB2k+rQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKo-0000000CjHY-3dcx;
	Wed, 03 Jun 2026 07:48:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 17/18] configfs_attach_group(): drop the unused parent_item argument
Date: Wed,  3 Jun 2026 08:48:14 +0100
Message-ID: <20260603074815.3033766-21-viro@zeniv.linux.org.uk>
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

This one *was* used - for passing it to configfs_attach_item(), which
didn't use the value passed to it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 2f3f3f504e2c..8fc05fe69992 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -657,8 +657,7 @@ static int populate_attrs(struct config_item *item)
 	return 0;
 }
 
-static int configfs_attach_group(struct config_item *parent_item,
-				 struct config_item *item,
+static int configfs_attach_group(struct config_item *item,
 				 struct dentry *dentry,
 				 struct configfs_fragment *frag);
 static void configfs_detach_group(struct dentry *dentry);
@@ -719,8 +718,7 @@ static int create_default_group(struct config_group *parent_group,
 	if (child) {
 		d_add(child, NULL);
 
-		ret = configfs_attach_group(&parent_group->cg_item,
-					    &group->cg_item, child, frag);
+		ret = configfs_attach_group(&group->cg_item, child, frag);
 		if (!ret) {
 			sd = child->d_fsdata;
 			sd->s_type |= CONFIGFS_USET_DEFAULT;
@@ -890,8 +888,7 @@ static void configfs_detach_group(struct dentry *dentry)
 	configfs_detach_item(dentry);
 }
 
-static int configfs_attach_group(struct config_item *parent_item,
-				 struct config_item *item,
+static int configfs_attach_group(struct config_item *item,
 				 struct dentry *dentry,
 				 struct configfs_fragment *frag)
 {
@@ -1423,7 +1420,7 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	spin_unlock(&configfs_dirent_lock);
 
 	if (group)
-		ret = configfs_attach_group(parent_item, item, dentry, frag);
+		ret = configfs_attach_group(item, dentry, frag);
 	else
 		ret = configfs_attach_item(item, dentry, frag);
 
@@ -1908,8 +1905,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 
 		err = configfs_dirent_exists(dentry);
 		if (!err)
-			err = configfs_attach_group(sd->s_element,
-						    &group->cg_item,
+			err = configfs_attach_group(&group->cg_item,
 						    dentry, frag);
 		if (err) {
 			BUG_ON(d_inode(dentry));
-- 
2.47.3

