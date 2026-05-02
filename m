Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B6222580
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 May 2026 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777685080; cv=pass; b=cRZ5l/owcfqQj8k8uGhfz8iKRm1EChdZ9YrujHuFRxuKIqUqpJ4VUMPVJdDjwHD2boBUFJGAHmFPCc23Hd8oma4rjZHpk1NBNBqryQQBrLA/kZnLjbqI5CR33rAD82SODWHCavvOOqb1Djr1pShgDy1PGFAFaYgUAowadbOmz4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777685080; c=relaxed/simple;
	bh=tlWzm/LweUKhSpUnvp6PcsofBh7GX2GlpWV4iQcCDA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKmluMFY8oU1516bLOuVAln0uz4cfGC0vXtM/pnXlCkTooUBu7Fnh3jg3EGfgx7jXDmgFd0/4GWis85UgLQn9aUnebK0h9KTcgSE9NmKhntT+8e3T/jRVXpEzVbFf2YelM9FYIzu9HVIjgzyA//ygLUnvvdc97hxmmctrbW17Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tglJjcaN; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tglJjcaN"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c8f9846c8so3257974c88.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 18:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777685078; cv=none;
        d=google.com; s=arc-20240605;
        b=kVYrNUwrENtgKrALagBz0DapH0TOmkquhr7cQ5v9BOz1QNkA3k2kHpAtMXLrNbtIHZ
         OJQ20tH+1mDkvdLb9K8EaOO7ynjc2jJUSLRs3Hi/81RnqsmtGY2Od1xi0kCUDJbkzvtH
         ycDWXGRV3kQAWcsrEDPu6lm0X0XvFaUVuTL8oLgZwfyxkTMFHtGAgC1taw5AbsgsKLG6
         mZFmLp3CWtDApcuzaQeXS1c/oTe1SBzJJsbzNgMzI+tDmXF90XdhM2Yqdwt1rpjxXuwp
         nGB8AsXxFN67vSUIhbEh803X92K7/n3VKh90byatFW6Y5fKkTmumBl0V4TWUS/x4stxI
         jHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UTYEXtZbnOW94bihUSWzw/uzxtoul8H4TwtkWQ/OOcs=;
        fh=1rsiXBQFrcLPZeKfwtw6CwlyT+DS8+U+9pmJoHsrmx8=;
        b=bzNV2/Xqwt+wcCN4nOvpY1Pif9mNJgvnj3FhdTRclK+Qzq3tgk+2NBQbal5O3x4Ysu
         5Evdxa84dAc1lEhzcnXTRfOqciN9VZI3JLxpv2jC5yJvJCraqpXZgxIw0BZCW8n5Q3vp
         uYwM38blgOMuFioKrphCRcEySLdicxYGYGOn827AjENfVfTkeEddF5g2ITcUY7eiAZlF
         LLBLmGWuS0VHXA4Crx7FI6Cbda8Rf1DqVmHCtl2md70CgZL/SHSq+ENk0QmjD2X5CrCN
         ms8WQF1ptRfpDEpPGn5JLUQNbZwF9UGvUv25wFsz7mesqleOKSkUHjrdCZ4UlUs1Smth
         7Iag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777685078; x=1778289878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTYEXtZbnOW94bihUSWzw/uzxtoul8H4TwtkWQ/OOcs=;
        b=tglJjcaNWzt4y7utHMv+h2WL5OY5tf5X5qF5TicSwYXh7uIlMSi3KGJkcoVmkjYyk7
         NRPdtihqKCqv0HTBx8FcZrVYkTJOT0IhjprmkHL88ahl8tGnbEw9q3Bk95tIRC4vPjC5
         huKTLA6roSivAdw/1nwE/w+FaU0jaHvMhFPS+NGeD9YXIsDfXL9ZBp6UTL8rnABdmcGo
         K8PrvuslN0Hr8RQeiJhswis2WE5mgekajTIad+8M9TuDZ+BpNsyx0/qpGfUzlTwY6McZ
         ey407Z2nBmi+QqZU9C01XJBn+Jc9oWjE5MqdVr7mzP5cDy3FuvEdDLJvElRZHKhvSbHQ
         m7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777685078; x=1778289878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UTYEXtZbnOW94bihUSWzw/uzxtoul8H4TwtkWQ/OOcs=;
        b=LKoyfj4J8CjcC4PqvDm3O/x1mP/9GVC+DmxeJ+glsDCOXRwMFau/8BbuM2GWuc5a1N
         2NpaT4c0JHizP519YN1vHRe1u+LDo8oAunaVQyBqx5tidPXwuDSnE+GvRrNHmzaoh8MM
         MqZAHhnZaMxoZC8eAXIYdzmM+VT7P6oC6VXer7BXA6Y7pJ3F2WMn//H3MvvceVnYfVg3
         GK1nTQ2JWc/bpVPxMflWZwGAY39b0cX4LoW7NAIR/Nl8QQCFqZiopd1fLn+eqoLoKd9L
         zVzDhLeKBKORFRvi0m5vzmHU03z7Ihb64/OdBsvY5vs++RLiY8UQr005ExOj7b++HRu4
         Q93A==
X-Forwarded-Encrypted: i=1; AFNElJ+VIEsqnASEgc7hYA+vIuQST4XDZl/4ZGiYoCH4EW2IbMs63PpA3KMU4DbM+mbPhU3p++AS2Fnu5QWXxzqy@vger.kernel.org
X-Gm-Message-State: AOJu0YwVasdi64TraDzMsHAlPEV7i4/wS3t8JTgXgwr/b1ki/iE2+tw0
	5MQaIjxzLsYEm+kT6N0YDzexXpf/wmcCYk/qm+GDp/teRjRIrfen+SpTYm+A72NgBUbmxY1Ldux
	zy4BrgW5nRL/u0h5RQvi5ukhAcTEMvCCHPXtBQPfK
X-Gm-Gg: AeBDiesEhqwl2U1yKIk3dq+M1C4tLrfENZfZE5IZg6UUQrXt9w4szJxs2Eav2+Qs1c5
	LQ/dQ8BrCdNMIfKnHUj3HmValHYi5d89d/+KSKKv8gCLDyUAWf4r6lLgbw9W1HAzRkngxlRKqrx
	Xkk29m4aOL1zu2364RinI2S3W8UTeiOthAb2NvPSMiKRYcvescsFUT1hsFvAgB/z44c1BK9CPds
	O40LUMbO9WtzPsVgxDu38AyBK+WrsUBBaIx4oOACEQ4LdgR/KBY2R0T4vWbqBENrELDX9RE829N
	opYNBzWNdBwTO7+UZNygQv1AV2HETPjEy/hf1POQXAroufXv4OIAdXUL4704Ge8O/FRYyiqNejf
	KPl9PaUf9LI6XBzzXuZkLGi3YmcBmDyeM2M7sRdI+CMlCS9aIizGHlVigBhcHPz/SaSakkdjYXA
	==
X-Received: by 2002:a05:7022:2514:b0:12d:de3f:f3d9 with SMTP id
 a92af1059eb24-12dfd8459ffmr501080c88.35.1777685077641; Fri, 01 May 2026
 18:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428175125.2705296-1-jkoolstra@xs4all.nl> <20260428175125.2705296-2-jkoolstra@xs4all.nl>
 <CAAVpQUBKeN2KtRkRAFr8sYJM1_-rbkdjsujau5fAyaiP_dO6FA@mail.gmail.com> <89346381.2074764.1777649680664@kpc.webmail.kpnmail.nl>
In-Reply-To: <89346381.2074764.1777649680664@kpc.webmail.kpnmail.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 1 May 2026 18:24:26 -0700
X-Gm-Features: AVHnY4Ivy4FFEa5elE6XvX0acVHEeFy5f9-HW7mgZQCbQK3BFpKAMdSRMm9bNLQ
Message-ID: <CAAVpQUDKgWdgPjPmJKhNxofssasS8-RdaLAcbFXHMWH8ztMJXA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] net: af_unix: Useful handling of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>, Kees Cook <kees@kernel.org>, 
	Simon Horman <horms@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Jeff Layton <jlayton@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@gmail.com>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Joel Granados <joel.granados@kernel.org>, Charlie Mirabile <cmirabil@redhat.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 8:34=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
>
> > Op 30-04-2026 04:04 CEST schreef Kuniyuki Iwashima <kuniyu@google.com>:
> >
> >
> > On Tue, Apr 28, 2026 at 10:51=E2=80=AFAM Jori Koolstra <jkoolstra@xs4al=
l.nl> wrote:
> > >
> > > Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> > > receive an SCM_RIGHTS fd the SCM_RIGHTS fd array will be cut short at
> > > that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> > > highly problematic behaviour, because it leaves the receiver
> > > wondering what happened. As per man page MSG_CTRUNC is supposed to
> > > indicate that the control buffer was sized too short, but suddenly
> > > a permission error might result in the exact same flag being set.
> > > Moreover, the receiver has no chance to determine how many fds got
> > > originally sent and how many were suppressed.[1]
> > >
> > > Add two MSG_* flags:
> >
> > Since we only have 5 bits remaining for future extension,
> > we need to consider the use case a bit more carefully.
> >
>
> Right. Since it wasn't a lot of work I implemented it exactly as the requ=
est
> was made from userspace, and then discuss it from there. By the way, I su=
ppose
> nothing can be done about that small flag space?

We could reuse an existing flag (e.g. MSG_FIN, MSG_RST)
if we were confident enough that the userspace does not use
the flag for a specific socket type.

Another option is to add another syscall, recvmsg2.


>
> >
> > >  - MSG_RIGHTS_DENIAL is set whenever any file is rejected by the LSM
> > >    during recvmsg() of SCM_RIGHTS fds.
> >
> > Is this really needed ?
> >
> > Even if the fd array is truncated, the application will traverse
> > the array anyway since it has some fds already installed (to
> > clean up in case of MSG_CTRUNC ?).
> >
> > Then, it will find the -EPERM entry.
> >
> > I assume no one uses MSG_RIGHTS_DENIAL without
> > MSG_RIGHTS_FILTER.
> >
>
> I guess that is a fair assumption to make. We can certainly do without
> MSG_RIGHTS_DENIAL if saving flags is important. I also suggested that
> we may see whether we can make MSG_RIGHTS_FILTER the default behavior.
> In the mean time I've found grep.app, and it turns out the answer is no.
> Apparently almost no one checks even for the truncation flag (mostly 1 fd
> is passed and then it is check the cmsg lenght). But cpython has this for
> instance:
>
>     /* Close all descriptors coming from SCM_RIGHTS, so they don't leak. =
*/
>     for (cmsgh =3D ((msg.msg_controllen > 0) ? CMSG_FIRSTHDR(&msg) : NULL=
);
>          cmsgh !=3D NULL; cmsgh =3D CMSG_NXTHDR(&msg, cmsgh)) {
>         cmsg_status =3D get_cmsg_data_len(&msg, cmsgh, &cmsgdatalen);
>         if (cmsg_status < 0)
>             break;
>         if (cmsgh->cmsg_level =3D=3D SOL_SOCKET &&
>             cmsgh->cmsg_type =3D=3D SCM_RIGHTS) {
>             size_t numfds;
>             int *fdp;
>             numfds =3D cmsgdatalen / sizeof(int);
>             fdp =3D (int *)CMSG_DATA(cmsgh);
>             while (numfds-- > 0)
>                 close(*fdp++);
>         }
>         if (cmsg_status !=3D 0)
>             break;
>     }
>
> >
> > >  - If MSG_RIGHTS_FILTER is passed as a flag to recvmsg(), the SCM_RIG=
HTS
> >
> > Does this flag need per-recvmsg() granularity ?
> >
>
> Perhaps not. What would be the alternative? A fcntl option for the socket=
 fd?

I'd add a new socket option like

setsockopt(SOL_SOCKET, SO_RIGHTS_TRUNC, &(int){0}, sizeof(int));


>
> > If the application does not welcome the truncated fd array,
> > it would have passed MSG_RIGHTS_FILTER to every
> > recvmsg(), no ?
> >
>
> Correct.
>
>
> Thanks,
> Jori.
