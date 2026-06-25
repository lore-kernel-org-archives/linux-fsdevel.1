Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172D34887E
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420298; cv=pass; b=kcUmFeD/Y3xkFMUCEnusJpSO5Ix2eburi4duz74xVoAMrRZAE70bdJ5L8BuvASokk1CU2OSmV6Uzi3/E493KlgZfxO1ZlDwH0CZrRLsYVghX5upWwkFwmDYfYCk9ARPAP6cLNatqGEprGXRRNEN1zJIq+CXaBdleRtfBYxm0FaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420298; c=relaxed/simple;
	bh=N9Dq4DwFj346OsehhL6Mi2d0QMKVNJTttDz0kqTp1YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBf1/nTpzBDauCaKDm3LlLin67v9N7Dm1CX4D0ih1nWA6Dt7aQLeVF7LHfHTH+oZSeAO7SVu6sCLcD+l3mCShhXhtdZIIlhoIzXsiQuaktTKaxWRnKUU9UON9pjkxm9efL+BiVBsJAHIaR6rMORhIXJJz7cEWPOcSdqK33xD2+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVt9QOH8; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVt9QOH8"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c85822059d8so187894a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 13:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782420295; cv=none;
        d=google.com; s=arc-20260327;
        b=HrRwH+kNjUui356PjzCzKFN81Rz93yP4970RkQW9R2hNbcgE4zouKB+wD2tLqAoNK4
         dU6SKHHqT33FefJNhNG4w52f2aw8sPaWzxciK/CQfBg/wqo+bVMXpSIFy6FA9J4vaH48
         uBEKLJw27Pv/7ClXcHNBlJsyID+rSoBwRFCzHv4Dufc6NW46RmrIxm3rlwXMxFEJmRCP
         /O6BvVyJk42op1Gi919KrF+M74ulDPy/296Cc6L3ilLCOx/7OvUhNq7jSa/mgOVhadqK
         wJMnONWlLK54R30wH5/VBam1u077RQH1UZgUZGZ/y8hVFffV9HDwTkaD0g5LZgVH4OeJ
         8OZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        fh=Ua4T4/p5l4ROC1xDF50j1dwGOJuVYp0Yxif+ApxIVtg=;
        b=Rd6SNGugyZgdmmqMG3eMc6MYkHS9XdSLMR6gk6KdnQGrCKtb5gFYW73zxPqUwPFndl
         uRCdtAcD2eTPExehA7ufV4NcdS++818oNj8FJWQ3Fs6BjfP7FsIT78zXe8oN6GvrdZEL
         DIWupqiTqZm7KKNIASpPNLQ7v5iDDboDlQbTzPcBBQhBWxNIb/A19zxDU/f7W4CpjHYo
         pOS4Z0CPlcue8aPHZhIPiCL76jOYW3x2F86lDhcHwQHmeh51m0gpob6Wk4Q8hmzt+ERB
         th+JVA0+eE9ZX3OKIser5Ou9uOeuY6ow0PRPwnQB/4QCWWGZWhRFS1UReuWIRUL8PCIG
         8N8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782420295; x=1783025095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        b=cVt9QOH85TZczzIKAW32WQbCke6oi2BzExTRrguWXJ53mLBPCyqikD/7rXtPYAYUE4
         RY0xEqimDJNhH/F/QZxsbtL2c/8Zct/VDrSkf17c/4VgQ518x5S+ao6WHbl6O8raGuVc
         IvuFjmRU97QWlC4wwkKSWHn0qi2wzUNT8Oe0hRoz3jXa/PAVLo7mYg1WKMfa0FrjHSuZ
         NCuOFwoRtUN2p/TrQ+uIoNs3dx7lNlnfIihxVAujVQ3NavHtOhH1KnY14YIV0RPZP371
         bDc3BlbBqVKeTW4+R9tCFGpP5eEVSBDqSQlZ+3MD17Rk14y9t75m1fL393UV1vgHlc0g
         6lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782420295; x=1783025095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        b=EcmO+SIdC5JyNDgSUvA/CaBGpb6430dzhXXYLTFhqV3oFcboJRziCc3zrznYVZX4aP
         qP4oLKW0vYnWRdSKw0LhpmOVbzqJxal8TVSDlu7ugkdz5262tdeV8M87U8Rh5lgXXLeS
         bQ861KtaMbhT9ms3M1yQ400OyDZPde+elOuY78kaslRl5KIRmK7G7xFPTFdXlFkVdzNA
         O8sMdj1L9kIZltrulLfJ6cJ4f5x6yCvjoPrP5GuxPQyUTGaZOBSsUzxXJTwkKI7kmyRl
         z1mJYGXnHwm2sD7U+hp4f7rzKlYTljTgzZSDPo1xJBspLeMPHGnH7KlyYkPPWNNSxFtJ
         WaIw==
X-Forwarded-Encrypted: i=1; AFNElJ+NLbmYox0eYuvskQ5WmfvAHP2wF3FxmteeqPcqDY6rK4zKfm/2ot5Cws8JcWVLQa7P7DHc/IKEmTvDb7PG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9j+1IsqAqVsTRM8mQPNy5v2bK+j99XMUI+j6/YFykqh8imdzl
	1uNKBlOp4EIL4I+efzlYSXGvKeQNAE+Oo2VtH+JmYj25zeBbMUhyCTEJh84cf4i+E1gVopLszD4
	03nIklnzcj/su2/BIoV62A6gX13PjRLc=
X-Gm-Gg: AfdE7ckBtnwH7YzlEftQQa9bqHWZZZZz99XRAT6vty+4eMtMkNTYRpSjnRhTYYZ+4ul
	q2Oewp0OtPF9iWUpknavsEm6pQKZg1F1WeP2kf25MOSMZj9+J4wDWE98ZpkGToecWSsnhH/0Z0/
	Gwz+gmg59phecSgynIiAUNHNbwxyJrWp5UnJF6+mV4c4dyrCTZ8dpiTocuOydRaHlBLfqd8mwgW
	T1XxrkbjwI7CHQtH0G7qqfs+mIomW6Kh4NtgNoE1pl8UcMCm8HCfXNtByvMSKlf6gthwSkEWjbQ
	aW/tgakp/iabxfmGJK/sZq8kJiYKjixvz/rn35pNyr8VLz2xPsHrLm+T42zSNyH8e7ipdOXOIek
	U3Gu8Uj1IooFZ
X-Received: by 2002:a05:6a20:144f:b0:3b4:84de:aa79 with SMTP id
 adf61e73a8af0-3bd4b064fcdmr5342275637.44.1782420294988; Thu, 25 Jun 2026
 13:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
 <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com> <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com>
In-Reply-To: <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jun 2026 13:44:42 -0700
X-Gm-Features: AVVi8Cd1aiwx-Wi0FGOZBeYqi53u50Be8i1kd9zEsWrT9afz6qquacMnoCzNbM8
Message-ID: <CAADnVQJM15E0PwomdTiz8zvVMGkqs9mTSjYRdPBF6fgE=tsPCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: David Windsor <dwindsor@gmail.com>, Christian Brauner <brauner@kernel.org>, 
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

On Thu, Jun 25, 2026 at 1:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 25, 2026 at 3:58=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > > > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> > > >
> > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomical=
ly set
> > > > > xattrs via the inode_init_security hook using lsm_get_xattr_slot(=
).
> > > > >
> > > > > The inode_init_security hook previously took the xattr array and =
count
> > > > > as two separate output parameters (struct xattr *xattrs, int
> > > > > *xattr_count), which BPF programs cannot write to. Pass the xattr=
 state
> > > > > as a single context object (struct xattr_ctx) instead, and have
> > > > > bpf_init_inode_xattr() take that context directly. Update the exi=
sting
> > > > > in-tree callers of inode_init_security to take and forward the ne=
w
> > > > > xattr_ctx.
> > > > >
> > > > > A previous attempt [1] required a kmalloc string output protocol =
for
> > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all L=
SMs to
> > > > > provide xattrs for inode_init_security hook") [2], the xattr name=
 is no
> > > > > longer allocated; it is a static constant.
> > > > >
> > > > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > > > restricted to lsm/inode_init_security. Restrict the xattr names t=
hat
> > > > > may be set via this kfunc to the bpf.* namespace.
> > > > >
> > > > > Link: https://kernsec.org/pipermail/linux-security-module-archive=
/2022-October/034878.html [1]
> > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > ---
> > > > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++++=
+++++-
> > > > >  include/linux/bpf.h               |   1 +
> > > > >  include/linux/bpf_lsm.h           |   3 +
> > > > >  include/linux/evm.h               |   9 +--
> > > > >  include/linux/lsm_hook_defs.h     |   4 +-
> > > > >  include/linux/lsm_hooks.h         |  16 ++---
> > > > >  include/linux/security.h          |   5 ++
> > > > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > > > >  kernel/bpf/trampoline.c           |   3 +
> > > > >  security/bpf/hooks.c              |   1 +
> > > > >  security/integrity/evm/evm_main.c |   8 ++-
> > > > >  security/security.c               |   7 +-
> > > > >  security/selinux/hooks.c          |   4 +-
> > > > >  security/smack/smack_lsm.c        |  27 ++++----
> > > > >  14 files changed, 166 insertions(+), 38 deletions(-)
> > > >
> > > > I have a few specific comments below, inline with the patch, but I =
wanted
> > > > to make some general comments too.
> > > >
> > > > The kfunc additions really don't belong in the VFS kfunc file, plea=
se
> > > > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add=
 the
> > > > kfunc code to this new file.
> > >
> > > We expose a bunch of VFS heavy operations for various security module=
s
> > > and this is really not different. For xattrs we have it all centraliz=
ed
> > > in the VFS and in general all VFS related bpf kfuncs should continue
> > > living there and be registered there. Anything that's just bpf infra
> > > specific can go to security/bpf/kfuncs.c instead. But anyway, it's a =
bpf
> > > specific helper so it's the bpf maintainer's call.
> >
> > Completely agree. This is vfs related kfunc and has to be
> > in fs/bpf_fs_kfuncs.c to make sure vfs maintainers review it now
> > and all future changes to it.
>
> *laughs*
>
> Okay, then split out the LSM specific stuff into
> security/bpf_lsm_kfuncs.c; all the LSM macros/defines/calls should be
> in the LSM kfuncs file.

Paul,

I'm sorry, but you didn't demonstrate the level of understanding
of bpf to be trusted to maintain any piece of it.
