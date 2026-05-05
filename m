Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071A3B38BD;
	Tue,  5 May 2026 05:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958741; cv=none; b=dIpgIoNhhFRRZiFu65gElJzrLuLcdWzhO8871oY8gwJUjmt66Q4v+tHGkQOE6ffCwhaUqRgcqRCC2aNBe9HEdsckB1K6QJAtzEox85OLjzzfwDKmBmUixADhc5H4KQ4OITgKuGQqjWDoJsnCVy2D42EeM8KdyH5yxS4L8GkLXq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958741; c=relaxed/simple;
	bh=CECCQlEnzj4mqsr2rHCvaHiMQhX+ENk7FrLR/bbRNGs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWw5ctqenVG+mMviZmM+Ty62KAjNfwM0kV//zmzSFvfrQWu3yseyWYRI8iLVYfA4U6c4FDhcaJqYs/POstuBJBQmn8Lm7ntRDYfl+4L69aRRzLoLeDrCdZKGjQIhtjLJphUxTH0tqzjflX2R0F+rQ1E63n9njgk9l0xUxqMiD5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUNmychu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUNmychu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFABFC2BCB4;
	Tue,  5 May 2026 05:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958740;
	bh=CECCQlEnzj4mqsr2rHCvaHiMQhX+ENk7FrLR/bbRNGs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BUNmychuT3cfLmI0wx3Buv8JPomn7yrsyGKf80KIgipHyFUfrkvN9OgotbBdL61Qr
	 MltHibFAtNMyYDj075fX6GRb+PAjURQfJJ+glMiglGu0Rw5nG3xrg88kwclLZM7RIW
	 TMnTe6isYpxniTT0W8rCX0ubMJRHlqjqTAcOtRsUE/s1FdFvEp4nBcw0SvTAjOz2Iq
	 cINK2mVrboN3Hp5ph9HK/juf8vw6mQGMpuVU5WcrO7TbPtxDGWWcuivJCQFnFzjDA/
	 RWc3JzP3Wup3LqMQ4dCzy8IZZ3ryR0LEUFkyd7LOhrkcqNKctsBo4ohuWtdaoJEkWT
	 2Wo4dscGA+NPw==
Date: Mon, 04 May 2026 22:25:40 -0700
Subject: [PATCH 07/10] libfuse: fix cppcheck complaints about constifying
 pointers in user-visible ABI
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853811.1133612.11619751593807121023.stgit@frogsfrogsfrogs>
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

I am not sure you ought to take this patch, because this affects the
client program ABI by limiting what the library can do in the future
with the passed in struct fuse_service object.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 include/fuse_service.h  |   11 ++++++-----
 lib/fuse_service.c      |   13 +++++++------
 lib/fuse_service_stub.c |   11 ++++++-----
 3 files changed, 19 insertions(+), 16 deletions(-)


diff --git a/include/fuse_service.h b/include/fuse_service.h
index 399830fcf142fe..bd89189cfe5d5b 100644
--- a/include/fuse_service.h
+++ b/include/fuse_service.h
@@ -139,7 +139,7 @@ int fuse_service_parse_cmdline_opts(struct fuse_args *args,
  * @param request_flags set of FUSE_SERVICE_REQUEST_* flags
  * @return 0 on success, or negative errno on failure
  */
-int fuse_service_request_file(struct fuse_service *sf, const char *path,
+int fuse_service_request_file(const struct fuse_service *sf, const char *path,
 			      int open_flags, mode_t create_mode,
 			      unsigned int request_flags);
 
@@ -155,7 +155,8 @@ int fuse_service_request_file(struct fuse_service *sf, const char *path,
  * @param block_size set the block device block size to this value
  * @return 0 on success, or negative errno on failure
  */
-int fuse_service_request_blockdev(struct fuse_service *sf, const char *path,
+int fuse_service_request_blockdev(const struct fuse_service *sf,
+				  const char *path,
 				  int open_flags, mode_t create_mode,
 				  unsigned int request_flags,
 				  unsigned int block_size);
@@ -169,7 +170,7 @@ int fuse_service_request_blockdev(struct fuse_service *sf, const char *path,
  *      descriptor value on success, or negative errno on failure
  * @return 0 on success, or negative errno on socket communication failure
  */
-int fuse_service_receive_file(struct fuse_service *sf,
+int fuse_service_receive_file(const struct fuse_service *sf,
 			      const char *path, int *fdp);
 
 /**
@@ -178,7 +179,7 @@ int fuse_service_receive_file(struct fuse_service *sf,
  * @param sf service context
  * @return 0 on success, or negative errno on failure
  */
-int fuse_service_finish_file_requests(struct fuse_service *sf);
+int fuse_service_finish_file_requests(const struct fuse_service *sf);
 
 /**
  * Require that the filesystem mount point have the expected file format
@@ -215,7 +216,7 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
  * @param sf service context
  * @return 0 on success, or negative errno on failure
  */
-int fuse_service_session_unmount(struct fuse_service *sf);
+int fuse_service_session_unmount(const struct fuse_service *sf);
 
 /**
  * Bid farewell to the mount.service helper.  It is still necessary to call
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index 5831e2131e9cbf..d14aced29e8268 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -162,7 +162,7 @@ static ssize_t __recv_packet(const struct fuse_service *sf, void *ptr,
 	return recvmsg(sf->sockfd, &msg, MSG_TRUNC);
 }
 
-int fuse_service_receive_file(struct fuse_service *sf, const char *path,
+int fuse_service_receive_file(const struct fuse_service *sf, const char *path,
 			      int *fdp)
 {
 	struct fuse_service_requested_file *req;
@@ -278,7 +278,7 @@ static int fuse_service_request_path(const struct fuse_service *sf,
 	return ret;
 }
 
-int fuse_service_request_file(struct fuse_service *sf, const char *path,
+int fuse_service_request_file(const struct fuse_service *sf, const char *path,
 			      int open_flags, mode_t create_mode,
 			      unsigned int request_flags)
 {
@@ -286,7 +286,8 @@ int fuse_service_request_file(struct fuse_service *sf, const char *path,
 					 create_mode, request_flags, 0);
 }
 
-int fuse_service_request_blockdev(struct fuse_service *sf, const char *path,
+int fuse_service_request_blockdev(const struct fuse_service *sf,
+				  const char *path,
 				  int open_flags, mode_t create_mode,
 				  unsigned int request_flags,
 				  unsigned int block_size)
@@ -752,7 +753,7 @@ int fuse_service_append_args(struct fuse_service *sf,
 }
 
 #ifdef SO_PASSRIGHTS
-int fuse_service_finish_file_requests(struct fuse_service *sf)
+int fuse_service_finish_file_requests(const struct fuse_service *sf)
 {
 	int zero = 0;
 	int ret;
@@ -777,7 +778,7 @@ int fuse_service_finish_file_requests(struct fuse_service *sf)
 	return 0;
 }
 #else
-int fuse_service_finish_file_requests(struct fuse_service *sf)
+int fuse_service_finish_file_requests(const struct fuse_service *sf)
 {
 	(void)sf;
 	return 0;
@@ -1102,7 +1103,7 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
 	return ret;
 }
 
-int fuse_service_session_unmount(struct fuse_service *sf)
+int fuse_service_session_unmount(const struct fuse_service *sf)
 {
 	struct fuse_service_simple_reply reply = { };
 	struct fuse_service_unmount_command c = {
diff --git a/lib/fuse_service_stub.c b/lib/fuse_service_stub.c
index 83f749bc15c0cc..1e27f5ea0c6b57 100644
--- a/lib/fuse_service_stub.c
+++ b/lib/fuse_service_stub.c
@@ -20,21 +20,22 @@
 #include "fuse_i.h"
 #include "fuse_service.h"
 
-int fuse_service_receive_file(struct fuse_service *sf, const char *path,
+int fuse_service_receive_file(const struct fuse_service *sf, const char *path,
 			      int *fdp)
 {
 	*fdp = -1;
 	return -EOPNOTSUPP;
 }
 
-int fuse_service_request_file(struct fuse_service *sf, const char *path,
+int fuse_service_request_file(const struct fuse_service *sf, const char *path,
 			      int open_flags, mode_t create_mode,
 			      unsigned int request_flags)
 {
 	return -EOPNOTSUPP;
 }
 
-int fuse_service_request_blockdev(struct fuse_service *sf, const char *path,
+int fuse_service_request_blockdev(const struct fuse_service *sf,
+				  const char *path,
 				  int open_flags, mode_t create_mode,
 				  unsigned int request_flags,
 				  unsigned int block_size)
@@ -70,7 +71,7 @@ char *fuse_service_cmdline(int argc, const char * const *argv,
 	return NULL;
 }
 
-int fuse_service_finish_file_requests(struct fuse_service *sf)
+int fuse_service_finish_file_requests(const struct fuse_service *sf)
 {
 	return -EOPNOTSUPP;
 }
@@ -87,7 +88,7 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
 	return -EOPNOTSUPP;
 }
 
-int fuse_service_session_unmount(struct fuse_service *sf)
+int fuse_service_session_unmount(const struct fuse_service *sf)
 {
 	return -EOPNOTSUPP;
 }

