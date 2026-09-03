Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB531B803
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405929; cv=none; b=sySYb3bPWljUT9DVNHkXjHl2HcfKxiIUYloRO4MH8SQdKVYan7z5CFDSnQt7cP+W/CTbUIkPPKwOpmz9vhceVVoKKLMDi1pY2yHwDQTMgU5LskAN9OhRZlT61JXFsq62D/c3Yo5zkHdccwAHuXTcgfYDNYZZr9k/U/BxWber2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405929; c=relaxed/simple;
	bh=jK/58eUjTVGKjKiyrOTvGyAq6vRYXsq5fXWh1iolrlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7YlPN2RJnfEbFE08iqQfBrP7tu0YAIv492/90oe3QlmIBLfCqGjjvqejW21ktoDar9WXGAK/yLWXd3TyxhQwL2dcqkS9PvyNr+dROMyvWPtBpPJxYXDiPhBDs72cl5Q2G/YmbwxOMnLwGT1MhGFPUwsnPFUq/9CSMJ05JJsFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nnKRyWwI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=idt0Fh/R; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nnKRyWwI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="idt0Fh/R"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92D81140010E;
	Wed,  2 Sep 2026 23:25:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 23:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788405927;
	 x=1788492327; bh=C6SvfnZia3V3zWDfLWAEagWI6Gt9PmoCsGxp/+VH06c=; b=
	nnKRyWwIqIfUL+76Ywe3Xn395HbqTCSNfL5JbBmvW0RtpMm0Mt1Alm+np6RR7NtK
	uXsHDkAzV+3chWkDGYmUAHbVyx2kgg90CbgA839ZakVYfbv5aI/EwoNdti+dCsMH
	4caRbrc4NPWx9bp4GGc2KQeYM8Lu3hFFrP1glghULoIntjmx2pw0Tsr0DpESv9Nm
	fHU8pVzAC3NmJ/I5gXTEYwgb6dSwwSI09L+gdSxXUUaOg2+shqhNbS2wEE3izSSq
	8zL+ZAkLzLL1d+9HSmE4umL9117MpaFT9j+HR86KoLLHPQBwlZ+aOKFnjcVg7BDk
	6Qp1Ke7OdS6f73lizu/hiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788405927; x=1788492327; bh=C
	6SvfnZia3V3zWDfLWAEagWI6Gt9PmoCsGxp/+VH06c=; b=idt0Fh/RNgidLz8gV
	GYHiQsocu+64MiAfH29cv/d7tbUw7eMvasuCmaR4k0fRJ6laef7BNQgr76j5ezgC
	pOg9ZbfkSgmA3bBqlpS0eurjOY8li1Ii9doNlIncF7pBzVKFNlWtImGQmUlEn549
	yV6jZ2RWxUNc2+3mW8auqcQtUHJUSUWB+tiY3ML3xj5jsjO/HKSEumibmqiMmAfa
	U4igdXPSOT+Nzs30s8lfsYgPBnmBpQ/4pPbcrtoyfHJh1RejkH3CWojUZMbD2jCf
	yH8e8ve4/gpwd//LwCGie2LW8+IkPryFmPcAtzVTgQtlBZ2xfhOICxdFghzpViuQ
	4oWNg==
X-ME-Sender: <xms:p-iYaqAROaHYuj3Xq5ejA2TGS-LpCZwVrP4dkdNqcuD4tc2_AkZ1ZA>
    <xme:p-iYaumg7zyAi-f3JKy9j9Op1GU8Rc_bKFmdWhpgQXVrdytC2CTZ9SmOAO25oWeZL
    Yb3aRdRxZ7qPTULAP9D1vYuliX7kZo4lni0WrSnoeAGkZP3F6U>
X-ME-Received: <xmr:p-iYatc0PxUenDyA9xw45px5jnxNgsFust1W8L2Fj940gK8QO-TnYn28TJCaEXJorB5CwRgiL5tOdZo1szoFuigWN5dor-8>
X-ME-Proxy-Cause: dmFkZTFqw1J/WE4BZnlnt+9pYGfxTz2N3QuzhmjRtGHuF818xu0ljWfVHmVUTaYb9dP8qh
    gDCqz1Mo9OcVlH6qvi+Guj9EZqYmh52leiv+4PbVILPzWFvwM4rxgizzoZvcZ0nBn5J9t2
    AGMhfo0rty0ynOJuGLVCCm6kw/VYTfTS6kPPwIi1iE98KDkV556lpxg+agNpkyNoTog9Nr
    0jmpsMONMlqaE3x/kyz+4YQg/sXpODZqFEXaC87zQVHpmHbsnNmzkzoHb0ySxX0ZW7F2rF
    gwL9y92lAlbulSYDNQkjrzmhePZvGAkGgr1o/lOH61UW5dmGvKmNvlldCgu7SVfDpjVkRh
    ECPRlkywxImPPgSlUm250knQfbP81fWut2D+6gyS0UJAz8IL19ADprtpu1X4tJ9M38DMit
    wEJHJHN+wwyVXLhqhRqfer8e3b1M/qkcLPWtE/mR46gzgJn4hrKm4jodJxHG2AacqTb1Pz
    Y0tRSirYrWGqqEnyTw2xnAK0zAEYZ42vA7VxBh6xGLcrFDbT8MHR6smHTcaJaCGYZdanzF
    frua3xswaAvfQAKLkDU0+XMCT8qTPou4JgpXZYQ3z2nBnjiXHx+gSRTxa207n7615wtxcX
    5UrFdNxI70syhNelnRUsFIEQOtQxFhcwAfUyK7tEgYOtZfC/ViDR7JP5yZKw
X-ME-Proxy: <xmx:p-iYaqSk_4v3FAlph0SgaT5x144O5cGbpVcZsS6EpZDLZ08y7JTAqQ>
    <xmx:p-iYassvgdy1t3_Vam0BV263jFf-60emAit6jhh83K7J4W78bQDCOA>
    <xmx:p-iYajfZ_oGSsLKHa3dcnnd3nroJsbPWWFQiR-NECG8G5Ko05jCLAA>
    <xmx:p-iYauZ0nGlKX4shpOuO7VV_oGJ8tuTn3QpPlf5Vtnqd9RgYLDDZXw>
    <xmx:p-iYamX8hHV7lfk3sELy-x4dfom4y5lHYCkLAxfNblwNVLEr86JSzQ8f>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 23:25:25 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 6/6] VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP lock.
Date: Thu,  3 Sep 2026 13:01:36 +1000
Message-ID: <20260903032431.142777-7-neilb@ownmail.net>
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

DCACHE_PAR_LOOKUP acts like a lock in that threads can block waiting for
it to clear.  As we plan to make changes to lock order for this lock,
teach lockdep to monitor it so as to help detect bugs early.

As NFS allocates an in-lookup dentry to unlink a silly-renamed file, and
completes the lookup in a different thread, we need interfaces to
release and the acquire ownership of the lock.  This avoids lockdep
complaining that a lock is still held on return to user-space.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 14 ++++++++++++++
 fs/nfs/unlink.c        |  3 +++
 include/linux/dcache.h | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index cbd5738de168..3af8b2ac699f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1901,6 +1901,7 @@ EXPORT_SYMBOL(d_invalidate);
  
 static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
+	static struct lock_class_key __lookup_key;
 	struct dentry *dentry;
 	char *dname;
 	int err;
@@ -1958,6 +1959,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	dentry->waiters = NULL;
 	INIT_HLIST_NODE(&dentry->d_sib);
 
+	lockdep_init_map(&dentry->lookup_map, "DCACHE_PAR_LOOKUP", &__lookup_key, 0);
+
 	if (dentry->d_op && dentry->d_op->d_init) {
 		err = dentry->d_op->d_init(dentry);
 		if (err) {
@@ -2037,6 +2040,7 @@ struct dentry *d_duplicate(struct dentry *dentry)
 		return ERR_PTR(-ENOMEM);
 
 	new->d_flags |= DCACHE_PAR_LOOKUP;
+	lock_map_acquire_try(&new->lookup_map);
 	spin_lock(&parent->d_lock);
 	new->d_parent = dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
@@ -2801,6 +2805,14 @@ static inline void end_dir_add(struct inode *dir, unsigned int n)
 static void d_wait_lookup(struct dentry *dentry)
 {
 	if (likely(d_in_lookup(dentry))) {
+		/*
+		 * Tell lockdep we will wait for the lookup lock, after
+		 * dropping ->d_lock, but won't actually take it.
+		 */
+		spin_release(&dentry->d_lock.dep_map, 0);
+		lock_map_sync(&dentry->lookup_map);
+		spin_acquire(&dentry->d_lock.dep_map, 0, 1, _THIS_IP_);
+
 		dentry->d_flags |= DCACHE_LOOKUP_WAITERS;
 		wait_var_event_spinlock(&dentry->d_flags,
 					!d_in_lookup(dentry),
@@ -2923,6 +2935,7 @@ struct dentry *__d_alloc_parallel(struct dentry *parent,
 	}
 	hlist_bl_add_head(&new->d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
+	lock_map_acquire_try(&new->lookup_map);
 	return new;
 mismatch:
 	spin_unlock(&dentry->d_lock);
@@ -3021,6 +3034,7 @@ static void __d_lookup_unhash(struct dentry *dentry)
 	b = in_lookup_hash(dentry->d_parent, dentry->d_name.hash);
 	hlist_bl_lock(b);
 	dentry->d_flags &= ~DCACHE_PAR_LOOKUP;
+	lock_map_release(&dentry->lookup_map);
 	__hlist_bl_del(&dentry->d_in_lookup_hash);
 	hlist_bl_unlock(b);
 	dentry->waiters = NULL;
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index b57cfaa4d516..c8d712204e64 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -67,6 +67,7 @@ static void nfs_async_unlink_release(void *calldata)
 	struct super_block *sb = dentry->d_sb;
 
 	up_read_non_owner(&NFS_I(d_inode(dentry->d_parent))->rmdir_sem);
+	d_lookup_acquire(dentry);
 	d_lookup_done(dentry);
 	nfs_free_unlinkdata(data);
 	dput(dentry);
@@ -159,6 +160,8 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 		return ret;
 	}
 	data->dentry = alias;
+	d_lookup_release(alias);
+
 	nfs_do_call_unlink(inode, data);
 	return 1;
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 2b7d99ec9306..e7e3ef05313b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -116,6 +116,8 @@ struct dentry {
 					 * possible!
 					 */
 
+	/* lockdep tracking of DCACHE_PAR_LOOKUP locks */
+	struct lockdep_map		lookup_map;
 	struct list_head d_lru;		/* LRU list */
 	struct hlist_node d_sib;	/* child of parent list */
 	struct hlist_head d_children;	/* our children */
@@ -554,6 +556,36 @@ static inline int simple_positive(const struct dentry *dentry)
 
 unsigned long vfs_pressure_ratio(unsigned long val);
 
+/**
+ * d_lookup_release - release ownership of DCACHE_PAR_LOOKUP lock
+ * @dentry: dentry that is locked
+ *
+ * If an in-lookup dentry is to be passed to another thread which
+ * will drop the in-lookup lock, then d_lookup_release() must be called
+ * to tell lockdep that this thread no lock holds the lock.  The
+ * thread that receives the lock must call d_lookup_acquire() to
+ * acquire the lock.
+ */
+static inline void d_lookup_release(struct dentry *dentry)
+{
+	if (d_in_lookup(dentry))
+		lock_map_release(&dentry->lookup_map);
+}
+
+/**
+ * d_lookup_acquire - acquire ownership of DCACHE_PAR_LOOKUP lock
+ * @dentry: dentry that is locked
+ *
+ * If an in-lookup dentry was passed to this thread, the
+ * d_lookup_acquire() must be called to tell lockdep that this
+ * thread now owns the DCACHE_PAR_LOOKUP lock.
+ */
+static inline void d_lookup_acquire(struct dentry *dentry)
+{
+	if (d_in_lookup(dentry))
+		lock_map_acquire_try(&dentry->lookup_map);
+}
+
 /**
  * d_inode - Get the actual inode of this dentry
  * @dentry: The dentry to query
-- 
2.50.0.107.gf914562f5916.dirty

