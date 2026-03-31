Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86B43D51A
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978655; cv=none; b=pJYLKAuHXZWHs9Yy+e9LUN2ujTCusPSRfqFn9d45Q4n0imPCNuzUXn9i4bGfLBCTyo+et0Ft60dYcD9q6Hxn9gkZYxqbPd71qFJNlny+R5lp3j4WIkEF4kuWvdxZLBSANRlyU/tKfmI4ZLT4H2aS+9YE9vbIrBPDX196r0GDO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978655; c=relaxed/simple;
	bh=UlWP6sYcWaF2aurRQYpuyIGOlldcF8ngCfZMNWAc2mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKHLhNZUYKzatnrJOudsUTN9BX69csjaJ6OondyTuLTXjq94HWHbGUZP0ZGcV0OwIJ2gO+/VQnhZ5BkjIg7p14M/yDYcrR7i4WKwM5pOwau8bLvV1sgsYd0yc7H7zSzoysNZAgOVfxiasuX10xvPlIk6Bg/LsmpVkm+yk+Uv/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=t3UBVye0; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="t3UBVye0"
X-KPN-MessageId: 47c9b9f3-2d28-11f1-969c-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 47c9b9f3-2d28-11f1-969c-005056abbe64;
	Tue, 31 Mar 2026 19:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=2YlyIdMRNoNd4J0kW1xvb6hL4F7KOX/JA5sN5ydhYuI=;
	b=t3UBVye0v0jwibNsIMAGm0Fc2LMoiJjiTp9e3sAKED/2BLRhifB+1zxWmXHS+VQCvkhSDRbtQu3xG
	 PXQnle/dijGfBZMo7pmuUBA0lBMtddbTNpvDz5yrlVT2zoDlAM0jbdvyJT0kPPjptSc+cpieI+nEiv
	 S7yuXjVMCl0mVZ1qzRCbDtqvSm/IwuJn8AkPkXPRG7VdKZJFIZguYh0LdkmuEbKSow02i4BkqPeAzC
	 roy+pfQB9g+xry6KWx9DypnpIGvq/R9rP77MaN69qLPKFziFJABk0VOYv/lxKHLvS+qjCsByXKEWpC
	 kdmn0jJyQztTP3qc12BfzEj662nYezQ==
X-KPN-MID: 33|t5zuWKj6Lz23LxhdxkkGhi2F7ST9rxGjajF7V8l1h88rHMju4DzdjuXrCOhHZeU
 QKzVBHLWS8MTZO91lVb7SeeJlze63BETWbpDc3e2Xs38=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nfL480qF5bvgH6tlTp8JjNWOEUncXMfYFcdJ/JXPkxLWRwwwQLAEMcfvc/AxVmD
 O3NYpnSFZEvcVAyw5iA8srg==
Received: from daedalus.home (unknown [178.227.25.158])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 44b1ea90-2d28-11f1-8011-005056ab7447;
	Tue, 31 Mar 2026 19:37:24 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: gregkh@linuxfoundation.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] vfs: replace ints with enum component_type for LAST_XXX
Date: Tue, 31 Mar 2026 19:37:22 +0200
Message-ID: <20260331173726.3517440-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several functions in namei.c take an "int *type" parameter, such as
filename_parentat(). To know what values this can take you have to find
the anonymous struct that defines the LAST_XXX values. I would argue
that the readability of the code is improved by making this an explicit
type. Also, when we have this "enum component_type" is does not really
make sense anymore to talk about LAST_XXX, but we should just use XXX,
as there is nothing specific about the component type showing up at the
end of a path.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c            | 75 ++++++++++++++++++++++---------------------
 include/linux/namei.h |  4 +--
 2 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9e5500dad14f..1eb9db055292 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -721,15 +721,15 @@ EXPORT_SYMBOL(path_put);
 
 #define EMBEDDED_LEVELS 2
 struct nameidata {
-	struct path	path;
-	struct qstr	last;
-	struct path	root;
-	struct inode	*inode; /* path.dentry.d_inode */
-	unsigned int	flags, state;
-	unsigned	seq, next_seq, m_seq, r_seq;
-	int		last_type;
-	unsigned	depth;
-	int		total_link_count;
+	struct path		path;
+	struct qstr		last;
+	struct path		root;
+	struct inode		*inode; /* path.dentry.d_inode */
+	unsigned int		flags, state;
+	unsigned		seq, next_seq, m_seq, r_seq;
+	enum component_type	last_type;
+	unsigned		depth;
+	int			total_link_count;
 	struct saved {
 		struct path link;
 		struct delayed_call done;
@@ -2221,9 +2221,9 @@ static struct dentry *follow_dotdot(struct nameidata *nd)
 	return dget(nd->path.dentry);
 }
 
-static const char *handle_dots(struct nameidata *nd, int type)
+static const char *handle_dots(struct nameidata *nd, enum component_type type)
 {
-	if (type == LAST_DOTDOT) {
+	if (type == DOTDOT) {
 		const char *error = NULL;
 		struct dentry *parent;
 
@@ -2267,7 +2267,7 @@ static __always_inline const char *walk_component(struct nameidata *nd, int flag
 	 * to be able to know about the current root directory and
 	 * parent relationships.
 	 */
-	if (unlikely(nd->last_type != LAST_NORM)) {
+	if (unlikely(nd->last_type != NORMAL)) {
 		if (unlikely(nd->depth) && !(flags & WALK_MORE))
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
@@ -2577,7 +2577,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	int depth = 0; // depth <= nd->depth
 	int err;
 
-	nd->last_type = LAST_ROOT;
+	nd->last_type = ROOT;
 	nd->flags |= LOOKUP_PARENT;
 	if (IS_ERR(name))
 		return PTR_ERR(name);
@@ -2607,16 +2607,16 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 
 		switch(lastword) {
 		case LAST_WORD_IS_DOTDOT:
-			nd->last_type = LAST_DOTDOT;
+			nd->last_type = DOTDOT;
 			nd->state |= ND_JUMPED;
 			break;
 
 		case LAST_WORD_IS_DOT:
-			nd->last_type = LAST_DOT;
+			nd->last_type = DOT;
 			break;
 
 		default:
-			nd->last_type = LAST_NORM;
+			nd->last_type = NORMAL;
 			nd->state &= ~ND_JUMPED;
 
 			struct dentry *parent = nd->path.dentry;
@@ -2780,7 +2780,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 static inline const char *lookup_last(struct nameidata *nd)
 {
-	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
+	if (nd->last_type == NORMAL && nd->last.name[nd->last.len])
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	return walk_component(nd, WALK_TRAILING);
@@ -2869,7 +2869,7 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 /* Note: this does not consume "name" */
 static int __filename_parentat(int dfd, struct filename *name,
 			       unsigned int flags, struct path *parent,
-			       struct qstr *last, int *type,
+			       struct qstr *last, enum component_type *type,
 			       const struct path *root)
 {
 	int retval;
@@ -2894,7 +2894,7 @@ static int __filename_parentat(int dfd, struct filename *name,
 
 static int filename_parentat(int dfd, struct filename *name,
 			     unsigned int flags, struct path *parent,
-			     struct qstr *last, int *type)
+			     struct qstr *last, enum component_type *type)
 {
 	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
 }
@@ -2963,12 +2963,13 @@ static struct dentry *__start_removing_path(int dfd, struct filename *name,
 	struct path parent_path __free(path_put) = {};
 	struct dentry *d;
 	struct qstr last;
-	int type, error;
+	enum component_type type;
+	int error;
 
 	error = filename_parentat(dfd, name, 0, &parent_path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
-	if (unlikely(type != LAST_NORM))
+	if (unlikely(type != NORMAL))
 		return ERR_PTR(-EINVAL);
 	/* don't fail immediately if it's r/o, at least try to report other errors */
 	error = mnt_want_write(parent_path.mnt);
@@ -3009,12 +3010,13 @@ struct dentry *kern_path_parent(const char *name, struct path *path)
 	CLASS(filename_kernel, filename)(name);
 	struct dentry *d;
 	struct qstr last;
-	int type, error;
+        enum component_type type;
+	int error;
 
 	error = filename_parentat(AT_FDCWD, filename, 0, &parent_path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
-	if (unlikely(type != LAST_NORM))
+	if (unlikely(type != NORMAL))
 		return ERR_PTR(-EINVAL);
 
 	d = lookup_noperm_unlocked(&last, parent_path.dentry);
@@ -3057,7 +3059,7 @@ EXPORT_SYMBOL(kern_path);
  * @root: pointer to struct path of the base directory
  */
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
-			   struct path *parent, struct qstr *last, int *type,
+			   struct path *parent, struct qstr *last, enum component_type *type,
 			   const struct path *root)
 {
 	return  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
@@ -4550,7 +4552,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 
 	nd->flags |= op->intent;
 
-	if (nd->last_type != LAST_NORM) {
+	if (nd->last_type != NORMAL) {
 		if (nd->depth)
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
@@ -4903,7 +4905,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	bool want_dir = lookup_flags & LOOKUP_DIRECTORY;
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
 	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
-	int type;
+	enum component_type type;
 	int error;
 
 	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
@@ -4914,7 +4916,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * Yucky last component or no last component at all?
 	 * (foo/., foo/.., /////)
 	 */
-	if (unlikely(type != LAST_NORM))
+	if (unlikely(type != NORMAL))
 		goto out;
 
 	/* don't fail immediately if it's r/o, at least try to report other errors */
@@ -5365,7 +5367,7 @@ int filename_rmdir(int dfd, struct filename *name)
 	struct dentry *dentry;
 	struct path path;
 	struct qstr last;
-	int type;
+	enum component_type type;
 	unsigned int lookup_flags = 0;
 	struct delegated_inode delegated_inode = { };
 retry:
@@ -5374,15 +5376,16 @@ int filename_rmdir(int dfd, struct filename *name)
 		return error;
 
 	switch (type) {
-	case LAST_DOTDOT:
+	case DOTDOT:
 		error = -ENOTEMPTY;
 		goto exit2;
-	case LAST_DOT:
+	case DOT:
 		error = -EINVAL;
 		goto exit2;
-	case LAST_ROOT:
+	case ROOT:
 		error = -EBUSY;
 		goto exit2;
+	case NORMAL: ; // OK
 	}
 
 	error = mnt_want_write(path.mnt);
@@ -5507,7 +5510,7 @@ int filename_unlinkat(int dfd, struct filename *name)
 	struct dentry *dentry;
 	struct path path;
 	struct qstr last;
-	int type;
+	enum component_type type;
 	struct inode *inode;
 	struct delegated_inode delegated_inode = { };
 	unsigned int lookup_flags = 0;
@@ -5517,7 +5520,7 @@ int filename_unlinkat(int dfd, struct filename *name)
 		return error;
 
 	error = -EISDIR;
-	if (type != LAST_NORM)
+	if (type != NORMAL)
 		goto exit_path_put;
 
 	error = mnt_want_write(path.mnt);
@@ -6074,7 +6077,7 @@ int filename_renameat2(int olddfd, struct filename *from,
 	struct renamedata rd;
 	struct path old_path, new_path;
 	struct qstr old_last, new_last;
-	int old_type, new_type;
+	enum component_type old_type, new_type;
 	struct delegated_inode delegated_inode = { };
 	unsigned int lookup_flags = 0;
 	bool should_retry = false;
@@ -6103,12 +6106,12 @@ int filename_renameat2(int olddfd, struct filename *from,
 		goto exit2;
 
 	error = -EBUSY;
-	if (old_type != LAST_NORM)
+	if (old_type != NORMAL)
 		goto exit2;
 
 	if (flags & RENAME_NOREPLACE)
 		error = -EEXIST;
-	if (new_type != LAST_NORM)
+	if (new_type != NORMAL)
 		goto exit2;
 
 	error = mnt_want_write(old_path.mnt);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 58600cf234bc..e79ff97063e9 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -16,7 +16,7 @@ enum { MAX_NESTED_LINKS = 8 };
 /*
  * Type of the last component on LOOKUP_PARENT
  */
-enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
+enum component_type {NORMAL, ROOT, DOT, DOTDOT};
 
 /* pathwalk mode */
 #define LOOKUP_FOLLOW		BIT(0)	/* follow links at the end */
@@ -70,7 +70,7 @@ static inline void end_removing_path(const struct path *path , struct dentry *de
 	end_creating_path(path, dentry);
 }
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
-			   struct path *parent, struct qstr *last, int *type,
+			   struct path *parent, struct qstr *last, enum component_type *type,
 			   const struct path *root);
 int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
 		    unsigned int, struct path *);
-- 
2.53.0

