Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1F9390C9A
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436900; cv=pass; b=HBCrGxHENuDGeZK4OOx/dpb3F2XLjPoD70xEOmJ4vkb5NJPDcGOAsQBDBxfGGukthiGzMOVe8W52aPyFREeRWnjH+ot/ohREx/04WwQ197LDWStEzujoS+DgsbIefK98Ch10GWBQkou2Duc+FhE4R18wBZsvsMkz2uaEczvmqLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436900; c=relaxed/simple;
	bh=Cr6SoVqAwbWoJGp6FUtdV4Ua2x9X0CDVbp/am3cRH2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9435r2+PxgNIHLOa4dKMLwqDw2IB7JBuA6Neoz4Fuszooe4qnHCQR1JmhjH7uj9XpQVvT9+7L1+K6Gi1ZhwMhz6qJAPPxOZWRJeqZi/yRt3+lkAa58JFFloRxr9YMxdhgSf/XpfjGIZY26Jh+YFjzEJ95SL27wc9A193KHOKxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XyueVyI1; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyueVyI1"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so221182a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 11:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785436896; cv=none;
        d=google.com; s=arc-20260327;
        b=nMpOayLB+Oy/k28UHZ9lnoXzfVrGModV3oeAoUZ4xQNI83J2+085Ay7S3gPPdpHPg1
         6mkiR3Dw6qP9zlvZjJEcPXfw8GllP17bX5DPAImiteZ7q+uj9g+78ej/0wsL2gTb4wzB
         y7ndH9A8sw7C9jhI73vUPP4MJGE8fZtDUrLaCT9EdZia8g9+oSqViMk2gmKY9SQvN7Ba
         OXUih1DBg2nq9mvcjhPE5zD8DgpYl4YhfcqT9FASmfqpO75DmweU2AR1iFcLM/GE7m3d
         3JJHbM9rjPuwaFTXJYZWrooncnqC6Fa5b3kE7MSP2O+BIkESKQrqdhBsvkjy3iOX3rU4
         n5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SkoxyqZ2p2t6MX7nGCw2wXd+CLpsvZAqcArxWBtQlHM=;
        fh=fosErmhf/EBJRiALvu8hQQ18CFSUm42hjnULD61n8Hg=;
        b=qQHW09n+RRs7rg7XWXoRhIbkrec0fEPnBvQz5VBKvmSBi7RJGNMiTE/QE91p2uh+9M
         76vF5hhng3TyD5PlzpJSt0Q15ioSmCh3SaghzHgtRdXevLJrHcwtHnxZsPHtPi/VPVXZ
         8IuEtfRuC51MqOYmTAdHWfGJHLviIYWJGQy5fnWrl58u2tkFe4RfZWtNqOrrwwCGINTs
         WKSF/qNIx/F3f9ua+PEbTNLSynWPJ5m8ib1fSHrAi7I0fqTCJ4NX9+Bp9ElYQaIYKZ6s
         w8Z8N0DeGOXkZOli9Bh2mISUbxhdJyawEN5Xw93nWUt845i3qHsJOLBrrrA2g9gMV/6T
         glBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785436896; x=1786041696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SkoxyqZ2p2t6MX7nGCw2wXd+CLpsvZAqcArxWBtQlHM=;
        b=XyueVyI14BDW57L5ccEhV3XMf4gU7vi4gtl7wsFmu7LDzaAcZ99JBTVEAuoPkNH3V7
         C2VBeloD3CE9/dLSq4FSFbKB7tgX9A7eE+P6d3/SD6BEiahJVMlbKGgXq/5nYohxrTnp
         HvHxRNF2HTePJ/UQ0afdJmN2775edYjFwUErFwhOwvzNLUD92dLcvC5PAGFZpuIoBFn+
         jZX94e/uoQG0NxksKdEKXpU6VMWkwaanWNMxR2yVtU1uc20PmVmHA0Y+DYl8Z42LofEq
         RBjo2EvFyTFH9rUbVmmFxAC6q4lFhhkmrSl19lgSl1gGqjM4V98Nvjt9I7CXeSwH6B2m
         vdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436896; x=1786041696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SkoxyqZ2p2t6MX7nGCw2wXd+CLpsvZAqcArxWBtQlHM=;
        b=qc7n2NQOJoUyyH+aMyB69v+dRDb+XBNfbAJBLY4QCDFyLNveNAc21KT+4KLEcz15AQ
         m0OQg9wOhLwutyzE3RqnhXTdWPMoIaRMr0nsRonEmJUPydH1gq9VMWQOjwpCmnWdwOtv
         OX4LD6sFz711v2zmwesDrTPUE5/3SXx2hRON8URzJK8YztrxTLabuVHSwlFpsvhwuUHw
         8e0uX4Z6m9BU5CQENOMlt4wGnWA5+DfClPFR+oqFvzYXxEhXAnzQXocuxLD2cCZI2rwd
         g4C20dbxUHY4Bj0K7OLl/+m4AYlCOP46wg0eK7uA2eVI2XDNPl7qK5vtB6/8a/hU+Xyv
         n5pg==
X-Forwarded-Encrypted: i=1; AHgh+Rqana9W5SRr3X33iMlqdwUUtrU6tiwqzBUo9FBHzsVMvgQBm5N/ucPI6chANQcKVcm65vAUT8yFBfK8Nrqw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6+wqe3aAJP62lyD5miWMu5DdpjFpZjiWisfkFGvhvp+OpZIX
	bYMw/+CsZEJ2nPeC3rgbCDSCiZbRInL5yrEgDjASKHA1q2dnGeURXv2LzDZG+oLagMM3DhddweJ
	reIs8HmakbVOentXK9cOcwuSwrhSkPEumr8mUQtys
X-Gm-Gg: AR+sD10XNpZsnUUuqci+yoq6E+wu0q/TTtFrTmzd+GgHMnVPIQTS9g7AeToby+O5ITF
	3WoaBbec8cPadpJ2dDhSlyvxECLRQdW8GhrYjkZ9mwYdknT0Kmmsqtm2+9bsHvPR4UGHt7qPgFY
	kt6TdRPnqUUBsED6UeeLFVMwdNHbZNajXiRTYeMJUpoznp04uA/DqzKkaxJtEfpjNLxAAYSEgKf
	CRWmds6yAAbRN7roEum3+rv2SxpPuIVnyhRzaRpp8bSFn1kj6p3km1VsvEnyRuJvwaHGnH2gm/I
	E0MbvejGS2/jAl4NR5hxYTJZe8jhD9U6B6Ky+zc/gwkjClvhAHNvkfdcViCAbflfU4WsZoD1jKs
	p42p2pHxbfCVFXnRVsWkr8BAMDNLDG3yFL6CYbp7EL12qtLsqr0hLsdE7JQ==
X-Received: by 2002:a17:90b:2c88:b0:38e:2c8f:a01a with SMTP id
 98e67ed59e1d1-38f9bda173amr3196062a91.11.1785436895411; Thu, 30 Jul 2026
 11:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl> <20260712192958.1631672-2-jkoolstra@xs4all.nl>
 <CAAVpQUCD27YphUQ=aL3PyPtWwTo0tEtaFt-hvyoyCnepGAmYCQ@mail.gmail.com>
 <2048838556.1496380.1784464286664@kpc.webmail.kpnmail.nl> <64825400.394146.1785247552949@kpc.webmail.kpnmail.nl>
In-Reply-To: <64825400.394146.1785247552949@kpc.webmail.kpnmail.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Jul 2026 20:41:21 +0200
X-Gm-Features: AUfX_myDaFrtN39vm4RE1HtRDrhRWnMGXyf5-hg5kxSxtlkZvyA8zSGnbs1K5ho
Message-ID: <CAAVpQUCxyR3VDtkJQxG4HQF5HGzo-g=oG1rpKW8hCGUgVobBtQ@mail.gmail.com>
Subject: Re: [net-next v5 1/4] net: af_unix: enable custom setsockopt for all
 socket types
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 4:05=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> @Kuniyuki,
>
> Could you take a look at this if you have time? Would like to move this
> along if we can.

Sorry for the delay, I was on vacation for two weeks.

>
> Thanks,
> Jori.
>
> > Op 19-07-2026 14:31 CEST schreef Jori Koolstra <jkoolstra@xs4all.nl>:
> >
> >
> > > Op 14-07-2026 11:19 CEST schreef Kuniyuki Iwashima <kuniyu@google.com=
>:
> > >
> > >
> > > On Sun, Jul 12, 2026 at 9:29=E2=80=AFPM Jori Koolstra <jkoolstra@xs4a=
ll.nl> wrote:
> > > >
> > > > unix_setsockopt() and the SOCK_CUSTOM_SOCKOPT flag were only wired =
up
> > > > for SOCK_STREAM (introduced along with the stream-only SO_INQ).
> > > > Consequently custom AF_UNIX options are unreachable on SOCK_DGRAM a=
nd
> > > > SOCK_SEQPACKET: those setsockopt() calls bypass unix_setsockopt() a=
nd
> > > > fall through to the generic sock_setsockopt(), failing with
> > > > -ENOPROTOOPT.
> > > >
> > > > Set SOCK_CUSTOM_SOCKOPT for every AF_UNIX socket type in unix_creat=
e(), and
> > > > also for accepted sockets in unix_accept() (reachable for stream an=
d
> > > > seqpacket).
> > > >
> > > > This is a prerequisite for making SO_RIGHTS_NOTRUNC settable on all=
 AF_UNIX
> > > > socket types.
> > > >
> > > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > > > ---
> > > >  net/unix/af_unix.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > > index f7a9d55eee8a..3d256255085b 100644
> > > > --- a/net/unix/af_unix.c
> > > > +++ b/net/unix/af_unix.c
> > > > @@ -949,7 +949,7 @@ static int unix_setsockopt(struct socket *sock,=
 int level, int optname,
> > > >         switch (optname) {
> > > >         case SO_INQ:
> > > >                 if (sk->sk_type !=3D SOCK_STREAM)
> > > > -                       return -EINVAL;
> > > > +                       return -ENOPROTOOPT;
> > > >
> > > >                 if (val > 1 || val < 0)
> > > >                         return -EINVAL;
> > > > @@ -1005,6 +1005,7 @@ static const struct proto_ops unix_dgram_ops =
=3D {
> > > >  #endif
> > > >         .listen =3D       sock_no_listen,
> > > >         .shutdown =3D     unix_shutdown,
> > > > +       .setsockopt =3D   unix_setsockopt,
> > > >         .sendmsg =3D      unix_dgram_sendmsg,
> > > >         .read_skb =3D     unix_read_skb,
> > > >         .recvmsg =3D      unix_dgram_recvmsg,
> > > > @@ -1029,6 +1030,7 @@ static const struct proto_ops unix_seqpacket_=
ops =3D {
> > > >  #endif
> > > >         .listen =3D       unix_listen,
> > > >         .shutdown =3D     unix_shutdown,
> > > > +       .setsockopt =3D   unix_setsockopt,
> > > >         .sendmsg =3D      unix_seqpacket_sendmsg,
> > > >         .recvmsg =3D      unix_seqpacket_recvmsg,
> > > >         .mmap =3D         sock_no_mmap,
> > > > @@ -1142,9 +1144,10 @@ static int unix_create(struct net *net, stru=
ct socket *sock, int protocol,
> > > >         if (protocol && protocol !=3D PF_UNIX)
> > > >                 return -EPROTONOSUPPORT;
> > > >
> > > > +       set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
> > >
> > > Please move this to unix_create1(), then we don't need the chunk belo=
w.
> > >
> > >
> >
> > I don't understand how this helps. The accept() path gets its struct so=
cket from
> > sock_alloc() not via unix_create() afaict. Also, unix_create1() is call=
ed with
> > sock =3D=3D NULL on connect(), so now you have to guard against that to=
o.

It seems I misread sk/sock.  Please keep set_bit() as is.

Thanks !

> >
> > But maybe I misunderstand you?
> >
> > I do agree with you other comment, accept() should probably inherit the=
 truncate
> > behavior from the listen() socket.
> >
> > Thanks,
> > Jori.
