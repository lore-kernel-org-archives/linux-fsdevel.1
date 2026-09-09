Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAC554A7CA
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961463; cv=none; b=EoTlNK+jyrQPEQaQ+pgpqudIPtQqg1747G3ogimJesiW40BNDcKYqS0hz2M7QPleemMWPv+2szD3mFjKfRvaGfnF7wcQSUiOPy5IR/68abmbjssCmNzhyokxF1JSC7U9KnZ6HOfxB7YPA/STPICnjxjUQwnoBRnkvZemRBhaMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961463; c=relaxed/simple;
	bh=fGfDyBPXNYEZzSU+1kb7Dezvbgm3pJmxW0aN3zpuabw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLy+XUIU9launuPBDv962aVQiC6w6GSo0Oo7XEu4SDoAvzc05id1SvwyYRzW7iKNzQzXV6GdVi79dzCmTELdFLBDRygYbb3GW+zDPuN6uvnHclkY1T/19EaqgsFIRSt5vWebtD/q416iCOklZdGGnaru13iT5rzpckI0YPNoLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRc5CXAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRc5CXAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0178B1F00A3A;
	Wed,  9 Sep 2026 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961462;
	bh=sP9RHlKIwmJMkDU6UJF6wUzVVbPKkiOQVgUSPFI2Gr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IRc5CXAB0rMpe1m29F8sDmFvta24bAYHeyAl4KKW/24SxyyohHnqJckfnGt1E8vmY
	 w5yacwIQt5dxc6Sv+aPau92po3kFOeKghYr1q644RYn63aR+QLxMGhOfKSkvA9+Gzt
	 alMhxIfO1rBynGu1AOu2xgZoP9moxE3vo9ntr9uyY06SZ0FkPw+DrcEyAQQqD3EDbb
	 uTL0fBsM/abzTpX8UWsvULN3ur+qcWOaWgKxj8E8G0PFgcGn//NVSRsBs2tCCrw8Et
	 2DT8iEaralVLjcKEw1rUCSMRFaWNhw8VI4i7kpp7Mf6cRpZPI9SDdqddY0SHnzgmMo
	 CzzFOxm4eeUfQ==
Date: Wed, 9 Sep 2026 15:44:16 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] sysctl: Make proc_doulongvec_ms_jiffies_minmax()
 enforce minmax again.
Message-ID: <skrtuyahssx5tvphmvo3kbkqy475re5yeb2kdl6luf7kmmfqad@2gsivqhqwtvw>
References: <20260905233819.1064529-1-kuniyu@google.com>
 <20260905233819.1064529-3-kuniyu@google.com>
 <hbatn4h5342kuvni5jcfjpdfjfof7dbsld5m26x6dla7ennpey@usgxbvlikr4i>
 <CAAVpQUA0ZKAMkhGipXdGb=4o5GRG1dS1Pv11KWhxYqgXKsw1Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pmchw3m5vzglugwi"
Content-Disposition: inline
In-Reply-To: <CAAVpQUA0ZKAMkhGipXdGb=4o5GRG1dS1Pv11KWhxYqgXKsw1Sg@mail.gmail.com>


--pmchw3m5vzglugwi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 11:44:08AM -0700, Kuniyuki Iwashima wrote:
> On Tue, Sep 8, 2026 at 5:15=E2=80=AFAM Joel Granados <joel.granados@kerne=
l.org> wrote:
> >
> > On Sat, Sep 05, 2026 at 11:36:31PM +0000, Kuniyuki Iwashima wrote:
> > > Since the cited commit changed proc_doulongvec_ms_jiffies_minmax()
> > > to use proc_ulong_conv(), proc_doulongvec_ms_jiffies_minmax() no
> > > longer applies the range check.
> > >
> > > It happened probably because do_proc_ulong_conv_ms_jiffies() does
> > > not have the _minmax suffix.
> > >
> > > In addition, sysctl_msecs_to_jiffies() casts u64 user input to u32,
> > > and a truncated value could bypass the max check.
> > This is something that is orthogonal to changing to true in the
> > proc_ulong_conv call. Please put this in its own commit.
> >
> > This also begs the question: why not just use an int converter if the
> > range of the values is going to be u32?
>=20
> I guess people wanted to use ulong just because jiffies
> is unsigned long.
>=20
> Looking at these users, none of them need the ulong range
> and it can be u32 actually.

Exactly. But changing those calls from ulong to uint is up to net and
parport. I'm more interested in defining the behavior in
sysctl_u2k_ulong_conv_ms.

Here is my train of thought:
1. u64 values will get truncated when they pass through msecs_to_jiffies

2. The range of msecs_to_jiffies is:
   [0, INT_MAX]          --->  ceil(m =C3=97 HZ / 1000)
   [INT_MAX+1, UINT_MAX] --->  MAX_JIFFY_OFFSET

   Which I interpret as whatever that falls out of [0, INT_MAX]
   milliseconds is just infinite jiffies (MAX_JIFFY_OFFSET).

3. All but one users of do_proc_ulong_conv_ms_jiffies are bound to
   values under MAX_JIFFY_OFFSET. The exception is net/rds/sysctl.c:67
   that has a max of ~0UL (is this too high?).

4. Since milliseconds to jiffies should be capped at MAX_JIFFY_OFFSET
   for big values. Should we just return MAX_JIFFY_OFFSET?
   Like this:

    diff --git i/kernel/time/jiffies.c w/kernel/time/jiffies.c
    index 213ae1d6a014..400353b0d6f9 100644
    --- i/kernel/time/jiffies.c
    +++ w/kernel/time/jiffies.c
    @@ -136,6 +136,8 @@ static int sysctl_k2u_int_conv_userhz(bool *negp, u=
long *u_ptr, const int *k_ptr

     static ulong sysctl_msecs_to_jiffies(const ulong val)
     {
    +       if (val > UINT_MAX)
    +               return MAX_JIFFY_OFFSET;
            return msecs_to_jiffies(val);
     }


>=20
> net/rds/sysctl.c:58: .proc_handler   =3D proc_doulongvec_ms_jiffies_minma=
x,
> net/rds/sysctl.c:67: .proc_handler   =3D proc_doulongvec_ms_jiffies_minma=
x,
> net/rxrpc/sysctl.c:59: .proc_handler =3D proc_doulongvec_ms_jiffies_minma=
x,
> net/rxrpc/sysctl.c:68: .proc_handler =3D proc_doulongvec_ms_jiffies_minma=
x,
> drivers/parport/procfs.c:369: .proc_handler =3D proc_doulongvec_ms_jiffie=
s_minmax,
> drivers/parport/procfs.c:399: .proc_handler =3D proc_doulongvec_ms_jiffie=
s_minmax,
>=20
>=20
<...snip...>
> >   do_proc_vec") incorrectlry removed. Append "_minmax" to the end of the
> >   do_proc_ulong_conv_ms_jiffies so it is clear that there should be a
> >   range check.
> >
> >   Fixes: b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec w=
ith do_proc_vec")
> >   Signed...
> >
> >
> >
> >
> > >
> > > --
> > > 2.55.0.1003.g10538fe699-goog
> > >

Best

Joel

--pmchw3m5vzglugwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqhYrAACgkQupfNUreW
QU8s7wwAgep+QGVg4fCRfsQvdJWsS/mrG+0cm+8vxU+IY+CRQFwFwDVmf+C4toFF
ZMKwu8cvkf4m1yWyox42x9Eo+gZc7M5f0LxdC0hqy5leBaAF4eUnD4mjFvLzeJkG
CcqwvR1Rhk9t9nAQNZEitMzdLz71lLfTgbG+mO6YmI4rK5CWQGbR4Wb+rymoqtbW
ZICKmQzJZyWgTE36YttX8k4drOovdaaZHYIWK5+eDPdx4AL9jjxz3Hn8RlUv3xe3
2QWiRtosETlxcZuCZJNjCrpXEmVLremWHyQXFBgdQtWiMAADWIyy2kCmz4ECZs2H
SuHJTYvD0UPj7KLh9/4Xv+rrY0VgzPLt8Qwou28nys2bU5Lf4PKpwfaepBETNVuX
CXxwBmEppjUVw+B+X/dTkGo0QDs+vH2F6UT09qfT9ewoPyausznyCHNBH4W7uO68
B9c+9xiSAV3NJhKWoJyPXjXsg0ZEYuoQhZUkK5Kp0VYaOmTgf9vGp6OOllS6xZ2S
SVdv/0vS
=6Tvg
-----END PGP SIGNATURE-----

--pmchw3m5vzglugwi--
