Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28DF37AA8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 05:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848541; cv=none; b=ECom6iTsQGEH0Dft+xZkNXZBPhzuqbnH4fg0hWz4WLfDfx//EVD/K/6fNdkIaQ2WiyqSiGscGrLONQ3WELfzgCiRseqb1XBLlqKnvvJi/jerOVSllfJ/lE8cVuimR75Nc5LT7tA89//zFdF9r074uzOK33DHKV69oaItpmLYHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848541; c=relaxed/simple;
	bh=JqRwHJFOCH5Fl0gmIrMtDHtcrpWR+61hQzVYlxseiJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmGZM3Tc+jRSOtomHJ6A9Ff9vpL7QZUsHbsfWqm8u/NzQL541vq9u189Xt3R6j7OfvMFBFXnc1BgxHilSK2xS9RN/5gxqXlTKqDfl0j8+z819Ho5Krh8sx0Ufjcys2klvtO6FSSZkPYudtM3BK1kUU9udMLhybNy/RZQpN43X7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YZchiXES; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ek1H0Gub; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YZchiXES";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ek1H0Gub"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 189FF7A02C9;
	Mon, 30 Mar 2026 01:28:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 30 Mar 2026 01:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1774848538;
	 x=1774934938; bh=5zHTjmQ5DksL380BCzFO39LIHkaPOCLj03pU5Z8i33I=; b=
	YZchiXESpADC+dHSk6nY0J1m05OFl4J2OfzPJRPq50tYWfsklCd/7hTGHOJkI8kC
	RtyEz0diJVPjJI22NRBIiHLm91Z9pQGp5ImbfXJM+TwsEWKgGzCRuvtFS4gZqnnM
	qSaaspBCXFqA6vzXeXtu6Tc0TdkbJujmnxoegBzAR6fLtuRbEoL6gx8crNi7tadQ
	1p0uFXfN16eJL3bthXWkAvbI3I8xxUXA6uAwZReWlihxQcxXz3Wnk+02rJBRpc/C
	M6CDOU5VGlc7Kw5stTZY3Qad9J7uqhh4z86vQS4Qqv2sPZscAm4aMh7QUoAe+ZH2
	fQI2SOii/lOXES+s0GWwxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1774848538; x=1774934938; bh=5
	zHTjmQ5DksL380BCzFO39LIHkaPOCLj03pU5Z8i33I=; b=ek1H0GubPv3sHRIUx
	V6Pt1kMIxmgGT/Bw14Zbm1ZL8KKg57UcaojPJ/weFjx8VndSOQQctwZW9PH6haiz
	Qd1GukLBq1oYa+hSMLZzSYaBZFKPmZX0V4tcEb4FdYp0/v7xhJZ4VE/1MCDAFGpH
	lm5oo7P5dKaVFqWJQC6LCKuH2t/KDqgO2ch2IiZS/8ljPSKhsSzAAk18wXjAPrfc
	JlZguKhTyjgusau8EstE3Jf6wFvM8VIm2AryeZ2iX/0zOvSPNLZAkzKfuUwyaw2f
	wGmS6zMh7kgxkWAEHnD6yOHPiqmPxkGej9OR1I/5P+/b5EklcBY8V+C/e0CRecuB
	jRfGg==
X-ME-Sender: <xms:GgrKafqqNU1YtvYOsjqL_MCcD7pADr6rOIqlR8mqAGgHUYRVAszN9Q>
    <xme:GgrKaVG2hNDuOzzpTP6bp2g4S0aknazA-oFm-Ww9ttdlTlc0OzWFr0NZqXQePAzhD
    kNC39HJ0kYP_5unxNlcJsakpPOAxLdJxfmcDeCnuVJwReN6>
X-ME-Received: <xmr:GgrKaft55dzIVgj9vbiWITjy0N0aFOQPf0_GQ3O0cGxV-mCncKejIFLByN_Rp1-b8NObCDLDUvIbeo3txwqmU28YcfpdOH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GgrKaXVY3XF9W3TzaxOQm-R_0YN_Nto1qhI1Fo2-miW2CnyIHJPg4g>
    <xmx:GgrKabFapv3YgHFGmFr7mL34zcRG_eM8DG9zSe1VqOGN3gDS88qZ1Q>
    <xmx:GgrKaZ3NHBSXXq-sfXGrJskjxlSxIqfQf537qVhdakipdRnjzQjlZQ>
    <xmx:GgrKadNW0Fhg5hh4MJV8NEu6Owjk2Av1Qgxf_v80K5D0s--jq0C1cQ>
    <xmx:GgrKaVa3D0r-OKQnaGRveX2U4m_UgOMzvsaAhYi5lZT0s9he4sZi1k4A>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 01:28:57 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] VFS: enhance d_splice_alias() to handle in-lookup dentries
Date: Mon, 30 Mar 2026 09:46:37 +1100
Message-ID: <20260329225603.2177730-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260329225603.2177730-1-neilb@ownmail.net>
References: <20260329225603.2177730-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

We currently have three interfaces for attaching existing inodes to
normal filesystems(*).
- d_add() requires an unhashed or in-lookup dentry and doesn't handle
  splicing in case a directory already has dentry
- d_instantiate() requires a hashed dentry, and also doesn't handle
  splicing.
- d_splice_alias() requires unhashed or in-lookup and does handle
  splicing, and can return an alternate dentry.

So there is no interface that supports both hashed and in-lookup, which
is what ->atomic_open needs to deal with.

Some filesystems check for in-lookup in their atomic_open and if found,
perform a ->lookup and can subsequently use d_instantiate() if the
dentry is still negative.  Others d_drop() the dentry so they can use
d_splice_alias().

This last will cause a problem for proposed changes to locking which
require the dentry to remain hashed while and operation proceeds on it.

There is also no interface which splices a directory (which might
already have a dentry) to a hashed dentry.  Filesystems which need to do
this d_drop() first.

Some filesystemss (NFS) skip ->lookup processes for
  LOOKUP_CREATE|LOOKUP_EXCL
which includes mknod, link, symlink etc.  So these inode operations
might get an unhashed or a hashed-negative dentry.  There is no
interface for instantiating these so against they need to unhash first.

So with this patch d_splice_alias() can handle hashed, unhashed, or
in-lookup dentries.  This makes it suitable for ->lookup, ->atomic_open,
and ->mkdir and others.

As a side effect d_add() will also now handle hashed dentries, but
I have plans to remove d_add() as there is no benefit having it as
well as the others.

__d_add() currently contains code that is identical to
__d_instantiate(), so the former is changed to call the later, and both
d_add() and d_instantiate() call __d_add().

* There is also d_make_persistent() for filesystems which are
  dcache-based and don't support mkdir, create etc, and
  d_instantiate_new() for newly created inodes that are still locked.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/vfs.rst |  4 ++--
 fs/dcache.c                       | 31 ++++++++++++-------------------
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7c753148af88..d8df0a84cdba 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -507,8 +507,8 @@ otherwise noted.
 	dentry before the first mkdir returns.
 
 	If there is any chance this could happen, then the new inode
-	should be d_drop()ed and attached with d_splice_alias().  The
-	returned dentry (if any) should be returned by ->mkdir().
+	should be attached with d_splice_alias().  The returned
+	dentry (if any) should be returned by ->mkdir().
 
 ``rmdir``
 	called by the rmdir(2) system call.  Only required if you want
diff --git a/fs/dcache.c b/fs/dcache.c
index 7ba1801d8132..2a100c616576 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2001,7 +2001,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
- 
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
@@ -2755,18 +2754,14 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 		dir = dentry->d_parent->d_inode;
 		n = start_dir_add(dir);
 		d_wait = __d_lookup_unhash(dentry);
+		__d_rehash(dentry);
+	} else if (d_unhashed(dentry)) {
+		__d_rehash(dentry);
 	}
 	if (unlikely(ops))
 		d_set_d_op(dentry, ops);
-	if (inode) {
-		unsigned add_flags = d_flags_for_inode(inode);
-		hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
-		raw_write_seqcount_begin(&dentry->d_seq);
-		__d_set_inode_and_type(dentry, inode, add_flags);
-		raw_write_seqcount_end(&dentry->d_seq);
-		fsnotify_update_flags(dentry);
-	}
-	__d_rehash(dentry);
+	if (inode)
+		__d_instantiate(dentry, inode);
 	if (dir)
 		end_dir_add(dir, n, d_wait);
 	spin_unlock(&dentry->d_lock);
@@ -3066,8 +3061,6 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	BUG_ON(!d_unhashed(dentry));
-
 	if (!inode)
 		goto out;
 
@@ -3116,6 +3109,8 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
  * @inode:  the inode which may have a disconnected dentry
  * @dentry: a negative dentry which we want to point to the inode.
  *
+ * @dentry must be negative and may be in-lookup or unhashed or hashed.
+ *
  * If inode is a directory and has an IS_ROOT alias, then d_move that in
  * place of the given dentry and return it, else simply d_add the inode
  * to the dentry and return NULL.
@@ -3123,16 +3118,14 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
  * If a non-IS_ROOT directory is found, the filesystem is corrupt, and
  * we should error out: directories can't have multiple aliases.
  *
- * This is needed in the lookup routine of any filesystem that is exportable
- * (via knfsd) so that we can build dcache paths to directories effectively.
+ * This should be used to return the result of ->lookup() and to
+ * instantiate the result of ->mkdir(), is often useful for
+ * ->atomic_open, and may be used to instantiate other objects.
  *
  * If a dentry was found and moved, then it is returned.  Otherwise NULL
- * is returned.  This matches the expected return value of ->lookup.
+ * is returned.  This matches the expected return value of ->lookup and
+ * ->mkdir.
  *
- * Cluster filesystems may call this function with a negative, hashed dentry.
- * In that case, we know that the inode will be a regular file, and also this
- * will only occur during atomic_open. So we need to check for the dentry
- * being already hashed only in the final case.
  */
 struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 {
-- 
2.50.0.107.gf914562f5916.dirty

