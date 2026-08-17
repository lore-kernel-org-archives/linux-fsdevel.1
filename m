Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E308C3C584A;
	Mon, 17 Aug 2026 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957667; cv=none; b=uS97pgpDhHm0Xt1ZwXbozIlIPICVGuxLNdh2+PvX8Oj1rE5knkv/2At8ggGptQWihZk3uvNUM5OYMw3Ix2Hhe8WnktFiYKUKFATcX6RzHvXkTZv+5ht0HaCGekExeoVrD1vAskP2qvIS86CqBKdzwvHoRIIVkF5lIJwyUrQEmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957667; c=relaxed/simple;
	bh=yuM7Pc9ufTXn9qOIvN/26Y3rOIQ+uSq7I6+Q+2GsoWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS3CN1dsQPVegZmjSJKhm3HsB2XoM8koGxRIqk91hNzWAFJBdhA2DI58oqfw9rIjKhQe5jZZBs7ckVTfo8yQOmDO6OqE/c2rpu8XZtkpMA8UgEcHmykRjzrNUJUtdGxaZ99PTUP73DXYK+YJollrwIQH2KKBr4Nfzw2pwXhWx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuePoHOo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuePoHOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA821F000E9;
	Mon, 17 Aug 2026 09:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786957665;
	bh=xwGT5tJCo6zhs0YfuUdogV7G+8vkarwnSczPrBXPfrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RuePoHOojFgF5YA2p4N4ykmdSI2kKb6EKvHaGYqoxDMQU8fszmikh/RvRAnq7eXgp
	 x5RJFQrpG4qQVidpeDYeq33iMD6qVdzIo4+6ZyF3ltKZBpmwF6yuU3BmgOxs/YN/NV
	 pF/z6YRnNFI1xX9NjDRohIIHLaPTlVy3QxaqQnwOVZTP/Yj9I0V5KoXvma9leCGhkP
	 MfUBXT+7XlYE2cAJYn64OUPAjK33AZACIF0nfH6h8J8PLWaFmnRKg9tQGp83ezaSVs
	 v1DXQZcXLpfo0QtEtnwoy4z6qBF+R3Qi+JiAvTsXTpbhQZNchBVIy4ElI6/1V4IqnH
	 kEwcjE0tJjq5g==
Date: Mon, 17 Aug 2026 11:07:38 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] man/man2/statmount.2: Fix incorrect function signature
Message-ID: <aoLOb0tixHee3AkZ@debian>
References: <20260815074526.1094308-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ar2etpy3xot6qf2d"
Content-Disposition: inline
In-Reply-To: <20260815074526.1094308-1-b.sachdev1904@gmail.com>


--ar2etpy3xot6qf2d
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] man/man2/statmount.2: Fix incorrect function signature
Message-ID: <aoLOb0tixHee3AkZ@debian>
References: <20260815074526.1094308-1-b.sachdev1904@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260815074526.1094308-1-b.sachdev1904@gmail.com>

Hi Bhavik, Josef,

> Date: 2026-08-15 13:15:26+0530
> From: Bhavik Sachdev <b.sachdev1904@gmail.com>
>
> flags argument is an unsigned int not an unsigned long [1].
>=20
> [1]:
> <https://github.com/torvalds/linux/blob/master/fs/namespace.c#L5961>

Thanks!

> Fixes: c011cc992510 (2024-07-09; "statmount.2: Add page")

Please CC the people involved in that commit.  (I've done it now.)

> Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
> ---
>  man/man2/statmount.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
> index b6d9dc2a1..a365002dd 100644
> --- a/man/man2/statmount.2
> +++ b/man/man2/statmount.2
> @@ -16,7 +16,7 @@ Standard C library
>  .P
>  .BI "int syscall(SYS_statmount, struct mnt_id_req *" req ,
>  .BI "            struct statmount *" smbuf ", size_t " bufsize ,
> -.BI "            unsigned long " flags );
> +.BI "            unsigned int " flags );

LGTM.

$ grepc -tfld statmount . | head -n4
=2E/fs/namespace.c:SYSCALL_DEFINE4(statmount, const struct mnt_id_req __use=
r *, req,
		struct statmount __user *, buf, size_t, bufsize,
		unsigned int, flags)
{


Josef, was it just a typo, or is there anything that needs checking?


Have a lovely day!
Alex

>  .P
>  .B #include <linux/mount.h>
>  .fi
> --=20
> 2.53.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--ar2etpy3xot6qf2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmqCz1oACgkQ64mZXMKQ
wqkHEw//e6snaLK/8FrcBF5CzGW2CldFqAHQsDCGSHKUd9OCV34jy5h2PL6YMS34
VDlgKLvAMRHS0hJnJbgtudGAEEgNRHYwWHDqLZXyeL7q+vAmhp9lUUTBFe1FlGLt
KUIXC/U2o9tUtCJDGargmYCII9GyUs63+fhgJbCZut01r0x2K5ec1KzyDLnK30am
onHfBZ6u6uj62tq1PPtg8fdrqxqbRZkUw8uU9Fl4lpb4cZz4ZcHTKNrYM0caebnC
hIttdlANhUetugsA84htE1/diQiPMcaQ8+1Y6c8qMQxvWt7hNrHpBexvoWg1vAL6
uIL5vrlPx1vPOaQeblbXnt6OtpO99mooGj+AwvMF95yLPHgGHBsFhYA9HaFrvvsy
0hXpNnFi0x5au0k72UH+BMvoWp9BRMoKRHpra8o4hw/fwRKs5u3azNPPaHaAa3+q
lpki2li7wALzIbI6edrWAIdi/VLshne9+26fqsuSUYdKl2QSy2dH6IpaOKsxGY1l
hdNYQ9aPpYzLz90ly/8+pD0AjIcp9Kndq9unWotv6B7UM82yzlnlfwS204XNC5eL
At6dD4+YwdLkQcPlf4wyKNrmbEvoVJPKHtPBthNaBUbm7R+HO+Fcjn395aSnRNEL
mDMlQ229Vcij2DwKttDK2+R2i3fKK7Ef5SeRGr8rQ+bVlAa7AU4=
=S4v5
-----END PGP SIGNATURE-----

--ar2etpy3xot6qf2d--
