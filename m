Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1E17A305
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368512; cv=none; b=APZM3/goToa052M02ES7rGalVf/bX4ww2qKT3Y8LkTPM6ccgVrbnfA3XQUq7S6uYWD8ISnTOmO7lnHmVs2bcIKRDKVOh871tGz85fRK89SGj+IT2yqykNBhp9SFdjx40m8xvMv+OyoW8XUAw0mL1Fosya8I5EHjQVNR3wqOi9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368512; c=relaxed/simple;
	bh=TTEgmToFZNll/tOEpL/Fkztg0eRVicudDp8FkYnfp20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXDHSpjKOa8TwbTAdlEai51JpkVP1xhBhcXiYT1E9SxS6P8XPLZVnKRI5cCuWhLHz9ZQQB0a7/IEGS7QAyezMJRBeBdzdO6ZYQPvyu0ulQRIa4Zqzj5MJjenx/7QXx7aT2kRXSG9llS7+uTkYEQZocOfl2qhaEparH7ojCsIW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Vb0lKs1K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xf/A64iT; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Vb0lKs1K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xf/A64iT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6105D1D0013C
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 20:08:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 18 Oct 2026 20:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1792368509;
	 x=1792454909; bh=BzgyxQsb9OHYweqBKSCj+6W3w2OpoVBllI28GIVISfw=; b=
	Vb0lKs1KgIGD+LhvGz6qhbb2QUjEHyanPCQcBUb0lta9BCagxFGRNTmjphASVsq1
	UvP5gRaN+2sfVZisA5cH5cr25Cp2zNFfs6WNV8AuKQWAB75IbD5jCF8dHg6ykOdy
	K1ylUQdNSJQjt6T2Yyqkh+EZfbnbeV42GmzVPQc0+bWNtIC0RM+9nSfnypnwahjk
	F84zEUbq4sA/YaPFSV/1mvetCue/Q+yXfVqxZ8go5pGlnej4rGQ5c/axLgOLih4T
	AsZVjA0/Zj2Qb+ou5FS6ET/Xj3S88HqM+RwW1w+jqkgEW5bf01VAaeKRU5xiOGK2
	KMqFJicMJEhG+gMFXTGZuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792368509; x=1792454909; bh=B
	zgyxQsb9OHYweqBKSCj+6W3w2OpoVBllI28GIVISfw=; b=Xf/A64iTdoA3tzSSI
	kqpcY4xv5mcPGB8htw8JSSyHhUk9vLjX+H5UZ7NDruzzIaEahbPJmpW0vvdF1V2H
	WNvHbOxqex/6gxC6Oqe4gE1vK7JJHnOdg1HxcgNALrNJRlMkVsjXkLlm4gH2pMml
	pOtQthc7JtqDqASRMgnOPkie7LE12HZ45eDs/6C8kWC1oTGIMQrgAC+WTkurpvli
	ucuNKvHpOu+cG8n4JGBGhNc7JhiIPxsURYUMf2xOKeB0bZ3fpZm4Z2txxUfaCZBA
	qx4EeBpoellLhdnyp2K5ipd9BpeqeLaw8rLGAgNClNfDgfSvnC7tI+Y6AKfeuIkS
	lRz8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792368509; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:fzZ2Ac2V4LVMYkavVoml2Ie+rkOJl91WJ0v33nO6p6zrTgM
	kEfA1Arxkjdl7qy3vsIPC1kKLrPKFawxNiCm/kxNwzMAL13GTu3v40K0DEDZcx6o
	vbPKwBi7z6Sgb/DKCTAXJK/1tvop3ECIC2H8SmwIqZYdxnfd8pRqNh2IgmPN7/yn
	4hh4+iqgAIrZLqiJ2yfCpvV3CyZQ8L4vTgkLzcL5z7s/6q7jSJ/PnMj5jyZ+NC0U
	EDOOK+3cd0NbdvmkKB+p/mjq1DXko4iPdDb1Tcp6RT4uEMKMWEd8c1bnQlW3uUY9
	urA34QR/hwhrOBzteppyp/aIQecX2TG6Bnb17KA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:OLg1wLXFnF6vc5ps0sAnvtWPiggyKnlO+5nJqaBiGK8=:TTEgmToFZNll/tOEpL/Fkztg0eRVicudDp8FkYnfp20=;
X-ME-Sender: <xms:fV_VaswlBWlclAuwHUCB3BVqMnpGhuKphBmyGj5EFztMFmZh19G71w>
    <xme:fV_Vai1A6knhT_Cp9QekRbPVAyp573cOwsSa6e5dkPR-suddkxbZaw-LLwcgGu_YR
    qZfG3vo4PGOcRjPe2-EPfjItgJSOLifeJdOuMKi5yURbgmLI28>
X-ME-Received: <xmr:fV_Vah-W_6Txy94hgrBxy4mQIMay032g5fdBzpRl_qZXD_VZEuPbOLvbKDcrhekGw0tYPEJ-DhmCL2YyTl8S07HPujnKZRM>
X-ME-Proxy-Cause: dmFkZTFs2i+5K0BYLeXMC0R006lxiATWY/pyyLHbxrZd5n676ixdWE8+6DS+wr2JnmZrE+
    XEDc9MiJU3LySWAtA5xXuB1qBwkZKM71WRxiNhPbAD79Ahrpi/ew7ryYTZhtYZgMRITqn5
    YRsCpjzWHB/LWfIl1uU5cN6J1CKRGuqVVWLAS2Ukrboe64/3/fwvOhXkINgxDg6k+Hmy1A
    McozUfzJ7vrTCvZ8+oJ56I8WJuFRAKSeox22j7QCwUCT+aqgatVwuTg4Mo88b8S+D+awZv
    J/iyl28Vfztd3b1k2Z3Q2unfkJg1S1uC86rtU/tzP5X3vDr0eVz2xU0OxvoPKm9KBzgbMb
    JhGpTXiOthaqfbvoJVsNk3EUSXWVm+2s+HT6+y5Vb7t+sh/dYn0+NKdRbRYiZDu9wYP/gB
    M1aymU7U2VmQ6r9Mytw4Jl83ZjTzA6ZvSDJaEbpOvavm+EBrKewJ4eLLs5tr4A16fCqs3n
    hb6CUX3gLgN6kSm5TMlddi6u3/tOTQZ1udbjIgSkOXjE31lJeZt2ZufwxlfBDpuioSqyXG
    jaCLGdrBr178/qXI2gqQl1RfoSntCrqokjk75nhSoUC93UaTPPCl/1rSUNeJmyWgL2ULbh
    DtGusvqjIveZmQxZm7gchO0iTHi6VRhGuvaoRZPS5+WLPQnDR0m6RpflA6vg
X-ME-Proxy: <xmx:fV_Vaqp60zVzvNLsiaWq7DLqQ-PFjX93T2D4dNQcAPEAZdFQo6B6PQ>
    <xmx:fV_VajQmeO0IHAH00z5180qulc2q4PGhlmmBodBOm-o80893UNQKag>
    <xmx:fV_ValOyDHDl1yceBP4JURIfe2kVe6xwksXFXXcSUjqOHSjlKb7pVA>
    <xmx:fV_Vaph7KUWC5LaBl15hrVVH5MHyJQv6fF8e0H5yWOdmf2cSGKp0HA>
    <xmx:fV_VajBCBxglXLILY1AsTs2y5G2bdSe1mceZHoCWQxkDbMzPeRVsI7FR>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 20:08:27 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v4 1/5] VFS: don't count references through ->d_parent
Date: Mon, 19 Oct 2026 11:00:39 +1100
Message-ID: <20261019000810.1837917-2-neilb@ownmail.net>
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

The number of negative child dentries that a given dentry can have is
effectively unbounded, so counting the references through ->d_parent can
overflow ->d_lockref.count.

We only use this count so that we can know when there are no remaining
references including from children.  However most children appear on the
->d_children list and the few remaining children (inactive
DCACHE_DENTRY_CURSORs) only exist in a context were a separate reference
is held on the parent.

So if we count whether d_children is nonempty (i.e.  dget() when it
becomes non-empty, dput() when it comes empty) and require children not
on ->d_children to have a reference on the parent some other way (which
they already do), then ->d_lockref.count will not overflow and we can
still know exactly when all references, including through ->d_parent,
are gone.

__d_move() allows that dentries might not be on any d_children list as
is the case for IS_ROOT() dentries.  Rather than track when this is the
case we dget() either parent if they have an empty d_children before
children are moved around, then dput() if they turn out to be empty
afterwards.  This will increment dentry if it IS_ROOT(), and then
decrement it afterwards, and will decrement the refcount on old_parent
if its ->d_children becomes empty.

To help with this, dput_dlock() is added which warns rather than
decrementing to zero (which should never happen).

When a DCACHE_CURSOR dentry is added to d_children, it is only ever
added "before" or "behind" an existing child, so it will never be the
first child added, and so never needs to adjust the refcount on the
parent.  If it remains on the list until dput() it could be the last
child to be removed, in which case normal handling applies in
dentry_unlist() (where it has been moved from dentry_kill().  When a
cursor is deliberately removed from the d_children list the refcount
must be decremented if that leaves the list empty.

hlist_move_behind() and hlist_move_before() are added to simplify moving
a cursor within the d_children list.  This results in some duplicate code
as they share a common prefix with d_detach_cursor() (hlist_del)
which is currently factored out.  We can expect the compiler to optimise
this away and don't need to clutter the C code with it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 40 +++++++++++++++++++++++++++++++++-------
 fs/internal.h          | 10 ++++++++++
 fs/libfs.c             | 14 +++++++-------
 include/linux/dcache.h | 17 ++++++++++++++++-
 include/linux/list.h   | 30 ++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f44c7b39c3b3..3a4d0a025447 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -670,6 +670,8 @@ static inline void dentry_unlist(struct dentry *dentry)
 		return;
 	}
 	__hlist_del(&dentry->d_sib);
+	if (hlist_empty(&dentry->d_parent->d_children))
+		dentry->d_parent->d_lockref.count--;
 	/*
 	 * Cursors can move around the list of children.  While we'd been
 	 * a normal list member, it didn't matter - ->d_sib.next would've
@@ -843,7 +845,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
-	if (parent && --parent->d_lockref.count) {
+	if (parent && parent->d_lockref.count) {
 		spin_unlock(&parent->d_lock);
 		return NULL;
 	}
@@ -1997,7 +1999,9 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	 * don't need child lock because it is not subject
 	 * to concurrency here
 	 */
-	dentry->d_parent = dget_dlock(parent);
+	dentry->d_parent = parent;
+	if (hlist_empty(&parent->d_children))
+		dget_dlock(parent);
 	hlist_add_head(&dentry->d_sib, &parent->d_children);
 	spin_unlock(&parent->d_lock);
 
@@ -2016,7 +2020,7 @@ struct dentry *d_alloc_cursor(struct dentry * parent)
 	struct dentry *dentry = d_alloc_anon(parent->d_sb);
 	if (dentry) {
 		dentry->d_flags |= DCACHE_DENTRY_CURSOR | DCACHE_NORCU;
-		dentry->d_parent = dget(parent);
+		dentry->d_parent = parent;
 	}
 	return dentry;
 }
@@ -2778,7 +2782,9 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 
 	new->d_flags |= DCACHE_PAR_LOOKUP;
 	spin_lock(&parent->d_lock);
-	new->d_parent = dget_dlock(parent);
+	new->d_parent = parent;
+	if (hlist_empty(&parent->d_children))
+		dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
 	if (parent->d_flags & DCACHE_DISCONNECTED)
 		new->d_flags |= DCACHE_DISCONNECTED;
@@ -3106,12 +3112,21 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 
 	/* ... and switch them in the tree */
 	dentry->d_parent = target->d_parent;
+
+	/*
+	 * Ensure ref count on parents reflect d_children being non-empty,
+	 * which they almost certainly are.  If either end up being empty,
+	 * this is handled below after the moves.
+	 */
+	if (hlist_empty(&old_parent->d_children))
+		dget_dlock(old_parent);
+	if (dentry->d_parent != old_parent &&
+	    hlist_empty(&dentry->d_parent->d_children))
+		dget_dlock(dentry->d_parent);
+
 	if (!exchange) {
 		copy_name(dentry, target);
 		target->d_hash.pprev = NULL;
-		dentry->d_parent->d_lockref.count++;
-		if (dentry != old_parent) /* wasn't IS_ROOT */
-			WARN_ON(!--old_parent->d_lockref.count);
 	} else {
 		target->d_parent = old_parent;
 		swap_names(dentry, target);
@@ -3124,6 +3139,17 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	if (!hlist_unhashed(&dentry->d_sib))
 		__hlist_del(&dentry->d_sib);
 	hlist_add_head(&dentry->d_sib, &dentry->d_parent->d_children);
+
+	/*
+	 * Adjust parent refcounts if either d_children ended up empty.
+	 * This should only ever be old_parent.
+	 */
+	if (hlist_empty(&old_parent->d_children))
+		dput_dlock(old_parent);
+	if (dentry->d_parent != old_parent &&
+	    hlist_empty(&dentry->d_parent->d_children))
+		dput_dlock(dentry->d_parent);
+
 	__d_rehash(dentry);
 	fsnotify_update_flags(dentry);
 	fscrypt_handle_d_move(dentry);
diff --git a/fs/internal.h b/fs/internal.h
index c658c8a5ebd5..59b2b8030b6c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -235,6 +235,16 @@ extern struct dentry *__d_lookup(const struct dentry *, const struct qstr *);
 extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
 				const struct qstr *name, unsigned *seq);
 
+static inline void d_detach_cursor(struct dentry *cursor)
+{
+	if (hlist_unhashed(&cursor->d_sib))
+		return;
+	hlist_del_init(&cursor->d_sib);
+	if (hlist_empty(&cursor->d_parent->d_children))
+		/* That was the last child, must drop implied reference */
+		dput_dlock(cursor->d_parent);
+}
+
 /*
  * pipe.c
  */
diff --git a/fs/libfs.c b/fs/libfs.c
index 27d7dc16fcb0..60586fe65895 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -128,9 +128,7 @@ static struct dentry *scan_positives(struct dentry *cursor,
 			count = 1;
 		}
 		if (need_resched()) {
-			if (!hlist_unhashed(&cursor->d_sib))
-				__hlist_del(&cursor->d_sib);
-			hlist_add_behind(&cursor->d_sib, &d->d_sib);
+			hlist_move_behind(&cursor->d_sib, &d->d_sib);
 			p = &cursor->d_sib.next;
 			spin_unlock(&dentry->d_lock);
 			cond_resched();
@@ -166,9 +164,10 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
 			to = scan_positives(cursor, &dentry->d_children.first,
 					    offset - 2, NULL);
 		spin_lock(&dentry->d_lock);
-		hlist_del_init(&cursor->d_sib);
 		if (to)
-			hlist_add_behind(&cursor->d_sib, &to->d_sib);
+			hlist_move_behind(&cursor->d_sib, &to->d_sib);
+		else
+			d_detach_cursor(cursor);
 		spin_unlock(&dentry->d_lock);
 		dput(to);
 
@@ -210,9 +209,10 @@ int dcache_readdir(struct file *file, struct dir_context *ctx)
 		p = &next->d_sib.next;
 	}
 	spin_lock(&dentry->d_lock);
-	hlist_del_init(&cursor->d_sib);
 	if (next)
-		hlist_add_before(&cursor->d_sib, &next->d_sib);
+		hlist_move_before(&cursor->d_sib, &next->d_sib);
+	else
+		d_detach_cursor(cursor);
 	spin_unlock(&dentry->d_lock);
 	dput(next);
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4b1ff99608e0..3b595adff7b4 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -324,7 +324,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- * dget_dlock -	get a reference to a dentry
+ * dget_dlock -	get a reference to a dentry while locked
  * @dentry: dentry to get a reference to
  *
  * Given a live dentry, increment the reference count and return the dentry.
@@ -339,6 +339,21 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
 	return dentry;
 }
 
+/**
+ * dput_dlock -	put a reference to a dentry while locked
+ * @dentry: dentry to get a reference to
+ *
+ * Given a live dentry, decrement the reference count and return the dentry.
+ * Caller must hold @dentry->d_lock.  The dentry must still have
+ * a reference after the decrement.  This can be used when two
+ * references are held and one must be dropped.
+ */
+static inline struct dentry *dput_dlock(struct dentry *dentry)
+{
+	if (!WARN_ON(dentry->d_lockref.count <= 1))
+		dentry->d_lockref.count--;
+	return dentry;
+}
 
 /**
  * dget - get a reference to a dentry
diff --git a/include/linux/list.h b/include/linux/list.h
index 77fb62f79928..a94eec20275f 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -1123,6 +1123,36 @@ static inline void hlist_add_behind(struct hlist_node *n,
 		WRITE_ONCE(n->next->pprev, &n->next);
 }
 
+/**
+ * hlist_move_behind - move an hlist node to a new location in list
+ * @n: hlist node to be moved
+ * @prev: hlist node after which @n should be added.
+ *
+ * @n may be on the list or unhashed but must not be @prev.
+ * It is removed if necessary and re-added after @prev.
+ */
+static inline void hlist_move_behind(struct hlist_node *n,
+				     struct hlist_node *prev)
+{
+	hlist_del_init(n);
+	hlist_add_behind(n, prev);
+}
+
+/**
+ * hlist_move_before - move an hlist node to a new location in list
+ * @n: hlist node to be moved
+ * @next: hlist node before which @n should be added.
+ *
+ * @n may be on the list or unhashed but must not be @next.
+ * It is removed if necessary and re-added before @next.
+ */
+static inline void hlist_move_before(struct hlist_node *n,
+				     struct hlist_node *next)
+{
+	hlist_del_init(n);
+	hlist_add_before(n, next);
+}
+
 /**
  * hlist_add_fake - create a fake hlist consisting of a single headless node
  * @n: Node to make a fake list out of

base-commit: f909e534f5e34feb2ea2701d54df63e21aa506fc
-- 
2.50.0.107.gf914562f5916.dirty

