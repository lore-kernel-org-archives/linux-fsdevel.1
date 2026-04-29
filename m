Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938C32ED3A;
	Wed, 29 Apr 2026 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473780; cv=none; b=scLKb8vVHGx0PoDRPoTvCsBK7xUO1rV7pmZRlmegkJEUmCSnckY8/sBWduTUBtWKbNXUUt71VxIq7Rmxu4rxKWC4xFbJMt0gF1lGDHsbZ0EPCa7ecHsoRtGP7uUF0MWCBL1NRvhjdCLseQc+cCvvp6jRtiHVSNvkTfmqyX8/4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473780; c=relaxed/simple;
	bh=lDrP/DjMjjs4U1ur7P3WELJzkDZlxNxeRAouhLGkFOg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDKe3aUdBvlKrH+Rb6K3kbwqIHeNUdJR1W+FgRk97BUZlCBJd8Ch6WPNPSCNxCys6ElaPA8aowAixqoMY0gKzKt83ctWvXVO5HvieoQPXa/ynQPaIr7luf0YbYAbvfwoKij5dWXFWLiBVhUtuJK8p3FywGnCYMZ1AB/gn2Ifry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZLx8eXQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZLx8eXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF54C2BCC6;
	Wed, 29 Apr 2026 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473779;
	bh=lDrP/DjMjjs4U1ur7P3WELJzkDZlxNxeRAouhLGkFOg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iZLx8eXQ1y6jegUsbe545WekzOofgc+/pYB8lGOkrJk+wQU9mBFg0oy1AYltl2BYo
	 mNU6jy/EbmKCa6YBzz6z28JxZK4Tb5vZZtbwiYW+CnQkCfd9E7n+sL1ehuvCLmwIW+
	 Ymddc7kSRElqKtKk/8HKrQtnbfHjuLZcccMEmn+xkSXkTcdrLchoETiYy7m8DVXKvC
	 iUX6rWWOqs7pecpNQN6wrKYi8ZSqegFnM4k925neX5ukWWlPHvxuEwNAj1p64mXvll
	 +GqNuMunAFGDHHve8q6MlDhtCcci/z3SaBbRPnwGz08qdIkxon1zQKaVRZ/pJZAJs9
	 03jEUsoMTBfOw==
Date: Wed, 29 Apr 2026 07:42:59 -0700
Subject: [PATCH 15/25] libfuse: allow discovery of the kernel's iomap
 capabilities
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211836.4104686.11098687446705278963.stgit@frogsfrogsfrogs>
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

Create a library function so that we can discover the kernel's iomap
capabilities ahead of time.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |    7 +++++++
 include/fuse_kernel.h   |    7 +++++++
 include/fuse_lowlevel.h |    9 +++++++++
 include/fuse_service.h  |   12 ++++++++++++
 lib/fuse_lowlevel.c     |   19 +++++++++++++++++++
 lib/fuse_service.c      |    5 +++++
 lib/fuse_service_stub.c |    5 +++++
 lib/fuse_versionscript  |    2 ++
 8 files changed, 66 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 6c03d845258d25..277a8209f09d50 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -539,6 +539,13 @@ struct fuse_loop_config_v1 {
 
 #define FUSE_IOCTL_MAX_IOV	256
 
+/**
+ * iomap discovery flags
+ *
+ * FUSE_IOMAP_SUPPORT_FILEIO: basic file I/O functionality through iomap
+ */
+#define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+
 /**
  * Connection information, passed to the ->init() method
  *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 6b1fcc44004dbf..95c6c179a4398a 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1156,12 +1156,19 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+struct fuse_iomap_support {
+	uint64_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
+					     struct fuse_iomap_support)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 6d80713fe8bf88..df41afee0cfbe5 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2659,6 +2659,15 @@ bool fuse_req_is_uring(fuse_req_t req);
 int fuse_req_get_payload(fuse_req_t req, char **payload, size_t *payload_sz,
 			 void **mr);
 
+/**
+ * Discover the kernel's iomap capabilities.  Returns FUSE_CAP_IOMAP_* flags.
+ *
+ * @param fd open file descriptor to a fuse device, or -1 if you're running
+ *           in the same process that will call mount().
+ * @return FUSE_IOMAP_SUPPORT_* flags
+ */
+uint64_t fuse_lowlevel_discover_iomap(int fd);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/fuse_service.h b/include/fuse_service.h
index 7e4c204e7a70bf..f1b3fb738aec3a 100644
--- a/include/fuse_service.h
+++ b/include/fuse_service.h
@@ -234,6 +234,18 @@ int fuse_service_send_goodbye(struct fuse_service *sf, int exitcode);
  */
 int fuse_service_exit(int ret);
 
+#if FUSE_MAKE_VERSION(3, 99) <= FUSE_USE_VERSION
+/**
+ * Discover the kernel's iomap capabilities.  Returns FUSE_CAP_IOMAP_* flags.
+ *
+ * @param fd open file descriptor to a fuse device, or -1 if you're running
+ *           in the same process that will call mount().
+ * @return FUSE_IOMAP_SUPPORT_* flags
+ */
+uint64_t fuse_service_discover_iomap(struct fuse_service *sf);
+
+#endif /* FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 99) */
+
 #endif /* FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 19) */
 
 #ifdef __cplusplus
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 034c00fcbe07ca..90136408b39204 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -5082,3 +5082,22 @@ void fuse_session_stop_teardown_watchdog(void *data)
 	pthread_join(tt->thread_id, NULL);
 	fuse_tt_destruct(tt);
 }
+
+uint64_t fuse_lowlevel_discover_iomap(int fd)
+{
+	struct fuse_iomap_support ios = { };
+
+	if (fd >= 0) {
+		ioctl(fd, FUSE_DEV_IOC_IOMAP_SUPPORT, &ios);
+		return ios.flags;
+	}
+
+	fd = open(fuse_mnt_get_devname(), O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return 0;
+
+	ioctl(fd, FUSE_DEV_IOC_IOMAP_SUPPORT, &ios);
+	close(fd);
+
+	return ios.flags;
+}
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index 83c1d564a18b0c..e860d1aafbe5e5 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -1246,3 +1246,8 @@ int fuse_service_exit(int ret)
 	 */
 	return ret != 0 ? EXIT_FAILURE : EXIT_SUCCESS;
 }
+
+uint64_t fuse_service_discover_iomap(struct fuse_service *sf)
+{
+	return fuse_lowlevel_discover_iomap(sf->fusedevfd);
+}
diff --git a/lib/fuse_service_stub.c b/lib/fuse_service_stub.c
index d34df3891a6e31..2cafde6d6b6f5d 100644
--- a/lib/fuse_service_stub.c
+++ b/lib/fuse_service_stub.c
@@ -104,3 +104,8 @@ int fuse_service_exit(int ret)
 {
 	return ret;
 }
+
+uint64_t fuse_service_discover_iomap(struct fuse_service *sf)
+{
+	return 0;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 5c1a1bfff44d87..46465540a1f51b 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -262,6 +262,8 @@ FUSE_3.99 {
 		fuse_add_direntry_plus_iflags;
 		fuse_fs_can_enable_iomap;
 		fuse_fs_can_enable_iomapx;
+		fuse_lowlevel_discover_iomap;
+		fuse_service_discover_iomap;
 } FUSE_3.19;
 
 # Local Variables:

