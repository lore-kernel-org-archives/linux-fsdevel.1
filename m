Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135A345CCD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948722; cv=none; b=GcqbWeg3WFrwV5zQ1yITwwi5ZxueOLpqlKajsa7XUI5KFWbjuy0IA8JtuANYOqr+8ggxRZiD/kiqvs1buCGZwFA8+FpJBXyWQCjNDrtgIq/9vgT3xzWd3LzC4CjPlpuxP4kdCTWSYoCEzojtlGUpZ/XEpWzVXCB8ZCcyCfj+Tfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948722; c=relaxed/simple;
	bh=4xmzD2jJgPn6+6OJgYrTDABbrhG5eOJGnHTjyDB16bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKhlkaFNM5Zv2drvLcQ2K4lFyUcAAA8uCrDibvBEXnlOAi7Aw8TbaFd1DSstqFjbp10sro5Dh/ptIdsxKCrUdn/Ii2SfXum0ii42XlNF+n6Wk0dLEG5yBTYab00WlXHuQpAkSYWJaxMZ1fdt7sVJLD7Opno3NyVi4KB1ogodEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hxHBw2lH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SLPqQAjX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hxHBw2lH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SLPqQAjX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F133E7A00CB;
	Wed,  1 Jul 2026 19:31:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 19:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782948719;
	 x=1783035119; bh=1/e7LwTOMpxGzmtJAm+zSqJy+dGh/bTtHUQCaWuk2YU=; b=
	hxHBw2lHwiPDljgvLnU6yY9UDtVYD/Itb8dU6B4GE1bd1BX0Dk0wWXfKybjFz9D1
	cY/1QLn/pEgKnyR3vd8uHUnlHx9eG+Kj30VMZT1avv65exEphrgTImLKsAsIOd8D
	NC8g21X+a5ROVf53oNlP8mWOA47Fe55LF+TbOIDvku8iRblhot2MexY78rtf/tkj
	98yolA2kMRDNCXTI58l42yW1/t1pWkQxLtylANh6FwgjMvdOmRWBMNY7SIlc8OSP
	JfzVeYwascB+fm1nnyaM4L4RDtU2kt7f49FfmMg4goi7VfKGR9oWXbBOJoykVFQl
	bzRMfMTMKFMkxMO66x26tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782948719; x=1783035119; bh=1
	/e7LwTOMpxGzmtJAm+zSqJy+dGh/bTtHUQCaWuk2YU=; b=SLPqQAjXiK+616O6N
	uts1+jHVC5kXsDl3E0sVokXZju04hetLX7pzkPqcAckMxbraW7fkhHRRwnOzDdVo
	kRsofnMw+qtYIqwlZYpmOVOVZGBrvXDDeYRmTcQ+WZGIhJE8rSXMxRx2y2x2p/yI
	s3kMTW0eU+8MoWQ3TAfx1yvtyUpsY0g5Mx7ZIIispixX0I2RbTPj7xu0jgTSeTsZ
	831hzG7WTgcuecq+EHIJRZy1BT2HhmWjR69BliFL+WniE7VZ6I0QjY4Su81PyTLd
	aKrxu7Ohjr4Z6ByiCGpaRfAR9Mbleygr0hOLuNgajoPOhodzOu02c0L4iz0JvD/1
	NZkVQ==
X-ME-Sender: <xms:b6NFaqOz0hmHOfd07A21aP08EPIVZXPFCn5Dsue8BuIKyLJk9xCOIA>
    <xme:b6NFakY89Y7LiLBWp-Ej6qCh_g69gVICI3p2gPf30FKYAnnTrNdpSc_62vdyTWDUI
    fGF9ZjqgIzytq7AvjpsAfzOMOhUzj9vWiXIqHBabYG7pCfkcQ>
X-ME-Received: <xmr:b6NFakyhBP-Jq11b0WISV1ANNKFOpHPihWPSNxWB3mpym7-NcyDHHAtMKrjXcgFnP-JZ5CoEl8md_xz1d94WafSqjuv9woM>
X-ME-Proxy-Cause: dmFkZTFM0H8U71vd02ztbF8TIR4P0eEfOPWkEzhqRICs3Hznw5OM43uEYT6FZYOUFz3aGX
    ztMmq/8RC2RDthnfkU6wZHZnDHnC9o1agZC0rxt+XtcM465UUQhrN/iac6m3rJIUKFS0vd
    bQDjEidgqtcjjZNKsGKPXu+XBh1x4UZFDqYoCwNQNveeeyMlmCnMgHpuG3o82Ab1mxyvim
    JAf109up/288e7v2twF09Zj1R6YUuFrhkvCgo/AgKHQHIkXJjSWauMNzA8QMKfGNCf4ZCV
    H6Dif+pL8b74IddJF3tNBG5/SnB+t23dPFbZqiEOzJuq5Eee/LMtMawYnpHTMCD00R5qSB
    cFDWQ+tvdco/ErcNQ4sd0n8C/GayA9oPqFuiQBIYfCK+GT6XY6ij0bXQddPbjf6ZXNrAbE
    9X4mep0VrSkFMObm20I778rJfCRLJ0zFMKHu/Su26y9Qh8/uZYTwhVZaoSxw/cJccMV5qw
    5omM4zbW2q1YiUzurgEi7Xz3zv7dv9Gl+6tP24xBbCQ1cHOMWKxZf5v26U2+GDZOeJnkCG
    b4skXqF8quxGRQKRC2TU174XkrMEnKR0QRQeKNzHQioTWFeBb1FdCcDHc2rCJMjQ5Wd1G2
    8DIQIj4/4dFbyvujDzKS/miEXUDdCFIo8V11do/KdBze6bowChKCCQOJPbdA
X-ME-Proxy: <xmx:b6NFavLbH3NBm5ACGISN2nYvH-hOm_XjpqTd-mxIGb8tIEClF0Ww9g>
    <xmx:b6NFauqkVubQ2qoEUYM1o5gg2Af82hO997g1Jg10EVPS1zdOn7wKPQ>
    <xmx:b6NFauKdZ2TnvFMDcrTs7eakl-WX4XIRImNF9csY45xa9Pfcliy0wg>
    <xmx:b6NFajQCZZWfvXqQaSpQdHZY1a3qbuBFPB37Hol17MPDeWL2Bdbb_A>
    <xmx:b6NFam-4cxy9ZvT8u-DqK_3YQ34Si2pE4oSZDhhBmHkFmiH3nqZT5Aw8>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 19:31:58 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] VFS: introduce d_alloc_trylock()
Date: Thu,  2 Jul 2026 09:29:03 +1000
Message-ID: <20260701233128.3356519-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260701233128.3356519-1-neilb@ownmail.net>
References: <20260701233128.3356519-1-neilb@ownmail.net>
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

So this patch introduces d_alloc_trylock() which doesn't block but
instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime the
dcache (smb/client, nfs, fuse, cephfs) can now use that and ignore
-EWOULDBLOCK errors as harmless.

Unlike d_alloc_parallel(), d_alloc_trylock() calculates the hash and
performs a lookup before an allocation, as that is what all callers
want.  This done using try_lookup_noperm() necessitating the inclusion
of namei.h in dcache.c.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 87 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/dcache.h |  1 +
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2fff76c0f6fe..c6f45b6846a5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/namei.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -2751,8 +2752,16 @@ static void d_wait_lookup(struct dentry *dentry)
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
@@ -2830,7 +2839,18 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		 * pin it and wait for them to finish
 		 */
 		dget_dlock(dentry);
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
@@ -2858,8 +2878,69 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	dput(dentry);
 	goto retry;
 }
+
+/**
+ * d_alloc_parallel() - allocate a new dentry and ensure uniqueness
+ * @parent: dentry of the parent
+ * @name:   name of the dentry within that parent.
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
+ * d_alloc_trylock() - find or allocate a new dentry
+ * @parent: dentry of the parent
+ * @name:   name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup() then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_trylock()
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
+struct dentry *d_alloc_trylock(struct dentry *parent,
+			       struct qstr *name)
+{
+	struct dentry *de;
+
+	de = try_lookup_noperm(name, parent);
+	if (!de)
+		de = __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL);
+	return de;
+}
+EXPORT_SYMBOL(d_alloc_trylock);
+
 /*
  * Move dentry from in-lookup state to busy-negative one.
  *
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4b1ff99608e0..7afe16d4664d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -257,6 +257,7 @@ extern void d_delete(struct dentry *);
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
+extern struct dentry * d_alloc_trylock(struct dentry *, struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
-- 
2.50.0.107.gf914562f5916.dirty

