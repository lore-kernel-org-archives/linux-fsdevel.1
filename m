Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50436894B
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878901; cv=none; b=RKSw43uaOyF9qlY3B6qY9rX5bsMyBkTVtfqNGg8gygije9KA8+/NMrQUpVQvx49VJaiCEtyMrPMssbgjLNJ4+565p30qbYhDq9SifKpj/HPzlgLpEYpUNWmF+k7+TwqqRWhV/g4OeaY4R52yz2OCW75iBiu1CE7J36DNQLyC1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878901; c=relaxed/simple;
	bh=35MZFXyUa1mf577Kk2bx5Uoab2PSK5f05XHYZdgt0lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIv6tiH4Bi7qGUCTmu3O+F0WFZz6aI9WwVQqCJfxD5+n1FrLnCWDxh3ya266oQS5/VaodGD92HFU/UDb5rAQIix+R4P9qdomJ/8NrXvYhH0i9soOO21o2gcUyLfE615zz+8L1rYx5vop0W43Z2GDkjUdJhpYz0X7hXPy3wKg8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=LdiZy/W4; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="LdiZy/W4"
X-KPN-MessageId: cc0883ae-7e1a-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cc0883ae-7e1a-11f1-bfba-00505699b430;
	Sun, 12 Jul 2026 19:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=unngHQ7XuHKiLSloKaFmMnBXhX63cPMZXAC31ja3FN0=;
	b=LdiZy/W4LMS4LVBsY1yzPAQHNIZa0XgkEW0h7nsx2Ufr+vxymI8UBX0NEOv66PHBd59yJHuilOXUR
	 hr9eRF2wgbJoa4DVOmgTxiFU3JlEjHJzxyA+sdln4AtoIj3hDv6VkcbD8PomH76J5Gj0k67fVnCqJJ
	 6EQ3pdb2iAZ+BKNdeHpeR5R9PcNGj4LH7lXos4dTSAOCqmGWZtJgTecJqn/VGNdxMcPAUu0kiW+uXl
	 TK0QmfdAcZ3x3syagyUMeUYWImoZJhaHvT9qhDApKwY5Gn7OK8JebaN2WaVwEY+DbQikn+qSd/umvp
	 CbjYmYTGKn8W5mLNBAuaT8GZFaipXvQ==
X-KPN-MID: 33|GTayxM4A7UTrpLKVC8UJLWwVQt0hUKEmWsF8CR9rVWOGVL9KEcOgxLRgSlbhdJe
 fvo+obN+GshS59I+NTHPuI7dfE6yMOtWRTQNnsTYzWtE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|YwIA+sILYb8w1+F+v4lrybepxO3Tz6IX+mNRxrpFqgRRnds0CeG/QZUDggHPOnC
 H/Etp1nJrFGdiBGHhOU6nEw==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cbdbaa3f-7e1a-11f1-87f7-00505699b758;
	Sun, 12 Jul 2026 19:54:58 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 05/10] vfs: lookup_open(): use vfs_create_no_perm()
Date: Sun, 12 Jul 2026 19:55:34 +0200
Message-ID: <20260712175539.1565444-6-jkoolstra@xs4all.nl>
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

We can replace the code in the no create_error/negative dentry found
from lookup case in lookup_open() with the vfs_create_no_perm() helper.

It is safe here to always pass excl=true to ->create via
vfs_create_no_perm(). Local filesystems always ignore the excl flag,
and cluster filesystems implement ->atomic_open, so that the ->create
call is never reached in lookup_open().

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index aaba03954cd5..91e01c9794af 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4525,19 +4525,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			goto out_dput;
 		}
 
-		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
-		if (error)
-			goto out_dput;
-
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 
-		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
-						mode, open_flag & O_EXCL);
+		error = vfs_create_no_perm(idmap, dentry, mode, delegated_inode);
 		if (error)
 			goto out_dput;
 
-		fsnotify_create(dir_inode, dentry);
 		file->f_mode |= FMODE_CREATED;
 	}
 	if (unlikely(create_error) && !dentry->d_inode) {
-- 
2.55.0

