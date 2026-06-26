Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED483E2AD1
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491317; cv=none; b=ipdr63QGMc6zmTqeAaTdy7vUjUVZ88H/R40NavvmAZXfOOpiVDT+uF6xUEBYP0NE0fQJco9BdgjLhNsR/1boyPj7bYK7i4aCjfn4pIiMZq3nk6EHvJrSLjTG+XWYX+7ug0K7TTU/dpri9pAdtBkDdrysNs7N00VHTE3HveqQRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491317; c=relaxed/simple;
	bh=KS9JDiMhOnF4fRXZe5BIB4cOnctYse4A9043O0yGgoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EU+C4NBe1FBkl9cfENoSSyK66E0+PTRxCEV1GnDQvEYOya/CKvRvvU1iUZGuCPtwJyPVXUTz+4ET5gR2Sw+g8FUPlQae80jksl+ghdmdEv+ZNqwoabHPjP9aZgmLdfWgj6vofr2P0h3GnQUji6WmAoJ5Lee+OxR7jpnWXFyBA60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip3Nd0kf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip3Nd0kf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49241a577d8so9128125e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782491315; x=1783096115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yRRCllVxAYk/OchgnjQ6W/17oLwF8I+OCpCxDAKNow=;
        b=ip3Nd0kfsDq88G0BrlUATAD3LgdXdfcLXNH1lnnEGb2ROx4WmGKwSPowstFc3MGqNS
         M64Tblsr1zllJ+ZF7rCimeybRazS9WNlo35q+15klX76gXnVwX4sRYDRU5uVRTKXrpyV
         uadbijvckMan9BbGlG/uUV5/+pegASl2FsVvAQbDHXOR1OTPKKfFhPXSOP0/xbxyoDNp
         QDw9bUAI5yjOcXKEIX85Xkev3ED21tVbNJETxKSqN3X84yWwTvyZu9Q41pdt3N8kS0bG
         WAY1GHgzceboJNdlq3HcGw7/fA1csz8ab1WDQMg8RfP5aJUuEBNzBzijVJciXq9HfG/G
         qGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782491315; x=1783096115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7yRRCllVxAYk/OchgnjQ6W/17oLwF8I+OCpCxDAKNow=;
        b=OSU3b+qGNYAMTg/Po4Fb4Htz07XPv/SB62X+1upML0URnrX243Nsfy3wHUWwj89yw6
         UXyyZWuKEhUBDaM1hMVwDEVzaOTfhgSGf0i6/CUkAX9smOdDTBBCKN9NgFxbaMibpm1P
         piBBs5mtUtdgJ+GGdgBfnuUk+5a3BWtLt3ALW7DXciLJ/0zfC69bKQktNnYeQHElIRQV
         7yayvcESncqZumEl/A+VrTqGKnWpQUBBBqrGBHlq3qLaxCXQj78GbK2f7Gs3D3sPj1jH
         9tZ3ZcOL4Lk/Ttmooj8EqPKNR75Xk9kZzXvV214NhSG4AQX3Meo+ulEhglr3upc/Jz3C
         tsMg==
X-Forwarded-Encrypted: i=1; AFNElJ+SqVR6sizR8dKubXos/A//He+CSXAqkOIqV7c5jnlDlPJAps6ey7REfrw3cVtz9BXu1SV9xZGar5JA2tlI@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQTls4UJ6tJGQsYQPgU5OhaO6rFhsGdlmmy1Fo1MBBFNo0LpB
	0s2F7KaI7T4e6w1eegU+Xk/H/fOMTds3iXsbZcZCkasyPA9QYTCbw1cc
X-Gm-Gg: AfdE7clKEEFTFfGfsp9X1XqB3rjTS89rnwcwizokwi1nywgfr4K5ayrqwDGk12ylVUD
	mMTUaZtv7loNfbvh0Xyez34P/+loNWfn511OWNGATYzTEz9MO+1knsf092FCiuQBEd/27yRD9Xa
	7GAZZgxDM0ZBhpaooPwrs/xGz4gmbCVNmgsLJa1Jx0J+XNcdDKVJOTRjIIDaGAq1GA/ZTGTQG/v
	kgI5/FLjda1U24IIILTA9V7CRubxPvB6FlFOir5SB2cXN34Q7LN+E7QjXbSm8CVY2Mvrqq33VEI
	Gs/zWS1kupzalJXEgpS2SK9VgXvAcibpMKp26cPMshq0RseeP3NonZ5B7ss5R2Jncl72bA9HKK+
	zUW6AnFjgXao1+L5wmU3I8LOgwKIOcg0Bj/bBAO7IVEfyCFcDaYsf8Z2qfEd9mUacVvkm6Oz7hn
	ydkoWij5UtTytAN8RSkbEdfvUQIx7aI+WDehRpABSrCfsr1OSYow==
X-Received: by 2002:a05:600c:8518:b0:492:62d8:2da8 with SMTP id 5b1f17b1804b1-49266884adfmr116414295e9.29.1782491314555;
        Fri, 26 Jun 2026 09:28:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49271465f35sm952455e9.9.2026.06.26.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:28:34 -0700 (PDT)
Date: Fri, 26 Jun 2026 17:28:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, John Ericson
 <mail@johnericson.me>, Farid Zakaria <farid.m.zakaria@gmail.com>, Jan Kara
 <jack@suse.cz>, Kees Cook <kees@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, shuah@kernel.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 linux-kselftest <linux-kselftest@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
Message-ID: <20260626172832.366deaac@pumpkin>
In-Reply-To: <CAG48ez3o1Mt59dWdyknh_SEaoi-cHv6pdmix+aOdBy3C0-LkYQ@mail.gmail.com>
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
	<sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
	<CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
	<24420045-a6eb-4999-ab19-1e344eaba8a4@app.fastmail.com>
	<20260625-atomkraftgegner-hunger-kursbuch-b452ff2becab@brauner>
	<CAG48ez2X1p5Nm2_sU=SK9wUusUO8c3_T-=FGrrOhkm7Kn9Y_7g@mail.gmail.com>
	<20260626142616.5232c61e@pumpkin>
	<CAG48ez3o1Mt59dWdyknh_SEaoi-cHv6pdmix+aOdBy3C0-LkYQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2026 15:34:12 +0200
Jann Horn <jannh@google.com> wrote:

> On Fri, Jun 26, 2026 at 3:26=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> > On Fri, 26 Jun 2026 14:39:22 +0200
> > Jann Horn <jannh@google.com> wrote:
> > =20
> > > On Thu, Jun 25, 2026 at 10:50=E2=80=AFAM Christian Brauner <brauner@k=
ernel.org> wrote: =20
> > > > The arguments I have heard from various people so far are:
> > > >
> > > > (1) Userspace would be able to clone a random chroot to /woot and r=
un a
> > > >     binary from it without having to set up a complicated sandbox
> > > >     effectively making dynamically linked binaries more like static
> > > >     binaries in a sense.
> > > >
> > > > (2) Quote:
> > > >     "If you debootstrap/dnf a chroot to some location in your
> > > >     home dir and try to run a binary from it, that it tries to load=
 the
> > > >     libraries from your /usr is a pretty unintuitive and not at all
> > > >     useful behavior."
> > > >
> > > > (3) Quote:
> > > >     "[Various remote execution things run in locked down containers=
 that
> > > >     disable userns, which makes the sandbox impossible and hence our
> > > >     builds wouldn't work there." =20
> > >
> > > FWIW I think someone also mentioned to me that it would make things
> > > easier for them if they could build a piece of software in one
> > > environment and then bundle it up with all required libraries and such
> > > and run it in a very different environment, without
> > > container/sandboxing stuff and without static linking. But I guess
> > > that's kinda niche. =20
> >
> > The problem with 'ship the shared libraries with the application' is
> > that you get all the problems of static linking.
> > If there is a bug in the library code you can't fix it without getting =
the
> > 3rd party to rebuild their application package. =20
>=20
> Yes, it's appropriate for weird use cases like "I want to run this
> historical version of the software and its dependencies", it's not
> necessarily a good idea for normal application use.

That's what LD_LIBRARY_PATH is for ...

And if you want to use a different elf interpreter just run it and pass the
program name and arguments to it. eg:
	/lib64/ld-linux-x64-64.so.2 /bin/echo fubar
Last time I did that I was trying to run non-linux ppc elf program.
I got part way there, but needed to build a lot more of libc.

	David
