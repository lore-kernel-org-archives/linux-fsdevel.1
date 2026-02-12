Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412B2EB872
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891390; cv=pass; b=W67DDw5QQNWko1to/FoWO5Cf5bg1Ml7iYvCcBtDmitV2Ww49Py076j56zGy14AI0PWTjodcgTmhDWRH+xJzOy/Zjjts+doZoUrF0tWfNvHGTi0ErFg5DG1xatXSAaXCkMkorAMSoaKyFn/dLZgZTC8+zFR1IlB3TUTSnxvOhOVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891390; c=relaxed/simple;
	bh=Pt9/exjDhoCvweSIUWpF0t/xsjLaYbAfb3NutSHIrDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYoRZdmfGQnvZ1U1hRcFuocVe+5NjZ67TzxLPSH6/VROJWJ+JZxwm0FMxSQFJwP38OyAQsTmADYhDafy8Xl2tI8m/raDmI3+l/CClAALZM4dwBQ82+50Sxriw2cFF+iwYYXy9H9nVrDqjG4GsBhRwuGRg3brtDZA/Ql05sER7KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=PtsM/1rk; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PtsM/1rk"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5062fc5d86aso66620041cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 02:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770891388; cv=none;
        d=google.com; s=arc-20240605;
        b=Oo4ecnPbWDdXxP5Asne51HSPMrV2lAdrEE/p3UmkBGTrJzDUKZyhuhyuH3Y8MTqAAF
         SDYycnx/wNaUzfYZms3HBrzagBRBv7koepM9NqVaoyEtEwowevCng0lAXV7tIWKH+ugs
         peN/ZvnsfPKCOeGlE3vP2vRqTVqcDOdE/dUaWmAZgNgreeWf0Zz4onGTGROgCkpn3Ij5
         wBRjeycQ5n/aXRN6ZJu1HqP1FjDzUB/YBnSYxt80BZbBMb5+9edHMKtAlVmcizyg9xBi
         XgOLp298s7nt3Srleezb1nKEZEjNvFFYg+7f9ruDmOxokgdRVmpYsGSmzGhQdZbWDlbk
         7J/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WeHZx4EX2ZTk3HQ8JmhCDUMUWvSWIxtWzn4WkoCFD68=;
        fh=NB6ln9RkiYrMdRAwIf7bGpzf4jDXLdlq3LXQ5uSYD0g=;
        b=F1o0Euehww2fzkFaKGeY3eA8ibvOktcChbvG9QOF8A6as+RWuwzFyaLUi33Ve2ub8g
         WzBXGGZXulre4qzE5nTK98BvRKxC2hde7BBmQqHGwwHvUbxYY74v5osh4AZ71smRw0xs
         51V0xIp6K6lF7gaHOV0OUzZaXEooqmzfniqf2GCUw6aYto5xnFvBwRKWxJFMHCxFxg+y
         FBCc3uLSLvt7AXWQc5E3BBMIKC+/vyP/YvLqeZsgG9pWQ4j58tPVvf5LjlPE5NTn85cj
         ks14ZTygg+2a4EHT68XCQeG6rcjZnIRsrSNWiqiApMkFF0TJcupunSIqJ3ckBox6K1cW
         ff7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770891388; x=1771496188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WeHZx4EX2ZTk3HQ8JmhCDUMUWvSWIxtWzn4WkoCFD68=;
        b=PtsM/1rkYbtBxmzVlngw0U6HNfjdiBaRxyq1t6givt8oAlt4o53q5DujQxKXU4THff
         nRoaWl+m9dcGx0Sl99zqn2dX7qEqi2EONzz9WWwbuWxVPosP1xMOnZZQIqmONj94Cp36
         5xFb1H0y/BHHKqRIObtCEz2PBup+whc8xQRmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770891388; x=1771496188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeHZx4EX2ZTk3HQ8JmhCDUMUWvSWIxtWzn4WkoCFD68=;
        b=KiQmhbqP7jKEQMEO8juIQ0Xr6NlC9r+AyO7UPdfGJOMDFP3lV4rwBGCxXPrxkDscyp
         KdJWxYX+XJjm5eq7yL8MAlzXE0LMpAW3pjS9Naz+q0eHK9bpFWb+7kpoT/aw2d4IsjB/
         uIct08LOr7ddkR2n6M4ZbzMg20pM8O5RzGRQePH20b4ZUtogRh674Vje4+d8cMPdWCjn
         9Go0gzY6m0jICzicbw7UX1U9AFWo9vaP2kMXL3/578T5tm3IzbdFGFh8klkkGK33cNdZ
         tqbVT6CZtnH/+S/x1qefGb2HUm0Ch73tjYQLsvpWrJTh73iDwZo9JjPa8bApKEvxr+EI
         qU8w==
X-Forwarded-Encrypted: i=1; AJvYcCWU8BBrZbPEFFCbXUFGN5knvLJ9p8E4yue7nlCGQGy15g8a4NI2GSaY89FKhp+1hZOGc+QgXBKULCzVoXYQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzWI2mJFztm5YCpAty/euFcN3mjlzm5EI2eKd6TEp80Uy0G2uS2
	RfgDPK91yUsRi/aVnROgMe/AKOgVxBxLQaztAylqTax7jxCa0PV+iLDxaT3DXQLFwKytm1a38M5
	ph9Ld4m3E10hNewa2ATtVyuWiepZTiIXIGgK1alVTRw==
X-Gm-Gg: AZuq6aLipi9ableV06DRjgEavCl23QkZLCQjmbB+/aa4kr82uacnODGMe+vZXy3qZ+I
	94O9MHPvxwNlr7SYE/kd5Nl0/75dt2NGY3qgdBZmLKMtfWlHBc6jM70eDlkXrsAAZf6eHjskZFA
	8yYXGBe/wSNlwQKuBbhjxcbwP6DYfeK5dSNIgKdjg5DaIsQ9Xr2cY/4oyBannHkF3b21NO1oQzx
	0ov7tt6KyCg5CAtMXLo+c8DacnjuRawxtFOk7IrM1Ma3HTW3qR0WMQTb75bi2ldPidLh4gLdSzu
	9X2nRg==
X-Received: by 2002:a05:622a:24f:b0:502:e25c:91a8 with SMTP id
 d75a77b69052e-50691f07c39mr26362841cf.61.1770891388010; Thu, 12 Feb 2026
 02:16:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com> <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com>
In-Reply-To: <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Feb 2026 11:16:17 +0100
X-Gm-Features: AZwV_Qg_4YwpNJiR9H6rRLYvwfQL5bW1n7ULaPaNWTsGsJMub1LiYUNq5I1eSUA
Message-ID: <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] fuse: add compound command to combine multiple requests
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Feb 2026 at 10:48, Bernd Schubert <bernd@bsbernd.com> wrote:
>
>
>
> On 2/12/26 10:07, Miklos Szeredi wrote:
> > On Wed, 11 Feb 2026 at 21:36, Bernd Schubert <bernd@bsbernd.com> wrote:
> >
> >> With simple request and a single request per buffer, one can re-use the
> >> existing buffer for the reply in fuse-server
> >>
> >> - write: Do the write operation, then store the result into the io-buffer
> >> - read: Copy the relatively small header, store the result into the
> >> io-buffer
> >>
> >> - Meta-operations: Same as read
> >
> > Reminds me of the header/payload separation in io-uring.
> >
> > We could actually do that on the /dev/fuse interface as well, just
> > never got around to implementing it:  first page reserved for
> > header(s), payload is stored at PAGE_SIZE offset in the supplied
> > buffer.
>
> Yeah, same here, I never came around to that during the past year.
>
> >
> > That doesn't solve the overwriting problem, since in theory we could
> > have a compound with a READ and a WRITE but in practice we can just
> > disallow such combinations.
> >
> > In fact I'd argue that most/all practical compounds will not even have
> > a payload and can fit into a page sized buffer.
>
> That is what Horst had said as well, until I came up with a use case -
> write and immediately fetch updated attributes.

Attributes definitely should fit in the reply header buffer.

> > So as a first iteration can we just limit compounds to small in/out sizes?
>
> Even without write payload, there is still FUSE_NAME_MAX, that can be up
> to PATH_MAX -1. Let's say there is LOOKUP, CREATE/OPEN, GETATTR. Lookup
> could take >4K, CREATE/OPEN another 4K. Copying that pro-actively out of
> the buffer seems a bit overhead? Especially as libfuse needs to iterate
> over each compound first and figure out the exact size.

Ah, huge filenames are a thing.  Probably not worth doing
LOOKUP+CREATE as a compound since it duplicates the filename.  We
already have LOOKUP_CREATE, which does both.  Am I missing something?

Thanks,
Miklos
