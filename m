Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398154;
	b=wkCaAHc+L+OwPgyxXRlTVJXuer/ABTiZ3MeLI/SoaSz8pzFNxwzsqFQAUBFSSfvG5tvn
	 xadG72N1HN6rQVsSkKnSDx2bq48Lm1eWx2NqUp4iYlghNdgUUiWUfi+dMXFOtNL4j9ezz
	 fphTqEFRv3W+wZfRSS/DpBGEYLYV/+37a+Bel+PYYz3xJUVEPkm6VbIFFqAmOMTDjZMYW
	 OcsVF+3fgfHR47Y61rUkSOqEUTxO/BCNSdv/Mlm99mZhcFF+eHJEwQnGtnqWlcULgfx+M
	 T3XNElts92gqYq1OQUD/lF1SV8NXYHeF9wDDM9K7bKo3O6xN9Uc/XQboRHbxDlH7HDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398154;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=os9Xu94wjD5DtnrFkl45so98Lu/jsCNQWsv2IOpbjKY=;
	b=Yt4bpttGfAvdPtzIkMEb9CHmKs3foYrmdKbcv3macRm5iOSuZmScCX8bCvot8QQ0A8HG
	 AOcQQiJ+1eubGZyqAgsV+AZEcWoRAFZ4PmLsTT0kn3mMG71snbNDK30/O4+rqmcx9r6UC
	 pWDKD+mxXKf5fJgkRSfsD5anHccPoJ0UFQ1UVwVS6rxvf6riVv1XUsXby4ogeXR5HPWuQ
	 tHJKsgfJVcaYXGkpUp41XrgZazd1XyF5/k8zWyN/f0UgJuYLJ76LAEGIwhF+mCZwTI9ZX
	 L1QUonzqnLd8UR6u0xtMhedFndNub00IXCrKNwISdSvOwTMbEyD7Tcd8uMt4Y5aMG0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L66tiotr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F354606A324;
	Wed, 11 Nov 2026 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L66tiotr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C67D1F00A05;
	Wed, 11 Nov 2026 11:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794398154;
	bh=os9Xu94wjD5DtnrFkl45so98Lu/jsCNQWsv2IOpbjKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L66tiotrbgpwYAP/mcO7QCwolaFuJkEjhMbfo5fNajxyqeKe90lR3peEpvw1YgPaa
	 Mp8tDyL54DmiWVSd4WyajAEQe0ROH12/WfzimzVQ+BMKLTu7suEzfE2NQpCKBNxCai
	 gDSYE5Z6FxJf41aJUrGf3hIYoBpH02NpL2DYi28I/2wnUfgdLKzgmFzLR7xvQO7ttR
	 fbrSBSEvHGhOAQP3M8OSP+NQI4WKhciNlOeek88fcqh6P3jp34NDDKqECnYffqi4cM
	 2risM9lXTgL4GpugHmI8CZ+L8bWwINgtSo/Vesf/4Vk8lpa3wb6Pq+L6zRn0gt9u/p
	 rGzlQH6yYgIJw==
Date: Wed, 11 Nov 2026 12:55:46 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: David Laight <david.laight.linux@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
Message-ID: <avRVHIx-6nA1mP2F@hobbes>
References: <cover.1793204511.git.wen.yang@linux.dev>
 <20261029105837.2f8bee67@pumpkin>
 <0316f664-d98c-43be-92af-13c30436727a@linux.dev>
 <au85ISJ2qUsB7y-6@hobbes>
 <20261107170507.0d66cc2e@pumpkin>
 <avGVyB9erjZl8zIO@hobbes>
 <e3c7bf98-64f9-4c29-b300-f54b7a4813d0@linux.dev>
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
	protocol="application/pgp-signature"; boundary="blsmae7suy7hgb4u"
Content-Disposition: inline
In-Reply-To: <e3c7bf98-64f9-4c29-b300-f54b7a4813d0@linux.dev>


--blsmae7suy7hgb4u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
MIME-Version: 1.0

On Wed, Nov 11, 2026 at 01:45:15AM +0800, Wen Yang wrote:
>=20
>=20
> On 11/9/26 18:07, Joel Granados wrote:
> > On Sat, Nov 07, 2026 at 05:05:07PM +0000, David Laight wrote:
> > > On Sat, 7 Nov 2026 16:27:39 +0100
> > > Joel Granados <joel.granados@kernel.org> wrote:
> > >=20
> > > > On Mon, Nov 02, 2026 at 11:40:40PM +0800, Wen Yang wrote:
> > > > >=20
> > > > >=20
> > > > > On 10/29/26 18:58, David Laight wrote:
> > > > > > On Thu, 29 Oct 2026 00:34:39 +0800
> > > > > > wen.yang@linux.dev wrote:
> > > > > > > From: Wen Yang <wen.yang@linux.dev>
> > > > > > >=20
> > > > > > > struct ctl_table describes an entry with data, maxlen and, un=
til this
> > > > > > > series, two untyped misc pointers in extra1 and extra2. Those=
 two pointers
> > > > > > > have accumulated at least seven unrelated jobs: a fixed bound=
, a bound read
> > > > > > > through a pointer on every call, an object or namespace point=
er, a small
> > > > > > > integer cookie encoded into the pointer, a lock signal, NULL =
standing for
> > > > > > > "no bound", and a value the core itself casts to unsigned int=
 while
> > > > > > > validating a u8 range. Nothing in the entry says which job ap=
plies, so
> > > > > > > readers infer it from the handler, and the core gets it wrong=
 where it
> > > > > > > treats extra1 as an unsigned int.
> > > > <--- snip --->
<--- snip --->
>   for (i =3D 0; i < head->ctl_table_size; i++) {
>           entry =3D sysctl_entry_at(head, i);
>           node =3D &head->node[i];
>           ...
>   }
>=20
> Insertion/deletion would take the node directly. Readdir would retain
> its RB-tree node cursor, recovering each entry through that node's header:
>=20
>     entry =3D sysctl_entry_at(node->header, node - node->header->node);
>=20
> No entry - head->ctl_table, caller slot constants or per-slot wrappers.
> RB-tree order remains unchanged. Old APIs and generated directory/link
> tables use sizeof(struct ctl_table).
>=20
> The two mechanisms have existing precedents:
>=20
>   /* include/linux/bsearch.h: explicit element size */
>   pivot =3D base + (num >> 1) * size;
>   result =3D cmp(key, pivot);
>=20
>   /* include/linux/hwmon-sysfs.h: extended descriptor */
>   struct sensor_device_attribute {
>           struct device_attribute dev_attr;
>           int index;
>   };
>=20
>   /* drivers/hwmon/adcxx.c: ordinary device_attribute callback */
>   const struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devat=
tr);
>=20
> hwmon registers &ad_input[i].dev_attr via device_create_file(); the core
> passes that same base descriptor to the callback. These are precedents
> for explicit-size traversal and embedded callback context separately,
> not an existing strided sysctl registration API.
>=20
> I agree that my fixed-slot solution adds maintenance overhead. Would
> it make sense to explore this in three small steps?
>=20
>   1. Entry-access helpers, unchanged packed layout.
>   2. Header stride and compatible registration wrappers.
>   3. nf_log conversion and code/memory comparison.
>=20
> I would appreciate your thoughts on whether this is worth pursuing.

Hey Wen

Without a series, it is hard to see how everything fits. Maybe you can
send out an RFC with just the changes to the sysctl core and one or two
examples of how it would be used in the more involved users.

The rest of the users can be "vibe coded" (so it compiles) and put into
one big commit that we will ignore for the first RFC. Just so we get a
clear idea of what you mean.

Tell me what you think

Best

--blsmae7suy7hgb4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmr0V7sACgkQupfNUreW
QU//GAv+NXM+FcWR9k9Zm1P7iln60PMwqFNdYEbXmdoXtiMJrLAA8nfGh+lzslrW
buNPgIZWOrH5EJ2EDZaJfsIQkLT/YklygZuzDCVLx8b62F4tm1iCsKSKs/nLm/ix
MDbP37MqrbsAHVGFvadrMh1St1IY32TorPPAV7wAomTZfyq+7KLRPv1B0k8lPnlo
P8rOB09xvk/ifqKsOYwOTLQzD9IXhlrvhR5kFxox15IyhMgOl/PzN0l4K1bb0rXK
Ikmv2a9OSDHBpBGLxdIoAXao6ShRp8CFxcOd9y7ADMA04UPCf+rglrnnau+idYjn
r90TjH/A4Ay22Td2+sHHWRjLhKVInrUv2mNSqgn5oSGr/Gb1hHFwUutKlNBFbkrh
m8p3zZg08b6GiUw4eUIosKHmHXb/2lemQdV5y1Wq8SWX/StwhawfsVmY9v6WUT4z
x23j25G3zzigWNOimo8VcpCunHLfB38nF7CMeJHLeKwDobwutk5TDgJAS+6hkJ8J
L4oarpK/
=0NWE
-----END PGP SIGNATURE-----

--blsmae7suy7hgb4u--
