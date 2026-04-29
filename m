Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32161E25F9;
	Wed, 29 Apr 2026 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473937; cv=none; b=JBd4EtbyGZbvIhMBRd0W7AVAkntecXu78nCv9IVEuObKHTA9zEuwmGcY4RPbzFtu/aX2GShSoTbmD7GRFexNmXgnKpt5nP2UuAC1Nm3sRTDAXodtED+ETWGd4whM9yV/2LZDA5i+USD4yhHKtsqzylT3reghu+3kZhTtvRMalis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473937; c=relaxed/simple;
	bh=6AITz2ZpiR8Z6a8fghsdmWNH/OAWuJSBSoafDVi77X4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unnHsotlbJxQMp78KN0dfunHDFd8wMHkCxpgQuzuJZnYSB0AoMpEiLm3vfxFd9yKsg+3U4JirisuQbglrdROOlk9SV5y8fQeA65H3oYfmgLbyVS3uYMaVHYITQjRRk5p0vV+gjhKqtmlOi3dwDBRbN1k+Z7XjcSG7bSDuy0rjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dycj56jf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dycj56jf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6F7C19425;
	Wed, 29 Apr 2026 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473936;
	bh=6AITz2ZpiR8Z6a8fghsdmWNH/OAWuJSBSoafDVi77X4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Dycj56jf8vAIukQusKcxlXV19X0f1guZF1iEPiu60/TJRZac/tShBEeenPpTO32e+
	 rJl4JVSM2THnwfC7pj9Sd61asaHoSvzNEDApHwcxTuQuw7gt25qGfQIDTM0YArhHZp
	 clZqhDWR+pxcwMyPQWbQgv3pt5YgEAU1UCsEfi8nZPJb1+a4EBIOyuOpsKtRoQ2j4p
	 Mx+WtZecrhCN/LJnyUg3nkDxxTBKj0S5UcEm/KASFJzeQOVt3mGicJNO0JnXI6XG+F
	 Jp0Igq6iFArHIxLp1vT1QKIYmv4L7ifWonIb6VNfy8guIHqkDajGWMb4MKYmXlXvYJ
	 Drdx5b+dBRbjA==
Date: Wed, 29 Apr 2026 07:45:36 -0700
Subject: [PATCH 25/25] libfuse: add upper-level filesystem freeze, thaw,
 and shutdown events
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212015.4104686.5558489638360590214.stgit@frogsfrogsfrogs>
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

Pass filesystem freeze, thaw, and shutdown requests from the low level
library to the upper level library so that those fuse servers can handle
the events.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |   15 +++++++++
 lib/fuse.c     |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index d68feb7ccfa84c..2717e654e92071 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -925,6 +925,21 @@ struct fuse_operations {
 	 */
 	int (*iomap_config)(const struct fuse_iomap_config_params *p,
 			    size_t psize, struct fuse_iomap_config *cfg);
+
+	/**
+	 * Freeze the filesystem
+	 */
+	int (*freezefs)(const char *path, uint64_t unlinked_files);
+
+	/**
+	 * Thaw the filesystem
+	 */
+	int (*unfreezefs)(const char *path);
+
+	/**
+	 * Shut down the filesystem
+	 */
+	int (*shutdownfs)(const char *path, uint64_t flags);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index ddf9b4044b8952..b43a336d7530bb 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2989,6 +2989,38 @@ static int fuse_fs_iomap_config(struct fuse_fs *fs,
 	return fs->op.iomap_config(p, psize, cfg);
 }
 
+static int fuse_fs_freezefs(struct fuse_fs *fs, const char *path,
+			    uint64_t unlinked)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.freezefs)
+		return -ENOSYS;
+	if (fs->debug)
+		fuse_log(FUSE_LOG_DEBUG, "freezefs[%s]\n", path);
+	return fs->op.freezefs(path, unlinked);
+}
+
+static int fuse_fs_unfreezefs(struct fuse_fs *fs, const char *path)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.unfreezefs)
+		return -ENOSYS;
+	if (fs->debug)
+		fuse_log(FUSE_LOG_DEBUG, "unfreezefs[%s]\n", path);
+	return fs->op.unfreezefs(path);
+}
+
+static int fuse_fs_shutdownfs(struct fuse_fs *fs, const char *path,
+			      uint64_t flags)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.shutdownfs)
+		return -ENOSYS;
+	if (fs->debug)
+		fuse_log(FUSE_LOG_DEBUG, "shutdownfs[%s]\n", path);
+	return fs->op.shutdownfs(path, flags);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4887,6 +4919,66 @@ static void fuse_lib_iomap_config(fuse_req_t req,
 	fuse_reply_iomap_config(req, &cfg);
 }
 
+static void fuse_lib_freezefs(fuse_req_t req, fuse_ino_t ino, uint64_t unlinked)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path(f, ino, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_freezefs(f->fs, path, unlinked);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	reply_err(req, err);
+}
+
+static void fuse_lib_unfreezefs(fuse_req_t req, fuse_ino_t ino)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path(f, ino, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_unfreezefs(f->fs, path);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	reply_err(req, err);
+}
+
+static void fuse_lib_shutdownfs(fuse_req_t req, fuse_ino_t ino, uint64_t flags)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct fuse_intr_data d;
+	char *path;
+	int err;
+
+	err = get_path(f, ino, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_shutdownfs(f->fs, path, flags);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	reply_err(req, err);
+}
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4989,6 +5081,9 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.statx = fuse_lib_statx,
 #endif
 	.syncfs = fuse_lib_syncfs,
+	.freezefs = fuse_lib_freezefs,
+	.unfreezefs = fuse_lib_unfreezefs,
+	.shutdownfs = fuse_lib_shutdownfs,
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,

