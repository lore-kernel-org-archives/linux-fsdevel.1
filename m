Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92D37188A;
	Mon, 14 Sep 2026 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429617; cv=none; b=brRgs42d1YTK2/4M6oAhrbIxuOh+69lLHSS2fBmIOTqPaKWYPaktRr0XC4Zn38qTufmBqdQcZTi/iPGW7K10gwolfF3AqCLFJiJqho1Nui7T0uPZpGl9TW/ed1Uv0Grp/Qx6mfp9P/CNmDm4Y1IiItN+tfmCPMCrYH7mt+whqx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429617; c=relaxed/simple;
	bh=vc3gK8rdW0E6XGs/ogff0lyv32RC8OPpnIEc8lwurOQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Ei2WwRWJyJyGe+w08r1iGZyEUTXwCsKF09LpVbBw+VeGmtA7zPwUK6bTkanaCilTPQI8LA9RbE0mFGzngDRThz8PqtOVjExp8MPsqlYaVhfrjrQoxbKECYxxYvbkaQmtpVURsSVxFac2kuT4NF9Sbogj3/KdSY2CnffzoMEoKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PUM/RIbm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SIBoKl4m; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PUM/RIbm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SIBoKl4m"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 708941D0005C;
	Mon, 14 Sep 2026 19:46:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 14 Sep 2026 19:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789429614; x=1789516014; bh=V3s7o3gI0yPUWxQCUr/3GqFnXiy29U2QQ3w
	y2+LezBo=; b=PUM/RIbmaTxnA3u9lFf1rBsuvPqdBIhtrVhSoUN6SprA6/9YGL8
	NlvJ/hPddAYyiG3kllREDAuPGIYT491VriKsWI2BFJf95VWHZ+1nc6JC+Zh8JHkt
	OBj1rFIsRp+v8bWspYG75puN9/OPJAQlvsAZaVwPS56NV3zbz7Upew5GpZSVQg+7
	6fathoknMlwT0PyvE/Uzw9GxMfZK2c+3RdRrDlpqAfgXiq28nr8w9KzT8tOqn46K
	P/b21WvC2+eomRSZxvS3CFu3sm6+Q8dTqduwnPCfSnIkjOrjjTznBj2s0wLDd+8q
	dWdzlIrmHXnWhpGp5N4NQV3IS3vV0UAq2tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789429614; x=
	1789516014; bh=V3s7o3gI0yPUWxQCUr/3GqFnXiy29U2QQ3wy2+LezBo=; b=S
	IBoKl4mRQ57Fh8fzDAetrS2QQ7NkE6fCFyZVnJfy/Dxh6BrscMv0PXBurOnXFSNw
	qalJXpVgbc7mXZEVvNFFQlPMKBctC3lAsIWWfk0yHY5IJ3m4bLcVtv2yuLE2cbeq
	yaz0ofnKIqw0yFF3NHXkEQCNo9CmuAvxLhKZOMKRRof0e4mjFtOHnHC4qzH4gu7S
	Ft96QSO0jXGWCOZeq43RishpGIKpi3dBoWfbAH3HjQjBClyW0JOTb9QESeyGJ9yi
	31Crl5bo0LBOkDte5tum43AXQS2MI/5ZUF3W1GQzOMtbdyMwV7egVDWFzCUITpR1
	UwPjmO4NOXMDukVOmPBXQ==
X-ME-Sender: <xms:boeoat8ZN31O_OkYJWhpUPKgKO1cqbGHNHCrNty4fimCgkpv6_gbYQ>
    <xme:boeoaj9iFgxpk6wLhCV6ojJMgfMjKqQRb3h6KQdWrLIXH7NQBfaulbTBbS0amGCPv
    1H-CdV3-5SMmF1RKvGNAlo1QAesGeI3SUM0oqJg4ktY2bojg1Ad>
X-ME-Received: <xmr:boeoatRKJGFvceDweRfPQgppMhe8Q7qdnbxvez8GHgk5fWERwC_1IDdI_nUw04wLB-5t6txBRGF7AH6sFYr5wSkiRXrZYUk>
X-ME-Proxy-Cause: dmFkZTGsZL8vu+ZKUlZ1eTDllNccSmmcExtFrx4CttXm4MjWm1JUSBpvLBpo0C+9OGdU44
    vzcY7T2sxLf9ROPpBn4NoAOU4+fCIlw1vhps+iO45a9TqrnqiaoBuFJu+xl9h9oLRdapCI
    cVxSg52fdtr2tUljpyu1YqTZ8n1nUzi6fO7oo4JvxnKwM1eruG7iBoBW4uk4CUVS1YVnir
    D7vpg8UIzBGxEXK4O3DX624fQ8pDWhxJgdztxcY6MwdL07UfWKrQYVD9+DiW0OvtMe3JuF
    rajRGa0XMeDqeeYTXWl5+1d60cZIcYPTGKvR+cK9w8W++vpr75EnLt0+IM91xVr5tFKoG9
    SgQHeiZPF5KAVnoVKfIzWEuW8tBaxzIaw3s4MsZ4LSVbv3qu0kYZGNP7IvTYc1iDL/KuZU
    GInfetwIuJNmT4ag1eN+FaQ+sL3oW2uB6kUUecp71AUOfxRkb5s4hBPlfa9h7OWRtVMj29
    W+GkH/HVuH4cmE8bKXJ8b+opOn2TXjFxSRmtBkqIOmqlZcAZTVRpJUKNppxJxo1iPd4+ye
    gQEwCkJZQ2lNR4d5wZwacYJShA324K9J0a+7TPxOB9/L8uGYZWvbnp3xHbWLNutXowiqWL
    yuKJRH/J/a2WA76gSqNyDYEWWYiOf8u6IG/nXbcwe9rIMDMGZ760EK6LGA/A
X-ME-Proxy: <xmx:boeoanfCzVmrunhpSHnLY7dDqkd969YGONiRhnUGmkycuJ20niM1ew>
    <xmx:boeoahCLu9g6nmryfEonsSlfV1DISMipJT3Wzl5PN5_ZR3_Qsw9iiQ>
    <xmx:boeoapn11yurVkThg3hxkziteYe20vxw0mVZHQz3z0e2-PxIK8O6Gg>
    <xmx:boeoasdjgTwwByotJ7uGjtkRCjQ_NQxITVFFk91d6mciiIF43xSFAQ>
    <xmx:boeoar3yf36J2ppNdB1SRf7zZpncrsTtdjOkPnoqo6tvd_EwjK45ggZQ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 19:46:51 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Mateusz Guzik" <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Mateusz Guzik" <mjguzik@gmail.com>
Subject: Re: [PATCH 02/10] fs: add path_create(), path_move() and path_clone()
In-reply-to: <20260913144918.1606123-3-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
  <20260913144918.1606123-3-mjguzik@gmail.com>
Date: Tue, 15 Sep 2026 09:46:49 +1000
Message-id: <178942960969.207413.13223800203703717090@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 14 Sep 2026, Mateusz Guzik wrote:

A few more words here wouldn't hurt.
Maybe just "These helpers encapsulate a common pattern and using them
will make the code easier to read".

When there are no words I have to guess the purpose myself and I am
terrible at guessing the thoughts of others.

Also I would probably make these static-inline, but maybe that isn't
important.

NeilBrown


> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/namei.c           | 29 +++++++++++++++++++++++++++++
>  include/linux/path.h | 14 ++++++++++++--
>  2 files changed, 41 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index ca4f5e3be99a..c8754c7ba8be 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -698,6 +698,35 @@ static __always_inline int lookup_inode_permission_may=
_exec(struct mnt_idmap *id
>  	return security_inode_permission(inode, mask);
>  }
> =20
> +/**
> + * path_create - WRITEME
> + * @path: path to get the reference to
> + * @mnt: WRITEME
> + * @dentry: WRITEME
> + *
> + * Create a path object using the given vfsmount and dentry pair while inc=
rementing
> + * the reference count on both.
> + */
> +void path_create(struct path *path, struct vfsmount *mnt, struct dentry *d=
entry)
> +{
> +	path->mnt =3D mntget(mnt);
> +	path->dentry =3D dget(dentry);
> +}
> +EXPORT_SYMBOL(path_create);
> +
> +/**
> + * path_clone - WRITEME
> + * @path: path to get the reference to
> + *
> + * Given a path increment the reference count to the dentry and the vfsmou=
nt.
> + */
> +void path_clone(const struct path *src, struct path *dst)
> +{
> +	dst->mnt =3D mntget(src->mnt);
> +	dst->dentry =3D dget(src->dentry);
> +}
> +EXPORT_SYMBOL(path_clone);
> +
>  /**
>   * path_get - get a reference to a path
>   * @path: path to get the reference to
> diff --git a/include/linux/path.h b/include/linux/path.h
> index 7ea389dc764b..8a621e0e1921 100644
> --- a/include/linux/path.h
> +++ b/include/linux/path.h
> @@ -10,8 +10,18 @@ struct path {
>  	struct dentry *dentry;
>  } __randomize_layout;
> =20
> -extern void path_get(const struct path *);
> -extern void path_put(const struct path *);
> +void path_create(struct path *, struct vfsmount *, struct dentry *);
> +void path_clone(const struct path *, struct path *);
> +void path_get(const struct path *);
> +void path_put(const struct path *);
> +
> +static inline void path_move(struct path *src, struct path *dst)
> +{
> +	dst->mnt =3D src->mnt;
> +	dst->dentry =3D src->dentry;
> +	src->mnt =3D NULL;
> +	src->dentry =3D NULL;
> +}
> =20
>  static inline int path_equal(const struct path *path1, const struct path *=
path2)
>  {
> --=20
> 2.53.0
>=20
>=20
>=20

