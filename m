Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41699345CCD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948717; cv=none; b=PUiYAn/H+QIRExuvXzyunVrXNxwWeVu8rV2B5g8sg1Wr8HfCeH7qvAiEBrvjJoYzMr0WTnLLUz4NoU9rhYEL6qP9u1eBVGgvkVn/DWy7MIVdgHpTL+iXedF3auMmnRr09Ddt68OZ/h4dPucfYxASUBLYKHtVXfxe6Db4rU3lsAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948717; c=relaxed/simple;
	bh=B4WtwTi2vYalfebMkkSnSEQL7PxqzwlSNYOjmj9IdzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYXwRdaZHdp+ZsjJB3iwYo/noDylhU0uRG0S/49gp8WqJwRETVaHZSmCZTb5KSJDzRawsxvW71xI/1eq4xgYc9hvQ/R610Y9NfNAXWCUBmvqkQiDBQ+hDrT3zRNymNBxaFHJeoBUoMhnSrMdMDXpbbzIJDNNkzNtLB7nx7CtDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Z9Z/qXaG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R8E3ndcX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Z9Z/qXaG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8E3ndcX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 986487A00CB;
	Wed,  1 Jul 2026 19:31:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 19:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782948715;
	 x=1783035115; bh=c+n1asoJsVw0P/7MksW2OkiOiwwl+sFWyhRS6LfRL6w=; b=
	Z9Z/qXaGBFGbVUAtKq2PLmJmnEHj65R6TBFOX2z8+MfUSgvKC0AKOs9i7VYA6tn4
	uGhrqYvaA+KPns8z8WL9lLfOIUD8v4ZTP+OG2nCXv2OwCVSA8FtNTVfoqiV9IP1N
	dVppwj+dIq1MJJCcGTDHjsxiZgGug82ZKTWBO3ovjIiouyMQaKenDIxkqSd5yJk4
	uilSdIJLpZqRkwe+GiHJNero2d/mVn+X8Nlg5qYkmxzhn6gMv9mBn7rwbC2fvoOC
	aZnrNMo/amTFGA7ZzgEL8G4Qs2ZpZ4ZmMzy4ErGMpZ6skQN8ac3khtE24hhrDk2T
	wQhXunqT5ZnYOh4KvwWq9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782948715; x=1783035115; bh=c
	+n1asoJsVw0P/7MksW2OkiOiwwl+sFWyhRS6LfRL6w=; b=R8E3ndcXOPG+Nk/QP
	pA/Wz1DkFECIhOMCLmS5G4WLAgnGo1q4xGte+Wf7KO+KlpMFOLRP28GygKU2DJAw
	ghzgicUtS58be8gppjY5XEHzy/gV+hnXSAR7Jj5zLryQNnf0+jcIWzesiliEckYe
	0+UNDLVR9Njyv1TLhn2pXWqrxv/KMeKMjapnXbUKoOaOZ2lfRcYwvRsgQOjs5m9C
	XvUrQVDZq3VycUNXMRiC0SWEprDz6ehz47uAkgroulf2h0JG3G8QOktFsXM0J8M7
	OjX8X+lKAsmMSz5CprB839t68gACmws6TMrLDT2MgoZt8RnOP2vfo0GiJmF0pHoO
	ut3HA==
X-ME-Sender: <xms:a6NFaiPbtBgntiy2PYhQolc3yiiFkRNbWFth5quAzTi4XU40InIN6A>
    <xme:a6NFasYNva5jARCQlc8H-l1m_R9eel2Bv1aXRYa_0dk0fPcXtGK43jGiogXeWuGnP
    CkONhmfhaeqeShY-5oqR6BmG6zYUsesZqcovHU_PvPG8-GEUig>
X-ME-Received: <xmr:a6NFaszUUS-nvNGQeqjl10KXpM4vzqHFNKDUvWm_ecbnUh6s-dndVH_AW5pG-bZxdmOigHEdy_NWIEnf0JZaeJaNif-OrEY>
X-ME-Proxy-Cause: dmFkZTEv1mzKvUP1vX1wYjS0gtAbJw3Z/i26L09D4vAz6A9959EaNTnRaYAT65JWIgQZQd
    muIY4vW/+1iC+BeoOqvwWlMtev/YNmpp+Q/AYquoqPer6Rnh/0+YT2YnH90GUsX22b744P
    zQhFB1E5/9VldrZXU+X7mtIqGFZ9VVCc8LBG3WZIwTJOUAsF6ujGMZjVAeAGnAJa9OSe4B
    oLCaL6SIwVmCllpXx5WJVDW9cgdAm1V/W2qOGpKa5K//denL/kf3yLwozPfNPNuF0d9xK2
    x4c2PwlRlcRun0I71kwfFZGmWDh0paXV04WIdxqZi5J7sW7tROyIZu9P4AgWz92DRANzJh
    U+IrNflhIWqK7Dd/GyGM+VkVQEnNf1gg/9nj2E11Fv8XF0W1ABpK06TLrH5D/PrQt/lSqJ
    kgb91f9z3nIt9JNuQYKEbzy2JzVy7WSEjJfLMLO13A+EJeeFbS5UXEsBJ69xENTFlid4+G
    74kR4f612vxSmGG+FpPeNlIY2deQjPrKCxMTCnnOYeKnS4P5Pxv5IP0KF40Eeh0iTmTNkg
    BFOZ1yWJSKhEmJKnqe+GQMXZm884xNrkK6Qf8AqUziwi6Nea4Pc7PpK9nX4cwj/CFSh6BH
    kvheDN71cAPN8EnwfOwhxPbX1ouxdkuejBp7bkKlfgnLmqnaqK9lnrHHIR7g
X-ME-Proxy: <xmx:a6NFanLJQ9rNmOwbDG9H1E4oc2r7bvMHOIvn_KIuqx55MZDbDuTlRg>
    <xmx:a6NFamrEAwpEb8yVgNTloyHqZLRQEQ6nKcjZfB8_6LtzsGzzwq5Z6g>
    <xmx:a6NFamIHaykll_xcF59ledUVCnPxgoPAaLLTG5Qt_9LcCzyiQhCl9g>
    <xmx:a6NFarTtocqBuNyoKEgfxdQvqs_G2RbdA-R0IgM3dBMET9e_6Gh55Q>
    <xmx:a6NFau_nxe_hM6DMlxOWEWuPDEpKRKI6f9yq8yZi-hTOwJTjEaHsfQr->
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 19:31:53 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] VFS: enhance d_splice_alias() to handle in-lookup dentries
Date: Thu,  2 Jul 2026 09:29:02 +1000
Message-ID: <20260701233128.3356519-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260701233128.3356519-1-neilb@ownmail.net>
References: <20260701233128.3356519-1-neilb@ownmail.net>
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

Some filesystemss (NFS) skip ->lookup processing for
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

Once updated to handle nr_dentry_negative as is required for
hashed dentrties, __d_add() contains code that is identical to
__d_instantiate(), so the former is changed to call the later, and both
d_add() and d_instantiate() now call __d_add().

* There is also d_make_persistent() for filesystems which are
  dcache-based and don't support mkdir, create etc, and
  d_instantiate_new() for newly created inodes that are still locked.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/vfs.rst |  4 ++--
 fs/dcache.c                       | 30 ++++++++++++------------------
 2 files changed, 14 insertions(+), 20 deletions(-)

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

