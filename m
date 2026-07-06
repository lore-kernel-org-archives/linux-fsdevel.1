Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2E3B27F3;
	Mon,  6 Jul 2026 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317121; cv=none; b=ZhmAjhGHDpyExqJARlo+d6UOSWnnKr9YwU0/Hq/v8QWZTCuk5x4bg1D+Uph3ktJEriuAB3DuwSbjM04ERkPMf0pyA7BxVYFh0758EPat1SdmzyRlQr7iu4nLFQNYLc3O+he3selfwiolaSTSlzM9fGkG/Zye5PEvX4ATQ63GUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317121; c=relaxed/simple;
	bh=fBA4q37u052szX2pL17hE8taDIlFfqtGKtN0RXiju8Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gv9hlgcuLqOldhfeEj0coGor4lgnOIV0goC2Hkc47uhoMvMjBICUmfkLhvrFc0aJxh5PLRjnET+14WCSeZgMWKUoD8WxJiJ1OJHrW/rJImOx0amlaFoZNyW1qkkFd55ibvGNck084NmiNgKlrg7oBjOaYH6b2guVp2GDORi7vsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=g58avU/+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q+oIiD8r; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="g58avU/+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q+oIiD8r"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96C467A00DC;
	Mon,  6 Jul 2026 01:51:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 01:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783317119; x=1783403519; bh=/oz0J2oDTi4/GxxeASivLTC5knUP7AWNvB5
	Q6rgM188=; b=g58avU/+v2x8o2pNq1w4Betq/1HnMR/darqyvZr8CrgwJnMCbki
	kboigL8GqyfHKwmc2ZJ2iBu+9+oiqVrej8pjk/VrX6EFGMnsY1+ZH4G2yft5ajJD
	g/icLtJC286beocmFvlmQcTYzMRppKpHMkVbJkXwQL7/gnOUQ/bhOmFWVTu/avL7
	4jg9qvILyLBE1g+yFtOME2v/8Tl6EA3xXl28kervwBuKFzfIrSMrKovYmsDsgGbz
	9N2zxYwULq8E17bnY+kmYJS316bp1QG4MDwqQSU8+Vz3phg6Ko3TmWAb/u4hXgR1
	Aa4mEIiGP6XAhIgAL0MJN+Uwp+KvTP9CQTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783317119; x=
	1783403519; bh=/oz0J2oDTi4/GxxeASivLTC5knUP7AWNvB5Q6rgM188=; b=q
	+oIiD8r9UV71DMkh6MgV6uemp7hANjkVrMEePbTHfK2U4hy60O3Plr+B87COF+2x
	f0/u67/rvvJvRsEgGEbQAeOvfiJcnUEJ9+AbHKdukzRuxQx3MQpfraPDKC89Bh4T
	/e6PB4juHr0JR0GDFaOXQ2CcNpl7WcJfgvUGEHMoff4YPfuanxJV5+BfI8MwYsqj
	Kk+k21jk2SkYaBHI4B6ZYW6vFJigV7O6epkRnHeybWLkef8Xg6f1+3o2A8XHlIpg
	kPyGEqWNbDhNgTzHNYPtKql8raRQroXqIDlxHPAtpWLt58rSPd674PDml6Vx02xy
	h6WgrnLYwBLwCRTzT1Kkw==
X-ME-Sender: <xms:f0JLaqcWOpcp3S5uFOKIoE2rsUqjwGFMbIFsd-pU0aU0_pGy1J856g>
    <xme:f0JLav7nr7uqNuaDGt25o4lTB0kBAhtV89IesMmYVB-u4AxqICpMDCTJN7ASQ0IaS
    NBrbccrAZE_OqJN68S3OZi61zdGqbpWRlX9DKcSD4Y02rbFZg>
X-ME-Received: <xmr:f0JLan_88EZNRUH5HgMNvEewjFTIEIkCktXoQO-JwJE1JsoKeeX5PoR2ON2a5mBkdooxfLgRwHvcoowjo76yAYU1rZoPevE>
X-ME-Proxy-Cause: dmFkZTGr5s8+228ljllYeqtSfpbnAxP616BmLcVVReD9PAkVrq1Frpv/sEaNpfyOzMAaCg
    tDffg3VTtiq10NkzSOxhu6bMiiw5uFmmwfOj4Yo6yV7RBbwxWCXYeP2DPlPy6BrG14dnIh
    WsJxzZj9pX0nBjBwzNf34a3+HLLMeM6LoBqxcXmY2PDdweouIm6cpX7JXKBtUjZuDhyvhf
    m5wJnMDQfCkallwgMlOs0XJpa4UG6jOsU9vEGHIE69Ml1gk2D34dgmX/0VVyMPOtuOq0Mp
    h1FVEWf5IHRKc303PeqIUH7faHd2KmuPuUOEDAqzt9DOhOZSPqPoJr/oTq1JKDJwEaCITK
    OB6Ly3g4YPVon0BYsPJBmJ9KlPkSkm14T6nLoQX9x4wIKOAusWT3NddKADBaGH0uvtt5KC
    A0uzwhTt+4t+ysCag3QNkn2BW1Q5/CsuwT4y2xEIkGAhbT2Z2LkOZz8vYdKqSsPqyUmtc4
    6bVWMOZgk1eQT4x1b/GeGa7YrI5Q0W7ZE4u75XzaIYYGq18/O40iATPRG5qpx39+QHUIg5
    3jJan9CiZio7iWAZXU9LvymicD9O9Uxp8LaZFESxPGuVuBWWzD+z6hyDmgNdGWE91SMyz1
    5E8SbAeeyA51UIjuP4P2pVQd6YzoPxu9YCoFai6nppV689IXj7PvsCeiEhVA
X-ME-Proxy: <xmx:f0JLahF0p_oPdF6LhpN3n9JaIT6WRPo_tQ7wTgieemr-MSnOrpJGBg>
    <xmx:f0JLasUoQsL95ZkeY1x_r-zFqAc9jnHufWvwvoHVNurTstz_vsbw-w>
    <xmx:f0JLat_CKCbKesZ8mk4ci_kNZL6p3IxmnkEdeerFSSZZ6HUJGkygPg>
    <xmx:f0JLap5jdaiZT8Vq4rvHysciQWVV3HHQGAcbwGxGOn-FnhY0o9aciA>
    <xmx:f0JLatln9Lr0Sdr3reT-IqSjeIbYUB7CTxlC6AUToI-pOX6iodLWey_y>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 01:51:56 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Aleksa Sarai" <aleksa@amutable.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jori Koolstra" <jkoolstra@xs4all.nl>
Subject: Re: [PATCH v3 12/14] vfs: short-circuit MAY_WRITE access for
 O_DIRECTORY opens
In-reply-to: <20260704164149.3480051-13-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-13-jkoolstra@xs4all.nl>
Date: Mon, 06 Jul 2026 15:51:54 +1000
Message-id: <178331711459.27465.5575151912695180298@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 05 Jul 2026, Jori Koolstra wrote:
> Requesting write access on a directory can never succeed. Rather
> than performing a path-walk to determine whether the target is
> actually a directory (-EISDIR) or not (-ENOTDIR), or does not exist
> (-ENOENT), etc., we short-circuit to -ENOTDIR.
>=20
> Currently O_WRONLY for directories is only blocked in may_open(),
> which happens after we have the inode for the target, so after any
> create via O_CREAT|O_DIRECTORY.
>=20
> The advantage of short-circuiting is that we don't have to add even
> more logic to lookup_open() to differentiate -EISDIR/-ENOTDIR. Also,
> for filesystems that define atomic_open(), handling this cannot even be
> done at the VFS level, as we can't know ahead of calling
> ->atomic_open() what the result of the lookup is.
>=20
> Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/open.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/open.c b/fs/open.c
> index 9121aece78bc..87e8864d9480 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1270,9 +1270,16 @@ inline int build_open_flags(const struct open_how *h=
ow, struct open_flags *op)
> =20
>  	op->intent =3D flags & O_PATH ? 0 : LOOKUP_OPEN;
> =20
> +	/*
> +	 * Requesting write access on a directory can never succeed. Rather
> +	 * than performing a path-walk to determine whether the target is
> +	 * actually a directory (-EISDIR) or not (-ENOTDIR), we short-circuit
> +	 * to -ENOTDIR.
> +	 */
> +	if ((flags & O_DIRECTORY) && !(flags & __O_TMPFILE) && (acc_mode & MAY_WR=
ITE))
> +		return -ENOTDIR;
> +

Nice simple approach.

Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown


>  	if (flags & O_CREAT) {
> -		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
> -			return -EISDIR;
>  		op->intent |=3D LOOKUP_CREATE;
>  		if (flags & O_EXCL) {
>  			op->intent |=3D LOOKUP_EXCL;
> --=20
> 2.55.0
>=20
>=20

