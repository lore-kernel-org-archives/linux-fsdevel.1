Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11A2D541B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574812; cv=none; b=FpXw0YyzZpchkamYM67+PJe1iVZLJI3KHQNpOQDSDuolk/z42wM+fY4o0FuHFEwdE0bFLXQ4FGmIPnRw58kqB9ydq/VS5idhGiuaFPQajfQO3UCSpR3XYfprRh4nk3FqYiHmyS3AFZfJlIK3Evns5JXzAulhF40pLd4oitHvVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574812; c=relaxed/simple;
	bh=WTnXxNoa5+SHnWAYmVXapqpN6f5qYf95ca/KnQX2UWs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gn4IGT9SDJIQ01Eig4hbfDYAEzoI8mctf5wzD7Jha5t0TZXqjC+hnF1U4LmEsOdjdluwKjlCuUrDBeBO0MUwdTht8em4znBA/3csY4toH/9LvB3//yLhb9IsB9USD8APEoi9GYBYohROxT954kXgudph9WLq1eYnBEsYq1Dlqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9aa1qUY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9aa1qUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0953AC116C6;
	Fri, 27 Mar 2026 01:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574812;
	bh=WTnXxNoa5+SHnWAYmVXapqpN6f5qYf95ca/KnQX2UWs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=s9aa1qUYHdtStHI0xlrzHTRcZ+gxh/SefYMm54WMu8cjL5TiLAW4pViP4sbxgtABH
	 5wdRlmWgH4WViLbMyZu9aL+2t/0KghT0lc2pqu0uSylNqO1BQd44Plnm1pXzj+AQOf
	 f12k2yT4G5I5dJQmHANPooC7oZ0Hk1muJA4ONmLemYpigVdJjTADKzLKXMQGtSN4Qz
	 Mklw6EFAECmRhSl33tQmYoLxowE5HZ1unHsnyvrbuzeCMaDc53mgZdnNC1M/W/RB+x
	 dH8KCaIZMfh+YnJC3uXiK0m74ck17qceMYaEd3ynM/mU2RRWxuJjEy5x3ZrRbHzOGa
	 Nztobc6Re0vdg==
Date: Thu, 26 Mar 2026 18:26:51 -0700
Subject: [PATCH 08/17] mount_service: read fuse.conf to enable allow_other for
 unprivileged mounts
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463259.1008428.6680534735656943423.stgit@frogsfrogsfrogs>
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

Now that we've hoisted the fuse.conf parsing and enforcement code into a
shared file, we can make fuservicemount use the same config file for the
same kinds of parsing.  This will enable distros to install
fuservicemount as a setuid program so that unprivileged userspace can
also access containerized fuse servers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)


diff --git a/util/mount_service.c b/util/mount_service.c
index 2e541f67277ee5..9f6feab902f89d 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -31,6 +31,7 @@
 #include "fuse_i.h"
 #include "fuse_service_priv.h"
 #include "mount_service.h"
+#include "fuser_conf.h"
 
 struct mount_service {
 	/* prefix for printing error messages */
@@ -199,7 +200,7 @@ static int mount_service_send_hello(struct mount_service *mo)
 	};
 	ssize_t size;
 
-	if (getuid() == 0)
+	if (getuid() == 0 || user_allow_other)
 		hello.flags |= htonl(FUSE_SERVICE_FLAG_ALLOW_OTHER);
 
 	size = sendmsg(mo->sockfd, &msg, MSG_EOR | MSG_NOSIGNAL);
@@ -813,6 +814,20 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
 			*equals = 0;
 		}
 
+		if (getuid() != 0 && !user_allow_other &&
+		    (!strcmp(tok, "allow_other") ||
+		     !strcmp(tok, "allow_root"))) {
+			fprintf(stderr,
+"%s: option %s only allowed if 'user_allow_other' is set in %s\n",
+				mo->msgtag, tok, FUSE_CONF);
+			return mount_service_send_reply(mo, EPERM);
+		}
+		if (!strcmp(tok, "blkdev") && getuid() != 0) {
+			fprintf(stderr, "%s: option blkdev is privileged\n",
+				mo->msgtag);
+			return mount_service_send_reply(mo, EPERM);
+		}
+
 #ifdef HAVE_NEW_MOUNT_API
 		if (mo->fsopenfd >= 0) {
 			int ret;
@@ -1347,6 +1362,8 @@ int mount_service_main(int argc, char *argv[])
 	else
 		mo.msgtag = "mount.service";
 
+	read_conf(mo.msgtag);
+
 	ret = mount_service_init(&mo, argc, argv);
 	if (ret)
 		return EXIT_FAILURE;

