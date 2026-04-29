Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9CB2475D0;
	Wed, 29 Apr 2026 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474218; cv=none; b=aMglv3KTQuwPkjrZEmcXouVTmGzuR5bE76m8sjmUilzYbS446XpEpZeFCviU4+uRoyQGarcs0jtBjxj0TyNM2iXXj6DkL1Wm6tf8vHy7E63RdS7z+CZoILfhT4U0Jy8hChdecpvSZ/zlNiO+RtsLAKDB/ETsfqmT9b/C/FfrbgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474218; c=relaxed/simple;
	bh=8A27lrU6vmQgropdlMArYbJJbs2AFt2Fh1u+Hng0EgM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcfqksugM1qYUpaT5rRyW2WW3CmoC4ebKeyCIFcIfPw6Y129Jm2o25b+Eew4MAjpJ4MwwxGg7m5Z7FRRYdhLRullufF0Gm9gHFbdQKQzN7NUD5NpuyecZVVkkpSLMHohFagPUvWgIvTcB4JkQ7aLZZCrtoivP+oV6RHhxVDPuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De2rPR0B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De2rPR0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8BBC19425;
	Wed, 29 Apr 2026 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474217;
	bh=8A27lrU6vmQgropdlMArYbJJbs2AFt2Fh1u+Hng0EgM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=De2rPR0BclZblr4Xzm8GfQ33e4OBTL5tLwOjkpIrGlYKX/yjhmpmvzCR0vHhPd6xF
	 hT//TEqjw5g0a6rudRyasdOiwyypzR+CCPRtCty51CYFFzfQ5z3NxFZHtV1D8y5WzP
	 2pIVMNOQo06f1JvwPcvnBT70CtJJkPJQGpdZSTtuNMf4vvq3Twg5Zf/Ijx8WGkFYJo
	 RxCMQN7FkSAVClqYs7povcyjJ4rE6jJ3BUdCcgwLthmvEZxI8ynw9hlzT0r1jL4UOf
	 6zgdWC1OdZo1IqY5zsPHuCiYXzoMhdjMcypx6cQbO1+KQUA0FxEPM4H2zXqM015MY2
	 +QbTldoKPFDIQ==
Date: Wed, 29 Apr 2026 07:50:17 -0700
Subject: [PATCH 5/9] libfuse: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747213336.4106384.10963007226836442728.stgit@frogsfrogsfrogs>
In-Reply-To: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
References: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Remove the guard that we used to avoid bisection problems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse_lowlevel.c |    2 --
 1 file changed, 2 deletions(-)


diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 4af2ed8380f5ac..5dcb321f2f87a7 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3185,8 +3185,6 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_ALLOW_IDMAP;
 		if (inargflags & FUSE_IOMAP)
 			se->conn.capable_ext |= FUSE_CAP_IOMAP;
-		/* Don't let anyone touch iomap until the end of the patchset. */
-		se->conn.capable_ext &= ~FUSE_CAP_IOMAP;
 
 	} else {
 		se->conn.max_readahead = 0;

