Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9EA43D4FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747419; cv=none; b=py/V4vgHI2iVD1q4yUsWEXp4aEtBoRkPHp+wr3CzV7aehtw6mYHwdnSL57VEu8/JLCB0eOjqeGBwgXK3gO2mKU40KygENylrDZkU1ulcBAMx6xqrxhO7Tlu3n5lZRnBGLrqIQuM5mRTdC9KToKjNmHa+VyeE6Eg8CKo0RwZf4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747419; c=relaxed/simple;
	bh=9I6fA3vnYaPDr6xwcu2DqtDSei+6PyQguQznq5rNnt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRyZD53QNZXoNtmimj3Ebxr4mYQnULtFOGBLv+gCJhyie6dZmi0t7hUJ+okILVFkfWyX6t2AQQxl+X8aqV2yz4JVdKNCyAr/XBxxOpM3feke9tsHqzCxMxjgfpZ81MwEo2ATxMdo2Vct1lZqQbvHz0HUdHEZsmAZhahVuIaSP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=SQEfYY4p; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="SQEfYY4p"
X-KPN-MessageId: 33ca6b4f-73d0-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 33ca6b4f-73d0-11f1-bfba-00505699b430;
	Mon, 29 Jun 2026 17:35:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=PtZwkNCW/5nY5d8mBTmyPZGJH5KWES5QNvMvKmYnLhA=;
	b=SQEfYY4p2q5BokL11eeIXvhXKeKfkmCOvcRsAcHvHMhxOaaOmVUPpX9gB7I/0po+OCMQHtmosGFb2
	 4Xi52dgu81dR3n7FZz6t9i04KyU/uqGc7HML9hqpZsMARhdWS5Bi5RXo7sypxRlQMpkDN20uXXr5+5
	 T5HMCt3tXIWyw4SsVbCLze1oLVA8tEvr9Mx5aIHcgtwL8502xDRCpR/P0dXUPmlp+6lwaZf2CoPzui
	 pFzBxbWOWQhmjmf+41wTTD8nYwMrmTp1Aeji3VODabdn0NCLos5+Wv0jNp6puIJQ5qB6id+/2ZN30m
	 P8kc2wJv6zqqNalAYODdrCu+QCy3PZg==
X-KPN-MID: 33|B1aXeAPGroLhIJy8Wh016l3KQ8Mf2BxShy9KWSqqHpJx5pDgwfHkyUt0g8Jukhb
 RMIUSeCfRBDEnNGWc58TiUFQtbx0DbgZTCxi0camltQQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Ndg3GtuZSh5TCnjTD3c1iDHvVw+g5sHgjZ5IoNiLg2ZUZmOB7b3CfAu7vD0G3cd
 poUuSrBiSrAQ4BROc5cEe+w==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 33956459-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:48 +0200 (CEST)
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
Subject: [PATCH v2 08/14] vfs: lookup_open(): use vfs_create_no_perm()
Date: Mon, 29 Jun 2026 17:36:24 +0200
Message-ID: <20260629153630.2158649-9-jkoolstra@xs4all.nl>
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

We can replace the code in the no create_error/negative dentry found
from lookup case in lookup_open() with the vfs_create_no_perm() helper.

It is safe here to always pass excl=true to ->create via
vfs_create_no_perm(). Local filesystems always ignore the excl flag,
and cluster filesystems implement ->atomic_open, so that the ->create
call is never reached in lookup_open().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 063d40d5753e..b1b43c85651a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4551,16 +4551,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
+	error = vfs_create_no_perm(idmap, dentry, mode, delegated_inode);
 	if (error)
 		goto out_dput;
 
-	error = dir_inode->i_op->create(idmap, dir_inode, dentry,
-					mode, open_flag & O_EXCL);
-	if (error)
-		goto out_dput;
-
-	fsnotify_create(dir_inode, dentry);
 	file->f_mode |= FMODE_CREATED;
 
 	return dentry;
-- 
2.54.0

