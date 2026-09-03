Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6D3655E9
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405911; cv=none; b=PfG19ONn+a5wv1uMJQXJOfrKhiFa4Im4YJw32w+KEG/O7/I5UixDLr+sL7a8EegbcAyKT/7C5se5/2dp41VOqBulIMDM8Zckt2b0SibIV856HfLi7FRNJbVGneVvHAPGFwZcpaGXmob8m9n5Tiu0I4t06QiXHTxQ5nEGbWOkr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405911; c=relaxed/simple;
	bh=XwfTSvsAss395NbUmNfD0BvIpEUe2T4vCMZGNsmwnsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrvlcG/y2b0FdYja5/cH8N8bfvYzKwQmL7FS8lMQl1FpLNgLhD3B9sm/JVLicImkxvXe9Ypt+hKhHV/XmW4S6pfctVmijfknP3W7ajPLIRbybpkmFnyma5Sh+Dp++tdZe1fpJS2eqBjkDZhGHytdSJevMiIfQSSclalAaPiN85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EeNQamGf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IJfeGbqp; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EeNQamGf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IJfeGbqp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B57D1400137;
	Wed,  2 Sep 2026 23:25:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 23:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788405908;
	 x=1788492308; bh=pwDhUtabD1EY8UJKERYdpDzwVgnQzJgdv/ipJhB6Ltg=; b=
	EeNQamGfTyBlZLPZNX+Ue4vQW9V5IDxuQwBWTEZPO/L9eSl4sXglumNnXdV6ZYD8
	8264nI3Ox/OmTOi4e+mBHb1DYCO075vDotV3tStmn/y83uQ4WcZphqai8n+6u1le
	xv0m9IJv2E4Rx7qI1OThhK91Y8qpgp+E4DakXUDHPw+6U2ZwO+pcQZnodSminap8
	NUcvkKkVFk5K5nYLAu+2TdgckI1QALjfzbSLsrjlIWsTkSeUhZ+t19UYbk+H6lgt
	w/gZxfBzSDMyE/gIYKMRZvCCDFFUeU7GahDeE3iqghhXOMNdU82wiyuO+CEOvbt+
	UjKwTg5Izaesqcm8WSqdEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788405908; x=1788492308; bh=p
	wDhUtabD1EY8UJKERYdpDzwVgnQzJgdv/ipJhB6Ltg=; b=IJfeGbqp7N6MIxKZY
	nsKFWL9csuNk8bL3z8R5GgsviSS9TLOINtqcf7ZiOLuZzmwlhekyADEa6W0eKJUd
	D/Uovm4Izq47G3++Qz0wTzD9CJw1jrZAJbrp38LILSBW93fGqmJ/wnRdYCNto3Ok
	2DK3oq2eVF5NCddRfWLggFvQ111MzD9i+bPWP7TI1KiX/swyk5KVk/HsZnbzmaL4
	tvIlLOuLtG0oHSNnV/bwD3Drgxud+IjYZ5IwhpHfE+SSmx4k0HY6lbDPuiiTUpx+
	/kgTSHFR5xdEcZmFWPBbdMOasMl/WjpUWA38hcvBwLChPtdVlZvA5l5V896957ZE
	n94Qg==
X-ME-Sender: <xms:lOiYavliB4IzSqWnWf3sGmHnTrzUFbNu19ZJUWB9DnTwP9ojSpfRWA>
    <xme:lOiYas456n1_A6Fg7aRwiB6aP3-DbDGmqNWLU_f5Cd8fyr2_LaUJU4N1fd4X_oeEE
    wGwtWaCcZL0EzZmtfLMJqkMixbbQpObEv-QwgZ07PRxmVcejQ>
X-ME-Received: <xmr:lOiYalgMbG6Wa6O22k_YR6VxlNq9WItM74gyVHsZH6xnH1AZz4xgDwQX--Ghonjm1WJqoczjDfHjh_1M9GkiwbDj-6JyVBY>
X-ME-Proxy-Cause: dmFkZTGsaHkdNTrXu9iyB/fvxfOEuojOzRMMz6ifq9y0Z8/aIcUoJ7+Yz1D+cgJ9QLCQF9
    hqI1KlsKE1PobBnOTp/0+G+RwvFQVf0UFkk1PgkYFahawGe4gFSL13MRIuYuZrQpxgooYz
    T9fOab/mwTM9tUF7fCXeRwZpean1ITGMZI8qvlcNWlCrHMEt9Vhshl4/gaGyZv5/aKX4k9
    ymdyoI62/zR2b209tiLntU5iWHtHXSE0keY77lYE5u39bZkSEb8sDegimeV9xJOPFTkCBB
    5e5lr5DUaJ6NykbO0v1qmvDrbS8weZi1x6cfEqVTZ44MIP2QgJ0MaVg0ROqUVH3BUcDJrh
    xNpi9BPzYxnVh5PjzbjPWgNQe5htiYrATxI2DL4TepYFG8gpA7gAB1U6oMCnbyqu7Fl6Yz
    WUl4I7d0IrKgi41psbo9lucG6Igh1loaotwLiF/NaS07CDh8WCCMpDAL/PVLRSkikcgXmW
    7kvEuSWSiDexKe9k4XI/xh54IK84ECpDf4uUjNJYztbSLXyH+gREx/DEBVXqbbnXA/FsQK
    JVCL3yeNRdwIrbvSJbn4vVt1xWEry0srh9KOYDbHzfCaR3ezciB2p0keTylWmnflIE8VF1
    69KM7U55mHaDK/uj/thdntTfOtTmY28mnsTCwHIwQzqm0nQwJKij6i1Sw1cQ
X-ME-Proxy: <xmx:lOiYapFMoVbLQPAZoq6MqehuJZpn1MXnzos5dejLSMdNflvA7qIbLQ>
    <xmx:lOiYarSdsLSmY8KQ9BVRtTT10nbK5oZ5y7nWruExWeeXeYtknxXeaQ>
    <xmx:lOiYamz7u4vm-Xz0T-Ex0Iu4wKsIkye6GcqctbtUHULMUDIjCxF6wA>
    <xmx:lOiYaneju_rgB0imrVrjPHH1Z_7ChlCA2UkJpHej6ZriIiPlqjuW5w>
    <xmx:lOiYapouEpKBS0nazVkj4UQ4jOWNLTrmxkzO95umcgCNAEJ5DhXgdEW9>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 23:25:05 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 2/6] VFS: enhance d_splice_alias() to handle hashed dentries
Date: Thu,  3 Sep 2026 13:01:32 +1000
Message-ID: <20260903032431.142777-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260903032431.142777-1-neilb@ownmail.net>
References: <20260903032431.142777-1-neilb@ownmail.net>
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

