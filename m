Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837167;
	b=oWpvqVSoAtioSLteaSKFERAtugA+XMP1Kjm45eUSgWsuzn6G14ltQZ9g61mr3/8Uct35
	 kmmTlK9dEQthJoak8KSqQDlYnD1XHex7HiSPemhJ+8ihHSIsiOSidtkc5ub56krfxPICM
	 XWEgpUXy6CNzh0hs7NV4y2vzAj5qJ/NaqftZ7izI5TA9pCzY2pCzYwSxkZ3x6KrWSY+/g
	 F4kxXibVUTDBpvtSyUC7E5KSsXVlYpLf/x3mTFKrXBGpRU/9nXuhkot2LvBKJfN+8V3ok
	 pkNht5eh/Nvr1egK5ElnviU9CHJPs+5nOKkpbak4L1wGzywpgA4HuIJiJH+zN/qKZYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rBao9fgm6zvnqMZ/xw9mMi296PqW8mAwycCLa5M4/yo=;
	b=pYlfkpqwhnj2sYpyxGIQC1BgEyd0xWOiU0NzEf3hBZX4Xu+xlnEnedci2feV4YDSR4LI
	 /+0TRlNAcCCaLzwBayrFuZdP4ziCbC72Mi1qMIcApIo04gJXynFPl0EtqPRuunsqESC2A
	 ZvPb0xCQvTflTCJfleyi56yu2wFStWrec7PSz0ST/Vmli1LahS4NgNunVLlpjzSrtqpWA
	 q9j5jAdPqf9mNZy4UU6lq6QJ9KKeypZ4rjOaKtGDbujKMx+UG4BYLlVKCukA706lNtJDo
	 HvLoAYnmEJTK6ykoBr9ErpaOhVV+DBh5T63dmenA0D86jUy2XadsWXv71eoFY+PNwfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UW7+Lg7r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8117606A329
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 00:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8117606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UW7+Lg7r
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4682977f9aso166302666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 16:06:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793837165; cv=none;
        d=google.com; s=arc-20260327;
        b=O3PaeS8yaRY3lOdan5slNnapdZl+Ec1lfJmf61sh5ixsVW4tCOXhOW/7UbYMNB7UmL
         8vhoX3XvKykSm8D20ntANk395va5c8JUCQ/AH3pA4xVvtt0PjY9NrLd5ldWtkcYP7FOJ
         sjR5PgHM68NDtqPo0lbZEhuPurg6h0hM2Gm0+W6a4gfiHGfRBnNdcEgG1f24qsIvG+7V
         01I7QFW2YGlTxxb/e4SjvGTYQtIzdY5nKEoscz6qEGj2RpJ8H0pkhOoobnoFgBTN+gFj
         YDk7bcvacPG58PEAGHzvpSDMmr70+l5NJrZNW5RAseOQzqhDZe+uNBYmhb3b1zjFKh2B
         qRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rBao9fgm6zvnqMZ/xw9mMi296PqW8mAwycCLa5M4/yo=;
        fh=R893NVa/5BPcK+kxFJIpOHffn5u1oT1EOLvKmRYvkr0=;
        b=L2mdLvjuISlMiEiXpUqROrmfm2An8kIDsXt/U6BgqQ2qKQZxt/WLv+s96VIpC7unWF
         fdnymoJuRrS3HeIAt5M4BMlEr064Lk+lj95mP7cly2xqsn3ZrjF8DQbJJJaylNkyqbz5
         S7/Ib4/JkdqXKwkhHmR/296FMHl49trHJoHmGoDJkYIXk2UFjavT6E3CXUiWSe1LEj9F
         MpcWmLWt2a930yxEZVc9/LWZvmmKsqb8rv+n4KgPmGlggU3vvX4X/OUPW3iJjIeFzR9U
         Xafp3XRB9x8fcCYqtJJnDqAkeMqZz3ZQR8YO6rEpNadDS6/ibWCpPgnAEfrhqAEla9br
         W8zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793837165; x=1794441965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rBao9fgm6zvnqMZ/xw9mMi296PqW8mAwycCLa5M4/yo=;
        b=UW7+Lg7rFdK2cPOSHdibyhfqd0mNfE52oRphbaahRpCOHjIZJidko9tTbllyzCryjy
         siNubT2yNT8UsddMzx39cRlaaf4u9pnE+6dIm/dTOyiVwyDFMyx/T503O/SAkgV4IgXs
         efUG5InyQPdPjXkVj3FyrgQw8Tp3Uwud4aaLkD2TGlBzm2pE66Yo0XieOJu07M7lI+DV
         gUkNX9hygDXotIY7g19Ob5YY4jcsnCTMlsFTY/Azp5LW+ukD9CKA5AAnTO8zpTJXxWqx
         5Vgp8TB7FfNb2pRMsONUAcd0wfnBxqAeiMrEDvVnn/35z4BZWsrn2RkRHETiQqHGP/C3
         KXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837165; x=1794441965;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBao9fgm6zvnqMZ/xw9mMi296PqW8mAwycCLa5M4/yo=;
        b=oJB2fJC9xuSutg1eDij09WtSMcV01ReNsZwV/QtApzhvCP2adrD8tzkVBQWd5VMR8H
         cYqeR8VdyPv4r4eS70E1danLQ98XMaIzOGQIyg7vvPJ2HxRwUGgrTBpKpiCBrsdIltZT
         QNL4p2ZJfxOj//I/gOQpTVwYHKWpEgHZNnYtEE1+K2SwH+RjhJpiS/FD75eF0gR7EQ4X
         3rbfPmn+QhdmkDJW4jQ9u198VrNszdcA/qjsRU+f9Pksrdp84kq1Tf/D1Lr0O0d+FZP9
         87Ewkl2a4BKpFzK/VAd9gL7tau2NdNWXCtLRgo4EyZVSzZ+tbNGwZzgH1t0NpXmC0zlU
         51Iw==
X-Forwarded-Encrypted: i=1; AKwUvBxKZJZtFXarj56gHEkhgrD35ojiQXfXRhy/wD3fWLVOwSA8ZB7BSgaik/StVdS+1+7KhE4uCnG2KNnUWPhM@vger.kernel.org
X-Gm-Message-State: APuU4Z9TsSBJd15VwT+Xl+4dYqfJKBE0sT9DTrfcbZuWuhR+4brb9/bC
	pCowLOW4o5VrIvDv9azD2LiUFiIErINbO+z+dWf2sI2CIjHwdb+MvHeJaNQJFrbi1+RN5weNMpp
	eYitP8Wjof5/gyDENQc5YE+Z4Q8n9dcGJDK1HN63k
X-Gm-Gg: AYBFou1Jxe/nal1Uw4XNIPXqwL3rzTr7BZKO7/wIK9FJoh9x9B9QQPpQr4tW68sUxKQ
	O90oiH3tIFWTzp01e/U2TQ5advCZXUcAYNpkDTUp7pYyE0+qrZxPC4AR6XIFmfyxRkdrrpQ+lVL
	BIfFzh0xieMJYQ7qdhOnINxCg/yBHpbpEtXuiORz2CyJ6FfJUP8/UqhV1GQsg30hm+RqWprew0D
	39vC1YhMqTECq6ESvtoXeUD3+31Qr3m97EMWKKX4jUGD6S4KhjoamFti2BlATrV9QNDkNeLRrI3
	THCSxZXnjv39KG8fA0GcUqRFn6Hbzjr3d+W6rd8pXLGfWxoNgVrb31P30g9JcOmW+4PgbWjrV/T
	F4iwDoXbpWyb1ht+kkF37/wvvnnf2bUPp2EC1WfjgDf4sutaEb6InnEL315vkQW412W4TGzc=
X-Received: by 2002:a17:907:3351:b0:c4c:b560:2a71 with SMTP id
 a640c23a62f3a-c4cb5603d9emr979541566b.36.1793837164883; Wed, 04 Nov 2026
 16:06:04 -0800 (PST)
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
 <20261104142307.431fc12f@pumpkin>
In-Reply-To: <20261104142307.431fc12f@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 4 Nov 2026 16:05:52 -0800
X-Gm-Features: AclHuK8Z7yNuvzdyvQXTyXXmXbvszi-XVmOSWc_IPj379xX-z3zgWWYR8Kt4UgU
Message-ID: <CAG2KctrY6GmVqsKP+fXYCsL6wDR4zp1kdRd7a7uOdCgg_JcMdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 6:23=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 3 Nov 2026 17:14:26 -0800
> Samuel Wu <wusamuel@google.com> wrote:
>
> > On Fri, Oct 30, 2026 at 3:02=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Thu, 29 Oct 2026 15:05:45 -0700
> > > Samuel Wu <wusamuel@google.com> wrote:
> > [...]
> > > > BY_NAME matches names exactly, like kallsyms_lookup_name(), so they
> > > > would be different symbols at different addresses. Please correct m=
e
> > > > if I'm missing something here!
> > >
> > > Only that the user might really want one of the copies.
> > > Sometimes there is only the copy.
> >
> > Good point. I'll have v3 add KALLSYMS_F_PREFIX + pos/next_pos
> > pagination to cover these. A prefix query for "foo." also finds the
> > copies when plain foo does not exist (expanded on this in my reply to
> > Andrii's Oct 30 mail in this thread).
>
> I'm busy rebasing my patches - they got stamped all over :-(
> I should get a v3 that applies by the end of the week.
>
> I will add a 'prefix' variant for you.
> The 'next symbol matches' flag is exactly that (actually it is a
> this symbol is a duplicate to avoid issues at the start of the array).
> So in this case that application would always need to read
> the next symbol (by name).

Thanks, that would be helpful. For my v3, I'll keep the lower_bound()
approach so the two series stay independent, but I can switch over
once your series lands, so there is only one search over the name
table.

> I think it might be more sensible (less pitfalls later on) to return
> the symbol number - not that of the next one.

What pitfalls were you anticipating? If the current symbol's position
is returned, userspace needs another ioctl() call and an -ENOENT
check, to learn that there are no more matches. Alternatively,
returning the next position means every call pays for a look-ahead,
which for an unfiltered query walks the module symbols even when
userspace only wants the first match.

Andrii, do you have a preference between the two?
