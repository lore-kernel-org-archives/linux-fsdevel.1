Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5DA340DA6;
	Thu, 30 Apr 2026 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518574; cv=none; b=FgZVmovvdWYOHALAS4vRH1H2JuBd3qnHBj4TtAwQXXHqHhcMuAX5kt6juicreUgZt/G3mVJwYZkbSbMx1zeEDmebKAEE+6D0WAVziNHbd9jgFMZ04A/6pAHT94rAnBisKBZuKNpkH6Typ5649lVAn/xp8YEtA9rkgaJodBmbR1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518574; c=relaxed/simple;
	bh=BG15dbbtGmbo7py2hh2tQuZ/Chxlj2dVvwfxDnyR62A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKnB4cG3ifL75/7NMpQRa32kzeECuI90RYnD426GGj0R529eKK6I1L0AE4iFBCMGPs4G26PfV/PeXmlB3oEtrblWGLaOZceNyDakcV4VldlSxLbwDoU4biNSkmQ7APBq4TkuK4wzSFdY2MgcTFt8NMFk7qalRfbzC2Yo+mi9Ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PU/r3YeH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4L5oU/s; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PU/r3YeH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4L5oU/s"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 1BAB81D00187;
	Wed, 29 Apr 2026 23:09:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 29 Apr 2026 23:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777518571;
	 x=1777604971; bh=MyRgJx5tx/nmumUkV3zg5NFxjmBpebhpDnTbkO1uNVQ=; b=
	PU/r3YeH4X5iZ8lWrktH6VejSn4xCjecC503Y60bMWmCHLFE2do0L0kf3Xih/duf
	4hocap2xaMxjSEbZ27iaZGRmQB9Mxf2TqPHz3NOf3k87cWeXn3GDyZLsJYXnKxp+
	783pCKRB/GEI7Dyhpxjw9sF8yH9BqMBcp6aF0fKCTeVXYuWfRI5P3aK0gmOg53l3
	RXwW4CNQIOn1FajVqcBohC1cAn9xutvzUni63sFvG+V1j4/omv0ToBwEKuqcxzRZ
	Wk7VSTnPHSr5pVyM9CFxhMYqdTDwLXcBLc1MIUZ4yNoDGX6Z1c8pUE11+w/UXubA
	1ZkryDzFOSc8C75TpJzx2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777518571; x=1777604971; bh=M
	yRgJx5tx/nmumUkV3zg5NFxjmBpebhpDnTbkO1uNVQ=; b=W4L5oU/sVoY1Bzp6U
	35dXIH02Y5qVKyge7gfX9WpQMUFtUFJiHuC1hNKy/NdS+MIDHRhLVkytJZgQxnAz
	abTzq0NW98ZTpzwHJpGRo+0/zNKB5cKaliIxQ+HkvfAKTg5AaKuBpkoyCwSxRY+n
	NyFh4AF84P7JvAeqfi93/MADuIhA1GvQLJh09OSx0wV4OI56mhvb57c+cG2C7j7z
	jOszDGxoqUKUIOg5/50YXVZM3QY+z1bdSTdCuDdqk2RxzqsarOCt1T8ZbaGoVNL/
	xW086EoMkValTb3ebfx00GDzXiyV0iSFuxSkCZ1uH9nOs0M/ToRH+OWZfR/xNdUF
	rDCmg==
X-ME-Sender: <xms:68fyaUYdv-1rH51iwHLv04RaInWxrzjE8cWMA-ouWFFmik4tZQvrAQ>
    <xme:68fyaR876NEGtGXpGeuy3vSc-GPL0LW9-DCCLrlfcxmMzq-csrHhVfs0daGsqJ57x
    qJnmrlCwHVYoH96buF7XeX1s5g0aW8dv3qOH4C7a62D-1ei>
X-ME-Received: <xmr:68fyaSnbsO7hvFb2YZk17q7Q8VGyhAhLmUVpeJlk-c_kUL6ClLO-EG4S9erfikcecAnWnUkbBVXlDAv9TzSv3OLc9juX8wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:68fyaezbjCsQsYi1kFszsQdxKD7dk9aQVOJ_qqiU2OFqmjiVayVN1g>
    <xmx:68fyaU7bn_-kiy2_4YnX5QC--Ag2wFVOiYYUhsmjxxcia1wPMjLtow>
    <xmx:68fyaWUqoldtW6zJXpRk9S-eHBbES1kSgtvVZJ7_wDDGgoBYjcsN6g>
    <xmx:68fyaULHRXaQr9qG7hfCxcowoWdxYcIfQTT1-p-EUnwAFKYAI5Lltw>
    <xmx:68fyaScuHBLbh7T7Ma9gwaBAZcWzOydmCmMTo-9EGArE2kBpNY_30T5u>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:09:29 -0400 (EDT)
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
Date: Thu, 30 Apr 2026 11:56:57 +1000
Message-ID: <20260430020137.3305302-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260430020137.3305302-1-neilb@ownmail.net>
References: <20260430020137.3305302-1-neilb@ownmail.net>
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

