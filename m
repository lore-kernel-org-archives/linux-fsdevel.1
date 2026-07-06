Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921313B7A3;
	Mon,  6 Jul 2026 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783310168; cv=none; b=gQwWwcod13CU5tbBTmUzKicsZ4quHFIUfoUPEEyj8RV6h8Legduktp8bc5DEMD0yLg+RsdIe5i9aoSzQ8fbpF0hWbYwA1uLHfL84a5kwpQFOuG2N/n+kMM8QW0DLwRHnqrQ++sieFrRlekOlbl0B0j+T7k8uouAfgjda82b1PuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783310168; c=relaxed/simple;
	bh=RgzRhDtCq4hVxwGhfvUcKlc2wypkYdqxaR5/YRkaP5k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=CIeMbyKi+pUQFHoIxjVigQi9C2v9ZY/s219FR5ug+cOQBO5mddpKEhqielU8scpIxYuB36uOB/o0Nn+JoWXnJYdcJRGkAQkL0zbtDR/oPZmnJONBKD87bM4dXQLkRWWE87dFEg+jHLpOQ/BLmjbQUN8/3ZbuFDJf6ikPESsMMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iE8jYCVh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rk25lu5W; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iE8jYCVh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rk25lu5W"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9CCBE1D0006E;
	Sun,  5 Jul 2026 23:56:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 05 Jul 2026 23:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783310165; x=1783396565; bh=s6mDSt/+U5YHaxVTixq0MsBHfguO27Rmlx/
	TpRSzjdg=; b=iE8jYCVhedEtlZbqv3XOIITfcFhOs4C57emIcF6j4il1+UxKkve
	GTLYCPewdvziNI5aLzgqbY6dpyNCojZEAjOUvVY9MHPQoZXGwQi82FGc6xB9zOgq
	hCCWL4wCiitzy8r7dpuke0/rXSf+i9lETTlQiDzftiIfJYSJo44qYIzw2Fy/NbTF
	xN7wle0A2n05s3rIrlS0hV17C4evkyLZMBBYWQFAmANois0rgp+DJuvK9F4ffVcc
	CTa8W5y5mjTnjhvE7ICN9dBmaUeoLhirC+29Ufsm4t2he58HqmAxoIoavB2cc/tc
	2uMlp+eT8jyENKw/hkXi1rfIk1LzMl/Hh+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783310165; x=
	1783396565; bh=s6mDSt/+U5YHaxVTixq0MsBHfguO27Rmlx/TpRSzjdg=; b=R
	k25lu5W2JS5DwuXKc1UyVLETOckL13J6EkhTiOoOUi8A66yBg++KcSQ3+vStDu2C
	jCylCCGDBvsYHEj3XfAxRyzvY3drjy1CwDVGMjW8+4u4MRSpB0ss+2rfVhh5NbgH
	K8W2T05oABIA2Dr7J56jOXJEPSg4orFjVlhVWKVU76eIIssU/NhNbNTViYIaq4gc
	CpWON2D3X9fGUJncTOrQWm29mGRQk6rKNmsdyhsOinnibCv+XzsLTmch2+6xMrpg
	hYymSRXyjT59CkLk8pTwL+KXdUU81SCrljp6jv7fHbssP9Fn0YD+IpEzEPlC6ukU
	8D0+MKzMy0vYChWazzBkQ==
X-ME-Sender: <xms:VCdLav0vyQiURHuaNNJaFljxldK5iYdssn0cJSKH5SgQaZjy1B6TMA>
    <xme:VCdLaqqjzpl0g5buHAqcmIiY2K329mjI5m31VNUPNAlIgXY-v0kXfmLt11ayF3ouK
    w7XfYLF2dB3x3RsKLnypZDQRe5usaevrSz2OgtV8Cz5eGLblQ>
X-ME-Received: <xmr:VCdLakWkZOQtQ2U4kYFJ2yOQ2m3N5Cs71qSo2Lt_96qyh-epLZGJvVKRMyoKFguib2pYJzGQanfaWnW5qKQDNkBgLcub7Ts>
X-ME-Proxy-Cause: dmFkZTG0h7Ae4Wi2W8x8WdEkM9+xue7ADUw8fkxP86Z59nTZmGH9Hlkh62LJKpXZ8kFzMd
    uNchGpOnLdWN4Mgerr0+CEEbJk+SbJ5M7HYBe9ZiYPsi87onodiWxnQ93J5DxrdiIbbWwW
    vY9xTNIgNiRJUgLelDm6r3DNn3/FbK+MF0N17DqXaF4O5DOVJL/S5WSo28YY5/gxXBn7Ia
    byJC9tpV+eCIGrxQvH2NP34iJFK7sit+eyUaXya3l9uWLyWD+sWhop0wuEFYi8e3CdPDkp
    Dn1rFBOOmTvqEwpi51K1+b9aqfA/IEyI780fYApDAbCB2t41se6ZCKfentCtc2x91cFCtJ
    ZT2rh8Fh1KO65+eEJl47LrmOe73MJB+jiuw1O2+SK7piyJMa58ECCOgjEfblWqeSbNrF2P
    Z66cv3fl6bKn8EJ+ttaFYXQg4I+eT/s6U7OZ7+eZOwSilZbUFbWEf7/Jvjk1h4YANu0E1/
    WehmY5YEVWvb6gqCUwF66r8fUdhGs0poOMBo9ML0ZG+zX0LVL/7hVjXa4h7ntzdFrwW/av
    VnFC9s4CxDaBSZYKcdscIq+VF8KCBQThb4ncKzmyh7KAw3k635pMq4v/4Qyqgba2QzAjT2
    rqv3aPbYoXPV6+13DJooIPbv5UQf7yxNvVQR39P/l7vybLg5aW4SIC06yhfA
X-ME-Proxy: <xmx:VCdLarrwgCDe8c2A0-8DiZRy3C4wiq07UAXgBFycA_F3U0T11NDw7g>
    <xmx:VCdLajBzw0Iadu1eVbmKC6PgTMpp9UlNa5pXyrz5MFOdP4u3DAsA9w>
    <xmx:VCdLavii96_MlyEU0QHjhqSbiS7M7C_b4EqtEt79X4jB6rrG5YDdNQ>
    <xmx:VCdLapacO0k5WUz5xKXzhcUXy4c3Mut9c1IW4jhQuJr43UuTNts_qw>
    <xmx:VSdLam7VkisM0Tfse_lEzkE6ou1oxAu-4-sSIotGB1pVQj5LGADR-KiM>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 23:56:02 -0400 (EDT)
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
Subject: Re: [PATCH v3 01/14] fs/namei.c: use trailing_slashes()
In-reply-to: <20260704164149.3480051-2-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-2-jkoolstra@xs4all.nl>
Date: Mon, 06 Jul 2026 13:56:00 +1000
Message-id: <178331016004.27465.14624469599238469373@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 05 Jul 2026, Jori Koolstra wrote:
> There are several places in fs/namei.c that can use the
> trailing_slashes() function to improve intent.

I think it would help to state here that trailing_slashes() is changed
to take a qstr instead of a nameidata as that is useful in more places.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 19ce43c9a6e6..a8890bc0ae21 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2781,9 +2781,14 @@ static const char *path_init(struct nameidata *nd, u=
nsigned flags)
>  	return s;
>  }
> =20
> +static inline bool trailing_slashes(const struct qstr last)
> +{
> +	return (bool)last.name[last.len];
> +}
> +
>  static inline const char *lookup_last(struct nameidata *nd)
>  {
> -	if (nd->last_type =3D=3D LAST_NORM && nd->last.name[nd->last.len])
> +	if (nd->last_type =3D=3D LAST_NORM && trailing_slashes(nd->last))
>  		nd->flags |=3D LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> =20
>  	return walk_component(nd, WALK_TRAILING);
> @@ -4521,17 +4526,12 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  	return ERR_PTR(error);
>  }
> =20
> -static inline bool trailing_slashes(struct nameidata *nd)
> -{
> -	return (bool)nd->last.name[nd->last.len];
> -}
> -
>  static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_=
flag)
>  {
>  	struct dentry *dentry;
> =20
>  	if (open_flag & O_CREAT) {
> -		if (trailing_slashes(nd))
> +		if (trailing_slashes(nd->last))
>  			return ERR_PTR(-EISDIR);
> =20
>  		/* Don't bother on an O_EXCL create */
> @@ -4539,7 +4539,7 @@ static struct dentry *lookup_fast_for_open(struct nam=
eidata *nd, int open_flag)
>  			return NULL;
>  	}
> =20
> -	if (trailing_slashes(nd))
> +	if (trailing_slashes(nd->last))
>  		nd->flags |=3D LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> =20
>  	dentry =3D lookup_fast(nd);
> @@ -4950,7 +4950,7 @@ static struct dentry *filename_create(int dfd, struct=
 filename *name,
>  	 * Do the final lookup.  Suppress 'create' if there is a trailing
>  	 * '/', and a directory wasn't requested.
>  	 */
> -	if (last.name[last.len] && !want_dir)
> +	if (trailing_slashes(last) && !want_dir)
>  		create_flags &=3D ~LOOKUP_CREATE;
>  	dentry =3D start_dirop(path->dentry, &last, reval_flag | create_flags);
>  	if (IS_ERR(dentry))
> @@ -5569,7 +5569,7 @@ int filename_unlinkat(int dfd, struct filename *name)
>  		goto exit_drop_write;
> =20
>  	/* Why not before? Because we want correct error value */
> -	if (unlikely(last.name[last.len])) {
> +	if (unlikely(trailing_slashes(last))) {
>  		if (d_is_dir(dentry))
>  			error =3D -EISDIR;
>  		else
> @@ -6171,16 +6171,16 @@ int filename_renameat2(int olddfd, struct filename =
*from,
>  	if (flags & RENAME_EXCHANGE) {
>  		if (!d_is_dir(rd.new_dentry)) {
>  			error =3D -ENOTDIR;
> -			if (new_last.name[new_last.len])
> +			if (trailing_slashes(new_last))
>  				goto exit_unlock;
>  		}
>  	}
>  	/* unless the source is a directory trailing slashes give -ENOTDIR */
>  	if (!d_is_dir(rd.old_dentry)) {
>  		error =3D -ENOTDIR;
> -		if (old_last.name[old_last.len])
> +		if (trailing_slashes(old_last))
>  			goto exit_unlock;
> -		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
> +		if (!(flags & RENAME_EXCHANGE) && trailing_slashes(new_last))
>  			goto exit_unlock;
>  	}
> =20
> --=20
> 2.55.0
>=20
>=20

