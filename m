Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286E13959D;
	Mon,  1 Jun 2026 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282613; cv=none; b=hCU8odH5xpINLwlEQlQtebVl9hewTMTX9Inja3e451TMZQQ04wBIo6VUsHnacKU9B3A0rb/cN40kGgPWcLgli9RDRMK9y3bjSq984OfeVieREGUuXG6rP2VcodyZAaeahvhOHx86M4y6O16P46TXOpl0VAT+oH1AAFmf4VdzLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282613; c=relaxed/simple;
	bh=fLyFd/9yaMRu+VfpjqMEdwkPIqznYQ8nPkXTMVLBZVs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EDszym3JAX3OhBxDrBLTqnaTOoj+um4CKluR3c32PtrR7HrZ0yzKzS7QWIfFDZPH91Vun+56U9Z4WoWqvOfspPFzOewdOzRNq+2TkBB6cgH53iCUYHzHurqidKW6Rb0MLt7PM5bAvn+lDQNY9hU5gth/aJWlWHAUC5Xv8zI3WDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=efj5TVMv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IedFIPx9; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="efj5TVMv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IedFIPx9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 343CB7A00F6;
	Sun, 31 May 2026 22:56:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 31 May 2026 22:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1780282610; x=1780369010; bh=/usb4z53yOEgw2yPnOfV+z/Q+3Dbx5M0YXD
	wS5E57FQ=; b=efj5TVMvmF+eaf6gap51Wr+Jk6NRw9XNdIjNDmXOQFrl2Aqz3GH
	HNnvq9eX3d8x/08NwYkgOjj/ZZ9g1hvVD1HaNc+Xmreqv1tGs0YPnUKrmps42rqU
	i6XngRttvWlSS1Lkdf6bK6pQSVPxs+sw0Bd0QqKlTxuh93cT/Kbhp4J/0KYCEeZs
	+KsbaIm51LKAdhzUaxTBexseOSHJr3NzI2CD6iVmx0b3Pbh5uDvl9ZdG2L6kSn4i
	qvAdTkSmU10TIDrH8hg1IfNRMbMTyqYKuOJQCNue24s8eTi3U2H932h+fh8SBl+r
	VrPmlRUMNEUtljlE3cqMKRrZVVl8cMi15DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780282610; x=
	1780369010; bh=/usb4z53yOEgw2yPnOfV+z/Q+3Dbx5M0YXDwS5E57FQ=; b=I
	edFIPx9SBxqsCHbs6QgFHrpcY60cFxEfB1r+S/0MCZWx8iZwHag2wSB950elLZ9J
	6521ODSTEYErHYNyUfx7iVgWymGRlsYKc+cCW7nIf6v9p36gMm4RYp3jEFhzcV5V
	VpNIj7HBTcnFJG5JX4tScfX8m7qWZD8dmS93xeZPv4sD+VNawlG5jzjx9mMk9S5V
	ZcnzPGxAA8AVx1uVVbiBgvvFTd0e9KOPKehpXYDC0CGnb+AKBuqnpMiDlxaDutHx
	MustztwViIcE2XP2Z1zDnUMe3A0LhE7GkIMcbMMgtA6PLCowoImkODT9HV+58d1V
	Ig7FV/l1TBXrqgW+R00QA==
X-ME-Sender: <xms:8vQcaj43uPAObcYrqUgOTxOF_Pgsc4iIzLB_yp1aMrf-qbtWF66vwg>
    <xme:8vQcavS3owNYkgVOPlzBxt-42cVIrqcirBMtxVmsRgMcZ57A5NkBRARo8Szkq1WMn
    8lZt8mrcXQitkBMqDYaUgpY7lBbz40FGIDGo-05UV7tu9hSO6Q>
X-ME-Received: <xmr:8vQcamus2k1W6sMYgkEgQkxPwG3ZbcNQDQOZlzM5_QZLxiErFI_KTVtXF2iDiWK5YAmLRoK3L5T5ZW4JwNrnPkGM57a9A2s>
X-ME-Proxy-Cause: dmFkZTG1epHyhLzZpRzCpxYFinwl+m7GyjStuJJcPqfkTNZFhlj9+Id1zb+x43FqlKUSaL
    bl2C9DPDPK7zKMumUb3gCNMfodPwzb9PS/Yu63AfpYfalr6Mmf2uvmsGFiHrfl91h6+LPl
    Px85ibzaPDz81SIpMOQgCLVw6ziO36aaTeRLoigRP+COO3oGUV59IOxBPujwfRDYvnu9Hp
    N7AzhfhLm0Y15l1BitKfPjkEOCAPJyBYX+d/X4I47xoLEWw5FbvF+ca3dMoW+3V48C9oCH
    /IBxqGLYve2ofLJqlN9Gg5GL/1RhoHIYTVDoM6E9zh6mbVEME6r2pj3AL8X6A/6ScEkvgS
    q781XLQ5gvmcTWvZVH+iLHjUdrvpZsDiYOoVjLCocz0YWe2D6B6G1MFSGEUcgGV7aVKcjm
    GbrDbpUd5ob7rGRWhNYjzhwwT4tQ/GqfCQ3A3wC/PnLGxPbWl/15kDtLtzIsq0Z4x73NRk
    Woul7q4Y4tcjygfGm7I7MSEJpPMXiI1idpAOKCRg2EBhM7LuByGp2UYW5LfKAdNFtigXIc
    ZvvvWXsHa/4F/LHiKSOR0z6HFRViGt2VmjXm22Pwv7NgqKy3tQpn75iTb0diTecGQKfPIr
    ge1gS2vFboA3xazIoAe4z6pV7jHUO0XQAEqD95ZoSbtJ6LFh+IqK1k340GtA
X-ME-Proxy: <xmx:8vQcah8rFb_LoST9EzK1WaMsNnhxwFppNKCW0CL76Fesw14SwXzaPQ>
    <xmx:8vQcavxAP5zVq0E4-QChnosxb7CbbKHCS8fdG-xObM06v5_Yb_L67Q>
    <xmx:8vQcaj9fS9mp8QiV6Z2wqveQ6FXsxLf_q_z4LZPtJk0AZoHr3AA8YA>
    <xmx:8vQcatMKrCbrMgRHffXG10sSSaPeeCv6Zc3sktS0dRyLi1s8sRQ_vg>
    <xmx:8vQcalJ6W7i01wFix4fIXMvqtog0xd4pZd69kZXQldtm1Y9JLY64SugZ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 22:56:46 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>, Paul Moore <paul@paul-moore.com>,
 Eric Paris <eparis@redhat.com>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>, "Aleksa Sarai" <cyphar@cyphar.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Mateusz Guzik" <mjguzik@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Charles Mirabile" <cmirabil@redhat.com>
Subject: Re: [RFC PATCH v6 5/9] vfs: lookup_open(): move audit_inode_child()
 and i_op->create check to before try_break_deleg()
In-reply-to: <20260531182045.171711-6-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
  <20260531182045.171711-6-jkoolstra@xs4all.nl>
Date: Mon, 01 Jun 2026 12:56:43 +1000
Message-id: <178028260358.2923901.6788358930458921830@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


[Paul and Eric - question for you towards the end)

On Mon, 01 Jun 2026, Jori Koolstra wrote:
> Calling audit_inode_child() and the i_op->create check in lookup_open()
> take place after the try_break_deleg() call. This does not match the
> order when doing a regular file create via mknod(2). There the call
> order is:
>=20
> 	filename_mknodat()
> 	vfs_create()
> 	may_create_dentry()
> 	audit_inode_child(dir, child, AUDIT_TYPE_CHILD_CREATE)
> 	i_op->create check
> 	try_break_deleg()
>=20
> In particular, audit_inode_child() is called regardless of whether
> try_break_deleg() fails.
>=20
> Move move audit_inode_child() and the i_op->create check to before
> try_break_deleg() in lookup_open().

I don't think this is sufficient.
I think (and we should confirm we people who know about auditing) that
the audit call should come before the permission check so that there is
an audit record on failed attempts.  In that case the
audit_inode_child() all needs to be much earlier.

Alternately if we don't need an audit record for failed attempts - maybe
the audit_inode(..., AUDIT_INODE_PARENT) is enough?  - then the
audit_inde_child(..., AUDIT_TYPE_CHILD_CREATE) in may_create_dentry()
should be after the permission check.

I think you are trying to make the two paths consistent.  I think that
is a good thing.  I don't think you have achieved it.

I notice that fsnotify_create() ALSO calls audit_inode_child(...
AUDIT_TYPE_CHILD_CREATE).  Surely we don't need both?

Paul, Eric: can you comment on whether AUDIT_TYPE_CHILD_CREATE() should
come before permission checks, after checks but before create, or after
the create?  Or maybe several of those?
We seem to do it both before in may_create_dentry(), and after in
fsnotify_create().


Thanks,
NeilBrown



>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 16dcf537db87..293592a4d011 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4526,17 +4526,18 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
> =20
>  	/* Negative dentry, just create the file */
>  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
> -		/* but break the directory lease first! */
> -		error =3D try_break_deleg(dir_inode, delegated_inode);
> -		if (error)
> -			goto out_dput;
> -
>  		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> +
>  		if (!dir_inode->i_op->create) {
>  			error =3D -EACCES;
>  			goto out_dput;
>  		}
> =20
> +		/* but break the directory lease first! */
> +		error =3D try_break_deleg(dir_inode, delegated_inode);
> +		if (error)
> +			goto out_dput;
> +
>  		error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
>  						mode, open_flag & O_EXCL);
>  		if (error)
> --=20
> 2.54.0
>=20
>=20

