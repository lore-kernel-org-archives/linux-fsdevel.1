Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FDD3F54C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480892; cv=pass; b=rn9CD09R9UXT+UntiPHa3ptNrlye5GrkzsYFx3QJT2TgWc9GNlTbv5zShIMdnVmiPEzIWOHCeuSa5x3+yjSQYyr72BjgGpx6dbPIg5BIyir5XON+rrdJhZ0rPIVP18qYegDZD7Wna7XayfDFvJbFQSmKKE1TgCNDR1ki5vECorw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480892; c=relaxed/simple;
	bh=xaBlLFNTZl0kG4DGG0ss7wNRi4uRD8j3TezB5k4Epq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLp8/7KYAN6LGzE4b+Qx6qIH+2GVUvIio335BAGruK1SW3Bs0F9X0cEaUVsq+0PMG2ByZXaBaJJNpyTAbnuYDOGBFv/UP4r+Kj2JlP7C+fmdoPvaLxLKRxx1R+wBhx3/H6Vs0th/9GHUxk7ab/ik9oyZYyeLeWKiU9eKJmF86sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmuEXy8E; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmuEXy8E"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69565156c06so11888a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 06:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782480889; cv=none;
        d=google.com; s=arc-20260327;
        b=TkRG93bdpgh8kCs8L4c3tS1y6QWhC5QS49ciA3krgrcKvtlx0JlQwVyVxggnk0+tsd
         ws80qUhVWYPLWT4yomi0d6Rdu8X66nPHaDaHMivHY3Wc5PXm+e+NALkSqzGlQSQtJF54
         sV0V14OvazF+kgO3r8ex/0rg1sb6uGsJtuSGCX4QHzlUwZf66zHFa3gorwTFGNU7SRF6
         tjrc6y/kmY+sz9Mv5dDyxAht0cHT4/NYj9xXj1UlLFeXwa495HFLR4oEUg81PWDAEy/c
         5X3/Av4P/ISouvqEaen4sC1zUP2AzbMPa0pnLqjxZYSPLL9WxRis9uUAqVjft95cfmZy
         zrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OFusc4+4RUwOAF9njJqeKXVcmCxYVbDE1Q1t4UJqUMM=;
        fh=kU0yfhaQ7dhy5DIhLuaC3xJx7Nrg+078c5qglNtwtUQ=;
        b=S5s++8wSiXM8WuKbx1K2aLauzb+EzqVTLHss/6nW8WNmKhX01zQBWF4qIrE7ox60HG
         OwvubHbwURelYL7UyPDGLx5VSMnAlMGEZzvdl4y8ILhbJi9itO9KXLGaiZamXNP57cxg
         q65PaLnrPiQeiqyDfrfBo701XSYTlboxdc/Jl8W4Poz5ggVa+zZIVaWXHVkB4IdJj3IA
         p7H8ASlAPrf1vi3jP1gRiHwYltG3yQfr9FTKqoqbtlFr403Rpqu42+Z12jtYEV1LZcfE
         6RS8/dweeOQMlrtRKrPbAIqVKP9fEifXiGltooywSfY8PIfVHMJuwkb8rhtXvDfgSdTu
         5ZlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782480889; x=1783085689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OFusc4+4RUwOAF9njJqeKXVcmCxYVbDE1Q1t4UJqUMM=;
        b=TmuEXy8Eb+db6mjphTsb7e790vmENZW6HFlV9ROV0ZwDHfYHG/kYOoUJ/JA1b99BAR
         lkhgHQE5lVBKWcRu/rZ78C/3AxFIp1+Ut+NrOa01pDclYWIdDyZFzO4t2GXkReiT/b12
         RLBkhkCx+oRgti/XJfr6vpiu8EiROu/1maRCvhOYBr07p8dnX/1t09etuemiWhhehR8p
         8KKo60hqhjcq1qmkmCfBNMpJ6hqC1n9zV6pXRXQceSXMlN7jVjV9gvh1RijYjsq39fyD
         GdehePE8aqOljG77ufH3X1Aci6/xqsJ2Eq0R0NsK/53fR3PV+0XtrAvP6lrsOSJ8Zv08
         nvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782480889; x=1783085689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFusc4+4RUwOAF9njJqeKXVcmCxYVbDE1Q1t4UJqUMM=;
        b=AyAqeSnNA31FCQ6ia0k46kJJYPtSXz41E+ehxxwKDxZJXMgB/chZH1fAiwnjnC0sv0
         sPzz81iOye7UUmCp3l5qEC1h6Ju0V9+MNVtfETb0sIMm/HBnzjhuWrBVg94FKoRJLh4P
         /PbucwgjfCnatoAgIMXhGmHqVEvllBBBE9eaiEOHclZDh74Clm2IKV5J1UHBsxUUqH5i
         PGSy0kTyoQppEg5FBH75FK+6yXXIW5aUolTg+yNePfzeNqpOpg3wAtWr2MGt4sn6A9RU
         I0ZYwZ/zoCPTLtV0TCOXD4frCoHTI4Zxwy8DvGdMzdq792tvOaXjoKvhvCVf1xQRRrBe
         zjyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqn2HCQ6NJmIF5vXjz6Pi37Is4i6xJctseU1vYyZP030Rg71Nj2W8HTUd+M56KatqpGXTJcKUH+sTMFpyY2@vger.kernel.org
X-Gm-Message-State: AOJu0YyDX1G4gDkq3Is47cFsF/62NhkzJ7zn6mCKgnyQoVZRkTAT/YvQ
	cxsAe4EzF+OBr7cHYeyYAduSkLOiBzSsd6obyYYwdj9How5DGtCH+Br2it1wKLPsP8LVhXGHt2f
	P89loZwbAOP2Vyl79adyfcyJW2o6SvBA6zVvOaczS
X-Gm-Gg: AfdE7cld4D5owcuwuBHA1iIgwh3DEgE2vxStvIDaNlQ1G2nlJWEV11BKBMeYp0ly2II
	XtmsJ2Aq7mq+jueHbvDw2eZ1rmUtxU2Of2ewwlIMjBm2jNH50T6N/3xXMUBPYfs8+TDi617h2Je
	UIFGXU46QzVx0i8WlBchC6TZU0JXb8vUa+eusGbCKM0tMjcdVRwes7X8zr2c4qgEcYEOoAZFZDA
	HlGJP0HY+Z8T0Vgf9jF4g/r0CnJ17/0W9AE3trkMs5S0r2GtQkAUaJk2bePEDRTDqk57E5bSvmI
	UUmKLYVTbvmjwPCJ74u7Utb/2sfkmL9EhGt7LQbOzWbmWBWT2wIMioYdT3Q=
X-Received: by 2002:a05:6402:305b:10b0:68f:d41d:ca5d with SMTP id
 4fb4d7f45d1cf-69838079835mr4734a12.11.1782480889012; Fri, 26 Jun 2026
 06:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
 <sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
 <CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
 <24420045-a6eb-4999-ab19-1e344eaba8a4@app.fastmail.com> <20260625-atomkraftgegner-hunger-kursbuch-b452ff2becab@brauner>
 <CAG48ez2X1p5Nm2_sU=SK9wUusUO8c3_T-=FGrrOhkm7Kn9Y_7g@mail.gmail.com> <20260626142616.5232c61e@pumpkin>
In-Reply-To: <20260626142616.5232c61e@pumpkin>
From: Jann Horn <jannh@google.com>
Date: Fri, 26 Jun 2026 15:34:12 +0200
X-Gm-Features: AVVi8Ccjij95miiFuC4obt1ADtwSEC1vQNqAn1Ep-7UuHNcBNEBqHY3MBA-NbNA
Message-ID: <CAG48ez3o1Mt59dWdyknh_SEaoi-cHv6pdmix+aOdBy3C0-LkYQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
To: David Laight <david.laight.linux@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, John Ericson <mail@johnericson.me>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, shuah@kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	linux-kselftest <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 3:26=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
> On Fri, 26 Jun 2026 14:39:22 +0200
> Jann Horn <jannh@google.com> wrote:
>
> > On Thu, Jun 25, 2026 at 10:50=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > The arguments I have heard from various people so far are:
> > >
> > > (1) Userspace would be able to clone a random chroot to /woot and run=
 a
> > >     binary from it without having to set up a complicated sandbox
> > >     effectively making dynamically linked binaries more like static
> > >     binaries in a sense.
> > >
> > > (2) Quote:
> > >     "If you debootstrap/dnf a chroot to some location in your
> > >     home dir and try to run a binary from it, that it tries to load t=
he
> > >     libraries from your /usr is a pretty unintuitive and not at all
> > >     useful behavior."
> > >
> > > (3) Quote:
> > >     "[Various remote execution things run in locked down containers t=
hat
> > >     disable userns, which makes the sandbox impossible and hence our
> > >     builds wouldn't work there."
> >
> > FWIW I think someone also mentioned to me that it would make things
> > easier for them if they could build a piece of software in one
> > environment and then bundle it up with all required libraries and such
> > and run it in a very different environment, without
> > container/sandboxing stuff and without static linking. But I guess
> > that's kinda niche.
>
> The problem with 'ship the shared libraries with the application' is
> that you get all the problems of static linking.
> If there is a bug in the library code you can't fix it without getting th=
e
> 3rd party to rebuild their application package.

Yes, it's appropriate for weird use cases like "I want to run this
historical version of the software and its dependencies", it's not
necessarily a good idea for normal application use.
