Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15338DC50
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863796; cv=pass; b=T/pdVNreRodSQV7KLbbe3lW6mdI+tiwbI3aN4zI9Ko0NOzaMc72q37sS7e1Hj1D9/SKQA9y72vC+49Z2of/GYvQqqcpVUTuY0VmXhcG9Rc2ep2/j4nduidl7lwVUsNfy9Qmw+6xY3NVxjj2A5BlAUj48hrHKVyfL1CjF6ysb2do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863796; c=relaxed/simple;
	bh=LF7+JYUCMqsJVubyUU/m/CpnjWFFkBdxSn4kk2Z///U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbIgS4YIkmoU8+GEYf/VV8RT4x2LNjPXtsu5TRSUnhqPCWfsAlSmod3qaS4wbTJimUNQebrkoiMLw7+KdEBDDhTCzl+83CDqca0Bn2TuSFhH76Kl6LuWjhQNi+2gYl6RWnxRTGxsyrksL23GdxEnh97bNyMTNlyEFQ8EQQIjtio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTPv6qNq; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTPv6qNq"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso45223a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 10:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785863780; cv=none;
        d=google.com; s=arc-20260327;
        b=NpRFC0fNXiYvxVRi9+b4KG2FLchdhL0u4KvGgfvpCdJ6W0/Jhjdm0JnSrjeDsdw8jd
         larIIuCT4l9KC0WwxKZehWb0OfufnEs5RGMGkv6iU1mkt8focoVUr3J4K/TFMBEzrsjK
         oKMuTQOGM3AkB+ov+jQKfqc8PMyAED1P4TtbeFa+vAckn452E3oD2JcwfpgSUO2pD0ks
         rUr2MPSfD2JsuN9ljsre6jAwT6kq+a6mlD4kVt2qF/FPiSZyfkuBmBrniEta1yvold3L
         8deYfkd6cgwSQD0vg4bJLZl9ZNA6Rh0ufEDReIkrPOPvDySE8qyckMSRLanYzUJuw9Gs
         nYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CBmg3o5zRRlI21PlSNYstLuxWjLbvI4zhMWhzTM4nt4=;
        fh=H6BTRZdqy+JGX02JmyOY7zm56S6V93Ijb9coivn+gLI=;
        b=ABEVT4v28f0SFwyWzPwxVxBOBaULg/9pWAN0xIhnalRM/JwCJozzRqnYGM+Aym9V9H
         BryozWXXgIrcgbtrng4ycwtQ8Im2jjMUTYhoRMVmHgW0CmATKsfqxni4Of5x0Wiulbyq
         K7lcIAb/MQcfWCt7LyZcXM0jYUgHh1e40Ex47t6H40krwlKYlo4tUi1SeIBNuk0Z3VmF
         gjQ7xoooYGHFJidCo+aUYGjARVXMaGwQ0Q1OGhyBtob+FNjrofE1mbEFNbifeECh0pLW
         K2XBBOVhH6tDSeT26jH4ntHB3KR3RQIijrGgxdgYR4r0lFAMYTjHM6QwbxHrL7RQBv19
         dfpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785863780; x=1786468580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CBmg3o5zRRlI21PlSNYstLuxWjLbvI4zhMWhzTM4nt4=;
        b=pTPv6qNqmMRlGL8AZ/Y/14JeHwhE6waF2n720iVqc3b1cFOvQ6964cKkEjkziOSk6K
         qmKAS2OZ9igfJlbwtuPFO+lBmvIslxLb8iyyZdBYHKHIlRHUZnPPq0mK4wo/vtJx7REH
         yVtaHhJXbWIBEL3CmQtn0TN0w7FL7QMguU8wvel/ZcGGjZMHRSMDIi5y6BL44WCVL/Jd
         Wv4LR4HlEWnzy99BzSTU+ck5SJ2v0Nz9rJjdlsabUs+vKlnc0Ic7briQ88jEpcGa0vzB
         DkiS2x5dfEdvIN+3eSa+TtIQG1Dy3UdKaLHphA8ggYi/Yh+l+RjVXV3E+JlJxesAkZ8W
         6roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863780; x=1786468580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CBmg3o5zRRlI21PlSNYstLuxWjLbvI4zhMWhzTM4nt4=;
        b=IoKUTuA8+7IjQBgNEG37mZOaYQvUCbSFbm+hKYqH2XgdodQTqfFS8rQslKIwgADLfy
         ffZqnIyJYj1apuC08eVK1urQdisM8mY+23sBLbe/paeZIVjCKd6uSY17OOJSsVdQ3Icy
         m1B8bGKUueSDuUNZ4l4x8t6maNo4lE+owK1bYYFoo39kWAVvf4Fo80sPavoCcV1d3UjX
         hL6hcsB/CiCLnmGqYcKpzavmQE+eEKL6ijThHU7qUx2JFWhmAINtt+Od688Frei2mXzx
         THcqfB/y288sERKzZD4et66tqGDNHIcL1/2SF/RNgraTpzR9/9rwzbzdBpT/Xfgtuh7Y
         pSiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqF5oAhEm13KrzabMiEfFdLE+utEKmkn1yuJW62Wm68+XxeUhC5Y99rSwRlbCAf3mugIMGmCna5fUJaYciR@vger.kernel.org
X-Gm-Message-State: AOJu0YygH2hvCy48LlUqyTa9O5B0qR8YDrG03F3gYOKqNPTn0UC6Hb5z
	08/fKmpFuBTTlPevE3fOqa8bLWP6YB7bA9bBKESGyfq7kfv6rg38ttMmmULoovbrLyszWYRJ+1F
	1COLFQbacHTVLvWVhqjSGCELDE9y7MoltjCn4lDMY
X-Gm-Gg: AR+sD101PEs74yZIFmgMQ17V8ev3Kg51vuqpjSk54M+jMlj4TZOqe7+j8sFQRVXOKmd
	LNvVvS3jDtrPgso3mI4YwGeETRYW4RZSyzcNQmGssqiKM6ogirKex9zC2+DeH+jOzYuJ6YTmww4
	dz4GYfLybCZzjesmSajb2S2pk7YrKuebyT40+3KL0YzXDGFcHzHWMPIx3aT1xZ+fVx789w7AYEB
	S5aTfvlEyOI3ZYcJ69Due5d+CF/7fMuD5nKYuVR+/6KSrYWEdt2QoxmiOJX2eLiLHJ4eBAwf81+
	wAOiJP6lHP3rVUBaBtoUfWose2dz+HAaSZsQzYdUfNf4tj0FxzdXqCsgf2NrG0RzyoyiNTsxERS
	1G35rgvkVBESpO+uH8/paXby5+8TgX8W+UffFIlsFf1xSxNnT1Gg2pZxcQgZtJ1HUrCQL4uzh4d
	wZ3Idn4pX4dt4=
X-Received: by 2002:a17:90b:55c7:b0:383:f52b:d616 with SMTP id
 98e67ed59e1d1-3903c592495mr527481a91.10.1785863779555; Tue, 04 Aug 2026
 10:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802151212.3294591-1-jkoolstra@xs4all.nl> <20260802151212.3294591-4-jkoolstra@xs4all.nl>
In-Reply-To: <20260802151212.3294591-4-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 10:16:06 -0700
X-Gm-Features: AUfX_mzrlkWRXfGhh9gUJLOiw_c0m3vTxSo6H_tm_VElR2P5S6SMKo8PVaUgFbc
Message-ID: <CAAVpQUCo0r+DDRJ9BT1_2JYmPcsUNnk6aS+oqPvOrO9ruCPUKw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 8:11=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
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
> and store the LSM errno in the blocked slot. The socket option is
> inherited by the child accept() socket if set on the listen() socket.
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
>  net/unix/af_unix.c                    | 12 ++++++++-
>  10 files changed, 61 insertions(+), 17 deletions(-)
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
> index 51cbf920130d..03ce23a4ebee 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -922,6 +922,7 @@ static bool unix_custom_sockopt(int optname)
>  {
>         switch (optname) {
>         case SO_INQ:
> +       case SO_RIGHTS_NOTRUNC:
>                 return true;
>         default:
>                 return false;
> @@ -957,6 +958,14 @@ static int unix_setsockopt(struct socket *sock, int =
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
> +               break;
> +
>         default:
>                 return -ENOPROTOOPT;
>         }
> @@ -1746,9 +1755,10 @@ static int unix_stream_connect(struct socket *sock=
, struct sockaddr_unsized *uad
>         init_peercred(newsk, &peercred);
>
>         newu =3D unix_sk(newsk);
> +       otheru =3D unix_sk(other);
>         newu->listener =3D other;
> +       newu->scm_rights_notrunc =3D otheru->scm_rights_notrunc;

nit: READ_ONCE() is needed here.



>         RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
> -       otheru =3D unix_sk(other);
>
>         /* copy address information from listening to new sock
>          *
> --
> 2.55.0
>
