Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677885;
	b=kNtVn+4wjhAfOulSbddnqcQHwAxpmi6+ITHIHYSVZjWW0f1tm4C4UYlbvaH1mIJw36IG
	 ibO/WvC0OSieSOKrptu2a76a2JOyT+InzhW7wgxbAvkeaVsKHVvb4rhnHmf/HYevQIxwa
	 eUBw0eq4cGe6oKacUg2ducSH+V3JtzXbLAuox3BVW/Te6tsCv5c+JYUptoeA5LcRBoVuY
	 Va2Va7OisAplUp+QmoFeGnNOi9DRC1V84V2uM27J36Ceyf2ROEM+tjtfAKHqzVu69t4Vj
	 iyl+EJ6YdSfYlPukcyQN2csoSg49RHWpqZ9Tboaz/Q9lf8AANzO0oERbsCRIa9J5h1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677885;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cx0D3M8foGa5r4mSo3Qi/32tdtXY6GyhdI9nlwY5qjo=;
	b=r02gNVaCZ1pqXyrrRTxdbCXfyfuaicYK0JqPhewPFJwfSLQ2qSLvAtNIhiqbtdloIvJu
	 gNZ2WcMx8AFged7eRDGJq9V3J457osnhgvN+fZHy1vcaPy9gek5gNDTsDrMT4pOWIJeYr
	 h2NxnH7Wb2yAfiKpwDS1ClWJR4J/hQK/qMiPJ7IJykSKaOtJPGtlCdOqLgz4bvVEeYl2G
	 ZzFNuufjgTUP1i1CRmFhWui/VzYF71nZnDaa/TWKnyNL4fjahwZwv/Cjykafczt9+6LHM
	 7yFlKD9srfF0rlHspoQhFu/BqmjybTBCih8kgnrLMoZPjPa4zmoPVnn1AHr/6aJoMGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsyF6QjW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D244606A319;
	Thu, 22 Oct 2026 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsyF6QjW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7021F000C1;
	Thu, 22 Oct 2026 14:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792677885;
	bh=cx0D3M8foGa5r4mSo3Qi/32tdtXY6GyhdI9nlwY5qjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RsyF6QjW/szYKE/DuobJAv2XCp/AYNz4T4T5lnX2kJIdMfErFB7E3H3DewwfpMEAy
	 jFb6jXzJ9bGN0ML8vBig5v3SCHHMVGvRvoNJgUpX//nuPPzKggJqiggSxTRqBkLpxS
	 JC8Wac6lfZXB/s+r3jcFNala1x45PBkK34eXisAR9wbbcN12b4xqftOwrR0DjLfv9y
	 DLY/+B7M5YuAG/rvPfotKXRfiWkvOslVYqijkhyfHCMJbE9uK3fRvdEtKcl8/kFiIF
	 r5viYj+l0oKUY/6QYx5ED+gT5rNy60f0JC/MlcBvdN4uXsUvTWq4p58JJ2zjBtF6YU
	 /yyj3hHMC7ywQ==
Date: Thu, 22 Oct 2026 16:04:39 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Serge Hallyn <serge@hallyn.com>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] sysctl: add typed field descriptors
Message-ID: <atoDngZsxy3TWmO_@hobbes>
References: <cover.1789987960.git.legion@kernel.org>
 <cover.1790439358.git.legion@kernel.org>
 <aszj54qPIdorUTO8@example.org>
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
	protocol="application/pgp-signature"; boundary="uiipg2lcg4rpxcah"
Content-Disposition: inline
In-Reply-To: <aszj54qPIdorUTO8@example.org>


--uiipg2lcg4rpxcah
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/5] sysctl: add typed field descriptors
MIME-Version: 1.0

On Mon, Oct 12, 2026 at 03:43:03PM +0200, Alexey Gladkov wrote:
> On Sat, Sep 26, 2026 at 06:22:07PM +0200, Alexey Gladkov wrote:
> > Hi,
> >=20
> > Some sysctl users copy an otherwise static ctl_table for each namespace=
 or
> > device, then replace data and limit pointers before registration. Besid=
es
> > the per-instance allocation, these fixups often depend on table indices:
> > reordering an entry without updating the fixup can silently bind it to =
the
> > wrong data or limits.
> >=20
> > This series lets such users describe a table once with static, read-only
> > sysctl_field entries. Each field names a data type and an offset into an
> > object selected by a sysctl_context at registration time. The offset
> > helpers check the member type at build time. Limits and custom handlers
> > remain optional properties of a field; the field type does not encode a
> > choice of handler or whether limits are present. A subsystem that needs
> > more than a namespace can embed sysctl_context in its own registration
> > context.
> >=20
> > The sysctl core keeps the context with the table header and materializes
> > a ctl_table entry when an existing handler, permission check or BPF hook
> > needs one. Legacy ctl_table registrations retain their own path, and
> > subsystems can convert tables independently. The IPC, mqueue and ucount
> > conversions here remove table copies without changing their backing dat=
a.
> >=20
> > Changes since v2:
> >=20
> > - Drop sysctl_uint_vals, as requested by Joel. Existing limit constants
> >   suffice for these conversions.
> > - Drop the *_MINMAX field types. A field's type now describes its data,
> >   while optional min/max pointers supply bounds to the selected handler.
> > - Keep __register_sysctl_table() and __register_sysctl_fields() as sepa=
rate
> >   registration paths, sharing only allocation and tree insertion helper=
s.
> > - Address the sashiko findings: avoid calling mode_fn under sysctl_lock,
> >   validate the effective maxlen against the context object, and reject
> >   NO_DATA fields paired with standard handlers that require data.
> >=20
> > This is the first part of the conversion. Network sysctls and other
> > subsystem-specific users will follow in separate series for review by
> > their maintainers.
> >=20
> >=20
> > Alexey Gladkov (5):
> >   proc: sysctl: address table entries by index
> >   sysctl: add typed field descriptors
> >   sysctl: ipc: use typed fields for IPC namespace sysctls
> >   sysctl: mq: use typed fields for IPC namespace sysctls
> >   sysctl: use typed fields for ucount limits
>=20
> Gentle reminder about the patchset.
Thx for persisting and sorry for the late reply.

The more I look at this, the more I am convinced that the first problem
that we should address is having a .data, .extra1 and .extra2 as void
pointers. Once that is out of the way, then we can focus on getting rid
of the kmemdup of the ctl_tables.

Motivation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Here are the motivational points for this series:
1. Remove the per-instance allocation thereby reducing the memory
   footprint
  * This one is relevant for instances with lots of NSs.

2. Remove the possibility of mistakenly associating one variable with a
   different sysctl name (because of un-synced changes)
  * This one is the least important for me. Keeping it synced is a
    little scary but something that I would be willing to live with.

3. Type checking .data, .extra1 and .extra2. "unambiguous pointer" that
   answers what it is.
  * I think if we are serious about type checking, we need to fix the
    existing (potentially uneeded) void pointers (.data, extra{1,2}).
    Which is not an easy as there are callers that (mis)use these in
    different ways. This has been discussed before (in [1,2,3] among
    others)

4. Don't bleed caller structs/types/logic into sysctl.
  * This one is mine and is the reason I really don't want it done in
    the manner that you propose. IMO, having network (or other callers
    logic) inside sysctl makes no sense.

I'll come back to these series after having yet another look at the void
pointers in ctl_table.

Best

[1] https://lore.kernel.org/all/87zgpte9o4.fsf@email.froward.int.ebiederm.o=
rg
[2] https://lore.kernel.org/all/875xyczpzm.fsf@email.froward.int.ebiederm.o=
rg
[3] https://lore.kernel.org/all/cover.1739115369.git.wen.yang@linux.dev



--uiipg2lcg4rpxcah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmraF+8ACgkQupfNUreW
QU/moQwAlDDDWhCpLDxeUYetboIigDRJ70lfnkQPzgHEP1A6LRk45+F1S6uuryO8
iwgG2b9f8C3bFfGWg53CGD6a1Ve8rE99uRKO/+Vdh6+HaRbmEVFMh+SAB4yhIsi4
e6TlfhRKa55xhHJD97y5HkawrBwOevEGA9/yrHz98IUfoGCZgIACFpG1Bn95a9Ns
PZk1zv17vmj16OFb/ImZSSoyPT70AdkUt9x6wgEwz/Ir5Bsvcgqkl2pk+DdCU0kl
DnxC0Brb0yYvTlh63Ob4BXPohlyrqubPQvOSJBiK5ZDjEmQSl2lpsc1vTjMFL4KZ
TwwbE1hcu34MH4Hi6QH97m5eKoHnKu7qD7Op+XUQGWgmFstFoNsVIsetoy50sAYw
drBcOk3wfuckP95BT+OIpAfLksAsbuRr2PxYA5MJVyPbcPl+PI1OxPfHka19S6PI
Jjj7OcZYNJ8M0+g2a3yqsvTC5eTdm0Z4vOyjb1d4bSQ4xrx5spRWwbcCpZ1dqBN5
htCWX9PQ
=S8IK
-----END PGP SIGNATURE-----

--uiipg2lcg4rpxcah--
