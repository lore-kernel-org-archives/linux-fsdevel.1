Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34B2F1FC9;
	Thu,  7 May 2026 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192054; cv=none; b=rBqpOEIfWLiuUUzxrhOtCTmi7DQXlWSJ/pRDH/ZT7R3NqQ5mzrD5lsuEv2ZcMbQ9COD0IZhYyAA4FtLPqT3UIZnRJIGLd1OIz+LmFd9ITLrlGfImF6PRfST2bQHpbd5tSIGU2foXVzgrHmkfRH9R7j7ZgSxCELEqiiq4eBbLsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192054; c=relaxed/simple;
	bh=M0MBFckKQ1+aNhZzXBzOvQ2OPfKnAE3uuhI/5nKdrII=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ey84ganJ6OQ0uHLloXr/0f7yBRMQ56gPIVTnwjeX5W3+BifmISByoGJN8GmT7A6r+AqyA+YlOAwkCNWHoYUmg7YfjYqzadn0wl739HLSjYUmG35zfXwlzdBuUhai/9dqASFtxyLiDp9QwNUM8H6e01mKf/h0ZjV2L1KhOFk3OpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj1VzwSO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj1VzwSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D51C2BCB2;
	Thu,  7 May 2026 22:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778192054;
	bh=M0MBFckKQ1+aNhZzXBzOvQ2OPfKnAE3uuhI/5nKdrII=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fj1VzwSOXJCh+Z+DA3ZABB1VEjO2+GAnThGM+a3Z7GDSRgi3+8WvevjW4h0angVl1
	 hsAOZkr5vIDiFO8nkQNMIlbkObJr1NGXU2SvHn2rsnlB+meOex55Ksy1qMbxu/H9Ct
	 tgBBRAeAl9vxubk1OMEA/LU6yLZOe2Oa5f4TRzznMhDfses9pzLP/HNEGyaVAWcnZU
	 OgKHhBKk+/enX/o5oZJbJgm4E9jZzipz25az0fWGZO4t3Sg6ZmHuI/JFgZ9Odcvevj
	 x5lDepWngdUyISBkhm9RQnkZz30UFfv4RrKGLWo1bxxOD0d3zvxRVMuNCjrKDcfs05
	 EHWB53VggVPLg==
Date: Thu, 07 May 2026 15:14:14 -0700
Subject: [PATCH 1/1] mount_service: use the mount_flags table instead of
 declaring our own
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org
Message-ID: <177819198067.3490792.2943381236495611249.stgit@frogsfrogsfrogs>
In-Reply-To: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
References: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use the canonical mount flags table in mount_util.c instead of
opencoding our own version in mount_service.c.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.c |   51 +++++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)


diff --git a/util/mount_service.c b/util/mount_service.c
index 8c9747b3928a51..79e5b060ba3356 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -1457,73 +1457,48 @@ struct ms_to_mount_map {
 	unsigned int mount_attr_flag;
 };
 
-static const struct ms_to_mount_map attrs[] = {
-	{ MS_RDONLY,		MOUNT_ATTR_RDONLY },
-	{ MS_NOSUID,		MOUNT_ATTR_NOSUID },
-	{ MS_NODEV,		MOUNT_ATTR_NODEV },
-	{ MS_NOEXEC,		MOUNT_ATTR_NOEXEC },
-	{ MS_RELATIME,		MOUNT_ATTR_RELATIME },
-	{ MS_NOATIME,		MOUNT_ATTR_NOATIME },
-	{ MS_STRICTATIME,	MOUNT_ATTR_STRICTATIME },
-	{ MS_NODIRATIME,	MOUNT_ATTR_NODIRATIME },
-#ifdef MOUNT_ATTR_NOSYMFOLLOW
-	{ MS_NOSYMFOLLOW,	MOUNT_ATTR_NOSYMFOLLOW },
-#endif
-	{ 0, 0 },
-};
-
 static void get_mount_attr_flags(const struct fuse_service_mount_command *oc,
 				 unsigned int *attr_flags,
 				 unsigned long *leftover_ms_flags)
 {
-	const struct ms_to_mount_map *i;
+	const struct mount_flags *i;
 	unsigned int ms_flags = ntohl(oc->ms_flags);
 	unsigned int mount_attr_flags = 0;
 
-	for (i = attrs; i->ms_flag != 0; i++) {
-		if (ms_flags & i->ms_flag)
-			mount_attr_flags |= i->mount_attr_flag;
-		ms_flags &= ~i->ms_flag;
+	for (i = mount_flags; i->opt != NULL; i++) {
+		if (!i->on || !(ms_flags & i->flag))
+			continue;
+
+		mount_attr_flags |= i->mount_attr;
+		ms_flags &= ~i->flag;
 	}
 
 	*leftover_ms_flags = ms_flags;
 	*attr_flags = mount_attr_flags;
 }
 
-struct ms_to_str_map {
-	unsigned long ms_flag;
-	const char *string;
-};
-
-static const struct ms_to_str_map strflags[] = {
-	{ MS_SYNCHRONOUS,	"sync" },
-	{ MS_DIRSYNC,		"dirsync" },
-	{ MS_LAZYTIME,		"lazytime" },
-	{ 0, 0 },
-};
-
 static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
 {
-	const struct ms_to_str_map *i;
+	const struct mount_flags *i;
 	int ret;
 
-	for (i = strflags; i->ms_flag != 0; i++) {
-		if (!(ms_flags & i->ms_flag))
+	for (i = mount_flags; i->opt != NULL; i++) {
+		if (!i->on || !(ms_flags & i->flag))
 			continue;
 
-		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
+		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->opt,
 			       NULL, 0);
 		if (ret) {
 			int error = errno;
 
 			fprintf(stderr, "%s: set %s option: %s\n",
-				mo->msgtag, i->string, strerror(error));
+				mo->msgtag, i->opt, strerror(error));
 			emit_fsconfig_messages(mo);
 
 			errno = error;
 			return -1;
 		}
-		ms_flags &= ~i->ms_flag;
+		ms_flags &= ~i->flag;
 	}
 
 	/*

