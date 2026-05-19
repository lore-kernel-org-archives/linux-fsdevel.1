Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C803B3C1D
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174400; cv=none; b=H/tHw0GenSEFSPJnHgCtx1xB1SOqCF4cN5mRihJ0PSQfLEYkjL33aWw/2MSDakhYVJ3BcfhRQ1zAHl9ani3/LjbF3jrN7AOGwRaagRaCmQ2Wy5YbBLJ3ZIbhv/C7owEUyH/nYOtxJbDeHySvsQizOw0wvky3atdg3r6QNWW+GD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174400; c=relaxed/simple;
	bh=lgDL3a4o56btHY4UlG/0bb7oEydQSthTE22cEYNE8eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vvb+wJCh5zURMdkiUPYzbzczSMY/oVODLmx2iorO42UauaaJvEtjSa8zStBhXbAJqZs7u5asusLxgN/EvxdQAiMdsKoEdB21XA1ZGi8S7KdwfhkILnif2IIly6kR95CiZhoqMekvcuH0YNiCw9If8be1n8dzfOV1Tta+uPye5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jhuhn5gb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jhuhn5gb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xm0i8jjmEamI6JRY0P0sFARB/Rn2ihKc++zlzwO/Mvg=; b=jhuhn5gbb10P1y3yn5fQ6DAEGb
	85CMj0Ks/G17KZfpvzb6HIp7f3wau2JlshgYnbuO4oJH+u841C4VIaXJi24lDZfN3jYR0VC6MlubJ
	VfdARA5U04WAvZuLDlZNjThOaNUgfjAHJ28jRty/izXl9BrF9sIjTzyI70WxvqBD6aYVDS8kSLbAN
	5Pk+Ca+xqXKLCyo/NCNC++K010UwKdw8EiD72IJphLyrhdPzIQjWdD0FqXA0KSoEJtmgxAr0aWZMR
	TCHe4AlVPYCd1vqkBBgvRvNzG6tyZU9TlTEcJ0YonLK9O+COskD7z8zNNudES8efBVzOVU6dUB5bb
	7KR4rH9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXC-00000008Uvk-0YsQ;
	Tue, 19 May 2026 07:06:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 09/14] configfs_remove_dir(), detach_attrs(): switch to passing dentry
Date: Tue, 19 May 2026 08:06:28 +0100
Message-ID: <20260519070633.2025485-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 57 ++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 395270cc3710..deb18689aa0a 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -394,7 +394,18 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
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
 
@@ -414,31 +425,6 @@ static void remove_dir(struct dentry * d)
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
@@ -573,15 +559,11 @@ static void configfs_detach_rollback(struct configfs_dirent *parent_sd)
 			configfs_detach_rollback(sd);
 }
 
-static void detach_attrs(struct config_item * item)
+static void detach_attrs(struct dentry *dentry)
 {
-	struct dentry * dentry = dget(item->ci_dentry);
 	struct configfs_dirent * parent_sd;
 	struct configfs_dirent * sd, * tmp;
 
-	if (!dentry)
-		return;
-
 	pr_debug("configfs %s: dropping attrs for  dir\n",
 		 dentry->d_name.name);
 
@@ -595,11 +577,6 @@ static void detach_attrs(struct config_item * item)
 		configfs_drop_dentry(sd, dentry);
 		configfs_put(sd);
 	}
-
-	/**
-	 * Drop reference from dget() on entrance.
-	 */
-	dput(dentry);
 }
 
 static int populate_attrs(struct config_item *item)
@@ -825,8 +802,12 @@ static void link_group(struct config_group *parent_group, struct config_group *g
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

