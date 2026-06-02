Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3B3DD53F
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401133; cv=none; b=FgvJsj8BTT/SZQSohIxCFrm/dsJfjqnV2eany8AUZhEhS8qmeot6eupNjKKhkJ+yMIH6c6f5PDVAsBo3ujZFjEYonISG4v5CHX1LqkcqvtD0reLKvg9pcqdybJiTiDOYL2iv7mJV7k4Tlw3WMPpO85qLgiQAjhNodlrtqxhGKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401133; c=relaxed/simple;
	bh=sz7pEPxWxAuPvg8Qqepcd9Zvzd0I2ZEN3Y2S1iqpR28=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RTAEx6rJLXPzA4enOASIVBDvW+mRwXElmD8iGonXunWlEgN4pIRVUGSwDoc1XtcgMjGyH8hco/1yFMqv/tLdAkIDQ8vPCGZuskV1jYXreUhaVJieF3u+lhhPHPXjvumz+D1dZVy34uLc4ZQSTRaB0JY9TjQalAiMLYFXJzNhUUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=e5hxFb7J; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="e5hxFb7J"
X-KPN-MessageId: 76e842f3-5e79-11f1-8ff7-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 76e842f3-5e79-11f1-8ff7-005056999439;
	Tue, 02 Jun 2026 13:52:00 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 76e6e93b-5e79-11f1-83dd-00505699891e;
	Tue, 02 Jun 2026 13:52:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=tF+gGkpDL4CxHTNTobZojYznC4Lasa04oDIA9zkOcQ4=;
	b=e5hxFb7JZ88wSHolPAxhNzzcSXh8DGVOLjLWz52qBjzNft7Bs/Y7fKN5Ri+Den/RfsK2YxU2ZIhB7
	 HM3srsoKOszQLlYjK/cSFNqZT1p/nhUcNsImFh7CJx1tgTcJNLnsLucFzpcG8R5OThpWy2cLURftyw
	 iqOgQfxiKkvTJ1dIw9hbNBnj49wgsPtGVUK8RcHHO76eVsVS6g8Hi2pI4vHF8FVWpM+TZGBEC10+aa
	 BnRkGrcWVNLsPDBv0bX0AiY1mTem0nTc+EQrf267xjaKoyIUpzPe+9rP+6M0D0n4/IQQiY36JlMphY
	 YuHnyQ3Ig0HVM1mfAuF6ZHVyhEaAOrg==
X-KPN-MID: 33|6xp8m6OYENueuUnG0oUR+PMeQgT7A2dhVDkE1MboY9V3zF4rZGV2MW4vBuu+3iJ
 SJdgL/EIs4ar+0fvd//WYCuH/p6CpCT2kIXogqzJyLMo=
X-CMASSUN: 33|rcDpp/dssS6if351X6B3dSmNFNjQyV1+AXOoQKpkhBGMA4ZJLQUf7tuDkKHSMWj
 iBI6xiUoS6qKQRD2D4OmA/w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 76dc687a-5e79-11f1-94b1-00505699eff2;
	Tue, 02 Jun 2026 13:52:00 +0200 (CEST)
Date: Tue, 2 Jun 2026 13:52:00 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Charlie Mirabile <cmirabil@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <1748352829.218751.1780401120337@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260512-sparflamme-themen-4f3f10225b2a@brauner>
References: <20260428175125.2705296-1-jkoolstra@xs4all.nl>
 <20260428175125.2705296-2-jkoolstra@xs4all.nl>
 <CAAVpQUBKeN2KtRkRAFr8sYJM1_-rbkdjsujau5fAyaiP_dO6FA@mail.gmail.com>
 <20260512-sparflamme-themen-4f3f10225b2a@brauner>
Subject: Re: [RFC PATCH 1/2] net: af_unix: Useful handling of LSM denials on
 SCM_RIGHTS
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

Only now get to this...

> Op 12-05-2026 15:06 CEST schreef Christian Brauner <brauner@kernel.org>:
>=20
> =20
> On Wed, Apr 29, 2026 at 07:04:25PM -0700, Kuniyuki Iwashima wrote:
> > On Tue, Apr 28, 2026 at 10:51=E2=80=AFAM Jori Koolstra <jkoolstra@xs4al=
l.nl> wrote:
> > >
> > > Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> > > receive an SCM_RIGHTS fd the SCM_RIGHTS fd array will be cut short at
> > > that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> > > highly problematic behaviour, because it leaves the receiver
> > > wondering what happened. As per man page MSG_CTRUNC is supposed to
> > > indicate that the control buffer was sized too short, but suddenly
> > > a permission error might result in the exact same flag being set.
> > > Moreover, the receiver has no chance to determine how many fds got
> > > originally sent and how many were suppressed.[1]
> > >
> > > Add two MSG_* flags:
> >=20
> > Since we only have 5 bits remaining for future extension,
> > we need to consider the use case a bit more carefully.
> >=20
> >=20
> > >  - MSG_RIGHTS_DENIAL is set whenever any file is rejected by the LSM
> > >    during recvmsg() of SCM_RIGHTS fds.
> >=20
> > Is this really needed ?
> >=20
> > Even if the fd array is truncated, the application will traverse
> > the array anyway since it has some fds already installed (to
> > clean up in case of MSG_CTRUNC ?).
>=20
> The socket option suggested later: Wouldn't it be simpler to just add a
> socket that instructs the scm layer to send all fds that were denied
> with a -EPERM sentinel. Then systemd can:
>=20
> * detect all fds that were denied simply by seeing they were -EPERM
> * keep the count in tact
>=20
> and - see below - get rid of the blatant layering violation in here...

With "add a socket" you mean add a socket option that can be used in the sc=
m layer?
I.e. do something in unix_setsockopt() and define it in unix_custom_sockopt=
()? Then
we can have an option like

struct unix_sock {
    ...
    unsigned char   whatever_scm_opt:1;
};


>=20
> > Then, it will find the -EPERM entry.
>=20
> I assume we're talking about the same thing. All the complicated rest
> should be dropped. There's a bunch of nonsense in that uapi entry -
> quite a few items are merely drafts.
>=20

We should update them or flag them as "needs further refinement." Is this
stuff that would be interesting to discuss at All Systems Go? I would like
to go, but I'm also already planning to go to Recipes, OSS Korea (if I can
get funding for my talk), and Prague in October.

> > > -int receive_fd(struct file *file, int __user *ufd, unsigned int o_fl=
ags)
> > > +int receive_fd_msg(struct file *file, int __user *ufd, unsigned int =
o_flags,
> > > +              unsigned int *msg_flags)
> > >  {
> > >         int error;
> > >
> > >         error =3D security_file_receive(file);
> > > -       if (error)
> > > +       if (error) {
> > > +               if (msg_flags)
> > > +                       *msg_flags |=3D MSG_RIGHTS_DENIAL;
> > > +
> > > +               if (ufd)
> > > +                       put_user(-EPERM, ufd);
> > > +
> > >                 return error;
> > > +       }
>=20
> I don't like this. It's bad enought that the generic file layer needs to
> call into __receive_sock() I don't want it to poke into other subsystems
> internals even more. That's just not appropriate. Get this out of the
> VFS's way, please.

Don't know what I was thinking here honestly. This is bad code :(
