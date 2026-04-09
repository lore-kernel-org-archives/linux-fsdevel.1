Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33C033EB0A
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773359; cv=none; b=GrBEe4gxUJnaZkbgLupm9Pr6ITfj9V53/5ejdC4Njb/8d5D1VVgPv0FhWafwTDt7fzUFLqOROSbVwN8kUIaMsL0H99s0TJS3nqe1r0GDsPq5UBgkEKJkqEcGIVeBF2xD20nQcZCGg0bMgpfv9IDbannPPVxymoq1KXoKG70ujTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773359; c=relaxed/simple;
	bh=Y4y9PXrp6fZUR8AwFPl6dTs4ERySlCOp0DHnTzbk9qc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDM4w2LIj67kOLnrbqA3AN2jMGBjzrfzVFCDqFrRdnK64wnXjeFz6Q/GJMcTlMNbZdtAJxwFW69eS45Nu9enHJi8Q+B3LZZhiM+CxlZ9TMiY77j/Mi+ZGFlFxkuxb3jUgoSYOVVFcZdhnyfd1p8FygFaawhjoE1rSq2QdC+6BJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fssl8OYP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fssl8OYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC74C4CEF7;
	Thu,  9 Apr 2026 22:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775773358;
	bh=Y4y9PXrp6fZUR8AwFPl6dTs4ERySlCOp0DHnTzbk9qc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fssl8OYP8D78v850rjjPE7GU61R5CKJ2iR0Mv/DAbK6yZEbaMlfS/0LA/Bew1nBxf
	 ahKzsmG4wmQRWvGIeWzTZrn5Xvi4khtUuYfH3ncfyp3M5XOWOojnUS9d/HWasRS9G0
	 5ivhCZgxNfrdwFmec/Tcz3Sv/pfM/AOBymV1H49rmRdrCgKSUDDxXLDgz2+NRs0uiU
	 Wi7+0dDhAmRRFAxxR8YNk0ZLxOcrvy508SSLcafUcWu4e2sl+csyD9bTKtVB6FZg39
	 Xs2aF5UniRrewLsyom97GuZTSjIjWZkqh0FJKTq5G0/RjqhapFQTEqRFsOK1HPibWl
	 OiJWbft1Egy8Q==
Date: Thu, 09 Apr 2026 15:22:38 -0700
Subject: [PATCH 08/13] mount_service: enable unprivileged users in the same
 manner as fusermount
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <177577270359.2064074.2765615359461460085.stgit@frogsfrogsfrogs>
In-Reply-To: <177577270167.2064074.16504004857564657756.stgit@frogsfrogsfrogs>
References: <177577270167.2064074.16504004857564657756.stgit@frogsfrogsfrogs>
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
fusermount.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.c |  150 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 3 deletions(-)


diff --git a/util/mount_service.c b/util/mount_service.c
index 8e9c721a56fd2a..0f7eae94ada377 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -33,6 +33,7 @@
 #include "fuse_i.h"
 #include "fuse_service_priv.h"
 #include "mount_service.h"
+#include "fuser_conf.h"
 
 struct mount_service {
 	/* prefix for printing error messages */
@@ -166,7 +167,9 @@ static int mount_service_connect(struct mount_service *mo)
 		return -1;
 	}
 
+	drop_privs();
 	ret = connect(sockfd, (const struct sockaddr *)&name, sizeof(name));
+	restore_privs();
 	if (ret && (errno == ENOENT || errno == ECONNREFUSED)) {
 		fprintf(stderr, "%s: no safe filesystem driver for %s available.\n",
 			mo->msgtag, mo->subtype);
@@ -208,7 +211,7 @@ static int mount_service_send_hello(struct mount_service *mo)
 	};
 	ssize_t size;
 
-	if (getuid() == 0)
+	if (getuid() == 0 || user_allow_other)
 		hello.flags |= htonl(FUSE_SERVICE_FLAG_ALLOW_OTHER);
 
 	size = sendmsg(mo->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
@@ -490,7 +493,9 @@ static int mount_service_send_required_files(struct mount_service *mo,
 {
 	int ret;
 
+	drop_privs();
 	mo->fusedevfd = open(fusedev, O_RDWR | O_CLOEXEC);
+	restore_privs();
 	if (mo->fusedevfd < 0) {
 		fprintf(stderr, "%s: %s: %s\n",
 			mo->msgtag, fusedev, strerror(errno));
@@ -628,7 +633,9 @@ static int prepare_bdev(struct mount_service *mo,
 	if (oc->block_size) {
 		int block_size = ntohl(oc->block_size);
 
+		drop_privs();
 		ret = ioctl(fd, BLKBSZSET, &block_size);
+		restore_privs();
 		if (ret) {
 			int error = errno;
 
@@ -675,7 +682,9 @@ static int mount_service_open_path(struct mount_service *mo,
 		return mount_service_send_file_error(mo, EINVAL, oc->path);
 	}
 
-	fd = open(oc->path, ntohl(oc->open_flags), ntohl(oc->create_mode));
+	drop_privs();
+	fd = open(oc->path, ntohl(oc->open_flags) | O_CLOEXEC, ntohl(oc->create_mode));
+	restore_privs();
 	if (fd < 0) {
 		int error = errno;
 
@@ -908,6 +917,20 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
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
+		if (!strcmp(tok, "blkdev") && getuid() != 0) {
+			fprintf(stderr, "%s: option blkdev is privileged\n",
+				mo->msgtag);
+			return mount_service_send_reply(mo, EPERM);
+		}
+
 #ifdef HAVE_NEW_MOUNT_API
 		if (mo->fsopenfd >= 0) {
 			int ret;
@@ -985,10 +1008,16 @@ static int attach_to_mountpoint(struct mount_service *mo, char *mntpt)
 	int error;
 	int ret;
 
+	drop_privs();
+
 	/*
 	 * Open the alleged mountpoint, make sure it's a dir or a file.
+	 * For unprivileged callers, we only allow mounting on paths that the
+	 * user can write to.
 	 */
-	mountfd = open(mntpt, O_RDONLY | O_CLOEXEC);
+	mountfd = open(mntpt, (getuid() == 0 ? O_RDONLY : O_WRONLY) | O_CLOEXEC);
+	if (mountfd < 0 && errno == EISDIR)
+		mountfd = open(mntpt, O_RDONLY | O_CLOEXEC);
 	if (mountfd < 0) {
 		error = errno;
 		fprintf(stderr, "%s: %s: %s\n", mo->msgtag, mntpt,
@@ -1067,6 +1096,7 @@ static int attach_to_mountpoint(struct mount_service *mo, char *mntpt)
 	mo->mountfd = mountfd;
 	mo->resv_mountpoint = res_mntpt;
 
+	restore_privs();
 	return mount_service_send_reply(mo, 0);
 
 out_res_mntpt:
@@ -1075,6 +1105,7 @@ static int attach_to_mountpoint(struct mount_service *mo, char *mntpt)
 	close(mountfd);
 out_error:
 	free(mntpt);
+	restore_privs();
 	return mount_service_send_reply(mo, error);
 }
 
@@ -1399,6 +1430,77 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
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
 static int mount_service_handle_mount_cmd(struct mount_service *mo,
 					  struct fuse_service_packet *p,
 					  size_t psz)
@@ -1471,6 +1573,44 @@ static int mount_service_handle_mount_cmd(struct mount_service *mo,
 		return mount_service_send_reply(mo, EINVAL);
 	}
 
+	/*
+	 * fuse.conf can limit the number of unprivileged fuse mounts.
+	 * For unprivileged mounts (via setuid) we also require write access
+	 * to the mountpoint, and we'll only accept certain underlying
+	 * filesystems.
+	 */
+	if (getuid() != 0) {
+		struct statfs fs_buf;
+
+		ret = check_nonroot_mount_count(mo->msgtag);
+		if (ret)
+			return mount_service_send_reply(mo, EUSERS);
+
+		ret = fstatfs(mo->mountfd, &fs_buf);
+		if (ret) {
+			int error = errno;
+
+			fprintf(stderr, "%s: %s: %s\n",
+				mo->msgtag, mo->mountpoint, strerror(error));
+			return mount_service_send_reply(mo, error);
+		}
+
+		drop_privs();
+		if (S_ISDIR(stbuf.st_mode))
+			ret = check_nonroot_dir_access(mo->msgtag,
+						       mo->mountpoint,
+						       mo->real_mountpoint,
+						       &stbuf);
+		else
+			ret = check_nonroot_file_access(mo);
+		if (!ret)
+			ret = check_nonroot_fstype(mo->msgtag, &fs_buf);
+		restore_privs();
+
+		if (ret)
+			return mount_service_send_reply(mo, EPERM);
+	}
+
 	if (mo->fsopenfd >= 0) {
 		ret = mount_service_fsopen_mount(mo, oc, &stbuf);
 		if (ret != FUSE_MOUNT_FALLBACK_NEEDED)
@@ -1601,6 +1741,10 @@ int mount_service_main(int argc, char *argv[])
 	else
 		mo.msgtag = "mount.service";
 
+	drop_privs();
+	read_conf(mo.msgtag);
+	restore_privs();
+
 	ret = mount_service_init(&mo, argc, argv);
 	if (ret)
 		return EXIT_FAILURE;

