Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B417A305
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368532; cv=none; b=N1g1sMZxglUR2zHH6teG65JzxwbSdjYWVPOiB9oYUvIZvLqlvNycsJSPQp5ACUtjLp/ruYenVMU0rjNQWrxuL+wIW9pJkeReLLO3c2h1S7+zujLfSA9b9ME27K9MW644PCVuNMJsvN8PR8pM1/7NCMK3ygFeDQgkIf0amlbgQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368532; c=relaxed/simple;
	bh=f8+wXCITbmOT3l6jD7lfG7+KtZYVVA41gG2faxJc8WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFvBxtDwscc37MRY2NrKOjCc2aU7fG6L2pfGrErKUtdzbI5VNcH0a2ZN5v6DT8ag+ahwZ33stReW5w3jIteDM9sQ/bK3zI/JQf76JcEO+9HohAYTBxhVY9n3LRBzKSMUNTDbxUwwPI8xwxyhajT4SliF/jRmAIb0bGgDJQSiqJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=U/Os4Vmz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CsL/bso4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="U/Os4Vmz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CsL/bso4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A43157A0196
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 20:08:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 18 Oct 2026 20:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1792368530;
	 x=1792454930; bh=bRGkkF+ZnzJ7xIukdXlv4P/PuAhtwWKBRnuLfqe7zi4=; b=
	U/Os4VmzYNX6zN+qKUPYBR54C/D+1zRav8vwHeHZMM2/5jGyUH1jIo5Fn1+e5MiW
	D7tO8NqljtYyp0gc4Hi39CSoe4bTWAg/fSVmDXohCi4MEb3NeOZsXq6A7d0HLJgN
	Idhn/0/Yo0pF8YvuYrsc5oOWJueSizTVSgLwGRLXAcLB4LzhHZtI6XcsQrXBfJ+t
	EfqnY3OUQGb7Irr8+eeP87XKCu7l4cxqgTR8b8caluUib/cZjto+aZ5x03pMSM1u
	+81VWUyUFk1UUiWOw5HClONEavqrCMcdlGt/s7mcKSm6FkD0b4QRVdQxSK+rIaP9
	5sJLwqWQwSxzuABgvFZ0aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792368530; x=1792454930; bh=b
	RGkkF+ZnzJ7xIukdXlv4P/PuAhtwWKBRnuLfqe7zi4=; b=CsL/bso4rLty7UksA
	t4LG+pevK9NC9zDmg/+L8Z0HUT8K/uxFulirQ3phqURb655VJajjHh7jc9lNBAxK
	fx4eKydF2sbAVUqOG6oQG7QZ8UmjDcOhXoMwdSIlOtTi3r+PH/v7+nBcGbfY66c9
	0dvEWdhdnSXz6N6nUVCAk0EJ6wofbz1cfDOQsWz3+Tq2XU7McwKCFkQuiKD+rwXz
	UcZ2hZVrvnpl8pXmkHZzhR3HyFIGTJtwCGOkWaDTkg4YmU98OGmnlZgO/4xunGbT
	dgKbDYo7tq8rLdLbh6nQ3bSLElnE8oIjtedoiB/qyiTHBIESdpA9kYQT1+zsmNvT
	vkpuw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792368530; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:TOlmTUiFdVUyoyK+v0/2mYrcUdALu4VCwnXx59+51ff58HO
	gWm1/ZkQ9c3vpuz/LHntBcF1y+JXpX4ntD0ZuvMWHZHOWophHKJhhieO6S1Wnu19
	BR06zRuWTEyP8H48/O6aVUgEkL+Bu1kB0RlhiFuAR6F0QYcTbxkep1dnO8aKrm4V
	iWr1zRGIr/Ty2GXbUrW5C1FQEddTFFECp7mukHaafcebvcx2etPPqX+RpOZLBquA
	MS2w9dbME3y8H2EGXyJgtUAtIvoEpPt8uD9ZQ6gzNmmvrHxBDy8euxuNL6pLK4X3
	FCe+74/CNP/uhJT6DEIN+y8zkMoiPUbD71ZebGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:fXRuDqOd0RvEjtgV2E4J8t9esl+Di6R5Dseq7NMzc+I=:f8+wXCITbmOT3l6jD7lfG7+KtZYVVA41gG2faxJc8WA=;
X-ME-Sender: <xms:kl_Vasexgjmn0eaHOSPZjS0Y20IGBNXklv9dWLFM3dGhxK18nP790w>
    <xme:kl_VagxchpAIezVFJp87361MV5K1eq0q2dEuWhLjt4gjXkb6iS1V5lqEB0HOy0PAZ
    PiRHoBIk668PTzwzzebeW3K2YVXembvm_sSzzzb-KQ9sryIUEA>
X-ME-Received: <xmr:kl_VahLOFQqmK7RoZlv4_n8_uM91gXTsYQLka10vSdvO98KMBxk-REye4dEso0_o5YatxFNOeJNAIxkcVvxn2mm5hZRGl0E>
X-ME-Proxy-Cause: dmFkZTFXUyzoXoBkNmYG35cDD28CxgKMJ+EmwrN8wAlNqEm0TwF62vLBdOcpP5ajUxn86r
    5fayCOFfSiEz8RIMB8B3OhzV6/yTUY6s/brxlPOQpdXvN7c5l9e8zsMuqA5ueGG2pMubX6
    22866RgnFHeiANKu8oegfGwl3DIBAyqkDbMks9xSiKq4VXwN1cOHe1WiP7lQPL3deaGKSt
    Bh1dDSOYvmqs9kClQRylkG11N7pq+wnyJFbAXiaZ1lSqys/JRCo9SV7wSTasV3N9gjwEsW
    gAw0NvjqsNAbGkFh01PuLIx9GenZ/+5JM+/0y4OYpaeF9272N0lZDCx0k0rY25EWEw/wKn
    R5Fl1+PMSoTLilx682fp4nldh4DrZVRBTOmqUwItrbt3xAj/KZKl8s6ppPkEQgzrnRWKjr
    U7VkO1uozikBkpePviHWQDHu6O51/Auh2cx7AbWs8V+HOzj6ZQv8k9lxKDOPRXHXi0Ad1B
    Gzd7DGDuKvIRT9dxxC21DfXwfwD86O3jEisrlvlmkLRi9Dt6UYSSybv43nhlUEynX4FIug
    5mf798yILcA9/7Ifhu+uGx4RufUipxULNhOidpCgg90NUP8GJnykPa7XkjIMQqfLtyoBMK
    IGJgkiNax6dESf/rh952v/GsoqJ3oFqjJ2TTJxDqDsAvE4z7jkfneDSGl0ww
X-ME-Proxy: <xmx:kl_VaiGfkYQ4wrHS8yOEjMxssQ7lvmENvQ8yEscSphbSBxWMhjfpGA>
    <xmx:kl_Vat-W5BiLIsg1coUuzqne385yduX3ejlvjwYjbsiZmR-vioGiTw>
    <xmx:kl_VaiJNFoJUjrpkSnjteYVGjpQWpB9lp5JB3ZT9zkbz-LkQO1Ejsw>
    <xmx:kl_VartfKs3dniYcAP7hoWfwF3nXz0tdAwMPT4HPVCRxxe-lzhxGlQ>
    <xmx:kl_VaiPQWW6LXwaxLDgAhC9R2RAOm12qux-jlhoPaLIQBQ9RffvxD293>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 20:08:47 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v4 4/5] Add d_for_each_positive_child family of iterators
Date: Mon, 19 Oct 2026 11:00:42 +1100
Message-ID: <20261019000810.1837917-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261019000810.1837917-1-neilb@ownmail.net>
References: <20261019000810.1837917-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Provide iterators for the d_children/d_sib lists.  These iterators only
report dentries that are positive (though they could be negative by the
time they are used).  As DCACHE_DENTRY_CURSOR dentries are never
positive they are never reported.

d_for_each_positive_child() takes the parent lock and sets the iterator
to each positive child in turn.

d_for_each_positive_child_continue() can continue after an existing
dentry, or (when initialised to NULL) behave like
d_for_each_positive_child().  This requires that something prevent the
start dentry from being moved before
d_for_each_positive_child_continue() can take the parent lock -
typically ->i_rwsem.

The use of scoped_guard() in these macros makes it safe to "break" or
"goto" out of the loop - the lock will be dropped in that case.

As there are reports that large numbers of negative dentries can lead to
soft lockups when walking the d_children/d_sib list, particularly in
fsnotify_set_children_dentry_flags(), we call cond_resched() as needed
during the walk.

To achieve this we use an on-stack dentry (about 330 bytes) to place a
cursor while calling cond_resched().  On-stack dentries are not standard
practice but should be safe since

Commit 3df5153c5f12 ("make cursors NORCU")

made cursors NORCU, confirming that they can safely be released without
waiting.  Also importantly nothing ever takes a reference on a cursor
that it doesn't own.

To facilitate this, a new __d_init() is split out of __d_alloc() and
used in d_init_cursor() which can be called on an on-stack dentry as is
done in the new d_next_sibling_sched().

Link https://lwn.net/Articles/1079407/
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 107 ++++++++++++++++++++++++++++++++++-------
 include/linux/dcache.h |  67 ++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 17 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3a4d0a025447..8bfcb52eff9e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1892,6 +1892,24 @@ void d_invalidate(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_invalidate);
 
+static void __d_init(struct dentry *dentry, struct super_block *sb)
+{
+	dentry->d_flags = 0;
+	lockref_init(&dentry->d_lockref);
+	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
+	dentry->d_inode = NULL;
+	dentry->d_parent = dentry;
+	dentry->d_sb = sb;
+	dentry->d_op = sb->__s_d_op;
+	dentry->d_flags = sb->s_d_flags;
+	dentry->d_fsdata = NULL;
+	INIT_HLIST_BL_NODE(&dentry->d_hash);
+	INIT_LIST_HEAD(&dentry->d_lru);
+	INIT_HLIST_HEAD(&dentry->d_children);
+	dentry->waiters = NULL;
+	INIT_HLIST_NODE(&dentry->d_sib);
+}
+
 /**
  * __d_alloc - allocate a dcache entry
  * @sb: filesystem it will belong to
@@ -1901,7 +1919,6 @@ EXPORT_SYMBOL(d_invalidate);
  * available. On a success the dentry is returned. The name passed in is
  * copied and the copy passed in may be reused after this call.
  */
- 
 static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
 	struct dentry *dentry;
@@ -1933,14 +1950,14 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		p = kmalloc_flex(*p, name, name->len + 1,
 				 GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 		if (!p) {
-			kmem_cache_free(dentry_cache, dentry); 
+			kmem_cache_free(dentry_cache, dentry);
 			return NULL;
 		}
 		atomic_set(&p->count, 1);
 		dname = p->name;
 	} else  {
 		dname = dentry->d_shortname.string;
-	}	
+	}
 
 	dentry->__d_name.len = name->len;
 	dentry->__d_name.hash = name->hash;
@@ -1950,20 +1967,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	/* Make sure we always see the terminating NUL character */
 	smp_store_release(&dentry->__d_name.name, dname); /* ^^^ */
 
-	dentry->d_flags = 0;
-	lockref_init(&dentry->d_lockref);
-	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
-	dentry->d_inode = NULL;
-	dentry->d_parent = dentry;
-	dentry->d_sb = sb;
-	dentry->d_op = sb->__s_d_op;
-	dentry->d_flags = sb->s_d_flags;
-	dentry->d_fsdata = NULL;
-	INIT_HLIST_BL_NODE(&dentry->d_hash);
-	INIT_LIST_HEAD(&dentry->d_lru);
-	INIT_HLIST_HEAD(&dentry->d_children);
-	dentry->waiters = NULL;
-	INIT_HLIST_NODE(&dentry->d_sib);
+	__d_init(dentry, sb);
 
 	if (dentry->d_op && dentry->d_op->d_init) {
 		err = dentry->d_op->d_init(dentry);
@@ -1980,6 +1984,75 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	return dentry;
 }
 
+/**
+ * d_init_cursor - initialise an on-stack dentry cursor
+ * @dentry: the dentry to be initialised
+ * @parent: dentry of parent where cursor will be used.
+ *
+ * A DCACHE_DENTRY_CURSOR is initalised for use in marking
+ * a place in the d_children/d_sib list.  While sb-related
+ * fields are filled in, they should never be used.
+ * The filesystems d_init is not called and a final d_put()
+ * should not be called, else d_release would be called.
+ */
+static void d_init_cursor(struct dentry *dentry, struct dentry *parent)
+{
+	const struct qstr *name = &slash_name;
+	char *dname;
+
+	/*
+	 * We guarantee that the inline name is always NUL-terminated.
+	 * This way the memcpy() done by the name switching in rename
+	 * will still always have a NUL at the end, even if we might
+	 * be overwriting an internal NUL character
+	 */
+	dentry->d_shortname.string[DNAME_INLINE_LEN-1] = 0;
+	name = &slash_name;
+	dname = dentry->d_shortname.string;
+
+	dentry->__d_name.len = name->len;
+	dentry->__d_name.hash = name->hash;
+	memcpy(dname, name->name, name->len);
+	dname[name->len] = 0;
+
+	/* Make sure we always see the terminating NUL character */
+	smp_store_release(&dentry->__d_name.name, dname); /* ^^^ */
+
+	__d_init(dentry, parent->d_sb);
+	dentry->d_parent = parent;
+	dentry->d_flags |= DCACHE_DENTRY_CURSOR | DCACHE_NORCU;
+}
+
+/**
+ * d_next_sibling_sched - return next sibling, but schedule() first
+ * @child:  current child
+ *
+ * This behaves like d_next_sibling(), but drops the parent d_lock
+ * and calls cond_resched() to avoid any soft-lockup.  A cursor
+ * is inserted as place holder.
+ *
+ * Caller must hold the parents d_lock, and must hold a counted
+ * reference on the parent.
+ *
+ * Returns: the next sibling, or NULL if there is none.
+ */
+struct dentry *d_next_sibling_sched(struct dentry *child)
+__must_hold(&child->d_parent->d_lock)
+{
+	struct dentry cursor;
+
+	d_init_cursor(&cursor, child->d_parent);
+	hlist_add_behind(&cursor.d_sib, &child->d_sib);
+	spin_unlock(&cursor.d_parent->d_lock);
+	cond_resched();
+	spin_lock(&cursor.d_parent->d_lock);
+	child = d_next_sibling(&cursor);
+	d_detach_cursor(&cursor);
+	WARN_ON(d_count(&cursor) != 1);
+	return child;
+}
+EXPORT_SYMBOL(d_next_sibling_sched);
+
 /**
  * d_alloc - allocate a dcache entry
  * @parent: parent of entry to allocate
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3b595adff7b4..55e3b10650aa 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -656,6 +656,73 @@ static inline struct dentry *d_next_sibling(const struct dentry *dentry)
 	return hlist_entry_safe(dentry->d_sib.next, struct dentry, d_sib);
 }
 
+struct dentry *d_next_sibling_sched(struct dentry *child);
+
+static inline struct dentry *d_next_positive(struct dentry *child)
+{
+	do {
+		if (need_resched())
+			child = d_next_sibling_sched(child);
+		else
+			child = d_next_sibling(child);
+	} while (child && !d_is_positive(child));
+	return child;
+}
+
+static inline struct dentry *d_first_positive(const struct dentry *parent,
+					      struct dentry *child)
+{
+	if (!child)
+		child = d_first_child(parent);
+	else
+		child = d_next_sibling(child);
+	if (child && !d_is_positive(child))
+		child = d_next_positive(child);
+	return child;
+}
+
+/**
+ * d_for_each_positive_child - iterate over positive children in the dcache
+ * @child: iterator dentry
+ * @parent: dentry of parent
+ *
+ * Iteratively set @child to each positive child of @parent.
+ * @parent->d_lock should NOT be held.
+ * @child may no longer be positive when the caller examines it
+ * so care is still needed which could involve locking the child
+ * or using d_inode_rcu() to access the inode.
+ *
+ * DCACHE_DENTRY_CURSOR dentries will never be returned, only true children
+ * which have at some point in the past been positive.
+ */
+#define d_for_each_positive_child(child, parent)			\
+	if (({might_sleep();0;})) ; else				\
+		scoped_guard(spinlock, &parent->d_lock)			\
+			for (child = d_first_positive(parent, NULL);	\
+			     child;					\
+			     child = d_next_positive(child))
+
+/**
+ * d_for_each_positive_child_continue - iterate over remaining positive children
+ * @child: iterator dentry and starting point.
+ * @parent: dentry of parent
+ *
+ * If @child is %NULL this behaves identically to d_for_each_positive_child().
+ * Otherwise @child must be an existing child of %parent and subsequent children
+ * in the d_children list of @parent are returned.
+ *
+ * Safely using this requires that something prevents @child from being
+ * renamed to a different directory before we get the lock.  Holding
+ * i_rwsem on the @parent is sufficient.
+ *
+ */
+#define d_for_each_positive_child_continue(child, parent)		\
+	if (({might_sleep();0;})) ; else				\
+		scoped_guard(spinlock, &parent->d_lock)			\
+			for (child = d_first_positive(parent, child);	\
+			     child;					\
+			     child = d_next_positive(child))
+
 void set_default_d_op(struct super_block *, const struct dentry_operations *);
 struct dentry *d_make_persistent(struct dentry *, struct inode *);
 void d_make_discardable(struct dentry *dentry);
-- 
2.50.0.107.gf914562f5916.dirty

