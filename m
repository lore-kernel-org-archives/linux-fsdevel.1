Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37723D7DC;
	Tue,  5 May 2026 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022660; cv=none; b=WqJuIW1u0rV7iBCZT1dmCBM2glB6iAbIJ3oztn6cw8RWiUeEBdv2kaXwxGTUVdNigEVHREsgj9QLjYfVS/Gff+Jp2r3/ANkrf/RQd7BU9Hehuw3bMc55KYugBjM/gPiaUCDGG7csNngM3Dtu8OnGvrBnPS4MF2DKLjeqe/c0Q7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022660; c=relaxed/simple;
	bh=3nJ6b3GJthKAPv4UaoBv4d1JuGiX2HnRguU1727nH1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4CRxsDTHQMeEabSj3IqMhuKLvPYw+m6WMErMafv3QWZc+js1PJY47BQita9MVA41YvObB29xQiLveisKIcDy2suZ38F+3KtOz8XG/fRBVlArU/Hqq+XO4cF4guhlun3T9G56vBMDWTpdm2UbJy2GWWHPVQhddrDPDq3dQ5Yn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ut1Ev9k5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ut1Ev9k5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3F1C2BCB4;
	Tue,  5 May 2026 23:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778022659;
	bh=3nJ6b3GJthKAPv4UaoBv4d1JuGiX2HnRguU1727nH1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ut1Ev9k5I+KABt2yht9/B6sqE8km9Ua1QI2r8OHtHVtinqsWZ+ZC8kgXO4EoidZeQ
	 0SOVca5I0pxN5sMCisj3+vh8zkysyv7hAyFZFG6JKp5GddemTqnUy/Cw0Vt30Mxnh8
	 29wWELN/srGwUdnQkqgvNGC2dwNAeb06U1mDHHgPxFe9/RlOtOBEQ960QZ5bgxwkK2
	 11EsVyQi/SNwBX0jz3R3nFzFb9DO2dWGm4P5NSEMTHQgfI12pv7ok9qwWYxK/qatoj
	 tszqk6HNiXUPRad/GIcXZyw3MyyLvdajFFvhwbzawm8t1+170x+zXD/FHWYl0cKW57
	 NiKCcSE1Z1THw==
Date: Tue, 5 May 2026 16:10:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Subject: [PATCH v1.2 1/2] libfuse: don't use SYNC_INIT unless asked for
Message-ID: <20260505231059.GE7739@frogsfrogsfrogs>
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
--
v1.2: simplify the logic even more
v1.1: improve commit message, refine logging logic
---
 lib/fuse_lowlevel.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 0e16845d2f14ff..6e078e820eddec 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4475,8 +4475,11 @@ static int session_start_sync_init(struct fuse_session *se, int fd)
 {
 	int err, res;
 
-	if (!se->want_sync_init &&
-		(se->uring.enable && !fuse_daemonize_is_used())) {
+	/*
+	 * Older fuse servers do not set want_sync_init or start the new
+	 * daemonize code, so they get async init.
+	 */
+	if (!fuse_daemonize_is_used() || !se->want_sync_init) {
 		if (se->debug)
 			fuse_log(FUSE_LOG_DEBUG,
 					"fuse: sync init not enabled\n");
