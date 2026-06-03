Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D3A406272
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472905; cv=none; b=gAusjSHiVNKAt5YyR61NCuxxd2NUvEzQJ7FdcvXUyz+DmVfsugKw4mUPYEQpsvXzcs6+LAt4bkAMO3lrZ22PAEEETkv5HUapL3ZbCYFu3vc0k8smF3+tG/Jtd80TjAlQyuu5KSGEK1lm6i8M2heym7RQ032DN2ky7vDNiVgLPYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472905; c=relaxed/simple;
	bh=O3vQ5K1OrVY08S6huxLkqXLZCTpBbLuq0pe1bNSyKwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaSWD+/7LidCLon7OZHcHaBOf0JR92CLQdLsFT6vBS1bZr+dL9KhFvFaBXGCiKwHJORpDYf3BFErV7oOUXx59+mdcRTfiFdktZYl5sUK5eMAEIAs42ykIceXY2rjnOemVCoCOxf5YyU2EvOXqnC/OD64QxOARPZapIKWEmY8MnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YR+CPkKK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YR+CPkKK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4/yNVuyMUtHU6SqtpT4x8XlAfEd3jLA36HEnE6pmKm0=; b=YR+CPkKK8on5p139eSXKuC2j0o
	VyviQIBUWohyMB+Evab1mRty2Xrr6IKKVl4J0sl7ipZhMHBuOdnKhOa0Fcl+hGk1y2goHbBYcpfRN
	4TLpYBfa+IFJyHQP+5MpxB8kWyvoruzZM+pwXTe4M0cbrN9ZRFQoby6LeWdgmKndVwveQm3NWFiWN
	sxKW4x6fAqZE2CLkQTMhDfWEn/plds+wprusMlKc7ktEZTzq7xIKsWDNWW+WTcbkZ460u26HWDpnX
	BQ6m87VZHsA2FU3WKiuBa7G2PIZs4QUUOqrgiy7laQA6oVsRYAWLHdw/OF02KG3iWNMSwHkpIYsAG
	7pbGuoww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKm-0000000CjEr-1h0K;
	Wed, 03 Jun 2026 07:48:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 04/18] configfs_detach_prep(): pass configfs_dirent instead of dentry
Date: Wed,  3 Jun 2026 08:48:01 +0100
Message-ID: <20260603074815.3033766-8-viro@zeniv.linux.org.uk>
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

The only thing it uses the argument for is its ->d_fsdata and
all callers have that already available.

Note that in the recursive call we are dealing with a (sub)directory
configfs_dirent, and for those ->s_dentry->d_fsdata points back
to configfs_dirent itself.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 8181771c8a58..b456e4de25ab 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -517,9 +517,8 @@ static struct dentry * configfs_lookup(struct inode *dir,
  * If there is an error, the caller will reset the flags via
  * configfs_detach_rollback().
  */
-static int configfs_detach_prep(struct dentry *dentry, struct dentry **wait)
+static int configfs_detach_prep(struct configfs_dirent *parent_sd, struct dentry **wait)
 {
-	struct configfs_dirent *parent_sd = dentry->d_fsdata;
 	struct configfs_dirent *sd;
 	int ret;
 
@@ -547,7 +546,7 @@ static int configfs_detach_prep(struct dentry *dentry, struct dentry **wait)
 			 * Yup, recursive.  If there's a problem, blame
 			 * deep nesting of default_groups
 			 */
-			ret = configfs_detach_prep(sd->s_dentry, wait);
+			ret = configfs_detach_prep(sd, wait);
 			if (!ret)
 				continue;
 		} else
@@ -1540,7 +1539,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
 		 */
 		ret = sd->s_dependent_count ? -EBUSY : 0;
 		if (!ret) {
-			ret = configfs_detach_prep(dentry, &wait);
+			ret = configfs_detach_prep(sd, &wait);
 			if (ret)
 				configfs_detach_rollback(dentry);
 		}
@@ -1837,7 +1836,7 @@ void configfs_unregister_group(struct config_group *group)
 
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
 	spin_lock(&configfs_dirent_lock);
-	configfs_detach_prep(dentry, NULL);
+	configfs_detach_prep(sd, NULL);
 	spin_unlock(&configfs_dirent_lock);
 
 	configfs_detach_group(&group->cg_item);
@@ -1984,7 +1983,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	inode_lock_nested(d_inode(dentry), I_MUTEX_CHILD);
 	mutex_lock(&configfs_symlink_mutex);
 	spin_lock(&configfs_dirent_lock);
-	if (configfs_detach_prep(dentry, NULL)) {
+	if (configfs_detach_prep(sd, NULL)) {
 		pr_err("Tried to unregister non-empty subsystem!\n");
 	}
 	spin_unlock(&configfs_dirent_lock);
-- 
2.47.3

