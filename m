Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DCD3BBFDA
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020684; cv=pass; b=dfxbZKjmGqZYCuNXgbaIv3o2pZ3x3hdRQRTVK6xGinGlE8/WBao05QPjMyI3nFTyTtLjFJYn4IPXjZ/MYsvv1sYiDkeQwg/aIEP+0r/6UrA1TH5qUJGMUjhR6UvnOlsQtniWfuA2wgCo5ljQHUihXJ7z0LMTywVJ0UZilY8Nrhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020684; c=relaxed/simple;
	bh=1tJQ9mruhM/lPc4sdxQcL6wM+3YeNMbRRx4k5OLxZXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gy75bPik9MI06tGJ22jQXpBQmw1q0dEbRAgnHIwsJ/dQcAdNbcP/Dn2QjcuDZ/EeH4w/bchKULKu9WN+W6UCjawBLWH9SDtco+5gpmbPmBKC+1bjEv0q9uHQPGlNmVUuxo7i2I2QGDttYXxEag86y6uqEzvzXwXCw1pW8gSnGNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFtZvs1h; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFtZvs1h"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso5713263a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 23:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789020678; cv=none;
        d=google.com; s=arc-20260327;
        b=UURd8e7ggN+P8nwbcYldrYKmgNBh9DzEM8JUOO6WB8TQU6DF1h+5mj+1FhReC7b1JL
         AK6WhiC9u9mizYXzo3DPEvshexOdwaPhjsR0h7iXc6aW3cccDPUFM9HAqNrQRfQRdz81
         g8Kk6uRcEE+tKZ6mAjFV8FniddDIttQsaq9rzNLf+2fgIdlD98rphQVMCTKxXMiTJU/F
         gsEONUTRbECBhyi8f9t6s/yJq/9+VSTn3C5J0gWWkIoAnVm0LgoZKgP9gJYHodRDxMBC
         b3VamJMf9DRDEOp0vfTcPe6Fo4U7NNvbwm666R3K3R9zAyn81IEmZfofm3D01Hjd7QJ0
         Fb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7NyyOOAtxIHkb8nmYnBuuhGEfeag/LMiOe4zjEVvRpY=;
        fh=UIYeAAIXIAtmEzz7PoQ4nO/8oG1Qk8W+pIrvOIPUtKE=;
        b=XD0FoYYNmGvuRyStlTFNzcsFvFig5pkYxaIw1DniRzEfc030WlwQkgp4s6w0SYWLXL
         RwiGtdLtK1rYN/XlC6QRVSWrIgIg12/vZgDPZczRnnHMXMHvjf3S3X/CJ2j3knENYe6V
         E6fv0Fer8nCV58L54mPUUsyDMyAyc2IEVlibNLV2CB+SOmOCBEhMS6XvbtyYCAPCKG5y
         /R7+LYiYbTjIV5QSqYJ5ULn2vpxmoiIOCwy3nueT+Zap8Y/o3wJFQmI/NNN68iUE0RPr
         NxcqEUjLtquGQf9OpKluWzqKhCvdIP8+9qbYyMHZZeGYUUImX5AM/5ZHPL6/hnMBQCoc
         TMew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789020678; x=1789625478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7NyyOOAtxIHkb8nmYnBuuhGEfeag/LMiOe4zjEVvRpY=;
        b=dFtZvs1hDsuuDpgpGsg82y1toEAKO/PJfxxjcPvzAOWAMSxS5OhQHYLOOSolZqtHFS
         3YUpm4e5ekajspF4hBXbnOdFajCTcqo1CnfSshW8Ktt2G5GXOyDoWdpXmRHT7aETddy1
         3cRlfEDEbdMbz22u5fds9ft475VYsNB/MgBEMEDeUTJYizW82+FC8AeW+iiW1Ab3b18n
         xLE/Bm1kl71OM9Hpa6TGtZ3naD76abt1yeUtsxp6nE32qACY4tyaQyXMdzpSvimY07Bb
         tQB0UFekeMTiD3IJ2YyxXpCjaOco8LWkgv73ANbh0xCFZCCC2QkEISq//aU67o8z5aG2
         eXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020678; x=1789625478;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NyyOOAtxIHkb8nmYnBuuhGEfeag/LMiOe4zjEVvRpY=;
        b=hWmJ+LdNxCHdD/+VJZjLk8CplWLftXSyEYZThYC5QqZ9/A4iSDcrKA7IDacWhlUJVm
         WixOzTyxz/y+TJns4Y0RoYRpM3jlRGVApHrHWwJUbEjb3b1FA9alHFqP7MUMAcTl6nUJ
         ZWifNSbrIb4t770bPJS9aX3wDc31ENQwnmuuaP+11HY7e5xptRTaECYPvU6dMtLc4xPY
         oAtqniN/Zuzva1QYrvzEbOD84/qMNIboEuroGtpJUgeOXUuQeDUmqrTyQtc2V3DkQVFV
         wVuiuwqatVK9JHsgJBRPxy+p/deznetT1w3vxpC/74zNagO2LLfmCgR8YbzqlEV3EN+V
         6ztQ==
X-Forwarded-Encrypted: i=1; AKwUvBxu9h0z5Y8kYP08tApZE6baMs4R2TZc6E8O4eSq4G+H3ivYnKZrE5FRuMI+7vAfWUbnszcuaCUdxxEQcdH8@vger.kernel.org
X-Gm-Message-State: AFuF++lMOz4SzbD1dtD97juzR1vClrEuuxkFlJHuVChbJUUyrXdgobjB
	8UulLFSDOP9aMw5C/qs8KMvuPE0N3mgepI73yBHsIwfgnR+9dnkvFH1J+7uur+7GZUZMLaoUC1g
	tlawR2YpMMaRLYL1uF1tkLDH2cUyniRJ31dN7OPSN
X-Gm-Gg: AYBFou2+4puyrfTcQw3b4qEieZhzAk9IIpm8xX1N8jPifhJHnDzfFfB/1jzor6wFV+J
	DsBQz+EfrN6oBxMuS5wvrGNQeuqAtGQdvKrFvXZ0KhdbIyKR8encRQxYUoMm6jsyb5naJ9HAFoe
	LrYsBAUBELvFY5T44QNXSCLKTSzrHgU2qNHpSha7e6qd85JV+HJodw1IFS/X6crq22Qra8Xu7Uq
	DA4kjDmU3fF0+7gunmAySo+CIoeJ7UkzPhiQAAz1T0SWigmpwOIp56t3LR1yQe4AZ5bKmJmIG3D
	0U9zx75X74oWDbHgFp8j5hG6K5/ybAwQIDMtcdQ04yufUgHsiRJwLouRQPOQL9qM5/7PG8LozW8
	bDvJJ5fMgKCswpGRB7Qhf8MhtdcvNZuPZ8M2mu62EglPSJMtSQtHelvg+M7lV2o+SQqATReKM6C
	ikKRvWawnZoWYTnyIu6wHs0aC5
X-Received: by 2002:a05:6820:168f:b0:6b1:a11a:eef4 with SMTP id
 006d021491bc7-6b6fbad3850mr22759542eaf.14.1789020676956; Wed, 09 Sep 2026
 23:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org> <20260909-work-unix-passpidfd-v2-7-7bd342abb2d1@kernel.org>
In-Reply-To: <20260909-work-unix-passpidfd-v2-7-7bd342abb2d1@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 9 Sep 2026 23:11:04 -0700
X-Gm-Features: AcwNN1W2SQ-KpC8ZkEjrvyXHJGjgWbDapMPc1W4MbMFrT4G-1RPmONjCdUNvIlc
Message-ID: <CAAVpQUAhajwkDO4h7_TL7no3MY7tUyMBmeWQajNv6m6n4F+RHA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] net: add SO_PEERPIDFD_THREAD to get a
 thread-specific pidfd
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:43=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> SO_PEERPIDFD hands out a pidfd for the thread-group that called
> connect() or socketpair(). Enable workloads such as the coredump server
> or a broker to get a pidfd of the specific thread that connected to the
> socket.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  2 +
>  arch/mips/include/uapi/asm/socket.h   |  2 +
>  arch/parisc/include/uapi/asm/socket.h |  2 +
>  arch/sparc/include/uapi/asm/socket.h  |  2 +
>  include/uapi/asm-generic/socket.h     |  2 +
>  net/core/sock.c                       | 87 ++++++++++++++++++++---------=
------
>  net/unix/af_unix.c                    |  1 +
>  7 files changed, 61 insertions(+), 37 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/ua=
pi/asm/socket.h
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
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi=
/asm/socket.h
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
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/=
uapi/asm/socket.h
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
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/ua=
pi/asm/socket.h
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
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic=
/socket.h
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
>  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 6ada7e7eb7d7..cb2ffd329bc6 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1743,6 +1743,50 @@ static int groups_to_user(sockptr_t dst, const str=
uct group_info *src)
>         return 0;
>  }
>
> +/* Hand out a pidfd for @type of the socket's peer via SO_PEERPIDFD*. */
> +static int sk_getsockopt_peerpidfd(struct sock *sk, enum pid_type type,
> +                                  sockptr_t optval, sockptr_t optlen, in=
t len)
> +{
> +       struct file *pidfd_file =3D NULL;
> +       unsigned int flags =3D 0;
> +       struct pid *peer_pid;
> +       int pidfd;
> +
> +       if (len > sizeof(pidfd))
> +               len =3D sizeof(pidfd);
> +
> +       spin_lock(&sk->sk_peer_lock);
> +       peer_pid =3D get_pid(sk->sk_peer_pid[type]);
> +       spin_unlock(&sk->sk_peer_lock);
> +
> +       if (!peer_pid)
> +               return -ENODATA;
> +
> +       /* The use of PIDFD_STALE requires stashing of struct pid on pidf=
s
> +        * with pidfs_register_pid() and only AF_UNIX were prepared for t=
his.

nit: while at it, s/were/is/


> +        */
> +       if (sk->sk_family =3D=3D AF_UNIX)

nit: please use sk_is_unix()


> +               flags |=3D PIDFD_STALE;
> +       if (type =3D=3D PIDTYPE_PID)
> +               flags |=3D PIDFD_THREAD;
> +
> +       pidfd =3D pidfd_prepare(peer_pid, flags, &pidfd_file);
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
> @@ -1938,45 +1982,14 @@ int sk_getsockopt(struct sock *sk, int level, int=
 optname,
>         }
>
>         case SO_PEERPIDFD:
> -       {
> -               struct pid *peer_pid;
> -               struct file *pidfd_file =3D NULL;
> -               unsigned int flags =3D 0;
> -               int pidfd;
> -
> -               if (len > sizeof(pidfd))
> -                       len =3D sizeof(pidfd);
> -
> -               spin_lock(&sk->sk_peer_lock);
> -               peer_pid =3D get_pid(sk->sk_peer_pid[PIDTYPE_TGID]);
> -               spin_unlock(&sk->sk_peer_lock);
> -
> -               if (!peer_pid)
> -                       return -ENODATA;
> -
> -               /* The use of PIDFD_STALE requires stashing of struct pid
> -                * on pidfs with pidfs_register_pid() and only AF_UNIX
> -                * were prepared for this.
> -                */
> -               if (sk->sk_family =3D=3D AF_UNIX)
> -                       flags =3D PIDFD_STALE;
> +               return sk_getsockopt_peerpidfd(sk, PIDTYPE_TGID, optval, =
optlen, len);
>
> -               pidfd =3D pidfd_prepare(peer_pid, flags, &pidfd_file);
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
> +               return sk_getsockopt_peerpidfd(sk, PIDTYPE_PID, optval, o=
ptlen, len);
>
>         case SO_PEERGROUPS:
>         {
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index d01ee76c8026..563d9827c5cc 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1056,6 +1056,7 @@ static bool unix_bpf_bypass_getsockopt(int level, i=
nt optname)
>         if (level =3D=3D SOL_SOCKET) {
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
