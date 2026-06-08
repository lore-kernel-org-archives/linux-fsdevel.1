Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C932EFD95
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 01:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780881892; cv=none; b=rZWCDSZEnTrdmWhU5uL4cJv/hbp9SCFhzGOrn2Tnxw71USHV+bQNU1GxRbEGQdD8SW+rN5y2JGNOBJ5GglWiLeFoZ3RQhIVhOEpcOKAkveWNlbyu4tU0T8zAdZex5lDHSFYCIcSITAkJzW/AY774DUB7wblT4VXJ81A2UImC91w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780881892; c=relaxed/simple;
	bh=CJatAejF25qglO6LaXhVhXVkLXGkginx4LgUdv7PA98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HspVM/d0TN5PRPl1DvQEuVOexIBHgqdkbPkcvMubfUK9kweLPNifteLc6kG7ZNCfOM2IRTOqAYXdsNpiuyvS0ue1RbcHTrFSFGLWHJaWZUiEp1cg9eR3HwB6EhFqDYjc8iSP/b1v1xprrLtNwntmlXURVor/OS8NDPMRv16OkQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3eZ2X3+; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3eZ2X3+"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4863eae4526so1614148b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2026 18:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780881889; x=1781486689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KA4szEGo6wOnyi0fbcbBAli7f/sHn9kX0lbzlCMGGU=;
        b=g3eZ2X3+eZ3lXeansZB6jgsTHoPOUkqJRSB7AHoN/hs9b2BJj2qnU2bS92mSXbFMIv
         Hq0x+nSw6DFb/CG/uhQssXKnAv2ycQKMzNTpN0QwVB0hNtxoHaRs3vjEnlfIdk3PXBg6
         509Kf/qt2uMJ8mKL2sonazWr7VtGee3o2AytZI+n0qkj0VXnYq7uESbRZpZLgxEFI/ui
         edTubxJ5NHGBWVcrELEdz6SfzQpYm08+fOk5TIQGoOJt8SWIeR2wRVi7EwtDv/dRtIkb
         xo9rXor/SSL3KsTufYprVsEN2MRkcFKH/Bf/PLAZQl4q7y/6UNlp2d9MupyvvdVf7U2y
         4Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780881889; x=1781486689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0KA4szEGo6wOnyi0fbcbBAli7f/sHn9kX0lbzlCMGGU=;
        b=UsvhSW0eVpeE+W1HI4OeET0TU3pypq6nzzYq0KfQkvWpzLnuV6RnsFTIyMKYKtuAdZ
         8uky3YECzsVvrTVHDfzTiTKC9CE/Xdyqgs8pr47Rt8D4wmT0zX8Nx5SYbVH03Dtl5A6s
         YOoieMSIz9Qq3pMegoWlyTnZzD2rdWfGDat64cnXaHNJYad6czctfcYxVnzg0B+e+Rrc
         chZdpzWbyoe0b8y8GufPUGo5gDUyH4ryGhLwxnFN9iYklsOrXnbCyCrx6ondNjN23bSn
         4WtIgVHhSsq+MlvCgfOns4AZODs3hPI67wURNxLiOG8xT4XRCiqosArEw4DJn1AGEiCn
         BBNw==
X-Forwarded-Encrypted: i=1; AFNElJ+qsWwiNZb3F2RcggMJtpnZELnKWm2RQ1qrQ96ry/6jw39qRjPAKR2mvv5AAaUFwrMqoLGlMmCS7mhJppUs@vger.kernel.org
X-Gm-Message-State: AOJu0YwoibQFGe/qMHlSDcxnldoaI3uUdUU1nnN+i//rYvo3HT1uZ2Vu
	Xbxu8DGxGZFtSnHK39LQ0yK18SZuMcoirIo0Ph3lK2BofHS05DNy6KlXX0T+1NcXpXE=
X-Gm-Gg: Acq92OELYrLiOtac2yRYsN57TQqFKGrSsnxYCGQ/3b1ovTkHUuZ2+dcwwd6tPSR9RPy
	biN15wdKMCgWMwewKPJ1xUIqinWv9O3siTxG3HM4n0mFK5V1MDlidjn0j5AnUa9zfNuYPWpCKy1
	bn7xKX/eEgvf4grO4N2ImVPz6IpI+UpcTcJ7NnHQro/Ad3obkg0YkF7xzuvgeuHMGBU9RWBT3Nq
	NQzM0UMpVQA/TWY3WYrUcXi5eeSraj+R5fKXhhKNDsk/4WZTglcf3zEiKXPj3XM6ZJEmpRbVQ6b
	DTjgaxzjhWVXOy7BEyDMo5EncdLQV2bveW5LBmTBgfkrBa+KrnEG8LPIXeWA70oyMf7t6hBvNFm
	oJBU0TqBNPcagq0BkOP+FXnvWmhmrj3tI8D6NzaepPpCKlWLX89NdRR/kxW2Zzhiq1kexDKnJt9
	A+/dRQVLdv7b3dYODAc6QDqHvlpI0zqRAOsL7St66SYAOpneSoasp27f8ntqp2wLURCIdJOLck1
	g==
X-Received: by 2002:a05:6808:2e4e:b0:485:7c5a:63b5 with SMTP id 5614622812f47-4868db2da00mr7219557b6e.4.1780881888670;
        Sun, 07 Jun 2026 18:24:48 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5b5fsm13177540b6e.2.2026.06.07.18.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 18:24:48 -0700 (PDT)
Date: Sun, 7 Jun 2026 20:24:48 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, open
 list <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] Maintainership of the EFS filesystem
Message-ID: <20260607202448.51d3fdfd@linuxescape>
In-Reply-To: <zeso7ucog4r7rcpul5oandqu36kdlz457fvh4smmplbu4yxj3p@lxitjovf6s7q>
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
	<aiOXiumEOIPOQm93@casper.infradead.org>
	<CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
	<20260606042109.GG2636677@ZenIV>
	<CAKqfh0HS1sZ1PQCZN13LgzY1sh_2c_yhaS3hG8aT+XYRYYPzbA@mail.gmail.com>
	<CAKqfh0Eke4S3rtbJEx_QbN=Ruz5k+=eQQEHJUyWTRVGfdmpUxQ@mail.gmail.com>
	<zeso7ucog4r7rcpul5oandqu36kdlz457fvh4smmplbu4yxj3p@lxitjovf6s7q>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 00:50:58 +0200
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Sat, Jun 06, 2026 at 12:17:53AM -0500, Maxwell Doose wrote:
> > On Fri, Jun 5, 2026 at 11:28=E2=80=AFPM Maxwell Doose <m32285159@gmail.=
com> wrote: =20
> > >
> > > On Fri, Jun 5, 2026 at 11:21=E2=80=AFPM Al Viro <viro@zeniv.linux.org=
.uk> wrote: =20
> > > >
> > > > On Fri, Jun 05, 2026 at 11:02:44PM -0500, Maxwell Doose wrote: =20
> > > > > On Fri, Jun 5, 2026 at 10:44=E2=80=AFPM Matthew Wilcox <willy@inf=
radead.org> wrote: =20
> > > > > >
> > > > > > As I said, I don't see the point.  Do you have any EFS filesyst=
ems? =20
> > > > >
> > > > > I don't personally have any EFS filesystems but that doesn't mean=
 that
> > > > > others don't.
> > > > > =20
> > > > > > Are you volunteering to do any major development on it? =20
> > > > >
> > > > > Like I said, we've already found some problems, and like I said I=
'd
> > > > > like to fix those before it becomes a FUSE as you suggested. So I
> > > > > guess I'll volunteer to do some major development for it as well.=
 =20
> > > >
> > > > Out of curiosity - had there been anything beside the "some code th=
at
> > > > had been ifdefed out since forever doesn't even build these days"
> > > > I've seen mentioned a while ago?
> > > > =20
> >=20
> > Forgot to answer this; I've been looking through the files and already
> > found more ifdefs but also a lot of style issues, most notably
> > trailing whitespace (eek!). I'm still auditing the files but it's 1am
> > over here so I'm going to continue in the morning.
> >  =20
>=20
> A glance at your patch history suggests you are not tied to EFS in any
> capacity. By your admission you don't even use it.
>=20
> It seems like you are just looking for an area to contribute to and
> figured EFS would make a good choice.
>=20

I've already made a contribution to EFS [1], and I'm an active
contributor and driver maintainer in IIO [2] [3], to answer your point.

> I would argue EFS is an excellent candidate for git rm instead. Nobody
> knows if it even works. Even if it happens to work and it gets removed,
> the absolute worst case for anyone interested in extracting data from
> EFS is having to boot up a vm with an older kernel to do it. I think
> that's something the (likely non-existent) users can live with.

I think the general consensus is conversion to a FUSE as well. Then I
suppose while that gets written we give EFS one last chance at life in
fs/.

> Note there is no write support.

A quick google search suggests that EFS initially did support writing,
however it may be too complex to add in this kernel module since all
data is stored in what they call an "extent", basically a sequence of
sectors. In later versions of IRIX EFS was made read-only.

> I did a quick search and found the following userspace tooling:
> https://github.com/sgi-demos/sgi-efs2tar
> https://github.com/jkbenaim/efsextract
>=20
> I have no idea if it works, presumably it does (and better than the
> kernel module).

Native support for EFS would be nice (for its users) but obviously your
point stands.

> So... I don't believe there is any practical value in keeping the fs,
> even for hobbyists.
>=20
> Perhaps you could submit a removal instead.

Then if we eventually remove it, I personally would give EFS about 3
months before we do that, but vfs maintainers may think otherwise.

> If you are looking for something to do, there is plenty of non-obsolete
> code suffering all kinds of breakage. All it takes is picking an area
> and digging into it.

Would be willing to do that, I'd say it may be interesting to take a
look at more orphaned subsystems, drivers, etc.

--=20
best regards,
max

[1]https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3D=
mm-nonmm-unstable&id=3D0f79e1121b0d36808e600a86ab597f86d7b52a51
("fs: efs: remove unneeded debug prints")

[2]https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=
=3Dtogreg&id=3D4452b868d669fbf6d5333cd03ab2bd8fbadb91a3
("MAINTAINERS: Add myself as SCD30 maintainer")

[3]https://lore.kernel.org/linux-iio/20260607182215.3e6e849e@jic23-huawei/T=
/#u
(Jonathan Cameron's IIO pull request)
