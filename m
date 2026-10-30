Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793385762;
	b=scrZzNgUaeRouVFe6AOmoVapGOEjksUGlAvvzWS/Jj61zx0Sa0f3ag1Z1KwA48NQwIED
	 vs0KgT5zzmM3A4O1BB1pqF9yVGsou7sQOL1RF1DbhdqEK7MgLvmt6N3HIElDvMgKPyWeD
	 Vq82Gkx17debrLhLmomMQfLvPlnFjiQJSn11QKyXE7sLlUqLfFj1vGfVJ2Go9QRVrQQyd
	 0f3zQ64wkOrWJfB6/RV0Gy3DDrN5kFzW7cTxJUQin9NbFpaey9o3v/2sOGtmANzwDP7fy
	 kB/FO0Rr96cKk2q272bHQmvRRLvZAopeEBFiv30M2KSIbo2uXOUPBpu+BvWn9u16Knw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ArYrG0SZmM4/M6BZSvCDJn/YoiUDh8QaQvrAG71KqZI=;
	b=tNwDVU8GDV0Qe8AVAP/C0Sk3RSUY4zEyFqapesnvt/+U9groiQQvgp3CJhv8jo6PGkMI
	 YER8TFsC8WU2aFGyrptqNG6Jnkn5XAzsCgx8bk0Y5DahKqxcMOlqxAgguIuEnTLAgyB1t
	 iv9F4RVX1aAJFPPQbrTuAABVXans9Kzf6l7xomY6IFrooLFqW1Edr0e+wZSQNawBOpeuB
	 PvdXJSfUkXRdtWES6scPxz84KK1D4Z8/h0AI55dKY1wz+Q/N3Y2GkSL8wINmtqsk9D2+M
	 2WtwnhdH6sXrNM1NpXnbQlPTWU8i2b/RNxfw68mMuO65UFCyP8BYwytooouqJxTBxgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ilhiRFdm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC07606A31F
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 18:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDC07606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ilhiRFdm
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab98332238so647271a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 11:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793385761; cv=none;
        d=google.com; s=arc-20260327;
        b=Rrhu4kZZRWmykcZGyytU3p/YR9yrUQbINxPGuEOHHwt5aFIesQU+KFc4afShPF1l5V
         AGuXmuPJFQfWfw3iBrRvaKxytAcN+CV9f8WZonpnhHBH0xgvOCPrk4Se2AXID8XwsP7L
         2TQgQ5QCdw3oCpQIrYW3Ipdg0LcjFzMKkd/vVLswtg+iTSvsNf4igLLoVLCLI5X2/Zz2
         KJ3MAUvLMHW2OuGgRHh83PMjJK9gBDTYA88zazUWOejMpXtd1ukS92Tjv3lrl3Ok1p4t
         0VMiDOuyE3IzIG5BHmiCTA0nEtCslgfNLjF9NbdcIaV/tPSOyUUcERfyOMpD+nY7/zpZ
         fx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ArYrG0SZmM4/M6BZSvCDJn/YoiUDh8QaQvrAG71KqZI=;
        fh=C094e6Ywl1x+C6nPou3OxjixeKjoFqP7FFnOxZjR6iQ=;
        b=I0EavxdXQDUNYCt/7QObGA2Aw1XVV9W3ukcy5Z8D/j3Abt6CiGMY3HR8GpNjHerI68
         HYkyGiVdD+XhYLwd5oDCaGrRcY5pk/a4ex0JW2SYIVq2+wCH6HiMHtFCOfYmXxLsf2Ws
         umYAmM37WRwlfG0zc5h4pg8dI08BFlJCGBt6WMBJvLI4SgZxFeGfikqKRM96G+yw1mMv
         uR3VdXJUuVPxyTUQXAoT3mffjJDajTi4MLbBkb6mbd26xBuVRg/0q9ZkB2+zORUCWtid
         RDc0rSi+8qRngx1Zdm0v3qGPJRN8w79F47mac50qyYiGrj1rCNMXE76TX/KjmWbWLcnV
         CJdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793385761; x=1793990561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ArYrG0SZmM4/M6BZSvCDJn/YoiUDh8QaQvrAG71KqZI=;
        b=ilhiRFdmDF7b2CCOVYg3yrhn1I/DSoWRa475WOgAruostyli6ZMqjZ8ESu/yy5CChS
         ORPsHXhLPSB1d8qNrTp62GpyH8yrD+KcK/Sl4X0TBIun9uQC8HbkSLeOQxdSLJiYuFMf
         XQv6Iyxweil5+vEvXvkSgud6DAU4epItDzW6UJ1rlDcLV2A5Mbef3YHl3NS1jQUpnBCz
         cXtS2Y1FhBsB8+HetmFOuYCQG3xb3XiaIZrXChQ1r6BwCboqJU6zWBFLaNgS9KhzrizS
         BIhSTD4xZXL4O7bpS/UEY3kl5bLzYJWvjxr8L2bxTLch81x4AItH1ByoYLZFjTdsOMix
         sxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385761; x=1793990561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ArYrG0SZmM4/M6BZSvCDJn/YoiUDh8QaQvrAG71KqZI=;
        b=e6IXUzpD1rYZ+Yey//V2EKYnlY9Euis8S02JJeNSl+P1Q1wNnFTwQtSCLOUynPMRuR
         5zBcqytpKiGe88SDHS0R6eoqX6wvaqu8+SqUsjj5If5i73jAMLnqkz5Ta52ERsBpw+EC
         O7gHMZtH7F+b2PzaFLpMjA2c3/VODff911l5K5HmD6MKJ7Veb6buBBTVVwEBfZh6rzgr
         /OOEloBCmUb812KKFTNKqUQ66Y5Xzrr/itIGTi1DouNjsXmBM+bH4RUk79vxSIMKJvGM
         Ytl2PaCzXGE55fHBYQhBQRCeGqS0WwwoSgLJy63hXv0QzJ8pGS992TSrp0jiyweX1277
         caQg==
X-Forwarded-Encrypted: i=1; AKwUvBzdI/l9Ix9tkpwzviRHV5htFn6tUmsbp+NKpxWjhwmnfUQxLwkxqAHX5nqxYaH4NLi3Lre1xLMoEF0CoKJi@vger.kernel.org
X-Gm-Message-State: AFq9FYLy8im7qK5KoW2N8fZFd1+RNUN3lVsorcFXXgihUW93pkhl8svg
	l3BzvT3QVv2x7FC46omC8xbDr2zcTOF1wo8cj9xuCw+HpVWP75bj7n1nAut+tFz+C6O//GsuS19
	ZJmrD144GBzrNoZdsaYTrYyyBoH30guw=
X-Gm-Gg: AYBFou1T6ET/DfZIst3+AXMGpIZB5vrYCG5VgLB4L5nm1QoUY0m/RgXOnImXY6/2dVE
	Ds0TlSWBS/yLzhnJ5YIyzTxq6PqOxrcAYhUl6tIPi3VNh1N24nFaHUD+mkIEuFUI5+mWv5bRbaW
	MEuEI7aL3HUOz3s/wCkxZCZ+9TSIB2WcSyvgviF2F0pYdwRZlOBCxDfC6+sOu6AzOW9ds5OMMOF
	s3fVyhuW3iol1nvzS73IIs5CgqudBmnGwCXxm6VFeixEaLpLbqNIt+Kd/FZo7SLlaSfw6dS2THy
	cx8IXxX7JD42tmwKiKoy3+uIY5e/3Iaw1wMZOV/S1FD10qj6uupIRm4R5oKDEQWPdpmU6L/FIdr
	/UHg9pyqBRKi/6irDUOi0Nkm1962J7Gi0R/i5E4N+URy9wxRcE1Ll/2m3jocUk793DgQXc/5Y7B
	OLOBdNBuhyYaYSanAoZPGByJ3hhN8MrxMEuSlA5Xl3ipDySjLvvpSuxwA=
X-Received: by 2002:a17:90b:54cd:b0:3ab:2737:3392 with SMTP id
 98e67ed59e1d1-3ae897a87admr2747287a91.53.1793385761164; Fri, 30 Oct 2026
 11:42:41 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <CAEf4Bzb--Jzz696u057G9_CgQN7zf6ksvoL80KJacKO2CorsnQ@mail.gmail.com>
 <CAG2Kctojb7xiOqTmwWqoAKFaNUECjOzXVc_t6KbG13Pqm2dbng@mail.gmail.com>
 <CAEf4Bzbs8F1DPBz=WXVTExrrNjzvaFsi4L+HEj+zbUTpPSTX5g@mail.gmail.com>
 <CAG2KctpSTCyWQHgJ8GyFEhHPdFawUa6zy0g7rkfCcujJRN6f6w@mail.gmail.com>
 <CAEf4BzbyqPC=RQGWEdpkqu1WDQ2_S0H8pZU2i=_gLuSDQtpFbg@mail.gmail.com> <20261030153528.0d5113e7@pumpkin>
In-Reply-To: <20261030153528.0d5113e7@pumpkin>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Oct 2026 11:42:28 -0700
X-Gm-Features: AclHuK-VjFk5niMzo0il-rDmeKs0ZQg3btwvPCyolGTPblfqirktPQXtvuort7I
Message-ID: <CAEf4Bzbw6hZ3T6uO-ah7c0+K9_kc+k32hV88YFP=qPnHos+-AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: David Laight <david.laight.linux@gmail.com>
Cc: Samuel Wu <wusamuel@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 8:35=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 29 Oct 2026 15:54:01 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Thu, Oct 29, 2026 at 3:36=E2=80=AFPM Samuel Wu <wusamuel@google.com>=
 wrote:
> ...
> > > > > Makes sense, but I'm thinking v3 doesn't need pagination or batch=
ing.
> > > > > I didn't see any performance wins when profiling libbpf, and it c=
an be
> > > > > added later without breaking UAPI.
> > > > >
> > > > > > on input I'd also add module name as optional input argument, w=
ith
> > > > > > "vmlinux" limiting to just vmlinux, set module name to just tha=
t name,
> > > > > > and NULL/zero meaning "we don't care"
> > > > >
> > > > > Makes sense, so here is a possible plan for QUERY_BY_NAME:
> > > > > - Optional module filter: NULL =3D any, "vmlinux", or a module na=
me
> > > > > - Returns the first match by default (vmlinux first, then modules=
). An
> > > > > ALL_MATCHES flag searches everything and reports the number of ma=
tches
> > > >
> > > > searches everything as in all modules, or you mean just full linear=
 scan?
> > >
> > > I envision ALL_MATCHES to do some form of lower_bound() +
> > > upper_bound() on vmlinux since it's sorted, and then linear scan of
> > > all modules. Of course, just one of the two or both aforementioned
> > > things depending on the module filter (any, vmlinux, module).
> >
> > no point in upper_bound() if it's sorted, you just start at
> > lower_bound and go linearly from there. I don't think it's realistic
> > to assume large number of duplicates, so I wouldn't optize for that,
> > one log(N) lower bound + linear scan will be faster in most cases,
> > probably
>
> Doing a system call for each symbol is probably fine and scales nicely.

Yep, I agree, for BY_NAME case it should be totally adequate. And I
agree about not needing to do full count, just whether there is more
is good enough, good suggestion!

> Just return the symbol number (in the by-address list or by-name list)
> so that the application can request the next one.
> While the application probably isn't interested in symbols with a
> lot of duplicates, some symbols get duplicated thousands of times.
> So you have to allow for them.
>
> (My kallsyms patches get scripts/kallsyms to mark when a symbol is a dupl=
icate
> of the previous one, but after a short linear scan for the first it falls
> back on the binary search otherwise looking up some symbols takes a long =
time.)
>
> ...
> > > > >
> > > > > > tl;dr, this is the right direction, but I think we should polis=
h API a
> > > > > > bit more to be more universally useful and extensible
> > > > > > > +
> > > > > > > +#define KALLSYMS_QUERY_SIZE_VER0       40 /* sizeof first pu=
blished struct */
> > > > > > > +
> > > >
> > > > [...]
> > > >
> > > > > >
> > > > > > PROCMAP_QUERY uses offsetofend() for the last defined field, an=
y
> > > > > > reason to have this #define and BUILD_BUG_ON here?
> > > > >
> > > > > David pointed out that the size field in struct kallsyms_query is
> > > > > redundant. In v3, I can drop the size field and use _IOC_SIZE(cmd=
),
> > > > > keep the *_SIZE_VER0 define (since we need minimum size). Perfect=
ly
> > > > > fine to switch to the PROCMAP_QUERY style though if preferred.
> > > >
> > > > I'm not sure how size is redundant, I don't see ioctl subsystem
> > > > accepting argument size as a separate parameter, so the size has to
> > > > come from the user and be embedded in user-provided structure, if w=
e
> > > > want any sort of backward/forward compatibility. At least looking a=
t
> > > > PROCMAP_QUERY I don't see how we could have avoided it, so not sure
> > > > how we can do that here.
> > >
> > > My understanding is that the size is encoded in the ioctl command
> > > itself: _IOWR() puts sizeof(struct) into the command number when
> > > userspace is compiled, so _IOC_SIZE(cmd) is the struct size of the
> > > header the caller was built against.
>
> Yep, I think that was added by the BSD kernels (but not SYSV) when they
> changed from 16bit to 32bit.
> Linux mostly uses it, but not always.
> If it were used consistently (or the high two direction bits are guarante=
ed
> unset) then the ioctl syscall wrapper can do the user copies.
>
> You'll find that _IOC_SIZE() is used in many places.
> Amongst other things it can select between 64bit and 32bit compat structu=
res.

I see the trend to stick to fixed sized __u64 and __u32, which allows
to not worry about compat. I'd go with that (we have used that
appraoch extensively in BPF syscall and it has never backfired, as far
as I know)

>
> > oh, interesting, I didn't realize we embed struct size into ioctl cmd
> > and match it exactly. I see that pm_scan_arg has the same __u64 size
> > in the struct approach, I'd stick to that, and when we extend any of
> > them we'd need to make sure to either ignore or hard-code the size
> > part, hm..
> >
> > > That said, either way is fine. We could mirror PROCMAP_QUERY style fo=
r
> > > consistency.
>
> There is nothing to be consistent with.
> These are the first ioctls for /proc/kallsyms.

consistency in the sense of these ioctl-based interfaces into
otherwise historically text-based interfaces.

I'm intending to fix PROCMPA_QUERY's embedded size (so that to
user-space it stays the same no matter the evolution of PROCMAP_QUERY
interface). I really think we should start with embedded size zero
here and have size embedded in query struct itself. This is another
thing that we've been doing in bpf() syscall for a really long while,
and given how dynamic and complex that syscall is, we had a great
success in building and evolving API in such a way that user-space
code doesn't have to care all that much about multitude of different
versions.

I'd really-really want us to not have
KALLSYMS_QUERY_BY_NAME_{V1,V2,V3}, it's just a pain for user space.
The evolution logic for versioning is simple: if user space provides
too large struct, unrecognized (by kernel) fields should be zero. If
user space provides too short struct (for initial version we can
enforce minimal supported version from the get go), then we just not
touch any fields added after that size. That's all there is to it.
User space, on its part, just provides its knowledge of struct size,
and then kernel will implicitly assume zeros where appropriate.

really, this is a good way to evolve API

>
> I'd also point out the _IOC_SIZE() is limited to 14 bits.
> There is much less scope for applications causing grief with very out
> of range values - indeed you don't get past the switch statement.
>
> David
>
> > >
> > > > >
> > > > > Thanks Andrii for all the thoughtful feedback!
> > > > >
> > > > > > > +               return -EINVAL;
> > > > > > > +
> > > > > > > +       err =3D copy_struct_from_user(&karg, sizeof(karg), ua=
rg, usize);
> > > > > > > +       if (err)
> > > > > > > +               return err;
> > > > > > > +
> > > > > >
> > > > > > [...]
> >
>
