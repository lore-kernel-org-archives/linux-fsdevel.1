Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A7388E67;
	Fri, 27 Mar 2026 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774592801; cv=none; b=JPun+G59V5jJoTuXkuwVJ7p2CFSLu8NsaKCPVB4PZz+OQyOAHK7flMFGQBumGkmifU7p0A2LKw88YOitpPm9Mzl2CTv9qIp2Ra2mZwNMHjvfPD38n5zKa0O/FyZ47Zj8ANATEiX7l6TfRTDrFug0Vatkxq1aDXDAO3wUc/Bim6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774592801; c=relaxed/simple;
	bh=vVF2X7X6xwhJNZwmWGhKrFPy1mXHUNZFruMxS0IbldE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2E6XFgD7gUl2c+TowsNyv3cayZREcgzT7p+uTspTQav81Dl9nJz6kCmpMTOvk1XgSr/OoDX04O+BY4vZFOKjC/yBtb4YnOcAVs0D31clHtyhegw7ancW+OGNh9/8E5L/SAmWNcEWJNMkXuEL/YRLL+wV8vCa8ALHE8tBsDDToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=vN7A9DjT; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="vN7A9DjT"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fhrJK3yBDz9tnZ;
	Fri, 27 Mar 2026 07:26:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1774592785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nVli7ZdjicMulZS13DL9My9zto95MiCpY5Nq27QLVo=;
	b=vN7A9DjT5XPivWES0LfIIMu4OI9JshKvRsgaSC6aCkqFx/Sc+rjHLS+iWKt8UIOwdzSWOL
	pw9hNteeHX6h+C8nvNmSUYWPd++A2RUcmHe9E4eqc+R5jKf7ERwgou0NYTdy4yCIcR79+D
	sx708ixa+JSFhPaNKVdlSimCFtQ9IJbexDQh2KhNSnTSVk1+jCgqk37WC16tj6EJCxEPjG
	E28IBDLZwk/5VWnigE23v0QfBdeQc/782HjA7aeHHnAWisKMBzKcLMY3nUh1It8DZ1ZFXl
	LtKZZylCU29UvyEgGZgLIHcL64hRf8KsV4zBemRustoOzIWZpRVZU6i7hDC6AA==
Date: Fri, 27 Mar 2026 15:26:06 +0900
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Ethan Tidmore <ethantidmore06@gmail.com>, NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
	Penglei Jiang <superman.xpt@gmail.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] vfs: add support for empty path to openat2(2)
Message-ID: <2026-03-27-finicky-copper-turkey-process-LwZ9E1@cyphar.com>
References: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
 <20260326182033.1809567-2-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="emc4et2r2dugri3c"
Content-Disposition: inline
In-Reply-To: <20260326182033.1809567-2-jkoolstra@xs4all.nl>


--emc4et2r2dugri3c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 1/3] vfs: add support for empty path to openat2(2)
MIME-Version: 1.0

On 2026-03-26, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> To get an operable version of an O_PATH file descriptor, it is possible
> to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> currently require going through open("/proc/<pid>/fd/<nr>"), which
> depends on a functioning procfs.
>=20
> This patch adds the OPENAT2_EMPTY_PATH flag to openat2(2). If passed,
> LOOKUP_EMPTY is set at path resolve time.
>=20
> Note: This implies that you cannot rely anymore on disabling procfs from
> being mounted (e.g. inside a container without procfs mounted and with
> CAP_SYS_ADMIN dropped) to prevent O_PATH fds from being re-opened
> read-write.

Actually, this flag doesn't need to be openat2(2) only -- all existing
kernels will reject a pathname of "" with ENOENT. This means that
O_EMPTYPATH being set acting as a no-op is fine for older kernels (no
program will get an unexpected result from O_EMPTYPATH).

In my view, adding it to openat(2) is preferable because it means that
systemd et al. can use it (they currently block openat2(2) with
seccomp). This is what I did in the original openat2(2) patchset[1].

[1]: https://lore.kernel.org/lkml/20190930183316.10190-4-cyphar@cyphar.com/

> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/fcntl.c                   |  4 ++--
>  fs/open.c                    | 11 +++++------
>  include/linux/fcntl.h        |  5 ++++-
>  include/uapi/linux/openat2.h |  4 ++++
>  4 files changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index beab8080badf..d9ae3c71edfe 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -1169,8 +1169,8 @@ static int __init fcntl_init(void)
>  	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
>  	 * is defined as O_NONBLOCK on some platforms and not on others.
>  	 */
> -	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> -		HWEIGHT32(
> +	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> +		HWEIGHT64(
>  			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
>  			__FMODE_EXEC));
> =20
> diff --git a/fs/open.c b/fs/open.c
> index 91f1139591ab..e019ddecc73c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1160,12 +1160,12 @@ struct file *kernel_file_open(const struct path *=
path, int flags,
>  EXPORT_SYMBOL_GPL(kernel_file_open);
> =20
>  #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
> -#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
> +#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O=
PENAT2_EMPTY_PATH)
> =20
>  inline struct open_how build_open_how(int flags, umode_t mode)
>  {
>  	struct open_how how =3D {
> -		.flags =3D flags & VALID_OPEN_FLAGS,
> +		.flags =3D ((unsigned int) flags) & VALID_OPEN_FLAGS,
>  		.mode =3D mode & S_IALLUGO,
>  	};
> =20
> @@ -1185,9 +1185,6 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  	int lookup_flags =3D 0;
>  	int acc_mode =3D ACC_MODE(flags);
> =20
> -	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPEN_FLAGS),
> -			 "struct open_flags doesn't yet handle flags > 32 bits");
> -
>  	/*
>  	 * Strip flags that aren't relevant in determining struct open_flags.
>  	 */
> @@ -1281,6 +1278,8 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  		lookup_flags |=3D LOOKUP_DIRECTORY;
>  	if (!(flags & O_NOFOLLOW))
>  		lookup_flags |=3D LOOKUP_FOLLOW;
> +	if (flags & OPENAT2_EMPTY_PATH)
> +		lookup_flags |=3D LOOKUP_EMPTY;
> =20
>  	if (how->resolve & RESOLVE_NO_XDEV)
>  		lookup_flags |=3D LOOKUP_NO_XDEV;
> @@ -1362,7 +1361,7 @@ static int do_sys_openat2(int dfd, const char __use=
r *filename,
>  	if (unlikely(err))
>  		return err;
> =20
> -	CLASS(filename, name)(filename);
> +	CLASS(filename_flags, name)(filename, op.lookup_flags);
>  	return FD_ADD(how->flags, do_file_open(dfd, name, &op));
>  }
> =20
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index a332e79b3207..d1bb87ff70e3 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -7,10 +7,13 @@
> =20
>  /* List of all valid flags for the open/openat flags argument: */
>  #define VALID_OPEN_FLAGS \
> +	 /* lower 32-bit flags */ \
>  	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC |=
 \
>  	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> -	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> +	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | \
> +	 /* upper 32-bit flags (openat2(2) only) */ \
> +	 OPENAT2_EMPTY_PATH)
> =20
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
> diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
> index a5feb7604948..c34f32e6fa96 100644
> --- a/include/uapi/linux/openat2.h
> +++ b/include/uapi/linux/openat2.h
> @@ -40,4 +40,8 @@ struct open_how {
>  					return -EAGAIN if that's not
>  					possible. */
> =20
> +/* openat2(2) exclusive flags are defined in the upper 32 bits of
> +   open_how->flags  */
> +#define OPENAT2_EMPTY_PATH	0x100000000 /* (1ULL << 32) */
> +
>  #endif /* _UAPI_LINUX_OPENAT2_H */
> --=20
> 2.53.0
>=20

--=20
Aleksa Sarai
https://www.cyphar.com/

--emc4et2r2dugri3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCacYi/hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG+X3wD/XokatdOzMfrsP9kislkN
BeQ06sXT5Ynm1GGdtbQLPh4A/jPoOoKqzClSt/ClXi1bV3+00mleP87YrPoxEP9a
kbIA
=n2EA
-----END PGP SIGNATURE-----

--emc4et2r2dugri3c--
