Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4923AB276
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695496; cv=pass; b=B927KjNpPKehq2Iz4eeUtkwEOpkEQbJeP9Rl2W+yWrSi6Pc3fA8RoRdcAps0rPWXxR0CZCWgWBArWpVSZiPL0Yt7ef3wUebuqUqxkQGnWL5JOAecju4VbrsyOIA9QxYbbMG6HM93NcjwB/QDGq+csKjZp/5il8aE/+C55NlE1/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695496; c=relaxed/simple;
	bh=kqPRzU1r8Upp5TYgefpiWZ9RVnkrVKI+N7GY819VmUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFXcJhOm/+2N0UBabcvd7/sAfTBRd/k5qwdc0OqN4Alot6YxDuUFpAxPkXFIkSc0SBGXUz4/iUtIpxEdbJCeOQGua9FILbK/34kR7DFaFVDJZFQ3qCDQwV2j0pS8LyI55GsjqW7YnZtlTXWxsgwosxojGH3o+DDDl2IrKLyPJR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhQanICp; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhQanICp"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5675d609621so2390901e0c.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 07:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776695494; cv=none;
        d=google.com; s=arc-20240605;
        b=N6PGIJ/cQ6gMysXJZOzkFOaWIDNMsSStKq0hli7ZuADxV/xw9ChrK10+7oZm/jmojw
         YgK+nWe/0/H9zf1hsiZvAHgMz+lM0DfFaLOj8vR5k9ysxFReVNCLvd2GU/LmWzluMw6x
         23Remlw/6ZMoDOh68rU5BWN/z9yq9eqY9g4gyl1nJxfyQT2oTKETm2EEipK3Vc1RGoiV
         VQiwgvBLI9GG4OUF8zs4VaeQoVj5IOv3LX9SKAe2OoOuHsMHVGb1D9Asx98gsZmoARzE
         O6dPvHqlTbOg1U7xJ6+RMIgBA+3OyV4tQCy/I+QZ+o7m1XG7V5fYxtxikwBpoBHbEpt2
         BnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        fh=16QCpnoWFQJydsl7MQ6PjFeapC9IrJm5Fc4/0icnWKw=;
        b=eHO9MEESHGswkXKDnY7tGYNVbPxYzSg1AfvsugypClb1qaJHQ1heEnk/0CcZaRFZzi
         BBlUvUVHMg4dUZGVYhHL/ObqlCjE2DGBraPV7SF4P71qZ3utzmkQSbz2Dt+YrYDeNQo5
         mrWu3RK7ZtdnVFv6u8j+4d9i7mTUtigG2UaqcoVzuqotbVeihNpZvxR+4uzY6ynaVbNA
         MO9GHwNc0DUwvS7BWgf0KgiT3kIcLSIKBZltmdypDmRB+tmHHa2FaYQcQncI4a0Mc6/z
         tIrhyWRhE6JtO6R/Gv766RwJokEECMTMOV+L5hmWbbxgOlGwxTcQPY+7KA2pynx0XlKE
         cOIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776695494; x=1777300294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        b=EhQanICpPv6wEMAT2QVDm8MgxITvcGEAYHe1m42iLSyMQj1Y0WareKAEFrCkR4fDyS
         SPGbqqTXwePHWW8p/f+2UlF/X2ihrUtbg8fbhtFxe6Qkqi2/QsyMkbJOzqro8eqXQAMl
         WcTOuWJXsUbOkZXsn0mFPAAJhM+mIGkIVvCxhoXQub2kbpvG2XE+6iWz+07ORoIJhtIs
         ClD0K9/EMLGHnjeD7QhTdYd1UAPBisbBisjidOI06FRByUtkXvWoSYx8MVyVgkzYR17D
         5S+1XoMelyZ02D7ZT3mCabthO4VIPjJuimT5uUTlee+2Q1h9TgB0nS+/3YwCJhdIarG8
         Pp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776695494; x=1777300294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        b=V1kk1pP5eW5BJWw1ZkjQbZjiOaA8hb19lyVXh6Pg5RJVSDPBzlpk5ir0cgdrSy8iSJ
         jl8NLQDL1ltwGxZKLlccJcvooJHdIfZm/e/fmBD4G06G/Xj7HT4q0HyQLQL3/ogSoH81
         PvZ+UWeS/AtR4br909GCy6bpdYRQM5qvQDKtQ5gS4u6QFXN6wzwGmE50/sT5nayBJ5d4
         COrVCUTgI/IVhWxeDWaayAU+YigL1zIp8cAhx2C14MEV6lUPxIKUanuM/SPJ+SITMIVN
         jR73Yss1n2T0BxMpTbl1/iEMg9Q9ghyoo3P/vl+xETMeR1NKqcECnGWHkaLdUz4PASZb
         eqTw==
X-Gm-Message-State: AOJu0Yzkg7Sx5p7IjhtLo6T4/M6DZjr4fkr1B2wLIprBBjSdJC3pc56x
	XwcQX4JFN/LeBmjoUeCg8PjJO/hfxVSGh1C02br8sweDEJvjE5UvTRgSWzBpe19/ufa0u076hEb
	3tKEcrl3C54/nyikQ3OpKqWlpgSAqAEI=
X-Gm-Gg: AeBDievFwObDhkO9HuMHOCEWGzHjgNNEyG8cdWfXH8upqWLN7VprFvN1rmmK+6MyAq7
	m+wuFJPdpFD93vrl3Ba6kiSm4bfybMXup2ysk+MeEqPa9KSi7sQ2QkFuDICj8WnyN8RqOSa6wbw
	hIjYQ26+sbBbO2//Vt7+Nqd/jvROJhnzTbSNCxZGlu/4xDrHvlj65pLBq+dVAYFY1O+yWfX0LiS
	oDmKchkSpqM16KeHbDFXW1pV9lQZ2yihdJjuzlu6bGpKYSueJ2NcoW6wfDpeDOM2DgFR9Cc4k7t
	9XXywFaxbb/yobteSRQk7zFL246w9x4cP3IWLSgX/PceEjCQVOAZ
X-Received: by 2002:a05:6122:4d12:b0:56f:9512:145 with SMTP id
 71dfb90a1353d-56fa5a39aa7mr6593038e0c.13.1776695494119; Mon, 20 Apr 2026
 07:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner> <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
 <20260420-laufen-einzeln-4cf4bb364a5d@brauner>
In-Reply-To: <20260420-laufen-einzeln-4cf4bb364a5d@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 20 Apr 2026 20:31:23 +0600
X-Gm-Features: AQROBzDP8Lx2bqkiL-O80tZkD0rFOUG8sjvNKKIkhcPgFqdc6FHkIJDo6D1Xn7k
Message-ID: <CAFfO_h5FH36eqYuuoYy2eVRXGytmQHLfz5p7fLi+3wHmQN9MnA@mail.gmail.com>
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

On Mon, Apr 20, 2026 at 7:20=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 16, 2026 at 09:22:03PM +0600, Dorjoy Chowdhury wrote:
> > On Thu, Apr 16, 2026 at 7:07=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > > > I came upon this "Ability to only open regular files" uapi feature =
suggestion
> > > > from https://uapi-group.org/kernel-features/#ability-to-only-open-r=
egular-files
> > > > and thought it would be something I could do as a first patch and g=
et to
> > > > know the kernel code a bit better.
> > > >
> > > > The following filesystems have been tested by building and booting =
the kernel
> > > > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_R=
EGULAR that
> > > > regular files can be successfully opened and non-regular files (dir=
ectory, fifo etc)
> > > > return -EFTYPE.
> > > > - btrfs
> > > > - NFS (loopback)
> > > > - SMB (loopback)
> > > >
> > > > [...]
> > >
> > > - I've added an explanation why OPENAT2_REGULAR is only needed for so=
me
> > >   ->atomic_open() implementers but not others. What I don't like is t=
hat
> > >   we need all that custom handling in there but it's managable.
> > >
> > > - I dropped the topmost style conversions. They really don't belong
> > >   there and if we switch to something better we should use (1 << <nr>=
).
> > >
> > > - I split the EFTYPE errno introduction into a separate patch.
> > >
> > > ---
> >
> > Thanks for fixing up and picking this one up!
> >
> > >
> > > Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> > > Patches in the vfs-7.2.openat.regular branch should appear in linux-n=
ext soon.
> > >
> >
> > I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
> > git.kernel.org.  Maybe this hasn't been pushed yet?
>
> Nothing will get pushed prior to -rc1 which is due this Sunday.

Understood. Thanks!

Regards,
Dorjoy
