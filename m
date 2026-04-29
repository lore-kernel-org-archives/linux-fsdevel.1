Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCFA11CBA;
	Wed, 29 Apr 2026 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474030; cv=none; b=DeUsoDctgwiY+A8N0KEg1k1vLA+AwabScKe1fJYmhOgiugvatcnwqWYOVOSy/bn+YSsae/Gy7LGay3QlKgfSzW9XoASdnfE4VByKRs1k6IWjHAJMJNnCMyoDzh//xh1ckzUT+0rFCkOFTB5xalYRIWSLQUrt906lTnhAs2eDdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474030; c=relaxed/simple;
	bh=nrbCtg+2J+Lmv5tBBA8uzNDF5ymKY2ahEVwxJlWoeG4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEHH5F3nr9lW8dncAUmdDLNNo42eAoLdyJHT7G1a/2DGCMIHCE5dW+FSduZd0H7YHeQ2fD/KT/TSsb+7IAbzT4rrlvPND3XmavRxDtT/5+DrUfMLuUHVeeS4wEgRovxm3JUzvtKDqEIUNWj8DESU2eZXUHw7ooKA4gryoSNaPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1pJmAkP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1pJmAkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704C6C19425;
	Wed, 29 Apr 2026 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474030;
	bh=nrbCtg+2J+Lmv5tBBA8uzNDF5ymKY2ahEVwxJlWoeG4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=A1pJmAkPtdXi73rTgD+dRax5rq+Lz0RTC3eJ+QdJxQp0aKtU/0b9uhBtYEj4ifpzl
	 EHzSPlXq8G2YMCM85up9w81vAO1uFKM5XTVbdu5TR7OTpidapbDIyEIiinFp41x1oS
	 9kBJqCPvdGv0fbyrcjlELaKUQdLbMTI1Vmz5Ra1tJAhCoXmBxySlRmDVs9ifIJl8LQ
	 7WxHq0AiPkw1Q4mctgCSAMkPUdXu1cZubw5EqHlVXkNh2X1Kede7s+NlILDjd3CyhU
	 RrWMMtU6UwRLi4G1RFOKAyi6YU3ZFq/bW6WdEXcHGOVs2k8S/BVc5qr+/cso2ey11o
	 bCFBT3X2T3tEA==
Date: Wed, 29 Apr 2026 07:47:10 -0700
Subject: [PATCH 3/3] mount_service: create loop devices for regular files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212693.4105892.7912637523007431380.stgit@frogsfrogsfrogs>
In-Reply-To: <177747212630.4105892.8288935565208062403.stgit@frogsfrogsfrogs>
References: <177747212630.4105892.8288935565208062403.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If a fuse server asks fuservicemount to open a regular file, try to
create an auto-clear loop device so that the fuse server can use iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_service.h      |    6 ++++++
 include/fuse_service_priv.h |    4 +++-
 lib/fuse_service.c          |    5 ++++-
 util/mount_service.c        |   45 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 2 deletions(-)


diff --git a/include/fuse_service.h b/include/fuse_service.h
index 5c4cd89f68459d..152e46cf425d18 100644
--- a/include/fuse_service.h
+++ b/include/fuse_service.h
@@ -128,6 +128,12 @@ int fuse_service_parse_cmdline_opts(struct fuse_args *args,
  */
 #define FUSE_SERVICE_REQUEST_FILE_QUIET		(1U << 0)
 
+/**
+ * If the file opened is a regular file, try to create a loop device for it.
+ * If successful, the loop device is returned; if not, the regular file is.
+ */
+#define FUSE_SERVICE_REQUEST_FILE_TRYLOOP	(1U << 1)
+
 /**
  * Ask the mount.service helper to open a file on behalf of the fuse server.
  *
diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
index 224ccd6e926085..db9ecdf768b6d6 100644
--- a/include/fuse_service_priv.h
+++ b/include/fuse_service_priv.h
@@ -101,7 +101,9 @@ struct fuse_service_fsopen_command {
 };
 
 #define FUSE_SERVICE_OPEN_QUIET		(1U << 0)
-#define FUSE_SERVICE_OPEN_FLAGS		(FUSE_SERVICE_OPEN_QUIET)
+#define FUSE_SERVICE_OPEN_TRYLOOP	(1U << 1)
+#define FUSE_SERVICE_OPEN_FLAGS		(FUSE_SERVICE_OPEN_QUIET | \
+					 FUSE_SERVICE_OPEN_TRYLOOP)
 
 struct fuse_service_open_command {
 	struct fuse_service_packet p;
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index 2193b997583e3f..100c98e4a303c4 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -222,7 +222,8 @@ int fuse_service_receive_file(struct fuse_service *sf, const char *path,
 	return ret;
 }
 
-#define FUSE_SERVICE_REQUEST_FILE_FLAGS	(FUSE_SERVICE_REQUEST_FILE_QUIET)
+#define FUSE_SERVICE_REQUEST_FILE_FLAGS	(FUSE_SERVICE_REQUEST_FILE_QUIET | \
+					 FUSE_SERVICE_REQUEST_FILE_TRYLOOP)
 
 static int fuse_service_request_path(struct fuse_service *sf, const char *path,
 				     mode_t expected_fmt, int open_flags,
@@ -244,6 +245,8 @@ static int fuse_service_request_path(struct fuse_service *sf, const char *path,
 
 	if (request_flags & FUSE_SERVICE_REQUEST_FILE_QUIET)
 		rqflags |= FUSE_SERVICE_OPEN_QUIET;
+	if (request_flags & FUSE_SERVICE_REQUEST_FILE_TRYLOOP)
+		rqflags |= FUSE_SERVICE_OPEN_TRYLOOP;
 
 	cmd = calloc(1, cmdsz);
 	if (!cmd) {
diff --git a/util/mount_service.c b/util/mount_service.c
index c50eb3125f8ef1..f36471a6387601 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -37,6 +37,7 @@
 #include "util.h"
 #include "fuse_i.h"
 #include "fuse_service_priv.h"
+#include "fuse_loopdev.h"
 #include "mount_service.h"
 #include "fuser_conf.h"
 
@@ -754,6 +755,41 @@ static int prepare_bdev(struct mount_service *mo,
 	return 0;
 }
 
+static int prepare_loopdev(struct fuse_service_open_command *oc, int *fd)
+{
+	int reg_fd = *fd;
+	int loop_fd = -1;
+	int ret;
+
+	drop_privs();
+	ret = fuse_loopdev_setup(reg_fd, ntohl(oc->open_flags), oc->path, 5,
+				 &loop_fd, NULL);
+	restore_privs();
+	if (ret) {
+		/*
+		 * If the setup function returned EBUSY, there is already a
+		 * loop device backed by this file, so we must return an error.
+		 * For any other type of error we'll leave *fd untouched to
+		 * send the original file we opened to the fuse server.
+		 */
+		if (ret == -EBUSY)
+			return -EBUSY;
+		return 0;
+	}
+	if (loop_fd < 0) {
+		/*
+		 * The loopdev setup function didn't give us a new fd, so we
+		 * return having left the passed-in fd alone.
+		 */
+		return 0;
+	}
+
+	/* Substitute the loop device for the regular file. */
+	close(reg_fd);
+	*fd = loop_fd;
+	return 0;
+}
+
 static int mount_service_open_path(struct mount_service *mo,
 				   mode_t expected_fmt,
 				   struct fuse_service_packet *p, size_t psz)
@@ -802,6 +838,15 @@ static int mount_service_open_path(struct mount_service *mo,
 	}
 	restore_privs();
 
+	if (request_flags & FUSE_SERVICE_OPEN_TRYLOOP) {
+		ret = prepare_loopdev(oc, &fd);
+		if (ret < 0) {
+			close(fd);
+			return mount_service_send_file_error(mo, -ret,
+							     oc->path);
+		}
+	}
+
 	if (S_ISBLK(expected_fmt)) {
 		ret = prepare_bdev(mo, oc, fd);
 		if (ret < 0) {

