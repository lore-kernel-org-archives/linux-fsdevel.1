Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F2395AFA
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455432; cv=none; b=h6s1CGhnw048ovi7V3+IR5+Q3DVce7QVwDOqrysPd4wk7r2CSRZB+s0bh9SPYLXccIucCLSXItyS+mMSHSlB2N/NZ2n5KfyoQBvf49IoPmJPeorgo1HVgIICCcwSLEO3rmMpeYdZQ3BlsDxKOE+G4mqhZ06LqBuVj4e+zAmbxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455432; c=relaxed/simple;
	bh=e4pLI/8PW4wuIH8vDQAV+1w2fWzNhEek9QhIqwFKRu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lONSOjRW1c9Dum5HJ7oec5ym0TNTLYpbtVCikUQns4DDxRpgZ+jiytjUVaPRne+lKxBAXWmHB+UN3Qaw2cB6pg0sRvX2AyC1DZBn55Oo5IsHeCaG/ySaZr2IP/K0qRsF//T+1Znt7TuDDGNPrgqaDXozXbL/TV4vBVImu49fpVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=IYP3QPVH; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="IYP3QPVH"
X-KPN-MessageId: 36f3e77a-6810-11f1-96a9-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 36f3e77a-6810-11f1-96a9-005056abbe64;
	Sun, 14 Jun 2026 18:43:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=yxkD9XzkBoMcdOEcIJcsFS8+zKxNhhVUfjQlDcYlGjU=;
	b=IYP3QPVHCX8s78/picZJenU3jA6mBgo6NRnqOINFhjPpvI+UEJlPFiuG7mP0365LjpkgmvmTT5evP
	 OaeNtN6jQKEq3sfY9WZbzIepCwUNK6l1sJm1E1A4q6BesnL46AtX5w/GBPyrCyJeFFFctgHF3YT4Vq
	 MWWEHkZ82Jvf7v9QadVcf7w9vcsRx3vtMRhTAxU9e+tzGlwsKCoAaUXVW0Vqt+l4huBxpCPNlRWQEM
	 2K+kD4TK1b1M5Sh7DfFTSW4PoY/J6ezHlNJXXfcdStd5NIpkf42h4mYN6CaHWAn94uPipVrfAe8mvS
	 7uVZyn4tBnj8h5r/aAfVRqFgIuGuS+A==
X-KPN-MID: 33|MlNBSDDgTrwdTyeeBVDo6IImG7yxbX8GQi/QktbphEgxCBPKqkvURFvzC/cCqOU
 9NcyG6zwC2d7KHFod02W9s1CzF0TOmQGjeFcHv8VthAI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|c8et47sw+iAbo57gGQFeqDMRz7/j2+2mwVhWV//l4QVLB575P+8MIGPuZJ0T/Yr
 +anczE3QR8O/FGAFuoO/BIQ==
Received: from daedalus.home (unknown [178.230.193.94])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 36badf6e-6810-11f1-8011-005056ab7447;
	Sun, 14 Jun 2026 18:43:47 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 07/12] vfs: lookup_open(): use vfs_create_no_perm()
Date: Sun, 14 Jun 2026 18:44:33 +0200
Message-ID: <20260614164438.2980769-8-jkoolstra@xs4all.nl>
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

We can replace the code in the no create_error/negative dentry found
from lookup case in lookup_open() with the vfs_create_no_perm() helper.

It is safe here to always pass excl=true to ->create via
vfs_create_no_perm(). Local filesystems always ignore the excl flag,
and cluster filesystems implement ->atomic_open, so that the ->create
call is never reached in lookup_open().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 15bf28b85a4e..50eb357fc0ff 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4535,17 +4535,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			goto out_dput;
 		}
 
-		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, delegated_inode);
+		error = vfs_create_no_perm(idmap, dentry, mode, delegated_inode);
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

