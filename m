Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596AE3358AF;
	Wed, 29 Apr 2026 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473514; cv=none; b=QWkiduhvT0xIOPqFi4tIjaq8v+xoI7IW8G5hep6d+O5ra38EqIqcMLayGWx5kM2uwFNLexf/ueKmp5qKKiYwgrPr0PenTF6kIcn+Lo8eWyOKHzQQ0DaCUSH+OzVM4iPi2gXiZRselR7RMOQcHfUDoy4LMlYsqpzvNj6IC7i83yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473514; c=relaxed/simple;
	bh=97pc/0Wkg+J0ciSwRkg/WskJVDLD4Ya4OreHxRwbXTw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwZ1nLYljQgRA/qtJkQnaUaLeQwvzd0U06+IP7GaBPi5pBT33c1omXLd8bFyLoG2jDkRZSfEw0MiqeHpDVtBKb0gY5qTgPOFmwcLSD6T/jvJnVtJmuNgyZImp+vmoTvLe53TLOMh7UJi7oqt77wDOafSU/BSw6ZDpQh5a3c0/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUJ9fIC+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUJ9fIC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AF2C19425;
	Wed, 29 Apr 2026 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473514;
	bh=97pc/0Wkg+J0ciSwRkg/WskJVDLD4Ya4OreHxRwbXTw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QUJ9fIC+VU/8xR2b86Th989dFKGG94oAayCboyXJxQv8SqYI/R7r/TTwGifZESVvC
	 I7Dss4AWCcfGW+IXJbX/oQDH69Kbu80OurV8fmRqn1mCVgfZhTp6aDMpnNf7OE5yXd
	 lS6TSbuTGBbfFjuwKToW4ZWjshQy/0ZX6zLafpKZLphMTmnZCaoDCmkvLZkZqzNDrs
	 L32E1lE7YKob4BYXBRasl/qgIZCfz9YuLZXk9mSrilsueq/petjFiNAmTE3ZASUE+l
	 WXBzAe7u89XiCdHgnn7lLD5xdh1wZgNeOwZnb6qvJWdNSPfChqUMUNt+WYrFfKTlui
	 lu1SPzQiKjPIA==
Date: Wed, 29 Apr 2026 07:38:33 -0700
Subject: [PATCH 12/12] fuse: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747207255.4103699.2745457382232000914.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
References: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_iomap.c |    3 ---
 1 file changed, 3 deletions(-)


diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 22b23a3fa2ae2c..8d3c7273dda810 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -70,9 +70,6 @@ MODULE_PARM_DESC(debug_iomap, "Enable debugging of fuse iomap");
 
 bool fuse_iomap_enabled(void)
 {
-	/* Don't let anyone touch iomap until the end of the patchset. */
-	return false;
-
 	/*
 	 * There are fears that a fuse+iomap server could somehow DoS the
 	 * system by doing things like going out to lunch during a writeback

