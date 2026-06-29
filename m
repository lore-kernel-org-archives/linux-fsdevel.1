Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6D842EEDD
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747359; cv=none; b=TUj1xMIW9ez2oGckuzzxb/ODfun5C8nhBHCa9R0hbm1eGPkZFg6lpwePJx0ee+HScpl5zwHytbe4LAE0ooJn9mbeXYyJ9+p1wKvotcAeWM7f1iY9isUU/t0EDxE6VsF2gd0uNRScoi9aS8+f+8H6M6LkHSTFhlH4bAil5JnaT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747359; c=relaxed/simple;
	bh=2jcRJ67t7P2EkH6GggcTkhcdqb0YuQuh0Sz5XEaQC0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW+NDdwxu6eadqN9Om/tYiqCVmloQe7QsF4q9P7fDvaHL1KiYRlXlAW3xS121LBuZjR+CnzVQOWdiZJ7WPe4ucWXoF6LdKgO3pg/Mn07GZ/lEm1p5g1XYpCX5UPFggc0pU9N5mxXUdc8lo226jP2PDs1pwLwmHzO+gfyQVn7+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=d7JDvQCW; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="d7JDvQCW"
X-KPN-MessageId: 3594857e-73d0-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3594857e-73d0-11f1-9e8e-005056999439;
	Mon, 29 Jun 2026 17:35:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=5ZYmBDhLFC07Rh7wT59cU0zeMCvfCyQLcZgMr42nnJA=;
	b=d7JDvQCWpUiYJgqcJN3yNv2gFKi/GRYKc1j2F7HPKZKGYwBJ6uVZRSSGemEbOU4eT3T0vg0T7owoJ
	 Aen1ZBCjuUmHbucb1iSEOxDgSWU1gh/sgtfJs60efbQcxW8Hazxnfbk7F48u1KYfN5XASyEXyZw78A
	 jdCfggelTkXKPsspwIbkFYEOhNgyzxPjvh9SRzS12cTCKFauVYjQ2SqPO1fhp3kJNS+JPDVBBH1zFC
	 eNCUo9XqAULYPAOQYiuiAwh3eTN+KbSCGHKuw0VV8T8Vf1uYITFwosGdBIXPByegr1oNFDPJrEmIYy
	 i6lQxhjXpeAaIrkUcoKHhHrI4to72fQ==
X-KPN-MID: 33|4OWnBrIcUPE+0W2oMjyRE3S2Nq5XcKJcmZRcrtas9Ad8rtWASdrOvj7J3sWvRkm
 fYb/cA4RTtT6NcxZpdMKfXeauLUrVjZPrk4cR7TcF8MY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|MQYentOaV2UD2ar9YEpW373xSGH1sAJ9AmfxnixIPalKzZSOpRpJGcQJM/Hy5Go
 V+XiDr8pv0tOWjHkSRS+G8Q==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 3561fe25-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:51 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neilb@suse.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 12/14] vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
Date: Mon, 29 Jun 2026 17:36:28 +0200
Message-ID: <20260629153630.2158649-13-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
References: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
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
2.54.0

