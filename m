Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057220;
	b=nUhh2oKhWFZW3+XWVLH9kq7/j1LtNkYBwO/KhGCaVZV2jfoW+ueFxA9k80z0PmxHIGE6
	 NUsCZMaKg3puWiBMWpmrs0WrUDJsfXc4F+nJm081/T2rwU68JntnYbi/wsQUVzXwkfkji
	 lK03TjxaKL/QYH+jA5mYr7fG5pFnCfF8mFlzdQm097XkRD9IsFL26dvoja+1tjvkvU2fW
	 pnVxJw1TVtsTN7Vm8Qih8hLbWDgkRAQHe0TrbsL0XHx1E33iRuHpbRsAjEumRCwf7DQXc
	 lPkg8ECqLAub82soJCX6Gwbkdo4rgzCGGjkkAWEWk1K3JvL5ola7jA5sf/7LmkbGHcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057220;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=8G4dJYJl0XpK9w0Qa1u7acISbMIHXsCjgII77kFE9vw=;
	b=2jp9Rwts5hJ5vHAPvYBiTKUL71jUAWCdWem5b/7EqWDF7LknyqBigscbgfBgo/XaaUxy
	 Ypn4IW6EAVQP8WCnqEaAZ1h+o2Dwx7hsfqkMhll92wNo+nw+/NnBxty0j9+wU0skB1duy
	 Hu/0EDCSEBN1e7tVpXpMHfNvSp1MBkosodaZ1e0nds4m5/9vLKRR/Spu1h2Dl8t0ONJ9z
	 z+DFlxXDiAxlYzWz+1BS9p2Mwl44E3Rn9MPgJqpsiKlPb5qEUdyPz34xdgnZsZB43+BZo
	 c62AKwVFjZXFHJkOaNfR3J9XCoPLGK+hug08rgoxBWMwVkzGF6nH1MHC+ydSNo5dr9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b="tA/enaF0";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3PtesWDh;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C1606A331
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 03:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E7C1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=tA/enaF0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3PtesWDh
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C9DD6140018A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 22:00:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 22:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795057218;
	 x=1795143618; bh=8G4dJYJl0XpK9w0Qa1u7acISbMIHXsCjgII77kFE9vw=; b=
	tA/enaF0sNmDc0neu5FLwSmny0nG2tPeVJk4MZJifayLIgBRgyRp5j7yM+gkk9R0
	en7UMRktzS5DTwLcCdOqSRM9cCSriv8Sm3G8ZSEHbhTSKeBVrf0dyQWaw6MtK+bv
	0T1wB/Fprhol+r66Q82jn2yx/EY70sFePk0WtOS5wOsFIkdtiZTWBPGbusODRWsZ
	KgfMakNQI7Hi2VN3aB7/WdI9ykVaZ7vFdRPK+Yuzc3ZLK69Adbkv01EP3QPQRHHI
	tHk/h0ZMPh0dV7PvnzLX9QLovZKPZm035bqh1CKiY1W8EIIWLJhUsvqSK6+Phzxm
	rKiOXQsJiK+NirxFpymkiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795057218; x=1795143618; bh=8
	G4dJYJl0XpK9w0Qa1u7acISbMIHXsCjgII77kFE9vw=; b=3PtesWDhLJcEmPGvj
	C5qEgLuTjmXvk5bcSe9shymHDyev1/py2pXcfEOL4lz9fALftIKDFdzTPyq7buq+
	jwOeuM39YGDMnPKNvIVCFnpELgrIcHxB6LgyDflIcMrfcCa1vDc+euUs7zh5xmkp
	221g0tk84H5vOlAUfe7rAuT5PACz4rj6Kue/i5y4Hk2V7P/6upxwUUjqA8ITZn3p
	i2bzaP//mzWE7C+dYuPqi6lWkwbHC1TrHsfZ1/Zm68Fm7hj1Op66N2C5dU6vD1sH
	NzH2GJbNwOLq7qnnPHi+/fPLz7mJyc76f430dJQCqzyVZfs9yQc1030o6dZTOZIi
	7pDEA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795057218; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:WQcDtO98MzyyaX91pNdOeZ0BogLVNswf1weakt//jSQEqZ7
	cb4QFGrOwwaXw7xwX1OnWfb9LU4CtoUs0tR0izrQYMSN1JhzitmdLKLYISxgACjh
	zl0yOOtqQ5C139XuJGQyX8X3YjjlzA5NZYhkzI9Gj4iN6vLSXDkgwPlI/M2adZf7
	V5JwAg6eYdISHJ6PDgDCPC7oL5aNe59Rt0qquYx14RizFeM/BtV1U/Q6uvl1GeJ2
	uEQIluz3n6FMHqvTCGCNimz32y57NvdJXceoq92AuTS2mtRYXwb3Du27WJG+ratq
	uQMhHdZC6ZwZo8ilpkAg+oRlbMR7T7n967kJDEw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:KIXZ1sNOEQTGwAOAnicCX8ZR3lDvL4cbIAWtsOzSnzg=:ym2mkUI3Wv9NQNk0PbR+36NXK8fke7L6JqYi+Xyt/Jw=;
X-ME-Sender: <xms:Qmb-akE2uou6S9eOfRBCXLi4D9qW5keMGg-Mj7YJuUDPbIr-BgJ21w>
    <xme:Qmb-av5fp18DqPCMPs9U5W-ZfYAMQZItYigp6F5gCybs_jpszXV_PuXzzaSGbpzRt
    ncsQPt1hep8fxG5pydgNz2u0BUFILlI54B_Cd0uX95iDxj2l0c>
X-ME-Received: <xmr:Qmb-ahzox2OZzA6pB1lXi4iJcTiiXEbRJrCE52DPiibxbVjSz9ilqPK2Y_DnvKlKjt5xOD_TRpe0uwuPeyNx5YOwv2uVE_4>
X-ME-Proxy-Cause: dmFkZTF5aNm3vmmontyyrT2O6rUztv8ppj0IeipASNV+CPcjRRA9YZoQDvTUrYLUlj3z+U
    d7nmqFT3cZ8iRlUAOQ7nwTQqZ8GU4/YJ5eLlR2pHJnzymEhfKraaOQL02uwwHm/YpeUTwa
    Je/H/f5H8Ga3rQMfDfkvAV/C/0CVEqypHYXea/xfgt8GPv1IajFXzA5ONcgGcJNZBshF0l
    tqbzCUDiR3KvVAsoXUb8O1nfFOPW0O6W9cjnkgQKL0KzUxEdSr5StwyWpsVrKRtDYVnSvM
    leOXff0VZ4f8+RJSrXHrJk8G8/9MgY/9OofkHwo3sJvC8O2UlTHNid9yGNwLYYlB31BbuF
    mQdZoD9MRGgMX4vtpcpsWS2vbdpzH5MnOI8dPSNjiCihRt2d7xZ4MLREIR9TFMfF/5rcEY
    TuCxq1Tnq46FDt1Jt8/06/QQsZnDpthM6+y5G1irwYOUx1THA5ZfJnayduWU+vTsUGJJHk
    n4EQmEjVGTA6OXD7fgsT6rUXOQfMyP6RK8Bkxe3s4y3OVDO5pGPyHWKJO9Hq7RgRBdfcHf
    s/yp8rwqrYSJ7V8bU3roxqfaBSLEoUuq1GXVaV5UBJCt43WQIwfRh4tfW5YK69shZxOfs8
    RgFNdFSuRCL0d4Mhko/EUEjLH/VA1y7A1sTBN4z25zGCtZB8qyFSwxErt+8g
X-ME-Proxy: <xmx:Qmb-amOxA2brb56IeIP4oCQr2-Rsg92QNbUVNOOZkA6IqAqEJ0LMUw>
    <xmx:Qmb-avmotaPfa4L2EpLwpREUfFuAA-rvPrR27cTAa3Y2Qow8ITFUVw>
    <xmx:Qmb-ajReVq_ooJQQXCA9DxDPUvg4-GIJJHsfwvIDoccuDThVwxkhNQ>
    <xmx:Qmb-amXQX_mmdXBWxtxgQYBazEZfSSwaGUfAKUNpBZKP9ewvctohTg>
    <xmx:Qmb-ai0e6nPSeLs1rtVjhsUpoT80QEVJMEazHIjyb5bRMYGo-nGXsxm1>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 22:00:16 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v5 4/5] Add d_for_each_positive_child family of iterators
Date: Thu, 19 Nov 2026 13:57:04 +1100
Message-ID: <20261119025942.2848130-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261119025942.2848130-1-neilb@ownmail.net>
References: <20261119025942.2848130-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
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
 fs/dcache.c            | 119 ++++++++++++++++++++++++++++++++++-------
 include/linux/dcache.h |  67 +++++++++++++++++++++++
 2 files changed, 166 insertions(+), 20 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0dc54ba31d8c..bacb218400a8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1950,6 +1950,27 @@ void d_invalidate(struct dentry *dentry)
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
+
+	lockdep_init_map(&dentry->dep_map, "DCACHE_PAR_LOOKUP",
+			 &sb->s_type->d_lookup_key, 0);
+}
+
 /**
  * __d_alloc - allocate a dcache entry
  * @sb: filesystem it will belong to
@@ -1959,7 +1980,6 @@ EXPORT_SYMBOL(d_invalidate);
  * available. On a success the dentry is returned. The name passed in is
  * copied and the copy passed in may be reused after this call.
  */
- 
 static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
 	struct dentry *dentry;
@@ -1991,14 +2011,14 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
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
@@ -2008,23 +2028,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
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
-
-	lockdep_init_map(&dentry->dep_map, "DCACHE_PAR_LOOKUP",
-			 &sb->s_type->d_lookup_key, 0);
+	__d_init(dentry, sb);
 
 	if (dentry->d_op && dentry->d_op->d_init) {
 		err = dentry->d_op->d_init(dentry);
@@ -2041,6 +2045,81 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
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
+ * Returns: the next sibling, or %NULL if there is none.
+ */
+struct dentry *d_next_sibling_sched(struct dentry *child)
+__must_hold(&child->d_parent->d_lock)
+{
+	struct dentry cursor;
+
+	/* always skip cursors to ensure we make some real progress */
+	while (child && (child->d_flags & DCACHE_DENTRY_CURSOR))
+		child = d_next_sibling(child);
+	if (!child)
+		return child;
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
index fff8393ec06b..7150ecd81d72 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -692,6 +692,73 @@ static inline struct dentry *d_next_sibling(const struct dentry *dentry)
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

