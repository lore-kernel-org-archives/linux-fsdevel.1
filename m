Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B21386C9
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jul 2026 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784464296; cv=none; b=Gw4vCUwHP0WnlH+8j/NQCrpCHldrVrNCrL7wLBgpTacgswV9CabsjGlyZOYVXHoj/YTKwKmKw4ip2y3egu3n1zrSYxT67K3YckT1xadqxg+7dFdPIXBFVEfl2gjhT1ozOaWXEzCHIPkTARP62ZgDL3MpBLhc7Bem+EIgz8snnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784464296; c=relaxed/simple;
	bh=DHZjCj81HBb1IVwJIhCz/tTWkaYvujMzuCnNK16C+UQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GRLcftQ3NSoaFyc7NwQSNk5t+xk2n+doNZtzDJkW49s50BtMbBgXE3ay+H3MvvgxOk/6fyZaz9wsg44hd+4XrjSL1UpbaReG12ialFud/uv/9grddmJV1y8VJMgQZr6jYB4Fnu0LH0kY4oN75H+MGc8gysK2WP2+pby5vqYHGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=GKrQNiov; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="GKrQNiov"
X-KPN-MessageId: c2c68f18-836d-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c2c68f18-836d-11f1-8f54-005056992ed3;
	Sun, 19 Jul 2026 14:31:26 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id c2c54ba3-836d-11f1-91c4-00505699891e;
	Sun, 19 Jul 2026 14:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=NYf1raD5UQY7WYwcwyb2mT1tPHM7j2gkw9m0yK5hjXk=;
	b=GKrQNioviRCkaleMEhTS61GGbTfvO25oQ4KZ/Wv3UTpSen4XO5ExrWzx2qr66LJhWTnVAWPnIzLFo
	 LF7D4CK6sq0nfbEhNt1xyK9jknTMP93kreBCroCI63eS9vhOzoUOYt6q6cWjqCa/akEBPhtMQPXXk3
	 VfOrRXctrR6qz5YSIvMOm5PFiLr+UBItmYaMFdQE5UWEPERU+OTK9aNd/IHhDW6s8w1kqocV5kuwds
	 MOW7mPlRRl+tyX6WTDa9N0ZRcbRA1GBykmPyGR+S7VK03E6nXIZG5/sc/ntUvMBAUOwzCdIcykuPHN
	 TbdbZ5EYenh6U8nTq+hmzTk0NFSHSnQ==
X-KPN-MID: 33|exm5DeESXxAcw4nNL7rTJ5+of//nAIx+RyXFrE5ZcPT1lNw2m9E9Evl8k3eAhuj
 E2Fu+/X8NsETqw4oS2kFDbV6clpiwr4CdieE9Xqqa2d8=
X-CMASSUN: 33|9UXII1lQl5i6oWsN8RNl+JLwFDiu2QzU3OAUgUWbm3yPhJuYoXJD97ExRL62hWr
 lokZVhD7o7w1YxINneNdzdg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id c2b79c65-836d-11f1-8edb-00505699eff2;
	Sun, 19 Jul 2026 14:31:26 +0200 (CEST)
Date: Sun, 19 Jul 2026 14:31:26 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <2048838556.1496380.1784464286664@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAAVpQUCD27YphUQ=aL3PyPtWwTo0tEtaFt-hvyoyCnepGAmYCQ@mail.gmail.com>
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl>
 <20260712192958.1631672-2-jkoolstra@xs4all.nl>
 <CAAVpQUCD27YphUQ=aL3PyPtWwTo0tEtaFt-hvyoyCnepGAmYCQ@mail.gmail.com>
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


> Op 14-07-2026 11:19 CEST schreef Kuniyuki Iwashima <kuniyu@google.com>:
>=20
> =20
> On Sun, Jul 12, 2026 at 9:29=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.n=
l> wrote:
> >
> > unix_setsockopt() and the SOCK_CUSTOM_SOCKOPT flag were only wired up
> > for SOCK_STREAM (introduced along with the stream-only SO_INQ).
> > Consequently custom AF_UNIX options are unreachable on SOCK_DGRAM and
> > SOCK_SEQPACKET: those setsockopt() calls bypass unix_setsockopt() and
> > fall through to the generic sock_setsockopt(), failing with
> > -ENOPROTOOPT.
> >
> > Set SOCK_CUSTOM_SOCKOPT for every AF_UNIX socket type in unix_create(),=
 and
> > also for accepted sockets in unix_accept() (reachable for stream and
> > seqpacket).
> >
> > This is a prerequisite for making SO_RIGHTS_NOTRUNC settable on all AF_=
UNIX
> > socket types.
> >
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  net/unix/af_unix.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index f7a9d55eee8a..3d256255085b 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -949,7 +949,7 @@ static int unix_setsockopt(struct socket *sock, int=
 level, int optname,
> >         switch (optname) {
> >         case SO_INQ:
> >                 if (sk->sk_type !=3D SOCK_STREAM)
> > -                       return -EINVAL;
> > +                       return -ENOPROTOOPT;
> >
> >                 if (val > 1 || val < 0)
> >                         return -EINVAL;
> > @@ -1005,6 +1005,7 @@ static const struct proto_ops unix_dgram_ops =3D =
{
> >  #endif
> >         .listen =3D       sock_no_listen,
> >         .shutdown =3D     unix_shutdown,
> > +       .setsockopt =3D   unix_setsockopt,
> >         .sendmsg =3D      unix_dgram_sendmsg,
> >         .read_skb =3D     unix_read_skb,
> >         .recvmsg =3D      unix_dgram_recvmsg,
> > @@ -1029,6 +1030,7 @@ static const struct proto_ops unix_seqpacket_ops =
=3D {
> >  #endif
> >         .listen =3D       unix_listen,
> >         .shutdown =3D     unix_shutdown,
> > +       .setsockopt =3D   unix_setsockopt,
> >         .sendmsg =3D      unix_seqpacket_sendmsg,
> >         .recvmsg =3D      unix_seqpacket_recvmsg,
> >         .mmap =3D         sock_no_mmap,
> > @@ -1142,9 +1144,10 @@ static int unix_create(struct net *net, struct s=
ocket *sock, int protocol,
> >         if (protocol && protocol !=3D PF_UNIX)
> >                 return -EPROTONOSUPPORT;
> >
> > +       set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
>=20
> Please move this to unix_create1(), then we don't need the chunk below.
>=20
>=20

I don't understand how this helps. The accept() path gets its struct socket=
 from
sock_alloc() not via unix_create() afaict. Also, unix_create1() is called w=
ith
sock =3D=3D NULL on connect(), so now you have to guard against that too.

But maybe I misunderstand you?

I do agree with you other comment, accept() should probably inherit the tru=
ncate
behavior from the listen() socket.

Thanks,
Jori.
