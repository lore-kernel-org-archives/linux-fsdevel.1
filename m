Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216361;
	b=OolfIzqpb3VIjb4qxxbkRUkZBaSeW46qxnpMOxwmkyTsND/XJ0s876ct+pv6bb/hVaXq
	 expjethWpJZidJMb7ygaWxEyOruYRxopnlk59kzDMcKwUoKo1ogEWYVfeg/m74sm8OSVy
	 3FUP5iMt4Yxwoy0iiharlLuwoMWpr9vO/orO92MJ6ZtCEjABqCEML5vYFMW+VTAsyB1OA
	 frRfEWs/sZvdsov/mgf35eMFJ5Ai24vJwl7BG/YrTkh/f7et6wpr6TZFw+x/f7DYY1E05
	 YNlLPbs1SDdgpuOnxLN2s4L2SMIF+iIppcHJq6cg2nQZBZ5DKHZM0lwf5lyPE/MFGrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216361;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UfmlPYw1M6tfZZ0BVl3ZtV0mI3ANbCo1r8noEBOul3U=;
	b=SeYR1mctuYPfP4YiHxGyOeKLG4QqzBDf7EgxK8w+ElJidazSLqf0TziLyY3qHIEx73QH
	 Sa6Q/yv/LquYNkHKmfXL5rgHMeCRONcGTw0LgQ1nRFopMjBgGbBqntT+y4LIN9vU3Tahl
	 4BPK9Dr83LyBRYtLqWdhARqQ5v5/UloXAWd9SNFPQb4vyt6BXVa0YY+XmhZVfLf7iDRGi
	 K1K+5XskyBba3K/GAU0aLy/udRTaHvkJaO1h4I2lNLbVJBVDlTzsBw4Q+Q1Q2d1cYgomk
	 /OyoIfIPTCkwcUyrpbe+02NnjbSd66jRJtgNc5xiFKoQD4LyCFLxSTd7i35RBGPp+ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlBXMneN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C1B606A31C;
	Mon,  9 Nov 2026 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlBXMneN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAB11F0089F;
	Mon,  9 Nov 2026 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216360;
	bh=UfmlPYw1M6tfZZ0BVl3ZtV0mI3ANbCo1r8noEBOul3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XlBXMneNIn/ptX7LhL0Q8NjWkTsApFnx14/VtFuTQ0+sULGjTtC6Y2kbyEpdP+z61
	 TdW3kw+vfc9/RTMbJqr68eqtDS47PmgWo+X26hw0tRF+FRjozt9Gx36ioeyzGsb6iN
	 yTVGHMnFm66z2c5SEFF3Vdhkdb0J1VH3ssMYlv0ILZbUkWH/cOY60ZcYtWna0s77Ji
	 edH4c7Ty2qc/Iv7W2tnV1pqyQ/YFtK1LydikQGdlZ4SBL653jHDhPCCwfjZrFpCetc
	 2g/EmruM9iF0Ec/bXIcsJDYw89AXiq7hrLOAvWE09bdWKg751DKbXOcfLKjlL8Rq7u
	 fm878SXNIrrZA==
Date: Mon, 9 Nov 2026 10:25:55 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: David Laight <david.laight.linux@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
Message-ID: <avGPP4k4qjG_gJa7@hobbes>
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
	protocol="application/pgp-signature"; boundary="4o7oszchxozzn5y3"
Content-Disposition: inline
In-Reply-To: <0316f664-d98c-43be-92af-13c30436727a@linux.dev>


--4o7oszchxozzn5y3
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
> > >=20
<... snip ...>
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

Actually: If you want to move the context handling completely outside
sysctl, I would suggest separating into different series and sending
them separately. I'm assuming that the sysctl subsys and the callers are
completely orthogonal after your change

best



--4o7oszchxozzn5y3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrxkZwACgkQupfNUreW
QU8Ytgv/SpezK6Nyy4cQk6Sv168VecnN07dvUbeeTwjP//6EqjIyQii7u4IffFEi
sIkTVYaI6DPZRHlO+ZZqphwxgHZcEqmGGnTnfoeI1CWijQ76NLSW4VbkfXpADJUg
Xx4Tm6B3rXMrBmoCtWX+T5ZiIHa0T5pUhEukOSkhX9ByxtqWCu8xo+WcZCojLv2X
Mkx0yft/yseLZLsjUW5tmf1GcHPTAI3r2ZkRoSDN//f9cqAmhnyxtko5SXFFVa6h
CUwhxmgnmSuxOlJAhDuH02bSFy+Ustor5LLpcDLWHWa2jGZsuh0Zua2zyEPKozZQ
gcy2+3D3zLfcOuVnh03jtTjQDcuCTqejkksBeOmuo9fRrkBg9Bo5TY3W2P1pkKpK
tQBicP0ZFZrDwQdqHVU968WIPYtWGHi+BAI0VK+ttKRjW8iNaG44XtBUUrn2RGp9
Qvpq2NbXD/viPR170RfCJPogGTWRaxiX8P+h3jN4kSJysHvV5icXNCZjMaPjFMnL
xcEVCyYi
=/8pu
-----END PGP SIGNATURE-----

--4o7oszchxozzn5y3--
