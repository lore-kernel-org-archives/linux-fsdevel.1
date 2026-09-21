Received: from mail-yx2-f5.google.com (mail-yx2-f5.google.com [74.125.224.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2646F51DB17
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029531; cv=none; b=aQUdPHGjsNm4t7DpLJ+N1ypn11EOSy4gEgoEH9Q5BdQPXT2+lm7n7qLPubhWsJ4cu6pGPwxilQ6PhvOsY6npWuVgQAFGufXidGRlSnIYPCG2pvfxhshgQedECXjOC89ZeuukWXpLaQi2EzQGInUEpZPPdOE7FoGU9Y+734FqFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029531; c=relaxed/simple;
	bh=PT3W/nO28TBwi5wqZrs3EjZOULa8Pkq0O82+HXOv7bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qfcl/lD/WNSM0UQYIKg3floXmgelErjPFRDJQ/S2tlq3iymq8bDvpl3rea15usLkrkXynuO1BF+LRU34E19/GLP7P9fXjNi4LRICLjneThD6pgofOKT8zv0ohc/7ePNOo6rLBRA8cEBY7isLSTwCw5acVLyvk+BiSlbn1/Zpys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=dYLFD8ta; arc=none smtp.client-ip=74.125.224.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="dYLFD8ta"
Received: by mail-yx2-f5.google.com with SMTP id 00721157ae682-86337316fceso2785937b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790029528; x=1790634328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yHGVqmok/0GVfDYu2EI5EhSCaWnpiCB5OMGPCzXLcFA=;
        b=dYLFD8taDP+waPb3luhu6g6oxSOEHhlH8EdTMH7rlkTwPvU7xO6on56eNDEoXOTvYe
         dIGjrWsfI0oEgOSGFBMxejvziW00PCTgzB6YIshNU/1ipQiH+dCaHq6Z1Lnqz54NRC4R
         YV2wK1q9WwY/ncmdIw7T6briUT8lou8wd7TRLd2+FI3YvvCMzYOO/78J30VlptFUW7dg
         lK4iJGaB73jVfqP5Le+TMc6qmoEpr967YwCoYqYqo8eIy1T5xQsmWKpGRKQyhyqZwSc8
         nP5FNv4Gv2HbysRqJaBpepSTrtwW5p7sZ5BWvAWGoyAgvtqvv3Dwl2ckGVCPfPmvzSM/
         DQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790029528; x=1790634328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yHGVqmok/0GVfDYu2EI5EhSCaWnpiCB5OMGPCzXLcFA=;
        b=qNhoo8fYhS0L1e30T0oFDJpr98wsMcsLJ6LsvYQ/B9LjxL4u7rlBC9YOtDljDdpkCf
         LB0jsm87qpLE8t8H4oHPMcIMQIBWIgN3WAUkZP57aKmAy4FRaXYNnrKraMvSJ+sdK4DH
         sRqDHh6F4iCh/0qmoLj0qC+2MD8BbAcEYJYRXAWNfsh2DrBys5bN7dugwJJNvZxdB5J9
         ZgPMNYdiCbqRVLCXRwS+mdpYeUe187D8XCI+q+9ykYEuLFJGFiq5ymRGU5pV2sSku5Kh
         /V5uDcCTGv0uTr6cqbBg8uqOGBszvz/8l8AK24Iiefl848kd0lSBMKSti34/oIflu68q
         fgKA==
X-Forwarded-Encrypted: i=1; AKwUvBxWZ0TL7Dndj9plSIUMFXkGMuHZxASFl//MaxHyZxxku+14spJfESQahEE9rlzbBeWNmXYeo3pmI48aDMh0@vger.kernel.org
X-Gm-Message-State: AFuF++mlIn5kuPCWwMJlnUQZWFWkLjRE8wlfpYykwmYpIWQQJ8Lo7apa
	9sTZz+YcStO7EP+imXIGekn7ideF/3YsBZTeumdr1vrKPyyyMfLMj9It0QzZJKBoFXFw
X-Gm-Gg: AYBFou0GN568QFvaleuILtkaT40viiPOm58BvdQzHK/ib08jq2CxcvhPBmiSKR0T72/
	+v9xXkcFldXBm+vLrthspR1gfDTibp6AHVn1bgLJwqPFClX31PZWP5uwxMPXQGov12N3dDB1kQf
	gcksSiSGet+hOZ5iCteBggHDCJ3Ydor/KVlr3PntRo58PkPP3YrK5NbOyTEPuTtvohCIbcNTbCv
	asEdmApJV0eM6v/Hh8JTofKRyuoxtXzC/kesfOtCDw32OHtEbkMBhQMwaTPgUc3x1z50Y7ZkTq5
	AvL90v2ZZ+kLTWBim2Uyk5W+/nyiW1yE1S/gWj67ZMeZ+mJKy1YDOkRSLwsXjS+eEetA/hpIpY9
	nZjfsR3/qAeCNL3cxs/UQQxGsH2wqb07TgukuwsWQEsHnsuH9QkC0tIcQ+T+jdgiwX817zPso3r
	VZDNsp8Xp8T2hP2L+3O84P37aIoR4um1OUCAUf+nQMeTYiZyiGwzGxZXEaaeKPVyKFXUKKlPzqM
	+vpxTpUOftIU8iAcQP56fgtqTtSWY+qOqGbjnRwkpI=
X-Received: by 2002:a05:690c:e20b:20b0:873:5c6b:a324 with SMTP id 00721157ae682-8a1f902f70emr4003017b3.30.1790029527751;
        Mon, 21 Sep 2026 15:25:27 -0700 (PDT)
Received: from toolbx (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a23e676c72sm2049217b3.33.2026.09.21.15.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 15:25:27 -0700 (PDT)
Date: Mon, 21 Sep 2026 17:25:34 -0500
From: Andrew Halaney <andrew@amutable.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v2 03/10] net: add SO_PASSPIDFD_THREAD to get a
 thread-specific SCM_PIDFD
Message-ID: <arGuC7Kaml0N728m@toolbx>
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
 <20260909-work-unix-passpidfd-v2-3-7bd342abb2d1@kernel.org>
 <CAAVpQUAK8uhZtO+oza3=5qfZvxy+RHFQd2AQ2y9FpWKbK5jgyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUAK8uhZtO+oza3=5qfZvxy+RHFQd2AQ2y9FpWKbK5jgyg@mail.gmail.com>

On Wed, Sep 09, 2026 at 10:24:47PM -0700, Kuniyuki Iwashima wrote:
> On Wed, Sep 9, 2026 at 3:43 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Currently, SCM_PIDFD carries a pidfd for the thread-group leader. A
> > broker or the coredump server cannot learn the identity of the specific
> > thread that sent a given message. Now that both struct pids are recorded
> > a receiver can ask for the specific identity it needs.
> >
> > So add SO_PASSPIDFD_THREAD as a sibling of SO_PASSPIDFD. Either option
> > makes recvmsg() deliver an SCM_PIDFD. SO_PASSPIDFD sends a pidfd for the
> > thread-group leader and SO_PASSPIDFD_THREAD sends a pidfd for the
> > specific thread.
> >
> > The two options are mutually exclusive. Enabling one switches the other
> > off, so getsockopt() always reports which of the two is active.
> >
> > On SOCK_STREAM sockets recvmsg() only stops merging data at a thread
> > boundary when the receiver asked for a thread pidfd. For SO_PASSCRED and
> > SO_PASSPIDFD receivers all threads of one process remain a single
> > writer.
> >
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  arch/alpha/include/uapi/asm/socket.h  |  2 ++
> >  arch/mips/include/uapi/asm/socket.h   |  2 ++
> >  arch/parisc/include/uapi/asm/socket.h |  2 ++
> >  arch/sparc/include/uapi/asm/socket.h  |  2 ++
> >  include/net/sock.h                    | 10 +++++++++-
> >  include/uapi/asm-generic/socket.h     |  2 ++
> >  net/core/scm.c                        | 19 +++++++++++++------
> >  net/core/sock.c                       | 26 ++++++++++++++++++++++++--
> >  net/unix/af_unix.c                    | 11 ++++++++---
> >  9 files changed, 64 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> > index 946a5fad2691..bb3d534826bb 100644
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -157,6 +157,8 @@
> >
> >  #define SO_RIGHTS_NOTRUNC      85
> >
> > +#define SO_PASSPIDFD_THREAD    86
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG == 64
> > diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> > index f1641dde135f..269badcaa086 100644
> > --- a/arch/mips/include/uapi/asm/socket.h
> > +++ b/arch/mips/include/uapi/asm/socket.h
> > @@ -168,6 +168,8 @@
> >
> >  #define SO_RIGHTS_NOTRUNC      85
> >
> > +#define SO_PASSPIDFD_THREAD    86
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG == 64
> > diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> > index f3a3815c7dc2..313aee10a52c 100644
> > --- a/arch/parisc/include/uapi/asm/socket.h
> > +++ b/arch/parisc/include/uapi/asm/socket.h
> > @@ -149,6 +149,8 @@
> >
> >  #define SO_RIGHTS_NOTRUNC      0x4053
> >
> > +#define SO_PASSPIDFD_THREAD    0x4054
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG == 64
> > diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> > index 7907f3b1f0ee..bd3e69bcce7a 100644
> > --- a/arch/sparc/include/uapi/asm/socket.h
> > +++ b/arch/sparc/include/uapi/asm/socket.h
> > @@ -150,6 +150,8 @@
> >
> >  #define SO_RIGHTS_NOTRUNC        0x005e
> >
> > +#define SO_PASSPIDFD_THREAD      0x005f
> > +
> >  #if !defined(__KERNEL__)
> >
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 51185222aac2..fc09c92e8a83 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -356,6 +356,7 @@ struct sk_filter;
> >    *    @sk_scm_security: flagged by SO_PASSSEC to recv SCM_SECURITY
> >    *    @sk_scm_pidfd: flagged by SO_PASSPIDFD to recv SCM_PIDFD
> >    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
> > +  *    @sk_scm_pidfd_thread: flagged by SO_PASSPIDFD_THREAD to recv a thread SCM_PIDFD
> >    *    @sk_scm_unused: unused flags for scm_recv()
> >    *    @ns_tracker: tracker for netns reference
> >    *    @sk_user_frags: xarray of pages the user is holding a reference on.
> > @@ -562,7 +563,8 @@ struct sock {
> >                                 sk_scm_security : 1,
> >                                 sk_scm_pidfd : 1,
> >                                 sk_scm_rights : 1,
> > -                               sk_scm_unused : 4;
> > +                               sk_scm_pidfd_thread : 1,
> > +                               sk_scm_unused : 3;
> >                 };
> >         };
> >         u8                      sk_clockid;
> > @@ -2986,6 +2988,12 @@ static inline bool sk_is_stream_unix(const struct sock *sk)
> >         return sk_is_unix(sk) && sk->sk_type == SOCK_STREAM;
> >  }
> >
> > +/* SO_PASSPIDFD or SO_PASSPIDFD_THREAD asked for an SCM_PIDFD. */
> > +static inline bool sk_scm_pidfd_wanted(const struct sock *sk)
> > +{
> > +       return sk->sk_scm_pidfd || sk->sk_scm_pidfd_thread;
> > +}
> > +
> >  static inline bool sk_is_vsock(const struct sock *sk)
> >  {
> >         return sk->sk_family == AF_VSOCK;
> > diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> > index 84ea7b92936e..d1e5c6de146d 100644
> > --- a/include/uapi/asm-generic/socket.h
> > +++ b/include/uapi/asm-generic/socket.h
> > @@ -152,6 +152,8 @@
> >
> >  #define SO_RIGHTS_NOTRUNC      85
> >
> > +#define SO_PASSPIDFD_THREAD    86
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index 9b9e119c353a..d69768414af4 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -499,9 +499,13 @@ static bool scm_has_secdata(struct sock *sk)
> >  }
> >  #endif
> >
> > -static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
> > +static void scm_pidfd_recv(struct sock *sk, struct msghdr *msg,
> > +                          struct scm_cookie *scm)
> >  {
> > +       enum pid_type type = sk->sk_scm_pidfd_thread ? PIDTYPE_PID : PIDTYPE_TGID;
> > +       struct pid *pid = scm->pid[type];
> >         struct file *pidfd_file = NULL;
> > +       unsigned int flags = PIDFD_STALE;
> 
> nit: Please keep the reverse xmas tree order.
> 
> 
> >         int len, pidfd;
> >
> >         /* put_cmsg() doesn't return an error if CMSG is truncated,
> > @@ -517,10 +521,13 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
> >                 return;
> >         }
> >
> > -       if (!scm->pid[PIDTYPE_TGID])
> > +       if (!pid)
> >                 return;
> >
> > -       pidfd = pidfd_prepare(scm->pid[PIDTYPE_TGID], PIDFD_STALE, &pidfd_file);
> > +       if (type == PIDTYPE_PID)
> > +               flags |= PIDFD_THREAD;
> 
> I'm wondering how this flag can be useful.
> 
> I thought this should be
> 
>   if (pid_has_task(pid, PIDTYPE_TGID))
>     flags |= PIDFD_THREAD;
> 
> because when the sender sends TGID, this flag is set even though
> it is a thread leader.
> 
> It seems PIDFD_THREAD is just feedback of whether the
> receiver has set SO_PASSPIDFD or _THREAD, which the
> application should already know.
> 

Isn't this flag necessary to indicate how to handle signals? i.e. its acting like
PIDFD_THREAD acquired pidfds defaulting to pidfd_send_signal() with
PIDFD_SIGNAL_THREAD. userspace can even read that back with fcntl() so
if you were to pass the pidfd around with SCM_RIGHTS, etc the other end knows
what type of pidfd they've gotten.

> 
> > +
> > +       pidfd = pidfd_prepare(pid, flags, &pidfd_file);
> >
> >         if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
> >                 if (pidfd_file) {
> > @@ -539,7 +546,7 @@ static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
> >                               struct scm_cookie *scm, int flags)
> >  {
> >         if (!msg->msg_control) {
> > -               if (sk->sk_scm_credentials || sk->sk_scm_pidfd ||
> > +               if (sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk) ||
> >                     scm->fp || scm_has_secdata(sk))
> >                         msg->msg_flags |= MSG_CTRUNC;
> >
> > @@ -586,8 +593,8 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
> >                 scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc));
> >         }
> >
> > -       if (sock->sk->sk_scm_pidfd)
> > -               scm_pidfd_recv(msg, scm);
> > +       if (sk_scm_pidfd_wanted(sock->sk))
> > +               scm_pidfd_recv(sock->sk, msg, scm);
> >
> >         scm_destroy_cred(scm);
> >  }
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 1ad41904db25..f9615b0de10e 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1571,10 +1571,25 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
> >                 break;
> >
> >         case SO_PASSPIDFD:
> > -               if (sk_is_unix(sk))
> > +               if (sk_is_unix(sk)) {
> > +                       /* Mutually exclusive with SO_PASSPIDFD_THREAD. */
> >                         sk->sk_scm_pidfd = valbool;
> > -               else
> > +                       if (valbool)
> > +                               sk->sk_scm_pidfd_thread = 0;
> > +               } else {
> > +                       ret = -EOPNOTSUPP;
> > +               }
> > +               break;
> > +
> > +       case SO_PASSPIDFD_THREAD:
> 
> If SO_PASSPIDFD had boolean check, it would have been possible
> to reuse SO_PASSPIDFD==2 as SO_PASSPIDFD_THREAD.
> 
> Given two options are mutually exclusive here, I think it's cleaner
> to have u32 SO_PASSPIDFD_OPTIONS or something, which can
> store 32 flags for future extension.
> 
> #define SO_PASSPIDFD_OPTION 86
> #define SO_PASSPIDFD_THREAD 1
> 
> Then, sk_scm_pidfd_thread will be used in unix_skb_scm_eq()
> and scm_pidfd_recv() only.


Are they really mutually exclusive? I could see a world where
maybe you want both set. If we do treat it as exclusive is it
a last option wins sort of thing?

i.e.:

    1. set SO_PASSPIDFD
    2. set SO_PASSPIDFD_OPTION with SO_PASSPIDFD_THREAD

does that just result in a SCM_PIDFD related to the thread?
and then if we do a SO_PASSPIDFD_OPTION with 0, does that
just stop sending the cmsg at all (or does it go back to SO_PASSPIDFD)?

To me it would be kind of nice if they were unique / independent,
i.e. if you did the above you'd get SCM_PIDFD and SCM_PIDFD_THREAD type as well
(and I don't know if I'd make it have flags like that then and instead
just keep it the way it is). That also seems to pair with SO_PEERPIDFD_THREAD better
which has to be a separate option since you can't shove in any flags.

Am I missing something? Happy to see it done either way but keeping them
exclusive and adding options in kind of confuses me with expected behavior.

Thanks,
Andrew
