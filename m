Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BCE2C027A;
	Wed, 29 Apr 2026 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472544; cv=none; b=ZNUX5Ryogka1EAXnNfLpqbvSNK+kCg7zmJXyR/i5DD3FSV+KJolXxwE3Z/yxJOJkcKWoFAVD5y6VIbDeH9V1aU8n336DDWdlQywr3ORpUtNotD9St0c7NY8mbwq7xOhDfcIQmHpSC9J/6bTrFRF3PKLEs42OJSvBENvoOaItCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472544; c=relaxed/simple;
	bh=KKBTAETFL/suhP21Y1Km1Zq5ZngyYNMztUHV1kBm+g4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0dRSZQHY5oxdGm97Qgw6KPRPQgPsLjAJIVpZXN5KPvoPsw8EAO0BJjtUNFSszD8HCEGPV8Tn+cTnhtp37M4hNK59SZ1ZM+gdqkgAyHbo6BRfxE/aCtogU72ZZpeDHcHTY+BOOxWY8Wy3xHJ8ozybfOYhIf/jrJ0adunBsF3sfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8ArjcLf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8ArjcLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E948AC19425;
	Wed, 29 Apr 2026 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472544;
	bh=KKBTAETFL/suhP21Y1Km1Zq5ZngyYNMztUHV1kBm+g4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=r8ArjcLf+m/t3QYW2d73sM4BunPARKJuMvddb1NZLGgnQR+2EIhSkVVRRd8pROgDq
	 sl3gsNvtD6FOlNIGQ/2kMhToTCsBX6rx1MTuSlWc7nLZXzkoYHelXrhTM5Gkxv59P2
	 5vLF9w8klPuDyPnRA2Oj67yqL0wssAJsOiUmIPw55fdasM0tD82ZQzZJqfR/y9yUhi
	 DwyXcf91YuVVqM/jH+h95kISyweoEkeokQN84z7K6Dw6nRVD2+HkMtShQHzLf5ZLAY
	 Pm2xxEjHwfKwkmG0m6vio60wiFgUJJTBNyle6KzmpQpdwgi6pNWD1qFdGWzeGiwKoF
	 1vibaVrIWZNnw==
Date: Wed, 29 Apr 2026 07:22:23 -0700
Subject: [PATCH 3/4] fuse: update file mode when updating acls
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747204051.4101397.16466232272715875212.stgit@frogsfrogsfrogs>
In-Reply-To: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs>
References: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If someone sets ACLs on a file that can be expressed fully as Unix DAC
mode bits, most local filesystems will then update the mode bits and
drop the ACL xattr to reduce inefficiency in the file access paths.
Let's do that too.  Note that means that we can setacl and end up with
no ACL xattrs, so we also need to tolerate ENODATA returns from
fuse_removexattr.

Note that here we define a "local" fuse filesystem as one that uses
fuseblk mode; we'll shortly add fuse servers that use iomap for the file
IO path to that list.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    2 +-
 fs/fuse/acl.c    |   56 +++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 8 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4c135a7edf54ac..0bcfb42592895c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1050,7 +1050,7 @@ static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
 	return get_fuse_mount_super(inode->i_sb);
 }
 
-static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
+static inline struct fuse_conn *get_fuse_conn(const struct inode *inode)
 {
 	return get_fuse_mount_super(inode->i_sb)->fc;
 }
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index cbde6ac1add35a..bee8a9a734f50a 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -11,6 +11,18 @@
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 
+/*
+ * If this fuse server behaves like a local filesystem, we can implement the
+ * kernel's optimizations for ACLs for local filesystems instead of passing
+ * the ACL requests straight through to another server.
+ */
+static inline bool fuse_inode_has_local_acls(const struct inode *inode)
+{
+	const struct fuse_conn *fc = get_fuse_conn(inode);
+
+	return fc->posix_acl && fuse_inode_is_exclusive(inode);
+}
+
 static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
 					struct inode *inode, int type, bool rcu)
 {
@@ -98,6 +110,8 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
+	umode_t mode = inode->i_mode;
+	const bool local_acls = fuse_inode_has_local_acls(inode);
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -113,14 +127,25 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	else
 		return -EINVAL;
 
+	/*
+	 * If the ACL can be represented entirely with changes to the mode
+	 * bits, then most filesystems will update the mode bits and delete
+	 * the ACL xattr.
+	 */
+	if (acl && type == ACL_TYPE_ACCESS && local_acls) {
+		ret = posix_acl_update_mode(idmap, inode, &mode, &acl);
+		if (ret)
+			return ret;
+	}
+
 	if (acl) {
 		unsigned int extra_flags = 0;
 		/*
-		 * Fuse userspace is responsible for updating access
-		 * permissions in the inode, if needed. fuse_setxattr
-		 * invalidates the inode attributes, which will force
-		 * them to be refreshed the next time they are used,
-		 * and it also updates i_ctime.
+		 * For non-local filesystems, fuse userspace is responsible for
+		 * updating access permissions in the inode, if needed.
+		 * fuse_setxattr invalidates the inode attributes, which will
+		 * force them to be refreshed the next time they are used, and
+		 * it also updates i_ctime.
 		 */
 		size_t size;
 		void *value;
@@ -137,9 +162,10 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		/*
 		 * Fuse daemons without FUSE_POSIX_ACL never changed the passed
 		 * through POSIX ACLs. Such daemons don't expect setgid bits to
-		 * be stripped.
+		 * be stripped, unless they've explicitly told the kernel to
+		 * take care of that.
 		 */
-		if (fc->posix_acl &&
+		if (fc->posix_acl && !local_acls &&
 		    !in_group_or_capable(idmap, inode,
 					 i_gid_into_vfsgid(idmap, inode)))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
@@ -148,6 +174,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		kfree(value);
 	} else {
 		ret = fuse_removexattr(inode, name);
+		/* If the acl didn't exist to start with that's fine. */
+		if (ret == -ENODATA)
+			ret = 0;
+	}
+
+	/* If we scheduled a mode update above, push that to userspace now. */
+	if (!ret) {
+		struct iattr attr = { };
+
+		if (mode != inode->i_mode) {
+			attr.ia_valid |= ATTR_MODE;
+			attr.ia_mode = mode;
+		}
+
+		if (attr.ia_valid)
+			ret = fuse_do_setattr(idmap, dentry, &attr, NULL);
 	}
 
 	if (fc->posix_acl) {

