Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE72264DB
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501239; cv=none; b=hYEB+X1/2aCgdiMfkwiow32jduTxuzhJRm/e2SQDV0f+Phz4fLowBTvJeN+ylLvTc8SNZ5joecmTDmTwcq97lor8fJ/wt8WyBFmH4uS9e+ZiEpUD9MUgKAFjAODGqCfABaJquj9TbQYIq1BWGIgGogG9kUgqmcl3GMmBe3CvdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501239; c=relaxed/simple;
	bh=Gt7onBZYdsy3Yfo0sqgPFGC6QywXWs1vSnStSHJwcdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCAYMFXFlffhOJrOR44OmDh6tnBP2z4DwlHXV/YeooeMy+DOMXtQjCvOHFQN82IYOkmQ/ZmIs7nT01JXEPwxLSUK9HlD1B4kMj7Q7sbdCfXbV5utbamlOsgEIayv/e43+DFUWRUJNhjKcH1y9ao3VizX/lu2aZB/rYfS676V08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=QrGDaGVt; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="QrGDaGVt"
X-KPN-MessageId: 8a8036bf-9f0c-11f1-bfbb-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8a8036bf-9f0c-11f1-bfbb-00505699b430;
	Sun, 23 Aug 2026 18:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=8PZtSq/HzqhQUrRAn5vv8dn6sAMc4aVq0EPLcAO5uts=;
	b=QrGDaGVtnd6OD+Fh0RpwJfVdYc5SxbZnZYzho/AtpvKjOKWqTWEjjO+kB58OOUaeibgiv9BkvT3I8
	 xq4NWWMbnycuKscNKepPB2Iqt6c3Z9d12RD6Jz/r1ZM5QB8DgyS1VUH3GCguQy8TSlBlu88RcFi4VE
	 D9c89KYY4aUxh0vieedWYRMlPmKWZZwkkQrv9PMnYRJVIzRqs6B0kTWZTq5IxzmZNR/5cAsULtojCA
	 M2Ekx0LR12+PJR1C91N77gYsoBipllWt3s2tpooj7vtjyyPx/RymaLkPVWQDnuEj8efHKL1bCmkvV4
	 n/1Z6bHDGQEvwzFFrUFVCrg2GyiTEew==
X-KPN-MID: 33|NWSVPxN5p+oPHBLhuIH0zet2uNRK6N6aeanbxOCc+lHXvDP3DBquXez943+kou1
 IFhgdScBiHF3+pShPW6Pt2mJdi/fvF9XwYNr5aAu9Pz8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pVczlwtz4mTe/fZGcFWPLoYPVk6RnkKBZ6uoF+E9d0/oA8F3430V4HNgVeRInED
 xCR0kdM2hh238fEvCjkWSRg==
Received: from daedalus.home (unknown [178.231.250.211])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 8a499a4a-9f0c-11f1-8ddb-00505699d6e5;
	Sun, 23 Aug 2026 18:06:03 +0200 (CEST)
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
Subject: [PATCH v5 04/10] vfs: move ->create check in lookup_open() to before try_break_deleg()
Date: Sun, 23 Aug 2026 18:07:00 +0200
Message-ID: <20260823160706.358293-5-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823160706.358293-1-jkoolstra@xs4all.nl>
References: <20260823160706.358293-1-jkoolstra@xs4all.nl>
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

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2aa18efa4e04..55ba23f95c5b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4576,15 +4576,15 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
-	if (error)
-		goto out_dput;
-
 	if (!dir_inode->i_op->create) {
 		error = -EACCES;
 		goto out_dput;
 	}
 
+	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
+	if (error)
+		goto out_dput;
+
 	error = dir_inode->i_op->create(idmap, dir_inode, dentry, mode);
 	if (error)
 		goto out_dput;
-- 
2.55.0

