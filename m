Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D664E50D1;
	Mon, 19 Oct 2026 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412018; cv=none; b=jcHwnLB8m4CWAd6M/5OU9A2U/oqEh/Z6A0AEBuq2kTkagttjbbnM99NZvNnLrbIoql+RHB/6Ll7MxTi+x1b+7MqIL3iSMKaXjIctl3hRQUlgfMSH5Hf/WqXMz77MQ3rX/ac5ID/Q0Xzi2iV7FJ0qyv+TYisp2yWplFf57IptbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412018; c=relaxed/simple;
	bh=Kcmzd1MARxy6cQKvZQJwOgauaCYkvTZQkli1DPrgHSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR3u0oVoJAZoh8sYM04SG8MR5NUm//OTXHNAZpBRzlv9TZqi7cwvUU4nlIthPnptKKwZaYpcUrLwov7QfC3b8fv9lj/wuUPp1knq2vhJFwAGyaiHCJ8swflzjDpCjWkQiwJdR+2cnLcoCQE5RMEa4bfgwQmqqAMPpkCWHj53gEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CicMJwJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CicMJwJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D069A1F000C6;
	Mon, 19 Oct 2026 12:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792412017;
	bh=x1ulo5tfLeX6zxSLxd40EYDxojL+fygGEKyZmtMcVbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CicMJwJzB1nrx6k7oD54mVOtUBH+pHXojeOQuA6aktFrB7KPS240RHvPLpBaKWWu0
	 QYaWuvUo9yYzMS7SvQxU58Bf9AsYlTpIC4ZSK5cD6ECc4lgg1uw6ksdHgypTaclwRk
	 E0gHN8cX9sBL6U0XHI0PrXFVGlIvZM7ttAXLxYJUrAFti1v1w+Jz6p4+rHKi1N2Vic
	 KvWdGNSmjf5gii02cW6Ue2OHgY8xp8SjbpYi8/gezIOc3w3JElW+B0wiPQMGUBDOdT
	 2PQ20vDLxdjrHsYNnmt+MV6zOqEZn3QhqewVKo8wVIZA6YZ0zxYxK16E/CBQw+6Jd4
	 P8YKOj5d59drQ==
Date: Mon, 19 Oct 2026 14:13:32 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Serge Hallyn <serge@hallyn.com>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] sysctl: add typed field descriptors
Message-ID: <atYIhvEpCfM4PSj7@hobbes>
References: <cover.1789987960.git.legion@kernel.org>
 <cover.1790439358.git.legion@kernel.org>
 <aszj54qPIdorUTO8@example.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ebgglbbxk7mzhue3"
Content-Disposition: inline
In-Reply-To: <aszj54qPIdorUTO8@example.org>


--ebgglbbxk7mzhue3
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

I have not forgotten. It's on my (very large after PTO) TODO list :)
thx for the reminder.

best

>=20
> >  fs/proc/inode.c        |   2 +-
> >  fs/proc/internal.h     |   2 +-
> >  fs/proc/proc_sysctl.c  | 681 +++++++++++++++++++++++++++++------------
> >  include/linux/sysctl.h | 138 ++++++++-
> >  ipc/ipc_sysctl.c       | 189 +++++-------
> >  ipc/mq_sysctl.c        | 104 +++----
> >  kernel/ucount.c        |  64 ++--
> >  7 files changed, 772 insertions(+), 408 deletions(-)
> >=20
> >=20
> > base-commit: 587858367581b9c55c3690f4e63382ad622719d4
> > --=20
> > 2.55.0
> >=20
>=20
> --=20
> Rgrds, legion
>=20

--ebgglbbxk7mzhue3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrWCWYACgkQupfNUreW
QU9dYwv7BeiZTgmcjyPEkvziGU95kMTrJYyoCiUSzFgPOaKdQcKn0lDBZM0AbWp2
kzTh48AXHSfO4R7Pce4u0YDxX+zbEmdugtem84FVWTLXC5JxqgYnm9YdWrAahIPt
9hnYJqzf8FuYctO/cSlRSddtScG/ezb+N+uKj7yRaCE0pj4wz2pNJIJqK/CM/ugg
nyls4sIQqcmAHpYWW7vd23KBaVPPjTHZMi2s2AH/phpMbkdZ5/uhFFdQulWwMZYi
RiaGIPeK78zMbCopDXnXEEVCmXS0/F01vBRnTHGNImCkOJWaQhnIK4xR4LNA4D4R
xAlkFNjsYDCfONvzs+kXyZZkw572ep30+jomhO4yD0KobPXbcs9hPlmwZmjGtTh4
h69VnqmsaKfoxEmhAqkx1gM7CdpoJsFYlCAFiKkCXJkidj1W1gA/0OgZJozY3dgT
23bvnrpX7F658OQbXuZ3y6ZJNxdR9ba3wLK7DV2YsjdpG7lg8qBafsuGuq7qznyJ
5iAqRkLL
=84QK
-----END PGP SIGNATURE-----

--ebgglbbxk7mzhue3--
