Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEED346AC3;
	Thu, 30 Apr 2026 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540106; cv=none; b=G8IfJsR0i3yKaWE7nMEFUjWciALYP25wNi1UJ1Jc78tYHXE7M6oJHxKqzY5nR3FDJhzJWBkGzi6duLSTdwjj56fZvWXMdTgeRfErTs334rA6sM43ejDRbf0ksKPB6MrdPp3k1hVtBcPHYYcqolxiYpezKJhlt/EwbIrwyH/NJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540106; c=relaxed/simple;
	bh=G0MCod4Tgu9iNrOch73gYeC0lR1uGaR1LNNjEfG50is=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bBg7hEd0bLEY2FM3Bi5a1une8idkvxll6mfLTWfAOLCO/Hy7KJS8JZK1wziUMA7pEhJ7fbn7gsebORqsD47VIfEvHdyxEcOzqMh3ypHZ6TkpkdGVEtPhgFaimc6qAaw16LJi3+Vi3kD7YyXeM8K9TXAUB0spAS8nZwybSw434+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=rQa60gO9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fe6rNzlT; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="rQa60gO9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fe6rNzlT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5E081400055;
	Thu, 30 Apr 2026 05:08:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Apr 2026 05:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777540102; x=1777626502; bh=1SbACwhD71UM2dRTZJL0I1wPlgbR9SVx7Rh
	gEhBWkis=; b=rQa60gO994jj5xpG/RKK+fuGrfcz3UfK89xo2V10VC0T4LPxVTo
	DZ/cQJGNWBGn5BrqcHTDbDdV1v+Zx9XnQOI0pVtuNeht5YEH241y3ZNzzRxjcITJ
	faZXY7FzRTPwh+K2YljJl2YdhR1eYn2xPrL+Lc2mhtsB/OWTaMQ3ZhP3YNuCQH8r
	pOCga2jFbxpWG9/gfEQe7WmYdo5OTOfhLuAMdK0A76WnJ0hxVYJ/7UHMypLhs7h8
	f2b2UsaUExYWYzNRQzhUkoFRzKxG7SCuaTQYkPfa0Kepm5akkiCielt7qm51jyfY
	Tubl0UJ8nWMoGS4rMhYqWDZYaHlrbTojPmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777540102; x=
	1777626502; bh=1SbACwhD71UM2dRTZJL0I1wPlgbR9SVx7RhgEhBWkis=; b=f
	e6rNzlTImfZSkpw5iyeppTtHBZ+QfRrJExgwzqTux42mVIHi2jVNLyy8MPkkSsMS
	KoJoDqkZSHO4egUmqtrfBWvIh36vY/iQtViuNXq+6Uepe6Behrj02moCfZtJ2gEm
	XWT57qETqM5AVOvOVwASCxp1C/YTMUUM2uTCc9TmZXIOwkz/GQlZ54X3cRv2aW9o
	IDr1ykZPXyCr2gtUit5Rpr09+ySH1PCNgwE6eLpZwW8o+4iho+VCRbPpU+tl2eCT
	TzcYmssQiWwEiPmsa2pMP8cOgSaYpGHt2qojajbkkAsxMheoTWqcwLD26jN7Peln
	BQlpKIM7VJGSc9vgXfMjg==
X-ME-Sender: <xms:BhzzaasOyu0k5wHECYAISJ4kchabWjGk1DPxUO5_CyXXzQ1E_j8EYQ>
    <xme:BhzzaSDBjco9yj3VcvyrOjy8VxRQsLmcjfRGCiscuRVYz20X-y4EuGQUhbMgzYYT6
    ndvQUQ5CJ-RlB2bQW-E3AmRfMHIRTqLyR7Kr6lGudIjTLGR_Q>
X-ME-Received: <xmr:BhzzaZbPe-p3AKGENTppwCRWTEuqNsBpqBp9lIBg8HyKpYkB1KL7MoSdGKq3MpXfhAdUMjj37AvmCRBu9AlVQZugG_qy3uc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekieelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:BhzzaVXcDJMB20JRuJbiN5RkjF0Cs-rR1CAAjegNOFECsnmxiYmo9w>
    <xmx:BhzzaQNeSoAdf1VWdMDWEIWeMJFfdzp4hkEVI9la2TWPnz30vu_QPw>
    <xmx:BhzzaXZvhsY8Kr6BIUa7prvT71NtjFtUEKHOO6hNYCSAyfyBjU6yDQ>
    <xmx:BhzzaX91MC1OoELKnNMg24f0qzLbpvL3YKkYBPEu2vDP6qcQUi31Iw>
    <xmx:Bhzzaf3gvlT8c1o9HidrIWid7vbDDc_9MmGFAevUhPdug0inxlKwLoqz>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 05:08:19 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7]] VFS: Prepare to lift lookup out of exclusive lock
 for directory ops
In-reply-to: <8cbb48535002d2a1a0f4e5154d0b499ba8934ce9.camel@kernel.org>
References: <20260430020505.3308841-1-neilb@ownmail.net>
  <8cbb48535002d2a1a0f4e5154d0b499ba8934ce9.camel@kernel.org>
Date: Thu, 30 Apr 2026 19:08:17 +1000
Message-id: <177754009715.1474915.14735586603792110597@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 30 Apr 2026, Jeff Layton wrote:
> On Thu, 2026-04-30 at 12:03 +1000, NeilBrown wrote:
> > Following are 7 VFS patches which modify or introduce APIs that will
> > allow modifying filesystems so that they will work with a proposed
> > change to move d_alloc_paralle() out from the parent i_rw_sem lock.
> >=20
> > If these can land in a non-rebasing tree, I can work with individual
> > filesystem maintainers to start using these APIs.
> >=20
> > I haven't included d_alloc_noblock_return() as it is only needed for one
> > fs (ovl) and it is not yet clear that it is the best approach.
> >=20
> > I also haven't included the change to d_alloc_name() as that is only
> > needed so that I can deprecate d_alloc() and there is no rush for that.
> >=20
> > Patch 2/7 is exactly the patch Al proposed in the conversation for v3.
> > I have taken the libery of adding a Signed-off-by from Al to match the
> > Co-developed-by.  I hope that was not inappropriate.
> >=20
> > I have been testing this series over NFS mounts from XFS so patches 2
> > and 3 don't seem to be causing any problems.  The changes in 4/5/6/7
> > won't be tested by this, and some cannot be tested until filesystems
> > start using new interfaces.
> >=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> >  [PATCH v4 1/7] VFS: fix various typos in documentation for
> >  [PATCH v4 2/7] VFS: use wait_var_event for waiting in
> >  [PATCH v4 3/7] VFS: enhance d_splice_alias() to handle in-lookup
> >  [PATCH v4 4/7] VFS: introduce d_alloc_noblock()
> >  [PATCH v4 5/7] VFS: add d_duplicate()
> >  [PATCH v4 6/7] VFS: Add LOOKUP_SHARED flag.
> >  [PATCH v4 7/7] VFS/xfs/ntfs: drop parent lock across
>=20
> I pointed Claude at the version of this in your tree and it spotted a
> regression that I think looks legitimate:
>=20
>   2. Lock imbalance on early return: The parent lock is dropped uncondition=
ally before             =20
>   d_alloc_parallel()/d_alloc(), but three early return paths exit without r=
eacquiring it:          =20
>     - IS_ERR(found) from d_alloc_parallel()                                =
                        =20
>     - !d_in_lookup(found) from d_alloc_parallel()                          =
                        =20
>     - !found from d_alloc()                                                =
                        =20
>                                                                            =
                        =20
>   The callers (lookup_slow(), lookup_slow_killable()) unconditionally call =
inode_unlock_shared()
>   after ->lookup() returns. If d_add_ci() returns without the lock held, th=
e caller unlocks an     =20
>   unheld rwsem =E2=80=94 corrupting its state.                             =
               =20

Thanks for that - yes that was careless.

The unlock/relock is only needed around d_alloc_parallel() so I've put
it there which make the problem go away.

I've updated the github repp.

New patch below.

Thanks,
NeilBrown

From: NeilBrown <neil@brown.name>
Subject: [PATCH] VFS/xfs/ntfs: drop parent lock across d_alloc_parallel() in
 d_add_ci()

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
 fs/dcache.c                           | 21 +++++++++++++++++++--
 fs/ntfs/namei.c                       |  2 +-
 fs/xfs/xfs_iops.c                     |  2 +-
 include/linux/dcache.h                |  3 ++-
 5 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystem=
s/porting.rst
index 5cc6ae19845c..146720fc9f6f 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1391,3 +1391,10 @@ either form of manual loop.
 **mandatory**
=20
 d_alloc_parallel() no longer requires a waitqueue_head.
+
+---
+
+**mandatory**
+
+d_add_ci() must now be passed the flags arguemnt that was given to ->lookup
+
diff --git a/fs/dcache.c b/fs/dcache.c
index 1943607f7547..665ce74eaadc 100644
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
=20
@@ -2301,7 +2302,23 @@ struct dentry *d_add_ci(struct dentry *dentry, struct =
inode *inode,
 		return found;
 	}
 	if (d_in_lookup(dentry)) {
+		/*
+		 * We are holding parent lock and so don't want to wait
+		 * for a d_in_lookup() dentry.  We can safely drop the
+		 * parent lock and reclaim it as we have exclusive
+		 * access to dentry as it is d_in_lookup() (so
+		 * ->d_parent is stable) and we are near the end
+		 * ->lookup() and will shortly drop the lock anyway.
+		 */
+		if (lookup_flags & LOOKUP_SHARED)
+			inode_unlock_shared(d_inode(dentry->d_parent));
+		else
+			inode_unlock(d_inode(dentry->d_parent));
 		found =3D d_alloc_parallel(dentry->d_parent, name);
+		if (lookup_flags & LOOKUP_SHARED)
+			inode_lock_shared(d_inode(dentry->d_parent));
+		else
+			inode_lock_nested(d_inode(dentry->d_parent), I_MUTEX_PARENT);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
 			iput(inode);
 			return found;
@@ -2311,7 +2328,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct i=
node *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		}=20
+		}
 	}
 	res =3D d_splice_alias(inode, found);
 	if (res) {
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 10894de519c3..e2f3430c2e6d 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -310,7 +310,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, =
struct dentry *dent,
 		}
 		nls_name.hash =3D full_name_hash(dent, nls_name.name, nls_name.len);
=20
-		dent =3D d_add_ci(dent, dent_inode, &nls_name);
+		dent =3D d_add_ci(dent, dent_inode, &nls_name, flags);
 		kfree(nls_name.name);
 		return dent;
=20
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 325c2200c501..db0beb3831a9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -369,7 +369,7 @@ xfs_vn_ci_lookup(
 	/* else case-insensitive match... */
 	dname.name =3D ci_name.name;
 	dname.len =3D ci_name.len;
-	dentry =3D d_add_ci(dentry, VFS_I(ip), &dname);
+	dentry =3D d_add_ci(dentry, VFS_I(ip), &dname, flags);
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
-extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr=
 *);
+extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr=
 *,
+				unsigned int);
 extern bool d_same_name(const struct dentry *dentry, const struct dentry *pa=
rent,
 			const struct qstr *name);
 extern struct dentry *d_find_any_alias(struct inode *inode);
--=20
2.50.0.107.gf914562f5916.dirty

