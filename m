Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6A370AD9
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 05:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017903; cv=pass; b=eQb8Px4iKC/p1DNsqA+FG6afWPR6bOi8Gi9J81d7RGR1TDCVOFR7yPWvbk+M6PTchqkw/KB/NJ5UWhs4bU4qnfvyIfHzzS0JO4At1LiUfBkf44UGFvEAkj9xH/xTb5ZZ4QbOfWDob6G2uWZC+UuJUZLTWqEFOaXSKSCb1SRZRdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017903; c=relaxed/simple;
	bh=ePU8bjQfcitI3JNEWqMUHPynSx8EHasei0zR7xs5xs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eK3NYL4jyqfldN7pqOnOs2rNG9NMqsT6gVK+7BsJq5/0VvcH/t6NT/773m4qE6px9jYzrODr7h+ZWq3n4O1qzTysFaJjzwMr0J3HNvnbxuSQPeDjzPv05Xef+6/niXOT8zwpFXW+6SqCKJ+MLmS7mp8Lk8Z2j51ojq76ZKRLJK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2+4E1IV; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2+4E1IV"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4acso1507353a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 22:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789017899; cv=none;
        d=google.com; s=arc-20260327;
        b=KnUGNYRsqIlllZYeQCfOOcYhYkD+PtSwTiXLDN93NBBHiQT+Lb+QD62gQPuzjEKKNa
         mCk89vyRws+/5kaKJHvJYvJ37GElM7KY4LF4AcZyCuu95UbtI6vnKdwyQ38WgPYVoAnZ
         UeJGUDaM0VuHKHP2XlteH4D04T6ua0GG/tHE5sUiV37ejZ0nu62tp6q/8x/7KDo5Y4gc
         T2CwZpnF/lsyTATljr1R4sDSSd8g/DA6vP/ckJu8JGC8YxIe3SSZnYw/gqgruJvRfQJW
         IotMfuJWaIM24KsGDnEnNcn5oaCW2/BsbfDCpmXVW30cf1SEJzEjaEzCHBfSYi7dTCrX
         STMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Ef7cZ7LIz7YkH+5bkyed2cZws3jPF9j96GwnoqHnhY=;
        fh=nxRrOVsfQtpeJ5nZv/CPq/US9kFEWxvPVCiWPzBXh9M=;
        b=cULgW1y6iq1u/9bSoSGIqVG/YnNRb90HgWbi4PLacYCHj2I4HfG8BE3cI0+fXobfAd
         Hk5ZKT8Bpw0jwkxeLVGn9PP+spde/j3AXlRNu0OO3YC/4t+BI0+r3TYcZw+NvMcG3DQW
         GqGBclMNX0sIC/vccPvysPlRGw6bE62SYNdUvXnSc24fYRmAQOD8EI+yWKdGzdQQDwGH
         E+jZvde16i1YId1sSqBZk8+bF+1QRE4GKuwGQixrMkzb8GMUYJJq6hIJEFmMuu8R01H+
         xr3zkLUce9ff17AH/b+rx28BLQ1yRZ4FWgc/IRZssQuuO10oHOOSglwPfmfojNrpzSC+
         nJEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789017899; x=1789622699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Ef7cZ7LIz7YkH+5bkyed2cZws3jPF9j96GwnoqHnhY=;
        b=h2+4E1IVkvE8tfG4Derp0gVLmwaUa+NxVwtjRgpVR8uCA4Nyif5YUfOvS4PacAy1k7
         emH7ShA62R7FUWCP2ttN0m1bvdlkcm7BWQAJDsEVbdLB0Tw2tlb35aA+Wf+wkJ/GeIqx
         3AD2FB7nF8DbCN3r9RN0KzyAHDl7LvpCsUdsZ/e+/ZTCyppaJ7wcDb0cC2YoTmc8aGpI
         S0Yf1tq/FhCKOQqKqzM4rLSVBCwxSa7hYnWZo3oWlqJWsQ+LIKL2m1vI51QiVhiq/n5S
         pNvN0W1eGfSy1pWEwLKbOVRSLyvvKukGRlJ0IR4uYL5KKmjKEC93t5Duawh72dHzVjJy
         J8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789017899; x=1789622699;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Ef7cZ7LIz7YkH+5bkyed2cZws3jPF9j96GwnoqHnhY=;
        b=pVRoIKsEL16Pa31pujwGRYyGZC/h6bWP4xCh3K/2PcnoQXtu5MPX6gPHHAfAe2QRYm
         4GFj21MLsJ9voPLORnondZOFGiGtgAxQ9vw51NBMJH9oAL4pnACJkchyoXb9vkAES5+i
         n/Nsb50yO9BcS0UqLcINMVdoi6VAZ/GU72o2ZodSgpZds62fdRWckkN6h0JbmGQ7MXQ6
         DxvGQGV+JWiRcUxBnTIdT1s3r0CLMwBNTQ+j1e0TTWzTJm4ggHRKT3k+DW66UR/1t5/M
         ui2+TNofpddtwn0nv3kwVD5X92PRiusl0MPclC3DVGFqXxDScxVDVDy/XzHnO5jr8zmh
         j1sQ==
X-Forwarded-Encrypted: i=1; AKwUvByB03E9rSyHoqczgc/MiqmDsvCqGm5dk80o6urkfCvbko/uwxTyOkejRhLpRXosXssxuuxdVTiZ8LygxUG2@vger.kernel.org
X-Gm-Message-State: AFuF++nYF4ypYUcsO6ifxA7NAS1xmXcZkxaNFCN4Qdyj1X/QQCcHJhNy
	2d5AqpATlJLxEu5iraED9vDdqqPe1nHVwQYDSWsN3jqPKqrK/nEECfw17M/RX/kzSFGlB6n27XP
	2BmW9vGcgVyO/697FKlHoP6tx1gQlB+8bZi+XMXRH
X-Gm-Gg: AYBFou1KX0gzOnFC4h8Itk8faESBesJCavVut00BmChQA8VaHs3YcQThvV3/BNkgesg
	/8JYqxY6qOKeUaI0VwruARNL046hTx22nzw1jOKV8hXiU8/Bh6BTE7hjYob6vN68mJbkdFy4inE
	BESy9OIEu/M0CAo+weZiza9qj315zOltR3W+xdw9ZhnBpFQnzD1SxMpI9AJItkkxxvh6MbjwO6k
	9voRfD5AFei92PW/rAkIHcsemqXILXLm17D1+olQdwv/VezvJzV2TPeT9ZucJa/fzZgU9Kukjhj
	lQ7a5vqkwSaPdBOyp7Vj/tQeR40iW8rQ8GsCFPW4CTkqMRp62QgXBYI/a2Zkw14ReW1KvOad9yQ
	HExOoNKFryJOI5LF0GfQWOJO21xUqmTUXXfdGDX5DsLkVsOxSNzmS12Kx1+2MN+jr/hd7R4kq54
	7yLGWgZ3Ou7KUfwcGClD6cE9Lg
X-Received: by 2002:a17:90a:d00b:b0:399:221d:63c0 with SMTP id
 98e67ed59e1d1-39bac471324mr16616729a91.25.1789017898717; Wed, 09 Sep 2026
 22:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org> <20260909-work-unix-passpidfd-v2-3-7bd342abb2d1@kernel.org>
In-Reply-To: <20260909-work-unix-passpidfd-v2-3-7bd342abb2d1@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 9 Sep 2026 22:24:47 -0700
X-Gm-Features: AcwNN1WK9FWU9GOte1zZj9C0wAPvirY3Ssrn9oO6-a1S_kCBQm8kLil1vJJi-iM
Message-ID: <CAAVpQUAK8uhZtO+oza3=5qfZvxy+RHFQd2AQ2y9FpWKbK5jgyg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] net: add SO_PASSPIDFD_THREAD to get a
 thread-specific SCM_PIDFD
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
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/ua=
pi/asm/socket.h
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
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi=
/asm/socket.h
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
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/=
uapi/asm/socket.h
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
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/ua=
pi/asm/socket.h
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
> +  *    @sk_scm_pidfd_thread: flagged by SO_PASSPIDFD_THREAD to recv a th=
read SCM_PIDFD
>    *    @sk_scm_unused: unused flags for scm_recv()
>    *    @ns_tracker: tracker for netns reference
>    *    @sk_user_frags: xarray of pages the user is holding a reference o=
n.
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
> @@ -2986,6 +2988,12 @@ static inline bool sk_is_stream_unix(const struct =
sock *sk)
>         return sk_is_unix(sk) && sk->sk_type =3D=3D SOCK_STREAM;
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
>         return sk->sk_family =3D=3D AF_VSOCK;
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic=
/socket.h
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
>  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
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
> +       enum pid_type type =3D sk->sk_scm_pidfd_thread ? PIDTYPE_PID : PI=
DTYPE_TGID;
> +       struct pid *pid =3D scm->pid[type];
>         struct file *pidfd_file =3D NULL;
> +       unsigned int flags =3D PIDFD_STALE;

nit: Please keep the reverse xmas tree order.


>         int len, pidfd;
>
>         /* put_cmsg() doesn't return an error if CMSG is truncated,
> @@ -517,10 +521,13 @@ static void scm_pidfd_recv(struct msghdr *msg, stru=
ct scm_cookie *scm)
>                 return;
>         }
>
> -       if (!scm->pid[PIDTYPE_TGID])
> +       if (!pid)
>                 return;
>
> -       pidfd =3D pidfd_prepare(scm->pid[PIDTYPE_TGID], PIDFD_STALE, &pid=
fd_file);
> +       if (type =3D=3D PIDTYPE_PID)
> +               flags |=3D PIDFD_THREAD;

I'm wondering how this flag can be useful.

I thought this should be

  if (pid_has_task(pid, PIDTYPE_TGID))
    flags |=3D PIDFD_THREAD;

because when the sender sends TGID, this flag is set even though
it is a thread leader.

It seems PIDFD_THREAD is just feedback of whether the
receiver has set SO_PASSPIDFD or _THREAD, which the
application should already know.


> +
> +       pidfd =3D pidfd_prepare(pid, flags, &pidfd_file);
>
>         if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
>                 if (pidfd_file) {
> @@ -539,7 +546,7 @@ static bool __scm_recv_common(struct sock *sk, struct=
 msghdr *msg,
>                               struct scm_cookie *scm, int flags)
>  {
>         if (!msg->msg_control) {
> -               if (sk->sk_scm_credentials || sk->sk_scm_pidfd ||
> +               if (sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk) ||
>                     scm->fp || scm_has_secdata(sk))
>                         msg->msg_flags |=3D MSG_CTRUNC;
>
> @@ -586,8 +593,8 @@ void scm_recv_unix(struct socket *sock, struct msghdr=
 *msg,
>                 scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc)=
);
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
> @@ -1571,10 +1571,25 @@ int sk_setsockopt(struct sock *sk, int level, int=
 optname,
>                 break;
>
>         case SO_PASSPIDFD:
> -               if (sk_is_unix(sk))
> +               if (sk_is_unix(sk)) {
> +                       /* Mutually exclusive with SO_PASSPIDFD_THREAD. *=
/
>                         sk->sk_scm_pidfd =3D valbool;
> -               else
> +                       if (valbool)
> +                               sk->sk_scm_pidfd_thread =3D 0;
> +               } else {
> +                       ret =3D -EOPNOTSUPP;
> +               }
> +               break;
> +
> +       case SO_PASSPIDFD_THREAD:

If SO_PASSPIDFD had boolean check, it would have been possible
to reuse SO_PASSPIDFD=3D=3D2 as SO_PASSPIDFD_THREAD.

Given two options are mutually exclusive here, I think it's cleaner
to have u32 SO_PASSPIDFD_OPTIONS or something, which can
store 32 flags for future extension.

#define SO_PASSPIDFD_OPTION 86
#define SO_PASSPIDFD_THREAD 1

Then, sk_scm_pidfd_thread will be used in unix_skb_scm_eq()
and scm_pidfd_recv() only.


> +               if (sk_is_unix(sk)) {
> +                       /* Mutually exclusive with SO_PASSPIDFD. */
> +                       sk->sk_scm_pidfd_thread =3D valbool;
> +                       if (valbool)
> +                               sk->sk_scm_pidfd =3D 0;
> +               } else {
>                         ret =3D -EOPNOTSUPP;
> +               }
>                 break;
>
>         case SO_PASSRIGHTS:
> @@ -1892,6 +1907,13 @@ int sk_getsockopt(struct sock *sk, int level, int =
optname,
>                 v.val =3D sk->sk_scm_pidfd;
>                 break;
>
> +       case SO_PASSPIDFD_THREAD:
> +               if (!sk_is_unix(sk))
> +                       return -EOPNOTSUPP;
> +
> +               v.val =3D sk->sk_scm_pidfd_thread;
> +               break;
> +
>         case SO_PASSRIGHTS:
>                 if (!sk_is_unix(sk))
>                         return -EOPNOTSUPP;
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 011af84e3626..468a9c479b87 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -803,7 +803,7 @@ static void copy_peercred(struct sock *sk, struct soc=
k *peersk)
>
>  static bool unix_may_passcred(const struct sock *sk)
>  {
> -       return sk->sk_scm_credentials || sk->sk_scm_pidfd;
> +       return sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk);
>  }
>
>  static int unix_listen(struct socket *sock, int backlog)
> @@ -2048,9 +2048,14 @@ static int unix_maybe_add_creds(struct sk_buff *sk=
b, const struct sock *sk,
>         return 0;
>  }
>
> -static bool unix_skb_scm_eq(struct sk_buff *skb,
> +static bool unix_skb_scm_eq(const struct sock *sk, struct sk_buff *skb,
>                             struct scm_cookie *scm)
>  {
> +       /* Only a thread pidfd receiver can tell threads of one process a=
part. */
> +       if (sk->sk_scm_pidfd_thread &&
> +           UNIXCB(skb).pid[PIDTYPE_PID] !=3D scm->pid[PIDTYPE_PID])
> +               return false;
> +
>         return UNIXCB(skb).pid[PIDTYPE_TGID] =3D=3D scm->pid[PIDTYPE_TGID=
] &&
>                uid_eq(UNIXCB(skb).uid, scm->creds.uid) &&
>                gid_eq(UNIXCB(skb).gid, scm->creds.gid) &&
> @@ -3029,7 +3034,7 @@ static int unix_stream_read_generic(struct unix_str=
eam_read_state *state,
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
