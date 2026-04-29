Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6A10F1;
	Wed, 29 Apr 2026 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473310; cv=none; b=UzVGVEa8hjfi3HCWC6s873i+EHCAk7tQ+5Bp0m5immgrWx+fDEI1gzgN1f8312e1600x/35TC+jC47clVap6oTBB/wDTxhD7IW48MoQhdB/MqKVuYigD4zIwPhQWr6SzR0toA7omOt2yTv0+6MREuFSke8moW8fmHiMeoZZqqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473310; c=relaxed/simple;
	bh=QIXgqF/jK7Bu6r6MgM2i22YQp/cjXKD1qXJK8yhe5tQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDPpFjepiL8Qqh1Naa9GlQGotvUc9lISA5opJNaGjH0gt2pmfOPOLbfPWwXpFu8JdNH720W/nqEzjp9hZ8/54ne5rvswTKg1+GNVoSx6C9zqmgRXFVVrIod80Xk8DJPeHnn8XoXqRN9/sLochwDXkPpJm4iJktaDys+9dtEOvys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtNgBX1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtNgBX1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA7EC19425;
	Wed, 29 Apr 2026 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473310;
	bh=QIXgqF/jK7Bu6r6MgM2i22YQp/cjXKD1qXJK8yhe5tQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RtNgBX1il5t6G2xdUh+XFncIZEjNmXk73Q8zZgz1Mt21AYD2DTpF5Qa/927JYNPB3
	 5VApbP56zqQY2h+OSn2Vya6PxmzDcwNLygX2gdMkvU2zaZHxv+yMcFFw3Qqp+CXWoz
	 p1xk+8aVJvCeZjk29K/RLAp5rlHvzQCYRygUfEi7PUrMHDSZNmmSWVetBY9p7IUDVp
	 TmFAaSEk8kOLtoV8T7uEVQc+TWnm5C8iIDnSFChCAjwBXkX4KgTlVNkFEO8LgtfayC
	 1YkU6xUYoreKiBpYkE/oUsI3mIjl54wXeXoSwkMBghMwHRKJuYYpwLvVjMMtCryh1x
	 Y6X/0tSKTxHeg==
Date: Wed, 29 Apr 2026 07:35:10 -0700
Subject: [PATCH 8/9] fuse: update ctime when updating acls on an iomap inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206659.4103309.4775738448916496995.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, the fuse kernel driver is in charge of updating file
attributes, so we need to update ctime after an ACL change.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/acl.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 9619ac84a85886..76c46946640d44 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -7,6 +7,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
 
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
@@ -113,6 +114,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	const char *name;
 	umode_t mode = inode->i_mode;
 	const bool local_acls = fuse_inode_has_local_acls(inode);
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -180,10 +182,24 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			ret = 0;
 	}
 
-	/* If we scheduled a mode update above, push that to userspace now. */
 	if (!ret) {
 		struct iattr attr = { };
 
+		/*
+		 * When we're running in iomap mode, we need to update mode and
+		 * ctime ourselves instead of letting the fuse server figure
+		 * that out.
+		 */
+		if (is_iomap) {
+			attr.ia_valid |= ATTR_CTIME;
+			inode_set_ctime_current(inode);
+			attr.ia_ctime = inode_get_ctime(inode);
+		}
+
+		/*
+		 * If we scheduled a mode update above, push that to userspace
+		 * now.
+		 */
 		if (mode != inode->i_mode) {
 			attr.ia_valid |= ATTR_MODE;
 			attr.ia_mode = mode;

