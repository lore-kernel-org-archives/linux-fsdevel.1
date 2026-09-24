Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B306A47A861;
	Thu, 24 Sep 2026 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256583; cv=none; b=PqRYSIzIyI0IwctPB+7kku/YPMjRFITXyQ0l/bRSCndiTxaEp9viyru/KjlhmT/nqIWg10nrqgVd2YQqwNNfIxmrSLDM5zWVDtmiIbKpe6D2qAl0tvrgUFL7nnN04Ia578aOTII0EXjxk0EqnbBtldz9EEHaECfCWS8NcqwNI9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256583; c=relaxed/simple;
	bh=rFeM1MpnX/mLlEIjvBGq8EnGFbjkBRUGAb/mYzCBh0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKG6LWSfhBCHyG4S4l4g5SpOVSNZKvBwbmtDQD2yzaEM/ow49pPbZ0Qb27MZMbu/+oaEY8FbMJ3Ny04ePw9/HYhNd/ND7ua5UCIYH7S5KOLzJqSXpbF/+nbmwrPTNVH+WchHWVmWoD4JhKgJ8GdxHshP/KTug3m22x8SYRN9ot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3U+xExS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3U+xExS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C861F00893;
	Thu, 24 Sep 2026 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256573;
	bh=QAyR7PE6geMhOAS4epE+ZKoJfPgWY4iNOtNmsoD4xpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m3U+xExSiMvNXkzevt/Gj/CqI+W3/UcFgPz2uaCjkWI0gnp3NYGlrqFK2QGeeCsqJ
	 aHtYMz/TBaftTY0EQFjjP0Ay/uemnBn/G5NMyRCWh3cdU5duHS4slKHFF99rJpJnFy
	 yMA5iQfIVfuiSo5IE0F/RHuUAABL7igrZvlC9hGLXl3v+zaaXbf6tdJIvN3qBCRicM
	 o25i1oMtHH626TC3eS5eUHsW/l1wsFn2p2LeUxmMDuTy2vjK/x1N1bC07ne+bzttJW
	 PadT4EDlrmVNpPve0gn+WZ7T15iHLuQ2iZvdtTOT64YLrlG11HuVElnNRKm4T9tgZ9
	 kIePPxOZ7sJcg==
Date: Thu, 24 Sep 2026 15:29:28 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Serge Hallyn <serge@hallyn.com>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] sysctl: add typed field descriptors
Message-ID: <gbiwlkkqx5ezpn2drqj5apylk7ohbcz4kkrpba6tpqnkcph7z6@5ez5wwz3jhi5>
References: <cover.1789987960.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q6rmzdowuvdg3zyn"
Content-Disposition: inline
In-Reply-To: <cover.1789987960.git.legion@kernel.org>


--q6rmzdowuvdg3zyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 12:54:47PM +0200, Alexey Gladkov wrote:
> Hi,
>=20
> Some sysctl users allocate a private copy of an otherwise static ctl_table
> for every namespace or device, then rewrite data and limit pointers before
> registration.  Besides the per-instance allocation, these fixups are often
> addressed by table index, so changing the table can silently associate an
> entry with the wrong data or limits.

In other words the motivation is to:

1. Remove the per-instance allocation thereby reducing the memory
   footprint
2. Remove the possibility of mistakenly associating one variable with a
   different sysctl name (because of un-synced changes)

Only those two. Right?

>=20
> This series adds struct sysctl_field as an alternative descriptor for such
> tables.  A field records the value type and an offset into an object
> selected at registration time.  The type-specific offset helpers are small
> wrappers around offsetof() and only add a compile-time check of the
> referenced member type.  The sysctl core derives the handler, size, data
> and limits, and builds a temporary ctl_table when invoking existing
> handler, permission and BPF interfaces.

Building a temporary ctl_table entry just before calling the
proc_handler is the way to go, IMO. But do you need to adjust all those
members (handler, size, data and limits) always? Sometimes everything
stays the same except for the one ".data" member.

Best

PS: Any meat in sashiko's comments?
    https://sashiko.dev/#/patchset/cover.1789987960.git.legion%40kernel.org

>=20
> A struct sysctl_context identifies the object shared by the whole
> registration and is copied into the table header.  Subsystems which need
> more than a namespace can embed it as the first member of a larger context
> and select the object to which field offsets apply.
>=20
> Existing ctl_table users are unchanged, and subsystems can migrate one
> table at a time.  Converted tables remain static and read-only instead of
> being copied and patched for every instance.
>=20
> Compared with the previous RFC [1], this drops the per-field accessor
> functions and the macros which generated them.  The first two patches
> prepare the sysctl core without changing its external behaviour.  The thi=
rd
> patch adds the new descriptor, followed by conversions of the IPC, mqueue
> and ucount tables as small users of the interface.
>=20
> This is only the first part of the conversion.  Network sysctls and the
> other subsystem-specific users will be submitted as separate follow-up
> series so they can be reviewed by their respective maintainers without
> making this initial series excessively large.
>=20
> [1] https://lore.kernel.org/all/cover.1787770053.git.legion@kernel.org/
>=20
> Alexey Gladkov (6):
>   proc: sysctl: address table entries by index
>   sysctl: add unsigned int limit constants
>   sysctl: add typed field descriptors
>   sysctl: ipc: use typed fields for IPC namespace sysctls
>   sysctl: mq: use typed fields for IPC namespace sysctls
>   sysctl: use typed fields for ucount limits
>=20
>  fs/proc/inode.c        |   2 +-
>  fs/proc/internal.h     |   2 +-
>  fs/proc/proc_sysctl.c  | 601 ++++++++++++++++++++++++++++++-----------
>  include/linux/sysctl.h | 150 +++++++++-
>  ipc/ipc_sysctl.c       | 188 ++++++-------
>  ipc/mq_sysctl.c        | 104 +++----
>  kernel/sysctl.c        |   3 +
>  kernel/ucount.c        |  64 ++---
>  8 files changed, 750 insertions(+), 364 deletions(-)
>=20
>=20
> base-commit: 587858367581b9c55c3690f4e63382ad622719d4
> --=20
> 2.55.0
>=20



--q6rmzdowuvdg3zyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq1Ja8ACgkQupfNUreW
QU9KHQv/Q2t3eJJ/ItWSSm2PXqK5HJjhxuuikPImvM83fuCtRKnJAEG67TTRhaHO
ty1v6hw/o8Ub+gDSUsLBPot75xTq+3DVgbMyYKUanULzcd2QCwNEbN/bgzP8vP4K
T5KwCvEEc9LYXmq4TnGqcWc4yPPKpnEOZCDwQcJKg9jBxtIBbUGvaxsWFivC+4Xc
cBIKGmhYm6c6buQsUMqwY7tLQSjDb5vfVQZZmATY2DD1Gi1yAKHEhvyisM6dQS+A
4ATJFGRrgbekB4nPbMGVQ/BmgvSqK9ykn1br4qhzfSN1Bo3y8XgrJaLJMLx27938
yzPMgLhtjILZ+OA6hcmbC0os+Fh2j+He/fX1rVK5c+8GpqxZqzlhoJEJDFeq6oLL
fo9HCe7oPM7iQHU+KBppIkVdsUbXqPtwQmRf9PUWd1vvAft/BsoyrM79/37kUyR9
f5bymBkGuoGs2YWvKFEnUa0QRB+DkUyHDeXxMMMtSqNy1y5/Cm8ixLb9gFzEmlq1
nxO6Ton7
=8Mg/
-----END PGP SIGNATURE-----

--q6rmzdowuvdg3zyn--
