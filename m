Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EAF439F9E;
	Fri,  4 Sep 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558814; cv=none; b=i84XPU66RRF/4UeU83UQERhZvWuRrTYDVTHch81IsRVe9cQTag8s7cR8vY9XGAV4SH7gZzFlQINQuUN58UAlzn3WOHFfhHpjob0XAs/xfR6mWZobqCbQeE3mJwrjljXkGwW9YSHYksX2pUswEiJ6VLR2XO6FTpwmbRnm8ySYMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558814; c=relaxed/simple;
	bh=XwfTSvsAss395NbUmNfD0BvIpEUe2T4vCMZGNsmwnsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgVpRjpNScFYWOFWqK3EYtCt0Ym2tOZVPkXZ8FWkZkV8jf6ocAcQGd7YZC3TS3BxO1/c5Yxu+kxdeVG2LMnASquumE2bZbYEHAJ/d+S8/460y4aRclEeNqrv4D2gDyYHyg0Pvgwt6pWHDvFMBPvhffJviCJedfjMA0wJ7j6uviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HAozJU3D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sknuf1iI; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HAozJU3D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sknuf1iI"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 377341400156;
	Fri,  4 Sep 2026 17:53:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 04 Sep 2026 17:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788558810;
	 x=1788645210; bh=pwDhUtabD1EY8UJKERYdpDzwVgnQzJgdv/ipJhB6Ltg=; b=
	HAozJU3DaXrUtXPQnRY/mB00j8IVS4SMWu5hQqmSmBqPU2CDJCbLG6wi5pNBv5F6
	fgIjp0JGE0xYplYU77DV8yWrKVpHoHif0ZkFqKeESMmUdM4AipDxgebkpSMvrQra
	mNQNnDaqtM1jAqU49xVeYsW1BFpP+H2bPxKay5qMzGO6mLDsiNwAHz9aCUNiyRvb
	cXytumgUSSPUQ801vdw33TE/n2NQjzI4Fa/39yDqsucWhkrQuJuN3CJ1quVUqs7V
	IlxuyTQoX1gHpmb+bPymAJ/XeH8+A/0GidVbi7F8Uvid3nAfSD+uxhCLMnTR4tbH
	RMrWq0ooPr5ptD5k4gJgxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788558810; x=1788645210; bh=p
	wDhUtabD1EY8UJKERYdpDzwVgnQzJgdv/ipJhB6Ltg=; b=Sknuf1iIjcPX8CioY
	aqtLzHuiueIdawwyiS3QSvrPKK4cPA4SKesBn4EE4WGw1jpcZX5MmU1lQknueTXP
	f6TmzZ9gFarEKWaNg63r7Syt7qQZOAdmSo6tovc9lWudTXhQg+3cnETmMFV7MlrT
	NXp1AxLEJnip6mhZLFECxil6Ry3FdVML/VqKzLJKCby7cIae5VCNT3fuPIo6ngcr
	W3Yj5xy9ZBsUiOYVSTb59ZFiVUSVv4FdMpXt+OHzW2fRBGJXi/ep/gNRhrdfX/7A
	1oBGdPMtSrWjisjV9DDZpE9r9j3gDqEhIMcfdgKs9FQTnd8o1aNugXWxu1fj0Jhy
	BLM/A==
X-ME-Sender: <xms:2T2baoYCD0Pc8ey2Xm8D-F5690CEwJ_WGRiHS8D0al2NjhXUrJISew>
    <xme:2T2bagRMThgehjwArykVq1wirDbSZr0SjASxoo83krsccdIIFDtq8RKsWpAyzN1Jp
    dtD0oEH1cyyZDHC7trToe7Sh-YsOzof3YKV2lo6LEc9CGFHYnU>
X-ME-Received: <xmr:2T2baiur3krAGM6QhEkB2_KNa3aQ9qrroq61akYq0R3DA0g7F5mPX2EamIwBuk9tGCsAoI2B4vPf6W-fsueHJJOSguF-n7U>
X-ME-Proxy-Cause: dmFkZTE9kA3thUlpLT361si23coA65UhzUPhrTWwkKM78lnPGqsN4WqGhrX6sVxsTEwsLH
    ORMYgoSmolSLTX+O1vlWByuNkCl9wjBDZIO33pyh+0tWhR4K4noJM/+vI1MBmqcIftaS2b
    /GtiqOatuq21RBzGugW3uasufhqhKX8qbUnLt2Dldix1ZFEwWdsaAp+5wDCTunbmew5pzc
    xd+xD35a9GCDgNKa3CYep28eFOpAh1Fsh18RmdQxkxptLMj+Iewv6oaB6vjlrs4TcpQgo0
    oinx301X3CEL9C1Yt9g+Z7sWJOv0dzlKXMlUgOscrJyVCHG9gHFPEU/kaA4ys8FbuoMDIl
    pZhYJ0WXjtNUlUhgv80JxjVZdF12mO3RBMsWFPrqWDm7Q+xMFfB2ADxNjdFyjWYPW9VMJK
    raVAak8HD+B81AJYeVy7vx5bi77nGvibFFZofjVQHYqP4rnQ+bgFlCnVuxqNv7CluU2AcK
    ggCj9S9GO13iyV6VUseaxeiwOdtjcKndElRhPolfDgmZNQ7MEiqG0xdRWPkrgrJauz0e5q
    bFwFbtzX2bk4WPvSAQQQEu2vLKA5VzDmN3nfrd4pKoorcwlWnDiK+w+oTNvWFKzhAlvKet
    ujrwvFMaRjHZHSR3h3TAHbX9xzj+tg4yP3xKw2fvusik8ozLU9s3cvTbfrag
X-ME-Proxy: <xmx:2T2baiGzu4Vi5Ov7u6_wChbE6vyKhULdO7Xm0KbCHhOtDF1eoC1ewg>
    <xmx:2j2bajyh6GWNEkVW-P60qsJLd194kiOTvJFYP8staV-Qx42RrBx1UQ>
    <xmx:2j2bas2KP9krSAYtUggESzs3d4cqnKztpl_FDhJ4JVKeVOS6hA-GUQ>
    <xmx:2j2bajouismGqBKt_mSbO4yd0_NrXR2IC-7nUT-OkO7PdowGJKGnAQ>
    <xmx:2j2baoXpVdKRB6f9oUAeX5KMSDUZXATJHfxXJOvo6q3Sq-xi0ZCVDOJc>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:53:27 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] VFS: enhance d_splice_alias() to handle hashed dentries
Date: Sat,  5 Sep 2026 07:48:11 +1000
Message-ID: <20260904215142.1060510-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260904215142.1060510-1-neilb@ownmail.net>
References: <20260904215142.1060510-1-neilb@ownmail.net>
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
require the dentry to remain hashed while an operation proceeds on it.

There is also no interface which splices a directory (which might
already have a dentry) to a hashed dentry.  Filesystems which need to do
this d_drop() first.

Some filesystems (NFS) skip ->lookup processing for
  LOOKUP_CREATE|LOOKUP_EXCL
which includes mknod, link, symlink etc.  So these inode operations
might get an unhashed or a hashed-negative dentry.  There is no
interface for instantiating these so again they need to unhash
first (nfs_link)

So with this patch d_splice_alias() can handle hashed, unhashed, or
in-lookup dentries.  This makes it suitable for ->lookup, ->atomic_open,
and ->mkdir as well as others.

As a side effect d_add() will also now handle hashed dentries, but
I have plans to remove d_add() as there is no benefit having it as
well as the others.

Once updated to handle nr_dentry_negative as is required for hashed
dentrties, __d_add() contains code that is identical to
__d_instantiate(), so the former is changed to call the later so now:

- d_add() calls __d_add() which hashes and might call __d_instantiate.
- d_instantiate() calls __d_instantiate() with appropriate locks.

It was suggested by Al Viro
   https://lore.kernel.org/all/20250813050717.GD222315@ZenIV/
that rather than allow d_splice_alias() to handle both hashed and
unhashed, we should have a new d_splice_alias_hashed().
I chose not to follow this path because, as noted above, there
are several cases where the filesystem has no a priori knowledge
of the state of the dentry, and so would need
  if (d_unhashed(dentry))
      alias = d_splice_alias(inode, dentry);
  else
      alias = d_splice_alias_hashed(inode, dentry);
which is clumsy.
Also I hope to minimise the distinction between hashed and in-lookup
(they will both be hashed, just with different DCACHE_ENTRY_TYPE)
and reduce the use of unhashed dentries.
Unhashed dentries would only be created by d_alloc_name() and all
of those are passed to d_make_persistent() (though configfs passes
some to d_add(dentry, NULL) first!).  So the use-case for
d_splice_alias() on unhashed dentries would disappear.
Note that d_make_persistent() already handles both hashed and
unhashed dentries - just not in-lookup.

* There is also d_make_persistent() for filesystems which are
  dcache-based and don't support mkdir, create etc, and
  d_instantiate_new() for newly created inodes that are still locked.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/vfs.rst |  4 ++--
 fs/dcache.c                       | 30 ++++++++++++------------------
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index d3a93eec3945..de8f8502056e 100644
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
index 1b1a81f10da6..fd74753e7715 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2168,7 +2168,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
- 
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(d_really_is_positive(entry));
@@ -2931,15 +2930,10 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 	}
 	if (unlikely(ops))
 		d_set_d_op(dentry, ops);
-	if (inode) {
-		unsigned add_flags = d_flags_for_inode(inode);
-		hlist_add_head(&dentry->d_alias, &inode->i_dentry);
-		raw_write_seqcount_begin(&dentry->d_seq);
-		__d_set_inode_and_type(dentry, inode, add_flags);
-		raw_write_seqcount_end(&dentry->d_seq);
-		fsnotify_update_flags(dentry);
-	}
-	__d_rehash(dentry);
+	if (inode)
+		__d_instantiate(dentry, inode);
+	if (d_unhashed(dentry))
+		__d_rehash(dentry);
 	if (dir) {
 		end_dir_add(dir, n);
 		__d_wake_in_lookup_waiters(dentry);
@@ -3241,7 +3235,7 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	BUG_ON(!d_unhashed(dentry));
+	BUG_ON(d_really_is_positive(dentry));
 
 	if (!inode)
 		goto out;
@@ -3297,6 +3291,8 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
  * @inode:  the inode which may have a disconnected dentry
  * @dentry: a negative dentry which we want to point to the inode.
  *
+ * @dentry must be negative and may be in-lookup or unhashed or hashed.
+ *
  * If inode is a directory and has an IS_ROOT alias, then d_move that in
  * place of the given dentry and return it, else simply d_add the inode
  * to the dentry and return NULL.
@@ -3304,16 +3300,14 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
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

