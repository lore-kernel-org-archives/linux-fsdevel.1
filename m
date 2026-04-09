Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518638AC80
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773312; cv=none; b=Uv6vSaroU7EisKy19aR/HwxAyxCE22tR8jQnGUS6bGNqIectbsAKQjkCXb6i+GzBnqBxyMcqu7shp8j4d6N9l5XYmjiY5Vj/3MJ5jIJKEDWR8HbbzCiCltOwrM+ZIEFUPe6oxCZ0Zf/aaqe9kZBc4lpoCsi38R5SQenDj/yI5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773312; c=relaxed/simple;
	bh=u+bkHwcl5SYaJRBOggjOoxuzAIAEvWlVTrldUHoi4ls=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSkS9eBMSFHiEbFTNwtLytlATZUGBZ3Vp+/X7AhFSP7Xj1/GpG3uAy5N80eLPJf8SRumfbDP+MunOdla+LC4NQWlKoIhavOK9fxwe6w3A+AF2agXEudQBpooRF7Hi48ZWBBY/xRijzBee6xBK593Bb1inqyhAilKBgRVWDvodNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXKgm3/F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXKgm3/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5DBC2BCB0;
	Thu,  9 Apr 2026 22:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775773311;
	bh=u+bkHwcl5SYaJRBOggjOoxuzAIAEvWlVTrldUHoi4ls=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gXKgm3/FtTXyARXPjqrxrdSWbfI07GiC6dXxVQSYut588UQQCnqX1veTpMsHI1z+e
	 g8NDhAQ2VshnRed2qLnhhTo9m9yJeJ1lRx48yYtLr11b3Gvtv7FTjlCryCeHkIUsJ3
	 nQ4rF2ymrJ8wFUg+EnG8X3hRnaRTzKO8I24rxUMCQf+WBw/+f6cjPWDUfxkjO21Djy
	 8i4DTaaFwYJ76mka8SyEPrk3S/DiJCNYDCyrQFbHwixjBC8Esc7v5u62lVqONIwoyT
	 +X/p/sYsxpdedO7cD/DVmTv4rw8eNnGT3oDnxIOP16/a4hlLH//4Aig6+kefjZ7BNr
	 K5dy6pCHlPhJg==
Date: Thu, 09 Apr 2026 15:21:51 -0700
Subject: [PATCH 05/13] mount_service: update mtab after a successful mount
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <177577270306.2064074.8848839758665868233.stgit@frogsfrogsfrogs>
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
 lib/fuse_service.c          |   15 ++++++++++
 lib/mount.c                 |    7 ++++
 util/mount_service.c        |   67 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+)


diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
index 8df871ee117875..d9149379a5b65f 100644
--- a/include/fuse_service_priv.h
+++ b/include/fuse_service_priv.h
@@ -37,6 +37,7 @@ struct fuse_service_memfd_argv {
 #define FUSE_SERVICE_MOUNT_CMD		0x444f4954	/* DOIT */
 #define FUSE_SERVICE_UNMOUNT_CMD	0x554d4e54	/* UMNT */
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
index b775727e7c91e2..b6044f788ed0d3 100644
--- a/lib/fuse_service.c
+++ b/lib/fuse_service.c
@@ -853,6 +853,7 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
 	char *fstype = fuse_mnt_build_type(se->mo);
 	char *source = fuse_mnt_build_source(se->mo);
 	char *mntopts = fuse_mnt_kernel_opts(se->mo);
+	char *mtabopts = fuse_mnt_mtab_opts(se->mo);
 	char path[32];
 	int ret;
 	int error;
@@ -920,6 +921,19 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
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
@@ -938,6 +952,7 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
 	opts->foreground = 1;
 
 out_strings:
+	free(mtabopts);
 	free(mntopts);
 	free(source);
 	free(fstype);
diff --git a/lib/mount.c b/lib/mount.c
index 952d8899dcf218..84c73579ab2daf 100644
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
index 246a95101e8d34..8e9c721a56fd2a 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -59,6 +59,9 @@ struct mount_service {
 	/* mount options */
 	char *mntopts;
 
+	/* mtab options */
+	char *mtabopts;
+
 	/* socket fd */
 	int sockfd;
 
@@ -937,6 +940,43 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
 	return mount_service_send_reply(mo, 0);
 }
 
+static int mount_service_handle_mtabopts_cmd(struct mount_service *mo,
+					     const struct fuse_service_packet *p,
+					     size_t psz)
+{
+	struct fuse_service_string_command *oc =
+			container_of(p, struct fuse_service_string_command, p);
+
+	if (psz < sizeof_fuse_service_string_command(1)) {
+		fprintf(stderr, "%s: mtab options command too small\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
+
+	if (!check_null_endbyte(p, psz)) {
+		fprintf(stderr, "%s: mtab options command must be null terminated\n",
+			mo->msgtag);
+		return mount_service_send_reply(mo, EINVAL);
+	}
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
 static int attach_to_mountpoint(struct mount_service *mo, char *mntpt)
 {
 	struct stat statbuf;
@@ -1140,6 +1180,14 @@ static int mount_service_regular_mount(struct mount_service *mo,
 		return mount_service_send_reply(mo, error);
 	}
 
+	/*
+	 * The mount succeeded, so we send a positive reply even if the mtab
+	 * update fails.
+	 */
+	if (mo->mtabopts)
+		fuse_mnt_add_mount(mo->msgtag, mo->source, mo->resv_mountpoint,
+				   mo->fstype, mo->mtabopts);
+
 	mo->mounted = true;
 	return mount_service_send_reply(mo, 0);
 }
@@ -1331,6 +1379,14 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
 		goto fail_mount;
 	}
 
+	/*
+	 * The mount succeeded, so we send a positive reply even if the mtab
+	 * update fails.
+	 */
+	if (mo->mtabopts)
+		fuse_mnt_add_mount(mo->msgtag, mo->source, mo->resv_mountpoint,
+				   mo->fstype, mo->mtabopts);
+
 	mo->mounted = true;
 	return mount_service_send_reply(mo, 0);
 
@@ -1469,6 +1525,13 @@ static int mount_service_handle_unmount_cmd(struct mount_service *mo,
 		return mount_service_send_reply(mo, error);
 	}
 
+	/*
+	 * The unmount succeeded, so we send a positive reply even if the mtab
+	 * update fails.
+	 */
+	if (mo->mtabopts)
+		fuse_mnt_remove_mount(mo->msgtag, mo->resv_mountpoint);
+
 	mo->mounted = false;
 	return mount_service_send_reply(mo, 0);
 }
@@ -1508,6 +1571,7 @@ static void mount_service_destroy(struct mount_service *mo)
 	free(mo->mountpoint);
 	free(mo->real_mountpoint);
 	free(mo->resv_mountpoint);
+	free(mo->mtabopts);
 	free(mo->mntopts);
 	free(mo->fstype);
 
@@ -1596,6 +1660,9 @@ int mount_service_main(int argc, char *argv[])
 		case FUSE_SERVICE_MNTPT_CMD:
 			ret = mount_service_handle_mountpoint_cmd(&mo, p, sz);
 			break;
+		case FUSE_SERVICE_MTABOPTS_CMD:
+			ret = mount_service_handle_mtabopts_cmd(&mo, p, sz);
+			break;
 		case FUSE_SERVICE_MOUNT_CMD:
 			ret = mount_service_handle_mount_cmd(&mo, p, sz);
 			break;

