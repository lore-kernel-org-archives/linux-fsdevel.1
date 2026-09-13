Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447613F9F50
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325388; cv=none; b=H7Hj+xu7vG3dfVIF1JAN4t++hYHdV6Ig90wMRQZuGBAVEMdghvwqIc3IvivSl8C+PrGQPVEyRBqRvJMHrJenf5GIwXcbyUewilyboZoCw9ELYooD2D7djnPPEPW9orIZEDTlpfN7PToCqoxUMUiEmmx+F9TC7aWnSnKszFcuAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325388; c=relaxed/simple;
	bh=xTMn6Xtc95suaBBQjPM3n6PoFjJzRupWsASzDVEqQBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWaAbqYjMn8ieUOIyRpIP3K2UEqLHPIHLHFkT7DVIHoKfRkL8kJvtJa5aYw/glZqT8Zs86zm/lsQG2tQEKijkvGrav0Ccp3qZp+4jeYobAyyuVChDKBaPmGwWWDwtcNo0GeuG6Z9NWdoz07YQ3tZkUN3dq8tyPMRxIrfBP6mA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=p1+8X0Jf; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="p1+8X0Jf"
X-KPN-MessageId: e1a1d730-afa3-11f1-83b4-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e1a1d730-afa3-11f1-83b4-005056ab378f;
	Sun, 13 Sep 2026 20:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=2PSPPEoGvrfvVZ6TTPZf20x7aN1ff0yNDpWtXOdoUoI=;
	b=p1+8X0Jfp6d6++DF1K/RXsxxKj2osx15SkI2q53lQtXVlFoI1w6y+8Lki5aqSqquqYXTBepVZLJat
	 LxCSqvdqUMBuriYeW1/c/rD+q4XXBzZJpZ4drLHSHhuv/fqte9e5W5j9U5MiES7T+yxr8cLUN1aCr4
	 2DFCtscTPPy8XFFItOrOCra/DpUcFM7e+Z2TkLnKHPfS6j3kdp+S4WklY39G4wGzw6o0dznJGqy0rH
	 bFTd8zVbkTeXN0J0AJSm7i0fdguaJTNOfoPsiPiYNOC/jR6u00usWUuaiBd9D5JD9iXQfZMRSLH7Nu
	 wB1RbOiwIGy8FSvX4S1GGprBonhrvyg==
X-KPN-MID: 33|46oqDKJdgWIbw8NdzWltlJ025bVsM19F8dn5TEgzi0o/jh2nxOeNo1IwJFKcRti
 NTWIejy2WsRdNjoG87yjANTl9N0NqhngTrttfYqnhARM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|hkCPKSVq2auj0IBpub8LXc4zSTrEJgitzmHQtqzXvC5kZ1v3mpK3aYjDbI2I+Au
 99aICGj6I8gw7WTd7NbuZCA==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id e167be68-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:42 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v6 11/12] vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
Date: Sun, 13 Sep 2026 20:50:15 +0200
Message-ID: <20260913185016.523376-12-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913185016.523376-1-jkoolstra@xs4all.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
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

The advantage of short-circuiting is that we don't have to add even more
logic to lookup_open() to differentiate -EISDIR/-ENOTDIR. Also, for
filesystems that define ->atomic_open, handling this cannot even be done
at the VFS level, as we can't know ahead what the result of the lookup
will be.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/open.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 189af02a2425..6cb5e2ad781f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1319,9 +1319,16 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 
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

