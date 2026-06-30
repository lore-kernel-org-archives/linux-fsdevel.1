Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533040D563;
	Tue, 30 Jun 2026 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778295; cv=none; b=oi2yd9c9Ag+CIHFtFb906KVdlSAV/1iatiAtimW7+zdN5bZa3MD0EUrPUFmOwdNTGjaUGu7ABUB36/MM+X8yqSSBLKfHUY0KQ2yPRIj8b5pA9CpVSxZETFZBzxcCP4kMpJj7886YGHmY2YOdR7TB+sVeMhTypiYI3PCUqjrG0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778295; c=relaxed/simple;
	bh=pDcyER3gypppyL+LA/mZgb0HzN2NoYjMufJRTsuiVYM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hIB1imvm8PdO3JFR15k+ibIkCx3kYD2UatPHCyk6iWF4HjVBXqIXyTtKtwN/3I+GUBxvjaiwRPKnMAvbNOwCURcskQQaAjz3QIDkMZAn26DnWGjCA6hoY8fA453f8r9Z7g4qSCKZ7oNRoGgBc62+YQcja+eiMjmfRpJipsEK6f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dNIXyi4M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BE8JYsig; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dNIXyi4M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BE8JYsig"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87836140007E;
	Mon, 29 Jun 2026 20:11:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 20:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782778293; x=1782864693; bh=gtl42NwUQ+top14AG3/x2xZc/kc2/ovgJ+h
	j98oiDmM=; b=dNIXyi4MlO+/eozdB6xoy2uOhFvt6gBTC2Jvtja3JS9jJtTvW+2
	PNDf9QMRvnbLqpjqPn4Z1VSOsvRswKK0LTaleVhHmUP+LkR0kon0pdwLo3I4cDNb
	cjRy0A8ahtosS+8IjJyNHDWM6f2USSp9Is2U1/hpvGmyQH+XFMJYlOJ+z+uWbtbb
	+U6mT6ZZaB8wySYzBn2yTRqz51mtVPW/W/hmZgnwtVWwm4+rxL7MsbelxcnmBq8p
	UNcJg+ouCU3jBLwbfdo6NMCpAGdlGQJtmBv93oDfDi/1F6ky43fjJLDPnUg8Trln
	RMjtjauqldmO6w2zgKjsaRbt/eoJ33Qywbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782778293; x=
	1782864693; bh=gtl42NwUQ+top14AG3/x2xZc/kc2/ovgJ+hj98oiDmM=; b=B
	E8JYsigeHZbo5D+0yfoP791cgmTpq10TvjF8GVYXBkR8MPT6rdyma5MComEC2cKF
	eHGYX9F6exD3A/YwZh3Ch3niXRh2eBjzWLtuvm3a5hrMudi+KTs1ApBfnZmK4dmj
	5Kr6sR2zkKWWiBUq+RHNMAEW6q8sYeTgNdcqNUry0PMyBYVTOm6LYStn3fk07V2C
	tIIOT/gwyvlK7FbwX8A+XoerZr8JmMby9nSVDAeaEu0kzZ0wK01ibaK2oz0XtyVb
	tEYtdMkC6E/D+q/s+hw7NFiBlvrOhgP34dbNlnhz/bIeLmE7iIVgfj+dah68NIsj
	y69lNgaHLuzGtoBTqjPAA==
X-ME-Sender: <xms:tAlDar7VoCqWfkWSg5uPHXMtX_eHN6Sqq0G9ZTeutHXHnK1lHaLNuA>
    <xme:tAlDatecd-1FBBKO5Bn6R6XjEGjvBryxtOedDOKzPfjVSf6fhQ9FM7_GpN9rxuNvi
    Ew5umX0_XP6iT1OZZDxaP76BKzqI6qS1-7LuhI1Qr9NSaquLg>
X-ME-Received: <xmr:tAlDam4qsQ5LalTwndPgOcrxKdGZBwvjs0gPlhB_qJLkGXS4U06TZH0FwNPE7Us3RoNvmsdmrUTAVEMUOUywh6US5MuEFTc>
X-ME-Proxy-Cause: dmFkZTGuEaa2bYdFNd621fzlqz7WFDgqL1jJgkQjN8XuEIceaqzwQcZkrIIn2UPQ1vaee3
    rZ42WYHaVSnXwc2xSpGiImrgBzjH9q2kacS7EsuK534lnxYhvPULinLA7k2EYaJrHAac6v
    8NW3uxVWFS2YDrTJb16lzCANU3zI9Z3nBLRifrIvwgsRDLXOGfvYXS7Ik9rKGotOvhks35
    vGbXXuCIUwoVyu+bPnwrlhI2eCchbIG4Qh+IlAeWv9q7o5EwJyvxItLSQ6/AOI6ILEgayL
    NmYY1WjO7zLRjDNA4kEm2KKX0A4AXA36mRHBAw9Z9ZKEG7ixVxQXy15wRFcrGcz5JLU9Bl
    lhmVWMT41FKo3kq+eoDG5V4ipHWq0VeeEU7yU79Erj/tCT7uLs191x/BIYKNsgDV+Hndwt
    9qDWs1FYs6PscS97GxJbq1yXrUXUUsUKklaASnZb5RnPyUTe00BwRbicvmTekP7yOhHgAH
    zVp8xbBy+TpKQStoMfadEN173GGs2LI/WleG8wLe4b1lUbd7CCgTWvEokOkLF3fY+mVEbm
    nRukm+VIqhpx8bgxATIGJQ61xdvTFTJwchMlSLj1pVeZQhtW5ix+NOVHnHm5RspyqqNpF6
    ARQYqQQXH/ui/je4DaIeWhhJ2WxG4gLmSqAkM8kmBDLwFSDW864Bc114R3Vg
X-ME-Proxy: <xmx:tAlDai_mah8cz-4TOqlsEjN3IgY_Q2GtQKZhYOhcoGgaZQ4xme8Nlw>
    <xmx:tAlDagEUxLzvsCA3hxDih26QjYL7b8pvl5J47yBF6O5w_uTER1tTxQ>
    <xmx:tAlDavXhY7GflMlNmdWT_Ug8uG6p_mOltrPrzj63S_fYuHsR21mkNA>
    <xmx:tAlDak-8JZz-McI81NmThThAqGAfjke7xbHmIiVsWEENdGDzziGy6A>
    <xmx:tQlDagAGdSKsLTzWMvg4ll3SsJOwvQrrPkX5K6jBlX8sXIXu6sQbO6rm>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 20:11:29 -0400 (EDT)
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
Cc: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jan Kara" <jack@suse.cz>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Aleksa Sarai" <cyphar@cyphar.com>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>
Subject:
 Re: [PATCH v2 05/14] fs/namei.c: don't dput() when atomic_open() errors
In-reply-to: <20260629153630.2158649-6-jkoolstra@xs4all.nl>
References: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
  <20260629153630.2158649-6-jkoolstra@xs4all.nl>
Date: Tue, 30 Jun 2026 10:11:27 +1000
Message-id: <178277828768.27465.5895037210796020693@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 30 Jun 2026, Jori Koolstra wrote:
> Both users of atomic_open() now need the dentry alive after return from
> atomic_open() on error, so we can remove the dput() from atomic_open()
> to prevent useless dget()/dput() calls on the normal path.

I don't really like this.
There is no need to improve dentry_create() as I'll be getting rid of it
as soon as I can.  And I think atomic_open() works better if all the
logic is moved into it.

NeilBrown


>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 4f747546ff3d..85ce44b068c1 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4365,7 +4365,7 @@ static int may_o_create(struct mnt_idmap *idmap,
>   * be set.  The caller will need to perform the open themselves.  @path wi=
ll
>   * have been updated to point to the new dentry.  This may be negative.
>   *
> - * Returns an error code otherwise.
> + * Returns an error code otherwise. On error the ref to dentry is kept.
>   */
>  static struct dentry *atomic_open(const struct path *path, struct dentry *=
dentry,
>  				  struct file *file,
> @@ -4389,17 +4389,24 @@ static struct dentry *atomic_open(const struct path=
 *path, struct dentry *dentry
>  		} else if (WARN_ON(file->f_path.dentry =3D=3D DENTRY_NOT_SET)) {
>  			error =3D -EIO;
>  		} else {
> +			struct dentry *old =3D dentry;
> +			bool replaced =3D false;
>  			if (file->f_path.dentry) {
> -				dput(dentry);
>  				dentry =3D file->f_path.dentry;
> +				replaced =3D dentry !=3D old;
>  			}
> -			if (unlikely(d_is_negative(dentry)))
> +			if (unlikely(d_is_negative(dentry))) {
> +				/* Do not drop original dentry ref on error */
> +				if (replaced)
> +					dput(dentry);
>  				error =3D -ENOENT;
> +			} else if (replaced) {
> +				dput(old);
> +			}
>  		}
>  	}
> =20
>  	if (error) {
> -		dput(dentry);
>  		dentry =3D ERR_PTR(error);
>  	} else {
>  		if (file->f_mode & FMODE_CREATED)
> @@ -4497,13 +4504,10 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  		struct dentry *orig_dentry =3D dentry;
>  		if (nd->flags & LOOKUP_DIRECTORY)
>  			open_flag |=3D O_DIRECTORY;
> -		dget(orig_dentry);
>  		dentry =3D atomic_open(&nd->path, dentry, file, open_flag, mode);
>  		error =3D PTR_ERR_OR_ZERO(dentry);
>  		if (unlikely(error))
> -			dentry =3D orig_dentry;
> -		else
> -			dput(orig_dentry);
> +			dentry =3D orig_dentry; /* atomic_open() keeps ref on error */
>  		if (unlikely(create_error) && error =3D=3D -ENOENT) {
>  			/* Should have done a create, but we already errored. */
>  			audit_inode_child(dir->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> @@ -5081,18 +5085,10 @@ struct file *dentry_create(struct path *path, int f=
lags, umode_t mode,
>  		if (create_error)
>  			flags &=3D ~O_CREAT;
> =20
> -		/* atomic_open will dput(dentry) on error */
> -		dget(orig_dentry);
>  		dentry =3D atomic_open(path, dentry, file, flags, mode);
>  		error =3D PTR_ERR_OR_ZERO(dentry);
> -
> -		if (IS_ERR(dentry))
> -			/* keep the original */
> +		if (unlikely(error))
>  			dentry =3D orig_dentry;
> -		else
> -			/* Drop the extra reference */
> -			dput(orig_dentry);
> -
>  		if (unlikely(create_error) && error =3D=3D -ENOENT)
>  			error =3D create_error;
> =20
> --=20
> 2.54.0
>=20
>=20
>=20

