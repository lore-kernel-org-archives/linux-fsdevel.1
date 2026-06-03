Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75340244E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472910; cv=none; b=XeXUg8m6QTj6Ipqb1CxgB9yqiMD5iRVxwjaKnm0BnKV1KqNPGL4HJ5kpRQ/sHX4wrpQoMRJzmnGd8k4Zt0hDs2BVUV64zhz4rBlKwJ06IymkY0ZWrMMWAJfBRt5Jld24UveiAyYf+oZCCpKlZDIE0+uDVAFcR33UCjK1ONwT0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472910; c=relaxed/simple;
	bh=iHIAV/KIOvfEA3FCJwua+ASaqN5mu8wvZ7b8biq6g9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aM/KzGI8aa5I4UhCsOahM9yfWhZQ+12V0SEh7v4Sk0XSBOqYtLjl8qaFqmGTyIaZF++HfEHWgV0WO1+gPISLnLWZg2cQZkp3xsph0cHVatvIKt9DHkSKM7PZTvVWjoEJoGkIDrmv2IV3RVBBBtiZM+9zK7TeeJ5VASCtwRSWdkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=B0j1Vhxc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="B0j1Vhxc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JizOmS7MvnqZzdPCyEB65raKvkfrO6RcPrncfCxcN/I=; b=B0j1VhxcZ0Rm9EgoD1K5jFO5UU
	+Hknz0FVRH5WCE2G9fgyQjJonX83Zb6IkH/seR7Pm2i+waG1kDw9/QkVdz39qAPFfsMzEVgkViaZ/
	j1b03YfigqgdtnsMgQDA0HlOwiEpU+Ciub2+hwn7Jqr9oZHlYqj7AkNHfY2dVqSGwh1wbnfRPn14D
	86/oDAe8QrcSksQIBRvQ+RqECHJAjdw1ca4nNo5Ndl3l3TfX8be3i7qn8xUrbX7vZKXtzdIO9AZR6
	0v3Nnu1qYmuv104fxieWKJs0Hoa7H291Z8k6H7TVR3DdcKgPqsXsjd+vgkDT/eXQwM5QtwIcrZJNy
	4iZxkNjg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKp-0000000CjHj-02y6;
	Wed, 03 Jun 2026 07:48:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 18/18] create_default_group(): pass parent's dentry instead of config_group
Date: Wed,  3 Jun 2026 08:48:15 +0100
Message-ID: <20260603074815.3033766-22-viro@zeniv.linux.org.uk>
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

the only way parent_group is used there...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 8fc05fe69992..4d82375b0cfd 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -701,14 +701,14 @@ static void detach_groups(struct dentry *dentry)
  * We could, perhaps, tweak our parent's ->mkdir for a minute and
  * try using vfs_mkdir.  Just a thought.
  */
-static int create_default_group(struct config_group *parent_group,
+static int create_default_group(struct dentry *parent,
 				struct config_group *group,
 				struct configfs_fragment *frag)
 {
 	int ret;
 	struct configfs_dirent *sd;
 	/* We trust the caller holds a reference to parent */
-	struct dentry *child, *parent = parent_group->cg_item.ci_dentry;
+	struct dentry *child;
 
 	if (!group->cg_item.ci_name)
 		group->cg_item.ci_name = group->cg_item.ci_namebuf;
@@ -735,10 +735,11 @@ static int create_default_group(struct config_group *parent_group,
 static int populate_groups(struct config_group *group,
 			   struct configfs_fragment *frag)
 {
+	struct dentry *parent = group->cg_item.ci_dentry;
 	struct config_group *new_group;
 
 	list_for_each_entry(new_group, &group->default_groups, group_entry) {
-		int ret = create_default_group(group, new_group, frag);
+		int ret = create_default_group(parent, new_group, frag);
 		if (ret)
 			return ret;
 	}
@@ -1767,7 +1768,7 @@ int configfs_register_group(struct config_group *parent_group,
 	parent = parent_group->cg_item.ci_dentry;
 
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	ret = create_default_group(parent_group, group, frag);
+	ret = create_default_group(parent, group, frag);
 	if (ret)
 		goto err_out;
 
-- 
2.47.3

