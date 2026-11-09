Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218828;
	b=yMaHZJDJcJZIaVM5WLjKJSV6abejgeOxBmV1vOiUhMXw9cWd2Pte0Gn8T3qCGsER477a
	 f3VGT7ni89FatB/VJEowEc9sf2jMPUbXoEkAkS77LYMpJDCMrg0KSSwksPZHBQLU9AZfM
	 zpFZPSei1jK0W6QeX9mReUDqhRjP3qDhwwbb7aURbCFrGJ7KCe03e0wNhcf7uPuVOPpW7
	 Heh1LWFQuNu9L2AgstB2s85pxu4A5Jm5XFeqAlMINEwdR/0prBs66rXM0p1yuDFBwj9wj
	 IMH8Ftc89iCEdbfHZDnwwGJ4U11/Dc+IJf9aBsDCdzVfd3S6jWtqJ1xPsLF0JKzeJow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218828;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HrsIsrqSYPkZUAPyuLllNQ1aS8CwBsDo/9IWKIbJVfA=;
	b=0kI6jY9toj2LzjT5TvLGwQgwaWU4qBG5z9akGfJ32jbBiCXRM+TniMnAY7hB4JtrHGjX
	 tK6lz06wTIQna/g9Guj/qGEcrmYd50JvTh60QNDhJVsOtcArU8Xu66FFlLLdt+RoKcu43
	 g5NYyOiVD6jBBERSXBU7hyaAc3LAzdmviIrJ+OSLs9n/2T09QO8AqBk8VC0Lx47xkk4v2
	 78IldNMZoUK1kSwaJJ5QNQP7jV58HBYDpfCAppuJ0S1o3KhQ/mhuP1wD5+droEX7KlU39
	 v1hF5muVF7LhPdSBwm6m6hpWmb0ncGv18GiB8RPec1MBIfdji9S36qCTiz/8Q3EdOEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VI8yRdjT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA8606A31C;
	Mon,  9 Nov 2026 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VI8yRdjT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF831F0089F;
	Mon,  9 Nov 2026 10:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794218827;
	bh=HrsIsrqSYPkZUAPyuLllNQ1aS8CwBsDo/9IWKIbJVfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VI8yRdjT7fBUJPMzLDt2H1mylAHBDLlQ55kdtzz7yVjxHqcA+QOMLSIVo/0wAASYr
	 Z7RWNX7Rl6RZSi2UO1oZcZLnKAgL4RvLRpLBeuktP+gpX0Swtyk9ZyQE+Q45VRjWUw
	 c8aEFA+Ptp3OuOOCwk8S/PdY0vaPOB5Jk9HKxHbc4OLf3KUIze/wW8BnNEKKOkmUSa
	 kobRALJLj0KzreD1irfZSMicoRE4Ip8wU6ZgPoI2iyNxQUHX+cIk/Mw/Kzv4W0PZfP
	 DMXxH0Nmz8xusIV4oT54nW+mLJXVgXgzLL2VA7510LUb921GAZ+85Y9dwBPem3eNP0
	 sTEkwfeY2T67g==
Date: Mon, 9 Nov 2026 11:07:02 +0100
From: Joel Granados <joel.granados@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Wen Yang <wen.yang@linux.dev>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
Message-ID: <avGVyB9erjZl8zIO@hobbes>
References: <cover.1793204511.git.wen.yang@linux.dev>
 <20261029105837.2f8bee67@pumpkin>
 <0316f664-d98c-43be-92af-13c30436727a@linux.dev>
 <au85ISJ2qUsB7y-6@hobbes>
 <20261107170507.0d66cc2e@pumpkin>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zykn2ejteafndfrg"
Content-Disposition: inline
In-Reply-To: <20261107170507.0d66cc2e@pumpkin>


--zykn2ejteafndfrg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
MIME-Version: 1.0

On Sat, Nov 07, 2026 at 05:05:07PM +0000, David Laight wrote:
> On Sat, 7 Nov 2026 16:27:39 +0100
> Joel Granados <joel.granados@kernel.org> wrote:
>=20
> > On Mon, Nov 02, 2026 at 11:40:40PM +0800, Wen Yang wrote:
> > >=20
> > >=20
> > > On 10/29/26 18:58, David Laight wrote: =20
> > > > On Thu, 29 Oct 2026 00:34:39 +0800
> > > > wen.yang@linux.dev wrote:
> > > >  =20
> > > > > From: Wen Yang <wen.yang@linux.dev>
> > > > >=20
> > > > > struct ctl_table describes an entry with data, maxlen and, until =
this
> > > > > series, two untyped misc pointers in extra1 and extra2. Those two=
 pointers
> > > > > have accumulated at least seven unrelated jobs: a fixed bound, a =
bound read
> > > > > through a pointer on every call, an object or namespace pointer, =
a small
> > > > > integer cookie encoded into the pointer, a lock signal, NULL stan=
ding for
> > > > > "no bound", and a value the core itself casts to unsigned int whi=
le
> > > > > validating a u8 range. Nothing in the entry says which job applie=
s, so
> > > > > readers infer it from the handler, and the core gets it wrong whe=
re it
> > > > > treats extra1 as an unsigned int. =20
> > <--- snip --->
> > > > > (~574 new min/max initializers) instead of pointing at constants.=
 The
> > > > > sysctl ABI is unchanged; the parport spintime minimum is correcte=
d as
> > > > > described above.
> > > > >=20
> > > > > The cost is 8 bytes per ctl_table entry on 64-bit (56 -> 64) and =
4 bytes on
> > > > > 32-bit, because priv is appended; the range read path gains no in=
direction
> > > > > and the migrated entries no longer dereference a bound pointer. =
=20
> > > >=20
> > > > Can you remove the little-used 'priv' parameter by making the extra
> > > > information just follow the table entry (nested structure) and have
> > > > the relevant functions use container_of() to get the outer structure
> > > > and extra values?
> > > >  =20
> > >=20
> > >=20
> > > Hi David, Hi Joel,
> > >=20
> > > I reworked the context side of the series so that priv is gone entire=
ly;
> > > and the final tree has no per-entry context pointer.
> > > A small helper recovers the enclosing object, but it needs the slot
> > > index from the caller:
> > >=20
> > >   #define sysctl_table_container(entry, type, member, index) ({      =
 \
> > >           static_assert(__same_type(*(entry),                        =
 \
> > >                                     typeof_member(type, member[0])), =
 \
> > >                         "pointer type mismatch");                    =
 \
> > >           (type *)((void *)(entry) - offsetof(type, member) -        =
 \
> > >                    (size_t)(index) * sizeof(*(entry)));              =
 \
> > >   })
> > >=20
> > > The reason plain container_of() is not enough is that the core keeps =
the
> > > table as a contiguous array.  For
> > >=20
> > >   struct addrconf_sysctl_table {
> > >           struct addrconf_sysctl_ctx context;
> > >           struct ctl_table table[];
> > >   };
> > >=20
> > > the handler receives an interior entry, and
> > >=20
> > >   container_of(ctl, struct addrconf_sysctl_table, table)
> > >       =3D=3D (char *)outer + index * sizeof(struct ctl_table)
> > >=20
> > > for ctl =3D=3D &outer->table[index].  It only returns the outer objec=
t for
> > > index 0.  Passing the index explicitly keeps the original registered
> > > entry usable:
> > >=20
> > >   static int addrconf_sysctl_forward(const struct ctl_table *ctl, ...)
> > >   {
> > >           struct addrconf_sysctl_table *t =3D
> > >                   sysctl_table_container(ctl, struct addrconf_sysctl_=
table,
> > >                                          table, ADDRCONF_SYSCTL_FORWA=
RDING);
> > >           const struct addrconf_sysctl_ctx *ctx =3D &t->context;
> > >           ...
> > >   }
> > >=20
> > > Shared handlers get one wrapper per slot; the common body does not ne=
ed
> > > to know its position:
> > >=20
> > >   #define DEVINET_CONF_WRAPPER(attr)                                 =
 \
> > >   static int devinet_conf_##attr(const struct ctl_table *ctl, ...)   =
 \
> > >   {                                                                  =
 \
> > >           struct devinet_sysctl_table *t =3D                         =
   \
> > >                   sysctl_table_container(ctl,                        =
 \
> > >                           struct devinet_sysctl_table, devinet_vars, =
 \
> > >                           IPV4_DEVCONF_##attr - 1);                  =
 \
> > >           return devinet_conf_proc_common(ctl, &t->context, ...);    =
 \
> > >   } =20
> >=20
> > Two questions before seeing the actual implementation of this.
> >=20
> > 1. This means that we will have to add more macros to the sysctl
> >    callers? There is a clear signal in [1] against overuse of macros.
> > 2. I understand that you are doing this to avoid having priv. Is it to
> >    save memory?  Yes. priv is a void* and we are also trying to get rid
> >    of these. But this changes removes the use of two void pointers and
> >    replaces it with just one.
>=20
> The idea behind removing the 'void *priv' is mostly to save memory.
> There are a lot of systctl and hardly any need it.
>=20
> This solution does look nasty.
> I suggested another where the size of the array entries was passed in
> by the caller.
That would mean changing all the proc handler signature. Right?

> If that works it would allow the per-value function use container_of()
> to get extra fields.
Would this mean that the callers would have to have to keep track of the
ctl_table offsets? in other words the sysctl indices and the caller's
indices would have to be synced. right? This goes a bit against the
second point in [1]. Which I'm still willing to live with, but worth
avoiding if it can be done.

Best

[1] https://lore.kernel.org/atoDngZsxy3TWmO_@hobbes


> That only really helps if only a few 'private' functions need it.
>=20
> David
>=20



> >=20
> > Best
> >=20
> > [1] https://lore.kernel.org/CAHk-=3DwjUmLrJd4KM4xvJHUN4P0r8oSu5LyvG4Jip=
nhxizBrE9Q@mail.gmail.com
> > >=20
> > > Single-entry tables simply use slot 0:
> > >=20
> > >   struct devinet_forward_table *t =3D
> > >           sysctl_table_container(ctl, struct devinet_forward_table, t=
able,
> > > 0);
> > >=20
> > >=20
> > > The series is 20 commits over 134 files, with no priv at any point.  =
If
> > > you would prefer a different shape for the helper or the wrappers, I =
am
> > > happy to adjust it.
> > >=20
> > >=20
> > > Thanks,
> > > Wen
> > >  =20
> > > > David
> > > >  =20
>=20

--zykn2ejteafndfrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrxm0UACgkQupfNUreW
QU8R7wv/aad4+doUCBbcOxH5zO2Rg4nvC7cOKpkalU4+WbIGiThVH77rYtuPS1ZC
ZgzUgOfOJPgdPYM300e7A17yZ6B3VKJwTM0X731XYnahP2q9lIOJGw6CKigHN3Vh
mu/tMoqZcfYttH2EdT3rFcuha8oXC1buECEZX91dZKBSjUAT1ma6jl0gTTrP0RmD
3YWzjd90LGIzcjb2oMrmYBVXU1jBdDR0VXot52104wS08MW1djXpcLZERt2bNIoU
hdGEf7nHcvqvQv1c5s/RweZHprTn8nwU0c2umj7dTTWiUCOnaWoZLk+/AmVCJJpB
zB9Oqeh3Lnt9SmuSM+zL9+ySGlWPUnqZzeY5UusU6yNY29A0yGQjApO5/Xqs3jqw
HTAtBh0QiGeO/8TwIhHgLCgVSf/QbU7Gt/rHOG0h7aBEeSvmzTsrJ6fiHdVgc1AV
OCBgxTc45IN68n6bm3zkgXk/gjbmx5fXc/JV2kwoKwfeDNG2eQNZElE3aJBSZX80
+CAc1KVV
=YBJs
-----END PGP SIGNATURE-----

--zykn2ejteafndfrg--
