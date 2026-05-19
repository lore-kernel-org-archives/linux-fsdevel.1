Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC863B3BE6
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174398; cv=none; b=S98D9a6cZNJUcN2psENoK0eY9X/Sw4qMyS1A4W5XeefAOhoNjn7mlSm7t8Nx077moTy1eQoOYlZ3p6/lEjYOlzkVvJEhqmbP6XdkDLTxY7xlOYWLT6uV8gf3qlwabjPNXrlGohoVFZGRdgegS3Gb3T0uUNyGnVrGihhU8009BnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174398; c=relaxed/simple;
	bh=Dlo9W8hHOFAiWjJcTwexugcaTjJDSU9qLMUdOLHNUbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iF/z/2dyAAcoGoVV3Tz0bHcIVeURtJHvC6vQyV0Ol9R7oTr5wNvJDLc0KYtrUQ7ndFq6b5D+rqloq1NZopROswIfIed3RIMq+k9Bydlya4A+RIhQ/4A5EV+sWJKEC+zBlfLpZD+fc20CzGSQTjpWoB4LF3LiNeaz1tUyCgDyNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=U7jzQ0es; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="U7jzQ0es"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dutWYJqSr0aD6J9B9qhrhqPN0Tk6tTxUZ7RLJtFmY10=; b=U7jzQ0es5b8ZsycNVIci1Ha166
	teSTE5z4FLmY2DC8T8WlXI3cA6PWtY1/faUuK7HlJ1Whz2NTnDGq5YMeHFelEvmOKegfl2tH/1yue
	w7GlYJc0eh1+Vd2UmweydpZIDQDC1celdp72+xmBiCFtbJwEgagvSUqMwGpwbxD7Oa+ktmroe3xLl
	TV1ZqnsWDAgP3NMrKbrIBvXNIWulBi9t3XU3sav1jrz+y3SjXE54/hSz68AKFlsZJb7pClhGGuGML
	gtZgDT0O1Ru+91A6ipo3VwFPbdv+cjEjGcv0yAGxxz8MqBGEUM7twGuV6rrMU1+dmLJ9g10/digic
	x+vEdWgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXB-00000008Uvd-3wqm;
	Tue, 19 May 2026 07:06:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 07/14] populate_group(): move cleanup on failure to the sole caller
Date: Tue, 19 May 2026 08:06:26 +0100
Message-ID: <20260519070633.2025485-8-viro@zeniv.linux.org.uk>
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

... where it folds with configfs_detach_item() into a call of
configfs_detach_group().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 726c56d1772d..d2a60429a545 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -728,17 +728,13 @@ static int populate_groups(struct config_group *group,
 			   struct configfs_fragment *frag)
 {
 	struct config_group *new_group;
-	int ret = 0;
 
 	list_for_each_entry(new_group, &group->default_groups, group_entry) {
-		ret = create_default_group(group, new_group, frag);
-		if (ret) {
-			detach_groups(group);
-			break;
-		}
+		int ret = create_default_group(group, new_group, frag);
+		if (ret)
+			return ret;
 	}
-
-	return ret;
+	return 0;
 }
 
 void configfs_remove_default_groups(struct config_group *group)
@@ -878,6 +874,13 @@ static void configfs_detach_item(struct config_item *item)
 	configfs_remove_dir(item);
 }
 
+/* Caller holds the mutex of the group's inode */
+static void configfs_detach_group(struct config_item *item)
+{
+	detach_groups(to_config_group(item));
+	configfs_detach_item(item);
+}
+
 static int configfs_attach_group(struct config_item *parent_item,
 				 struct config_item *item,
 				 struct dentry *dentry,
@@ -904,7 +907,7 @@ static int configfs_attach_group(struct config_item *parent_item,
 		configfs_adjust_dir_dirent_depth_before_populate(sd);
 		ret = populate_groups(to_config_group(item), frag);
 		if (ret) {
-			configfs_detach_item(item);
+			configfs_detach_group(item);
 			d_inode(dentry)->i_flags |= S_DEAD;
 			dont_mount(dentry);
 		}
@@ -917,13 +920,6 @@ static int configfs_attach_group(struct config_item *parent_item,
 	return ret;
 }
 
-/* Caller holds the mutex of the group's inode */
-static void configfs_detach_group(struct config_item *item)
-{
-	detach_groups(to_config_group(item));
-	configfs_detach_item(item);
-}
-
 /*
  * After the item has been detached from the filesystem view, we are
  * ready to tear it out of the hierarchy.  Notify the client before
-- 
2.47.3

