Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24198446C0D
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247560; cv=none; b=guVkU1CP4eF9zWqTZ9AJ+gATrNPa5S6EW7/fca7O5da2MaKPfpb2niIVFn4hLhQFO8BeWMivhZmUkub46RTJSBpZX87Vz/wcDtSTjdw5YaPCg4uYk3N5IjPi+6qqhyIsgDmEZLC1jWAMoOgewMzqZ5FUMwwYVIQBc7elg4AfbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247560; c=relaxed/simple;
	bh=evIc72wiwT1XdwA0FSRtAYgMY29DbtQ7JWn9+wbCnts=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=IJR5neJ1C4lwYVjP+KPvf3oSvTM5WkEL7XfYCiRNI1HLFRbbE2gQckSUJrkkDuaqVezLAe/L3EcuSwvVn2HCF5tKUAdqYwOiIoKhqJ92sTGCvTTrR7dRImxG2gQ4U2LoktVaOp/xI6XRckZ7b6UydmGlB5FHFOG36LN+iX9Q2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=byDnxZ8Q; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="byDnxZ8Q"
X-KPN-MessageId: 71e01010-8a8d-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 71e01010-8a8d-11f1-8f54-005056992ed3;
	Tue, 28 Jul 2026 16:05:53 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 71dcd388-8a8d-11f1-b315-0050569977a2;
	Tue, 28 Jul 2026 16:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=y9qzNaBQaJ1HHxdW4i/51Xov/C1q/PIlpBEt7Bj0kcw=;
	b=byDnxZ8QTVJB11AqaH1d50hnfydgqGryAF+oKPSMWm9mMCuHHdYRxIHbIi8QpF08orDIwPiWbw5p5
	 piKHv+MuweF51WPYcJt2S4aTFv6wcEDxMViehT6i8KSePzpVXKWjPiDCczgCBFVLnkuo1Kr0cv/IJl
	 vEnGvuqopaB+ix7eq1PQWN7cZ/hxaMje+5bYtqd1E8LV8MMqXBZHSJIVzuGUxlMNMGg4XAKkwao7zX
	 YeDwbFdR769JYrD2/hbkwsdlPkckIuuJaVJ6GqUfJJNHnB1sd1u54TOKVfCVHSZUyWuvZwXHqxre4/
	 Ed+h69DVsY0oXRpvfbrh+D6tfgeaO9Q==
X-KPN-MID: 33|L3/beUzbwIgwmHaE1/vPBQJjHb/zC7dwTmdxjrSgGQ543wtcCaPmJSNGeY3cxkD
 fkgYAq4RRDFgmMHGmW6jp6tu471JZ8xqkkkYrJSRauxU=
X-CMASSUN: 33|1TXlOyJ4SBjb+JXD39+OGcnAnSiIdSUq2+6bt1kXloC9yPbKiyHl/FgQQXqhfzh
 47PwaUg94IzO3ouL557RtSQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 71cdc435-8a8d-11f1-8edb-00505699eff2;
	Tue, 28 Jul 2026 16:05:53 +0200 (CEST)
Date: Tue, 28 Jul 2026 16:05:52 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <64825400.394146.1785247552949@kpc.webmail.kpnmail.nl>
In-Reply-To: <2048838556.1496380.1784464286664@kpc.webmail.kpnmail.nl>
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl>
 <20260712192958.1631672-2-jkoolstra@xs4all.nl>
 <CAAVpQUCD27YphUQ=aL3PyPtWwTo0tEtaFt-hvyoyCnepGAmYCQ@mail.gmail.com>
 <2048838556.1496380.1784464286664@kpc.webmail.kpnmail.nl>
Subject: Re: [net-next v5 1/4] net: af_unix: enable custom setsockopt for
 all socket types
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

@Kuniyuki,

Could you take a look at this if you have time? Would like to move this
along if we can.

Thanks,
Jori.

> Op 19-07-2026 14:31 CEST schreef Jori Koolstra <jkoolstra@xs4all.nl>:
>=20
> =20
> > Op 14-07-2026 11:19 CEST schreef Kuniyuki Iwashima <kuniyu@google.com>:
> >=20
> > =20
> > On Sun, Jul 12, 2026 at 9:29=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all=
.nl> wrote:
> > >
> > > unix_setsockopt() and the SOCK_CUSTOM_SOCKOPT flag were only wired up
> > > for SOCK_STREAM (introduced along with the stream-only SO_INQ).
> > > Consequently custom AF_UNIX options are unreachable on SOCK_DGRAM and
> > > SOCK_SEQPACKET: those setsockopt() calls bypass unix_setsockopt() and
> > > fall through to the generic sock_setsockopt(), failing with
> > > -ENOPROTOOPT.
> > >
> > > Set SOCK_CUSTOM_SOCKOPT for every AF_UNIX socket type in unix_create(=
), and
> > > also for accepted sockets in unix_accept() (reachable for stream and
> > > seqpacket).
> > >
> > > This is a prerequisite for making SO_RIGHTS_NOTRUNC settable on all A=
F_UNIX
> > > socket types.
> > >
> > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > > ---
> > >  net/unix/af_unix.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index f7a9d55eee8a..3d256255085b 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > > @@ -949,7 +949,7 @@ static int unix_setsockopt(struct socket *sock, i=
nt level, int optname,
> > >         switch (optname) {
> > >         case SO_INQ:
> > >                 if (sk->sk_type !=3D SOCK_STREAM)
> > > -                       return -EINVAL;
> > > +                       return -ENOPROTOOPT;
> > >
> > >                 if (val > 1 || val < 0)
> > >                         return -EINVAL;
> > > @@ -1005,6 +1005,7 @@ static const struct proto_ops unix_dgram_ops =
=3D {
> > >  #endif
> > >         .listen =3D       sock_no_listen,
> > >         .shutdown =3D     unix_shutdown,
> > > +       .setsockopt =3D   unix_setsockopt,
> > >         .sendmsg =3D      unix_dgram_sendmsg,
> > >         .read_skb =3D     unix_read_skb,
> > >         .recvmsg =3D      unix_dgram_recvmsg,
> > > @@ -1029,6 +1030,7 @@ static const struct proto_ops unix_seqpacket_op=
s =3D {
> > >  #endif
> > >         .listen =3D       unix_listen,
> > >         .shutdown =3D     unix_shutdown,
> > > +       .setsockopt =3D   unix_setsockopt,
> > >         .sendmsg =3D      unix_seqpacket_sendmsg,
> > >         .recvmsg =3D      unix_seqpacket_recvmsg,
> > >         .mmap =3D         sock_no_mmap,
> > > @@ -1142,9 +1144,10 @@ static int unix_create(struct net *net, struct=
 socket *sock, int protocol,
> > >         if (protocol && protocol !=3D PF_UNIX)
> > >                 return -EPROTONOSUPPORT;
> > >
> > > +       set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
> >=20
> > Please move this to unix_create1(), then we don't need the chunk below.
> >=20
> >=20
>=20
> I don't understand how this helps. The accept() path gets its struct sock=
et from
> sock_alloc() not via unix_create() afaict. Also, unix_create1() is called=
 with
> sock =3D=3D NULL on connect(), so now you have to guard against that too.
>=20
> But maybe I misunderstand you?
>=20
> I do agree with you other comment, accept() should probably inherit the t=
runcate
> behavior from the listen() socket.
>=20
> Thanks,
> Jori.
