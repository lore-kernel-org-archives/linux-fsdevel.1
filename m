Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC503BD62E
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788493230; cv=none; b=GvumJqIqi+VQ3KQDGndS+an7wTCKO+Xmtt/8Q2mParHPsL7TR0KFv/BYpGesgFUMQvLPYNK6SqP6155nachhhFk5EstnrPKyqzCEbNNJEcyzp2juqXjpIpdoL4UvhSBYL4VH8O3oWy2bwZFJWjSVcHPysjRfEvdW9q39KhUU4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788493230; c=relaxed/simple;
	bh=Qcbn1Dc3aezToHJMlhouCpKpK/OB6S/dvn6AN0De3U0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=D+RKBkRuLuYVVIvK1LgwSUcUyF9j21YdbxckgCSidWZHCN+jFDJk7IOZXG4Usux16kSELQuh2dp4J+LATY1dHGVLAChdrpXLVYmamKwL4Dcvizx/BnbwzNF5oVS0MHmgFjT7ohqA9Z+3hWMLe44AMlBecOICwAK71Fi2Wj+Huvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=jYh4JFdr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uRPh0xTI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="jYh4JFdr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uRPh0xTI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EAC76EC017A;
	Thu,  3 Sep 2026 23:40:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 23:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1788493226; x=1788579626; bh=IK07Y/u1GKQuIzLV5UM5mfWcLOjSwmNm0Om
	/8XKWp8k=; b=jYh4JFdrduxuizj0p+Lf0T5Ff+TkUkvB9imA/JQfKlrx+59p9Du
	EqDSJjC2/khph6Q5oiTO/QVVYAtvbpeizEHvEEuoL9kGVDT0MOLFBeq6ds0kwX3B
	ohmx2NRV9pLsCK1QuC/UsRruc/YJTMH5tDFvV1z+NzDW65nZixiQvAF6EgmGpKR4
	TuAQJzCQ58Jz8tA4EsXWACd7Gq5M46FTWAitjlmEuRIe0DJnAjLByn96LAE4DQ8+
	LU2he1Fztfh9oOAeBAHrzrz9qFv1Mjr9G+PHFDKT1daViX2FIUppPYCjoskrnGHV
	nbg2HYnXPXhrNpwBz/9q/n9CXjsS8OYYDZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788493226; x=
	1788579626; bh=IK07Y/u1GKQuIzLV5UM5mfWcLOjSwmNm0Om/8XKWp8k=; b=u
	RPh0xTILmAiV4iH2TI7aJUiJ78QCyHNSv0h0dsklk8SYa7+eCwVabfvLRnooMeh8
	jr6I8e6zozaEqRUT1ha2pavfx/NDBNVnSUWW6eQG5DcyanC+rwhpPCnpaztcDbjx
	D5aMLxnZPxAdZxFTLnCLHbuXzJkeYoTt4oMYzW1+Tjr90PfqUGy/YbdTkAfikH1j
	Mn8PvMbW916ChZDotcLgW7dSOHRn16ZY+PimfGLB4HdgKdkCBurCGdWat8eXyGBv
	IlRCOryBAU2zqadOC/OoE8XSjeblbnTZcuKQHqNxBMjNz7d8cBu7K9g4EJ7YqIiv
	5/uknbS0v5l1dasrQN2JQ==
X-ME-Sender: <xms:qj2aakDCVfaiC4_hqL-UIe80xaGUg0A0XNd8-JiLwF0lssN8FUVNnQ>
    <xme:qj2aagmVVtSyHlPO76-ErwGSZcdYQPgCAfa15AD5PJvtUF347Rz81Vkmz_3tbaXuC
    KOocLJXx0hdR9VJ5yvGNnnn4RaG_fDjwUTLdHLg2_G8ACuvGG8>
X-ME-Received: <xmr:qj2aanfm6dj91HsOCMvfK_G7yAjbzvi0lBSF3fVhQ7jXpOrsdXqNesG-ZxgxBfMTKqwbW76JphJxjgnQGaednVwwe5hJm84>
X-ME-Proxy-Cause: dmFkZTF7Gtlmat09jQ7eAquoH2QNkWCczJMnXbKul2ft85bMcmiBuqh4VC6G3HVRXoD7Y4
    IyO+KGem5WYhkFjpUlD5ckQs6E1XrF6Krp78fxt86N9/xUjiJUG4672epXVYwuA4uffqhO
    +D1RRCAI35TLkUbQNov9SzObPfnd8xXiaBTVSdWPYLFgOBYmZWfMOAeg45B5tnkdJTovCy
    J2a8r47tQZzQtKCt5gchJ5uECm9rfK/tsMNe8vVpLWW4vIp+fr/hB4dxeyTMxH17OeFIej
    T252Fgm/EBiksdzKuDeU7Y8PKhqzQpFrQbFmDFxQewppvS5h/xQQks6cNYvzeKs8poP2lp
    /kpjj8eCaVTxhEq+Veq3w/gDX4AA9lr3Cvvxa468j7olsyHU+whepjgJ4e3x3uO6VpQrfI
    +qwSWOnitUx/+WiLdyQfDIZ2ipLCxK2ycKRkL2OUR5PqLUKRYaxMkkgX239ETUOl/IE3EQ
    74WSBvPT9271huHQmleYelMcSZ6ohgii+sfLG1Fz3LLNM1P+5mxVeRIbZk4vhRpW0HKGpP
    t9UozcyH4Lq0Za88+cFEK5pVibCv4Yazwe73gqPbk9+CQxxyI5Jwk9e3sXSR5ym0pWeukJ
    wkfffbG0LaxQjrRZfPzFwT4s5SBVB5duEAe7UFKO6n3DiWzZbrxsZDGCHESg
X-ME-Proxy: <xmx:qj2aasQFw7aqN94BtU_Eut7vxkBUc9vXWy6C_rmiOKPKImF6z5lbAw>
    <xmx:qj2aamtKdORxyVF0ugOsGtSRtbGhGBXLb1qUNVJSmNBr_DCrZ1R7tA>
    <xmx:qj2aalfv7Jm11w9cqmSTt2Vguz6Ey2uLqDCe5dbB-39CKJzLxyEk-Q>
    <xmx:qj2aaoagXKdEQ3u7Y_kcqscDBApN7gY12b_i-mLka2qdt0uDF2NcgA>
    <xmx:qj2aagUn0a1a1mJYYynrQnukM2_TwVVP5hVDMAAfTSDEEM_7yXMNAee_>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 23:40:24 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>
Subject:
 Re: [PATCH v3 6/6] VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP lock.
In-reply-to: <20260903032431.142777-7-neilb@ownmail.net>
References: <20260903032431.142777-1-neilb@ownmail.net>
  <20260903032431.142777-7-neilb@ownmail.net>
Date: Fri, 04 Sep 2026 13:40:19 +1000
Message-id: <178849321924.207413.10355742855271220022@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 03 Sep 2026, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>=20
> DCACHE_PAR_LOOKUP acts like a lock in that threads can block waiting for
> it to clear.  As we plan to make changes to lock order for this lock,
> teach lockdep to monitor it so as to help detect bugs early.
>=20
> As NFS allocates an in-lookup dentry to unlink a silly-renamed file, and
> completes the lookup in a different thread, we need interfaces to
> release and the acquire ownership of the lock.  This avoids lockdep
> complaining that a lock is still held on return to user-space.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/dcache.c            | 14 ++++++++++++++
>  fs/nfs/unlink.c        |  3 +++
>  include/linux/dcache.h | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
>=20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index cbd5738de168..3af8b2ac699f 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1901,6 +1901,7 @@ EXPORT_SYMBOL(d_invalidate);
>  =20
>  static struct dentry *__d_alloc(struct super_block *sb, const struct qstr =
*name)
>  {
> +	static struct lock_class_key __lookup_key;
>  	struct dentry *dentry;
>  	char *dname;
>  	int err;
> @@ -1958,6 +1959,8 @@ static struct dentry *__d_alloc(struct super_block *s=
b, const struct qstr *name)
>  	dentry->waiters =3D NULL;
>  	INIT_HLIST_NODE(&dentry->d_sib);
> =20
> +	lockdep_init_map(&dentry->lookup_map, "DCACHE_PAR_LOOKUP", &__lookup_key,=
 0);
> +
>  	if (dentry->d_op && dentry->d_op->d_init) {
>  		err =3D dentry->d_op->d_init(dentry);
>  		if (err) {
> @@ -2037,6 +2040,7 @@ struct dentry *d_duplicate(struct dentry *dentry)
>  		return ERR_PTR(-ENOMEM);
> =20
>  	new->d_flags |=3D DCACHE_PAR_LOOKUP;
> +	lock_map_acquire_try(&new->lookup_map);
>  	spin_lock(&parent->d_lock);
>  	new->d_parent =3D dget_dlock(parent);
>  	hlist_add_head(&new->d_sib, &parent->d_children);
> @@ -2801,6 +2805,14 @@ static inline void end_dir_add(struct inode *dir, un=
signed int n)
>  static void d_wait_lookup(struct dentry *dentry)
>  {
>  	if (likely(d_in_lookup(dentry))) {
> +		/*
> +		 * Tell lockdep we will wait for the lookup lock, after
> +		 * dropping ->d_lock, but won't actually take it.
> +		 */
> +		spin_release(&dentry->d_lock.dep_map, 0);
> +		lock_map_sync(&dentry->lookup_map);

Unfortunately that does compile when lockdep isn't enabled.
I guess I'll resend the series.

NeilBrown


> +		spin_acquire(&dentry->d_lock.dep_map, 0, 1, _THIS_IP_);
> +
>  		dentry->d_flags |=3D DCACHE_LOOKUP_WAITERS;
>  		wait_var_event_spinlock(&dentry->d_flags,
>  					!d_in_lookup(dentry),
> @@ -2923,6 +2935,7 @@ struct dentry *__d_alloc_parallel(struct dentry *pare=
nt,
>  	}
>  	hlist_bl_add_head(&new->d_in_lookup_hash, b);
>  	hlist_bl_unlock(b);
> +	lock_map_acquire_try(&new->lookup_map);
>  	return new;
>  mismatch:
>  	spin_unlock(&dentry->d_lock);
> @@ -3021,6 +3034,7 @@ static void __d_lookup_unhash(struct dentry *dentry)
>  	b =3D in_lookup_hash(dentry->d_parent, dentry->d_name.hash);
>  	hlist_bl_lock(b);
>  	dentry->d_flags &=3D ~DCACHE_PAR_LOOKUP;
> +	lock_map_release(&dentry->lookup_map);
>  	__hlist_bl_del(&dentry->d_in_lookup_hash);
>  	hlist_bl_unlock(b);
>  	dentry->waiters =3D NULL;
> diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
> index b57cfaa4d516..c8d712204e64 100644
> --- a/fs/nfs/unlink.c
> +++ b/fs/nfs/unlink.c
> @@ -67,6 +67,7 @@ static void nfs_async_unlink_release(void *calldata)
>  	struct super_block *sb =3D dentry->d_sb;
> =20
>  	up_read_non_owner(&NFS_I(d_inode(dentry->d_parent))->rmdir_sem);
> +	d_lookup_acquire(dentry);
>  	d_lookup_done(dentry);
>  	nfs_free_unlinkdata(data);
>  	dput(dentry);
> @@ -159,6 +160,8 @@ static int nfs_call_unlink(struct dentry *dentry, struc=
t inode *inode, struct nf
>  		return ret;
>  	}
>  	data->dentry =3D alias;
> +	d_lookup_release(alias);
> +
>  	nfs_do_call_unlink(inode, data);
>  	return 1;
>  }
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 2b7d99ec9306..e7e3ef05313b 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -116,6 +116,8 @@ struct dentry {
>  					 * possible!
>  					 */
> =20
> +	/* lockdep tracking of DCACHE_PAR_LOOKUP locks */
> +	struct lockdep_map		lookup_map;
>  	struct list_head d_lru;		/* LRU list */
>  	struct hlist_node d_sib;	/* child of parent list */
>  	struct hlist_head d_children;	/* our children */
> @@ -554,6 +556,36 @@ static inline int simple_positive(const struct dentry =
*dentry)
> =20
>  unsigned long vfs_pressure_ratio(unsigned long val);
> =20
> +/**
> + * d_lookup_release - release ownership of DCACHE_PAR_LOOKUP lock
> + * @dentry: dentry that is locked
> + *
> + * If an in-lookup dentry is to be passed to another thread which
> + * will drop the in-lookup lock, then d_lookup_release() must be called
> + * to tell lockdep that this thread no lock holds the lock.  The
> + * thread that receives the lock must call d_lookup_acquire() to
> + * acquire the lock.
> + */
> +static inline void d_lookup_release(struct dentry *dentry)
> +{
> +	if (d_in_lookup(dentry))
> +		lock_map_release(&dentry->lookup_map);
> +}
> +
> +/**
> + * d_lookup_acquire - acquire ownership of DCACHE_PAR_LOOKUP lock
> + * @dentry: dentry that is locked
> + *
> + * If an in-lookup dentry was passed to this thread, the
> + * d_lookup_acquire() must be called to tell lockdep that this
> + * thread now owns the DCACHE_PAR_LOOKUP lock.
> + */
> +static inline void d_lookup_acquire(struct dentry *dentry)
> +{
> +	if (d_in_lookup(dentry))
> +		lock_map_acquire_try(&dentry->lookup_map);
> +}
> +
>  /**
>   * d_inode - Get the actual inode of this dentry
>   * @dentry: The dentry to query
> --=20
> 2.50.0.107.gf914562f5916.dirty
>=20
>=20
>=20

