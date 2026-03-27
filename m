Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1DE2FF170
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574859; cv=none; b=s6TGyFhcrBP2H2NACjB0oZ2WNbjz8AV3idjPrsO0rWi3Sf+H77HGKVlTtUJU9uDaW+H2ZYAlVxAnMNdLE4QpBGCBt6DVXYiqiy0AgHCTWmaYC859UH4YFDIl4WaeNGC2ERXW1VGU8Yxh75z3LkQ4yii1u0vykNp61xM4YlHubJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574859; c=relaxed/simple;
	bh=vMbvgp0mtiihPPzf5blBH9tIuvs6M9GGEXUIy85lD2Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjY2g9GfNyjYaym1aGAJQ6HhQzYieNTvqOE8ZEGo/e1p24511mM8S+OZ12yY7DRYPEHnbcABWlOxmDyIDwFhtnPJslkWVHxhX3rJPJ8jNMW8436Zdmkntwj1hUPnOsfDEx7SKrPfnlFP1q1jXXJA1z46l26oZEEL5/sEDxTkwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgQ3nknA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgQ3nknA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1628AC2BCB0;
	Fri, 27 Mar 2026 01:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574859;
	bh=vMbvgp0mtiihPPzf5blBH9tIuvs6M9GGEXUIy85lD2Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kgQ3nknA3r+hEChAEckdncOapYN908zOKs87S4VJkhLuPVw1A9aL3k4kjARM7/sx0
	 jUKsE4qLvrmC5q/uvmwp2e0FC6eQCAsx5ZVTw43Cp7RpxnuDMiwGwbLn3pQNr7oOo7
	 EOPd4EFjvN38b5O6OGf39rhLktpix2ptOaKjt1pbGceoox2YafnlPVn8wbDxM47+57
	 2/kfb5zKwJyT4NfIAyfkV2Ck79082HpsBUHRYrg2yGTIeiiCTgLAvxXZWExo3Po1aQ
	 5Ab3WGlSmD4mKzNU5A3dPyqL2Cnz0F8k92TIoXMxMHO4HUaV7SKSwAWD7zaHtaRpQ5
	 VziN3NAVtNxuw==
Date: Thu, 26 Mar 2026 18:27:38 -0700
Subject: [PATCH 11/17] mount_service: use over the other non-root user checks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463316.1008428.211933150228152448.stgit@frogsfrogsfrogs>
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

Now that we've hoisted the code that checks non-root fuse mounts to a
common file, make fuservicemount obey them too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)


diff --git a/util/mount_service.c b/util/mount_service.c
index 9f6feab902f89d..6e53447e1d65be 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -1224,6 +1224,30 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
 # define mount_service_fsopen_mount(...)	(-2)
 #endif
 
+static int check_nonroot_file_access(const struct mount_service *mo)
+{
+	char buf[32];
+	char *mntpt;
+	int fd;
+
+	if (mo->mountfd >= 0) {
+		snprintf(buf, sizeof(buf), "/dev/fd/%d", mo->mountfd);
+		mntpt = buf;
+	} else {
+		mntpt = mo->mountpoint;
+	}
+
+	fd = open(mntpt, O_WRONLY);
+	if (fd < 0) {
+		fprintf(stderr, "%s: user has no write access to mountpoint %s\n",
+			mo->msgtag, mo->mountpoint);
+		return -1;
+	}
+
+	close(fd);
+	return 0;
+}
+
 static int mount_service_handle_mount_cmd(struct mount_service *mo,
 					  struct fuse_service_packet *p)
 {
@@ -1298,6 +1322,44 @@ static int mount_service_handle_mount_cmd(struct mount_service *mo,
 		return mount_service_send_reply(mo, EINVAL);
 	}
 
+	/*
+	 * fuse.conf can limit the number of unprivileged fuse mounts.
+	 * For unprivileged mounts (via setuid) we also require write access
+	 * to the mountpoint, and we'll only accept certain underlying
+	 * filesystems.
+	 */
+	if (getuid() != 0) {
+		struct statfs fs_buf;
+
+		ret = check_nonroot_mount_count(mo->msgtag);
+		if (ret)
+			return mount_service_send_reply(mo, ENOMEM);
+
+		ret = fstatfs(mo->mountfd, &fs_buf);
+		if (ret) {
+			int error = errno;
+
+			fprintf(stderr, "%s: %s: %s\n",
+				mo->msgtag, mo->mountpoint, strerror(error));
+			return mount_service_send_reply(mo, error);
+		}
+
+		drop_privs();
+		if (S_ISDIR(stbuf.st_mode))
+			ret = check_nonroot_dir_access(mo->msgtag,
+						       mo->mountpoint,
+						       mo->real_mountpoint,
+						       &stbuf);
+		else
+			ret = check_nonroot_file_access(mo);
+		if (!ret)
+			ret = check_nonroot_fstype(mo->msgtag, &fs_buf);
+		restore_privs();
+
+		if (ret)
+			return mount_service_send_reply(mo, EPERM);
+	}
+
 	if (mo->fsopenfd >= 0) {
 		ret = mount_service_fsopen_mount(mo, oc, &stbuf);
 		if (ret != -2)

