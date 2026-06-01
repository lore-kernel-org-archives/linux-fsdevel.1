Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C0199949;
	Mon,  1 Jun 2026 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780354713; cv=none; b=VcNnKf8DyGsP4JHE1WkDhZCQkMiyNftmMEK4OllrKRi1G6ZMYQ1mjAscY4qWbvM/LQqejJJg/mQzlOGeLYESlp+Qwk5Yem08hm1twyBycQCfbrO+frLzIDThv83ABit/+3lDkR+GSIR5LLQN4urrv//ot6BNhL2FeOIl7cfKHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780354713; c=relaxed/simple;
	bh=Rnq9K8g2oM43Q3bXYRYfb99m107XnkyONqNp85y2IIo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UHoMG+OU/Ew2rVpmdNUzCfyApekFo+pV5rLPxkwiQzmC4O3k3ZRa3AD88Fz1Fcf8srjTIQv8B5rsyTNpew1buOwKbVK4PnafWgsOsAc6dNfoi/ueQOOMBllzWVQ49xUfJ+GNz1yG2nVX568KcXBl5YRY/6h3JLf6TCn9lvA+tuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=h/UlIio+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/dgfNhX; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="h/UlIio+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/dgfNhX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 51C83EC06AB;
	Mon,  1 Jun 2026 18:58:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 18:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1780354710; x=1780441110; bh=fNvQOWqWpm6NNXGBtE6b3O+w7EF/b0ZRcI6
	OXDSk3Xw=; b=h/UlIio+zFbboa4PtltCl6iHByxTqfSttGKAVCPK+GV+hlIc5QD
	y7Lj9P9MyOyA7oytXdf9xeAWVRX59TTm9frK0Qcio5alhsSqnHFo8t8yZViKHwx8
	ue5jHrit0pWOp7milgyJc3ZADJmB8idNOk9Wpkik3wpaV/wL38f8zNmN56eBtBOQ
	zZxK0Ks6qy650ZaOVphshpNc8TauaQulDhVLbEKf+NaOngp9g+Mxqmx2SKm2ynTD
	7c+8SHunFlWR2NymltW1dK82vvEvuak78URp+mj/ocHDQ2aqRVuBnBpjhkVaG+CI
	q95kc5NjFXyR9ogDQdImWtZiqMR9arq3K5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780354710; x=
	1780441110; bh=fNvQOWqWpm6NNXGBtE6b3O+w7EF/b0ZRcI6OXDSk3Xw=; b=j
	/dgfNhXWu0O7Z7jv5n0mT3EX4AFYDYq2q+u6qnjJMXiDpbx/tV4FBh95HfK6ouE6
	93UQTZJfIOgcfIReC+3RejmKe0MFn7EbtOJ3RFeQH4vea0g/2R0TT507Hkrqo+xp
	R1wsOq3sKXcp5qMQDTNZ5vsbDL6XstZvS//inzt2o+MERr68OhmL2wpeXLM6rafU
	VCDwGV2J+jRHm+Z/CN1WGRXoJ8kdjkFF54ZCgxlxKSL39ptLZ/oOeqXOEeWL1v6+
	1bV52nYw4Q4kA4ZrrpDo48Ecno1oKKGdJrsENTeRCMd6MS/cRp2+W5NnOHiB8iEX
	+zafFTy+lLmJXCh3PhBRg==
X-ME-Sender: <xms:lQ4eag_gCocb83h8_DL2qMe49AaBO4HyDGSP1gjkTYlRoObsaRnkNw>
    <xme:lQ4earTAdgc_MS95B3Ox5UUmenHO5USDwQQUhNF5PZAhYtHtSAU7txPLjcp6-oakr
    hCcaQF65l-JWW6gk5JAaXwv_YdpbB9mdsoJSviguq2mRfpMHQ>
X-ME-Received: <xmr:lQ4eapqZvyMmuitjwdP2AnUlGmiWtCOifxaEmwb-1eHm9iTmdVIWzLRcFw2p6wW7Evwxks7q7HDE_aFK7uePuFFvr3ZPvuw>
X-ME-Proxy-Cause: dmFkZTFeAF2Pr3NX7F5A/EfBwpJOmsIi/oBfk6/6nzs90uvaYBKq5pvXSfDa3+gC0zv2D7
    /Mezun34Z++fzjlb3fY04VVM4H6Hdd9ybkINBtypyHos07vSmcNWzvoMBIzeI4JKIC+pmx
    ufBWmPMmuGSjlKYGKnNuLRRjYtZA7II8KnoPI/clQsEastzG17u5LrI7us0afi5trLx8zR
    sdxscLovO3uySsCdczKyhMRKR7WCGWTTFYEHRV7hsO3FPRPsL5FE4uVCosO1WPjjdkriIV
    3oATiax99uSUIlSY5uJTyyPsgSnyMD2ieqiCHGHkBH6W20ROgLmrjkrXx/6tmpUYEQQItc
    GODULCpL30qAmCzi0z3RAwBameCiixB8D1lNXKhbO7DNz69uAQbafhB8Y5Io9I879etrtm
    /R/SUXjQoECArPHc1IwYyIMnyroiecz6dZ4goPWoPWyi8Db8qfS6Zy1Y2eMAgvQiz7GUiJ
    fXYUUS8oA4Ex3HPhZdF3QayVX3jZONv6oAJxMZDjow7oHhc7odReuwucZFxqZMfgIZGrdu
    QWPGFs8yN5ESUwW4NNPTyWjgMuQafn9hydrNfi03eV6frEyJ6kMmYDPGOkVV+IKCk1I2LM
    PbS1OqmCDzZJPStbmvVensssIJFbuT2Grn8L03UoPR8e+DLQht+mKSPNLNXg
X-ME-Proxy: <xmx:lQ4eagl4GZBE6sWRzV8UuRRUMAQACMWKBCDUpHg4NI8tKcFlsMIcdQ>
    <xmx:lQ4eaqdhfDSTp5t2aCYMVh-VjXniww0kWHq4M-cUKg2HptdZXhZF1A>
    <xmx:lQ4eakpURwLACLw2XFMiv6Z0yX2sOGhy-YBfLvi3k02loUq_gETwFQ>
    <xmx:lQ4easNbWLfAwj8_m-seOriO0En5dP5w1CKOQUDUtWj7PocFQwyb1w>
    <xmx:lg4eamXX696lz4aOIv0fkeWL2IV2nHJ0T_koGak9b-9b-_bG0-V5rrIR>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 18:58:27 -0400 (EDT)
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
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Aleksa Sarai" <cyphar@cyphar.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cmirabil@redhat.com
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <1825098847.140203.1780349158954@kpc.webmail.kpnmail.nl>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
  <20260525202937.466497-2-jkoolstra@xs4all.nl>
  <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
  <1825098847.140203.1780349158954@kpc.webmail.kpnmail.nl>
Date: Tue, 02 Jun 2026 08:58:23 +1000
Message-id: <178035470365.2923901.16027569586235650310@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 02 Jun 2026, Jori Koolstra wrote:
> > Op 27-05-2026 09:27 CEST schreef NeilBrown <neilb@ownmail.net>:
> >
> > > @@ -1268,6 +1269,8 @@ inline int build_open_flags(const struct open_how=
 *how, struct open_flags *op)
> > >  	op->intent =3D flags & O_PATH ? 0 : LOOKUP_OPEN;
> > > =20
> > >  	if (flags & O_CREAT) {
> > > +		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
> > > +			return -EISDIR;
> >=20
> > It seems odd that the MAY_WRITE test is only performed for O_CREAT.
> > Shouldn't any open of O_DIRECTORY|O_WRONLY fail, and shouldn't the one
> > test catch both create and non-create cases?
> >=20
>=20
> I get your point, it does look odd. But AFAIS O_DIRECTORY|O_WRONLY is curre=
ntly only blocked
> after path resolution and final lookup. So that was the behavior I tried to=
 keep. On the
> other hand, right now O_DIRECTORY|O_CREAT is already blocked in build_open_=
flags().

I see that currently O_WRONLY for directories is only blocked in
may_open() which happens after we have the inode for the target, so
after any create.

So I agree that we need to put something in build_open_flags() which
happens much earlier before path-walk even starts.

I think it would be best to always block an O_WRONLY/O_RDWR combined
with O_DIRECTORY.  It can never succeed so there is no point in even
starting the path-walk.

But I too would like to know what Christian or Al think.

>=20
> But if that is true, and you have atomic_open() defined for your filesystem=
, then you
> can lookup and open a directory with O_DIRECTORY|O_WRONLY, while it fails w=
ith EISDIR later
> (if the fs atomic_open() does not error on O_DIRECTORY|O_WRONLY, which I wo=
uld guess it
> mostly does). It will then fput_close() the file, so there is no leak, but =
I don't think
> that is wanted behavior.
>=20
> @Christian, what do you think?
>=20
> >=20
> > >  		op->intent |=3D LOOKUP_CREATE;
> > >  		if (flags & O_EXCL) {
> > >  			op->intent |=3D LOOKUP_EXCL;
> > > diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> > > index e4295a5b55b3..ec8c54c91261 100644
> > > --- a/fs/smb/client/dir.c
> > > +++ b/fs/smb/client/dir.c
> > > @@ -526,6 +526,9 @@ int cifs_atomic_open(struct inode *dir, struct dent=
ry *direntry,
> > >  	if (unlikely(cifs_forced_shutdown(cifs_sb)))
> > >  		return smb_EIO(smb_eio_trace_forced_shutdown);
> > > =20
> > > +	if ((oflags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK)
> > > +		return -EINVAL;
> > > +
> > >  	/*
> > >  	 * Posix open is only called (at lookup time) for file create now. For
> > >  	 * opens (rather than creates), because we do not know if it is a file
> > > diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> > > index 42bedc4ec7af..aef5ca6730be 100644
> > > --- a/fs/vboxsf/dir.c
> > > +++ b/fs/vboxsf/dir.c
> > > @@ -318,6 +318,9 @@ static int vboxsf_dir_atomic_open(struct inode *par=
ent, struct dentry *dentry,
> > >  	u64 handle;
> > >  	int err;
> > > =20
> > > +	if ((flags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK)
> > > +		return -EINVAL;
> > > +
> > >  	if (d_in_lookup(dentry)) {
> > >  		struct dentry *res =3D vboxsf_dir_lookup(parent, dentry, 0);
> > >  		if (res || d_really_is_positive(dentry))
> > > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > > index a332e79b3207..e31f3a57f07c 100644
> > > --- a/include/linux/fcntl.h
> > > +++ b/include/linux/fcntl.h
> > > @@ -12,6 +12,8 @@
> > >  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> > >  	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> > > =20
> > > +#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
> > > +
> > >  /* List of all valid flags for the how->resolve argument: */
> > >  #define VALID_RESOLVE_FLAGS \
> > >  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> > > --=20
> > > 2.54.0
> > >=20
> > >=20
> > >=20
> >=20
> > Thanks,
> > NeilBrown
>=20
> There is another point, I maybe should have mentioned in the cover letter: =
I have not attempted
> to handle dangling symlinks for O_MKDIR. Not because I think they are a gre=
at idea (as Aleksa
> has mentioned, but I am not very familiar with the dragons it entails), but=
 I wanted to discuss
> what behavior we want in this case. Do we say that we never do a mkdir afte=
r following a lookup
> last symlink? I don't think that state is even recorded right now.

I think the state might be recorded in nd->depth.  But you probably
don't want to use that directly.  Maybe forcing LOOKUP_FOLLOW to be
cleared if O_CREAT|O_DIRECTORY is set would be good.  But what would
stop you opening an existing directory through a symlink....

Probably we need a clear statement of intended semantics which we can
review, agree on, then implement.  Have you looked at preparing a patch
for man-pages to document the change in behaviour for openat etc?

Thanks,
NeilBrown


>=20
> Best,
> Jori.
>=20

