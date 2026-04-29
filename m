Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA01E25F9;
	Wed, 29 Apr 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473999; cv=none; b=LdTU06dXEfC1xnVaUgcB8D6zJ8G47ukzG5dDJxKVXrMg9rp4A14hY+FNGFSZ7T0owN6xnBi7uViVNJqajP+1EQs1QXgVNA1ep2CM62QpH7wtTgdcCEIn+UDpX+6aGR6QKgOsT+cHdJCgi9kLJQyGOX5DUtYcfvOgGsuNm9tfdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473999; c=relaxed/simple;
	bh=2R49fnwZXOniH5dsMvSKs1PdLgyYuD0bq65VQPJyf1s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkdrQ5QATK1oTH2TgHiLVxzENFVA0pjDdQNOGGW4HP+1g/cX2dh3pSj5UW0n3ZMiuXJjKNoZK7sY6voAYk6QJMwtzapmHuMPUbsMbHq8tUhQggcO3l2ahRGhNR97Y1+Cjv1aGv2PK3Kc4zEumCIQ+mFPy06AKLN4pJpSXIsfbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnF71OOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnF71OOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A86C19425;
	Wed, 29 Apr 2026 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473999;
	bh=2R49fnwZXOniH5dsMvSKs1PdLgyYuD0bq65VQPJyf1s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mnF71OOJB7yP03coWdyyqYNXIMAXcPS8v6xRFJNAu2GFWWKESLczvlm6U1ZdTKyKv
	 EdA1S6rBSi9gfddND20xzLymxq0EYbnxvQ/oivtLp0Yj5ZKuUln2jmCmDknjHN7xaj
	 eiS1yaCeOiNllpYelEA3PSr6uH3xMGg3YBAh/d1PsYLKCZk6842ctT5pPmjITimGwa
	 nCSKRjfPobFXoIqz+4zkhbqsV36pul+/7H+5J6GSBPzIitmdt5pIjHG+DMmkHrIB/h
	 uDLWHmnrb+AdyMPJfnVGQ+FvSNtf8QeefRod3yxKfpJxQBRwkyh67T5R8AyMQmGCj2
	 88bgwQO2WIWww==
Date: Wed, 29 Apr 2026 07:46:38 -0700
Subject: [PATCH 1/3] mount_service: delegate iomap privilege from
 mount.service to fuse services
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212657.4105892.4434339567880943002.stgit@frogsfrogsfrogs>
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

Enable the mount.service helper to attach whatever privileges it might
have to enable iomap to a /dev/fuse fd before passing that fd to the
fuse server.  Assuming that the fuse service itself does not have
sufficient privilege to enable iomap on its own, it can now inherit that
privilege via the fd.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h       |    1 +
 include/fuse_lowlevel.h     |   10 ++++++
 include/fuse_service.h      |   11 ++++++
 include/fuse_service_priv.h |   10 ++++++
 lib/fuse_lowlevel.c         |    7 ++++
 lib/fuse_service.c          |   43 +++++++++++++++++++++++++
 lib/fuse_service_stub.c     |    6 +++
 lib/fuse_versionscript      |    2 +
 util/mount_service.c        |   74 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 164 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index bee825a6d17ad5..10a82bf818d2cc 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1189,6 +1189,7 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
 #define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
+#define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 101)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index bac627bb9038c6..d09ea5ca1b8ad7 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2760,6 +2760,16 @@ uint64_t fuse_lowlevel_discover_iomap(int fd);
  */
 int fuse_lowlevel_disable_fsreclaim(struct fuse_session *se, int val);
 
+/**
+ * Request that iomap capabilities be added to this fuse device.  This enables
+ * a privileged mount helper to convey the privileges that allow iomap usage to
+ * a completely unprivileged fuse server.
+ *
+ * @param fd open file descriptor to a fuse device
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_lowlevel_add_iomap(int fd);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/fuse_service.h b/include/fuse_service.h
index f1b3fb738aec3a..5c4cd89f68459d 100644
--- a/include/fuse_service.h
+++ b/include/fuse_service.h
@@ -179,6 +179,17 @@ int fuse_service_receive_file(struct fuse_service *sf,
  */
 int fuse_service_finish_file_requests(struct fuse_service *sf);
 
+/**
+ * Attach iomap to the fuse connection.
+ *
+ * @param sf service context
+ * @param mandatory true if the server requires iomap
+ * @param error result of trying to enable iomap
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_service_configure_iomap(struct fuse_service *sf, bool mandatory,
+				 int *error);
+
 /**
  * Require that the filesystem mount point have the expected file format
  * (S_IFDIR/S_IFREG).  Can be overridden when calling
diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
index 8560b1ac610143..224ccd6e926085 100644
--- a/include/fuse_service_priv.h
+++ b/include/fuse_service_priv.h
@@ -40,6 +40,7 @@ struct fuse_service_memfd_argv {
 #define FUSE_SERVICE_UNMOUNT_CMD	0x554d4e54	/* UMNT */
 #define FUSE_SERVICE_BYE_CMD		0x42594545	/* BYEE */
 #define FUSE_SERVICE_MTABOPTS_CMD	0x4d544142	/* MTAB */
+#define FUSE_SERVICE_IOMAP_CMD		0x494f4d41	/* IOMA */
 
 /* mount.service sends replies to the fuse server */
 #define FUSE_SERVICE_OPEN_REPLY		0x46494c45	/* FILE */
@@ -116,6 +117,15 @@ static inline size_t sizeof_fuse_service_open_command(size_t pathlen)
 	return sizeof(struct fuse_service_open_command) + pathlen + 1;
 }
 
+#define FUSE_IOMAP_MODE_OPTIONAL	0x503F /* P? */
+#define FUSE_IOMAP_MODE_MANDATORY	0x5021 /* P! */
+
+struct fuse_service_iomap_command {
+	struct fuse_service_packet p;
+	uint16_t mode;
+	uint16_t padding;
+};
+
 struct fuse_service_string_command {
 	struct fuse_service_packet p;
 	char value[];
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 00eaf511aaccc0..fa8cf6f9837bed 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -5283,3 +5283,10 @@ int fuse_lowlevel_disable_fsreclaim(struct fuse_session *se, int val)
 
 	return ret ? -errno : 0;
 }
+
+int fuse_lowlevel_add_iomap(int fd)
+{
+	int ret = ioctl(fd, FUSE_DEV_IOC_ADD_IOMAP);
+
+	return ret ? -errno : 0;
+}
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index e860d1aafbe5e5..2193b997583e3f 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -1251,3 +1251,46 @@ uint64_t fuse_service_discover_iomap(struct fuse_service *sf)
 {
 	return fuse_lowlevel_discover_iomap(sf->fusedevfd);
 }
+
+int fuse_service_configure_iomap(struct fuse_service *sf, bool mandatory,
+				 int *errorp)
+{
+	struct fuse_service_iomap_command cmd = {
+		.p.magic = ntohl(FUSE_SERVICE_IOMAP_CMD),
+		.mode = mandatory ? ntohs(FUSE_IOMAP_MODE_MANDATORY) :
+				    ntohs(FUSE_IOMAP_MODE_OPTIONAL),
+	};
+	struct fuse_service_simple_reply reply = { };
+	ssize_t size;
+
+	size = __send_packet(sf, &cmd, sizeof(cmd));
+	if (size < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: send iomap command: %s\n",
+			 strerror(error));
+		return -error;
+	}
+
+	size = __recv_packet(sf, &reply, sizeof(reply));
+	if (size < 0) {
+		int error = errno;
+
+		fuse_log(FUSE_LOG_ERR, "fuse: iomap command reply: %s\n",
+			 strerror(error));
+		return -error;
+	}
+	if (size != sizeof(reply)) {
+		fuse_log(FUSE_LOG_ERR, "fuse: wrong iomap command reply size %zd, expected %zd\n",
+			 size, sizeof(reply));
+		return -EBADMSG;
+	}
+
+	if (ntohl(reply.p.magic) != FUSE_SERVICE_SIMPLE_REPLY) {
+		fuse_log(FUSE_LOG_ERR, "fuse: iomap command reply contains wrong magic!\n");
+		return -EBADMSG;
+	}
+
+	*errorp = ntohl(reply.error);
+	return 0;
+}
diff --git a/lib/fuse_service_stub.c b/lib/fuse_service_stub.c
index 2cafde6d6b6f5d..84eed8482f7d2b 100644
--- a/lib/fuse_service_stub.c
+++ b/lib/fuse_service_stub.c
@@ -109,3 +109,9 @@ uint64_t fuse_service_discover_iomap(struct fuse_service *sf)
 {
 	return 0;
 }
+
+int fuse_service_configure_iomap(struct fuse_service *sf, bool mandatory,
+				 int *error)
+{
+	return -EOPNOTSUPP;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index b2357623a49ce6..347aad1c1c8b1d 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -269,6 +269,8 @@ FUSE_3.99 {
 		fuse_fs_iomap_device_invalidate;
 		fuse_lowlevel_disable_fsreclaim;
 		fuse_loopdev_setup;
+		fuse_lowlevel_add_iomap;
+		fuse_service_configure_iomap;
 } FUSE_3.19;
 
 # Local Variables:
diff --git a/util/mount_service.c b/util/mount_service.c
index bc5940bc900dad..c50eb3125f8ef1 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -88,6 +88,9 @@ struct mount_service {
 
 	/* is this a fuseblk mount? */
 	bool fuseblk;
+
+	/* did someone try to configure iomap already? */
+	bool iomap_configured;
 };
 
 static char IGNORE_MTAB;
@@ -586,6 +589,23 @@ static int mount_service_send_file_error(struct mount_service *mo, int error,
 	return ret;
 }
 
+static int mount_service_config_iomap(struct mount_service *mo,
+				      bool mandatory)
+{
+	int ret;
+
+	mo->iomap_configured = true;
+
+	ret = fuse_lowlevel_add_iomap(mo->fusedevfd);
+	if (ret && mandatory) {
+		fprintf(stderr, "%s: adding iomap capability: %s\n",
+			mo->msgtag, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
 static int mount_service_send_required_files(struct mount_service *mo,
 					     const char *fusedev)
 {
@@ -1354,6 +1374,50 @@ static int mount_service_handle_mountpoint_cmd(struct mount_service *mo,
 	return attach_to_mountpoint(mo, expected_fmt, mntpt);
 }
 
+static int mount_service_handle_iomap_cmd(struct mount_service *mo,
+					  struct fuse_service_packet *p,
+					  size_t psz)
+{
+	struct fuse_service_iomap_command *oc =
+			container_of(p, struct fuse_service_iomap_command, p);
+	bool mandatory = false;
+	int ret;
+
+	if (psz != sizeof(struct fuse_service_iomap_command)) {
+		fprintf(stderr, "%s: iomap command wrong size\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	if (oc->padding) {
+		fprintf(stderr, "%s: invalid iomap command\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	switch (ntohs(oc->mode)) {
+	case FUSE_IOMAP_MODE_MANDATORY:
+		mandatory = true;
+		fallthrough;
+	case FUSE_IOMAP_MODE_OPTIONAL:
+		ret = mount_service_config_iomap(mo, mandatory);
+		if (ret < 0) {
+			/*
+			 * Ok to return 0 here, fuse servers can fall back
+			 * if there's no iomap support.
+			 */
+			return mount_service_send_reply(mo, EPERM);
+		}
+		break;
+	default:
+		fprintf(stderr, "%s: invalid iomap command mode\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
 static inline int format_libfuse_mntopts(char *buf, size_t bufsz,
 					 const struct mount_service *mo,
 					 const struct stat *stbuf)
@@ -1839,6 +1903,13 @@ static int mount_service_handle_mount_cmd(struct mount_service *mo,
 			return mount_service_send_reply(mo, -ret);
 	}
 
+	/*
+	 * If nobody tried to configure iomap, try to enable it but don't
+	 * fail if we can't.
+	 */
+	if (!mo->iomap_configured)
+		mount_service_config_iomap(mo, false);
+
 	if (mo->fsopenfd >= 0) {
 		ret = mount_service_fsopen_mount(mo, oc, &stbuf);
 		if (ret != FUSE_MOUNT_FALLBACK_NEEDED)
@@ -2037,6 +2108,9 @@ int mount_service_main(int argc, char *argv[])
 		case FUSE_SERVICE_MTABOPTS_CMD:
 			ret = mount_service_handle_mtabopts_cmd(&mo, p, sz);
 			break;
+		case FUSE_SERVICE_IOMAP_CMD:
+			ret = mount_service_handle_iomap_cmd(&mo, p, sz);
+			break;
 		case FUSE_SERVICE_MOUNT_CMD:
 			ret = mount_service_handle_mount_cmd(&mo, p, sz);
 			break;

