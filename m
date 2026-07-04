Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F120372EE3
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183294; cv=none; b=k/frM/QVHrF3+9UAeggUmPipjJEkY/j3ChQh1fGzziOrIWbHbGZkWHFWjWfHtcI8bZmDfiXiQi8XwqSwG+oUCy+ORfY0fyQxgQ7oMajLLhHfWvqYG4DgzO7VBtCLtb9bo3RSqITgwX/4yiaChj013zk61RgCId91Yn13yDT2l1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183294; c=relaxed/simple;
	bh=1QKtYUmu8q/HWjVbbJIVz/0RMDyV3iKnajm3Db3L9DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn9TpbfgwByHTddelgFKCR7XFxzhAqatEFcu/Dv8Mq9aXozGi6ZSgHx3uQN1WJEuECVEPE75i09W1+sNnkVchhM2jrbAlVmHy+ImNQokcHk6aTnXeT5UTtTgH5xcVHb5V545kaGwvJfYOIZ6pTZ+AVRB3PDmOm+QmG/+o/AyIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ZrzKLYni; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZrzKLYni"
X-KPN-MessageId: 2ef23137-77c7-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2ef23137-77c7-11f1-861c-005056aba152;
	Sat, 04 Jul 2026 18:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=nmJfJL5aIKkG516hFBygMhA360fsiR+gFeMro6rPD5g=;
	b=ZrzKLYniNPCBdeEifOw3UCjMosymhdGzJf2CqXYqw7ZspOKdwa7LTraYo+LIsGyyMir3fZr539tiU
	 /TLmcaVLK86f+MuUGyK9KLVzUw2Jec1OcM7ul6AkcKfxqJVmA1jpkltheOjbM9gL+0XNqhCdcnyyG3
	 siBQMoYBOes8mO+tta6LjiyBAQJH/BZBhR/cs1sZof7jGrkDJBCvkOZv8k1W+JiuSz/GE/K4FDk1Zm
	 9F6O+tWDafZ6Fq8AmTdW4Y7u4cpGHXzHc9sk1KdwVVo146qNSah7TCnwxGxhsURfoqNGYdvWvMuPTy
	 joxaf3+hYpeCrCT1DCa8qHfnu8s9GdQ==
X-KPN-MID: 33|zguQ3ukVrHHmSFdlcbXw1pOxHVmVoW2oE1RMsCmT+cL0zlKiCNrdOVf0zf/ld0K
 YTSJiYwdE14A9zJ6vqmq3qg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|V5Gvte8mbYWesIzRP5Em7PL41nCPwQCe0wvWULSVdzsDH1Vkkni797QN3AU7glH
 1UinpJXqXDAmIZY+IGhZnDw==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2eafbe58-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:19 +0200 (CEST)
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
Subject: [PATCH v3 08/14] vfs: lookup_open(): use vfs_create_no_perm()
Date: Sat,  4 Jul 2026 18:41:42 +0200
Message-ID: <20260704164149.3480051-9-jkoolstra@xs4all.nl>
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
index 6601460d2772..eaa0ade4a1b0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4553,16 +4553,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
2.55.0

