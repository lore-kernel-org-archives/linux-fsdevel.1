Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6833F8D6;
	Thu, 30 Apr 2026 03:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518607; cv=none; b=Bd+OHb8mMeSuAG99s1WNKBfezFSWkIDloHVSZ8+825FVlfge3/2uwQj8DZ9wDliEKsrG5cADo6bQF6tv+lKb4HO0X5wZZlOqzoooit93Ha3Zn5H1HSdBTR5puCQdFV6hksyKuYtTDLpsVfHdEvxwFbyWaJri+uQ/RwHjcB5g3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518607; c=relaxed/simple;
	bh=jf6KAreEhzC9iKfr8qZxGb49Bp93yd84aSdVysagRTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2dCSBKIc07JS4w4uMbAb6kU0DsNqHOZinOfbXleWBjRvF2naqzFnVc0uoNYHz4jpi5hQk5LJapFoG654ZKeM6j595jhrvdT5fsg5Huqb9+Ghkdh2/pysScE3/4tlRS4cnqfj/m/Um3hznjk+8pA3+e41prHpHmHK05w1GZBCHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=kdWmLYrT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q6TRt4Qi; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="kdWmLYrT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q6TRt4Qi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 100B77A0105;
	Wed, 29 Apr 2026 23:10:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 29 Apr 2026 23:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777518604;
	 x=1777605004; bh=+/kF3lV3RjcCVMTQn+tev9+a0eFeqoHqrap29/WwdPI=; b=
	kdWmLYrTY19oXcVjZjjdTQjG+WwO3kxd2siNZq5w5ald1zvAe9Rprrn3ub8qX57O
	30d3iU+VKJ9O0Jgh2JLO1QrMoWlisGpCfrcFQjrfDKTvhTpx/p7aaOoEPkfCP9dq
	BEAHb5HHPvpUKt55ipRDEg0/DwQz1Z03pGIeCi0hSzKOoJ7zDpvto2HLFqIAYlmo
	xH3FFv4rlkfCtkchUkDARz856FpTx/ZGRHVnihZHMi0oit18QDdYqJHxI5uYQDt6
	xaRArjyLxCtMYfVzl9x1SxgZX3sbM63HBH9C19MZ99pZfIggmGCrbZe3XgnUy42L
	VTWHTQmU54B21dBLbNrURg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777518604; x=1777605004; bh=+
	/kF3lV3RjcCVMTQn+tev9+a0eFeqoHqrap29/WwdPI=; b=q6TRt4Qip39wRlxqY
	oxzCFzT3xSsEQI+IZT/rg17q/lwJFaoqIeIo6TzjvPrXSxUA5VLh3kh7z9hxOZY+
	J1Ud9f/NPMXqFs/qJ8SN6lW0pSW/zTu1c4a7Grb/+Qhye3XPlIpNKIxMTJFIm2ga
	LugpOSr//z1dfJ2E9XTY3UrLRQEkMDjMKjVyHU/9o5ay94w0Z9Eei/DT8DLmiIZq
	jBN+NNg/3Kwebrl8s13iliYN/rku+TgVB4fu/slra6BhvmfXPWh36I+Upv06RUn9
	WgJjPYitBz8g3nKrX7HnFJHBIpK6qmG10wSvxvlRj6Kf65y3iehkPfsPJ++p0btY
	9zYSw==
X-ME-Sender: <xms:DMjyaVCAxloavlayu_2t1z6q3JTzm0quVDHJBuhufsOOk7ax5HForg>
    <xme:DMjyaWFiQNpGa7-9Z22FOCZJoQc1Jw9STlnMy6bFrnM4beCq3Qf7mdUPlTE_LO6a-
    vp8Cie3r8_omw7suQkVrfa5a6-wxEx2P9ah8oz5s7VNjS12m6Y>
X-ME-Received: <xmr:DMjyaUPeVhx45hJGewmGcH65xT3pjnEhCrtT-n3hi3wQ-fOL5zjGOY2-lUIZmk42HRZY3bCHdkS-zqiquCajIGcflpCQUs4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DMjyaf6J_SkZu4zA6wF_wF63zW6xrlqSU8VK-25TNOZp-fZ__N_gcg>
    <xmx:DMjyafgklqY21y2sXauc5dQ8RH5M9_Z7ErwAUfTz9511pRnXW_-qqQ>
    <xmx:DMjyacdDZgkCREdGEdKBg8vBGCnVCMqOslBPS9PS_V53Ijm_euNm7w>
    <xmx:DMjyafyh6rcT7kq_st4atpEjXo2uv1vqEDv4vlyt8y-cyu2p7xJTvg>
    <xmx:DMjyaSJjZQky3Xvy9SMjoQsjVs_OITtrZOLEbzP6cA810Ob1fMgrssxE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:10:00 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] VFS: use wait_var_event for waiting in d_alloc_parallel()
Date: Thu, 30 Apr 2026 12:03:23 +1000
Message-ID: <20260430020505.3308841-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260430020505.3308841-1-neilb@ownmail.net>
References: <20260430020505.3308841-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

d_alloc_parallel() currently requires a wait_queue_head to be passed in.
This must have a life time which extends until the lookup is completed.

This makes it awkward to use and particularly make it hard to use in
lookup_one_qstr_excl() which I hope to do in the future.

This patch changes d_alloc_parallel() to use wake_up_var_locked() to
wake up waiters, and wait_var_event_spinlock() to wait.  dentry->d_lock
is used for synchronisation as it is already held and the relevant
times.

In most cases there will be no waiters so the wake_up_var_locked() call
(which can walk an arbitrarily long list) would be a complete waste.  To
optimise this a new ->d_flags flag is added: DCACHE_LOOKUP_WAITER.  This
is set whenever any thread prepares to wait for the dentry, and if it
isn't set when DCACHE_PAR_LOOKUP is cleared, no wakeup is sent.
DCACHE_LOOKUP_WAITER is cleared after the wakeup is set.

__d_lookup_unhash() no longer returns a wq.  Callers check
DCACHE_LOOKUP_WAITER to check if a wakeup is needed, and
wake_up_var_locked() can find the wq.

__d_lookup_unhash() no longer needs to re-init ->d_lru.  That was
previously shared (in a union) with ->d_wait but ->d_wait is now gone
so it no longer corrupts ->d_lru.

Wakeup is move out of end_dir_add() as it is conceptually a separate action.

Co-developed-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  6 ++
 fs/afs/dir_silly.c                    |  4 +-
 fs/dcache.c                           | 83 +++++++++++++++------------
 fs/fuse/readdir.c                     |  3 +-
 fs/namei.c                            |  6 +-
 fs/nfs/dir.c                          |  6 +-
 fs/nfs/unlink.c                       |  3 +-
 fs/proc/base.c                        |  3 +-
 fs/proc/proc_sysctl.c                 |  3 +-
 fs/smb/client/readdir.c               |  3 +-
 include/linux/dcache.h                | 11 ++--
 include/linux/nfs_xdr.h               |  1 -
 12 files changed, 67 insertions(+), 65 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index bfdff4608028..5cc6ae19845c 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1385,3 +1385,9 @@ for_each_alias(dentry, inode) instead of hlist_for_each_entry; better
 yet, see if any of the exported primitives could be used instead of
 the entire loop.  You still need to hold ->i_lock of the inode over
 either form of manual loop.
+
+---
+
+**mandatory**
+
+d_alloc_parallel() no longer requires a waitqueue_head.
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index a748fd133faf..982bb6ec15f0 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -248,13 +248,11 @@ int afs_silly_iput(struct dentry *dentry, struct inode *inode)
 	struct dentry *alias;
 	int ret;
 
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-
 	_enter("%p{%pd},%llx", dentry, dentry, vnode->fid.vnode);
 
 	down_read(&dvnode->rmdir_lock);
 
-	alias = d_alloc_parallel(dentry->d_parent, &dentry->d_name, &wq);
+	alias = d_alloc_parallel(dentry->d_parent, &dentry->d_name);
 	if (IS_ERR(alias)) {
 		up_read(&dvnode->rmdir_lock);
 		return 0;
diff --git a/fs/dcache.c b/fs/dcache.c
index 2c61aeea41f4..1a065df22ecd 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2250,8 +2250,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		return found;
 	}
 	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name,
-					dentry->d_wait);
+		found = d_alloc_parallel(dentry->d_parent, name);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
 			iput(inode);
 			return found;
@@ -2638,32 +2637,24 @@ static inline unsigned start_dir_add(struct inode *dir)
 	}
 }
 
-static inline void end_dir_add(struct inode *dir, unsigned int n,
-			       wait_queue_head_t *d_wait)
+static inline void end_dir_add(struct inode *dir, unsigned int n)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
 	preempt_enable_nested();
-	if (wq_has_sleeper(d_wait))
-		wake_up_all(d_wait);
 }
 
 static void d_wait_lookup(struct dentry *dentry)
 {
-	if (d_in_lookup(dentry)) {
-		DECLARE_WAITQUEUE(wait, current);
-		add_wait_queue(dentry->d_wait, &wait);
-		do {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			spin_unlock(&dentry->d_lock);
-			schedule();
-			spin_lock(&dentry->d_lock);
-		} while (d_in_lookup(dentry));
+	if (likely(d_in_lookup(dentry))) {
+		dentry->d_flags |= DCACHE_LOOKUP_WAITERS;
+		wait_var_event_spinlock(&dentry->d_flags,
+					!d_in_lookup(dentry),
+					&dentry->d_lock);
 	}
 }
 
 struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name,
-				wait_queue_head_t *wq)
+				const struct qstr *name)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2766,7 +2757,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return dentry;
 	}
 	rcu_read_unlock();
-	new->d_wait = wq;
 	hlist_bl_add_head(&new->d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
@@ -2778,13 +2768,26 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 EXPORT_SYMBOL(d_alloc_parallel);
 
 /*
- * - Unhash the dentry
- * - Retrieve and clear the waitqueue head in dentry
- * - Return the waitqueue head
+ * Move dentry from in-lookup state to busy-negative one.
+ *
+ * From now on d_in_lookup(dentry) will return false and dentry is gone from
+ * in-lookup hash.
+ *
+ * Anyone who had been waiting on it in d_alloc_parallel() is free to
+ * proceed after that.  Note that waking such waiters up is left to
+ * the callers; PREEMPT_RT kernels can't have that wakeup done while
+ * in write-side critical area for ->i_dir_seq, so it's done by calling
+ * __d_wake_in_lookup_waiters() once it's safe to do so.
+ *
+ * Both __d_lookup_unhash() and __d_wake_in_lookup_waiters() should
+ * be called within the same ->d_lock scope.  PAR_LOOKUP is cleared
+ * here, while LOOKUP_WAITERS (set by somebody finding dentry in
+ * the in-lookup hash and setting down to wait) is checked and cleared
+ * in __d_wake_in_lookup_waiters().  Both are gone by the end of
+ * ->d_lock scope.
  */
-static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
+static void __d_lookup_unhash(struct dentry *dentry)
 {
-	wait_queue_head_t *d_wait;
 	struct hlist_bl_head *b;
 
 	lockdep_assert_held(&dentry->d_lock);
@@ -2793,18 +2796,23 @@ static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 	hlist_bl_lock(b);
 	dentry->d_flags &= ~DCACHE_PAR_LOOKUP;
 	__hlist_bl_del(&dentry->d_in_lookup_hash);
-	d_wait = dentry->d_wait;
-	dentry->d_wait = NULL;
 	hlist_bl_unlock(b);
 	dentry->waiters = NULL;
-	INIT_LIST_HEAD(&dentry->d_lru);
-	return d_wait;
+}
+
+static inline void __d_wake_in_lookup_waiters(struct dentry *dentry)
+{
+	if (dentry->d_flags & DCACHE_LOOKUP_WAITERS) {
+		wake_up_var_locked(&dentry->d_flags, &dentry->d_lock);
+		dentry->d_flags &= ~DCACHE_LOOKUP_WAITERS;
+	}
 }
 
 void __d_lookup_unhash_wake(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
-	wake_up_all(__d_lookup_unhash(dentry));
+	__d_lookup_unhash(dentry);
+	__d_wake_in_lookup_waiters(dentry);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(__d_lookup_unhash_wake);
@@ -2814,14 +2822,13 @@ EXPORT_SYMBOL(__d_lookup_unhash_wake);
 static inline void __d_add(struct dentry *dentry, struct inode *inode,
 			   const struct dentry_operations *ops)
 {
-	wait_queue_head_t *d_wait;
 	struct inode *dir = NULL;
 	unsigned n;
 	spin_lock(&dentry->d_lock);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir = dentry->d_parent->d_inode;
 		n = start_dir_add(dir);
-		d_wait = __d_lookup_unhash(dentry);
+		__d_lookup_unhash(dentry);
 	}
 	if (unlikely(ops))
 		d_set_d_op(dentry, ops);
@@ -2834,8 +2841,10 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 		fsnotify_update_flags(dentry);
 	}
 	__d_rehash(dentry);
-	if (dir)
-		end_dir_add(dir, n, d_wait);
+	if (dir) {
+		end_dir_add(dir, n);
+		__d_wake_in_lookup_waiters(dentry);
+	}
 	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
@@ -2948,7 +2957,6 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 		     bool exchange)
 {
 	struct dentry *old_parent, *p;
-	wait_queue_head_t *d_wait;
 	struct inode *dir = NULL;
 	unsigned n;
 
@@ -2979,7 +2987,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	if (unlikely(d_in_lookup(target))) {
 		dir = target->d_parent->d_inode;
 		n = start_dir_add(dir);
-		d_wait = __d_lookup_unhash(target);
+		__d_lookup_unhash(target);
 	}
 
 	write_seqcount_begin(&dentry->d_seq);
@@ -3018,9 +3026,10 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	write_seqcount_end(&target->d_seq);
 	write_seqcount_end(&dentry->d_seq);
 
-	if (dir)
-		end_dir_add(dir, n, d_wait);
-
+	if (dir) {
+		end_dir_add(dir, n);
+		__d_wake_in_lookup_waiters(dentry);
+	}
 	if (dentry->d_parent != old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
 	if (dentry != old_parent)
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index db5ae8ec1030..a2361f1d9905 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -164,7 +164,6 @@ static int fuse_direntplus_link(struct file *file,
 	struct inode *dir = d_inode(parent);
 	struct fuse_conn *fc;
 	struct inode *inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	int epoch;
 
 	if (!o->nodeid) {
@@ -201,7 +200,7 @@ static int fuse_direntplus_link(struct file *file,
 	dentry = d_lookup(parent, &name);
 	if (!dentry) {
 retry:
-		dentry = d_alloc_parallel(parent, &name, &wq);
+		dentry = d_alloc_parallel(parent, &name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 	}
diff --git a/fs/namei.c b/fs/namei.c
index 65e60536a6d1..a6349b31fdb6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1891,13 +1891,12 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 {
 	struct dentry *dentry, *old;
 	struct inode *inode = dir->d_inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	/* Don't go there if it's already dead */
 	if (unlikely(IS_DEADDIR(inode)))
 		return ERR_PTR(-ENOENT);
 again:
-	dentry = d_alloc_parallel(dir, name, &wq);
+	dentry = d_alloc_parallel(dir, name);
 	if (IS_ERR(dentry))
 		return dentry;
 	if (unlikely(!d_in_lookup(dentry))) {
@@ -4414,7 +4413,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -4423,7 +4421,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
-			dentry = d_alloc_parallel(dir, &nd->last, &wq);
+			dentry = d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
 				return dentry;
 		}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e9ce1883288c..9580af999d70 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -726,7 +726,6 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		unsigned long dir_verifier)
 {
 	struct qstr filename = QSTR_INIT(entry->name, entry->len);
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct dentry *dentry;
 	struct dentry *alias;
 	struct inode *inode;
@@ -755,7 +754,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 	dentry = d_lookup(parent, &filename);
 again:
 	if (!dentry) {
-		dentry = d_alloc_parallel(parent, &filename, &wq);
+		dentry = d_alloc_parallel(parent, &filename);
 		if (IS_ERR(dentry))
 			return;
 	}
@@ -2106,7 +2105,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		    struct file *file, unsigned open_flags,
 		    umode_t mode)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct nfs_open_context *ctx;
 	struct dentry *res;
 	struct iattr attr = { .ia_valid = ATTR_OPEN };
@@ -2162,7 +2160,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		d_drop(dentry);
 		switched = true;
 		dentry = d_alloc_parallel(dentry->d_parent,
-					  &dentry->d_name, &wq);
+					  &dentry->d_name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 		if (unlikely(!d_in_lookup(dentry)))
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index df3ca4669df6..43ea897943c0 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -124,7 +124,7 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 	struct dentry *alias;
 
 	down_read_non_owner(&NFS_I(dir)->rmdir_sem);
-	alias = d_alloc_parallel(dentry->d_parent, &data->args.name, &data->wq);
+	alias = d_alloc_parallel(dentry->d_parent, &data->args.name);
 	if (IS_ERR(alias)) {
 		up_read_non_owner(&NFS_I(dir)->rmdir_sem);
 		return 0;
@@ -185,7 +185,6 @@ nfs_async_unlink(struct dentry *dentry, const struct qstr *name)
 
 	data->cred = get_current_cred();
 	data->res.dir_attr = &data->dir_attr;
-	init_waitqueue_head(&data->wq);
 
 	status = -EBUSY;
 	spin_lock(&dentry->d_lock);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..d55a4b603188 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2132,8 +2132,7 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 		goto end_instantiate;
 
 	if (!child) {
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-		child = d_alloc_parallel(dir, &qname, &wq);
+		child = d_alloc_parallel(dir, &qname);
 		if (IS_ERR(child))
 			goto end_instantiate;
 		if (d_in_lookup(child)) {
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 49ab74e0bfde..04a382178c65 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -692,8 +692,7 @@ static bool proc_sys_fill_cache(struct file *file,
 
 	child = d_lookup(dir, &qname);
 	if (!child) {
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-		child = d_alloc_parallel(dir, &qname, &wq);
+		child = d_alloc_parallel(dir, &qname);
 		if (IS_ERR(child))
 			return false;
 		if (d_in_lookup(child)) {
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index be22bbc4a65a..a8995261831c 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -73,7 +73,6 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	bool posix = cifs_sb_master_tcon(cifs_sb)->posix_extensions;
 	bool reparse_need_reval = false;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	int rc;
 
 	cifs_dbg(FYI, "%s: for %s\n", __func__, name->name);
@@ -105,7 +104,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 		    (fattr->cf_flags & CIFS_FATTR_NEED_REVAL))
 			return;
 
-		dentry = d_alloc_parallel(parent, name, &wq);
+		dentry = d_alloc_parallel(parent, name);
 	}
 	if (IS_ERR(dentry))
 		return;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 2577c05f84ec..97a887be150a 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -116,10 +116,7 @@ struct dentry {
 					 * possible!
 					 */
 
-	union {
-		struct list_head d_lru;		/* LRU list */
-		wait_queue_head_t *d_wait;	/* in-lookup ones only */
-	};
+	struct list_head d_lru;		/* LRU list */
 	struct hlist_node d_sib;	/* child of parent list */
 	struct hlist_head d_children;	/* our children */
 	/*
@@ -210,6 +207,9 @@ enum dentry_flags {
 	DCACHE_REFERENCED		= BIT(6),	/* Recently used, don't discard. */
 	DCACHE_DONTCACHE		= BIT(7),	/* Purge from memory on final dput() */
 	DCACHE_CANT_MOUNT		= BIT(8),
+	DCACHE_LOOKUP_WAITERS		= BIT(9),	/* A thread is waiting for
+							 * PAR_LOOKUP to clear
+							 */
 	DCACHE_SHRINK_LIST		= BIT(10),
 	DCACHE_OP_WEAK_REVALIDATE	= BIT(11),
 	/*
@@ -256,8 +256,7 @@ extern void d_delete(struct dentry *);
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
-extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
-					wait_queue_head_t *);
+extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index fcbd21b5685f..6aced49d5f00 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1743,7 +1743,6 @@ struct nfs_unlinkdata {
 	struct nfs_removeargs args;
 	struct nfs_removeres res;
 	struct dentry *dentry;
-	wait_queue_head_t wq;
 	const struct cred *cred;
 	struct nfs_fattr dir_attr;
 	long timeout;
-- 
2.50.0.107.gf914562f5916.dirty

