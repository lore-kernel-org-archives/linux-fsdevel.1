Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291D239E9B;
	Tue,  5 May 2026 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958616; cv=none; b=iS5eyIWsJljAHNMMWkiHgIMzEpvHGDSvAmLg/O2LF7GU7q7OlY96OzXDRzFx5Suftfr6TWTBvoXWGAuuZoIhuAHTjQF80nEhoXpAyP0IIT7JlP0kXlUfTkUCR19UECl1dJ2C9WIHrt1Gm/DeF/ZByvqadUtQnkJGt5EmN5GqpOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958616; c=relaxed/simple;
	bh=hwlYGN1NM17s8/dTGHtnIEzBC4IpjzB25d2fSGmx+WA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lp1UCAAMYjaRim406Ji3XAyuPV0TcWyQtVl+OX6dmv3dEKqt8ZDBmhi775l1YLhP4JSKjrC9EfHwTNxF8H2MG/1kRYt+ughRe85J/Mq/y+TN6/Yj1+S1QYywAtgNSbfJazCwuPkGA4sC+G3XCwVlt7TZyqmgMuS3W2UBXcnFOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY2O0x0i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY2O0x0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB2EC2BCB4;
	Tue,  5 May 2026 05:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958615;
	bh=hwlYGN1NM17s8/dTGHtnIEzBC4IpjzB25d2fSGmx+WA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EY2O0x0i5DdJMm1WTjLV1l91i1jfEZGEFuzCZdj65yd6fj6azKL8KeIXZj0J9R98L
	 Y4mgfKCy3JAYLg7hnZ0OHRwiKnFfX5IwKu8DNfePxxB+Zv0KJ+YbOAX4pkXdGLPUBD
	 6Kr5uzzCFZcGNKOtSlJL8+SNm4JZeIsaVZaL5PyErSlN+6HgAlFZbBFN5alqPtbFhu
	 Xay4PUiKfiNjFG/qiD3kfGRBaxxbHaOJZ5x9PD8Nxf9tQ7mRZMmqWqWXhA49A+hv9H
	 KC3HM2QkXNR+BBFB1ZF31oIiXKDL3EdblSS4wqZWENHBDUqgJhDvZg9745zxetBM0P
	 gR+S6hhH8dltw==
Date: Mon, 04 May 2026 22:23:35 -0700
Subject: [PATCH 1/2] libfuse: don't use SYNC_INIT unless asked for
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853473.1133476.16730865173873586203.stgit@frogsfrogsfrogs>
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

If we didn't ask for SYNC_INIT, don't enable it.  This is needed to
maintain compatibility with older fuse servers that only support
asynchronous FUSE_INIT.

Fixes: 3e1101057aea57 ("fuse mount: Support synchronous FUSE_INIT (privileged daemon)")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 lib/fuse_lowlevel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 0e16845d2f14ff..0a801132590079 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4475,9 +4475,9 @@ static int session_start_sync_init(struct fuse_session *se, int fd)
 {
 	int err, res;
 
-	if (!se->want_sync_init &&
-		(se->uring.enable && !fuse_daemonize_is_used())) {
-		if (se->debug)
+	if (!se->want_sync_init) {
+		/* SYNC_INIT is required for io_uring(?) */
+		if ((se->uring.enable && !fuse_daemonize_is_used()) || se->debug)
 			fuse_log(FUSE_LOG_DEBUG,
 					"fuse: sync init not enabled\n");
 		return 0;

