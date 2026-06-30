Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34B83C415F
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837845; cv=pass; b=HO9XLihEjrl4XSTlbbXa7HPnrw7NOT2vZ8ZBPaBF/eLsmGShJxyXMMCCV0hmiLSOxRMpWE60ZjRoWxHIrGhWCBpR8E9LT1AO5KqstF/JzQJeHCklO1HLd1Vzd6rf806aeN0wT3utgQ0S5nt5SXhMsqIypzQKMfsN0/776IAQw+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837845; c=relaxed/simple;
	bh=v/OcWx3LYLBx0KlspHhgb4R6jpCaa2+fiCx8LKjOQhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/2M67MWL3aDRWXXISztR5GUC0CoCr91V2ayCM7N7hfRgYmmVVrLG6BcamVFlQHhVrO4KmMRlcg0zGCl5xVctEloSKrF1cl0m65YFS5q1/URWP1o6CzdsvhgLMRTKGO4z407PwS9emWfUD5Yq7AfgGgFyVkPms8sTv1XJ3mLPpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NypgtcyR; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NypgtcyR"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1384ebe7a10so8491356c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 09:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782837843; cv=none;
        d=google.com; s=arc-20260327;
        b=izMNQvhe3sE5SAqrAYrgSjqxJbanj/7zT/MtU7rNjxohJZbf27O0TFw4UQ1inXLILY
         dG2XJibzpLJt2Vp0lJzHcF3Ca9h5TJ9xcvlPc58AQvkzt4hrnAzEwQ1lh09x4DmM2lRV
         Xhkh3ERKfEbdUVLA4tjEc3+MR3gjKykIQc+QIL7IzNRIeJAtk/wOGVoES/J6RShFeN+k
         yVeQgjcHJDWWnJBXEVMQO++aWQ9bHCXg7vXQ1XQyigBP2Ak+80EdZ72yqJYhPyDRvQAF
         YDcUQ8NDLTfsJ5pNjxvKC/Uiu/nbjekgg1db+Jdt53MBgI0Lg1vKez1MunqbRV7ZHPmc
         COYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=603x+vbEytdZ550OAdNYJC+Z9vxOv/z6ypcG3r0EpNE=;
        fh=k+oV9+outENiC150gEIwCJ9aOb3F0eDCDKBJKEGWdVE=;
        b=Ea0TM0bFSiYo7RuUSdiM/74MDV8pJdbSHJVpHv1qFrHzx89Zy3ZGvF7fXRyG7yOUr7
         PvNXrSvgu2KcRy3sFw7vt+pH8nGUjctso6lQ6j+dsk8PGabQUS6NeaP9VVKdCPYNqw+y
         K3a6ExiLkPC0L/lC03x2muBQeR2Xh/P9DV3uIl2qtOVLLVgz0/rk7R/jXsotqIVl1EhS
         2l02QZ/dY1QzHF/+H+/vFb0rUJIuFi9r5TjnJsztYpbUdmblYKYx4T2L9NQ4glDC3zEo
         5AEXwjTxMI0TKs8HGbq9vdob0R5tLhBv6Tb5NljF+tZ+j0MmBrITYupZ4GdFdctNy5Hw
         uzbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782837843; x=1783442643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=603x+vbEytdZ550OAdNYJC+Z9vxOv/z6ypcG3r0EpNE=;
        b=NypgtcyRac1p+m/Q+Rzoe9y2EBHtO02VxKrCpbLnh7jrpbVCLR+nWqrrjXQJp8Rwxy
         GZT7XqtJ5KgzVVmExnJYW9xCwm2q76sKXMJ02OI/msDuiI6B6y0H+/KhQNWRVA/iJgW2
         Ovo0BF+hs16iKmcebuphhYntq7qoMGDEEocmMlYz+59LljkKnARA//FqKDvUk1ijhygN
         Plz/sqAj2lkhxtdGwMe9T/4FlxV7jnJIbOexykr++UCv69CesvLslaZ7IHOV+JEIoJQj
         aTGCoNeTQCkD2CMqhOOMem5uM2DJyJPpTsbvA9ioVhzgsgg6srzA/qQRsBKV9+mtmuFl
         0XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837843; x=1783442643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=603x+vbEytdZ550OAdNYJC+Z9vxOv/z6ypcG3r0EpNE=;
        b=oAhQYU2Ci3l7yJuVHsx6Vdh/x005WzDN0SAoByd3E/YsuyvOJJ4uU3Hs76ONdJFfYW
         VuzjdvaJgzmkuII/vhR7/PS+g4ew66MqJz1yPweWBcn38iV/HQO7e/A3MxB8odbbcAUY
         Zy7DHKAHFKu5Tn4T+2AeERkqyCoIgTd844Mu92uWNn+GtoE/Lp3gXBuFDsTHPs9WicCz
         3rmXj5rKKTK4yZcY8r7Sd0/3kfRclofKZxhml9EZ3EIo0oAoNElg9vEJUz1tHLdDBsL4
         yF6rAcm1zyEuvZ6DqHZSJTo7arxetXmPe9zF7IjBsqFlWfe/uQgo000egWNk+xLHkFfn
         r72Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ItMFZRX/FeEI+fxRFkfn2uDfeqV3tS0iIesFQk847Qc9k2pHEhJ/Avg4jdewGjsvo23ytueIr7cM9vZmw@vger.kernel.org
X-Gm-Message-State: AOJu0YwpdyU6t2W9PtC7JtgaRSXGdJc2cGI0pVfLpwqCBGlSyGV50Lx+
	vU4kpPqSZt5+sQsu2lI6lckshe1fP0PW5GrRQcJSPkulxGCPSWXdmGrJ49bN7j3JwxF00PBxObt
	s6qBGvIKaIh6BoVDup3bxyefl/uXWi9f6npzmd9DKyGRlUPwuygrriXJ3yyi7yg==
X-Gm-Gg: AfdE7clEmlJLHEwnrtwz5gKo09128OpZeGv1l9SF2v52s7uwJPNdmRUjwnWXa+jfGwp
	meibVyGneprlpqv4msvtVHSozTTakIsIs+fjb5y41iaT0LwnX/SNyNeWq0H8eMdxovMn9AfOQLh
	OYdMFz1HT4hkK1tZDWRo+y02Ml/tBTkZIvGSP1Osfd46WTpIzrdsMJr1Y4NiFjt5Y9JOodsAb/e
	ZI97vND5UBcPScFby9gwiTeto5uS/6+Y18GcYPw2EqrVEF+tIi8MDijRidi+OdUii27WVZqa5ca
	bBjVkLjtdp5xUH54XeiyQcsUyZpUCPOYmib2gxHmvlLM0GCk4kLQ/ugptdbMSuSRjYvBr1fo+8C
	JuN7uUwzG4PvBC0JVobjoIg9Ep+w1NPRrA9uuMA==
X-Received: by 2002:a05:7022:fa5:b0:139:ed5d:3b3 with SMTP id
 a92af1059eb24-13b2a1d25d6mr3161157c88.44.1782837842011; Tue, 30 Jun 2026
 09:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl> <20260629194327.2270798-4-jkoolstra@xs4all.nl>
In-Reply-To: <20260629194327.2270798-4-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 30 Jun 2026 09:43:50 -0700
X-Gm-Features: AVVi8Cfg-jGOSmM0AyC_veTlwOcXtiFvZmVGHLWJZaxOaynBoRDq8uW1BKdMGmA
Message-ID: <CAAVpQUBFJXv2FK=7DmKgWms7JROJGWp=S+AOBS__hxmgbLbUkA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/5] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 12:42=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl=
> wrote:
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
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  include/net/af_unix.h             |  1 +
>  include/net/scm.h                 | 15 +++++++++++----
>  include/uapi/asm-generic/socket.h |  3 +++
>  net/compat.c                      |  4 ++--
>  net/core/scm.c                    | 16 +++++++++++-----
>  net/unix/af_unix.c                |  9 +++++++++
>  6 files changed, 37 insertions(+), 11 deletions(-)
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
> index c52519669349..761cda0803fb 100644
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
> @@ -108,11 +108,18 @@ void scm_recv_unix(struct socket *sock, struct msgh=
dr *msg,
>                    struct scm_cookie *scm, int flags);
>
>  static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
> -                                 unsigned int flags)
> +                                 unsigned int flags, bool notrunc)
>  {
> +       bool filtered;
> +       int error;
> +
>         if (!ufd)
>                 return -EFAULT;
> -       return receive_fd(f, ufd, flags);
> +
> +       error =3D receive_fd_filtered(f, ufd, flags, &filtered);
> +       if (filtered && notrunc)
> +               return put_user(error, ufd);
> +       return error;
>  }
>
>  #endif /* __LINUX_NET_SCM_H */
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic=
/socket.h
> index 53b5a8c002b1..c5fb2ee96830 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -150,6 +150,9 @@
>  #define SO_INQ                 84
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      85
> +#define SCM_RIGHTS_NOTRUNC     SO_RIGHTS_NOTRUNC

SCM_RIGHTS_NOTRUNC is not needed as it's not used.


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
> index a73b1eb30fd2..55bab203281a 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -351,7 +351,7 @@ static int scm_max_fds(struct msghdr *msg)
>         return (msg->msg_controllen - sizeof(struct cmsghdr)) / sizeof(in=
t);
>  }
>
> -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
> +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool not=
runc)
>  {
>         struct cmsghdr __user *cm =3D
>                 (__force struct cmsghdr __user *)msg->msg_control_user;
> @@ -365,12 +365,12 @@ void scm_detach_fds(struct msghdr *msg, struct scm_=
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
> @@ -542,8 +542,14 @@ void scm_recv_unix(struct socket *sock, struct msghd=
r *msg,
>         if (!__scm_recv_common(sock->sk, msg, scm, flags))
>                 return;
>
> -       if (scm->fp)
> -               scm_detach_fds(msg, scm);
> +       if (scm->fp) {
> +               struct unix_sock *u;
> +               bool notrunc;
> +
> +               u =3D unix_sk(sock->sk);
> +               notrunc =3D READ_ONCE(u->scm_rights_notrunc);

Does this build with CONFIG_UNIX=3Dn ?


> +               scm_detach_fds(msg, scm, notrunc);
> +       }
>
>         if (sock->sk->sk_scm_pidfd)
>                 scm_pidfd_recv(msg, scm);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f7a9d55eee8a..83274ce18e06 100644
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
> +               break;
> +
>         default:
>                 return -ENOPROTOOPT;
>         }
> --
> 2.54.0
>
