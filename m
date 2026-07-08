Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1688642EED9;
	Wed,  8 Jul 2026 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507815; cv=none; b=Of+Zl7FsEgSpIVmwNdGhBysvCUiC9TF5lhIoIFPzrr+WGCOKb7mUjIX7z0eGOzLjSr9RJJRVmbogvtiwspLCQqbJUMUj3SVjQkt4oY/a0ROaEgHS9CDqd8ewQJgkvUmIMcixjmVFgo7FX25fjdGmsrTcAih9ejfYwtN6J0lJAfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507815; c=relaxed/simple;
	bh=lU1uOWWnTVs0aL9mJTe/iICeafu65+qXIbzy7fSaCow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLJ3Hf2I6U5ELBKu5gKjJyhthEoqeVgcoI7SXpsh7SFJ1HHLHBFePFDY43PdwobwR75bF1tyWqkbean0pnDBRoGbOMs9lwXfKkBcOv4kxpa5HB7QzhIjy8GzT2gPm/E6uJIcll+x2UX8P0LobrsRU2eaVwiGt3tCSGa7TNhVxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrNncAH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrNncAH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF801F000E9;
	Wed,  8 Jul 2026 10:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507808;
	bh=A9nkaP8lgfrQp2+YzsAxpXHQMVHlSJOkhpwEIfU4SNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OrNncAH2nGE3RC9KnIPHpUD4hJEnRgdLi7HkSCIldASlJOHHbFz4MOl0Qwuvzi3tQ
	 HQi8+uAsdhsQYIelDu+TomUXZ/+c85lAPVDanUVs7aEEC2NmMuWY8VEkKGPbrddn+b
	 MzU5LBl9Fwe3XoFJvPAMl0f81VHQNq8Yw25589sCQMSGShuAsNe1/muaQU8m0Whjly
	 qAoKp743XyjzyiAWmbDvr74WgluB74PnweP4HzTN4BaLJhMHXtXczhOipgkcL1r7uY
	 qrOfJFQllZiKbepXslGKHqNl3IznKgz3BCnSRWhWkCVr5ofjb19V2A9ooCiAzjqQcl
	 HGXoRwVZVT9cQ==
Date: Wed, 8 Jul 2026 12:50:03 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] sysctl: Consolidate do_proc_* functions into
 one function
Message-ID: <ec7erkpto5rymf2wbqznpg3spatdhyyfp7vp7szz5otlssfsme@fop557qvj3li>
References: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xyb44fc2rlqi3t6d"
Content-Disposition: inline
In-Reply-To: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>


--xyb44fc2rlqi3t6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'll put this into sysctl-next to give us time to test.

On Thu, Jun 25, 2026 at 10:38:12PM +0200, Joel Granados wrote:
> What
> =3D=3D=3D=3D
> Generate do_proc_{int,uint,ulong} with the new proc_vec_conv function.
> Removed small differences between each implementation and put it all
> under one roof. This function is meant for internal (to sysctl.c) static
> functions; it should not be used from the outside.
>=20
> Groups and document the proc handler and converter functions in
> include/linux/sysctl.h. Document how to create custom converters
> with examples for every converter type.
>=20
> This series sits on top of v7.1, you can see the working branch here [1].
>=20
> Why
> =3D=3D=3D
> Working with one instead of three slightly different implementations of
> the same thing makes more sense to me for three reasons: 1. I don't have
> to think about the different types separately (less context switches),
> 2. One place to begin debugging proc_handler issues and 3. A fix for
> one type, fixes all types.
>=20
> Why the intermediate macro
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> This series introduces a macro, only to remove it in the last commit.
> I left it like this on purpose because I think the transition to one
> function is made more clear with the intermediate step.
>=20
> A word on checkpatch
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * It does not like that ENOSYS is returned for the no-op functions. I'm
>   just following the pattern that was initially there. Does -EINVAL
>   makes more sense?
> * It has a false positive on a spacing around a pointer.
>=20
> Testing
> =3D=3D=3D=3D=3D=3D=3D
> Ran sysctl selftest/kunit on x86_64 and 0-day.
>=20
> Changes in v3:
> - Replaced the initial macro implementation with a function.
> - Rebased on top of v7.1
> - Link to v2: https://lore.kernel.org/r/20260101-jag-dovec_consolidate-v2=
-0-ff918f753ba9@kernel.org
>=20
> Changes in v2:
> - Handle neg more carefully in the macro:
>   1. Initialize neg to false. So it does not inadvertently return
>      a negative value to user space from an unsigned variable
>   2. Return -EINVAL when the user passes a negative value to an unsigned
>      type.
> - Link to v1: https://lore.kernel.org/r/20251219-jag-dovec_consolidate-v1=
-0-1413b92c6040@kernel.org
>=20
> Comments are greatly appreciated
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.g=
it/log/?h=3Djag/dovec_consolidate
>=20
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
> ---
> Joel Granados (10):
>       sysctl: Move default converter assignment out of do_proc_dointvec
>       sysctl: Replace do_proc_dointvec with a type-generic macro
>       sysctl: Generate do_proc_doulongvec_minmax with do_proc_dotypevec m=
acro
>       sysctl: Add negp parameter to douintvec converter functions
>       sysctl: Generate do_proc_douintvec with a type-generic macro
>       sysctl: Rename do_proc_dotypevec macro to do_proc_typevec
>       sysctl: Group proc_handler declarations and document
>       sysctl: Rename proc_doulongvec_minmax_conv to proc_doulongvec_conv
>       sysctl: Update API function documentation
>       sysctl: Replace do_proc_typevec macro with do_proc_vec function
>=20
>  fs/pipe.c              |   2 +-
>  include/linux/sysctl.h | 123 +++++++++----
>  kernel/sysctl.c        | 475 ++++++++++++++++++++++++++-----------------=
------
>  kernel/time/jiffies.c  |  28 ++-
>  4 files changed, 364 insertions(+), 264 deletions(-)
> ---
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
> change-id: 20251218-jag-dovec_consolidate-5a704f2a3f9b
>=20
> Best regards,
> --=20
> Joel Granados <joel.granados@kernel.org>
>=20
>=20

--=20

Joel Granados

--xyb44fc2rlqi3t6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmpOK1oACgkQupfNUreW
QU/gkgv8Dvft5IXqMzXqXNjiq8uJ/mj7EW+nVk1jwkYMzS87fgURkyTJ8FLvml2C
rOg/bkAkSe54B59lSeTvTbfhwjzbyq82wdI3j8XWUcfstljPTj1fQgvTF/31VDp1
w4w8k9e0I6tkpteBZEaTQ77xnD0B2VqQItifzwZHSUhU02kzrJUp6uFxMTIcsQk1
4IlH7U1FVo7e+Voh9Q5fjE9KCfCOkD6bCF/gXF6kfSW0aCN/uDF/5Kw6EM2WUqj5
XkN1xLflRxaoZKm9evz1FwYn0LSZLDTJiXLQAnhntQBTxR7JCrupZpFz5LnjkVnv
jzaTheRxAvfKCjaU+IQx5nNfx650YSOd3z6A/KfW41/3yP1NDRMdTGyj3rfT1M/2
8KKsAJ47sU0li1DzqzhJDj737vo3SbGnhhvH/b8yLYwWdcejOX7MDDFZ2AqaHdPu
iBhIbVDLvCiHJ4jl1Ps3+WWCNwIfNRzgq62laQPckPOzWdNhHYdoFSoHLKUBJl9P
hdst6IlS
=gGpM
-----END PGP SIGNATURE-----

--xyb44fc2rlqi3t6d--
