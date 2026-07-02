Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058213A5445
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990954; cv=none; b=QNPnJ+Qol1/v4Jbf+lQ87gvCafhEfxHZr4vfAfblYrV8j8Pm5UCym4oRWwNphIlktaGME2zffbBg2P1CeGoZCbjDPsAR0+nA/Uz0Lr57jk83ixHWTaJ2nblJmqjfDYFdUXdDJcsIUHjjE2Y+lWkIOyoRgwB4jvaR+Kblww014wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990954; c=relaxed/simple;
	bh=o3L8rAPHiy/10eQII74uqvkHypZ/DJEOuDz8+/vV5nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrfbBIsS3ynIokRLN6ZhLOQ4KIXo9m/Y9rbPu7+qkPHUbRqWRLTTGTvrWgMTeOsYENjiz7AGNJj5GEIrMbJrVXgKcQlohvdhwias4RKQOwBybN03Lhe09jB4TuRhlp7zv1z3yHkJqCXjmEbEIbVehJPa8oRvYQV7SSQpCu6lv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PH54OQ/K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dFqv5VZx; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PH54OQ/K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dFqv5VZx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3BF84EC02C0;
	Thu,  2 Jul 2026 07:15:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Jul 2026 07:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1782990952;
	 x=1783077352; bh=XAcEQ6cVFr33H2ISpoN2Lk9eyeaITM41VfCB9z/797o=; b=
	PH54OQ/Kq6x0pEG1rpsERBgYDpGSsw3XEelVrdf0wsXoVJM+ge+3SyrbAwReiB9n
	S2XMWBTPBwkBVfZ7w4LtHU0LAznyFV3wMHVaphsQC1hLbRNrvXPyrRJCaVbZqPRb
	Ru/XEJDny0tPGrdO7MkJMQwD/Vf1y1QSM9RNcixv4WGQ82dfDxse9fDx0QiufVJL
	RwlA7L42xIwLqHoyUbYG3hJrCALZlpriyBhvdd1sZdjY4Nl/7NgXSFfSersn8iuA
	KPyS0G8ezj0p9PQ4HdGxkz1uIq128xmNRTBARGIUyyhbzd2QoWhmM2nDI0KyiaRH
	9Ag5tApfl8H/LqDaU5V+4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1782990952; x=1783077352; bh=X
	AcEQ6cVFr33H2ISpoN2Lk9eyeaITM41VfCB9z/797o=; b=dFqv5VZxYHiMhSf63
	RPf07lCHSl+0jPAr3zGtKiK+X6KrgSlYTHqQYS/OlfGh9uGnHnV0tXSqDOz0Toa1
	XUac3aGvOwR1lm94ovSc2RF1ScTiTQNgIqrbAL4xdq2mwygaJ+9Mr+UwI9Pyw6Cx
	ypbf2y+Tycjgsf4FQgak7y3aTp9wLsz1teR0AoqX03rZg7EItVbKkbGCZQJ3COAs
	PATyqKmx2qoBxNWAcR4gQL8Eczb00Ie3uzgZXGqrapQcYlBXkGP+f5tduGhwfDUZ
	2CKCIG3GKv7K6GLetJkMPWBsiYWTqDeYwrvnqHdkJxlMjukCH9rbieurhcFjOoCK
	+JCQg==
X-ME-Sender: <xms:aEhGavaizvnO6y7WCURLBg2V6QoXFMACDqPeH-dk6y-2EC1i7GKmHA>
    <xme:aEhGanXAKJbb_JUI3AJ0ZKYSRhz1xblBD1gUeL6vKgiHOKqU9IItxnEoXd5RGk1uc
    f6c1q9uYzLU5dxuFVQ-mL7Yz3wwX-BAMZIrVbPXVXnNcyBhFw>
X-ME-Received: <xmr:aEhGathXWMTN8JF7pXPJ1zIfghhqObVj0WY0SLnFRXuwvzH-EUXLwlyxLojhj08AAzq8aJeBufJ_oQ4-FpPe06ZMCEOuO3g>
X-ME-Proxy-Cause: dmFkZTGAj4tPrnRCfABz+6tzWcP/g5MP0zOCQZK/BdAi7s4Klp5HDo6JKm5ohTwOS54M/E
    /csJlXbNTXDnGVXZ18fXudwJ3FNp2FsiUIyhax9Yq7AVZ/FCBG4TDE0cKHRhE4Ha3CsPEj
    W1y7WOTvjM5jElEd6PoLy9qb0HQi+qY0CiNrM0z/rl/BswrK0I6DZbHc5/1lHsB/3JNec4
    RRJ0iHzthWxBUN0NmYHA7C8N7wV/hHuSD7h9BwEcq+QKECHA9rJcyawIeNvsNVt4HTW9GG
    /7j8L6DTHAljiBamtx3ZF2oSXY3W9ucHLbCINvC5BaudPluw0Umo/U0S03aFU8w0HrZ4hj
    pDqWzwmC1DXzzaALAipQavpzF32Ug60nK3hsA++Vt9GM6T5ESa55kQeJTvadAmtAAFqJYb
    usqNUzGeU30BQB3lCLFcosj1ay0BUAhsTGRPBRdqY7MFcFW6LlPSNTsKC1Bzm8rRDZmGpX
    ekUMXsyNUbJ9KbLg3q/l7syca9xoOzII0cIGC1Xw5R+snv3emfG7yte017BbQC52Ei8yw8
    MJ6mjcZdGp/03XRnZ8kzoFFmxfqlY7Si2stqhuE6tT2DlGB44p1Q50BB7h0tT1TmwjYO8Z
    tgELPoVcyaVBJJ6ogYBwC0qlSCMJ7CeQ/czUHsY3hnI8WPWib31ZG5HlU1Sg
X-ME-Proxy: <xmx:aEhGalu4Gjt6CR9IQAplv4Qq6Y49ywNgHJsStx0fyI6ZKZMuGDvdGg>
    <xmx:aEhGam6bqVLOey2Xbg7vl-XPrmqV82-A1qflpwW5qOPaHxGWgMPclg>
    <xmx:aEhGapNxMSVuWJqK6FEynx8BR80slDu04pEKPsHdx8gJvn6vgcBa_g>
    <xmx:aEhGass8EdZo7jBBCFPTrsP_lNjt_i_KDeoS7tXE5jEyq844IaZMVQ>
    <xmx:aEhGaq3ieQx2QBYP5FDfRobekZl6LTiEyujepapVbUgvSrrJiKxtJ8rU>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 07:15:50 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 2/3] VFS: move delegated_inode retry loop into lookup_open()
Date: Thu,  2 Jul 2026 21:09:20 +1000
Message-ID: <20260702111529.3559835-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260702111529.3559835-1-neilb@ownmail.net>
References: <[PATCH 0/3] VFS: replace dentry_create>
 <20260702111529.3559835-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

By moving this retry into lookup_open() we no longer need to pass around
the delegated_inode pointer.

Various variable assignments need to be moved out of the declaration
block so that they can be repeated after the "goto retry".

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 55404fe0e269..cb33a01d16eb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4397,17 +4397,23 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
  * An error code is returned on failure.
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
-				  const struct open_flags *op,
-				  struct delegated_inode *delegated_inode)
+				  const struct open_flags *op)
 {
+	struct delegated_inode delegated_inode = { };
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
 	struct inode *dir_inode = dir->d_inode;
-	int open_flag = op->open_flag;
+	int open_flag;
 	struct dentry *dentry;
-	int error, create_error = 0;
-	umode_t mode = op->mode;
-	bool got_write = false;
+	int error, create_error;
+	umode_t mode;
+	bool got_write;
+
+retry:
+	open_flag = op->open_flag;
+	got_write = false;
+	mode = op->mode;
+	create_error = 0;
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
@@ -4505,7 +4511,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
+		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
 		if (error)
 			goto out_dput;
 
@@ -4539,6 +4545,15 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
 
+	if (is_delegated(&delegated_inode)) {
+		/* Must have come through out_dput: dentry is an ERR_PTR() */
+		error = break_deleg_wait(&delegated_inode);
+
+		if (!error)
+			goto retry;
+		dentry = ERR_PTR(error);
+	}
+
 	return dentry;
 
 out_dput:
@@ -4586,7 +4601,6 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
-	struct delegated_inode delegated_inode = { };
 	int open_flag = op->open_flag;
 	struct dentry *dentry;
 	const char *res;
@@ -4616,19 +4630,10 @@ static const char *open_last_lookups(struct nameidata *nd,
 				return ERR_PTR(-ECHILD);
 		}
 	}
-retry:
-	dentry = lookup_open(nd, file, op, &delegated_inode);
-
-	if (IS_ERR(dentry)) {
-		if (is_delegated(&delegated_inode)) {
-			int error = break_deleg_wait(&delegated_inode);
 
-			if (!error)
-				goto retry;
-			return ERR_PTR(error);
-		}
+	dentry = lookup_open(nd, file, op);
+	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
-	}
 
 	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
 		dput(nd->path.dentry);
-- 
2.50.0.107.gf914562f5916.dirty

