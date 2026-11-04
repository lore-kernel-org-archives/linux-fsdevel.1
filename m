Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793754316;
	b=ttywskesAck75Mfq7nw/8RjRSogGQrWapvGUupOm27wTncPKDeZEhKV4Ks1tM7fearmR
	 A/CCE5s6oJCQRM4ZPTA2+I1+0D9jpqXevhI71peDI6PnWxHvowu9/F6JGJDM8VBOjaLmk
	 vnQO1ZF3PkKmTybbEQ6dT0RrTbf3p64xTFcqcDHaD1PQxS07nWjcIOtb5BNYs4b40uwIf
	 Z+4BGPVtS6QaiQc6a/aCSviGsuFN8tAT/MkRmtH4bmh3P0PHmD58JBcp0WR+7X744Yi3J
	 pniiZZkljlTaxgZNogbojFG39gxzWHdUecH2jKvdpxDd0ih4Cw5o99fJRG2sXLbEmRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GGVgNCMMS0dFIobhgfKFI81188J1mL3nz/OKckiJVo4=;
	b=RUVD+YRiqs+ZmqOjFLrCZtGQmaTUYX6fMTyjadxVWJX0fvwHsmIwuACbrR6k0E1zbz2g
	 95NfW6YETkc4XFKYwPQBTINtz6aARfCtUL1CEJd/Y8VwdlaHYwwZ2n8LeP0moTjyfi5Vj
	 8lfqQtYeO3dNhS+vaJRd+5AnIqJZcc1dllt0OTwSFOmc3HlsYOiqS2DQPZs/Y/3/oBbfe
	 XuqfmKfM2SLFuzTK4yOiFD9sVWzd15f3F3HQLgegxug1IpEHdARgA2K/qYu15PAmE8PYP
	 YlIojLd2pmQadSaTOsVtGKxYQc1vG6WVcmweJP4/efSZigq+gEG1kRx+reZ1SWh/QZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="NmCY6l/h";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB87606A32D
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 01:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB87606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NmCY6l/h
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4395d31228so26760166b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 17:05:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793754314; cv=none;
        d=google.com; s=arc-20260327;
        b=nVl0QxEuemwb7sm4n+cChSEPKtsX18QQaOdmWvciOOrFHZkWZm/AOirLbMkxtW7trW
         WlftyANnPCyuU9IEd2dDFJQTdD8dPCL9I2vgj60RyoKPacZNaGXagA9ybkvWsaH0v8Ao
         W1XozvnHmnuhrvodTGcmgaQtW6EF/IX1WWerrJYCRFmoIQ1SjFram0ac6BLRGBMe/y5S
         7ndtN0Bsuno/sWHN3GX/78zEk0ie+M0WAKLwPfa+lws5ujgPqRZ97GnknhD8tCYHl32O
         swD/FLZxx97lA8FEwmUasbgUebLUmMil/KAhypHzLxKG1ul96g8eVjJZqQ2dkKEjQy10
         Xg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GGVgNCMMS0dFIobhgfKFI81188J1mL3nz/OKckiJVo4=;
        fh=Prj8gRZWJVhfRbhDjBfuaKntUu3reWhqlWfA4vusqHk=;
        b=l9u2MFz+eBdfSJj2vifnhw5+X/UhzwBbTw0KnUb9rZ6TDecOvHTLZ0TLDRlv62bsis
         La627BL1VJrPpGu2J2xcBSn4olnupjNngJQ4+G0/ReEFqyGw+OhMLMDJSErtOZ5Fv/wm
         ZcgYh0ziVW+IyLk5tJHy7ywtPOpRXshYx+/5d26PCnjCrMocCFgwP3QohPD4tJi5/s7H
         QZ9CM9THg6qxIPCBWUQGzudKE1oh26GTe1U3auCE9Mahk/ATE0o0plY7GY4HX7EZZdT3
         O4sxWEeeNhqLEsE4njtjAWSW7mxKFBgxTtzlFEKkY8bLz5bhZ3T7uYGQyLcX6E2v2h4E
         bDdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793754314; x=1794359114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GGVgNCMMS0dFIobhgfKFI81188J1mL3nz/OKckiJVo4=;
        b=NmCY6l/hddhLIayqwx0pWhDlzky4zOFriG2Pdv4bVgKzrRIN/6DXrKq8SeIFpFSDzG
         OSms2h9cDJSkVBH5/IkifIVYnfvh+hsyQJtRrGsZdUmtb2ziewUHbbsX1RP1CEZB5HxX
         iy51pExN69DyKyexFvTHkYAxYP21gKZD8XowMLSFZiekG7RpaJCHxS4fldPWq/wG8Dtt
         kOM/cipylAMQawMEXaxMxu4+TRBFfLAxSQw9WjmITlds8lBIpEAlzKgdz84Ey9gExnv5
         /B1iiJxBuoY8in0DZjwRakIl1gpv9h2omGVHDsDWWmXteA1WCj/AkvnaACWyEIR7eDwF
         HTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754314; x=1794359114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GGVgNCMMS0dFIobhgfKFI81188J1mL3nz/OKckiJVo4=;
        b=Wb0wYYdXS/jMIcMxepDV18PKtVoXYTkXRgqec3vdVK96SgP2vdJlc7vpZYmrwx4ybw
         7jLOPXs9qg4taidaccgbPwIw71QmTQkGjoAZA9eZ1feNGqsm2j9s9M03ZY1cLHhOXhXE
         gwpHOjuEFUHxtqoHJoSVFMvPgFuXGBLkPrNrcoGUdSFWYQBjS8JDQF+farpsIpYZv0p5
         Stz/KtyvpbNkmpYb914iJrCAjHvN/MMchZuHLHDxDo8+XyNB7lsAKk3VZdrjd8a9DAuu
         IiTGt6byW1pK3WLL28QurJmGOaw2lwT9acB2su7lrE7MTkbet47s13OOAX6ycAsLJDvl
         T6DA==
X-Forwarded-Encrypted: i=1; AKwUvBxzjwe2OxiSisJxYanYKtmcEBnyPlfXDdptB99HH4xXcDLtYSAVPw6Ax54qXYPMo5BVBbUZngR+WqdghQWj@vger.kernel.org
X-Gm-Message-State: APuU4Z+3S3mSgZFJVFuV8lwUWg3x6DI1iYqR6mo+g4VKC8gPdUshDGRL
	OjiHmL+UstMMRw0y2bHdZRIiZwhRVOhWoEOGXWXnHYkPXqQHj9vV2NMt+vYaJ02YgZKBIVl2kEs
	tsK+SQJipA+6Wmmt1sy1uUqB0tN+bmNjUhO1wq/Se
X-Gm-Gg: AYBFou0EwAV95zbis2+n86DgOGGlwwgkXgbDrnLKlbjDxFKuqNnZ1kIka8Qrl5e7SYn
	FfCY3rhLLFfBNvOUqYlRu0+0xIEXibrPXUQgaG8vkxQ8mfdrkH3VqcSp3TeZC7OXNmkcQI6h66z
	cxF9i2uQhu7BJ2pnJjeoKQD74o+9ltw6pZFbuh3CAkwm//8OLnXhP47EN6Afi7tMWop5UAHgAIG
	HQVALCWAkNj7ECIl776fG4k7o6vV7BW5O4IO//+hUXb6/9zB8jr3PKJEcItVHyUhjTURcgukj5i
	ewgk/hP9H+pn3H04ppSwBYxYPnzbLO05r2ZXZCu+p2ebvlG/D169PwyzxoGRmy/kJJr3kjBjmR7
	rE2GkniDsVv3tEe8olWIRW0JL3Q1rx1bd0h5yit3O7HhPDr+sMBum4T1z1Qj4c4BO+VC/Lc0=
X-Received: by 2002:a17:906:c145:b0:c46:7ec3:fdfd with SMTP id
 a640c23a62f3a-c4ca7a1c3ccmr1392142066b.14.1793754313888; Tue, 03 Nov 2026
 17:05:13 -0800 (PST)
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
 <CAEf4BzbyqPC=RQGWEdpkqu1WDQ2_S0H8pZU2i=_gLuSDQtpFbg@mail.gmail.com>
 <20261030153528.0d5113e7@pumpkin> <CAEf4Bzbw6hZ3T6uO-ah7c0+K9_kc+k32hV88YFP=qPnHos+-AQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzbw6hZ3T6uO-ah7c0+K9_kc+k32hV88YFP=qPnHos+-AQ@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 3 Nov 2026 17:05:02 -0800
X-Gm-Features: AclHuK9b_Pt7vf67g62PZ8vH_eaq5fO461r38gdQA-3gsipu-4DIyrTVCZocpdU
Message-ID: <CAG2KctrmAVo-jC5zHURvx9-V_Wu4U8PctxEevycV+zq+6GngUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Fri, Oct 30, 2026 at 11:42=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 30, 2026 at 8:35=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
[...]
> > Doing a system call for each symbol is probably fine and scales nicely.
>
> Yep, I agree, for BY_NAME case it should be totally adequate. And I
> agree about not needing to do full count, just whether there is more
> is good enough, good suggestion!

Makes sense, thanks both. Nearly all symbol names in /proc/kallsyms
are unique (~99% on my test VM), so I'll have v3 keep the kernel side
simple and let userspace apply its own duplicate policy via one-by-one
pagination: KALLSYMS_QUERY_BY_NAME takes pos (0 to start) and returns
next_pos across all sources (vmlinux, modules, ftrace, BPF JIT, and
kprobes). The kernel peeks ahead one match, so in the common, unique
case a single ioctl() returns the symbol with next_pos =3D=3D 0; when
next_pos !=3D 0, userspace can step through the remaining matches one
ioctl() at a time. libbpf does that and still fails the load if the
matches have different addresses.

Paired with a prefix flag (KALLSYMS_F_PREFIX), the same lower_bound +
pos/next_pos also handles suffixed symbols cleanly since they're
sorted: querying <name>.llvm." (or "<name>." for .constprop, etc.)
lands directly on the contiguous suffix entries in the sorted vmlinux
table and userspace can choose to step through clones via next_pos.

[...]
> > You'll find that _IOC_SIZE() is used in many places.
> > Amongst other things it can select between 64bit and 32bit compat struc=
tures.
>
> I see the trend to stick to fixed sized __u64 and __u32, which allows
> to not worry about compat. I'd go with that (we have used that
> appraoch extensively in BPF syscall and it has never backfired, as far
> as I know)

Ack, I'll update v3 to use __u64 fields throughout. There already is a
precedent for this, and it is simpler to not fill holes that __u32
would leave.

[...]
> I'm intending to fix PROCMPA_QUERY's embedded size (so that to
> user-space it stays the same no matter the evolution of PROCMAP_QUERY
> interface). I really think we should start with embedded size zero
> here and have size embedded in query struct itself. This is another
> thing that we've been doing in bpf() syscall for a really long while,
> and given how dynamic and complex that syscall is, we had a great
> success in building and evolving API in such a way that user-space
> code doesn't have to care all that much about multitude of different
> versions.
>
> I'd really-really want us to not have
> KALLSYMS_QUERY_BY_NAME_{V1,V2,V3}, it's just a pain for user space.
> The evolution logic for versioning is simple: if user space provides
> too large struct, unrecognized (by kernel) fields should be zero. If
> user space provides too short struct (for initial version we can
> enforce minimal supported version from the get go), then we just not
> touch any fields added after that size. That's all there is to it.
> User space, on its part, just provides its knowledge of struct size,
> and then kernel will implicitly assume zeros where appropriate.

Ack. In v3, I'll update KALLSYMS_QUERY_BY_NAME and
KALLSYMS_QUERY_BY_ADDR to be _IOC(..., 0), and so the sizes live in
the structs (size; sym_struct_size for the nested struct
kallsyms_sym). Sorry for the back-and-forth, David. Also, the nested
kallsyms_sym needs its own size anyway, which _IOC_SIZE() cannot
carry. That keeps userspace free of V1...Vn command variants as the
struct grows.
