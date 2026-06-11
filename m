Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB11E8826;
	Thu, 11 Jun 2026 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140451; cv=none; b=C2rnQzwZCFXZiRUkwt3cBDtIfBMDnB2BrvcLDVjWr8Oo+UW9+H5msHXuDJUb6ovU4XdeHO6ZyuicA6f8o+7F3uj8B7Zxpt/j+5tEzjnJQ1mL9TYpWvCR+2ciHhUR4YehoUCnroKDESChMo+tGwC3KuxgdH79VSW1IMEdmvU/nVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140451; c=relaxed/simple;
	bh=RvnsXUb7WSI152+3lcvoM7X93601MBqKMJThzk7OCcA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqyQtq7EyzHhwDDzbn40tysjsRysKbD0/ezszwLgPoGF0/Nsm6O8Ltcv69CfP9uJD5W1xEJ8VYSSIk+mpwPvyQOBON7X6IebXCH5ren8pdh/vzFKfq+J/avV8ScJ6Q2R3Xcu2Kek1JYavSo1RBLd81v6zL5az6ULhmO7w5CnCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKRgXjYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKRgXjYi"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 359051F00893;
	Thu, 11 Jun 2026 01:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781140450;
	bh=Z6mihF/aUti1QqRMHWiGLzXD4l9ul/ZqW1HoJeVuQc4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=HKRgXjYiMw1QW4sHwyml3LmoTmRTz+jeeRvXjHReIk0NV6/9ZCEUqENbdI+R5+vnn
	 e644NZ+o+cqdTco2J6Hrlc7hWSR2MzkpWVB1+YlPj5Mk2XLpWJGT2EkFmzUFfdKjPW
	 zlnNJN6Op/CyV6TjBP6CgtEQM16tSEaU6/u+v0xHnXC6f9JdbY/MdpcLKpaBbh4OFC
	 5veYkffMbFeXJgIWSDvfI3idB4AfCB9BZP1yioa9h+QRaoqIxygz6Y8bjkAXvEh5Fn
	 5RoziblgMyNxzpsGWbwLw2fAxq0s/EGQWHu9tpsfmbzGMgs4OJp+MzLN1G1qDiD4Ox
	 QJcsXcFCsMMbw==
Date: Wed, 10 Jun 2026 18:14:09 -0700
Subject: [PATCH 7/7] libfuse: remove unmount command from the service api
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178114032697.139936.7354789721792577507.stgit@frogsfrogsfrogs>
In-Reply-To: <178114032546.139936.4052263259025005657.stgit@frogsfrogsfrogs>
References: <178114032546.139936.4052263259025005657.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Bernd received a complaint via github that the "unmount" command in the
new fuse service API is prone to malicious symlink creation races
because the umount2 call doesn't use UMOUNT_NOFOLLOW.  Therefore, if you
can trick a fuse service into asking the mount service helper to undo
the mount just after you've replaced the mount with a symlink to a
sensitive mount (e.g. /sys) then you whack a system hard.

I don't know why this unmounting functionality exists in libfuse, and
apparently Bernd doesn't like it.  Since the fuse service API has not
yet been released, let's just rip out the command and pretend it never
existed.

Fixes: 5d8b9a39a1cb3e ("mount_service: add systemd socket service mounting helper")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_service.h      |    8 ------
 include/fuse_service_priv.h |    5 ----
 lib/fuse_service.c          |   51 -------------------------------------
 lib/fuse_service_stub.c     |    5 ----
 lib/fuse_versionscript      |    1 -
 util/mount_service.c        |   60 +------------------------------------------
 6 files changed, 1 insertion(+), 129 deletions(-)


diff --git a/include/fuse_service.h b/include/fuse_service.h
index 0536312dc7120c..d6aedea8f0f831 100644
--- a/include/fuse_service.h
+++ b/include/fuse_service.h
@@ -218,14 +218,6 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
 			       mode_t expected_fmt,
 			       struct fuse_cmdline_opts *opts);
 
-/**
- * Ask the mount helper to unmount th e filesystem.
- *
- * @param sf service context
- * @return 0 on success, or negative errno on failure
- */
-int fuse_service_session_unmount(const struct fuse_service *sf);
-
 /**
  * Bid farewell to the mount.service helper.  It is still necessary to call
  * fuse_service_destroy after this.
diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
index cfbc444bf5dcbd..988f7c9251c86d 100644
--- a/include/fuse_service_priv.h
+++ b/include/fuse_service_priv.h
@@ -37,7 +37,6 @@ struct fuse_service_memfd_argv {
 #define FUSE_SERVICE_MNTOPTS_CMD	0x4f505453	/* OPTS */
 #define FUSE_SERVICE_MNTPT_CMD		0x4d4e5450	/* MNTP */
 #define FUSE_SERVICE_MOUNT_CMD		0x444f4954	/* DOIT */
-#define FUSE_SERVICE_UNMOUNT_CMD	0x554d4e54	/* UMNT */
 #define FUSE_SERVICE_BYE_CMD		0x42594545	/* BYEE */
 #define FUSE_SERVICE_MTABOPTS_CMD	0x4d544142	/* MTAB */
 
@@ -150,10 +149,6 @@ struct fuse_service_mount_command {
 	uint32_t ms_flags;
 };
 
-struct fuse_service_unmount_command {
-	struct fuse_service_packet p;
-};
-
 int fuse_parse_cmdline_service(struct fuse_args *args,
 				 struct fuse_cmdline_opts *opts);
 
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index 2d7232c3484aea..b42e6b53f516cb 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -1128,57 +1128,6 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
 	return ret;
 }
 
-int fuse_service_session_unmount(const struct fuse_service *sf)
-{
-	struct fuse_service_simple_reply reply = { };
-	struct fuse_service_unmount_command c = {
-		.p.magic = htonl(FUSE_SERVICE_UNMOUNT_CMD),
-	};
-	ssize_t size;
-
-	/* already gone? */
-	if (sf->sockfd < 0)
-		return 0;
-
-	size = __send_packet(sf, &c, sizeof(c));
-	if (size < 0) {
-		int error = errno;
-
-		fuse_log(FUSE_LOG_ERR, "fuse: send service unmount: %s\n",
-			 strerror(error));
-		return -error;
-	}
-
-	size = __recv_packet(sf, &reply, sizeof(reply));
-	if (size < 0) {
-		int error = errno;
-
-		fuse_log(FUSE_LOG_ERR, "fuse: service unmount reply: %s\n",
-			 strerror(error));
-		return -error;
-	}
-	if (size != sizeof(reply)) {
-		fuse_log(FUSE_LOG_ERR, "fuse: wrong service unmount reply size %zd, expected %zd\n",
-			size, sizeof(reply));
-		return -EBADMSG;
-	}
-
-	if (ntohl(reply.p.magic) != FUSE_SERVICE_SIMPLE_REPLY) {
-		fuse_log(FUSE_LOG_ERR, "fuse: service unmount reply contains wrong magic!\n");
-		return -EBADMSG;
-	}
-
-	if (reply.error) {
-		int error = ntohl(reply.error);
-
-		fuse_log(FUSE_LOG_ERR, "fuse: service unmount: %s\n",
-			 strerror(error));
-		return -error;
-	}
-
-	return 0;
-}
-
 void fuse_service_release(struct fuse_service *sf)
 {
 	if (sf->owns_fusedevfd)
diff --git a/lib/fuse_service_stub.c b/lib/fuse_service_stub.c
index 44aef47e351388..668c259891c729 100644
--- a/lib/fuse_service_stub.c
+++ b/lib/fuse_service_stub.c
@@ -93,11 +93,6 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
 	return -EOPNOTSUPP;
 }
 
-int fuse_service_session_unmount(const struct fuse_service *sf)
-{
-	return -EOPNOTSUPP;
-}
-
 void fuse_service_release(struct fuse_service *sf)
 {
 }
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index ab79209008595a..e8dc0066137dde 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -250,7 +250,6 @@ FUSE_3.19 {
 		fuse_service_request_blockdev;
 		fuse_service_send_goodbye;
 		fuse_service_session_mount;
-		fuse_service_session_unmount;
 		fuse_req_secctx_count;
 		fuse_req_secctx_reset;
 		fuse_req_secctx_next;
diff --git a/util/mount_service.c b/util/mount_service.c
index 6a6a8b608b7c6e..d4f57630e4efe2 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -42,6 +42,7 @@
 #ifdef HAVE_NEW_MOUNT_API
 #include "mount_i_linux.h"
 #endif
+#include "fuse_mount_compat.h"
 
 struct mount_service {
 	/* prefix for printing error messages */
@@ -1722,62 +1723,6 @@ static int mount_service_handle_mount_cmd(struct mount_service *mo,
 	return mount_service_regular_mount(mo, oc, &stbuf);
 }
 
-static int mount_service_handle_unmount_cmd(struct mount_service *mo,
-					    struct fuse_service_packet *p,
-					    size_t psz)
-{
-	int ret;
-
-	(void)p;
-
-	if (psz != sizeof(struct fuse_service_unmount_command)) {
-		fprintf(stderr, "%s: unmount command wrong size %zu, expected %zu\n",
-			mo->msgtag, psz, sizeof(struct fuse_service_unmount_command));
-		return mount_service_send_reply(mo, EINVAL);
-	}
-
-	if (!mo->mounted) {
-		fprintf(stderr, "%s: will not umount before successful mount!\n",
-			mo->msgtag);
-		return mount_service_send_reply(mo, EINVAL);
-	}
-
-	ret = chdir("/");
-	if (ret) {
-		int error = errno;
-
-		fprintf(stderr, "%s: fuse server failed chdir: %s\n",
-			mo->msgtag, strerror(error));
-		return mount_service_send_reply(mo, error);
-	}
-
-	close(mo->mountfd);
-	mo->mountfd = -1;
-
-	/*
-	 * Try to unmount the resolved mountpoint, and hope that we're not the
-	 * victim of a race.
-	 */
-	ret = umount2(mo->resv_mountpoint, MNT_DETACH);
-	if (ret) {
-		int error = errno;
-
-		fprintf(stderr, "%s: fuse server failed unmount: %s\n",
-			mo->msgtag, strerror(error));
-		return mount_service_send_reply(mo, error);
-	}
-
-	/*
-	 * The unmount succeeded, so we send a positive reply even if the mtab
-	 * update fails.
-	 */
-	if (have_real_mtabopts(mo))
-		fuse_mnt_remove_mount(mo->msgtag, mo->resv_mountpoint);
-
-	mo->mounted = false;
-	return mount_service_send_reply(mo, 0);
-}
-
 static int mount_service_handle_bye_cmd(const struct mount_service *mo,
 					struct fuse_service_packet *p,
 					size_t psz)
@@ -1921,9 +1866,6 @@ int mount_service_main(int argc, char *argv[])
 		case FUSE_SERVICE_MOUNT_CMD:
 			ret = mount_service_handle_mount_cmd(&mo, p, sz);
 			break;
-		case FUSE_SERVICE_UNMOUNT_CMD:
-			ret = mount_service_handle_unmount_cmd(&mo, p, sz);
-			break;
 		case FUSE_SERVICE_BYE_CMD:
 			ret = mount_service_handle_bye_cmd(&mo, p, sz);
 			free(p);

