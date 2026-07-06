Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A73AFCF4;
	Mon,  6 Jul 2026 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317075; cv=none; b=XjFNBY0ceBJ/lqSoccSe8XhEEJJ9+5Y2RqGn+sUIc4wRiv02Obt4ACXEVLfQvtWLyGCBsL7J8Mbn/1xzY+3nk3SdtRquBI2h+TD4x7j48EgAKegul3eqH7WjGm/iuZ8vdBBp07GWQG7Lg8pCqeM89oyQ/v8O/Eo3k1LawXCESUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317075; c=relaxed/simple;
	bh=fvfWPS03cG4/TZKIVsnZMukbOnOzhpbj39fIRdWM/TM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GenjOeuKdn9Nlnygo9gk/ijzXz3kNbpUIuLoaYeQUd2KCFFvDQ/NmqluEZZ+Z8Sml4ajSbB6/K7zlnEdnXbYdaqSA1WhJuuTD2IqPUyG0vE4WieJqz9Se+cc2YSLTslGDuHBWBKad7uh+z8OE4izwfx1jyZ0KiISNqF6J1N6Xo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=j4Pj2r6m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gEE+W9o5; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="j4Pj2r6m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gEE+W9o5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E45611D0005E;
	Mon,  6 Jul 2026 01:51:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jul 2026 01:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783317072; x=1783403472; bh=NiXXqkZNAy64FEtjIcjMnyoUgWwFD/MXlLT
	+Y6uEDzE=; b=j4Pj2r6mxTR/WdXxmd1ccQtV1KmdjQZq+luBpAVmbC7utpyrRgO
	THLnwadDbSUD8FN5neA6ny63FRH8EBIueqC6heH9FVfRKrw1uR0BtrmLxt2vbRMc
	4opLWj5wO1Cf2fSGT3hpVb5EXuM3JS4WHNv3NcErC7zC5cx1idFTdLVad+NMhIPZ
	SZRFy0xOxfqMQgSTTEbg7x5EIT4huXcIOvP8MmeBwaS5z/NVDNx6YhoNwWT/lK+F
	Kn+iH/G+IrWHZGEdRIXgPflQEQFWpnQice8DWO17TKlqy9fDKSdcJePP6kPoi5rF
	bfDyQ0CRMGx/naWQPN1Ynv7rIAyrK1hoTaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783317072; x=
	1783403472; bh=NiXXqkZNAy64FEtjIcjMnyoUgWwFD/MXlLT+Y6uEDzE=; b=g
	EE+W9o53Ts++DQd15rgCyGpdYvH5NR8ajqEl2jV+4jn/q2hlhjzotNQB81HWGt9S
	r1U0nHQfDNraSIdHWPqU1CWVJA9gJzOpU7IjPa7qN9Rw1VdvG1Fiyg5sxbMbyj0U
	u++hfouEvwh5zwLxolZZDDa2j9urUSFelyqpULsn9uR/AFpFtV6PGQkNLPVYBONG
	G/pVp2umYs8xHwDtiuQ+uekcdHnwjY4oCd5VOo1wYDGHxTGJZcPKXpzcpiCt3dL8
	6Ss45ECTcs/kLj1KYSU8J4bkF+nEsMVHesNR1dOO1QHWedFFKbaj7/csUrEGKdAF
	auvqdKJ6RK7eK0K55Ye7g==
X-ME-Sender: <xms:UEJLakZgdf4M5xqOuDURRNY7xHlzrJlvLl_rC1V9sxmxtDCUd6X1Vg>
    <xme:UEJLarEap7SyAaYxY3gPVhT5-78mXP0EyQA9arpsnY5GVmSwComX0VI6zrXAd0bkR
    YlshldHbPJn0fBmQOMBdq16maki9zsxDlJnkAOr5UIiiD9gHA>
X-ME-Received: <xmr:UEJLarZkwlYE4fpS9xp73q2XIyDWjLPYDzF-9RvLReMqCh3-XkszYWNcksk2-6ZElvw47j4S8tY4CWCd0ajR8jaXMhahVL4>
X-ME-Proxy-Cause: dmFkZTEi4gFgSXZ1Buqb38D/V9Y4CZdYez94bFbR4XeR2jsO9lv5wGWReoYji6JHjuwtT8
    oYAuGGbD4VBvOb9Zh8wx+IWLe3/TyJePkJ+9cqWj/OJR1OhQlL57oiiNknmJLxnUQg/GoO
    7k3OE8k1KaFjA/POjVAXDGH/+QMv3hcyIMJxHu2SCGttJvVQKy3egbp5M+TSwosb0xNsnZ
    paenvU2aTFoR43QYOhxDsAa8uWUBl2kSvOzuwp/gGBkFIkbwsMGHyjdcgFrwakY69sdlRZ
    8pNJzatV2D8TFp2DULTwWwKjIrFagnntYUT9LWTJ5i8/4kAXZ+FN9YsnM/+qLtxCI99HIO
    BmzYAlNVTAjUUXKcVwBzVBB71pa4FenMxF00Ie/epDdo5VFbwIgsNT1Zkte7LHJW7UvEZK
    q45lvx3h35EnUZDjZtOexsHvs8/VkRJoPWzbPydMLjdN6Hb7iOT0EtmRrU5nqqV4deMOxC
    Q4fpCsxmGRJpNdsbxRwuLgyw1bZE359PbXH0VVJs5VF8ibpsNiGTX2kX9KpQ+O0RUwTdsq
    yn7yI2Y5kCSac+aA43MjY648SCiChDawaxuXZPk05AJ/bJKTCQFrAoTpByVjYCf+r2SvqO
    Q+YzjMa9ZyyO/j92HNGgDA9Mn2eeeXTRoMCknOxa0C+HHKj1lU3ZgqtKkCNA
X-ME-Proxy: <xmx:UEJLanw9Jp9yH2hFyGWnjb7TEqzSfrTvhUApSozqS5HrL5DXVZs5wg>
    <xmx:UEJLalQN2C2q_MdwovFwiynja2XnRrqcOs4CdBCA8kHeCPLefch52g>
    <xmx:UEJLasKNJ1YWMZgqISFs70s9_KZR0JOV6EW2gLf0oUPC108eVl5sUg>
    <xmx:UEJLakW4feU8eP0ni1T0XEdTL21wKn1dKRMFu8-Ccxyh6TyTRVgJqw>
    <xmx:UEJLatj_R_vvDnLXj8pbnE6eJNo_CX0YS6u2qVvHNMFxm3uFDhnqKRhs>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 01:51:09 -0400 (EDT)
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
Subject: Re: [PATCH v3 11/14] vfs: refuse O_CREAT for directories through a
 dangling symlink
In-reply-to: <20260704164149.3480051-12-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-12-jkoolstra@xs4all.nl>
Date: Mon, 06 Jul 2026 15:51:07 +1000
Message-id: <178331706789.27465.16191131997490012539@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 05 Jul 2026, Jori Koolstra wrote:
> open(O_CREAT) without O_EXCL follows a trailing symlink and, when the
> symlink target does not exist, creates it. Refuse to create through a
> dangling symlink for directories.
>=20
> In lookup_open() a negative target reached with nd->depth > 0 was
> arrived at by following a trailing symlink; since the dentry is negative
> the symlink is dangling. Set create_error to -EEXIST in that case
> (matching the errorno returned by mkdir(2).) Reusing the existing
> create_error path strips O_CREAT for both the generic and
> ->atomic_open create paths and only reports the error when the target is
> actually negative. Thus opening an existing target through a symlink,
> interior symlinks, and O_EXCL (which never follows the trailing link)
> are all unaffected.
>=20
> Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 76916caa264d..030cac4fbe55 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4546,6 +4546,11 @@ static struct dentry *lookup_open(struct nameidata *=
nd, struct file *file,
>  						    dentry, mode, create_dir);
>  		else
>  			create_error =3D -EROFS;
> +		/* Refuse to create a directory through a dangling (trailing)
> +		 * symlink. For regular files this has been allowed historically
> +		 * on O_CREAT without O_EXCL. */
> +		if (unlikely(nd->depth) && create_dir && !create_error)
> +			create_error =3D -EEXIST;
>  	}
>  	if (create_error)
>  		open_flag &=3D ~O_CREAT;
> --=20
> 2.55.0
>=20
>=20

Reviewed-by: NeilBrown <neilbrown.name>

NeilBrown
