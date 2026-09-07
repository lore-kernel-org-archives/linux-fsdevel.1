Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0E3597B
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775379; cv=pass; b=pRXymIKP3+oZnK976uzPrfmYe8gvX+tn/YNixs+c/rwyIytMwxMtoK2FNfTQ2Uf4yH6WcxLu41DDlEVlu7pYmc+8Cei52A3N9T2KomyTZGlAt2DR4z3o0m/n4chrt9616DLX7GQjY7l0IbPKJ5QLho1Wc0w66m/zWuD2iSesW8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775379; c=relaxed/simple;
	bh=Agb1U5psKWFluwAHuOfTyImm6NSwIkYlNTBkyvN5v54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGqH7Wan7abfw+O4Pq4gkf+dyeibBnSlEyazmCTBiEEph1I5Y9Ejw43uRhM97m1dUlxvnpIcugD3VdsWMLzw+bPhCUregxaPlFIoC0K3wGDZ/9Q9XxyCHZ7HfA6GJGJjNar2e4mOmROp2Bwxdge+dLsbRse5kZHA2eHaeoy/vRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=J/oQ0zbe; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="J/oQ0zbe"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c253425b253so471801466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 03:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788775375; cv=none;
        d=google.com; s=arc-20260327;
        b=X1D9Nt1xuR7BCt4FPTwcRW/uRfni20YdjVtfXCGOl+WPhQOcY1BOjTQfANSMRU6oum
         aqLMPPLM8bTjJQ7Pzy6v7KzAAxTty9hm1uVafiK6LwVsQV3k+IC0y2fugoy2i2EoxozM
         zXgWm7MEXir1VEK24IvE1O/uknDdDezZMpINJY25MKCukLydPR+747KC61pnDSAEd45y
         Q/27iF0l2nzHY9Z+PV0mPviRjlyV3ml+2a+NWCmBo0OnD/uM1mKAP6MJ/4lQNJhjQErQ
         H+SrcV9cCauGTheRuAWpjFqiqxKrszD2s5Zs+8P7EpLyDFFk5wyV4cOWkK5OJtOvMG10
         F+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mYUAt3CoW8hcdk4x5wF7dW2bJUGkWCMPVdPRg2ig/X4=;
        fh=TYXDBrFQge5fa1EQSjZMH97RK0jzBF/evEDhGsHgjcs=;
        b=EFbInnV4+uxZLQ2faISepfTBWsDzAFXn0QkWRGhl5K8rS8uJkAP+Dx2peAkJSucHsY
         ugpryP+asM2pxMjYBqCYvFj01MvKOi4QEX6oy0YOmQ7aDQXXNraIfgffClnT5tr4VWtC
         XqGroYSZEJaA5+sP1QFETXvgk+FhNPgc+jOOqlMXZL+JXpLgRxlemZprtzVqPFWY1XoO
         I/Y592/PFnNS0CmzGRM20pLGeFbrQ/CF+e1h8U9iQnXrZItNAbY5xqZb5V9fvsJAZttK
         E/OnSVZ2uJtEAflgAgdaZGCc7Pdlxn1yFbaAvztzZVnYkpupfROZwA/zdtTJn8toVFtI
         SQZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788775375; x=1789380175; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYUAt3CoW8hcdk4x5wF7dW2bJUGkWCMPVdPRg2ig/X4=;
        b=J/oQ0zbe6cvhl1dRG2znv7QMeeCxKvm1y5gI2xZDXVriD7XRjtVW+VbqNDz9Kq3yDD
         UUe2kk4tE0FmxhelVEU/fOahN1lTu8Ckv6zbwgziX0o4u0HB97nyV+/r625PLeQi0eHj
         IEvZ28zO+PR9ABq56J5QqSA7+9ew6jIwRHYpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788775375; x=1789380175;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mYUAt3CoW8hcdk4x5wF7dW2bJUGkWCMPVdPRg2ig/X4=;
        b=B6xSzN3e0nPDBvtv43eL4L76ssEh5i/5/+OEGzNvDgHdCDMAv3NuV/fWzHMHDr01tm
         oIRN1E30//oXvwbqVgmDui2EiMww2p4OBeFYEcjhubT6C8QxEYssKAOoUhP0RV9qU7/u
         JaacTDbxsPrJUnjz/weCnG3iu1fVCulpYTJcYFcERzFmuWmJqakQ+ffthevMvRvVBoFK
         etEt6UmT4TBHI9oVFuZVyyR1zEXXVm/N8XkqPK4GIis6souuyX+fR693QgpiPNTfXn6D
         8CUPNOB90HjpNe2ZVI2nokpDoO0+D97PWPHVO27/w9kToNjSqxgkiLQ1lnOVjJ8yHlzu
         fSHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvk3K1u3w37D7Olm8sOPi1YjgbiOupVvyBFZjvWpO5L/rRvcpL1LBUQ3mJQZH7/gxDiY2+WhagEp3AjvA3@vger.kernel.org
X-Gm-Message-State: AFuF++k2Gi/FIJqaKs3dOyVgTgYi3U197deiHYUudVBIcAIiA8O/GIs9
	9lrrFytC1OpQ5uuM8wAL53EQ6hKK+pxG/TjbTegvEigGQv7A7Tvs0AKmNDQxP74OFQAsxtks0//
	gZoAdJEfWHxQX1I54U9UYpp24y1ETfyH3P2k8nhVcmg==
X-Gm-Gg: AYBFou09fv3Oq0LBTJv5iRbxse+HyHKyga5bSJBOE5XGOtb1jQduZKx53Sff2SnVC4t
	9rMD31y2RgArk/kGb0vDqxPPqor941JbvUHDPl40rC0A4r3wkE3QltEyojvxDmLMMfn6agO5WlX
	g3UAl+1uQNl7uqm9CRk21z4+GXFXdExIWmhmiSMaOmlbvCePXwM3iRsGvluq6ml9i5Z80sFtwul
	qeKtLmTFcXi8w23FSZNYrHT7vLguCBDzpOJwav9/tNDw3EtzK/LafETerBPXBE18eCL3FH18YFI
	ReddqIFPlf7TrxhkKGfdDBy7KuFZA74YvkLYmmqs/wwH4lb3LRwjiBhp5Q2DkGsP8dpOaX06wE8
	=
X-Received: by 2002:a17:906:6a06:b0:c27:420b:7c91 with SMTP id
 a640c23a62f3a-c27420ba148mr324617266b.45.1788775375021; Mon, 07 Sep 2026
 03:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-3-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-3-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 12:02:43 +0200
X-Gm-Features: AcwNN1WrhkNKsQbqXVbkhOZyJ1cNaX0dXsg8rTr7YIJ3nSA211pYR6RUAISIT_4
Message-ID: <CAJqdLrrHfVs_53rZ3tnCA8+F=rH93hGi8H=COgzhSAovHp2btQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] net: add SO_PASSPIDFD_THREAD to get a
 thread-specific SCM_PIDFD
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 31. Aug. 2026 um 13:21 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Currently, SCM_PIDFD carries a pidfd for the thread-group leader. A
> broker or the coredump server cannot learn the identity of the specific
> thread that sent a given message. Now that both struct pids are recorded
> a receiver can ask for the specific identity it needs.
>
> So add SO_PASSPIDFD_THREAD as a sibling of SO_PASSPIDFD. Either option
> makes recvmsg() deliver an SCM_PIDFD. SO_PASSPIDFD sends a pidfd for the
> thread-group leader and SO_PASSPIDFD_THREAD sends a pidfd for the
> specific thread.
>
> The two options are mutually exclusive. Enabling one switches the other
> off, so getsockopt() always reports which of the two is active.
>
> On SOCK_STREAM sockets recvmsg() only stops merging data at a thread
> boundary when the receiver asked for a thread pidfd. For SO_PASSCRED and
> SO_PASSPIDFD receivers all threads of one process remain a single
> writer.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  arch/alpha/include/uapi/asm/socket.h  |  2 ++
>  arch/mips/include/uapi/asm/socket.h   |  2 ++
>  arch/parisc/include/uapi/asm/socket.h |  2 ++
>  arch/sparc/include/uapi/asm/socket.h  |  2 ++
>  include/net/sock.h                    | 10 +++++++++-
>  include/uapi/asm-generic/socket.h     |  2 ++
>  net/core/scm.c                        | 19 +++++++++++++------
>  net/core/sock.c                       | 26 ++++++++++++++++++++++++--
>  net/unix/af_unix.c                    | 11 ++++++++---
>  9 files changed, 64 insertions(+), 12 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index 946a5fad2691..bb3d534826bb 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -157,6 +157,8 @@
>
>  #define SO_RIGHTS_NOTRUNC      85
>
> +#define SO_PASSPIDFD_THREAD    86
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> index f1641dde135f..269badcaa086 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -168,6 +168,8 @@
>
>  #define SO_RIGHTS_NOTRUNC      85
>
> +#define SO_PASSPIDFD_THREAD    86
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> index f3a3815c7dc2..313aee10a52c 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -149,6 +149,8 @@
>
>  #define SO_RIGHTS_NOTRUNC      0x4053
>
> +#define SO_PASSPIDFD_THREAD    0x4054
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> index 7907f3b1f0ee..bd3e69bcce7a 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -150,6 +150,8 @@
>
>  #define SO_RIGHTS_NOTRUNC        0x005e
>
> +#define SO_PASSPIDFD_THREAD      0x005f
> +
>  #if !defined(__KERNEL__)
>
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 51185222aac2..fc09c92e8a83 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -356,6 +356,7 @@ struct sk_filter;
>    *    @sk_scm_security: flagged by SO_PASSSEC to recv SCM_SECURITY
>    *    @sk_scm_pidfd: flagged by SO_PASSPIDFD to recv SCM_PIDFD
>    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
> +  *    @sk_scm_pidfd_thread: flagged by SO_PASSPIDFD_THREAD to recv a thread SCM_PIDFD
>    *    @sk_scm_unused: unused flags for scm_recv()
>    *    @ns_tracker: tracker for netns reference
>    *    @sk_user_frags: xarray of pages the user is holding a reference on.
> @@ -562,7 +563,8 @@ struct sock {
>                                 sk_scm_security : 1,
>                                 sk_scm_pidfd : 1,
>                                 sk_scm_rights : 1,
> -                               sk_scm_unused : 4;
> +                               sk_scm_pidfd_thread : 1,
> +                               sk_scm_unused : 3;
>                 };
>         };
>         u8                      sk_clockid;
> @@ -2986,6 +2988,12 @@ static inline bool sk_is_stream_unix(const struct sock *sk)
>         return sk_is_unix(sk) && sk->sk_type == SOCK_STREAM;
>  }
>
> +/* SO_PASSPIDFD or SO_PASSPIDFD_THREAD asked for an SCM_PIDFD. */
> +static inline bool sk_scm_pidfd_wanted(const struct sock *sk)
> +{
> +       return sk->sk_scm_pidfd || sk->sk_scm_pidfd_thread;
> +}
> +
>  static inline bool sk_is_vsock(const struct sock *sk)
>  {
>         return sk->sk_family == AF_VSOCK;
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 84ea7b92936e..d1e5c6de146d 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -152,6 +152,8 @@
>
>  #define SO_RIGHTS_NOTRUNC      85
>
> +#define SO_PASSPIDFD_THREAD    86
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 9b9e119c353a..d69768414af4 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -499,9 +499,13 @@ static bool scm_has_secdata(struct sock *sk)
>  }
>  #endif
>
> -static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
> +static void scm_pidfd_recv(struct sock *sk, struct msghdr *msg,
> +                          struct scm_cookie *scm)
>  {
> +       enum pid_type type = sk->sk_scm_pidfd_thread ? PIDTYPE_PID : PIDTYPE_TGID;
> +       struct pid *pid = scm->pid[type];
>         struct file *pidfd_file = NULL;
> +       unsigned int flags = PIDFD_STALE;
>         int len, pidfd;
>
>         /* put_cmsg() doesn't return an error if CMSG is truncated,
> @@ -517,10 +521,13 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
>                 return;
>         }
>
> -       if (!scm->pid[PIDTYPE_TGID])
> +       if (!pid)
>                 return;
>
> -       pidfd = pidfd_prepare(scm->pid[PIDTYPE_TGID], PIDFD_STALE, &pidfd_file);
> +       if (type == PIDTYPE_PID)
> +               flags |= PIDFD_THREAD;
> +
> +       pidfd = pidfd_prepare(pid, flags, &pidfd_file);
>
>         if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
>                 if (pidfd_file) {
> @@ -539,7 +546,7 @@ static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
>                               struct scm_cookie *scm, int flags)
>  {
>         if (!msg->msg_control) {
> -               if (sk->sk_scm_credentials || sk->sk_scm_pidfd ||
> +               if (sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk) ||
>                     scm->fp || scm_has_secdata(sk))
>                         msg->msg_flags |= MSG_CTRUNC;
>
> @@ -586,8 +593,8 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
>                 scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc));
>         }
>
> -       if (sock->sk->sk_scm_pidfd)
> -               scm_pidfd_recv(msg, scm);
> +       if (sk_scm_pidfd_wanted(sock->sk))
> +               scm_pidfd_recv(sock->sk, msg, scm);
>
>         scm_destroy_cred(scm);
>  }
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 1ad41904db25..f9615b0de10e 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1571,10 +1571,25 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>                 break;
>
>         case SO_PASSPIDFD:
> -               if (sk_is_unix(sk))
> +               if (sk_is_unix(sk)) {
> +                       /* Mutually exclusive with SO_PASSPIDFD_THREAD. */
>                         sk->sk_scm_pidfd = valbool;
> -               else
> +                       if (valbool)
> +                               sk->sk_scm_pidfd_thread = 0;
> +               } else {
> +                       ret = -EOPNOTSUPP;
> +               }
> +               break;
> +
> +       case SO_PASSPIDFD_THREAD:
> +               if (sk_is_unix(sk)) {
> +                       /* Mutually exclusive with SO_PASSPIDFD. */
> +                       sk->sk_scm_pidfd_thread = valbool;
> +                       if (valbool)
> +                               sk->sk_scm_pidfd = 0;
> +               } else {
>                         ret = -EOPNOTSUPP;
> +               }
>                 break;
>
>         case SO_PASSRIGHTS:
> @@ -1892,6 +1907,13 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>                 v.val = sk->sk_scm_pidfd;
>                 break;
>
> +       case SO_PASSPIDFD_THREAD:
> +               if (!sk_is_unix(sk))
> +                       return -EOPNOTSUPP;
> +
> +               v.val = sk->sk_scm_pidfd_thread;
> +               break;
> +
>         case SO_PASSRIGHTS:
>                 if (!sk_is_unix(sk))
>                         return -EOPNOTSUPP;
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 011af84e3626..468a9c479b87 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -803,7 +803,7 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
>
>  static bool unix_may_passcred(const struct sock *sk)
>  {
> -       return sk->sk_scm_credentials || sk->sk_scm_pidfd;
> +       return sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk);
>  }
>
>  static int unix_listen(struct socket *sock, int backlog)
> @@ -2048,9 +2048,14 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
>         return 0;
>  }
>
> -static bool unix_skb_scm_eq(struct sk_buff *skb,
> +static bool unix_skb_scm_eq(const struct sock *sk, struct sk_buff *skb,
>                             struct scm_cookie *scm)
>  {
> +       /* Only a thread pidfd receiver can tell threads of one process apart. */
> +       if (sk->sk_scm_pidfd_thread &&
> +           UNIXCB(skb).pid[PIDTYPE_PID] != scm->pid[PIDTYPE_PID])
> +               return false;
> +
>         return UNIXCB(skb).pid[PIDTYPE_TGID] == scm->pid[PIDTYPE_TGID] &&
>                uid_eq(UNIXCB(skb).uid, scm->creds.uid) &&
>                gid_eq(UNIXCB(skb).gid, scm->creds.gid) &&
> @@ -3029,7 +3034,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>
>                 if (check_creds) {
>                         /* Never glue messages from different writers */
> -                       if (!unix_skb_scm_eq(skb, &scm))
> +                       if (!unix_skb_scm_eq(sk, skb, &scm))
>                                 break;
>                 } else if (unix_may_passcred(sk)) {
>                         /* Copy credentials */
>
> --
> 2.53.0
>
