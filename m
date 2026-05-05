Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10B3A2549;
	Tue,  5 May 2026 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958725; cv=none; b=paqVrwxvRMqAOnx0FNQoR0P94pUG3WRgjOrdHniWqxIZubS4IhhQqSnUJDmqMMX97yDUxyJtHE5/mRBudbeNfnwANBlSeTJlSEqMFnP0nqZdMi0qt3Vwapxf4Nxn0KNtgNEljHSMejzsvL5hQciStPa3HUtBP9uRCeIr27lChGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958725; c=relaxed/simple;
	bh=4nyBvYNb00bN2VljvbdIhCYVVaNo09L+Ii+kMz8PTWk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocEGO4lIXM5g9tCZMp11qnGuYGvFLgIvqs193XT4o4SGLia2GnNnyCHyPBsQW8wLZWqL/7oVVNCUmIWa3a3+VOxEKNxa5Rm/mcCvmowBSK/Asgc6dLGXf9ix2pKIR3tJzsWFNvN/Gd5PlttAKDtp48ORKJd5G5uyI2FtBQ4SckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6OMITM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6OMITM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3FCC2BCB4;
	Tue,  5 May 2026 05:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958725;
	bh=4nyBvYNb00bN2VljvbdIhCYVVaNo09L+Ii+kMz8PTWk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=J6OMITM0fUBWs/ynd78eo+zNVikKI+QzVaSYg88vx+8sNJfWlNfBjI2fQDGwBsmeJ
	 cb6T4BcPSW5xkJIWArFbadcq+KJwmy2Xs7nkKPa+tRsmpM2aMd7mJerXhKTAT9AxuH
	 8/jJ2Z8h4kIPB+zzZArkteDXaR9IbSZhYZC+AA25XYC9E5h1RrCsT8pUaBKs7Wwc+2
	 LH9inHcN2rr6Md+vFo6+wCC4C/6ix0PYRuYslXEL6Y0FG3bGoIWTp6LOLlQtRpqT8t
	 58SKcM8meyJM2gW5a3kd5qN8LVg5ZSa5nZRAv0b46Rq2yo8KBLbQvl95RWxp7asMuE
	 41VAoopLGRMHg==
Date: Mon, 04 May 2026 22:25:24 -0700
Subject: [PATCH 06/10] libfuse: fix cppcheck complaints about constifying
 pointers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853793.1133612.11088485120340130526.stgit@frogsfrogsfrogs>
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
 include/fuse_service.h  |    7 ++++---
 lib/fuse_service.c      |   30 +++++++++++++++++-------------
 lib/fuse_service_stub.c |    6 ++++--
 3 files changed, 25 insertions(+), 18 deletions(-)


diff --git a/include/fuse_service.h b/include/fuse_service.h
index 7e4c204e7a70bf..399830fcf142fe 100644
--- a/include/fuse_service.h
+++ b/include/fuse_service.h
@@ -48,7 +48,7 @@ int fuse_service_accept(struct fuse_service **sfp);
  * @param sf service context
  * @return true if it has, false if not
  */
-static inline bool fuse_service_accepted(struct fuse_service *sf)
+static inline bool fuse_service_accepted(const struct fuse_service *sf)
 {
 	return sf != NULL;
 }
@@ -59,7 +59,7 @@ static inline bool fuse_service_accepted(struct fuse_service *sf)
  * @param sf service context
  * @return true if it has, false if not
  */
-bool fuse_service_can_allow_other(struct fuse_service *sf);
+bool fuse_service_can_allow_other(const struct fuse_service *sf);
 
 /**
  * Release all resources associated with the service context.
@@ -97,7 +97,8 @@ int fuse_service_append_args(struct fuse_service *sf, struct fuse_args *args);
  * @param args fuse args structure
  * @return effective command line string, or NULL
  */
-char *fuse_service_cmdline(int argc, char *argv[], struct fuse_args *args);
+char *fuse_service_cmdline(int argc, const char * const *argv,
+			   struct fuse_args *args);
 
 struct fuse_cmdline_opts;
 
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index 240b1107296849..5831e2131e9cbf 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -53,7 +53,7 @@ struct fuse_service {
 	bool allow_other;
 };
 
-static int __recv_fd(struct fuse_service *sf,
+static int __recv_fd(const struct fuse_service *sf,
 		     struct fuse_service_requested_file *buf,
 		     ssize_t bufsize, int *fdp)
 {
@@ -132,7 +132,8 @@ static int __recv_fd(struct fuse_service *sf,
 	return 0;
 }
 
-static ssize_t __send_packet(struct fuse_service *sf, void *ptr, size_t len)
+static ssize_t __send_packet(const struct fuse_service *sf, void *ptr,
+			     size_t len)
 {
 	struct iovec iov = {
 		.iov_base = ptr,
@@ -146,7 +147,8 @@ static ssize_t __send_packet(struct fuse_service *sf, void *ptr, size_t len)
 	return sendmsg(sf->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
 }
 
-static ssize_t __recv_packet(struct fuse_service *sf, void *ptr, size_t len)
+static ssize_t __recv_packet(const struct fuse_service *sf, void *ptr,
+			     size_t len)
 {
 	struct iovec iov = {
 		.iov_base = ptr,
@@ -219,7 +221,8 @@ int fuse_service_receive_file(struct fuse_service *sf, const char *path,
 
 #define FUSE_SERVICE_REQUEST_FILE_FLAGS	(FUSE_SERVICE_REQUEST_FILE_QUIET)
 
-static int fuse_service_request_path(struct fuse_service *sf, const char *path,
+static int fuse_service_request_path(const struct fuse_service *sf,
+				     const char *path,
 				     mode_t expected_fmt, int open_flags,
 				     mode_t create_mode,
 				     unsigned int request_flags,
@@ -322,8 +325,8 @@ int fuse_service_send_goodbye(struct fuse_service *sf, int exitcode)
 
 static int count_listen_fds(void)
 {
-	char *listen_fds;
-	char *listen_pid;
+	const char *listen_fds;
+	const char *listen_pid;
 	char *p;
 	long l;
 
@@ -589,7 +592,7 @@ int fuse_service_accept(struct fuse_service **sfp)
 	return ret;
 }
 
-bool fuse_service_can_allow_other(struct fuse_service *sf)
+bool fuse_service_can_allow_other(const struct fuse_service *sf)
 {
 	return sf->allow_other;
 }
@@ -781,7 +784,7 @@ int fuse_service_finish_file_requests(struct fuse_service *sf)
 }
 #endif
 
-static int send_fsopen(struct fuse_service *sf, const char *fstype,
+static int send_fsopen(const struct fuse_service *sf, const char *fstype,
 		       int *errorp)
 {
 	struct fuse_service_simple_reply reply = { };
@@ -825,7 +828,7 @@ static int send_fsopen(struct fuse_service *sf, const char *fstype,
 	return 0;
 }
 
-static int send_string(struct fuse_service *sf, uint32_t command,
+static int send_string(const struct fuse_service *sf, uint32_t command,
 		       const char *value, int *errorp)
 {
 	struct fuse_service_simple_reply reply = { };
@@ -877,7 +880,7 @@ static int send_string(struct fuse_service *sf, uint32_t command,
 	return 0;
 }
 
-static int send_mountpoint(struct fuse_service *sf, mode_t expected_fmt,
+static int send_mountpoint(const struct fuse_service *sf, mode_t expected_fmt,
 			   const char *value, int *errorp)
 {
 	struct fuse_service_simple_reply reply = { };
@@ -932,7 +935,7 @@ static int send_mountpoint(struct fuse_service *sf, mode_t expected_fmt,
 	return 0;
 }
 
-static int send_mount(struct fuse_service *sf, unsigned int ms_flags,
+static int send_mount(const struct fuse_service *sf, unsigned int ms_flags,
 		      int *errorp)
 {
 	struct fuse_service_simple_reply reply = { };
@@ -1175,12 +1178,13 @@ void fuse_service_destroy(struct fuse_service **sfp)
 	*sfp = NULL;
 }
 
-char *fuse_service_cmdline(int argc, char *argv[], struct fuse_args *args)
+char *fuse_service_cmdline(int argc, const char * const *argv,
+			   struct fuse_args *args)
 {
 	char *p, *dst;
 	size_t len = 1;
 	ssize_t ret;
-	char *argv0;
+	const char *argv0;
 	unsigned int i;
 
 	/* Try to preserve argv[0] */
diff --git a/lib/fuse_service_stub.c b/lib/fuse_service_stub.c
index 231b98423df628..83f749bc15c0cc 100644
--- a/lib/fuse_service_stub.c
+++ b/lib/fuse_service_stub.c
@@ -23,6 +23,7 @@
 int fuse_service_receive_file(struct fuse_service *sf, const char *path,
 			      int *fdp)
 {
+	*fdp = -1;
 	return -EOPNOTSUPP;
 }
 
@@ -52,7 +53,7 @@ int fuse_service_accept(struct fuse_service **sfp)
 	return 0;
 }
 
-bool fuse_service_can_allow_other(struct fuse_service *sf)
+bool fuse_service_can_allow_other(const struct fuse_service *sf)
 {
 	return false;
 }
@@ -63,7 +64,8 @@ int fuse_service_append_args(struct fuse_service *sf,
 	return -EOPNOTSUPP;
 }
 
-char *fuse_service_cmdline(int argc, char *argv[], struct fuse_args *args)
+char *fuse_service_cmdline(int argc, const char * const *argv,
+			   struct fuse_args *args)
 {
 	return NULL;
 }

