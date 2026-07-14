Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E643CEF2
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020983; cv=pass; b=UsV9mVSoieoZD0dTZczlqNDbk/G0poRBwBmiXc4iTlYVWbGwtE5a6KkZKJ21JFfssevh6CxQf9Uw6t/wyRhbVy+mpSO+idCxkpxG6yOBBG0IkRD88AOyjbkK3bGH4l+1mCSOqOTbfrHQDLTZnSt64n0qfWXqdKFKxAPyCsuvaqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020983; c=relaxed/simple;
	bh=kq9BpiaMu64ayuqtT2xYYrv+mWKCPV7p7LohTLRn0uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EA/AC9vzsNWgceAVp5tB32iIG8LzjtK5wP4pMkrkJmCxOnnppPwhwTRcHA0CCnxO/x0x/D/glerT/LJIL8wJjiOKDT0YgWkiYmxanqpJ31wk/ZpWqhnArsRXSICGWwbmntkkTf+jg8X+EP5SFiXB1hDdxYj0UxebUQN3mJi81Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzSaTue5; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzSaTue5"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so3088458a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 02:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784020981; cv=none;
        d=google.com; s=arc-20260327;
        b=ALDgTPNqM6LmNCgBRZFnmQZD/6rG0+cxBUViwBZZS5FWwgi2bwWi1/i7S425LxYRx1
         8ENYkAZDT1ZwtVI08x6FM8H0JB6R1cnOOKEHCoDlfIp8gZMAWEP+leBq8sOqncJcjXZN
         o38yTjk4hwJw39rFHBr5C8QmXovO/b4zuqDT/KFW5BaIIzM5NxLay+Ys8TpUO0mTxyUf
         ZkunDJ+tOBagHHmx2MIUHijQNfsjW49U8RSMfyWC2l2TpcizxjkIhuCFblcEweZ58uya
         zeazdsyKBeEu35l/H0oHjkSoSZPDLP2Q8Uvm6joIUel/4n5Sf+9XgjtB0CFr/jVynLIc
         eDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Ffx1jovQ60HIicFzCljXtq6wI+0UH0XgdbovnzHgcY=;
        fh=Wn56TEd8ELxOqWBYl5F8BEisF5iBwQy7wiph3vhoZdE=;
        b=czophc5cX9XdlFpPBOAy8YaqzOvRc2H6aUcyEe71ZnSFwsPMfG/RQuss2h3JDG4MZO
         KViMJnoMlXIcaITG80g9Z1pt+vR9HWxKjuLpYijTc1Pf9Tst0hcVneOuNIO1Pvkvf+iM
         sIjUee/xxGt7sUSK5u3eOG+SA9q7Jfk+v6XmcPSxihYWoxvheMyIpehYrBM0bZ2Gkwn/
         jXUp9la5PaRfO8UdI4ozay83WVQrIZyeGOrcGlXUV82UzDDlZmWtGMhjQtiWIOLbNvM6
         WIyMBFOoruIpAIJJArVt2Kgk+97Jq3BCm65oLOe+hDQvmPeRu4W/yfiOQRySMIMWnZEE
         LpsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784020981; x=1784625781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Ffx1jovQ60HIicFzCljXtq6wI+0UH0XgdbovnzHgcY=;
        b=VzSaTue5q1OdEkGPxN/ipeKU/lFF53V4ZXD8TE+OKu7OChxvPyklnk5Jn45voSjZal
         ctjolybYJ2uK+J6sQ/C9A3VKcFp3WFIafzh5yjcX7npnn5/uCFORphOvl4Ml0WR8dTon
         YC8iN8Af2Lzjvr9P1KhMhmkssxJORLHfRpiO87FPElC9qmp3qILQKf787F9OrKBub7eQ
         b+P3WCEBXK5rBimkq/CxN9U6GSQJ7ANnsNE9j7O7nSPzIoeuDiDG9+qIohN5dtVUg7Mw
         QpKjo7W268UNug1yeYwqBmG4H0W+eNVtx0EIEQOTdU8XWqOb96PqOHws2HDLWUF3viZs
         dmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020981; x=1784625781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Ffx1jovQ60HIicFzCljXtq6wI+0UH0XgdbovnzHgcY=;
        b=aJm7eHlxPIj45iP3cu8giWaGj8BAh1zH6eid8s83sMRddb09aCKHxAwVL3NYWPLEzu
         iUbRZcvBkRt4KXwzqqkDTbTYajiIdt49Ttq7dSPLJ+NeuYN9NybO6RqVe5DWa4MeDaAB
         EjoQENZlOKUDwUbzQf40iu//QAUD4CWSKMhJHFUMPriMYrV66pN98D6Uf8hootCxZq6p
         XaVlQ/mzPFtB62SDqSGoMwLkRZqheIdpctg0S0Gt0Lw5iZyYSSazEX6rF8fC6/lcShxy
         QBoqVmJ7YcSXN206HMhcGwrCcUXKhe8sBuT/UPkc2MUrQjKt9hezml+WXEngqghdULlr
         w//Q==
X-Forwarded-Encrypted: i=1; AHgh+RoRfbOgOX2g1mNFgsFgmx64QPxHH8jcd2eJO0MTQEke/+5HgsG4U5OfEI9igRmbVrzOjDVOoEZ6sXLDU5BX@vger.kernel.org
X-Gm-Message-State: AOJu0YygG3oXBysJcznBc65Kd8BrjtEEQomNEsOMmupZ9/clcfpy2ogy
	SFtrOUphedGWFL65oHPCry+EQAP5E3Fcrjy8R1yblqKnZU8Z4r82YwIcDtir5RINlWJvFV2IZcy
	0nlBc/LspvzOePSEfBfETbR8Mg19sbAJszA1stG7z
X-Gm-Gg: AfdE7cnAzKAfVLGtiZwnQJQkmj0wfx4DutfmY3/WDbMmCN3jPthF8Rm6d447R7oAx0g
	YYe4z5yH88ZaKXx4PY4ut4HfEAz4q9Im+LOZY7GX/L4/mhZ8/r5z4SKp9CkHM6yJsuOa84Ild56
	Zpo0v7oHDOH/IyaMh4c04ZpiTIYfKthFM37W39D3RFtezxD3Wr7gjV0QbCC8WavJNyks8e560MT
	7mdVcJ8VNlllANTploHiuJZdyHbMyCCtfx9AqbQZJ9TgKXK1vy6znBaJM4tZZWSZDEFp/VKlNbt
	VMdGNjPGLPnwQ/0qh6epw3e8/69dB0Ha5HF7BHRfxuk7sEfkeMQGgp2ZgNVVrYAN7KFi43GAurr
	1MloTJe9ffWI=
X-Received: by 2002:a05:6a20:ef03:b0:3c3:373f:e82f with SMTP id
 adf61e73a8af0-3c3373febc5mr6365502637.8.1784020980740; Tue, 14 Jul 2026
 02:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl> <20260712192958.1631672-4-jkoolstra@xs4all.nl>
In-Reply-To: <20260712192958.1631672-4-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Jul 2026 11:22:47 +0200
X-Gm-Features: AVVi8Cc_JhE7Jh-3tzGwanDA4IvEQcjam1JNFpxbhnHSnWak-LhE8J3Bk2heG4E
Message-ID: <CAAVpQUDMVo2+V+NObF8vuPu0AcO1ZcSLeOWk84czPGgT+8QoyA@mail.gmail.com>
Subject: Re: [net-next v5 3/4] net: af_unix: useful handling of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 9:29=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> highly problematic behaviour, because it leaves the receiver
> wondering what happened. As per man page MSG_CTRUNC is supposed to
> indicate that the control buffer was sized too short, but suddenly
> a permission error might result in the exact same flag being set.
> Moreover, the receiver has no chance to determine how many fds got
> originally sent and how many were suppressed.[1]
>
> Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> handling of LSM denials when receiving SCM_RIGHTS messages: instead of
> truncating the message at the first blocked fd, keep every fd slot
> and store the LSM errno in the blocked slot.
>
> [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm=
-denials-on-scm_rights
>
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  2 ++
>  arch/mips/include/uapi/asm/socket.h   |  2 ++
>  arch/parisc/include/uapi/asm/socket.h |  2 ++
>  arch/sparc/include/uapi/asm/socket.h  |  2 ++
>  include/net/af_unix.h                 |  1 +
>  include/net/scm.h                     | 13 +++------
>  include/uapi/asm-generic/socket.h     |  2 ++
>  net/compat.c                          |  4 +--
>  net/core/scm.c                        | 38 +++++++++++++++++++++++----
>  net/unix/af_unix.c                    |  9 +++++++
>  10 files changed, 59 insertions(+), 16 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/ua=
pi/asm/socket.h
> index 5ef57f88df6b..946a5fad2691 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -155,6 +155,8 @@
>  #define SO_INQ                 84
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      85
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi=
/asm/socket.h
> index 72fb1b006da9..f1641dde135f 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -166,6 +166,8 @@
>  #define SO_INQ                 84
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      85
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/=
uapi/asm/socket.h
> index c16ec36dfee6..f3a3815c7dc2 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -147,6 +147,8 @@
>  #define SO_INQ                 0x4052
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      0x4053
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/ua=
pi/asm/socket.h
> index 71befa109e1c..7907f3b1f0ee 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -148,6 +148,8 @@
>  #define SO_INQ                   0x005d
>  #define SCM_INQ                  SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC        0x005e
> +
>  #if !defined(__KERNEL__)
>
>
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 34f53dde65ce..bb1b3dee02e8 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -49,6 +49,7 @@ struct unix_sock {
>         struct scm_stat         scm_stat;
>         int                     inq_len;
>         bool                    recvmsg_inq;
> +       bool                    scm_rights_notrunc;
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>         struct sk_buff          *oob_skb;
>  #endif
> diff --git a/include/net/scm.h b/include/net/scm.h
> index c52519669349..86ae6bc109ec 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -50,8 +50,8 @@ struct scm_cookie {
>  #endif
>  };
>
> -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
> -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
> +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool not=
runc);
> +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, b=
ool notrunc);
>  int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cooki=
e *scm);
>  void __scm_destroy(struct scm_cookie *scm);
>  struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
> @@ -107,13 +107,8 @@ void scm_recv(struct socket *sock, struct msghdr *ms=
g,
>  void scm_recv_unix(struct socket *sock, struct msghdr *msg,
>                    struct scm_cookie *scm, int flags);
>
> -static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
> -                                 unsigned int flags)
> -{
> -       if (!ufd)
> -               return -EFAULT;
> -       return receive_fd(f, ufd, flags);
> -}
> +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> +                   bool notrunc);
>
>  #endif /* __LINUX_NET_SCM_H */
>
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic=
/socket.h
> index 53b5a8c002b1..84ea7b92936e 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -150,6 +150,8 @@
>  #define SO_INQ                 84
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      85
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
> diff --git a/net/compat.c b/net/compat.c
> index d68cf9c3aad5..6bdf4a2c9077 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -286,7 +286,7 @@ static int scm_max_fds_compat(struct msghdr *msg)
>         return (msg->msg_controllen - sizeof(struct compat_cmsghdr)) / si=
zeof(int);
>  }
>
> -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
> +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, b=
ool notrunc)
>  {
>         struct compat_cmsghdr __user *cm =3D
>                 (struct compat_cmsghdr __user *)msg->msg_control_user;
> @@ -296,7 +296,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct=
 scm_cookie *scm)
>         int err =3D 0, i;
>
>         for (i =3D 0; i < fdmax; i++) {
> -               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags);
> +               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags, notrunc);
>                 if (err < 0)
>                         break;
>         }
> diff --git a/net/core/scm.c b/net/core/scm.c
> index a73b1eb30fd2..f0d44ecdb11f 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -351,7 +351,31 @@ static int scm_max_fds(struct msghdr *msg)
>         return (msg->msg_controllen - sizeof(struct cmsghdr)) / sizeof(in=
t);
>  }
>
> -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
> +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> +                   bool notrunc)
> +{
> +       int error;
> +
> +       if (!ufd)
> +               return -EFAULT;
> +
> +       error =3D security_file_receive(f);
> +       if (error)
> +               return notrunc ? put_user(error, ufd) : error;
> +
> +       FD_PREPARE(fdf, flags, get_file(f));
> +       if (fdf.err)
> +               return fdf.err;
> +
> +       error =3D put_user(fd_prepare_fd(fdf), ufd);
> +       if (error)
> +               return error;
> +
> +       __receive_sock(fd_prepare_file(fdf));
> +       return fd_publish(fdf);
> +}
> +
> +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool not=
runc)
>  {
>         struct cmsghdr __user *cm =3D
>                 (__force struct cmsghdr __user *)msg->msg_control_user;
> @@ -365,12 +389,12 @@ void scm_detach_fds(struct msghdr *msg, struct scm_=
cookie *scm)
>                 return;
>
>         if (msg->msg_flags & MSG_CMSG_COMPAT) {
> -               scm_detach_fds_compat(msg, scm);
> +               scm_detach_fds_compat(msg, scm, notrunc);
>                 return;
>         }
>
>         for (i =3D 0; i < fdmax; i++) {
> -               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags);
> +               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags, notrunc);
>                 if (err < 0)
>                         break;
>         }
> @@ -542,8 +566,12 @@ void scm_recv_unix(struct socket *sock, struct msghd=
r *msg,
>         if (!__scm_recv_common(sock->sk, msg, scm, flags))
>                 return;
>
> -       if (scm->fp)
> -               scm_detach_fds(msg, scm);
> +       if (scm->fp) {
> +               struct unix_sock *u;
> +
> +               u =3D unix_sk(sock->sk);
> +               scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc)=
);
> +       }
>
>         if (sock->sk->sk_scm_pidfd)
>                 scm_pidfd_recv(msg, scm);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 3d256255085b..e7b3aab2f176 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -921,6 +921,7 @@ static bool unix_custom_sockopt(int optname)
>  {
>         switch (optname) {
>         case SO_INQ:
> +       case SO_RIGHTS_NOTRUNC:
>                 return true;
>         default:
>                 return false;
> @@ -956,6 +957,14 @@ static int unix_setsockopt(struct socket *sock, int =
level, int optname,
>
>                 WRITE_ONCE(u->recvmsg_inq, val);
>                 break;
> +
> +       case SO_RIGHTS_NOTRUNC:
> +               if (val > 1 || val < 0)
> +                       return -EINVAL;
> +
> +               WRITE_ONCE(u->scm_rights_notrunc, val);

This should be inherited to the child sock, after setting newu->listener
in unix_stream_connect().


> +               break;
> +
>         default:
>                 return -ENOPROTOOPT;
>         }
> --
> 2.55.0
>
