Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C038634C
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 01:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771634; cv=none; b=jfL97VYBt6E1ewkz+IkdMqRt3h8i3qN6wSProGmuLxykryFnG//jwTWa0VZoJGQZRA6u9xZULKpXX3uAKEwWaRwD3teNu410wu9gUc+VXWYGBgJex139vLKaSIl/Bw71s+nqEUfrbmCKLUPCAjBkgCo+uqUyllkjbXVAg3Uk1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771634; c=relaxed/simple;
	bh=C1M6HG7CbfDHQ0BpokspwYqVZH4OES5z/C5DtktQB6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amkyoZXwzejRS9FMRN5b/Ka4cB0ebOaIX0r6zVkICR4o/5NuAT5tSiPczXPxnPRgEeHF574SnRBad3vgnqDANhQ6riLVKV3OJhB/CbMm8olok8M9/KktE4dcm7hTdgt9iqEUZGZ8wgJOsso9daLuV8TYb0jomdkqtA+SG7i054I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=RNYQjSNs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EVotKsCo; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="RNYQjSNs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EVotKsCo"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 6ED311D000A7;
	Wed, 22 Jul 2026 21:53:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 22 Jul 2026 21:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1784771631;
	 x=1784858031; bh=Hx6MUFwUMe92XVnvXwCXRVPajE22y9wyTgtdUHYsV0w=; b=
	RNYQjSNsE7Y9yAQQf5BpPEARt3i9aYkbU56kTDK8eTYkbw00ocnu3CnKxh6GWDpH
	cjL2Qm0HXI0pISznGURU3DgrJXg27ZHgw4oXgoi1kcEKR1oAH+bCxCxGZ/ESV/g1
	7XOjIaWaW0LJBMsS8M6CtN8zglsuwmTInpah+FU7SfR9xq9mPpgajHi6c1t+E1Xy
	Z+ksBpwavXswpBkReImRiLxHnRyfdROPeDmbVQrO7FLAtLMeCVNq9h9yRit9TELt
	0WSEbINKSxPQA7Xr6pv39toXfb5IrwZFzbLL5QYn6qF/HYn+hvXtdlzGSKaksAdj
	YgiyLQA7r1/LnaG5/SDBxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784771631; x=1784858031; bh=H
	x6MUFwUMe92XVnvXwCXRVPajE22y9wyTgtdUHYsV0w=; b=EVotKsCohNgZoDZIP
	wLeJjYmUCUNECq8PeuTGr3nc3MKo4/+R9hWcrTwKEXhucGZVor/DUa8O3Pd3KAhi
	kS9w0R5Ff5RkHw3nnbS07xIgjkOtcNR/XJq6CHVrRfTyQXP5kzL+paeasb2gxRRu
	UPT+FCEX9oM/BoYkJmIGl1k2GltHlagctBGOOt+gkI91SaLCy06eQS126hNv1rqj
	ddh0z5R3hCtfXXGdcyRjneCR3DYM0SQDZ/0NFV5J5z3t5pIrA5HtaG2CQPW/QAbH
	30JAMdNaJTTJy2Hr8B6sGGhZGNVMNgXuQuKB+221EjjZKRC1SXm9rx4qSlCCIZMf
	bMt+w==
X-ME-Sender: <xms:L3RhavLpQel0UhRys1E6MQE6mXIKq1yyHhzbUBynvyqs1ac3apVQjg>
    <xme:L3RhaulV7l7gij-8xLEtIfNNAKyjUEGqIAOcykfnB8yFW1az5yTCzAmG2ZHaFS4uj
    Ny0fu1l1tk3mDMQqE8tBu04deEGDEfAHFLvM8AxlC7vAc4MjQ>
X-ME-Received: <xmr:L3RharP9YFVGGzgOYAR0YXDNciGxGW7pjzd-1amwysj8V_Y5aT53p-lwPVxLx4vMp8OILfZmTkM0tl_Ve3t1jherI34M4Zo>
X-ME-Proxy-Cause: dmFkZTEjo/RxGOopu+r12OLHz+VW33pfHhmRo7fMHlfa5mryaHc8K4tF9PAsiT3XwY4sg/
    HdqYN9SGa+MqyJGfGdnEkG6dRUI/+g7Co4WBAFO3HBgf+5n97O8zZt6OUPSVs1UiSi7qvJ
    fKvCqB4dBFVBcgbOnc6PM+RpyUtrpjQjrPA8epclelBR5N4GxYLCyAn4PNCEYCqsgU5ErV
    QR+pPBBBk2a3rpgslKHdp8U/TMXmNoKgQWXCDZQEYeqvoAWZ4fy2cYnflE9Tbno4CRLL/w
    NV3zhTkOeheg4EXexXBq3826nIlONfRPJcX5OztX4A4PmZUgUZNmyX6KFExyE9Ef6+Ptds
    PhAubu+oiV1QXJLkTRIlqcLEC4itLhpdbBL51xOg4bFvIHkFZR1m1nSp5bARqTNTY5Dg7R
    MyNuxl5VlVwzQszN5AgJKmAQ7nPHGV5AKy1LTNpotu5/x0AX4vvqN3cWJN7ZtT4he2Me4i
    XXLcNKrdJFG5A+nuKWdzCLigHn5HeOkzemxHBwv5PO3j2TmlaXM0fr36PRL7EjAjk0dqfF
    GHlUWkkm+HiCC7jt60cwdts9xpKJVTHQnos3x2ElSzokpzKN99ydMJTWZTlBPtf+TvSqwQ
    NuUciQoexnmr889xjZYL5vtMXq4zvkS2tdvflECYuypx9v8hbcbNydxeZtww
X-ME-Proxy: <xmx:L3Rhas29a7Sh1sLnA50OYarzLKjVfEkpcz1QKjKLRrnqPElWUUvMMg>
    <xmx:L3RhaimRdACNdZkTfUjqObPG3ntvUwWCRHGHAJqtNtMEWnpOCv0VJA>
    <xmx:L3RharXOedE2Vj22HNtVvxbbcaPRXvP3_0TzXmQXT6KYzGbQ51ekIA>
    <xmx:L3RhagtehVr_iZfO-8IkpvNAGPht4vQCLKTFHUlYTHRcHfTiVLM4yQ>
    <xmx:L3Rhas6u2tog24aWI2NGZbpDvpkRSyN4vVks1Mkn8sO98VpgG1gKS7t1>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 21:53:49 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/4] VFS: enhance d_splice_alias() to handle hashed dentries
Date: Thu, 23 Jul 2026 11:49:47 +1000
Message-ID: <20260723015330.3093207-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260723015330.3093207-1-neilb@ownmail.net>
References: <20260723015330.3093207-1-neilb@ownmail.net>
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
unhashed dentries - just no in-lookup.

* There is also d_make_persistent() for filesystems which are
  dcache-based and don't support mkdir, create etc, and
  d_instantiate_new() for newly created inodes that are still locked.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/vfs.rst |  4 ++--
 fs/dcache.c                       | 30 ++++++++++++------------------
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 651b83b00440..986518eb9639 100644
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
index 3e9af9de7074..2fff76c0f6fe 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2163,7 +2163,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
- 
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(d_really_is_positive(entry));
@@ -2926,15 +2925,10 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
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
@@ -3236,7 +3230,7 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	BUG_ON(!d_unhashed(dentry));
+	BUG_ON(d_really_is_positive(dentry));
 
 	if (!inode)
 		goto out;
@@ -3292,6 +3286,8 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
  * @inode:  the inode which may have a disconnected dentry
  * @dentry: a negative dentry which we want to point to the inode.
  *
+ * @dentry must be negative and may be in-lookup or unhashed or hashed.
+ *
  * If inode is a directory and has an IS_ROOT alias, then d_move that in
  * place of the given dentry and return it, else simply d_add the inode
  * to the dentry and return NULL.
@@ -3299,16 +3295,14 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
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

