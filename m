Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6122B3F99FA
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325386; cv=none; b=fw58CnHZnKGlVuxZdCADdozxq6mIiHKYydjJcHU1TwrzJ1QywZ9SL5p5MT3R+Qm0BKbzv5xSN2yOu2Un3+JzUjphrR4/33VhhhnHVxDTcDT5Quz3aj1dDUW04oMBXwwnCMTu/AWiz6xPiE+5/HdyZ4KMyRDzJEEdIQqNayFRpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325386; c=relaxed/simple;
	bh=17eTtnSWW7iGPbqJe2nrFaKLmvqhueUxRZU3/BTcefU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpuew1vbgFnyhci1EsBzR4wIs9bff5bJwslYcQZuRSSLUhnznOWmzyA3ea/x1jXmpP+/Msw1MAyyvlDrNqWvPnB0b5xy8UH26YicHCHev6NuLeFun6Ej7wbsh1cbFoJctgSlgG6eA3+OcHWwBOXCdEyUxT+d3Pu9kSLYDorL6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=fyJUPGma; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="fyJUPGma"
X-KPN-MessageId: df7a3ed6-afa3-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id df7a3ed6-afa3-11f1-b2a8-005056abbe64;
	Sun, 13 Sep 2026 20:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=VevmlAFlgqBr1KihxzNewL9ukoTBFxyRRj2gCZd4PMo=;
	b=fyJUPGmams0stY42r2gsJMgm4qaCkFPhHdKZPSuXitVWDuBJ/p6qbDz1K7t7bWNILqFW5BZCyJSYy
	 GJAdGD6y7CWx/uhelrkXASECvH+BenDMRC0/rIKUdfJgkKrHDjnKEvz+pzkDtOs1d036VNKL0jbURi
	 e3Em5Pf4BHPWp28GoDxhEgRapG5BGEtd/fpwD2Kg5J+3rKd3oGacwpUKhb/agBonyukCRruVZl9ZZb
	 TT43Hu11B1j3Y1vU+dxQu54yUH6aofj2IIbU9aS1uUEPcRRE2jL6y6BM0Ayt5EwmE2gLdNn9Xdp8vE
	 vkbNZTZAv7J5ZFTg43uvj29r8DPMVOQ==
X-KPN-MID: 33|ZwGBvn9DlFIcdIEAEEll6kuRPfWpoqVVpCb0AFjpIfhy3An8W5EycFTsIZvmQtF
 zyHAKOn5cHSSNok0dCDO6/SXqAx3OW9cTulj+HJeZlQo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|YDYG3yZu3l1PlIUtjAwE3dhDYt/ZMOcU7XmRcHFaXvvTagjHuCLdQNgOaCguAj0
 oKKbxXfMbXxmQm0JRRv5rwA==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id df44500a-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:38 +0200 (CEST)
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
Subject: [PATCH v6 10/12] vfs: refuse O_CREAT for directories through a dangling symlink
Date: Sun, 13 Sep 2026 20:50:14 +0200
Message-ID: <20260913185016.523376-11-jkoolstra@xs4all.nl>
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

open(O_CREAT) without O_EXCL follows a trailing symlink and, when the
symlink target does not exist, creates it. Refuse to create through a
dangling symlink for directories.

In lookup_open() a negative target reached with nd->depth > 0 was
arrived at by following a trailing symlink; since the dentry is negative
the symlink is dangling. Set create_error to -EEXIST in that case
(matching the errno returned by mkdir(2).) Reusing the existing
create_error path strips O_CREAT for both the generic and
->atomic_open create paths and only reports the error when the target is
actually negative. Thus opening an existing target through a symlink,
interior symlinks, and O_EXCL (which never follows the trailing link)
are all unaffected.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index a990c9c8bddf..fce3aaa37365 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4601,6 +4601,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 						    dentry, open_flag, mode);
 		else
 			create_error = -EROFS;
+		/* Refuse to create a directory through a dangling (trailing)
+		 * symlink. For regular files this has been allowed historically
+		 * on O_CREAT without O_EXCL. */
+		if (unlikely(nd->depth) && create_dir && !create_error)
+			create_error = -EEXIST;
 	}
 	if (create_error)
 		open_flag &= ~O_CREAT;
-- 
2.55.0

