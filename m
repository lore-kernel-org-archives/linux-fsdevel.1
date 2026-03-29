Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B238759A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848549; cv=none; b=lLnBY6ShpUw5Dx5nzYT0Woh+ynOfDGhbAC7dodMpT31VJaaCDsus4Wuk1YjjtE5UZrC1nkzcxELk3h1sbrgEvut+pponUQOVM9sWBU2vpIV5WICIihh3LDz6zOC33R5LqFAwLqP4nqqFzMJ/Q1tOcpXhg89I+fC/J/SrTIYM2Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848549; c=relaxed/simple;
	bh=jS1HFtJbJrA30tp8VeRsYP74tHQtVumThjO3qWiYE2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEpAy1SWr4YI2e5CJEjdQM1A1GJW4USY52VTLRJOZzrOf2kSgjWLkG2XfteFW4yxYD6sx6LT/VpiGRwDRudLpEvFXNjuvxL6EvLHzeWBDvIrAY5reuRW4nY9Dc98+FIlcdIjRyxl7cWKm1Y6R0NfEEfXlmdEvhXFYwMJHs8YTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=m/2KVbqK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x150tJTN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="m/2KVbqK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x150tJTN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E46E1D0024F;
	Mon, 30 Mar 2026 01:29:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 30 Mar 2026 01:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1774848547;
	 x=1774934947; bh=Ty1jQAccVhA93uFonrylXcgoqCLxd1UtFcakunW35HM=; b=
	m/2KVbqK/2LI7nUNSmFP6fwo3mVME7JB1OGJDSAIDQgzCFSx/GD3Pu+DlTfSiqhL
	nk4KRrMRlhgSvA8atJ5cZoFIRZuV4vgHpHiK2AeLwZ6s+VYPbnPzEgLZbFAW4yRK
	pT7qN9awngT7kDsPIPKrQlEFisxI+NAPPF8NcEKt2mb4ftrNBzXI5q592YMYA9ld
	vxKEcJcTIE4MsRHMkyCcAC57r6p9rKcWJ9GCEUHyKDRbMTrEyQNHEwaXJkgo86DJ
	ZcqTBMn8yZPw19YTFlsxb4iBPgJijjXHHueu2MOI9Dmoj3Py+qX3FgC0CKkhd2+y
	oCuxBKbZ48DBs24kwbo1Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1774848547; x=1774934947; bh=T
	y1jQAccVhA93uFonrylXcgoqCLxd1UtFcakunW35HM=; b=x150tJTNZw3PvcX+k
	7KWunhFQdYIckc5A58N0NWfjYZuzicHbtQyWb2QlVbN4Avavd2resoiv4eoo4eAy
	QBgrf4C1u/d4aZcJtajGPYaZVh4EFlgNJdR1xn1Y0pSQJ3YpeF/dPaIuZCukhkWZ
	527CPbVAgdbxZUFlg0YKysvHNVg6ug/DtxsL+55JzbaZJ7haGKK0k5BwENhmy8dY
	K6GtOqvGb9WV8Gd6XnfWxP/8nrWEQnb/e4JbZPK8H7n64tLv1I1iakP1QeSjoNSi
	TnQOKN3hHILRKIGay6TsLU/RCFmEHaC/KkHk0z/vTb64wP4N+MA127vuV/9GAKxb
	hyhAw==
X-ME-Sender: <xms:IgrKacG7JUxnhOvzUO-Hq5sHwa5wB0CGRfJ5cFcsHY04c1mbsQqMwA>
    <xme:IgrKaQylQhUaPw8V5SOXaBD61asQZJbd92e-cCayehy1guD37PjkUDBZETVZiTiGj
    tcRaanabXqFkwK9918nfeoPBfaFhDWrvPxf6cbeX65kC3lJv8c>
X-ME-Received: <xmr:IgrKaZohpARaI5ut2ZQ-j9BvlVunNbeyWIVDhYA1MuO6MFLAVDpnRLiGaFvGo-ltmptHzLAKSgIZL4bMytOSPbgfMqSseXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IwrKaSiRNxHr_vAw63NncHTkHvko_FLCOIa_tiEU-OptLsxDEHH7Tg>
    <xmx:IwrKaehQBWWJF36biOD8finglI8nU7DaOIJ6GJnixi8eugzHNPY5KQ>
    <xmx:IwrKaQgNdRWqDD8KHdf-JzMuRPvZMVJLmxGJjloBZ0YP8taablhZcg>
    <xmx:IwrKaWJ5AXXGKOQlcovIGU0iYi77FoW4QxucUlQgySUy0-9qDvmOiQ>
    <xmx:IwrKaa0I-zc6fh-kWzje6fe5mOg_JLSP1mpkDluycwRiBj5xyVOJxuS2>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 01:29:05 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] VFS: use global wait-queue table for d_alloc_parallel()
Date: Mon, 30 Mar 2026 09:46:39 +1100
Message-ID: <20260329225603.2177730-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260329225603.2177730-1-neilb@ownmail.net>
References: <20260329225603.2177730-1-neilb@ownmail.net>
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

Future patches will make more use of d_alloc_parallel() and use it in
contexts where having an on-stack wait_queue_head is not convenient.
For exaple lookup_one_qstr_excl() can only use d_alloc_parallel() if it
accepts a wait_queue_head pass in by the caller.

The interface would be easier to use if this need were removed.  Rather
than passing a wait_queue_head into lookup_one_qstr_excl() we can let
d_alloc_parallel() manage the wait_queue_head entirely itself.

This patch replaces the on-stack wqs with a global array of wqs which
are used as needed.  A wq is NOT assigned when a dentry is first
created but only when a second thread attempts to use the same name and
so is forced to wait.  At this moment a wq is chosen using a hash of the
dentry pointer and that wq is assigned to ->d_wait.  The ->d_lock is
then dropped and the task waits.

When the dentry is finally moved out of "in_lookup" a wake up is only
sent if ->d_wait is not NULL.  This is more direct than checking if the
wait queue is active and avoids a memory barrier in a common case.

The wake up passes the dentry that the wake up is for as the "key" and
the waiter will only wake processes waiting on the same key.  This means
that when these global waitqueues are shared (which is inevitable
though unlikely to be frequent), a task will not be woken prematurely.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  6 +++
 fs/afs/dir_silly.c                    |  4 +-
 fs/dcache.c                           | 78 ++++++++++++++++++++++-----
 fs/fuse/readdir.c                     |  3 +-
 fs/namei.c                            |  6 +--
 fs/nfs/dir.c                          |  6 +--
 fs/nfs/unlink.c                       |  3 +-
 fs/proc/base.c                        |  3 +-
 fs/proc/proc_sysctl.c                 |  3 +-
 fs/smb/client/readdir.c               |  3 +-
 include/linux/dcache.h                |  3 +-
 include/linux/nfs_xdr.h               |  1 -
 12 files changed, 81 insertions(+), 38 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 560b473e02d0..6a507c508ccf 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1375,3 +1375,9 @@ similar.
 lock_rename(), lock_rename_child(), unlock_rename() are no
 longer available.  Use start_renaming() or similar.
 
+---
+
+**mandatory**
+
+d_alloc_parallel() no longer requires a waitqueue_head.  It uses one
+from an internal table when needed.
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
index 3bd4e15320af..ef0d3172bc77 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2201,8 +2201,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		return found;
 	}
 	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name,
-					dentry->d_wait);
+		found = d_alloc_parallel(dentry->d_parent, name);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
 			iput(inode);
 			return found;
@@ -2212,7 +2211,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		} 
+		}
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
@@ -2578,6 +2577,46 @@ void d_rehash(struct dentry * entry)
 }
 EXPORT_SYMBOL(d_rehash);
 
+#define PAR_LOOKUP_WQ_BITS	8
+#define PAR_LOOKUP_WQS (1 << PAR_LOOKUP_WQ_BITS)
+static wait_queue_head_t par_wait_table[PAR_LOOKUP_WQS] __cacheline_aligned;
+
+static int __init par_wait_init(void)
+{
+	int i;
+
+	for (i = 0; i < PAR_LOOKUP_WQS; i++)
+		init_waitqueue_head(&par_wait_table[i]);
+	return 0;
+}
+fs_initcall(par_wait_init);
+
+struct par_wait_key {
+	struct dentry *de;
+	struct wait_queue_entry wqe;
+};
+
+static int d_wait_wake_fn(struct wait_queue_entry *wq_entry,
+			  unsigned mode, int sync, void *key)
+{
+	struct par_wait_key *pwk = container_of(wq_entry,
+						 struct par_wait_key, wqe);
+	if (pwk->de == key)
+		return default_wake_function(wq_entry, mode, sync, key);
+	return 0;
+}
+
+static inline void d_wake_waiters(struct wait_queue_head *d_wait,
+				  struct dentry *dentry)
+{
+	/* ->d_wait is only set if some thread is actually waiting.
+	 * If we find it is NULL - the common case - then there was no
+	 * contention and there are no waiters to be woken.
+	 */
+	if (d_wait)
+		__wake_up(d_wait, TASK_NORMAL, 0, dentry);
+}
+
 static inline unsigned start_dir_add(struct inode *dir)
 {
 	preempt_disable_nested();
@@ -2590,31 +2629,42 @@ static inline unsigned start_dir_add(struct inode *dir)
 }
 
 static inline void end_dir_add(struct inode *dir, unsigned int n,
-			       wait_queue_head_t *d_wait)
+			       wait_queue_head_t *d_wait, struct dentry *de)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
 	preempt_enable_nested();
-	if (wq_has_sleeper(d_wait))
-		wake_up_all(d_wait);
+	d_wake_waiters(d_wait, de);
 }
 
 static void d_wait_lookup(struct dentry *dentry)
 {
 	if (d_in_lookup(dentry)) {
-		DECLARE_WAITQUEUE(wait, current);
-		add_wait_queue(dentry->d_wait, &wait);
+		struct par_wait_key wk = {
+			.de = dentry,
+			.wqe = {
+				.private = current,
+				.func = d_wait_wake_fn,
+			},
+		};
+		struct wait_queue_head *wq;
+
+		if (!dentry->d_wait)
+			dentry->d_wait = &par_wait_table[hash_ptr(dentry,
+								  PAR_LOOKUP_WQ_BITS)];
+		wq = dentry->d_wait;
+		add_wait_queue(wq, &wk.wqe);
 		do {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			spin_unlock(&dentry->d_lock);
 			schedule();
 			spin_lock(&dentry->d_lock);
 		} while (d_in_lookup(dentry));
+		remove_wait_queue(wq, &wk.wqe);
 	}
 }
 
 struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name,
-				wait_queue_head_t *wq)
+				const struct qstr *name)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2627,6 +2677,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return ERR_PTR(-ENOMEM);
 
 	new->d_flags |= DCACHE_PAR_LOOKUP;
+	new->d_wait = NULL;
 	spin_lock(&parent->d_lock);
 	new->d_parent = dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
@@ -2717,7 +2768,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return dentry;
 	}
 	rcu_read_unlock();
-	new->d_wait = wq;
 	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
@@ -2755,7 +2805,7 @@ static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 void __d_lookup_unhash_wake(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
-	wake_up_all(__d_lookup_unhash(dentry));
+	d_wake_waiters(__d_lookup_unhash(dentry), dentry);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(__d_lookup_unhash_wake);
@@ -2782,7 +2832,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 	if (inode)
 		__d_instantiate(dentry, inode);
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, d_wait, dentry);
 	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
@@ -2966,7 +3016,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	write_seqcount_end(&dentry->d_seq);
 
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, d_wait, target);
 
 	if (dentry->d_parent != old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..f588252891af 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -160,7 +160,6 @@ static int fuse_direntplus_link(struct file *file,
 	struct inode *dir = d_inode(parent);
 	struct fuse_conn *fc;
 	struct inode *inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	int epoch;
 
 	if (!o->nodeid) {
@@ -197,7 +196,7 @@ static int fuse_direntplus_link(struct file *file,
 	dentry = d_lookup(parent, &name);
 	if (!dentry) {
 retry:
-		dentry = d_alloc_parallel(parent, &name, &wq);
+		dentry = d_alloc_parallel(parent, &name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 	}
diff --git a/fs/namei.c b/fs/namei.c
index 6ffb8367b1cf..d31c3db7eb5e 100644
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
@@ -4408,7 +4407,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -4417,7 +4415,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
-			dentry = d_alloc_parallel(dir, &nd->last, &wq);
+			dentry = d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
 				return dentry;
 		}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2402f57c8e7d..52e7656195ec 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -727,7 +727,6 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		unsigned long dir_verifier)
 {
 	struct qstr filename = QSTR_INIT(entry->name, entry->len);
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct dentry *dentry;
 	struct dentry *alias;
 	struct inode *inode;
@@ -756,7 +755,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 	dentry = d_lookup(parent, &filename);
 again:
 	if (!dentry) {
-		dentry = d_alloc_parallel(parent, &filename, &wq);
+		dentry = d_alloc_parallel(parent, &filename);
 		if (IS_ERR(dentry))
 			return;
 	}
@@ -2107,7 +2106,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		    struct file *file, unsigned open_flags,
 		    umode_t mode)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct nfs_open_context *ctx;
 	struct dentry *res;
 	struct iattr attr = { .ia_valid = ATTR_OPEN };
@@ -2163,7 +2161,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
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
index 4eec684baca9..070c0d58b2da 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2129,8 +2129,7 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 
 	child = try_lookup_noperm(&qname, dir);
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
index 8615a8747b7f..47f5d620b750 100644
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
index 898c60d21c92..c6440c626a0f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -244,8 +244,7 @@ extern void d_delete(struct dentry *);
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
-- 
2.50.0.107.gf914562f5916.dirty

