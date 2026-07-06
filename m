Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F633B19B2;
	Mon,  6 Jul 2026 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316324; cv=none; b=OYVe0kEwHXXObuP7OL34kIT45D12RVL7tF38IfUz2g5st0uiN0/1wIgTWtqD+/dkxpve2Me1FCMiMTu/btD36rfKIxOSRrVrh8ItC8/EaU9wmjV6V/Aw24wK3PxW96e/xP2eQA5apiWwtm4WLnkfLRK4zYminh5Xl/WCVumvheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316324; c=relaxed/simple;
	bh=/sGk2lvWRXkAYPtpAMV7KrAHswIiJpvBURqtzUwp/i8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=odi3YsC6z4sEEe+0lbSs14YVyx2ed+4TqEZ85DFlRAdu2dv2vbmBlW06sMki9H+FL583ZOxO1HPqlDhz/0coy65TQpkwoTTE2af+CNbWf8QbE5Ol+AT0bemFJ5vjfMZEVofS9S4Q6bpttWdaHBCbJBTES7G0bsJd6VRWtt7K9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WKyx2jPD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijoaChh8; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WKyx2jPD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijoaChh8"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 369057A00E9;
	Mon,  6 Jul 2026 01:38:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jul 2026 01:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783316322; x=1783402722; bh=t+DjGSDWgcLvszvc6snLKhxLDDgBKIzOUVH
	DcwQgLVA=; b=WKyx2jPDPKGM3vZRQdeguvhYnzOoO8SijdpTDRowTnr6cN52B1O
	zKhSjg6iG9D9fYhAA1uJvuIJzVvtzLYKnIWnQHYWbbNt4jcEA5eGfbss/J9TXbYH
	oQl3r3eBmUnsoQv9pVZ4q664vf3ZoN7LXBFPNykyuylGHxFJzDkoKT/thbCOSIi0
	l9mwQnWwBFgcsZAjOtZYWrRQAKeInG1KOsoBG0N13w3W8MFak3KxiHzRuw/bw6YH
	dAySp1Fyu0mTopECPl00EjvcALyYAiEljT4erF0KCmTdpyUe1UQK/2hZbq5Isg9j
	LVcPRXrDlF1SI2J9KG/0G2mCX+qpwEhZzMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783316322; x=
	1783402722; bh=t+DjGSDWgcLvszvc6snLKhxLDDgBKIzOUVHDcwQgLVA=; b=i
	joaChh8YodgNNjCtUhfZi7GXIeivpJGG5Rf43G4rI86yf2swjsB2cBh2WzbFTqTx
	vsJ7khlfy7ab1QwdklZLZbv3KjfENHtSAunrJ5m//f9cbul2wb6BcIp4rxrBe4ce
	H9d8clDhs4UK09xpFvDHwlS+NENC7UDRESIdNQuR4f31v7inhr+YgQeD8bpD1EQm
	z6tlkn0CZuK+1tg1EF92a2ITcq3XZqxQ/ZpQLMWjgo2Pe3aQmjm/aPM3+LQFcK4e
	AbDm06W9XFCc4gt1g97mCHA3xAWVjXciO30wek5yqnskoQhAzqmgK3/BwOUlV/2n
	bskSN1/AMW/sFQq91eetQ==
X-ME-Sender: <xms:YT9LapC1lq9LY2xnti5FASpfqe50pzvL1N6ekVF3ZccB40YDzOq4dg>
    <xme:YT9LajPnsN4ZMusF53Da7a8IiZXfxyj24ugOqEK8pn8wIAoCF3dkq0lIigTkUdbO8
    k_rnZjd8jqtOxDVr7nhcBPukFrw9v1U7aQPBeCv3fXufjIrAw>
X-ME-Received: <xmr:YT9LahBEg04-Zzv6cXm-xCB6NZubo-o3YRtxx4oa90nQQ_8NldKhUoox-Cv2MX_EMdpn3STHZ2bEG-UK9gnGhPlA9s2JRjI>
X-ME-Proxy-Cause: dmFkZTEV95tMNlLncNpyB4f5kRdpXQA5t15C0DsyoNiVtb12FxilWIf1b8z0Wc2gp4GN+Z
    OUR7wzwiwSkH7fYGBeZ+6qMrCbLnFciYzCgtnSFXHJjzrJfotK+6IYgoMFokvYzKnpUOKi
    IjJwC1D2h1OxYzTOg4kzlMXflIbw4RCURVZfwrA1YkhMuKqzpFkYvtOfx7BM/SqL3wIXoM
    IOM3c06qNeAnDZM2oMxl6Ju8YG358AboXLm4eqR+At41Nd9HUeCcUkz2DQcEAPBBMkJeXh
    8MWjG3MHpiabSbge3CI7LWvYJyqnBbgmX+m5lUb/OLuEYuPlvzxvI7Oh+6ylDcQz5FCsOh
    NmRU02on/9GH7RkZk41nBlOTTB1FC7FRs2+OkY5Hrxd4rSnkQIAYUoA3922cxCthS+fUi2
    ncK88g9Sjxel41mLzeernQ4snLAolzDWwhvHXG1W/5hcNfaiRvcImoAtjFHbvJzFJgmHLI
    Va970AuAPqVvFOrPFrPQ27RkFWgf3hlWYsABYOU80E8YtFy99h4iSAUMDLS68fAnisJUmM
    qWXKY4igvam1N6Ndv/dV9SBWT0A7SDBeZLV17IQp73UkqCWeNfRoxvXjbeeQ2GzdbcABqz
    REnrnZatM82jS8nP9bEPWod9Ij7TZrtru+Yd+jdd3St6a/fkd6RS7Yiz1UYw
X-ME-Proxy: <xmx:YT9Las4y6Ffy0G4iSLItyiwUOj71gKf2jrsVktYuNwvDA6YFRdiOoQ>
    <xmx:YT9Laj4tbV6BT_ObHQlTOE_hQ4pm1yvvXoNxmTviPIQ3YPu2ABOU7Q>
    <xmx:YT9LamRgCljYtXyjxj3bnnREyVtoC6UDmZ0J74FeUlEMLj_FVMkoRg>
    <xmx:YT9Laj_zpiWN3nZMjomhRUqScuRabUm3s8eW_F95xc49l8PI02ku1w>
    <xmx:Yj9Lagk_befMyzzfK0uu68X8kDhEMEkEb_uj1u8DcFLaDHGDRyplkOhG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 01:38:39 -0400 (EDT)
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
Subject: Re: [PATCH v3 08/14] vfs: lookup_open(): use vfs_create_no_perm()
In-reply-to: <20260704164149.3480051-9-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-9-jkoolstra@xs4all.nl>
Date: Mon, 06 Jul 2026 15:38:37 +1000
Message-id: <178331631709.27465.1544779909431694111@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 05 Jul 2026, Jori Koolstra wrote:
> We can replace the code in the no create_error/negative dentry found
> from lookup case in lookup_open() with the vfs_create_no_perm() helper.
>=20
> It is safe here to always pass excl=3Dtrue to ->create via
> vfs_create_no_perm(). Local filesystems always ignore the excl flag,
> and cluster filesystems implement ->atomic_open, so that the ->create
> call is never reached in lookup_open().
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 6601460d2772..eaa0ade4a1b0 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4553,16 +4553,10 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  		goto out_dput;
>  	}
> =20
> -	error =3D try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_in=
ode);
> +	error =3D vfs_create_no_perm(idmap, dentry, mode, delegated_inode);
>  	if (error)
>  		goto out_dput;
> =20
> -	error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
> -					mode, open_flag & O_EXCL);
> -	if (error)
> -		goto out_dput;
> -
> -	fsnotify_create(dir_inode, dentry);
>  	file->f_mode |=3D FMODE_CREATED;
> =20
>  	return dentry;
> --=20
> 2.55.0
>=20
>=20

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown
