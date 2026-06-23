Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44B39DBD4
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187334; cv=pass; b=e+aWYwZEOZ07kqV2GFhF0zv56pJJ1/tYFWsLgoe6GFLuLtx0o1zB8mNbQ6d+cukFV3SuLQGg8pvTIFYQaKsfhQQCgwAm0jn0ZeUS9/WbbL8/LbI2ECt4qZ1BY5o+N0nV9cLservrHFzTPeF+FIqaGjNbj+V+gKVWzmSoXQjPzzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187334; c=relaxed/simple;
	bh=F0wTGQkkGlxpSFeNyjD6eaC/VlWEy1Nj2KPYSgkBaLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opIBfsnnzAmGJ2cUPMR7H26K0psyW+5GkMM1lR53Wf/fNQqH98QAeVOL+ZTz/60yUsxIcCwjfJ7toq1gFIasBgz+ERwtIr2dgVMPTtZilhwxOBW1ZPNaq74vPim693M30SAEM+FtfSHxBs+K/+H9h4s+I1AGG/bUqcHLCvGOIo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvfEHe85; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvfEHe85"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-915c36e32abso486626685a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 21:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782187328; cv=none;
        d=google.com; s=arc-20240605;
        b=i+lUuM49jHushxz9zaxBJdpF3FrEStpOjaZhP+vuIdHW4ru1J+3riPulSV5sIrpYHW
         EqSrd4o8imIsb3zLtadWA6Dmu/thdqPkO4E5fKkDSFwifXd3wq5/kN2pY2kJiIIgW9Jj
         dQz8kVRQEeyrhgfJm72zfYYtkizBsc0PhM1TG5MoeaxqYVjjJw4zmlrOmOa4IwtGj4Xh
         3mDHruAEe69ARFAKrsP2jr2Z5ZdmygfPGKrcE1IY0ajv8LOZmpqq/IX/8XnBmK1okpAV
         /A1Acdq85f5LaoLb2RpJ01U9/X7kT9mb9g6T2oKNySYKYzW/z6vMRXYpBU3yvvcxvz4k
         NC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        fh=PgYDfYOVSXjiiQC6u6omVLzLOHXdNjhBHbyBtBqxW5c=;
        b=JjncUQ5XlT2lw2E0w0IJeHfP5veGx8QFByhloPjySawGXxSD+rja5DQ+EWsta0FHH4
         ImoV8+jJRd+s+6QbWDUKV1geSv9mde8xjckXjRSQ/rfJVx4CICa3vx2rjyadr/uWsNaY
         Tq8TJvhV7rLp+EHcJ59l8KOVHzanrhnevpwPdCJsVyO2mLf5jBjxLBc8OYCs+O0S91e2
         4kS0aKU96lJd8b3oa6VTyqkgGVStFu/9CqUL6kyTHWCWZndw45DSPN3rxtil8rYqZDQt
         EPPBwUpTgeE1Ocxwxlmfp8yqKUhII4Q5jFmqm3+QQx2uaG03PjoQWa2qPsEVGPvIPh/f
         tdgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782187328; x=1782792128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        b=kvfEHe85g9lUYBp4b+HBBNOtnEXPs2FhHtjfbueg3OXE/2zsiVDDCk5Sf2KOR1lxib
         zIoQxQiskpChFQyo21WNgATlA1ZTx/GP/aSDvLer8bGK1k/DXX2aghlwkYqQv2pFkyFz
         oked1raJu7gLr0qxR3h80MSU/LFbvjxaK41XdPy0f5iGOahOso5D6brjklO00daNIfq1
         gIxALTWLg3bznUVXFcT2ZVDOgIwpidNjrhE9Sc+zhNk1C8e6f6KiwIxKTskiB6kpTBMK
         w1nNx8ay0Yr5pDD5SIS7zDfDIGIW66P2uO5D9Xu05DDJK12HXpSTUlR+6N1r5JyQ9KZc
         sUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187328; x=1782792128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        b=oiSISinowtjdmAOE+32OHjYnKzddDz8SNVKAvdm3I4Ir61+KlgokYRDLWUxjSdtsyC
         xu6omDcd+JVwKf7qkO+07skkxK4uWqgra9j6pXIK3KBjBcjQ3VnOaTO2QskoddjrP8nY
         IRAlDSKK8odxeiYtMkeBTxlAjhzjxjj/ElbxlMNn3e8O+h/b4gyiYnpqxp85yZyx/cp6
         MMUzNjbV9++c3s0viqnwGEFU3PHRA3gYe+iu3BLvqg4Re0XwGoji8FXRD4+hAhJ6XBKM
         9CAF+YOAoURiEVYK/P/ReVnvUozAqjDo0v2r2+HWEX50Zx1WINpBamNgXMxBDk6BFJpp
         HI+w==
X-Forwarded-Encrypted: i=1; AFNElJ/Jee/mEs5YrryZNalcT534Rj1EeHsqOHpOxrxnd8fqaIUJiWuGGJog4b4LTc0FX60q0z7dSreC4cc6DKDa@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0191MwQC0+YLw44Lu7ZNkVPNxHMEVJAirxI9tDpKfkqn5TVY
	e91gix4F78UeHnn4p6GNgMLLqeerK0GM5ZYbKcaSu0YQju3eGh+Z4tow7RPOBpUaBjVQW378Lh7
	RI6k9yGfFdavUb/aOpMwn4ulhWTxJLGQ=
X-Gm-Gg: AfdE7cnjwryit/F90igVKcv4E+TLsVDD9W85+V9WYSbT2Eb03MA50SiYoi20ziQjLzb
	6EsNS480rjJ8ua1kkMXgn6MB+OQrnieqoCoO4kNYsX4Zj0tXx2HAEmLSeJbCMsuZWcrFBAA3tlJ
	3WfMQlsSC6zQ4lSWjHzC/HpXBFiC9JzHutQxsW5lY+W4fmORLs7sZsPY2oDzshjKO0HmOrPSFzw
	kHK+byhag1jP/EzwH0LasWrKDXkZbQgN+Z+4M0zm3vQhR3/pb7ieVuNytClJrGzlTFkGPoYKqOT
	Ba59KkgfAAIFXQ6vEOOriL45pBOh8KWtbwzDSg==
X-Received: by 2002:a05:620a:4808:b0:915:e9c3:f1a0 with SMTP id
 af79cd13be357-9208f05c232mr2733502085a.12.1782187328229; Mon, 22 Jun 2026
 21:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com> <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
 <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
In-Reply-To: <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 23 Jun 2026 00:01:56 -0400
X-Gm-Features: AVVi8CdBJDCEtsjZ6Cr-k5RWu5qRO4rCaGhk6aOZoAtNJHl7U-y4zrw2gKO9F3E
Message-ID: <CAEXv5_jTxeTRdWpv71=6k_VTN4ZCes30xPs746Frw96fShfe4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
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

On Mon, Jun 22, 2026 at 11:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> >
> > > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > > index 1a721fc4bef5..b41b02173e24 100644
> > > > --- a/kernel/bpf/trampoline.c
> > > > +++ b/kernel/bpf/trampoline.c
> > > > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_t=
rampoline *tr,
> > > >       }
> > > >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> > > >               return -E2BIG;
> > > > +     if (node->link->prog->aux->attach_limit &&
> > > > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_li=
mit)
> > > > +             return -E2BIG;
> > >
> > > No need. The check inside kfunc is enough.
> > >
> >
> > Paul wanted this check because it occurs at bpf prog attach time,
> > whereas the one in the kfunc is at inode creation time.
>
> Sorry, we're not adding redundant code to the verifier.

Thanks, will send v4 soon.
