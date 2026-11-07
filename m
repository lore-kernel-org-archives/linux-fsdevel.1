Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794065274;
	b=s4Y0TbbcLKFZaDKuiuucKHd65CcAABBm++EwgjoE9kyA++09NCYm9aSFc2UbchdGIHjt
	 pUGaAzbyz6bmTncW9RY/DU43xG6AfatOaQFQbgJ+Amht+wU73hH/Sw8Ebjd57BlbcKGDI
	 mUESZpi1yBwQXg+bjZc+6bOUqfJlWAKGlEgyUmhSmSZSDE2ESI+ePA+7Z/pc4HvqLUX5q
	 8Qf+xbXVUKuWWlZ6rIcK1CbxQiMlHpP4NSHB9a++NX2nPvOx/o8fDIBKcXfnaPQHiovxr
	 5x0J4k3yoLkaKK/7qg9F5UuQ/t7breAAINXcMlT9ItQkYYLlYKvEN36dOFS46Y6VLEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794065274;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ph2t4knCJOyucU1WzKS5xblnUdrZ8Cbp0nWPL8wGjTU=;
	b=gIxIohLzwO+gE9gm2ym4Co7A9Cnq+fshJiWGGg5Z2pFVtltjraXLFHJ27i8DGiuQGeXx
	 m4XYd1x3iH6her7qGf2AYGNogZrLgtyVgWBFWFFK1A78rM+RfSMRXfdO8kQQE7dfB9dgv
	 IlqS1DuJHCGM7YPVzRRZnsc/Pc4+hJ5l6z9XeGf/pS9J250XFy3tus6wIatsW1PA1PH93
	 qNxLh9RodynwvOAva68TdoQGFJUDy3co36vxnZ9Q15HBc2kdZDeEzQQcqlkwTxZD3MzWM
	 9fuQNhZiNgrklflGAgvuvqG44ejkvV3OyaJS9YkQQcQc+h1KN7KN3XrMLp5s4fkkdFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QlEK02+Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA58606A326;
	Sat,  7 Nov 2026 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QlEK02+Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159EA1F0089F;
	Sat,  7 Nov 2026 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794065273;
	bh=Ph2t4knCJOyucU1WzKS5xblnUdrZ8Cbp0nWPL8wGjTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QlEK02+ZHmhnxP31ehAeA2Juadksl6+HcJm1iqoMA/FBqYvha/Oe+18fvSZzPcgjL
	 lxlq1zOl+sNyMeJJ1HYCSiFBebHo3ktJYiW95XW6a7OIQrjWbTAYLRXH4V0L3P9R3d
	 EbnQBatdHYDew1aO5p5Vkx6qTEv5hq9IGSDvu18jviNrZwoNtqKTzNIRXrkkxPIwn3
	 HW+vDh7J2VBZhYT5jQKOzcj1u5snXjmQy0KRwfmJ+7RD4xyNfT1thuW9L5WQpBJzN5
	 Fw+tyIOAy8gYj56IUuYsM1ElORAv6btJqLxuLDHgVj4+KYb6KRM0WP/x2SBeSug8Je
	 JBqbj+8mU78KQ==
Date: Sat, 7 Nov 2026 16:27:39 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: David Laight <david.laight.linux@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
Message-ID: <au85ISJ2qUsB7y-6@hobbes>
References: <cover.1793204511.git.wen.yang@linux.dev>
 <20261029105837.2f8bee67@pumpkin>
 <0316f664-d98c-43be-92af-13c30436727a@linux.dev>
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
	protocol="application/pgp-signature"; boundary="izytb5obkgwh663k"
Content-Disposition: inline
In-Reply-To: <0316f664-d98c-43be-92af-13c30436727a@linux.dev>


--izytb5obkgwh663k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 11:40:40PM +0800, Wen Yang wrote:
>=20
>=20
> On 10/29/26 18:58, David Laight wrote:
> > On Thu, 29 Oct 2026 00:34:39 +0800
> > wen.yang@linux.dev wrote:
> >=20
> > > From: Wen Yang <wen.yang@linux.dev>
> > >=20
> > > struct ctl_table describes an entry with data, maxlen and, until this
> > > series, two untyped misc pointers in extra1 and extra2. Those two poi=
nters
> > > have accumulated at least seven unrelated jobs: a fixed bound, a boun=
d read
> > > through a pointer on every call, an object or namespace pointer, a sm=
all
> > > integer cookie encoded into the pointer, a lock signal, NULL standing=
 for
> > > "no bound", and a value the core itself casts to unsigned int while
> > > validating a u8 range. Nothing in the entry says which job applies, so
> > > readers infer it from the handler, and the core gets it wrong where it
> > > treats extra1 as an unsigned int.
<--- snip --->
> > > (~574 new min/max initializers) instead of pointing at constants. The
> > > sysctl ABI is unchanged; the parport spintime minimum is corrected as
> > > described above.
> > >=20
> > > The cost is 8 bytes per ctl_table entry on 64-bit (56 -> 64) and 4 by=
tes on
> > > 32-bit, because priv is appended; the range read path gains no indire=
ction
> > > and the migrated entries no longer dereference a bound pointer.
> >=20
> > Can you remove the little-used 'priv' parameter by making the extra
> > information just follow the table entry (nested structure) and have
> > the relevant functions use container_of() to get the outer structure
> > and extra values?
> >=20
>=20
>=20
> Hi David, Hi Joel,
>=20
> I reworked the context side of the series so that priv is gone entirely;
> and the final tree has no per-entry context pointer.
> A small helper recovers the enclosing object, but it needs the slot
> index from the caller:
>=20
>   #define sysctl_table_container(entry, type, member, index) ({       \
>           static_assert(__same_type(*(entry),                         \
>                                     typeof_member(type, member[0])),  \
>                         "pointer type mismatch");                     \
>           (type *)((void *)(entry) - offsetof(type, member) -         \
>                    (size_t)(index) * sizeof(*(entry)));               \
>   })
>=20
> The reason plain container_of() is not enough is that the core keeps the
> table as a contiguous array.  For
>=20
>   struct addrconf_sysctl_table {
>           struct addrconf_sysctl_ctx context;
>           struct ctl_table table[];
>   };
>=20
> the handler receives an interior entry, and
>=20
>   container_of(ctl, struct addrconf_sysctl_table, table)
>       =3D=3D (char *)outer + index * sizeof(struct ctl_table)
>=20
> for ctl =3D=3D &outer->table[index].  It only returns the outer object for
> index 0.  Passing the index explicitly keeps the original registered
> entry usable:
>=20
>   static int addrconf_sysctl_forward(const struct ctl_table *ctl, ...)
>   {
>           struct addrconf_sysctl_table *t =3D
>                   sysctl_table_container(ctl, struct addrconf_sysctl_tabl=
e,
>                                          table, ADDRCONF_SYSCTL_FORWARDIN=
G);
>           const struct addrconf_sysctl_ctx *ctx =3D &t->context;
>           ...
>   }
>=20
> Shared handlers get one wrapper per slot; the common body does not need
> to know its position:
>=20
>   #define DEVINET_CONF_WRAPPER(attr)                                  \
>   static int devinet_conf_##attr(const struct ctl_table *ctl, ...)    \
>   {                                                                   \
>           struct devinet_sysctl_table *t =3D                            \
>                   sysctl_table_container(ctl,                         \
>                           struct devinet_sysctl_table, devinet_vars,  \
>                           IPV4_DEVCONF_##attr - 1);                   \
>           return devinet_conf_proc_common(ctl, &t->context, ...);     \
>   }

Two questions before seeing the actual implementation of this.

1. This means that we will have to add more macros to the sysctl
   callers? There is a clear signal in [1] against overuse of macros.
2. I understand that you are doing this to avoid having priv. Is it to
   save memory?  Yes. priv is a void* and we are also trying to get rid
   of these. But this changes removes the use of two void pointers and
   replaces it with just one.

Best

[1] https://lore.kernel.org/CAHk-=3DwjUmLrJd4KM4xvJHUN4P0r8oSu5LyvG4Jipnhxi=
zBrE9Q@mail.gmail.com
>=20
> Single-entry tables simply use slot 0:
>=20
>   struct devinet_forward_table *t =3D
>           sysctl_table_container(ctl, struct devinet_forward_table, table,
> 0);
>=20
>=20
> The series is 20 commits over 134 files, with no priv at any point.  If
> you would prefer a different shape for the helper or the wrappers, I am
> happy to adjust it.
>=20
>=20
> Thanks,
> Wen
>=20
> > David
> >=20

--izytb5obkgwh663k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrvQ2QACgkQupfNUreW
QU8nhgv/bOtQvxtZIW9FR4G5+avco51TQR3Rx2Cb+L6Hb2JDt4cm1xIGlE4DzoZC
AqwnuTVyvHXmSTZ14YXgUPtgnB6bdfMq+uXX3wuIP/wflX3WknrpcQst2lznVje7
tgXZvBiIULte8LblHlXULFm+Jrp5zJmWN9U4HU8LqJ1rieZrin5J93c/9362gU7z
xHQdFjwKYbUVaYsVb2bwvhdm/Q+6Y0HhqaSEV3HrV3IuyPoqqWpLkg3Rkn2EgQt2
pYea7y2PGh9B414D/mTFU2VV/lUYHxLwMAm7Zk10T3GSDU5ts8/Vg776koYnnVlM
gXjvj0KazVj4y8nHD6NbrHqQ8tnEUldj8QoJ3R26WJhCPUCYzFQA6I5dbLOlj/1/
jPhgJJ/3YpQY9vF3R7X0Lx35D5V2tSnPoVreWAk+cZQ6P+fRYYRTivDO4Hh6qlyc
jANi09hOu2gJYeSVlzYOZBsXu87rIbC02Lsgu99zvXC64g517ryvsvgmwm8bPuzv
cEFzHXHX
=NJK7
-----END PGP SIGNATURE-----

--izytb5obkgwh663k--
