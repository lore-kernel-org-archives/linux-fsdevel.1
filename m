Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112B22083;
	Tue,  5 May 2026 05:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958632; cv=none; b=NiYDnaY12yQwSzuiQd/MhEpApyY1dDRhaveamswGDjHh6QwAK0zM2PGF15urltWjX1MkXagao5lFBSdZn6WnzBEiXwgory5lUTMiAwfetlUZqxEOQf/b7QvPOKaY3VBox7OQ3OuxSfmMifIlwB5u1k/sqmTpWmhKEsbsZJaBtRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958632; c=relaxed/simple;
	bh=5VMreoLJ1ccVuP+R9Nm8iI4Duk0cvjnMQvKTJbng0XU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNjVQa+rbR1+sRR+Dgtat9TK6zGlydq7wAYpfIFO23PpgtdYMCio3/9TDRK58plYM0HmPcQaqCgWLuqAGH2aPT4X3YCmnmE0KsWZVWVkK4HshUgR2+COy1T7dTpqZbUlJroVB+HfRISd8A2f6m6zeYgSSn8RtWeZ3VQcMZUnlmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgTqeBHz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgTqeBHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73124C2BCB4;
	Tue,  5 May 2026 05:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958631;
	bh=5VMreoLJ1ccVuP+R9Nm8iI4Duk0cvjnMQvKTJbng0XU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PgTqeBHzMNG813r2HaqHCln6N37UZKOhXPt3PGwdX1R7v76qKmkNOr7qcJJ/wtwWu
	 JTne276VrCVM6LgVINQj6DQ53EzbZTtr6slrrahwu1WDiJG6KaGqF1KE/wEl/PVnEf
	 UFGe/ypjDeM3u5ziEiv8o5faeuj6vEuyELQDmqCIbjZ40brX0QlAcCrSGjkY9aVSsb
	 /OjDXgG2e31yPbxE5fjUTkbthsDEUHM4n69miI1i/R6AGABvoBhevrtOgBEzaA0Z8E
	 FSBnM6wDSUzMzYAHc/w3/VO8C1CZMU1UiWmPshM3nWW1PlMV9JOwr+8RCeSQIoy9xC
	 sg2hYUMjXpD2A==
Date: Mon, 04 May 2026 22:23:51 -0700
Subject: [PATCH 2/2] libfuse: always send the subtype to the kernel when using
 fsconfig()
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853491.1133476.14673788941960394877.stgit@frogsfrogsfrogs>
In-Reply-To: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
References: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Although it's possible to supply a filesystem subtype when calling
fsopen(), it does not pass the stuff after the dot to the mount option
parsing mechanism like the legacy mount() call does.  Therefore, it's
necessary to pass the subtype explicitly via fsconfig() or else the
subtype will be missing from the /proc/mounts output.

For example, fuse4fs with the old mount API produces this:

/dev/sda /mnt fuse.ext4 rw,nosuid,nodev,relatime,user_id=0,group_id=0 0 0

But with the new mount API, we only get:

/dev/sda /mnt fuse rw,nosuid,nodev,relatime,user_id=0,group_id=0 0 0

...which breaks fstests, which requires the fsname to match the string
that it passes to mount -t.  Update the comment in mount_service.c to
match this requirement.

Fixes: 14cb7b93bb9688 ("Add support for the new linux mount API")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount_fsmount.c  |   13 +++++++++++++
 util/mount_service.c |    3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)


diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
index 615271b09758c3..5e13b34ccfc610 100644
--- a/lib/mount_fsmount.c
+++ b/lib/mount_fsmount.c
@@ -359,6 +359,19 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
 		goto out_free;
 	}
 
+	/* Configure subtype */
+	if (subtype) {
+		res = fsconfig(fsfd, FSCONFIG_SET_STRING, "subtype",
+			       subtype, 0);
+		if (res) {
+			err = -errno;
+			log_fsconfig_kmsg(fsfd);
+			fprintf(stderr, "fuse: fsconfig subtype failed: %s\n",
+				strerror(-err));
+			goto out_free;
+		}
+	}
+
 	/* Configure source */
 	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", source, 0);
 	if (res == -1) {
diff --git a/util/mount_service.c b/util/mount_service.c
index bc5940bc900dad..3fbabfdd69300d 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -821,7 +821,8 @@ static void try_fsopen(struct mount_service *mo)
 	/*
 	 * As of Linux 7.0 you can pass subtypes to fsopen, but the manpage for
 	 * fsopen only says that you can pass any value of the second column of
-	 * /proc/filesystems into fsopen.
+	 * /proc/filesystems into fsopen.  You must still call fsconfig() for
+	 * the subtype separately, however.
 	 */
 	mo->fsopenfd = fsopen(fsname(mo), FSOPEN_CLOEXEC);
 }

