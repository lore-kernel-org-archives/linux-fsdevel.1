Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B23FF1B4
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924566; cv=none; b=WuVEovG+vLqfJFSlY4HvphZXO4m/hzWzOtWiS8MHyrEIC+4rfEvwD80BqO+JqdWcr73+gko9h3HGNazToxSjb1fN6acwnukxesJc6Z+Lz/IVKRm1X5MGf1CPtYLzg84GAtHv+q8FSXzVxzQvAwYmwmjfSxoCTy5MAfO/BRqty+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924566; c=relaxed/simple;
	bh=HkeWm/OI+CbpQ+KTRzZZkwccU342neeWKjPDT1qbgT4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fbezI7V9m8li6MuogFxg/DPUSeOVRHClWmemZev2flJ6ov9QE11wYgAQ1r1tII2zv8/YFuwTnx9ypMvGrTfVi8mjoBtmmCcvAoJZqV/M2VEbj8BMBp1sNo+3cM6IMDe02/F8dASLh8o4yryJY4ncQE58TGdMKFYL0brfZ4P6Mlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=pzOBKzuF; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="pzOBKzuF"
X-KPN-MessageId: b4ebf1c0-90b5-11f1-bfbb-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b4ebf1c0-90b5-11f1-bfbb-00505699b430;
	Wed, 05 Aug 2026 12:09:12 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id b4eaf8c0-90b5-11f1-91d4-00505699891e;
	Wed, 05 Aug 2026 12:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=jdV4cshdM2xxKeG/1zJGcdAfUiFdpyqmALwEPM0tqKs=;
	b=pzOBKzuFEDO1hzEtScEGDtFXyf1Rg5716Gfz7BeJn6dzwcqtfG1U7wIQ20j8UK2ge97u6qdYWf/Xk
	 f+KQuXLqoIDMN686G+/IhtofwBYUNwoOvwhuN82CBGprm77vQctWAr6uqwGBUWi4dYIfGApDaaPZNi
	 5dtS0tWCWl15dTrBdc7BQvbBcLBydvSI7zBwnaKEbXtHIVyEdgknTTNt3rvxzbRGJ6H+PWFxZSYEJI
	 CeGkyUNsW8PAX7ZyyEu+DrqJGEIixBnEW2jRUSmJdEU+OqKNZBctXqlyi6DNf2ufin5QIqWI79M8Nk
	 KdYTl1WADPGa3LH59aMYIEJtTOFP2Jw==
X-KPN-MID: 33|DsUKKhFEbxLM4O7+ivm6ryffxHBVm6n+PjK8UsYbQBDRQcNO5LeHBOZkWRqzaJm
 qZ2+meRFP5VXnl2mgUyv8kRBxsXLqWQZp/FV4Px28vRU=
X-CMASSUN: 33|q8zbj9pwCYjAPDEnA/pALcy63n22bmc8fBTFIT2fcx/5rqSE0abahhLCEG6VNG/
 HEpA7VUDfnmEpr4WVLNuIwA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id b4d43af8-90b5-11f1-916a-005056995d6c;
	Wed, 05 Aug 2026 12:09:12 +0200 (CEST)
Date: Wed, 5 Aug 2026 12:09:12 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <728282285.265641.1785924552245@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAAVpQUCo0r+DDRJ9BT1_2JYmPcsUNnk6aS+oqPvOrO9ruCPUKw@mail.gmail.com>
References: <20260802151212.3294591-1-jkoolstra@xs4all.nl>
 <20260802151212.3294591-4-jkoolstra@xs4all.nl>
 <CAAVpQUCo0r+DDRJ9BT1_2JYmPcsUNnk6aS+oqPvOrO9ruCPUKw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
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


> Op 04-08-2026 19:16 CEST schreef Kuniyuki Iwashima <kuniyu@google.com>:
>=20
> =20
> On Sun, Aug 2, 2026 at 8:11=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl=
> wrote:
> >
> > Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> > receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> > that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> > highly problematic behaviour, because it leaves the receiver
> > wondering what happened. As per man page MSG_CTRUNC is supposed to
> > indicate that the control buffer was sized too short, but suddenly
> > a permission error might result in the exact same flag being set.
> > Moreover, the receiver has no chance to determine how many fds got
> > originally sent and how many were suppressed.[1]
> >
> > Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> > handling of LSM denials when receiving SCM_RIGHTS messages: instead of
> > truncating the message at the first blocked fd, keep every fd slot
> > and store the LSM errno in the blocked slot. The socket option is
> > inherited by the child accept() socket if set on the listen() socket.
> >
> > [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-l=
sm-denials-on-scm_rights
> >
> > Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  arch/alpha/include/uapi/asm/socket.h  |  2 ++
> >  arch/mips/include/uapi/asm/socket.h   |  2 ++
> >  arch/parisc/include/uapi/asm/socket.h |  2 ++
> >  arch/sparc/include/uapi/asm/socket.h  |  2 ++
> >  include/net/af_unix.h                 |  1 +
> >  include/net/scm.h                     | 13 +++------
> >  include/uapi/asm-generic/socket.h     |  2 ++
> >  net/compat.c                          |  4 +--
> >  net/core/scm.c                        | 38 +++++++++++++++++++++++----
> >  net/unix/af_unix.c                    | 12 ++++++++-
> >  10 files changed, 61 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/=
uapi/asm/socket.h
> > index 5ef57f88df6b..946a5fad2691 100644
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -155,6 +155,8 @@
> >  #define SO_INQ                 84
> >  #define SCM_INQ                        SO_INQ
> >
> > +#define SO_RIGHTS_NOTRUNC      85
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64
> > diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/ua=
pi/asm/socket.h
> > index 72fb1b006da9..f1641dde135f 100644
> > --- a/arch/mips/include/uapi/asm/socket.h
> > +++ b/arch/mips/include/uapi/asm/socket.h
> > @@ -166,6 +166,8 @@
> >  #define SO_INQ                 84
> >  #define SCM_INQ                        SO_INQ
> >
> > +#define SO_RIGHTS_NOTRUNC      85
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64
> > diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/includ=
e/uapi/asm/socket.h
> > index c16ec36dfee6..f3a3815c7dc2 100644
> > --- a/arch/parisc/include/uapi/asm/socket.h
> > +++ b/arch/parisc/include/uapi/asm/socket.h
> > @@ -147,6 +147,8 @@
> >  #define SO_INQ                 0x4052
> >  #define SCM_INQ                        SO_INQ
> >
> > +#define SO_RIGHTS_NOTRUNC      0x4053
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64
> > diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/=
uapi/asm/socket.h
> > index 71befa109e1c..7907f3b1f0ee 100644
> > --- a/arch/sparc/include/uapi/asm/socket.h
> > +++ b/arch/sparc/include/uapi/asm/socket.h
> > @@ -148,6 +148,8 @@
> >  #define SO_INQ                   0x005d
> >  #define SCM_INQ                  SO_INQ
> >
> > +#define SO_RIGHTS_NOTRUNC        0x005e
> > +
> >  #if !defined(__KERNEL__)
> >
> >
> > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > index 34f53dde65ce..bb1b3dee02e8 100644
> > --- a/include/net/af_unix.h
> > +++ b/include/net/af_unix.h
> > @@ -49,6 +49,7 @@ struct unix_sock {
> >         struct scm_stat         scm_stat;
> >         int                     inq_len;
> >         bool                    recvmsg_inq;
> > +       bool                    scm_rights_notrunc;
> >  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> >         struct sk_buff          *oob_skb;
> >  #endif
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index c52519669349..86ae6bc109ec 100644
> > --- a/include/net/scm.h
> > +++ b/include/net/scm.h
> > @@ -50,8 +50,8 @@ struct scm_cookie {
> >  #endif
> >  };
> >
> > -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
> > -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)=
;
> > +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool n=
otrunc);
> > +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm,=
 bool notrunc);
> >  int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_coo=
kie *scm);
> >  void __scm_destroy(struct scm_cookie *scm);
> >  struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
> > @@ -107,13 +107,8 @@ void scm_recv(struct socket *sock, struct msghdr *=
msg,
> >  void scm_recv_unix(struct socket *sock, struct msghdr *msg,
> >                    struct scm_cookie *scm, int flags);
> >
> > -static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
> > -                                 unsigned int flags)
> > -{
> > -       if (!ufd)
> > -               return -EFAULT;
> > -       return receive_fd(f, ufd, flags);
> > -}
> > +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flag=
s,
> > +                   bool notrunc);
> >
> >  #endif /* __LINUX_NET_SCM_H */
> >
> > diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-gener=
ic/socket.h
> > index 53b5a8c002b1..84ea7b92936e 100644
> > --- a/include/uapi/asm-generic/socket.h
> > +++ b/include/uapi/asm-generic/socket.h
> > @@ -150,6 +150,8 @@
> >  #define SO_INQ                 84
> >  #define SCM_INQ                        SO_INQ
> >
> > +#define SO_RIGHTS_NOTRUNC      85
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP=
32__))
> > diff --git a/net/compat.c b/net/compat.c
> > index d68cf9c3aad5..6bdf4a2c9077 100644
> > --- a/net/compat.c
> > +++ b/net/compat.c
> > @@ -286,7 +286,7 @@ static int scm_max_fds_compat(struct msghdr *msg)
> >         return (msg->msg_controllen - sizeof(struct compat_cmsghdr)) / =
sizeof(int);
> >  }
> >
> > -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
> > +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm,=
 bool notrunc)
> >  {
> >         struct compat_cmsghdr __user *cm =3D
> >                 (struct compat_cmsghdr __user *)msg->msg_control_user;
> > @@ -296,7 +296,7 @@ void scm_detach_fds_compat(struct msghdr *msg, stru=
ct scm_cookie *scm)
> >         int err =3D 0, i;
> >
> >         for (i =3D 0; i < fdmax; i++) {
> > -               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, =
o_flags);
> > +               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, =
o_flags, notrunc);
> >                 if (err < 0)
> >                         break;
> >         }
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index a73b1eb30fd2..f0d44ecdb11f 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -351,7 +351,31 @@ static int scm_max_fds(struct msghdr *msg)
> >         return (msg->msg_controllen - sizeof(struct cmsghdr)) / sizeof(=
int);
> >  }
> >
> > -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
> > +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flag=
s,
> > +                   bool notrunc)
> > +{
> > +       int error;
> > +
> > +       if (!ufd)
> > +               return -EFAULT;
> > +
> > +       error =3D security_file_receive(f);
> > +       if (error)
> > +               return notrunc ? put_user(error, ufd) : error;
> > +
> > +       FD_PREPARE(fdf, flags, get_file(f));
> > +       if (fdf.err)
> > +               return fdf.err;
> > +
> > +       error =3D put_user(fd_prepare_fd(fdf), ufd);
> > +       if (error)
> > +               return error;
> > +
> > +       __receive_sock(fd_prepare_file(fdf));
> > +       return fd_publish(fdf);
> > +}
> > +
> > +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool n=
otrunc)
> >  {
> >         struct cmsghdr __user *cm =3D
> >                 (__force struct cmsghdr __user *)msg->msg_control_user;
> > @@ -365,12 +389,12 @@ void scm_detach_fds(struct msghdr *msg, struct sc=
m_cookie *scm)
> >                 return;
> >
> >         if (msg->msg_flags & MSG_CMSG_COMPAT) {
> > -               scm_detach_fds_compat(msg, scm);
> > +               scm_detach_fds_compat(msg, scm, notrunc);
> >                 return;
> >         }
> >
> >         for (i =3D 0; i < fdmax; i++) {
> > -               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, =
o_flags);
> > +               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, =
o_flags, notrunc);
> >                 if (err < 0)
> >                         break;
> >         }
> > @@ -542,8 +566,12 @@ void scm_recv_unix(struct socket *sock, struct msg=
hdr *msg,
> >         if (!__scm_recv_common(sock->sk, msg, scm, flags))
> >                 return;
> >
> > -       if (scm->fp)
> > -               scm_detach_fds(msg, scm);
> > +       if (scm->fp) {
> > +               struct unix_sock *u;
> > +
> > +               u =3D unix_sk(sock->sk);
> > +               scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrun=
c));
> > +       }
> >
> >         if (sock->sk->sk_scm_pidfd)
> >                 scm_pidfd_recv(msg, scm);
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 51cbf920130d..03ce23a4ebee 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -922,6 +922,7 @@ static bool unix_custom_sockopt(int optname)
> >  {
> >         switch (optname) {
> >         case SO_INQ:
> > +       case SO_RIGHTS_NOTRUNC:
> >                 return true;
> >         default:
> >                 return false;
> > @@ -957,6 +958,14 @@ static int unix_setsockopt(struct socket *sock, in=
t level, int optname,
> >
> >                 WRITE_ONCE(u->recvmsg_inq, val);
> >                 break;
> > +
> > +       case SO_RIGHTS_NOTRUNC:
> > +               if (val > 1 || val < 0)
> > +                       return -EINVAL;
> > +
> > +               WRITE_ONCE(u->scm_rights_notrunc, val);
> > +               break;
> > +
> >         default:
> >                 return -ENOPROTOOPT;
> >         }
> > @@ -1746,9 +1755,10 @@ static int unix_stream_connect(struct socket *so=
ck, struct sockaddr_unsized *uad
> >         init_peercred(newsk, &peercred);
> >
> >         newu =3D unix_sk(newsk);
> > +       otheru =3D unix_sk(other);
> >         newu->listener =3D other;
> > +       newu->scm_rights_notrunc =3D otheru->scm_rights_notrunc;
>=20
> nit: READ_ONCE() is needed here.
>=20

Yeah, I was thinking whether to add that or not. We have

=09newsk->sk_scm_recv_flags =3D other->sk_scm_recv_flags;

earlier, so without READ_ONCE(), and earlier there is

=09unix_state_lock(other);

which should make this assignment safe. However, that does not protect nece=
ssarily
against compiler mangling. Then again, we are reading a bool here, so isn't=
 this
a theoretical concern mostly?

I am happy to change it though (if only to signal intent), but then the acc=
ess to
sk_scm_recv_flags should also be READ_ONCE(), I believe, or it will be need=
lessly
confusing why it is there for one access but not the other.

Thanks,
Jori.

>=20
>=20
> >         RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
> > -       otheru =3D unix_sk(other);
> >
> >         /* copy address information from listening to new sock
> >          *
> > --
> > 2.55.0
> >
