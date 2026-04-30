Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5233F5BA;
	Thu, 30 Apr 2026 03:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518589; cv=none; b=oz9OG7OEW5WG6sI3BvdBDd85aeJNUKoNEN3rurG+7meggI9N72muRqlxIpgDF2469H6DRSjsZu4uOgyic3Haa0TGePSzO8mXeOGXCJTPplD9JZDADcy4erWC9mpQ5yBClDUDczGZkFBMmpy9PcNOEW3eZMgJn+4OeCqzoFeepVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518589; c=relaxed/simple;
	bh=t9kggWsulA9KxdwVFklPlh4m30Ed/VK+5i4xHr1w7C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSya4jlrRvw+vTrl92h95pkdbN/nbPr3+v0uzr8sWLVt6dMxMdwLvd3cSKybnyhnbNsLXEnsJcRGONDYaAzNtI4JvE4uu9lLfhBeBa84mEH9PhuyKAm9l5meeQiHExqhxOgWEsMkqiRkmaLlNKvvKU9w8H0FWMgJP/T6+jCYsag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mjOcLmdJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4Hakb2i; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mjOcLmdJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4Hakb2i"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9BBA87A00F5;
	Wed, 29 Apr 2026 23:09:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 29 Apr 2026 23:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777518587;
	 x=1777604987; bh=IPvhYgSpY2OYytpoQzuPZwD9BYsKRv/q4WdeXo/yL6E=; b=
	mjOcLmdJ3h41bDxvkjxgid0w9Nu1cvc39wuBEygvf1JMVgYYdV9zLh/NiaEYgHW/
	FbRikC+bTbOqamyvM54fGa6eFF407CRfp+eAu+/vgB9204MGGsA4OfXglnHkzstW
	GNJVgq7EsloGgw/NW8fbofSIpoOkgw5SUH5kcVIYuta5IVI9EhTVKC5m90egkwLh
	K+txFgMxGnZ/Wg1BS+Ris3itmFLdQ65Qu6+pobYEAvm1Rg2OxXkYFemZLastA8Gd
	k/f6zp+2soffEhQYQZkXEKOCUDNeY/X1Ekbx46X84p+XnSfS3OtvRS9fwnaoQc23
	Pa2RIp8SdBaBRf9oqPotjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777518587; x=1777604987; bh=I
	PvhYgSpY2OYytpoQzuPZwD9BYsKRv/q4WdeXo/yL6E=; b=E4Hakb2iISaU+sNW+
	7BB5nZgPMwDJEiz3KMmIr9tFTv0Otp+zE5RmRb9pIqJB2GgPPLhpNgesv2VHMBpS
	fWL+lbuTes5SV1Ooo7+B3fguxl50sMyK+OdJchcR4FUEZxn1sSE7phpLy5rDLYCf
	VE9xqDscO04eHjBG8SqBTFvWm82Bt6o2udIkpVkBgQ4Amo6fYRSZvWucY1YbLTZI
	4hjOh5l7PdjyRqWlRIdSj5JiuT5rmI7meIIEjhEKN882gk45wLE7XZU7yiA5X7/R
	UgFQMG+dJmrwDIQ3IR4Wwxw3SPlayaHofW5p5D6xt2pngQHL+B0RKjjL+oxclirw
	cafeg==
X-ME-Sender: <xms:-8fyaWrmxdSoGvXhjCywCxqMGPbnBV3m21aAJJi5Um9saiaMZerpEQ>
    <xme:-8fyaXM3su3S4frEgRCwI0P0mNfA301brawmttSbktowiSU44kNJ9V81GobWC374k
    Zf0b8L06dGDutim5IIOcTqck-y4qOrmFZzz-UmxGD6CtGIIKQ>
X-ME-Received: <xmr:-8fyae3C1LHMgt8Qb7iR8CZPcmgfg0fW07X9DZtZfBB5oRQVxIgYYTmGJ9rkjyQBtXXv1XjatQcko92hUflc_se1LWxhTNo>
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
X-ME-Proxy: <xmx:-8fyaWCiwCRdX3vIBkyj0Q8ITiFdXE0kaojKIv8QpKb0ZGc_U-KT7w>
    <xmx:-8fyabKS5ynGex_PsvGmpdESTYWiHxD-s5mQ9MNjLNQO_KHWUCLrpQ>
    <xmx:-8fyafkXH4-jkl8CKAj6hgF8HYHwOLZlAO42G5nF6w0gA6Vms3zdug>
    <xmx:-8fyaUbnWbB6KaGpPpxTfCnfklhyvWPzaRWNJdo3AvCNcG1Oceo1vg>
    <xmx:-8fyaTwycULdyN1Fdrz2tlOpVNzxCFmTW9zGp78S8YLVOglbyu5wooJn>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:09:44 -0400 (EDT)
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
Date: Thu, 30 Apr 2026 11:57:00 +1000
Message-ID: <20260430020137.3305302-8-neilb@ownmail.net>
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
 fs/dcache.c            | 18 +++++++++++++++++-
 fs/ntfs/namei.c        |  2 +-
 fs/xfs/xfs_iops.c      |  2 +-
 include/linux/dcache.h |  3 ++-
 4 files changed, 21 insertions(+), 4 deletions(-)

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

