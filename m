Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C3343D64;
	Thu, 30 Apr 2026 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518617; cv=none; b=CO5TMd7gE6Br41dyaf7a5L5/rjImMtJJOy2kwGMNIPyXNPna0POKAV0UvZzSKRG2QHxSSVoVOxzbmJURk7DS7XskK8W3ICDQR7t9sad8O/FIkaY8v8yNpNHU1/Gb4rf8QxZblwOxgDfMlTfnixTeyv6LDKeJ7ELb2WrIsh/eXJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518617; c=relaxed/simple;
	bh=BG15dbbtGmbo7py2hh2tQuZ/Chxlj2dVvwfxDnyR62A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTiFHkOzMykFOxgVEYw7Bkc0j5hEQ+rxRMJrhKv9lT/ys1jhknmJu7hzHtPoowU5ep1PUhQokEgg95XcVzF1vkqLAQGFeh85d6tPAwrAFugBDdErPTNGNkgnEAMKyYtAC9vqMYnkWIZx59l4qLQi9PEIPvXCPqa+AW1HHvylAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=APE34RHw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LcO2NwBL; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="APE34RHw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LcO2NwBL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A24A51D00113;
	Wed, 29 Apr 2026 23:10:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 29 Apr 2026 23:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777518615;
	 x=1777605015; bh=MyRgJx5tx/nmumUkV3zg5NFxjmBpebhpDnTbkO1uNVQ=; b=
	APE34RHw34Hi9NRp3ENP1879yIUt19Y1+i3Z1w0g3/JeUfD51EXamWgthXv2ONS3
	zVR5N0fvbraeVHToCcrDUjgSXMhMlvu4ovVwOb6JGDP+Zxp70vN3KJEfl4a/H8Xx
	KO0HIWuYG3hCynVsoGdsuIlL334/cP0Ocq3RxurQf7fk+z79+VYVDnaxIxu3LxUC
	In2xyh4NaE8i4ONraQA/HDDRt4fGgTp5OC8VyAiXgY6TNGe1rBvpYMRX3ShJBsGU
	O25/tddwi8Sm+wRIYOrXjR9ZqYyZO5eZl+aR6TEPgXb+/4CL963q6jz16cKksxU1
	HNe8L/W9h7yuAKzbkEIswg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777518615; x=1777605015; bh=M
	yRgJx5tx/nmumUkV3zg5NFxjmBpebhpDnTbkO1uNVQ=; b=LcO2NwBLOeIY2GHXc
	mgJbVErasC0seWtNfNQYsuenZfgyOcENqrgokZEf3Q7hWUdv/JLqOR/YVqYzyp2q
	uqRLgeq9d+/GfaPdyAQkDP7g0+1xt6N2EWH5q7sUht+PQtIGZ4/pLcKG7s6mb+5r
	vA8z6TqDw00p+cMxkmOM+2ZEeWfKGUFFiMvhqT0yxKg5PXEjPHGEV3hIbBQOP4cD
	K+DWGylgWlBg+41pLluE4k+zKke9Z1I/1n+NFlX9fugUEjtmvf2e3yMW6q5dtZlb
	dd/8RadhZvDV45QG496V8bYM3nUq4QYJAftJMdMtGXppoM8tuul65O8tKmM9MlXg
	b4noQ==
X-ME-Sender: <xms:F8jyaVA5qrC_pd8wIfGvDYs7vq8GInJ66zQmBtdDbwkp98CScxnnLQ>
    <xme:F8jyaWEnbJCEYaBgAnBuCwcwLBmsH49uUmtgSmTk0g9rVICMZ6pcd0E7H5aPr5o3r
    ViU2HaeAz3n0A9UTx-Hs7ybC-_upLhYAoM2UIWCNgwQIiwYYRY>
X-ME-Received: <xmr:F8jyaUO_95sQGOBywomT3F_lXHc8b-uvD1uD92j_H90JTsrJvVii9vWKe2CuYtlkhxkpfsvPo32ZTtvky0nvGmzkClVgYPc>
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
X-ME-Proxy: <xmx:F8jyaf5Wo3e0tPj3KkD7_sK5V_O9S65kt2uTDErEWs5bu0OcqiF3Cw>
    <xmx:F8jyafhtXKiVA4YfhRWV6UFLYpxFHRI22s-xd0BEXenhNwcQCtYzJw>
    <xmx:F8jyacdYaTzN_273paHK4ADlushGaps3ReFAPk7gsQXlYLjsX98vlw>
    <xmx:F8jyafySGJFmUB3bX9eZgdLj_WNpp98eCrb4tOxR30YwbBNkewsqMw>
    <xmx:F8jyaSKcWxzHhnnUWnxACHk8j6SDim8s7CUs2Z4szuNtuNDkUQYNIaoJ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:10:12 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] VFS: introduce d_alloc_noblock()
Date: Thu, 30 Apr 2026 12:03:25 +1000
Message-ID: <20260430020505.3308841-5-neilb@ownmail.net>
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

Several filesystems use the results of readdir to prime the dcache.
These filesystems use d_alloc_parallel() which can block if there is a
concurrent lookup.  Blocking in that case is pointless as the lookup
will add info to the dcache and there is no value in the readdir waiting
to see if it should add the info too.

Also these calls to d_alloc_parallel() are made while the parent
directory is locked.  A proposed change to locking will lock the parent
later, after d_alloc_parallel().  This means it won't be safe to wait in
d_alloc_parallel() while holding the directory lock.

So this patch introduces d_alloc_noblock() which doesn't block but
instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime the
dcache (smb/client, nfs, fuse, cephfs) can now use that and ignore
-EWOULDBLOCK errors as harmless.

Unlike d_alloc_parallel(), d_alloc_noblock() calculates the hash and
performs a lookup before an allocation, as that is what all callers
want.  This done using try_lookup_noperm() necessitating the includion
of namei.h in dcache.c.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 87 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/dcache.h |  1 +
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a4ee380f3dfc..a0096ac02790 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/namei.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -2652,8 +2653,16 @@ static void d_wait_lookup(struct dentry *dentry)
 	}
 }
 
-struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name)
+/* What to do when __d_alloc_parallel finds a d_in_lookup dentry */
+enum alloc_para {
+	ALLOC_PARA_WAIT,
+	ALLOC_PARA_FAIL,
+};
+
+static inline
+struct dentry *__d_alloc_parallel(struct dentry *parent,
+				  const struct qstr *name,
+				  enum alloc_para how)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2735,7 +2744,18 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		 * wait for them to finish
 		 */
 		spin_lock(&dentry->d_lock);
-		d_wait_lookup(dentry);
+		if (d_in_lookup(dentry))
+			switch (how) {
+			case ALLOC_PARA_FAIL:
+				spin_unlock(&dentry->d_lock);
+				dput(new);
+				dput(dentry);
+				return ERR_PTR(-EWOULDBLOCK);
+			case ALLOC_PARA_WAIT:
+				d_wait_lookup(dentry);
+				/* ... and continue */
+			}
+
 		/*
 		 * it's not in-lookup anymore; in principle we should repeat
 		 * everything from dcache lookup, but it's likely to be what
@@ -2764,8 +2784,69 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	dput(dentry);
 	goto retry;
 }
+
+/**
+ * d_alloc_parallel() - allocate a new dentry and ensure uniqueness
+ * @parent: dentry of the parent
+ * @name:    name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup(), then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_parallel() waits for
+ * that lookup to complete before returning the dentry and then ensures the
+ * match is still valid.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.
+ * If the returned dentry is not d_in_lookup() then a lookup has
+ * already completed.
+ *
+ * The @name must already have ->hash set, as can be achieved
+ * by e.g. try_lookup_noperm().
+ *
+ * Returns: the dentry, whether found or allocated, or an error %-ENOMEM.
+ */
+struct dentry *d_alloc_parallel(struct dentry *parent,
+				const struct qstr *name)
+{
+	return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT);
+}
 EXPORT_SYMBOL(d_alloc_parallel);
 
+/**
+ * d_alloc_noblock() - find or allocate a new dentry
+ * @parent: dentry of the parent
+ * @name:   name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup() then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_noblock()
+ * returns with error %-EWOULDBLOCK.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.
+ * If the returned dentry is not d_in_lookup() then a lookup has
+ * already completed.
+ *
+ * The @name need not already have ->hash set.
+ *
+ * Returns: the dentry, whether found or allocated, or an error
+ *    %-ENOMEM, %-EWOULDBLOCK, and anything returned by ->d_hash().
+ */
+struct dentry *d_alloc_noblock(struct dentry *parent,
+			       struct qstr *name)
+{
+	struct dentry *de;
+
+	de = try_lookup_noperm(name, parent);
+	if (!de)
+		de = __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL);
+	return de;
+}
+EXPORT_SYMBOL(d_alloc_noblock);
+
 /*
  * Move dentry from in-lookup state to busy-negative one.
  *
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 97a887be150a..d22c308043bb 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -257,6 +257,7 @@ extern void d_delete(struct dentry *);
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
+extern struct dentry * d_alloc_noblock(struct dentry *, struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
-- 
2.50.0.107.gf914562f5916.dirty

