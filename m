Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E62FD1B3;
	Wed, 29 Apr 2026 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473623; cv=none; b=L6+Lxh4GRzr1m6J9B+sQ7Ie/jnw/DExn3NeUyJEs7apf//MjL36cWGCL9DmcmQkJKizfrpHvhwJWtfBBDiStFlyGUSG0j3ffydYDFhMrsC4Tn4QyQHpSiy7XbkqCVM8S3VPXfqat34ItlJmdSNfxtbiozX5jkI9eaa5Ref8x8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473623; c=relaxed/simple;
	bh=KG51QL+/l71cUW2mnlEOnapNQLZxPRSASygxCHDmu6c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpLHe67Ut0pE2LWdQk/afTvfLLnGjOT1qDPvgFKLTVusGWz1lOlYPxsHXNbBIiOIaLgv+W0miOL4ldFdKdMVJ9ohncjvb1MI6ZdOc915v6cT8QzsYfy5C/9pYAUECUbuUQ0LQ2pxdY11FNRySkzSTIjzX3g/5KhSHwWB21V347E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcQSdUgk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcQSdUgk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEAAC19425;
	Wed, 29 Apr 2026 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473623;
	bh=KG51QL+/l71cUW2mnlEOnapNQLZxPRSASygxCHDmu6c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OcQSdUgkGyzDA3wqxyDMoW7Mh0umc1VUm9PaVUNFgNTMVVQg3djuehfSMye3BqSwo
	 GSbijoT6dWs5RHQqpGqnecxUu/TH1QYOP942mQbvcHv+9T4/v/b7jr/Abz1XC+91uc
	 zdZspVlWTOYRs6sdAEArE7WU0UiGapYKlJhYjp+1uEUbhAic/o2u4Kfv0Bo1WdKWJb
	 lZn4Drym+Y3SvTZmTCSDN/lxwododxXxmorYJoQGbNwNV9PRZ1moerwKYWTct1lR33
	 Vt3AqjfxaY/LED1OrQPWTj+9WVVGjy/HC0l0QDmOIktgTISASUFWGJvUTEjmIXDnR6
	 M2JHdBpmOoumQ==
Date: Wed, 29 Apr 2026 07:40:23 -0700
Subject: [PATCH 05/25] libfuse: add upper level iomap commands
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211656.4104686.16419473486400887241.stgit@frogsfrogsfrogs>
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

Teach the upper level fuse library about the iomap begin and end
operations, and connect it to the lower level.  This is needed for
fuse2fs to start using iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |   17 +++++++++
 lib/fuse.c     |  102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 129c744e39c46a..58d7538aee795c 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -885,6 +885,23 @@ struct fuse_operations {
 	 * calling fsync(2) on every file on the filesystem.
 	 */
 	int (*syncfs)(const char *path);
+
+	/**
+	 * Send a mapping to the kernel so that a file IO operation can run.
+	 */
+	int (*iomap_begin)(const char *path, uint64_t nodeid,
+			   uint64_t attr_ino, off_t pos_in,
+			   uint64_t length_in, uint32_t opflags_in,
+			   struct fuse_file_iomap *read_out,
+			   struct fuse_file_iomap *write_out);
+
+	/**
+	 * Respond to the outcome of a previous file mapping operation.
+	 */
+	int (*iomap_end)(const char *path, uint64_t nodeid, uint64_t attr_ino,
+			 off_t pos_in, uint64_t length_in,
+			 uint32_t opflags_in, ssize_t written_in,
+			 const struct fuse_file_iomap *iomap);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 1bb94ca6aa0d39..c8089baaf6628c 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2813,6 +2813,49 @@ int fuse_fs_chmod(struct fuse_fs *fs, const char *path, mode_t mode,
 	return fs->op.chmod(path, mode, fi);
 }
 
+static int fuse_fs_iomap_begin(struct fuse_fs *fs, const char *path,
+			       fuse_ino_t nodeid, uint64_t attr_ino, off_t pos,
+			       uint64_t count, uint32_t opflags,
+			       struct fuse_file_iomap *read,
+			       struct fuse_file_iomap *write)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_begin)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_begin[%s] nodeid %llu attr_ino %llu pos %llu count %llu opflags 0x%x\n",
+			 path, (unsigned long long)nodeid,
+			 (unsigned long long)attr_ino, (unsigned long long)pos,
+			 (unsigned long long)count, opflags);
+	}
+
+	return fs->op.iomap_begin(path, nodeid, attr_ino, pos, count, opflags,
+				  read, write);
+}
+
+static int fuse_fs_iomap_end(struct fuse_fs *fs, const char *path,
+			     fuse_ino_t nodeid, uint64_t attr_ino, off_t pos,
+			     uint64_t count, uint32_t opflags, ssize_t written,
+			     const struct fuse_file_iomap *iomap)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_end)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_end[%s] nodeid %llu attr_ino %llu pos %llu count %llu opflags 0x%x written %zd\n",
+			 path, (unsigned long long)nodeid,
+			 (unsigned long long)attr_ino, (unsigned long long)pos,
+			 (unsigned long long)count, opflags, written);
+	}
+
+	return fs->op.iomap_end(path, nodeid, attr_ino, pos, count, opflags,
+				written, iomap);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4505,6 +4548,63 @@ static void fuse_lib_syncfs(fuse_req_t req, fuse_ino_t ino)
 	reply_err(req, err);
 }
 
+static void fuse_lib_iomap_begin(fuse_req_t req, fuse_ino_t nodeid,
+				 uint64_t attr_ino, off_t pos, uint64_t count,
+				 uint32_t opflags)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_file_iomap read = { };
+	struct fuse_file_iomap write = { };
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path_nullok(f, nodeid, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_begin(f->fs, path, nodeid, attr_ino, pos, count,
+				  opflags, &read, &write);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, nodeid, path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	if (write.length == 0)
+		fuse_iomap_pure_overwrite(&write, &read);
+
+	fuse_reply_iomap_begin(req, &read, &write);
+}
+
+static void fuse_lib_iomap_end(fuse_req_t req, fuse_ino_t nodeid,
+			       uint64_t attr_ino, off_t pos, uint64_t count,
+			       uint32_t opflags, ssize_t written,
+			       const struct fuse_file_iomap *iomap)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path_nullok(f, nodeid, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_end(f->fs, path, nodeid, attr_ino, pos, count,
+				opflags, written, iomap);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, nodeid, path);
+	reply_err(req, err);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4607,6 +4707,8 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.statx = fuse_lib_statx,
 #endif
 	.syncfs = fuse_lib_syncfs,
+	.iomap_begin = fuse_lib_iomap_begin,
+	.iomap_end = fuse_lib_iomap_end,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)

