Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AA3B5F63
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686538; cv=none; b=fFIU0xX97Poo+4viBZi7LMLmelii0mY5T3Fomwz9j1Bo4kS6sA6CNFYg07CI12NMlkNWI3cno1c4WMQddSKp3Zdw35pj2indkVJJjc0WMDa6d1MdO75C/5Xr7d5s8Ry+DEhrd+s7kJ+yM95mxr6DWkuxXGBjX9vm4ns6sZw6Gyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686538; c=relaxed/simple;
	bh=MmutxcldK+DtJ0RFE31YTswnGSG20eVh239ybyfYgYg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LnvUfPz4MhQeWI/Z5GbXO0dyyLOZBq81hkt2ICy9imZ7BxNJAIFuOpLzbQIq+90z1HULCkn4TOANKl4uP917s/A4iOY26lLjhdpwk20NnziC7HxKNgPNfPXF+41KTX2X/Opioh7yuAZUxUVDEnBMlwLsTtRNRnLpoHjGuVQhH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=miAq54xj; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="miAq54xj"
X-KPN-MessageId: 48950d68-6a2a-11f1-8f53-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 48950d68-6a2a-11f1-8f53-005056992ed3;
	Wed, 17 Jun 2026 10:55:26 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 48944385-6a2a-11f1-b2ea-0050569977a2;
	Wed, 17 Jun 2026 10:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=iXHBD4+j5O5wT5sSkRwzomAqYCmhns+sW69jzeRQ7jQ=;
	b=miAq54xjVE42ufkSIA1oG6SAzZvzv4UGiknqzCUooquhI/jdCjPVXMDzoB6TaATqbR7NUpCL0rT2v
	 Kxi+mRNC9UlzvTV3au1Lc9ibURY3s3V+g6IzhwgIdlRAxBOEmYG+mmvi3sthz9DrjwH00vrQPSeooV
	 RilxIRYEDguhw6vtlL9mMslwCmhHmFjKVoEckYGKESLdSf28qJ0tTIq4TXb6eoEbEw2TnmC1e2a4lj
	 n3GBfrhOPyq/VSK0I3M4pkYZaBFqMok/3nB/Vna44/+mN3SdSA2fZR4WeDfB7OJpgrZKtEKjL5TyUP
	 LepAo8BtgdLnil/BSPpVMSweW2ekCOw==
X-KPN-MID: 33|YwThd7xqZPFR7GM5iPQuWnhohNC8fpebY9QI1bPttks9FRIB2zlaDXRgfKoSWot
 6LKlUNvyRMBV2r9yFtsYEmLdMAQVjkUm5qHZJTktsGmg=
X-CMASSUN: 33|DlaiNBNymlHfYl2c3+Nqv6APSb+bxY+3EjhUb/Q7dJL9JXLIT4eSKyU9aXKepQb
 ZRpU3N+FHjuS73eKM96C/gw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 488779d6-6a2a-11f1-8edb-00505699eff2;
	Wed, 17 Jun 2026 10:55:26 +0200 (CEST)
Date: Wed, 17 Jun 2026 10:55:26 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Paul Moore <paul@paul-moore.com>, NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"audit@vger.kernel.org" <audit@vger.kernel.org>
Message-ID: <1304452148.2041031.1781686526317@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAHC9VhSBOQqjQ6A+f4YEJZmWVxVqOrRbtj7hF2qL_-vCCBc2Fg@mail.gmail.com>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
 <20260614164438.2980769-5-jkoolstra@xs4all.nl>
 <526417482.1849950.1781559782000@kpc.webmail.kpnmail.nl>
 <CAHC9VhSBOQqjQ6A+f4YEJZmWVxVqOrRbtj7hF2qL_-vCCBc2Fg@mail.gmail.com>
Subject: Re: [PATCH 04/12] fs/namei.c: lookup_open(): move
 audit_inode_child() up
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal


> Op 17-06-2026 04:32 CEST schreef Paul Moore <paul@paul-moore.com>:
>=20
> =20
> On Mon, Jun 15, 2026 at 5:43=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.n=
l> wrote:
> > > Op 14-06-2026 18:44 CEST schreef Jori Koolstra <jkoolstra@xs4all.nl>:
> > >
> > > In the mknod(2) path of calling vfs_create() we call audit_inode_chil=
d()
> > > before permission checks in may_create_dentry() (but after path-based
> > > LSM check). Copy this behaviour to lookup_open() and move
> > > audit_inode_child() to may_o_create().
> > >
> > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > > ---
> > >  fs/namei.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> ...
>=20
> > CC, audit@vger.kernel.org
> >
> > Went too quick with this one... audit_inode_child() probably shouldn't =
be called
> > if we are in the lookup case. So there isn't really a way to do this ex=
actly
> > symmetrical to the vfs_create()/vfs_mkdir() paths.
> >
> > But certainly the current implementation is also wrong. In the atomic_o=
pen case
> > audit_inode_child() is called only once (in the final fsnotify call in
> > open_last_lookups()), but in the regular ->create case audit_inode_chil=
d() is
> > called twice.
> >
> > What behavior is actually wanted here?
>=20
> I haven't looked at the VFS open/create code in a while, and I'm kinda
> swamped with other things at the moment so a few pointers would go a
> long way towards helping get the right context for your question.
>=20

You are right, I should have added some more context, sorry about that.
And thank-you for taking the time to look into this.

In the current mainline code, in lookup_open() in fs/namei.c (which is
the primary function that handles creates from open(O_CREAT)) on line
4502 we call

=09audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);

just before we delegate to i_op->create(). However, on return of lookup_ope=
n()
in open_last_lookups() on line 4610 we also have

=09if (!IS_ERR(dentry)) {
=09=09if (file->f_mode & FMODE_CREATED)
=09=09=09fsnotify_create(dir->d_inode, dentry);

So, if the create succeeded, fsnotify_create() is called on the same inode.
This function is given by:

static inline void fsnotify_create(struct inode *dir, struct dentry *dentry=
)
{
=09audit_inode_child(dir, dentry, AUDIT_TYPE_CHILD_CREATE);

=09fsnotify_dirent(dir, dentry, FS_CREATE);
}

Thus it appears that audit_inode_child() is called twice. This happens is
various forms for most other audit involved paths in vfs too (like mknod,
mkdir, etc.)

This is what is confusing me. What should be the correct order/number of ca=
lls
here?


> We shouldn't *need* multiple calls into audit_inode_child() for a
> given filesystem object as long as all of the information audit needs
> can be captured in the single call site.
>=20
> --=20
> paul-moore.com
