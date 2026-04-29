Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3173176EF;
	Wed, 29 Apr 2026 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472716; cv=none; b=EaROYk/+iz1tIn2CMk/gfr4RDu3An6D4dY0FZTMT9ogPWMvvGulf/n8Kh+XQ5q2plfQdy4VM8yQIoxJYs8y+Mwich8sYDDo+gysQCXM0MiDo0iqDdStnoETDJA3d9Xu4ZWYGT+yO6NBUfHfYsQsxJzeljzFE0KoVZzNmuzL9G4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472716; c=relaxed/simple;
	bh=/JKn+SsrU0bfshoCghGx5IOWEBKXvoUAmzqh3Zs/dKU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMV6D/O3owpX17vjNTqriTU014ihMQ0bFzRup7XrmYpuPaBUiRAHI6McrxWXNskBZ5tQxbFGqcxcrgdpWG9y+NjewthXQFmWxgRrWW4d4m97K9PaWr7PSl3sCfF2J6t3FHoNKy5eDF1zZDH4U64xBH+fk52NazNIxJrbMMritLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmc7kdnG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmc7kdnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89A7C19425;
	Wed, 29 Apr 2026 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472715;
	bh=/JKn+SsrU0bfshoCghGx5IOWEBKXvoUAmzqh3Zs/dKU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pmc7kdnGHSop39XPIfpC86aUVwI358W9VItt8oiHhdrOc3FlA2P0AED1rRjAOnYNO
	 fDTAyxpqJ6URt1Em0STNdEcJ4PjOnAi8RDBHbopO2OZ5VVGLw2Z9OdCELkGxBEHmoL
	 GsDi5XnRJRsKoT5rdUPsUkWAb+uZVJIhCDtyemunYa/tr4dIBfPIi0XEv3+GFRrKU3
	 IjQY49tzHVNbee6J17UFoSXj743298faiDN8HylBEXEL4vQ82IuURe2QKVAR10uLli
	 JsboRPBqa5csDMOs22xL/gMY+lIGoGFMOUxTxrRrTFtmGAT/VmiRYN22TV7lzFUfaN
	 R4+d1PupkumYg==
Date: Wed, 29 Apr 2026 07:25:15 -0700
Subject: [PATCH 06/33] fuse: enable SYNCFS and ensure we flush everything
 before sending DESTROY
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205278.4101881.14173917071771536980.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

At unmount time, there are a few things that we need to ask a fuse iomap
server to do.  We need to send FUSE_DESTROY to the fuse server so that
it closes the filesystem and the device fds before unmount returns.
That way, a script that does something like "umount /dev/sda ; e2fsck
-fn /dev/sda" will not fail the e2fsck because the fd closure races with
e2fsck startup.  This is essential for fstests QA to work properly.

To make this happen, first, we need to flush queued events to userspace
to give the fuse server a chance to process the events.  These will all
be FUSE_RELEASE events for previously opened files.  Once the commands
are flushed, we can send the FUSE_DESTROY request to ask the server to
close the filesystem.  This depends on libfuse to hold the destroy
command until there are no unreleased files (instead of having the
kernel enforce the ordering) because the kernel fuse developers don't
like the idea of unbounded waits in unmount.

Second, to reduce the amount of metadata must be persisted to disk in
the fuse server's destroy method, enable FUSE_SYNCFS so that previous
sync_filesystem calls can flush dirty data before we get deeper in the
unmount machinery.  If a fuse command timeout is set, this reduces the
likelihood that the kernel aborts the FUSE_DESTROY command whilst the
server is busy flushing dirty metadata.

This is a major behavior change and who knows what might break existing
code, so we hide it behind iomap mode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h     |    3 +++
 fs/fuse/fuse_iomap.h |    5 +++++
 fs/fuse/fuse_iomap.c |   32 ++++++++++++++++++++++++++++++++
 fs/fuse/inode.c      |    9 +++++++--
 4 files changed, 47 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a02af3403e6849..620489520ddc8e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1428,6 +1428,9 @@ int fuse_init_fs_context_submount(struct fs_context *fsc);
  */
 void fuse_conn_destroy(struct fuse_mount *fm);
 
+/* Send the FUSE_DESTROY command. */
+void fuse_send_destroy(struct fuse_mount *fm);
+
 /* Drop the connection and free the fuse mount */
 void fuse_mount_destroy(struct fuse_mount *fm);
 
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 43562ef23fb325..129680b056ebea 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -20,9 +20,14 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 }
 
 extern const struct fuse_backing_ops fuse_iomap_backing_ops;
+
+void fuse_iomap_mount(struct fuse_mount *fm);
+void fuse_iomap_unmount(struct fuse_mount *fm);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
+# define fuse_iomap_mount(...)			((void)0)
+# define fuse_iomap_unmount(...)		((void)0)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 0ac783dd312dc3..4b63bb32167877 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -584,3 +584,35 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
 	.may_close = fuse_iomap_may_close,
 	.post_open = fuse_iomap_post_open,
 };
+
+void fuse_iomap_mount(struct fuse_mount *fm)
+{
+	struct fuse_conn *fc = fm->fc;
+
+	/*
+	 * Enable syncfs for iomap fuse servers so that we can send a final
+	 * flush at unmount time.  This also means that we can support
+	 * freeze/thaw properly.
+	 */
+	fc->sync_fs = true;
+}
+
+void fuse_iomap_unmount(struct fuse_mount *fm)
+{
+	struct fuse_conn *fc = fm->fc;
+
+	/*
+	 * Flush all pending file release commands and send a destroy command.
+	 * This gives the fuse server a chance to process all the pending
+	 * releases, write the last bits of metadata changes to disk, and close
+	 * the iomap block devices before we return from the umount call.
+	 * iomap fuse servers are expected to release all exclusive access
+	 * resources before unmount completes.
+	 *
+	 * Note that multithreaded fuse servers will have to hold the destroy
+	 * command until all release requests have completed because the kernel
+	 * maintainers do not want to introduce waits in unmount.
+	 */
+	fuse_flush_requests(fc);
+	fuse_send_destroy(fm);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 15a8ce8afa4241..945afc30211d69 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -636,7 +636,7 @@ static void fuse_umount_begin(struct super_block *sb)
 		retire_super(sb);
 }
 
-static void fuse_send_destroy(struct fuse_mount *fm)
+void fuse_send_destroy(struct fuse_mount *fm)
 {
 	if (fm->fc->conn_init) {
 		FUSE_ARGS(args);
@@ -1504,6 +1504,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 		init_server_timeout(fc, timeout);
 
+		if (fc->iomap)
+			fuse_iomap_mount(fm);
+
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
@@ -2126,7 +2129,9 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
 
-	if (fc->destroy) {
+	if (fc->iomap) {
+		fuse_iomap_unmount(fm);
+	} else if (fc->destroy) {
 		/*
 		 * Flush all pending requests before sending FUSE_DESTROY.  The
 		 * fuse server must reply to the flushed requests before

