Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEE468C31
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778205; cv=pass; b=WmU5q+hUZrpSQVwQtbMujT523WciDPpvRI6yMPEGF/tLaLw+H1VVu+n74mBpjhGalac+g7ZSTxuEmzBpkBG672/YhdEgxwbLhB2W0dbFwsVW/JSCIyoRv7pDoyRWcTKsFSvT0Sha+ZpJWY+dNY+5sPs83FzplpymaYUsjVniS5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778205; c=relaxed/simple;
	bh=m2lih3NNM3nXZvl36JBb7wUDN3xChnmzMRftKfii0Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2S5FufrqRcnUY27JGM3PlP7uBxCxhEh4MnFtFHAwDUlQ0smIdf00E2aZ4yBXF2Ti6hEQDwI8eY7jRrVUu/pYz79rauexiuLr/Zw2oS1Iu/9bzXa9+f5wfSGzgR35XlvYM+zQoLibMm5rLMY1796c+gn2FEyBZq41FlCASrOVn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=Pu5lgoDn; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="Pu5lgoDn"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2531f453eeso453050866b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 03:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788778201; cv=none;
        d=google.com; s=arc-20260327;
        b=sW16CxVWMw1XV/E2Ii476Wb1jmNVxvxYGdKG23Dk7x9D2Ry001a7fMfOybzXV38waw
         vfgMd05EHVtwa6NrXzNSBHQaUNj8ZUo1CBeqZJ2BDJ7Z34vqPPTpms/Jkvt2kHLmF5Z3
         FGVAVjNXQfJqDKVGks6BdzT1DDPTpkQWS9ZtH9nSuHMgssXnSAbMdT+QRAY0cY1E4RpY
         nDYmHTdTaX9LghlN25U6iSmPfFJQgKsLnmnUyVsnOIJCz0sUMGQz61VyYqIUAnByrgqD
         H77z8zMDZwm6V3nw43NOcHBJPAWxwfV8/0vDraoUiOuwuboOVzOD8zoMZWdDOF/kStj8
         8WAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pfguWzPzl853yJtKqzuKDZlU916kkLOBY67tJF8BgOw=;
        fh=mOaiBXeRHWKdxunYemlAM0lvdlw4oURX38dRTCLG3GY=;
        b=TatsKtXTogYUoq5wT0tJWO/FEtgYUIHKa7jr2DTTHV8BvTYUv6nY2bpXPuPZPcQEft
         6ktemaz6evV0C1Lj8esfRk+d4PxoLbbQqjWIiGBiJPD+iEmy/FyzQ0sLqXYgLjfb4Fbq
         NYeE9PkVUj3u206/9LFfuX88rdlkCV3MPPidaUfnwfsSvRHkqXTUOUisY781BPiGYVwl
         be78c5kVyM1q9AoYwzZMCQ2nsTZaci7E1ncBknOlwUW1sIZsTBeA724dANo8jq82+ID4
         rRm9uBVNnzHDsqqbiI7Fa4JSr3nWlh2d37VWy5diFAR2iXcrz4hARTfK6R+FFzsCkGnd
         YDPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788778201; x=1789383001; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfguWzPzl853yJtKqzuKDZlU916kkLOBY67tJF8BgOw=;
        b=Pu5lgoDn/s8jglQTDKn/xOiSFI0BW86Brjgke+/IRuVylk89kYPoqL/KMCfiDJOVyW
         HknKYo5kWB2oKPxlpMUehS47KJ+wHpbEKNtM9dXYciXK3dZ/oXiHIvfUKrjwvIN/frjE
         wjLg6aR14MJzeEHvRv0Jq/Q5VYy4AgJkoSqaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778201; x=1789383001;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pfguWzPzl853yJtKqzuKDZlU916kkLOBY67tJF8BgOw=;
        b=sMVgyMq8hMA4uf3gEjJfSh9zabJ1D9pT6tATjlcCwUI3kc/IXMVBmgqKQtav+3moyQ
         0q18nK577zJnr2bX8MN7vf1N8SDQl7HDy5fHrZxLgZdXu1QkNwgUJJGU496zIKiHWoFU
         rE8wi2o/Lp/0S2FJgY6bbkIugHUzbTSSs3kTzKRE1Av4HPGqZ4Uobi4dCindr0ZUsFJs
         Y5xvjEFD0skEY6yyUL+oYKF5KUrS+4ckpbqEkGJZWdMAP325LXIkeJd5Zu4SqOs7CJNj
         UCdrY1mZZriQdX07vo/bRMcfURH8GX4hlJDgOU3MvrEbHgiJrUCS4n+fe9E2YbdoU175
         1X+g==
X-Forwarded-Encrypted: i=1; AKwUvBwziXIMS2qjHCbsvmX5wcyU/z52MzFo2HsiTVfNOjTiMbilzrxvkdNm6yb58oF9B896tzYhA6+6A84hGh6m@vger.kernel.org
X-Gm-Message-State: AFuF++kKSrHiVLJkuKM+KQFgjJ/1EYJ8YGeGNF36BsRr058BngVlsgPw
	6QYfXXPWeSEdBi0tp8iD8eqSoTMwNyieX9FRwpR8sDeUqAiqCSRz9ZIFuwm0ftihcYLdSVCzb3o
	Ztb+0EIYXi/uZxJHCZgbY+5VVDuf7UH91loIaSE7awQ==
X-Gm-Gg: AYBFou1I/zcFmbQON2z7OUuIcP4xPdB+WW+4uGmkG1nFKbrDowhcOXAYZYsVvDjJEre
	nClDmCMix8TD7j+0JkowAlMxX/bfhbV3pmtc2ShZDf1/f22FHVWP7QA2ddDp8KJYsWw5QfBUN5s
	mMbrRX4KXR77wRyjv0WYoO8Pf7EzXDiLRBL428Vw19l7CRZaBa3zZ6+hLxsKPZCFcTME6KAk/05
	queALOuLNqyYDXDPRZu9PAngiCN/VGRds7dvEFVb4Gzt4W+LgGqlJ5fGJlLveHIALhbr8mU7jx+
	mgz+LWGT517kpr+wj5e+eOI+cvC2V/iCmCC456geFDO41wJxIazQtulxeKjI9hpLHie4HQzGV82
	fzp7ryZmLQQ==
X-Received: by 2002:a17:906:7956:b0:c16:84dc:9607 with SMTP id
 a640c23a62f3a-c260ca323dcmr1544501166b.19.1788778200417; Mon, 07 Sep 2026
 03:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-7-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-7-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 12:49:48 +0200
X-Gm-Features: AcwNN1XRQbjmt8u40rEyLnoiU1YqH4VMsoGBtHpWSXaJltkwr5aTgGVxP_BPxtc
Message-ID: <CAJqdLrr5PfwH2z6x-HK0z7bHGD0UQDY6QoY5Y=tmwcd_QQnO7A@mail.gmail.com>
Subject: Re: [PATCH 07/10] net: add SO_PEERPIDFD_THREAD to get a
 thread-specific pidfd
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
> SO_PEERPIDFD hands out a pidfd for the thread-group that called
> connect() or socketpair(). Enable workloads such as the coredump server
> or a broker to get a pidfd of the specific thread that connected to the
> socket.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  arch/alpha/include/uapi/asm/socket.h  |  2 +
>  arch/mips/include/uapi/asm/socket.h   |  2 +
>  arch/parisc/include/uapi/asm/socket.h |  2 +
>  arch/sparc/include/uapi/asm/socket.h  |  2 +
>  include/uapi/asm-generic/socket.h     |  2 +
>  net/core/sock.c                       | 87 ++++++++++++++++++++---------------
>  net/unix/af_unix.c                    |  1 +
>  7 files changed, 61 insertions(+), 37 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index bb3d534826bb..5d3524c26b2b 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -159,6 +159,8 @@
>
>  #define SO_PASSPIDFD_THREAD    86
>
> +#define SO_PEERPIDFD_THREAD    87
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> index 269badcaa086..245a43f52fb1 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -170,6 +170,8 @@
>
>  #define SO_PASSPIDFD_THREAD    86
>
> +#define SO_PEERPIDFD_THREAD    87
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> index 313aee10a52c..f23710e1c671 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -151,6 +151,8 @@
>
>  #define SO_PASSPIDFD_THREAD    0x4054
>
> +#define SO_PEERPIDFD_THREAD    0x4055
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> index bd3e69bcce7a..b35b25bdefc2 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -152,6 +152,8 @@
>
>  #define SO_PASSPIDFD_THREAD      0x005f
>
> +#define SO_PEERPIDFD_THREAD      0x0060
> +
>  #if !defined(__KERNEL__)
>
>
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index d1e5c6de146d..56fed7ab27ab 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -154,6 +154,8 @@
>
>  #define SO_PASSPIDFD_THREAD    86
>
> +#define SO_PEERPIDFD_THREAD    87
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 6ada7e7eb7d7..cb2ffd329bc6 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1743,6 +1743,50 @@ static int groups_to_user(sockptr_t dst, const struct group_info *src)
>         return 0;
>  }
>
> +/* Hand out a pidfd for @type of the socket's peer via SO_PEERPIDFD*. */
> +static int sk_getsockopt_peerpidfd(struct sock *sk, enum pid_type type,
> +                                  sockptr_t optval, sockptr_t optlen, int len)
> +{
> +       struct file *pidfd_file = NULL;
> +       unsigned int flags = 0;
> +       struct pid *peer_pid;
> +       int pidfd;
> +
> +       if (len > sizeof(pidfd))
> +               len = sizeof(pidfd);
> +
> +       spin_lock(&sk->sk_peer_lock);
> +       peer_pid = get_pid(sk->sk_peer_pid[type]);
> +       spin_unlock(&sk->sk_peer_lock);
> +
> +       if (!peer_pid)
> +               return -ENODATA;
> +
> +       /* The use of PIDFD_STALE requires stashing of struct pid on pidfs
> +        * with pidfs_register_pid() and only AF_UNIX were prepared for this.
> +        */
> +       if (sk->sk_family == AF_UNIX)
> +               flags |= PIDFD_STALE;
> +       if (type == PIDTYPE_PID)
> +               flags |= PIDFD_THREAD;
> +
> +       pidfd = pidfd_prepare(peer_pid, flags, &pidfd_file);
> +       put_pid(peer_pid);
> +       if (pidfd < 0)
> +               return pidfd;
> +
> +       if (copy_to_sockptr(optval, &pidfd, len) ||
> +           copy_to_sockptr(optlen, &len, sizeof(int))) {
> +               put_unused_fd(pidfd);
> +               fput(pidfd_file);
> +
> +               return -EFAULT;
> +       }
> +
> +       fd_install(pidfd, pidfd_file);
> +       return 0;
> +}
> +
>  int sk_getsockopt(struct sock *sk, int level, int optname,
>                   sockptr_t optval, sockptr_t optlen)
>  {
> @@ -1938,45 +1982,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>         }
>
>         case SO_PEERPIDFD:
> -       {
> -               struct pid *peer_pid;
> -               struct file *pidfd_file = NULL;
> -               unsigned int flags = 0;
> -               int pidfd;
> -
> -               if (len > sizeof(pidfd))
> -                       len = sizeof(pidfd);
> -
> -               spin_lock(&sk->sk_peer_lock);
> -               peer_pid = get_pid(sk->sk_peer_pid[PIDTYPE_TGID]);
> -               spin_unlock(&sk->sk_peer_lock);
> -
> -               if (!peer_pid)
> -                       return -ENODATA;
> -
> -               /* The use of PIDFD_STALE requires stashing of struct pid
> -                * on pidfs with pidfs_register_pid() and only AF_UNIX
> -                * were prepared for this.
> -                */
> -               if (sk->sk_family == AF_UNIX)
> -                       flags = PIDFD_STALE;
> +               return sk_getsockopt_peerpidfd(sk, PIDTYPE_TGID, optval, optlen, len);
>
> -               pidfd = pidfd_prepare(peer_pid, flags, &pidfd_file);
> -               put_pid(peer_pid);
> -               if (pidfd < 0)
> -                       return pidfd;
> -
> -               if (copy_to_sockptr(optval, &pidfd, len) ||
> -                   copy_to_sockptr(optlen, &len, sizeof(int))) {
> -                       put_unused_fd(pidfd);
> -                       fput(pidfd_file);
> -
> -                       return -EFAULT;
> -               }
> +       case SO_PEERPIDFD_THREAD:
> +               /* Only AF_UNIX records the peer's connecting thread. */
> +               if (!sk_is_unix(sk))
> +                       return -EOPNOTSUPP;
>
> -               fd_install(pidfd, pidfd_file);
> -               return 0;
> -       }
> +               return sk_getsockopt_peerpidfd(sk, PIDTYPE_PID, optval, optlen, len);
>
>         case SO_PEERGROUPS:
>         {
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index d01ee76c8026..563d9827c5cc 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1056,6 +1056,7 @@ static bool unix_bpf_bypass_getsockopt(int level, int optname)
>         if (level == SOL_SOCKET) {
>                 switch (optname) {
>                 case SO_PEERPIDFD:
> +               case SO_PEERPIDFD_THREAD:
>                         return true;
>                 default:
>                         return false;
>
> --
> 2.53.0
>
