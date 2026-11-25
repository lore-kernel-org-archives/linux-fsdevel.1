Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578419;
	b=N92WAiV8NyGYj5M0OIC7zR1yTuLcY2EFi4RVhHjzJmjVjSR+8XIRxdgJJmcl8WVyP+x+
	 Dp+6OcRrpaEANCjiAuHGu4CFQW53K5ozmDDtwL+vhXgs1jhpI1/f9Qs0gZDL3XYIjg/8F
	 hkcfDK5dyXkBZJ8q5BasYbGW7W+Zq6SUDH/ADGmg7afCnv202eF6HRPsK7N9ADjTdUAnH
	 uiO2Df6lX8AnJcpe4g1rW2oGmmr1kXvFWj4kFrdshsgfF3iT03M8idrUUhz/TD0PHGcbO
	 YBZnM9bYwlZhBM6qazynMiNeEeJP39k04anxLLg8EJNzcAgYZIAmIfHs/rmCk+h7Naw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578419;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=ZJj42sbdWeB/wLiTmyNjdZ8BVwwPFHh83C2++A0reDg=;
	b=ZPUUzhIKOkLJqmoHSS56LEj1RMjc0fOpDL90akJg9EGP3WGH/FziUNZ/Uo1edQtNLu4Y
	 dBM8FK15me/lDNKOVfT556kAZEBINejrARaAFEQjLvvmEYgcRntOXsG9tY0A0Ehxhmka9
	 9/0U7wyNimnRlBbN0pWzt9muo5vMLZnuSEY3SaG6WUf4zsSG9H7kEm3OkbD7NYIVCMQ/U
	 XYh9gRBr7TF88QY/P4czgx/xK9tpCBNZtFdJSQyLbJ15ywBgSv43ZZ/Ih9LorYbpOP9ND
	 7sR6WgHCN6qxzcun8WQSvFT13vyJgDXqxnJNR02R4Xq/1DQg1l1H53qIfRwlK3DXnnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=UXS7+lxA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ms9lWP08;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54302606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54302606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=UXS7+lxA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ms9lWP08
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91E451400366
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:46:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 24 Nov 2026 22:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578417;
	 x=1795664817; bh=ZJj42sbdWeB/wLiTmyNjdZ8BVwwPFHh83C2++A0reDg=; b=
	UXS7+lxA2gWzpwnXWJ/0DUPdLAmseAlhdb1N4fEFA0AzBjqGVjW6w960RQwEk4dt
	SaoSyfNlrLjcT1bqWukMtSSOIKyVfybXCZl9HY9w+c4jy2oLMUE9ltJkYR3WnBb1
	hipcMd2qL76w5eWPkAXmz0RgxGTOKMR3I4AgOD4oViagTDGwJ9+3Cu+NfKaiU4I9
	LUQCyroOmK8N26fsoJql/bfzJ/gXS4Uf3/EMGIb4fmYP2a4Hh7GFrV5Qw9YfHhnB
	7xzsRei4AnHVywy1oqZFp2ZebkmJZm++n0rd1Uw2/ZiWbdARuik3IyNSwF7uagq/
	IrD+U+qBi/YhZNX0jAlXvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578417; x=1795664817; bh=Z
	Jj42sbdWeB/wLiTmyNjdZ8BVwwPFHh83C2++A0reDg=; b=Ms9lWP08MTQLfhK9I
	Qn8mYgol/GVVMj8AZ1ViRbJnK2HnL/lN5WwDUsHB0ZzG4j8BRR33EILL6JCzBL+p
	zzsMIzPoCBzVdhR8O3r8bArMALljb2nrq+Tb2Xr5tFcbuFNReYFbKIh0DM60MukH
	YXpNazz4FD4oD3Vc+scCN0C1uA67v1UZOpGi1w+VpD5mJexhfQvgZUZQ4/2JC9zY
	jQtiWDYJf7xvUgb3RRR7P73Z2vpVZU5aVcrq1hHmcNR9ZEaEHveT7NIol8Z0yf/I
	KGJj4rvF3FuvP/0U9u4IMo9fubVaYfR+4EEq2+a6lpS7zgTmkbld5Kziw1nfuo/d
	0uHxw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578417; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:tzF0WehzkN8Y2AbKb8WgCYvtJWB7eUWr2tWRs16P0uOGMDk
	VBk0KDO4esqOpwmBP6RmAGonlBRuwrU/nH8cCHgtJMufneDxBoAc+BKhuN9RORJl
	VAjO3GbV9i7qBXjqHZtO2g8jBpD7yRt0wvkjF1UY5KwhIuMEnGaxMV1lnTDrw8UT
	JXZNpuZR/Q3duqdA656JEYNBPGWzuDuEmzOMCHxEqMQq4ugcamA+KCzL9G53jJmw
	wJVdM3DkZnmRWPZYiUC/YsOiwquR/SlfQwLJjHGaQ9X01As076fVP9cAl1TucFNZ
	AdRB1XsMpXi3dOlmaIMREim6yehKFfDaoibycAw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:20zyX+aJVxI6AdffA4cfGs+HiNU58mrbjTUKFbNNm2E=:GXqxxZ4nCPcItWLOjAOkRMljcoG+dv30mbjjfSpSE9k=;
X-ME-Sender: <xms:MVoGa9UT3ReJzgDm5mJCOWmgwj2XS1DwMjv6wScah8A4RNa7NuTkkQ>
    <xme:MVoGa0gtMtwQcyIZzskWsstVyR8Z9lNfmKrMguUzhgHM52bZF3VKAEs9OB-EBmYai
    aFS81Odg-LVZaioewKRZHbqnPnOtcWiOydpxcNz7oJVh1p9cg4>
X-ME-Received: <xmr:MVoGa-dJW7bs-11limHQgtdWvM0GDZiC0G5w1swfm8UWxKx37nuJ9M694ZaIyC2LI8gfADQzL_PsVoibTbk2RTbCj3NE2uo>
X-ME-Proxy-Cause: dmFkZTFR427OSMpMhBUq2c/PRD6RmqRpXHsHavEQEoZib45veoj0ON4Fee0fFpAMf6IRZD
    7ioshD0AaEWr7quPZ3VJk4MkgPxfK4VajmEfAasmF1N4QuQ1Nx4fAT27aU1zZmPYaReDqx
    rfP5UHReFgze/pUM1YUaeJAgJLGWSi2iJU/qcqRk+B4M1TsPMqQDofdX/Jn7SjcVJvCtNm
    zdB65WAuETFQQDYBDZIOHXvboBphMIm2vyy1TKs+e7zZqPSqTzzCVyEWo2arAfhj68hGFx
    kBzHUYnaQIV/eTYhsd/MgvSt0+AvaXUSwYNCdWWq7bBlwHpxfTlmsOfayzrTTRF9w5P7PC
    SeV47q2FuIOfIZMVMhjQJ/dV/n+UX7M13OfpguGdXETZW7FLzQD+0u8vOwdyWIeG/Rqfjj
    ldiwC3mEq+O4w6xJoCtCeoRdzm+TdpYlWciZU3Zr/spSi9hCkb2asl/hDkxdr/iBGpaEVc
    Wgjnk7v4NkGAHlXWLVLtVocs6pAuXej1OcPShJyoiefm39JjmByC7698NkQXBXMiK2UQBS
    b4VQwlpkDfgY4xj3/1Iu6AX+P4PEPegy0xCfQZo19Lh7HHwW3ATKqVwoxYXEs2EdjHUKNe
    BToL94ArJdkyJ35bnFMG0/y9neOegnqPekF7/+9nsevG0ndRJcVZ1HC4j9Uw
X-ME-Proxy: <xmx:MVoGa3c57kDACDFsxCkBg-qlZlZt_91HC9yabde746SqbBhsQsn3Ng>
    <xmx:MVoGayVWIvPmv-mcbj9goU5U7ww_0gj9iKrOhk5h4zN3894or7pH_w>
    <xmx:MVoGazfD8VsFGaOqfFkVzQG-xJYpixl1vVKq90dZ_orFPEE_IwKmJA>
    <xmx:MVoGa-_QUzdS0ek1aNZ4XXiw6p_2N3eJF5CG0dH6aBwsAN7v5WuGUQ>
    <xmx:MVoGayDbV5vJzu94SozIPPVYMOQQIzeqf0IYhjiRr_MCXHpvYz71KVXJ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:46:52 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-afs@lists.infradead.org
Subject: [PATCH v3 08/11] VFS: use d_alloc_parallel() in lookup_one_qstr_excl().
Date: Wed, 25 Nov 2026 14:16:46 +1100
Message-ID: <20261125034543.4084039-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
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

lookup_one_qstr_excl() is used for lookups prior to directory
modifications (other than open(O_CREATE)), whether create, remove,
or rename.

A future patch will lift lookup out of the i_rwsem lock that protects
the directory during these operations (only taking a shared lock if the
target name is not yet in the dcache).

To prepare for this change and particularly to allow lookup to
always be done outside the parent i_rwsem, change lookup_one_qstr_excl()
to use d_alloc_parallel().

For the target of create and rename some filesystems skip the
preliminary lookup and combine it with the main operation.  This is only
safe if the operation has exclusive access to the dentry.  Currently
this is guaranteed by an exclusive lock on the directory.
d_alloc_parallel() provides alternate exclusive access (in the case
where the name isn't in the dcache and ->lookup will be called).

As a result of this change, ->lookup is now only ever called with a
d_in_lookup() dentry.  Consequently we can remove the d_in_lookup()
check from d_add_ci() which is only used in ->lookup.

The caller must now ensure d_lookup_done() is called at an appropriate
time, and must not assume that it can test for positive or negative
dentries without confirming that the dentry is no longer d_in_lookup() -
unless it is filesystem code acting on itself and *knows* that
->lookup() always completes the lookup (currently true for all
filesystems other than NFS).  This is all handled in start_creating()
and end_dirop() and friends.
At present only LOOKUP_EXCL and LOOKUP_RENAME_TARGET might result in
an in-lookup dentry after a successful ->lookup, but that might change.

Note that as lookup_one_qstr_excl() is called with an exclusive lock on
the directory, d_alloc_parallel() cannot race with another thread and
cannot return a non-in-lookup dentry.  However that is expected to
change so that case is handled with this patch.

As mentioned, with this change it is safe for d_alloc_parallel() to be
called without holding ->i_rwsem on the parent.  This holds providing
that any filesystem which uses d_alloc() or d_alloc_name() and then
instantiates the dentry, only does so in a context where ->lookup cannot
instantiate a (positive) dentry with the same name without relying
on ->i_rwsem.
This is already the case. e.g.
 - some filesystem use simple_lookup which only instantiates negative
   dentry.  A race with d_alloc() will mean the negative entry added with
   simple_lookup() will be later in the hash chain and so never found.
 - some filesystems only use d_alloc() during fs creation, before
   ->lookup is possible.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 14 ++++++++++
 fs/dcache.c                           | 16 +++---------
 fs/namei.c                            | 37 +++++++++++++++++++--------
 3 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index e41466904501..78df8842bddb 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1422,3 +1422,17 @@ helpers take a ``const struct mnt_idmap *``. mnt_idmap() and file_mnt_idmap()
 return one. The idmapping is immutable so nothing should have modified it
 anyway. References are taken and dropped via mnt_idmap_get() and
 mnt_idmap_put() as before, both accept a const pointer.
+
+---
+
+**mandatory**
+
+All start_creating and start_renaming functions may return a
+d_in_lookup() dentry.  end_dirop() calls the necessary d_lookup_done().
+If the caller *knows* which filesystem is being used, it may know that
+this is not possible.  Otherwise it must be careful testing if the
+dentry is positive or negative as the lookup may not have been performed
+yet.
+
+inode_operations.lookup() is now only ever called with a d_in_lookup()
+dentry.
diff --git a/fs/dcache.c b/fs/dcache.c
index ba17f49f8a63..2ad39c1515b7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2472,18 +2472,10 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		iput(inode);
 		return found;
 	}
-	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name);
-		if (IS_ERR(found) || !d_in_lookup(found)) {
-			iput(inode);
-			return found;
-		}
-	} else {
-		found = d_alloc(dentry->d_parent, name);
-		if (!found) {
-			iput(inode);
-			return ERR_PTR(-ENOMEM);
-		} 
+	found = d_alloc_parallel(dentry->d_parent, name);
+	if (IS_ERR(found) || !d_in_lookup(found)) {
+		iput(inode);
+		return found;
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
diff --git a/fs/namei.c b/fs/namei.c
index 6d63a4c08495..cfd37044a516 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1785,13 +1785,13 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 }
 
 /*
- * Parent directory has inode locked exclusive.  This is one
- * and only case when ->lookup() gets called on non in-lookup
- * dentries - as the matter of fact, this only gets called
- * when directory is guaranteed to have no in-lookup children
- * at all.
- * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
- * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ * Parent directory has inode locked.
+ * d_lookup_done() must be called before the dentry is dput().
+ * If the dentry is not d_in_lookup():
+ *   Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
+ *   Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ * If it is d_in_lookup() then these conditions can only be checked by the
+ * file system when carrying out the intent (create or rename).
  */
 static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 					   struct dentry *base, unsigned int flags)
@@ -1809,14 +1809,24 @@ static struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	if (unlikely(IS_DEADDIR(dir)))
 		return ERR_PTR(-ENOENT);
 
-	dentry = d_alloc(base, name);
-	if (unlikely(!dentry))
-		return ERR_PTR(-ENOMEM);
+	dentry = d_alloc_parallel(base, name);
+	if (unlikely(IS_ERR(dentry)))
+		return dentry;
+	if (unlikely(!d_in_lookup(dentry)))
+		/* Raced with another thread which did the lookup */
+		goto found;
 
 	old = dir->i_op->lookup(dir, dentry, flags);
 	if (unlikely(old)) {
+		d_lookup_done(dentry);
 		dput(dentry);
 		dentry = old;
+	} else if (d_in_lookup(dentry)) {
+		/* We cannot check for errors resulting from LOOKUP_ flags.
+		 * The caller will have to wait for any create-etc attempt
+		 * to get relevant errors.
+		 */
+		return dentry;
 	}
 found:
 	if (IS_ERR(dentry))
@@ -2938,6 +2948,7 @@ static struct dentry *__start_dirop(struct dentry *parent, struct qstr *name,
  * The lookup is performed and necessary locks are taken so that, on success,
  * the returned dentry can be operated on safely.
  * The qstr must already have the hash value calculated.
+ * The dentry may be d_in_lookup().
  *
  * Returns: a locked dentry, or an error.
  *
@@ -2959,6 +2970,7 @@ void end_dirop(struct dentry *de)
 {
 	if (!IS_ERR(de)) {
 		inode_unlock(de->d_parent->d_inode);
+		d_lookup_done(de);
 		dput(de);
 	}
 }
@@ -3918,8 +3930,10 @@ __start_renaming(struct renamedata *rd, int lookup_flags,
 	return 0;
 
 out_dput_d2:
+	d_lookup_done(d2);
 	dput(d2);
 out_dput_d1:
+	d_lookup_done(d1);
 	dput(d1);
 out_unlock:
 	unlock_rename(rd->old_parent, rd->new_parent);
@@ -4014,6 +4028,7 @@ __start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 	return 0;
 
 out_dput_d2:
+	d_lookup_done(d2);
 	dput(d2);
 out_unlock:
 	unlock_rename(old_dentry->d_parent, rd->new_parent);
@@ -4123,6 +4138,8 @@ EXPORT_SYMBOL(start_renaming_two_dentries);
 
 void end_renaming(struct renamedata *rd)
 {
+	d_lookup_done(rd->old_dentry);
+	d_lookup_done(rd->new_dentry);
 	unlock_rename(rd->old_parent, rd->new_parent);
 	dput(rd->old_dentry);
 	dput(rd->new_dentry);
-- 
2.50.0.107.gf914562f5916.dirty

