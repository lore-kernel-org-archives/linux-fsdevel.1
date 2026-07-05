Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53319366051
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jul 2026 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783295712; cv=none; b=giNemDUI4r0vWXWrL4HgzdZz503mn1A65hgZ1QnDX8Uxf5woDucM4tksYiZwpfUrJxNVlI9nbuOYhXt5JwtqkPZ/ZnXATZNXnhU7sVqniti+l2p6Eh5TBiybrdbEOCGk6IkBTg+sJc4wiIpI06ieG2p2lSYfbOS5/6CbRG/1faU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783295712; c=relaxed/simple;
	bh=bI7Fu7+m4Y4paeZeRm+9DvalA4qZf1f/fYVH/Aaw6n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMKKFWzY6v/WxxWt8/vIjOeSWf+brG0R70O4Z9ddpGD4FI1is8si4yyvADFM0qaUN/xu2RMFdJOIkHId/dZt5CfNlCNcwbvUGqxwy3NLLu18+MiaRYZDBqBe7Q261hdtrjHan1OKjXgoG8z6vEFbwW1O59OEfDOWbElT8djucS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WfgxoDd3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADjE8Szn; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WfgxoDd3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADjE8Szn"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 909B91400093;
	Sun,  5 Jul 2026 19:55:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 05 Jul 2026 19:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783295709;
	 x=1783382109; bh=40XiNEdAzh1eFu4Ly1xdPF5oTxAkThXBFBTECpiedog=; b=
	WfgxoDd3kaFpFfeSPEAlE4zvVfX6F8RfiUzQQw7w5jrDGaM+siI7uCmMfYyy/01s
	Xx3h/kMMF4qOxXNZMYQlEKYU2YDaA1euJrIU//6pcMnz0Dy/f7ZvPiKoBL6qRtdh
	U1XponckVo/HsrKJP9W5XjDv1PUBvsrZxBjf7p49okMWdGA/kN/OJswbLaGc6taL
	GTaWpsoaDin8bNUVfxIjFG4eDUt965UD5qG5RLZXnHMtaVaDBvxZkX1HF1W9oUBA
	1kaJQTSbnj4uaFDNqio7lf+gqqtnig0BCoLU6CcmIwFkY9uw4D743Crnyozjbrvr
	zTYDZ4c7PidkfnIBQ8A2lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783295709; x=1783382109; bh=4
	0XiNEdAzh1eFu4Ly1xdPF5oTxAkThXBFBTECpiedog=; b=ADjE8SznnRucl5dit
	bgEMeYyy/MgjqibeXs2mapTF+ob7U/5qTUzJzU0vwIPMIOvwhQk6760ItktoWlNY
	DySysLYLdUXxbor0ViexIzVDL0gOjSERfBSdHX3gJnjmjCsENexs8QuTNF+GcCba
	DiXzn1wGEXszewe3KWAXq2qDWmvirhntmGPFcp4HBghtlmVFu8muvMKl1UuLaUBu
	ImDeAHAkOLR0NbU3MQDg6uedVfIBe+/ccKr6U6/N1XKKbXCUw1vCKs8Xn5i2XPma
	Xoobgkrit68ws8jv6ugUEDx3dPRYhZ0bKsAAkLvJu/OjvfLKNgauhAC/CPpY9p5M
	HdelA==
X-ME-Sender: <xms:3e5Kavf4wacuJA_Yl08JCqIRu1xPyW-hBXqSF07U-fKVM1GuxuGgFQ>
    <xme:3e5KauJE9WxrX5Humw0QSHnnUFWpR5tY3G3YjLkXU-5xbg5YNt0q3d7T3E8i8x7L4
    WDPt3IB8gh4U_drbDzxmR17puaRedj1P7A3l_oUnscNQeGS1Yk>
X-ME-Received: <xmr:3e5KakGo4pK48bkBegO2F6GVUlURuIZ_0IhGc6zw9Q-CyYUeF8zh1XINhyX_gB_g7jshN-s-VNZDlfsLtzzHz9CWcPfM2P4>
X-ME-Proxy-Cause: dmFkZTFZ3maL1kaqyYDflRj18K22YAVuctYMrHJEVN4CkEC78AUR2GrbcaifqTD10giemB
    nYQqDBG0n/gPyR9Uu6xwfGQ+JrlWQ2X0dcNMm3SaAyi0YnSRIUEglkxmzzGvmhekjd6Qvm
    6v7kEC8yrgG87M0/DkhGBE1kjVyjTyUQLddKs7Z1hui9RbON+VZllJ2WPvP0eFVPrsWhf+
    njduKt6BNVD8a/G+LJPLl9GjtEFt8Lwecz/BUfDIvhi8rQTN36ukRdbVxFSrgDvrWB6Oku
    Tjd/5VZue+KJ+uhGJj/fvcdcqIFifKn2fMJBZa8ETbN7OcoPeHfYFuJKnAPx0aMwjiJwIJ
    T05+sGgfbJwU8wltZu/IEfQ8ixXtu0f0Ne7jTuWm9Hix666ul5t48M/Q41mPOpP2B2Z8kg
    XIudTVNdK1YFIoB6ag/qjymEoo2wf4zraPENBiAn9XTp2lxmgdlCHJph3EYHdtnktU/Vms
    Lrmxiao8NOcmZs6FX+kcOEUt+MArvS0PH3+fii3lRiSBnVwVSwhk5rxb453FplvZ09It9N
    mZ4Cxun6tu1raXKOdt6ZxXcNmVBntqT75iVws3E8vLZowR1/5HCy3qj63YSvK/AlRaOV2z
    CfPsUtrdlpReWJByhEYxnjZ/Kxl74hknoK02Z8N3fPpD3/FoGd0ZNabQrNuQ
X-ME-Proxy: <xmx:3e5KahBLCZ_1921Ov5F6XqXisoeysm9bRFkwQu3f84WkbXrOVPsoEw>
    <xmx:3e5Kan-w6GvzLdL-Czp19YymwOx7EL9wfVUrAy46okN2CtrnU8PbkA>
    <xmx:3e5KatCvprsxCXcqUWs7rsx_Lae7sUuolxWrMBBOsn-x0UO-spFqwg>
    <xmx:3e5KasSKI4ITjD98fH_mK4nawDEXXD0I-64ZU08fOUEzHAYydij5oA>
    <xmx:3e5KamKyqnv3w7wI73DVAgzBvo8Vw4MmK1j9AE28Hq5WNz4oIZsHHDiE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 19:55:07 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 1/3] VFS: move mnt_want_write() and locking into lookup_open()
Date: Mon,  6 Jul 2026 09:46:00 +1000
Message-ID: <20260705235447.1322365-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260705235447.1322365-1-neilb@ownmail.net>
References: <20260705235447.1322365-1-neilb@ownmail.net>
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

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
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

