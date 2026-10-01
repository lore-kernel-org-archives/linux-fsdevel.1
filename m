Received: from mail-dy2-f26.google.com (mail-dy2-f26.google.com [74.125.229.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39523C0621
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 04:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827654; cv=pass; b=S7AS4C6V2Jd9CSYW0yTtTQXJXwJlQf/Dz2Il07HfKz7DFtKxuD6kz2nswEM8YFr2pzUVBS9hUzgONYjTo9DN4R9yvrzLOK8ywwF+ovN8gc2CubkQZ3tYW2UkXmfPd2clHWB8foKEEw13R01tWbKBhrW7Y4e74DNCoYHT4Tp2QlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827654; c=relaxed/simple;
	bh=YkjwWReI3QCWe09zXhFij7zBQpgeEk4qxmf2p0+9+QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlZF2/3rAUE+vXbAkks974GqGetSAkQrucSoSXSUzC4zMXKdF3J1+6ID58l3AUg8U6v9KfFjyKzsCy5VPUfyanPtGp1tLU5MfpvX/ajSPFigLnB4qIzds43GfuCHPN31TjM0qZoPYJmtgWAV0TTBsk/jrGX5F24NK2oQCrzirrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JV3Z05GU; arc=pass smtp.client-ip=74.125.229.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JV3Z05GU"
Received: by mail-dy2-f26.google.com with SMTP id 5a478bee46e88-34b14db40daso1303544eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 21:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790827652; cv=none;
        d=google.com; s=arc-20260327;
        b=bXjJkxYumugWJdBnyOafRBe2D3SDRe251VL+sNk7vmZXFfbEH7NaM7LPmsmS1PX5CC
         ecUqj0SCSzJ2dRuwKZBNz83ERxnzvHuXpKvMuubyH+d6oJcUY6vVxtvVlyqqXLXeFsNk
         NJdhlQ9BqJXq4yZkdVfIS94HfTu1mxRESfNUthbUE9G8dTjOeuZGtgNmCKTOdEjgpsZh
         LcBDXXIeOtUy8FLMTL8ZtSvHnWxQ4R/APkAvzRyXIEFughbcWuYdRQ0YhhTDbJf49Kop
         I1qFCZyz/TMhwV7pZegQAEhEJ3AuKT5yb1aF6dtQNdbFw4noSLp7DnTpr/0QytfKCOXW
         gZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l3eHEQ2bOwj9/vcLYd/rAmE7Mn4xynnjMzE65jNbwTA=;
        fh=H+dUZEQm01uE8dKZkdskei/3bBpKA0jTJREpfKeLKjU=;
        b=AzYke1Pm+X2bBiNvjj8XjdgU3KLMD4O5NiZ5P38kb6wUNFxfGUkszQYNO15upAGb48
         /E/uLnJqY4/4gnfo7KfNu3L8n27uOeFpG1qKjF3Fw3yTO/e/iZb+Z4SlwpXOeLxLuICI
         QwuGKJIkvqzKJwUA4svXygAjVJhZtJTtlzXDarPgc9pYxdZcP3p9KATjJesEy2IE3APW
         2DguDaSz0H+3umF2ljTPzJBMriQ6wUC5H+upeMC0TNTtZ7uQZFg3i7tPYIM1TXY/UXFP
         FcTsz7tVFUm6Him+7duc4Sw3/agUBFdtyPjSFCGcutIfuMV1VeC1kjYbsAh/Q+/8RRfx
         eRXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790827652; x=1791432452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l3eHEQ2bOwj9/vcLYd/rAmE7Mn4xynnjMzE65jNbwTA=;
        b=JV3Z05GUW+Y36/wF26IbWgxoD9CNE4bYeY+nw7YMNBKhaowZWnugmdsGUve768KqrJ
         5EeA3T+IvwublPwJxLHD3cJ5I61d45TXmdH1j5kEjgRi+MEkn3vIabiM/RW1lCipWSN1
         vKo2EeCoTrGWYw/1Qe1DkG+pLwvbcC3cCxELCedU3qERXC9Y2oJtgS/vvAPVgCba8s5z
         RhjASzQ61lTPUhAkr2ounEn0X8pGvggeQMIpC96Vy2ydgpMsWPg/nb7u3wvHOD4S4GnX
         Sw4scku6dr6nhQv3RqnGYxK8m8LsW/OH48Q0slDQSvAOnQ+53jINtnr7mCSKBwrQuBCP
         WY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827652; x=1791432452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l3eHEQ2bOwj9/vcLYd/rAmE7Mn4xynnjMzE65jNbwTA=;
        b=vILzNcpryny9tFRObF9OBZvgldbI+22D5uo5iKIKdlaMbSY/yuM33wbcslgDOB1gZD
         tJVx4x6yKVGwgmIfxsAUkJYbn1Ve/Lw8r2A7b4mEuXT1aygwcRY2xssBiA78iByHZGPL
         bxgNX70idafFehWJRmOLlZmYO5+bbVNa4Pgtgpok2A4oA5MMYlEi4p0ZFS2/t8j+xYd/
         iBE3yQLfRNbO9D5C+9cK7BMS57y7Xg+QMSMSPgRjMA5rFKvQDlJHXUVHyaShT3NpcmxM
         2Va1OM+SflDmyjW5448G68xLAd/prMvedBvjM/UArDHoBa6560pFxNkM0UODtzHYMxZf
         2wiQ==
X-Forwarded-Encrypted: i=1; AKwUvBwW35O5kf7XFCUosU/Cxmye2b3OenkUqVpNAG4UgN6M6xvvYQS/MHKLeKLex1ABWmIO3DQ2i3CioOhKUmI3@vger.kernel.org
X-Gm-Message-State: AFuF++meP67SuR8Zwy8nmtAa2EFwVQOj1Iln5DJAntREWM9i24pDRZ/m
	C0oK8wac0uLtulb7mmxfusz3tYfVVV3g8H2A5wTso7pnrkiHnrLX5Jh/BUQu5VeZQXPdSbYOwHR
	ECaf+0Z8/TJm+OWvJQ345c/Awwng1BpNDAFRquKFA
X-Gm-Gg: AYBFou3dP3Zt3ABXipZlbRs2ukfwrLxUjIkYsdPT6g9zumblfam/sfVMYjalWMFUdQ3
	ZXAooRexdBx+6ikQHOUoDj2c64KaSme7ZUOwaM7ceWaeTsAM7bzPk8eOZ0WTk1kAUBLJyit+G7a
	8nYZHQ6PUPOp1jCGyD89Oos6/pVqiJg3MyhM3YmGB1kwJr9aNqONaXKPFTq+f05kqS9YyssTVHE
	mxr1gg/vhOk0ePmUdhSqWRPSbz2I7nbDAKq4/XxaP53HVxOIneLwx+cR65WuUOHDIcCxbr3dstr
	zTdz0tDajJ7/kAiGVb+1auXoGQJEVISEooXCshyFW95hxDv7gLRsjvWN2ZXowPpC5vpKsdfIrXT
	KiSDO9L1SQnQY1ZXTOK7L4pJISGyMfxgQAB3xFEnQJF4+KSS8ig+/GIHNvui2jP/cqS55
X-Received: by 2002:a05:701a:ca84:b0:14c:c588:ac21 with SMTP id
 a92af1059eb24-14dce417c07mr1975649c88.9.1790827650908; Wed, 30 Sep 2026
 21:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com> <20260928-work-unix-passpidfd-v3-3-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-3-532018a91b21@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 21:07:19 -0700
X-Gm-Features: AclHuK8CKaHPn8rIHrieWjCFAbNwMyqoXGSxvwRgSsHDQA6Esio0zaSdSQcr7pA
Message-ID: <CAAVpQUDJ=vBuXUSTyURa6-dYbpV8+ZshXW0vcVAgmLsri2A17g@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] net: add SO_PASSPIDFD_THREAD to get a
 thread-specific SCM_PIDFD
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:27=E2=80=AFAM Andrew Halaney <andrew@amutable.com=
> wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Currently, SCM_PIDFD carries a pidfd for the thread-group leader. A
> broker or the coredump server cannot learn the identity of the specific
> thread that sent a given message. Now that both struct pids are recorded
> a receiver can ask for the specific identity it needs.
>
> So add SO_PASSPIDFD_THREAD as a sibling of SO_PASSPIDFD.
> SO_PASSPIDFD_THREAD delivers an SCM_PIDFD_THREAD, i.e. scoped
> to the specific thread sending. This is completely independent of
> SO_PASSPIDFD, meaning you can use both options and get both cmsgs.
>
> On SOCK_STREAM sockets recvmsg() only stops merging data at a thread
> boundary when the receiver asked for a thread pidfd. For SO_PASSCRED and
> SO_PASSPIDFD receivers all threads of one process remain a single
> writer.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Co-developed-by: Andrew Halaney <andrew@amutable.com>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  2 ++
>  arch/mips/include/uapi/asm/socket.h   |  2 ++
>  arch/parisc/include/uapi/asm/socket.h |  2 ++
>  arch/sparc/include/uapi/asm/socket.h  |  2 ++
>  include/linux/socket.h                |  9 +++++----
>  include/net/sock.h                    | 14 +++++++++++++-
>  include/uapi/asm-generic/socket.h     |  2 ++
>  net/core/scm.c                        | 27 +++++++++++++++++++--------
>  net/core/sock.c                       | 14 ++++++++++++++
>  net/unix/af_unix.c                    | 12 +++++++++---
>  10 files changed, 70 insertions(+), 16 deletions(-)
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
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 5a5eb1250103..b17fdb7d38a7 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -189,10 +189,11 @@ static inline size_t msg_data_left(const struct msg=
hdr *msg)
>
>  /* "Socket"-level control message types: */
>
> -#define        SCM_RIGHTS      0x01            /* rw: access rights (arr=
ay of int) */
> -#define SCM_CREDENTIALS 0x02           /* rw: struct ucred             *=
/
> -#define SCM_SECURITY   0x03            /* rw: security label           *=
/
> -#define SCM_PIDFD      0x04            /* ro: pidfd (int)              *=
/
> +#define        SCM_RIGHTS              0x01    /* rw: access rights (arr=
ay of int) */
> +#define SCM_CREDENTIALS                0x02    /* rw: struct ucred      =
       */
> +#define SCM_SECURITY           0x03    /* rw: security label           *=
/
> +#define SCM_PIDFD              0x04    /* ro: pidfd (int)              *=
/
> +#define SCM_PIDFD_THREAD       0x05    /* ro: thread pidfd (int)       *=
/
>
>  struct ucred {
>         __u32   pid;
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 60ea55dc1885..14df0fb68259 100644
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
> @@ -2988,6 +2990,16 @@ static inline bool sk_is_stream_unix(const struct =
sock *sk)
>         return sk_is_unix(sk) && sk->sk_type =3D=3D SOCK_STREAM;
>  }
>
> +static inline bool sk_scm_pidfd_wanted(const struct sock *sk)
> +{
> +       return sk->sk_scm_pidfd;
> +}
> +
> +static inline bool sk_scm_pidfd_thread_wanted(const struct sock *sk)
> +{
> +       return sk->sk_scm_pidfd_thread;
> +}

nit: remove these helpers and use the values directly.

Unlike scm_has_secdata(), the fields do not depend on any config.


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
> index 9b9e119c353a..ba43d76027af 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -499,11 +499,16 @@ static bool scm_has_secdata(struct sock *sk)
>  }
>  #endif
>
> -static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
> +static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm,
> +                          enum pid_type type, int cmsg_type)
>  {
> +       unsigned int flags =3D PIDFD_STALE;
>         struct file *pidfd_file =3D NULL;
> +       struct pid *pid;
>         int len, pidfd;
>
> +       pid =3D scm->pid[type];
> +
>         /* put_cmsg() doesn't return an error if CMSG is truncated,
>          * that's why we need to opencode these checks here.
>          */
> @@ -517,12 +522,15 @@ static void scm_pidfd_recv(struct msghdr *msg, stru=
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
>
> -       if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
> +       pidfd =3D pidfd_prepare(pid, flags, &pidfd_file);
> +
> +       if (put_cmsg(msg, SOL_SOCKET, cmsg_type, sizeof(int), &pidfd)) {
>                 if (pidfd_file) {
>                         put_unused_fd(pidfd);
>                         fput(pidfd_file);
> @@ -539,8 +547,8 @@ static bool __scm_recv_common(struct sock *sk, struct=
 msghdr *msg,
>                               struct scm_cookie *scm, int flags)
>  {
>         if (!msg->msg_control) {
> -               if (sk->sk_scm_credentials || sk->sk_scm_pidfd ||
> -                   scm->fp || scm_has_secdata(sk))
> +               if (sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk) ||
> +                   sk_scm_pidfd_thread_wanted(sk) || scm->fp || scm_has_=
secdata(sk))
>                         msg->msg_flags |=3D MSG_CTRUNC;
>
>                 scm_destroy(scm);
> @@ -586,8 +594,11 @@ void scm_recv_unix(struct socket *sock, struct msghd=
r *msg,
>                 scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc)=
);
>         }
>
> -       if (sock->sk->sk_scm_pidfd)
> -               scm_pidfd_recv(msg, scm);
> +       if (sk_scm_pidfd_wanted(sock->sk))
> +               scm_pidfd_recv(msg, scm, PIDTYPE_TGID, SCM_PIDFD);
> +
> +       if (sk_scm_pidfd_thread_wanted(sock->sk))
> +               scm_pidfd_recv(msg, scm, PIDTYPE_PID, SCM_PIDFD_THREAD);
>
>         scm_destroy_cred(scm);
>  }
> diff --git a/net/core/sock.c b/net/core/sock.c
> index d23333bb4f3f..3b5f28573752 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1578,6 +1578,13 @@ int sk_setsockopt(struct sock *sk, int level, int =
optname,
>                         ret =3D -EOPNOTSUPP;
>                 break;
>
> +       case SO_PASSPIDFD_THREAD:
> +               if (sk_is_unix(sk))
> +                       sk->sk_scm_pidfd_thread =3D valbool;
> +               else
> +                       ret =3D -EOPNOTSUPP;
> +               break;
> +
>         case SO_PASSRIGHTS:
>                 if (sk_is_unix(sk))
>                         sk->sk_scm_rights =3D valbool;
> @@ -1893,6 +1900,13 @@ int sk_getsockopt(struct sock *sk, int level, int =
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
> index c7d423465859..6cc2873d9a4f 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -803,7 +803,8 @@ static void copy_peercred(struct sock *sk, struct soc=
k *peersk)
>
>  static bool unix_may_passcred(const struct sock *sk)
>  {
> -       return sk->sk_scm_credentials || sk->sk_scm_pidfd;
> +       return sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk) ||
> +               sk_scm_pidfd_thread_wanted(sk);
>  }
>
>  static int unix_listen(struct socket *sock, int backlog)
> @@ -2048,9 +2049,14 @@ static int unix_maybe_add_creds(struct sk_buff *sk=
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
> @@ -3033,7 +3039,7 @@ static int unix_stream_read_generic(struct unix_str=
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
> 2.55.0
>
