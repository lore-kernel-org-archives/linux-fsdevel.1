Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92314353A9E
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783983455; cv=pass; b=mGWoEIAj7g2skR05LdF0CtJwB2qn/ImnumD96ulKEE6EsSkVuMrQbomT/jgS0sYxxMg1oysBK/jHKBiG5/e1EYvtDwZBbDulRvU0oU8O8/QlxX9JYAlcijJ6kNWLKEAvgCdDJ9lfjmdzv7b/a47ySqvo7SUw2k+DEqJnIPwf6Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783983455; c=relaxed/simple;
	bh=9L/5VLdIHmS3I81dp9ygwQ/Sgi7UyEOF3MlxNCvzo8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1XhRVA2OV3qzUbBopzSQiWIzuVKMbnKPxc8GaMWMmtjKqHWtGioRhVL91ZXkHca8vdokzzx6/fpWSF1XZT/OQ3I2p9MfLdmRzAH1snwGxL13FOM0PbRl3dpONEqXZ7RXLmCdEL/3CJXimqmF3NnnaarElbP091MaMOJ7ckrI5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qHN2n0E1; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qHN2n0E1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc61541f8cso4212535ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 15:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783983454; cv=none;
        d=google.com; s=arc-20260327;
        b=oCoUtKdy5pDPJWQe3NOb2Eu7nCUj6QfbrwliHrJvg1EScVSVxjJnSTgK2vfD/pbFkg
         Jv2wsM3T9FScn1Xsy1iVOQKg0QzCnhJB3wDA7OvlE8X1OyQbtGuJD2YnP6N0PGesG/hM
         bpbxPGdPpNwZbNk4AnvLTQG7Wr+dHknV0KBHIHplevJo95A6gg/uXGz/kwVfY5szCbxR
         NVso9puw5q4nLZV8y2i1xYQZJShsDTA8P7ljORhMTdt4jzQKKw74ucW6EJlXP7GpLJU2
         rwDUz/csHdYHHPpHnjQ7vAeWR+A+PF+vVedXIubfqa4EI7ZxATrWFdl8vAdfSFnpGUbu
         IzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UR70c6tm5fxtYd6rMoEXnKV8m3WbtaUkpCXr766W6nQ=;
        fh=1UB/l+nJRyI1kSHFtJ/wE2hANSVEao0irKJsEFgmYC0=;
        b=V6V652ez5fVEtfzxsdQg8VcU6kBPMYt2bFXaze5iYeyNibWvCZ0Yy+bUmutFwnQM5u
         /344NqTnhrqcYAsY4aAXekLViBlz7ck5srZE8u8uXrQX/DUu7e4B2Y8Mr+HbIiMnZszq
         8EODMzFayjaBOLJgMvvm3h0HYavm/bvVUGlKo1WKynURZDVpgBzXj7LJafggRQ65MnEn
         7mFESEtlf/gPvYUXawSm7WC3+zTgRHy2CBEHxL+9mslYJkxR0KRqLU3ITl4kzBxZwjnw
         ApzXC/2yM7PHUQHKXJT54dGOs1g/E726q7QwSS6CTTO199PqvNFbwZAk0LG3s5bB0dAl
         jmEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783983454; x=1784588254; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UR70c6tm5fxtYd6rMoEXnKV8m3WbtaUkpCXr766W6nQ=;
        b=qHN2n0E16Ut1bhbh1A4s6notUOF2OIEjc+TyKK/SHk/f9pXThY2FM9fc8uVTivgViI
         ckmT0fdV0kTdtxSjMTU7QRUBMemUjTp6hkbN2LI5jhb1YFqJAAnllMwUJCS/PJy1maE8
         yCz5GBXRuuH2iQlXkC09QeBLZwWCh7A18X8J2C3Jr8QfV3x4dUMsURJwvXPB8GT+xKLa
         5h5+XbYZQ0DforiGz2bxyx4bBoE9EloZLpXbpbg4md/HUrVj0NCJIeUl9QMVxaL45+tF
         kFKnShCFMVOVy6GvmnSzgKwga8HdUxs9yX8y0a+AQQo7f1VWiBsIlmBJFKm9KuNVYEvz
         w8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783983454; x=1784588254;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UR70c6tm5fxtYd6rMoEXnKV8m3WbtaUkpCXr766W6nQ=;
        b=j9p8Dh0F2S2kFjzwUckaCiZ++u1eNbOjPbrts5tO43VYuIyxsDf1SNKbqQ/3hOchnb
         WhxgTNqGjfgMQOkd+uRK/AEARfa0rZhgajOEtXiN1WPc185aIKT+LsqT+hdatzD6kUMT
         qxzyKYa3vd+bpxaX3f+yyW5Fa4B+m93drVSIYuVmb0iwrE3lLvsrgleuBxT6Z2BEL8rt
         i3CBvi8nla+oPU7dFRMu/O0VR4jH2PwPdftMF+wj8Iy4/FGZi/Uu9nAdktZa+8XFEpA/
         dbSkZC96CnYNq2siuj+7yhudlNu0SAvPXo785b9o5bw2Kf+A6VIkH8wd9o24YhPzJuFu
         EI3w==
X-Forwarded-Encrypted: i=1; AHgh+RqUUJD1S08NQPIiNXnZ02013OHUuIXNDApl242/Tq0w4xSSLym6WfvsIkh7CVjHNBbmbt/dqgtGe92z0hNo@vger.kernel.org
X-Gm-Message-State: AOJu0YzAAAybTDR9FA5bYsHNL0JVO+/FLnrmyT377WaBihGIBSUaurwK
	Dnu1tuQHyg808TSvTaEkvlTRkoRfLRhK9q36VX7+qUbuopPFXgpAwbPgsM4tST1N3bBn8Ej3LNr
	TbNEdyKbr34dvsU+a6Qq4cIfgS2NTPTE1HGhQ2ih8
X-Gm-Gg: AfdE7cm3mhWLgmX+tidqrX4wwnHrYcHNDOXADYenvRMdmoGt+CA+ANkiW68iegd+bMD
	c9fY/usjM/+PYrPG0S3qJrxb1Pcq290S/SGRvOVwT9n156sAIRpyv5Fm+Etx6BN/nQU9alrzWk4
	hkk6WdZBNdOpEv9JacoXB1wRP/DZsfnkxXnEAGdA1CKf71IoXy8aXNwe6LPnBY5n+oQljS3tRY0
	5N3/1rKlzvNc/Y5VgaYA5uBcacL/FOUQIzDhBjbif44c2aenBA4PoaO03bQROSfQFCmTR1Ysw==
X-Received: by 2002:a05:6a21:d88:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3c0f0ae84bbmr16882048637.19.1783983453460; Mon, 13 Jul 2026
 15:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712165610.366474-1-timday@thelustrecollective.com>
 <20260712165610.366474-2-timday@thelustrecollective.com> <alT2yHlfzhTZ9n4T@mit.edu>
 <20260713164417.350710-1-timday@thelustrecollective.com> <CANpmjNMfQT6Z9ke4x49sp6z8+pt_5ZLUoSh0da-99bwos5-8Lw@mail.gmail.com>
In-Reply-To: <CANpmjNMfQT6Z9ke4x49sp6z8+pt_5ZLUoSh0da-99bwos5-8Lw@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 14 Jul 2026 00:56:56 +0200
X-Gm-Features: AVVi8Cfgsq6HzcYx2FQQAOWvnd3IKq2ABcFMG8fBLZ6iq_4VJeP2hxKfQnYU0Sk
Message-ID: <CANpmjNM5CmQc_YG_5=zhdLCr7gGL3QYPcd4R4=m2NzwNY03d3Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] ext2: fix ext2_xattr_delete_inode() context
 analysis warning
To: Timothy Day <timday@thelustrecollective.com>
Cc: Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jul 2026 at 00:27, Marco Elver <elver@google.com> wrote:
>
> On Mon, 13 Jul 2026 at 18:44, Timothy Day
> <timday@thelustrecollective.com> wrote:
> >
> > On Mon, 13 Jul 2026 10:32:56 -0400, Theodore Tso wrote:
> > > On Sun, Jul 12, 2026 at 12:56:02PM -0500, Timothy Day wrote:
> > > > Clang reports the following warning when context analysis is enabled:
> > > >
> > > > fs/ext2/xattr.c:829:6: error: rw_semaphore 'EXT2_I().xattr_sem' is not \
> > > >   held on every path through here [-Werror,-Wthread-safety-analysis]
> > > >   829 |         if (WARN_ON_ONCE(!down_write_trylock(&EXT2_I(inode)->xattr_sem)))
> > > >       |             ^
> > > >
> > > > When WARN_ON_ONCE() wraps down_write_trylock(), it adds an unlikely()
> > > > annotation which hides the conditional acquire annotation from Clang's
> > > > context analysis. This triggers a false positive. Pull the trylock out
> > > > of the macro to silence this warning.
> > >
> > > Does this mean that using Clang's context analysis means that we can't
> > > use unlikely()?  That seems.... unfortunate.  Is there any other way
> > > we can fix the false positive?
> >
> > We can't wrap a function that acquires a context inside unlikely(). We
> > can use unlikely everywhere else. AFAICS, I think the trylock functions
> > are only problem right now. Grepping for ".*WARN.*trylock.*" and
> > ".*unlikely.*trylock.*" shows a few other examples of code like this.
> > Not a huge amount, but not zero. I looked at a few other
> > series [1][2][3][4], but I haven't seen anyone do a similar conversion.
> >
> > [1] (block) https://lore.kernel.org/all/91cb8c790fc8b26b8aa742569fbf8c2c1d099dac.1780682325.git.bvanassche@acm.org/
> > [2] (drdb) https://lore.kernel.org/all/77d0fd75811d7f604fa80b5c93172b5653b52880.1781042470.git.bvanassche@acm.org/
> > [3] (raid) https://lore.kernel.org/all/20260708090614.1431014-2-hch@lst.de/
> > [4] (nvme) https://lore.kernel.org/all/20260713115444.465704-19-nilay@linux.ibm.com/
> >
> > > Even disabling unlikely() if and only
> > > if Clang context analysis is enabled might be a better choice, since
> > > we don't necessarily need to build with context analysis enabled when
> > > building a production kernel.
> >
> > I don't think we'd want to disable unlikely() globally when context
> > analysis is enabled. Only for cases where it'd conflict with the
> > context analysis annotation. Long term, I think we'd want context
> > analysis enabled by default for Clang builds.
> >
> > I think we have a couple options:
> >
> > a) Current fix - it's okay, but a bit ugly
> > b) Teach LLVM/Clang to handle this better - no idea how practical this is
>
> I'm not quite sure what's going on here yet, but
> __builtin_expect-wrapped trylock function calls are supported by
> Context Analysis (Clang's Thread Safety Analysis). Some of the
> additional layers that WARN_ON_ONCE adds is likely throwing it off.
> I'll take a look, but might be a week or so. We are already bumping
> min Clang version for Context Analysis to Clang 23, so I'm hoping this
> can be fixed in Clang 23 (which is not yet released).

Relatively certain statement expressions were once again the problem -
this should fix it: https://github.com/llvm/llvm-project/pull/209330

I haven't had time to test the Clang fix on  fs/ext2/xattr.c with
context analysis enabled  (please do so if you already build Clang
yourself, otherwise I might get to it in ~week).
