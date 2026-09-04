Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0C43D503;
	Fri,  4 Sep 2026 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558834; cv=none; b=V0R14Lakq7TWtIvvANhPw8sig1SePJFEOfz11glag69gecPkyOhYdUwii3ldcfUdPPT+JJK12NUhtYE4B7buM2SRsrYdk59SzeGjvHrYtjD/uY/F6W2BaI7+h4LmcUoSgrGCyBPgVSet6v72Ok6VyC0tPsxYiyUe9CcHd1e2wik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558834; c=relaxed/simple;
	bh=QyziwjqPMuKUE0Ywdu8lOJLdi6iNAo/ZH9vHAtT5uy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctLC3kT3jY2m7zhSQWpsoIkmKrGX7ouCWnakDe/zAtd1dVKzMcAsSXJHhUu4rlNsj/LHo0bvnrx9sSKcwwhbstude7xVzny2eH/RpUUyQ6seB1E55wDWQhBwUJ1UO8DS67CNdcUnR8PYpWGrZcw4odYsIQ2zOXj/mPmnmeQuu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nhrta9X7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hrwp4K6u; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nhrta9X7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hrwp4K6u"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 406AFEC0148;
	Fri,  4 Sep 2026 17:53:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 17:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788558831;
	 x=1788645231; bh=BM84miZIdMOU+h52rKqAXVXjLVrvMNKt0AXMbFVF+8k=; b=
	nhrta9X7GX0M3ZwZ3XCrXHXNOs+HxbD5/C/9z9wpWZjBnYRhHbHq4kh9zwiyG6kH
	+XUIqLZ1MqbM1WkrjPY1Ffo0b70lGymj2bzZ4qak+fkww8RCTWzEDZ3mZcZJMBrs
	Hka5/1d7iruC9GNXx9DfegQNFaOA9OgRZ+2o31uBBGEGe1iFByOLHkpfAb1k6Cq2
	f2sgZ1U/7pFuaYicf4ruPYmaBD2H89P2Hyv2oEsmdg0IPBffiK7O0DT7w5ygt5F0
	QONTqrhlUt1IHmka/Fxen3dysLhnSWo8wlHyCVleBHaQ62CTJiXtowwFRnzMzixp
	QoRlbqo5oAcwJ6/rFlvr1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788558831; x=1788645231; bh=B
	M84miZIdMOU+h52rKqAXVXjLVrvMNKt0AXMbFVF+8k=; b=Hrwp4K6u3j5crd1pZ
	VlVZwVML3G/CcKPDYRlim35qLemloeCZD/6lcOh+o8wOiw3EY5iPGjJ3/e2kDlpu
	0XJse7DFWJod7HvKF9ffN5rIs3+6X2ORTQh7uU8VpxrTteaNDNn715MLY5svwXdY
	7mgknh7PBLRS+ND+mOTWkQJf4+uB9pdzOZZoR0dA9tOvMzT5Sn4aKq7GsmEcjFgN
	1/DQcVapAQbkmThRdCenV/hCOEhPff4bnOjsI8E6AFuiIWnPQBWxusd48Y9TTXxB
	rp2QSfStR22xOx48vo8aFpLashoJEwjiS4S2I9/h6Vp64qdON03P+7O75APIq5CL
	xHu0w==
X-ME-Sender: <xms:7z2bavHBmU8tGjjBS0r3X0BLgtQj6PgdjDaH96vZGYc9gUTD7CxgSg>
    <xme:7z2bau75lQPNtBusJ7zGYTgIdoQd8hLxx1r_p6VIal7T2jHvG7JGe2k8GEgNcojxU
    0sk2Xfdzq_Jz041cs_nVWEL3Tu1RW7m9BELi6hsliwQRMnEMVM>
X-ME-Received: <xmr:7z2bakwT7ZekJlVEwvgkumlA0CDV1SU_4wg4mtBxzxXe8uOWK80L6ECDV36hey1304APcVvYyxI4KnzBg_ZlAwpafI8t41w>
X-ME-Proxy-Cause: dmFkZTFDVljjZPAYZ1l/aqq4nrL+3Kba1UGdgNzRbLHxNyZsBntb6givVbdJfo5BU3j95t
    +UQU7WjR6Go54RULzYYdNoUTzLStmDkBzIg7iAUMGGPyun7cXaJ/tB+RDeFqAMJs98sAqA
    8UTNhC/OQM/aHTCEgRGMWo/qNqW4Cm4ZpbUAGc1yB/wYZCmyUFIFjHNO+nBl6KHnpd3kh5
    kJGEMNZuUD6j2jJVpJ5tURud5waXhGOgIEZWqqHFhojd6ln7NIlrB7SgqCD/laD7h+xaRU
    I5R2WpSXAH/sDdSGVPXGsuUa9Zu1lOQJK4tOelP1k+iwmt4tCWllwcYTI4lONAt5xo76VK
    ZbQgvL7/1f8FZ6kq8yTsgb2Y+kN/+A7R9zGfLM2zvYWA+LdZ41luRJh2lPVylusqyP5aBh
    IR3RAWxfhpP/4A4ZbYSFCly023+qulKqlDxnXdpdtzF51nhmFjuv/LL+PZy/4+iIxG+W6X
    v1o0rr4V5gLZeuy3O9FgIk00V8pfVBnG6c0qhTQ8y9f5NCK5JA/3dXLSKP7zz8Nbp/nlVm
    qmkwdc2BwJlpynoGFR9v8zCMo/m1Ci56SDJMCJMKh8SZXRDWedTMgS2pMIhClgTpyoZQMr
    xEm1oAVcIUHr8cLCiPsYt9m/4DyyfLgt87YdFQZ/FxfuZF7cPHqlqMDXQJ9Q
X-ME-Proxy: <xmx:7z2batM05G6R-CcXzVTswsAvW-JpVFQHKrhXdTHaWOTdpj77uMN44g>
    <xmx:7z2baqk_pGylhXLuGOb9tZaTh7rIWhbB9rFm8Hh7cmlkxE5im2cR-g>
    <xmx:7z2baiSnjiLFyvJl1mlyH9AM1Lm8Zt-QJuHGaC6yuoSJaFoMlZRyng>
    <xmx:7z2bapV-Hve-OaM2wpGCArYh6BhycjcFdPgsEF1ioGiZbAbcY9CP-Q>
    <xmx:7z2basu0vv9DcnQLVvckdVrjfL-A7cQ8Xv8sp4kt5G5QaLZ176Ivoj1v>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:53:48 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP lock.
Date: Sat,  5 Sep 2026 07:48:15 +1000
Message-ID: <20260904215142.1060510-7-neilb@ownmail.net>
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

DCACHE_PAR_LOOKUP acts like a lock in that threads can block waiting for
it to clear.  As we plan to make changes to lock order for this lock,
teach lockdep to monitor it so as to help detect bugs early.

As NFS allocates an in-lookup dentry to unlink a silly-renamed file, and
completes the lookup in a different thread, we need interfaces to
release and the acquire ownership of the lock.  This avoids lockdep
complaining that a lock is still held on return to user-space.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 15 +++++++++++++++
 fs/nfs/unlink.c        |  3 +++
 include/linux/dcache.h | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index cbd5738de168..83790c7a4dee 100644
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
@@ -2801,6 +2805,15 @@ static inline void end_dir_add(struct inode *dir, unsigned int n)
 static void d_wait_lookup(struct dentry *dentry)
 {
 	if (likely(d_in_lookup(dentry))) {
+		/*
+		 * Tell lockdep we will wait for the lookup lock, after
+		 * dropping ->d_lock, but won't actually take it.
+		 */
+		spin_release(&dentry->d_lock.dep_map, _THIS_IP_);
+		lock_map_acquire(&dentry->lookup_map);
+		lock_map_release(&dentry->lookup_map);
+		spin_acquire(&dentry->d_lock.dep_map, 0, 1, _THIS_IP_);
+
 		dentry->d_flags |= DCACHE_LOOKUP_WAITERS;
 		wait_var_event_spinlock(&dentry->d_flags,
 					!d_in_lookup(dentry),
@@ -2923,6 +2936,7 @@ struct dentry *__d_alloc_parallel(struct dentry *parent,
 	}
 	hlist_bl_add_head(&new->d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
+	lock_map_acquire_try(&new->lookup_map);
 	return new;
 mismatch:
 	spin_unlock(&dentry->d_lock);
@@ -3021,6 +3035,7 @@ static void __d_lookup_unhash(struct dentry *dentry)
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

