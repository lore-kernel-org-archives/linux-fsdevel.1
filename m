Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696259;
	b=H60HfY1XXt9+1fEOsRpuGPeIxhruRet6geUuwKOM1MxGj9mBK+NFizIKykBZcT28stNp
	 5hh0CbwWCXRPv2Ynp5tSOLSWOxZQtEV6W5YWwu5+J5HEsCbQU1QOosbTqidLifibHmTt9
	 02NaJTbJ1MnFftBj/2MRW8bQQFPE1Vf1nd/1zsFDaVxEUDMsLFJzQBubacz8C5GxDH1JS
	 lwHf8VyJi6zq5tbMGsZt4ztQedqvmm6w4uh2M+MivIvObkQU7htUQI1QhPOmZpV3pVUMy
	 cPy840HKNTPy1GM6EVZAEFd5C/ffvo94uJUZJK0nfZGLHPAozOfVQj1I0URM5Q0FbNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696259;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NHNwpqGkapkLTywPi1kj5mcBBpsQAg5W37jUFryGrao=;
	b=EScOOqqhYiklt5eOFbOO26jKMFs4w3/XoODpw6J97UVhAiuvfY6Zq+15ya/QniTTGFxG
	 iLWkzFAN4I8D8wXhRwLZOzjUxFCOGCyge3sSwuGhzwsS9Q5LYO0o3CbbNC5KADh63mYVk
	 ZFEM3CnZrxXBXg3yVE1bjv0Kv8qpAteiLInzny8EFJhWp7dTsbCwG3hA2S6DfE7YVPZ1X
	 FubDMxVyBD8MsxNdeNVZBjtAM9NL2oXmejABSHHH1gUp+JXnyqBa+nEW/qHF2uRmnCMIn
	 kpfHC02iHqwmhykaQzrphaR4VpKnWGNxp6tx5SjwaLsgI/f0ZLkerrXmhLgXn6wPllA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5jDCdzM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2952606A31E;
	Thu, 26 Nov 2026 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5jDCdzM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0500F1F000C6;
	Thu, 26 Nov 2026 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696258;
	bh=NHNwpqGkapkLTywPi1kj5mcBBpsQAg5W37jUFryGrao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S5jDCdzMr+Df7NGBx/YoxU2MVB/X1L6evO6Ep1vgPlkKjoAq1DGOi9QTcXNrXMIgx
	 +YZRUsQprpMW0dLNfjJbbXfiTXQ/C8KqGZWIA9N6wUqLqN3/H8cj+eRwF/urhPjRFI
	 aLw8HnVMLymI76m4bT719Il8UdhRUryAPRX7+rccktLzEr90rbMvFwn6ZZMtqzeujs
	 96wD6Dw1oDwE3w2TjuTG4X11PVLCq0FBh8rzbr4rP1iavYu5V5rAXb7aX5v1lf4lWT
	 k7fhyxJo89o81de1EtlgcpnNY8mtlOc3mPofXUloC7E0DVoSbD5iTXdjnC4k+Iy1Wv
	 gjPFIy61rOnuQ==
Date: Thu, 26 Nov 2026 13:30:53 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/6] sysctl: replace overloaded extra pointers
 with typed bounds and core stride
Message-ID: <awgj9tL-yAMS14zy@hobbes>
References: <cover.1794844686.git.wen.yang@linux.dev>
 <awV04op6IxD2NWQA@hobbes>
 <0e4be7f5-8704-4d2c-8e63-d578fad13774@linux.dev>
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
	protocol="application/pgp-signature"; boundary="33mcerusmc4aosgd"
Content-Disposition: inline
In-Reply-To: <0e4be7f5-8704-4d2c-8e63-d578fad13774@linux.dev>


--33mcerusmc4aosgd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 0/6] sysctl: replace overloaded extra pointers
 with typed bounds and core stride
MIME-Version: 1.0

On Thu, Nov 26, 2026 at 01:37:12AM +0800, Wen Yang wrote:
>=20
>=20
> On 11/24/26 21:26, Joel Granados wrote:
> > On Tue, Nov 17, 2026 at 12:07:32AM +0800, wen.yang@linux.dev wrote:
> > > From: Wen Yang <wen.yang@linux.dev>
> > Thx for taking the time to put this out. This gives perspective and adds
> > to the discussion of how best to move forward with "struct ctl_table".
> >=20
> > >=20
<... snip ...>
> > > 1. Abandoned per-entry 'void *priv' (David Laight):
> > Though not adding yet another entry in ctl_table is commendable, I
> > prefer adding a priv entry over the stride mechanism in this series.
> > Here are my thoughts:
> >=20
> > 1. The type should set the stride in sysctl core. The situation where
> >     the stride of a type might be different from its size should be avo=
ided.
> >     In these cases I would prefer a whole new type.
> >=20
> > 2. Having ctl_table as the grounding entry inside another struct and, at
> >     the same time, it be a regular (non-grounding) entry is asking for
> >     trouble.
> >     - A proc_handler assumes there is a containing entry around only to
> >       realize that it was passed just a pointer.
> >     - The core might start overlaying clt_table entries to deal with
> >       namespaces [1], [2], [3]
> >=20
> > >     - v1 added 'priv' to struct ctl_table, incurring 8 bytes on 64-bi=
t and
> > >       4 bytes on 32-bit for all ~1,000 entries across thousands of dy=
namic
> > >       instances, even though <7% of entries need context.
> > Just a quick comment here: If you want to get rid of 8/4 bytes with the
> > ctl_table struct, you might want to look at struct ctl_table_poll, which
> > (to my knowledge) is only used in one ctl_table array. Finding a way to
> > service utsname while at the same time removing that entry is much more
> > of a low hanging fruit IMO.
> >=20
>=20
> Hi Joel,
>=20
> Thanks for the detailed feedback and the namespace overlay pointers.
FYI, I just sent out a new RFC [1] which has very little overlap (and we
should try to keep it that way) with your work here.

>=20
> Our main motivation for prototyping the stride approach (and the v3 we
> have been testing) was to avoid growing struct ctl_table while still
> eliminating the per-entry wrapper functions. However, the upcoming
> namespace table overlay work is a compelling reason to keep ctl_table
> arrays homogeneous and  self-contained.
>=20
> Following your advice, we will set the stride series aside and split the
> work into focused steps:
>=20
> 1, first, prepare a small, standalone series (based on the lastest -rc)
>    focused on migrating the non-bound context callers of extra1/extar2
>    to a dedicated void *priv, field in struct ctl_table, without
>    touching any min/max bounds yet.
Yes. That will take us to a place where we will have priv and extra{1,2}
at the same time. But will allow us to move the callers one by one.

Once all the callers are updated, we can eliminate/replace the
extra{1,2} as there is not other dependencies (that I know of)

>=20
> 2, Once the context pointer migration is settled, follow up with the
>    typed min/max bound conversion as a separate series.
ACK

>=20
> Regarding struct ctl_table_poll in utsname: is someone already working
> on removing it from struct ctl_table, or would you like us to look into
> that as a separate cleanup as well?
No one is working on it to my knowledge. If you can come up with a way
to keep the poll without having it in ctl_table, that would be a win.

>=20
> We expect to have the context-pointer series ready in about 1 week.
> Please let me know if you have any preferences or suggestions on this pla=
n.
That sounds good to me.


>=20
> Thanks,
> Wen
>=20

[1] https://lore.kernel.org/20261126-lklm-sysctl-ctx-flatarray-v1-0-d7fc9cc=
9b03e@kernel.org

--33mcerusmc4aosgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmsIJnwACgkQupfNUreW
QU/q5wwAk6zCIZ1Bq0/sglUTswTCfRfPk3rOCWArYdgO4kXJXDAOTIaUzNA6pdYj
4DhrxA0QR9+hyWvmpG5Z+M2GlqceCECXskH6ArmOtd73W3mkSMBwfNt3R8luWkPB
beTpJshIy0K3AkEtQT82NuoBp1Z6qE7EHhrgupBmDzAKFxYWHrQZ8BdZ1wK5lenS
OX+l2vhtNmRVDr7lx/mIIem3nSf9m7adQLD9a6WQLvd2l2/pyJEHg9SsXX8U8BOx
tpB4pmekPc5k+lnCh1S+VPt/LnmoLrvz2jYlwEaK0uN58NZInfKdFriodzKjP7fH
3iuPT2SKVb83N051kL+lsrMuvNNguFDKW1clj4bGrwBD/7QgBUgaPErtxFDE/gng
rqYmEaY06tFa5umSSCer3Ge8GNx3fjy9RC8y+14hSyzyoZPD0JNVkISeDz+2eP10
6pMLe9SrtXJ++BfMAx5itPaZ3msN1vZpmUzDrQI5xw13h8ApDcmRr+qVnSN5BNjV
MAVNOhbf
=wprq
-----END PGP SIGNATURE-----

--33mcerusmc4aosgd--
