Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E175372B59;
	Wed, 29 Apr 2026 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473764; cv=none; b=QMhY5XYIlXGG8UJZqhZbyicHu7v10YHC/0UNWQKLgRoy4KOKnzr2iX1SVFJbvdIKbLvey0ylo6QeJrZAcavhHS60CYKvvQYwIbn3UKT0FVy20k/2ObggaWl2ObxEksiJJrzUkiVMwPorPkdjsdVt9KCkXTZ2PhXLYPZCbIMeF00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473764; c=relaxed/simple;
	bh=Fw0ZIYtYDrNCh8zh1DFNC8UisEjb1WcIURSSLZV6uQM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERUM8m9D4s9o7Hw8PxvFWkj2niItu26uO/9/1+rrXCpdk3grV3abxV2dzUZsxpZ7gP+UYbLFpXD9NO6Mqd3Jd2tOGlJJR2OEiRl0RK9ZTvnMnbg0v9H9lfuV7SStaOKNzW+lW2uNYxSUsoCnlc2JtV3pKjpSJVirWt1B1UjSGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO3iew2L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO3iew2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF38C19425;
	Wed, 29 Apr 2026 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473764;
	bh=Fw0ZIYtYDrNCh8zh1DFNC8UisEjb1WcIURSSLZV6uQM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KO3iew2LhetqoagUKSaagqjcV/cM/WIt/0s23GRALOfrOGhXFG2gf+Fzq9DHTHM/b
	 uq82oNloLe3v3AKynl15c4jh+fLwf6cUNe48tg/AYBWRtkUj8DRw/dhjktqWJtM/1k
	 ribdW8QGdCnmIGt4Ih/rBKMgL2aR1G5+74caQol8wtwcVDEbYvLW5flo7fri75AzUr
	 xyoF8kW+0BdNqvUipbMRBAfLD6ecTZQJmTFBnVfdOgG3EhsibkmPa/LrlWbhkiz9cr
	 OhpgVHtUjpaCZi3lxvwaaTlGCpb6cwwpqgdMT9ZfWBqIzB0hz3uaGVxm3V3riaHwI+
	 cZ4uPoEc/2zGw==
Date: Wed, 29 Apr 2026 07:42:43 -0700
Subject: [PATCH 14/25] libfuse: don't allow hardlinking of iomap files in the
 upper level fuse library
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211818.4104686.16474605311582967133.stgit@frogsfrogsfrogs>
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

The upper level fuse library creates a separate node object for every
(i)node referenced by a directory entry.  Unfortunately, it doesn't
account for the possibility of hardlinks, which means that we can create
multiple nodeids that refer to the same hardlinked inode.  Inode locking
in iomap mode in the kernel relies there only being one inode object for
a hardlinked file, so we cannot allow anyone to hardlink an iomap file.
The client had better not turn on iomap for an existing hardlinked file.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   18 ++++++++++
 lib/fuse.c             |   90 +++++++++++++++++++++++++++++++++++++++++++-----
 lib/fuse_versionscript |    2 +
 3 files changed, 101 insertions(+), 9 deletions(-)


diff --git a/include/fuse.h b/include/fuse.h
index 1b009c7bdee295..e2099ebc8ac7a1 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1472,6 +1472,24 @@ int fuse_fs_iomap_device_add(int fd, unsigned int flags);
  */
 int fuse_fs_iomap_device_remove(int device_id);
 
+/**
+ * Decide if we can enable iomap mode for a particular file for an upper-level
+ * fuse server.
+ *
+ * @param stbuf stat information for the file.
+ * @return true if it can be enabled, false if not.
+ */
+bool fuse_fs_can_enable_iomap(const struct stat *stbuf);
+
+/**
+ * Decide if we can enable iomap mode for a particular file for an upper-level
+ * fuse server.
+ *
+ * @param statxbuf statx information for the file.
+ * @return true if it can be enabled, false if not.
+ */
+bool fuse_fs_can_enable_iomapx(const struct statx *statxbuf);
+
 int fuse_notify_poll(struct fuse_pollhandle *ph);
 
 /**
diff --git a/lib/fuse.c b/lib/fuse.c
index f2d1026c90b957..35ba13271d0b9c 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -3274,10 +3274,66 @@ static void fuse_lib_rename(fuse_req_t req, fuse_ino_t olddir,
 	reply_err(req, err);
 }
 
+/*
+ * Decide if file IO for this inode can use iomap.
+ *
+ * The upper level libfuse creates internal node ids that have nothing to do
+ * with the ext2_ino_t that we give it.  These internal node ids are what
+ * actually gets igetted in the kernel, which means that there can be multiple
+ * fuse_inode objects in the kernel for a single hardlinked inode in the fuse
+ * server.
+ *
+ * What this means, horrifyingly, is that on a fuse filesystem that supports
+ * hard links, the in-kernel i_rwsem does not protect against concurrent writes
+ * between files that point to the same inode.  That in turn means that the
+ * file mode and size can get desynchronized between the multiple fuse_inode
+ * objects.  This also means that we cannot cache iomaps in the kernel AT ALL
+ * because the caches will get out of sync, leading to WARN_ONs from the iomap
+ * zeroing code and probably data corruption after that.
+ *
+ * Therefore, libfuse must never create hardlinks of iomap files, and the
+ * predicates below allow fuse servers to decide if they can turn on iomap for
+ * existing hardlinked files.
+ */
+bool fuse_fs_can_enable_iomap(const struct stat *stbuf)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return false;
+
+	return stbuf->st_nlink < 2;
+}
+
+bool fuse_fs_can_enable_iomapx(const struct statx *statxbuf)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return false;
+
+	return statxbuf->stx_nlink < 2;
+}
+
+static bool fuse_lib_can_link(fuse_req_t req, fuse_ino_t ino)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct node *node;
+
+	if (!(req->se->conn.want_ext & FUSE_CAP_IOMAP))
+		return true;
+
+	node = get_node(f, ino);
+	return !(node->iflags & FUSE_IFLAG_IOMAP);
+}
+
 static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 			  const char *newname)
 {
 	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
 	struct fuse_entry_param e;
 	char *oldpath;
 	char *newpath;
@@ -3286,17 +3342,33 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 
 	err = get_path2(f, ino, NULL, newparent, newname,
 			&oldpath, &newpath, NULL, NULL);
-	if (!err) {
-		struct fuse_intr_data d;
+	if (err)
+		goto out_reply;
 
-		fuse_prepare_interrupt(f, req, &d);
-		err = fuse_fs_link(f->fs, oldpath, newpath);
-		if (!err)
-			err = lookup_path(f, newparent, newname, newpath,
-					  &e, &iflags, NULL);
-		fuse_finish_interrupt(f, req, &d);
-		free_path2(f, ino, newparent, NULL, NULL, oldpath, newpath);
+	/*
+	 * The upper level fuse library creates a separate node object for
+	 * every (i)node referenced by a directory entry.  Unfortunately, it
+	 * doesn't account for the possibility of hardlinks, which means that
+	 * we can create multiple nodeids that refer to the same hardlinked
+	 * inode.  Inode locking in iomap mode in the kernel relies there only
+	 * being one inode object for a hardlinked file, so we cannot allow
+	 * anyone to hardlink an iomap file.  The client had better not turn on
+	 * iomap for an existing hardlinked file.
+	 */
+	if (!fuse_lib_can_link(req, ino)) {
+		err = -EPERM;
+		goto out_path;
 	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_link(f->fs, oldpath, newpath);
+	if (!err)
+		err = lookup_path(f, newparent, newname, newpath,
+				  &e, &iflags, NULL);
+	fuse_finish_interrupt(f, req, &d);
+out_path:
+	free_path2(f, ino, newparent, NULL, NULL, oldpath, newpath);
+out_reply:
 	reply_entry(req, &e, iflags, err);
 }
 
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 01c11ba1794231..5c1a1bfff44d87 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -260,6 +260,8 @@ FUSE_3.99 {
 		fuse_reply_create_iflags;
 		fuse_reply_entry_iflags;
 		fuse_add_direntry_plus_iflags;
+		fuse_fs_can_enable_iomap;
+		fuse_fs_can_enable_iomapx;
 } FUSE_3.19;
 
 # Local Variables:

