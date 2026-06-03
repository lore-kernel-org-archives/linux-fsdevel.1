Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BDA402438
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472905; cv=none; b=p8WtzpEshIJtUuO9sQFqhEclBS2cjHsB5I9+0diSYVSeLhvxVztnLpOjT+227pFba/rje5QG6vVIaxbV091YaLIyXFrScLTDFgoyoFXsaYTNW8/sjb+ovcG23xqDapX0VBKuhbXycBlAmur5noOuwFYNaazSksPs9ciI7g/vwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472905; c=relaxed/simple;
	bh=xJf6QowbCN8Ij0se8iVAy2lEEjr7B9xkc7UDNTLFEpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXjWTvIzVptTzR9PhurWUIQvyKYzyK4+UpUP/MR1qd5wIJMePQCSrF5O7TiQXBH0XdQPfNFDCI9wtVmmBX2frDI9CyJ8rz3S1XQPblDpFvsWhm/aIOL5yxqfmNIZQWlXfn0Mg3C7OOx/7HIuLT+oAYClxTpnZLvauvPC7Tk6MCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Y6c0Rr8E; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Y6c0Rr8E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aajDy027KMMwsuOo458skPhdfGZDlmSyDtjhs16TGeA=; b=Y6c0Rr8EfNXK37FCEzu42/wO6j
	6Y7qGZ4qvn/y6kw4vd75xgwPMtNe/qZZ+hqmUTVyjyshwbegfseF5UzZYnF7ugXGtVJMjcXr46Kfi
	tcLdYvN+M8fNaK4g7vfWrLaQixmKyw62qppde/ib1cvSZW2hS0qXIWH+mo5eGlhWezTfzxHCT7oT0
	YZmJ2A4Da+wp4QDeNSTcKpNL7xk/mwB4Efoc0YEelxXYwgOxsTpfkVfdUVl2WJWUgds/BE2x62MeL
	erdvT0hH0JcwCLBA7y5X7EmKqA293FxyjwTCD+kIG02VOocsQXTcRZfj1HJWQa190/Fkt+5VmnqKy
	8AkLO6Aw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKm-0000000CjEN-18FM;
	Wed, 03 Jun 2026 07:48:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 03/18] configfs_mkdir(): use take_dentry_name_snapshot()
Date: Wed,  3 Jun 2026 08:48:00 +0100
Message-ID: <20260603074815.3033766-7-viro@zeniv.linux.org.uk>
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

Note that neither ->make_group() nor ->make_item() are allowed to modify
the string passed to them - the argument is const char *.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index eb991b2a9c34..8181771c8a58 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1329,7 +1329,11 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
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
 
@@ -1381,14 +1385,6 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -1410,7 +1406,6 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	}
 	mutex_unlock(&subsys->su_mutex);
 
-	kfree(name);
 	if (ret) {
 		/*
 		 * If ret != 0, then link_obj() was never called.
@@ -1497,6 +1492,7 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	put_fragment(frag);
 
 out:
+	release_dentry_name_snapshot(&n);
 	return ERR_PTR(ret);
 }
 
-- 
2.47.3

