Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3A342510;
	Thu, 30 Apr 2026 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518632; cv=none; b=Bg8LpxdgpQEMkQjjs0xjRafYzFP8t0RB7jCxhJqqJnV8844kjuK5GHYmCMfFcc6X2v2mR4EgATxS0tLqP+vscIk5ZvZqjEeCec2KixVVhcFwSUuC63scGe7/3hy2orO4mdG+XTPEikka4OFK0O9cs824N++8jYRIKFhv0sWvTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518632; c=relaxed/simple;
	bh=UAJM24qUUx8sGGgdwz+1qGnn3czFQr+lW/5exwiHzOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxnYGQupqN3OzeXecQEwnQk3USuVnQAICDMfpevanTCaIdMF2ayDcZfChYwdW1YDREdhBVV4bV7jO7xijr/O2V5LIsUq2LbBDc3Ii+jyxTZfxjV8QdhCFCATC/zwx0keMM0UWafn2I2ulauS/LjetUfm3W9zHhQhOXliIg+UUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XwTSox+h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LtWHAZvZ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="XwTSox+h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LtWHAZvZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EC7561D00113;
	Wed, 29 Apr 2026 23:10:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 29 Apr 2026 23:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777518630;
	 x=1777605030; bh=397bwYAv51bs3HjVSNAjjDiciH3vsAoQlMx7AK9mSzs=; b=
	XwTSox+hWbMmg6QNZ9wjPVKF1UNvl3Fb11LzUB9CXLZv4V+j82//spmULHgX2S5r
	g8UMeYXybYMGO1XBTORMA92lTwogd3OWiEKcnEqWyBCg+EbfD1FqsL6cuaucLGYu
	sogN2qboYcufw49dzCgkdKYMvSUgeqDQnbSe7hE8hj+NVYfcqqHxnsbObq42LaXi
	VCQt0QJcGhppmRzatdIT1e9maFJGJ/wRf+RVpJYu/N/756noEQ/NX+705X80ntSv
	o6XOirlWeUteXTYHbkNSlDykjDoSqYgcrSM194tjkFLprEpfciSY3B4wjDl0HplQ
	pO+3SJnyxVks0BlHNhROOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777518630; x=1777605030; bh=3
	97bwYAv51bs3HjVSNAjjDiciH3vsAoQlMx7AK9mSzs=; b=LtWHAZvZEpZuwbL41
	Ecwmx5CRMOusWfHH/Qt9zpGW/cIgcb6r6w7kugbYWc8K1BYt8HXp86t0tzVdrLpm
	MEm3XI4gUOOU5zEFd5DBhr/I9TwZQN7OtrxjFdn6RddA73JfpgV6sSzK/EGGY9aQ
	KkxNW8qCGI046kmkOguarkbzKIK22GigG8nk1Q8WKilch0nshTmWR0BRlBRCSWmt
	ll++WbfDtyBkDDODmx6mzbkLhohOq99q4eIcoIcVw0RCdW2wJU1gOLJZhS25n9wn
	xbven88t0qgwtcPzZ5MXoZs/6w3swMHiOj+tNqCHm7CLA8DTLGMXtQdldSyMLobD
	7ueyQ==
X-ME-Sender: <xms:JsjyadJrv9cYK6p7BgZsTEC4fKp68fm_NkXGQYxtDhn5JY8pQsUGeg>
    <xme:Jsjyabt0q4scAU_x6UiZzCtLrAH9JogOpVMfqvD5e9xttK6zkKK10ETS_0K10OmWH
    tIHAgm1aDkc2s1d6Y_uUGm2Ie2PKktgLwVQrU0mUrmwaVll-Q>
X-ME-Received: <xmr:JsjyaZWKYtCLZ5QhHFcNn3a_YgwAF8vJbta_LApltBMh5CVdcwvHuag4aCFQbf6vZrdKsaGs8pA0M1DLcKzYGRkZ0ColTSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JsjyaeiUX0fntlB8_y1c5LBvpcA1-r-SoTCd726OQK47X4WDO8V5Gg>
    <xmx:JsjyaZoG2zoKjO06nM98vWjFDrpATXKgYCAKokm7RvNS72KVOkuhrg>
    <xmx:JsjyacHhyYqrSwxL6h_n6t_ko0Y9mwbyztXKFrx1JsBwfZ498GL_Uw>
    <xmx:JsjyaW6Bu70ZjoIcmnDVmL6KVaIxs3vY7NK0CHK4jEuUkaGUbzlyQg>
    <xmx:JsjyacNd8jOh4Ecp5awbDiQb2xhtUMfjZ5YI7YcEixVqX1q00FthkV_B>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:10:28 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] VFS/xfs/ntfs: drop parent lock across d_alloc_parallel() in d_add_ci()
Date: Thu, 30 Apr 2026 12:03:28 +1000
Message-ID: <20260430020505.3308841-8-neilb@ownmail.net>
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

A proposed change will invert the lock ordering between
d_alloc_parallel() and inode_lock() on the parent.
When that happens it will not be safe to call d_alloc_parallel() while
holding the parent lock - even shared.

We don't need to keep the parent lock held when d_add_ci() is run - the
VFS doesn't need it as dentry is exclusively held due to
DCACHE_PAR_LOOKUP and the filesystem has finished its work.

So drop and reclaim the lock (shared or exclusive as determined by
LOOKUP_SHARED) to avoid future deadlock.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  7 +++++++
 fs/dcache.c                           | 18 +++++++++++++++++-
 fs/ntfs/namei.c                       |  2 +-
 fs/xfs/xfs_iops.c                     |  2 +-
 include/linux/dcache.h                |  3 ++-
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 5cc6ae19845c..146720fc9f6f 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1391,3 +1391,10 @@ either form of manual loop.
 **mandatory**
 
 d_alloc_parallel() no longer requires a waitqueue_head.
+
+---
+
+**mandatory**
+
+d_add_ci() must now be passed the flags arguemnt that was given to ->lookup
+
diff --git a/fs/dcache.c b/fs/dcache.c
index 1943607f7547..43cd0765670f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2275,6 +2275,7 @@ EXPORT_SYMBOL(d_obtain_root);
  * @dentry: the negative dentry that was passed to the parent's lookup func
  * @inode:  the inode case-insensitive lookup has found
  * @name:   the case-exact name to be associated with the returned dentry
+ * @lookup_flags: flags passed to ->lookup
  *
  * This is to avoid filling the dcache with case-insensitive names to the
  * same inode, only the actual correct case is stored in the dcache for
@@ -2287,7 +2288,7 @@ EXPORT_SYMBOL(d_obtain_root);
  * the exact case, and return the spliced entry.
  */
 struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
-			struct qstr *name)
+			struct qstr *name, unsigned int lookup_flags)
 {
 	struct dentry *found, *res;
 
@@ -2300,6 +2301,17 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		iput(inode);
 		return found;
 	}
+	/*
+	 * We are holding parent lock and so don't want to wait for a
+	 * d_in_lookup() dentry.  We can safely drop the parent lock and
+	 * reclaim it as we have exclusive access to dentry as it is
+	 * d_in_lookup() (so ->d_parent is stable) and we are near the
+	 * end ->lookup() and will shortly drop the lock anyway.
+	 */
+	if (lookup_flags & LOOKUP_SHARED)
+		inode_unlock_shared(d_inode(dentry->d_parent));
+	else
+		inode_unlock(d_inode(dentry->d_parent));
 	if (d_in_lookup(dentry)) {
 		found = d_alloc_parallel(dentry->d_parent, name);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
@@ -2313,6 +2325,10 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 			return ERR_PTR(-ENOMEM);
 		} 
 	}
+	if (lookup_flags & LOOKUP_SHARED)
+		inode_lock_shared(d_inode(dentry->d_parent));
+	else
+		inode_lock_nested(d_inode(dentry->d_parent), I_MUTEX_PARENT);
 	res = d_splice_alias(inode, found);
 	if (res) {
 		d_lookup_done(found);
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 10894de519c3..e2f3430c2e6d 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -310,7 +310,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 		}
 		nls_name.hash = full_name_hash(dent, nls_name.name, nls_name.len);
 
-		dent = d_add_ci(dent, dent_inode, &nls_name);
+		dent = d_add_ci(dent, dent_inode, &nls_name, flags);
 		kfree(nls_name.name);
 		return dent;
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 325c2200c501..db0beb3831a9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -369,7 +369,7 @@ xfs_vn_ci_lookup(
 	/* else case-insensitive match... */
 	dname.name = ci_name.name;
 	dname.len = ci_name.len;
-	dentry = d_add_ci(dentry, VFS_I(ip), &dname);
+	dentry = d_add_ci(dentry, VFS_I(ip), &dname, flags);
 	kfree(ci_name.name);
 	return dentry;
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index b4663a1a0636..9553bffbb098 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -263,7 +263,8 @@ struct dentry *d_duplicate(struct dentry *dentry);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
 					  const struct dentry_operations *);
-extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
+extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *,
+				unsigned int);
 extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
 			const struct qstr *name);
 extern struct dentry *d_find_any_alias(struct inode *inode);
-- 
2.50.0.107.gf914562f5916.dirty

