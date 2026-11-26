Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795685018;
	b=h58scRqf+qXQWtCoqDZ47S5Xd4mQER0+l09gkeoZbt1Hi4RriecOhtQ4fFgcNraetzcw
	 qWgKQfrYp5w1Ih+gsmIdRFTUQIiYlhA8ow6VqFZOZgb/PGuR94KMuaiVe1z/L0/GiodtZ
	 65gA0b3JbuFInuC8iSGUipIrcCQwEVLPEjftxz+tcMKWDhg2Tuc5S/1zU+P3VRwrJfITi
	 VZHMw7GnkuLTcZzAhqSPhBhcTIA7SSHf+FXV5y2Gau9Z7FcSSArXOH1+Twrhhezcy0h8D
	 dD1+2p29jnwv4J5LX82TN0xEskZbbbxepPCQZLZ1xBzqsg9TtbdPHQ5Knk3ruXsnz2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xckR6blDjDVAhqTSlG7y2c/dJk+7MAk3ZiUn44VZKcw=;
	b=dK3/nwYf+Li3dSJUW5ys2IEXXpsVxvQe6Dhw7tHMX3WUecrqmjggfxDyTR5/owo6aTAw
	 9e9GZOppjeiCzqEOABHBvq8XgWHRByzld3tTvCZiKJacAMg/FqCtv2DkI7Hz73rlujDi+
	 2kxUOZA/tAXH5fAIbNuZU7qZ0AG9m71QTiLnmD6ezQntwmtJfUtLZf+3kA8hzxYN4pG27
	 /OXyWMWYjCcKvbeoYmEethCmj8toqzv2yB1vYv6qpA8X9M3jhr8kdw7Kvr70kyKzin2fY
	 f9yu+/HtizudiHdMsrQ0bro7QgIvD2zWVVYcRWQ3Yp2VryeeBVEJ0eh7ZyzjgSN9tFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=htZC86Pa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C0606A329
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 09:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 476C0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=htZC86Pa
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b87a92c17eso9532534a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 01:23:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795685016; cv=none;
        d=google.com; s=arc-20260327;
        b=L0U1jzKYnjxnEN8HeSSJEs21GY74xF8Eqd053oW3MeuHY1PuGMKKx2HHcmJ2apv+BR
         EdBEBzTg3YxeO17w8qiovMDQ2ODHbFmNO+zSyHRnTMq0MsZHNlEVvSM38mrcmjU8WlT0
         kT/0ilS3Y1XIqQ1wUF0kxO0RXufP5gFv71bMorWoyT5WHmpFg48hdC9o1SbWueIbxfs9
         LnsYKV0p9OGbrKMdXUQpCUtHJe3NAXHPPHoj8+H93e2zp7vvgBcympBGavJc6wUGKjxf
         JowUQ9+1Xn3LR4j7mKPRYX/kSI3ziFSpYNRHEzThrHPEPH/tg80pYGve2OAoukIpoyLF
         JiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xckR6blDjDVAhqTSlG7y2c/dJk+7MAk3ZiUn44VZKcw=;
        fh=xj5S0SbgkxpeOOtMEu4A8Y66Agj9fVkXOptSAkJ7Ecc=;
        b=kzcTdFOROdPNBxTTAYqgBQvKu68aurBxIr1/wd/Cn6RzlhjAkKICOMTvejHhJfR+fd
         bHLMrK2QtCg3Wmbvwcv8vyk2xcsTCwDzWfn+lRgdNZfntdahpiieW8m5M/ifrcu9gN8B
         Ps3vsYfzQt+xwPKyVI8izCkDCfQZcH3dgWyVQxvpTQC3/AxY4ggv5lRfD/7aS3ezYg/t
         MextE5NYimJaj/keVZYOpgiU5T9XTnZI4WMbRVC9j52rk7ZNz88ajfecB66XT7CanCE6
         0vL6m5fK+kkBxFLPU58qf8lz0PlbHIC571eqX9tHp5Fo3O1VInx6MTXeknRZ0opntjV0
         pe2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685016; x=1796289816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xckR6blDjDVAhqTSlG7y2c/dJk+7MAk3ZiUn44VZKcw=;
        b=htZC86PaPTG34kYWAisdWcgHJD1UzaMIQvA1regyq5nViPY53KsD3NsllAndQX1evi
         Ni4eoDAvoFkwSVjRH2aLo8DK1It6q5/8NfVeByru4dF9S6/VEXj+TZJ5U8mChY30w0Uv
         jcCx/2OSR9wIj7x8YmXDsxOsBKo6p3Q3ujwy/4TdmbIF5u+YX04R1Bv1QF0hLopIVtio
         PngI5fpJQ1uCiosc+uFsN8S0QqiNZJdqLTNdOL6uay7GyqwBy7ErG/e7G5Nk2oTVO/wr
         64NWwOk7mZ5vgAa+kdjPvHzrMIdBU6PYX15ePP1qntAbHhcwn6ZQtcGoRW3QJj2GibeU
         nxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685016; x=1796289816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xckR6blDjDVAhqTSlG7y2c/dJk+7MAk3ZiUn44VZKcw=;
        b=pvhM1lDlCZVetpI35vIcsQWVQTJJDETN+WloJxl4EWHyW4an1X5vIZ1R2Kpk3gXWj4
         8UJ/NgHzoNttKO2QqTK/FYu48GyVy5s8d3WaIRUNjeGy+l8YZMeNfSPOhPdCjvGu3iqo
         eC8PknQqgIpmPS30OtgFtHR1aBc0B5aZJqpkaVO39P6CQurXM1LZEgJ9CwNpE4MaHAct
         /jhiJCe+cHcb/IJLVLoptx3nYV07Avn5uwjinCgkXnezz2/zWXe316OYuh1ImnsE/zlT
         Pul83tGTpVdhgpQOHdk6u60N0ZhRJXY37NUsxtt183bvWmLbquKmUSmnhXr3UHvwSosm
         lG8A==
X-Forwarded-Encrypted: i=1; AL+hErGlNdqLeBYbtIFSbxlvYiRQA6OAONYXZI3zVn3IK+dW+gPhpxBX4Q+wOoWrxMpXXuJHrE/z81EuKcgca55Z@vger.kernel.org
X-Gm-Message-State: APuU4Z/Bgy2fuO2J/iS5LTKNKhyFfo6XEdo6LcywLcfvHzBwLrOZRtHa
	n34kQhHzh/WdUZQBasfXwPEDZ4pVT1mRKkDUUrfhcBJh+E5wDJ0T2KU/CGoAnkgaQCkD8nbl0Kw
	8Y75In6y5bvQVsCmCj8Cr10sXq6IYUy4=
X-Gm-Gg: AZFdTZfjZBmRFX1cGSa887k5ABpnZjomkox3Bm0ToX8XR8oVYrDs8XBwAV6HDVKabmv
	xqSPAkWthRNBeLAKlybYHj88HZkSQUAveuBK3gmDdsfUWOr9oCRGvBlsf9vKEq7o3OKNXOkUjuI
	w793bbJwasnDT60Jnhtdf42DCTzmWCx3z1YyNYkel1koSyUdzyei57yUW0whhcKi0mxBMM00N+X
	SZ3hGgR3vzoCgAsadMHClpptUy3LVuRXkYuHJlciOAmDrRZuGf5zCg213UN8SOQ8xNu+/mrDX3d
	n9sQRlh3Yssn4r0UySpxbfGlAufChwWoH1lBfdPrNJDStZ2KRLywOWgpyXEhy/+Swt3IVSb/MTX
	UFR64AKDPiQIVynjVfchO3D63/phllSsKM2JO/7CT/a2Dy1h3P8lR4xFnH6WEZ0Z5HsKSdw==
X-Received: by 2002:a05:6402:1501:b0:6b7:182c:5d4e with SMTP id
 4fb4d7f45d1cf-6ba37c7c3a6mr11134218a12.5.1795685016112; Thu, 26 Nov 2026
 01:23:36 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122000856.536902-1-koray.fra@gmail.com> <20261122000856.536902-3-koray.fra@gmail.com>
 <CAOQ4uxhegn1z=41_MHL1Zu2hXuPtzNhC=x4gd371oaeJE4-weQ@mail.gmail.com>
 <DN2N6A68PBO1.2QT8ZOARF4I6L@gmail.com> <CAOQ4uxhDQqEQ3T9NveBFpUmSU032BxrNV5D+_zHj8u9LOQY+qg@mail.gmail.com>
 <DN4DRUYPHYMP.20U4DYV5VBN7P@gmail.com> <CAOQ4uxg0g+XkPb3-kQS5ez1-rp7Q=BkYDHW0CGOFhpbcf70yMg@mail.gmail.com>
 <DN4KLSM2OO0K.2C8Q5CPFBVNL6@gmail.com> <CAOQ4uxhpJygZH-arLFSUYEEfqFG96Sr3_6CWakfSkdWxEsOxMg@mail.gmail.com>
 <DN50PH7HHSWZ.3H4T25JFPQECY@gmail.com>
In-Reply-To: <DN50PH7HHSWZ.3H4T25JFPQECY@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Nov 2026 10:23:23 +0100
X-Gm-Features: Aa3M54qgNadyHP5LQf6BsvKupVU6AY9XgOmNRBH-yAFSYibTS_3xHgBMtDNHcI0
Message-ID: <CAOQ4uxgJTSspRJqRFaSJxKUShVULaJpMv8UhBFR-DV2kUe1sXw@mail.gmail.com>
Subject: Re: [PATCH 2/3] vfs: add xflags mask to fileattr API
To: koraynilay <koray.fra@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Darrick J . Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lauri Gates <lauri.gates@gmail.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ntfs@lists.linux.dev, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 9:59=E2=80=AFAM koraynilay <koray.fra@gmail.com> wr=
ote:
>
...
> >> > Attributes that have X_value like fsx_projid have few types:
> >> > 1. 0 means disabled (all existing values incl. projid)
> >> > 2. 0 is a valid value but cannot be unset (btime)
> >> > 3. 0 is a valid value and NULL/unset is also a valid value
> >> >
> >> > Only for type 3 does can the interpretation of
> >> > (!XFLAG_X && !fsx_X) be considered as an "unset"
> >> > and anyway, this will require support in individual fs.
> >>
> >> IMO !(xflags & XFLAG) && (rw_mask & XFLAG) should clear/unset the valu=
e
> >> in all cases, ignoring what's in fsx_X.
> >>
> >> And all existing values would be of type 1 for VER0, but of type 1 + 3
> >> for VER1.
> >>
> >
> > I agree that this will be more consistent.
> >
> > With explicit opt-in to FILEATTR_MASKS API
> > vfs can determine that
> > (!XFLAG_X && !!fsx_X) is alway -EINVAL
> >
> > When fsx_X =3D=3D 0, the value of XFLAG_X does not really matter
> > so filesystems can decide themselves if they want to act on
> > an "unset" flag or not.
>
> Hmm, I think fsx_xflags should have priority over the value in this
> _masks API.
>
> In my mind, to clear PROJID a userspace program would only need to do:
>
>   struct file_attr fa =3D {
>         .fsx_xflags =3D 0,
>         .fsx_xflags_rw_mask =3D FS_XFLAG_PROJID
>   };
>   file_setattr(&fa, AT_FILE_ATTR_MASKS);

If the program (e.g. chattr -p) internationally sets rw_mask =3D FS_XFLAG_P=
ROJID
what do we gain from not requiring the program to also set fsx_projid =3D 0=
?
I just don't see any wins for anyone from this design choice.

Maybe I am missing something.

>
> and have projid cleared (same for EXTSIZE/EXTSZINHERIT/COWEXTESIZE),
> while to set/change it:
>
>   struct file_attr fa =3D {
>         .fsx_xflags =3D FS_XFLAG_PROJID,
>         .fsx_xflags_rw_mask =3D FS_XFLAG_PROJID,
>         .fsx_projid =3D 67,
>   };
>   file_setattr(&fa, AT_FILE_ATTR_MASKS);
>
> and this:
>
>   struct file_attr fa =3D {
>         .fsx_xflags =3D FS_XFLAG_PROJID,
>         .fsx_xflags_rw_mask =3D FS_XFLAG_PROJID,
>         .fsx_projid =3D 0,
>   };
>   file_setattr(&fa, AT_FILE_ATTR_MASKS);
>
> would have the same result as the first snippet, but not the same
> meaning, since this would mean "set projid to 0" while the first snippet
> means "clear/unset projid" (but in this case, for projid and all the
> other already existing fsx_* it would have the same result).
>

As I wrote it could matter per attribute and per filesystem
whether set to 0 or unset is different.

The man page language should be flexible enough about this point.

It only needs to document the invalid combinations.

When proposing an UAPI change I often included a man-page draft
as a proof that the UAPI can make sense to human readers.

Thanks,
Amir.
