Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924AB438FE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747417; cv=none; b=MY4M8j6qbxk4rMHepbs0EX63IPzGKX+8SGsUgz+OEj4NCoV7Qqmtl794EAp8DmJPar2mCCkZyicDNi1jC7o3o6CHcPDhw5AolF99ELFydmQvDcj1AEdWn571CN5H+Hc49q+kw8HvWm6fCC1qoiqSGdNUghVJTaIwCIxCGwUyQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747417; c=relaxed/simple;
	bh=ILqw1Ru+KJE2AiP0ma2zU3vq67QswPNO3GjOz5+LNhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7ZBLpznjja9MiikolXM3gHEae13QqckZ6bSTWgwpiVWuDEEO1PTxR/r353nqf60uY1mfTXHvaJ/mVgo+YWCOlvviu2IT8gpxasNc+Rh1sB4GgkaWleZPZhhwYPnKQ29cegOKvdFZb0pY+MXztF0QmwPfQi4uRy+JTzitU9D7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=btQjmlq9; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="btQjmlq9"
X-KPN-MessageId: 3349320c-73d0-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3349320c-73d0-11f1-bfba-00505699b430;
	Mon, 29 Jun 2026 17:35:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=snbzhqnvhNewSgPwaYP88BgLeOnHdEK61w7ZalV8VjU=;
	b=btQjmlq9vPmkub6Tn3GYR8QIke55EPKIGLw3FXoXJPjeZfRLvEDMVXBc/lgze8jREanbpUz4U2Kj3
	 m2TFsgWU/P91X2zgaK4VItjYIlDqB7TDFHPljbAJbAKLCL1QsvTLU7PNb/QRZ38I9t+6jVbiWv8bB9
	 EsondVgrTw96FaEM3ExECjjyzhGRROuPmEZhDsIE8cr0ziuso73h4KYeSJ0nAXUL/UeN0/Q0lxOLTE
	 mLAg2Sjgy6VV61y+9A8jePWasn1tBegabeOy5G+/sUZB9NJkVKTVDVCwLlO4OOT8DQ6nt+tjF02DFy
	 AI4DacU/Js51xp9dvw1yFrgLfEwBRaQ==
X-KPN-MID: 33|W31WNmWfo5pemXMbcQZOpuDHsuV1O0z6qpelQpspyydrD1Ef5a31l7fOBfNwoFM
 TPnZ+orN73ddnjXLi7C9A687RNGYrNF0YMXCPrJ0/MjE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|YUw0Ynbd7FroA+4/yN+OGhWy01RoCzt9Pe4dlwtOu/ojCUNX2YG7040Lxn7wTO8
 ApxyRi4veBlI2AiZSg/8vKA==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 331598b4-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:47 +0200 (CEST)
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
Subject: [PATCH v2 07/14] fs/namei.c: lookup_open(): move i_op->create check before try_break_deleg()
Date: Mon, 29 Jun 2026 17:36:23 +0200
Message-ID: <20260629153630.2158649-8-jkoolstra@xs4all.nl>
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

The i_op->create check in lookup_open() takes place after the
try_break_deleg() call. This does not match the order when doing a
regular file create via mknod(2). There the call order is:

	filename_mknodat()
	vfs_create()
	i_op->create check
	try_break_deleg()

Move the i_op->create check to before try_break_deleg() in
lookup_open().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a7e179366703..063d40d5753e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4546,15 +4546,15 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
-	if (error)
-		goto out_dput;
-
 	if (!dir_inode->i_op->create) {
 		error = -EACCES;
 		goto out_dput;
 	}
 
+	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
+	if (error)
+		goto out_dput;
+
 	error = dir_inode->i_op->create(idmap, dir_inode, dentry,
 					mode, open_flag & O_EXCL);
 	if (error)
-- 
2.54.0

