Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557D26158B;
	Mon, 30 Mar 2026 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872758; cv=none; b=lDGC8tNrSbJ6UrsPXs7tW6pboOg80qq+cOTblfgVXIkwUUUHrACSd0PSwwVhKwHMw/YeyxRa9Lv3o4AvZaQHd+NH2+ZhZvzg1dm0dRtoJtZUY3fMKpJv0rf3+MBWYGMzetAwGXa7f3VjtNNywCKdRWH+IviSkTtEhks0LDzH9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872758; c=relaxed/simple;
	bh=yEmrf+JTnTJ95Cv0KoHwIbHQDWbrEQQdV+atXyjYZAc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eu1Unf144NCmLTGEVUsB+aWtAbz7d367JDdVef5Pxryy4cyS/eA9Y0MSI0ihQBlhNtjdCBBLqI87MmqYvPbDWBsTPaub7sc1In7NGbEIfTi1zKcHlYJ4tW3T4OfBboPf8UKyx0YeoRZCtbAFo4dbPkG+L/Kz0RcRaIMeTUZHtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNdp4K5s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNdp4K5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD6DC2BCB0;
	Mon, 30 Mar 2026 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774872758;
	bh=yEmrf+JTnTJ95Cv0KoHwIbHQDWbrEQQdV+atXyjYZAc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iNdp4K5sHwmSPuSETaU/mDyHTxBtdE9IokRxKreRihak7yhcPRwalvjO3ygtPKQAI
	 U2WyiRk7WVlFPEKyYzbSRNLEhIhPf/vHafrT5StPIwr7E9lDkH9c9N9m2yGsRW5G05
	 7ce8IabAAmaLGWX08lLGIuNEBDOL76KiyIxekzqPgmcjOaKXuuihkSM2VFxs1y7Ufu
	 cWw0I816JIRGh6EYOWz25AX2yxFbdk+nEPa4qSMBHgIIRL8pWM67v4tpHQ4imGJpD+
	 uEjUh8KB4ClpavZehEPzSQqL9UNEjDHnndTkht1YEICElvrC/gKwYiBIJvDrqVhvl2
	 iFt8j9HhuUPWQ==
Message-ID: <ecc86514cde4732995d9f50b9f5071fbb1f675e4.camel@kernel.org>
Subject: Re: [RFC PATCH v2 1/3] vfs: add support for empty path to openat2(2)
From: Jeff Layton <jlayton@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>, Chuck Lever
 <chuck.lever@oracle.com>,  Alexander Aring <alex.aring@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner	
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan
 <shuah@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Aleksa Sarai <cyphar@cyphar.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport
 <rppt@kernel.org>,  "Liam R . Howlett" <Liam.Howlett@oracle.com>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,  Ethan
 Tidmore <ethantidmore06@gmail.com>, NeilBrown <neil@brown.name>, Oleg
 Nesterov <oleg@redhat.com>,  Penglei Jiang <superman.xpt@gmail.com>, Kees
 Cook <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>,  Vlastimil
 Babka <vbabka@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Namjae Jeon
 <linkinjeon@kernel.org>,  Mateusz Guzik <mjguzik@gmail.com>, Wei Yang
 <richard.weiyang@gmail.com>, Bala-Vignesh-Reddy	
 <reddybalavignesh9979@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Mon, 30 Mar 2026 08:12:33 -0400
In-Reply-To: <20260326182033.1809567-2-jkoolstra@xs4all.nl>
References: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
	 <20260326182033.1809567-2-jkoolstra@xs4all.nl>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-26 at 19:20 +0100, Jori Koolstra wrote:
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
>=20
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

Looks sane to me. Can this be merged apart from the rest of the series?
It doesn't seem like the transitive stuff is dependent on this.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
