Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114A3C1411;
	Tue,  5 May 2026 05:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958756; cv=none; b=dmDIJb3J2A+bxGHwcQQYhDar/hlHZ/UYPyKmu+m+zhMosxICgDyAoNJUs0x5/J3ttC2Wg1Icb9QD5CzWkfzODjL7RObTD8vszJ+gLXaNp0wLEzx61DTu7+mhrZikFQk4bqXRxIdvCH/1/nO+DlBHAAk6wVQuHllfbX9629INXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958756; c=relaxed/simple;
	bh=dy9GqzdgD4NY9os4vbV/W65HIh+rPHDVbo2KG9B7q9k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZV1d/QSFVg990ZLPy2/gjf1zIugVyg9iox0zht+t1BcIN/DAnwn9JwmRqrcqW/hT9Ey1lsHeAtwcXi8eGhUawoelHi2YCcx6QQ7vMw7YSOrvdR1rZnho6oo0KeWe69AWKJxxe2pgCdYXIed39FGjP0d13k8rquIe29a6SDqNKUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIazY8NY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIazY8NY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9C1C2BCB4;
	Tue,  5 May 2026 05:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958756;
	bh=dy9GqzdgD4NY9os4vbV/W65HIh+rPHDVbo2KG9B7q9k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nIazY8NY9IyBavHJgKF4dHQkjhEfHTmg2rNvvEwPByMOP3uTYVt+ejQ2JxxoolC/B
	 SyseUby+L6mij3NvYLwdQh3hFhgZvT8+ZdPJwGgLYLrrQcBvj2hk7ObhktgNPAR42u
	 vOcDiVhsI+DYLaqvZftjQUEOaHKMeWYaRbqVSfk+c4gtDgLTeAx6H6+5I7ea2qzV4E
	 qq2kgIG3wbamzRsc36MWhr2UZH5d+oJsC6AYm9GOm4+WQdSGA0nlZF8U3Q7h2l7sEn
	 aKGdSBsTrV0SlpPFgl9qyv00Te4CRnJARBVb2wCre9DBlo45trgS/wZhXFvrMU1Nm1
	 3UzuSUmf3wi+Q==
Date: Mon, 04 May 2026 22:25:56 -0700
Subject: [PATCH 08/10] util: fix cppcheck complaints about constifying
 pointers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853828.1133612.413151057564265737.stgit@frogsfrogsfrogs>
In-Reply-To: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
References: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Fix various cppcheck complaints about pointers that could be const
pointers instead.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 util/fuservicemount.c |    2 +
 util/mount_service.c  |   68 ++++++++++++++++++++++++++-----------------------
 2 files changed, 37 insertions(+), 33 deletions(-)


diff --git a/util/fuservicemount.c b/util/fuservicemount.c
index 4d4cad6cb9253c..a17ae0be290794 100644
--- a/util/fuservicemount.c
+++ b/util/fuservicemount.c
@@ -29,7 +29,7 @@ static int check_service(const char *fstype)
 
 int main(int argc, char *argv[])
 {
-	char *fstype = NULL;
+	const char *fstype = NULL;
 	bool check = false;
 	int i;
 
diff --git a/util/mount_service.c b/util/mount_service.c
index 3fbabfdd69300d..8c9747b3928a51 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -97,7 +97,7 @@ static inline bool have_real_mtabopts(const struct mount_service *mo)
 	return mo->mtabopts && mo->mtabopts != &IGNORE_MTAB;
 }
 
-static ssize_t __send_fd(struct mount_service *mo,
+static ssize_t __send_fd(const struct mount_service *mo,
 			 struct fuse_service_requested_file *req,
 			 size_t req_sz, int fd)
 {
@@ -132,7 +132,8 @@ static ssize_t __send_fd(struct mount_service *mo,
 	return sendmsg(mo->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
 }
 
-static ssize_t __send_packet(struct mount_service *mo, void *ptr, size_t len)
+static ssize_t __send_packet(const struct mount_service *mo, void *ptr,
+			     size_t len)
 {
 	struct iovec iov = {
 		.iov_base = ptr,
@@ -146,7 +147,7 @@ static ssize_t __send_packet(struct mount_service *mo, void *ptr, size_t len)
 	return sendmsg(mo->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
 }
 
-static ssize_t __recv_packet_size(struct mount_service *mo)
+static ssize_t __recv_packet_size(const struct mount_service *mo)
 {
 	struct iovec iov = { };
 	struct msghdr msg = {
@@ -156,7 +157,8 @@ static ssize_t __recv_packet_size(struct mount_service *mo)
 	return recvmsg(mo->sockfd, &msg, MSG_PEEK | MSG_TRUNC);
 }
 
-static ssize_t __recv_packet(struct mount_service *mo, void *ptr, size_t len)
+static ssize_t __recv_packet(const struct mount_service *mo, void *ptr,
+			     size_t len)
 {
 	struct iovec iov = {
 		.iov_base = ptr,
@@ -198,7 +200,7 @@ const char *mount_service_subtype(const char *fstype)
 
 static int mount_service_init(struct mount_service *mo, int argc, char *argv[])
 {
-	char *fstype = NULL;
+	const char *fstype = NULL;
 	const char *subtype;
 	int i;
 
@@ -237,7 +239,7 @@ static int mount_service_init(struct mount_service *mo, int argc, char *argv[])
 }
 
 #ifdef SO_PASSRIGHTS
-static int try_drop_passrights(struct mount_service *mo, int sockfd)
+static int try_drop_passrights(const struct mount_service *mo, int sockfd)
 {
 	int zero = 0;
 	int ret;
@@ -260,7 +262,7 @@ static int try_drop_passrights(struct mount_service *mo, int sockfd)
 # define try_drop_passrights(...)	(0)
 #endif
 
-static int check_sendbuf_size(struct mount_service *mo, int sockfd)
+static int check_sendbuf_size(const struct mount_service *mo, int sockfd)
 {
 	const size_t min_size = sizeof_fuse_service_open_command(PATH_MAX);
 	int sendbuf_size = -1;
@@ -344,7 +346,7 @@ static int mount_service_connect(struct mount_service *mo)
 	return -1;
 }
 
-static int mount_service_send_hello(struct mount_service *mo)
+static int mount_service_send_hello(const struct mount_service *mo)
 {
 	struct fuse_service_hello hello = {
 		.p.magic = htonl(FUSE_SERVICE_HELLO_CMD),
@@ -398,7 +400,7 @@ static int mount_service_send_hello(struct mount_service *mo)
 	return 0;
 }
 
-static int mount_service_capture_arg(struct mount_service *mo,
+static int mount_service_capture_arg(const struct mount_service *mo,
 				     struct fuse_service_memfd_argv *args,
 				     const char *string, off_t *array_pos,
 				     off_t *string_pos)
@@ -510,7 +512,7 @@ static int mount_service_capture_args(struct mount_service *mo, int argc,
 	return 0;
 }
 
-static int mount_service_send_file(struct mount_service *mo,
+static int mount_service_send_file(const struct mount_service *mo,
 				   const char *path, int fd)
 {
 	struct fuse_service_requested_file *req;
@@ -548,8 +550,8 @@ static int mount_service_send_file(struct mount_service *mo,
 	return ret;
 }
 
-static int mount_service_send_file_error(struct mount_service *mo, int error,
-					 const char *path)
+static int mount_service_send_file_error(const struct mount_service *mo,
+					 int error, const char *path)
 {
 	struct fuse_service_requested_file *req;
 	const size_t req_sz =
@@ -619,7 +621,7 @@ static int mount_service_send_required_files(struct mount_service *mo,
 	return ret;
 }
 
-static int mount_service_receive_command(struct mount_service *mo,
+static int mount_service_receive_command(const struct mount_service *mo,
 					 struct fuse_service_packet **commandp,
 					 size_t *commandsz)
 {
@@ -676,7 +678,7 @@ static int mount_service_receive_command(struct mount_service *mo,
 	return 0;
 }
 
-static int mount_service_send_reply(struct mount_service *mo, int error)
+static int mount_service_send_reply(const struct mount_service *mo, int error)
 {
 	struct fuse_service_simple_reply reply = {
 		.p.magic = htonl(FUSE_SERVICE_SIMPLE_REPLY),
@@ -694,8 +696,8 @@ static int mount_service_send_reply(struct mount_service *mo, int error)
 	return 0;
 }
 
-static int prepare_bdev(struct mount_service *mo,
-			struct fuse_service_open_command *oc, int fd)
+static int prepare_bdev(const struct mount_service *mo,
+			const struct fuse_service_open_command *oc, int fd)
 {
 	struct stat stbuf;
 	int ret;
@@ -734,11 +736,11 @@ static int prepare_bdev(struct mount_service *mo,
 	return 0;
 }
 
-static int mount_service_open_path(struct mount_service *mo,
+static int mount_service_open_path(const struct mount_service *mo,
 				   mode_t expected_fmt,
 				   struct fuse_service_packet *p, size_t psz)
 {
-	struct fuse_service_open_command *oc =
+	const struct fuse_service_open_command *oc =
 			container_of(p, struct fuse_service_open_command, p);
 	uint32_t request_flags;
 	int open_flags;
@@ -796,14 +798,14 @@ static int mount_service_open_path(struct mount_service *mo,
 	return ret;
 }
 
-static int mount_service_handle_open_cmd(struct mount_service *mo,
+static int mount_service_handle_open_cmd(const struct mount_service *mo,
 					 struct fuse_service_packet *p,
 					 size_t psz)
 {
 	return mount_service_open_path(mo, 0, p, psz);
 }
 
-static int mount_service_handle_open_bdev_cmd(struct mount_service *mo,
+static int mount_service_handle_open_bdev_cmd(const struct mount_service *mo,
 					      struct fuse_service_packet *p,
 					      size_t psz)
 {
@@ -834,7 +836,7 @@ static int mount_service_handle_fsopen_cmd(struct mount_service *mo,
 					   const struct fuse_service_packet *p,
 					   size_t psz)
 {
-	struct fuse_service_fsopen_command *oc =
+	const struct fuse_service_fsopen_command *oc =
 			container_of(p, struct fuse_service_fsopen_command, p);
 	uint32_t fsopen_flags;
 
@@ -1059,7 +1061,8 @@ static int mount_service_handle_mtabopts_cmd(struct mount_service *mo,
 	struct fuse_service_string_command *oc =
 			container_of(p, struct fuse_service_string_command, p);
 	char *tokstr = oc->value;
-	char *tok, *savetok;
+	const char *tok;
+	char *savetok;
 
 	if (psz < sizeof_fuse_service_string_command(1)) {
 		fprintf(stderr, "%s: mtab options command too small\n",
@@ -1284,9 +1287,10 @@ static int attach_to_mountpoint(struct mount_service *mo, mode_t expected_fmt,
 
 static int mount_service_handle_mountpoint_cmd(struct mount_service *mo,
 					       const struct fuse_service_packet *p,
-					       size_t psz, int argc, char *argv[])
+					       size_t psz, int argc,
+					       const char * const argv[])
 {
-	struct fuse_service_mountpoint_command *oc =
+	const struct fuse_service_mountpoint_command *oc =
 			container_of(p, struct fuse_service_mountpoint_command, p);
 	char *mntpt;
 	mode_t expected_fmt;
@@ -1373,8 +1377,8 @@ static inline int format_libfuse_mntopts(char *buf, size_t bufsz,
 }
 
 static int mount_service_regular_mount(struct mount_service *mo,
-				       struct fuse_service_mount_command *oc,
-				       struct stat *stbuf)
+				       const struct fuse_service_mount_command *oc,
+				       const struct stat *stbuf)
 {
 	char *fstype = NULL;
 	char *realmopts;
@@ -1534,8 +1538,8 @@ static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
 }
 
 static int mount_service_fsopen_mount(struct mount_service *mo,
-				      struct fuse_service_mount_command *oc,
-				      struct stat *stbuf)
+				      const struct fuse_service_mount_command *oc,
+				      const struct stat *stbuf)
 {
 	char tmp[64];
 	unsigned long ms_flags;
@@ -1729,7 +1733,7 @@ static int check_nonroot_file_access(struct mount_service *mo)
 	return ret;
 }
 
-static void adjust_nonroot_mount_flags(struct mount_service *mo,
+static void adjust_nonroot_mount_flags(const struct mount_service *mo,
 				       struct fuse_service_mount_command *oc)
 {
 	const struct mount_flags *mf;
@@ -1905,11 +1909,11 @@ static int mount_service_handle_unmount_cmd(struct mount_service *mo,
 	return mount_service_send_reply(mo, 0);
 }
 
-static int mount_service_handle_bye_cmd(struct mount_service *mo,
+static int mount_service_handle_bye_cmd(const struct mount_service *mo,
 					struct fuse_service_packet *p,
 					size_t psz)
 {
-	struct fuse_service_bye_command *bc =
+	const struct fuse_service_bye_command *bc =
 			container_of(p, struct fuse_service_bye_command, p);
 	int ret;
 
@@ -2033,7 +2037,7 @@ int mount_service_main(int argc, char *argv[])
 			break;
 		case FUSE_SERVICE_MNTPT_CMD:
 			ret = mount_service_handle_mountpoint_cmd(&mo, p, sz,
-								  argc, argv);
+					argc, (const char * const *)argv);
 			break;
 		case FUSE_SERVICE_MTABOPTS_CMD:
 			ret = mount_service_handle_mtabopts_cmd(&mo, p, sz);

