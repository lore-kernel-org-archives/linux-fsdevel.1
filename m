Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7EB8462;
	Tue, 30 Jun 2026 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782777832; cv=none; b=EV8xiX6J9waiQeRAsii5zWs7u74x8ul609lCmFoicUvY5T3JKu+uUP1azWL40a+2UHc5nDuSP1ZxtFmdrdifIAdcQOirwkiwmsa85i4w51iK2tKFYYe8AO3Zb/qrGpTQn3Pz8Zm/v3jOt6Qa2gro2NfjcYkTmkLValThj02akEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782777832; c=relaxed/simple;
	bh=QzPikbc0lpdgXhBmQLynofKhlWN+5cSqT/LBzozw+pw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XNmdMM+zGw6/+AIIgzjADPbvkyuoZY68j/E9fehkm6gAtpiEjOEYZT9rvxC4Es+sbLfOQolXSmjl7JUxoEBBgqJtEwKwl9mxp2bwv2f1/sExmOhBc6Azy3ChN33lxm7QKMIHg0fkhTSBZq07/XuIHSgRTmGt4wF/gPcByeC1z5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=njTdAPNJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijIuVlpa; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="njTdAPNJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijIuVlpa"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AE19FEC006D;
	Mon, 29 Jun 2026 20:03:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 20:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782777829; x=1782864229; bh=p4VLK5OhA6l3v0qZNfNCPF7PlBPGgRf99nu
	clEG/iSQ=; b=njTdAPNJb1fkuAcwzkf26cTtVIDW5xv+ZD5Ul9Tn8loi3IzK2Ma
	+Tep6r/+h1erSJmy0VYoa1JokidFrELtZI2xK0fdmUFUSkikO45N1RqRpy1LAliN
	8lQ2qzMG59QanvfQjGrG6vVl700WrlNSeZqrvOoBVUKJkJ57JXDVG6jHPNL79iAQ
	lTYz4MyyAis3R6IwankLQa02xMkXY8XiERhWcbefgNMAaQbDHse+28ZybQj8cFCX
	bUGcPGgNteAVKCikzkKSvM9Mghlp3Judvr7UCSJq0cRusegA0HyOYoqhL+69PErm
	j3UYzFcECNImRiZNYhPCsP+vGgSkc93g7bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782777829; x=
	1782864229; bh=p4VLK5OhA6l3v0qZNfNCPF7PlBPGgRf99nuclEG/iSQ=; b=i
	jIuVlpaeUsMrOczSLaBbR6vg7Xmbu1VFNr9YWpdRBcZTCvfrV6xUOL2V3I5qOrIO
	63yN7OFlt3Q7pbiQh0kASt/tzckjrpQBgTmZvfdYz4PV6roI44AIbwf/tBIU2169
	b6x84+a+Sz6kihr1+l5nWIJw58Un985kepS2sKBzAEGiG+2JlETenu6Nokpp4HWM
	5VIGPO+Pfqcr+Vvp7Pi/XrrT9ZmTDUZyemb+Eem5fB5glZugyZxBUMFUd17230HT
	j/bbFAxkfSFwAoXpKueY3EHm77dat2YmeMI3LTDv2WTEq5SDgKWVU21WZJFEiXRF
	59peBioPzRXXQZ7oMYx2A==
X-ME-Sender: <xms:5AdDatW_OIWoSnLbdMc_-0E5Xi0YL1MqWcL06rHdqh78ccMitzzjOg>
    <xme:5AdDaqLyqrui9HGK4r9s7L5POL1apTEgj4C5TnH8njrPPE2qI0pZQ2gH6CRhUIN7D
    vzu_aU0jj3phFCxz6jH8sPyHjHhIFWyLZhXcHaJxv9cfwm9>
X-ME-Received: <xmr:5AdDat0TxRqXhaLsXIFAawYuR6mQTdQ4gsi4wZi7L-LUMOKEyCXXyCTwuK6sLcokimzPQ20erEkq2JfEA4qB25uAktaF0QY>
X-ME-Proxy-Cause: dmFkZTGuEaa2bYdFNd621fzlqz7WFDgqL1jJgkQjN8XuEIceaqzwQcZkrIIn2UPQ1vaee3
    rZ42WYHaVSnXwc2xSpGiImrgBzjH9q2kacS7EsuK534lnxYhvPULinLA7k2EYaJrHAac6v
    8NW3uxVWFS2YDrTJb16lzCANU3zI9Z3nBLRifrIvwgsRDLXOGfvYXS7Ik9rKGotOvhks35
    vGbXXuCIUwoVyu+bPnwrlhI2eCchbIG4Qh+IlAeWv9q7o5EwJyvxItLSQ6/AOI6ILEgayL
    NmYY1WjO7zLRjDNA4kEm2KKX0A4AXA36mRHBAw9Z9ZKEG7ixVxQXy15wRFcrGcz5JLU9WS
    9SIFNzRDjtJ99X3D8lwbjiEtLH0JsfZqa4Iv+mfj+vdfaoubbD0TPkUUXmPrnpDfSvWpxs
    KtETZsj30VBl7R4fQrKXTeNyPRQnSLbyn2iEvvYRabaoXUke2RES7ngpp+BpVRvRjWsi6Z
    UV8mVEQRSAei1f75tbcWRicAMOXpPt6t7ej7c0GUmRt+qGdMEKEM4WkKRJltG0V0L+576y
    yapLCSfZo4o0H1lFulD3GEyE3FmNoka0ozmfVpzHzNaHFCLvJPEeQamN9cFr3Ni6qn8C5A
    4Qy108BbYfBS1JvavvmhsEiAFxMVR2TDkTD/MqMCZnAM0JULJGmBEMa4qFGA
X-ME-Proxy: <xmx:5AdDanIE85vUPYxPgHpPFzjOWyIcj3Nes5C2KoE12u2_MK_qgNblTg>
    <xmx:5AdDaogorQ2Pv1ZSMF3q3IhjA445NC0HOHH-ECYmG_Xusgbv6ZS56w>
    <xmx:5AdDanDphovGUfI-xLMRhvSA-gw0RhUa2ci_Nyd0ajRWJhEg0sFHKg>
    <xmx:5AdDaq5tLIVQgBc80S8IjjJJ_WJkpV-SGVkBIdaZVKfTBHPyam7rMw>
    <xmx:5QdDaitwjcS9H1x7IkDFIUPMREnToMA6g924tUQB1Ae1b42TlqwRH86d>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 20:03:46 -0400 (EDT)
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
Subject: Re: [PATCH v2 04/14] vfs: call audit_inode_child() in lookup_open()
 on failure too
In-reply-to: <20260629153630.2158649-5-jkoolstra@xs4all.nl>
References: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
  <20260629153630.2158649-5-jkoolstra@xs4all.nl>
Date: Tue, 30 Jun 2026 10:03:42 +1000
Message-id: <178277782252.27465.3474742947797016992@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 30 Jun 2026, Jori Koolstra wrote:
> audit_inode_child() is called in may_create_dentry() so that failed
> filesystem operations still register an audit entry. On success, the
> entry is overwritten when, for instance, fsnotify_create() is called.
> This is the calling convention in vfs_create() and vfs_mkdir().
> In lookup_open(), however, when atomic_open() should have created a
> file but didn't, no call to audit_inode_child() is made. The same is
> true for the regular ->create() path.
>=20
> Fix the calling of audit_inode_child() in lookup_open() to match the
> vfs_create() path. Note that if ->atomic_open() returned an error
> other than -ENOENT while trying to do a create, the audit is skipped.
> There is no way around this because we can't know at the vfs level
> if the error was due to a failed lookup or failed create.
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 60 ++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 38 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 9cdc9191dcda..4f747546ff3d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4462,7 +4462,7 @@ static struct dentry *lookup_open(struct nameidata *n=
d, struct file *file,
>  		dentry =3D NULL;
>  	}
>  	if (dentry->d_inode) {
> -		/* Cached positive dentry: will open in f_op->open */
> +		/* Cached positive dentry: will open in do_open(). */
>  		return dentry;
>  	}
> =20
> @@ -4494,11 +4494,23 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  	if (create_error)
>  		open_flag &=3D ~O_CREAT;
>  	if (dir_inode->i_op->atomic_open) {
> +		struct dentry *orig_dentry =3D dentry;
>  		if (nd->flags & LOOKUP_DIRECTORY)
>  			open_flag |=3D O_DIRECTORY;
> +		dget(orig_dentry);
>  		dentry =3D atomic_open(&nd->path, dentry, file, open_flag, mode);
> -		if (unlikely(create_error) && dentry =3D=3D ERR_PTR(-ENOENT))
> -			dentry =3D ERR_PTR(create_error);
> +		error =3D PTR_ERR_OR_ZERO(dentry);
> +		if (unlikely(error))
> +			dentry =3D orig_dentry;
> +		else
> +			dput(orig_dentry);
> +		if (unlikely(create_error) && error =3D=3D -ENOENT) {
> +			/* Should have done a create, but we already errored. */
> +			audit_inode_child(dir->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> +			error =3D create_error;
> +		}
> +		if (unlikely(error))
> +			goto out_dput;
>  		return dentry;

I think the extra dget/dput is unnecessary and a little clumsy.
I would rather you passed 'create_error' to atomic_open() and let it
call audit_inode_child() is needed before it calls dput().

Otherwise I like this patch - I think it clarifies the code flow.

Thanks,
NeilBrown


>  	}
> =20
> @@ -4515,33 +4527,37 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  			dentry =3D res;
>  		}
>  	}
> +	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {
> +		/* No need to create a file. If lookup returned a positive
> +		 * dentry, the file will be opened in do_open(). */
> +		return dentry;
> +	}
> +
> +	/* Negative dentry with O_CREAT flag set */
> +	audit_inode_child(dir->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> =20
> -	if (unlikely(create_error) && !dentry->d_inode) {
> +	if (unlikely(create_error)) {
> +		/* Should have done a create, but we already errored */
>  		error =3D create_error;
>  		goto out_dput;
>  	}
> =20
> -	/* Negative dentry, just create the file */
> -	if (!dentry->d_inode && (open_flag & O_CREAT)) {
> -		/* but break the directory lease first! */
> -		error =3D try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_i=
node);
> -		if (error)
> -			goto out_dput;
> +	error =3D try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_in=
ode);
> +	if (error)
> +		goto out_dput;
> =20
> -		file->f_mode |=3D FMODE_CREATED;
> -		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> -		if (!dir_inode->i_op->create) {
> -			error =3D -EACCES;
> -			goto out_dput;
> -		}
> +	file->f_mode |=3D FMODE_CREATED;
> +	if (!dir_inode->i_op->create) {
> +		error =3D -EACCES;
> +		goto out_dput;
> +	}
> =20
> -		error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
> -						mode, open_flag & O_EXCL);
> -		if (error)
> -			goto out_dput;
> +	error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
> +					mode, open_flag & O_EXCL);
> +	if (error)
> +		goto out_dput;
> =20
> -		fsnotify_create(dir_inode, dentry);
> -	}
> +	fsnotify_create(dir_inode, dentry);
> =20
>  	return dentry;
> =20
> --=20
> 2.54.0
>=20
>=20
>=20

