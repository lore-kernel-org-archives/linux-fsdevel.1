Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF83403158
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472908; cv=none; b=tXUlzmwh6349iyWAr5/RQnZQpOG+gsUXOTuHGRxGQK0WpDf6B+yllcso6TnBdSFyUZXhIn/M3edLo45MoqtE0pd1YFx9ixnnDk8Utvb0HBi2P6GcDzxZxayRcSenKkIxnH6GOnX1YfrkWJejsO1YVCSkHVRHDuL8OtA0Wv55r7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472908; c=relaxed/simple;
	bh=uubg7tOnHQoyuKy+T5t/e8qT9KBBGVQ5iL2AG8o2DI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhE/qQWr1V8lWCKNlhmDenVB5Wj4UtKH59aJmykopIwsTyeGDqzWkwzPs9dlTL8Oil5+tELC0Ubltcw58UjUoHM++A0pntJ0OyzHmL2SN+qmd2IzFS7Y15RXs8U+be9EPVBhFe/pJv2sTg+GDDywfT1egqsnfIzw/e87SvveDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aVubDqUD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aVubDqUD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Q1B5mhiy63xKrdx+4oADqnr8OQD9EgCq6YwE+LKlTIU=; b=aVubDqUDfdNvXeh5nXOlvr7JaU
	rqm1ZGM9cnW5px3uHXlymSZZe1fCjQZZ+roW1y8KrzeDsJofoy36b9hi1jfU+crShVnCMEmNvKqVi
	yHkyWDiUufAF2IUru+VhO+ZsqIjVGrfqI8oqIsEySrUx8c4fcPqCd/1uh8sBzc/pjqHhWIx5CR6ch
	0QLMw9gMlrImuK4wny3EGSFOE9E8Jvh20KTDFB+XK0muKkQr6WHZ2IAuMznVXyQfeCWi1oHznRfNu
	dxnuZSQenh2ELVdO4O3qbcPbnrMc40mgLAtcdSLiDDKKY4b4HdYWxunS7qjW+ceDHry1hUzKPZuSF
	c69UCKCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKn-0000000CjGU-40tH;
	Wed, 03 Jun 2026 07:48:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 10/18] configfs_remove_dir(), detach_attrs(): switch to passing dentry
Date: Wed,  3 Jun 2026 08:48:07 +0100
Message-ID: <20260603074815.3033766-14-viro@zeniv.linux.org.uk>
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

... and deal with grabbing/dropping it in the sole caller.
After that configfs_remove_dir() becomes an unconditional call of remove_dir(),
so we can fold them together.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 60 ++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 6580c919ee5a..11e2597fb1e2 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -395,7 +395,18 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
 	return PTR_ERR(inode);
 }
 
-static void remove_dir(struct dentry * d)
+/**
+ * configfs_remove_dir - remove an config_item's directory.
+ * @d:	dentry we're removing.
+ *
+ * The only thing special about this is that we remove any files in
+ * the directory before we remove the directory, and we've inlined
+ * what used to be configfs_rmdir() below, instead of calling separately.
+ *
+ * Caller holds the mutex of the item's inode
+ */
+
+static void configfs_remove_dir(struct dentry *d)
 {
 	struct dentry * parent = dget(d->d_parent);
 
@@ -415,31 +426,6 @@ static void remove_dir(struct dentry * d)
 	dput(parent);
 }
 
-/**
- * configfs_remove_dir - remove an config_item's directory.
- * @item:	config_item we're removing.
- *
- * The only thing special about this is that we remove any files in
- * the directory before we remove the directory, and we've inlined
- * what used to be configfs_rmdir() below, instead of calling separately.
- *
- * Caller holds the mutex of the item's inode
- */
-
-static void configfs_remove_dir(struct config_item * item)
-{
-	struct dentry * dentry = dget(item->ci_dentry);
-
-	if (!dentry)
-		return;
-
-	remove_dir(dentry);
-	/**
-	 * Drop reference from dget() on entrance.
-	 */
-	dput(dentry);
-}
-
 static struct dentry * configfs_lookup(struct inode *dir,
 				       struct dentry *dentry,
 				       unsigned int flags)
@@ -591,17 +577,12 @@ static struct configfs_dirent *next_dirent(struct configfs_dirent *parent,
 	return NULL;
 }
 
-static void detach_attrs(struct config_item * item)
+static void detach_attrs(struct dentry *dentry)
 {
-	struct dentry * dentry = dget(item->ci_dentry);
 	struct configfs_dirent *parent_sd;
 	struct configfs_dirent *sd, *next;
 
-	if (!dentry)
-		return;
-
-	pr_debug("configfs %s: dropping attrs for  dir\n",
-		 dentry->d_name.name);
+	pr_debug("configfs %pd: dropping attrs for  dir\n", dentry);
 
 	parent_sd = dentry->d_fsdata;
 
@@ -617,11 +598,6 @@ static void detach_attrs(struct config_item * item)
 		spin_lock(&configfs_dirent_lock);
 	}
 	spin_unlock(&configfs_dirent_lock);
-
-	/**
-	 * Drop reference from dget() on entrance.
-	 */
-	dput(dentry);
 }
 
 static int populate_attrs(struct config_item *item)
@@ -851,8 +827,12 @@ static void link_group(struct config_group *parent_group, struct config_group *g
 /* Caller holds the mutex of the item's inode */
 static void configfs_detach_item(struct config_item *item)
 {
-	detach_attrs(item);
-	configfs_remove_dir(item);
+	struct dentry *dentry = dget(item->ci_dentry);
+	if (dentry) {
+		detach_attrs(dentry);
+		configfs_remove_dir(dentry);
+		dput(dentry);
+	}
 }
 
 /*
-- 
2.47.3

