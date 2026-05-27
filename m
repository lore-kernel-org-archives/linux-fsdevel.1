Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D739A274B37
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921639; cv=pass; b=JiU6Jp3GcG8TeKF35GvsTySYtzJi8hzsyTvGRa/FL1gyYrx2h4rRAHKUcfFCKuiV4CzVTc37RZPaMJU6eZhmfAaakPzZ712xkxMrDxp3VfSLqRyTqOrXP79V6zn/bo6sei6oMqdwdIcSBBLznFa9CYbmmj5aH9Y9P0qUKjTVqG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921639; c=relaxed/simple;
	bh=apu/P6/fBfHw730fI/dCBoHLTtx+6SzUKNBbDiT201w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlF6Wpex4zNJV6Xov7r4LXQMTMAtSetHNCbY8Of2JYxEYeLd4wfRdAffiEjFW6ximmxIPS80kAWG9ceQvVZ1YMu/51HJRRQWZELXm6eugmdF+n/BXGcCMVPN4CNyOLbsPGYXkvqCQpS5Zg3+wZwo1/pj9RZebWtgRGM6t3cciG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djMK6vfu; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djMK6vfu"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4906238c62eso35166905e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 15:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779921636; cv=none;
        d=google.com; s=arc-20240605;
        b=P/8tYnM0EW0LcdCWs+6FVYr6lHmBE3TL2Hj3JBjKJVsgve0gEj1FiPbGeNPmdm/MHz
         H2rU1J6xNXWOrUBynxFZxJKvklls+w4+9/+oRkZb1WRZUYoLURiPlXvplWkDEbqVFPa6
         pyI8Hc8kU8nT4fvNTmH8z0K5f1TXOmOfFDsbic4JGH97BWIQ8Fry/057p+gOhtDRAdOO
         82VwG/TELLI6tNl5v05sS1BiBCUcXvOOmbccPKG83JiQeCDelXtasdtcGx4gfsXEHoYF
         YereS3nVWvsVNUwnYoTByyV/O6Zfi3zxCA5tDNXL3yIeqVodQ2RtN3hNztxNXNvXcL5T
         JT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=apu/P6/fBfHw730fI/dCBoHLTtx+6SzUKNBbDiT201w=;
        fh=xhneoojxnTSLfmkl/FVILzYBUqg0XndCw2dwTrzwzmY=;
        b=I2zyDCVzOdHDkWzYLiPKwN9WnXfkXDo5d6y1z73SyFLoNFvlBl33M33zPpx+6qX06H
         mpQ5yfD+h9WGY8USWw/BWx9J+6Y2JEtg9NbEULCMjCCFgZmfPDN4s/AdqkfT0bC/Pi/o
         13FjoHWTx8H4sVXiDLpbCd+TCZmVU4+IwarwP732cpMP3HxMnczcax02OT2WtiHrXvOe
         iByc7oUH1hU8OjlGojWQYIELCMJ4rW3PLOv90BFLsCjy/sbbLJi+qy5bS6fhEZqdo+Mx
         CHwbuvNPhoy3MEV7qZXCW74VroTBl4/6nlok0mdbaOuIJ/IYmg9pL+yDetZqCDCPPzqj
         WU2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779921636; x=1780526436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apu/P6/fBfHw730fI/dCBoHLTtx+6SzUKNBbDiT201w=;
        b=djMK6vfuLpHZ6gfFn1sJZNl5QTd4vrXaTy6cibM3ZXSLQAMypaU31O+bgaDZeMoRtQ
         J39UfJPQO1PX37i7mdcvGzXSXokwRkeq/DxvvmNvxzhLoNr7c6+cWbTECciO5bbUkelw
         QqUQZtUksNUpdG0kE1C2BbZ3uyHtDjwiao/uv4D0PilSoM1gzTWONimget9IlnSIm4u+
         LcbP+Ij4oUYKdrMFqogiER5wskC6Av43x3z3NiuPrBTWtr8nFzuFR70/FJWwcHpVphfI
         PSNIE4lYHymcbTp9zWCwespyYgQJswe4YaHoh3JGlugQbnIIAC8w0ff+we5jaPdV1eu5
         2+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779921636; x=1780526436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=apu/P6/fBfHw730fI/dCBoHLTtx+6SzUKNBbDiT201w=;
        b=rPnDfeMQagCCILRcVBT4e9tdPvDWqdbrnGreRT9WDm+z2PvnGAdby49z5WjIEP0BKa
         sJzOD9By0jAxdpv5I3nqD2X/Zs3hOQ6dbD+IFTVnth0UyGtm320RhmjmKAnKojzwdbaE
         Bh5BM8Iik6mHFvFxRmPl1vJZTnqNm8RedRPbar+qG9TR8McMm/Nz05uxbfEOrS8BQHBJ
         /C8a6VpdzEA1L65Sn0WnNxfgsRw7rNXNTNiJ08hrNfJTeGrQmdAClearTutno3uMus9t
         EjV09jptDvxgNzSOb484iujtRXvt+5sHRdGrJwJXDtKe4V5x/X+Qa65mNF1olNXsyqKp
         80iw==
X-Forwarded-Encrypted: i=1; AFNElJ/3OI1fir7i/b+giz/CrzyOXRpTeqFmRtr0QEvMDJFqtv5ELuktX2roX3fCDW1NevmUgN5lax9YGke6sGxW@vger.kernel.org
X-Gm-Message-State: AOJu0YxcuJLukD2iYz3aII0oCfwoIBs9hPkVIdHBy9wimBDX6n28GJML
	cZuGDm3KbG7n37liA0SgucwnBq3QbehwTXa9tddxc9+6HmbBEKNIq4LOSWHcGi/MhFRkHfW13e+
	EXyfrcIZ3tuIDJO3QN5GigNSsG6Z4xkPvQtLGnYA=
X-Gm-Gg: Acq92OFf5loFnv+de5i4GCGSYvG9HFaK1Phl3fjFT9Pet9XsUi/g8hdWGYfJGqDxR3k
	pdn1p6Tz33qkd68RHlvFWZVMdlmO+/KXo8o5ndwKZ7ccz2PP8Mfh9qEPIhptrHYPdbhRNddv5QY
	+Bh1rZIAT91gzVVFzMMhQYT+to6iSFED1ACxIRbH3kK68Wjfs9k+CcYzHJfu3FrETry/OjbDAiW
	KQdkfCObkbJmYNPppTX4YHTJoKd+FoC6EcEeIXnvP4CCHnkbH1jm4Q7NI4Y2e6sazeFkr2M0KRK
	TRavH0uKI6fwh3fTvmhoEIuAiIE45c1WADva9Rr+9dBN
X-Received: by 2002:a05:600c:1d0d:b0:490:601f:d788 with SMTP id
 5b1f17b1804b1-490601fd8bamr278017935e9.5.1779921636078; Wed, 27 May 2026
 15:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
 <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
 <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
 <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
 <ahaF7UaeQlgajYDi@fedora.fritz.box> <CAOQ4uxiqP=f+5py=2Ma1uEchogYttQ5sKZte6XKRVHAO=pY1DA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiqP=f+5py=2Ma1uEchogYttQ5sKZte6XKRVHAO=pY1DA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 27 May 2026 15:40:23 -0700
X-Gm-Features: AVHnY4IwTYY5ddtTAGaKtbU2Fh0R1_NeaT1KtLDt7fmycX1PzTpXR0Gv5QqS7mI
Message-ID: <CAJnrk1a_8SCDUPCjAT6a7xK7r=b-iqKeRnkPSbv7dUvjjBGDyw@mail.gmail.com>
Subject: Re: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Amir Goldstein <amir73il@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jan Kara <jack@suse.cz>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 3:59=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, May 27, 2026 at 8:06=E2=80=AFAM Horst Birthelmer <horst@birthelme=
r.de> wrote:
> >
> > On Tue, May 26, 2026 at 06:42:35PM -0700, Joanne Koong wrote:
> > >
> > > For getting this to work on fuse servers with strictlimiting, I think
> > > the next steps are to
> > > a) as Jan had suggested in [1], come up with some heuristic to
> > > constrain the max order supported for large folios for these fuse
> > > servers if they're running with the writeback cache enabled
> > > b) benchmark ^ and if there are still regressions, then we should
> > > probably just turn large folios off for these servers
> > > c) add the granular writeback/dirty accounting for large folios
> > > d) look into improving the balance_dirty_pages() throttling logic to
> > > handle narrow gaps between the freerun and full throttling zones
> > > better and reduce over-throttling
> > >
> > > Does this sound like a reasonable way forward?
> >
> > Sounds good to me, since we have seen pretty much the same when we enab=
led
> > large folios for testing.

Awesome, glad to hear we've been seeing the same things.

> >
> > >
> > > For privileged servers, I still think it makes sense to remove the
> > > strictlimiting requirement or at the least, let admins opt out of tha=
t
> > > if they are confident their server is well-behaved.
> > >
> >
> > Here I'm not really sure what the most logical and sane way would be.
> > I really don't like limits for no reason but I understand the necessity
> > to have limits enabled for unpriviledged servers.
> >
> > Do you think a module parameter is the right way to go here?
> > The connection parameter might be a problem since an admin would have
> > to set it for a large number of mounts.
> >
>
> Not saying no to a module option, but I am curious.
> This admin opt-in per mount could easily be implemented in userspace
> in either libfuse and/or mount helper.
>
> For such a niche ("I know what I am doing") feature, why does it matter
> to do this in the kernel module params?
>

I'm hoping we're able to keep things as simple as possible by just
getting rid of strictlimiting by default for privileged servers on the
kernel side, without needing any module parameters or libfuse changes,
but I'm not sure if Miklos is comfortable with that. imo if the server
is privileged, it can be trusted to not misbehave and should be given
the same kind of capabilities as a local filesystem. But I guess there
might be the possibility of user regressions if it turns out people's
privileged fuse servers are accidentally buggy.

I think the module parameter makes sense if admins trust unprivileged
servers enough to turn off strictlimiting globally. Otherwise, I think
Miklos just mentioned there's already a /sys/class/bdi interface that
lets admins disable strictlimit on a per-mount basis, so I think it
would be cleaner (though more annoying on the userspace side :)) if
libfuse used this to turn it off by default. The max supported folio
order is set per-inode when the inode is first looked up, not at mount
time, so the admin can disable strictlimit via sysfs after mount
(which is when the bdi sysfs entry gets created) and new inodes will
pick up large folio support from there.

Thanks,
Joanne

> Thanks,
> Amir.
