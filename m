Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793930452;
	b=sOdK0MJtCHhBYr9h2JdSwCXWh2xDfH39PsODE7Ow1Zyta7C6rX3zIrTpMLwdzJFYT4El
	 GilRBvsWZzNkvdQ/cWhx2QRtVLeoBAZ3/bUr02aa/Utye3Pppk2CyNs3MDHLoP21NXxbJ
	 cW2bPvIZ4uZLw/t7xcjk+8qoUtnyjEJ35ghbEZcmLBK5DtWIJbKoTEevR4xLw/GRkCUSl
	 xypzpJFqOKJCyYvvyPK5hd7sAnCYX4FV7qcLDACD+D3Y6FzsTABZ5UPKKbbxxuS3Ug7Q1
	 /Dsw3srZmsNPSbASiLGe3V3FTLCqgNYf3jqAyN7j1MkfUa1l7g/OxGS3MSqEGHkpjEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=s7c/qg88c8erx5Dvpd9/JaL1ilkeZNtkbNUxPsE3zPs=;
	b=No3c9oMASbrrw1HumT52oH9L5p/cTp1IkwZg2zPNaSoVkt2l3h0yX5zPy9FIef2WiPfb
	 jbBKBJVP1sB2MNRdjwJ4wHilpNy9VyfnwvWqBqPvRiZoG/nTHWVaIGAg5WskSNDbXgStv
	 YV5VWXaXsGpbGK1GSJ2AkGDGf92prjf0MfG5zJqLunn1MDkPBuLZIaA9r/2ZFBpYbUL4E
	 K1fk+j9rvyUyRgMUM3NKC3K/y8O3lsxFD0hgJ+DGBINtcLiv3iftq3m3KNMkzjOT9VUt9
	 kFWVcY2y6pXOMd4uISZZXqu5SnTJ1mE8yJh5/2O8BjxY53shlh/MsTkBB7WK5gaaYdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n0sfVB8H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643BE606A32E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 02:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 643BE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n0sfVB8H
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4322d310e7so23158366b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 18:00:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793930451; cv=none;
        d=google.com; s=arc-20260327;
        b=ErNyD90yngBRgehWbulfB946Gcdpwj1YC2SxJ3poyCaKIR4uQhahUSmu7MnxZFyVnE
         2/FzjW2LAvddk43XNZalWe8DWhgPNAUjkYQTXY+r43FgEaE++hahRevlNSkqc/Rcg6Hs
         248tj91FySBGSBZKgsOURqXXT9/zhwRUyuP7SYfAdK6pk1+5au+w9fhYuaKPydpr+A/b
         yV+ulnGYZWivQk1DMM6FU3T/tY23xRoRMoSWNm53cPnTq5tlblYX68ZJgdrJ1t7wSfp+
         mcXtQ/apreWeK5bfY/5/DTAhnYJZFi2LFXnRl2fweJ/svFEKwaDvQXsDpfjk8m8ZQvgn
         HvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s7c/qg88c8erx5Dvpd9/JaL1ilkeZNtkbNUxPsE3zPs=;
        fh=/mxpp6aquR2vm8QCtlWWh78ONHSrDwd0xAwWjbrG/PA=;
        b=pXHigZRDwgvSBdG3bguY7Ek8jjWRF3UfdhQAmIxn/RMD2Q7JoDJaCZ1vZ7CJzxtLw7
         buvie3Dgo8LYsCIHaSXGenGFnHpm6HmCvm5X3cUgN+RPHXoejKLefs2wlA5ZK7h3d3OY
         BZ9ek93do4beuzoC+yILMXdkAZyn+rlUkWDxn/2vcP2/vg3zf8P/NGRkrVj1s35sY3bh
         TZq9K7MIStalYIFEAxqs6Hl/nri4q09cFFi4b4yx/D/Q3tU/FgBW1//UQrzEAsxLMdHk
         Z9DsAq5oMDJPEPIKPxTK5BieiYp7zwfdXcqGd4i9i+r3EYA61tK6GPkxkmUgNdERmVV1
         QgwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793930451; x=1794535251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s7c/qg88c8erx5Dvpd9/JaL1ilkeZNtkbNUxPsE3zPs=;
        b=n0sfVB8HDMUIuXTocfcJVzoho8pZXk6bz0tzYjFzYmhSx1pFhTaSZo2yumVp+d748k
         EF4jR91ea7ibNEGxROUSMHM011PgzTAI8L1qWD0ISoyr1JcQCXHPqNvsMWVFxbt9wB8L
         pVWLUNSqw5HdxDBqekaiiz5oT5qSjOrJE5ODDKZ/VB3w6uZmeyx/0kQYDZapcUrltRdZ
         8fR0loS/DvGXRU6jX9KX9o6p1Ldw8G7WKpqq2NCoD45ROybfLxtqHAL0Tx2xU7De+KLh
         gi5zSg4xLzZZYLvuMhcffDFLNETBzEZCobr2lGt0WTB8BXHid6mc2feh+qdplGHJNBHS
         He+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793930451; x=1794535251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s7c/qg88c8erx5Dvpd9/JaL1ilkeZNtkbNUxPsE3zPs=;
        b=kwvOy0e/Ey40qxMu2tKKQFrGtJ47qg6FQQyiOe24tAZYK6W2TDFftnuOYGwOl/R6PI
         sWYVOekNVM53V8cpMP8rV8QuHJRnarsWiBIJmYHlWV2YQLFMy4DohreVFxjjUV7S+XAx
         GowcyKVhqu0BI0rUI0HyAPZJa+whFoyQrBO+kwZEPqQEbIy+wOwFlc97QZLNS303+boE
         ETTp/sIjl9GB2ZvtOTSPsCrKBI1vtBskqi3jI5BKZ8bMissbYbOFXroJSL+PSZmPlPc9
         7elZnkv/oS2d64YlGEITYt9Sp1l0x4r99NXw2in9CDRo8EMzE0tGtmPTdHME+UIEeY/U
         tRJA==
X-Forwarded-Encrypted: i=1; AKwUvBz4Gbyl9T/ZwZ/rDskPljH3ty8a09wzBvmcmTUmx5gyobghiE/qlswKUC7hS1+lpKU6o2x4JI6R78bd527D@vger.kernel.org
X-Gm-Message-State: APuU4Z89mOaNLXxgj56RtOGS8zKwX2HETqaARpeypb6IsoeNQ+7zxvyO
	eGUocsicYv1SmeP6Z6as9b/lEw4C9xZr7LKCpOzqEGOrBfoHQ/bGV+HNYCFId2WvK/jFTiECe8t
	l/e41A/YaENQWLgfOD4l1YlSz5KqezWs18RnX77gq
X-Gm-Gg: AYBFou1v8y4DBItLqbrrZkUYXjYGsBSXTEvPmRcaCdazJJUD0r8vhFy/P+NPByKdKBC
	EYnEdZI0VOVlmZSAnBj0atvxtUSl2FOKGjafl89EKdDNr5G2u8j7Mlk1Ag7cQ0nyJtscoL6CCpa
	nC7Kmo/GKLymmglvtzqlCX57a6zuAgGTncE7Z9r4O2xDnIv+poIRW4tzKYqhSnCXOx0YvBT1rz5
	ylw1kCEKIc/SZyMd4/r3lhybSUMMHDWnwHsumjV/79lVE1yd7wNDblzZ35QYTrWz/k/aWyqEj3w
	55J9H071/FwBYihdanKcHEEhOGTl4KRarPxvz0THaHKVNV40MDIxLe7HPKIZq9QjfejybsKw6a9
	I71eVkdKUmt82zCTzKQ7p1YazEVZJ7f2G09ruFUzIpKetwShQJKeDd7uv2Z9DwoUyeHPpvAI=
X-Received: by 2002:a17:906:ef04:b0:c24:6985:d7a1 with SMTP id
 a640c23a62f3a-c4d3468f9f2mr101330766b.7.1793930450357; Thu, 05 Nov 2026
 18:00:50 -0800 (PST)
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
 <CAEf4BzbYqbPRPWQU9yM29E+Pr68y+KX0O8whK-36dyH=Zd_udg@mail.gmail.com>
In-Reply-To: <CAEf4BzbYqbPRPWQU9yM29E+Pr68y+KX0O8whK-36dyH=Zd_udg@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 5 Nov 2026 18:00:37 -0800
X-Gm-Features: AclHuK_AXTODf6fbRoRayz3qqp4e-qEs_ls_rSieFkkllrojC2ZFyUBK4KHwxAM
Message-ID: <CAG2KctpBEtBxwb6Tayg8z5na39TVe9GQ1+Bk5ts6eL7VaKjKnQ@mail.gmail.com>
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

On Thu, Nov 5, 2026 at 2:32=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 4, 2026 at 4:06=E2=80=AFPM Samuel Wu <wusamuel@google.com> wr=
ote:
> >
> > On Wed, Nov 4, 2026 at 6:23=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 3 Nov 2026 17:14:26 -0800
> > > Samuel Wu <wusamuel@google.com> wrote:
> > >
> > > > On Fri, Oct 30, 2026 at 3:02=E2=80=AFAM David Laight
> > > > <david.laight.linux@gmail.com> wrote:
> > > > >
> > > > > On Thu, 29 Oct 2026 15:05:45 -0700
> > > > > Samuel Wu <wusamuel@google.com> wrote:
> > > > [...]
> > > > > > BY_NAME matches names exactly, like kallsyms_lookup_name(), so =
they
> > > > > > would be different symbols at different addresses. Please corre=
ct me
> > > > > > if I'm missing something here!
> > > > >
> > > > > Only that the user might really want one of the copies.
> > > > > Sometimes there is only the copy.
> > > >
> > > > Good point. I'll have v3 add KALLSYMS_F_PREFIX + pos/next_pos
> > > > pagination to cover these. A prefix query for "foo." also finds the
> > > > copies when plain foo does not exist (expanded on this in my reply =
to
> > > > Andrii's Oct 30 mail in this thread).
> > >
> > > I'm busy rebasing my patches - they got stamped all over :-(
> > > I should get a v3 that applies by the end of the week.
> > >
> > > I will add a 'prefix' variant for you.
> > > The 'next symbol matches' flag is exactly that (actually it is a
> > > this symbol is a duplicate to avoid issues at the start of the array)=
.
> > > So in this case that application would always need to read
> > > the next symbol (by name).
> >
> > Thanks, that would be helpful. For my v3, I'll keep the lower_bound()
> > approach so the two series stay independent, but I can switch over
> > once your series lands, so there is only one search over the name
> > table.
> >
> > > I think it might be more sensible (less pitfalls later on) to return
> > > the symbol number - not that of the next one.
> >
> > What pitfalls were you anticipating? If the current symbol's position
> > is returned, userspace needs another ioctl() call and an -ENOENT
> > check, to learn that there are no more matches. Alternatively,
> > returning the next position means every call pays for a look-ahead,
> > which for an unfiltered query walks the module symbols even when
> > userspace only wants the first match.
> >
> > Andrii, do you have a preference between the two?
>
> no perfect solution, but given you don't always care about duplicates,
> I'd probably return the found symbol's position, which can be used for
> further pagination (if necessary, user just does +1). so, let's return
> current symbol index, and have way to say "find by name/prefix 'blah'
> starting from position X", where X will be previous symbol index + 1?

Ack, seems reasonable to me. Thanks Andrii
