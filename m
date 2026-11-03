Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718638;
	b=H0nnZTU+RkvoHQIEaxCG8GyLwO18FwUtn2s3jvCn019onejEpmlxUuGjODG6dmEUsNKc
	 Fr2xh+3GrXT3gCuLeG+QVXo+/TU7gcOkljYzvtE2iHqZUW7Av1mzpjyeNictKkBchBXW/
	 1///ZkGJZtMHvR2Sg/eeTKDcorriABqC29nQ17HQDpsZQFmuXlve6hVzt/OHtTJ2rWeAJ
	 9t6Q6Pwu51YyWMCwdHeroBRYfXK/Nnyxo7wFPRAdSDcml+uv4yUvPFhWSya33j+zVfKNr
	 LXajFbKv/x9SWuVCjt6djPRsiwhGc0hmHJXbDbDc2za4rHvRX5CCFpTVfQVNDuR2QOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7sE4JPqE1qSE0dDJji3oRyNIsowmIbXefj05D9f9GTA=;
	b=xBrBTERhjTnI11LoAloRetr7P8lkZvHL5ZepXtWhSTjZQdHbRDODa/paEBF2GyjefCNC
	 t39Rl9EbyxYdOIMOpcfIR+KR1eXL6IFWL8F35MCvFqu/cALO29eUH0O7G/4uUdg74oPUs
	 4pCIgWqtK6HDdrxNhGHJQsBXtS1YyQYUtvEJ4qpa/mtDCVaw1cmNdhVS9nDyvRsl8k5Ht
	 TDI/X16PNAamUr6HSbH1ms3KVJzykWv98nzaQSpydIn5R+6huWlpvTVVaz1OC5e8nEDbP
	 UtCvXSA+YqH6HiUlNc1JDv/Nu2mF6Z1JFP7POuIR4tR2yZ9uqYnx9MlzMdombjTJd6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IODVJv7c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3C606BA3B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 15:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05E3C606BA3B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IODVJv7c
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1d8944cb0so7202090a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 07:10:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793718636; cv=none;
        d=google.com; s=arc-20260327;
        b=bEGgklszr0qZWR2UrsmGamtsqP+eIaJkKn/Yf2eVKcoy1lKWg9piMXY4huPBIMrW7n
         6v2f27FLqiOfraeRzf7BWI1SjyKe8DmlCu1b3bYO8qczglE8OrL8AxfC1mxFylVTsrEY
         SzZpUUzRytBLs/8WbG1t6MquBzHbdxKEMSjYO7NdTRnruKhPFwqn15cQQd2NJmaAJo5F
         rVVIv2IFZRAxFgGv8uwcAqwhsmJQF4NsWnf3xIXCBwIga47rHMRWaR84DY4eNrBpxPsg
         PcoSJREzcmP14yqX7U8rDIdtlfwrDTG5J9CBICUkxEH7VTWlBj0lPK3EYPSzmxp4py4c
         sgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7sE4JPqE1qSE0dDJji3oRyNIsowmIbXefj05D9f9GTA=;
        fh=Xw3amDyuyehVp+x07qoSSuYvlMsFDoifNeWhLxSJKlU=;
        b=GnGn+we1Go38x1vmEPWruaBxaLEI1EKKIq2Gt6iWTYbo3jwbT2i44VWn1bixpp0usY
         LRzrS0ejSH8hnO8P38B6zyPhkMXxKB3FDGl2lEaKEKKnkyVxSHPP/BtO6Lv9yDzMM33U
         g6LYm1q4u3K55GBzS2QRMAQ6vDT7GTY/6iQIyg6mgFmlMfpR8hzn3e1XgKgBDagsyWoH
         HhGB4DvR5LcJeTemSCGCZ5w6O6UlMur3dBsSuwSCNAsgUgDgE1gU1bDp3ddigAOf6+jQ
         IM3YRSwGmT6AZIQ/7o24d4pazo3vD/szBVn6QWqBcMygdVsFtOT7w/jhT4bHNm+yGX2C
         HozQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793718636; x=1794323436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7sE4JPqE1qSE0dDJji3oRyNIsowmIbXefj05D9f9GTA=;
        b=IODVJv7cdAiH0zI7EYwsSnOisU2I29QacRI48d3GrxZ/4ahTqZYjCqm3KezEodiSwY
         KCcB17frnQVJPSU30oNUQVd+nMk5pNZUdHRRHtexBAcVEnGW6qI/hr5KBmZoGKU9n1AA
         nX7CBFPWo7OCb7jC//Cb3RWTM+8h/yqeY6CfYOZwkZSo8jHXe8sSpor73NKW/nDvJZT9
         /jUg0RghHQEpHFi9UISuH2cBTU+qDXMt5uUjVJ4bcvsnUCsR9swJZWPjdvTg2aLnef7R
         K+UYBntvwOMC75a1sODBxaY3kTz0ODpxjGJ5O/lhjvZS7WbSzPyZEfQDeWHRhswBRXSP
         fOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718636; x=1794323436;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7sE4JPqE1qSE0dDJji3oRyNIsowmIbXefj05D9f9GTA=;
        b=LBQF57FToxa3zJxph9KCIqz7o/CLttdVOfFGHGlFEtz1IbiApKxHqt5NZNp47TT+0D
         +Mf38at1VJjx0OtNSeIfUKJO/rVltNnsXrIzC94eHUnlcgF/Lp4X7YjOc37bToHA+31i
         T2lt8RXLJ489H/TsXYZ8pIFMwOFQ4T2Mc3b5pW5SjUNwfkZSvKFj4K4veM61iUNbQa9G
         9H6cEbyuxb0uPJOeDTYWKNGO8AFWBuSCjWMiBR0DexLN+cNVLpLtTn64HMY8bg/UH5nV
         VpLdbJxeY46YkQWVEHsw4m8kL7+Zo6ep5HfE81B7fvtT5zDWj9DM5kqLX+3eNKdm0P4/
         QX6w==
X-Forwarded-Encrypted: i=1; AKwUvBwAqiZ9gp3t1ZeuO94sgslUmnJr5TiPDqkCOsIYZr4mdl7+uQe9y25PAPn+NbgVAhbo8f6chXTsQSPnDrkK@vger.kernel.org
X-Gm-Message-State: APuU4Z+QGMd76Y1Y8jNWQ/GMudFiIPwwae1F+hBlAQVRQMwj6Y0pzXFw
	a9j5G9aAlfbFI0A056YeKpTCbjKWOW8JHU5ntnDvll4XWvoDb31weFzDl4wlUJm6Ui7khrVTVGn
	TNvYpsx++beZ4wkJK2NdCv+O7ba4262Q=
X-Gm-Gg: AYBFou3lVAvVsz+PsNztdvuKDmJztHXZ7RcLiUSbbbYViQZL3VHMAIGR7Dbexs8K96u
	CiGO0rFGFJi0DNg+5Zz4SDkR4PvKBEvbK+UOiIyqyYhPcw0MEk7xUY+J9axHrG+jiTVIWrDWTKW
	Rkql9FNV5I5OdTALksrlT+m6m0VgXqhNJUN8p37vYDCDuzX312AwtioLHEsdpayOxh3zaEeZ00/
	rtxgsgCbI58NRtKsM+HVX954VwgES6UluD6rrl5oDKfrjKsY2FQ1LacQza3s4D+Rm2b5XE9weOb
	koV0QV8acrla3wVTwcyp4cMl27L9qDoG5BHWD1j6LYs4X6No5RW9LEHqDS8SzOWEz8eL3qBH/VT
	LlSVhrp42H/FiH8DCsFfNb0N3bqkX3W4y/SkTSiD9b9IABXMf2b8BA8aBMAwwSB5hzMP0DQ==
X-Received: by 2002:a05:6402:1576:b0:6b4:2807:94db with SMTP id
 4fb4d7f45d1cf-6b4d63b89b4mr7276457a12.41.1793718635985; Tue, 03 Nov 2026
 07:10:35 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101015551.786044-1-koray.fra@gmail.com> <20261101015551.786044-4-koray.fra@gmail.com>
 <20261102142452.d6jkitgdeuquy23i@pali> <CAOQ4uxhQ3uhq6s+4deEJAQV5iy8QZoucojR58_dUNYrnjt_yvA@mail.gmail.com>
 <20261102153845.d67wlorqcbe3c2w7@pali> <DD1A08F1-8F47-4612-A807-AEA39461AF9B@dilger.ca>
 <CAOQ4uxh8EDX5HzFFKWv10-mHYVcSC1zXN+BS2qCm5cTMq=GOCA@mail.gmail.com> <20261103094906.n55n5dhrpct5ykmw@pali>
In-Reply-To: <20261103094906.n55n5dhrpct5ykmw@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Nov 2026 16:10:24 +0100
X-Gm-Features: AclHuK-nvjo0FA1uWKxpxW2jM-UILx8XEkVUZkdQkJAo4Tb9oLsdcVumIEFmEyo
Message-ID: <CAOQ4uxizEdR-MauSMOTfVcdxnuSMkrEuPth3nm3MsZuhcN5vjA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/5] ntfs3: make crtime user-settable using ptime
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Andreas Dilger <adilger@dilger.ca>, koraynilay <koray.fra@gmail.com>, 
	David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Chris Mason <mason@kernel.org>, 
	Jan Kara <jack@suse.cz>, Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <cel@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Sean Smith <defendthedisabled@gmail.com>, 
	Andrey Albershteyn <aalbersh@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	exfat@lists.linux.dev, ntfs3@lists.linux.dev, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:49=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Tuesday 03 November 2026 09:23:32 Amir Goldstein wrote:
> > On Tue, Nov 3, 2026 at 2:19=E2=80=AFAM Andreas Dilger <adilger@dilger.c=
a> wrote:
> > >
> > > On Nov 2, 2026, at 09:38, Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > >
> > > > On Monday 02 November 2026 16:09:41 Amir Goldstein wrote:
> > > >> On Mon, Nov 2, 2026 at 3:24=E2=80=AFPM Pali Roh=C3=A1r <pali@kerne=
l.org> wrote:
> > > >>>
> > > >>> On Sunday 01 November 2026 02:55:49 koraynilay wrote:
> > > >>>> @@ -154,6 +158,11 @@ int ntfs_fileattr_set(const struct mnt_idma=
p *idmap, struct dentry *dentry,
> > > >>>>      if (flags & FS_APPEND_FL)
> > > >>>>              new_fl |=3D S_APPEND;
> > > >>>>
> > > >>>> +     if (fa->fsx_xflags & FS_XFLAG_PTIME) {
> > > >>>> +             ni->i_crtime.tv_sec =3D fa->fsx_ptime.tv_sec;
> > > >>>> +             ni->i_crtime.tv_nsec =3D fa->fsx_ptime.tv_nsec;
> > > >>>> +     }
> > > >>>> +
> > > >>>>      inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
> > > >>>>
> > > >>>>      /* Save nodump flag to return in ntfs_getattr. */
> > > >>>> @@ -275,8 +284,9 @@ int ntfs_getattr(const struct mnt_idmap *idm=
ap, const struct path *path,
> > > >>>>      if (unlikely(is_bad_ni(ni)))
> > > >>>>              return -EINVAL;
> > > >>>>
> > > >>>> -     stat->result_mask |=3D STATX_BTIME;
> > > >>>> +     stat->result_mask |=3D (STATX_BTIME | STATX_PTIME);
> > > >>>>      stat->btime =3D ni->i_crtime;
> > > >>>> +     stat->ptime =3D ni->i_crtime;
> > > >>>
> > > >>> For me this patch looks dangerous. Somehow I would expect that th=
e
> > > >>> "btime" will never change for existing inode.
> > > >>>
> > > >>> But because the ptime is mapped to i_crtime and ptime is settable=
 from
> > > >>> userspace, with this patch it is directly possible to change btim=
e.
> > > >>>
> > > >>>
> > > >>>
> > > >>> I was thinking more about it... Is not this just misunderstanding=
 of how
> > > >>> the security model around the times is working on different syste=
ms?
> > > >>> Because on NTFS there is stored just one field which says when th=
e file
> > > >>> was created. There are not two fields like "time set by user and =
time
> > > >>> set by system".
> > > >>>
> > > >>> Windows security model allows anybody with WRITE_ATTRIBUTES acces=
s to
> > > >>> change that create time. Linux security model does not allow to c=
hange it.
> > > >>>
> > > >>> NTFS in this view is just a filesystem like any other (ext4, btrf=
s, ...).
> > > >>> In my opinion if the ext4 or btrfs filesystem is correctly implem=
ented
> > > >>> on Windows systems, then Windows security model should handle it =
in the
> > > >>> same way like for NTFS or exFAT. So if something grants WRITE_ATT=
RIBUTES
> > > >>> access, then Windows should allow to change also btime on ext4 or=
 btrfs.
> > > >>>
> > > >>>
> > > >>>
> > > >>> On the other hand, I understand the use case to have two creation=
 times.
> > > >>> One time which would never be changed and could be used for any k=
ind of
> > > >>> atomic / synchronization by userspace application logic (this bti=
me).
> > > >>> And another time for human which can be changed at any time to an=
y value
> > > >>> which user wants (this ptime).
> > > >>>
> > > >>> In any case, I would suggest that filesystem driver would not rep=
ort to
> > > >>> userspace unsupported values and would not try to invent other va=
lues
> > > >>> and lying about them.
> > > >>
> > > >> But all those fs with mutable creation time already report it with=
 STATX_BTIME
> > > >> so what can we do about this?
> > > >
> > > > Well, what I wanted above to point out is that the "mutability" of
> > > > creation time is not feature of filesystem, but in my opinion rathe=
r
> > > > property of the security model on the running operating system.
> > > >
> > > > Maybe better question is: how ext4 btimes differs from the ntfs bti=
me?
> > > > In my opinion there is no much difference, both of them has meaning
> > > > "time when was the file created".
> > > >
> > > >> If userspace requests both STATX_BTIME|STATX_PTIME in mask arg,
> > > >> those fs could technically return only STATX_PTIME and it should n=
ot regress
> > > >> existing programs.
> > > >>
> > > >> But this is still a bit surprising behavior is it not?
> > > >>
> > > >> Thanks,
> > > >> Amir.
> > > >
> > > > I'm not sure what to do with it.
> > > >
> > > > If we allow to change btime of ntfs then for consistency we should =
also
> > > > allow to change btime of ext4.
> > > >
> > > > Maybe another idea... define new capability which would allow to ch=
ange
> > > > btime (on any filesystem)? This would at least make the consistency=
.
> >
> > Pali, I think this is a very bad idea.
>
> Ok, if the point is that ext4 btime must stay immutable then it is a bad =
idea.
>
> > This has nothing to do with capabilities.
> > The Windows and MacOS filesystems have allowed setting their
> > "creation time" forever
>
> FreeBSD for some fs allow it too (see below).
>
> > and for all the other Linux filesystems that had
> > "birth time" it was immutable, so let's not mix filesystem features
> > with capabilities.
>
> I think that it is important to first define behavior and invariants of
> these "btime" and "ptime" kernel properties.
>
> If we want to be consistent then there are two possible options:
>
> 1. If we choose that the STATX_BTIME is immutable then no kernel fs
>    driver should allow to change.
>
> 2. If we choose that the "NTFS create time" is reported via STATX_BTIME
>    then STATX_BTIME is not immutable at all.
>
> These two options cannot be chosen together because option 1 would
> implie that the modifiable "NTFS create time" cannot be reported over
> STATX_BTIME.
>
> We are have currently STATX_BTIME immutable and "NTFS create time"
> reported via STATX_BTIME.
>
> If we want to stay _consistent_ across fs drivers then adding API for
> changing "NTFS create time" would break one of those two things.
>
> In my opinion we should stay consistent across filesystem drivers and
> provide unified behavior of APIs independently of used filesystem.
> Otherwise userspace applications would have to write fs specific code
> for doing their use cases (and we can stay with fs-specific xattrs, no
> need to create unified APIs).
>
> Does it make sense? Or it is still a bad idea to think about it in this w=
ay?
>

My "bad idea" comment was only referring to capability.

w.r.t the STATX_BTIME ambiguity there is another option we may want to
consider: Don't publish STATX_PTIME via statx() at all.

One of the reasons that developers have pointed to fileattr as the right AP=
I
to host the creation time as well as the DOS attributes is that it has a hi=
story
of carrying filesystem specific attributes.

Not every attribute available in lsattr is also available in statx().
If projid is not available in statx() then the settable creation time
doesn't need to be in statx() either.

The file_[sg]etattr() syscalls provides a symmetric API to set/get it.

The same could be true to HIDDEN/ARCHIVE/SYSTEM flags if those
are added to fileattr.

Do we need to stop publishing NTFS creation time in STATX_BTIME?
I think it's too late for that and nobody is going to gain anything
from doing that.

Thanks,
Amir.
