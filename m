Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B933890E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550760; cv=pass; b=py/x2nHoE+w3kZbY1wU1dqX4AQJIde88/SRPt2jJ8rSmssIh+N+ulVB6ekoVfNWH1Ow2Wsmlrg90Qqx+3YY5STniZQdwi7a2ZNRmfVYOqe4Z5jCLQB9Kyt63vvdJxRyPoKpDpFFRVvMjtrrspTESVkSNDipGLLhKXlExSiI/B90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550760; c=relaxed/simple;
	bh=pDkaf92aGIzW2nURaj6jT8tYViv87t0+zoEW+ew11LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYmoaHSlHavPtHVnwTie4+LB2H9VLeZozZ1QaccP7xArZPI3MmoQPh70WJrv/V95CV1XpbV6gdsGkTHi2W1rbD2Goqq25oFhaluLguigDLYJvWH/VHC32wEPBpJfplv8GP0xzZ8Mf/IZ4u64jyuTXExllUiG2GNh+pqdwsYJT4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LSNlgRR+; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LSNlgRR+"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c998fd549a8so818669a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 09:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786550758; cv=none;
        d=google.com; s=arc-20260327;
        b=Gtap2/WPHBAzipKMIG1uDDi7fPURXazPOnlidO1eqZkY2PQtndCFqc9piHTiNmyCmc
         nOlq/ZmNGyheojnJupClW583PlxkymbSetG4gk3M3WzKofZRzHicPMeVofZvjvfV9Q+Y
         TBsywW3LaZ3VH5vmwNzlMIBLw76oz2dKifNt/uQokMzKOc4FSyRYCezFh6m9J4sJvLdx
         x03EndUmSqBl46wABBhE24izHWmpdfAeSHcdyccPngk/eIhIWtwv/Gqn1TKg8lNzxJjH
         jNWmedPNMPpuw2t+KdrPWanxhwOdi9FNtjjntaqem2H7zp+bQfviWuRHjJ3ujYoYDop3
         xCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CMffE6MB40CLoVG0GMrgQarav/1U88Yb+D4J0FCr0oo=;
        fh=k4YvZrMMSpQZw6o0RfkmuxYAz69sjRSszzpYvHYrhLc=;
        b=RbqR87dyGGi5YW+JXGnBggSLSBfUP7Ug5xRykrdRL2/mRDaDrwrvltz47LNLLnQEPt
         nyvfRup3YDrQiHj/I6QJFpgj57Ly6PR+qLVI9JU+sLRfIUJ3BJBCSxMFtf3qclacQAgp
         yEzFDsyGCRadZrfb/Bhuko0UCxobkOmDt3jLkCpDNSjrzMLD59pVxL0UxDLaONGreVoN
         eXC+axO3g49ubayrg4cNjumX1ge4LhOmVGuOu9errWhwqBurwV27MY62Ccmvf3BbozvX
         9nN7IwxYmeFlMii0dHGGuB6KuF20syWQMDkcm+tW9FDDBUYfAiWRawsCSgBO09mCXOgN
         Kk+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786550758; x=1787155558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMffE6MB40CLoVG0GMrgQarav/1U88Yb+D4J0FCr0oo=;
        b=LSNlgRR+eELM3xwyi2MCH1ZQ3d+PiHt8iTM9jZgs8Y/oQPqKy7QREcovkLQGQobfmf
         UIZqVTvQU+nfUdcqxoUoe0RP/Ah08pqNvZwevohX3KIn+lf3OrO1xfsvLtsnxfn5yM6K
         GOV3+y41+zjujdNOEQFj/ad9A+//KkAeSTIeLJ8hCoZhHt3Pk2tLAGJdXF8EFIAeXPhR
         sgpqk6/jf+SfHP3BiS9aNULlIOpnToI7F9gz5WIOSJChrUKmU0zfliwpeE96XrgtOoNv
         hiYgACLjgN7u2OK6scw3PV5ZIFOpMqUz/CQdC7WnwHYUtagVp/umFHohfDZivt4dPQw8
         wAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550758; x=1787155558;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMffE6MB40CLoVG0GMrgQarav/1U88Yb+D4J0FCr0oo=;
        b=DJ/tcqo/+jcgZFsGKcIPN143yPsShNPXs+yiTHzs3YVX/5F4tqStpaolr5TRAKynNw
         LZqQj+MNVcXpCKTAAQUuliqz/4LvboFpoO82S+Q6pRvsXuwoepAbN/+A4lez12jBtI1o
         ZsrwiDmY+ojIPPlEjonL6kWtd6gWkZZVNOZtzxdTJs/QYhyUgCCG1W0Q/lTSjON9S3TD
         Ck4IroAVk8hL9MysovMVmpePqNc5+I+uoJyNI3908t0Zzg1/uRnyF4cqOFV6yOJMHSf0
         N9k2sN0raJj5i+0rTC6vIAh04293W53QrjohHlJbiqiXwGAWC/xl9nUSBOW8vSFXpA0n
         1I6A==
X-Forwarded-Encrypted: i=1; AHgh+RqmaSZk4tqF2q+f/wY1F5CxYWbfv/qhgv8Gnax+LN41r+xjgB6wIiKOJkUlbyuQdl5FxwmtFUo2p9K41JhY@vger.kernel.org
X-Gm-Message-State: AOJu0YycAQ2Fl5Kv1LE0iXfEllBo+oOk1jydFEzNu4vmgLpnZ+1/jm3z
	PVF17SDmuy+iWhcVn3kcO4C7R/GULkNZgZzyk3iuqDz3Ro/ikAnJu/m9goTxy96Nvex6FQQiO11
	zmV7rTrD9LhEWvBRO9j51k2M5yai/FoQKXUN3OAem
X-Gm-Gg: AR+sD123nYZvc3NVSmQQSs7gUq97uE6EoEynRsn1dFjTaMt8FHuvS9P2r0Fp7eQKPeb
	kSq9ulj/sfR4dlN+EAjNn/yMy2SwN2XvARMVLYs8Ba/kzQs0wWSLCgEbe5Bv+48wUqmcGTDunm6
	3us81BniucUqoTF3hXX0aGENKejqUduGF63TLB3SX7twH4Re/mjRrWbinMhtZf4cyFYxhbHcXoT
	RSNLEld9BqP1g+wHB8O0vlB4WaKPu6RAdA4qgoTFFy0Hp+BIYDvd6AhXI3mazrr1KvrS5AOyReT
	NA49lvGDNZ453wEy1FV0G/7iVfxI7I5IjpIC2TgapBAMv6DyPtOwKlml
X-Received: by 2002:a05:6a20:3ca7:b0:3c6:61b9:917c with SMTP id
 adf61e73a8af0-3cc3f5e505cmr7352750637.11.1786550758430; Wed, 12 Aug 2026
 09:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170035.4073532-1-rrobaina@redhat.com> <CAHC9VhTR-qaU-WFiuWZLfxhNisTtKXahLMHrH7-Ts5o09VMYcw@mail.gmail.com>
 <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com> <P3A-8ZIRRiqomtqZCupr6w@redhat.com>
In-Reply-To: <P3A-8ZIRRiqomtqZCupr6w@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 12 Aug 2026 12:05:44 -0400
X-Gm-Features: AUfX_mwgqsR9fwt6Rz0lG5XrNmGm9lUL84hkqCi-TwUMbW5pAP1usk0PPwndJY8
Message-ID: <CAHC9VhTDsVZPfu9ZNDge+fbRLr1c4EFPKi_E8R7+N9wfvL9n5g@mail.gmail.com>
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
To: Steve Grubb <sgrubb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 12:01=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wr=
ote:
> On Wednesday, August 12, 2026 10:39:52=E2=80=AFAM Eastern Daylight Time R=
icardo
> Robaina wrote:
> > On Tue, Jul 28, 2026 at 6:22=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@red=
hat.com>
> wrote:
> > > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount=
(2)
> > > > syscall. The generic SYSCALL audit record logs the move_mount sysca=
ll
> > > > but does not capture the flags argument, creating an audit gap for
> > > > mount relocation operations.
> > > >
> > > > Add a MOVE_MOUNT auxiliary record that logs the flags argument pass=
ed
> > > > to move_mount(2). Pathnames and file descriptors are captured throu=
gh
> > > > existing PATH records and SYSCALL record arguments.
> > > >
> > > >  ----
> > > >  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:41 =
...
> > > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > > >  ----
> > > >  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=
=3Dfc:00 ...
> > > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > > >
> > > > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > > ---
> > > >
> > > >  fs/namespace.c             |  3 +++
> > > >  include/linux/audit.h      | 10 ++++++++++
> > > >  include/uapi/linux/audit.h |  1 +
> > > >  kernel/auditsc.c           | 13 +++++++++++++
> > > >  4 files changed, 27 insertions(+)
> >
> > Thanks for reviewing this patch, Paul!
> >
> > > This is because we only log the first four syscall parameters,
> > > correct?  To put this another way, if we logged all six syscall
> > > parameters this wouldn't be an issue, yes?
> >
> > Yes, that's correct.
>
> I've been aiming to reply to this and lost the original...in the case of
> mmap, yes. If we had just 5 of the passed values, we would not need a
> supplemental record just to record the fd.
>
> However, in many other syscalls, we only have pointers. Sometimes syscall=
s
> are designed to pass a structure with config items where some are securit=
y
> relevant. In those cases having all the args doesn't help and we still ne=
ed
> the supplemental record.

True, but that is independent of logging all of the syscall
parameters.  In my opinion only logging the first four was a terrible
mistake (I know you disagree Steve) and I'd just assume we correct
that before we add an auxiliary record.

--=20
paul-moore.com
