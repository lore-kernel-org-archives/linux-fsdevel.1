Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20E3AFD1A;
	Mon,  6 Jul 2026 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316274; cv=none; b=V/YgoPr6QRYWOqv0dL7iMHzx/sK26+qVwB2JwRf5VN7xWi2YtaPlhnGrnxMd90A7lPjdl69NcYME7GqfAEKCTh+qQ53EvDdUUdl2uGaW3V1iJ+/NT/h4l9wIUay5Duzlir4j1FGpajixgiEAHoixFvyBTT9uuNX8HTkmJphxFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316274; c=relaxed/simple;
	bh=ZfZpBXmP6OydztPvD5CTiy7mg3F2U4de1ZIAkYIijco=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LAo2WuePKZ7++AzY0yZ58/9L9cLyLlIU934gzBpO3HIHDrdhFGeAEufKXR6ov84jxOqpFyGjw91nGWyjHmRg5Yzk8M0f7vzCccvVJ9/0dGapdKVHpMOB4kAzIdql9OJt8Hu9Tz0NZjbFMnQvniddksmpX0nRIYC7+n1Unw11a1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=JydUb2Be; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AwjA4TFe; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="JydUb2Be";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AwjA4TFe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A25B1D0006D;
	Mon,  6 Jul 2026 01:37:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 01:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783316272; x=1783402672; bh=ZW2tXQMlQ/HKzXxh/lecoQ/hcEj4VQHWx0z
	0XqRAmNo=; b=JydUb2Be7pewWL60K5a5BCGDsf+E8ShiezaFhdKDHV25zE99Nw3
	gq6zxXqyRoV1AzceJqgTMh02C05z+qWWScwGSg9v/gHxqP2no5hZ9mK63H1ZUcSy
	76bF2znhfyjbjESxQyWQHFG+PMu6lbxnj86QcFNjIIS0wRTJSud8/wMlVeGlajry
	TdwMsJbVi4otszfIBcf9NSjqDYxynf0PzRnI32iyra9Rf1jHs+mt4u3ZJ3Ed0aY7
	7GZslNB0Q5jNobF9r0pDxxghe985k/c6Ekrd9jnGmDPX2u5lnqJPurJUgTsXGEFv
	cXrjjNRhv5A7Eg7AzsYazvs++KvaKhNg2Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783316272; x=
	1783402672; bh=ZW2tXQMlQ/HKzXxh/lecoQ/hcEj4VQHWx0z0XqRAmNo=; b=A
	wjA4TFezhw+p0ENBajO4POma+GIkWxLzDZSRRLOIXfx5zqLMewKYrgHKvBJqJzUT
	3TCZRF3MTuZfFeaHfR8+Y4bndgAHFWe7VUed2cjwxln6e0ZDO+vTW+6KY+9daSPc
	fUoiJrUpSX/eoWTNnQW5CMxSBIIe4dPo9yFJh17SU6Vn2Yh1VF0N7bnK79oxRfbL
	JH2ksLXGBzK0BdqD0Tn1e4WBd1wJRvXMrJmP2BLfVAZ8TLTph3yYGsCb9MyXYsxI
	I/gF/ar6JKTxEzsxtExLdtZd26poBd3CgUFfA1JVxnG3viyb64OdRt+ALSDWulSV
	6naq5wv1GB7juOeqllg2w==
X-ME-Sender: <xms:Lz9Laun4crTeK6YrZaU7lWRdA9sDtYybqX8FfzvM0nK1tUyBXuRzGw>
    <xme:Lz9LaiY4LR0f5gIu_qym0MY5qKMYfs49lf8D-OzbZ8to1mb9jGRPm_5m9vNgYhygj
    jwr5iaPushcUlksC7wBVM5V5Z4vx2C_Mdn_XVAA2NqdNQ31Gw>
X-ME-Received: <xmr:Lz9LahFFYTeF9DJAYjgDlnDMWSSk3HSOszrhIaRUANHUsXP3PMocxUadfkGZrhuna5rNblpLcttUZNLS6HIyTl6c9sXpEnk>
X-ME-Proxy-Cause: dmFkZTEV95tMNlLncNpyB4f5kRdpXQA5t15C0DsyoNiVtb12FxilWIf1b8z0Wc2gp4GN+Z
    OUR7wzwiwSkH7fYGBeZ+6qMrCbLnFciYzCgtnSFXHJjzrJfotK+6IYgoMFokvYzKnpUOKi
    IjJwC1D2h1OxYzTOg4kzlMXflIbw4RCURVZfwrA1YkhMuKqzpFkYvtOfx7BM/SqL3wIXoM
    IOM3c06qNeAnDZM2oMxl6Ju8YG358AboXLm4eqR+At41Nd9HUeCcUkz2DQcEAPBBMkJeXh
    8MWjG3MHpiabSbge3CI7LWvYJyqnBbgmX+m5lUb/OLuEYuPlvzxvI7Oh+6ylDcQz5FCsha
    9PJ8Z8WQv7q+4f4Mk4Oyo521g16PsCi/PV7GBgcTjNAs7F512KTQ2Ap31ODZ5cS4p+ag5l
    +vOlkXgNMW/eFgm2q9KGRPKPUC5IAd3G+h5Ho8UGvxIUMSVYL4lm7WFGAG4TPB59nu6j1G
    dUOkmYRg4TsG5u9XHGkFL2E9EsJff5sSgX6Fqeg12gKieHmmogPb8JGXtwms0bWG9ppViA
    lPOj4eHrTe9n8hvCD2Z9hc3UyQcSAYEQYNuAdAfxOOihqWWOaOM6AZs9T4YGXRIPpMwqAk
    yzeoE9Kw4KJyqcaEXzrKCbWQ6RHcyCnrglVKcwk8h7U62Tkx9lX3uX/hDsOw
X-ME-Proxy: <xmx:Lz9LapavmJKorSqGfnqnzu-fynpCQlV6uH0fIDLqd0N3lf-hiFiGQg>
    <xmx:Lz9LatxeKecYVO0jxrz9qZpP9Ln8_aasHZS-oGlbCWhDOC8lYLYbBg>
    <xmx:Lz9LajSDqauirJ4uFrKilH12qXmdCETMDCQnMxSgf5LWO6SCqKXu3g>
    <xmx:Lz9LaiL-vQJpV9ijTepO8syEunUenzktfEcjLlcRpXA7vjVhW25Q8A>
    <xmx:MD9LagqckswpNrfdaGU7WVwNvtyE6N2tdiIOXNmFiaVQS7s21XYDOvCC>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 01:37:49 -0400 (EDT)
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
Subject: Re: [PATCH v3 07/14] vfs: move ->create check in lookup_open() to
 before try_break_deleg()
In-reply-to: <20260704164149.3480051-8-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-8-jkoolstra@xs4all.nl>
Date: Mon, 06 Jul 2026 15:37:46 +1000
Message-id: <178331626682.27465.15027045190456858603@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 05 Jul 2026, Jori Koolstra wrote:
> The i_op->create check in lookup_open() takes place after the
> try_break_deleg() call. This does not match the order when doing a
> regular file create via mknod(2). There the call order is:
>=20
> 	filename_mknodat()
> 	vfs_create()
> 	i_op->create check
> 	try_break_deleg()
>=20
> Move the i_op->create check to before try_break_deleg() in
> lookup_open().
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Reviwed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

> ---
>  fs/namei.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index daf31845e3bb..6601460d2772 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4548,15 +4548,15 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  		goto out_dput;
>  	}
> =20
> -	error =3D try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_in=
ode);
> -	if (error)
> -		goto out_dput;
> -
>  	if (!dir_inode->i_op->create) {
>  		error =3D -EACCES;
>  		goto out_dput;
>  	}
> =20
> +	error =3D try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_in=
ode);
> +	if (error)
> +		goto out_dput;
> +
>  	error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
>  					mode, open_flag & O_EXCL);
>  	if (error)
> --=20
> 2.55.0
>=20
>=20

