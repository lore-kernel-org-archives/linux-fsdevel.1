Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727661;
	b=xMTE7Erh/JPnz864P/LWmpCWCBCVVIxNpT3whRd8MKa1Cj4gdfmODQiJiRQ8kpl3sh6f
	 ufFNiVKggp6hBmKeKRIw7FJ/isE3xqpTYobD6y4Lvg9uNFuqsE7I4ki9mbRnK+i8uSN/h
	 IZlP5Zx2Qy8Tbh/jSZzEjHaefDnpEIWPvywT23ivno4K231xCxrullVvE1h8MnhxjJhU1
	 MM59mmOLCs5ARtaScXs6yKHwqYziDfU0rt8h617boZViKOFvGQbNyHxNiEFjktAGbCoMV
	 VtWKlvfS4lsrEmB1JR+8GhVwepLokRg0Zj4NeyilpRwOP0ORNKF4VI4z4GTE9Ox9Vug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=HalRvx8YdrlduYgz3MgmPlo+8RqyE0QcDNI34iRIm4o=;
	b=IjG3IdIhIyD7YovihtkNyIh4Z44VJSxpZOKm/Iudf4eJI1rpR68JfsY/waXxyTGCTBRG
	 XlqObhaGUevD/544qKzNsBzFXTmqWl+rEgu9D1S2EhDvHr0oBv+snqru8QzM4Iiup6UdU
	 zc4pnZd9qV2hbZume41cezwoONB5bTUeBZIoTtO/V3TJVHmmKl/lB+KsyYj2CL8dIRhWg
	 D+lSLGHdZZfA9aUAeWoh46IL/L+shau4pyOlbpaWnYYFEt3tewwRNEgNheCtiY4dMAc0B
	 YMYotqE8CvaJeN1RKt/WrezwS54YOhWZRXAg+jMPjaIN7XJRFW3y1l1XgU4MD0ndtfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=woy6HRwX;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54A606A32C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 17:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD54A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=woy6HRwX
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48df8fe8513so3863578f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 09:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793727659; x=1794332459; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HalRvx8YdrlduYgz3MgmPlo+8RqyE0QcDNI34iRIm4o=;
        b=woy6HRwXOILk2YRmozyjEQzBKUGc5Nf/4COoj8UwkKe57OQMjizixt8h2Onklui4dG
         1Vufu55PSfdgtAhx2T8CMoQdY2JbX2Yr+A889SNXnKPMg0IOSnbY43V89ZAp2SQ1y+Yu
         0Lo3Kk+5PdkN5aZJN1TTu4I4z8smhZ13Lx9UpmfwkRPgfRa8koFkNHg+PdMw/vi+Tl3n
         D9FewKOa4jG+Kql6zm4Seklqcl2NN/YZJh3Uuhm6z7ZwkWAyx/Ol+wuLb119e6+TzonZ
         eEy7mlgzD3yUcTDh48FObCbYQtkn2Cu5USSf+CpvJ+iUuZYjd8M9s4jy3c+fhMi+JSd/
         qyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793727659; x=1794332459;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HalRvx8YdrlduYgz3MgmPlo+8RqyE0QcDNI34iRIm4o=;
        b=WUuycAK9xx4kg2IcVUA5x4/mg2eotgXm29gtB6dlGPV3tA6Hjvq6y+WSw3cHOz5d0M
         6HCBZjhHbiK0c1776oMTWeFcc9kkXbovZpEGBI/qVdfq8eQMym3ImTpnS3qrX0de3FOk
         Y0TS4S/fSif+BZh9qobh+AkzCj3PWdDmtvQQkLvWyzyUEDlLAIYxpLymyDq+QNayfjpk
         7KOkoSrobvN5irSisDNzu6vGyjs7TmCnlzQMyN//f9IcXMdgp4i3LNgXamk4R3bQcDV1
         E7HPGSacZP7wxVpplutcV9Jr0w4rnWMm2UX/Hzi8i6/IMhDeT8HNBtbln14g4gIwRh49
         oIXw==
X-Forwarded-Encrypted: i=1; AKwUvBxQIIg651J2/DGFDYptTFPBS+mD7uJet9/TNvaNEc4PXVRM2i6H1CmYS0wyebQGQx48TN1YJZJ/sXv2phq3@vger.kernel.org
X-Gm-Message-State: APuU4Z9+iBWcbMtMj2l8kToKZ8m0HH8jtT68kkytZ5M2fp23+ZevuEHI
	pKZfrUPpucMP/8QjCx7NGP1OOEqoo9cjoMvqicPO6WkXq1zo+qDVuZ/9
X-Gm-Gg: AYBFou3381ep+PrSQVW57tMTK0TBvv/sx6yj6g/Lx6TYdveH5g6MlDcaGoREE/4s+9F
	Msh8F0U1RZETzeRc9XtGG1LEBkfXlZXEffF522vu790K/w8pXwvrZlwlWR4xD7+fExZfAn4obdV
	y1J0YUWqg/5QPlJFe9fy52RLxa/d85KgHeUAOgxABjfqYGLMb4fQzLCxWZ4sDTM0q81A/W2ZTW5
	zW3l0dygD4bwRxXuEVJsDcrajBZxRrNb/iFPslMXmeoDLQ/w3cSrdJEabFeiYbi1GgAzgW7AUuW
	nyhc55emvsfvtvL3z84E9C5NU2CGKkU1e8bVO+2X0j7aYC0nqA9aCl9E5E2QIHzSTtUiEQ9pJ4k
	HYF1wrhAkui5XMYnZNWXz+mots9lWhYUmdQoHcCaNI27QcHbr0bEWtVgugbf10jTIIZ6V1WoEgT
	iTBbgcxr4eepsebvjQ67hMN4XxKieBOkwNgII4VD0N/yKlesqbc39U0JZwlVmzxZgyORbfV7L/x
	pqkidlHHfI/hFM/+pCI76aY/8G9AL6nI1MxDqerGlS/OxL5H+cOCbCRnyYE4599JWlE3jcWu7qT
	wga61VAigCUaoAF0nyIHBund
X-Received: by 2002:a05:6000:454f:b0:48f:bcbf:26f5 with SMTP id ffacd0b85a97d-48fbcbf2c73mr1923220f8f.52.1793727658865;
        Tue, 03 Nov 2026 09:40:58 -0800 (PST)
Received: from localhost ([151.60.201.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80306sm28135094f8f.33.2026.11.03.09.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:40:58 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=c5a5fde869710a3a79bb3641c634c1197ac09790723846e273976b318448;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 03 Nov 2026 18:40:43 +0100
Message-Id: <DMLRDRF0IJ5H.2FLKGIYY948MB@gmail.com>
Cc: "Amir Goldstein" <amir73il@gmail.com>, "Andreas Dilger"
 <adilger@dilger.ca>, "David Sterba" <dsterba@suse.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Sungjong Seo"
 <sj1557.seo@samsung.com>, "Konstantin Komarov"
 <almaz.alexandrovich@paragon-software.com>, "Chris Mason"
 <mason@kernel.org>, "Jan Kara" <jack@suse.cz>, "Yuezhang Mo"
 <yuezhang.mo@sony.com>, "Chuck Lever" <cel@kernel.org>, "Darrick J . Wong"
 <djwong@kernel.org>, "Sean Smith" <defendthedisabled@gmail.com>, "Andrey
 Albershteyn" <aalbersh@kernel.org>, "Pedro Falcato" <pfalcato@suse.de>,
 <linux-btrfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <exfat@lists.linux.dev>,
 <ntfs3@lists.linux.dev>, <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v3 3/5] ntfs3: make crtime user-settable using ptime
From: "koraynilay" <koray.fra@gmail.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261101015551.786044-1-koray.fra@gmail.com>
 <20261101015551.786044-4-koray.fra@gmail.com>
 <20261102142452.d6jkitgdeuquy23i@pali>
 <CAOQ4uxhQ3uhq6s+4deEJAQV5iy8QZoucojR58_dUNYrnjt_yvA@mail.gmail.com>
 <20261102153845.d67wlorqcbe3c2w7@pali>
 <DD1A08F1-8F47-4612-A807-AEA39461AF9B@dilger.ca>
 <CAOQ4uxh8EDX5HzFFKWv10-mHYVcSC1zXN+BS2qCm5cTMq=GOCA@mail.gmail.com>
 <20261103094906.n55n5dhrpct5ykmw@pali>
 <CAOQ4uxizEdR-MauSMOTfVcdxnuSMkrEuPth3nm3MsZuhcN5vjA@mail.gmail.com>
 <DMLQY7IRCAX1.1B2J5G5VNEVAS@gmail.com>
 <20261103173203.c4lldr63tocfstok@pali>
In-Reply-To: <20261103173203.c4lldr63tocfstok@pali>

--c5a5fde869710a3a79bb3641c634c1197ac09790723846e273976b318448
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Nov 3, 2026 at 6:32 PM CET, Pali Roh=C3=A1r wrote:
> On Tuesday 03 November 2026 18:20:24 koraynilay wrote:
>> On Tue Nov 3, 2026 at 4:10 PM CET, Amir Goldstein wrote:
>> > On Tue, Nov 3, 2026 at 10:49=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.o=
rg> wrote:
>> >>
>> >> On Tuesday 03 November 2026 09:23:32 Amir Goldstein wrote:
>> >> > On Tue, Nov 3, 2026 at 2:19=E2=80=AFAM Andreas Dilger <adilger@dilg=
er.ca> wrote:
>> >> > >
>> >> > > On Nov 2, 2026, at 09:38, Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
>> >> > > >
>> >> > > > On Monday 02 November 2026 16:09:41 Amir Goldstein wrote:
>> >> > > >> On Mon, Nov 2, 2026 at 3:24=E2=80=AFPM Pali Roh=C3=A1r <pali@k=
ernel.org> wrote:
>> >> > > >>>
>> >> > > >>> On Sunday 01 November 2026 02:55:49 koraynilay wrote:
>> >> > > >>>> @@ -154,6 +158,11 @@ int ntfs_fileattr_set(const struct mnt_=
idmap *idmap, struct dentry *dentry,
>> >> > > >>>>      if (flags & FS_APPEND_FL)
>> >> > > >>>>              new_fl |=3D S_APPEND;
>> >> > > >>>>
>> >> > > >>>> +     if (fa->fsx_xflags & FS_XFLAG_PTIME) {
>> >> > > >>>> +             ni->i_crtime.tv_sec =3D fa->fsx_ptime.tv_sec;
>> >> > > >>>> +             ni->i_crtime.tv_nsec =3D fa->fsx_ptime.tv_nsec=
;
>> >> > > >>>> +     }
>> >> > > >>>> +
>> >> > > >>>>      inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
>> >> > > >>>>
>> >> > > >>>>      /* Save nodump flag to return in ntfs_getattr. */
>> >> > > >>>> @@ -275,8 +284,9 @@ int ntfs_getattr(const struct mnt_idmap =
*idmap, const struct path *path,
>> >> > > >>>>      if (unlikely(is_bad_ni(ni)))
>> >> > > >>>>              return -EINVAL;
>> >> > > >>>>
>> >> > > >>>> -     stat->result_mask |=3D STATX_BTIME;
>> >> > > >>>> +     stat->result_mask |=3D (STATX_BTIME | STATX_PTIME);
>> >> > > >>>>      stat->btime =3D ni->i_crtime;
>> >> > > >>>> +     stat->ptime =3D ni->i_crtime;
>> >> > > >>>
>> >> > > >>> For me this patch looks dangerous. Somehow I would expect tha=
t the
>> >> > > >>> "btime" will never change for existing inode.
>> >> > > >>>
>> >> > > >>> But because the ptime is mapped to i_crtime and ptime is sett=
able from
>> >> > > >>> userspace, with this patch it is directly possible to change =
btime.
>> >> > > >>>
>> >> > > >>>
>> >> > > >>>
>> >> > > >>> I was thinking more about it... Is not this just misunderstan=
ding of how
>> >> > > >>> the security model around the times is working on different s=
ystems?
>> >> > > >>> Because on NTFS there is stored just one field which says whe=
n the file
>> >> > > >>> was created. There are not two fields like "time set by user =
and time
>> >> > > >>> set by system".
>> >> > > >>>
>> >> > > >>> Windows security model allows anybody with WRITE_ATTRIBUTES a=
ccess to
>> >> > > >>> change that create time. Linux security model does not allow =
to change it.
>> >> > > >>>
>> >> > > >>> NTFS in this view is just a filesystem like any other (ext4, =
btrfs, ...).
>> >> > > >>> In my opinion if the ext4 or btrfs filesystem is correctly im=
plemented
>> >> > > >>> on Windows systems, then Windows security model should handle=
 it in the
>> >> > > >>> same way like for NTFS or exFAT. So if something grants WRITE=
_ATTRIBUTES
>> >> > > >>> access, then Windows should allow to change also btime on ext=
4 or btrfs.
>> >> > > >>>
>> >> > > >>>
>> >> > > >>>
>> >> > > >>> On the other hand, I understand the use case to have two crea=
tion times.
>> >> > > >>> One time which would never be changed and could be used for a=
ny kind of
>> >> > > >>> atomic / synchronization by userspace application logic (this=
 btime).
>> >> > > >>> And another time for human which can be changed at any time t=
o any value
>> >> > > >>> which user wants (this ptime).
>> >> > > >>>
>> >> > > >>> In any case, I would suggest that filesystem driver would not=
 report to
>> >> > > >>> userspace unsupported values and would not try to invent othe=
r values
>> >> > > >>> and lying about them.
>> >> > > >>
>> >> > > >> But all those fs with mutable creation time already report it =
with STATX_BTIME
>> >> > > >> so what can we do about this?
>> >> > > >
>> >> > > > Well, what I wanted above to point out is that the "mutability"=
 of
>> >> > > > creation time is not feature of filesystem, but in my opinion r=
ather
>> >> > > > property of the security model on the running operating system.
>> >> > > >
>> >> > > > Maybe better question is: how ext4 btimes differs from the ntfs=
 btime?
>> >> > > > In my opinion there is no much difference, both of them has mea=
ning
>> >> > > > "time when was the file created".
>> >> > > >
>> >> > > >> If userspace requests both STATX_BTIME|STATX_PTIME in mask arg=
,
>> >> > > >> those fs could technically return only STATX_PTIME and it shou=
ld not regress
>> >> > > >> existing programs.
>> >> > > >>
>> >> > > >> But this is still a bit surprising behavior is it not?
>> >> > > >>
>> >> > > >> Thanks,
>> >> > > >> Amir.
>> >> > > >
>> >> > > > I'm not sure what to do with it.
>> >> > > >
>> >> > > > If we allow to change btime of ntfs then for consistency we sho=
uld also
>> >> > > > allow to change btime of ext4.
>> >> > > >
>> >> > > > Maybe another idea... define new capability which would allow t=
o change
>> >> > > > btime (on any filesystem)? This would at least make the consist=
ency.
>> >> >
>> >> > Pali, I think this is a very bad idea.
>> >>
>> >> Ok, if the point is that ext4 btime must stay immutable then it is a =
bad idea.
>> >>
>> >> > This has nothing to do with capabilities.
>> >> > The Windows and MacOS filesystems have allowed setting their
>> >> > "creation time" forever
>> >>
>> >> FreeBSD for some fs allow it too (see below).
>> >>
>> >> > and for all the other Linux filesystems that had
>> >> > "birth time" it was immutable, so let's not mix filesystem features
>> >> > with capabilities.
>> >>
>> >> I think that it is important to first define behavior and invariants =
of
>> >> these "btime" and "ptime" kernel properties.
>> >>
>> >> If we want to be consistent then there are two possible options:
>> >>
>> >> 1. If we choose that the STATX_BTIME is immutable then no kernel fs
>> >>    driver should allow to change.
>> >>
>> >> 2. If we choose that the "NTFS create time" is reported via STATX_BTI=
ME
>> >>    then STATX_BTIME is not immutable at all.
>> >>
>> >> These two options cannot be chosen together because option 1 would
>> >> implie that the modifiable "NTFS create time" cannot be reported over
>> >> STATX_BTIME.
>> >>
>> >> We are have currently STATX_BTIME immutable and "NTFS create time"
>> >> reported via STATX_BTIME.
>> >>
>> >> If we want to stay _consistent_ across fs drivers then adding API for
>> >> changing "NTFS create time" would break one of those two things.
>> >>
>> >> In my opinion we should stay consistent across filesystem drivers and
>> >> provide unified behavior of APIs independently of used filesystem.
>> >> Otherwise userspace applications would have to write fs specific code
>> >> for doing their use cases (and we can stay with fs-specific xattrs, n=
o
>> >> need to create unified APIs).
>> >>
>> >> Does it make sense? Or it is still a bad idea to think about it in th=
is way?
>> >>
>> >
>> > My "bad idea" comment was only referring to capability.
>> >
>> > w.r.t the STATX_BTIME ambiguity there is another option we may want to
>> > consider: Don't publish STATX_PTIME via statx() at all.
>> >
>> > One of the reasons that developers have pointed to fileattr as the rig=
ht API
>> > to host the creation time as well as the DOS attributes is that it has=
 a history
>> > of carrying filesystem specific attributes.
>> >
>> > Not every attribute available in lsattr is also available in statx().
>> > If projid is not available in statx() then the settable creation time
>> > doesn't need to be in statx() either.
>> >
>> > The file_[sg]etattr() syscalls provides a symmetric API to set/get it.
>>=20
>> btime currently is also a fliesystem specific implementation tho, and
>> there was already a transition from stat to statx when btime was added,
>> so I think ptime should be included in statx, especially since it should
>> be treated as one of the standard timestamps from now on (or at least,
>> that's what I hope to achieve eventually).
>> The only difference to the currently standard timestamps would be that
>> a/mtime are managed by utimensat, ctime/btime by the filesystems
>> themselves (as they're more "internal" and less "user-facing") and ptime
>> would be managed by file_[gs]etattr() (since changing utimensat wouldn't
>> make sense as said in the april thread).
>
> Not related to these changes, but I think it would make sense to adjust
> also utimensat man page documentation and mention there what kind of
> syscall/function will be used for changing ptime. From my experience,
> such cross reference can help developers. Also the fact is that FreeBSD
> changes birth time via utimes syscall could mean that developers could
> look for similar Linux functionality in linux utime* manpages.

Right, I'll add some quick draft/mention in the manpage for next series,
just to remember to include this in the final patch (and to get feedback
on this point too).

Thanks,
koraynilay

>>=20
>> > The same could be true to HIDDEN/ARCHIVE/SYSTEM flags if those
>> > are added to fileattr.
>> >
>> > Do we need to stop publishing NTFS creation time in STATX_BTIME?
>> > I think it's too late for that and nobody is going to gain anything
>> > from doing that.
>> >
>> > Thanks,
>> > Amir.
>>=20
>>=20



--c5a5fde869710a3a79bb3641c634c1197ac09790723846e273976b318448
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCauocmwAKCRA0bnTtJTDo
OAdQAQCYIdU5uaWCGPbgdHiAaI43OTEUpmNMNI06KVgbMWpOXgEAgvqYaGh+5xGv
tTUbArF1CokI7Zqs1nLK83tHMHPSWwI=
=fO3V
-----END PGP SIGNATURE-----

--c5a5fde869710a3a79bb3641c634c1197ac09790723846e273976b318448--
