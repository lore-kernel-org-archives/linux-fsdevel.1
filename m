Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528362D8DD6;
	Wed, 29 Apr 2026 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473717; cv=none; b=LIyeYTKzU08fVqMyfX2h5x2b1Ci99WbjbK0/5nUxsJqthEzfBZ2qEdrMrE3OXel5t4K/I3UrUgrJCZBhaSpRZcAk6GDamSghBtoHrmXMV3Jr3nI3LbotwBQ1vmy3MUn+/97IrcPhK+j8Pw2hRlTVchyaWWL3RmMgIdEVioid4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473717; c=relaxed/simple;
	bh=TAXUR8DRqZpJxDmg8eZ4t9DR56+6pn5x6LN1PYrKDho=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMjj0m0Q+Mhe79uNG1TsEc9we3On20HspolO9jj09G7sA7q9QDx+Z69TIHWxFMld25Cn39dduTMhkQK2VW2S7dAxAPnVetEi/9Q1/TG6LjgV/MzrNNtWx5daqmqW8C6VkW3d/saKCivpuywemU3Yb+0G6yjwNbm/R61DnzfzcPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBYWI6US; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBYWI6US"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B553C2BCB8;
	Wed, 29 Apr 2026 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473717;
	bh=TAXUR8DRqZpJxDmg8eZ4t9DR56+6pn5x6LN1PYrKDho=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KBYWI6USBVShL2LdONVhqzN3v1w/N7ARU7xIuxlbor+SynFnEbk92KrEwPA8HyUlQ
	 +La9sSoREEJAgQ+Jj15bACEnUmro++2MkY5cV1Ui+defQc0P/5yuXcRbb1qs2nAqB9
	 7IUeMM8xMSmjOsf1NZdZHa78TKC63/TLNA3QdTo16nZk1qkDteHZ1GUMa5ggXR3v9N
	 BLZDg/ZBY2HjjUa3XX3GL6o/fnvCYjCwqkUpt+aA9AFmsJC+6MNF+p1JO64ov25+1e
	 uc8WDOgj5H0AAyqccTwihQwAk/DokBmearIwp1FGgHZWrQoXXcnIQCsSVs0dSzAPkE
	 1nzt+yzuqLFDA==
Date: Wed, 29 Apr 2026 07:41:56 -0700
Subject: [PATCH 11/25] libfuse: connect high level fuse library to
 fuse_reply_attr_iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211764.4104686.751959395455834873.stgit@frogsfrogsfrogs>
In-Reply-To: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
References: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a new ->getattr_iflags function so that iomap filesystems can set
the appropriate in-kernel inode flags on instantiation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    7 ++
 lib/fuse.c     |  192 ++++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 151 insertions(+), 48 deletions(-)


diff --git a/include/fuse.h b/include/fuse.h
index dbb72c80b138c6..1b009c7bdee295 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -911,6 +911,13 @@ struct fuse_operations {
 			   uint64_t written_in, uint32_t ioendflags_in,
 			   int error_in, uint32_t dev_in,
 			   uint64_t new_addr_in, off_t *newsize);
+
+	/**
+	 * Get file attributes and FUSE_IFLAG_* flags.  Otherwise the same as
+	 * getattr.
+	 */
+	int (*getattr_iflags)(const char *path, struct stat *statbuf,
+			      unsigned int *iflags, struct fuse_file_info *fi);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 1bd672a7818a1f..f2d1026c90b957 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -123,6 +123,7 @@ struct fuse {
 	struct list_head partial_slabs;
 	struct list_head full_slabs;
 	pthread_t prune_thread;
+	bool want_iflags;
 };
 
 struct lock {
@@ -144,6 +145,7 @@ struct node {
 	char *name;
 	uint64_t nlookup;
 	int open_count;
+	unsigned int iflags;
 	struct timespec stat_updated;
 	struct timespec mtime;
 	off_t size;
@@ -1629,6 +1631,24 @@ int fuse_fs_getattr(struct fuse_fs *fs, const char *path, struct stat *buf,
 	return fs->op.getattr(path, buf, fi);
 }
 
+static int fuse_fs_getattr_iflags(struct fuse_fs *fs, const char *path,
+				  struct stat *statbuf, unsigned int *iflags,
+				  struct fuse_file_info *fi)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.getattr_iflags)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		char buf[10];
+
+		fuse_log(FUSE_LOG_DEBUG, "getattr_iflags[%s] %s\n",
+			file_info_string(fi, buf, sizeof(buf)),
+			path);
+	}
+	return fs->op.getattr_iflags(path, statbuf, iflags, fi);
+}
+
 int fuse_fs_rename(struct fuse_fs *fs, const char *oldpath,
 		   const char *newpath, unsigned int flags)
 {
@@ -2490,7 +2510,7 @@ static void update_stat(struct node *node, const struct stat *stbuf)
 }
 
 static int do_lookup(struct fuse *f, fuse_ino_t nodeid, const char *name,
-		     struct fuse_entry_param *e)
+		     struct fuse_entry_param *e, unsigned int *iflags)
 {
 	struct node *node;
 
@@ -2508,25 +2528,64 @@ static int do_lookup(struct fuse *f, fuse_ino_t nodeid, const char *name,
 		pthread_mutex_unlock(&f->lock);
 	}
 	set_stat(f, e->ino, &e->attr);
+	*iflags = node->iflags;
 	return 0;
 }
 
+static int lookup_and_update(struct fuse *f, fuse_ino_t nodeid,
+			     const char *name, struct fuse_entry_param *e,
+			     unsigned int iflags)
+{
+	struct node *node;
+
+	node = find_node(f, nodeid, name);
+	if (node == NULL)
+		return -ENOMEM;
+
+	e->ino = node->nodeid;
+	e->generation = node->generation;
+	e->entry_timeout = f->conf.entry_timeout;
+	e->attr_timeout = f->conf.attr_timeout;
+	if (f->conf.auto_cache) {
+		pthread_mutex_lock(&f->lock);
+		update_stat(node, &e->attr);
+		pthread_mutex_unlock(&f->lock);
+	}
+	set_stat(f, e->ino, &e->attr);
+	node->iflags = iflags;
+	return 0;
+}
+
+static int getattr(struct fuse *f, const char *path, struct stat *buf,
+		   unsigned int *iflags, struct fuse_file_info *fi)
+{
+	if (f->want_iflags)
+		return fuse_fs_getattr_iflags(f->fs, path, buf, iflags, fi);
+	return fuse_fs_getattr(f->fs, path, buf, fi);
+}
+
 static int lookup_path(struct fuse *f, fuse_ino_t nodeid,
 		       const char *name, const char *path,
-		       struct fuse_entry_param *e, struct fuse_file_info *fi)
+		       struct fuse_entry_param *e, unsigned int *iflags,
+		       struct fuse_file_info *fi)
 {
 	int res;
 
 	memset(e, 0, sizeof(struct fuse_entry_param));
-	res = fuse_fs_getattr(f->fs, path, &e->attr, fi);
-	if (res == 0) {
-		res = do_lookup(f, nodeid, name, e);
-		if (res == 0 && f->conf.debug) {
-			fuse_log(FUSE_LOG_DEBUG, "   NODEID: %llu\n",
-				(unsigned long long) e->ino);
-		}
-	}
-	return res;
+	*iflags = 0;
+	res = getattr(f, path, &e->attr, iflags, fi);
+	if (res)
+		return res;
+
+	res = lookup_and_update(f, nodeid, name, e, *iflags);
+	if (res)
+		return res;
+
+	if (f->conf.debug)
+		fuse_log(FUSE_LOG_DEBUG, "   NODEID: %llu iflags 0x%x\n",
+			(unsigned long long) e->ino, *iflags);
+
+	return 0;
 }
 
 static struct fuse_context_i *fuse_get_context_internal(void)
@@ -2613,11 +2672,14 @@ static inline void reply_err(fuse_req_t req, int err)
 }
 
 static void reply_entry(fuse_req_t req, const struct fuse_entry_param *e,
-			int err)
+			unsigned int iflags, int err)
 {
 	if (!err) {
 		struct fuse *f = req_fuse(req);
-		if (fuse_reply_entry(req, e) == -ENOENT) {
+		int entry_res;
+
+		entry_res = fuse_reply_entry_iflags(req, e, iflags);
+		if (entry_res == -ENOENT) {
 			/* Skip forget for negative result */
 			if  (e->ino != 0)
 				forget_node(f, e->ino, 1);
@@ -2658,6 +2720,9 @@ static void fuse_lib_init(void *data, struct fuse_conn_info *conn)
 		/* Disable the receiving and processing of FUSE_INTERRUPT requests */
 		conn->no_interrupt = 1;
 	}
+
+	if (conn->want_ext & FUSE_CAP_IOMAP)
+		f->want_iflags = true;
 }
 
 void fuse_fs_destroy(struct fuse_fs *fs)
@@ -2681,6 +2746,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e = { .ino = 0 }; /* invalid ino */
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 	struct node *dot = NULL;
 
@@ -2695,7 +2761,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 				dot = get_node_nocheck(f, parent);
 				if (dot == NULL) {
 					pthread_mutex_unlock(&f->lock);
-					reply_entry(req, &e, -ESTALE);
+					reply_entry(req, &e, 0, -ESTALE);
 					return;
 				}
 				dot->refctr++;
@@ -2715,7 +2781,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 		if (f->conf.debug)
 			fuse_log(FUSE_LOG_DEBUG, "LOOKUP %s\n", path);
 		fuse_prepare_interrupt(f, req, &d);
-		err = lookup_path(f, parent, name, path, &e, NULL);
+		err = lookup_path(f, parent, name, path, &e, &iflags, NULL);
 		if (err == -ENOENT && f->conf.negative_timeout != 0.0) {
 			e.ino = 0;
 			e.entry_timeout = f->conf.negative_timeout;
@@ -2729,7 +2795,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 		unref_node(f, dot);
 		pthread_mutex_unlock(&f->lock);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void do_forget(struct fuse *f, fuse_ino_t ino, uint64_t nlookup)
@@ -2765,6 +2831,7 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 	struct fuse *f = req_fuse_prepare(req);
 	struct stat buf;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	memset(&buf, 0, sizeof(buf));
@@ -2776,7 +2843,7 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 	if (!err) {
 		struct fuse_intr_data d;
 		fuse_prepare_interrupt(f, req, &d);
-		err = fuse_fs_getattr(f->fs, path, &buf, fi);
+		err = getattr(f, path, &buf, &iflags, fi);
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, ino, path);
 	}
@@ -2789,9 +2856,11 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 			buf.st_nlink--;
 		if (f->conf.auto_cache)
 			update_stat(node, &buf);
+		node->iflags = iflags;
 		pthread_mutex_unlock(&f->lock);
 		set_stat(f, ino, &buf);
-		fuse_reply_attr(req, &buf, f->conf.attr_timeout);
+		fuse_reply_attr_iflags(req, &buf, iflags,
+				       f->conf.attr_timeout);
 	} else
 		reply_err(req, err);
 }
@@ -2900,6 +2969,7 @@ static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 	struct fuse *f = req_fuse_prepare(req);
 	struct stat buf;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	memset(&buf, 0, sizeof(buf));
@@ -2957,19 +3027,23 @@ static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			err = fuse_fs_utimens(f->fs, path, tv, fi);
 		}
 		if (!err) {
-			err = fuse_fs_getattr(f->fs, path, &buf, fi);
+			err = getattr(f, path, &buf, &iflags, fi);
 		}
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, ino, path);
 	}
 	if (!err) {
-		if (f->conf.auto_cache) {
-			pthread_mutex_lock(&f->lock);
-			update_stat(get_node(f, ino), &buf);
-			pthread_mutex_unlock(&f->lock);
-		}
+		struct node *node;
+
+		pthread_mutex_lock(&f->lock);
+		node = get_node(f, ino);
+		if (f->conf.auto_cache)
+			update_stat(node, &buf);
+		node->iflags = iflags;
+		pthread_mutex_unlock(&f->lock);
 		set_stat(f, ino, &buf);
-		fuse_reply_attr(req, &buf, f->conf.attr_timeout);
+		fuse_reply_attr_iflags(req, &buf, iflags,
+				       f->conf.attr_timeout);
 	} else
 		reply_err(req, err);
 }
@@ -3020,6 +3094,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3036,7 +3111,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 			err = fuse_fs_create(f->fs, path, mode, &fi);
 			if (!err) {
 				err = lookup_path(f, parent, name, path, &e,
-						  &fi);
+						  &iflags, &fi);
 				fuse_fs_release(f->fs, path, &fi);
 			}
 		}
@@ -3044,12 +3119,12 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 			err = fuse_fs_mknod(f->fs, path, mode, rdev);
 			if (!err)
 				err = lookup_path(f, parent, name, path, &e,
-						  NULL);
+						  &iflags, NULL);
 		}
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, parent, path);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
@@ -3058,6 +3133,7 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3067,11 +3143,12 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
 		fuse_prepare_interrupt(f, req, &d);
 		err = fuse_fs_mkdir(f->fs, path, mode);
 		if (!err)
-			err = lookup_path(f, parent, name, path, &e, NULL);
+			err = lookup_path(f, parent, name, path, &e, &iflags,
+					  NULL);
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, parent, path);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_lib_unlink(fuse_req_t req, fuse_ino_t parent,
@@ -3141,6 +3218,7 @@ static void fuse_lib_symlink(fuse_req_t req, const char *linkname,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3150,11 +3228,12 @@ static void fuse_lib_symlink(fuse_req_t req, const char *linkname,
 		fuse_prepare_interrupt(f, req, &d);
 		err = fuse_fs_symlink(f->fs, linkname, path);
 		if (!err)
-			err = lookup_path(f, parent, name, path, &e, NULL);
+			err = lookup_path(f, parent, name, path, &e, &iflags,
+					  NULL);
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, parent, path);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_lib_rename(fuse_req_t req, fuse_ino_t olddir,
@@ -3202,6 +3281,7 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 	struct fuse_entry_param e;
 	char *oldpath;
 	char *newpath;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path2(f, ino, NULL, newparent, newname,
@@ -3213,11 +3293,11 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 		err = fuse_fs_link(f->fs, oldpath, newpath);
 		if (!err)
 			err = lookup_path(f, newparent, newname, newpath,
-					  &e, NULL);
+					  &e, &iflags, NULL);
 		fuse_finish_interrupt(f, req, &d);
 		free_path2(f, ino, newparent, NULL, NULL, oldpath, newpath);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_do_release(struct fuse *f, fuse_ino_t ino, const char *path,
@@ -3260,6 +3340,7 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 	struct fuse_intr_data d;
 	struct fuse_entry_param e = {0};
 	char *path;
+	unsigned int iflags;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3267,7 +3348,8 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 		fuse_prepare_interrupt(f, req, &d);
 		err = fuse_fs_create(f->fs, path, mode, fi);
 		if (!err) {
-			err = lookup_path(f, parent, name, path, &e, fi);
+			err = lookup_path(f, parent, name, path, &e,
+					  &iflags, fi);
 			if (err)
 				fuse_fs_release(f->fs, path, fi);
 			else if (!S_ISREG(e.attr.st_mode)) {
@@ -3287,10 +3369,14 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 		fuse_finish_interrupt(f, req, &d);
 	}
 	if (!err) {
+		int create_res;
+
 		pthread_mutex_lock(&f->lock);
 		get_node(f, e.ino)->open_count++;
 		pthread_mutex_unlock(&f->lock);
-		if (fuse_reply_create(req, &e, fi) == -ENOENT) {
+
+		create_res = fuse_reply_create_iflags(req, &e, iflags, fi);
+		if (create_res == -ENOENT) {
 			/* The open syscall was interrupted, so it
 			   must be cancelled */
 			fuse_do_release(f, e.ino, path, fi);
@@ -3324,13 +3410,16 @@ static void open_auto_cache(struct fuse *f, fuse_ino_t ino, const char *path,
 		if (diff_timespec(&now, &node->stat_updated) >
 		    f->conf.ac_attr_timeout) {
 			struct stat stbuf;
+			unsigned int iflags = 0;
 			int err;
+
 			pthread_mutex_unlock(&f->lock);
-			err = fuse_fs_getattr(f->fs, path, &stbuf, fi);
+			err = getattr(f, path, &stbuf, &iflags, fi);
 			pthread_mutex_lock(&f->lock);
-			if (!err)
+			if (!err) {
 				update_stat(node, &stbuf);
-			else
+				node->iflags = iflags;
+			} else
 				node->cache_valid = 0;
 		}
 	}
@@ -3659,6 +3748,7 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 		.ino = 0,
 	};
 	struct fuse *f = dh->fuse;
+	unsigned int iflags = 0;
 
 	if ((flags & ~FUSE_FILL_DIR_PLUS) != 0) {
 		dh->error = -EIO;
@@ -3682,6 +3772,7 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 
 	if (off) {
 		size_t newlen;
+		size_t thislen;
 
 		if (dh->filled) {
 			dh->error = -EIO;
@@ -3697,8 +3788,8 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 
 		if (statp && (flags & FUSE_FILL_DIR_PLUS)) {
 			if (!is_dot_or_dotdot(name)) {
-				int res = do_lookup(f, dh->nodeid, name, &e);
-
+				int res = do_lookup(f, dh->nodeid, name, &e,
+						    &iflags);
 				if (res) {
 					dh->error = res;
 					return 1;
@@ -3706,10 +3797,12 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 			}
 		}
 
-		newlen = dh->len +
-			fuse_add_direntry_plus(dh->req, dh->contents + dh->len,
-					       dh->needlen - dh->len, name,
-					       &e, off);
+		thislen = fuse_add_direntry_plus_iflags(dh->req,
+							dh->contents + dh->len,
+							dh->needlen - dh->len,
+							name, iflags, &e, off);
+		newlen = dh->len + thislen;
+
 		if (newlen > dh->needlen)
 			return 1;
 		dh->len = newlen;
@@ -3796,6 +3889,7 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
 		unsigned rem = dh->needlen - dh->len;
 		unsigned thislen;
 		unsigned newlen;
+		unsigned int iflags = 0;
 		pos++;
 
 		if (flags & FUSE_READDIR_PLUS) {
@@ -3807,15 +3901,17 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
 			if (de->flags & FUSE_FILL_DIR_PLUS &&
 			    !is_dot_or_dotdot(de->name)) {
 				res = do_lookup(dh->fuse, dh->nodeid,
-						de->name, &e);
+						de->name, &e, &iflags);
 				if (res) {
 					dh->error = res;
 					return 1;
 				}
 			}
 
-			thislen = fuse_add_direntry_plus(req, p, rem,
-							 de->name, &e, pos);
+			thislen = fuse_add_direntry_plus_iflags(req, p, rem,
+								de->name,
+								iflags, &e,
+								pos);
 		} else {
 			thislen = fuse_add_direntry(req, p, rem,
 						    de->name, &de->stat, pos);

