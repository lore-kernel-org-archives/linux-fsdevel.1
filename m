Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB38635D;
	Wed, 29 Apr 2026 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473968; cv=none; b=itYlZ88jmCTSKj3SDX3IsQg1bp8uQWw8BbrvYsTyZpfEr4tLyd5tMxdQUkrlw8j12hlylvtTtfR6NBk6DAJKSj9xWU1353nYQ3D5k/Dhvkw0UV9z5z5hxkRRJFvJf9Vl+vfSXtURJQIcBH/ar//qLZpFZVXihbYgzs7qW/w9WsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473968; c=relaxed/simple;
	bh=Kb05cpvckBL1NK7f5mQfDpNfr5O5RpBya8VwOAoJVe4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNOTW+e8siMTXycq1sOa3j2YKsHZgO+IOZqR3ageqGiaCzsSz0PkrvVQv/KZ+Ij94k6r4yAvhwregJoT4k2+DeCgHZ49K5Rydw/l9N2F6vlx35Rf3WnMY7yGKiN33lQIPr+5KSyLrSjDMEYdj3JP5s9txTEDAyTPHvFrcRV18co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFJPGs+I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFJPGs+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03029C19425;
	Wed, 29 Apr 2026 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473968;
	bh=Kb05cpvckBL1NK7f5mQfDpNfr5O5RpBya8VwOAoJVe4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bFJPGs+IKqdi2sDv+QIptOD/fdAlmZTNaNZpqAoKhGLwFHpCHz3zuz44VW5a52T5O
	 X3Dj3nrstpT/XQ7vC6xhP6E7ywXF70BwGgLXFUYPGZSfrpHwUsVqu/y9TMGcdN9ODk
	 NRE9C4PT9OyjHIWKN2caEzmNZdBVRU/lPp7QEfMYPGIAtteIf7jD9juZclA/jjOBeT
	 YTVC80x+u75CZXi/1JjrykETriyIoZjrc0alA5X8WvMuDceIREwuIgeHXSUj47Q4B4
	 atNJNnbVN5iT1VBoojJC4WIuSFhA6WKbSkr8C2L1vH6WEGfrrnuY+eUhFmDFI2d3ag
	 Ki2eTbC4DtiNA==
Date: Wed, 29 Apr 2026 07:46:07 -0700
Subject: [PATCH 1/2] libfuse: add strictatime/lazytime mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212464.4105754.11153526600603528430.stgit@frogsfrogsfrogs>
In-Reply-To: <177747212442.4105754.7242835990761551019.stgit@frogsfrogsfrogs>
References: <177747212442.4105754.7242835990761551019.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

fuse+iomap leaves the kernel completely in charge of handling
timestamps.  Add the lazytime and strictatime mount options so that
fuse+iomap filesystems can take advantage of those options.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)


diff --git a/lib/mount.c b/lib/mount.c
index 3e7e4c22ce6559..0825b4dfba4385 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -117,9 +117,12 @@ static const struct fuse_opt fuse_mount_opts[] = {
 	FUSE_OPT_KEY("dirsync",			KEY_KERN_FLAG),
 	FUSE_OPT_KEY("noatime",			KEY_KERN_FLAG),
 	FUSE_OPT_KEY("nodiratime",		KEY_KERN_FLAG),
-	FUSE_OPT_KEY("nostrictatime",		KEY_KERN_FLAG),
 	FUSE_OPT_KEY("symfollow",		KEY_KERN_FLAG),
 	FUSE_OPT_KEY("nosymfollow",		KEY_KERN_FLAG),
+	FUSE_OPT_KEY("lazytime",		KEY_KERN_FLAG),
+	FUSE_OPT_KEY("nolazytime",		KEY_KERN_FLAG),
+	FUSE_OPT_KEY("strictatime",		KEY_KERN_FLAG),
+	FUSE_OPT_KEY("nostrictatime",		KEY_KERN_FLAG),
 	FUSE_OPT_END
 };
 
@@ -189,12 +192,15 @@ static const struct mount_flags mount_flags[] = {
 	{"noatime", MS_NOATIME,	    1},
 	{"nodiratime",	    MS_NODIRATIME,	1},
 	{"norelatime",	    MS_RELATIME,	0},
-	{"nostrictatime",   MS_STRICTATIME,	0},
 	{"symfollow",	    MS_NOSYMFOLLOW,	0},
 	{"nosymfollow",	    MS_NOSYMFOLLOW,	1},
 #ifndef __NetBSD__
 	{"dirsync", MS_DIRSYNC,	    1},
 #endif
+	{"lazytime",	    MS_LAZYTIME,	1},
+	{"nolazytime",	    MS_LAZYTIME,	0},
+	{"strictatime",	    MS_STRICTATIME,	1},
+	{"nostrictatime",   MS_STRICTATIME,	0},
 	{NULL,	    0,		    0}
 };
 

