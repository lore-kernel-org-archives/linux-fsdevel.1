Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E330C3BD647;
	Thu, 24 Sep 2026 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261208; cv=none; b=fBaWCZRnLWkDHumIaTDhoefRDtkrCiQtZtrPoEgejsTqbTmmPJRJmxLf/FQIaqoYNBJ+1CPbpc1jwwWNP9yeCTMAbgdZDSHuGrgWEk3tguKemLpzOo+SCxFCCRGG6gWMhK5R3cGMXtEApQshW+C5DyDqSnShIvn927mT5mjWKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261208; c=relaxed/simple;
	bh=50OODfIs/vV7NpIEzx75LwoTtlqUVrAfZ753hubMnaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQNcM+Bo+hfM2ZdG1pfJFnkB722jLL8xMqjbO+DEFYCBcvQ+IDr6UWxUTyYrjDp54OVhwqc8iyl7frLuc6jkr6JAMqD5OLcf6Vu2gWoilggvL3uoEUT7KigAn8j/qVlgxXqpPKcig/ESBTYYEnBw/8jsKt2KRpIhvBwN/qaA1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSAXSEZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSAXSEZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4601F000FF;
	Thu, 24 Sep 2026 14:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790261205;
	bh=qe09bvKpBTm+LEK6lbFZn9BTAaGjo5YNbSJwlWnT6to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SSAXSEZCC1rcrDBCnVFPzgf3F8f25xxLtaTI8PXYwJ6RJHJ51bmWSVRsoEnPzWpOP
	 1Vg36FrzxMiI+toL7DJjCLjXGJPsWr4PtMkAy1hrn14RsIY+x1NTSBux+0Bflrj+49
	 uyLraBTYC3bk4RYF6JF62THW/g2CItz458VfhkdT2NNV8nXXVqZvKr/7J1Xh8FVCqo
	 TCe3YOqy2ZFpTVZzzYEk779nA1KyrE4+UpR/no2us+0M/AgI2y8tVSzxqAoXhCSTbd
	 JJTpEIHPoFFpMYfom4hEMeLVffDAHEb1vLh6z46UUlkoopq6J/6d1bjvC+/hELwks/
	 rT8wybR7NPROg==
Date: Thu, 24 Sep 2026 16:46:39 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Serge Hallyn <serge@hallyn.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] sysctl: add typed field descriptors
Message-ID: <arU3z_CUfNL0Xezt@example.org>
References: <cover.1789987960.git.legion@kernel.org>
 <gbiwlkkqx5ezpn2drqj5apylk7ohbcz4kkrpba6tpqnkcph7z6@5ez5wwz3jhi5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cxV2zgm/6AiVs18/"
Content-Disposition: inline
In-Reply-To: <gbiwlkkqx5ezpn2drqj5apylk7ohbcz4kkrpba6tpqnkcph7z6@5ez5wwz3jhi5>

--cxV2zgm/6AiVs18/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 03:29:28PM +0200, Joel Granados wrote:
> On Mon, Sep 21, 2026 at 12:54:47PM +0200, Alexey Gladkov wrote:
> > Hi,
> >=20
> > Some sysctl users allocate a private copy of an otherwise static ctl_ta=
ble
> > for every namespace or device, then rewrite data and limit pointers bef=
ore
> > registration.  Besides the per-instance allocation, these fixups are of=
ten
> > addressed by table index, so changing the table can silently associate =
an
> > entry with the wrong data or limits.
>=20
> In other words the motivation is to:
>=20
> 1. Remove the per-instance allocation thereby reducing the memory
>    footprint
> 2. Remove the possibility of mistakenly associating one variable with a
>    different sysctl name (because of un-synced changes)
>=20
> Only those two. Right?

Another reason is type checking during compile time. Currently, .data,
=2Eextra1, and .extra2 are pointers to void. The sysctl_check_table()
attempts to validate extra fields, but this is done at runtime and
essentially involves checking .maxlen.

I thought that we could not only eliminate the need for memory allocation
but also make the parameter checks more strict.

> >=20
> > This series adds struct sysctl_field as an alternative descriptor for s=
uch
> > tables.  A field records the value type and an offset into an object
> > selected at registration time.  The type-specific offset helpers are sm=
all
> > wrappers around offsetof() and only add a compile-time check of the
> > referenced member type.  The sysctl core derives the handler, size, data
> > and limits, and builds a temporary ctl_table when invoking existing
> > handler, permission and BPF interfaces.
>=20
> Building a temporary ctl_table entry just before calling the
> proc_handler is the way to go, IMO. But do you need to adjust all those
> members (handler, size, data and limits) always? Sometimes everything
> stays the same except for the one ".data" member.

The `struct ctl_table/sysctl_field` array may contain entries with
different types and other fields. I figured it would be easier to reassign
the values to keep things simple.

> PS: Any meat in sashiko's comments?
>     https://sashiko.dev/#/patchset/cover.1789987960.git.legion%40kernel.o=
rg

Hm. For some reason, sashiko has stopped sending review emails. I used to
receive them, but now I haven't received anything. I'll check his review
and address his comments.

By the way, I heard from Oleg Nesterov that he isn't getting any messages
=66rom sashiko either.

> >=20
> > A struct sysctl_context identifies the object shared by the whole
> > registration and is copied into the table header.  Subsystems which need
> > more than a namespace can embed it as the first member of a larger cont=
ext
> > and select the object to which field offsets apply.
> >=20
> > Existing ctl_table users are unchanged, and subsystems can migrate one
> > table at a time.  Converted tables remain static and read-only instead =
of
> > being copied and patched for every instance.
> >=20
> > Compared with the previous RFC [1], this drops the per-field accessor
> > functions and the macros which generated them.  The first two patches
> > prepare the sysctl core without changing its external behaviour.  The t=
hird
> > patch adds the new descriptor, followed by conversions of the IPC, mque=
ue
> > and ucount tables as small users of the interface.
> >=20
> > This is only the first part of the conversion.  Network sysctls and the
> > other subsystem-specific users will be submitted as separate follow-up
> > series so they can be reviewed by their respective maintainers without
> > making this initial series excessively large.
> >=20
> > [1] https://lore.kernel.org/all/cover.1787770053.git.legion@kernel.org/
> >=20
> > Alexey Gladkov (6):
> >   proc: sysctl: address table entries by index
> >   sysctl: add unsigned int limit constants
> >   sysctl: add typed field descriptors
> >   sysctl: ipc: use typed fields for IPC namespace sysctls
> >   sysctl: mq: use typed fields for IPC namespace sysctls
> >   sysctl: use typed fields for ucount limits
> >=20
> >  fs/proc/inode.c        |   2 +-
> >  fs/proc/internal.h     |   2 +-
> >  fs/proc/proc_sysctl.c  | 601 ++++++++++++++++++++++++++++++-----------
> >  include/linux/sysctl.h | 150 +++++++++-
> >  ipc/ipc_sysctl.c       | 188 ++++++-------
> >  ipc/mq_sysctl.c        | 104 +++----
> >  kernel/sysctl.c        |   3 +
> >  kernel/ucount.c        |  64 ++---
> >  8 files changed, 750 insertions(+), 364 deletions(-)
> >=20
> >=20
> > base-commit: 587858367581b9c55c3690f4e63382ad622719d4
> > --=20
> > 2.55.0
> >=20
>=20
>=20



--=20
Rgrds, legion


--cxV2zgm/6AiVs18/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEfyo9BymBSaB5PJpOpFq6VEz/1DQFAmq1N88ACgkQpFq6VEz/
1DSIbw/+LaOB2NR+jkRlI34gs6VxAZjbPaVgt2DRr8ckX64Y/L/QCDdPHhxC7jKj
BNn1G99ph4GIlmTuzGVBdCO629U/46TvWs0sKpwFeI6iHm6p6tJ+uGUrqaAaKYo8
0z6Z+3fN3+r9hwG5REZTb2P92Fk1LhHYK7ynNhhz7Ex6XOs4p99tkJj85LgBdLkD
Jv9up8zcDPRiTG0o3F6ZLDHi8zWAkiQmE52EcpOpqWUlbqT5yaiSfEKwecZRh/tN
I++xwbgky2xOrxKgClvxELCtNZNURj4sdmzpHiwjbeOG3tKMlpH4/gvYKU0fxnPK
Iz2lSSEhuV56DLQUW46Vwddpiw+ck5mak23ygPVLljREqNkWH2J9T6cMmkf9lCHw
K9u+EAv9uQVvSfnHji9Fc6OqWIXCfNIcSkCxJFDrNjdO2lul2LAlqb2mSrmj5mmI
SNy4Erp0n7sEjBRyOqQ0RczK02iz9oY+xuG+iMN5473B24o00+AufQyHsaskZKbt
kFOi7w/pAp1z6pGyvnD2UQHz0KA+9j/o/kpp08lrR9hi/O5KwsGtvf4/lYt2H14S
AHGYCUjtmAKqHjTg6Qm/AnoDXLreSv3PDuR91IP+HMVPRFIhYtlZo/V5jGe5Zbwb
/P3uci30RPKgrWathfHCD3J7RVb7TGGFlJD34FLwsuG0ImPeDrA=
=1CAV
-----END PGP SIGNATURE-----

--cxV2zgm/6AiVs18/--
