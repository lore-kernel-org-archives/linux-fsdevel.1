Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F19D31ED8B;
	Tue,  2 Jun 2026 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365207; cv=none; b=AZMhnmee9CCR8JwOZLOQwrS+mjpAyPC5vSgRFdJd6a9G19ec/y4XiB1G8kR1UDA7V1MS5C96sBfxEttnvCOrrKqPmTkhL+REpX7eVqfBanwG0vNx9hHyDHAKGRml7CTjI0vBa5u9eECcclvHHYaOZeW11lrROaXeRy+y7Lu5g0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365207; c=relaxed/simple;
	bh=fRoA0SJo6xfMvoHnrhcOgntAKqYImBseHuV3c9/clho=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/OKiVNirsqobvUgEpLIa5v4qbeFXgHcnTJMJVOwqR3jLAjsBJ529zuRx5rdvd7Yv+Q4t/P6juMeM4Bs00ycwnUjp3MTNclrQMvK1fAgpI4KhK6N3Dj3yVFFnVoYSpzXTRn8jrhe78KqyBHlKD2WGMi5qbg0toTvLtuEHiIzRwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxAWb/pZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxAWb/pZ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E7ED11F00893;
	Tue,  2 Jun 2026 01:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365206;
	bh=k3Ktmr/rc4wTgzjc+QknlGGcu9HUpp9nF7io1c7UDKk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=hxAWb/pZdFcVHkMYLJ/UXYo7InOdn+GtB9TJta7GUXinBmf3POLWjhjLo1pwwVCCB
	 2aFog+8YdIzryXdT4dqLZJmuK2D6WZ77vH19Sa7Fbv7mQArMX6cP8POY/WHZqE2EZM
	 wgeHqgLFuOlK9eD9YSEn7RJKIGfMyGK1cVztIVE9Ajp6m1HrvsTxelLMDlOdN+a9PJ
	 74NP+WpKEWYXLxr+0ONNgA6uBqhPz7eN5jjPTuDR/TG5wSJ5sMNWSma6D+QrHDAZ2C
	 3uKojUdCy4zrVdBPj8NaTKfO0PbCNuZ1d0EPgcd6SN5CFbfczw+2/9dJXdbdWj+dbH
	 735nXczwlvS9Q==
Date: Mon, 01 Jun 2026 18:53:25 -0700
Subject: [PATCH 3/3] mount_service: call the new fsmount ms_flags helpers in
 the right order
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178036512194.432362.255954133278562428.stgit@frogsfrogsfrogs>
In-Reply-To: <178036512130.432362.7597373245082703669.stgit@frogsfrogsfrogs>
References: <178036512130.432362.7597373245082703669.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Codex noticed a discrepancy between the new fsmount code that Bernd
wrote and my port of the even newer mount service code to use the
helpers that Bernd wrote.  Specifically, set_fsconfig_ms_flags only
clears bits from MS_FLAGS if there's no corresponding MOUNT_ATTR_ flag,
whereas ms_flags_to_mount_attrs always clears them.

In other words, set_fsconfig_ms_flags MUST be called before
ms_flags_to_mount_attrs or we can lose the 'ro' option.  Fix this.

Fixes: 7211953256526f ("mount_service: use the fsmount API helpers from mount_fsmount.c")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount_fsmount.c  |    1 +
 util/mount_service.c |   12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)


diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
index 83768f0b8d193b..7bd772d139808e 100644
--- a/lib/mount_fsmount.c
+++ b/lib/mount_fsmount.c
@@ -35,6 +35,7 @@
 #define MOUNT_ATTR_NOSYMFOLLOW  0x00200000
 #endif
 
+/* Must be called after set_fsconfig_ms_flags */
 unsigned long ms_flags_to_mount_attrs(unsigned long ms_flags,
 				      unsigned int *mount_attrs)
 {
diff --git a/util/mount_service.c b/util/mount_service.c
index 360a78bab3bd3d..f1b61ace526275 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -1410,14 +1410,12 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
 				      const struct stat *stbuf)
 {
 	char tmp[64];
-	unsigned long ms_flags;
+	unsigned long ms_flags = ntohl(oc->ms_flags);
 	unsigned int attr_flags;
 	int mfd;
 	int error;
 	int ret;
 
-	ms_flags = ms_flags_to_mount_attrs(ntohl(oc->ms_flags), &attr_flags);
-
 	ret = set_fsconfig_ms_flags(mo->fsopenfd, &ms_flags);
 	if (ret) {
 		error = errno;
@@ -1478,6 +1476,14 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
 		goto fail_fsconfig;
 	}
 
+	ms_flags = ms_flags_to_mount_attrs(ms_flags, &attr_flags);
+	if (ms_flags != 0) {
+		error = ENOTSUP;
+		fprintf(stderr, "%s: unsupported mount flags encountered\n",
+			mo->msgtag);
+		goto fail_fsconfig;
+	}
+
 	mfd = fsmount(mo->fsopenfd, FSMOUNT_CLOEXEC, attr_flags);
 	if (mfd < 0) {
 		error = errno;

