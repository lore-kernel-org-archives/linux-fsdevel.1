Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F12D541B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574750; cv=none; b=g+WtXMM9Pli4E/UJi+csV7gmXW+vheFzdVW+ATa2LIPKUyNWCIG92npcqlEVvWoTWudoHn9aRvOeCb7X4pzZ3gmymz7RAzAcAEcuYjE9RbnSkGdlvc94JxQK+lytEDOkKZoTS+VxTpFcS7rF7j7xEleHvB+sPRo9i8Fk3aOC1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574750; c=relaxed/simple;
	bh=Nj/OewFDC2gb4QBCvHSd8j5eji8tkewoGnUUpLg2AEY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STghVvzneIkRJotL16Ne0epiGOgQDqTTw8XKSfd6tQWf8ragliQV0T/E4BiIVxeVLJmEf7RWdyF0/YEf2cgnoQFEai88trQ+kXu5rySy2MudpG64X3PvOyhiuG1xtNe+CwURxkjwZcmPFbPvfrj+hHqeT8IL0xWMJztNax7DTk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpH6a63X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpH6a63X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76686C116C6;
	Fri, 27 Mar 2026 01:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574749;
	bh=Nj/OewFDC2gb4QBCvHSd8j5eji8tkewoGnUUpLg2AEY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XpH6a63XbNo/wQUX/aQcQzWfrY0lTlFz58ThgGVXfBSce/QEazTl+g9Kux+ax/wQL
	 z6HGDmRPhGuPEHA7ovfE3N5SloCssBJSnEg0uYqEFqg4hax8QHN+2YFVgiH69Ybmd0
	 rRzTg6kfTA4ix/MAnYm3Fkl3fmcBqsw3bl/gnWeOBh02dzUcfvVRTLCr6rAVq4Kz7d
	 BxXTx/hYddhdPHhYFbrWcpXdfx2QsedCqnuw2EjNw9bzn8CRNyVIm+61zni/vnRZFT
	 GtTeRtM/kOtw5VUwnT2Ud12klz9oGtZzYGNGhU1BybIqt13I1X6ta5KE0bYmdsUgA4
	 DYDrC7Sh5qkYw==
Date: Thu, 26 Mar 2026 18:25:49 -0700
Subject: [PATCH 04/17] mount_service: use the new mount api for the mount
 service
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463189.1008428.16697718096512582220.stgit@frogsfrogsfrogs>
In-Reply-To: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use the new fsopen/fsmount system calls to mount the filesystem so that
we get somewhat better diagnostics if something gets screwed up.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 meson.build          |   15 +++
 util/mount_service.c |  299 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 314 insertions(+)


diff --git a/meson.build b/meson.build
index d6ba8740effd5c..b0988548bf806a 100644
--- a/meson.build
+++ b/meson.build
@@ -130,6 +130,21 @@ special_funcs = {
 	int main(int argc, char *argv[]) {
           return SD_LISTEN_FDS_START;
 	}
+    ''',
+    'new_mount_api': '''
+       #define _GNU_SOURCE
+       #include <sys/mount.h>
+       #include <linux/mount.h>
+       #include <unistd.h>
+       #include <fcntl.h>
+
+       int main(void) {
+           int fsfd = fsopen("fuse", FSOPEN_CLOEXEC);
+           int res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0);
+           int mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+           res = move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
+           return 0;
+       }
     '''
 }
 
diff --git a/util/mount_service.c b/util/mount_service.c
index ae078e537dc560..4a2c1111b66b91 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -65,6 +65,9 @@ struct mount_service {
 
 	/* O_PATH fd for mount point */
 	int mountfd;
+
+	/* fd for fsopen */
+	int fsopenfd;
 };
 
 /* Filter out the subtype of the filesystem (e.g. fuse.Y -> Y) */
@@ -87,6 +90,7 @@ static int mount_service_init(struct mount_service *mo, int argc, char *argv[])
 	mo->argvfd = -1;
 	mo->fusedevfd = -1;
 	mo->mountfd = -1;
+	mo->fsopenfd = -1;
 
 	for (i = 0; i < argc; i++) {
 		if (!strcmp(argv[i], "-t") && i + 1 < argc) {
@@ -690,9 +694,50 @@ static int mount_service_handle_fsopen_cmd(struct mount_service *mo,
 		return mount_service_send_reply(mo, error);
 	}
 
+#ifdef HAVE_NEW_MOUNT_API
+	/* If this fails we fall back on mount() */
+	mo->fsopenfd = fsopen(oc->value, FSOPEN_CLOEXEC);
+#endif
+
 	return mount_service_send_reply(mo, 0);
 }
 
+#ifdef HAVE_NEW_MOUNT_API
+/* callers must preserve errno */
+static void emit_fsconfig_messages(const struct mount_service *mo)
+{
+	uint8_t buf[BUFSIZ];
+	ssize_t sz;
+
+	while ((sz = read(mo->fsopenfd, buf, sizeof(buf) - 1)) != -1) {
+		if (sz <= 0)
+			continue;
+		if (buf[sz - 1] == '\n')
+			buf[--sz] = '\0';
+		else
+			buf[sz] = '\0';
+
+		if (!*buf)
+			continue;
+
+		switch (buf[0]) {
+		case 'e':
+			fprintf(stderr, "Error: %s\n", buf + 2);
+			break;
+		case 'w':
+			fprintf(stderr, "Warning: %s\n", buf + 2);
+			break;
+		case 'i':
+			fprintf(stderr, "Info: %s\n", buf + 2);
+			break;
+		default:
+			fprintf(stderr, " %s\n", buf);
+			break;
+		}
+	}
+}
+#endif
+
 static int mount_service_handle_source_cmd(struct mount_service *mo,
 					   const struct fuse_service_packet *p)
 {
@@ -714,6 +759,21 @@ static int mount_service_handle_source_cmd(struct mount_service *mo,
 		return mount_service_send_reply(mo, error);
 	}
 
+#ifdef HAVE_NEW_MOUNT_API
+	if (mo->fsopenfd >= 0) {
+		int ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "source",
+			       oc->value, 0);
+		if (ret) {
+			int error = errno;
+
+			fprintf(stderr, "%s: fsconfig source: %s\n",
+				mo->msgtag, strerror(error));
+			emit_fsconfig_messages(mo);
+			return mount_service_send_reply(mo, error);
+		}
+	}
+#endif
+
 	return mount_service_send_reply(mo, 0);
 }
 
@@ -722,6 +782,8 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
 {
 	struct fuse_service_string_command *oc =
 			container_of(p, struct fuse_service_string_command, p);
+	char *tokstr = oc->value;
+	char *tok, *savetok;
 
 	if (mo->mntopts) {
 		fprintf(stderr, "%s: mount options respecified!\n",
@@ -738,6 +800,45 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
 		return mount_service_send_reply(mo, error);
 	}
 
+	/* strtok_r mutates tokstr aka oc->value */
+	while ((tok = strtok_r(tokstr, ",", &savetok)) != NULL) {
+		char *equals = strchr(tok, '=');
+		char oldchar = 0;
+
+		if (equals) {
+			oldchar = *equals;
+			*equals = 0;
+		}
+
+#ifdef HAVE_NEW_MOUNT_API
+		if (mo->fsopenfd >= 0) {
+			int ret;
+
+			if (equals)
+				ret = fsconfig(mo->fsopenfd,
+					       FSCONFIG_SET_STRING, tok,
+					       equals + 1, 0);
+			else
+				ret = fsconfig(mo->fsopenfd,
+					       FSCONFIG_SET_FLAG, tok,
+					       NULL, 0);
+			if (ret) {
+				int error = errno;
+
+				fprintf(stderr, "%s: set mount option: %s\n",
+					mo->msgtag, strerror(error));
+				emit_fsconfig_messages(mo);
+				return mount_service_send_reply(mo, error);
+			}
+		}
+#endif
+
+		if (equals)
+			*equals = oldchar;
+
+		tokstr = NULL;
+	}
+
 	return mount_service_send_reply(mo, 0);
 }
 
@@ -875,6 +976,196 @@ static int mount_service_regular_mount(struct mount_service *mo,
 	return mount_service_send_reply(mo, 0);
 }
 
+#ifdef HAVE_NEW_MOUNT_API
+struct ms_to_mount_map {
+	unsigned long ms_flag;
+	unsigned int mount_attr_flag;
+};
+
+static const struct ms_to_mount_map attrs[] = {
+	{ MS_RDONLY,		MOUNT_ATTR_RDONLY },
+	{ MS_NOSUID,		MOUNT_ATTR_NOSUID },
+	{ MS_NODEV,		MOUNT_ATTR_NODEV },
+	{ MS_NOEXEC,		MOUNT_ATTR_NOEXEC },
+	{ MS_RELATIME,		MOUNT_ATTR_RELATIME },
+	{ MS_NOATIME,		MOUNT_ATTR_NOATIME },
+	{ MS_STRICTATIME,	MOUNT_ATTR_STRICTATIME },
+	{ MS_NODIRATIME,	MOUNT_ATTR_NODIRATIME },
+#ifdef MOUNT_ATTR_NOSYMFOLLOW
+	{ MS_NOSYMFOLLOW,	MOUNT_ATTR_NOSYMFOLLOW },
+#endif
+	{ 0, 0 },
+};
+
+static void get_mount_attr_flags(const struct fuse_service_mount_command *oc,
+				 unsigned int *attr_flags,
+				 unsigned long *leftover_ms_flags)
+{
+	const struct ms_to_mount_map *i;
+	unsigned int ms_flags = ntohl(oc->ms_flags);
+	unsigned int mount_attr_flags = 0;
+
+	for (i = attrs; i->ms_flag != 0; i++) {
+		if (ms_flags & i->ms_flag)
+			mount_attr_flags |= i->mount_attr_flag;
+		ms_flags &= ~i->ms_flag;
+	}
+
+	*leftover_ms_flags = ms_flags;
+	*attr_flags = mount_attr_flags;
+}
+
+struct ms_to_str_map {
+	unsigned long ms_flag;
+	const char *string;
+};
+
+static const struct ms_to_str_map strflags[] = {
+	{ MS_SYNCHRONOUS,	"sync" },
+	{ MS_DIRSYNC,		"dirsync" },
+	{ MS_LAZYTIME,		"lazytime" },
+	{ 0, 0 },
+};
+
+static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
+{
+	const struct ms_to_str_map *i;
+	int ret;
+
+	for (i = strflags; i->ms_flag != 0; i++) {
+		if (!(ms_flags & i->ms_flag))
+			continue;
+
+		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
+			       NULL, 0);
+		if (ret) {
+			int error = errno;
+
+			fprintf(stderr, "%s: set %s option: %s\n",
+				mo->msgtag, i->string, strerror(error));
+			emit_fsconfig_messages(mo);
+
+			errno = error;
+			return -1;
+		}
+		ms_flags &= ~i->ms_flag;
+	}
+
+	/*
+	 * We can't translate all the supplied MS_ flags into MOUNT_ATTR_ flags
+	 * or string flags!  Return a magic code so the caller will fall back
+	 * to regular mount(2).
+	 */
+	return ms_flags ? -2 : 0;
+}
+
+static int mount_service_fsopen_mount(struct mount_service *mo,
+				      struct fuse_service_mount_command *oc,
+				      struct stat *stbuf)
+{
+	char tmp[64];
+	char *dot;
+	unsigned long ms_flags;
+	unsigned int attr_flags;
+	int mfd;
+	int error;
+	int ret;
+
+	get_mount_attr_flags(oc, &attr_flags, &ms_flags);
+
+	ret = set_ms_flags(mo, ms_flags);
+	if (ret == -2)
+		return ret;
+	if (ret) {
+		error = errno;
+		goto fail_mount;
+	}
+
+	snprintf(tmp, sizeof(tmp), "%i", mo->fusedevfd);
+	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "fd", tmp, 0);
+	if (ret) {
+		error = errno;
+		fprintf(stderr, "%s: set fd option: %s\n",
+			mo->msgtag, strerror(error));
+		goto fail_fsconfig;
+	}
+
+	snprintf(tmp, sizeof(tmp), "%o", stbuf->st_mode & S_IFMT);
+	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "rootmode", tmp, 0);
+	if (ret) {
+		error = errno;
+		fprintf(stderr, "%s: set rootmode option: %s\n",
+			mo->msgtag, strerror(error));
+		goto fail_fsconfig;
+	}
+
+	snprintf(tmp, sizeof(tmp), "%u", getuid());
+	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "user_id", tmp, 0);
+	if (ret) {
+		error = errno;
+		fprintf(stderr, "%s: set user_id option: %s\n",
+			mo->msgtag, strerror(error));
+		goto fail_fsconfig;
+	}
+
+	snprintf(tmp, sizeof(tmp), "%u", getgid());
+	ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "group_id", tmp, 0);
+	if (ret) {
+		error = errno;
+		fprintf(stderr, "%s: set group_id option: %s\n",
+			mo->msgtag, strerror(error));
+		goto fail_fsconfig;
+	}
+
+	dot = strchr(mo->fstype, '.');
+	if (dot) {
+		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "subtype",
+			       dot + 1, 0);
+		if (ret) {
+			error = errno;
+			fprintf(stderr, "%s: set subtype option: %s\n",
+				mo->msgtag, strerror(error));
+			goto fail_fsconfig;
+		}
+	}
+
+	ret = fsconfig(mo->fsopenfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	if (ret) {
+		error = errno;
+		fprintf(stderr, "%s: creating filesystem: %s\n",
+			mo->msgtag, strerror(error));
+		goto fail_fsconfig;
+	}
+
+	mfd = fsmount(mo->fsopenfd, FSMOUNT_CLOEXEC, attr_flags);
+	if (mfd < 0) {
+		error = errno;
+		fprintf(stderr, "%s: fsmount: %s\n",
+			mo->msgtag, strerror(error));
+		goto fail_fsconfig;
+	}
+
+	ret = move_mount(mfd, "", mo->mountfd, "",
+			 MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH);
+	close(mfd);
+	if (ret) {
+		error = errno;
+		fprintf(stderr, "%s: move_mount: %s\n",
+			mo->msgtag, strerror(error));
+		goto fail_mount;
+	}
+
+	return mount_service_send_reply(mo, 0);
+
+fail_fsconfig:
+	emit_fsconfig_messages(mo);
+fail_mount:
+	return mount_service_send_reply(mo, error);
+}
+#else
+# define mount_service_fsopen_mount(...)	(-2)
+#endif
+
 static int mount_service_handle_mount_cmd(struct mount_service *mo,
 					  struct fuse_service_packet *p)
 {
@@ -949,6 +1240,12 @@ static int mount_service_handle_mount_cmd(struct mount_service *mo,
 		return mount_service_send_reply(mo, EINVAL);
 	}
 
+	if (mo->fsopenfd >= 0) {
+		ret = mount_service_fsopen_mount(mo, oc, &stbuf);
+		if (ret != -2)
+			return ret;
+	}
+
 	return mount_service_regular_mount(mo, oc, &stbuf);
 }
 
@@ -971,6 +1268,7 @@ static void mount_service_destroy(struct mount_service *mo)
 	close(mo->mountfd);
 	close(mo->fusedevfd);
 	close(mo->argvfd);
+	close(mo->fsopenfd);
 	shutdown(mo->sockfd, SHUT_RDWR);
 	close(mo->sockfd);
 
@@ -984,6 +1282,7 @@ static void mount_service_destroy(struct mount_service *mo)
 	mo->argvfd = -1;
 	mo->fusedevfd = -1;
 	mo->mountfd = -1;
+	mo->fsopenfd = -1;
 }
 
 int mount_service_main(int argc, char *argv[])

