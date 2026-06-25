Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975E2E6CB3
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417523; cv=pass; b=t+LxObpvG+vFCeyUfdc5t76exITtXVobgBTusfpJk16Vu9Y3NAnzwbJDHBD9pR4kl5eEfaydaXAzaaViFI2m6Ki3Sj0p2w1f0GoSdGsBKuizaVr+KzNgYWPdpiOevncbSgfGGu5fpuUK7W11c47huoolOwloQXoAS6/CnEJdXe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417523; c=relaxed/simple;
	bh=t01HuVJS93Se9y/xJOr+SDSuCi2qkwkLjpWQtvIuIYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksqtEwpBXnkLNRL11/q/iB9Y+4FJS9Q90vubZqG7TJElcl/bXycBJaBkIUTchmmmy0pjr/uTSFDUxyX95HVeRv8aWDvL+dCd/9tmcwvDzIiI28bpKwvNqP3pGKvWnxWVCuAYjwz7+eGGA31eE8Rgfiutnxe5yQDLkaIYvVCog3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaESUM/3; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaESUM/3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8422f395a4aso139725b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 12:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782417522; cv=none;
        d=google.com; s=arc-20260327;
        b=hU0SVxz8xMnJnLnzKqggn4GVmsRAXRz/adZSkFri+YQZiHiJ5a1fzRsH67jmHHsV7Z
         O0i0nvnioVes5aNBpIS3+LBrCl6ZI2Fp63fjhVeOFI+KDl2ug6V2yuyXuMhlWJiYStvj
         j9mw7blWIFHon1IMzSFy4vHvt+dOJZG0aqAvK9JdkkhUiulcJQf08Onm8wmg++Ip+6uZ
         UcU1CefxNdsztn1eLGIE6S5/i57uwcu+cLQwle4mh6LZdzQw98j4C7kZLJ8mYXLI77Kz
         aVOjZs9QRq1zPNNXiij8nMk6ROXh67S8TmRqQFLGt35RA3/QJmkrfghfucEqC4T3x65l
         QQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hPszu32IdAgDeUQ2X3Ei0AlLyibH0GB2lSQN/iu5tDY=;
        fh=vv4Lq5kAIb6RSAXoVdYjOUUM7zj1xSu43ioCgZuoBPk=;
        b=PWIl9qZeF/wt/bSvIlDyztqXWmYWulfKTAgq1mocjGHJ8QSPFtsRL9vksfDpCEOELC
         5EDqJojUT7XqrfyH4q4HZ4dd21cbMAKU/LPp4ejwioOwGdusOv6YFMAOv9Y4ciPl4k4q
         14QK5iQeyPbFlKtn3gIdAd25fty6XQmVEyFBcTgC6gCVRJ/zfEwJmjpzOL9GvBQvDIR4
         MW424Lm5Z+fR6sQJT/cHSVRQ+i7ZwezaUaBr5LDp/RIYxbvZ5f//gCifxz7mKleVXTgc
         tc7mnOMIdY8q9a5YZGQYjj2D89QfSkEYtG8dvlYX+oE4eimw76WAgHDleaYoH0GBU5ou
         UmTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782417522; x=1783022322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPszu32IdAgDeUQ2X3Ei0AlLyibH0GB2lSQN/iu5tDY=;
        b=eaESUM/3qu36XTQpaqOGJRjKaAGFJhqF0lkNADskUW0FZ5YSzZqmQQpCBGhGz/9CVZ
         3yTqnvI+Bx7woEDhrV7jxG/KIq4nb7Ybwyq8STUCdKFcVOnEBgsqaZtgwLc4IwSrvR6x
         gAVj749Xk0LvTdnJIO6EhVs1PAhCSbSiB88EoPgFP4UYmxz7F7Zyc0hoIl6K8xltNi+P
         VBGRGMT9JCYv6vh+8ZsfDNDU1ezEF+k52IKQtYr/p85BMLcP+bDoMyrU8nbOl44doxbK
         VBlYIdTR0xF5O9W/ojYmiA2Okz/K4cgU5uRDbSIknQxrKRIpZC0xQEeVGhJE8uHDz+mx
         5bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782417522; x=1783022322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPszu32IdAgDeUQ2X3Ei0AlLyibH0GB2lSQN/iu5tDY=;
        b=PrdBcX/sbvi8AyQNnJa55VX+ZWZXFEhQQS2lKGTUQGlavDUKG+bBAdi/de4JZGPBf6
         0KnlGHJYxQyMBVnJLKl0e1DlQqkfg6ClT7xRpJGhUqeAQcANiYDbl7MERf5KrpYmJ1+/
         Iy9RtB68gSpF+1xnXjYh4+EXal6fO+sj/DPEKfNhVuWHIFI52oqW/mIqNTUGuoanVEDr
         di9ixL1zfKE0GtVtrrJJmDNaCD5X39jqEH2kLvKEnLOon+ogjO+z2akyjtsPFye74PL7
         YR8/xVPC4E8H84KK8SLZvsW1LE9fWOJRk2105spqLDQ/aUOeFcMCu6A6EQtAAuZVRuRP
         Sdng==
X-Forwarded-Encrypted: i=1; AHgh+RozvEIzd2mIYsaFztIxMA1qh99SlzU10tf7nIgoy7DRNaLwubDP+XpXLJG8s+L+1G5RaLt+t8k+y/7dAaSo@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4lkFPaKFiVgXg3SG6axf4Dkv8sKRSkoA2+onY0qf2ExvwmRN
	wRvlQEPYVG/zG8VjiKRKTS+mhcgiuibXAf8Ye9X1Zu50Ub8si/JI0v1VKJqo2PxmYV5/j5GV5lA
	6yV5ttus0/iFTerXRioC4FMYWtIZBSaI=
X-Gm-Gg: AfdE7cnCPzTl3gQPNf3cwowKDrUCocNmRIM5/NR0RWMSwcH24XsF/as229eWbVEC/Xq
	knD34o9rPLHgmbSwxwmcppWOk4s7ZptsUdDjJb/+QsK572kI4X+dJ3rPsO7LTkxlKHBizeNHXJ8
	C/P1FvlOFWXPajjjEWK+aNWuVq2ozipLv+br/YQQemNcYy6qFbTD9Xt2kQ14Gg+51CaSx2r2LmM
	cIwv/XLbRYOZpi3b00+SKVvC2NPOWAOSX3FKrqLmUmEdIFFuz5T+mmBlQDOC2OT9AJWk9NUKK3i
	WaKlQJz2XL6lMUWpBxuoeXccAO5A+w48amzWbwMlW2wDzHx4/6unkw0N2QlRsZORAGVQ3i1gzz6
	cemGbaFpuEAvh
X-Received: by 2002:a05:6a00:b44:b0:842:614b:50dc with SMTP id
 d2e1a72fcca58-84591b767a3mr12823311b3a.13.1782417521452; Thu, 25 Jun 2026
 12:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
In-Reply-To: <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jun 2026 12:58:29 -0700
X-Gm-Features: AVVi8CcGIc2g2XVMtMkmAY3eaT2U_sbyaP0UfCx7SkpWcEZUZelhXqYLRoruYRQ
Message-ID: <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, David Windsor <dwindsor@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>, selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> >
> > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically s=
et
> > > xattrs via the inode_init_security hook using lsm_get_xattr_slot().
> > >
> > > The inode_init_security hook previously took the xattr array and coun=
t
> > > as two separate output parameters (struct xattr *xattrs, int
> > > *xattr_count), which BPF programs cannot write to. Pass the xattr sta=
te
> > > as a single context object (struct xattr_ctx) instead, and have
> > > bpf_init_inode_xattr() take that context directly. Update the existin=
g
> > > in-tree callers of inode_init_security to take and forward the new
> > > xattr_ctx.
> > >
> > > A previous attempt [1] required a kmalloc string output protocol for
> > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs =
to
> > > provide xattrs for inode_init_security hook") [2], the xattr name is =
no
> > > longer allocated; it is a static constant.
> > >
> > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > restricted to lsm/inode_init_security. Restrict the xattr names that
> > > may be set via this kfunc to the bpf.* namespace.
> > >
> > > Link: https://kernsec.org/pipermail/linux-security-module-archive/202=
2-October/034878.html [1]
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D6bcdfd2cac55 [2]
> > > Suggested-by: Song Liu <song@kernel.org>
> > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > ---
> > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++++++++=
+-
> > >  include/linux/bpf.h               |   1 +
> > >  include/linux/bpf_lsm.h           |   3 +
> > >  include/linux/evm.h               |   9 +--
> > >  include/linux/lsm_hook_defs.h     |   4 +-
> > >  include/linux/lsm_hooks.h         |  16 ++---
> > >  include/linux/security.h          |   5 ++
> > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > >  kernel/bpf/trampoline.c           |   3 +
> > >  security/bpf/hooks.c              |   1 +
> > >  security/integrity/evm/evm_main.c |   8 ++-
> > >  security/security.c               |   7 +-
> > >  security/selinux/hooks.c          |   4 +-
> > >  security/smack/smack_lsm.c        |  27 ++++----
> > >  14 files changed, 166 insertions(+), 38 deletions(-)
> >
> > I have a few specific comments below, inline with the patch, but I want=
ed
> > to make some general comments too.
> >
> > The kfunc additions really don't belong in the VFS kfunc file, please
> > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add the
> > kfunc code to this new file.
>
> We expose a bunch of VFS heavy operations for various security modules
> and this is really not different. For xattrs we have it all centralized
> in the VFS and in general all VFS related bpf kfuncs should continue
> living there and be registered there. Anything that's just bpf infra
> specific can go to security/bpf/kfuncs.c instead. But anyway, it's a bpf
> specific helper so it's the bpf maintainer's call.

Completely agree. This is vfs related kfunc and has to be
in fs/bpf_fs_kfuncs.c to make sure vfs maintainers review it now
and all future changes to it.
