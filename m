Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B83AA1B8
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878911; cv=none; b=k85UwOTrlz2RjehBRv1AKz8jhAl08F2stZq80TpwnqMWTx7t9GdcAxaDPV8EVUeYYpbo8bIUyOGXlJiAmxaW8nJanHLvZoIK28ajrN1BZGAgG5F6pq0rEeJAzK2VWgOf4I5gUEYEieo4THobLmjSkiVOhd81jZl+RTnRvGROVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878911; c=relaxed/simple;
	bh=0yOpKf6tauTKVrZ3MskO8jxoL/B/foDdZEWjYmHc/co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uF3vd1Y7uPwpAqbliqvZbuQIOZ9HN5XjYm1zQh3BZoKk0iyTv/MnQK2eIALUP41XxxhsKR/RugRHQX1sM2cSAjdN+7rDn0rWuQJ39GJgbMvb8WpuyQHOVp/qqmp1cGr4xotuxXdZ6pFLciYt6i7M89AoGEULUkmcJVr0G+RHQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=BtMhTPfs; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="BtMhTPfs"
X-KPN-MessageId: ce83ac83-7e1a-11f1-8f54-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ce83ac83-7e1a-11f1-8f54-005056992ed3;
	Sun, 12 Jul 2026 19:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=0dXj08FzOLdO3c5dt6t8xpXist1W3wr1WmEpW5zQyPg=;
	b=BtMhTPfsB2KP2tLX5IJ1PaTxgiFRLx6Y+xtFGrISdc3LBfUVy9SSTGoQDgvYYSXoM+BcMzQmAICTv
	 V5K07OxKCIdHMyVHIHu1IVZL3jtib99trnkhKd5gGyk5Ec7nqrQ8cqEW5MadSCHTFZiHccUImB/Aqy
	 yNYOzXtQQmHFgAPlIr0tcrqIczaRDZxWbyY8nCUzrtWH6c9Z8huFBbQjxD4W/ExQdWQUX9uOndzWfQ
	 rUJjytVyLYICpqW4YMkIcw+bXjj4P4T/io9qkfPQth1It3zCvUlX6dKPLHIclRkcNzkvj/JbvLkYHk
	 JpQfzUNGsh27K4dVMosOw+I6DuV7ggw==
X-KPN-MID: 33|x1L+9/1Div3P7pMGcwlQkZwmoewgAYxtrY919685D/O4Kbaq/nXJhKt2KSYhIL1
 X41IdAC9tAWA/avlkJ0ZJ6ts8Ga4CnTAfFXTaH2EYAKM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|FZa9YyVh1LsFcCg/hzzoJICzqs3c9cOZZTY1Z5/y1Xr5mHZ+aBe/UONFgwPdsUF
 E5QVwHdN8U1cr2s5oYPIIpw==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ce57a63f-7e1a-11f1-87f7-00505699b758;
	Sun, 12 Jul 2026 19:55:02 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 09/10] vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
Date: Sun, 12 Jul 2026 19:55:38 +0200
Message-ID: <20260712175539.1565444-10-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712175539.1565444-1-jkoolstra@xs4all.nl>
References: <20260712175539.1565444-1-jkoolstra@xs4all.nl>
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
Reviewed-by: NeilBrown <neil@brown.name>
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

