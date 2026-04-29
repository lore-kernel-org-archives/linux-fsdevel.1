Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C32D8DD6;
	Wed, 29 Apr 2026 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473686; cv=none; b=NrQhuDQnRBf04S80nL6YkrgHdi6sdB7aRsFIse5EgKMAQb0vavnRiI+XjdzUydvh0xPSFfWIoysrxDs4RnIpGwYoZE+J5a6Hf7StLlhhT2mkbey23LqkS4WUR994UwvssZmPcqBv6WjHxDTIP+qwve5HIyqymaAjrT+uCNblTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473686; c=relaxed/simple;
	bh=6gOmsEabA6+i6dX53KWIinaG/2l+YEAZIuXXP7r7pCk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbqH7yVcfDg9/VlNKFTRC7NrlSCEZRvZmVezdWByzlzSNgG2eSCSrQ9+nPzaftdzRaTj/X7HkUGUSB7yG/vaJzPMYSE9dyoR5k3Qs04iWMohjJb2bwEMtJT5wm3elFNAZLqvEfWbqOUQXoAVFMFa8befGr/8XURBF+upN8Jl3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN3Kyvtu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN3Kyvtu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1219C19425;
	Wed, 29 Apr 2026 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473685;
	bh=6gOmsEabA6+i6dX53KWIinaG/2l+YEAZIuXXP7r7pCk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HN3KyvtugoMB9c58EnLK3ud6h6bEeMq2+68GrGB0LSta51NqO5pOfy8Ya5uRUzJJP
	 mYwzGIOz8cpduIhoR1sztz8Ssg4bYR5PRRM7md9OyimdlD/6A9Y/QNy273jMscbGUI
	 TUXJxRgdWWc3EKyAs0NakOARgyz8gGmgXaOBS4gsHYhCK/5Z3PssSURBXnWikoMb65
	 8NozJTr0xBj96YuYfPH3fqnfhqUItUPCKVgZ7zbB2zeZvVHTxuurqT3JGC96/GbbDT
	 OcIAzIZ/FiXBMYGqflXnMe4m6d3K4xu61mZOgxW5F611bB6u1fjsKYm+ZImsZ48DC3
	 rtp7XUcKOTx4Q==
Date: Wed, 29 Apr 2026 07:41:25 -0700
Subject: [PATCH 09/25] libfuse: add upper level iomap ioend commands
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211728.4104686.7746081628649904525.stgit@frogsfrogsfrogs>
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

Teach the upper level fuse library about iomap ioend events, which
happen when a write that isn't a pure overwrite completes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    9 +++++++++
 lib/fuse.c     |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 8e79103f45404d..dbb72c80b138c6 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -902,6 +902,15 @@ struct fuse_operations {
 			 off_t pos_in, uint64_t length_in,
 			 uint32_t opflags_in, ssize_t written_in,
 			 const struct fuse_file_iomap *iomap);
+
+	/**
+	 * Respond to the outcome of a file IO operation.
+	 */
+	int (*iomap_ioend)(const char *path, uint64_t nodeid,
+			   uint64_t attr_ino, off_t pos_in,
+			   uint64_t written_in, uint32_t ioendflags_in,
+			   int error_in, uint32_t dev_in,
+			   uint64_t new_addr_in, off_t *newsize);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 8f012710c994d5..1bd672a7818a1f 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2872,6 +2872,28 @@ int fuse_fs_iomap_device_remove(int device_id)
 	return fuse_lowlevel_iomap_device_remove(se, device_id);
 }
 
+static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
+			       uint64_t nodeid, uint64_t attr_ino, off_t pos,
+			       uint64_t written, uint32_t ioendflags, int error,
+			       uint32_t dev, uint64_t new_addr, off_t *newsize)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.iomap_ioend)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		fuse_log(FUSE_LOG_DEBUG,
+			 "iomap_ioend[%s] nodeid %llu attr_ino %llu pos %llu written %zu ioendflags 0x%x error %d dev %u new_addr 0x%llx\n",
+			 path, (unsigned long long)nodeid,
+			 (unsigned long long)attr_ino, (unsigned long long)pos,
+			 written, ioendflags, error, dev,
+			 (unsigned long long)new_addr);
+	}
+
+	return fs->op.iomap_ioend(path, nodeid, attr_ino, pos, written,
+				  ioendflags, error, dev, new_addr, newsize);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4621,6 +4643,36 @@ static void fuse_lib_iomap_end(fuse_req_t req, fuse_ino_t nodeid,
 	reply_err(req, err);
 }
 
+static void fuse_lib_iomap_ioend(fuse_req_t req, fuse_ino_t nodeid,
+				 uint64_t attr_ino, off_t pos, size_t written,
+				 uint32_t ioendflags, int error, uint32_t dev,
+				 uint64_t new_addr)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	off_t newsize = 0;
+	int err;
+
+	err = get_path_nullok(f, nodeid, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_iomap_ioend(f->fs, path, nodeid, attr_ino, pos, written,
+				  ioendflags, error, dev, new_addr, &newsize);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, nodeid, path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_reply_iomap_ioend(req, newsize);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4725,6 +4777,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.syncfs = fuse_lib_syncfs,
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
+	.iomap_ioend = fuse_lib_iomap_ioend,
 };
 
 int fuse_notify_poll(struct fuse_pollhandle *ph)

