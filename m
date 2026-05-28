Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C3F3F9F52
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990867; cv=none; b=VTRYo9SU1Ck697pwWpSY6psJcT0ggUzZUjBuKuFsY9Zsrv6fyc0iBF3JI358pdVS4z1/be04VC0aINqgH6ZXmYAFCE1uco34ZoDk9149xuVGAsENLhaXBbiQo7jvyhZWunx93sQN6gvAeGdGOzRQFhmPtj/+tPezuWd1AtBqfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990867; c=relaxed/simple;
	bh=Ue8HKH9MpdMTsCJjxt8OtXyYjATu+d0+/k0c1WFzPvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKws/Wl6AhTJqLF6dzEnhM25eFajkG0vl6R2gSmV0qwN7WFeYN11aKsyx4CtZmAuYsnV1GSeujHx3UJqhkGHiR+ZkmdYcDFTLu8lqikC209jqsEBZepGPTXZAUXceLTQP72CI7I/16IH06FW0QFdBDuzdjFX48QCwjWbereDcM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Givdo+tm; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Givdo+tm"
X-KPN-MessageId: 3e7c2c58-5abe-11f1-afe2-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3e7c2c58-5abe-11f1-afe2-005056994fde;
	Thu, 28 May 2026 19:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=w6Un1rCkqbM0OEBOr4ke4J3x7jxD52UgDVisxetoJrY=;
	b=Givdo+tmGJPYjR8tnDCW90uDTJCdzMFZeuUlvCFu5TEGMobsv5k007/MB6j70eyDAkPpamLph2NRL
	 TrdzVdj4uhOnnMftxccMYNzqGCWnWCJXNCfhtKmFq3qMT0HHDrdo77/wXE1vaKiEL0hUWM4jp8aSz6
	 IMoRJP7bI+6w6TcuOhRYsGS6zc86vytiknBlMeLGQqHBBrIO2/wO8YTUo98xuFXvJXJq6/Mrrpj8fP
	 SDTogOhXn0Rey4TrDrgWicj3OPFraq+2+/GvM+HdElVRZjOU1Y4iKOAfepDPv2EmMKu2sRsaWwj6mC
	 EDXYjC9chpjyqrzdpiQYmAeUVU5dJgA==
X-KPN-MID: 33|So/0RRqGHCK4CLmitwnDZDNtM37FoHCpqKSt2KiQuhFjeTgkAC9RalXJGlcOg6v
 6E+6A9wiOah942EaOlA860PHIdeSg/vG8vP2g0oV1K4g=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|j174vUss0B5MNfWXGswfiAhZ/AqN0UR18aPsk8zHZYdLaV0mk6zODH1xvqqZHo2
 u9+0dCDsniWPYnA3/ew+Syg==
Received: from daedalus.space.revspace.nl (83-84-7-238.cable.dynamic.v4.ziggo.nl [83.84.7.238])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 3e652001-5abe-11f1-9c0c-00505699d6e5;
	Thu, 28 May 2026 19:54:16 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] vfs: replace ints with enum last_type for LAST_XXX
Date: Thu, 28 May 2026 17:58:47 +0000
Message-ID: <20260528175854.57626-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528175854.57626-1-jkoolstra@xs4all.nl>
References: <20260528175854.57626-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several functions in namei.c take an "int *type" parameter, such as
filename_parentat(). To know what values this can take you have to find
the anonymous struct that defines the LAST_XXX values. Define an enum
last_type to make this type explicit.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 889792761bc2..a1ba45f9faa9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -132,7 +132,7 @@ static struct kmem_cache *__names_cache __ro_after_init;
 /*
  * Type of the last component on LOOKUP_PARENT
  */
-enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
+enum last_type {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 
 void __init filename_init(void)
 {
@@ -732,7 +732,7 @@ struct nameidata {
 	struct inode	*inode; /* path.dentry.d_inode */
 	unsigned int	flags, state;
 	unsigned	seq, next_seq, m_seq, r_seq;
-	int		last_type;
+	enum last_type	last_type;
 	unsigned	depth;
 	int		total_link_count;
 	struct saved {
@@ -2225,7 +2225,7 @@ static struct dentry *follow_dotdot(struct nameidata *nd)
 	return dget(nd->path.dentry);
 }
 
-static const char *handle_dots(struct nameidata *nd, int type)
+static const char *handle_dots(struct nameidata *nd, enum last_type type)
 {
 	if (type == LAST_DOTDOT) {
 		const char *error = NULL;
@@ -2873,7 +2873,7 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 /* Note: this does not consume "name" */
 static int __filename_parentat(int dfd, struct filename *name,
 			       unsigned int flags, struct path *parent,
-			       struct qstr *last, int *type,
+			       struct qstr *last, enum last_type *type,
 			       const struct path *root)
 {
 	int retval;
@@ -2898,7 +2898,7 @@ static int __filename_parentat(int dfd, struct filename *name,
 
 static int filename_parentat(int dfd, struct filename *name,
 			     unsigned int flags, struct path *parent,
-			     struct qstr *last, int *type)
+			     struct qstr *last, enum last_type *type)
 {
 	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
 }
@@ -2966,7 +2966,8 @@ static struct dentry *__start_removing_path(int dfd, struct filename *name,
 	struct path parent_path __free(path_put) = {};
 	struct dentry *d;
 	struct qstr last;
-	int type, error;
+	enum last_type type;
+	int error;
 
 	error = filename_parentat(dfd, name, 0, &parent_path, &last, &type);
 	if (error)
@@ -3012,7 +3013,8 @@ struct dentry *kern_path_parent(const char *name, struct path *path)
 	CLASS(filename_kernel, filename)(name);
 	struct dentry *d;
 	struct qstr last;
-	int type, error;
+	enum last_type type;
+	int error;
 
 	error = filename_parentat(AT_FDCWD, filename, 0, &parent_path, &last, &type);
 	if (error)
@@ -3062,7 +3064,7 @@ int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
 			   struct path *parent, struct qstr *last,
 			   const struct path *root)
 {
-	int type;
+	enum last_type type;
 	int err =  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
 				       &type, root);
 	if (err)
@@ -4937,7 +4939,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	bool want_dir = lookup_flags & LOOKUP_DIRECTORY;
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
 	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
-	int type;
+	enum last_type type;
 	int error;
 
 	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
@@ -5399,7 +5401,7 @@ int filename_rmdir(int dfd, struct filename *name)
 	struct dentry *dentry;
 	struct path path;
 	struct qstr last;
-	int type;
+	enum last_type type;
 	unsigned int lookup_flags = 0;
 	struct delegated_inode delegated_inode = { };
 retry:
@@ -5408,6 +5410,8 @@ int filename_rmdir(int dfd, struct filename *name)
 		return error;
 
 	switch (type) {
+	case LAST_NORM:
+		break;
 	case LAST_DOTDOT:
 		error = -ENOTEMPTY;
 		goto exit2;
@@ -5541,7 +5545,7 @@ int filename_unlinkat(int dfd, struct filename *name)
 	struct dentry *dentry;
 	struct path path;
 	struct qstr last;
-	int type;
+	enum last_type type;
 	struct inode *inode;
 	struct delegated_inode delegated_inode = { };
 	unsigned int lookup_flags = 0;
@@ -6108,7 +6112,7 @@ int filename_renameat2(int olddfd, struct filename *from,
 	struct renamedata rd;
 	struct path old_path, new_path;
 	struct qstr old_last, new_last;
-	int old_type, new_type;
+	enum last_type old_type, new_type;
 	struct delegated_inode delegated_inode = { };
 	unsigned int lookup_flags = 0;
 	bool should_retry = false;
-- 
2.54.0

