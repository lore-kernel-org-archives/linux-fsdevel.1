Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B4194C95
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Apr 2026 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775441621; cv=none; b=u4ojII0fKbTelHALuotFSdiaBpW9dE+HVwta2daIJrpwbzsopiPynPFs3kyyjyLB0G3AUvOLFL8KZGH7im2kJL8fsVXKrbL0u5YxGPnNysLlkSM4wEFLYGrvtv760mt/a3BSx2Hw/F1g+aRobmUh8Lwo65RE8+e6nF4IKoze0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775441621; c=relaxed/simple;
	bh=8oeetu90yH6tteVivQLt8DeIms+MVGyQoiC+Y0ZmqAI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BGCAfEQZGiY3GlTjDMsclC9inTYJNj2tKbdKO6dvILHCmwIPeBdXiBSo5x4lZnGqYq4WX+DMV8suhClod2R/Zwl9NC2uMJjJ/vyD9QsNFRkAHooOlNRVYYzlNSCNSUvtH7ZBun0mZoZdZF558HFjBg38qD9+/iopYKJFP0k19jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fVjiLQGZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTD251Yf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="fVjiLQGZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTD251Yf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D82B8140005A;
	Sun,  5 Apr 2026 22:13:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 05 Apr 2026 22:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1775441617; x=1775528017; bh=zyqwGFgBkWIgtTbtvXudqG7fY5HrHKc/eVy
	ukCB5c7U=; b=fVjiLQGZW1hBWdSF9IujPvpwf6MbQ2IOCn+FzEZMq7K0x4yMJjd
	7Dvoi1sMmHZoo6Xtukn3GnmdvEZnGLVdCDXJlpk0Uv0fudvyQlMJjCmGKI65JljD
	wqlyg+n1g0GFKf173Sjq/dm5mHN1ktZIDi4sEBjrUjXpQX9nKB2/I4VNYY42wnAC
	LUM1UcbfNov8CcJ2lmKyX4X+nqcfA1wfa3Jj5VXQtgv87IvGemnv8RneyDFHoIjY
	vj5hA55cIT1A9DZQVCma7yMDwGTuj56eaUH+4lOARaPH92/NN9KfRrm/uHtWXuwf
	gaJz6Nnf6WZgAfkVOMfo4nAnvJIuV3NvMgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775441617; x=
	1775528017; bh=zyqwGFgBkWIgtTbtvXudqG7fY5HrHKc/eVyukCB5c7U=; b=j
	TD251Yf9GRlqVDKFeB2m1HNT0mYAz7zN283cHoopfOKmIP4Z5gHuAJLC8yrcoWuR
	PTQvaMpmaiJn6fjV7SsuCebKcJ29+yWRMWWCEubcRwjNRwZ5N40xehlTUmQyxOeP
	C07jmbjnCCF++nmKbVJaT5s+kOSIYWi4MvYl7lqXdAuLbRCdzWSJDZEM2bvyyqoz
	/uJLbGPUaS34OSRUCNUTsBAtpxDhgvwpFyIWZj1s0G7I+PZT5gMeIDpTYIDrD0pN
	g2JhDqYUMW+fvm+Bv7GJ3z2Bddi5VWB50iWbfFuqhfoldpftwnDMteVNFfvpu1EC
	LwqefcAosFT9jYk4omTnw==
X-ME-Sender: <xms:0RbTaQQ9iNuSyGQaLz-W6yfgMiTZjST8ChuxgvL4lAnyb_6rQDpFlg>
    <xme:0RbTaWvsf5sR9GcHyDlB8EYWQ4E0zBEkEoe1EqpcNkACaCKOpqkpnvubjTU0ehzrN
    _B7nHiBk5p_5VGv-r0vybJDFDFLIvxIrQumy_7kAThvAvc1fA>
X-ME-Received: <xmr:0RbTaZYTvTbvDCGaRSSf_kFYfzJ-KScI34Y91J8OKMeM1NmtvYKd8NZmvdaSuJMcKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduieeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegsrhgruhhnvghrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:0RbTaUFc00cE-1V_7blTLLGpuOB7gAjTeA9PFIGQlzPg_YEM8PChyA>
    <xmx:0RbTaVwIkCw88nZj1v2qFzjpn3SKTdrsu6S5FlwAYZKmCCChUB3l2A>
    <xmx:0RbTaemmk8GBY4z6K5n1B1izBg7NzcbtCxI919J5nduQBXnpkadOtA>
    <xmx:0RbTaWk2FWc4QMciMW3Rza9CK0UNG6uHIxZneGl-Rk_BtfxbqvvbhQ>
    <xmx:0RbTaabGcngmpDMe2Uam4WKBodfjSl2QIQSsKbThdeaADlthNDrvCdaR>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Apr 2026 22:13:35 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject:
 [PATCH v2 4/4] VFS: use wait_var_event for waiting in d_alloc_parallel()
In-reply-to: <177485404586.1851489.2979661987621854672@noble.neil.brown.name>
References: <20260329225603.2177730-1-neilb@ownmail.net>  <>,
 <20260329225603.2177730-5-neilb@ownmail.net>, <>,
 <acoV3YBaJjl0Bh2X@infradead.org>,
 <177485404586.1851489.2979661987621854672@noble.neil.brown.name>
Date: Mon, 06 Apr 2026 12:13:33 +1000
Message-id: <177544161355.1474915.17180151531872069334@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


From: NeilBrown <neil@brown.name>

d_alloc_parallel() currently requires a wait_queue_head to be passed in.
This must have a life time which extends until the lookup is completed.

This makes it awkward to use and particularly make it hard to use in
lookup_one_qstr_excl() which I hope to do in the future.

This patch changes d_alloc_parallel() to use wake_up_var_locked() to
wake up waiters, and wait_var_event_spinlock() to wait.  dentry->d_lock
is used for synchronisation as it is already held and the relevant
times.

In most cases there will be no waiters so the wake_up_var_locked()
call is a complete waste.  To optimise this a new ->d_flags flag is
added: DCACHE_LOCK_WAITERS.  This is set whenever any thread prepares to
wait for the dentry, and if it isn't set when DCACHE_PAR_LOOKUP is
cleared, no wakeup is sent.
(The name is deliberately generic as I plan to replace DCACHE_PAR_LOOKUP
with more generic per-dentry locking in the future).

__d_lookup_unhash() now returns a bool rather than a wq.  This is true
if DCACHE_LOCK_WAITERS was sent and is used to decide to send the wake
up.  It would be easier to send the wakeup immediately when clearing
DCACHE_LOCK_WAITERS, but then the waiter could wake a bit earlier and
then spend time spinning on ->d_lock.  I don't know if that cost is
interesting.

__d_lookup_unhash() no longer needs to re-init ->d_lru.  That was
previously shared (in a union) with ->d_wait but ->d_wait is now gone
so it no longer corrupts ->d_lru.

Signed-off-by: NeilBrown <neil@brown.name>
---

This alternate 4/4 implements Christoph's suggestion of using
wait_var_event etc.
I can resend all 4 as a new set if that would be useful.

Thanks,
NeilBrown

 Documentation/filesystems/porting.rst |  6 +++
 fs/afs/dir_silly.c                    |  4 +-
 fs/dcache.c                           | 64 ++++++++++++---------------
 fs/fuse/readdir.c                     |  3 +-
 fs/namei.c                            |  6 +--
 fs/nfs/dir.c                          |  6 +--
 fs/nfs/unlink.c                       |  3 +-
 fs/proc/base.c                        |  3 +-
 fs/proc/proc_sysctl.c                 |  3 +-
 fs/smb/client/readdir.c               |  3 +-
 include/linux/dcache.h                | 11 +++--
 include/linux/nfs_xdr.h               |  1 -
 12 files changed, 50 insertions(+), 63 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystem=
s/porting.rst
index 560b473e02d0..565d695d3a76 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1375,3 +1375,9 @@ similar.
 lock_rename(), lock_rename_child(), unlock_rename() are no
 longer available.  Use start_renaming() or similar.
=20
+---
+
+**mandatory**
+
+d_alloc_parallel() no longer requires a waitqueue_head.
+
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index a748fd133faf..982bb6ec15f0 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -248,13 +248,11 @@ int afs_silly_iput(struct dentry *dentry, struct inode =
*inode)
 	struct dentry *alias;
 	int ret;
=20
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-
 	_enter("%p{%pd},%llx", dentry, dentry, vnode->fid.vnode);
=20
 	down_read(&dvnode->rmdir_lock);
=20
-	alias =3D d_alloc_parallel(dentry->d_parent, &dentry->d_name, &wq);
+	alias =3D d_alloc_parallel(dentry->d_parent, &dentry->d_name);
 	if (IS_ERR(alias)) {
 		up_read(&dvnode->rmdir_lock);
 		return 0;
diff --git a/fs/dcache.c b/fs/dcache.c
index 3bd4e15320af..e28a1876831b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2201,8 +2201,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct i=
node *inode,
 		return found;
 	}
 	if (d_in_lookup(dentry)) {
-		found =3D d_alloc_parallel(dentry->d_parent, name,
-					dentry->d_wait);
+		found =3D d_alloc_parallel(dentry->d_parent, name);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
 			iput(inode);
 			return found;
@@ -2212,7 +2211,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct i=
node *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		}=20
+		}
 	}
 	res =3D d_splice_alias(inode, found);
 	if (res) {
@@ -2590,31 +2589,24 @@ static inline unsigned start_dir_add(struct inode *di=
r)
 }
=20
 static inline void end_dir_add(struct inode *dir, unsigned int n,
-			       wait_queue_head_t *d_wait)
+			       bool do_wake, struct dentry *de)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
 	preempt_enable_nested();
-	if (wq_has_sleeper(d_wait))
-		wake_up_all(d_wait);
+	if (do_wake)
+		wake_up_var_locked(&de->d_flags, &de->d_lock);
 }
=20
-static void d_wait_lookup(struct dentry *dentry)
+static inline bool d_must_wait(struct dentry *dentry)
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
-	}
+	if (!d_in_lookup(dentry))
+		return false;
+	dentry->d_flags |=3D DCACHE_LOCK_WAITER;
+	return true;
 }
=20
 struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name,
-				wait_queue_head_t *wq)
+				const struct qstr *name)
 {
 	unsigned int hash =3D name->hash;
 	struct hlist_bl_head *b =3D in_lookup_hash(parent, hash);
@@ -2696,7 +2688,9 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		 * wait for them to finish
 		 */
 		spin_lock(&dentry->d_lock);
-		d_wait_lookup(dentry);
+		wait_var_event_spinlock(&dentry->d_flags,
+					!d_must_wait(dentry),
+					&dentry->d_lock);
 		/*
 		 * it's not in-lookup anymore; in principle we should repeat
 		 * everything from dcache lookup, but it's likely to be what
@@ -2717,7 +2711,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return dentry;
 	}
 	rcu_read_unlock();
-	new->d_wait =3D wq;
 	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
@@ -2733,29 +2726,29 @@ EXPORT_SYMBOL(d_alloc_parallel);
  * - Retrieve and clear the waitqueue head in dentry
  * - Return the waitqueue head
  */
-static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
+static bool __d_lookup_unhash(struct dentry *dentry)
 {
-	wait_queue_head_t *d_wait;
 	struct hlist_bl_head *b;
+	bool do_wake;
=20
 	lockdep_assert_held(&dentry->d_lock);
=20
 	b =3D in_lookup_hash(dentry->d_parent, dentry->d_name.hash);
 	hlist_bl_lock(b);
-	dentry->d_flags &=3D ~DCACHE_PAR_LOOKUP;
 	__hlist_bl_del(&dentry->d_u.d_in_lookup_hash);
-	d_wait =3D dentry->d_wait;
-	dentry->d_wait =3D NULL;
+	do_wake =3D !!(dentry->d_flags & DCACHE_LOCK_WAITER);
+	dentry->d_flags &=3D ~(DCACHE_PAR_LOOKUP|DCACHE_LOCK_WAITER);
+
 	hlist_bl_unlock(b);
 	INIT_HLIST_NODE(&dentry->d_u.d_alias);
-	INIT_LIST_HEAD(&dentry->d_lru);
-	return d_wait;
+	return do_wake;
 }
=20
 void __d_lookup_unhash_wake(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
-	wake_up_all(__d_lookup_unhash(dentry));
+	if (__d_lookup_unhash(dentry))
+		wake_up_var_locked(&dentry->d_flags, &dentry->d_lock);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(__d_lookup_unhash_wake);
@@ -2765,14 +2758,15 @@ EXPORT_SYMBOL(__d_lookup_unhash_wake);
 static inline void __d_add(struct dentry *dentry, struct inode *inode,
 			   const struct dentry_operations *ops)
 {
-	wait_queue_head_t *d_wait;
+	bool do_wake =3D false;
 	struct inode *dir =3D NULL;
 	unsigned n;
+
 	spin_lock(&dentry->d_lock);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir =3D dentry->d_parent->d_inode;
 		n =3D start_dir_add(dir);
-		d_wait =3D __d_lookup_unhash(dentry);
+		do_wake =3D __d_lookup_unhash(dentry);
 		__d_rehash(dentry);
 	} else if (d_unhashed(dentry)) {
 		__d_rehash(dentry);
@@ -2782,7 +2776,7 @@ static inline void __d_add(struct dentry *dentry, struc=
t inode *inode,
 	if (inode)
 		__d_instantiate(dentry, inode);
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, do_wake, dentry);
 	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
@@ -2895,7 +2889,7 @@ static void __d_move(struct dentry *dentry, struct dent=
ry *target,
 		     bool exchange)
 {
 	struct dentry *old_parent, *p;
-	wait_queue_head_t *d_wait;
+	bool do_wake =3D false;
 	struct inode *dir =3D NULL;
 	unsigned n;
=20
@@ -2926,7 +2920,7 @@ static void __d_move(struct dentry *dentry, struct dent=
ry *target,
 	if (unlikely(d_in_lookup(target))) {
 		dir =3D target->d_parent->d_inode;
 		n =3D start_dir_add(dir);
-		d_wait =3D __d_lookup_unhash(target);
+		do_wake =3D __d_lookup_unhash(target);
 	}
=20
 	write_seqcount_begin(&dentry->d_seq);
@@ -2966,7 +2960,7 @@ static void __d_move(struct dentry *dentry, struct dent=
ry *target,
 	write_seqcount_end(&dentry->d_seq);
=20
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, do_wake, target);
=20
 	if (dentry->d_parent !=3D old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..f588252891af 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -160,7 +160,6 @@ static int fuse_direntplus_link(struct file *file,
 	struct inode *dir =3D d_inode(parent);
 	struct fuse_conn *fc;
 	struct inode *inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	int epoch;
=20
 	if (!o->nodeid) {
@@ -197,7 +196,7 @@ static int fuse_direntplus_link(struct file *file,
 	dentry =3D d_lookup(parent, &name);
 	if (!dentry) {
 retry:
-		dentry =3D d_alloc_parallel(parent, &name, &wq);
+		dentry =3D d_alloc_parallel(parent, &name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 	}
diff --git a/fs/namei.c b/fs/namei.c
index 6ffb8367b1cf..d31c3db7eb5e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1891,13 +1891,12 @@ static struct dentry *__lookup_slow(const struct qstr=
 *name,
 {
 	struct dentry *dentry, *old;
 	struct inode *inode =3D dir->d_inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
=20
 	/* Don't go there if it's already dead */
 	if (unlikely(IS_DEADDIR(inode)))
 		return ERR_PTR(-ENOENT);
 again:
-	dentry =3D d_alloc_parallel(dir, name, &wq);
+	dentry =3D d_alloc_parallel(dir, name);
 	if (IS_ERR(dentry))
 		return dentry;
 	if (unlikely(!d_in_lookup(dentry))) {
@@ -4408,7 +4407,6 @@ static struct dentry *lookup_open(struct nameidata *nd,=
 struct file *file,
 	struct dentry *dentry;
 	int error, create_error =3D 0;
 	umode_t mode =3D op->mode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
=20
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -4417,7 +4415,7 @@ static struct dentry *lookup_open(struct nameidata *nd,=
 struct file *file,
 	dentry =3D d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
-			dentry =3D d_alloc_parallel(dir, &nd->last, &wq);
+			dentry =3D d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
 				return dentry;
 		}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2402f57c8e7d..52e7656195ec 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -727,7 +727,6 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_e=
ntry *entry,
 		unsigned long dir_verifier)
 {
 	struct qstr filename =3D QSTR_INIT(entry->name, entry->len);
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct dentry *dentry;
 	struct dentry *alias;
 	struct inode *inode;
@@ -756,7 +755,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_e=
ntry *entry,
 	dentry =3D d_lookup(parent, &filename);
 again:
 	if (!dentry) {
-		dentry =3D d_alloc_parallel(parent, &filename, &wq);
+		dentry =3D d_alloc_parallel(parent, &filename);
 		if (IS_ERR(dentry))
 			return;
 	}
@@ -2107,7 +2106,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *d=
entry,
 		    struct file *file, unsigned open_flags,
 		    umode_t mode)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct nfs_open_context *ctx;
 	struct dentry *res;
 	struct iattr attr =3D { .ia_valid =3D ATTR_OPEN };
@@ -2163,7 +2161,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *d=
entry,
 		d_drop(dentry);
 		switched =3D true;
 		dentry =3D d_alloc_parallel(dentry->d_parent,
-					  &dentry->d_name, &wq);
+					  &dentry->d_name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 		if (unlikely(!d_in_lookup(dentry)))
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index df3ca4669df6..43ea897943c0 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -124,7 +124,7 @@ static int nfs_call_unlink(struct dentry *dentry, struct =
inode *inode, struct nf
 	struct dentry *alias;
=20
 	down_read_non_owner(&NFS_I(dir)->rmdir_sem);
-	alias =3D d_alloc_parallel(dentry->d_parent, &data->args.name, &data->wq);
+	alias =3D d_alloc_parallel(dentry->d_parent, &data->args.name);
 	if (IS_ERR(alias)) {
 		up_read_non_owner(&NFS_I(dir)->rmdir_sem);
 		return 0;
@@ -185,7 +185,6 @@ nfs_async_unlink(struct dentry *dentry, const struct qstr=
 *name)
=20
 	data->cred =3D get_current_cred();
 	data->res.dir_attr =3D &data->dir_attr;
-	init_waitqueue_head(&data->wq);
=20
 	status =3D -EBUSY;
 	spin_lock(&dentry->d_lock);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4eec684baca9..070c0d58b2da 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2129,8 +2129,7 @@ bool proc_fill_cache(struct file *file, struct dir_cont=
ext *ctx,
=20
 	child =3D try_lookup_noperm(&qname, dir);
 	if (!child) {
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-		child =3D d_alloc_parallel(dir, &qname, &wq);
+		child =3D d_alloc_parallel(dir, &qname);
 		if (IS_ERR(child))
 			goto end_instantiate;
 		if (d_in_lookup(child)) {
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 49ab74e0bfde..04a382178c65 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -692,8 +692,7 @@ static bool proc_sys_fill_cache(struct file *file,
=20
 	child =3D d_lookup(dir, &qname);
 	if (!child) {
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-		child =3D d_alloc_parallel(dir, &qname, &wq);
+		child =3D d_alloc_parallel(dir, &qname);
 		if (IS_ERR(child))
 			return false;
 		if (d_in_lookup(child)) {
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 8615a8747b7f..47f5d620b750 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -73,7 +73,6 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 	struct cifs_sb_info *cifs_sb =3D CIFS_SB(sb);
 	bool posix =3D cifs_sb_master_tcon(cifs_sb)->posix_extensions;
 	bool reparse_need_reval =3D false;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	int rc;
=20
 	cifs_dbg(FYI, "%s: for %s\n", __func__, name->name);
@@ -105,7 +104,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *nam=
e,
 		    (fattr->cf_flags & CIFS_FATTR_NEED_REVAL))
 			return;
=20
-		dentry =3D d_alloc_parallel(parent, name, &wq);
+		dentry =3D d_alloc_parallel(parent, name);
 	}
 	if (IS_ERR(dentry))
 		return;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 898c60d21c92..d07afa524043 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -115,10 +115,7 @@ struct dentry {
 					 * possible!
 					 */
=20
-	union {
-		struct list_head d_lru;		/* LRU list */
-		wait_queue_head_t *d_wait;	/* in-lookup ones only */
-	};
+	struct list_head d_lru;		/* LRU list */
 	struct hlist_node d_sib;	/* child of parent list */
 	struct hlist_head d_children;	/* our children */
 	/*
@@ -198,6 +195,9 @@ enum dentry_flags {
 	DCACHE_REFERENCED		=3D BIT(6),	/* Recently used, don't discard. */
 	DCACHE_DONTCACHE		=3D BIT(7),	/* Purge from memory on final dput() */
 	DCACHE_CANT_MOUNT		=3D BIT(8),
+	DCACHE_LOCK_WAITER		=3D BIT(9),	/* A thread is waiting for
+							 * PAR_LOOKUP to clear
+							 */
 	DCACHE_SHRINK_LIST		=3D BIT(10),
 	DCACHE_OP_WEAK_REVALIDATE	=3D BIT(11),
 	/*
@@ -244,8 +244,7 @@ extern void d_delete(struct dentry *);
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
-extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
-					wait_queue_head_t *);
+extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *=
);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index ff1f12aa73d2..1acc2479cb38 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1740,7 +1740,6 @@ struct nfs_unlinkdata {
 	struct nfs_removeargs args;
 	struct nfs_removeres res;
 	struct dentry *dentry;
-	wait_queue_head_t wq;
 	const struct cred *cred;
 	struct nfs_fattr dir_attr;
 	long timeout;
--=20
2.50.0.107.gf914562f5916.dirty

