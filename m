Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED93431F2;
	Thu, 30 Apr 2026 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518569; cv=none; b=Vj+rdZ7WPgPf+kTMNk67uUN887YqtCfYwDwao1jRFpJpmxPQtN65poQ8A7GoZUFWIe0fq51ZyjK4JhWu7WppuJ/hLuP1uD1Wdnhn/1342h/EZ+Fdnc6Dwpfy2wEATWalluw5NgmqYViPh+Q7PoJ1FrDnWiWpZYAbtt2OLgAK+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518569; c=relaxed/simple;
	bh=5mBhhdWXfdaAZ07YKnPOt9GDUV+dFOUGUrrpEQj+IH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l57NqjwnqH8pJM4+xNYWeyjG7xC8wsO4zZuopTZLgDDjmO1ETez6OI876eo/3BerPU2KuNnJkOBu9mx+hbmv5LVYaDbfkkoji8ibcfr8Su4u5T3CKWztnZ65yfapY/yNLsU2vJcAPHUwe8uq/8cICXfXz20nIrUx0341iKMeul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=CsREaFYr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vgkM2n3+; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="CsREaFYr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vgkM2n3+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECA3E7A00EA;
	Wed, 29 Apr 2026 23:09:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 29 Apr 2026 23:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777518566;
	 x=1777604966; bh=o0VDMq63HKComdkN2neiDrUWUFgUELHBmVs/SqfLOjc=; b=
	CsREaFYrHvwKXb/dFGYAiGE7kmce7C5j6kWxFlszcFdtontDRTCY8qe/PFlNryTF
	/n/CuELwbu0h0+oODm3MFOoi/OV9JXTnvvh4B1/LryqMgH9jSokErgjXr7P1fYzU
	PGk3NpKXpUzgc6QEZmyIJYSqDuaal8p2hfYEmcBmPBdq1IRzLnvyFGQbCKv2pygg
	CJA26DGnqrUTEVA7Z0PduyWdtMRBI3fyYZX2MXC2AB+cDPwfLlrVjrxdHiCYeV+y
	WYHIws8I8zCtGydS1nhGgEFYiok8VwduVwJ7gV6EzT2dwvFHjLcOtkdyAFkrOJeY
	lUuv0wmHUxxIDOjqfZeAaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777518566; x=1777604966; bh=o
	0VDMq63HKComdkN2neiDrUWUFgUELHBmVs/SqfLOjc=; b=vgkM2n3+3vpZFFJVk
	JTXjuC+PDfWMgD9LZxbDQF2GR2Dpt1+qK9CXLl9TXxpRFdKg74Z/J7IIfjaw9U0H
	QcZU4Pq0vKBXZCz8P2zWJKOBGOgk1Q+sJnEuDB4h8Um9nFmoWutAuWhmoO/5S2Oa
	lftmKDBtSXZjIwwnyCGvDEge6d6P7rvYXxhXZX1RIio61DPpxyd9T4DzV287qd51
	rRAq3uKAIPYMJlWYgrKI7/iTkilr+tqm24PjcwpSy3HhBhfJmKSuyzxNNWZr0hsO
	ISS+Ox81aDS+n+JT6aXZmCm71IX8LCUmO2fmHjPbetOWrObiJScvo6r68+VkiltJ
	JHJ1A==
X-ME-Sender: <xms:5sfyael4y4hx3Jouu5g6yY75hRTYxz6L0V8P_SAQnvXl7ZKoekcpgQ>
    <xme:5sfyaYaxw8QSkndjog8hOaqO2ijLKO1iXFEEVKjLNWpUl8PZpK_MvZ4t9gsjcYLzX
    78DqS5EK-9lAid5fBV4VAnclTCkin5qS-f0zI5IaleXGZHuQg>
X-ME-Received: <xmr:5sfyaQTPdvtT2BmR1xSN5pQRR4xDrYrYE0nWLxZsiZcSaCtR0ixj93ma_o_gzAvhy1bflSrNIoX13ooos5Ee6bFiutmnjqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5sfyaSty0CyR1WWtVi1I5pbr1BH9CPThvDyI8wP6OKZKLMYndJM--w>
    <xmx:5sfyaSFud2ach9Pm_1eb3b72LenPj4h-VZ-wWHctM7TQCHtWfwJK4A>
    <xmx:5sfyaTxA2SN6iEhXWGA6hbbtZOvIZKEfTr9hUnQy-J2BkHrKkxZbTQ>
    <xmx:5sfyac09jXvdEXE8_7ehxBfztWKPN9qLy4wZHUkVgJCM-LdPXgNMzg>
    <xmx:5sfyaTseE_ZTW8KTGo2pSh-iAN5r08XDlX9pMhTTLUKWJSkuLHFEVHph>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:09:24 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] VFS: enhance d_splice_alias() to handle in-lookup dentries
Date: Thu, 30 Apr 2026 11:56:56 +1000
Message-ID: <20260430020137.3305302-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260430020137.3305302-1-neilb@ownmail.net>
References: <20260430020137.3305302-1-neilb@ownmail.net>
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

Some filesystemss (NFS) skip ->lookup processing for
  LOOKUP_CREATE|LOOKUP_EXCL
which includes mknod, link, symlink etc.  So these inode operations
might get an unhashed or a hashed-negative dentry.  There is no
interface for instantiating these so again they need to unhash
first (nfs_link)

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
index 1a065df22ecd..a4ee380f3dfc 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2068,7 +2068,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
- 
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(d_really_is_positive(entry));
@@ -2829,18 +2828,14 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 		dir = dentry->d_parent->d_inode;
 		n = start_dir_add(dir);
 		__d_lookup_unhash(dentry);
+		__d_rehash(dentry);
+	} else if (d_unhashed(dentry)) {
+		__d_rehash(dentry);
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
 	if (dir) {
 		end_dir_add(dir, n);
 		__d_wake_in_lookup_waiters(dentry);
@@ -3142,8 +3137,6 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	BUG_ON(!d_unhashed(dentry));
-
 	if (!inode)
 		goto out;
 
@@ -3192,6 +3185,8 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
  * @inode:  the inode which may have a disconnected dentry
  * @dentry: a negative dentry which we want to point to the inode.
  *
+ * @dentry must be negative and may be in-lookup or unhashed or hashed.
+ *
  * If inode is a directory and has an IS_ROOT alias, then d_move that in
  * place of the given dentry and return it, else simply d_add the inode
  * to the dentry and return NULL.
@@ -3199,16 +3194,14 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
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

