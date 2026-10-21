Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583259;
	b=kh9AACXmBcv29BP5kEbCNoexm4IHMYXfsm4j/ryq2ajpPyOyTIhMysp9UarjBNT1ybg4
	 vNoCu351v2MNpWFFimvsABgUGIVnNNHux3cgvqRojUCMcA06rMVEiFO+NqHJsaIbHyvD5
	 O0SCMXEawp+hSYlU7BpMl5UV5mFBygSf8CJm3oQMIg9mXYW7Ru14VocPa5pMsYmw4ZJQp
	 DSk99j6ulkFEx+liknGs9GFdZuAqornmBMvo+wiG6rJgyFGz9lgYO2k9jsM7D66sHoIn+
	 MOqRf+bjidS8nwJGYE0cKe6nwE7BAWkiA5onLMqEZbmuggvfiG9Gaux3JwuYOb8jrBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583259;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=hcOdMO4WqZB6XbkxK7JvUxUVUX8bkPWCmgf1RH08hT4=;
	b=FEqKLoS6EJ+43NLM5NNZfaWHtGLePz1v0xro+2Ffdq13cLIfiajo3fRtvFw5adxK1MXy
	 dEdNIJQX/eOCiqQOMLfrEYCKGfkxDE4bBmQIgACEud+ngst9gq93R9cLT6SOe54QpP4Xu
	 ETObjsRbiU4Jn1jIl9+KymPLYdHui9YvVix5XWLLg65uA9fR2qzixzx2R/Ym4a984WIrI
	 Ojv5fwUK/GnuKNm2BCjWM5WD5lbOQu0ZltjybUjmWxdRnrGCT6rRfqN0j+z/8tFJRcIRW
	 x/ImVQv3ZnwBzSp1VCFUb/tt84e5MFqj5f8QfYoqTskjWU2iEd5hBsn/zFj1ug44hWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=themaw.net;
	spf=pass smtp.mailfrom=themaw.net;
	dkim=pass header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=gOxF+x2e;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=C3Bacg5j;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488560A2614
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 11:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5488560A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm1 header.b=gOxF+x2e;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=C3Bacg5j
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 849EE1D000B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 07:47:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 07:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792583256;
	 x=1792669656; bh=hcOdMO4WqZB6XbkxK7JvUxUVUX8bkPWCmgf1RH08hT4=; b=
	gOxF+x2eikExlKGFPBQsGU3bbCOzE/6pZOv9QI3oNkfKZ0Tq6t1lOCbZn7ZKgCZ6
	hMVqG8UeiJElAg6FmE8PDbHD1uC+VsKAqZ4mMSYgU1N8LFMUyl8vgL+ctzKB7Vau
	e8VgCSQQkP5Qnqh+TUzWUIS56yka6G3+eEhCrcEWbfCWAnivbc2M8tmnXDEJyLMF
	tnUaZMSReNxvbEfOD/GaEVSe9ptzde3Egs6bP6VOBxkIaUyZblpzOmiHrEWgGCmz
	AAlenx79RPJpimxE4dLb98Q9oNYqiRk5jIIUiYBTbotfj0gw/Cni6NjqI65f+MTr
	MpMjcpPqoDh6DCf19hEFdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792583256; x=
	1792669656; bh=hcOdMO4WqZB6XbkxK7JvUxUVUX8bkPWCmgf1RH08hT4=; b=C
	3Bacg5j0xXqpZrsa6C2TQEROBEGpNCUgNBYia1miqPPiuec5KHZUnUU8oBrybm6r
	JCfErJioexo4rRRxMNNrgXPY9serSCyaAlT/DEjUEHb9jZSV8WRcNzI3KnK55jf7
	F08iZFgqjOMjDEYXFSydXUMxGe/veJZr6SLalP3sdrCH7MMcIpHqstTzJo7Sy6Bd
	5m400C6D6YaWdKn431FBOQw62jGY54iMgpWuA/LqofiMJVad44+EPzvgErQx/y5k
	Ah5Zi01i1S945TzEedWwkwAQZHaucNvHIznGoAkee9yBcC+hvuR1WINq3pL31A1l
	3SOjfnYhVLJGdjwdGdxsw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792583256; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:IaW6HWAcsJ9QK7nlhZF+/0Bz07K1DJuXDnZ4GOnKNXNZn7k
	BKJWLSgiUecpd3JrLm0K05cdZZI0/laZ3EGkSZqdW+2nEAm7IL97BkcwXhG94TEC
	w1lciWfVv9xPNmPB1kNiBRht9B/nd+W4QSC9gmntx24cYDvVpKLq3hp40uOh6xwe
	/39TBveguKn9LNeTcSE0AVWvKs2HNsG634/saihMSKAlPS1yhal3lmLJAhDikRMZ
	hqqqGuqK85X1Zez1eC1B4lL/PaV6frnQ4+33iiSxZbxw6Bqh4NlP4mIrHog9I1uy
	PwHi5OM55XapSOUbRe2yIafOO0XnEJmg1x4UggQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:Sxc+gwbz09YWjNuGRvzapcErCcPEf0aLPDWY8yL/4bg=:FH2QeGaTBsr/dDUPUt+MS5Sv8mItsHNQ23T2E50Z9qM=;
X-ME-Sender: <xms:WKbYam8bxZaKD2h-I5HcjjyqZ1MRyj_fF5HI12hg99cqmjoS7ubVjw>
    <xme:WKbYapRImgfIgMdgil0Q8ZXrfYWb2Q0GjStJfKm4_m8aDjr5kaSC7JOXG4T864y33
    qR5yn1gRjT_IgaUgsTtsGbgnS2h6BPfgMMR4G_kGp2ZUJrTNg>
X-ME-Received: <xmr:WKbYavqzc6HEL4Sh3rbiVtFr5JlP-Yl3u66JjrVCLQ_zZAWI8w-Whwtg7ZLQ8-OXLe27N6gp3lKgsCfm1DZ6atuwEaQj6t-khUKqWH7ipXhOiAdgDBBfazK4zg8>
X-ME-Proxy-Cause: dmFkZTEl8I0STdc5fVLr/5XJ9IBicug9DaVdOQu7W6S1K2uTtkwzs/dy8VYLbqvu80uzNH
    hsK/IZjZBdYeHkaS1W8Qio7fIm1DyGYFWXIeD7eDXol+EyIlGxTxThxC8bXxb/GsRW9vwf
    KOHWG2GhrQ/F5vh/gRXpJ/MbNycSFziKOZZDdsvK3GLHr7zH2tN7ecWID0pDBAzcmX19iG
    qfsgFHaqK+SUynxij3NGB96f4lGh1SKMo+p6Clwa4AB78FPgKNH8C25SSgz4Y3j7RCyTi0
    HEFjrsx0pN1hURvkqfceWcx8R7uefyuVVnJb9QhtqtmEfhTk13sNpmMoinOkxd9qLSmziY
    7i/I1zVcE1GA8TKbz4tRslttZTkKl518eABvW0xieEuEvULKfH/cRLrOJGHutefrlPgWfh
    GvS52oMNVdtrwaenXCP88cmwuRkvQ27OBelu+I8mx86t6cSf0adQQrwS5QeFL9InMMqc1Z
    nFTBGZ00hGMT0R6y6CJRMYIDfRJI3eUManvXDfpi5639fItMvOnSn3gFZ42qXp+Ny89PVB
    CwTmTfefDkXcGkw5mSJ9D/Wf7lXzITrhqVU3BioYBK+AsVbFp9CEZ8g8b+Hj8isuc7axvv
    sX4+G58eVrjM1sAwfLs4ye+XlmQpWfTQPO30rPu0Lp3aWpkmTc3uxg5SdEBQ
X-ME-Proxy: <xmx:WKbYauny-nXtyYDjsJR6mljDAqUYMw6lh7zUoIFEJIiybiUlYq0Szg>
    <xmx:WKbYagfzYjB5ymrh4QpQTq5FEv5Ie6W8aiaskkjZxdEzVdMC-WCLNA>
    <xmx:WKbYaip6j64XBslnggOf7NyBubhym5pFp2PHKGI5GbXCB0w9g1jClg>
    <xmx:WKbYaiO8lw6s267VkFqqUc2YRiN6IqTIBn4MrXHLJ3_TyGGJMJ-dbw>
    <xmx:WKbYarSEGLLktn9dIOLbVuP0Asz2f0ZBO2HD3LR68tunLCO1HOT6yLSC>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 07:47:33 -0400 (EDT)
Message-ID: <fc2c9191a50a782fa6560349060ddfd763ec2ab0.camel@themaw.net>
Subject: Re: [PATCH v4 1/5] VFS: don't count references through ->d_parent
From: Ian Kent <raven@themaw.net>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir
 Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jake Edge
	 <jake@lwn.net>
Date: Wed, 21 Oct 2026 19:47:29 +0800
In-Reply-To: <179257644849.1724252.12278532043596915181@noble.neil.brown.name>
References: <20261019000810.1837917-1-neilb@ownmail.net>
	  <20261019000810.1837917-2-neilb@ownmail.net>
	 <179257644849.1724252.12278532043596915181@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-21 at 20:54 +1100, NeilBrown wrote:
> On Mon, 19 Oct 2026, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > The number of negative child dentries that a given dentry can have
> > is
> > effectively unbounded, so counting the references through -
> > >d_parent can
> > overflow ->d_lockref.count.
> >=20
> > We only use this count so that we can know when there are no
> > remaining
> > references including from children.=C2=A0 However most children appear
> > on the
> > ->d_children list and the few remaining children (inactive
> > DCACHE_DENTRY_CURSORs) only exist in a context were a separate
> > reference
> > is held on the parent.
> >=20
> > So if we count whether d_children is nonempty (i.e.=C2=A0 dget() when i=
t
> > becomes non-empty, dput() when it comes empty) and require children
> > not
> > on ->d_children to have a reference on the parent some other way
> > (which
> > they already do), then ->d_lockref.count will not overflow and we
> > can
> > still know exactly when all references, including through -
> > >d_parent,
> > are gone.
>=20
> sashiko discovered a real bug here as autofs depends on d_count()
> including the number of child dentries.=C2=A0 This is easily fixed.
Umm ... oops!

Yes it does but that's purely to establish if there's any additional
references held indicating an open file or working directory within
the directory although I'm not sure I actually use it for individual
directories. The mount reference count changes that Al did some time
ago should mean that ino_count can be eliminated and the mount count
alone used instead.

In fact I still need to post a fix for may_umount_tree() that uses
those changes ... maybe now's the time so you have example usage.

Sigh ... time ... time ... time ...

Ian
>=20
> sashiko also reported a false-positive with the fsnotify changes
> because
> it didn't account for group->mark_mutex providing exclusion.
>=20
> It also suggested a useful improvement for d_next_sibling_sched() to
> always skip all cursors.
>=20
> I'll resend after the merge window closes.
>=20
> NeilBrown
>=20
>=20
> >=20
> > __d_move() allows that dentries might not be on any d_children list
> > as
> > is the case for IS_ROOT() dentries.=C2=A0 Rather than track when this i=
s
> > the
> > case we dget() either parent if they have an empty d_children
> > before
> > children are moved around, then dput() if they turn out to be empty
> > afterwards.=C2=A0 This will increment dentry if it IS_ROOT(), and then
> > decrement it afterwards, and will decrement the refcount on
> > old_parent
> > if its ->d_children becomes empty.
> >=20
> > To help with this, dput_dlock() is added which warns rather than
> > decrementing to zero (which should never happen).
> >=20
> > When a DCACHE_CURSOR dentry is added to d_children, it is only ever
> > added "before" or "behind" an existing child, so it will never be
> > the
> > first child added, and so never needs to adjust the refcount on the
> > parent.=C2=A0 If it remains on the list until dput() it could be the
> > last
> > child to be removed, in which case normal handling applies in
> > dentry_unlist() (where it has been moved from dentry_kill().=C2=A0 When
> > a
> > cursor is deliberately removed from the d_children list the
> > refcount
> > must be decremented if that leaves the list empty.
> >=20
> > hlist_move_behind() and hlist_move_before() are added to simplify
> > moving
> > a cursor within the d_children list.=C2=A0 This results in some
> > duplicate code
> > as they share a common prefix with d_detach_cursor() (hlist_del)
> > which is currently factored out.=C2=A0 We can expect the compiler to
> > optimise
> > this away and don't need to clutter the C code with it.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> > =C2=A0fs/dcache.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 40 +++++++++++++++++++++++++++++++++-----
> > --
> > =C2=A0fs/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 10 ++++++++++
> > =C2=A0fs/libfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 14 +++++++-------
> > =C2=A0include/linux/dcache.h | 17 ++++++++++++++++-
> > =C2=A0include/linux/list.h=C2=A0=C2=A0 | 30 +++++++++++++++++++++++++++=
+++
> > =C2=A05 files changed, 96 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index f44c7b39c3b3..3a4d0a025447 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -670,6 +670,8 @@ static inline void dentry_unlist(struct dentry
> > *dentry)
> > =C2=A0		return;
> > =C2=A0	}
> > =C2=A0	__hlist_del(&dentry->d_sib);
> > +	if (hlist_empty(&dentry->d_parent->d_children))
> > +		dentry->d_parent->d_lockref.count--;
> > =C2=A0	/*
> > =C2=A0	 * Cursors can move around the list of children.=C2=A0 While
> > we'd been
> > =C2=A0	 * a normal list member, it didn't matter - ->d_sib.next
> > would've
> > @@ -843,7 +845,7 @@ static struct dentry *dentry_kill(struct dentry
> > *dentry)
> > =C2=A0	spin_unlock(&dentry->d_lock);
> > =C2=A0	if (likely(can_free))
> > =C2=A0		dentry_free(dentry);
> > -	if (parent && --parent->d_lockref.count) {
> > +	if (parent && parent->d_lockref.count) {
> > =C2=A0		spin_unlock(&parent->d_lock);
> > =C2=A0		return NULL;
> > =C2=A0	}
> > @@ -1997,7 +1999,9 @@ struct dentry *d_alloc(struct dentry *
> > parent, const struct qstr *name)
> > =C2=A0	 * don't need child lock because it is not subject
> > =C2=A0	 * to concurrency here
> > =C2=A0	 */
> > -	dentry->d_parent =3D dget_dlock(parent);
> > +	dentry->d_parent =3D parent;
> > +	if (hlist_empty(&parent->d_children))
> > +		dget_dlock(parent);
> > =C2=A0	hlist_add_head(&dentry->d_sib, &parent->d_children);
> > =C2=A0	spin_unlock(&parent->d_lock);
> > =C2=A0
> > @@ -2016,7 +2020,7 @@ struct dentry *d_alloc_cursor(struct dentry *
> > parent)
> > =C2=A0	struct dentry *dentry =3D d_alloc_anon(parent->d_sb);
> > =C2=A0	if (dentry) {
> > =C2=A0		dentry->d_flags |=3D DCACHE_DENTRY_CURSOR |
> > DCACHE_NORCU;
> > -		dentry->d_parent =3D dget(parent);
> > +		dentry->d_parent =3D parent;
> > =C2=A0	}
> > =C2=A0	return dentry;
> > =C2=A0}
> > @@ -2778,7 +2782,9 @@ struct dentry *d_alloc_parallel(struct dentry
> > *parent,
> > =C2=A0
> > =C2=A0	new->d_flags |=3D DCACHE_PAR_LOOKUP;
> > =C2=A0	spin_lock(&parent->d_lock);
> > -	new->d_parent =3D dget_dlock(parent);
> > +	new->d_parent =3D parent;
> > +	if (hlist_empty(&parent->d_children))
> > +		dget_dlock(parent);
> > =C2=A0	hlist_add_head(&new->d_sib, &parent->d_children);
> > =C2=A0	if (parent->d_flags & DCACHE_DISCONNECTED)
> > =C2=A0		new->d_flags |=3D DCACHE_DISCONNECTED;
> > @@ -3106,12 +3112,21 @@ static void __d_move(struct dentry *dentry,
> > struct dentry *target,
> > =C2=A0
> > =C2=A0	/* ... and switch them in the tree */
> > =C2=A0	dentry->d_parent =3D target->d_parent;
> > +
> > +	/*
> > +	 * Ensure ref count on parents reflect d_children being
> > non-empty,
> > +	 * which they almost certainly are.=C2=A0 If either end up
> > being empty,
> > +	 * this is handled below after the moves.
> > +	 */
> > +	if (hlist_empty(&old_parent->d_children))
> > +		dget_dlock(old_parent);
> > +	if (dentry->d_parent !=3D old_parent &&
> > +	=C2=A0=C2=A0=C2=A0 hlist_empty(&dentry->d_parent->d_children))
> > +		dget_dlock(dentry->d_parent);
> > +
> > =C2=A0	if (!exchange) {
> > =C2=A0		copy_name(dentry, target);
> > =C2=A0		target->d_hash.pprev =3D NULL;
> > -		dentry->d_parent->d_lockref.count++;
> > -		if (dentry !=3D old_parent) /* wasn't IS_ROOT */
> > -			WARN_ON(!--old_parent->d_lockref.count);
> > =C2=A0	} else {
> > =C2=A0		target->d_parent =3D old_parent;
> > =C2=A0		swap_names(dentry, target);
> > @@ -3124,6 +3139,17 @@ static void __d_move(struct dentry *dentry,
> > struct dentry *target,
> > =C2=A0	if (!hlist_unhashed(&dentry->d_sib))
> > =C2=A0		__hlist_del(&dentry->d_sib);
> > =C2=A0	hlist_add_head(&dentry->d_sib, &dentry->d_parent-
> > >d_children);
> > +
> > +	/*
> > +	 * Adjust parent refcounts if either d_children ended up
> > empty.
> > +	 * This should only ever be old_parent.
> > +	 */
> > +	if (hlist_empty(&old_parent->d_children))
> > +		dput_dlock(old_parent);
> > +	if (dentry->d_parent !=3D old_parent &&
> > +	=C2=A0=C2=A0=C2=A0 hlist_empty(&dentry->d_parent->d_children))
> > +		dput_dlock(dentry->d_parent);
> > +
> > =C2=A0	__d_rehash(dentry);
> > =C2=A0	fsnotify_update_flags(dentry);
> > =C2=A0	fscrypt_handle_d_move(dentry);
> > diff --git a/fs/internal.h b/fs/internal.h
> > index c658c8a5ebd5..59b2b8030b6c 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -235,6 +235,16 @@ extern struct dentry *__d_lookup(const struct
> > dentry *, const struct qstr *);
> > =C2=A0extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
> > =C2=A0				const struct qstr *name, unsigned
> > *seq);
> > =C2=A0
> > +static inline void d_detach_cursor(struct dentry *cursor)
> > +{
> > +	if (hlist_unhashed(&cursor->d_sib))
> > +		return;
> > +	hlist_del_init(&cursor->d_sib);
> > +	if (hlist_empty(&cursor->d_parent->d_children))
> > +		/* That was the last child, must drop implied
> > reference */
> > +		dput_dlock(cursor->d_parent);
> > +}
> > +
> > =C2=A0/*
> > =C2=A0 * pipe.c
> > =C2=A0 */
> > diff --git a/fs/libfs.c b/fs/libfs.c
> > index 27d7dc16fcb0..60586fe65895 100644
> > --- a/fs/libfs.c
> > +++ b/fs/libfs.c
> > @@ -128,9 +128,7 @@ static struct dentry *scan_positives(struct
> > dentry *cursor,
> > =C2=A0			count =3D 1;
> > =C2=A0		}
> > =C2=A0		if (need_resched()) {
> > -			if (!hlist_unhashed(&cursor->d_sib))
> > -				__hlist_del(&cursor->d_sib);
> > -			hlist_add_behind(&cursor->d_sib, &d-
> > >d_sib);
> > +			hlist_move_behind(&cursor->d_sib, &d-
> > >d_sib);
> > =C2=A0			p =3D &cursor->d_sib.next;
> > =C2=A0			spin_unlock(&dentry->d_lock);
> > =C2=A0			cond_resched();
> > @@ -166,9 +164,10 @@ loff_t dcache_dir_lseek(struct file *file,
> > loff_t offset, int whence)
> > =C2=A0			to =3D scan_positives(cursor, &dentry-
> > >d_children.first,
> > =C2=A0					=C2=A0=C2=A0=C2=A0 offset - 2, NULL);
> > =C2=A0		spin_lock(&dentry->d_lock);
> > -		hlist_del_init(&cursor->d_sib);
> > =C2=A0		if (to)
> > -			hlist_add_behind(&cursor->d_sib, &to-
> > >d_sib);
> > +			hlist_move_behind(&cursor->d_sib, &to-
> > >d_sib);
> > +		else
> > +			d_detach_cursor(cursor);
> > =C2=A0		spin_unlock(&dentry->d_lock);
> > =C2=A0		dput(to);
> > =C2=A0
> > @@ -210,9 +209,10 @@ int dcache_readdir(struct file *file, struct
> > dir_context *ctx)
> > =C2=A0		p =3D &next->d_sib.next;
> > =C2=A0	}
> > =C2=A0	spin_lock(&dentry->d_lock);
> > -	hlist_del_init(&cursor->d_sib);
> > =C2=A0	if (next)
> > -		hlist_add_before(&cursor->d_sib, &next->d_sib);
> > +		hlist_move_before(&cursor->d_sib, &next->d_sib);
> > +	else
> > +		d_detach_cursor(cursor);
> > =C2=A0	spin_unlock(&dentry->d_lock);
> > =C2=A0	dput(next);
> > =C2=A0
> > diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> > index 4b1ff99608e0..3b595adff7b4 100644
> > --- a/include/linux/dcache.h
> > +++ b/include/linux/dcache.h
> > @@ -324,7 +324,7 @@ extern char *dentry_path(const struct dentry *,
> > char *, int);
> > =C2=A0/* Allocation counts.. */
> > =C2=A0
> > =C2=A0/**
> > - * dget_dlock -	get a reference to a dentry
> > + * dget_dlock -	get a reference to a dentry while locked
> > =C2=A0 * @dentry: dentry to get a reference to
> > =C2=A0 *
> > =C2=A0 * Given a live dentry, increment the reference count and return
> > the dentry.
> > @@ -339,6 +339,21 @@ static inline struct dentry *dget_dlock(struct
> > dentry *dentry)
> > =C2=A0	return dentry;
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * dput_dlock -	put a reference to a dentry while locked
> > + * @dentry: dentry to get a reference to
> > + *
> > + * Given a live dentry, decrement the reference count and return
> > the dentry.
> > + * Caller must hold @dentry->d_lock.=C2=A0 The dentry must still have
> > + * a reference after the decrement.=C2=A0 This can be used when two
> > + * references are held and one must be dropped.
> > + */
> > +static inline struct dentry *dput_dlock(struct dentry *dentry)
> > +{
> > +	if (!WARN_ON(dentry->d_lockref.count <=3D 1))
> > +		dentry->d_lockref.count--;
> > +	return dentry;
> > +}
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * dget - get a reference to a dentry
> > diff --git a/include/linux/list.h b/include/linux/list.h
> > index 77fb62f79928..a94eec20275f 100644
> > --- a/include/linux/list.h
> > +++ b/include/linux/list.h
> > @@ -1123,6 +1123,36 @@ static inline void hlist_add_behind(struct
> > hlist_node *n,
> > =C2=A0		WRITE_ONCE(n->next->pprev, &n->next);
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * hlist_move_behind - move an hlist node to a new location in
> > list
> > + * @n: hlist node to be moved
> > + * @prev: hlist node after which @n should be added.
> > + *
> > + * @n may be on the list or unhashed but must not be @prev.
> > + * It is removed if necessary and re-added after @prev.
> > + */
> > +static inline void hlist_move_behind(struct hlist_node *n,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 struct hlist_node *prev)
> > +{
> > +	hlist_del_init(n);
> > +	hlist_add_behind(n, prev);
> > +}
> > +
> > +/**
> > + * hlist_move_before - move an hlist node to a new location in
> > list
> > + * @n: hlist node to be moved
> > + * @next: hlist node before which @n should be added.
> > + *
> > + * @n may be on the list or unhashed but must not be @next.
> > + * It is removed if necessary and re-added before @next.
> > + */
> > +static inline void hlist_move_before(struct hlist_node *n,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 struct hlist_node *next)
> > +{
> > +	hlist_del_init(n);
> > +	hlist_add_before(n, next);
> > +}
> > +
> > =C2=A0/**
> > =C2=A0 * hlist_add_fake - create a fake hlist consisting of a single
> > headless node
> > =C2=A0 * @n: Node to make a fake list out of
> >=20
> > base-commit: f909e534f5e34feb2ea2701d54df63e21aa506fc
> > --=20
> > 2.50.0.107.gf914562f5916.dirty
> >=20
> >=20
> >=20
