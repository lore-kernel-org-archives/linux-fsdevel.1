Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1553570C8;
	Wed, 29 Apr 2026 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473639; cv=none; b=hiZ1pOFgB2JDnp8m+7b8JtbT8xfYipFmp0BxKvpNQEqHrvwQXtxC5oXgnWkMZxJphm8i4g+r3/VQwNheMyqJLFvnGOS+UnZHSrcYyebDxPhvhl85nic8NisO6AUaHMlNDUWR4FabnpZWvTpa+Fp21lHvBnmnbEC8hVqGUGJcFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473639; c=relaxed/simple;
	bh=OeVzk1EklEAR6o1wkb+Ru4/TaqsZidyb6mfqbQFKgfI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oi9J0z2dYijXANzOVxCj6QBCJ35dplfhJlbykNDtbHV33xLwVEZFi1pJTJLESlUcwvJsXoGYo3YqnYsKmyv9oEk99jCX5zL82gh+tVSNfRKOyt1oGhVs4m75j3cHoWoryK/QbdQCjglopoyqFtXMuw9BFoH38OjVRzbkKxfj5vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhR2zXTJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhR2zXTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06418C2BCFD;
	Wed, 29 Apr 2026 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473639;
	bh=OeVzk1EklEAR6o1wkb+Ru4/TaqsZidyb6mfqbQFKgfI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DhR2zXTJfN+VGcX0gwiMk4qmBcVM+HUZeFmZChCA+ftmOFonrGuIpmS6sRmD3cXKR
	 j4LDlvI9MUX5pZKTCly4HI3z0rcnj72Wcn8Cz3ySldO8NIojHfrptmbrj1dl9GLvqx
	 rB43GiVsEq/2UTpo0tVnOgqVbgrjslkoQXIrK77GcXSeYrVNE0gNgi4d0trTQIhpMK
	 unbR6nTlQ3o7xyFx+3KjGu9m+BgWD8SQzpgLrQBz/I1UNZqARStBw/SFHKsi9EiPGL
	 Sf2jIZN+AzaGoY6l2eVWNOqrTr/JDaR9VhI7/qBjSBPUTZw1eQv9WzwRZhfMqxjtNQ
	 aF1MAnVrgGWHw==
Date: Wed, 29 Apr 2026 07:40:38 -0700
Subject: [PATCH 06/25] libfuse: add a lowlevel notification to add a new
 device to iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211674.4104686.12026011419976518627.stgit@frogsfrogsfrogs>
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

Plumb in the pieces needed to attach block devices to a fuse+iomap mount
for use with iomap operations.  This enables us to have filesystems
where the metadata could live somewhere else, but the actual file IO
goes to locally attached storage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |    7 +++++++
 include/fuse_lowlevel.h |   30 +++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   49 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    2 ++
 4 files changed, 88 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index b3750bb6275620..e69f9675c4b57d 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1135,6 +1135,13 @@ struct fuse_notify_prune_out {
 	uint64_t	spare;
 };
 
+#define FUSE_BACKING_TYPE_MASK		(0xFF)
+#define FUSE_BACKING_TYPE_PASSTHROUGH	(0)
+#define FUSE_BACKING_TYPE_IOMAP		(1)
+#define FUSE_BACKING_MAX_TYPE		(FUSE_BACKING_TYPE_IOMAP)
+
+#define FUSE_BACKING_FLAGS_ALL		(FUSE_BACKING_TYPE_MASK)
+
 struct fuse_backing_map {
 	int32_t		fd;
 	uint32_t	flags;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index b9a072841ef078..c0bbb6b658808d 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2035,6 +2035,36 @@ int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
 int fuse_lowlevel_notify_prune(struct fuse_session *se,
 			       fuse_ino_t *nodeids, uint32_t count);
 
+/*
+ * Attach an open file descriptor to a fuse+iomap mount.  Currently must be
+ * a block device.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param fd file descriptor of an open block device
+ * @param flags behavior flags for the operation; none defined so far
+ * @return positive nonzero device id on success, or negative errno on failure
+ */
+int fuse_lowlevel_iomap_device_add(struct fuse_session *se, int fd,
+				   unsigned int flags);
+
+/**
+ * Detach an open file from a fuse+iomap mount.  Must be a device id returned
+ * by fuse_lowlevel_iomap_device_add.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param device_id device index as returned by fuse_lowlevel_iomap_device_add
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id);
+
 /* ----------------------------------------------------------- *
  * Utility functions					       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index df13e2f8f84add..95ff8ca458480a 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -623,6 +623,55 @@ int fuse_passthrough_close(fuse_req_t req, int backing_id)
 	return ret;
 }
 
+int fuse_lowlevel_iomap_device_add(struct fuse_session *se, int fd,
+				   unsigned int flags)
+{
+	struct fuse_backing_map map = {
+		.fd = fd,
+		.flags = FUSE_BACKING_TYPE_IOMAP |
+			(flags & ~FUSE_BACKING_TYPE_MASK),
+	};
+	int ret;
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return -ENOSYS;
+
+	ret = ioctl(se->fd, FUSE_DEV_IOC_BACKING_OPEN, &map);
+	if (ret == 0) {
+		/* not supposed to happen */
+		ret = -1;
+		errno = ERANGE;
+	}
+	if (ret < 0) {
+		int err = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: iomap_device_add: %s\n",
+			 strerror(err));
+		return -err;
+	}
+
+	return ret;
+}
+
+int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id)
+{
+	int ret;
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return -ENOSYS;
+
+	ret = ioctl(se->fd, FUSE_DEV_IOC_BACKING_CLOSE, &device_id);
+	if (ret < 0) {
+		int err = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: iomap_device_remove: %s\n",
+			 strerror(errno));
+		return -err;
+	}
+
+	return ret;
+}
+
 int fuse_reply_open(fuse_req_t req, const struct fuse_file_info *f)
 {
 	struct fuse_open_out arg;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 260a7047c158e4..e32dcb17551e9e 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -251,6 +251,8 @@ FUSE_3.99 {
 	global:
 		fuse_iomap_pure_overwrite;
 		fuse_reply_iomap_begin;
+		fuse_lowlevel_iomap_device_add;
+		fuse_lowlevel_iomap_device_remove;
 } FUSE_3.19;
 
 # Local Variables:

