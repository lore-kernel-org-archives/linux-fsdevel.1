Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACAF3F8251
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117178; cv=none; b=oFPx6+GJR2EH/0wNguE6ycA+C4tS+M27Y31zkKCDK2D5OmL6+dASFQEjIHXMDYI7hoVXDbFKbXQLS4g+WtTbbQ9WFwNLOF0E6cS4H9XUMa/eIlAbLnPiNWTUY2O9FVfgzIpdF5l3x1qSYOk4s2t5cFPhMMGa5Q4n8hsqCBbEv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117178; c=relaxed/simple;
	bh=Zp4f5T4HItD3vFpjoIgndCvCdVlfwX8d2DutZftq7t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE3J+Ii8CHgCCiHr6GM42/Kgdeh0pGcMpbyK1SkIpD+/hfcL+L0Z0MC9ypaDLipxouoR52zsvSOD4tF72p/86BQCmvTUpRaeOPs09EF/Ua3zDI66MDu3IpIxmXQ6OBXpH37OvZfqRCrC0bMrmUGvZvS+l2I3TiA9eFY6APkBPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCrK4gF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCrK4gF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA1C1F000FF;
	Fri, 11 Sep 2026 08:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117176;
	bh=eIeilX92bc+iBaEJ6dyPC3t95vWWihFrsch1owrBu5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mCrK4gF92GzIe4XwdczWgc1noR4oKosIeAQFOdnccYgMg1AqZ7PXi/RJCrJAtluJJ
	 K0mZvS5KJ834C+9/ztBu7mmMec2qDQtvZrxQdap2L9hMIW6ZQ4ZOdHvePP5pFvVc9X
	 ZVJw8eiEJ+RMttQdlwWAXDp6dnkiRy6Erx74YmMHmUlNupVELROyIhEXAQmsUBPQ9V
	 sJWlX73nc2IYPF7vSCXmt2ESOVYuh5NEvhDn1ze2drdhrrOc4u5biWKd1oYpHogOfG
	 4zdu2xdZc5x4+gu+t+5MjXrIl37k+JTmerK/h9rdxCHgaO8ETWfds4XFdL6uFFpiXe
	 6rH7yG8VSymyw==
Date: Fri, 11 Sep 2026 10:59:31 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] sysctl: Make proc_doulongvec_ms_jiffies_minmax()
 enforce minmax again.
Message-ID: <xfgyqifrwew72b3zsfwksixrfgfkxstjeuvwbl35rxwkc67223@wlejfenvjipo>
References: <20260905233819.1064529-1-kuniyu@google.com>
 <20260905233819.1064529-3-kuniyu@google.com>
 <hbatn4h5342kuvni5jcfjpdfjfof7dbsld5m26x6dla7ennpey@usgxbvlikr4i>
 <CAAVpQUA0ZKAMkhGipXdGb=4o5GRG1dS1Pv11KWhxYqgXKsw1Sg@mail.gmail.com>
 <skrtuyahssx5tvphmvo3kbkqy475re5yeb2kdl6luf7kmmfqad@2gsivqhqwtvw>
 <CAAVpQUDOXfiVyuSgJ5HqZ=xX3aBM+Bar5i2Gmf8ur+jBT-74yA@mail.gmail.com>
 <yjcicbo7okgpkd6gh4exgagt2gkklnkbivq34i3ypksmnooxb4@3t4jfy6grwog>
 <l6n6b4hq63qvrefys4chliyip5kezzxuqrjz5wbtg3ulb4dyyp@zvfh4mov2q67>
 <CAAVpQUDtfWQVBj6Vhtn1wGUZz4H46XXuit_G=YyxrJHUxT_=_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ywhgclbll4x4x5ky"
Content-Disposition: inline
In-Reply-To: <CAAVpQUDtfWQVBj6Vhtn1wGUZz4H46XXuit_G=YyxrJHUxT_=_g@mail.gmail.com>


--ywhgclbll4x4x5ky
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 09:43:29AM -0700, Kuniyuki Iwashima wrote:
> On Thu, Sep 10, 2026 at 3:45=E2=80=AFAM Joel Granados <joel.granados@kern=
el.org> wrote:
> >
> > On Thu, Sep 10, 2026 at 11:04:12AM +0200, Joel Granados wrote:
> > > On Wed, Sep 09, 2026 at 10:07:53AM -0700, Kuniyuki Iwashima wrote:
> > > > On Wed, Sep 9, 2026 at 6:44=E2=80=AFAM Joel Granados <joel.granados=
@kernel.org> wrote:
> > > > >
> > > > > On Tue, Sep 08, 2026 at 11:44:08AM -0700, Kuniyuki Iwashima wrote:
> > > > > > On Tue, Sep 8, 2026 at 5:15=E2=80=AFAM Joel Granados <joel.gran=
ados@kernel.org> wrote:
> > > > > > >
> > > > > > > On Sat, Sep 05, 2026 at 11:36:31PM +0000, Kuniyuki Iwashima w=
rote:
> > > > > > > > Since the cited commit changed proc_doulongvec_ms_jiffies_m=
inmax()
> > > > > > > > to use proc_ulong_conv(), proc_doulongvec_ms_jiffies_minmax=
() no
> > > > > > > > longer applies the range check.
> > > > > > > >
> > > > > > > > It happened probably because do_proc_ulong_conv_ms_jiffies(=
) does
> > > > > > > > not have the _minmax suffix.
> > > > > > > >
> > > > > > > > In addition, sysctl_msecs_to_jiffies() casts u64 user input=
 to u32,
> > > > > > > > and a truncated value could bypass the max check.
> > > > > > > This is something that is orthogonal to changing to true in t=
he
> > > > > > > proc_ulong_conv call. Please put this in its own commit.
> > > > > > >
> > > > > > > This also begs the question: why not just use an int converte=
r if the
> > > > > > > range of the values is going to be u32?
> > > > > >
> > > > > > I guess people wanted to use ulong just because jiffies
> > > > > > is unsigned long.
> > > > > >
> > > > > > Looking at these users, none of them need the ulong range
> > > > > > and it can be u32 actually.
> > > > >
> > > > > Exactly. But changing those calls from ulong to uint is up to net=
 and
> > > > > parport.
> > > >
> > > > Agreed, it should be done in the -next branch of each subsystem.
> > > >
> > > > And later, we can remove do_proc_ulong_conv_ms_jiffies().
> > > >
> > > >
> > > > > I'm more interested in defining the behavior in
> > > > > sysctl_u2k_ulong_conv_ms.
> > > > >
> > > > > Here is my train of thought:
> > > > > 1. u64 values will get truncated when they pass through msecs_to_=
jiffies
> > > > >
> > > > > 2. The range of msecs_to_jiffies is:
> > > > >    [0, INT_MAX]          --->  ceil(m =C3=97 HZ / 1000)
> > > > >    [INT_MAX+1, UINT_MAX] --->  MAX_JIFFY_OFFSET
> > > > >
> > > > >    Which I interpret as whatever that falls out of [0, INT_MAX]
> > > > >    milliseconds is just infinite jiffies (MAX_JIFFY_OFFSET).
> > > >
> > > > nit: for HZ > 1000 (IIRC up to 1200 ?), the max of the range
> > > > gets a little bit smaller.
> > > >
> > > >
> > > > >
> > > > > 3. All but one users of do_proc_ulong_conv_ms_jiffies are bound to
> > > > >    values under MAX_JIFFY_OFFSET. The exception is net/rds/sysctl=
=2Ec:67
> > > > >    that has a max of ~0UL (is this too high?).
> > > >
> > > > I think this is just set as the theoretical max of @jiffies,
> > > > but not specifically for the knob.
> > > >
> > > > The default of the knob is 1 sec (HZ), and even INT_MAX
> > > > (24 days) is too high for RDS reconnect.
> > > >
> > > >
> > > > >
> > > > > 4. Since milliseconds to jiffies should be capped at MAX_JIFFY_OF=
FSET
> > > > >    for big values. Should we just return MAX_JIFFY_OFFSET?
> > > > >    Like this:
> > > > >
> > > > >     diff --git i/kernel/time/jiffies.c w/kernel/time/jiffies.c
> > > > >     index 213ae1d6a014..400353b0d6f9 100644
> > > > >     --- i/kernel/time/jiffies.c
> > > > >     +++ w/kernel/time/jiffies.c
> > > > >     @@ -136,6 +136,8 @@ static int sysctl_k2u_int_conv_userhz(boo=
l *negp, ulong *u_ptr, const int *k_ptr
> > > > >
> > > > >      static ulong sysctl_msecs_to_jiffies(const ulong val)
> > > > >      {
> > > > >     +       if (val > UINT_MAX)
> > > > >     +               return MAX_JIFFY_OFFSET;
> > > >
> > > > Given the nit at 2., it should be like this
> > > >
> > > > if (val > jiffies_to_msecs(MAX_JIFFY_OFFSET))
> > > >     return MAX_JIFFY_OFFSET;
> > > >
> > > > as done in _msecs_to_jiffies().
> > >
> > > That is even better.
> > >
> > > Please send a V2 of the 3 fixes discussed and I'll push them through
> > > next week.
> >
> > I have created [1] to test the fixes before pushing it upstream.
> > If you are ok with all my changes contained in [1], there is no need to
> > send V2. But if you want to change something, do send it out.
>=20
> Patch 2 has a typo "incorrectlry", but otherwise looks good to me.
Will adjust=20

> Feel free to push them with it fixed.

Thx for the bugfixes!!

--ywhgclbll4x4x5ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqjwuwACgkQupfNUreW
QU8mzwwAkkFeDeu9H4vfPU9nOvwitb9qhlLMrR6WbKAIZv33IQef+FNtBknss6s4
MPu1pAHQV8M5qKezTRWERRVxhjTb1T8ehSOSHh8tdSdl99E5Khm3kobVWlKHOh/v
eUBJBe/jTfmQwpikAn9gkLjJ3xksmBT2WjI9pU41Nwyp0w195oau8sJvttyzt/Rs
wZAvtVS2avTsXom4abHHzt+8EpTphQ/2ljL4xcQ9U8JB4k8GE0mPVM4FvRbO52PB
bgh/vAG67Mam4QpUfKBw0hP5wzS9+vKS/OP7qg6IIXL1i+24tCo5WpGgnnVajsEJ
KIEnq4IEhXA21txjxRwleuh7S/8kKP8BBDst8Y8Obz2txnbHG0HZYcdufTzsVec2
wmrTEMQwPvA+BZQ0Z7ZN4RLzMDC1J+gw5BPFLfQP8/LC9Kj/ETK9cmSafJBX61Qm
wUD+RsyPIxkLmxGoRehKtU1P7zs9ws9vc5Apu4JR/uUkbLM10mrWmGJLapX9o6RQ
wYV++qHF
=/+Bo
-----END PGP SIGNATURE-----

--ywhgclbll4x4x5ky--
