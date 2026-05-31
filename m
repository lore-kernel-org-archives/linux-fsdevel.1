Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35B394EA7
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251660; cv=none; b=FxplPvFWsHr6ivAFNtHi+qxJqqY5Siq3bXaSl2W2LI35rTYvWthFlVH7Pbs5rwvdpfwpdjvOXxoENSk05a1aM57gBKSf7aGcr4NgThVMF4NprQkTlFS3QEJq9sd/gs1ZZxTpO9jHvmt0FQ7P8V4bW+VQx99x/LvjbJcc0u1Ht1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251660; c=relaxed/simple;
	bh=ft+9yq72KJdD/sjuEoB+DhVJkKsT41kLGUfS9mNA/ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oV3oECH+ckjtaahuAWKgaBou3VMheWquLCRRXt3FQ1wJYsniYHwX66Y47uT0zt/asVZGLKL+1FnYkcDReUNao4zcWXXyD9xeKDVXu6bC4RbaD7MSDOOLHus2ZIu2adYCqhC2UhyJ76BxS5/QX3v4Fm1nB38LqBhPM9pHGQtk24s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=hfYQEFqI; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="hfYQEFqI"
X-KPN-MessageId: 507b806a-5d1d-11f1-96a9-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 507b806a-5d1d-11f1-96a9-005056abbe64;
	Sun, 31 May 2026 20:19:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=L1JI9rT8lcqw7yTG/hZa/LYzcpZYPHY91GUQ2FxpbBw=;
	b=hfYQEFqIDy4epi5eefEHXkuuKFooBodLagZIw9+yP/yaYpBBAErjLyfDUgw3KbXsCOCsK9jjZFIEq
	 h+DJm1AFNJog6l8n4kDKYIlnI1ThcKf9zSXaldilesniaK4FAmqXIp3nlshrGzKIInOJL+XobxJiSB
	 n6Ct7anY7DilKjGOtzX4b4gyl0XkktatQ9aTDUqhLs50ooA52pDc4hvIhZBvtspWqPsPil/LZeYjUt
	 sSBQ3BntGclkxo6oUgf0BTjdIZYeXIzOa6RJR4BClEvIue7h2R462HptzGO+O2SVqwBojqnrpbiCiZ
	 CK7MuMVo1YZcNdlThmG+DQXdgzAYu7w==
X-KPN-MID: 33|1V+7mnPA12pc+J4sY5I1PKRJWaUYYa/u5H9dehUrX8NcOqufRTfi0GubfB7ABP/
 Hp7WafaNj5eRL3mVHDc1IWjBjK83yK9EKp+G7j5lXwA8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|42GZKuzmEJbp6p3rqqF/zylRA4b9REWOhWDBS5djRNI7Hj4AUJMQL3IX9GesYae
 ya1q/MKjbjcMN+Iz3cLfg7g==
Received: from daedalus.home (unknown [178.227.141.146])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 50319ac2-5d1d-11f1-8011-005056ab7447;
	Sun, 31 May 2026 20:19:50 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [RFC PATCH v6 6/9] vfs: lookup_open(): use vfs_create_no_perm()
Date: Sun, 31 May 2026 20:20:42 +0200
Message-ID: <20260531182045.171711-7-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531182045.171711-1-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can replace the code in the no create_error/negative dentry found
from lookup case in lookup_open() with the vfs_create_no_perm() helper.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 293592a4d011..a8c247e0bb65 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4533,17 +4533,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			goto out_dput;
 		}
 
-		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, delegated_inode);
+		error = vfs_create_no_perm(idmap, dentry, mode, delegated_inode,
+					   open_flag & O_EXCL);
 		if (error)
 			goto out_dput;
 
-		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
-						mode, open_flag & O_EXCL);
-		if (error)
-			goto out_dput;
-
-		fsnotify_create(dir_inode, dentry);
 		file->f_mode |= FMODE_CREATED;
 	}
 
-- 
2.54.0

