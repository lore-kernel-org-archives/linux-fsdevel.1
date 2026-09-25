Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33B37E5E1;
	Fri, 25 Sep 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348580; cv=none; b=Er0vFsJFFDkDfYXNRPNRNxrdF8Y+KWagOGwO4uLBihI53mjPw0/26UuUfOADPev1TcBZ4yQ+gvVaYX/T0bT6t5WZIGgeDw/M9CfIpmskNXDw2BvQ4q9hmAqWG4hbIy+KMBIYF+VUAwsgfeXCCDjE4Mk19bqzYKivcYWZUZTS8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348580; c=relaxed/simple;
	bh=D+IvWrh3Xp3sts7ylIo0zH0HDPJr8QQjeGW8J16Yn28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBZhsbNM8jvv3lbLNC62OehEt8Y7zvU0+V3RBbu8vxm4s3LY7qlFsFGf2SSwll+gFKqRL5bdgEi5+ZXg3Lwe8ML9nxIupXBuOqnktj0ooNHl3H4CfIziCyeAxUcNU0TPLMC3jerg8O4FrCD95WLUGqqegbaQYb8qgJnZDOm0Gvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAssOL+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAssOL+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45591F000FF;
	Fri, 25 Sep 2026 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790348569;
	bh=1Vz14WVxEZ+5HsZOE4US0Akac5iAXwZOcYLBCs8xszg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TAssOL+akFZjsCyWoQFw2I9XAnuQbmOzaSTy2rgSydBphyGNYQEpDoucXHHyzfsc8
	 gWjptqyh/xCG1gu38M3pOkHofpVFUvUB+s2fPzRZTqrqc29R0Zv9wqY0D+gWaU0vjR
	 JEDvmg5tlNKWUkmcxWDqaMI0IHrqMGvKphm6Wmx2OngD+JD17rO3FvgkcTapBlgS0o
	 osrOCpJsrIOyvduqqXpgQWTP/ZtXlTT1kFzMl4gLDhA+wJrfYtrNAKA0/32YkHdzJh
	 5QbgSpbEFQnAEilCvPGxkjtWL3dJEhQvQpAxTyecj01EliwP5xQlxO11YgFFb3utNg
	 zkUstFF593+Gg==
Date: Fri, 25 Sep 2026 17:02:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrew Halaney <andrew@amutable.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v2 03/10] net: add SO_PASSPIDFD_THREAD to get a
 thread-specific SCM_PIDFD
Message-ID: <20260925-nutzen-fachbegriff-bauhof-2e7dd6d47390@brauner>
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
 <20260909-work-unix-passpidfd-v2-3-7bd342abb2d1@kernel.org>
 <CAAVpQUAK8uhZtO+oza3=5qfZvxy+RHFQd2AQ2y9FpWKbK5jgyg@mail.gmail.com>
 <arGuC7Kaml0N728m@toolbx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arGuC7Kaml0N728m@toolbx>

On Mon, Sep 21, 2026 at 05:25:34PM -0500, Andrew Halaney wrote:
> On Wed, Sep 09, 2026 at 10:24:47PM -0700, Kuniyuki Iwashima wrote:
> > On Wed, Sep 9, 2026 at 3:43 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > Currently, SCM_PIDFD carries a pidfd for the thread-group leader. A
> > > broker or the coredump server cannot learn the identity of the specific
> > > thread that sent a given message. Now that both struct pids are recorded
> > > a receiver can ask for the specific identity it needs.
> > >
> > > So add SO_PASSPIDFD_THREAD as a sibling of SO_PASSPIDFD. Either option
> > > makes recvmsg() deliver an SCM_PIDFD. SO_PASSPIDFD sends a pidfd for the
> > > thread-group leader and SO_PASSPIDFD_THREAD sends a pidfd for the
> > > specific thread.
> > >
> > > The two options are mutually exclusive. Enabling one switches the other
> > > off, so getsockopt() always reports which of the two is active.
> > >
> > > On SOCK_STREAM sockets recvmsg() only stops merging data at a thread
> > > boundary when the receiver asked for a thread pidfd. For SO_PASSCRED and
> > > SO_PASSPIDFD receivers all threads of one process remain a single
> > > writer.
> > >
> > > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > > ---
> > >  arch/alpha/include/uapi/asm/socket.h  |  2 ++
> > >  arch/mips/include/uapi/asm/socket.h   |  2 ++
> > >  arch/parisc/include/uapi/asm/socket.h |  2 ++
> > >  arch/sparc/include/uapi/asm/socket.h  |  2 ++
> > >  include/net/sock.h                    | 10 +++++++++-
> > >  include/uapi/asm-generic/socket.h     |  2 ++
> > >  net/core/scm.c                        | 19 +++++++++++++------
> > >  net/core/sock.c                       | 26 ++++++++++++++++++++++++--
> > >  net/unix/af_unix.c                    | 11 ++++++++---
> > >  9 files changed, 64 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> > > index 946a5fad2691..bb3d534826bb 100644
> > > --- a/arch/alpha/include/uapi/asm/socket.h
> > > +++ b/arch/alpha/include/uapi/asm/socket.h
> > > @@ -157,6 +157,8 @@
> > >
> > >  #define SO_RIGHTS_NOTRUNC      85
> > >
> > > +#define SO_PASSPIDFD_THREAD    86
> > > +
> > >  #if !defined(__KERNEL__)
> > >
> > >  #if __BITS_PER_LONG == 64
> > > diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> > > index f1641dde135f..269badcaa086 100644
> > > --- a/arch/mips/include/uapi/asm/socket.h
> > > +++ b/arch/mips/include/uapi/asm/socket.h
> > > @@ -168,6 +168,8 @@
> > >
> > >  #define SO_RIGHTS_NOTRUNC      85
> > >
> > > +#define SO_PASSPIDFD_THREAD    86
> > > +
> > >  #if !defined(__KERNEL__)
> > >
> > >  #if __BITS_PER_LONG == 64
> > > diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> > > index f3a3815c7dc2..313aee10a52c 100644
> > > --- a/arch/parisc/include/uapi/asm/socket.h
> > > +++ b/arch/parisc/include/uapi/asm/socket.h
> > > @@ -149,6 +149,8 @@
> > >
> > >  #define SO_RIGHTS_NOTRUNC      0x4053
> > >
> > > +#define SO_PASSPIDFD_THREAD    0x4054
> > > +
> > >  #if !defined(__KERNEL__)
> > >
> > >  #if __BITS_PER_LONG == 64
> > > diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> > > index 7907f3b1f0ee..bd3e69bcce7a 100644
> > > --- a/arch/sparc/include/uapi/asm/socket.h
> > > +++ b/arch/sparc/include/uapi/asm/socket.h
> > > @@ -150,6 +150,8 @@
> > >
> > >  #define SO_RIGHTS_NOTRUNC        0x005e
> > >
> > > +#define SO_PASSPIDFD_THREAD      0x005f
> > > +
> > >  #if !defined(__KERNEL__)
> > >
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 51185222aac2..fc09c92e8a83 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -356,6 +356,7 @@ struct sk_filter;
> > >    *    @sk_scm_security: flagged by SO_PASSSEC to recv SCM_SECURITY
> > >    *    @sk_scm_pidfd: flagged by SO_PASSPIDFD to recv SCM_PIDFD
> > >    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
> > > +  *    @sk_scm_pidfd_thread: flagged by SO_PASSPIDFD_THREAD to recv a thread SCM_PIDFD
> > >    *    @sk_scm_unused: unused flags for scm_recv()
> > >    *    @ns_tracker: tracker for netns reference
> > >    *    @sk_user_frags: xarray of pages the user is holding a reference on.
> > > @@ -562,7 +563,8 @@ struct sock {
> > >                                 sk_scm_security : 1,
> > >                                 sk_scm_pidfd : 1,
> > >                                 sk_scm_rights : 1,
> > > -                               sk_scm_unused : 4;
> > > +                               sk_scm_pidfd_thread : 1,
> > > +                               sk_scm_unused : 3;
> > >                 };
> > >         };
> > >         u8                      sk_clockid;
> > > @@ -2986,6 +2988,12 @@ static inline bool sk_is_stream_unix(const struct sock *sk)
> > >         return sk_is_unix(sk) && sk->sk_type == SOCK_STREAM;
> > >  }
> > >
> > > +/* SO_PASSPIDFD or SO_PASSPIDFD_THREAD asked for an SCM_PIDFD. */
> > > +static inline bool sk_scm_pidfd_wanted(const struct sock *sk)
> > > +{
> > > +       return sk->sk_scm_pidfd || sk->sk_scm_pidfd_thread;
> > > +}
> > > +
> > >  static inline bool sk_is_vsock(const struct sock *sk)
> > >  {
> > >         return sk->sk_family == AF_VSOCK;
> > > diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> > > index 84ea7b92936e..d1e5c6de146d 100644
> > > --- a/include/uapi/asm-generic/socket.h
> > > +++ b/include/uapi/asm-generic/socket.h
> > > @@ -152,6 +152,8 @@
> > >
> > >  #define SO_RIGHTS_NOTRUNC      85
> > >
> > > +#define SO_PASSPIDFD_THREAD    86
> > > +
> > >  #if !defined(__KERNEL__)
> > >
> > >  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> > > diff --git a/net/core/scm.c b/net/core/scm.c
> > > index 9b9e119c353a..d69768414af4 100644
> > > --- a/net/core/scm.c
> > > +++ b/net/core/scm.c
> > > @@ -499,9 +499,13 @@ static bool scm_has_secdata(struct sock *sk)
> > >  }
> > >  #endif
> > >
> > > -static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
> > > +static void scm_pidfd_recv(struct sock *sk, struct msghdr *msg,
> > > +                          struct scm_cookie *scm)
> > >  {
> > > +       enum pid_type type = sk->sk_scm_pidfd_thread ? PIDTYPE_PID : PIDTYPE_TGID;
> > > +       struct pid *pid = scm->pid[type];
> > >         struct file *pidfd_file = NULL;
> > > +       unsigned int flags = PIDFD_STALE;
> > 
> > nit: Please keep the reverse xmas tree order.
> > 
> > 
> > >         int len, pidfd;
> > >
> > >         /* put_cmsg() doesn't return an error if CMSG is truncated,
> > > @@ -517,10 +521,13 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
> > >                 return;
> > >         }
> > >
> > > -       if (!scm->pid[PIDTYPE_TGID])
> > > +       if (!pid)
> > >                 return;
> > >
> > > -       pidfd = pidfd_prepare(scm->pid[PIDTYPE_TGID], PIDFD_STALE, &pidfd_file);
> > > +       if (type == PIDTYPE_PID)
> > > +               flags |= PIDFD_THREAD;
> > 
> > I'm wondering how this flag can be useful.
> > 
> > I thought this should be
> > 
> >   if (pid_has_task(pid, PIDTYPE_TGID))
> >     flags |= PIDFD_THREAD;
> > 
> > because when the sender sends TGID, this flag is set even though
> > it is a thread leader.
> > 
> > It seems PIDFD_THREAD is just feedback of whether the
> > receiver has set SO_PASSPIDFD or _THREAD, which the
> > application should already know.
> > 
> 
> Isn't this flag necessary to indicate how to handle signals? i.e. its acting like
> PIDFD_THREAD acquired pidfds defaulting to pidfd_send_signal() with
> PIDFD_SIGNAL_THREAD. userspace can even read that back with fcntl() so
> if you were to pass the pidfd around with SCM_RIGHTS, etc the other end knows
> what type of pidfd they've gotten.
> 
> > 
> > > +
> > > +       pidfd = pidfd_prepare(pid, flags, &pidfd_file);
> > >
> > >         if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
> > >                 if (pidfd_file) {
> > > @@ -539,7 +546,7 @@ static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
> > >                               struct scm_cookie *scm, int flags)
> > >  {
> > >         if (!msg->msg_control) {
> > > -               if (sk->sk_scm_credentials || sk->sk_scm_pidfd ||
> > > +               if (sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk) ||
> > >                     scm->fp || scm_has_secdata(sk))
> > >                         msg->msg_flags |= MSG_CTRUNC;
> > >
> > > @@ -586,8 +593,8 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
> > >                 scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc));
> > >         }
> > >
> > > -       if (sock->sk->sk_scm_pidfd)
> > > -               scm_pidfd_recv(msg, scm);
> > > +       if (sk_scm_pidfd_wanted(sock->sk))
> > > +               scm_pidfd_recv(sock->sk, msg, scm);
> > >
> > >         scm_destroy_cred(scm);
> > >  }
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 1ad41904db25..f9615b0de10e 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -1571,10 +1571,25 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
> > >                 break;
> > >
> > >         case SO_PASSPIDFD:
> > > -               if (sk_is_unix(sk))
> > > +               if (sk_is_unix(sk)) {
> > > +                       /* Mutually exclusive with SO_PASSPIDFD_THREAD. */
> > >                         sk->sk_scm_pidfd = valbool;
> > > -               else
> > > +                       if (valbool)
> > > +                               sk->sk_scm_pidfd_thread = 0;
> > > +               } else {
> > > +                       ret = -EOPNOTSUPP;
> > > +               }
> > > +               break;
> > > +
> > > +       case SO_PASSPIDFD_THREAD:
> > 
> > If SO_PASSPIDFD had boolean check, it would have been possible
> > to reuse SO_PASSPIDFD==2 as SO_PASSPIDFD_THREAD.
> > 
> > Given two options are mutually exclusive here, I think it's cleaner
> > to have u32 SO_PASSPIDFD_OPTIONS or something, which can
> > store 32 flags for future extension.
> > 
> > #define SO_PASSPIDFD_OPTION 86
> > #define SO_PASSPIDFD_THREAD 1
> > 
> > Then, sk_scm_pidfd_thread will be used in unix_skb_scm_eq()
> > and scm_pidfd_recv() only.
> 
> 
> Are they really mutually exclusive? I could see a world where
> maybe you want both set. If we do treat it as exclusive is it
> a last option wins sort of thing?
> 
> i.e.:
> 
>     1. set SO_PASSPIDFD
>     2. set SO_PASSPIDFD_OPTION with SO_PASSPIDFD_THREAD
> 
> does that just result in a SCM_PIDFD related to the thread?
> and then if we do a SO_PASSPIDFD_OPTION with 0, does that
> just stop sending the cmsg at all (or does it go back to SO_PASSPIDFD)?
> 
> To me it would be kind of nice if they were unique / independent,
> i.e. if you did the above you'd get SCM_PIDFD and SCM_PIDFD_THREAD type as well

I agree that's the nicer model!
