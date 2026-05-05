Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0AA175A6E;
	Tue,  5 May 2026 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999471; cv=none; b=JxOUPRdsJuLwIUY6MONOqTg0MSrMSH8wCXmWDFylk8zqIr+ZRp9XzNBvSEZWmMJcw7erlDSde9dUTi6ZwYbx5O6kTjYpmqyKR3Akmrxln6xf8FGqFww9jcaMqCBM+UurhuLtnSi9qPCWMqSjV7r2m66L7DtvR1PmvAI5rKj2MpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999471; c=relaxed/simple;
	bh=xj8LpSNbtv+j4xFJKQ9xt2fSol5GjGyuqBZaqt8GzDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0ovaMHCm+YeBZVaIyRyUycvomco0Vmdh9rX82qaQk79EZzTbQHNfJfW1eO+AtQADmezBjBX5C1iP+1x9AqVFmCH5cmOiWyNNqfE6t/mjBGWNvX37TivGR+wKdXLneQh2kIFhonQjrnWU2iWk5e3bqnkQOGZhL7+f856jsYUR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q01h7JvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q01h7JvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A48C2BCB4;
	Tue,  5 May 2026 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777999470;
	bh=xj8LpSNbtv+j4xFJKQ9xt2fSol5GjGyuqBZaqt8GzDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q01h7JvYhPGcq3PfZNoE0gAwre7dTXNsj38xaKAFbFVAb4uD7tXqMulBkPzyCPxma
	 MqrCuY/oiBZWH4EVZp3PibFaiJOdKeOOjOqwLxRk0CX3V3VqbZm594kpHEuAbbv+wJ
	 pyNpqQkANgj6wCVlaeGkD0Xyer6kzLetbl9ULYgGOsxcH91xadO24utLUQZeP7YbXu
	 fh+LzRCpT8C7M6Vi4DGjBqDgEOth18GbekfRs4r8l3VeBUAzLtUMhL02tGP9IdL6HZ
	 VaDSBxVR0etvDr1oi1BMwUQhNuJCafsjKqD4d4OY5AfGOvwL2pS7bmrnx5oJoMWiux
	 Tt8w32vSxAWpA==
Date: Tue, 5 May 2026 09:44:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Subject: [PATCH v1.1 1/2] libfuse: don't use SYNC_INIT unless asked for
Message-ID: <20260505164428.GC7739@frogsfrogsfrogs>
References: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
 <177795853473.1133476.16730865173873586203.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177795853473.1133476.16730865173873586203.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

fuse2fs calls fuse_main, then starts threads from ->init.  It doesn't
call fuse_daemonize_early_start because I haven't ported it to use any
of the new APIs.  I don't have io_uring enabled for fuse on my dev box.

fuse_main calls fuse_session_mount calls fuse_session_mount_new_api
calls session_start_sync_init.  At the start of the function,
se->want_sync_init, se->uring.enable, and daemonize.active are all
false.  The first branch is not taken, so we call FUSE_DEV_IOC_SYNC_INIT
and enable sync_init even though the user didn't ask for that and didn't
prepare for it either.

FUSE_DEV_IOC_SYNC_INIT succeeds, so we send the synchronous FUSE_INIT
from mount, which calls fuse2fs' init() method.  That starts the
background threads and returns.  Upon return to the kernel, the mount()
now succeeds, and the next thing that fuse_main does is call
fuse_daemonize().  Since we didn't call fuse_daemonize_early_start, the
daemonize forks the process and the threads die with the parent.

If we didn't ask for SYNC_INIT, don't enable it.  This is needed to
maintain compatibility with older fuse servers that only support
asynchronous FUSE_INIT.

Fixes: 3e1101057aea57 ("fuse mount: Support synchronous FUSE_INIT (privileged daemon)")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
v1.1: improve commit message, refine logging logic
---
 lib/fuse_lowlevel.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 0e16845d2f14ff..83158d02bb8827 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4475,9 +4475,21 @@ static int session_start_sync_init(struct fuse_session *se, int fd)
 {
 	int err, res;
 
-	if (!se->want_sync_init &&
-		(se->uring.enable && !fuse_daemonize_is_used())) {
-		if (se->debug)
+	if (!se->want_sync_init) {
+		/*
+		 * SYNC_INIT is required for io_uring to initialize without
+		 * deadlocking the kernel if the fuse server crashes.
+		 *
+		 * !fuse_daemonize_is_used implies the fuse server doesn't know
+		 * about any of the SYNC_INIT APIs, so we don't enable sync
+		 * init or generate log messages.
+		 */
+		if (se->uring.enable)
+			fuse_log(FUSE_LOG_DEBUG,
+					"fuse: io_uring broken with async init\n");
+		else if (!fuse_daemonize_is_used())
+			; /* empty */
+		else if (se->debug)
 			fuse_log(FUSE_LOG_DEBUG,
 					"fuse: sync init not enabled\n");
 		return 0;
