Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744533E024B
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031058; cv=none; b=RnrYyQJY+bZU7/ZN+S+ZfLKHW1ulDa5na7pOcNfKi7+kA47aInkY+VVS5rYMEwD5sIPpM7zbwwTaO0XymMdHtuzSJGfPbsPfQnCdTN5XAAEDQ+N3CCSvGO3jSwdTLW0kHfri0kOl05ly+wxPd/YplGyD+AKk5veCF73c64YtLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031058; c=relaxed/simple;
	bh=WLZ6zrQmo6HVXLwkUoZd3daPQsWnGSfgcCiIaY/+cEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBeEbo6nkuOYFmy7O/EgLoirDtIgmO48lDfb2e3PABlAO+UHZ8MhCVsj3Zao6LqiSXP6BVjozVT6MqAmHv58t2Jp9djgD+9vDuNcD8gfXaR2vEG+7i291nj7R9KaWhTMYBmU02rN01mBODWb0mgpLKKDVjJ+DORX1Mi6s5/mSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8iiK5qL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8iiK5qL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF001F000FF;
	Thu, 10 Sep 2026 09:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789031057;
	bh=yBtnVUkOBjFC+tuRfrIDMyjFFDS18yS74JsjfirXMqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e8iiK5qLJNOPjyFcTIF2BUIcMokjY32R04rnmH6WiChOBK6aqDA4U+pOy64W0J6Kv
	 iFTKc+jd6xKGoDkw/ISoG7qq2exU2IFiFh1f6eU29KJ1Q6UtvbBmCDBTyDS+h1pnJS
	 YHx5+3h6/Vmy7pFJpYV3fh5B2GeHe6HO+ImkP4rZA3o8qp3uQAiBn069WRVGuztHzN
	 6Lno9cz019L4b/MHu1ji9WSWgFxhacfVkxX3ZRQiqJrhMA0Z0ypgBUdGRCIayoKWw2
	 aCM/oCt1POSQmZJGYuLQjeUlPTSW7Iaxy7CwdOMyzIRacsBqDRK4NH+Zxb2opDieAp
	 TJzb8ogpzNWbQ==
Date: Thu, 10 Sep 2026 11:04:12 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] sysctl: Make proc_doulongvec_ms_jiffies_minmax()
 enforce minmax again.
Message-ID: <yjcicbo7okgpkd6gh4exgagt2gkklnkbivq34i3ypksmnooxb4@3t4jfy6grwog>
References: <20260905233819.1064529-1-kuniyu@google.com>
 <20260905233819.1064529-3-kuniyu@google.com>
 <hbatn4h5342kuvni5jcfjpdfjfof7dbsld5m26x6dla7ennpey@usgxbvlikr4i>
 <CAAVpQUA0ZKAMkhGipXdGb=4o5GRG1dS1Pv11KWhxYqgXKsw1Sg@mail.gmail.com>
 <skrtuyahssx5tvphmvo3kbkqy475re5yeb2kdl6luf7kmmfqad@2gsivqhqwtvw>
 <CAAVpQUDOXfiVyuSgJ5HqZ=xX3aBM+Bar5i2Gmf8ur+jBT-74yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a6rxe2vpvgn67z2m"
Content-Disposition: inline
In-Reply-To: <CAAVpQUDOXfiVyuSgJ5HqZ=xX3aBM+Bar5i2Gmf8ur+jBT-74yA@mail.gmail.com>


--a6rxe2vpvgn67z2m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 10:07:53AM -0700, Kuniyuki Iwashima wrote:
> On Wed, Sep 9, 2026 at 6:44=E2=80=AFAM Joel Granados <joel.granados@kerne=
l.org> wrote:
> >
> > On Tue, Sep 08, 2026 at 11:44:08AM -0700, Kuniyuki Iwashima wrote:
> > > On Tue, Sep 8, 2026 at 5:15=E2=80=AFAM Joel Granados <joel.granados@k=
ernel.org> wrote:
> > > >
> > > > On Sat, Sep 05, 2026 at 11:36:31PM +0000, Kuniyuki Iwashima wrote:
> > > > > Since the cited commit changed proc_doulongvec_ms_jiffies_minmax()
> > > > > to use proc_ulong_conv(), proc_doulongvec_ms_jiffies_minmax() no
> > > > > longer applies the range check.
> > > > >
> > > > > It happened probably because do_proc_ulong_conv_ms_jiffies() does
> > > > > not have the _minmax suffix.
> > > > >
> > > > > In addition, sysctl_msecs_to_jiffies() casts u64 user input to u3=
2,
> > > > > and a truncated value could bypass the max check.
> > > > This is something that is orthogonal to changing to true in the
> > > > proc_ulong_conv call. Please put this in its own commit.
> > > >
> > > > This also begs the question: why not just use an int converter if t=
he
> > > > range of the values is going to be u32?
> > >
> > > I guess people wanted to use ulong just because jiffies
> > > is unsigned long.
> > >
> > > Looking at these users, none of them need the ulong range
> > > and it can be u32 actually.
> >
> > Exactly. But changing those calls from ulong to uint is up to net and
> > parport.
>=20
> Agreed, it should be done in the -next branch of each subsystem.
>=20
> And later, we can remove do_proc_ulong_conv_ms_jiffies().
>=20
>=20
> > I'm more interested in defining the behavior in
> > sysctl_u2k_ulong_conv_ms.
> >
> > Here is my train of thought:
> > 1. u64 values will get truncated when they pass through msecs_to_jiffies
> >
> > 2. The range of msecs_to_jiffies is:
> >    [0, INT_MAX]          --->  ceil(m =C3=97 HZ / 1000)
> >    [INT_MAX+1, UINT_MAX] --->  MAX_JIFFY_OFFSET
> >
> >    Which I interpret as whatever that falls out of [0, INT_MAX]
> >    milliseconds is just infinite jiffies (MAX_JIFFY_OFFSET).
>=20
> nit: for HZ > 1000 (IIRC up to 1200 ?), the max of the range
> gets a little bit smaller.
>=20
>=20
> >
> > 3. All but one users of do_proc_ulong_conv_ms_jiffies are bound to
> >    values under MAX_JIFFY_OFFSET. The exception is net/rds/sysctl.c:67
> >    that has a max of ~0UL (is this too high?).
>=20
> I think this is just set as the theoretical max of @jiffies,
> but not specifically for the knob.
>=20
> The default of the knob is 1 sec (HZ), and even INT_MAX
> (24 days) is too high for RDS reconnect.
>=20
>=20
> >
> > 4. Since milliseconds to jiffies should be capped at MAX_JIFFY_OFFSET
> >    for big values. Should we just return MAX_JIFFY_OFFSET?
> >    Like this:
> >
> >     diff --git i/kernel/time/jiffies.c w/kernel/time/jiffies.c
> >     index 213ae1d6a014..400353b0d6f9 100644
> >     --- i/kernel/time/jiffies.c
> >     +++ w/kernel/time/jiffies.c
> >     @@ -136,6 +136,8 @@ static int sysctl_k2u_int_conv_userhz(bool *neg=
p, ulong *u_ptr, const int *k_ptr
> >
> >      static ulong sysctl_msecs_to_jiffies(const ulong val)
> >      {
> >     +       if (val > UINT_MAX)
> >     +               return MAX_JIFFY_OFFSET;
>=20
> Given the nit at 2., it should be like this
>=20
> if (val > jiffies_to_msecs(MAX_JIFFY_OFFSET))
>     return MAX_JIFFY_OFFSET;
>=20
> as done in _msecs_to_jiffies().

That is even better.

Please send a V2 of the 3 fixes discussed and I'll push them through
next week.

Best


--a6rxe2vpvgn67z2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqicowACgkQupfNUreW
QU/6qQv/S9rctnQabOzPzSgRmuzzg919WTFryxCVMdyY2k5GAviNTIPr/YZ8v2pZ
7tRcbWX/n0llTrUzAtxOT8IVZbRP67cRQNbHOPjpatoms6zjJMBEQDzIYmeb7mrA
E24t870HCy5DfIY6z6klf66DBEehtzCp+PLgn4BAYOx39IkyfyAtEy8V2C9HZG1Z
/eApOClvxRmRu/MEwgOexlbgjy9Q/0ncKYjVdaRdfyjHVgABh5y+M7iuMvqfdMag
KvWmfq40lxM73EF4UeCVfTMIs1IK+gwnyjUWob68wBHMEDQ365K1JoZg+DvdGbri
BPgeKEj6Rizg5m5i2syuo7dwBS+ZwfPniAg3MGdWYbi2SR+sNaD46E6FxRXeKyFQ
9gQyCVdimKDCaIs3bbBJ7zPBbBXSkLi/lYzX9H/uNJcuT5Iu5usnmj44r86pIQ/2
qzXbK8h65Fo1BEE8YuSL0d/blhfljbHfneEsITiciZayK5vx+/okkQaT3PAzQIbX
7B90OiI4
=SFuq
-----END PGP SIGNATURE-----

--a6rxe2vpvgn67z2m--
