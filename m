Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576457;
	b=IGi0+m5wP9jHOtk78nXwCw/n3pIpzx4DYppr+T0VALpD+QyQjGllhH0QKfF4wg5Sd0FB
	 Jx58bvJ010epvg0/F3sKvGL0PtumcArPj5XjmQfINSew5gOPZoVvuB1ygNzQea8vyWV5D
	 GrVCNbjPFWSw4KP5Tk4zi0vEQGVxN0mgmPpzDh5FUqhdhiVvtFW75pZ7Z+cumNjDiCAtu
	 ZGNNRbgig/sOjNBum/G25cvIug4ca3ATQS6tEWVxjBO2FFZf7LS0MzK54vcKqtEMtLMw9
	 W5EP/vzSgo0zNA2DqmZGweWwm1NWq297APmUFsJn1B0JJD0xTxHGFw7Q5GdbqilBC/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576457;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=cmXx/ctHfbYkt2QwLH08xQTdQ6Caojm2cQrRQkeH4ww=;
	b=xf/YjbBwffGebXJEQT/vfFcDRRu0MWeye3dSTehNU/pgRbVPw7Dz3BieTk4kAgTgqFh0
	 bzrNJCjabRPjZYyW5tyaeKZmplIbMPUiYMmeRPayYZyh1DjDluCo03K4Ey1pNzbjPdaOX
	 5wUwvHA3styPGVBE+7CzexJmqAw3mgdNRI8sU4H8IV3Yxd6fgiaXVO6pmdMvDoGX1O/L0
	 DLRzwJRC5iZAPu6DfyZmk727K0ePgkR9HSpQ2QJvYh0hcDhcEDGUu2UvibrArLXIieEJh
	 aRPR53+/mBSd4KWj/c2pE5m6s8rSrxL9ummB1++VLnw2B7QZD0gPSN5R56m6Mh8UOqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=JLjlRMA1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BlkvBYYF;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D4606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 09:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 634D4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=JLjlRMA1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BlkvBYYF
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C3D271D00138
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 05:54:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 05:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1792576455; x=1792662855; bh=cmXx/ctHfbYkt2QwLH08xQTdQ6Caojm2cQr
	RQkeH4ww=; b=JLjlRMA1pkwih4SXHnW+tTwUnxP4uk0k791/bto6PSAjIONBVYD
	Tr24YuA7IztEWMrtZmPCCeHAgkIwk7mihoeGPdI7tzioiWqf2+A6IzAP3RP83ptP
	oS4bNIkBgYcGFGhK8CLoO8Sb2o5yQGErKHvfQCvL1aXZw6YIqueQC/tXSqK5Gesf
	C821ohuNN3fX5TH96YOrWuA1GG6vWGrl23Ahkgwd/7nC9U6BWiCvApwUbJHon7Ry
	auX6Z4B+irDsPuFtCyaURmBei4ggiRrsGCQMVgGpXnWrfzWC5K/SxeIRGrIk7EGC
	/1hPyDQAxrfCBB2KMmUiosXOYSXCHh2SPSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792576455; x=
	1792662855; bh=cmXx/ctHfbYkt2QwLH08xQTdQ6Caojm2cQrRQkeH4ww=; b=B
	lkvBYYFB4rCYd7j64m8OLW5l187bT4uTuDr9wa4MOGRGPv4aHsvODqGdiLUlGUhR
	/YhAxT7NYkJptGX7f3yVb0OVY9iq24sCcsFt2gteqZou8Dnbis0sVZ1Va8dd2ep3
	zFvdQODGqa1Q9AOZvzAcYga5IwITwRsUCsh8i0gHG00M+Ew8s4KKhnPiNr+v4JGl
	WK2OB7a8m5Ohlola2KEfCcfrQbUvRkrsOSyyhzN77CrHSv2E2/sqUe5kT5ajMdpd
	tr0JyIrx7Xk85oXctPm+59Pmy/h6YrzFQH3mvw1ZadxTKUNMcwGKsQAtjR1uOViK
	JuPxdnAlw7XDKq9+hV9yw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792576455; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:Q2eDJ8mOt9bdHsyIRTaqpKTg5omHorxfOo4MbHqMRE7WE2q
	3liE5WcNQa37gT6sCaqM2xuqb3LKMZFQLXaqZ9XYN/YOWtvA1pe62l61aihFeU25
	+0NBGLpIiE/zRWTRpdFPioyiWhWQey6YzLJUnxABem8sVa1z+tdpbUUx1jthrktM
	kK7EI/uGuHKbRH3XTbP1v7LRtQqDW7m34nrmR3IRcxTJSldq2ELd8//EFcXdSkbL
	qq7fzsKFYXjDYsAZcbP7uyL6Op5gf5iAY22/BmLsDamonDT82TxDcz8VAcvPcQVJ
	82dOlha55cEkfIGWXh1o0Ve+NF2NTBJyh2PP4Sw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:Zih5R2LHKiaj5cNcBnr13ufV5bjaPCvrsriTEClLRr8=:xYbpUMxyePC8xopGvJsfiFuE22ZBwsjqFE9oOClULDg=;
X-ME-Sender: <xms:xovYaifG0JOZgUEJ6IpoAvaj4Ti5LjUL1ZGKep3AVu90_Q_bw_4VBg>
    <xme:xovYauxIkzJBZQXTTOjAT9blIAJrSZfhKzv6LBn8eRagAYvMc0yk5oThZU1QDcBII
    1QG7iZHTZb4FFCg8JIqXcGmy5dd57EfC5bkOJhOdST9TafUVbc>
X-ME-Received: <xmr:xovYanLp50Se9mS0_lQomZUW26DgWcPA6qY7VUeJAawYi3DplY-qmYm-1I3mVoOslBZLJceI6IX5Ia6OvBRgjtpQZEsMRMs>
X-ME-Proxy-Cause: dmFkZTESfkQU1bdoDkzPs4pZ2j6KqI5Dj52aNfFYat6FM7LYvrrav9XouHeqFe2TlMbpCR
    BNg6RoeoGaNa6q8XIergXxy0xAH4CV2+00tRlMaBiGBFt8XOVXcIL42Fg6v1FnYvOrqOqQ
    edtBFPG47j1mONoeFOSs7BHE/Q1KvqYRTjbViVd51222FRvkcSNArbNZyD6q0wXLNZqfP7
    yPvaxQE1TUcoWqWahZ5Ueg0elrbGZbgzwoo6x+AG8Lky2fUtvAfkfmRG0c9DX2/K5Wzblw
    QQ2gFj34NTxFW44kcXIQMYYHWrqupRbsxwaiDXNbb1xLdmMI0R93TluCWmbN0JPoUQbsG+
    k6AaToyCHRTPmXBYlaPtHpSVCqn/EDH226Sa22BuCy4rbNbfKffzMc/lUo60U2HiHHQQg6
    rBugaRDa+q42u8sdIhAQ7qJloWypfK0JCp/bh56g0xxE5iES8rn7+tPQeH8OXPp5LLBfvK
    T59aZCSuj5LWDsCFqF2/RE9QtKHyWVFUbxcJubtSADxalvFX65z5OzoLvs7SyVrtMXxphZ
    +koLrJ1BsIl3ottRQ1K2jRoc4dNFpdsKer5ZPkLZi2E4h0WTyLUb9LCG3uGmULRVAM0Bpw
    Cg6daMSceUr9/V3CQyxD38+Xs2G9+Pv8IiOoevFwG1OAATIwkaamhRv/CwtA
X-ME-Proxy: <xmx:xovYagGHH9He7HTXVoS66V6qhHoI0aNrlWLUtwdzm6aaUkdxqw1_Ow>
    <xmx:xovYaj-RIzLGVGsHfogA6Gjj3o9Gbiu5g-1qjqPzejvblEkTHcSsGw>
    <xmx:xovYagIoWeeyl6Pz314gY0Px_TtKJiOTXHS3a0hh2_h7LzpUqZEp-w>
    <xmx:xovYahvRxgF8JsevMTFvkODw6wqLymZFmcKCiTedYLonG1JJJxiZ5g>
    <xmx:x4vYaoOrgGcRAQpXlaHPm-5049xHqi1EfkMVq4lfruu6jH4YZtXStiw_>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 05:54:12 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Amir Goldstein" <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Ian Kent" <raven@themaw.net>, "Jake Edge" <jake@lwn.net>
Subject: Re: [PATCH v4 1/5] VFS: don't count references through ->d_parent
In-reply-to: <20261019000810.1837917-2-neilb@ownmail.net>
References: <20261019000810.1837917-1-neilb@ownmail.net>
  <20261019000810.1837917-2-neilb@ownmail.net>
Date: Wed, 21 Oct 2026 20:54:08 +1100
Message-id: <179257644849.1724252.12278532043596915181@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 19 Oct 2026, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>=20
> The number of negative child dentries that a given dentry can have is
> effectively unbounded, so counting the references through ->d_parent can
> overflow ->d_lockref.count.
>=20
> We only use this count so that we can know when there are no remaining
> references including from children.  However most children appear on the
> ->d_children list and the few remaining children (inactive
> DCACHE_DENTRY_CURSORs) only exist in a context were a separate reference
> is held on the parent.
>=20
> So if we count whether d_children is nonempty (i.e.  dget() when it
> becomes non-empty, dput() when it comes empty) and require children not
> on ->d_children to have a reference on the parent some other way (which
> they already do), then ->d_lockref.count will not overflow and we can
> still know exactly when all references, including through ->d_parent,
> are gone.

sashiko discovered a real bug here as autofs depends on d_count()
including the number of child dentries.  This is easily fixed.

sashiko also reported a false-positive with the fsnotify changes because
it didn't account for group->mark_mutex providing exclusion.

It also suggested a useful improvement for d_next_sibling_sched() to
always skip all cursors.

I'll resend after the merge window closes.

NeilBrown


>=20
> __d_move() allows that dentries might not be on any d_children list as
> is the case for IS_ROOT() dentries.  Rather than track when this is the
> case we dget() either parent if they have an empty d_children before
> children are moved around, then dput() if they turn out to be empty
> afterwards.  This will increment dentry if it IS_ROOT(), and then
> decrement it afterwards, and will decrement the refcount on old_parent
> if its ->d_children becomes empty.
>=20
> To help with this, dput_dlock() is added which warns rather than
> decrementing to zero (which should never happen).
>=20
> When a DCACHE_CURSOR dentry is added to d_children, it is only ever
> added "before" or "behind" an existing child, so it will never be the
> first child added, and so never needs to adjust the refcount on the
> parent.  If it remains on the list until dput() it could be the last
> child to be removed, in which case normal handling applies in
> dentry_unlist() (where it has been moved from dentry_kill().  When a
> cursor is deliberately removed from the d_children list the refcount
> must be decremented if that leaves the list empty.
>=20
> hlist_move_behind() and hlist_move_before() are added to simplify moving
> a cursor within the d_children list.  This results in some duplicate code
> as they share a common prefix with d_detach_cursor() (hlist_del)
> which is currently factored out.  We can expect the compiler to optimise
> this away and don't need to clutter the C code with it.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/dcache.c            | 40 +++++++++++++++++++++++++++++++++-------
>  fs/internal.h          | 10 ++++++++++
>  fs/libfs.c             | 14 +++++++-------
>  include/linux/dcache.h | 17 ++++++++++++++++-
>  include/linux/list.h   | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 96 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index f44c7b39c3b3..3a4d0a025447 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -670,6 +670,8 @@ static inline void dentry_unlist(struct dentry *dentry)
>  		return;
>  	}
>  	__hlist_del(&dentry->d_sib);
> +	if (hlist_empty(&dentry->d_parent->d_children))
> +		dentry->d_parent->d_lockref.count--;
>  	/*
>  	 * Cursors can move around the list of children.  While we'd been
>  	 * a normal list member, it didn't matter - ->d_sib.next would've
> @@ -843,7 +845,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
>  	spin_unlock(&dentry->d_lock);
>  	if (likely(can_free))
>  		dentry_free(dentry);
> -	if (parent && --parent->d_lockref.count) {
> +	if (parent && parent->d_lockref.count) {
>  		spin_unlock(&parent->d_lock);
>  		return NULL;
>  	}
> @@ -1997,7 +1999,9 @@ struct dentry *d_alloc(struct dentry * parent, const =
struct qstr *name)
>  	 * don't need child lock because it is not subject
>  	 * to concurrency here
>  	 */
> -	dentry->d_parent =3D dget_dlock(parent);
> +	dentry->d_parent =3D parent;
> +	if (hlist_empty(&parent->d_children))
> +		dget_dlock(parent);
>  	hlist_add_head(&dentry->d_sib, &parent->d_children);
>  	spin_unlock(&parent->d_lock);
> =20
> @@ -2016,7 +2020,7 @@ struct dentry *d_alloc_cursor(struct dentry * parent)
>  	struct dentry *dentry =3D d_alloc_anon(parent->d_sb);
>  	if (dentry) {
>  		dentry->d_flags |=3D DCACHE_DENTRY_CURSOR | DCACHE_NORCU;
> -		dentry->d_parent =3D dget(parent);
> +		dentry->d_parent =3D parent;
>  	}
>  	return dentry;
>  }
> @@ -2778,7 +2782,9 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
> =20
>  	new->d_flags |=3D DCACHE_PAR_LOOKUP;
>  	spin_lock(&parent->d_lock);
> -	new->d_parent =3D dget_dlock(parent);
> +	new->d_parent =3D parent;
> +	if (hlist_empty(&parent->d_children))
> +		dget_dlock(parent);
>  	hlist_add_head(&new->d_sib, &parent->d_children);
>  	if (parent->d_flags & DCACHE_DISCONNECTED)
>  		new->d_flags |=3D DCACHE_DISCONNECTED;
> @@ -3106,12 +3112,21 @@ static void __d_move(struct dentry *dentry, struct =
dentry *target,
> =20
>  	/* ... and switch them in the tree */
>  	dentry->d_parent =3D target->d_parent;
> +
> +	/*
> +	 * Ensure ref count on parents reflect d_children being non-empty,
> +	 * which they almost certainly are.  If either end up being empty,
> +	 * this is handled below after the moves.
> +	 */
> +	if (hlist_empty(&old_parent->d_children))
> +		dget_dlock(old_parent);
> +	if (dentry->d_parent !=3D old_parent &&
> +	    hlist_empty(&dentry->d_parent->d_children))
> +		dget_dlock(dentry->d_parent);
> +
>  	if (!exchange) {
>  		copy_name(dentry, target);
>  		target->d_hash.pprev =3D NULL;
> -		dentry->d_parent->d_lockref.count++;
> -		if (dentry !=3D old_parent) /* wasn't IS_ROOT */
> -			WARN_ON(!--old_parent->d_lockref.count);
>  	} else {
>  		target->d_parent =3D old_parent;
>  		swap_names(dentry, target);
> @@ -3124,6 +3139,17 @@ static void __d_move(struct dentry *dentry, struct d=
entry *target,
>  	if (!hlist_unhashed(&dentry->d_sib))
>  		__hlist_del(&dentry->d_sib);
>  	hlist_add_head(&dentry->d_sib, &dentry->d_parent->d_children);
> +
> +	/*
> +	 * Adjust parent refcounts if either d_children ended up empty.
> +	 * This should only ever be old_parent.
> +	 */
> +	if (hlist_empty(&old_parent->d_children))
> +		dput_dlock(old_parent);
> +	if (dentry->d_parent !=3D old_parent &&
> +	    hlist_empty(&dentry->d_parent->d_children))
> +		dput_dlock(dentry->d_parent);
> +
>  	__d_rehash(dentry);
>  	fsnotify_update_flags(dentry);
>  	fscrypt_handle_d_move(dentry);
> diff --git a/fs/internal.h b/fs/internal.h
> index c658c8a5ebd5..59b2b8030b6c 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -235,6 +235,16 @@ extern struct dentry *__d_lookup(const struct dentry *=
, const struct qstr *);
>  extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
>  				const struct qstr *name, unsigned *seq);
> =20
> +static inline void d_detach_cursor(struct dentry *cursor)
> +{
> +	if (hlist_unhashed(&cursor->d_sib))
> +		return;
> +	hlist_del_init(&cursor->d_sib);
> +	if (hlist_empty(&cursor->d_parent->d_children))
> +		/* That was the last child, must drop implied reference */
> +		dput_dlock(cursor->d_parent);
> +}
> +
>  /*
>   * pipe.c
>   */
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 27d7dc16fcb0..60586fe65895 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -128,9 +128,7 @@ static struct dentry *scan_positives(struct dentry *cur=
sor,
>  			count =3D 1;
>  		}
>  		if (need_resched()) {
> -			if (!hlist_unhashed(&cursor->d_sib))
> -				__hlist_del(&cursor->d_sib);
> -			hlist_add_behind(&cursor->d_sib, &d->d_sib);
> +			hlist_move_behind(&cursor->d_sib, &d->d_sib);
>  			p =3D &cursor->d_sib.next;
>  			spin_unlock(&dentry->d_lock);
>  			cond_resched();
> @@ -166,9 +164,10 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offs=
et, int whence)
>  			to =3D scan_positives(cursor, &dentry->d_children.first,
>  					    offset - 2, NULL);
>  		spin_lock(&dentry->d_lock);
> -		hlist_del_init(&cursor->d_sib);
>  		if (to)
> -			hlist_add_behind(&cursor->d_sib, &to->d_sib);
> +			hlist_move_behind(&cursor->d_sib, &to->d_sib);
> +		else
> +			d_detach_cursor(cursor);
>  		spin_unlock(&dentry->d_lock);
>  		dput(to);
> =20
> @@ -210,9 +209,10 @@ int dcache_readdir(struct file *file, struct dir_conte=
xt *ctx)
>  		p =3D &next->d_sib.next;
>  	}
>  	spin_lock(&dentry->d_lock);
> -	hlist_del_init(&cursor->d_sib);
>  	if (next)
> -		hlist_add_before(&cursor->d_sib, &next->d_sib);
> +		hlist_move_before(&cursor->d_sib, &next->d_sib);
> +	else
> +		d_detach_cursor(cursor);
>  	spin_unlock(&dentry->d_lock);
>  	dput(next);
> =20
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 4b1ff99608e0..3b595adff7b4 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -324,7 +324,7 @@ extern char *dentry_path(const struct dentry *, char *,=
 int);
>  /* Allocation counts.. */
> =20
>  /**
> - * dget_dlock -	get a reference to a dentry
> + * dget_dlock -	get a reference to a dentry while locked
>   * @dentry: dentry to get a reference to
>   *
>   * Given a live dentry, increment the reference count and return the dentr=
y.
> @@ -339,6 +339,21 @@ static inline struct dentry *dget_dlock(struct dentry =
*dentry)
>  	return dentry;
>  }
> =20
> +/**
> + * dput_dlock -	put a reference to a dentry while locked
> + * @dentry: dentry to get a reference to
> + *
> + * Given a live dentry, decrement the reference count and return the dentr=
y.
> + * Caller must hold @dentry->d_lock.  The dentry must still have
> + * a reference after the decrement.  This can be used when two
> + * references are held and one must be dropped.
> + */
> +static inline struct dentry *dput_dlock(struct dentry *dentry)
> +{
> +	if (!WARN_ON(dentry->d_lockref.count <=3D 1))
> +		dentry->d_lockref.count--;
> +	return dentry;
> +}
> =20
>  /**
>   * dget - get a reference to a dentry
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 77fb62f79928..a94eec20275f 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -1123,6 +1123,36 @@ static inline void hlist_add_behind(struct hlist_nod=
e *n,
>  		WRITE_ONCE(n->next->pprev, &n->next);
>  }
> =20
> +/**
> + * hlist_move_behind - move an hlist node to a new location in list
> + * @n: hlist node to be moved
> + * @prev: hlist node after which @n should be added.
> + *
> + * @n may be on the list or unhashed but must not be @prev.
> + * It is removed if necessary and re-added after @prev.
> + */
> +static inline void hlist_move_behind(struct hlist_node *n,
> +				     struct hlist_node *prev)
> +{
> +	hlist_del_init(n);
> +	hlist_add_behind(n, prev);
> +}
> +
> +/**
> + * hlist_move_before - move an hlist node to a new location in list
> + * @n: hlist node to be moved
> + * @next: hlist node before which @n should be added.
> + *
> + * @n may be on the list or unhashed but must not be @next.
> + * It is removed if necessary and re-added before @next.
> + */
> +static inline void hlist_move_before(struct hlist_node *n,
> +				     struct hlist_node *next)
> +{
> +	hlist_del_init(n);
> +	hlist_add_before(n, next);
> +}
> +
>  /**
>   * hlist_add_fake - create a fake hlist consisting of a single headless no=
de
>   * @n: Node to make a fake list out of
>=20
> base-commit: f909e534f5e34feb2ea2701d54df63e21aa506fc
> --=20
> 2.50.0.107.gf914562f5916.dirty
>=20
>=20
>=20

