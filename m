Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075142D97BB;
	Wed, 29 Jul 2026 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288553; cv=none; b=CuAwcoQRE4169hIheBTrXszr/j0wlBW0OCr1uQbBPEa0X9hLQAnEF6vQw0s4VYF5oFpo9Nuj7gtKc3RhR6tsl3kVVaeqm8z+/77ETIsHcqpue4l50rMzbsWG7NBrkHoUsJ2i/XmdMcKQKkmavNyAu/W2eGTnY7Do8C5+eg0rMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288553; c=relaxed/simple;
	bh=clB4JWIXTxQAH8HUYueQETkqTjtJdDwXPIrDZ/7c0S8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gt98gp7ytoI3+ZuieTjY4SUAWTMgvcJAPDdIZcPNQighfTlPpSl0+Nu+Wi7fhl3+WqZKgcBJztl2W8315+AepfBKwwlxVLExxIGb3xcrylR5AFuRkx6woAorMeUqqNLV3XnBtYcX5ZlOFXZ1OS/0z2x3iIs7IpAiTcevNHDcjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=ZUY/fGiK; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="ZUY/fGiK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1785288544;
	bh=H1YLGWwnsvxtLLbYo0HPAVBXHveTul38Nsl1c4zz7NE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZUY/fGiKyL5U8MLo7QA2pvurvzu3sfK260Sked16NsEWWqF2pggRfbAv/JTmbHeNH
	 vCmpG80nKXhvLTj57gf8yBV/kc5leKkx5ngcevaxp/0ksK6mAnh27Bc15bf4kvXBz0
	 v3hhXRissapnts0mD9oMKhmCfSa3eUjRR92F8tI8=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 7092065AAE;
	Tue, 28 Jul 2026 21:29:03 -0400 (EDT)
Message-ID: <605939add4dfb674bd7ab39ef8dbd3fd22e754e4.camel@xry111.site>
Subject: Re: [PATCH 6/6] io_uring/epoll: disallow adding an epoll file to an
 epoll context
From: Xi Ruoyao <xry111@xry111.site>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, Linus Torvalds
	 <torvalds@linux-foundation.org>, Juan =?ISO-8859-1?Q?Jos=E9?=
	 <soyjuanarbol@gmail.com>
Date: Wed, 29 Jul 2026 09:29:01 +0800
In-Reply-To: <20260514140817.623026-7-axboe@kernel.dk>
References: <20260514140817.623026-1-axboe@kernel.dk>
	 <20260514140817.623026-7-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-14 at 08:07 -0600, Jens Axboe wrote:
> One of the nastier things about epoll is how it allows adding epoll
> files to epoll contexts. This leads to all sorts of loop detection
> code, and has been a source of issues in the past.
>=20
> Arguably adding IORING_EPOLL_CTL is a historical mistake on the
> io_uring side, but we're kind of stuck with it now as it does seem
> to be in use according to code searches. But we can at least minimize
> the damage a bit and just disallow this part of epoll, where nesting
> issues can arise.

libuv uses this ... thing and there's even a test case against
exercising the code path adding an epoll file:

- https://github.com/libuv/libuv/commit/3b6a1a14caee
- https://github.com/libuv/libuv/blob/09591002d38e/test/test-poll.c#L690

And the test triggers an abort on the EINVAL at
https://github.com/libuv/libuv/blob/09591002d38e/src/unix/linux.c#L1360

I'm unsure what to do here.

> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> =C2=A0io_uring/epoll.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/io_uring/epoll.c b/io_uring/epoll.c
> index b9db8bde27ec..eecd748cad01 100644
> --- a/io_uring/epoll.c
> +++ b/io_uring/epoll.c
> @@ -62,6 +62,9 @@ int io_epoll_ctl(struct io_kiocb *req, unsigned int
> issue_flags)
> =C2=A0	CLASS(fd, tf)(ie->fd);
> =C2=A0	if (fd_empty(tf))
> =C2=A0		return -EBADF;
> +	/* disallow adding an epoll context to another epoll context
> */
> +	if (ie->op =3D=3D EPOLL_CTL_ADD && is_file_epoll(fd_file(tf)))
> +		return -EINVAL;
> =C2=A0
> =C2=A0	key.file =3D fd_file(tf);
> =C2=A0	key.fd =3D ie->fd;

--=20
Xi Ruoyao <xry111@xry111.site>
