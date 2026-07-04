Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E523372ED7
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183293; cv=none; b=DzGUnefyKZcvkBpA8ihkIKD9WYUKeWo5OnZj7pem3TqP1eq+tFOFwZpmSnpTXBRgwEiiEIFH8liZQ8kZGDjA7YSbJ/IsZgy+h8gabhlEiDsy0DpaxB1v1AS9oyvPm/Jy6z10QXRgUPI8CJeQlXksFzTuxRTwpz1gVOFEFqg9aHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183293; c=relaxed/simple;
	bh=eK7U1Qg0LBeGWFlE9e0UvutLv2qHcuuOfD+HYQ5fxPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ4k4P/C8WmdjTvjFlj9z1IxM4c4tPYsRdyEUL16/i5iL54dc1GENzN5U8QQofjq5K0PC1o26QoKy3vRjgggqPx9pFLGnOMPM4FOBnzlC/1JwdpT/tDbHi9PlvJI5YPkROQ2GHj0XpZZ8FUkLx6vcYulLxBeBnHURZ8ZHGSPiHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=U9O7vaeE; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="U9O7vaeE"
X-KPN-MessageId: 31bfbfea-77c7-11f1-83b1-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 31bfbfea-77c7-11f1-83b1-005056ab378f;
	Sat, 04 Jul 2026 18:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=n0FHXxZp7MxLpvcDw6t+L4Y7Ef0wpS0xiHIgwSMJZ8E=;
	b=U9O7vaeERSiBoQLKp6AT8tYhbW5hAvu2Po1xJklpwMVpA9Gdb+YEyPL+1gOdrcnTbdlivqoZppM/1
	 ri/xKVRjB4u6Tuxpti8TgeSs+/Ui0+cy3PI8nUUJ8ZNhqMVItZkxgYm4UJ1FfsNtk5rXV7tYSwAHiI
	 4XdvjiBll1jTEZa8vF1p2jNsd/kKJtMU7R7uSqLuIQl4fpBYIbAgMTalvszG441l8thISkyYRM/hwG
	 WYqyamli1o2PxFd7NcgVoCE1euV+F4l2Xymv4yJIo5lQKPhfCyQA1IshAUNu+HsKh0vvbmyX3xL/3k
	 jcPgXXVBlAfLGeAzuSf776N/EV+SFgA==
X-KPN-MID: 33|dWTzLLNLU8fklMYlGaWRfuiy0CPpz2FGx3KD1jzrsB7vTxyVMzblnUvohBLnDmJ
 CcjX9Pva7fOMJZwcF8KBBjZYvxcs1e4YBFcKF0ous+hU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pmhI8G1IUD0krHKUA4txqN2nnAHUAYucBKFTggT0vv3h14OGz5fkWZouMlVRfG0
 Mz6YKCfE2+HzdCqlwcTMT7Q==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 317334d8-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:24 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 12/14] vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
Date: Sat,  4 Jul 2026 18:41:46 +0200
Message-ID: <20260704164149.3480051-13-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Requesting write access on a directory can never succeed. Rather
than performing a path-walk to determine whether the target is
actually a directory (-EISDIR) or not (-ENOTDIR), or does not exist
(-ENOENT), etc., we short-circuit to -ENOTDIR.

Currently O_WRONLY for directories is only blocked in may_open(),
which happens after we have the inode for the target, so after any
create via O_CREAT|O_DIRECTORY.

The advantage of short-circuiting is that we don't have to add even
more logic to lookup_open() to differentiate -EISDIR/-ENOTDIR. Also,
for filesystems that define atomic_open(), handling this cannot even be
done at the VFS level, as we can't know ahead of calling
->atomic_open() what the result of the lookup is.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/open.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 9121aece78bc..87e8864d9480 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1270,9 +1270,16 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 
 	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
 
+	/*
+	 * Requesting write access on a directory can never succeed. Rather
+	 * than performing a path-walk to determine whether the target is
+	 * actually a directory (-EISDIR) or not (-ENOTDIR), we short-circuit
+	 * to -ENOTDIR.
+	 */
+	if ((flags & O_DIRECTORY) && !(flags & __O_TMPFILE) && (acc_mode & MAY_WRITE))
+		return -ENOTDIR;
+
 	if (flags & O_CREAT) {
-		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
-			return -EISDIR;
 		op->intent |= LOOKUP_CREATE;
 		if (flags & O_EXCL) {
 			op->intent |= LOOKUP_EXCL;
-- 
2.55.0

