Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA1A3672A8
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378578; cv=pass; b=tIkthuM5SwFHQT5tMaGt8neDoMts8WIso7IUEJsx7qYV6ri98Nq4p77G+aKIf5w0tNG/FfQnx6cykC/6F48Pjd87UyXuanR31DDoY1XPS99cC6hkCY96rE0DP4pLO7z9iEkvGeukwrC+X9UdCtNOUoALu3vgumwev7huuzngdw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378578; c=relaxed/simple;
	bh=oTJGeDYTACLQP4b7lcnYS7MF/F8SkeHi472hQfd2CPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnoed14J5rO2QVUiQu2qylOOQv+fUAo63srtZYhmNFy0rBhCeFYd60eMd3OfWrngvV44bCub6YHyaewELgi/WZ+WLvsuWGjyljDIHTFqXttVRPAAn7Ug/DjMPAhK/ipPAy4GkU7LwwrOVF3ycgid2jRO2C1wkDEs3ULosAPeBl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL1NHx9I; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL1NHx9I"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-628086439b6so5689506137.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 08:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779378575; cv=none;
        d=google.com; s=arc-20240605;
        b=UaEmsq4h/jRAOs0o4PPpZJBXq0mcqT8uMvRt+gmxc05atSbW4KeN9MXPdBf51T5ZVX
         GbK80OL8CV+d8Fad4B+GUFO1DPE6e6MTHt84giX2SVPFTKMdMk6LgtoS0b/tr3XIjs4z
         7QQK9tCXh5uZI21RAy6nrkrp2QZ+nZkCFq5NHmywR9Yr7MsnAJsHCjKm9Pjh8k1ti6BF
         cFfxWOxUJLhY2RHY41wdcEfKMjRSSummFbBKZ4But9lbCBkfNqzVTKIrRMyuhWSp7rDs
         gn59nmjDPFBSx7eT2jC++sgUNvBe4pPE/pzN8ycc28aDGb3lhJrtfC0N3m4eimH4VldU
         GzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        fh=16QCpnoWFQJydsl7MQ6PjFeapC9IrJm5Fc4/0icnWKw=;
        b=aPwjP/7Uwrxoo16Cq09X9K7pHf25qaJv97PAn6adv/jbn4NLgbflAaSycAsUvrYLpS
         av+363ZtDF7V0dYkSRjUHhKsg/1kmhl0HRZc/4mqvX/8q4XY2HCkmoLetII6NkPiKD9E
         iJ5M2gRorF2TBG9tEOmcORXw2adBzDI9qUqfzri3LQFMJYQmR5G+7K4NyM9u9dojyNOa
         wwDs7yb3q8ShbcE/JB1Ulcv7F10Wye+BzwAn7QaN+MKVcxshcK7tiU8LpfKZpy8xrTjd
         qkW6gJhBEdq+eLOXOZ/TG4A7z5uWSFwbZpHCyTJ76CgIAAJF8QdJN9HTZH9Krv1YHN1e
         XsNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779378575; x=1779983375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        b=lL1NHx9IIKtcx4n399OipzLHTG7xOmxIhzXqniZ5H/PlWZnBHPquJmbnT+WXpW8VGl
         gD5K7nwalvqc4Jt0om+M7KYYupeksRrANY4jRunce7CrRXOXxqnPI7tkmKyFagBaXwF0
         8hbAFX6ZrBAhSIQxY+fV56hM0QhsKH/3w0jYikbW8LAIDNiMade6YzJVU1Efx90sVY3x
         4RhbDvS072Slf7nSGxLx08t5GZTGyaCT39m+CpTwAhqunSH3Y9mmA6I+HSghd2xMwMha
         PQ0O8KzBHHVN1VIStAFdCi0DV3GfXQMWyTqCZkVW0qbXHgDdJtycc4DpHzSHcGvAFvB1
         f1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779378575; x=1779983375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        b=lIF6VEmFbvKq3g1WfToHTk2wND4RgqMxKqTiQWRO3nAPyg0HBNweBKgLwzpv9a3NTr
         MPpriwiPKOufZLcSpczpdGf+cGeQNp1rm04T3HZXtN9bPJ0Zs57jxvYHayO9WTtJ7lUT
         HEMqsE/iZ7zfKHE5uAJWdQ2h95w31zlkoPza7lI/1P0/GBJvST9nQjLxr1DUUHC59xB+
         0JdgZLziR8nsWKNis80+4UZ8mMQl26s4opACGWyAH6MxzmwsYqAnpYicHliPZWypWisW
         xAxQyiwNPufEtv8NaZRab58TYpxBU9FkW3clADbvhjzm12cXgJY6QOH2h+krpwiQTgQQ
         S2Gw==
X-Gm-Message-State: AOJu0Yx+6ztgbznE4U/BcQDR5cLbFtDdLQ3mCKt1h0D3NF4tyEKwKNYc
	3AQpv41OMphfqWETCm+knKOIwMYtHf0gjuoBBlyMb9MT/Pj2IdcxeeTYRL2K2BvNS3Kz7uxvjor
	5SDfRE1nMYoiMkoEJEhdvfKCqmUtW1rU=
X-Gm-Gg: Acq92OHetfPjWSLc/pKXHl4oQU3u4/EpWMmYEzyQn96n8cGGnO+BMxfyuHUDV9Wzjkw
	rdu59+VRC1/QpLVSOUgsQnJ0IUJ+PeS+9oD/pi3g8FFTWz4sLASyJoD7h8zJEndUspFWcKCZI1U
	dvr1itsrSo+Q2/iHTXRRTTWmocvkGw4/Haixek6lCXCAWs93vulQxFNHbdn/e43MLc0OEFIhBRb
	XufeZkCXRoK3POcoiVzt/nqd0tVyWzVBznByqlh1Gjp6Dvhh6WWIoUf4k/hLGh8Am6vnUbawpD+
	cFUmdNj1OGFBaGZRNuPveLs9j/C225M6GsFeaus5UaV7f6m/DxhC05o=
X-Received: by 2002:a05:6102:1591:b0:650:a9f6:4d29 with SMTP id
 ada2fe7eead31-67390b66b29mr2592164137.13.1779378575543; Thu, 21 May 2026
 08:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner> <20260521-grube-leitfaden-0e5420c9bedc@brauner>
In-Reply-To: <20260521-grube-leitfaden-0e5420c9bedc@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 21 May 2026 21:49:23 +0600
X-Gm-Features: AVHnY4JMLUcx8yOSfS2Q9vtP8tvb48vFjP_vPMN644Wd5G5CD5CLlCbq3u4DVJI
Message-ID: <CAFfO_h4Em26Hfbv-DWF+9dNS8TBuGpfWjWFBUhLr7jYCKzj3_Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 4:54=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 16, 2026 at 03:07:12PM +0200, Christian Brauner wrote:
> > On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > > I came upon this "Ability to only open regular files" uapi feature su=
ggestion
> > > from https://uapi-group.org/kernel-features/#ability-to-only-open-reg=
ular-files
> > > and thought it would be something I could do as a first patch and get=
 to
> > > know the kernel code a bit better.
> > >
> > > The following filesystems have been tested by building and booting th=
e kernel
> > > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REG=
ULAR that
> > > regular files can be successfully opened and non-regular files (direc=
tory, fifo etc)
> > > return -EFTYPE.
> > > - btrfs
> > > - NFS (loopback)
> > > - SMB (loopback)
> > >
> > > [...]
> >
> > - I've added an explanation why OPENAT2_REGULAR is only needed for some
> >   ->atomic_open() implementers but not others. What I don't like is tha=
t
> >   we need all that custom handling in there but it's managable.
> >
> > - I dropped the topmost style conversions. They really don't belong
> >   there and if we switch to something better we should use (1 << <nr>).
> >
> > - I split the EFTYPE errno introduction into a separate patch.
>
> So I've massaged this series a bit in that I moved OPENAT2_REGULAR into
> the upper 64-bit and internally use a __O_REGULAR bit. After having
> thought about it makes a lot more sense to move the openat2() only
> features into the upper 32-bit for the uapi space. I also ported the
> selftests to the TEST* framework to fit with Aleksa's recent rework.

Thanks for fixing up!

Regards,
Dorjoy
