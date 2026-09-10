Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF63D9699
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037122; cv=none; b=Xg06O7nDEKE4/5PXs1LC8SwlHTnLaIJIs8mVsHr3X5VcuLfAFJ7CBt3yHVNzCBGbFd3W3nbApOf4Y23O8Uw/CHKUIhnluZw7s2vslkmqHtC1qQw7mBQIidUKBxtHjoChBwlBeLFer9zL96iIaubJRTapck4J4AoL+WvXD4O2pBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037122; c=relaxed/simple;
	bh=RoWFhkri0NCRO3GkwJLdm+Fm2wvu2w0WNV+MR+kTs3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyQQEohQ869Jc+sm3gVs2k3RhplCnIcM+yBL+1399InQ7NePLsxrkqZo6fvP1xR7VjcKGjHXXTcKg1vs4p9yXoxxube1DBCmAInr5OtDq0PgsKxtMyGuz0qDKsNc9B/5Zufv3tvlcc6eK5NQDqq2sATuyVhbst4PpwTngBQspVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl1Crbea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl1Crbea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6271F000FF;
	Thu, 10 Sep 2026 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037119;
	bh=+1320aivpSdwPWFFHfm2vzl6g8OVaLd+u2NIsy7OER8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cl1CrbeaNgu8IDa2SZuNP8g+OXpucWBOSQg0KMzlTLEYg6pP1AqX+x+KrOOrEwprr
	 cmunbbtBs7ccih0kJ9yuAR6URS8XJhSEynpERCjoy1XU2ZzQ/ToDKIuxmn68GS01Mj
	 sBjb3WEuYL6oLMRtvGn7aWHa0UGCQq/Xo+nCj79f1XEtchis+g7mXTHDIJmwvKbLTH
	 hlA0jRRNn8xH734KHvk7b1atoIn0AZcNQSkrosiGuwybJd9q9WFXRTzNKFFTLgc4pl
	 lka0XODFo0tn44pgCtq5407Us47OcIvzdVQsvk8z9weQbvRidCdbcwn+I5BQSXjROP
	 ZDX2S8r2wFSig==
Date: Thu, 10 Sep 2026 12:45:10 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] sysctl: Make proc_doulongvec_ms_jiffies_minmax()
 enforce minmax again.
Message-ID: <l6n6b4hq63qvrefys4chliyip5kezzxuqrjz5wbtg3ulb4dyyp@zvfh4mov2q67>
References: <20260905233819.1064529-1-kuniyu@google.com>
 <20260905233819.1064529-3-kuniyu@google.com>
 <hbatn4h5342kuvni5jcfjpdfjfof7dbsld5m26x6dla7ennpey@usgxbvlikr4i>
 <CAAVpQUA0ZKAMkhGipXdGb=4o5GRG1dS1Pv11KWhxYqgXKsw1Sg@mail.gmail.com>
 <skrtuyahssx5tvphmvo3kbkqy475re5yeb2kdl6luf7kmmfqad@2gsivqhqwtvw>
 <CAAVpQUDOXfiVyuSgJ5HqZ=xX3aBM+Bar5i2Gmf8ur+jBT-74yA@mail.gmail.com>
 <yjcicbo7okgpkd6gh4exgagt2gkklnkbivq34i3ypksmnooxb4@3t4jfy6grwog>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="icy7yiidmc3jq3qw"
Content-Disposition: inline
In-Reply-To: <yjcicbo7okgpkd6gh4exgagt2gkklnkbivq34i3ypksmnooxb4@3t4jfy6grwog>


--icy7yiidmc3jq3qw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:04:12AM +0200, Joel Granados wrote:
> On Wed, Sep 09, 2026 at 10:07:53AM -0700, Kuniyuki Iwashima wrote:
> > On Wed, Sep 9, 2026 at 6:44=E2=80=AFAM Joel Granados <joel.granados@ker=
nel.org> wrote:
> > >
> > > On Tue, Sep 08, 2026 at 11:44:08AM -0700, Kuniyuki Iwashima wrote:
> > > > On Tue, Sep 8, 2026 at 5:15=E2=80=AFAM Joel Granados <joel.granados=
@kernel.org> wrote:
> > > > >
> > > > > On Sat, Sep 05, 2026 at 11:36:31PM +0000, Kuniyuki Iwashima wrote:
> > > > > > Since the cited commit changed proc_doulongvec_ms_jiffies_minma=
x()
> > > > > > to use proc_ulong_conv(), proc_doulongvec_ms_jiffies_minmax() no
> > > > > > longer applies the range check.
> > > > > >
> > > > > > It happened probably because do_proc_ulong_conv_ms_jiffies() do=
es
> > > > > > not have the _minmax suffix.
> > > > > >
> > > > > > In addition, sysctl_msecs_to_jiffies() casts u64 user input to =
u32,
> > > > > > and a truncated value could bypass the max check.
> > > > > This is something that is orthogonal to changing to true in the
> > > > > proc_ulong_conv call. Please put this in its own commit.
> > > > >
> > > > > This also begs the question: why not just use an int converter if=
 the
> > > > > range of the values is going to be u32?
> > > >
> > > > I guess people wanted to use ulong just because jiffies
> > > > is unsigned long.
> > > >
> > > > Looking at these users, none of them need the ulong range
> > > > and it can be u32 actually.
> > >
> > > Exactly. But changing those calls from ulong to uint is up to net and
> > > parport.
> >=20
> > Agreed, it should be done in the -next branch of each subsystem.
> >=20
> > And later, we can remove do_proc_ulong_conv_ms_jiffies().
> >=20
> >=20
> > > I'm more interested in defining the behavior in
> > > sysctl_u2k_ulong_conv_ms.
> > >
> > > Here is my train of thought:
> > > 1. u64 values will get truncated when they pass through msecs_to_jiff=
ies
> > >
> > > 2. The range of msecs_to_jiffies is:
> > >    [0, INT_MAX]          --->  ceil(m =C3=97 HZ / 1000)
> > >    [INT_MAX+1, UINT_MAX] --->  MAX_JIFFY_OFFSET
> > >
> > >    Which I interpret as whatever that falls out of [0, INT_MAX]
> > >    milliseconds is just infinite jiffies (MAX_JIFFY_OFFSET).
> >=20
> > nit: for HZ > 1000 (IIRC up to 1200 ?), the max of the range
> > gets a little bit smaller.
> >=20
> >=20
> > >
> > > 3. All but one users of do_proc_ulong_conv_ms_jiffies are bound to
> > >    values under MAX_JIFFY_OFFSET. The exception is net/rds/sysctl.c:67
> > >    that has a max of ~0UL (is this too high?).
> >=20
> > I think this is just set as the theoretical max of @jiffies,
> > but not specifically for the knob.
> >=20
> > The default of the knob is 1 sec (HZ), and even INT_MAX
> > (24 days) is too high for RDS reconnect.
> >=20
> >=20
> > >
> > > 4. Since milliseconds to jiffies should be capped at MAX_JIFFY_OFFSET
> > >    for big values. Should we just return MAX_JIFFY_OFFSET?
> > >    Like this:
> > >
> > >     diff --git i/kernel/time/jiffies.c w/kernel/time/jiffies.c
> > >     index 213ae1d6a014..400353b0d6f9 100644
> > >     --- i/kernel/time/jiffies.c
> > >     +++ w/kernel/time/jiffies.c
> > >     @@ -136,6 +136,8 @@ static int sysctl_k2u_int_conv_userhz(bool *n=
egp, ulong *u_ptr, const int *k_ptr
> > >
> > >      static ulong sysctl_msecs_to_jiffies(const ulong val)
> > >      {
> > >     +       if (val > UINT_MAX)
> > >     +               return MAX_JIFFY_OFFSET;
> >=20
> > Given the nit at 2., it should be like this
> >=20
> > if (val > jiffies_to_msecs(MAX_JIFFY_OFFSET))
> >     return MAX_JIFFY_OFFSET;
> >=20
> > as done in _msecs_to_jiffies().
>=20
> That is even better.
>=20
> Please send a V2 of the 3 fixes discussed and I'll push them through
> next week.

I have created [1] to test the fixes before pushing it upstream.
If you are ok with all my changes contained in [1], there is no need to
send V2. But if you want to change something, do send it out.

Best


[1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git=
/log/?h=3Djag/sysctl-fixes


--icy7yiidmc3jq3qw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqiijUACgkQupfNUreW
QU8xOwv+LPhBVsE6Il04c8tYQnOX8UgtkYxiTUDCBvguc/6HkZpctt5G0AOz387m
r+HvZ2zOEYQ8XtDH9Ijtl/uBSVl+VdrmJ8V+nQXGz7bHXB3IxiLwBNG0Ec9aaCln
9jcjuq2YB/JlcWA+h7HDkcKaITHYcZb3UjmjCWk5a4dQdEHqEA8w772AqAVhAW6J
sSdmM+9mWhW+Y6vbuBBJNlphIklgYRpSdE75cgsFy7TY6rFpCVZOQCypw9VC81Hx
U/J4mtEd0hMHhWEJJZbhdEoImXE8T180zPrhbEEwSTKjwuuY1r4orMs+QPZrSRj6
+RHre6d9hPrU9+B9Tpqa9621VP65pvo7uJjnRRPWqiuK9ey+mhwYVaevBs3wNXx8
GUrvioxS+fVWHWWKRPpu7AVaa3putS8ghgssr4ks4tX/WhvHwKrnmigcxkWLrjWi
HYhDByo0TlG27vebsbxNQnwwmDimy3vMTrxeSPsvL+M3OmPWYPJ2EkIFiJTHuCKk
FZLlrQTY
=2hZU
-----END PGP SIGNATURE-----

--icy7yiidmc3jq3qw--
