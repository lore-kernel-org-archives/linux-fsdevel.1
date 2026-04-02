Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF235CB6E
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153121; cv=none; b=sV5Y0oF8Q7Zm39l6tCVchg7tFk1i3aB8EZqjV3Sgty5kbvMs6/CLlbhE+VneNFGDgF24XeVysMsMj0jZ19m+gQk0culRgyvSKQaNEOyh3Lcsj5O+0ZvfzO+QDdPyrdkXy4XTaFa+bw7l5TP5ImcJ00StJYIiR6U0ontnAyFogJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153121; c=relaxed/simple;
	bh=93Ql44OFxdZ2pQxYH042uiOVEEXNxVRfKjWAzVR2xn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbpWiB+FNWtJYvPUYodUqYkcdQc1+RschCQbgp4lnAU9x0dbaAboEBSs0nArFzNgQJ9pRgCOXnoEm2OqeycqxgPN8198JnDAbjUmlnYxLwmxCmgAOBbGx1ulfeWbt9G/wilJPYSS8Lt4RFHYOMnlrzn8d2FZ+3vi5O5gn800bFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bXSPhnX3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bXSPhnX3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Y0i1aFClDuDWd3IV+j4nUsXqvpWCZH0jbno8MJIJ6S4=; b=bXSPhnX3Gv2Ah7m51o4D4bRk+D
	W/K3Lxo63v1BaebQbXW3CBh9Rxos+iBLYjQV22NA/QVd6TEiPHJiMjovci8g28/5fsCjmQ5yKF8Vu
	+y3J9TVOXs8eUkN7b2bg0qCTNHxv/rrQsamuGZ6cE1ZYWj3h/+jQFFrvP5cEKYzeQgLMh4QLrZcQt
	sgGAD62OWbe6tVs7EKeUUHdHSrIhukzDQMJrGVu0DWOukYb+x071dBNvKFuyrHOJmJKhhoVIlOh5H
	Mpado7CRZ88naAiUPj/VU5N0X7LknEvVki1wO5eOVkDKh4dLAdawzlC93rbg9PnpKS+0H/R+rUag8
	XHHGW9Uw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8MTM-0000000FeJw-1iNx;
	Thu, 02 Apr 2026 18:08:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH v2 4/4] get rid of busy-waiting in shrink_dcache_tree()
Date: Thu,  2 Apr 2026 19:08:49 +0100
Message-ID: <20260402180850.3729310-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
References: <20260122202025.GG3183987@ZenIV>
 <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

If shrink_dcache_parent() runs into a potential victim that is already
dying, it must wait for that dentry to go away.  To avoid busy-waiting
we need some object to wait on and a way for dentry_unlist() to see that
we need to be notified.

The obvious place for the object to wait on would be inside struct
select_data we have on our stack frame.  We will store a pointer to
select_data in victim dentry; if there's more than one thread wanting to
wait for the same dentry to finish dying, we'll have their select_data
linked into a list, with reference in dentry pointing to the head of
that list.

* add struct completion and a pointer to the next select_data into
struct select_data; that will be what we wait on and the list linkage.

* add a new member (->waiters, opaque pointer to struct select_data)
to struct dentry.  It is defined for negative live dentries that are
not in-lookup ones and it will remain NULL for almost all of them.

It does not conflict with ->d_rcu (defined for killed dentries), ->d_alias
(defined for positive dentries, all live) or ->d_in_lookup_hash (defined
for in-lookup dentries, all live negative).  That allows to colocate
all four members.

* make sure that all places where dentry enters the state where ->waiters
is defined (live, negative, not-in-lookup) initialize ->waiters to NULL.

* if select_collect2() runs into a dentry that is already dying, have
its caller insert its select_data into the head of list that hangs off
dentry->waiters and wait for completion.

* if dentry_unlist() sees non-NULL ->waiters, have it carefully walk
through the select_data on that list, calling complete() for each.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 90 ++++++++++++++++++++++++++++++++++--------
 include/linux/dcache.h | 18 +++++++--
 2 files changed, 89 insertions(+), 19 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 616a445ec720..09a80f7f3d05 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -455,7 +455,9 @@ static void dentry_unlink_inode(struct dentry * dentry)
 
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_clear_type_and_inode(dentry);
-	hlist_del_init(&dentry->d_alias);
+	if (likely(!hlist_unhashed(&dentry->d_alias)))
+		__hlist_del(&dentry->d_alias);
+	dentry->waiters = NULL;
 	raw_write_seqcount_end(&dentry->d_seq);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&inode->i_lock);
@@ -605,6 +607,52 @@ void d_drop(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_drop);
 
+struct select_data {
+	struct dentry *start;
+	union {
+		long found;
+		struct {
+			struct dentry *victim;
+			struct select_data *next;
+			struct completion completion;
+		};
+	};
+	struct list_head dispose;
+};
+
+/*
+ *  shrink_dcache_parent() needs to be notified when dentry in process of
+ *  being evicted finally gets unlisted.  Such dentries are
+ *	already with negative ->d_count
+ *	already negative
+ *	already not in in-lookup hash
+ *	reachable only via ->d_sib.
+ *
+ *  Use ->waiters for a single-linked list of struct select_data of
+ *  waiters.
+ */
+static inline void d_add_waiter(struct dentry *dentry, struct select_data *p)
+{
+	struct select_data *v = dentry->waiters;
+	init_completion(&p->completion);
+	p->next = v;
+	dentry->waiters = p;
+}
+
+static inline void d_complete_waiters(struct dentry *dentry)
+{
+	struct select_data *v = dentry->waiters;
+	if (unlikely(v)) {
+		/* some shrink_dcache_tree() instances are waiting */
+		dentry->waiters = NULL;
+		while (v) {
+			struct completion *r = &v->completion;
+			v = v->next;
+			complete(r);
+		}
+	}
+}
+
 static inline void dentry_unlist(struct dentry *dentry)
 {
 	struct dentry *next;
@@ -613,6 +661,7 @@ static inline void dentry_unlist(struct dentry *dentry)
 	 * attached to the dentry tree
 	 */
 	dentry->d_flags |= DCACHE_DENTRY_KILLED;
+	d_complete_waiters(dentry);
 	if (unlikely(hlist_unhashed(&dentry->d_sib)))
 		return;
 	__hlist_del(&dentry->d_sib);
@@ -1509,15 +1558,6 @@ int d_set_mounted(struct dentry *dentry)
  * constraints.
  */
 
-struct select_data {
-	struct dentry *start;
-	union {
-		long found;
-		struct dentry *victim;
-	};
-	struct list_head dispose;
-};
-
 static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 {
 	struct select_data *data = _data;
@@ -1569,6 +1609,10 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 			return D_WALK_QUIT;
 		}
 		to_shrink_list(dentry, &data->dispose);
+	} else if (dentry->d_lockref.count < 0) {
+		rcu_read_lock();
+		data->victim = dentry;
+		return D_WALK_QUIT;
 	}
 	/*
 	 * We can return to the caller if we have found some (this
@@ -1608,12 +1652,26 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 		data.victim = NULL;
 		d_walk(parent, &data, select_collect2);
 		if (data.victim) {
-			spin_lock(&data.victim->d_lock);
-			if (!lock_for_kill(data.victim)) {
-				spin_unlock(&data.victim->d_lock);
+			struct dentry *v = data.victim;
+
+			spin_lock(&v->d_lock);
+			if (v->d_lockref.count < 0 &&
+			    !(v->d_flags & DCACHE_DENTRY_KILLED)) {
+				// It's busy dying; have it notify us once
+				// it becomes invisible to d_walk().
+				d_add_waiter(v, &data);
+				spin_unlock(&v->d_lock);
+				rcu_read_unlock();
+				if (!list_empty(&data.dispose))
+					shrink_dentry_list(&data.dispose);
+				wait_for_completion(&data.completion);
+				continue;
+			}
+			if (!lock_for_kill(v)) {
+				spin_unlock(&v->d_lock);
 				rcu_read_unlock();
 			} else {
-				shrink_kill(data.victim);
+				shrink_kill(v);
 			}
 		}
 		if (!list_empty(&data.dispose))
@@ -1787,7 +1845,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	INIT_HLIST_BL_NODE(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_HLIST_HEAD(&dentry->d_children);
-	INIT_HLIST_NODE(&dentry->d_alias);
+	dentry->waiters = NULL;
 	INIT_HLIST_NODE(&dentry->d_sib);
 
 	if (dentry->d_op && dentry->d_op->d_init) {
@@ -2729,7 +2787,7 @@ static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 	d_wait = dentry->d_wait;
 	dentry->d_wait = NULL;
 	hlist_bl_unlock(b);
-	INIT_HLIST_NODE(&dentry->d_alias);
+	dentry->waiters = NULL;
 	INIT_LIST_HEAD(&dentry->d_lru);
 	return d_wait;
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f939d2ed10a3..07dac37eb75c 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -88,6 +88,7 @@ union shortname_store {
 
 #define d_lock	d_lockref.lock
 #define d_iname d_shortname.string
+struct select_data;
 
 struct dentry {
 	/* RCU lookup touched fields */
@@ -122,12 +123,23 @@ struct dentry {
 	struct hlist_node d_sib;	/* child of parent list */
 	struct hlist_head d_children;	/* our children */
 	/*
-	 * d_alias and d_rcu can share memory
+	 * the following members can share memory - their uses are
+	 * mutually exclusive.
 	 */
 	union {
-		struct hlist_node d_alias;	/* inode alias list */
-		struct hlist_bl_node d_in_lookup_hash;	/* only for in-lookup ones */
+		/* positives: inode alias list */
+		struct hlist_node d_alias;
+		/* in-lookup ones (all negative, live): hash chain */
+		struct hlist_bl_node d_in_lookup_hash;
+		/* killed ones: (already negative) used to schedule freeing */
 	 	struct rcu_head d_rcu;
+		/*
+		 * live non-in-lookup negatives: used if shrink_dcache_parent()
+		 * races with eviction by another thread and needs to wait for
+		 * this dentry to get killed .  Remains NULL for almost all
+		 * negative dentries.
+		 */
+		struct select_data *waiters;
 	};
 };
 
-- 
2.47.3

