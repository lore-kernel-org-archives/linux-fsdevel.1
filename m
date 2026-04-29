Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512573570C8;
	Wed, 29 Apr 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473139; cv=none; b=uzszTbOiVilb5BuDT+z24XogLh9SuF3Z/q7rQs0NVAOXihwhmcGDqF5c+6rSGg/5CLhxPR+ZeTIm4sqakcNS9zCDfLIgxXZlPpJ0YKiPEg6RK5+SUi21m7TOhuRZp1tC/u39em32RvXs2l1/xUdDcZdfMDYF2kKC95SO8KQklq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473139; c=relaxed/simple;
	bh=/EjUVAzqvG20L5hJLEffN9YKFet57EeOLeC91uwL2XI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/iHeyXz8yR9wXAURZi4Ksx27czW+OBxqQRHMCsQecZrBA3ySsXG4r1mEaVsEG2jdSOpVm6I/g/E1BNTBmJu2/wurQDozbCbit/MnCiGOloGC+CIjHQdPB+PLYkrMFrbRk9TJykRHkPzaNoJnhUr/bzxgeoYAIk0yCl2S/dZx+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9nNqmQt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9nNqmQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B734EC19425;
	Wed, 29 Apr 2026 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473138;
	bh=/EjUVAzqvG20L5hJLEffN9YKFet57EeOLeC91uwL2XI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=k9nNqmQtpSaKC/7cVVdhxsD6pnHM83/KbHVm4GO9q89+uPjVGo4PjfAYZ/4do92sO
	 Yub8NpR/E93mTOqLcMe142Is5abmaxXtg0D+5A19WrlMUy9iDaXGDoUf/aigo7RdXX
	 UMJzSn/w0AQZYwM4OkRpH6Zx1oZs+5AuvGfJdYa/wpSpD/O3WOXr98dxmqgXTx0JRB
	 0EQaFmf6+8uTBlNNn8MFSkwYqji0g7ekiDnBeumCAvO1gQEQvWCgCnPSQHGUX1YTbG
	 s7vnrFNuKTGU8JE639Gd20ba3iTSi+8bgbnarttnw2O3dWXefdQsESc2vPWjJcJcOO
	 kxmrLOpMxyDww==
Date: Wed, 29 Apr 2026 07:32:18 -0700
Subject: [PATCH 33/33] fuse: implement freeze and shutdowns for iomap
 filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205856.4101881.10694466069338531152.stgit@frogsfrogsfrogs>
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

Implement filesystem freezing and block device shutdown notifications
for iomap-based servers

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/uapi/linux/fuse.h |   12 +++++++
 fs/fuse/inode.c           |   73 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)


diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5f3724f36f764a..b6fa828776b82f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -695,6 +695,10 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_FREEZE_FS		= 4089,
+	FUSE_UNFREEZE_FS	= 4090,
+	FUSE_SHUTDOWN_FS	= 4091,
+
 	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
@@ -1257,6 +1261,14 @@ struct fuse_syncfs_in {
 	uint64_t	padding;
 };
 
+struct fuse_freezefs_in {
+	uint64_t	unlinked;
+};
+
+struct fuse_shutdownfs_in {
+	uint64_t	flags;
+};
+
 /*
  * For each security context, send fuse_secctx with size of security context
  * fuse_secctx will be followed by security context name and this in turn
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f6ec67a8eb86a2..6d4ff08ad3069a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1264,6 +1264,74 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 	return parent;
 }
 
+#ifdef CONFIG_FUSE_IOMAP
+/*
+ * Second stage of a freeze. The data is already frozen so we only
+ * need to take care of the fuse server.
+ */
+static int fuse_freeze_fs(struct super_block *sb)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_freezefs_in inarg = {
+		.unlinked = atomic_long_read(&sb->s_remove_count),
+	};
+	FUSE_ARGS(args);
+	int err;
+
+	if (!fc->iomap)
+		return -EOPNOTSUPP;
+
+	args.opcode = FUSE_FREEZE_FS;
+	args.nodeid = get_node_id(sb->s_root->d_inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	err = fuse_simple_request(fm, &args);
+	if (err == -ENOSYS)
+		err = -EOPNOTSUPP;
+	return err;
+}
+
+static int fuse_unfreeze_fs(struct super_block *sb)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	FUSE_ARGS(args);
+	int err;
+
+	if (!fc->iomap)
+		return 0;
+
+	args.opcode = FUSE_UNFREEZE_FS;
+	args.nodeid = get_node_id(sb->s_root->d_inode);
+	err = fuse_simple_request(fm, &args);
+	if (err == -ENOSYS)
+		err = 0;
+	return err;
+}
+
+static void fuse_shutdown_fs(struct super_block *sb)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_shutdownfs_in inarg = {
+		.flags = 0,
+	};
+	FUSE_ARGS(args);
+
+	if (!fc->iomap)
+		return;
+
+	args.opcode = FUSE_SHUTDOWN_FS;
+	args.nodeid = get_node_id(sb->s_root->d_inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	fuse_simple_request(fm, &args);
+}
+#endif /* CONFIG_FUSE_IOMAP */
+
 /* only for fid encoding; no support for file handle */
 static const struct export_operations fuse_export_fid_operations = {
 	.encode_fh	= fuse_encode_fh,
@@ -1286,6 +1354,11 @@ static const struct super_operations fuse_super_operations = {
 	.statfs		= fuse_statfs,
 	.sync_fs	= fuse_sync_fs,
 	.show_options	= fuse_show_options,
+#ifdef CONFIG_FUSE_IOMAP
+	.freeze_fs	= fuse_freeze_fs,
+	.unfreeze_fs	= fuse_unfreeze_fs,
+	.shutdown	= fuse_shutdown_fs,
+#endif
 };
 
 static void sanitize_global_limit(unsigned int *limit)

