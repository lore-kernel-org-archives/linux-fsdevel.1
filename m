Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472069;
	b=hWRcnsDPJP9e05MsIVc68k5pEwZsEuTN7KCwYAB4FR5CyOCeXvH419VxLxUd2W7+fvWr
	 xJ84icMVTVBzThqVGD7bdf4VDdFcv/I26Is58gOdyf7fc9ghAoOlDFZIeNwgIDnRsrlhS
	 WAhDkSD6P3Gi45h9CQ1IjFDu7AUnaaK7Nf/jR50h8OUD7KRU//EjTTo5EpiR1fukDbAMV
	 IIg4T/8uO9DBScEhBDLtqhtMas9FazOeVX5Y74LB2QcN3HShnUwHYSVqYRm3+dlHST/d6
	 juPNt+fjeX74Pn/qRJhqSkONivE1dn5UAfaFzHdJNJk0O8CQmSXrq2Je4xF+FNgPLbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472069;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=s6DObuQJ2ExYR59EsZUV6WpA0yuT9SiqoJwGzpOoQeE=;
	b=KX01HiAYq8pCOk9vCtcBBlPnAXGb7AUS002MFRGdtzjx7VcOZ4bet+tuzFkTUItF4GS1
	 DehgjwBbLrc5FysvSagsZay0wNW5jEWClnuop3NT3Mu7qYZHZpzFR3Gil9y0OpccpUOqo
	 jmJIb3Cv8m43Xsuyo0DO80BP6sXmaw29CEhXn9Io/sAwPgK0WIq5reH0UitNnfslAeVja
	 XcbPN9LISks6dC+oj4zd3UfnIurEl1N1+3ovYHiXb7F75NmxnytNNAKO4jcAR7/6073mM
	 4E6o7/MwWPKbRztptr+5nKKAz0B2OrszijmoDJ5HTbF+9HDXW8C9tPjUejDhRUlC7sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=q3XI8UKA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bgy3icnl;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E81606A339
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 22:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96E81606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=q3XI8UKA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bgy3icnl
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFC501400398
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 17:14:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 17:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795472067;
	 x=1795558467; bh=s6DObuQJ2ExYR59EsZUV6WpA0yuT9SiqoJwGzpOoQeE=; b=
	q3XI8UKAt5OA/VZSbFQIzKsJGdG42UUsThQ6x80VEsP9SxFMEwbNAFi+tlxaMq3U
	dnoXSaeVMVCulaSemrTilnwk4e7Az7vnl8q5s+nTQg1wE4OfT6F8BnbFARnFTgOo
	ye3iUGMQ+m1+pHV7vQz70kiksZ34HQFBQvDHJr4Zv9fECJ2WyNd6oXWwGfVrdk+w
	t1UDIQFa8qujKOWEqG13Tbfe5Cw3Sb1cgeiVTixqGvmttPOh3xkrXfcV0vf9+BJ/
	FVr/v4W0RZwQnW7k3uu0G75g93jJPwryf+OA0hdKYvIeRB+3Dp64lQ3zQySJGoHO
	RM3MA/n+v35JJGMktxwe8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795472067; x=1795558467; bh=s
	6DObuQJ2ExYR59EsZUV6WpA0yuT9SiqoJwGzpOoQeE=; b=bgy3icnlEPMLLYZVn
	aSLLdoL1xv3chSLzp/u9HPfXykqRaTfCW7hhRMY968mHCDaCB3Qoe3fT2Mzj5aim
	/YNIjuD+uNiqYMGSmiUra99V4N/ImuQrzRsQ9IfEbjZPy9aB9rPULnSaEQvdsVPX
	+Prc29TrMRajcavEm6V5alsLhLi2JyhjN6xGttn4bpLPSraIVAVYtpD1dId771n6
	4j7h3bvUvpbenzISkFRTsdYGhfXUrQDZg8OM1+17s1VxLsnysxstnVRDEnaJ7eR9
	/vL8UcUcVFWN+X/Z8H6sNGSdNkQgPUz7C1Bke0GKcddcUFEfKWME04vgL96ZLfb1
	iReEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795472067; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:Gr4elzmB4n4FRcvkYyTiVL3hB9BxkczdzUI3S7QU8KuDUIj
	5b8GYKYw3NffgVwXhIAch8HKC6vJDb5mdr6geUPXxi8A57ZbPTYDXr3V2UElEmu3
	/I2YsOYNkDff7ZcXecAPsVMj+kaWLTvD8aw4Ivp8GMATzMyE6TpFCLmeC77hwp6r
	8KZyaR5rafKnV1xYePWEAi2n3dIinL5QKkH1HDsCnsMwgCRBJy52rUj8NYV/L3c7
	Y0OiTgY+bMNxiNkd7tH8KxFHS1VxYFy6s3KtmudxuE0curmfohyTVEd42Z2dKcj0
	pD1K7Ez5Hh/EQ15vhnKipnUun1DTFOMHa0rRUSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:UjHQiu2vZAxldpI4fABmlluFgrAs8xCVyuILCDMlEPk=:fnFZLNe/EByDdwYSXFb9zsAmZrkBiEHF0UujhKp73eQ=;
X-ME-Sender: <xms:w7oEa-sVjj41wux8420SIpIlcdTNOw6Shga4BBvKjltW288-t_KNkA>
    <xme:w7oEa2BXiHvD05Lv2FelUMlcGkcA7edN_bRUVNi2butkrM0cP1JDMacbKfdttT_JX
    NLN6Cp5p6Axdrjl3pysQvZDzTSjhvhjedS4C83ZsI1NNF6-sxQ>
X-ME-Received: <xmr:w7oEa9ZIK2vm5--L-Muj8iLlx-hoWYHp15yi5IAdQu-SFmH8XBYoaMUzgdPKlbmvH9v3VWpw8sfbGdiSuFiKhxNneokxrsY>
X-ME-Proxy-Cause: dmFkZTGeQG7+oCOtWDmnSz98fLIuNC1Tk8Z7XhHnobbOLI6WuBDQNaBEthwlGmH0h5XYyv
    0zPeMFN0KvFixQfoLN/F8Pe6ZzfsHR+Kg8vVy/LgMZpCOkrPq1SA+pGTOaQ5yTZO8fc79n
    A2L/J/o36VD6hfC9y7Q4sde4+12Vj4pQbWP2Lg9xXCiYljmRQNBVpnttUkbX+pu+xZSZCF
    kUmG2slBnnvm/CELMbc8Xa/tUuKDNnkZeYFjxev+ul/+31HCgi9yBJeWdoIviQPtKuVMlG
    T9d10deUqy6gKqdbte8CCyn97qEbnmG2FnKkTrvzQo0xRFptMooysaG8wEdixEIo4XcqGW
    GRr4zBzZiRj5q2I63YsnDv7g6fnsANuFOYPyKOrcWwHyI923OXOZKn8GH7KwPJg95DVgRg
    2krpa5GL1XLvdxu6/V5Ujbi559WyHaspoCWdDNgpSjMMwPIl+bbQGaYPBtR/PoAwxiV5NB
    tb7YAhxMNr2fhEGXmqjo+mTk4EY4cslGLp4An8VtDjk3X8WqTX7UoQyFqOcRVrKyMAhIlQ
    Z6StD/XnQqK89wIMeNKXTa7aq9fDVjVBnE8fKGLp5MK+WwRSClh/PDDLJ3Sz+Bh3BVpExC
    BdljhfdnlU+xZHbOPVBkSBlxnDS1Ah9nb7mPnqnT7JqcQ1OwfG3juAhCMgSg
X-ME-Proxy: <xmx:w7oEa5X8sksqMW_aHPDIAxU4ZC9scCQgTHW67O47CQvsmrO8CdsA9g>
    <xmx:w7oEa0OZ_5qk9AHPAcqeKrAY_uXwpaz-zKI9zJagztHlHNemfsUpcA>
    <xmx:w7oEa7Yp7BcfS9AGp8xgPk392DIppnKK-N1gR2Kq5sn4vGYuQiPYew>
    <xmx:w7oEa79C1m0SOvmxH9pRXFS0dzqSqwAqgxjdLUjBFCGy5_IybvYn7Q>
    <xmx:w7oEa-cSGCpkMWkFjB8newr0f-tl-DRnpLn6Te2YFmSXdxrOcHvegzzh>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 17:14:24 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v6 1/5] VFS: don't count references through ->d_parent
Date: Tue, 24 Nov 2026 09:12:38 +1100
Message-ID: <20261123221410.3328780-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261123221410.3328780-1-neilb@ownmail.net>
References: <20261123221410.3328780-1-neilb@ownmail.net>
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
static-inline "extra_references()" is added which performs the
check and is told how many unusual references to expect.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/autofs/expire.c     | 33 ++++++++++++++++----------------
 fs/dcache.c            | 43 ++++++++++++++++++++++++++++++++++--------
 fs/internal.h          | 10 ++++++++++
 fs/libfs.c             | 14 +++++++-------
 include/linux/dcache.h | 17 ++++++++++++++++-
 include/linux/list.h   | 30 +++++++++++++++++++++++++++++
 6 files changed, 114 insertions(+), 33 deletions(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 5c2d459e1e48..4a9f72c8c072 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -7,6 +7,18 @@
 
 #include "autofs_i.h"
 
+static inline bool extra_references(struct dentry *d, int expected)
+{
+	/* a ref is always held on 'd' */
+	expected += 1;
+	/* DCACHE_PERSISTENT is always set */
+	expected += 1;
+	if (!hlist_empty(&d->d_children))
+		/* expect children to be counted */
+		expected += 1;
+	return d_count(d) > expected;
+}
+
 /* Check if a dentry can be expired */
 static inline int autofs_can_expire(struct dentry *dentry,
 				    unsigned long timeout, unsigned int how)
@@ -207,16 +219,8 @@ static int autofs_tree_busy(struct vfsmount *mnt,
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
+			/* top has an extra reference */
+			if (extra_references(p, (p==top))) {
 				top_ino->last_used = jiffies;
 				dput(p);
 				return 1;
@@ -321,7 +325,6 @@ static struct dentry *should_expire(struct dentry *dentry,
 				    unsigned int how)
 {
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
-	unsigned int ino_count;
 
 	/* No point expiring a pending mount */
 	if (ino->flags & AUTOFS_INF_PENDING)
@@ -375,9 +378,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 	if (!(how & AUTOFS_EXP_LEAVES)) {
 		/* Not a forced expire? */
 		if (!(how & AUTOFS_EXP_FORCED)) {
-			/* ref-walk currently on this dentry? */
-			ino_count = READ_ONCE(ino->count) + 1;
-			if (d_count(dentry) > ino_count)
+			if (extra_references(dentry, 0))
 				return NULL;
 		}
 
@@ -392,9 +393,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 
 		/* Not a forced expire? */
 		if (!(how & AUTOFS_EXP_FORCED)) {
-			/* ref-walk currently on this dentry? */
-			ino_count = READ_ONCE(ino->count) + 1;
-			if (d_count(dentry) > ino_count)
+			if (extra_references(dentry, 0))
 				return NULL;
 		}
 
diff --git a/fs/dcache.c b/fs/dcache.c
index ba17f49f8a63..b09988d01c55 100644
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
 
@@ -2106,7 +2110,8 @@ struct dentry *d_duplicate(struct dentry *dentry)
 	new->d_flags |= DCACHE_PAR_LOOKUP;
 	lock_map_acquire_try(&new->dep_map);
 	spin_lock(&parent->d_lock);
-	new->d_parent = dget_dlock(parent);
+	if (hlist_empty(&parent->d_children))
+		dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
 	if (parent->d_flags & DCACHE_DISCONNECTED)
 		new->d_flags |= DCACHE_DISCONNECTED;
@@ -2130,7 +2135,7 @@ struct dentry *d_alloc_cursor(struct dentry * parent)
 	struct dentry *dentry = d_alloc_anon(parent->d_sb);
 	if (dentry) {
 		dentry->d_flags |= DCACHE_DENTRY_CURSOR | DCACHE_NORCU;
-		dentry->d_parent = dget(parent);
+		dentry->d_parent = parent;
 	}
 	return dentry;
 }
@@ -2907,7 +2912,9 @@ struct dentry *__d_alloc_parallel(struct dentry *parent,
 
 	new->d_flags |= DCACHE_PAR_LOOKUP;
 	spin_lock(&parent->d_lock);
-	new->d_parent = dget_dlock(parent);
+	new->d_parent = parent;
+	if (hlist_empty(&parent->d_children))
+		dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
 	if (parent->d_flags & DCACHE_DISCONNECTED)
 		new->d_flags |= DCACHE_DISCONNECTED;
@@ -3300,12 +3307,21 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 
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
@@ -3318,6 +3334,17 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
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

base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
-- 
2.50.0.107.gf914562f5916.dirty

