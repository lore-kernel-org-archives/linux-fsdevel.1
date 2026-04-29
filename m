Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527A3570C8;
	Wed, 29 Apr 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473326; cv=none; b=APjlmu7WkH1wlSCsHBemAey1I5BlvI5M+LaL9XUtAcxOPEGzkOrD2+oalpMj6y7m+7Vad1Ubq8LBwS+J7y5Q8anrGZ9XnDP4Xy/beltUjUaWH7ISJA64JKUywTWVapKVUwK8JYHFmKiDzYC5pJequ4xtSQdjEmayrayS8UQh9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473326; c=relaxed/simple;
	bh=v5pQKlKQDtXY/t0lmUzYHRV+yDtjQKwSLtXlx4DUino=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgEIgHu9AeIDsVsQGucY2BqNyqx5F4NiNxDy8QvakhIAlbwoobUms3J2MZy8lSkUzqySbLyUYxX2A5O7YRkr68lpR3dUYYwW9mJkQ+aoVr0HBDrEfs6vMd9ZcTu/Wlz6EWOoTiXJh7rua4ghbg4Wu2Lxbs6hwnR/uKzs0UkJIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKt4ON/R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKt4ON/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1D2C19425;
	Wed, 29 Apr 2026 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473326;
	bh=v5pQKlKQDtXY/t0lmUzYHRV+yDtjQKwSLtXlx4DUino=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gKt4ON/RBv5zbTrN0MTA8ctOpEa9WUY+SKrDQGxnXYSrS/lNsEAiD2ivkb2uxSFG/
	 AW4H3bBt0Ckg02oUCaSCazTf1ASBZ5DcpAYpf2WovD5/nZFNpoAGBTV2VmpKMzNHfp
	 H6vuiQ6mLDhKB+ZS/yYNSblE2c7UK76pe/7cbpHiC4zDTxoxdAfEQFnoMQjXn1PLVj
	 Etwedflr0AO6pK2xqPcyPSL85fCNYpy1FaV7LQs9D7NDN7SGz50peIvcyGrj9KUhcj
	 +MN5vc1XpkoKE15QsNCcdLKU32g3SQ3OwfE7L7OuMb2WNXTYRGAXVIlyfP9yrfrLFK
	 8qErSYqBUUGEw==
Date: Wed, 29 Apr 2026 07:35:25 -0700
Subject: [PATCH 9/9] fuse: always cache ACLs when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206680.4103309.11723648282385068624.stgit@frogsfrogsfrogs>
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

Keep ACLs cached in memory when we're using iomap, so that we don't have
to make a round trip to the fuse server.  This might want to become a
FUSE_ATTR_ flag.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/acl.c     |   12 +++++++++---
 fs/fuse/dir.c     |   11 ++++++++---
 fs/fuse/readdir.c |    5 ++++-
 3 files changed, 21 insertions(+), 7 deletions(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 76c46946640d44..8e88029ae29265 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -212,10 +212,16 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (fc->posix_acl) {
 		/*
 		 * Fuse daemons without FUSE_POSIX_ACL never cached POSIX ACLs
-		 * and didn't invalidate attributes. Retain that behavior.
+		 * and didn't invalidate attributes. Retain that behavior
+		 * except for iomap, where we assume that only the source of
+		 * ACL changes is userspace.
 		 */
-		forget_all_cached_acls(inode);
-		fuse_invalidate_attr(inode);
+		if (!ret && is_iomap) {
+			set_cached_acl(inode, type, acl);
+		} else {
+			forget_all_cached_acls(inode);
+			fuse_invalidate_attr(inode);
+		}
 	}
 
 	return ret;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 716f3e893dda66..ca75f2e9be4464 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -447,7 +447,8 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
 			goto invalid;
 
-		forget_all_cached_acls(inode);
+		if (!fuse_inode_has_iomap(inode))
+			forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &outarg.attr, NULL,
 				       ATTR_TIMEOUT(&outarg),
 				       attr_version);
@@ -1667,7 +1668,8 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 		sync = time_before64(fi->i_time, get_jiffies_64());
 
 	if (sync) {
-		forget_all_cached_acls(inode);
+		if (!fuse_inode_has_iomap(inode))
+			forget_all_cached_acls(inode);
 		/* Try statx if a field not covered by regular stat is wanted */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
 			err = fuse_do_statx(idmap, inode, file, stat);
@@ -1851,6 +1853,9 @@ static int fuse_access(struct inode *inode, int mask)
 
 static int fuse_perm_getattr(struct inode *inode, int mask)
 {
+	if (fuse_inode_has_iomap(inode))
+		return 0;
+
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
@@ -2534,7 +2539,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 		 * If filesystem supports acls it may have updated acl xattrs in
 		 * the filesystem, so forget cached acls for the inode.
 		 */
-		if (fc->posix_acl)
+		if (fc->posix_acl && !is_iomap)
 			forget_all_cached_acls(inode);
 
 		/* Directory mode changed, may need to revalidate access */
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 5ba19ca9d8a949..bd92bb00d197f7 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -8,6 +8,8 @@
 
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
+
 #include <linux/iversion.h>
 #include <linux/posix_acl.h>
 #include <linux/pagemap.h>
@@ -228,7 +230,8 @@ static int fuse_direntplus_link(struct file *file,
 		fi->nlookup++;
 		spin_unlock(&fi->lock);
 
-		forget_all_cached_acls(inode);
+		if (!fuse_inode_has_iomap(inode))
+			forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &o->attr, NULL,
 				       ATTR_TIMEOUT(o),
 				       attr_version);

