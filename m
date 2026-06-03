Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8F405C44
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472907; cv=none; b=ksE8OhBb5GM5DMOsAkkAwobgIRbmB4qJXDxoDYM9FRQvbudoBOMpIDh2ROgU3TYXLTEXmG4VqI3eH8hChUqiatl0hp5dSDaRBZiZ4GJ2VY23FZE8jGQn8uuiAQ1BH2OLY8A2qpVDTF7ugNNk0IdjHeUnEtLkZJQsLz0vmx3Egdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472907; c=relaxed/simple;
	bh=+OXp4I2w8P194EHNr3T3/e39X0kdoGPQipQTnWq8Cok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhhTDObNpGTlxmfazZ5/Rg6IcmtDm1Pa2oB7J9P38VnbzULZ8IlUoU/ZBJUEszzXYZCW5ltuTYb/cKuuMf8NZi9DjWjLgDj9gBPd+9LIb1Be96Dc6dcOQEWUw074zVlmv1hF5Lj+Ux6fWaZ1dDB9VU/xnA1vO4jtqaqMuZeXNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=a/mj8Dvf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a/mj8Dvf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8m1bCZuQV9fxbIWqfY/3QghVnznjtksaO8b6ID4CQJA=; b=a/mj8Dvfa/vWitjc3DS8RPZF3v
	FWGs3rIYemXJEdIjMdJNQ4z/w2pA4vcN7cPioV9O0uQctu4nRspuA+QRHTy5Uv8g1uBLnlO+cJcHn
	vDd7StYRXnb8vih2LN7U+kmE1Gf9MGN/rf/vfBzjqGkdLtINPsIeJYCtzVLhyddNqnSUT7PXidp4R
	h5jjGeAEmEqxfHhZwd7jWLAJQjf2Wm//Dybsmsj0LA839Mu4hj5VJZlViGhhFIvm9rDSjroxH2Aqh
	CtTmCl2n6wgsQD+PbJfTmJJdFi5pbnNg7Llpru3X2aV8BBEDd0OZ5aapSxR7Ef1nIG0UJy5jH3vbV
	gJpU6KLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKl-0000000CjE6-3MWy;
	Wed, 03 Jun 2026 07:48:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/3] get rid of impossible checks in detach_attrs()/configfs_detach_item()
Date: Wed,  3 Jun 2026 08:47:56 +0100
Message-ID: <20260603074815.3033766-3-viro@zeniv.linux.org.uk>
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

configfs_detach_item() is never called with NULL item->ci_dentry.
Call graph stinks to high heaven, unfortunately (which is a major part
of the reasons for the entire massage)...

1) after successful configfs_create_dir(item, dentry), item->ci_dentry
is non-NULL, equal to dentry and dentry->d_fsdata->s_element points
to item.
2) after successful configfs_attach_item(_, item, dentry), we know we'd
passed through successful configfs_create_dir()
3) all directory dentries other than root have passed through successful
configfs_create_dir().  Root has ->d_fsdata set manually so that the
same warranties hold - ->d_fsdata->s_element->ci_dentry points back to
dentry itself.
4) when sd->s_type gets CONFIGFS_USET_DEFAULT set, we are guaranteed that
sd->s_element points to an item with ->ci_dentry non-NULL and
->ci_dentry->d_fsdata pointing back to sd.

configfs_detach_item()
	configfs_attach_item(), after successful configfs_create_dir()
	configfs_attach_group(), after successful configfs_attach_item()
	configfs_rmdir(), with item coming from dentry->d_fsdata->s_element,
			dentry being that of a directory
	configfs_detach_group()
		configfs_rmdir() (same as above)
		detach_groups(), given sd->s_element when sd->s_type has
				CONFIGFS_USET_DEFAULT))
		configfs_unregister_group(), assumes we'd called
				configfs_register_group() first, which
				would've done configfs_default_group(),
				which would've done configfs_attach_group().
				In any case, oopses a line later if
				->ci_dentry is NULL.
		configfs_unregister_subsystem(), assumes we'd called
				configfs_register_subsystem() first, which
				would've done configfs_attach_group().
				In any case, would've already oopsed if
				->ci_dentry had been NULL.

detach_attrs() is called only by configfs_detach_item() and gets item
from it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

detach_attrs() is called only by configfs_detach_item() and gets item
from it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 98bf37376165..515f41e7dba2 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -519,9 +519,6 @@ static void detach_attrs(struct config_item * item)
 	struct configfs_dirent * parent_sd;
 	struct configfs_dirent * sd, * tmp;
 
-	if (!dentry)
-		return;
-
 	pr_debug("configfs %s: dropping attrs for  dir\n",
 		 dentry->d_name.name);
 
@@ -773,9 +770,6 @@ static void configfs_detach_item(struct config_item *item)
 	detach_attrs(item);
 
 	dentry = dget(item->ci_dentry);
-	if (!dentry)
-		return;
-
 	parent = dget(dentry->d_parent);
 
 	configfs_remove_dirent(dentry);
-- 
2.47.3

