Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64393255F52
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536984; cv=none; b=Ub90B1YErpKG6mdSN25hf1va0s3LkW8mfvyqt5Tq2/rAiuPuArK0bGrp/J38Ol8asSYSjkZAsPivpibkLsV8KkUTq0lEh+3z4iCA3nw3OQZ0bWtUjj1TNuy8d9exy0Z19ggHWkhcP/NOkDE0HjGsr/wG8ksfretiJXSRIddj+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536984; c=relaxed/simple;
	bh=PgR2EBd2DtMmU8//JFrvsRIW4rcdCXlNqhsH3pR3F68=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=p1aBsmCwbTsEg8Br5P9uqaIRdPV3SDeYjBP1b7pIOpNr3blBNENWIrJNwoCB/U/fyHU7fQb68/GX/ZDIyPdTStLkxam1gmPF/M93eK5S03cyksNJfI+IkmUQCiAb7i5seOFVxBLgiIKoGYuFThNUVsh7F6A/+yaA1RANuwmedRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WjEEBDMM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mWDBGaUe; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WjEEBDMM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mWDBGaUe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74409140018A;
	Mon, 11 May 2026 18:03:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 18:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1778536981; x=1778623381; bh=rKQYxgVCo7Lq9MV6c6HIsCConHvbIoZuk1n
	he9B2iN4=; b=WjEEBDMMuRJa5Dq8IcbVLRotfVH7mn8CrhEB8Xm1mG1gsbfQ7ve
	L3wGpTfyLbRaumpo4ki/ho2Dels9j/eNGS/dLOuPd6QuV9h/c9ow6trwIkiB4/DI
	zShai7AaT7guyCX2DsQpnflwCDRA6fk4U1hHPaHIjrerH69Ci6LtjVXk5cFzsCAw
	w1tVT3XHq+3lDZnT+cCVUbKWIWgznYVQSL3+QRlJv+cTJaOj3gpEcu/rOVS4eVmz
	Vj/rPMbpyA7xd5YKoLNEJPrY0kouG/p6ZZPw6EcWF50ZAsy7+8EzIUmExnpRvLdF
	uFRi0YPvqRs17IUV1XfR/BqOW/cxChb5+qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778536981; x=
	1778623381; bh=rKQYxgVCo7Lq9MV6c6HIsCConHvbIoZuk1nhe9B2iN4=; b=m
	WDBGaUeeCe1TEpSdIoQn9dCAMBs6EPEDVdi4cdjAs5ocCoIlhY4WsjWhGAcMHgOp
	w6Sjo3uDZ+H6Nbx71ZHtxiH0ZGPX9dODastrOvPmeHdC+qPqAG52vIHMEtJgKzSx
	xqpRRRNdPtbYPaeJKxZHHLb4FLmB3+LHrRDXgsN+BJE5DuCuyMOGZhqtsq8LLvIo
	ZvHS1d8zqpDnj/MAIOl59T6L220CaEwVAmdBbfRVDrVdpkT3nEnJ892ox7jOFEEt
	u4mWJ8VrdnSea4IL/MrvLQu/xdMZzd8rqINdC8i7TATOWJlFijR9lvi34KrK0dNu
	6XqyL0ygd4MZMteLIiohw==
X-ME-Sender: <xms:FFICarcbk2XQWpXr-ju9cfkLeF35DZyCG_s4KP87C2E-JfYz5kKYUQ>
    <xme:FFICaqKQOa3mOCRThdxTSxSAmVcmTJ-dt8e7pIU54TCPGiqJsCj1RnxqpbWlhz43W
    gyev_D5-pfSyQWduzc5mLRKpDYJbDsFrk7xoNJr4w6JpB4>
X-ME-Received: <xmr:FFICagFpBaGsGIJ07gH_PWnzloYirp8Ab9VzLQYgzalEc4M2Xwnm6IjfHSFjbPqZm_QcXhZSgYeOPLixBTEq8ctLZPJEuSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddttdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohephhgthheslhhsth
    druggvpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FFICatDcAQ7Q9Z92018Z5DHV6ibczKYr-vql_GCWiMBHrz8pt_oRWA>
    <xmx:FFICaj8_sdtKcOQX1gEZCeMIcqJSXiPrtxc_LVpnvnRmKzWvuzTYUA>
    <xmx:FFICapD3S50vb9Zfoys8Q0UezSoC087FC_b7GyE3xbywfh2rAPRZng>
    <xmx:FFICaoSX-bhMQ2G7mf3XRzZld7YTEPTNRuSBTeN2cOvXSbb7EB8-EQ>
    <xmx:FVICamX9NUiXscNcEyjBwL3YWw589r0l2mr0IFcMyeM73UXBUNc4RdMz>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 18:02:59 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jan Kara" <jack@suse.cz>
Cc: "Christoph Hellwig" <hch@lst.de>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH 3/3] fs: fold __start_removing_path into start_removing_path
In-reply-to: <ctmsec34gzs4cy64o6tchtge4ho3yczztuayzbebjubsnxdflg@hiof5cer2fnq>
References: <20260511072239.2456725-1-hch@lst.de>
  <20260511072239.2456725-4-hch@lst.de>
  <ctmsec34gzs4cy64o6tchtge4ho3yczztuayzbebjubsnxdflg@hiof5cer2fnq>
Date: Tue, 12 May 2026 08:02:57 +1000
Message-id: <177853697754.2788210.12069124083777465894@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 12 May 2026, Jan Kara wrote:
> On Mon 11-05-26 09:22:30, Christoph Hellwig wrote:
> > Only one caller left, and simplified this way.
> >=20
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>=20
> Looks good. Seems like it's like this for 8 months so we're hopefully not
> breaking Neil in the middle of some of his vfs series. In the worst case he
> can reintroduce this once it is really needed. Feel free to add:

Thanks for the heads-up Jan.  No objection from me.
With bcachefs gone it is reasonable to discard
start_removing_user_path_at(), and with that gone there is no benefit in
__start_removing_path() being separate.

I have plans for changes to start_dirop() and start_renaming() but not
to the various APIs which call those.

Thanks,
NeilBrown


>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
>=20
> 								Honza
>=20
> > ---
> >  fs/namei.c | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index bc641838530f..4852ca208bd4 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2955,15 +2955,16 @@ void end_dirop(struct dentry *de)
> >  EXPORT_SYMBOL(end_dirop);
> > =20
> >  /* does lookup, returns the object with parent locked */
> > -static struct dentry *__start_removing_path(int dfd, struct filename *na=
me,
> > -					   struct path *path)
> > +struct dentry *start_removing_path(const char *name, struct path *path)
> >  {
> > +	CLASS(filename_kernel, filename)(name);
> >  	struct path parent_path __free(path_put) =3D {};
> >  	struct dentry *d;
> >  	struct qstr last;
> >  	int type, error;
> > =20
> > -	error =3D filename_parentat(dfd, name, 0, &parent_path, &last, &type);
> > +	error =3D filename_parentat(AT_FDCWD, filename, 0, &parent_path, &last,
> > +			&type);
> >  	if (error)
> >  		return ERR_PTR(error);
> >  	if (unlikely(type !=3D LAST_NORM))
> > @@ -3023,12 +3024,6 @@ struct dentry *kern_path_parent(const char *name, =
struct path *path)
> >  	return d;
> >  }
> > =20
> > -struct dentry *start_removing_path(const char *name, struct path *path)
> > -{
> > -	CLASS(filename_kernel, filename)(name);
> > -	return __start_removing_path(AT_FDCWD, filename, path);
> > -}
> > -
> >  int kern_path(const char *name, unsigned int flags, struct path *path)
> >  {
> >  	CLASS(filename_kernel, filename)(name);
> > --=20
> > 2.53.0
> >=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>=20

