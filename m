Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067486;
	b=xfUsSQW0CJTVpr9+xYtkc9oFTrfyYdY21nHkUDIuhqJEFreltSzRZWrftTxQ/fHKkdQv
	 FbENDGhj5blUuRjNfsbHZNtOSyw1JPQJIKJSlA05KwdfZ9RcAjQ6B4h0UlOH5GBsKVLT6
	 OHJpxT9yElHSxbUW8pzqF1rkMraWCruj/p0sIV0v5QmouTTf+w58XwP3cH5XBCjKOk6to
	 MkV+PA7RlWxqaYkb22Q3KXr0UxHWcx/JK8cH8yanawFKVqPBJJiY1rscFLtWq9vO94yEc
	 EuipLVzLLq8XKfiqkkKVSQr+aPPyix7V6IEjs4jL1rXzW7TEDn/VtQBTtxCY5ivfBPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=mqyQUben+O+C45t60kMw5HEu8sl3i3WUxLhAUPmitLU=;
	b=yMFzX+uTuHiWp85/lb+jzN9W/tUkva24n6JDefu0O1fZeLmRLg8Qm3YmI9fClmxdOkWa
	 RYCBx6Ieu9qo7BCUtq8Rutm7b0Cz3gNBY2IhcHiuPbQ6cv7qziLEWHlYw2A5IqEoGAd47
	 TBLhSbk7L/UlWaI8vJAbgi1C9dn7MEQ5Uq+gcE0fzUFjuOcMDP96TYZa+AoCAdub51E0x
	 /dYF0lsvEw6M7jhL8oMMGLtYlWi/2ay75WLUju5uss3uS6t9PeLhAD3wzuOnKnoZ4sy16
	 fOv/lzdqxSRHmH/tSnFufaz5744FRc1jWdyErxc0I6dJlLgGTtOOXGPl89zVRNSNrPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YZf/KkmS";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ABB606A32E
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 16:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0ABB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YZf/KkmS
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4b467581b98so12513455e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 08:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067484; x=1794672284; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mqyQUben+O+C45t60kMw5HEu8sl3i3WUxLhAUPmitLU=;
        b=YZf/KkmSteAYdRId8mTuuz8BJ1lU0kzsVdHhpcRnnR0CeeqnhipeaU0L73tQ+IUITO
         8rDliT1U67umS4LkrhAS6QvZRNETB8V8E0+ghQQMGGnWb7ijLmrOghJVu3Au2EJyWlaD
         bL838wdplSfs9kpxwI4OLCmteAeuCyxbjtrXDa45y5fGDpbrT0J/ZiRr09wnRdAyrfnX
         ucrIHuFRXb7KM1aXXTqeIZI7CAq8FX+g9KGH2PkSs2BUJsij5onOWbqKipq7Lm3Ax74C
         9wk/Bdgf6iNWumacZJlCrUdLplNGZe47u2FDr817cv97Y38mKuE1VNytKZy3KfaOFwgb
         YfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067484; x=1794672284;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mqyQUben+O+C45t60kMw5HEu8sl3i3WUxLhAUPmitLU=;
        b=wjHp6FS7KoMb0YNS+r6D/vrZP/41ZJ048e86qmFqBHCt1PF9BSX95c6mBtTAl3SadB
         50EO6OpwIAu0owuuThxg2Mz3hnjqqbzsy0Wd9CH1V8+NRWXemON48I4LD5m3P6o2Hkmj
         oRpNUxdMG/Gsv7dwLZttqkdgIOKx2ukIhzOwr1oe2G8w2zts0IiAZn2idfom/2xpdz7v
         80cGznr30+CVRah5azDOPv977y+Oapz6/xkXIZ5S7XUtZLUnRiJ2tAWZw2pGqZkfqYvf
         8Tus/PfLfMrcPHhW3VgQL9gXtVI8KFc8c2JfNnNyM2q0Pez+pqesDynCKkNtg4+h8ZU0
         kttA==
X-Forwarded-Encrypted: i=1; AKwUvBz1YRfkThTd6uGtZC/QIKL1XH5H+Ce5ds9KUemZHLNNphvUG7ePODJl5wWaeE73nw05hey4Wj3hh38jRF2n@vger.kernel.org
X-Gm-Message-State: APuU4Z+wfTWVjm4Os1Wu/KEi4uKJnQn19CaJ3I7YH0xuqLCyIVJ/6cnx
	4a2vmyDlcIhiR5S0a/Sqgp0DWhYjQwBx/0y9Fe771VCoDL3G2OaulXZJ
X-Gm-Gg: AYBFou1Dip3iuOTuq5rBJJHK9wORwfPgcH98HF3n2PLgP9lCDOOXWemaLeLflrPU9eq
	WlnlJfXXHf4l4+3BR7rYtWXMcn1UoLnuHxJyoQyjq+5FZkpOYluB2VnB9GJMgye1nXENUrxpRwc
	pZsFS6nUg2fTj7IVjvccHlUMRzTCikFLWVQwCDJXRybIOyjszbbiaB80dbOE1CZWXhbXgVttG45
	22REpRJA2foNCSUttm1KHfExLdfrm7Sa12vIljZ/tYbWQdJDJSMwONy+CQxLjAvHtX52mS8ETS8
	WuRN9lkLuvPKeaFBVhoVOOet2+Re6CLKcwrVDtFM46VDqoogeK92DhEFX+PIfU0kVbaKPW8aSvm
	c8We14pvjY1oRLSSpEPFdW1A1nALUpEIgdUJGMHOutw+A1oxaBG0UvH7LM3Ny7lmbhg4VFrKwGq
	kRi/60XkKUWZyu5yjUgd+Pxa0q7K82mkSnfSR9JwzlfiKoLxv+TFzF2wkRPgqG/3lYwIvmURp5k
	ek4YTlbBXK1aWZyHnRJ6IgtgoM1lulovHbCHgO9bdNl1yy4Pb4hRpyh7XSKTaowPCnt8kZjBSVX
	C1lx6W3eRbTFQLK3jR1KQi9LmbXxBkRR5A+jU6XhvB5/jYUb
X-Received: by 2002:a05:600c:3e8f:b0:4a5:87b3:ddc1 with SMTP id 5b1f17b1804b1-4b6de4a6ba1mr96406245e9.13.1794067483781;
        Sat, 07 Nov 2026 08:04:43 -0800 (PST)
Received: from localhost ([2001:b07:5d26:7a6a:de3b:51f3:e461:c0df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e327a652sm72731355e9.7.2026.11.07.08.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 08:04:42 -0800 (PST)
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
 boundary=95ab675be9d074487606c137f0b6646de41c65221c97957b70ca632d1c3b;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 07 Nov 2026 17:04:33 +0100
Message-Id: <DMP3UBB0QVOT.20HIXK7ZL6K6U@gmail.com>
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
In-Reply-To: <CAOQ4uxiuJ=eZu28FZAUz3rpqPKqCimPxJucOnYYuBowvD09_Cw@mail.gmail.com>

--95ab675be9d074487606c137f0b6646de41c65221c97957b70ca632d1c3b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 2, 2026 at 3:00 PM CET, Amir Goldstein wrote:
> On Sun, Nov 1, 2026 at 2:57=E2=80=AFAM koraynilay <koray.fra@gmail.com> w=
rote:
>>
>> Add provenance time (ptime), indicating the time when a file or
>> directory was created. This is user-settable via file_setattr() and
>> retrievable via statx(2) (using STATX_PTIME) or file_getattr().
>>
>> The semantics of when to preserve this new timestamp are the same as
>> mtime, the idea being that there is a correspondence like this:
>>
>> ctime <-> btime
>> mtime <-> ptime
>>
>> so every operation (copying, moving, ...) that currently preserves mtime
>> should also preserve ptime.
>>
>> Furthermore, in order to avoid the legacy FS_IOC_FSSETXATTR accepting
>> FS_XFLAG_PTIME, add an FS_FILE_ATTR_XFLAGS_MASK mask to support new
>> xflags, and use it in fileattr_to_file_attr()/file_attr_to_fileattr() to
>> allow ptime to be used with the file_setattr()/file_getattr() syscalls.
>>
>> [ This is a re-implementation of the initial patch[1] by Sean Smith
>>   <defendthedisabled@gmail.com>, following the advice[2] from Darrick J.
>>   Wong <djwong@kernel.org> of using file_setattr() instead of updating
>>   utimensat() ]
>>
>> [1]: https://lore.kernel.org/20260405195007.1306-2-DefendTheDisabled@gma=
il.com
>> [2]: https://lore.kernel.org/20260407014129.GC6192@frogsfrogsfrogs
>>
>> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
>> Signed-off-by: koraynilay <koray.fra@gmail.com>
>> ---
>>  fs/file_attr.c            | 33 +++++++++++++++++++++++++++++++--
>>  fs/stat.c                 |  2 ++
>>  include/linux/fileattr.h  |  5 +++++
>>  include/linux/stat.h      |  1 +
>>  include/uapi/linux/fs.h   |  8 +++++++-
>>  include/uapi/linux/stat.h |  7 ++++++-
>>  6 files changed, 52 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/file_attr.c b/fs/file_attr.c
>> index 833e03810b24..c0645cb22bf3 100644
>> --- a/fs/file_attr.c
>> +++ b/fs/file_attr.c
>> @@ -102,7 +102,7 @@ EXPORT_SYMBOL(vfs_fileattr_get);
>>  static void fileattr_to_file_attr(const struct file_kattr *fa,
>>                                   struct file_attr *fattr)
>>  {
>> -       __u32 mask =3D FS_XFLAGS_MASK;
>> +       __u32 mask =3D FS_FILE_ATTR_XFLAGS_MASK;
>>
>>         memset(fattr, 0, sizeof(struct file_attr));
>>         fattr->fa_xflags =3D fa->fsx_xflags & mask;
>> @@ -110,6 +110,8 @@ static void fileattr_to_file_attr(const struct file_=
kattr *fa,
>>         fattr->fa_nextents =3D fa->fsx_nextents;
>>         fattr->fa_projid =3D fa->fsx_projid;
>>         fattr->fa_cowextsize =3D fa->fsx_cowextsize;
>> +       fattr->fa_ptime_sec =3D fa->fsx_ptime.tv_sec;
>> +       fattr->fa_ptime_nsec =3D fa->fsx_ptime.tv_nsec;
>>  }
>>
>>  /**
>> @@ -141,15 +143,20 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
>>  static int file_attr_to_fileattr(const struct file_attr *fattr,
>>                                  struct file_kattr *fa)
>>  {
>> -       __u64 mask =3D FS_XFLAGS_MASK;
>> +       __u64 mask =3D FS_FILE_ATTR_XFLAGS_MASK;
>
> That is not the correct way to extend this API.
> This fixed mask was added as a placeholder for
> "We intend to add support for more xflags to selective filesystems":
> https://lore.kernel.org/linux-fsdevel/20250329143312.1350603-2-amir73il@g=
mail.com/
>
> Please see this POC patch for filesystems to publish their supported
> xflags mask:
> https://lore.kernel.org/linux-fsdevel/20250329143312.1350603-3-amir73il@g=
mail.com/

Quick quesiton, should _mask also be used for user-space -> VFS to advertis=
e
what it wants to change?
This would be useful for on/off flags, but for ptime both fa->xflags and
fa->xflags_mask would have the same meaning of "I want to change ptime,
look at fa->ptime".
Should we make _mask the only way to advertise what the user wants to
change, ignore xflags | PTIME in user-space -> VFS and use it only in FS
-> VFS -> user-space to say "this fs supports PTIME for this file"
(which will be always once support is added to an FS, so it would just
be "this FS supports PTIME")?

Thanks,
koraynilay

> This will allow callers of file_getattr() to know if the filesystem
> supports ptime
> without trying to set it and failing.
>
> Thanks,
> Amir.



--95ab675be9d074487606c137f0b6646de41c65221c97957b70ca632d1c3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCau9MEQAKCRA0bnTtJTDo
OPD4AQDWB5fWQqsTINMtZPk06g/4k0QigUfibKGxR/tGXecw/wEA85kDqWvA8lK2
swDiGJWmx17SfhowAqqmLKGa5kRouQI=
=T96n
-----END PGP SIGNATURE-----

--95ab675be9d074487606c137f0b6646de41c65221c97957b70ca632d1c3b--
