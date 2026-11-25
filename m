Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565456;
	b=J2c+Kyb/hd6pPy1LJkk0Pe9xAdDiGmRsnz0fDsc7UucxpyaXZ3jwFuOSaXbXk19FlbD9
	 ZGd+mUtpFBT+z0jFlHb+btkxI1QtQRvqHEZR1/jPdxNilDIEkz3rLgXbPnXRwLtD+Bivm
	 y9VD9BtQCBTgczgCNgU27PtVvKSfKkv6ilaPseWFphJfAW0t7E7dhLSr4pQaVa5JRKKaz
	 t7zVBYPLkq31y6kA6k4oL2djwaqg+B5ugxdByM+yGyBUY8cOc7XArD8HCqPRz54VAB49A
	 OPkllWc0B+OGjbERjivJae19hA9HMn++4XJE2AFhKd0JS7EghonjRmSDffvSVE/+lsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565456;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=IC6eUJ1BYoA7ZSZVQpSThiq5+++mbT+UVqm+e9giAkA=;
	b=0tNNP5dbyqcV30Aoq1Es9d8TCM0KqlwEcNYQqDcCdvza9PJkUitwpjRf8Dhsm/RYcbCE
	 92/i4xuVu39y1tL8ZdtGKSAiQPpMBa6j+e6YPacrJPdNKlK+ddBDBRFJkyw+esseg1Dxc
	 vhmtBb5eWlCTgtcxKUHa0uI9lI2K4oJwo2KU8OMg8PA9K0hLKd6aHMwFVrDQncHKwgveW
	 0QGiN9omruZRdi9ssTbUO3+IGEucE3z98s/RqCuVzXFW39+BsEsBMMh0sg6Sqg8ZBQMeu
	 00ryVp5oJZUIcKZSLx5sb+9F4GTqaT41WZCXQRVF2N5q1XniyIKVdtX5vr17q2S6GVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=EZT1P5iV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eDvRYS7+;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D9606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 00:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA2D9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=EZT1P5iV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eDvRYS7+
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D1A21400340
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:10:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 24 Nov 2026 19:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795565455;
	 x=1795651855; bh=IC6eUJ1BYoA7ZSZVQpSThiq5+++mbT+UVqm+e9giAkA=; b=
	EZT1P5iVpeVuCLVAF/i46ytukQXcfaUbyZInP8kD+2JL0MOFz17z7hg5QOuJ82c5
	BJBFIxEJojXxbo1hlly5Kahv7lZU1QqPvwSvWcLrzJ2x0+OmcyLxifO4Mtk76VzX
	heDfnTaMr3aY0+iXrK6QdVMippTSlqEZguuAOOOxKYW4XLTrOyfnLDzpInbTYGwD
	r7eu3aybExdtKSzD+a0f2ifP+INggya5tv1Ec0TZqPkkTYCe1FBY4JB7LQxZQwvQ
	MNAZQOyOK3C2Zeeh21sN4WKjcGEDdAh5ukpsitZ3HrQ85NM7zx1W47FqRvU1kcfu
	iaz8s6WH67djaZLAsb7CZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795565455; x=1795651855; bh=I
	C6eUJ1BYoA7ZSZVQpSThiq5+++mbT+UVqm+e9giAkA=; b=eDvRYS7+WLpUQa929
	qel5qKJk3/uPy8SQexK6zd9UI1+Y2pvmK67f9wikQbICTkS7zbj+g/js1iWZ14tQ
	phViVrPeW1zzTt+aVJ48XF2h/yISavo8mInppKJDcoHuBSYC5wFu+e71qFIu1xbz
	i4Fi+wOfmIk7jUjlzsPV5GEVjouI1JPmzlTLmod1/HeyKUyni8RQxIaz4Q+GgSy+
	bqYoE2FFC+L4zaHztAQxamTa3T34qa96D6WiJ3qrkTnS56oeV2iLSzLlHuAMaJza
	Nncap7twxO94GCaW+Xd4roeGTI3GGmaGnQUYuDaw+E6Lo0OngQIqG65KPUjbukdG
	+8kNQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795565455; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:xGVrVBtSBUyWClWgLtKj75AgkFcdAkU08JqcpdldMzrSeUG
	fiJmQzV1dv2HZaXBkC55YKRT+qaTNWLBTm2U+dcZIw12hofrsiNAHu17eq0ZLcDT
	P7soRBF3VFfGYpWoj5MsDv1PghhD7hQnORI3rsfDkVxRGdMz9s0+/O4EMEoUBrum
	DYS8LgH03sRgcqQOKA/Xce/UVIIB20K478Leha5UVk58QoSz9jR/Ds0fMaeDQcJ+
	PNk/NoHmi+h/SsLR+n1HWUJ9jXYY0DDPeVUoWM5LL6QFGthUg2b6TlSv/F7VXuXT
	fTLL3sQC4FybWIHQ76Wyhuir8udFrB5AjSd8IBQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:fAHoyDs+bDHtf78K8rTEiNLZKBXGvuKbK5Mc0429rkM=:BQVHU5KnFjiQssXhtybSi7xUfMgyInAmssd0+FRf/ps=;
X-ME-Sender: <xms:jicGa9Q60gnkfeeZb59hKsNJ_DM4loWdei76mBli57MnuVN5hMUIvQ>
    <xme:jicGa5VkgVXLevkUs98zEanW7DZE-GD2xThGdS2mjwps9J3z_ZZAp4N-9HVadLj5v
    _iElEb-XMjVNMv4GGng_wPJ0XjJabhM-ny782eFEmHkSeQpvQ>
X-ME-Received: <xmr:jicGa2eG7x4CNTjiENhg7DKJFmXBGIxqDxSUCWJjSqi56ipUtn9KUaV3j7MkOfG7pF_a-M7Q2dJHANHeEGqVugqAKakNNXk>
X-ME-Proxy-Cause: dmFkZTFtvvtjo3TiqnwievywHT6UMcqs4LNW0jtUBl4WBqV/m7gd8GJpLHqrSgN8SWLSUZ
    VJzM9Mehgr8GzWto4KXYhuPfb2KYnCUl5uLncNNiprl4L2/H+RTJ/fuYTB9lhxGbbLKMYD
    M/6CxXIb3E/XyzdymtH1FBzd5e8L2Po01VMPRPLL5C3Io0AwFZ8dbU3XydszypkkZokBqR
    /jGhZrNqXiUxGkRCo3/x2DTJGeMaThLWGacM5+cfNvEWgcAm40zlBt5kA6JjfFB6gF3nMg
    YcWsKjzsifnV88vQpUOFazoiPMwVgCfmSGKauqcf58vaHaqH0uQcfMVcybu2xlmAKlOroT
    2a5u6pMLop95ZTO0LgPEGrrLStCZJDhG0sCCCIdFdPw3aGfR5CE/PA8SAe9hz4b2/GXMZy
    YSgd+zgXkYA9A5ZnIyPtF7/OPLyrz06UmDRmmUhBIsVnyF1F/B+7LlE9OECRWsAfZjNqNa
    lJjD04p0SU1Wryii6atEEmeMb2rYBlgtzLC/ypurEtwzCNriInoRlsT927YnNfptmkFyLN
    JBO9WwdBRdwBOEeTMbMuTDS3az6goQ2uMYEgCG/K+ri5JlPdr8Z+ZNoUikiIgP9omnuj/W
    lpbrKpGkt3tLN7ckcPg/VYacqcxXrgoBidGzKa7oibONWIko8vmEckcYXGQg
X-ME-Proxy: <xmx:jicGa1J5PaU1dfWmW-sI1aFj-5jifoKttm8jE1R4QSM6MVjQkHkrCg>
    <xmx:jicGa7yDRAt3Vo1pEo0cyNPkohb3yueio2hlfjPME0WaOqNqNVGrbg>
    <xmx:jicGazu1eOX3fwsAyAatEb1j7srvtbQFwEP-mNsVVsjTgWOp-HMj1Q>
    <xmx:jicGa2AooyxGAGf92Js9N7pUirYCx-y9BHAqwKPKhe1LanyI3eacew>
    <xmx:jycGa3hCupjJM8vuqtX66bm34wSl5SbbUqm1pgI8zaulijpH5KGSvdRa>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 19:10:51 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v7 1/5] VFS: don't count references through ->d_parent
Date: Wed, 25 Nov 2026 11:03:38 +1100
Message-ID: <20261125000836.3984402-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125000836.3984402-1-neilb@ownmail.net>
References: <20261125000836.3984402-1-neilb@ownmail.net>
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
any children rather than "one" for each child.  This can be done without
using ino->count but simply by looking at ->d_children.  So a new
static-inline "dentry_busy()" is added which performs the
check and is told how many unusual references to expect.
As no locks are held, this test is racy.  And comment is provided
explaining why the race is of no consequence.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/autofs/expire.c     | 43 +++++++++++++++++++++++++----------------
 fs/dcache.c            | 44 ++++++++++++++++++++++++++++++++++--------
 fs/internal.h          | 10 ++++++++++
 fs/libfs.c             | 14 +++++++-------
 include/linux/dcache.h | 17 +++++++++++++++-
 include/linux/list.h   | 30 ++++++++++++++++++++++++++++
 6 files changed, 125 insertions(+), 33 deletions(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 5c2d459e1e48..4eabf61719fc 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -7,6 +7,28 @@
 
 #include "autofs_i.h"
 
+static inline bool dentry_busy(struct dentry *d, int expected)
+{
+	/*
+	 * The dentry is not locked so both ->d_children and d_count()
+	 * could change asychronously, possibly resulting in a false
+	 * negative.  This is of no consequence as a negative results in
+	 * should_expire() finding a dentry, and autofs_expire_indirect()
+	 * requires that should_expire() find the same dentry twice in
+	 * a row.  Even if both attempts race the same way, the worst case
+	 * is that a mount is expired early and has to be remounted.
+	 */
+
+	/* a ref is always held on 'd' */
+	expected += 1;
+	/* DCACHE_PERSISTENT is always set */
+	expected += 1;
+	if (!hlist_empty(&d->d_children))
+		/* expect children to be counted */
+		expected += 1;
+	return data_race(d_count(d) > expected);
+}
+
 /* Check if a dentry can be expired */
 static inline int autofs_can_expire(struct dentry *dentry,
 				    unsigned long timeout, unsigned int how)
@@ -207,16 +229,8 @@ static int autofs_tree_busy(struct vfsmount *mnt,
 				return 1;
 			}
 		} else {
-			struct autofs_info *ino = autofs_dentry_ino(p);
-			unsigned int ino_count = READ_ONCE(ino->count);
-
-			/* allow for dget above and top is already dgot */
-			if (p == top)
-				ino_count += 2;
-			else
-				ino_count++;
-
-			if (d_count(p) > ino_count) {
+			/* an extra reference is held on "top" */
+			if (dentry_busy(p, (p==top))) {
 				top_ino->last_used = jiffies;
 				dput(p);
 				return 1;
@@ -321,7 +335,6 @@ static struct dentry *should_expire(struct dentry *dentry,
 				    unsigned int how)
 {
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
-	unsigned int ino_count;
 
 	/* No point expiring a pending mount */
 	if (ino->flags & AUTOFS_INF_PENDING)
@@ -375,9 +388,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 	if (!(how & AUTOFS_EXP_LEAVES)) {
 		/* Not a forced expire? */
 		if (!(how & AUTOFS_EXP_FORCED)) {
-			/* ref-walk currently on this dentry? */
-			ino_count = READ_ONCE(ino->count) + 1;
-			if (d_count(dentry) > ino_count)
+			if (dentry_busy(dentry, 0))
 				return NULL;
 		}
 
@@ -392,9 +403,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 
 		/* Not a forced expire? */
 		if (!(how & AUTOFS_EXP_FORCED)) {
-			/* ref-walk currently on this dentry? */
-			ino_count = READ_ONCE(ino->count) + 1;
-			if (d_count(dentry) > ino_count)
+			if (dentry_busy(dentry, 0))
 				return NULL;
 		}
 
diff --git a/fs/dcache.c b/fs/dcache.c
index ba17f49f8a63..8ddfddc31546 100644
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
 
@@ -2106,7 +2110,9 @@ struct dentry *d_duplicate(struct dentry *dentry)
 	new->d_flags |= DCACHE_PAR_LOOKUP;
 	lock_map_acquire_try(&new->dep_map);
 	spin_lock(&parent->d_lock);
-	new->d_parent = dget_dlock(parent);
+	new->d_parent = parent;
+	if (hlist_empty(&parent->d_children))
+		dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
 	if (parent->d_flags & DCACHE_DISCONNECTED)
 		new->d_flags |= DCACHE_DISCONNECTED;
@@ -2130,7 +2136,7 @@ struct dentry *d_alloc_cursor(struct dentry * parent)
 	struct dentry *dentry = d_alloc_anon(parent->d_sb);
 	if (dentry) {
 		dentry->d_flags |= DCACHE_DENTRY_CURSOR | DCACHE_NORCU;
-		dentry->d_parent = dget(parent);
+		dentry->d_parent = parent;
 	}
 	return dentry;
 }
@@ -2907,7 +2913,9 @@ struct dentry *__d_alloc_parallel(struct dentry *parent,
 
 	new->d_flags |= DCACHE_PAR_LOOKUP;
 	spin_lock(&parent->d_lock);
-	new->d_parent = dget_dlock(parent);
+	new->d_parent = parent;
+	if (hlist_empty(&parent->d_children))
+		dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
 	if (parent->d_flags & DCACHE_DISCONNECTED)
 		new->d_flags |= DCACHE_DISCONNECTED;
@@ -3300,12 +3308,21 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 
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
@@ -3318,6 +3335,17 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
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
index aaa4ba7a1299..83e8569a82e5 100644
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
+ * dput_dlock - put a reference to a dentry while locked
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

base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
-- 
2.50.0.107.gf914562f5916.dirty

