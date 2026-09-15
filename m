Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576FF485CEC;
	Tue, 15 Sep 2026 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473193; cv=none; b=bdFcCDXz7NCxA83NaoRbLnD3z5RNm/hjrhhUhVdPl+cmQ2rjO1HtNGc/7Y6hj4YcNjAVeYnY4Z0TNuYmE6mDmGHv39ygsq7K0HEvXzg+IOEw1rJHXA36At4edVYyX/CWsJGsCKq6rSApHACKIzmM4ViZBMSxpyHCycs6LPFX1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473193; c=relaxed/simple;
	bh=SB6i1TkRgK612AfnnsVY4olctcc75HncKfHTvnrtP8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4x273fZ3gbqee1PyVhTLdUSjhtGkvgkh6lN4y99ofVl4SU4PyH3GXCrgd2O2TPSeJN/JFmvxZFoHdZQTTvV3zqZnr29mNOi4JwMG95iSEiFrF3is/4NabPDseXZxoARcZDKbo2gFgIAAlfgYT2y/Nm/nmNUDkBKn5I83wzj8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNPd/XH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNPd/XH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4987C1F000FF;
	Tue, 15 Sep 2026 11:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473191;
	bh=O+zWMO5Xj19Spqy4WM07OMJbwgwnSpgue67uWDwSOUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QNPd/XH14WcSYKnNvM7q+LytEQem8r/FvdydoZcTNCdGHDv/EIHHUA2sDBVJ2Ibbm
	 uuZACDN3/b2+aLg8wqPezWewbs1PJqeEvqT2ZC0/9n25AiI40rDMd6izD3iyEqiDfu
	 b/vO5ztX3g9OwJsGrKUI9HUFeF3yh339aeyxExWXQRWvKC0k2IzEEIsCFSIxBamO9j
	 Xf8lXLAJQ/DHpyC/CylNHk2iGUbegYUwHxYErmK9TNtAnGwwLJX1/b77wIqRmUZw8z
	 UpFu07t3FGt2RU5uhK6DhRxMLuBtD17uYk2IGHF31qvpXAB0lMQ/NYrE674bk+gT0H
	 ZBwgATDzmL6EA==
Date: Tue, 15 Sep 2026 13:53:06 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Safety 1 <git.userk@gmail.com>
Cc: kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Safety 1 <176830914+JokerPython3@users.noreply.github.com>
Subject: Re: [PATCH] fs/proc: avoid unused ctl_table entry in init_header
Message-ID: <lzl6lem6igc7abqild6haypxnkr636wasu466hyvgc7k3mcuht@23rchp73jxv6>
References: <20260909163214.245399-1-176830914+JokerPython3@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rdhlkomltylbjfx6"
Content-Disposition: inline
In-Reply-To: <20260909163214.245399-1-176830914+JokerPython3@users.noreply.github.com>


--rdhlkomltylbjfx6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 07:32:14PM +0300, Safety 1 wrote:
> The entry variable in init_header() is only used by
> list_for_each_table_entry() for iteration and is never read. With
> -Werror=3Dunused-but-set-variable, this causes the build to fail.
That makes no sense. entry++ implies a read. Additionally that entry should=
 be
removed once the code is optimized compiled. So there is no need for this.

>=20
> Use the table size directly for the loop since the entry value is
> not needed here.
>=20
> Tested with: make -j$(nproc)
> Signed-off-by: Safety 1 <176830914+JokerPython3@users.noreply.github.com>
This is just wrong.

> ---
>  fs/proc/proc_sysctl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 04a382178..ddc510def 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -206,9 +206,7 @@ static void init_header(struct ctl_table_header *head,
>  	head->node =3D node;
>  	INIT_HLIST_HEAD(&head->inodes);
>  	if (node) {
> -		const struct ctl_table *entry;
> -
> -		list_for_each_table_entry(entry, head) {
> +		for (size_t i =3D 0; i < head->ctl_table_size; i++) {
>  			node->header =3D head;
>  			node++;
>  		}
>=20
> base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
> --=20
> 2.55.0
>=20

--rdhlkomltylbjfx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqpMZYACgkQupfNUreW
QU/jQQv+MtKl9izwUR4ANXAF8uCgHtcB/HncUj77+lIpsOC9ucKhIuVS6aLqxlea
uaCMe1wJcP8l9x5flbR357XWTd8k+fQgX5t48kIG6KJu6G0F4YYuELBY3mIXaz1p
coiqrqjaGBtj6PjalttUTyhPMCfkvyyyPR+sNq2YbyQqujQvdu0+hch+LSN+fCEo
0ifG+9Mb6uyCV+YHgG5Ak7N1Tc1mpyhw2kB3TI+NYnhVBVNt/fM4fpYZiDfTWX8k
3at5aqWdHwQKD/1M1prAf5Zla4mGpQw7a37wqOU7DHkBqo1rlX9sQuHMeYwj4OEE
SGr3WEqG1afkKnzlEzNgQKR6xlvRIwcZWl8201e2Lx7EbK6H4+VTEKqfFPvvt3fa
9kJGDeuW+QAHZTIR3oXJ8YVMw+cj97Ctrp/r1BRUdvXPr1H+8ZaswIF+GxAbzfUd
Y86EU5tXVcVGPQ1e2SioUVDGVNUVMXTKWqHeZRHoIkO/FrfiVG2r1dR+nM6gGeRw
i53Lzb/W
=2kLQ
-----END PGP SIGNATURE-----

--rdhlkomltylbjfx6--
