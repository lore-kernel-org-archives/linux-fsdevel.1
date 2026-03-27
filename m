Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2A2D541B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574765; cv=none; b=ec+ytcb0uY7obxX9obZvd12YuFk6DI+vzxhvjK3X/d/U0YIaRdIYzhbtFXGIsVLrL8nPhk5fwxnvl03KQqaqjFDQnBc0adtnsPAw3W6XXBqNZR+JbdJNOWVMm9ZmMdgeZ8IPrqDIA4NPPxa6q+ljEMXgsdZP7WTjWNJBdfXrWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574765; c=relaxed/simple;
	bh=lDX7i0JdWqWhQknUexzO2LNZAwu3XTGf125quCymX1E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFNvYqnsBcQycatBJ9LBYtUuZcaU+dPA3WR6GZU+w5VhwtDrFtQQwMC6MZQrys7tyW6tynFn3Qu/yrkibTz6TINSKp1GD05SWVruZrrxl+rskO7czqWxFkjPhYDB03yfVAzvIYyHMfc1sfGzrM/7vZE8FIDK0fjgzZKpW036NIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcGTxIGq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcGTxIGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26582C116C6;
	Fri, 27 Mar 2026 01:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574765;
	bh=lDX7i0JdWqWhQknUexzO2LNZAwu3XTGf125quCymX1E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VcGTxIGqAWeiHE2ftImJsysaWOqY88oOtrWjJ7Zi3SDKWDXc5D7wFi9+AsBVmif6n
	 jaSVmLpLm5cC6qwDefk3+NiD314KNN1xmoiXyuEXRHGgXApa8udd5LZZk4j0la72dD
	 iGNougDVJ2f/XcKX6c2kd+yVYt/2fiBQGJigfcl9x9hm/TEV9MvLhIUX5/fdfqeuNz
	 AMNk3YFzp22cUFOGDqinNek8jp32ly+zCx9WbhcJwn7GDVlKymJk7mEspKz0A047u/
	 hzk+EbaqFPm8ljAOvo555AhNXru6NqFHFeou7QcuVEJYPMk1E04pGkIcdjsUm9oMYg
	 uMae0RvdJ8eKw==
Date: Thu, 26 Mar 2026 18:26:04 -0700
Subject: [PATCH 05/17] mount_service: update mtab after a successful mount
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463206.1008428.3710251281230290878.stgit@frogsfrogsfrogs>
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

Update "mtab" so that non-kernel mount options (e.g. "x-fubar=XXX") are
recorded somewhere so that userspace utilities can pick that up.  Note
that this likely is not the venerable /etc/mtab, which has been a
symlink to procfs for years.  On a modern system, these non-kernel
options end up /run/mount/utab.

But that's not a detail that libfuse has to worry about directly; it's
really just calling mount -f(ake) to make the changes it wants.  Old
hats may remember the use of mount -f to update /etc/mtab after mounting
the root filesystem.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_service_priv.h |    1 +
 lib/mount_common_i.h        |    1 +
 lib/fuse_service.c          |   15 ++++++++++++++
 lib/mount.c                 |    7 ++++++
 util/mount_service.c        |   47 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+)


diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
index d1fdd6221b5268..17002249d6a02e 100644
--- a/include/fuse_service_priv.h
+++ b/include/fuse_service_priv.h
@@ -36,6 +36,7 @@ struct fuse_service_memfd_argv {
 #define FUSE_SERVICE_MNTPT_CMD		0x4d4e5450	/* MNTP */
 #define FUSE_SERVICE_MOUNT_CMD		0x444f4954	/* DOIT */
 #define FUSE_SERVICE_BYE_CMD		0x42594545	/* BYEE */
+#define FUSE_SERVICE_MTABOPTS_CMD	0x4d544142	/* MTAB */
 
 /* mount.service sends replies to the fuse server */
 #define FUSE_SERVICE_OPEN_REPLY		0x46494c45	/* FILE */
diff --git a/lib/mount_common_i.h b/lib/mount_common_i.h
index 631dff3e6f8aaf..541cdebae4f47a 100644
--- a/lib/mount_common_i.h
+++ b/lib/mount_common_i.h
@@ -15,6 +15,7 @@ struct mount_opts;
 char *fuse_mnt_build_source(const struct mount_opts *mo);
 char *fuse_mnt_build_type(const struct mount_opts *mo);
 char *fuse_mnt_kernel_opts(const struct mount_opts *mo);
+char *fuse_mnt_mtab_opts(const struct mount_opts *mo);
 unsigned int fuse_mnt_flags(const struct mount_opts *mo);
 
 
diff --git a/lib/fuse_service.c b/lib/fuse_service.c
index 795453693da09b..8076a8b2737574 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -804,6 +804,7 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
 	char *fstype = fuse_mnt_build_type(se->mo);
 	char *source = fuse_mnt_build_source(se->mo);
 	char *mntopts = fuse_mnt_kernel_opts(se->mo);
+	char *mtabopts = fuse_mnt_mtab_opts(se->mo);
 	char path[32];
 	int ret;
 	int error;
@@ -871,6 +872,19 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
 		}
 	}
 
+	if (mtabopts) {
+		ret = send_string(sf, FUSE_SERVICE_MTABOPTS_CMD, mtabopts,
+				  &error);
+		if (ret)
+			goto out_strings;
+		if (error) {
+			fuse_log(FUSE_LOG_ERR, "fuse: service fs mtab options: %s\n",
+				 strerror(error));
+			ret = -error;
+			goto out_strings;
+		}
+	}
+
 	ret = send_mount(sf, fuse_mnt_flags(se->mo), expected_fmt, &error);
 	if (ret)
 		goto out_strings;
@@ -889,6 +903,7 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
 	opts->foreground = 1;
 
 out_strings:
+	free(mtabopts);
 	free(mntopts);
 	free(source);
 	free(fstype);
diff --git a/lib/mount.c b/lib/mount.c
index 2018172ae570f0..ce8f58450827ce 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -758,6 +758,13 @@ char *fuse_mnt_kernel_opts(const struct mount_opts *mo)
 	return NULL;
 }
 
+char *fuse_mnt_mtab_opts(const struct mount_opts *mo)
+{
+	if (mo->mtab_opts)
+		return strdup(mo->mtab_opts);
+	return NULL;
+}
+
 unsigned int fuse_mnt_flags(const struct mount_opts *mo)
 {
 	return mo->flags;
diff --git a/util/mount_service.c b/util/mount_service.c
index 4a2c1111b66b91..2e541f67277ee5 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -54,6 +54,9 @@ struct mount_service {
 	/* mount options */
 	char *mntopts;
 
+	/* mtab options */
+	char *mtabopts;
+
 	/* socket fd */
 	int sockfd;
 
@@ -842,6 +845,30 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
 	return mount_service_send_reply(mo, 0);
 }
 
+static int mount_service_handle_mtabopts_cmd(struct mount_service *mo,
+					     const struct fuse_service_packet *p)
+{
+	struct fuse_service_string_command *oc =
+			container_of(p, struct fuse_service_string_command, p);
+
+	if (mo->mtabopts) {
+		fprintf(stderr, "%s: mtab options respecified!\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	mo->mtabopts = strdup(oc->value);
+	if (!mo->mtabopts) {
+		int error = errno;
+
+		fprintf(stderr, "%s: alloc mtab options string: %s\n",
+			mo->msgtag, strerror(error));
+		return mount_service_send_reply(mo, error);
+	}
+
+	return mount_service_send_reply(mo, 0);
+}
+
 static int mount_service_handle_mountpoint_cmd(struct mount_service *mo,
 					       const struct fuse_service_packet *p)
 {
@@ -973,6 +1000,14 @@ static int mount_service_regular_mount(struct mount_service *mo,
 		return mount_service_send_reply(mo, error);
 	}
 
+	/*
+	 * The mount succeeded, so we send a positive reply even if the mtab
+	 * update fails.
+	 */
+	if (mo->mtabopts)
+		fuse_mnt_add_mount(mo->msgtag, mo->source, mo->mountpoint,
+				   mo->fstype, mo->mtabopts);
+
 	return mount_service_send_reply(mo, 0);
 }
 
@@ -1155,6 +1190,14 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
 		goto fail_mount;
 	}
 
+	/*
+	 * The mount succeeded, so we send a positive reply even if the mtab
+	 * update fails.
+	 */
+	if (mo->mtabopts)
+		fuse_mnt_add_mount(mo->msgtag, mo->source, mo->mountpoint,
+				   mo->fstype, mo->mtabopts);
+
 	return mount_service_send_reply(mo, 0);
 
 fail_fsconfig:
@@ -1274,6 +1317,7 @@ static void mount_service_destroy(struct mount_service *mo)
 
 	free(mo->source);
 	free(mo->mountpoint);
+	free(mo->mtabopts);
 	free(mo->mntopts);
 	free(mo->fstype);
 
@@ -1359,6 +1403,9 @@ int mount_service_main(int argc, char *argv[])
 		case FUSE_SERVICE_MNTPT_CMD:
 			ret = mount_service_handle_mountpoint_cmd(&mo, p);
 			break;
+		case FUSE_SERVICE_MTABOPTS_CMD:
+			ret = mount_service_handle_mtabopts_cmd(&mo, p);
+			break;
 		case FUSE_SERVICE_MOUNT_CMD:
 			ret = mount_service_handle_mount_cmd(&mo, p);
 			break;

