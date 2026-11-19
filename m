Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057202;
	b=dZt/SoFmdYuMuEV8ZyuPTnqa93/+mRJYpXJT//9PbdmL7XCx9/9Xw8JRwhJLbydk7Veh
	 YTgeuvgGoXm1tvnuiKMkarQz/YyPHmqdziSIhqZu/iY56JsofDA2tqpVL5HJUGuHGAXWN
	 DUDS+VlV+2YUXTxFCPQaF4SDL8rcHtbLwEYxCUx+AoWdoempznpTQhSf631+c2cb0yw8d
	 +QI6EiBauBOHC3zu+WunkVeQ3Qq5sIFO3xHk+1AXE1YYhBxAm1NEkKnK5hHCgl8hQHLX0
	 MM5pjTZXrcSd+p1qbroqRfklE4IMKvNDFuIgPiHzJy3EJFKqf1Bj/Gcd2ivzBAAr+Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057202;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=cFJlEF5Fmv66phfNnpI0BDoKGdOvPpnu+qgejcj8x28=;
	b=LP+obrpBLp1XTPjcK9HhKzyG7G4er06xqzvEyAROeZvLGJbo8LtRp2oJ7wBiAk46GIaf
	 NwQOLSQHm4KfWEotQZ6JOyt0zD9oCajV6cakqTdWLTor7j8ScjdGnqG6ZAfYGfknjeBBS
	 hdayC8BFYWTBsXNemkIUhts/LbeHHFZKT8SoIU1paDd4punEbQOdcU572AKc846yM565X
	 h3h3Jnwmsq3dgGwfaQla77BlwJ1a0hVlBOZzzMVKx2I1RUeELHkA0Z/kDBl7zjzMokTvH
	 tpWW+OJdUVWdh7XZD2ibue2OsQuK5QhhspkWWwkjkXQN5V1pOEyCRbfzwrGSQ1LIpUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b="lNjRLxx/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ziVKXuII;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD10606A33F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 03:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AD10606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=lNjRLxx/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ziVKXuII
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FF35140018A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 22:00:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 22:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795057200;
	 x=1795143600; bh=cFJlEF5Fmv66phfNnpI0BDoKGdOvPpnu+qgejcj8x28=; b=
	lNjRLxx/jVdme4TgBZIS+JD17fGlScVhsyj1Uq4HO777RuSiaDq9kvNV0KPehTLU
	fQvazGpjoBhp7swypH1AyKA4l8FjYTwN0QeEgwAyceZNGHc6mtLd18wFZoCNzMEY
	8DT1Gq7yXfxahJ8d6REMYXAWCiOuaGiVunGc5bNVLQDho5x8KdPjgAb5LAbjMVbK
	d/wOu8ApXcOiIwihFKhlHrOfYJP2d82nEGXx0iWhlaP8qT9NFXJLg4nZo91lcTSk
	vXrOBX6AeJm7m7vDJ2v+xsXLXIOOmq+28DX5M3HsxVPtCzOnmZQ6GoXqQWKDLo4U
	zRGs56BRm27M0mwR3OuQ6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795057200; x=1795143600; bh=c
	FJlEF5Fmv66phfNnpI0BDoKGdOvPpnu+qgejcj8x28=; b=ziVKXuIIdlVieUdYK
	m53jhZzlfriHsOb24POfN+CBSh+SuDamXTQUOayAUafTUnMGKVI1n/3Xn5ojD1Nw
	LkifAq6X0Mm9ciRukq3Xd2pKQvgsaVX1VzUuX6LA3jvYW1SF4//B2XgCx9MzLmh6
	jmt8CUyar2qFkxAiyNsOyJ05Bs5NMiB6zCNxFMjBrwJH520NZW4hXk/RNB8M2qFS
	3uJgQN0wHrjcCl5cXhTX+TW2U1xzyuQF2Q2J6CZKF09kasId4FzclqZ3jOujzUNX
	AmIVFTcLwEC1HNuanp4YBww6s8AIl+hU+mnWVhrAPeSm6LlItfUPY4s2ot6+OAel
	qjGTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795057200; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:GH45OfFwXx0hqpFX10vYGqC7jyNGlRbV0tHCUFumBt9j85X
	SF1anyBHuNDg6MN+aA0VxmSZT9CbPNLY2Fjqsl5PMC009S2kG8xn0/j9uuswvqeZ
	87sM1q23iQypKz3+lMSEgAn+kNJvzAO3rNZEY/OGNLWd/cBXUnUnQc1k2YyIarj8
	wC883WPvvWnrBU3y2oZD2oGQS0VZhZPqO8T4vvjmvlm9XnPvQrDM/se/b8/Sxpwn
	UZMN/+Ie14s8vbr5ykGrQihM3n1N24T4SxuZ2h+OckL97hSHmgfa0iLOkjLUt/TJ
	JgvpDIw+hdwsWgp0kMk5h8AqrHQM/4c2GRLSGtg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:1bp8Eu3NXlpIvPKoTuqAad4roESJVjrjHNjDHM9rc/s=:/WVBRh+QKN0kgqUP8nCYRPnooNUGfmGfHk2zlz/Bcrg=;
X-ME-Sender: <xms:MGb-atozmMyYtl-HBp3TZ2kswY2rrVzfa7Xfk7nsaoElmLyJPJmrnA>
    <xme:MGb-aiPQD-fll0Ix4LvY41xb72O5wuSsUm6aNZxHSPONj1OMDtmCXV2eQTcWAcYUo
    C5NDL8l8dVB_qc4r8i4f55HUr5xZfUq3XgUkrxqDbEAvstGtA>
X-ME-Received: <xmr:MGb-at3lHFiCZIFSwKe_8SFd9wWdN5mKQbHyFhsaq1fS46zTNZL8vomU1yeQKIbUlczKTQE5xyxFNC59r8Z3V7kdVyEqUM0>
X-ME-Proxy-Cause: dmFkZTFOC6uO02mRbMQ83LyNIejJGqymQ66up6ULDVZjog2cbHInVW+5y+J8LS7quS7hdj
    /F6/ZcfkNUOs5ISLEVKL2Z2qegTgRKRJkRPhqVQWk0E9CJMgblWjd82s0dKukSGnvBLipX
    nWZ3IqUcU37LK+bN5ZQWvDWh7n3ew8Jq65CMatxydWrQepbvozB3ogsb+STelHdtPSHsm1
    ne4dF11k4L1vh4LhGojQeiID59J8FU/UhvzRmYdjDNyUU9zPp+Vs4CokkvcCWGyJrDKOxq
    d5Yj5WvZZ9iCVRs6W/lDQCMq5i+cvoq2lnVv6X2KZj2b+h0cEaYAAOkRqzQT4DaMNPSySE
    G/UYZB2iOldBpDk3US+3Exz4FN63U/dUvUW23V3iP4AHD3Ojs2/wsamlz06vY0crI+RqS/
    rkefg+6RwxiYRafaodov6vN/4uKv+KfPyLz7yN+fZzx0CC/JVi/ub5NBkAToSWa9SckUR4
    sCnL0cEEJQWkDl23ErZubS/6GhnKqpKHALnPSYsTJLxjAqeGXGpqdDqKbfqlaeB1/Vjs+c
    J24/3objuUH6eH3WWx13udh5bYEM/R+N8NDLE0o0wF6BO4NJuiAcdfre+hbOJjeopGbD2Q
    duLKrQUKIy6Sr4BX8JpedCvkvB4NsxqHQSzlLg1VBI5ox09f4+j3YkVCa8RQ
X-ME-Proxy: <xmx:MGb-apAiGxYgbodQL7MXyJRndcKdceA2AqsyAVrXCxkWEqBsKOb9TA>
    <xmx:MGb-aiJH2wjcjES1zhv7l3BU3nCLomRzrGI9KcJ-UG5zwMPsr8PTNA>
    <xmx:MGb-aqmLP-gwLyW2Tt_IkujpAgljKqxo867UfBmiUZTRuzUWPoCWgA>
    <xmx:MGb-ajZJWxHc2e2-vpsDQD4I3jxOEbLv5qwGJE2o0t8Qzgd9-WsnBw>
    <xmx:MGb-au5tNKMJ5p3BYhcv4f5ANTgg6RR0v7bQa6JCFd4R8eTRvtHp_Rrp>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 21:59:56 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v5 1/5] VFS: don't count references through ->d_parent
Date: Thu, 19 Nov 2026 13:57:01 +1100
Message-ID: <20261119025942.2848130-2-neilb@ownmail.net>
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

autofs compares d_count() with the number of known children of a dentry
to detect if there are any concurrent references to a dentry.  These
comparisons must be changed to reflect that we now only count "one" for
any children rather than "one" for each child.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/autofs/expire.c     | 25 ++++++++++++++++---------
 fs/dcache.c            | 40 +++++++++++++++++++++++++++++++++-------
 fs/internal.h          | 10 ++++++++++
 fs/libfs.c             | 14 +++++++-------
 include/linux/dcache.h | 17 ++++++++++++++++-
 include/linux/list.h   | 30 ++++++++++++++++++++++++++++++
 6 files changed, 112 insertions(+), 24 deletions(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 5c2d459e1e48..cd276bce28c9 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -208,15 +208,18 @@ static int autofs_tree_busy(struct vfsmount *mnt,
 			}
 		} else {
 			struct autofs_info *ino = autofs_dentry_ino(p);
-			unsigned int ino_count = READ_ONCE(ino->count);
+			unsigned int use_count;
+
+			/* allow for 1 if there are any children */
+			use_count = READ_ONCE(ino->count) > 0;
 
 			/* allow for dget above and top is already dgot */
 			if (p == top)
-				ino_count += 2;
+				use_count += 2;
 			else
-				ino_count++;
+				use_count++;
 
-			if (d_count(p) > ino_count) {
+			if (d_count(p) > use_count) {
 				top_ino->last_used = jiffies;
 				dput(p);
 				return 1;
@@ -321,7 +324,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 				    unsigned int how)
 {
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
-	unsigned int ino_count;
+	unsigned int use_count;
 
 	/* No point expiring a pending mount */
 	if (ino->flags & AUTOFS_INF_PENDING)
@@ -375,9 +378,11 @@ static struct dentry *should_expire(struct dentry *dentry,
 	if (!(how & AUTOFS_EXP_LEAVES)) {
 		/* Not a forced expire? */
 		if (!(how & AUTOFS_EXP_FORCED)) {
+			/* dentry has any children? */
+			use_count = READ_ONCE(ino->count) > 0;
 			/* ref-walk currently on this dentry? */
-			ino_count = READ_ONCE(ino->count) + 1;
-			if (d_count(dentry) > ino_count)
+			use_count += 1;
+			if (d_count(dentry) > use_count)
 				return NULL;
 		}
 
@@ -392,9 +397,11 @@ static struct dentry *should_expire(struct dentry *dentry,
 
 		/* Not a forced expire? */
 		if (!(how & AUTOFS_EXP_FORCED)) {
+			/* dentry has any children? */
+			use_count = READ_ONCE(ino->count) > 0;
 			/* ref-walk currently on this dentry? */
-			ino_count = READ_ONCE(ino->count) + 1;
-			if (d_count(dentry) > ino_count)
+			use_count += 1;
+			if (d_count(dentry) > use_count)
 				return NULL;
 		}
 
diff --git a/fs/dcache.c b/fs/dcache.c
index ba17f49f8a63..0dc54ba31d8c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -701,6 +701,8 @@ static inline void dentry_unlist(struct dentry *dentry)
 		return;
 	}
 	__hlist_del(&dentry->d_sib);
+	if (hlist_empty(&dentry->d_parent->d_children))
+		dentry->d_parent->d_lockref.count--;
 	/*
 	 * Cursors can move around the list of children.  While we'd been
 	 * a normal list member, it didn't matter - ->d_sib.next would've
@@ -874,7 +876,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
-	if (parent && --parent->d_lockref.count) {
+	if (parent && parent->d_lockref.count) {
 		spin_unlock(&parent->d_lock);
 		return NULL;
 	}
@@ -2058,7 +2060,9 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	 * don't need child lock because it is not subject
 	 * to concurrency here
 	 */
-	dentry->d_parent = dget_dlock(parent);
+	dentry->d_parent = parent;
+	if (hlist_empty(&parent->d_children))
+		dget_dlock(parent);
 	hlist_add_head(&dentry->d_sib, &parent->d_children);
 	spin_unlock(&parent->d_lock);
 
@@ -2130,7 +2134,7 @@ struct dentry *d_alloc_cursor(struct dentry * parent)
 	struct dentry *dentry = d_alloc_anon(parent->d_sb);
 	if (dentry) {
 		dentry->d_flags |= DCACHE_DENTRY_CURSOR | DCACHE_NORCU;
-		dentry->d_parent = dget(parent);
+		dentry->d_parent = parent;
 	}
 	return dentry;
 }
@@ -2907,7 +2911,9 @@ struct dentry *__d_alloc_parallel(struct dentry *parent,
 
 	new->d_flags |= DCACHE_PAR_LOOKUP;
 	spin_lock(&parent->d_lock);
-	new->d_parent = dget_dlock(parent);
+	new->d_parent = parent;
+	if (hlist_empty(&parent->d_children))
+		dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
 	if (parent->d_flags & DCACHE_DISCONNECTED)
 		new->d_flags |= DCACHE_DISCONNECTED;
@@ -3300,12 +3306,21 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 
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
@@ -3318,6 +3333,17 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
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
index 3f2fbac40f8e..22e018429759 100644
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
index 46e0205154e7..9f7f6bf5666a 100644
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
index aaa4ba7a1299..fff8393ec06b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -330,7 +330,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- * dget_dlock -	get a reference to a dentry
+ * dget_dlock -	get a reference to a dentry while locked
  * @dentry: dentry to get a reference to
  *
  * Given a live dentry, increment the reference count and return the dentry.
@@ -345,6 +345,21 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
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
index e3753695e76c..ab8ad0d18d09 100644
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

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.50.0.107.gf914562f5916.dirty

