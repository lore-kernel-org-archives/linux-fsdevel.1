Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374533;
	b=N+m3bbzV0/IKJegQYr/KheFrdhZBwEDc5tgaEKC046wS3lxhM0HJIYKnh0fX/FWG7DQp
	 IVKH1ZgXolCyNutXvSb8yxGYnWRNz37tawiOaWSKbEdeT7j8TyN9q6sC7tqFUs/FXp8Br
	 nY8OvUcM7ucPDjqmmk1Et7dx6Ft3PPeamO6OE7o9osNhfrbSS1gMQvmkRdur+MU336ur+
	 PKiyJJlCtHjvjww9GzzWCvTCSB315mi/TUztynr2/wBT8EsTVh+lFJJU7r2IK9o4jkI5D
	 J4powuyC4Aq2uyW1MBlmxiro/6+4RYAjO9IiCjeEKoUR11OuWKV5idm2zMa/RtKmNrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RFd8QlUF/2f8EIujxTa2mmugUe04z4PT62Q1oHJNdgA=;
	b=qbAt0ETkNpiEcscgl83MoTjALCPN6oXh96Zaolocnpi1h/EBkRJLaV7889DvsCa79tcj
	 4Qj8faeWQVxrpPkIPFPsIHBOr0At3MDaetR/VQaokogQpD4FaKa0iBzfGqmMXvwKT01g2
	 5adjD9GlJIdQlX1hOhM28CO0+pTBGlFE3GMVWe2YQVwfIs+SqdsanePSeo5H2hbWA0IV3
	 zSYeJ4RPOVeaSGlRkLMLWwYgvtqdoSXnFS2hze7lZVvCLI5zM4UuhFJOtA/5Z5mIbFX4D
	 vLsV3DKe1xinH+n5KH1BVxddrSAH+tBGwdodSQmDtssrmNiBOE3wQXTSZOzc+BvqFvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RjGbbE3X;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE133606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 15:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE133606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RjGbbE3X
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a215e64962so8301715e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374531; x=1793979331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RFd8QlUF/2f8EIujxTa2mmugUe04z4PT62Q1oHJNdgA=;
        b=RjGbbE3X8BPclL0e72nIXlgY9hYoB3XaopldJs3l7cp6GLmip8FPSNV6VGCzcTSu2T
         bJfC0sWgzYmHCLlD5CShQg0a48xOaPVY65ALbgjvFv7y5y4OyjfMrFZLeFok70kdKqvJ
         9Lh2Ix8F152sdvnrSY5XZRMZde2U7ksobftizu3b3zCbfyvl+VU8o1WBAfUao0aZS5i0
         BONczumcBtnudzqXOBSk+HZr2Hg9qV0E9p2nhcBGrw6Hg3ql+L/ilNvi6sxNDA04JU7L
         bkz3cQ1uWupdjMbFiJzT9luwq5GQXyjs3Sg1mnhLt8AezCWy67N1bhlRjGaeT79xFjVw
         Q6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374531; x=1793979331;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFd8QlUF/2f8EIujxTa2mmugUe04z4PT62Q1oHJNdgA=;
        b=UE/dc30k7dCmCKz421bjwXKe+1eRTTgiJvsQ+DpBjEW3/eHeXc4WLeahA8kuCbQDTF
         3OoZffpFuLEw9XJ7lLAu7GanBv7egfyfbbIJ4T5dfDf1W6udkqYZe8iVzYWLtCOibEey
         B17Jn3SzL8dJVqIg94LMgBcwN3wSfHkpbJw1oX6Owh9m+4Y4QD6IYWq+HSh4ROvJbz8O
         2DK6Bz4URi8wvyU5szFrePLkYvkgPeWkNOhhLe5NZlK2yD5fMYApmVEvKLftx2fk9s/q
         LWHjiA1jYcb3badwwpyKUxTsMz7r1pe8zBJoB4n6epzHKHWJJq4RAZjNQ4ZAGslCmwMV
         IOSg==
X-Forwarded-Encrypted: i=1; AKwUvBz2pzoBACbRVrqnpdKNy9sapZkeCTLlHCUHXdN7yAc7CH16c82gn7nAb8JArdVzji4iWBfr1c0D7P22t+Yw@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2OsEz2BsL++hwqTZFhEevteIzAestPMofWMapV018zNwr0bsR
	DPVzkNR1Z9t3INa6oNgZ59w2jeZLb81yzSpb+i81x6L9qDDQh6dkqJ3m
X-Gm-Gg: AYBFou2HCGGNkHywhXW0G6UVRJnP3wYkSZpIvjG3/iAGksK0scuCiakz0GZmRaeJUrL
	vJ/IYOetjeTSItTVwwL4F+aXwWceKSF7K3WHuQONnU0MflszXi3dU24MROADlZ/9ogWAt3b8wLg
	/Fe32CsleOperUnm8mexwT/2Z9BDlaeovlwCqKYAKUqnxUhRW9lgHFxEjvoIuAVCv0rNHrg9f7/
	AiNUzgod70qOFz+RV3zCCEEsx4gik0y0yjS4VKaEfsma51PH9JVz5diREOuk5cf20itPhxBuP1l
	Hy0Rhcg4Jkh8NBnOQEDFKXuBy5Y468DFwTpQ5ql37Qvwc1wzUZn8euciZwvKJFpgOtGCiPcLQ7v
	gvXOXFBh1S2aSfSVa7LTDRomGLAd757S1uazW8SV8vsWbn3U1Qpx7VrPiQDH2gFSAPSIucXkBch
	g97kQ/XVOuKcN59+CzQLpCglYmqFequkbx+g51fC78TOvRfU3EK9DeokuRPJyD7xH4ErNzXhTRG
	P++Ayu64hx7nVhZzgdb88vgzp3bxImy6pTHZt1T3Jg2z6nfbfjgLBENP50Ss3EYdeUFJvR+yEWG
	/dAXo7mPcnoRD19KHYVIwVi1Wi8wLS7+shBLeUkGoSbgPRzp0qzJDkUO/+NKBEJmFQ==
X-Received: by 2002:a05:600c:8b85:b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-4ac14fbdcf7mr54356935e9.4.1793374531121;
        Fri, 30 Oct 2026 08:35:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm70755145e9.10.2026.10.30.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:35:29 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:35:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Samuel Wu <wusamuel@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to
 /proc/kallsyms
Message-ID: <20261030153528.0d5113e7@pumpkin>
In-Reply-To: <CAEf4BzbyqPC=RQGWEdpkqu1WDQ2_S0H8pZU2i=_gLuSDQtpFbg@mail.gmail.com>
References: <20261023001603.560210-8-wusamuel@google.com>
	<20261023001603.560210-9-wusamuel@google.com>
	<CAEf4Bzb--Jzz696u057G9_CgQN7zf6ksvoL80KJacKO2CorsnQ@mail.gmail.com>
	<CAG2Kctojb7xiOqTmwWqoAKFaNUECjOzXVc_t6KbG13Pqm2dbng@mail.gmail.com>
	<CAEf4Bzbs8F1DPBz=WXVTExrrNjzvaFsi4L+HEj+zbUTpPSTX5g@mail.gmail.com>
	<CAG2KctpSTCyWQHgJ8GyFEhHPdFawUa6zy0g7rkfCcujJRN6f6w@mail.gmail.com>
	<CAEf4BzbyqPC=RQGWEdpkqu1WDQ2_S0H8pZU2i=_gLuSDQtpFbg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2026 15:54:01 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Oct 29, 2026 at 3:36=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:
...
> > > > Makes sense, but I'm thinking v3 doesn't need pagination or batchin=
g.
> > > > I didn't see any performance wins when profiling libbpf, and it can=
 be
> > > > added later without breaking UAPI.
> > > > =20
> > > > > on input I'd also add module name as optional input argument, with
> > > > > "vmlinux" limiting to just vmlinux, set module name to just that =
name,
> > > > > and NULL/zero meaning "we don't care" =20
> > > >
> > > > Makes sense, so here is a possible plan for QUERY_BY_NAME:
> > > > - Optional module filter: NULL =3D any, "vmlinux", or a module name
> > > > - Returns the first match by default (vmlinux first, then modules).=
 An
> > > > ALL_MATCHES flag searches everything and reports the number of matc=
hes =20
> > >
> > > searches everything as in all modules, or you mean just full linear s=
can? =20
> >
> > I envision ALL_MATCHES to do some form of lower_bound() +
> > upper_bound() on vmlinux since it's sorted, and then linear scan of
> > all modules. Of course, just one of the two or both aforementioned
> > things depending on the module filter (any, vmlinux, module). =20
>=20
> no point in upper_bound() if it's sorted, you just start at
> lower_bound and go linearly from there. I don't think it's realistic
> to assume large number of duplicates, so I wouldn't optize for that,
> one log(N) lower bound + linear scan will be faster in most cases,
> probably

Doing a system call for each symbol is probably fine and scales nicely.
Just return the symbol number (in the by-address list or by-name list)
so that the application can request the next one.
While the application probably isn't interested in symbols with a
lot of duplicates, some symbols get duplicated thousands of times.
So you have to allow for them.

(My kallsyms patches get scripts/kallsyms to mark when a symbol is a duplic=
ate
of the previous one, but after a short linear scan for the first it falls
back on the binary search otherwise looking up some symbols takes a long ti=
me.)

...
> > > > =20
> > > > > tl;dr, this is the right direction, but I think we should polish =
API a
> > > > > bit more to be more universally useful and extensible =20
> > > > > > +
> > > > > > +#define KALLSYMS_QUERY_SIZE_VER0       40 /* sizeof first publ=
ished struct */
> > > > > > + =20
> > >
> > > [...]
> > > =20
> > > > >
> > > > > PROCMAP_QUERY uses offsetofend() for the last defined field, any
> > > > > reason to have this #define and BUILD_BUG_ON here? =20
> > > >
> > > > David pointed out that the size field in struct kallsyms_query is
> > > > redundant. In v3, I can drop the size field and use _IOC_SIZE(cmd),
> > > > keep the *_SIZE_VER0 define (since we need minimum size). Perfectly
> > > > fine to switch to the PROCMAP_QUERY style though if preferred. =20
> > >
> > > I'm not sure how size is redundant, I don't see ioctl subsystem
> > > accepting argument size as a separate parameter, so the size has to
> > > come from the user and be embedded in user-provided structure, if we
> > > want any sort of backward/forward compatibility. At least looking at
> > > PROCMAP_QUERY I don't see how we could have avoided it, so not sure
> > > how we can do that here. =20
> >
> > My understanding is that the size is encoded in the ioctl command
> > itself: _IOWR() puts sizeof(struct) into the command number when
> > userspace is compiled, so _IOC_SIZE(cmd) is the struct size of the
> > header the caller was built against.

Yep, I think that was added by the BSD kernels (but not SYSV) when they
changed from 16bit to 32bit.
Linux mostly uses it, but not always.
If it were used consistently (or the high two direction bits are guaranteed
unset) then the ioctl syscall wrapper can do the user copies.

You'll find that _IOC_SIZE() is used in many places.
Amongst other things it can select between 64bit and 32bit compat structure=
s.

> oh, interesting, I didn't realize we embed struct size into ioctl cmd
> and match it exactly. I see that pm_scan_arg has the same __u64 size
> in the struct approach, I'd stick to that, and when we extend any of
> them we'd need to make sure to either ignore or hard-code the size
> part, hm..
>=20
> > That said, either way is fine. We could mirror PROCMAP_QUERY style for
> > consistency.

There is nothing to be consistent with.
These are the first ioctls for /proc/kallsyms.

I'd also point out the _IOC_SIZE() is limited to 14 bits.
There is much less scope for applications causing grief with very out
of range values - indeed you don't get past the switch statement.

David

> > =20
> > > >
> > > > Thanks Andrii for all the thoughtful feedback!
> > > > =20
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > > +       err =3D copy_struct_from_user(&karg, sizeof(karg), uarg=
, usize);
> > > > > > +       if (err)
> > > > > > +               return err;
> > > > > > + =20
> > > > >
> > > > > [...] =20
>=20

