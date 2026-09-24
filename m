Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E64248C6;
	Thu, 24 Sep 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260689; cv=none; b=XGmAG4/dabNOvxGWXpzqtSViI3f63UUHLXV4SM/cFMZorzACZm4gX+0onfTZYzvNwDmqcKf/EtLJo0s7o8NnJCAIVPoPtjwY4RqFDnIjTKUJAmDhaOWp8wzO8hl0G8HprSB3I48GzkSHxZIQfCpyFh3S0/yLVGOjUFJHld+mffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260689; c=relaxed/simple;
	bh=mGlcmnIGls6o1OfSJyflTFJfda4N7E1RBJ5hxnP4UFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9tMvO+nPEppxZAtybtK87QYEJv5zBadufazQrbDERgndUWe4YCji2/beUryx4kG66h6JvGkr6FIKlwmqWKZGegscERcNzPpvR/bb+DuYtoVeiAqCRDU+6B50CbLRZAr4uJHUXHdk+ZOZqd+Wy7xhaJiPbKEMoqGu9LyVHTTB7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpqQBHi9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpqQBHi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0B81F000FF;
	Thu, 24 Sep 2026 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260687;
	bh=Igd0sh31gTQ6adT62fN5ERcdHIbc9JcteqykQ44kqT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hpqQBHi9n7NvSNV0+aVkt3GTG9056w7IS+hzvR6dkpW6Rv1Z5ma4oP/fie+m1rwMN
	 RiLcU9Rjm9rMkujrbzW9XJSNkPH1RgXuAVzmmvsB78gJ2iHpV0/AVvDX98AqG6S683
	 S5SUxqi5WwMjBcEFIN6f+ro68sUMuqfIWWTlrE/p6RV2L/ZISxs3IIeP298IKcP01g
	 +PTvW68tubRjI/V9KaGYFfEUjqCgMEYrfqmel49ylkIUTn+xXGzeWGHW3VCQrVO2k3
	 RwTKErmxHBWc8diKGE7VliyYuq6CcOOveVCXSgOJfM7VEkCTP5Aull3ZOz464tEKYr
	 6sj28G14Dhb8Q==
Date: Thu, 24 Sep 2026 16:38:01 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Serge Hallyn <serge@hallyn.com>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] sysctl: add typed field descriptors
Message-ID: <lmqp6t3br4n5di2wtxxzxr7rrf4xyzjswdii4qvppunuau6aj3@7xri3ahkpqbl>
References: <cover.1789987960.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zdag5vmjkefxwjm7"
Content-Disposition: inline
In-Reply-To: <cover.1789987960.git.legion@kernel.org>


--zdag5vmjkefxwjm7
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
>=20
> This series adds struct sysctl_field as an alternative descriptor for such
> tables.  A field records the value type and an offset into an object
> selected at registration time.  The type-specific offset helpers are small
> wrappers around offsetof() and only add a compile-time check of the
> referenced member type.  The sysctl core derives the handler, size, data
> and limits, and builds a temporary ctl_table when invoking existing
> handler, permission and BPF interfaces.
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

I was thinking more along the lines of [1]. I understand that you have
had 2 or 3 versions of this series and it would be great to get your
feedback to see if I missed anything obvious

Best

[1] https://lore.kernel.org/all/20260924-lklm-sysctl-headerctx-template-v1-=
0-b25e51c66ba7@kernel.org/


--zdag5vmjkefxwjm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq1NcgACgkQupfNUreW
QU8L2wwAjXcj7rJyUqJrcYM9gU9aaUTlud5MxQOpbjQXO8kD9Ql2k4RNz4ggKDjC
mA8qAETTSteH9+JUv+fzGjAUK2/CcJtedEu5aIbA8kZYp1EAE3nBMcT2cP5ea8uP
0ohx8UdEMhF6AWPGFD6v9XwiwO+MI7r0uQVsXVO5qwy58ow5EKTx1n4057s0HoQW
XS4iF3JX+jrqtOlCU4vw0iE9KZBszWd+NegMoTsl+vrUOqxXrUMka4cMM2vtFSrD
C3iZY3X+oS4l2CnLUgMpRVHJRNO2Pub+vZfcosd9RNeKU/JXdO4AewQcN/1HwlBs
FvZ5E+CM79MEQDT7FK94Mz9BcG5ZhNrYbNTo4cYBfSnbfn+wF7fZ7kI2Cq9SFpgy
9JysUsa84z08uxNtKKoMMkqnoPEVMy1VCn/jHeR7iuV5cQa1C3V66PhfXJDM4DH+
ZEMbdRni8D6XvKAA0Wiz7cnzNV6SwwexeT2Kg2I7JCfJo9IjWtQDL2d+wbpYdCk4
uwzOtXDC
=C5b1
-----END PGP SIGNATURE-----

--zdag5vmjkefxwjm7--
