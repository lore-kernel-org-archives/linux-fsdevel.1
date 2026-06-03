Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B46405C4D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472907; cv=none; b=lFYZ2YF+xCySNFci00FAn178z1FnpB7VzBKqeRyCyN81FBvsVs5F3hQ2AakZFnUx3vcXli5lDQcR7r5WVsAcTkNwhbCnRKrYm2lkp3bsPhh6k99UZbpYjdLV5ffmRwaNlbPZzlhUUvB2TeghoGu0p7WRWqx0O3DYa1XFhQ6jAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472907; c=relaxed/simple;
	bh=ng5Q/BbxHOLyr4Ue0GnnGsnfRKQhFKldOpBrJOWXlqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKOIPkazVHvOh+U672RAH0vIB1ZOKpmxmXQ9duSgizV4ZqBFaC/OCMBufzvHjkezgSZSR30JM2VNQDHbztG1WLD45X8ohZHInU6l8U1lme9HWKOz7KSm+nFy42afi8zKJq2DU0X5Hgu15yaPLIxIgRdn7gjFf8FMqp8fyCj2A7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dgDM7Mvr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dgDM7Mvr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wc5IiHVCXOvMW4pFAc3CruF1vcev1c4X6nedR6SZBu0=; b=dgDM7Mvr7lSRmZj+tzujzzPCTi
	zzQTzg6eKatOCT43/90MbsKdiD+p3yROdhf+S2ACVAYf77NzJQDLrt/L0iS56AaIwsvURHtiwe26E
	nFgji9SABS2LdYci093s55+K+F08yCWerGJ+v/JB4xTXN2WIi8FTHgFzAPrhtg1Iib7Ts5a/XicZF
	kXBmbQ6jGmYIYfR8+57EpF5lCIX2mPbbIvxjWmtEIPApKnHvajIUmjYymKfhMQqeRdvdi/VrfHl8N
	7wtbGE9xxa7+d5ATrJr+07ZgfIiVKIVago+quDIKimb4h/lYABwLN0pr3UdosccUG+WfnzorqeMM7
	R9K3C1OQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKl-0000000CjEG-43cg;
	Wed, 03 Jun 2026 07:48:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 02/18] configfs: fix lockless traversals of ->s_children
Date: Wed,  3 Jun 2026 08:47:58 +0100
Message-ID: <20260603074815.3033766-5-viro@zeniv.linux.org.uk>
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

Having the parent directory locked protects entries from removal
by another thread, but it does *not* protect cursors from being
moved around by lseek() - or freed, for that matter.

Fixes: 6f6107640625 ("configfs: Introduce configfs_dirent_lock")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 54 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index e84483a0836d..eb991b2a9c34 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -235,15 +235,16 @@ static int configfs_dirent_exists(struct dentry *dentry)
 	const unsigned char *new = dentry->d_name.name;
 	struct configfs_dirent *sd;
 
+	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (sd->s_element) {
-			const unsigned char *existing = configfs_get_name(sd);
-			if (strcmp(existing, new))
-				continue;
-			else
+			if (strcmp(configfs_get_name(sd), new) == 0) {
+				spin_unlock(&configfs_dirent_lock);
 				return -EEXIST;
+			}
 		}
 	}
+	spin_unlock(&configfs_dirent_lock);
 
 	return 0;
 }
@@ -575,11 +576,28 @@ static void configfs_detach_rollback(struct dentry *dentry)
 			configfs_detach_rollback(sd->s_dentry);
 }
 
+/*
+ * Find the next non-cursor.  configfs_dirent_lock held by caller.
+ */
+static struct configfs_dirent *next_dirent(struct configfs_dirent *parent,
+					   struct configfs_dirent *last)
+{
+	struct configfs_dirent *s;
+
+	s = list_prepare_entry(last, &parent->s_children, s_sibling);
+
+	list_for_each_entry_continue(s, &parent->s_children, s_sibling) {
+		if (s->s_element)
+			return s;
+	}
+	return NULL;
+}
+
 static void detach_attrs(struct config_item * item)
 {
 	struct dentry * dentry = dget(item->ci_dentry);
-	struct configfs_dirent * parent_sd;
-	struct configfs_dirent * sd, * tmp;
+	struct configfs_dirent *parent_sd;
+	struct configfs_dirent *sd, *next;
 
 	if (!dentry)
 		return;
@@ -588,15 +606,19 @@ static void detach_attrs(struct config_item * item)
 		 dentry->d_name.name);
 
 	parent_sd = dentry->d_fsdata;
-	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
-		if (!sd->s_element || !(sd->s_type & CONFIGFS_NOT_PINNED))
+
+	spin_lock(&configfs_dirent_lock);
+	for (sd = next_dirent(parent_sd, NULL); sd; sd = next) {
+		next = next_dirent(parent_sd, sd);
+		if (!(sd->s_type & CONFIGFS_NOT_PINNED))
 			continue;
-		spin_lock(&configfs_dirent_lock);
 		list_del_init(&sd->s_sibling);
 		spin_unlock(&configfs_dirent_lock);
 		configfs_drop_dentry(sd, dentry);
 		configfs_put(sd);
+		spin_lock(&configfs_dirent_lock);
 	}
+	spin_unlock(&configfs_dirent_lock);
 
 	/**
 	 * Drop reference from dget() on entrance.
@@ -655,18 +677,20 @@ static void detach_groups(struct config_group *group)
 	struct dentry * dentry = dget(group->cg_item.ci_dentry);
 	struct dentry *child;
 	struct configfs_dirent *parent_sd;
-	struct configfs_dirent *sd, *tmp;
+	struct configfs_dirent *sd, *next;
 
 	if (!dentry)
 		return;
 
 	parent_sd = dentry->d_fsdata;
-	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
-		if (!sd->s_element ||
-		    !(sd->s_type & CONFIGFS_USET_DEFAULT))
+	spin_lock(&configfs_dirent_lock);
+	for (sd = next_dirent(parent_sd, NULL); sd; sd = next) {
+		next = next_dirent(parent_sd, sd);
+		if (!(sd->s_type & CONFIGFS_USET_DEFAULT))
 			continue;
 
 		child = sd->s_dentry;
+		spin_unlock(&configfs_dirent_lock);
 
 		inode_lock(d_inode(child));
 
@@ -678,7 +702,9 @@ static void detach_groups(struct config_group *group)
 
 		d_delete(child);
 		dput(child);
+		spin_lock(&configfs_dirent_lock);
 	}
+	spin_unlock(&configfs_dirent_lock);
 
 	/**
 	 * Drop reference from dget() on entrance.
@@ -1130,6 +1156,7 @@ configfs_find_subsys_dentry(struct configfs_dirent *root_sd,
 	struct configfs_dirent *p;
 	struct configfs_dirent *ret = NULL;
 
+	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(p, &root_sd->s_children, s_sibling) {
 		if (p->s_type & CONFIGFS_DIR &&
 		    p->s_element == subsys_item) {
@@ -1137,6 +1164,7 @@ configfs_find_subsys_dentry(struct configfs_dirent *root_sd,
 			break;
 		}
 	}
+	spin_unlock(&configfs_dirent_lock);
 
 	return ret;
 }
-- 
2.47.3

