Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718890;
	b=Xe5b6RzP6wK3ylnesjx4lZOdqq1RsDZYGtA2vI1+kIPaNWMHPteWfoYXuroka8tFd+Oz
	 nsqbs8K0Z5jVvMvPnv3UQW/eNt7EFQyiSVxEapCI9JiTyfobKj61TVUaAPnjIZASjihFF
	 TRxz8IuwB6pQsnf3v44q2ItZVD9JegTpguNnJHxcz/EZxY5i+0K2+fsbx3knBW+qZ+b2s
	 IGFn08Vo5vabUOhucLd3e6kGNsmNaobX+zBVzgQ0IlbeHJeofBAYre506RrqZ5YsymgEF
	 OM7JPKZN6hkyGCxfvid6yAowXvxO3Xo8N3WXrAPNcjYAvBCEraw7zO3RM28qnVVKnXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QDUu0ipWkEkr2evKB+VQexo3kZhP7laIpcWU434jcM4=;
	b=YT9j5NoonDQ5U+eJO2zx6bUhr7PA6ggGwTImgLpRWWlWMZU0CQ2TFq0kAHZcG9bBb9xG
	 B2WULCk53li3mOJO6V4/6xMAXAfoxkNa39eHAtBC/TOpPEAiXz3NkjQ6Rg+U6PE+x3WTh
	 Xm2+FhgjSoLNIz0Dyvd50LJOt2xvT85PVIN8lSVCq5z6CY/Xc4bVd9/ooX3Kjd0p2H5lP
	 ou/Ugm3Gz9rE8ZKPaueNceR2ro+bZ+37RoRXm0XoBMnVpFwmf3/COVkjyGQwl7rkhCbRb
	 8Q4Sedt4qWr2Wimash5wPrjvTwUzNwqwzbkk8TVc/XJMrm+byAcyZmP0D2ES6hxgeQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAw1L019;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C0606EE8C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 15:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B7C0606EE8C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAw1L019
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so6198454a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 07:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793718888; cv=none;
        d=google.com; s=arc-20260327;
        b=b6gZhoIO2PYdAnFuCQS4A0ZWetKsdClyvBgNBfhLpcJ4umOv87XV3o7AWQJxHlv88U
         IvuDf+NnjW36DILbTzYmnEwy/fIIx5/OFgqO4FHcYpXI7mD0nETzY2MckjcpIOpdYbc7
         n29DSVTFzDXk0LUGyx0esvaaxSjL1gnYlCGnd3Sr5CSi8PKk0XU7vgTWk99mEnH33LV+
         GnSEYVDLXj1DFJnjERpzBc4wQrvjPE+RyvnlAZNle7hqmj+h+8ZuOcog8WW7bVjcvznV
         oYLIvse2mFvW5afq8BkQzoYkCirVDNaa7OjWF6vj6k/0XV9Zx0RWq1xw9n67qrfZLf4x
         j3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QDUu0ipWkEkr2evKB+VQexo3kZhP7laIpcWU434jcM4=;
        fh=TYcWxh4NmYhUR1mQa2Wkc1XJOs2ffiMRpO23RO5L8nM=;
        b=kReS0hYXLYn6BvsMG2dF1IyRAmEaaOoLck8zJ/JHsp+mMUVzdnOUp6aRwZ3uPrI1ww
         a8n1IBn/hHuwe+YixDlxjLptyMNbTvhI9DxJCYuWG5y/hfUWfrsRsxCaOJwZwFSt1pqj
         Sf5mqwfg/Q24QLeGYGgigzua49bcp4LBJY2hhX7YWThiFRHb+UhP3cP6Q5NiXcjgwafX
         z34BhYGyrgvl9a09FpQWPS84r+XIwY+CC8qwESTdm1+nW1zAIdGi5nvcPYrpcGF8ekJ8
         YhcaF1AupS3hwaV1Z7zrWgZKw2jrJ538UDSuaM/CBAxtvZfsZa20t1NivNHTXNFZzMIT
         i3Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793718888; x=1794323688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QDUu0ipWkEkr2evKB+VQexo3kZhP7laIpcWU434jcM4=;
        b=iAw1L019pbEECqKdWoucVoYt8cFM0CJimSPA3rGm9rZtMZpD0LGCCG5hkH3c1GOMpf
         IspJYDJNQRBAf5O6qxCrg24PZgTtDkgCcJNc+Te/FaLgF/P2D2ygdPGcLtFbCUaY0gnX
         nmK4XIqfh/wBKe13PTQ3kpyVHbCepAgmJlXpEqP8L3+CnEReQhrjzuddQkWkPc8aT2Ew
         WXWATOtMwvJL4pflCNbceNHwqDeFvIKJFx0h/Vg6B5F579r0iqYdPkfD5EDX+IkmrfUS
         8lO3wA9EaUVodg+Hln22pbunmgEx1YJidGyr6Qo2rLI9Snk3VNHTBqzw5kVIPPr31SEA
         cHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718888; x=1794323688;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QDUu0ipWkEkr2evKB+VQexo3kZhP7laIpcWU434jcM4=;
        b=DuO2onwKEX6z9OV0diqqjEnAYwSlzBXBMqohXIP11WqY6CA5OBgL2rXTNjVpZk2uUw
         idR/NSGWrA9x2LCy8CZWnqdyPqLANrwYahq7zZwKCLyukknu+fds927zW5YK2pqantnz
         9+aunz3NpxZ4etOoWqrziO0P9R0P6WAKbkrkyp2k89t3YMzWo5tDUFCzOWRSipNkQWZN
         AXqXcorFvPnxtMtZpvzKktTxnOPeR0Lw419F7SOYJVQoappl5O4EX8DEyCWp5sK0nLKv
         tsv7YIvY+hzGUlJ+Wm3+DGUVFX9f39qJ9NBEjH//KHWsCf5iGgOX8TXnKdY4p/uzHXd3
         pVug==
X-Forwarded-Encrypted: i=1; AKwUvBzHm+KnNJ5lQ00lQylAGNKG9q553scsaeiO/kziW4vBS86U0+SN6PwQc1qasRqHFQ97AZ/9V0cCa8SPf4Mw@vger.kernel.org
X-Gm-Message-State: APuU4Z8Pz6mcRMtDzMouWbFWSKMNBT5HsYa3PMaRAkNPnWlB8hX/qLjp
	gmhHNa2UP70eI8P7e+7Og4aQ4VPycrH2y07/3lRNgC9/6/vQOtLKWrU/v26pSRtrf4tiZYKAEhw
	UfSh9X04O7/Uk3p/N+oV5iFHW3+4vWYY=
X-Gm-Gg: AYBFou3dery51CyGd3J6271Zxwp8nyiXy+6EPdtVd3u9t9bn97IR74t6f6Fq+CStXCT
	AC9JJuGBSyJQT2c7gkdGja9r0DmXIlYZAxoCzgwdiBOLT1a+laJXjgM0P+TwYtswkArDo9nxszf
	qxhZ/+36H4dDZFgcF2vpQ7vXuu9oKQo6IOgYIiFarAft/4aBOXjCeoXSolyYR8pR+SFitcOD1Eq
	cdgLDM+iEWe3FgFZuJb5ANQ18SkzF+SNDvGdKB1oQWTJ5/Wrx+jYPXLXNBkidizrvcTUdP9wfdv
	MuLI8wvR1LVx2RjFf9Nbd/Qgdn4vl5OEOB7ZUdtKt+LetX2OIAhEGWlY6Bsjp5WgQSNEVtLGLr4
	mHL68g5h3nTYWfyXtXpaIBAZna1OcpGwhMspaa5Qe1MN9B1N7F7tKrZt2G6RCC+h936RnljI=
X-Received: by 2002:aa7:d309:0:b0:6b3:f094:8ced with SMTP id
 4fb4d7f45d1cf-6b4d4683a29mr7344511a12.21.1793718887787; Tue, 03 Nov 2026
 07:14:47 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101015551.786044-1-koray.fra@gmail.com> <20261101015551.786044-2-koray.fra@gmail.com>
 <CAOQ4uxiuJ=eZu28FZAUz3rpqPKqCimPxJucOnYYuBowvD09_Cw@mail.gmail.com> <DMLJ5DR2A4KZ.28U8XSZ0KFJTG@gmail.com>
In-Reply-To: <DMLJ5DR2A4KZ.28U8XSZ0KFJTG@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Nov 2026 16:14:35 +0100
X-Gm-Features: AclHuK-EjP75rU69csZK2uVzxHspULIwEcPYYUtLw5t3M157ApaMB9lhTx9MQvw
Message-ID: <CAOQ4uxiTS-QT7y1avNSasJSffkt2uRNkdrb2_GrK7kJ82-MoXw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] vfs: add provenance time (ptime)
To: koraynilay <koray.fra@gmail.com>
Cc: David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Chris Mason <mason@kernel.org>, 
	Jan Kara <jack@suse.cz>, Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <cel@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Sean Smith <defendthedisabled@gmail.com>, 
	Andrey Albershteyn <aalbersh@kernel.org>, Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:13=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> On Mon Nov 2, 2026 at 3:00 PM CET, Amir Goldstein wrote:
> > On Sun, Nov 1, 2026 at 2:57=E2=80=AFAM koraynilay <koray.fra@gmail.com>=
 wrote:
> >>
> >> Add provenance time (ptime), indicating the time when a file or
> >> directory was created. This is user-settable via file_setattr() and
> >> retrievable via statx(2) (using STATX_PTIME) or file_getattr().
> >>
> >> The semantics of when to preserve this new timestamp are the same as
> >> mtime, the idea being that there is a correspondence like this:
> >>
> >> ctime <-> btime
> >> mtime <-> ptime
> >>
> >> so every operation (copying, moving, ...) that currently preserves mti=
me
> >> should also preserve ptime.
> >>
> >> Furthermore, in order to avoid the legacy FS_IOC_FSSETXATTR accepting
> >> FS_XFLAG_PTIME, add an FS_FILE_ATTR_XFLAGS_MASK mask to support new
> >> xflags, and use it in fileattr_to_file_attr()/file_attr_to_fileattr() =
to
> >> allow ptime to be used with the file_setattr()/file_getattr() syscalls=
.
> >>
> >> [ This is a re-implementation of the initial patch[1] by Sean Smith
> >>   <defendthedisabled@gmail.com>, following the advice[2] from Darrick =
J.
> >>   Wong <djwong@kernel.org> of using file_setattr() instead of updating
> >>   utimensat() ]
> >>
> >> [1]: https://lore.kernel.org/20260405195007.1306-2-DefendTheDisabled@g=
mail.com
> >> [2]: https://lore.kernel.org/20260407014129.GC6192@frogsfrogsfrogs
> >>
> >> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
> >> Signed-off-by: koraynilay <koray.fra@gmail.com>
> >> ---
> >>  fs/file_attr.c            | 33 +++++++++++++++++++++++++++++++--
> >>  fs/stat.c                 |  2 ++
> >>  include/linux/fileattr.h  |  5 +++++
> >>  include/linux/stat.h      |  1 +
> >>  include/uapi/linux/fs.h   |  8 +++++++-
> >>  include/uapi/linux/stat.h |  7 ++++++-
> >>  6 files changed, 52 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/file_attr.c b/fs/file_attr.c
> >> index 833e03810b24..c0645cb22bf3 100644
> >> --- a/fs/file_attr.c
> >> +++ b/fs/file_attr.c
> >> @@ -102,7 +102,7 @@ EXPORT_SYMBOL(vfs_fileattr_get);
> >>  static void fileattr_to_file_attr(const struct file_kattr *fa,
> >>                                   struct file_attr *fattr)
> >>  {
> >> -       __u32 mask =3D FS_XFLAGS_MASK;
> >> +       __u32 mask =3D FS_FILE_ATTR_XFLAGS_MASK;
> >>
> >>         memset(fattr, 0, sizeof(struct file_attr));
> >>         fattr->fa_xflags =3D fa->fsx_xflags & mask;
> >> @@ -110,6 +110,8 @@ static void fileattr_to_file_attr(const struct fil=
e_kattr *fa,
> >>         fattr->fa_nextents =3D fa->fsx_nextents;
> >>         fattr->fa_projid =3D fa->fsx_projid;
> >>         fattr->fa_cowextsize =3D fa->fsx_cowextsize;
> >> +       fattr->fa_ptime_sec =3D fa->fsx_ptime.tv_sec;
> >> +       fattr->fa_ptime_nsec =3D fa->fsx_ptime.tv_nsec;
> >>  }
> >>
> >>  /**
> >> @@ -141,15 +143,20 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
> >>  static int file_attr_to_fileattr(const struct file_attr *fattr,
> >>                                  struct file_kattr *fa)
> >>  {
> >> -       __u64 mask =3D FS_XFLAGS_MASK;
> >> +       __u64 mask =3D FS_FILE_ATTR_XFLAGS_MASK;
> >
> > That is not the correct way to extend this API.
> > This fixed mask was added as a placeholder for
> > "We intend to add support for more xflags to selective filesystems":
> > https://lore.kernel.org/linux-fsdevel/20250329143312.1350603-2-amir73il=
@gmail.com/
> >
> > Please see this POC patch for filesystems to publish their supported
> > xflags mask:
> > https://lore.kernel.org/linux-fsdevel/20250329143312.1350603-3-amir73il=
@gmail.com/
>
> Thanks, I did not think of adding a dynamic mask like that, I will look
> into it and implement it for v4.
>
> > This will allow callers of file_getattr() to know if the filesystem
> > supports ptime
> > without trying to set it and failing.
>
> So after adding fsx_xflags_mask to file_kattr, every filesystem would
> populate fsx_xflags_mask with all the returned (=3D=3D supported) FS_XFLA=
G_*
> in their own specific .fileattr_get, correct?

Not all filesystems. Just the ones that wish to extend the constant
legacy FS_XFLAGS_MASK.
So just the ones that you change to support XFLAGS_PTIME

Thanks,
Amir.
