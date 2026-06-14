Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7012C3CDBD3
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455501; cv=none; b=mOH254EcTLtBHwsuim3c/CEl2xN36bWVzfEPN3pv2JHbgZ7i06F1hx05HZlao95Rxq/CUP2oGZOGm502K12sApsFcRFznvui1uW/ylZyKDSscme+EFM3nkwz7fKalJXC03Y5dbdPEvu3ppUVQrKEFlWD27jgwGsBBAcSVtcZYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455501; c=relaxed/simple;
	bh=oG8HTAFvC0YvzstFkzCEyyxFE0XK09drCp59i6gFHjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9mQ/Ti2NUfZHcOTRB2fihrvJ0qKGVjfpknfy0UI6DHlGN52GoCctVoEXm6rJ8WHd/im4G7gmNKzDo0nl+zUIx6O3Gg7l16VY2Afg7xHT/ifVjwgUvYooLZFXxztMpBKEfH9pUU57zPUyZufvqmF1en30Ueq7WLhpp7OSFtbMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=sbF9oGtO; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="sbF9oGtO"
X-KPN-MessageId: 3839d7b9-6810-11f1-b18c-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3839d7b9-6810-11f1-b18c-005056abad63;
	Sun, 14 Jun 2026 18:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=XJy8VCbNENbNNOYGkmhc516O50OO7swmOez7pVuWluA=;
	b=sbF9oGtOOCKfEf2jk1f61IM9RYMar2rmsAAbfB82XiAGmm2eCw11oBTpZhbF6QFz29jrNJG+sQbef
	 mTUQF70SIs7X0MHHvoIrYQzHTpeLAfkC6Kd2vMziTykbAny44yMv6u9x/0ij13LuUvuWkrEAGVWUR8
	 C9SFQoxr+DZXQE50NkE6ak/GdJFkjpJtma0yEEzEVY63qrZrGpXeDy05JDheXyzRRaksw8fakecidN
	 dH/00F9ZqSqUqQ9Fj4zJF81BRVAp4hu3SlbrcFjXxGNsUbe+ojC4PBGXIetUlhzFkwSj7kw9bzZXno
	 Z2F2Vdb5RHuZNec8rvF2KWHJC8TSWQg==
X-KPN-MID: 33|xcSYSZt8lJvuHCy7Nck1lJiuYtv1THMizXp+WDXfB0Hb9b9YnNB08jGZbkQhzbV
 i/vuYPKrc9sA5ZMl2WuxatwJbIx896Ekv422ByStBOpA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|dmeKvflViKbo3t7p+Ktey6gxNULDvrPdCkc/mqjFyMjFOHtwcIFoLUEoh6/MJuU
 NTnymMDDXZsBAttavF26Lcw==
Received: from daedalus.home (unknown [178.230.193.94])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 3808ca79-6810-11f1-8011-005056ab7447;
	Sun, 14 Jun 2026 18:43:49 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 10/12] vfs: refuse O_CREAT for directories through a dangling symlink
Date: Sun, 14 Jun 2026 18:44:36 +0200
Message-ID: <20260614164438.2980769-11-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

open(O_CREAT) without O_EXCL follows a trailing symlink and, when the
symlink target does not exist, creates it. Refuse to create through a
dangling symlink for directories.

In lookup_open() a negative target reached with nd->depth > 0 was
arrived at by following a trailing symlink; since the dentry is negative
the symlink is dangling. Set create_error to -ELOOP in that case.
Reusing the existing create_error path strips O_CREAT for both the
generic and ->atomic_open create paths and only reports the error when
the target is actually negative, so opening an existing target through a
symlink, interior symlinks, and O_EXCL (which never follows the trailing
link) are all unaffected.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index f91de2038321..6029259cc9bd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4530,6 +4530,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 						    dentry, mode, create_dir);
 		else
 			create_error = -EROFS;
+		/* Refuse to create a directory through a dangling (trailing)
+		 * symlink. For regular files this has been allowed historically
+		 * on O_CREAT without O_EXCL. */
+		if (unlikely(nd->depth) && create_dir && !create_error)
+			create_error = -ELOOP;
 	}
 	if (create_error)
 		open_flag &= ~O_CREAT;
-- 
2.54.0

