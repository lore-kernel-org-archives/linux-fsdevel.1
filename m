Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654102;
	b=UnUdoz4OdAEqJurc69vyJfvhde1FW5Rg5xIDySCreWuQJvxC8Gf6UcV6PhyOIxOy3fos
	 ZuwSXpGw+1AbZ7tDKXsML4KW233Y7KLds/cXrD+xOZx+KTgjcdOHxBFS/ZjFKtcdR7KEO
	 8crGmeSr7h4aNqOAivrWdn1Nke/TAArae3SwODh1C8hc6EyhSVsjwbOT4hoHETAhR2uee
	 HTBF5vhh6RVW/cP+uYqfS7y7el1uHwzl8Xy7dIyaaQfqTSnZbz3ZeV85UEsCu3ujNo7ZX
	 1eTKwAuwUtRLkRrMOxcBbY4L/eUG1AwYCxyZ0TV+JVDm73U0cUzLrIUv+0ihKre9FCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
	b=1gZwMSspNFcWM61fsQrp7pQT9cPmqY3D1b6bhJ61+/S29OweiJ4t/TjfPaTcil1YcUHq
	 tFiFR3tcmaBNdBhAwpwBamdtb1nXo0QS9m5HoWsA11Zh8IEgjsd2zO3MCx5ICF2V1eyYb
	 io6iiyR32tzb2/PCtkYkw8g6+taHrotpe+kErRA4Tb+w/QQXTa+3XmPcN0NyaG5unFwZl
	 /JmpCng85WDoVd0cjJkhgOFJCHIFokUVwNbMSIj3gs02HsLmd0aebKzrXBA3BQXkX/4DL
	 PI9kUGU6ub4TU0wAQ9Xlw0NXBK+PtPoT/CrVdfHRZSHiRGBCzeSoytDZ6jLP3exPOvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QWMZ80Cz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52077606A327
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 00:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52077606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QWMZ80Cz
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b8a52db5f9so8016403a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 16:48:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795654101; cv=none;
        d=google.com; s=arc-20260327;
        b=HeJany8sl9xKCEMBPWXTLK2k4uTtMcoG//DMJr/ePmiWKLz/bmNd5XJ7Fxa1AQXkW1
         BUh6Bx/+t/zv+7+SX+2EfPCI56k3xOv+ibB718/50T3tV1dN3SfgVIOFQO1p+bzfZIrp
         leiL7lRjCdKKnoHr07laTdsnJF6oYMaqDgFsaq/Q+G2b1s85jUecCAc8C8GBGzCVY1NF
         vh5zii49ZNczV0rw1+0Ov5EJjvkAWVtlVbRavzXMef66c+sCU785jEaDzymwES6L+g8v
         0VKEwzJSGnTlHShSsxv0Op+F4hnjP06TvfsXaowRQV3UlqffCNoJrvALPPxx5/eM6+sK
         ND8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
        fh=8ocBqUSgRqKrzkSAuSqsWTgugQninNdgQCzkIFiykDg=;
        b=WmsEWWTm7aA/RU0tSJ/fKiVxJsjphUC+nX8aVd0kNX53lZsPINp0fIHes+QfrJMnjw
         2tJF2XDFuA2/m/zlS5ZdQFXwEu45i2sFIOYjEU9DYeCT7p2OyHTGPv0+oNHOQzuUfxk7
         1qOvtJ5IRBybefg2zni8BdFhy7KrIsS9HIMMVWBL9uXRnw5HiwYk9en2z3RJKHeUMW0h
         Nv4LpLpFml97Tyw8bMTd/eZD0HfwDZ2rcQUngwFkynVsUKTtDWyeClViXKwmMofxN6ox
         u9m1D0B9B/bmQYH9NrqIJ7qQiBGUYHauwwfAKV+RLvMyWfZChoz0aMkBlpMlnSua4hKO
         EZxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795654101; x=1796258901; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
        b=QWMZ80CzZfH6yoH4sucNVvHTrwf1PIcC+Bp2zpQDOXhvTaLR5/Hb6aclEYP0GJ5EbO
         tJUXzbHm5a1lhC/Ax05U+ZOxJaUnTui2Rk4msdPfixijvZGIv/STMD8sdmvdk0JLoPML
         TqbI7e+F27OvNQ1L2QOdn33Qfg3eLkeqAwD6ryOf7vQH0q2dc2f1o0EKha9CE2cwglDJ
         7Sd/maZlmbFd2u6vfPe4Bc4+mGU0kS7nC1KhuBzJ0BY73ENkc4VuiMfat2qIpNB6JRsB
         QZjOMEBbuY0eBgGxKWFhpFa0ZVGml7Ayw5gVKKOPjRvn3VcvJm969BGQaiZe0I0XPK79
         1ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654101; x=1796258901;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
        b=0J6+jcjHTWu87QD4jIoLGZTg3R+WOIlcSQzI2xFcqjYqq7BG9YlvDgr3/T38nRcb3+
         Ol06xF5oTlvbOdXdz1Wq51ySoYbq3JSGupyOOn5HoF+0neAYp4+VsHE4g0mMhxa7WyCE
         C2UUaIWVFyCooh+duEKk6xisOhgTIz319U88NjLp9c+ODN/DY7mSTwjamlFtNrzBmf9d
         x0i5MWGia0Ud9aZEmnDI269zk/V2wsnLfS1G07QYs8opMGvhLC/2H1ht1j0WxkrQjKbJ
         iyFjYP5AHtlWxMS7eJu7a4GnVExJ8/xMipA8q+zQClpVsIyOdlsreRxlwc0C0fNyL+kz
         gMPg==
X-Forwarded-Encrypted: i=1; AL+hErE7fHW4J6Z+/ZrxWpJNrwgKlejBnZv+NuCse/CXQljXzZoAh4mWyxaKjpD/Ty8XyqIw4PSU/y9KdF6JtG9i@vger.kernel.org
X-Gm-Message-State: APuU4Z+7pfz8w/Dgdw1DTh1fNEb8xxYfCD/uXV3PKx5AoofJWUNx6om+
	Mit1MwdJXJ1+SUKwrdFvPOkRgQ6/AZh4JjfAawv6ZNshMs4pQxw1BLG1s4LlYQJ4SWoBKOwH4qH
	Pdtti0J6zAto3VIFU9w8IICxJ5OEbWOFU2Vk6fJul
X-Gm-Gg: AZFdTZel7a8oK9Agcv4TEr8yrQuUDSajJfyKSUzGIBUhrlI9CnF1RENwzRN+FarHfHh
	VoA7LKrkXlYJoAToaTpeqsnPTbXArKKRQ6+NxkOeq9PxYwuFxsHAX1cCZ1U4VxHi/yXq+g7Z/AV
	/WPgsqhSl2ynse4qXhV67duUIRA8QwToZ0VCDaxiZWKJMWYrbL71+KQCaZMCQllpwlp2V2DOqXP
	gOJjG/GTXgKHOmwLWjoXhgqMNpcNxe16jh87tjO29IhVAMZx9Uk3ghxmHKQsI8LxeAFhPRzFHjt
	plUg6b7uGs+ZylXiKNK14+SldhFrLqeGvGSVh9p76yplI+RYFuU9DGcbQP2E6FgcBgGBya3QN5U
	TM2P7wQUsz+nKVI0hMtD5TaY6MPw23y/D3QkRfPz/BjrbwkaOK8CjTrPmznTP9lgUYMU=
X-Received: by 2002:a05:6402:1d4f:b0:6b7:f106:3419 with SMTP id
 4fb4d7f45d1cf-6ba37ed40e7mr16523342a12.43.1795654100281; Wed, 25 Nov 2026
 16:48:20 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-14-wusamuel@google.com> <CAEf4BzYLqCCwxSAfuzB-wZiae_tgf0yxAVsFc_wzfRAdeqjDtw@mail.gmail.com>
In-Reply-To: <CAEf4BzYLqCCwxSAfuzB-wZiae_tgf0yxAVsFc_wzfRAdeqjDtw@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:48:08 -0800
X-Gm-Features: Aa3M54pWdHazBU-AqLK5TiYQKtZxCNreXkIezAAKXNEVmmWGCBCO_8U3jzAUf4c
Message-ID: <CAG2Kctp-XoiK-Ej3eHWnYyijydej6Bw5sLKNNi-S+xEGDB+mGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[...]

> > +/*
> > + * Find a symbol by exact name, or by prefix with KALLSYMS_QUERY_NAME_PREFIX,
> > + * in the entries of /proc/kallsyms, except undefined module symbols. vmlinux
> > + * matches come first. A module_filter of "vmlinux" selects the core kernel.
> > + *
> > + * Each call returns one match and sets pos to its position, even on
> > + * -ENAMETOOLONG. Start with pos 0 and use pos + 1 for the next match, until
> > + * -ENOENT. Use pos only with the same query. Matches can be skipped or
> > + * repeated if symbols change between calls.
> > + */
> > +struct kallsyms_query_by_name {
> > +       __u64 size;             /* in - sizeof(struct kallsyms_query_by_name) */
> > +       __u64 query_flags;      /* in - enum kallsyms_query_flags */
> > +       __u64 query_name;       /* in - user ptr to name or prefix */
> > +       __u64 module_filter;    /* in - user ptr to loaded module name, or 0 */
>
> similar to the comment on the previous patch, how does the user
> express that it only wants to search vmlinux image and not consult
> module?
>
> and naming nit: query_module to be consistent with "query_name"?

Passing "vmlinux" selects only the core kernel (noted in the block
comment above, missing inline). Will rename to query_module and note
"vmlinux" inline.

>
> > +       __u64 pos;              /* in/out - start position / match position */
> > +       __u64 sym;              /* in - user ptr to struct kallsyms_query_sym */
> > +       __u64 sym_struct_size;  /* in - sizeof(struct kallsyms_query_sym) */
>
> I'd name it "sym_size" for consistency with "sym" naming, and the
> comment/doc here is unambiguous about what that is (struct size, not
> the symbol's recorded size). seems fine as far as UX goes
>
Ack, will switch to sym_len
>
> other than nits, this API looks great
>
> [...]
>
> > +/* On -ENAMETOOLONG, *ksym is still copied, to return the required sizes. */
> > +static int kallsyms_copy_sym_to_user(u64 usym, u64 usym_size,
> > +                                    struct kallsyms_query_sym *ksym,
> > +                                    const struct kallsyms_sym_match *m)
> > +{
> > +       size_t copy_sz = min_t(size_t, usym_size, sizeof(*ksym));
> > +       bool too_long = false;
> > +       int err;
> > +
> > +       ksym->sym_addr = m->addr;
> > +       ksym->sym_size = m->size;
> > +       err = kallsyms_copy_str_to_user(ksym->sym_name, &ksym->sym_name_len,
> > +                                       m->name);
> > +       if (err == -EFAULT)
> > +               return -EFAULT;
> > +       too_long |= (err == -ENAMETOOLONG);
>
> nit: if (err == -ENAMETOOLONG) too_long = true; is just as short
>
> but also you are eating any other error, maybe write it so that
> original err is preserved as is, not special-casing ENAMETOOLONG? if
> you get EFAULT later, original error still takes precedence

Sounds good- I'll simplify this to preserve the first error via
something like `ret = ret ?: err` without any special handling for
ENAMETOOLONG.

[...]
