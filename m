Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039B34029E;
	Wed, 22 Apr 2026 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900087; cv=none; b=J8H4V1MGuKmT+o9a5EDgHgblqKLzPIiEOQ8uz5jntTlSSq+k4e7xTcWhWNjj0+UE4meMnbmDeipUkfXhKGoRgn9bSQwS8m1hlcROjLRZh0E9/tDtANF5iR8YobtPtCkIbHj3oOfvvmsMAoJxwtuVSBLj6lwjS04sQ0zTDkWkDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900087; c=relaxed/simple;
	bh=w4TsrncluomBkkDSJxichIaC08DLJqCYx5JoLMX6Qvs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTY0IMxk+CYvjtK7gTIrHEcO3RyqUxbgnYvWFPBvIe9lc40G5gMP9DgtFdTmR2C36dKdEJ5ohseal5Tfbb1NBmKM1Z2nORra16dhmUx35fR3RiceZM/PjMGpZo4Qoj2yn2w5+XQDy7CSNi8wNc6wT5NLiU3xyz3rC3PxOw1I2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJHI9dPU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJHI9dPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB761C19425;
	Wed, 22 Apr 2026 23:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900087;
	bh=w4TsrncluomBkkDSJxichIaC08DLJqCYx5JoLMX6Qvs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oJHI9dPUbwHjx8FXsjRHkacJX6TXnww6RwM28tMiKg+tkPft/2qTAZa6fXzkvdVJ2
	 cLUPrAQM5CZ2tl7l0MDcAQKYXvUxpudbNJfVAhQ6OaG5PMhe10guVOUd0x5hVEnZ2+
	 eqXN0tqBZARbhGw5jA5/0CT57euZW3Z4+fAwbJEwt608E11S3Hl6zqqB0/fux6KBRk
	 jgdzJuB4zpsJ6h/6en9iN69ebotU3F6uvcA4/AWLnhltsB0/XydgMcCuRQ+pYlG6BW
	 SB8EydXxx03j7NQpziGH9j0vqx+r4jJVswBgq6zFLskQQd+rE07xbV+nDyrznJuIW2
	 cxX3Aqbr9JXdg==
Date: Wed, 22 Apr 2026 16:21:26 -0700
Subject: [PATCH 08/13] mount_service: enable unprivileged users in a similar
 manner as fusermount
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: neal@gompa.dev, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
 miklos@szeredi.hu, fuse-devel@lists.linux.dev
Message-ID: <177689988684.3820166.10437047373153632328.stgit@frogsfrogsfrogs>
In-Reply-To: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
References: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Some Linux distributions allow unprivileged users to mount fuse
filesystems through the use of the setuid fusermount helper program.  It
would be useful to provide similar functionality when mounting a
filesystem that runs as a systemd service.

Therefore, read the fuse config file and implement the same checks as
fusermount.  The only new requirement is that the unprivileged user must
be able to open the mountpoint for write access if it's a regular file;
or have write access if it's a directory.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.c |  232 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 227 insertions(+), 5 deletions(-)


diff --git a/util/mount_service.c b/util/mount_service.c
index 915a0c4b610792..95de56f2b625fe 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -38,6 +38,7 @@
 #include "fuse_i.h"
 #include "fuse_service_priv.h"
 #include "mount_service.h"
+#include "fuser_conf.h"
 
 struct mount_service {
 	/* prefix for printing error messages */
@@ -313,8 +314,10 @@ static int mount_service_connect(struct mount_service *mo)
 	if (ret)
 		return ret;
 
+	drop_privs();
 	ret = connect(sockfd, (const struct sockaddr *)&name, sizeof(name));
 	if (ret && (errno == ENOENT || errno == ECONNREFUSED)) {
+		restore_privs();
 		fprintf(stderr, "%s: no safe filesystem driver for %s available.\n",
 			mo->msgtag, mo->subtype);
 		close(sockfd);
@@ -323,10 +326,12 @@ static int mount_service_connect(struct mount_service *mo)
 	if (ret) {
 		int error = errno;
 
+		restore_privs();
 		fprintf(stderr, "%s: %s: %s\n",
 			mo->msgtag, name.sun_path, strerror(error));
 		goto out;
 	}
+	restore_privs();
 
 	ret = try_drop_passrights(mo, sockfd);
 	if (ret)
@@ -349,7 +354,7 @@ static int mount_service_send_hello(struct mount_service *mo)
 	struct fuse_service_hello_reply reply = { };
 	ssize_t size;
 
-	if (getuid() == 0)
+	if (getuid() == 0 || user_allow_other)
 		hello.flags |= htonl(FUSE_SERVICE_FLAG_ALLOW_OTHER);
 
 	size = __send_packet(mo, &hello, sizeof(hello));
@@ -586,14 +591,17 @@ static int mount_service_send_required_files(struct mount_service *mo,
 {
 	int ret;
 
+	drop_privs();
 	mo->fusedevfd = open(fusedev, O_RDWR | O_CLOEXEC);
 	if (mo->fusedevfd < 0) {
 		int error = errno;
 
+		restore_privs();
 		fprintf(stderr, "%s: %s: %s\n",
 			mo->msgtag, fusedev, strerror(error));
 		return -1;
 	}
+	restore_privs();
 
 	ret = mount_service_send_file(mo, FUSE_SERVICE_ARGV, mo->argvfd);
 	if (ret)
@@ -710,14 +718,17 @@ static int prepare_bdev(struct mount_service *mo,
 	if (oc->block_size) {
 		int block_size = ntohl(oc->block_size);
 
+		drop_privs();
 		ret = ioctl(fd, BLKBSZSET, &block_size);
 		if (ret) {
 			int error = errno;
 
+			restore_privs();
 			fprintf(stderr, "%s: %s: %s\n",
 				mo->msgtag, oc->path, strerror(error));
 			return -error;
 		}
+		restore_privs();
 	}
 
 	return 0;
@@ -754,6 +765,7 @@ static int mount_service_open_path(struct mount_service *mo,
 	}
 
 	open_flags = ntohl(oc->open_flags) | O_CLOEXEC;
+	drop_privs();
 	fd = open(oc->path, open_flags, ntohl(oc->create_mode));
 	if (fd < 0) {
 		int error = errno;
@@ -762,11 +774,13 @@ static int mount_service_open_path(struct mount_service *mo,
 		 * Don't print a busy device error report because the
 		 * filesystem might decide to retry.
 		 */
+		restore_privs();
 		if (error != EBUSY && !(request_flags & FUSE_SERVICE_OPEN_QUIET))
 			fprintf(stderr, "%s: %s: %s\n",
 				mo->msgtag, oc->path, strerror(error));
 		return mount_service_send_file_error(mo, error, oc->path);
 	}
+	restore_privs();
 
 	if (S_ISBLK(expected_fmt)) {
 		ret = prepare_bdev(mo, oc, fd);
@@ -994,6 +1008,15 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
 			*equals = 0;
 		}
 
+		if (getuid() != 0 && !user_allow_other &&
+		    (!strcmp(tok, "allow_other") ||
+		     !strcmp(tok, "allow_root"))) {
+			fprintf(stderr,
+"%s: option %s only allowed if 'user_allow_other' is set in %s\n",
+				mo->msgtag, tok, FUSE_CONF);
+			return mount_service_send_reply(mo, EPERM);
+		}
+
 #ifdef HAVE_NEW_MOUNT_API
 		if (mo->fsopenfd >= 0) {
 			int ret;
@@ -1077,19 +1100,64 @@ static int mount_service_handle_mtabopts_cmd(struct mount_service *mo,
 	return mount_service_send_reply(mo, 0);
 }
 
+static int open_mountpoint(const char *mntpt, bool *require_dir)
+{
+	int ret;
+
+	*require_dir = false;
+
+	if (getuid() == 0) {
+		/*
+		 * Open the alleged mountpoint.  We're root, so we only bother
+		 * checking for readability.
+		 */
+		return open(mntpt, O_RDONLY | O_CLOEXEC);
+	}
+
+	/*
+	 * Open the alleged mountpoint.  For unprivileged callers, we only
+	 * allow mounting on paths that the user can write to.
+	 */
+	ret = open(mntpt, O_WRONLY | O_CLOEXEC);
+	if (ret >= 0 || errno != EISDIR)
+		return ret;
+
+	/*
+	 * However, we can't open directories with write access.  Try again in
+	 * readonly mode, but require the caller to verify that we actually got
+	 * a directory.
+	 */
+	*require_dir = true;
+	ret = open(mntpt, O_RDONLY | O_CLOEXEC);
+	if (ret >= 0 || (errno != EACCES && errno != EPERM))
+		return ret;
+
+#ifdef O_PATH
+	/*
+	 * If we can't open at all, let's try opening this directory with
+	 * O_PATH.
+	 */
+	return open(mntpt, O_PATH | O_CLOEXEC);
+#else
+	/* No idea what to do now */
+	errno = EACCES;
+	return -1;
+#endif
+}
+
 static int attach_to_mountpoint(struct mount_service *mo, mode_t expected_fmt,
 				char *mntpt)
 {
 	struct stat stbuf;
 	char *res_mntpt;
+	bool require_dir;
 	int mountfd = -1;
 	int error;
 	int ret;
 
-	/*
-	 * Open the alleged mountpoint, make sure it's a dir or a file.
-	 */
-	mountfd = open(mntpt, O_RDONLY | O_CLOEXEC);
+	drop_privs();
+
+	mountfd = open_mountpoint(mntpt, &require_dir);
 	if (mountfd < 0) {
 		error = errno;
 		fprintf(stderr, "%s: %s: %s\n", mo->msgtag, mntpt,
@@ -1117,6 +1185,13 @@ static int attach_to_mountpoint(struct mount_service *mo, mode_t expected_fmt,
 		goto out_mountfd;
 	}
 
+	if (require_dir && !S_ISDIR(stbuf.st_mode)) {
+		error = EACCES;
+		fprintf(stderr, "%s: %s: Mount point must be directory.\n",
+			mo->msgtag, mntpt);
+		goto out_mountfd;
+	}
+
 	/*
 	 * Resolve the (possibly relative) mountpoint path before chdir'ing
 	 * onto it.
@@ -1193,6 +1268,7 @@ static int attach_to_mountpoint(struct mount_service *mo, mode_t expected_fmt,
 	mo->mountfd = mountfd;
 	mo->resv_mountpoint = res_mntpt;
 
+	restore_privs();
 	return mount_service_send_reply(mo, 0);
 
 out_res_mntpt:
@@ -1201,6 +1277,7 @@ static int attach_to_mountpoint(struct mount_service *mo, mode_t expected_fmt,
 	close(mountfd);
 out_error:
 	free(mntpt);
+	restore_privs();
 	return mount_service_send_reply(mo, error);
 }
 
@@ -1580,6 +1657,141 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
 # define mount_service_fsopen_mount(...)	(FUSE_MOUNT_FALLBACK_NEEDED)
 #endif
 
+static int check_nonroot_file_access(struct mount_service *mo)
+{
+	struct stat sb1, sb2;
+	int fd;
+	int ret;
+
+	/*
+	 * If we already succeeded in opening the file with write access, then
+	 * we're good.
+	 */
+	ret = fcntl(mo->mountfd, F_GETFL);
+	if (ret < 0) {
+		int error = errno;
+
+		fprintf(stderr, "%s: %s: %s\n", mo->msgtag, mo->mountpoint,
+			strerror(error));
+		return -1;
+	}
+
+	if ((ret & O_ACCMODE) != O_RDONLY)
+		return 0;
+
+	ret = fstat(mo->mountfd, &sb1);
+	if (ret) {
+		int error = errno;
+
+		fprintf(stderr, "%s: %s: %s\n",
+			mo->msgtag, mo->mountpoint, strerror(error));
+		return -1;
+	}
+
+	/* Try to reopen the file with write access this time. */
+	fd = open(mo->real_mountpoint, O_WRONLY | O_CLOEXEC);
+	if (fd < 0) {
+		int error = errno;
+
+		fprintf(stderr, "%s: %s: %s\n",
+			mo->msgtag, mo->mountpoint, strerror(error));
+		return -1;
+	}
+
+	/* Is this the same file? */
+	ret = fstat(fd, &sb2);
+	if (ret) {
+		int error = errno;
+
+		fprintf(stderr, "%s: %s: %s\n",
+			mo->msgtag, mo->mountpoint, strerror(error));
+		goto out_fd;
+	}
+
+	if (sb1.st_dev != sb2.st_dev || sb1.st_ino != sb2.st_ino) {
+		fprintf(stderr, "%s: %s: Mount point moved during fuse startup.\n",
+			mo->msgtag, mo->mountpoint);
+		ret = -1;
+		goto out_fd;
+	}
+
+	/*
+	 * We reopened the same file with write access, everything is ok.  Swap
+	 * the two file descriptors so that we retain our write access.
+	 */
+	ret = mo->mountfd;
+	mo->mountfd = fd;
+	fd = ret;
+	ret = 0;
+out_fd:
+	close(fd);
+	return ret;
+}
+
+static void adjust_nonroot_mount_flags(struct mount_service *mo,
+				       struct fuse_service_mount_command *oc)
+{
+	const struct mount_flags *mf;
+	uint32_t ms_flags = ntohl(oc->ms_flags);
+
+	/* only care that the unsafe flags are set to the value of @on */
+	for (mf = mount_flags; mf->opt != NULL; mf++) {
+		if (mf->safe)
+			continue;
+		if (!!(ms_flags & mf->flag) == !!mf->on) {
+			ms_flags = (ms_flags & ~mf->flag) |
+				   (mf->on ? 0 : mf->flag);
+
+			fprintf(stderr, "%s: unsafe option %s ignored\n",
+				mo->msgtag, mf->opt);
+		}
+	}
+
+	oc->ms_flags = htonl(ms_flags);
+}
+
+/*
+ * fuse.conf can limit the number of unprivileged fuse mounts.  For
+ * unprivileged mounts (via setuid) we also require write access to the
+ * mountpoint, and we'll only accept certain underlying filesystems.
+ */
+static int check_nonroot_access(struct mount_service *mo,
+				struct fuse_service_mount_command *oc,
+				const struct stat *stbuf)
+{
+	struct statfs fs_buf;
+	int ret;
+
+	ret = check_nonroot_mount_count(mo->msgtag);
+	if (ret)
+		return -EUSERS;
+
+	ret = fstatfs(mo->mountfd, &fs_buf);
+	if (ret) {
+		int error = errno;
+
+		fprintf(stderr, "%s: %s: %s\n",
+			mo->msgtag, mo->mountpoint, strerror(error));
+		return -error;
+	}
+
+	adjust_nonroot_mount_flags(mo, oc);
+
+	drop_privs();
+	if (S_ISDIR(stbuf->st_mode))
+		ret = check_nonroot_dir_access(mo->msgtag,
+					       mo->mountpoint,
+					       mo->real_mountpoint,
+					       stbuf);
+	else
+		ret = check_nonroot_file_access(mo);
+	if (!ret)
+		ret = check_nonroot_fstype(mo->msgtag, &fs_buf);
+	restore_privs();
+
+	return ret ? -EPERM : 0;
+}
+
 static int mount_service_handle_mount_cmd(struct mount_service *mo,
 					  struct fuse_service_packet *p,
 					  size_t psz)
@@ -1621,6 +1833,12 @@ static int mount_service_handle_mount_cmd(struct mount_service *mo,
 		return mount_service_send_reply(mo, error);
 	}
 
+	if (getuid() != 0) {
+		ret = check_nonroot_access(mo, oc, &stbuf);
+		if (ret)
+			return mount_service_send_reply(mo, -ret);
+	}
+
 	if (mo->fsopenfd >= 0) {
 		ret = mount_service_fsopen_mount(mo, oc, &stbuf);
 		if (ret != FUSE_MOUNT_FALLBACK_NEEDED)
@@ -1752,6 +1970,10 @@ int mount_service_main(int argc, char *argv[])
 	else
 		mo.msgtag = "mount.service";
 
+	drop_privs();
+	read_conf(mo.msgtag);
+	restore_privs();
+
 	ret = mount_service_init(&mo, argc, argv);
 	if (ret)
 		return EXIT_FAILURE;

