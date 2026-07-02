Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949B2E62B3
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990950; cv=none; b=jtQz3O1xcdvQuepnBSDD4K8gqOtTO5U/DlXgsD0NM5yJQg1lg+IOVk00YgkUsYBXecMp8Y7FSinzco2GlccO9W2WjFGo7c1idBBX10cN0TA3BZqQYAz9iu/b/suU7t1T/jtoDHwtRlrnuMysE6S1L3k1jHLdW1dJg9s1PepfUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990950; c=relaxed/simple;
	bh=Qeyi35SIo1gfCFS1PX4bOWlT/tWZhV4MRNMTd160DTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KozvEs0mQDgiVYRAIJ6UtPWyu9eotGiXhejW8Q79RWrgJS6V+0L+OQwqC1Mf1HXLi7sV/Jr0MBzDj29+GRQbwXsumyuy+Emya0iTk2esCme6hwTjllfhcqOyGtcL4+RFElSf4MgrUf1qIcVqpG+4dRYtbXeoTFdoQtvZWXgkR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=J53yPML2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XMGgkM+q; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="J53yPML2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMGgkM+q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BBCE01400227;
	Thu,  2 Jul 2026 07:15:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 02 Jul 2026 07:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1782990947;
	 x=1783077347; bh=9wgHph4FYseV8ky5bKdLj7dDr0P185U/I5hMrXrAWKE=; b=
	J53yPML2bFvSMVRCKkQVGjGQ8wJ5Zd/kDLufx7HkyWBQRbhVfzzop8y95px0HI3P
	TI+011M+dcsmdhqqjfDJrAMm8Kx3Q5AHAgi3Xoq1uzJOIJFKJK/6Uf9xXseLPJrI
	RMBsnW0KJxqQiz7QExqmjAcAlNblwiRcmbzS2g9clvbQzLNfx6n0nMNY+MeXSzqi
	XegnQpcxrWIUH4gk59ZNZbl9ha9JyFraqZ6nupmcbggq5q3egGLaixWK2+m3/gsE
	aYPGtHsCJRJXtfSpB+nRpWGIxuynGjiJbCuG3vuv2gzcjKOo7gxxqFyevaYEcMjH
	/YQO4Slmy6FnDjmOGfLeFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1782990947; x=1783077347; bh=9
	wgHph4FYseV8ky5bKdLj7dDr0P185U/I5hMrXrAWKE=; b=XMGgkM+qmQdsMWPvx
	Z2S4l/eA+JNJE42+pcyZcfg2zPkd1go1hI78mYl6+Qlb4qCSlwuEoEP1poDIwXBe
	kuh269FoICFg7Hg0bFuPgT5xk0y/raoqHtpBIsm7sLAOQQ1wTFqoBULR2NFZBJpZ
	7e8mXntJS7R5XL2DsJ4opR3g5loRP6IlaX4vX1Kwdo7RbTdUcIogsxwvCUgScq79
	f16mSg0dbpcyn/UNDkj6tpgVPA5JzKNNQh58lFZ8EevSNem92ng7zE8yCY8Ish53
	Dq5PpAXvL+ExIDgcm4A5GySv9AYx7NlS5TCmAn+KNspEaqgNQecJ+JHrtXhG+5qC
	Ng5TQ==
X-ME-Sender: <xms:Y0hGak1hEIeoyIb7QBx7xVGMMtotfzKDHstZGSaEpx0Cc9GXiuyg9A>
    <xme:Y0hGaoD1XLYZxspbAjgbnqK2vLbNhnSlyx7EOYV0F763Mik1gH4vu2H6XIKO1q4sw
    nyKk9sgJz379jlQ-TRf2KGgXPDQnRPtAb1Zw76WXbPESVCRVQ>
X-ME-Received: <xmr:Y0hGaofPXtJm5iJ0WnXRxlX7QiFhwV6-bGyOVOvrBvP5hHXQxdVk9pG-S8pt7F94Of5CZPu0A-vQVG7WFJf7KmJEb0vCJAA>
X-ME-Proxy-Cause: dmFkZTGAj4tPrnRCfABz+6tzWcP/g5MP0zOCQZK/BdAi7s4Klp5HDo6JKm5ohTwOS54M/E
    /csJlXbNTXDnGVXZ18fXudwJ3FNp2FsiUIyhax9Yq7AVZ/FCBG4TDE0cKHRhE4Ha3CsPEj
    W1y7WOTvjM5jElEd6PoLy9qb0HQi+qY0CiNrM0z/rl/BswrK0I6DZbHc5/1lHsB/3JNec4
    RRJ0iHzthWxBUN0NmYHA7C8N7wV/hHuSD7h9BwEcq+QKECHA9rJcyawIeNvsNVt4HTW9GG
    /7j8L6DTHAljiBamtx3ZF2oSXY3W9ucHLbCINvC5BaudPluw0Umo/U0S03aFU8w0HrZ4Co
    5gka+izjxtLJoQ3nwdhCVkRL6wGTztFMsPvuT9FTLtcXIpHyuRYVW+Z126qZs5sihyM5F2
    Zr+FV2ah85MGwE0Olw6sQxM4US7Q1UkK2GYE+1PnT2j9XIRHvVFykHqr11TnkLq5pfGynN
    HlTtMKWtYasU2x89V7v/NZgcyoIpphK406ixsL91d+KB2VnFV5eR4Fe9MKk5K4uZaJUfdS
    ULBXJ+UHkWixET13ABCGY2fofSRF4Dxi6e13NC6V3bgpg92bAbs3+UUerhUH7NNWUt26M/
    7kqIZS42Frd0UNLiK++yAME5hJ06lAOAWuRRsxAOD7R1/3LYNhAhcxDEJXfQ
X-ME-Proxy: <xmx:Y0hGat7nthrF58aMm-Fh43utAJ2rl5Le7lANWYkejQpTGOdL6_ccBA>
    <xmx:Y0hGajWInUGwAgaERSDsmezRGq9pCZPwcfaYH0Ackwi4F18XSU_4Gg>
    <xmx:Y0hGak4MPOOooN1_Pw6zR42fZy5v7I17k7P7unzEQiK7zlNrm6qUkg>
    <xmx:Y0hGamog_RWISeG41QEP44udtVPLGtR8ZG8cDo2JDJSJ7W5OmEuoGg>
    <xmx:Y0hGajDNDAILwp1uwRy7CoX0xsFyUvSwgNTenuF0w7PZjiDTHklnaOGw>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 07:15:45 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 1/3] VFS: move mnt_want_write() and locking into lookup_open()
Date: Thu,  2 Jul 2026 21:09:19 +1000
Message-ID: <20260702111529.3559835-2-neilb@ownmail.net>
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

The mnt_want_write() call and the parent inode locking in
open_last_lookups() are only needed for lookup_open().  So we can move
them and all the got_write handling into lookup_open().

Note that we need to also check create_error when determining whether to
unlock shared or not, as O_CREAT can be cleared, but create_error is
only set of O_CREAT was set.

The fsnotify calls come too as they must be in the locked region.

Also use the existing dir_inode uniformly for dir->d_inode.

This is a step towards exporting an better "open/create" interface to nfsd.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 77 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7ead3db55be2..55404fe0e269 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4398,7 +4398,7 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op,
-				  bool got_write, struct delegated_inode *delegated_inode)
+				  struct delegated_inode *delegated_inode)
 {
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
@@ -4407,9 +4407,25 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
+	bool got_write = false;
 
-	if (unlikely(IS_DEADDIR(dir_inode)))
-		return ERR_PTR(-ENOENT);
+	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
+		got_write = !mnt_want_write(nd->path.mnt);
+		/*
+		 * do _not_ fail yet - we might not need that or fail with
+		 * a different error; let lookup_open() decide; we'll be
+		 * dropping this one anyway.
+		 */
+	}
+	if (open_flag & O_CREAT)
+		inode_lock(dir_inode);
+	else
+		inode_lock_shared(dir_inode);
+
+	if (unlikely(IS_DEADDIR(dir_inode))) {
+		dentry = ERR_PTR(-ENOENT);
+		goto out;
+	}
 
 	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
@@ -4417,7 +4433,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (!dentry) {
 			dentry = d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
-				return dentry;
+				goto out;
 		}
 		if (d_in_lookup(dentry))
 			break;
@@ -4433,7 +4449,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	}
 	if (dentry->d_inode) {
 		/* Cached positive dentry: will open in f_op->open */
-		return dentry;
+		goto out;
 	}
 
 	if (open_flag & O_CREAT)
@@ -4454,7 +4470,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		mode = vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
+		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
 		if (likely(got_write))
 			create_error = may_o_create(idmap, &nd->path,
 						    dentry, mode);
@@ -4469,7 +4485,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
 		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
 			dentry = ERR_PTR(create_error);
-		return dentry;
+		goto out;
 	}
 
 	if (d_in_lookup(dentry)) {
@@ -4508,11 +4524,27 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		error = create_error;
 		goto out_dput;
 	}
+out:
+	if (!IS_ERR(dentry)) {
+		if (file->f_mode & FMODE_CREATED)
+			fsnotify_create(dir_inode, dentry);
+		if (file->f_mode & FMODE_OPENED)
+			fsnotify_open(file);
+	}
+	if ((open_flag & O_CREAT) || create_error)
+		inode_unlock(dir_inode);
+	else
+		inode_unlock_shared(dir_inode);
+
+	if (got_write)
+		mnt_drop_write(nd->path.mnt);
+
 	return dentry;
 
 out_dput:
 	dput(dentry);
-	return ERR_PTR(error);
+	dentry = ERR_PTR(error);
+	goto out;
 }
 
 static inline bool trailing_slashes(struct nameidata *nd)
@@ -4555,9 +4587,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct delegated_inode delegated_inode = { };
-	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
-	bool got_write = false;
 	struct dentry *dentry;
 	const char *res;
 
@@ -4587,32 +4617,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		}
 	}
 retry:
-	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
-		got_write = !mnt_want_write(nd->path.mnt);
-		/*
-		 * do _not_ fail yet - we might not need that or fail with
-		 * a different error; let lookup_open() decide; we'll be
-		 * dropping this one anyway.
-		 */
-	}
-	if (open_flag & O_CREAT)
-		inode_lock(dir->d_inode);
-	else
-		inode_lock_shared(dir->d_inode);
-	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
-	if (!IS_ERR(dentry)) {
-		if (file->f_mode & FMODE_CREATED)
-			fsnotify_create(dir->d_inode, dentry);
-		if (file->f_mode & FMODE_OPENED)
-			fsnotify_open(file);
-	}
-	if (open_flag & O_CREAT)
-		inode_unlock(dir->d_inode);
-	else
-		inode_unlock_shared(dir->d_inode);
-
-	if (got_write)
-		mnt_drop_write(nd->path.mnt);
+	dentry = lookup_open(nd, file, op, &delegated_inode);
 
 	if (IS_ERR(dentry)) {
 		if (is_delegated(&delegated_inode)) {
-- 
2.50.0.107.gf914562f5916.dirty

