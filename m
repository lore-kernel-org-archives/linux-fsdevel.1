Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991E4D98FB;
	Mon, 11 May 2026 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536708; cv=none; b=l25fTDvzMFzgYHFTf4p2f8ruPQ/1y1LADnexv2+zE2ei+X+wJAQlzT4cT6g2ddGPuNXdVX7Mf8JGKLKwDInxImU7TOejlz3Uj8X3P2IBm1+1GdwFdlLaMTMYIhoqfy5UOIsPTx3xyDvT/jSE6eL6btg8LScb5+ZlnO7JL3uZxJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536708; c=relaxed/simple;
	bh=FItf21fskoUTLrhGT9z32cIDErk8B/18OYbfcTgHfcw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TpDn145va7ou4sBW7zXfRubqXOKhmnPFv5pkF547gUrtMkTlEm5DsbvEbyaF1Ru6Bdt927Kffd+7fd0u2Mg70qhwpl6IOju/Z1nKIIVvYxV9EixT28RqwPr1hkBzz0hXuC+dvbJV8e6WVyW6UcQbRDYQmKX1g5PPUCW9sAQk6Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=C8HBtruV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DN0SsZt2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="C8HBtruV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DN0SsZt2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B94491400142;
	Mon, 11 May 2026 17:58:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 11 May 2026 17:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1778536704; x=1778623104; bh=a0iPeLniqzd3Is7n7MrzIqEivNGfuxmsGKu
	qM60Bxdk=; b=C8HBtruVeO34TeNHwDN/3f/ywumUZuAEtzRBqBDhCK0o9q30cu1
	uskPT8OpiNxlsY4WteHWwFDVoejwiBHWs7WxLAroDKb7HlbSrn8rQK5/7k8dMlTN
	9FQUNOpBJjp8VBcMUp9Ea/n4Aooxj5aV4parypo2duNQF5wYZeQ4jed5iZpNR7Gf
	JB+F61LaaFBZPb5OZyzM5timGtUn8j9oK8qRZra18cE7Q2Kntp22i3iDhOuEnY/R
	b9gSH/0w2Q5wr3YupahNqyJ/AB70iYTON5XE/+kYvyB365SR1iEPY4mcExps15nr
	nmXA4bxh1C4bsm5nJjUbgpQj0EmbKP1I13A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778536704; x=
	1778623104; bh=a0iPeLniqzd3Is7n7MrzIqEivNGfuxmsGKuqM60Bxdk=; b=D
	N0SsZt2hP9u7BIjuiRO/CiTkul4kgvXjl+jjmIC450Eyg/sacPgAYgsjh+KleMfA
	EtnWwZ4uJNEcZEDLNGEL0h2Wp1tTMSjCPLPri3PhgnqdZ+IqDXDXu4Zq32mv0yT9
	IaxwzmrmSVkfyl9eXJ6TsAiZjc2dA11vP4RIX6L03pGV0LW1Ceqv2lP9SzN1vNMf
	nWMqZKMS9PaN4wKUF283UCuWlmoeHEKS0ByeIMDareaeGs5TeULSyKMIxLoGUsLd
	MEGx8XFrfb8D66FrArSqUnxyPueMUWp4yusxCK1Zv9avc9B98cjjxr/Zm3V8qvxv
	KJJGD862Y2Nl+9YshXIXA==
X-ME-Sender: <xms:AFECajuEt4mCWnAI3cr3krqWo63j2eN2C2z_-MoLZS69iB8XklXyAw>
    <xme:AFECanAvCMeiWwCOXAqnhd3Vrgf_g5C4QG9XKql1GvzRGLrkZ4UcUWDWSPp9Moa0K
    3ITr35QfZ-ZmxSbrVbByMBQyd6JLD_YZkGv3f8yC10yFJU>
X-ME-Received: <xmr:AFECaqaneHu9CaNCw8DRsMO7QW_4kZWbp9h4Nxqc-JaGOwrd2-WcVpKuZlNvQfEiK62ykf3gwN0i9z7g2euA4Gr_eifVMa0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepthhorhhvrghl
    ughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehjlhgrhi
    htohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AFECaiU7k4fabeMScRWBUy6B6deQN8Cr_Q7O7-wzpZaFZHfqWoD9vQ>
    <xmx:AFECapOcbx6_WK2u6Nxy3jXstlErw-BaScTCnYjlAQZkGgTwHxTthg>
    <xmx:AFECasZyVx8X25O1ALH-7mGOpZxWVUemVMF91tYUrKiJCUKEvUtt1Q>
    <xmx:AFECao--6DT0p0uVSSNHK_ZEiKaejIjvvCCTdqN3xwLUXkMPtgfOCw>
    <xmx:AFECao1-NrBjQKRgTCdKYzfy9ownKxJV24TVI1y5FL9xr6chWTDjEO7h>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 17:58:21 -0400 (EDT)
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
Subject:
 Re: [PATCH v4 2/7] VFS: use wait_var_event for waiting in d_alloc_parallel()
In-reply-to: <769926ac94c1565c392bc55e84cb0eb8d3c3c6f5.camel@kernel.org>
References: <20260430020137.3305302-1-neilb@ownmail.net>
  <20260430020137.3305302-3-neilb@ownmail.net>
  <769926ac94c1565c392bc55e84cb0eb8d3c3c6f5.camel@kernel.org>
Date: Tue, 12 May 2026 07:58:18 +1000
Message-id: <177853669851.2788210.11426449253715303453@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 12 May 2026, Jeff Layton wrote:
> On Thu, 2026-04-30 at 11:56 +1000, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > d_alloc_parallel() currently requires a wait_queue_head to be passed in.
> > This must have a life time which extends until the lookup is completed.
> >=20
> > This makes it awkward to use and particularly make it hard to use in
> > lookup_one_qstr_excl() which I hope to do in the future.
> >=20
> > This patch changes d_alloc_parallel() to use wake_up_var_locked() to
> > wake up waiters, and wait_var_event_spinlock() to wait.  dentry->d_lock
> > is used for synchronisation as it is already held and the relevant
> > times.
> >=20
> > In most cases there will be no waiters so the wake_up_var_locked() call
> > (which can walk an arbitrarily long list) would be a complete waste.  To
> > optimise this a new ->d_flags flag is added: DCACHE_LOOKUP_WAITER.  This
> > is set whenever any thread prepares to wait for the dentry, and if it
> > isn't set when DCACHE_PAR_LOOKUP is cleared, no wakeup is sent.
> > DCACHE_LOOKUP_WAITER is cleared after the wakeup is set.
> >=20
> > __d_lookup_unhash() no longer returns a wq.  Callers check
> > DCACHE_LOOKUP_WAITER to check if a wakeup is needed, and
> > wake_up_var_locked() can find the wq.
> >=20
> > __d_lookup_unhash() no longer needs to re-init ->d_lru.  That was
> > previously shared (in a union) with ->d_wait but ->d_wait is now gone
> > so it no longer corrupts ->d_lru.
> >=20
> > Wakeup is move out of end_dir_add() as it is conceptually a separate acti=
on.
> >=20
> > Co-developed-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  Documentation/filesystems/porting.rst |  6 ++
> >  fs/afs/dir_silly.c                    |  4 +-
> >  fs/dcache.c                           | 83 +++++++++++++++------------
> >  fs/fuse/readdir.c                     |  3 +-
> >  fs/namei.c                            |  6 +-
> >  fs/nfs/dir.c                          |  6 +-
> >  fs/nfs/unlink.c                       |  3 +-
> >  fs/proc/base.c                        |  3 +-
> >  fs/proc/proc_sysctl.c                 |  3 +-
> >  fs/smb/client/readdir.c               |  3 +-
> >  include/linux/dcache.h                | 11 ++--
> >  include/linux/nfs_xdr.h               |  1 -
> >  12 files changed, 67 insertions(+), 65 deletions(-)
> >=20
> >=20
>=20
> [...]
>=20
> > =20
> > @@ -2979,7 +2987,7 @@ static void __d_move(struct dentry *dentry, struct =
dentry *target,
> >  	if (unlikely(d_in_lookup(target))) {
> >  		dir =3D target->d_parent->d_inode;
> >  		n =3D start_dir_add(dir);
> > -		d_wait =3D __d_lookup_unhash(target);
> > +		__d_lookup_unhash(target);
> >  	}
>=20
> In the old code, d_wait was associated with the target...
>=20
> > =20
> >  	write_seqcount_begin(&dentry->d_seq);
> > @@ -3018,9 +3026,10 @@ static void __d_move(struct dentry *dentry, struct=
 dentry *target,
> >  	write_seqcount_end(&target->d_seq);
> >  	write_seqcount_end(&dentry->d_seq);
> > =20
> > -	if (dir)
> > -		end_dir_add(dir, n, d_wait);
> > -
> > +	if (dir) {
> > +		end_dir_add(dir, n);
> > +		__d_wake_in_lookup_waiters(dentry);
> > +	}
>=20
> ...but here you are waking based on "dentry". Should that be:
>=20
> 		__d_wake_in_lookup_waiters(target)
>=20
> ?

Good catch.  I needed a long test run and a hint from Al before I saw
that :-)
The version in vfs-next/work.dcache (c177d84a4476) has "target" as you
suggest.

Thanks,
NeilBrown
