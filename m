Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38883FE668
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472906; cv=none; b=smZ+IXUQovr3Fetp9v3+itwJPwA3i6UIDUnGH+BlroXbhvhFyZcJnrVWqcT65riOcAPSMKFJRXs59LylNjbfMV1v9WSlUipR/KsGvXbgXJQrLhidcvHvUxvpHYxpoynW3gjYdQl95YgQQ0eK2Hh+UDukzih0al3+XdjqCD2sbDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472906; c=relaxed/simple;
	bh=wuyNWfac326FDlU28jp9Qaklczhf7wpB1cjsQ5omxkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeHMWloQShWDEp25lP58v8UA7qt5+lzWucT8eFXgxcZ1xvHnWXWeR5X1FYh5VHfeM13b1qeDWxuDLrNgR88qnLMEFcc2QaalLtpcOU/ofg4gfMagSQLMkLI5warU4mtledYMVp1s0GQaDJZtZufzrK1xIo7SbzQMvP/7aXvg/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uHNFOkS7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uHNFOkS7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9bZXfU56nu/W625eKxSy1XMzeZQIUQDaYyS78oUpKdk=; b=uHNFOkS7amCWaSFldcyOMDy/fz
	YQ0+7KzfAR+yNTp6CWMwIlcrobyxJEChI1eDNxdi864C+o3iXkn6e8jF9DVGiP+yp8neZ6YFj3cBX
	UDjFUbOq97prTXBNol5I/EAfdayxebPtczIoSOw1fdkDvSaphmgz7EfnNxg2NQrufXG9EZIb5Zei1
	QiXQEDrad2ofbp2mbDzoxGfW9A1X60MLQJri4EijCM0Bs0xTJNTe7zR/nmZCP+83v4Sff8SO0clk2
	bULJVKn2YXOImaPTRKT/CpXejwMddWWMQS3EoZBA7Pb3UxSmnRE0wa9ceeOASIT58PIc8J5gIIUKi
	rduAo41Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKm-0000000CjFJ-3B4a;
	Wed, 03 Jun 2026 07:48:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 08/18] populate_group(): move cleanup on failure to the sole caller
Date: Wed,  3 Jun 2026 08:48:05 +0100
Message-ID: <20260603074815.3033766-12-viro@zeniv.linux.org.uk>
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

... where it folds with configfs_detach_item() into a call of
configfs_detach_group().

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index c420191610c3..01de8ef5fbe6 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -754,17 +754,13 @@ static int populate_groups(struct config_group *group,
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
@@ -904,6 +900,13 @@ static void configfs_detach_item(struct config_item *item)
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
@@ -930,7 +933,7 @@ static int configfs_attach_group(struct config_item *parent_item,
 		configfs_adjust_dir_dirent_depth_before_populate(sd);
 		ret = populate_groups(to_config_group(item), frag);
 		if (ret) {
-			configfs_detach_item(item);
+			configfs_detach_group(item);
 			d_inode(dentry)->i_flags |= S_DEAD;
 			dont_mount(dentry);
 		}
@@ -943,13 +946,6 @@ static int configfs_attach_group(struct config_item *parent_item,
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

