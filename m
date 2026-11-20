Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183979;
	b=qweFaWuMK+7kxmqP9gQLzl2+1VAuYPHtNv9kohF/J+rlPGihsOTRhsLnOUYB/dNcxoXK
	 QqMdOeVVi4CGL3rs4KpoQ1FfLF9puUDv0UAs1HXv0XS0uXaAvTenPVKozJJhYux5iRx0K
	 J6giFVCOLNkGrwwaXwkCQBd9EH31wFLXlNeiR+KtDZ3fsZFrk/U5uqeA3pbH0Zes7VVmh
	 bASYHNpPgvNwm/Mz3Xe4w/Zsu/KsmuUzEH3vqqbSKrnbv+yWcE126j0VhMHEnR9f/KgVH
	 837pwHNAxtebX4VYHPWHmnZlFqyPdN+U+ibejmPahAQW8B6kQDNG+1sluf95Z4uOaAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=ob1FlA4nHTyzVacAeo+PvFthXWjQDamhK5368LJKCsA=;
	b=s08vlPZQ1NReQn3l6wWQmYt7YIkgFfssVlvvccfDDBGeAEc/GWCrUimejLKlLjRfUcMq
	 yWoOslDVW+7n7fWxFD0ee7RLFyHJWz36o1EVKp0IO8lb8yGNMyyQN209jQKsnhxKKTaKz
	 Zyy/p+TyL7SyvnMbIOpCEAgDt73nArApZNjfFPukkWBToAJMmhCtZVhSB0+vSUdEfbrqm
	 GCTJ7YO2xurooDElFrmA++Eku8mAXWTAclG14GPvmXAf/j+IJqkNu4X6BJVOlPUzD7x6X
	 1A0gMfRg4MJihqFbEZrTcYGhrSqykFFBdeUCuzpnQ7XowQwoOv4RNv4f+qW64GVOtHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rbdeZn9I;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF4660A2603
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BF4660A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rbdeZn9I
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso806896f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795183978; x=1795788778; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ob1FlA4nHTyzVacAeo+PvFthXWjQDamhK5368LJKCsA=;
        b=rbdeZn9ILcLAYFNo6TnnJ/A/KWVu0+5+Msk52h1KKBNcteqyesyrPXI/akOkn7Y5nZ
         IJyrZg0HBWpxlikd55uohYATUxLodDwD7+b0Es+Sv1nPKJ9z0TnzqWj2CjA739oyp/6S
         YFXswRBrBr/Roowpp01nTbbkrenfbJmQnMPa7Wvw4iNxateK7/eiauenrJfEXM37DDZh
         JQQGJufT9v88mGvYant1EA3p1ELjXQH8dS6GrkmHhnTOb/00rX33bFSULeUgKsQShHVD
         y459Q8ZJz1MEcjiZvRKUq6FM655W5Trml3NMjWgRKIK/DU3HXLHP9kP7MoIvCkq7hyDx
         oZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183978; x=1795788778;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ob1FlA4nHTyzVacAeo+PvFthXWjQDamhK5368LJKCsA=;
        b=Qp5Da0cqwTexIdPyrcKLBGoUUnlMEQBZg2EYhxoOlUuLkmVRgzS1+ZTNvBBZA3KOKZ
         8V0UO7ER7VaiVs4NePeDLJWIX5DXmVv96Gd8uzAfMv2DznYPRC620VaHI3YJxNgu7zEw
         Lf5qILiiCaNJY62/IRgkCXq5G/d9oWB653TkbZ+YvR0ZfmXm21VV5DKtrJE2lImN7a5N
         a2ubkbt9/F+8CBVoGfHwSDnu6nV15ymo7szRCfsO51PLuvj4qrwca/qAD6yui7pp86Vd
         fS4ANXVmvu4PvSL3iZHG2BxoBLIssVkAUM+sKnpSehyBHC4ytMjX+SGBRA/TkogXVuyf
         Cibg==
X-Forwarded-Encrypted: i=1; AL+hErHXUJEljD8ffJBp3gQZddZYn5ikRtgYmCwaDgYPywpIC68bz9PqGeQevtUMtq6/gDxY23TRglEfXHDd7Hmb@vger.kernel.org
X-Gm-Message-State: APuU4Z+d0kMFyOxVpeGjQ1odeP0Hs4Ox0MRD4zvMci12f5E/otbnUQ81
	Blb+4pwfWOSzIeoXI/U+nLykyxPkjEDFXiWzDPQzK/rSSHOjD68Tz9NUwxr59+1B
X-Gm-Gg: AYBFou1PEm2HUwJ500QMf4x3Nmdx1mahg+w+f56pbNOqZYQBdPoX80dt9N8zjgGKJct
	XvnKoZt5VAg6Yw/8IO+Dhury2sJsXt3D8SX7DAjkDFf3w3C3HW2QQBPTUdMTncpTQblFq0nNKIr
	6MUE8omCaLhgnvQIQ70JiNnrDClSDihJgZ7gAHaBvCizaXkdg6yNzFmTlJUh01LNzt3n0houX10
	sShoeLcqTMnHozXp9YMJ5DNXXz5gPnHfu/dM3lAkcmiOUBcgmESSHM8mu5ARLd/Z6N8yR4SviMA
	5i1nrlLSFVHz9e9BrOfTnlcM8CI641UwLbfBwaDz4GAZ31srH0Lu1tiSytGfy2SAQJOk3QTm1F5
	buJSoZezWZl4Uw8LrsK1+TCFKU0sM+PEy6uNJCoLetXTTI2xl48NZAN8zmeAbnx3hh8xh3tSoli
	FneL7Trrkv6y4Se79JM/uM64IL+jGuTt0ScuPTnixt46JJ89HnFxRiEET+4p+vYyVwsnfEGE79k
	/+SBR4Qt2BHQCQ8ZN6IouS02ZJaPeY6S0zSEzT3QBEMZ2dBRGzUbOptC8E6wImJ8lsrvJlxMPrC
	hU2ay9Tub9o6NhH4Vor/S0Jb+l5grEO7n7dLBPB4Rz6KGcb8
X-Received: by 2002:a05:600c:3d05:b0:4b8:d17e:da27 with SMTP id 5b1f17b1804b1-4bb88930872mr78210085e9.27.1795183977527;
        Fri, 20 Nov 2026 06:12:57 -0800 (PST)
Received: from localhost ([130.192.98.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm189744955e9.4.2026.11.20.06.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 06:12:55 -0800 (PST)
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
 boundary=1c0f90a8e81abc35d40b9da9afa2a275d20c96cec9fed1a0bbc0e0120237;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 20 Nov 2026 15:12:54 +0100
Message-Id: <DN03LWNSDYP5.11FTQ5KCWU2X7@gmail.com>
Cc: "Lauri Gates" <lauri.gates@gmail.com>, "Dave Chinner" <dgc@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Christoph Hellwig"
 <hch@infradead.org>, <linux-xfs@vger.kernel.org>, "Carlos Maiolino"
 <cem@kernel.org>, "Christian Brauner" <christian@brauner.io>, "Darrick J.
 Wong" <djwong@kernel.org>, <linux-api@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
 <ocfs2-devel@lists.linux.dev>, <linux-nfs@vger.kernel.org>,
 <linux-cifs@vger.kernel.org>, "Theodore Tso" <tytso@mit.edu>
Subject: Re: Concurrent FIEMAP on reflinked files serialises on the AGF
 buffer lock
From: "koraynilay" <koray.fra@gmail.com>
To: "Amir Goldstein" <amir73il@gmail.com>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <av4Hn9u80fs8iHZ6@dread>
 <20261119095943.85048-1-lauri.gates@gmail.com>
 <DMZ4VQ7SZ07T.29WMPQ0BQZGSS@gmail.com>
 <CAOQ4uximow25oc=3XEN1ATgQvonQaTXtDPmQufxo75tJ=e355A@mail.gmail.com>
 <DMZJDGMJ1RVF.32ES391JKNFGP@gmail.com>
 <CAOQ4uxjVQ9cjV=_jBjQtNg9zCuWUEJT9KNYMKV+1jwBkHen5OA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjVQ9cjV=_jBjQtNg9zCuWUEJT9KNYMKV+1jwBkHen5OA@mail.gmail.com>

--1c0f90a8e81abc35d40b9da9afa2a275d20c96cec9fed1a0bbc0e0120237
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Nov 20, 2026 at 6:52 AM CET, Amir Goldstein wrote:
> On Thu, Nov 19, 2026 at 11:21=E2=80=AFPM koraynilay <koray.fra@gmail.com>=
 wrote:
>>
>> On Thu Nov 19, 2026 at 6:04 PM CET, Amir Goldstein wrote:
>> > On Thu, Nov 19, 2026 at 12:00=E2=80=AFPM koraynilay <koray.fra@gmail.c=
om> wrote:
>> >>
>> >> On Thu Nov 19, 2026 at 10:59 AM CET, Lauri Gates wrote:
>> >> > On Wed, Nov 18, 2026 at 10:16PM +0200, Dave Chinner wrote:
>> >> >> I really don't care if it is exposed by statx or file_attr; checki=
ng
>> >> >> the flag through either interface will be orders of magnitude fast=
er
>> >> >> than using FIEMAP to iterate extents on every file to find shared
>> >> >> extents. My concern with statx is coherency - it runs completely
>> >> >> unlocked and so can race with operations that add/remove the refli=
nk
>> >> >> flag...
>> >> >
>> >> > Thanks, Dave and Christian. Given Christian's preference and the
>> >> > coherency point, I'll write the RFC against file_attr, once the
>> >> > question at the end is settled. xfs_fileattr_get() already reads th=
e
>> >> > flags under XFS_ILOCK_SHARED, so the new flag gets that without ext=
ra
>> >> > work. The answer can still go stale right after the call, as with a=
ny
>> >> > stat result: a clone that lands after the read is missed, just as o=
ne
>> >> > that lands after FIEMAP returns is missed today.
>> >> >
>> >> > As I suggested on the 6th, the flag would take the inverted meaning=
,
>> >> > so that an unset flag stays the safe answer: say FS_XFLAG_NOSHARED
>> >> > ("no extents shared with another file"), read-only, in
>> >> > FS_XFLAG_RDONLY_MASK next to the case-folding flags.
>> >>
>> >> Hello, I don't have any say in the FIEMAP issue, but I wanted to let =
you
>> >> know that, since also a mask was mentioned and your patch would be
>> >> touching the fileattr API, there is work going[1] on for adding a
>> >> fsx_xflags_mask that filesystem use[2][3] to advertise supported flag=
s (on
>> >> get, like stx_attributes_mask) and users use to say what they want to
>> >> change (on set).
>> >> It doesn't seem like an FS_XFLAG_NOSHARED flag would touch this new
>> >> change, but I thought it was worth pointing out, especially because t=
his
>> >> patch would also add FS_XFLAG_PROJID and a new FS_FILE_ATTR_XFLAGS_MA=
SK
>> >> to have a way to include both legacy and newly added xflags, so
>> >> FS_XFLAG_NOSHARED would maybe also go there (correct me if I'm wrong)=
.
>> >>
>> >> > Christian, one question on the shape within file_attr: would you ta=
ke
>> >> > the inverted flag, or would you rather keep a plain "may share" fla=
g
>> >> > and add a mask to struct file_attr that says which xflags the
>> >> > filesystem reports?
>> >>
>> >> And if Christian chooses the mask approach, then my patch[4] becomes
>> >> relevant.
>> >> (in [4] I put the patch that will be sent in v5 of [1], since in [1]
>> >> it's merged with the ptime change)
>> >>
>> >> (For Amir who I just CC'd, [5] is the main link for this thread)
>> >
>> > Thanks for the CC and the link
>> >
>> >>
>> >> Thanks,
>> >> koraynilay
>> >>
>> >> [1]: https://lore.kernel.org/all/20261115180343.576773-1-koray.fra@gm=
ail.com/T/#u
>> >> [2]: https://lore.kernel.org/all/CAOQ4uxj82K4z+2OiY5W1g7NyWAFOFjqqWnZ=
SS3prytW36j1LgA@mail.gmail.com/
>> >> [3]: https://lore.kernel.org/all/CAOQ4uxiuJ=3DeZu28FZAUz3rpqPKqCimPxJ=
ucOnYYuBowvD09_Cw@mail.gmail.com/
>> >> [5]: https://lore.kernel.org/linux-xfs/20261102193533.93690-1-lauri.g=
ates@gmail.com/T/#u
>> >>
>> >> [4]:
>> >> commit 0efe0de3b5cc2b767aa6e2bb9174eb05b0d818f1
>> >> Author: koraynilay <koray.fra@gmail.com>
>> >> Date:   Tue Nov 17 14:57:47 2026 +0100
>> >>
>> >>     vfs: add xflags mask to file_attr API
>> >>
>> >>     Add fa_xflags_mask to struct file_attr and equivalent fsx_xflags_=
mask
>> >>     to struct file_kattr.
>> >>
>> >>     This lets filesystems advertise their support for specific xflags=
 and
>> >>     users specify only what they want to change, behaving like
>> >>     statx.stx_attributes_mask:
>> >>     - on GET (file_getattr): each filesystem fills the mask according=
 to
>> >>       its supported xflags, e.g. FS_XFLAG_COWEXTSIZE or FS_XFLAG_EXTS=
IZE,
>> >>       and provides the values in the corresponding struct fields;
>> >>     - on SET (file_setattr): userspace fills the mask according to wh=
ich
>> >>       xflags it wants to change, VFS validates this and preserves xfl=
ags
>> >>       that were not specified in the mask;
>> >>     - if xflags_mask =3D=3D 0, use legacy full-struct replacement to =
keep
>> >>       compatibility with older programs.
>> >>
>> >>     Furthermore, add the missing FS_XFLAG_PROJID flag, to allow users=
pace to
>> >>     set the projid using file_[sg]etattr().
>> >
>> > Correction. usersapce can already set projid using file_[sg]etattr().
>> > With FS_XFLAG_PROJID in fsx_xflags_mask, chattr -p <projid>
>> > could set the projid without having to read and set all the other xfla=
gs.
>>
>> Oh right, thanks, I'll fix it.
>>
>> >>
>> >>     Finally, in order to prevent the legacy FS_IOC_FSSETXATTR from ac=
cepting
>> >>     FS_XFLAG_PROJID, add an FS_FILE_ATTR_XFLAGS_MASK to support new x=
flags
>> >>     and use it in fileattr_to_file_attr()/file_attr_to_fileattr() to
>> >>     validate that the xflags passed in fa_xflags and fa_xflags_mask f=
ields
>> >>     are valid.
>> >>
>> >>     Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.7
>> >>     Signed-off-by: koraynilay <koray.fra@gmail.com>
>> >> ---
>> >>  fs/file_attr.c           | 46 ++++++++++++++++++++++++++++++++++++++=
++++----
>> >>  include/linux/fileattr.h |  5 +++++
>> >>  include/uapi/linux/fs.h  |  3 +++
>> >>  3 files changed, 50 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/fs/file_attr.c b/fs/file_attr.c
>> >> index 833e03810b24..56ea65f790f1 100644
>> >> --- a/fs/file_attr.c
>> >> +++ b/fs/file_attr.c
>> >> @@ -102,10 +102,18 @@ EXPORT_SYMBOL(vfs_fileattr_get);
>> >>  static void fileattr_to_file_attr(const struct file_kattr *fa,
>> >>                                   struct file_attr *fattr)
>> >>  {
>> >> -       __u32 mask =3D FS_XFLAGS_MASK;
>> >> +       /*
>> >> +        * fsx_xflags_mask contains only flags added after the
>> >> +        * file_[gs]etattr() API, so we need to tell userspace the fi=
lesystem
>> >> +        * actually supports all legacy (FS_XFLAGS_MASK and FS_XFLAG_=
PROJID,
>> >> +        * which lacked its own bit) and new advertised flags.
>> >> +        */
>> >> +       __u32 mask =3D (FS_XFLAGS_MASK | FS_XFLAG_PROJID | fa->fsx_xf=
lags_mask) &
>> >> +                    FS_FILE_ATTR_XFLAGS_MASK;
>> >
>> > This is not exactly how I envisioned exporting fa_xflags_mask.
>>
>> This is exactly why I CC'd you :D
>>
>> > fa_xflags_mask =3D=3D 0 means old kernel or unmodified fs.
>> >
>> > For a new kernel with fs that supports flags other than
>> > FS_XFLAGS_MASK it's the fs responsibility to advertise its supported
>> > flags.
>> >
>> > Something like:
>> >
>> >      __u32 mask =3D (fa->fsx_xflags_mask ?: FS_XFLAGS_MASK) &
>> >                               FS_FILE_ATTR_XFLAGS_MASK;
>> >
>> >      memset(fattr, 0, sizeof(struct file_attr));
>> (I'm sorry, but why memset if we assign the fields right after?)
>> >      fattr->fa_xflags =3D fa->fsx_xflags & mask;
>> >      fattr->fa_xflags_mask =3D fa->fsx_xflags_mask ? mask : 0;
>> >
>> > Then you can add filesystems that support get/set of new
>> > attributes without support for legacy attributes.
>> >
>> > And specific filesytems could opt-into the set of an individual
>> > attribute like projid by advertising
>> > fa->fsx_xflags_mask =3D FS_XFLAGS_MASK | FS_XFLAG_PROJID
>> > or a subset thereof.
>>
>> I agree, this is definitely better.
>>
>> > And I am still on the fence wrt should API also advertise the
>> > fsx_xflags_ro_mask in addition to the supported mask.
>> >
>> > The advantage being that it makes the interface symmetric.
>> > User can alway setattr() with the buffer they got from getattr()
>> > and instead of randomly ignoring flags in set, the fsx_ro_mask
>> > along with fsx_mask defines the behavior exactly.
>>
>> Hmm, so ro_mask would be ignored by vfs on set so users don't have to
>> manually remove the read only flags, correct?
>>
>
> Correct.

Ok.

> With non-zero xflags_mask, internal contact masks
> can be used for -EINVAL not for silent ignoring.

What do you mean by "internal contact masks"?

>> Also I think I'll try writing some basic userspace programs that use
>> this API and see how I'd expect it to be.
>>
>
> Don't write programs please contribute to chattr (e2fsprogs) and
> xfs_io (xfsprogs). The latter already support the new syscalls, the
> former not yet.

Oh no, I didn't mean full fledged programs, just simple struct ->
syscall like the set_ptime[1] I've been using for testing.

>>
>> Anyway, I think it would be better to split the _mask change into its
>> own separate patch series, so it can more easily be used by this shared
>> extent patch and it's easier to reason about the API when it's
>> disconnected from the ptime/btime change.
>
> Agree.

Nice.

Thanks,
koraynilay

> Thanks,
> Amir.

[1]:

#include "include/uapi/linux/fs.h"

int main(int argc, char *argv[]) {
	char *path =3D argv[1];
	long long sec =3D atoll(argv[2]);
	long long nsec =3D atoll(argv[3]);
	struct file_attr fa =3D {
		.fa_xflags =3D FS_XFLAG_PTIME,
		.fa_xflags_mask =3D FS_XFLAG_PTIME,
		.fa_ptime_sec =3D sec,
		.fa_ptime_nsec =3D nsec,
	};

	return syscall(__NR_file_setattr, AT_FDCWD, path, &fa, sizeof(fa), AT_SYML=
INK_NOFOLLOW);
}

--1c0f90a8e81abc35d40b9da9afa2a275d20c96cec9fed1a0bbc0e0120237
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCawBVZgAKCRA0bnTtJTDo
OMQNAP9TcBGO7jcWF1/PpewpEzZJSL/5N2sNKL8LH7OSI8wxDwD8Cp4yvccYDNFU
CFFrvp1gJzGGHbalK20JCnIW5/YPGQ0=
=XOHR
-----END PGP SIGNATURE-----

--1c0f90a8e81abc35d40b9da9afa2a275d20c96cec9fed1a0bbc0e0120237--
