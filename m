Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793917936;
	b=NpyCWvaKou1YHiVyBuatUdAcuL6CmBrTE03PGAdDikuUckNGtORj4dvXes+HVVfGmpyL
	 dLDX2bubrFqKDdGclYz+2u5h4P7paXHkC72KNMZFCQ5Qe5wikg4jgPtBpmk2CTT+WUzmD
	 mMDuWqDdpKPFmEvVYoKjCizF9DojHw1fnaJjyMd373jQQOdGDijKipuXnS7doX/q37NNR
	 WQPoYrp6OhWJOB9cNlg9yrp7kut7k0ZbIpgxhoQeg0y5oGm6aaeRWBmSUqHHT2L3QRtSu
	 5SllZhMG7d2zI+zC8PQJLNYMRRCkdclq6VWqLQlVrx3X7x1AKYWElDL4L24lw1MJDxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dVk8FlSCk0p0X/zLsBRSgcQPtRAQ4rsApX2OtPYv6mA=;
	b=WwQ/l7Z9Aslr0JwM5FcWwsvzCT9Xo5ucatPFIJEfBBNYmXf/U5KnKjXtBCpEgih4KylE
	 ORQGl421xAOZXsYJwC2euFLlb1LgFtVul3IJkvlg6W8IO7B2yJ8cgbqlYl7gMPJgx9/ZG
	 pHXq3GzfamyBX+YXGKqfaGBmAdsa1Acm4OQoFiX62x/0VXcHw845OQP6tPHMbh2/HPoud
	 abgGmbRj6DptpuG0hw+e4ZgTyywC8ZN7VFJDDvsBJMuL3OYU6ACKtTyPA5uJJd+iJIFtY
	 DjRS66FGK0FxgBF7divunLUTW/Nb9vicptq8GV31VqnlyLHS9JAJMn6rkGRTas4kLkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eh+RrIwy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E03606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 22:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50E03606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eh+RrIwy
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b271e573adso514470b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 14:32:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793917930; cv=none;
        d=google.com; s=arc-20260327;
        b=o61PRh0fe5kwHrXjLwoKbcKk0n12OviwF7HOCm9CzZ8kCzoYKvCmWfkyKT6leLS1cn
         H485QrB0X2NPdHGcrFkxldHooGBn4TAJkumGDAfXIdgCilwe40pjo9TrmEcgNVAgZIUs
         CAhu6shJdtcGgbUXfxnUqkPKTC3qpEro8joZ9JdsD73H4E/ssZCpGtcCOFfTH1yLDhL9
         t6Ze5bTQtD8m8sHHUuv4sppxKTPxh74hck8We8/C0/0LXEkCH5UR/io6LzcEEEB2/LgA
         gwzkXlpbW7Ou910B+kaDIJmjRNwwqq1Y8u+5/hrd/DFVNi3+PPa9UGoBL5XIJ///qjy3
         atUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dVk8FlSCk0p0X/zLsBRSgcQPtRAQ4rsApX2OtPYv6mA=;
        fh=gXBdkORkxK+IYiTSyfqKGX/VvppgPN3IHaiMxZk0IgU=;
        b=m+o0fAGQKS6KoC4hebh/Fn26hvoW/2DosrV3IGWDgKCZk/Fk6Q4zKy4ufpgTETxPYR
         Nf3yaRGAA6G53B4Y4iWboyJZ/i1kWvPdpROA5bKdiYnhOnK/NoILlCYXBzzxQ4c/W2Ec
         TFz99/R+YEtyAJODYNSwmkGAmEtm/IGPbZ3QjZbeo8qKJJ6B1evaRwvvtHwCHcU9Wd5l
         Jqp57NdiqiraYMX6zoIjMfjp3SNKubqvGNM+9fd85NIMZRN8jdWFyijOiM+1WYxJKmeq
         MnCPXPLpYAdm5AiFoVwQF3Pha2xmALoUZo5VWdt2go+RVeeuI28FcRyUGupvQujd1PfR
         ee6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917930; x=1794522730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dVk8FlSCk0p0X/zLsBRSgcQPtRAQ4rsApX2OtPYv6mA=;
        b=Eh+RrIwyRW2pLFAckDF0MHCbB39wfpgowwsx1EjCEg4TjglDCPKN/+7ORVBplodNEl
         jPsuezn9sp+54nY0YFIN5id6tKlbCmtePGeBOzUEgEtD3zRu4wGuAGpQI9AU5O9H/OG2
         BPrZhYK4c4JMn8PnVzz5wZtQIKJrYDSceGNLApikgEpvL+Cm5kmuYnC7eHy1JGXZFMxb
         f758muqYNnvb4aLtbgJMg7+gE4B3HhSKAGYRVp57kx0wCQq7XDhPMG4nfMdkf23f4ouv
         mOvK402Ka+ie5oiUrYTV9bgBNPGKvXrkXueKKPphc1LciwU9R0c1CRCypkNY+ZaDHYvD
         3AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917930; x=1794522730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVk8FlSCk0p0X/zLsBRSgcQPtRAQ4rsApX2OtPYv6mA=;
        b=yxPEkq/DBC2mwa+E6a31FDj4Keuk/Whznj7f3PPvL3GOloPHhjglpeRpvMhCi8X1mR
         kM8tBX5+AqN4JaZjMDHJEGaOm4cgKnaZs+kjO/v3awGS330Lz7PrQmrya4IKomLDXa+8
         dzYYmQ+Py8Ue6YjJXHzFL8v6kfJ6GB6+MiHoAzJzMqslF6zHC57B9OU7RdazhWAd27j5
         FOlMfNBtDgsOldxeKU5fPBm9SMGFe0h7nLTaNsHlUQmcbfxcz+B/WqJddXypaTEPkooW
         1hZbH2wdrxExbbNTpufPrBDMrJAZq5M9ynicyVJj+6hT0wIFrt/E/rTdp2nAvw7wQtna
         Z6sQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrbtKLFMMfJK6y6tZegxZUzqF8Db4iXLDY4bD9OxYTekdkcqSk6FLCLTn3HA8snciHzfm4GYWnExfsjeRQ@vger.kernel.org
X-Gm-Message-State: APuU4Z+1fZoijA6r2SOQEb/KlY6+BHsJBOPVjp8RJ0ydVEjZe2p1YFt1
	I+tmX01yh5teaHGBqiu6YYzR/FZSHxZbH1ag1Ybg91r7h4zf7WdJdwWxMRBIxEWtdg/K9QdtBrF
	vEV0sv3zR/n7mk4NG91Q7VcFF7jNeqeE=
X-Gm-Gg: AYBFou3lGtUABniP9oiwODgc01qsR/xYGDHGvX8FWoXzigRuBNdt7xE3+ZqzV0RYo9A
	W1dC2N5HqZxT0u1so8cE1XATUOMVqithfC0tqumFX9XcIjCfIrlruWVwdLDvpLwr44QGvwD3xWV
	hGsp3FwvrMiREN4hjDoqVFBw+ML8AZmnSuSmXvdAuZSXJnwsQgCoCOzt8fjEdqInkTfTCRdG37p
	LzGx5zjMVvdjAw72jPSSxnU97wrwjoKE76Esp3tRDG+kkIH+ikJjpq05Zw0bPfHwUAms4y07mD6
	E4/lr246s95CF0e/Fs4Nu/ZOCij2wz6v9FRnUGTxlWtZLX4OXM3c8V8cnR3tN7UvrjLXIAspgsc
	gsMeXyewsJuORB/f7TE40lxASNe0HkI6si8+bznxNdc29YHUzdS8tFm5skLCd+alwsx5DqnijCs
	0HoKPZZg+/8F5ViYkjKnsQZYAzkySJmLgaiw==
X-Received: by 2002:a17:903:2304:b0:2ed:1f0c:d31 with SMTP id
 d9443c01a7336-2ed40e688c7mr9370095ad.59.1793917930400; Thu, 05 Nov 2026
 14:32:10 -0800 (PST)
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
 <20261030100215.6f8e0d4f@pumpkin> <CAG2KctqdPq6NmK6rB13s2bgM7kP2w4OMMy2hdp_OFMVYYhTnZA@mail.gmail.com>
 <20261104142307.431fc12f@pumpkin> <CAG2KctrY6GmVqsKP+fXYCsL6wDR4zp1kdRd7a7uOdCgg_JcMdQ@mail.gmail.com>
In-Reply-To: <CAG2KctrY6GmVqsKP+fXYCsL6wDR4zp1kdRd7a7uOdCgg_JcMdQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 14:31:58 -0800
X-Gm-Features: AclHuK8BPGpbYIUoL0zJXTIzG60i-gPbL3KKgBgfTHwRc2VAS0UUrPKJVoGciTA
Message-ID: <CAEf4BzbYqbPRPWQU9yM29E+Pr68y+KX0O8whK-36dyH=Zd_udg@mail.gmail.com>
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

On Wed, Nov 4, 2026 at 4:06=E2=80=AFPM Samuel Wu <wusamuel@google.com> wrot=
e:
>
> On Wed, Nov 4, 2026 at 6:23=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 3 Nov 2026 17:14:26 -0800
> > Samuel Wu <wusamuel@google.com> wrote:
> >
> > > On Fri, Oct 30, 2026 at 3:02=E2=80=AFAM David Laight
> > > <david.laight.linux@gmail.com> wrote:
> > > >
> > > > On Thu, 29 Oct 2026 15:05:45 -0700
> > > > Samuel Wu <wusamuel@google.com> wrote:
> > > [...]
> > > > > BY_NAME matches names exactly, like kallsyms_lookup_name(), so th=
ey
> > > > > would be different symbols at different addresses. Please correct=
 me
> > > > > if I'm missing something here!
> > > >
> > > > Only that the user might really want one of the copies.
> > > > Sometimes there is only the copy.
> > >
> > > Good point. I'll have v3 add KALLSYMS_F_PREFIX + pos/next_pos
> > > pagination to cover these. A prefix query for "foo." also finds the
> > > copies when plain foo does not exist (expanded on this in my reply to
> > > Andrii's Oct 30 mail in this thread).
> >
> > I'm busy rebasing my patches - they got stamped all over :-(
> > I should get a v3 that applies by the end of the week.
> >
> > I will add a 'prefix' variant for you.
> > The 'next symbol matches' flag is exactly that (actually it is a
> > this symbol is a duplicate to avoid issues at the start of the array).
> > So in this case that application would always need to read
> > the next symbol (by name).
>
> Thanks, that would be helpful. For my v3, I'll keep the lower_bound()
> approach so the two series stay independent, but I can switch over
> once your series lands, so there is only one search over the name
> table.
>
> > I think it might be more sensible (less pitfalls later on) to return
> > the symbol number - not that of the next one.
>
> What pitfalls were you anticipating? If the current symbol's position
> is returned, userspace needs another ioctl() call and an -ENOENT
> check, to learn that there are no more matches. Alternatively,
> returning the next position means every call pays for a look-ahead,
> which for an unfiltered query walks the module symbols even when
> userspace only wants the first match.
>
> Andrii, do you have a preference between the two?

no perfect solution, but given you don't always care about duplicates,
I'd probably return the found symbol's position, which can be used for
further pagination (if necessary, user just does +1). so, let's return
current symbol index, and have way to say "find by name/prefix 'blah'
starting from position X", where X will be previous symbol index + 1?

but tbh, you have to write some code on how to do these "typical"
queries and see whether API is convenient and meaningful, hard to know
upfront what makes the most sense
