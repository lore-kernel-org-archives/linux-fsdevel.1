Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9002C237C;
	Wed, 29 Apr 2026 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473952; cv=none; b=uud2a7WL7zVQWZhfCFmhKLrwpeEcQbhPU0S9J5uFWj7zyjtUvH7xWxoZ+ravzv+Zsq9+wM2P6kgcd1XiOatXNV12nq1zlyHJnbST0bsbZ5HhionOqP5vkYx3PVrFMnnULR5da8KF1+7Lu0vipG57cajyiayh4cYxPQ0FBqhljwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473952; c=relaxed/simple;
	bh=Jt22jRZon9RyfuUdQ5KQx2yIgxHiSz1KBH3nsBlB6KY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0NiO1Bzpi+t1Lhp6uaNggcZ7tXfy6knkOuVehHO1FYvjo2a4COS3TUYZSsgXw1InkA9dc9F+hwfaJYtOaFIt5fyvG2lz+U1gm4jqenz8mE78BLB6icRxL3OWtKcmXGtuLJXJJgkmUQvCyprbuSEm5Fp+AIIULLprqD9oBzGjbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsSlE82l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsSlE82l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6210BC19425;
	Wed, 29 Apr 2026 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473952;
	bh=Jt22jRZon9RyfuUdQ5KQx2yIgxHiSz1KBH3nsBlB6KY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MsSlE82lu/+EskdvmEFWpDmBP7x0P1Z+0JhZ3vRprY9mM7Q6EuQCJD88BFSB+n4ay
	 vlxvd8paB1Q13vh+d7VuHmv9TEzf0fJAIyu6trVAIG2W/081g5AbuXsqfr7jYv8LIQ
	 b8rv0/ajeaRgvqo3VhHz8D9TDc4T6tzg4ONyAyEhVzcyELfU5tNXkL76uOi8Hh6Gfm
	 ABwwkhy6OS1ulTMFKFwlILs7sXyeMAoa2gTyB8SVj0Gv7Ph7cy/SBxnq852KWJOycf
	 7i4VSNa5cYzCLDcFckVuzqb59zekzUi1+E2q4kcCX14ChcMtGk9GAZgcGP8K8a+8GM
	 rwKk7973UcmSQ==
Date: Wed, 29 Apr 2026 07:45:51 -0700
Subject: [PATCH 1/1] libfuse: allow root_nodeid mount option
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212239.4105652.11290600815654098860.stgit@frogsfrogsfrogs>
In-Reply-To: <177747212220.4105652.10875200461200906124.stgit@frogsfrogsfrogs>
References: <177747212220.4105652.10875200461200906124.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow this mount option so that fuse servers can configure the root
nodeid if they want to.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount.c       |    1 +
 util/fusermount.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)


diff --git a/lib/mount.c b/lib/mount.c
index 84c73579ab2daf..3e7e4c22ce6559 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -100,6 +100,7 @@ static const struct fuse_opt fuse_mount_opts[] = {
 	FUSE_OPT_KEY("defcontext=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("rootcontext=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("max_read=",		KEY_KERN_OPT),
+	FUSE_OPT_KEY("root_nodeid=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("user=",			KEY_MTAB_OPT),
 	FUSE_OPT_KEY("-n",			KEY_MTAB_OPT),
 	FUSE_OPT_KEY("-r",			KEY_RO),
diff --git a/util/fusermount.c b/util/fusermount.c
index c7905d58a85e32..a9d07683395632 100644
--- a/util/fusermount.c
+++ b/util/fusermount.c
@@ -733,7 +733,8 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
 				} else if (opt_eq(s, len, "default_permissions") ||
 					   opt_eq(s, len, "allow_other") ||
 					   begins_with(s, "max_read=") ||
-					   begins_with(s, "blksize=")) {
+					   begins_with(s, "blksize=") ||
+					   begins_with(s, "root_nodeid=")) {
 					memcpy(d, s, len);
 					d += len;
 					*d++ = ',';

