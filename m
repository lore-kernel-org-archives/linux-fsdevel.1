Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793312201;
	b=q9oKB8ITlXxyWQRZqZS7LHG+aq9RnhYp7BxxRw/ittkOhZd9Y2bc5bHwq+JcI+XWXNux
	 JrcIHxWy6yWCqiEhwW9r0xzDrntlwIJ0V6RC5BhiXYR7xC1Na1f91kco5O+b6rG7uQ7dP
	 MZnakyBt0C0idt/hR8GvFaM2inHDns8Mt9dnuwzzZM/CGsxMoW9NAtFVFVldmjAQq89R4
	 z1DVWf6+TqDAEvfq+eRfMxLT+YZypQEsEXUTKJJPKZqSh5bBOtF9ncqDNn0LhXpXAoI16
	 BmwZwR0sXDYUQKn8lZqT3btMb2XRlg94FcDLu3SMS4IFCRcr5GHsqH2K547rAuJ5AyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=koZpx6vqHKuQYrxobP/d4PhoSM1zd0NfzqrWj5/V+0E=;
	b=l/ym89XC55mPpRCUNU4JD06GqU4c+SAVnnZK1xEwTGTdiEWNB/JkcIPcbSd6ah+jWSpe
	 pZEVfunk8q8WRiHSLh1iTwibP3gwWRCwu6Cmoulc7FoMOIeJTxFkcmrhAkqUhPVAx626y
	 ThU6VerTniAiME/uDwNxgE/j8mywMtBF3VHxqFQdRZmVjQfb/7NpuwlcFOoL3Q12m+PN5
	 9dPLYfWGP8GnLfyOct9fzf6BYO1NkMkc5mZfDeka+v+AhkUI4o0N6cIHbL0yX/lE5GcEI
	 HXMnl/OAZiNF1POG/la1R1L8/8xApWdxwyWUg4DEgrBrl/gFOHWVqyb2ayjOCLSmgRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xr2L+YSV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEF606A320
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 22:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0AEF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xr2L+YSV
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae486f8a27so42978a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 15:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793312200; cv=none;
        d=google.com; s=arc-20260327;
        b=kSv+nH8Xk6W9geZVQ4xWdnDjHkfkjfoU1sBpxqcqaB2FghMZMqR44v8pPILH9O7lby
         AfUr8dDVNZibmsO0PSGIzrDhM3oSO1SNTn1McIcXUPO4QZ2dIyrYwcw55TSJbkZ21pk1
         kW48T6GcIdGHMXjCp/mQDbjVCn6bR4Pfe2zN0wzkdKQtvLSFjIOunsdm4lbRp/RSdp36
         OH/iBtIEoNEbGbLw1IgoAiMKim9bWVKjtcL4diJjROMZ8gdzRxW1+Gmxnjmf5bzVzFwA
         SY6rUm3HpmmgxaPK2T4NM2tvFXABRFfP7xjF2lVP4qKQU1X1SDhQLecdwakCR5zZKNF3
         cckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=koZpx6vqHKuQYrxobP/d4PhoSM1zd0NfzqrWj5/V+0E=;
        fh=hEZmt6QfTudV/lFUegzGkCdELVv/8GMwu7hhfcMkLfc=;
        b=rOl2WS+mY82TZLTqBRV1FmAfpEMW+nBwEsKWz1yJeiUwR7Z11g+MypvlZVQ/Vc3kY7
         odCp/NlwJfVh1eDF1OcYZ6Ik7jBaCp/nGpg3Mw6q+bFV8qbhN738MTX6ILoVmAwEKqQC
         jhaif49uEtC4ci7OT8jhp8IVsL0j4Hp8JgSJbm69tOqU7yt/tyTpU/J3nUiwRMMHqdiE
         99CopcbHxPpWHH3NZjSJJVWJkLycAyK86n+w0tyiGdqj4moz1et+1Uu0wYv6DSRRT5NF
         UDbEjGk3y+I3E2SdGn+xUzpgbRRamc531YY26NjiYo8TTWqCA7cWLqj+kztDoDyLvwQ4
         lwYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312200; x=1793917000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=koZpx6vqHKuQYrxobP/d4PhoSM1zd0NfzqrWj5/V+0E=;
        b=xr2L+YSVfPIi5bsK0sQduGMgmae01aKgXSUseaJikh3GJOXYKaCpT7MugONeWoy1Wy
         L0fdYaceEriICAikAcMys9iLe0NuSQyGQTELjt2Ft54mZK0Ea2rsg22LaEwXUnKKsovd
         kL7PGxEK47e2qujKLsgE9yrTo5lfZKx8nHxgb3r/PIxi0YchvNvUoe5g+rWm0xrJEUse
         9DRaJt4wWvOsq/laKci0C89PCBiI5SJb3D52TcFto6hBRRY+AOb0prFHVuz6lvt3uQIn
         O911UfpGGIIYXaSbBrKrO1+qB14+el9UMLEsR0DWmN+bb465NXDjwcUKwy1uZCPx7BeO
         Va8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312200; x=1793917000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koZpx6vqHKuQYrxobP/d4PhoSM1zd0NfzqrWj5/V+0E=;
        b=aAwp41PL87gPsOg0QZETX4LKVINbHLXJcGR9fJHp+JBW6M9955EM3wj8beyBqe6ZqG
         A3jfTvsuPoLLFY8mMu1UHRZeLOGYA3noCgDkMh+lfoVKn10OAG7Wy9NRzJI2bCaDppoV
         O0hkI5NAA5tU7+JJanXNXHjrjirnMFcH/yZG0984TUjlnFbbZnBsmRLH1ht/XoDPxvAS
         0ycTo7us1zMOHl10X676fowSaHdXB+MJXT/o5Rbi6Y3x6a9VhydTQbAOmJnoxtll/iKr
         PZBN79UB5mwBQAH0miVOVF/nNAoq5uWb4QMdOn7L5vgSN43+B3OD71sWyFuT6sjcSo2F
         t99w==
X-Forwarded-Encrypted: i=1; AKwUvBx6fwLb2oLmHtBw60JUM+uKxBHWxT4FeIPb1PYfDvkTLfcMmqd2wpORpKl6koCczYQuVXFWpq/pAEieaQNs@vger.kernel.org
X-Gm-Message-State: AFq9FYLgVN9+N0Pox2ujA3F1bidzAgud/uAC6Oj+ht57fMXog65FGOMb
	W7r9gsx59/LB1SBnd8SAgJY1EZbllgFelAjiB3OCCwCk40DDH2VYqR0YcOhpZi+fhdCJ/Cs9oqx
	Ni6Wcby0csOs2n4HR7UEp2mZs6ukoA4I=
X-Gm-Gg: AYBFou31n6N0xHCeAuzHXdmWKOyhCsZg/ur48qSQsXVvXlKblM2GWmcXy/n0u8NVvmX
	5tKHjDeI75nR+ZYbCvCYlnSmKiPYG0mAKP6p5HICLJX+Mv2lmeX5Lk8rWsERasFkqXL9cckKMS3
	UZ9+o+U6z/Si6hYegk1/td+WvWGdKoghHMohKn2Ylpfjs7mqdlGDEu29R9GeIi6cw2azSehYKNl
	FCtf2FlEWqIpYa62m1+PKF/rCnfxG+E3CAQ9yundPPaSyoccAd12gUTZ7cxlbIVw7ZwmJ62i9R7
	GrUf9rgcSwEAffOQTq1uYGppjQ2SO+4YlwjVMjzpaqn5udPZqpGmnFvJkkCJlqSd4XITnfuFsDY
	0jCmZUD9XmdAMIuQkWDv09uH/uPMubN45FDKLe/VVprPNH0N9qoyRYLNRV7pI6XvD88/JY4vXnj
	Huek11PtSBzZnPwcrOHJRPltgzS57Zmy7yxw==
X-Received: by 2002:a17:90b:380c:b0:3a7:250:333e with SMTP id
 98e67ed59e1d1-3ae896f8315mr277145a91.11.1793312200139; Thu, 29 Oct 2026
 15:16:40 -0700 (PDT)
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
 <20261028134012.01d52e94@pumpkin> <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
In-Reply-To: <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Oct 2026 15:16:27 -0700
X-Gm-Features: AclHuK9av7Er2dEcOWg6hJWIv2K2TpdNYpqUpTLgWkKxe-dORmBpAAvoyO4hh00
Message-ID: <CAEf4BzYT4rvKwbOJ6UQ3zcp4wdsSBqRsMz-2=U1DA2RyUA3XSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Samuel Wu <wusamuel@google.com>
Cc: David Laight <david.laight.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
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

On Thu, Oct 29, 2026 at 3:06=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> On Wed, Oct 28, 2026 at 6:40=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Thu, 22 Oct 2026 17:16:02 -0700
> > Samuel Wu <wusamuel@google.com> wrote:
> >
> > > Add an extensible KALLSYMS_QUERY ioctl() interface to /proc/kallsyms
> > > to support fast point queries without scanning the entire text file.
> > > Exactly one query mode must be set in query_flags.
> > >
> > > When KALLSYMS_QUERY_BY_SYMBOL is set in query_flags, KALLSYMS_QUERY
> > > resolves a NUL-terminated symbol name in vmlinux or loaded modules an=
d
> > > then populates sym_addr:
> > > - Searches vmlinux first via kallsyms_lookup_names() (binary search),
> > >   which takes precedence over loaded modules, and falls back to
> > >   module_kallsyms_on_each_symbol() under module_mutex for module
> > >   symbols
> > > - Matches names exactly, like kallsyms_lookup_name(), disregarding th=
e
> > >   .llvm.<hash> matching, following precedent set by commit fb6a421fb6=
15
> > >   ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")
> >
> > Hmmmm....
> > What happens when you have functions foo and foo.constprop0
> > In some sense they are duplicates.
>
> BY_NAME matches names exactly, like kallsyms_lookup_name(), so they
> would be different symbols at different addresses. Please correct me
> if I'm missing something here!
>

foo and foo.constprop0 are different functions with different
arguments, so I think we should distinguish them. The only special
case is .llvm.<hash> because that suffix is added by compiler for LTO
and I don't think the function itself is any different from the
original

> > > - Resolves 0x0 symbol addresses in both vmlinux and modules
> > > - Rejects ambiguous symbols (multiple entries with the same name at
> > >   different addresses within vmlinux, or across loaded modules) with
> > >   -EADDRNOTAVAIL, while allowing same-address aliases
> > >
> > > Userspace symbolizers resolve kernel addresses to symbol names with
> > > /proc/kallsyms. This is typically done by reading the entire
> > > /proc/kallsyms text file, and keeping a compressed sorted copy of it =
in
> > > order to resolve addresses at runtime.
> >
> > You could mmap the tables into userspace and have a ioctl that reported
> > the offsets of the tables (etc).
> > Then user lookup would faster then kernel lookup!
> > Especially since you could throw a bit more memory at it to remove the
> > linear scans.
>
> I think that would increase the UAPI surface because it would set the
> table format, so I'd prefer not to. It would only cover vmlinux and
> not modules, and then we'd need to apply kptr_restrict checks to the
> mapping.
>
> > >
> > > When KALLSYMS_QUERY_BY_ADDR is set in query_flags, KALLSYMS_QUERY
> > > resolves one address to the symbol that contains it:
> > > - sym_addr holds the address to resolve on input.
> > > - sym_name_addr must point to a user buffer of sym_name_size bytes
> > >   that receives the NUL-terminated symbol name. On output,
> > >   sym_name_size holds the number of bytes written (including the
> > >   terminating NUL). -ENAMETOOLONG is returned if the buffer is too
> > >   small; a buffer of KSYM_NAME_LEN (512 at the time of writing) bytes
> > >   is always large enough.
> > > - Symbols are resolved via kallsyms_lookup(), the same lookup as %pS,
> > >   covering vmlinux, loaded modules, BPF JIT images, and freed module
> > >   init functions still tracked by ftrace.
> > >
> > > On an 8 CPU Cuttlefish (x86-64 VM), using this patchseries to load a =
BPF
> > > program with 11 typeless ksyms has ~220x speedup (157ms -> 0.7ms).
> >
> > Have you tried measuring it with my patches that speed up the kernel
> > 'search by name' code?
> > That speeds the lookup by a factor of ~18 (testing the code in userspac=
e).
>
> Not yet. Can you point me to the latest version? Happy to try it out.
>
> > You also should allow for 'find first' and 'find next'.
> > As well as letting the code iterate though functions with the same name
> > it is absolutely trivial to enhance the 'lookup by name' code to match
> > a prefix.
>
> Agreed, that would be useful. In v3, the idea will be to have BY_NAME
> return the first match by default, and an ALL_MATCHES flag to report
> how many matches exist. Find next and prefix matching can be added
> later with breaking UAPI, and best to not include in v3 since there
> isn't yet a user.

I do think it would be good to spend a bit of thought on how to
support at least one-by-one pagination from the get go. The same
mechanism can then be used by batch version. I.e., think what can we
use to provide data back to user which they can use to continue search
after the symbol we just returned (at least for fixed set of symbols
in vmlinux and modules; we also have dynamic symbols added for [bpf]
"module", etc, we should support those as much as possible with the
least possible deviation, IMO)

>
> > (Basically it needs to 'return -index' instead of 'return -1' when the
> > binary scan fails.)
> >
> >
> > >
> > > On an 8 CPU x86-64 VM with a 175k line kallsyms, there are broad
> > > performance and memory savings for the symbolization and callstack
> > > sampling tool, Perfetto:
> > > - Init time: ~350x speedup (155.7ms -> 0.44ms)
> > > - 50k symbolizations: ~12x speedup (25.2ms -> 2.2ms)
> > > - VmRSS: -68% (15.1MB -> 4.8MB)
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > ---
> > >  include/uapi/linux/fs.h |  41 +++++++++++++
> > >  kernel/kallsyms.c       | 132 ++++++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 173 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > index 34c6f219462a..b43f227dad0e 100644
> > > --- a/include/uapi/linux/fs.h
> > > +++ b/include/uapi/linux/fs.h
> > > @@ -674,6 +674,47 @@ struct procmap_query {
> > >       __u64 build_id_addr;            /* in */
> > >  };
> > >
> > > +/* /proc/kallsyms ioctl */
> > > +#define KALLSYMS_QUERY       _IOWR(PROCFS_IOCTL_MAGIC, 18, struct ka=
llsyms_query)
> > > +
> > > +/* Exactly one query mode must be set in query_flags. */
> > > +enum kallsyms_query_flags {
> > > +     /*
> > > +      * Look up a symbol in vmlinux or loaded modules (vmlinux first=
; BPF
> > > +      * and ftrace symbols are not searched) by exact NUL-terminated=
 name
> > > +      * at sym_name_addr and return sym_addr. sym_addr and sym_name_=
size
> > > +      * must be 0 on input.
> > > +      */
> > > +     KALLSYMS_QUERY_BY_SYMBOL =3D 0x01,
> > > +     /*
> > > +      * Look up the symbol covering sym_addr and write its NUL-termi=
nated
> > > +      * name to the sym_name_addr buffer of sym_name_size bytes. The=
 same
> > > +      * symbols as %pS are searched: vmlinux, loaded modules, BPF JI=
T
> > > +      * images, and freed module init functions still tracked by ftr=
ace.
> > > +      * A buffer of KSYM_NAME_LEN (512 at the time of writing) bytes=
 is
> > > +      * always enough. On success, sym_name_size is set to the numbe=
r of
> > > +      * bytes written (including the terminating NUL).
> > > +      */
> > > +     KALLSYMS_QUERY_BY_ADDR =3D 0x02,
> > > +};
> > > +
> > > +/*
> > > + * Returns -ENOENT if no symbol matches, -EADDRNOTAVAIL if the name =
maps to
> > > + * more than one address, -ENAMETOOLONG if the name does not fit in
> > > + * KSYM_NAME_LEN (512 at the time of writing) or sym_name_size bytes=
, and
> > > + * -EPERM if kallsyms addresses are hidden from the opener of /proc/=
kallsyms
> > > + * (e.g. kptr_restrict).
> > > + */
> > > +struct kallsyms_query {
> > > +     __u64 size;             /* in - struct size for compatibility *=
/
> >
> > I'm not sure you need a size here as well as the one in the ioctl comma=
nd.
> > It only complicates things when they differ.
> >
> > If you need a new version they you add an extra case to the switch stat=
ement.
> > Simple and easy,
>
> Good find thanks! Will update.

think about user space application compiled against UAPI headers from
older kernel version. For that application size will be smaller and
that's ok, newer kernel should honor this and only fill out smaller
part of v2 struct. Versioning is done by appending fields. This is a
well established pattern that provides a pretty good forward/backward
compat story, let's keep it.

>
> > > +     __u64 query_flags;      /* in - query mode (enum kallsyms_query=
_flags) */
> > > +     __u64 sym_name_addr;    /* in - address of symbol name buffer *=
/
> > > +     __u64 sym_addr;         /* out (BY_SYMBOL) / in (BY_ADDR) */
> > > +     __u64 sym_name_size;    /* in/out - name buffer size / bytes wr=
itten */
> >
> > Maybe separate the buffer size from the length of the symbol written?
> > The in/out parameter will get annoying in code doing multiple lookups.
> > Or just have the buffer size and require it to be '\0' terminated.
> > (There is a strncpy_from_user() can that be used.)
>
> That is simpler- in v3, we can have buffer sizes as input only, and
> names will always be NUL-terminated.
>

user code can be easily written by always setting buffer size, even if
kallsyms_query is reused. This is the pattern with PROCMAP_QUERY,
let's keep it consistent.

also, returning actual size even if buffer is too short is a good way
for user space to "probe" and increase buffer if necessary. unless it
adds tons of complexity, this is a good and flexible UAPI

> > The '\0' terminated string handling is likely to be noise against
> > all the rest of the lookup code.
> >
> > David
> >

[...]
