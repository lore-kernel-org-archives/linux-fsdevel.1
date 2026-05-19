Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ECD3B47C5
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174399; cv=none; b=b2FAR8H3qzMN0TLJQx5/buXd5LQSpZfDwCnc0CD+gciEnelLxlTrVfBUZ580F4biMsRbdnyxtbkBMf718z5WpjfI2hZfZ5H91+TYD1QJeykPrvCqufegUM6ZCLvIpRf5q+st69kTej9k+ID1MyXDU5g30vgXEb9TrQXhfePmeds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174399; c=relaxed/simple;
	bh=5zLwVQtxrHh/s41CX4SdxB7hermuisghzLCPbtmLugk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbGFnFSN1E0gJfDyIhL0LkQiSghUXcdayEB+zdBE6Hn0seh1q4bSseILRx8F/Bis4A9BZ5nv4XYOa4mHXM78T9q0XxnLChHrohgvcdpPbc6TjUpd58jrmqkzGkW5IzVgII23YpPkgQwr3nSPJ3KJS8iv7SqaEIS7vUSN/BLENEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=prYC7ztG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="prYC7ztG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=18lkhJ4Cri82TMJn9X7IbCdLCAMsnJ8iwyL/xV9Rh/o=; b=prYC7ztGe/pTf7h+EUweezWQHJ
	iO29xX6VLSuuwu6GF3LQiDMF51J3kN9QHTIPKYNTVWLEBlpemeGkEqresy24QihhmEo777wJ4ZoOk
	HKbzn7HjPN9s2sXxjYq7sOE1PyvY0z3lzF3HPQnjNa1EAN2FhqUNMIgtqsXTzU/qL6StuTZjMA7fb
	9P/SUYDncerDOSg/oVhRnTG0h3Oa4I/Lr/oE9T0kfR2iMhuHEVyR+g3pjEVif4GlOEY8PpVk0QZTP
	i6FspdO+hU102utO3yeWzz+SdRmOKzUh5K9JasmUxw6jMVQ6PB3M+ETH4QZYAJaiA2+OD7E4Q2TpM
	MMgUF+Ew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wPEXB-00000008UvP-1nOE;
	Tue, 19 May 2026 07:06:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 02/14] configfs_mkdir(): use take_dentry_name_snapshot()
Date: Tue, 19 May 2026 08:06:21 +0100
Message-ID: <20260519070633.2025485-3-viro@zeniv.linux.org.uk>
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

Note that neither ->make_group() nor ->make_item() are allowed to modify
the string passed to them - the argument is const char *.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index e84483a0836d..662dcd7d1bf0 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1301,7 +1301,11 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	const struct config_item_type *type;
 	struct module *subsys_owner = NULL, *new_item_owner = NULL;
 	struct configfs_fragment *frag;
-	char *name;
+	struct name_snapshot n;
+	const char *name;
+
+	take_dentry_name_snapshot(&n, dentry);
+	name = n.name.name;
 
 	sd = dentry->d_parent->d_fsdata;
 
@@ -1353,14 +1357,6 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_put;
 	}
 
-	name = kmalloc(dentry->d_name.len + 1, GFP_KERNEL);
-	if (!name) {
-		ret = -ENOMEM;
-		goto out_subsys_put;
-	}
-
-	snprintf(name, dentry->d_name.len + 1, "%s", dentry->d_name.name);
-
 	mutex_lock(&subsys->su_mutex);
 	if (type->ct_group_ops->make_group) {
 		group = type->ct_group_ops->make_group(to_config_group(parent_item), name);
@@ -1382,7 +1378,6 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	}
 	mutex_unlock(&subsys->su_mutex);
 
-	kfree(name);
 	if (ret) {
 		/*
 		 * If ret != 0, then link_obj() was never called.
@@ -1469,6 +1464,7 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	put_fragment(frag);
 
 out:
+	release_dentry_name_snapshot(&n);
 	return ERR_PTR(ret);
 }
 
-- 
2.47.3

