Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1582F6596
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591344; cv=pass; b=AHWyLPeeH4Zl7M8q9+coOZpODE4HG9qM3rUpgJ//6kOQraRvZ5x+cqBlPXsCR4xvPkVm9LE3l9FiYs1vdugnQVGz1xJSxA+yyTLvLE8MqahW2xZYADzTzXpTKcxFMSsbOB3gCf0/aJ/r/kFPNbPZtbXPPpySupbBWqR1xcl/IGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591344; c=relaxed/simple;
	bh=mo49/bwIycAKmpSP+V6WX3/6DK2iyEaRqfrdokj7b6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRDg80LPa9zT94lebrkcNo2LHNqtxherePhztfGCslKIKIyAVPst1EEsnFwIo0MDcGijg5G1mreipu34fjWzIGzt8MbqOyY9g/QPRB7+sjr3hs4qi75RzGqgxjodMgVYGd/NyHS70RovQ0mSRNrbPbT3DeCtuXtfQdSRQHw1FvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEv120hL; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEv120hL"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd36614d329so7216466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 06:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778591341; cv=none;
        d=google.com; s=arc-20240605;
        b=d2wBLJRLj9xGn//n1mcAMCYJso0t0yb+nOLYNq8jR/0lgaHnzUsR1UAbadZppHRMLQ
         IK+zl0MdlMT14rv+HpWQm+9dNfQUmm3WaeSAJvS0dtjAuakFy2DZBwGA6NMksEmnZzLm
         P1WJDhUvzHvyqb/hEmtSI5JfCq6Vw2kjaGB+w/iH9ilHIdQqW9+iJhEe9NTlXosKWvEL
         agka/XlwbPgNChummTBHzxkbU9xmnSg2gyc2UWxl/Mf04CxsDo06krFdcGBBLuuaD8NX
         9+9dSiVHzVugu+DbLlJXgjP/p1/qGJMnbC4Jvq00OrZhTTBGDg39DborrorBjWWwJB4E
         AJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2qBWjjaW/pbuvKmNqOdQeu4n6soD8yZr6RME3HLH1bE=;
        fh=HT3NOtAQXRZTNRkiu8dXIIrk5NfikPGNUKJTF6hZxp8=;
        b=H/F5DZW1xF/HUUehJnhEs5OGoldsRv58ESPIA9NAOdhTWqIz1+s22rsGPYvkzB+YUs
         29D3blE4Ouj89Bazo3J71zfnKvBeYqR65IKVMGpRKbBMiMCDieXr1MmKV4xqBMXG++xh
         4YvzFjdJSTMb9xwo7IDWIiPpQEDqj6ZeHn5/TU4ThmqXOBot6I9RPqaw24aDbMgFh9XQ
         fWkVb7E0p+mCLuHZnkV62004sO8h9eO135K37MBA+qolpGtjbVm5YD15JX0Z3sfhRDgj
         W5BQnIUzhWbnpF3m/iJl6/vAiAGlU4hAVOkNjO2uRjAF0kJixgC9dYj3CskT1cmjkZUU
         vxLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591341; x=1779196141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qBWjjaW/pbuvKmNqOdQeu4n6soD8yZr6RME3HLH1bE=;
        b=cEv120hLxoQGNm6YZeTgnlWKRXpn205RgOYDDJW6GmiKDRd6N3FKONiU/VV9Ol3ytI
         O6RxOe7qvzEkpqh2nRUNUJqm8sfBYG+1vI1MkuY98i2csVp5QD2Yt5qaPB68kA3/7IzO
         FLa+GYM4RBOJi5fvAs2sZSwWc0liQk7Ed51/wPwm97jdrcOfZycgxvRyWx1hA2wuVZBF
         BuPS9IlvK4Akh9YbvJowTl1WyaDY3PRCSu9kr887sfM3gHau017Zg2tNwRVSpQE7u0Kd
         Sy/j4u7jcTAqWgooZ2mB/sAr7FSXn5j7ZuE3h7DNh2P8DYJWVxiQ+X+z1GA65crvoX35
         Wrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591341; x=1779196141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qBWjjaW/pbuvKmNqOdQeu4n6soD8yZr6RME3HLH1bE=;
        b=Dqasxv/mdc/0we0JhVGhuT6OWb40VfmQZPUmtdmJwrKZ7r+eqB9fABAl4WtdfygJyW
         e8YHcieQTyqcPw522ijVGc/Bdh8TZ20ZnvA9ZNvYOkrumAplNg4ZQw6RPjf0EmAIk0WQ
         jRmNjliX4sh3QlNyfDm8BHgVhuhainOJkR81Z6lMzD8vaPR6SrpxT+yiB0NQ0n3PQfu5
         6rRkdX1dHnKvUQyg3VMK/E2yks0VY+pbfEdPuGVMgCxAozCa92GLX0+FW4UZ926T3k7p
         XxgiplffFhq8Eg5nOaIc64e87ohlpug4PpBLXbUBABmldYUslV0FKVTBg4nDd891qmLf
         hbmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8x4V14EEITijjmbi8c3D8tJGFCH7wJNMv5XZdN+UbDJ9dBvDtk/kX17twVGTMaiDnEtTYFeQMFarrVcSEF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19sGkAf2uPT4emjrjbNvgatDzTFVuQn8LWWMY1Ed0Y/1mlQbg
	jfrEaTfzQ7Jp3TNqQUBftd4tkxlVvGEsOjUxxvYJpSBephwCnuzyyOKgaCRj1T/SeMvfsetXuMJ
	WVU8baOZPXX+eCvT2CO41Fg75BghHe9c=
X-Gm-Gg: Acq92OEdx9de/rwN9YxZSPUYMFqko2DU4NDs5H7IQ7codLf/7RNjt7wK+JgshiIVDaf
	oKvqzn4xgdFuUDyohH6YFFC+BPCnlpxUDWimVfndCtjZ13gW/Jg7tL1l0tz3Q8Q/4HEnB0o6e1L
	eZNGYpjuiKhodMDba+7W+adAjH3IMtRwjhSw//5jbVJdmE0ghJmRhyhzLElOU/Wt/dlOR9Wc1k7
	p/Wuig+kks/MAr1OmFl1zWXNmVvZIRAghGkz/EEZ5obtwkIlLKx5gsZ+8nXXEFWNY+enepf6fDB
	2oulgLFpC1qbWC+2734EvQAeuYAAI5c/f5fJOhYK
X-Received: by 2002:a17:907:9806:b0:bc3:783f:1da9 with SMTP id
 a640c23a62f3a-bd28f692fdbmr186838366b.33.1778591340776; Tue, 12 May 2026
 06:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <afxK2HSiwY32KaWw@fedora>
 <CAOQ4uxg-tgCmJkjFAQ86_xB7dDQKGy=geKAcxT2vB8cUSEKdPQ@mail.gmail.com> <CAJfpegt7hj=WDKKASjWLVG-R2tGYUKMJ1qR0iv_Y+GaYS0mW4w@mail.gmail.com>
In-Reply-To: <CAJfpegt7hj=WDKKASjWLVG-R2tGYUKMJ1qR0iv_Y+GaYS0mW4w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 May 2026 15:08:47 +0200
X-Gm-Features: AVHnY4JhU96zGLWsyuK7ihmNJ28PAQ9LCLpUgSWFv5s7IHoqjEj5a1B2ZwVtsLM
Message-ID: <CAOQ4uxgoavKU6zNMN9YF5cchvux6CGGxd56BBOJFWX0gkVAChg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <horst@birthelmer.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:18=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> > I see no reason for fusex to not support lookup by ".", which is
> > anyway needed for "reconnect", so a fresh FUSEX_NFS_EXPORT opt-in
> > for "re-export to NFS" may make more sense.
>
> Why add reconnect?  If server supports persistent file handles, and
> all req's get the file handle, then no state (nodeid) needs to be
> stored by the server.
>

Yes, we are saying the same thing.
What I am saying is that legacy fuse has FUSE_EXPORT_SUPPORT
which means server supports lookup of "." which libfuse always enabled
and then we added FUSE_NO_EXPORT_SUPPORT to opt-out of nfs export.

I am saying that in FUSEX, lookup "." support is implied.
And that nfs export should always be opt-in (FUSEX_NFS_EXPORT).

Thanks,
Amir.
