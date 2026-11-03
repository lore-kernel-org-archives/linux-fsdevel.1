Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726874;
	b=k4r1tBvzrPeH9VBNMw9DEac8uqttMi/M9VF2EF7YuGPNJVUaoBXcOjuvkTS86HRdpgPJ
	 S65o09iErFKjkvGzPl05/wBVCRo1bOZOW+ulgYGrGF4EIXGvq4TiQrWEzfsOJc/5H3vXt
	 bQMya663FohLMP6+vVekLb66d90TB6ZUe0IVQ7jb4Z4jqC5gbDzhkdv0Oixqu3c99F3G4
	 vlJcjNmy89oZwq7+CD4dqy3HR9aphFxrx6x6yMAzXrHh/gxi+Farskdv2AjL79bttaoPn
	 IJAUXNcVm25hp+awhjguKkz4fx4XjgVfx3HQMadExxI/wSeYcTR8H0koQj5wNYk09VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=C7J2xwMhxMcLYQn+HgHArsLVIUvcNtC3sZDiMzWGQG0=;
	b=vUKrAYvze6o2gHGE8Vo+3Cnb+qOKD3B3uqibvanq4KjqaqV1TsXjfhVWdtpM7KzoAbiC
	 kEWVrBvUUu8GWbUE9Dy8d79b1hKtIpAfsXEeSeSqflBLopQYp+3E1OHvGasb1PUazxIHF
	 MHEtbsLvX0mbxEPcXf/ruQE5Ut5A/dOcNkL4rxC//solPEYI+VgAn1uuF1IlwlY9chwDc
	 NFengqThlLPnbJUh0QCPpjub4Z3ARGNwkMJemEgdbbk8b7vb05X1cj9rxvgpeGhuenUtD
	 KxyQ7Lc223ZP63PiG5Mzgz4n2fz9ZgZrcxRteP1Tb0Sbdp025KgfNDavcmLxTyEYldg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qvfk2p2C;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C833D606A32D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 17:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C833D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qvfk2p2C
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e4831c028so3912014f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 09:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793726872; x=1794331672; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C7J2xwMhxMcLYQn+HgHArsLVIUvcNtC3sZDiMzWGQG0=;
        b=qvfk2p2C7RCe841ado8qfFCS9EjFtuex2WDROo9E1Fc+ZhltsWR8vV/rOq8z5I/k57
         i3OGX0Wr2HUlX5zo0HJCLZs28lP+10Fth3SFAs8j1PknAVLmwsILnXxT75hbwpoj3mJz
         IYCPW01qa04mTijdJ4QJYJANkJ9seTSqhbYnwcHcZ35YfNGTk7XzMa2YjOrSZQ68spD9
         +s8BYOoXJ+NdDhKHpkfxestZlteDvW1FVKYgK0L1ajglWzOoUcwAHlqS3XXE88Sz26Ne
         kKl3qzhacnH2H3er+WMxxp5rl8vZTDFab0IITU4dQil1PxAIXbLjlf2wr0tvFf9Wb6BA
         vszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793726872; x=1794331672;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C7J2xwMhxMcLYQn+HgHArsLVIUvcNtC3sZDiMzWGQG0=;
        b=T70gRQWD45cIT2iWFVw+G+xCG8pHqr2ks9W/6aOvubCW1LWtGXZBMAwaRUJc8/iG6e
         ayQS4QZ4dkfKEq5h5Har70cpLgPFsQHGC+DSIBpbWk+fMFj992eZwpatA+0dk8kXCxi9
         mal8JQu05f03Nw3E5+0VpYSOd8pLh5I/KDfic2CILtHqT23NDccYckdSPOaVyI5R2vTU
         ZnbmApWmRhinfXSs3a01AnYXqPFLChdert/FdOPL7NEXyr1OVo8ZLTkaLLpbp6QoXEMW
         ggZmciZkZjcNPxGCOSFGK40LfgrppzK7WMsBluZhA7edgFfysgrtQe3ILXTz9aVM+7eX
         QCbw==
X-Forwarded-Encrypted: i=1; AKwUvBwGM/Q6XTuO5V+caqNj9XWc9sV2PVmF+UYFeucGouIDxJ9AaOuijtnCyn9AjeWvbBeWwNbntBvdfwTaSzTJ@vger.kernel.org
X-Gm-Message-State: APuU4Z+8cYH27Z990A5GQ5TWptunow+CzxxiENqbTISKZf3rIoEszK09
	ztINNCV7NZ6jenZzdvEqQ2eUUkQUugmpH8CLm/lLWasG9YURqWK60npj
X-Gm-Gg: AYBFou15cNlCiTzdTUiBjxYs3lU/tY162PCesA4/pA4rSL7f1++aGrTQ02l6bTr1IAm
	urmzzLrdqJ2tJeYccW7+gQAP+w+mpKGRE7cgfCnyJWjXJ/6UO34V4r4mOBVqwnfj6d5GB1Ac8eQ
	yP2Gua/QewXdrx+N0qtstjGX0HCTTgmKWambmVTiwlkIkME8cRkqyh0mEUt8R5YPSeD8qG0BA76
	ImS8GiNzLsNVAYEKoQmti6Ctu//x/RGSMBpQYLcQfKqBw3WYxz0ilQzVAqC2hTpc4wVP7v6j2Xo
	kg0YqQjftLuDdQCfp2xzTQIZOaDjbAYPlLZ2VBUs4J8bnVV0UbHZc87x2vzUxG5gVR0n0IVDrh2
	nFNdiu0VzjECXLa0PIPEHfhv57nvGGYhbOz6q/4NlXTVqsH27+z16tChz+8CfeJ8/KPkHw2a/LY
	YKtnHrsf0CNQGBYwywPZ3hbLPcBtTLrlObEvKa4nkIPjNbIQSR4CF5R3XcncLZhPNLpuTUSUyQg
	El8678bOzYTPTMyBW3vQWJ3bio9Wo7FKMNJOxxaXPDHnOXdw2UO7Cw9CRTd4GSjV7n6JUNyAoEd
	BZzG/FyEHIZAnbkRf4N991cyys8eaTngdhsKlwmy5gRGag==
X-Received: by 2002:a05:6000:26c8:b0:48e:10a7:40f with SMTP id ffacd0b85a97d-48e6e302612mr29233891f8f.17.1793726872045;
        Tue, 03 Nov 2026 09:27:52 -0800 (PST)
Received: from localhost ([151.60.201.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b728ddsm25764477f8f.9.2026.11.03.09.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:27:50 -0800 (PST)
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
 boundary=7bf7be77af3bb2ca970a31782cf12336c55eb4edcc365a7f2b8809684642;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 03 Nov 2026 18:27:48 +0100
Message-Id: <DMLR3VF6HEMW.34XWXBBJLV9A3@gmail.com>
Cc: "David Sterba" <dsterba@suse.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Sungjong Seo"
 <sj1557.seo@samsung.com>, "Konstantin Komarov"
 <almaz.alexandrovich@paragon-software.com>, "Chris Mason"
 <mason@kernel.org>, "Jan Kara" <jack@suse.cz>, "Yuezhang Mo"
 <yuezhang.mo@sony.com>, "Chuck Lever" <cel@kernel.org>, "Darrick J . Wong"
 <djwong@kernel.org>, "Sean Smith" <defendthedisabled@gmail.com>, "Andrey
 Albershteyn" <aalbersh@kernel.org>, "Pedro Falcato" <pfalcato@suse.de>,
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 <linux-btrfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <exfat@lists.linux.dev>,
 <ntfs3@lists.linux.dev>, <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v3 1/5] vfs: add provenance time (ptime)
From: "koraynilay" <koray.fra@gmail.com>
To: "Amir Goldstein" <amir73il@gmail.com>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261101015551.786044-1-koray.fra@gmail.com>
 <20261101015551.786044-2-koray.fra@gmail.com>
 <CAOQ4uxiuJ=eZu28FZAUz3rpqPKqCimPxJucOnYYuBowvD09_Cw@mail.gmail.com>
 <DMLJ5DR2A4KZ.28U8XSZ0KFJTG@gmail.com>
 <CAOQ4uxiTS-QT7y1avNSasJSffkt2uRNkdrb2_GrK7kJ82-MoXw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiTS-QT7y1avNSasJSffkt2uRNkdrb2_GrK7kJ82-MoXw@mail.gmail.com>

--7bf7be77af3bb2ca970a31782cf12336c55eb4edcc365a7f2b8809684642
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Nov 3, 2026 at 4:14 PM CET, Amir Goldstein wrote:
> On Tue, Nov 3, 2026 at 12:13=E2=80=AFPM koraynilay <koray.fra@gmail.com> =
wrote:
>>
>> On Mon Nov 2, 2026 at 3:00 PM CET, Amir Goldstein wrote:
>> > On Sun, Nov 1, 2026 at 2:57=E2=80=AFAM koraynilay <koray.fra@gmail.com=
> wrote:
>> >>
>> >> Add provenance time (ptime), indicating the time when a file or
>> >> directory was created. This is user-settable via file_setattr() and
>> >> retrievable via statx(2) (using STATX_PTIME) or file_getattr().
>> >>
>> >> The semantics of when to preserve this new timestamp are the same as
>> >> mtime, the idea being that there is a correspondence like this:
>> >>
>> >> ctime <-> btime
>> >> mtime <-> ptime
>> >>
>> >> so every operation (copying, moving, ...) that currently preserves mt=
ime
>> >> should also preserve ptime.
>> >>
>> >> Furthermore, in order to avoid the legacy FS_IOC_FSSETXATTR accepting
>> >> FS_XFLAG_PTIME, add an FS_FILE_ATTR_XFLAGS_MASK mask to support new
>> >> xflags, and use it in fileattr_to_file_attr()/file_attr_to_fileattr()=
 to
>> >> allow ptime to be used with the file_setattr()/file_getattr() syscall=
s.
>> >>
>> >> [ This is a re-implementation of the initial patch[1] by Sean Smith
>> >>   <defendthedisabled@gmail.com>, following the advice[2] from Darrick=
 J.
>> >>   Wong <djwong@kernel.org> of using file_setattr() instead of updatin=
g
>> >>   utimensat() ]
>> >>
>> >> [1]: https://lore.kernel.org/20260405195007.1306-2-DefendTheDisabled@=
gmail.com
>> >> [2]: https://lore.kernel.org/20260407014129.GC6192@frogsfrogsfrogs
>> >>
>> >> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
>> >> Signed-off-by: koraynilay <koray.fra@gmail.com>
>> >> ---
>> >>  fs/file_attr.c            | 33 +++++++++++++++++++++++++++++++--
>> >>  fs/stat.c                 |  2 ++
>> >>  include/linux/fileattr.h  |  5 +++++
>> >>  include/linux/stat.h      |  1 +
>> >>  include/uapi/linux/fs.h   |  8 +++++++-
>> >>  include/uapi/linux/stat.h |  7 ++++++-
>> >>  6 files changed, 52 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/fs/file_attr.c b/fs/file_attr.c
>> >> index 833e03810b24..c0645cb22bf3 100644
>> >> --- a/fs/file_attr.c
>> >> +++ b/fs/file_attr.c
>> >> @@ -102,7 +102,7 @@ EXPORT_SYMBOL(vfs_fileattr_get);
>> >>  static void fileattr_to_file_attr(const struct file_kattr *fa,
>> >>                                   struct file_attr *fattr)
>> >>  {
>> >> -       __u32 mask =3D FS_XFLAGS_MASK;
>> >> +       __u32 mask =3D FS_FILE_ATTR_XFLAGS_MASK;
>> >>
>> >>         memset(fattr, 0, sizeof(struct file_attr));
>> >>         fattr->fa_xflags =3D fa->fsx_xflags & mask;
>> >> @@ -110,6 +110,8 @@ static void fileattr_to_file_attr(const struct fi=
le_kattr *fa,
>> >>         fattr->fa_nextents =3D fa->fsx_nextents;
>> >>         fattr->fa_projid =3D fa->fsx_projid;
>> >>         fattr->fa_cowextsize =3D fa->fsx_cowextsize;
>> >> +       fattr->fa_ptime_sec =3D fa->fsx_ptime.tv_sec;
>> >> +       fattr->fa_ptime_nsec =3D fa->fsx_ptime.tv_nsec;
>> >>  }
>> >>
>> >>  /**
>> >> @@ -141,15 +143,20 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
>> >>  static int file_attr_to_fileattr(const struct file_attr *fattr,
>> >>                                  struct file_kattr *fa)
>> >>  {
>> >> -       __u64 mask =3D FS_XFLAGS_MASK;
>> >> +       __u64 mask =3D FS_FILE_ATTR_XFLAGS_MASK;
>> >
>> > That is not the correct way to extend this API.
>> > This fixed mask was added as a placeholder for
>> > "We intend to add support for more xflags to selective filesystems":
>> > https://lore.kernel.org/linux-fsdevel/20250329143312.1350603-2-amir73i=
l@gmail.com/
>> >
>> > Please see this POC patch for filesystems to publish their supported
>> > xflags mask:
>> > https://lore.kernel.org/linux-fsdevel/20250329143312.1350603-3-amir73i=
l@gmail.com/
>>
>> Thanks, I did not think of adding a dynamic mask like that, I will look
>> into it and implement it for v4.
>>
>> > This will allow callers of file_getattr() to know if the filesystem
>> > supports ptime
>> > without trying to set it and failing.
>>
>> So after adding fsx_xflags_mask to file_kattr, every filesystem would
>> populate fsx_xflags_mask with all the returned (=3D=3D supported) FS_XFL=
AG_*
>> in their own specific .fileattr_get, correct?
>
> Not all filesystems. Just the ones that wish to extend the constant
> legacy FS_XFLAGS_MASK.
> So just the ones that you change to support XFLAGS_PTIME

Ah ok yeah that makes more sense, so like the fileattr_has_fsx_mask()
(that checks if fa has fsx, ignoring the suppored/allowed ones specified
as second arg) that I added, but in the opposite way: "I advertise only
the extra fsx (so only 0 or FS_XFLAG_PTIME rn) that I support".

Thanks,
koraynilay

> Thanks,
> Amir.



--7bf7be77af3bb2ca970a31782cf12336c55eb4edcc365a7f2b8809684642
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCauoZlAAKCRA0bnTtJTDo
OBnVAP9J2oe3Q/z4+CIvNcDvvOtFdyX98jyvuqmiHKySHzb6XAD+N8QVNASksB7a
or/C2uBDgyHnZr93FRknmz2MMzGnvwQ=
=0YAO
-----END PGP SIGNATURE-----

--7bf7be77af3bb2ca970a31782cf12336c55eb4edcc365a7f2b8809684642--
